#!/usr/bin/env bash
# verify-repo.sh — Automated consistency checks for deutsch-lernpaket
# Run from repo root: bash scripts/verify-repo.sh
# Exits 0 on all pass, 1 on any failure.
# Adapted from upstream's verify-repo.sh (MohgaNabil/deutsch-lernpaket).

set -euo pipefail

PASS=0
FAIL=0
WARN=0

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

ok()   { echo -e "${GREEN}✓${NC} $1"; PASS=$((PASS + 1)); }
fail() { echo -e "${RED}✗${NC} $1"; FAIL=$((FAIL + 1)); }
warn() { echo -e "${YELLOW}⚠${NC} $1"; WARN=$((WARN + 1)); }

SKILLS=(
  daily-german-practice
  german-weekend-review
  german-sunday-schreiben-und-hoeren
  schreib-skill
  lektuere-skill
  monatsrueckblick
  grammatik-vertiefung
  telc-pruefungsvorbereitung
  wortschatz-auffrischung
)

echo "== Check 1: Repository structure =="

for skill in "${SKILLS[@]}"; do
  if [[ -f "skills/$skill/SKILL.md" ]]; then
    ok "skills/$skill/SKILL.md exists"
  else
    fail "skills/$skill/SKILL.md MISSING"
  fi

  if [[ -f "platforms/claude/$skill.skill" ]]; then
    ok "platforms/claude/$skill.skill exists"
  else
    fail "platforms/claude/$skill.skill MISSING"
  fi

  # Check zip contents match SKILL.md
  if [[ -f "platforms/claude/$skill.skill" && -f "skills/$skill/SKILL.md" ]]; then
    zip_content=$(unzip -p "platforms/claude/$skill.skill" SKILL.md 2>/dev/null || echo "")
    disk_content=$(cat "skills/$skill/SKILL.md")
    if [[ "$zip_content" == "$disk_content" ]]; then
      ok "platforms/claude/$skill.skill SKILL.md matches skills/$skill/SKILL.md"
    else
      fail "platforms/claude/$skill.skill is OUT OF SYNC with skills/$skill/SKILL.md"
    fi
  fi
done

echo ""
echo "== Check 2: SKILL.md frontmatter =="

for skill in "${SKILLS[@]}"; do
  if [[ ! -f "skills/$skill/SKILL.md" ]]; then continue; fi

  # name: field must match folder name
  name_field=$(grep -m1 '^name:' "skills/$skill/SKILL.md" | sed 's/^name:[[:space:]]*//' | tr -d '"' || echo "")
  if [[ "$name_field" == "$skill" ]]; then
    ok "$skill: name: field matches folder"
  else
    fail "$skill: name: field is '$name_field', expected '$skill'"
  fi

  # model: field must be present
  if grep -q '^model:' "skills/$skill/SKILL.md"; then
    ok "$skill: model: field present"
  else
    fail "$skill: model: field MISSING"
  fi
done

echo ""
echo "== Check 3: Dashboard JS syntax =="

DASHBOARD="core/dashboard/dashboard.html"
if [[ ! -f "$DASHBOARD" ]]; then
  fail "$DASHBOARD not found"
else
  if command -v node &>/dev/null; then
    TMPFILE=$(mktemp /tmp/dashboard_js_XXXXXX.js 2>/dev/null || mktemp)
    # Extract content of the inline <script> block (skip external <script src=...> tags)
    awk '/<script[^>]*src=/{next} /<script[^>]*>/{found=1; next} found && /^<\/script>/{exit} found{print}' "$DASHBOARD" > "$TMPFILE"
    if node --check "$TMPFILE" 2>/dev/null; then
      ok "Dashboard JS syntax valid (node --check)"
    else
      fail "Dashboard JS syntax ERRORS detected"
    fi
    rm -f "$TMPFILE"
  else
    warn "node not found — skipping dashboard JS syntax check"
  fi
fi

echo ""
echo "== Check 4: No stale README references =="

STALE_FILES=("GETTING_STARTED.md" "ANDROID_WINDOWS_SETUP.md" "SKILLS_AND_NOTION.md" "IMPROVEMENTS.md" "REVIEW.md")
for stale in "${STALE_FILES[@]}"; do
  if grep -q "$stale" README.md 2>/dev/null; then
    fail "README.md still references deleted file: $stale"
  else
    ok "README.md: no reference to $stale"
  fi
done

echo ""
echo "== Check 5: Notion MCP save calls =="

NOTION_SAVE_EXEMPT=(wortschatz-auffrischung)
for skill in "${SKILLS[@]}"; do
  if [[ ! -f "skills/$skill/SKILL.md" ]]; then continue; fi
  exempt=0
  for ex in "${NOTION_SAVE_EXEMPT[@]}"; do [[ "$skill" == "$ex" ]] && exempt=1; done
  if [[ $exempt -eq 1 ]]; then
    ok "$skill: notion_create_page exempt (drill-only skill)"
  elif grep -q 'notion_create_page' "skills/$skill/SKILL.md"; then
    ok "$skill: notion_create_page present"
  else
    fail "$skill: notion_create_page MISSING"
  fi
done

echo ""
echo "== Check 6: No Apple Notes references =="

APPLE_FNS=("apple_notes" "add_note" "list_notes" "get_note_content")
apple_fail=0
for skill in "${SKILLS[@]}"; do
  if [[ ! -f "skills/$skill/SKILL.md" ]]; then continue; fi
  for fn in "${APPLE_FNS[@]}"; do
    if grep -q "$fn" "skills/$skill/SKILL.md"; then
      fail "$skill: Apple Notes call '$fn' found"
      apple_fail=1
    fi
  done
done
[[ $apple_fail -eq 0 ]] && ok "No Apple Notes MCP calls in any skill"

echo ""
echo "== Check 7: No Austrian flag (🇦🇹) =="

austria_fail=0
for skill in "${SKILLS[@]}"; do
  if [[ ! -f "skills/$skill/SKILL.md" ]]; then continue; fi
  # UTF-8 bytes for 🇦🇹: F0 9F 87 A6 F0 9F 87 B9
  if grep -Pq $'\xf0\x9f\x87\xa6\xf0\x9f\x87\xb9' "skills/$skill/SKILL.md" 2>/dev/null || \
     grep -q '🇦🇹' "skills/$skill/SKILL.md" 2>/dev/null; then
    fail "$skill: Austrian flag 🇦🇹 found — use 🇩🇪 instead"
    austria_fail=1
  fi
done
[[ $austria_fail -eq 0 ]] && ok "No Austrian flag in any skill"

echo ""
echo "== Check 8: Gender-neutral pronouns =="

pronoun_warn=0
for skill in "${SKILLS[@]}"; do
  if [[ ! -f "skills/$skill/SKILL.md" ]]; then continue; fi
  if grep -qiE '\b(she/her|he/him)\b' "skills/$skill/SKILL.md"; then
    warn "$skill: gendered pronoun config found (they/them is the default)"
    pronoun_warn=1
  fi
done
[[ $pronoun_warn -eq 0 ]] && ok "No explicit she/her or he/him pronoun defaults found"

echo ""
echo "== Check 9: session-schema.json validity =="

SCHEMA="core/session-schema.json"
if [[ ! -f "$SCHEMA" ]]; then
  fail "$SCHEMA not found"
elif command -v node &>/dev/null; then
  if node -e "JSON.parse(require('fs').readFileSync('$SCHEMA','utf8'))" 2>/dev/null; then
    ok "$SCHEMA is valid JSON"
  else
    fail "$SCHEMA is INVALID JSON"
  fi
elif command -v python3 &>/dev/null; then
  if python3 -c "import json,sys; json.load(open('$SCHEMA'))" 2>/dev/null; then
    ok "$SCHEMA is valid JSON"
  else
    fail "$SCHEMA is INVALID JSON"
  fi
else
  warn "Neither node nor python3 found — skipping session-schema.json validation"
fi

echo ""
echo "== Check 10: Platform adapter completeness =="

PLATFORMS=("claude" "copilot" "roo-code" "openwebui" "n8n" "antigravity")
for platform in "${PLATFORMS[@]}"; do
  if [[ -d "platforms/$platform" ]]; then
    ok "platforms/$platform/ exists"
  else
    fail "platforms/$platform/ MISSING"
  fi
  if [[ -f "platforms/$platform/README.md" ]]; then
    ok "platforms/$platform/README.md exists"
  else
    fail "platforms/$platform/README.md MISSING"
  fi
done

echo ""
echo "== Check 11: CHANGELOG footer links =="

if grep -q '^\[2\.1\.0\]:' CHANGELOG.md 2>/dev/null; then
  ok "CHANGELOG.md has [2.1.0]: footer link"
else
  fail "CHANGELOG.md missing [2.1.0]: footer link"
fi

if grep -q '^\[2\.0\.0\]:' CHANGELOG.md 2>/dev/null; then
  ok "CHANGELOG.md has [2.0.0]: footer link"
else
  fail "CHANGELOG.md missing [2.0.0]: footer link"
fi

echo ""
echo "== Check 12: Dashboard session type coverage =="

SESSION_TYPES=(
  "Deutsch B2 Konversation"
  "Deutsch B2 Quiz"
  "Deutsch B2 Übersetzung"
  "Deutsch B2 Schreiben"
  "Deutsch B2 Lektüre"
  "Deutsch B2 Grammatik"
  "Deutsch B2 Monatsrückblick"
)

if [[ ! -f "core/dashboard/dashboard.html" ]]; then
  fail "core/dashboard/dashboard.html not found"
else
  for stype in "${SESSION_TYPES[@]}"; do
    if grep -q "$stype" "core/dashboard/dashboard.html"; then
      ok "Dashboard covers: $stype"
    else
      fail "Dashboard MISSING session type: $stype"
    fi
  done
fi

echo ""
echo "==========================================="
echo -e "Results: ${GREEN}${PASS} passed${NC}  ${RED}${FAIL} failed${NC}  ${YELLOW}${WARN} warnings${NC}"
echo "==========================================="

if [[ $FAIL -gt 0 ]]; then
  exit 1
fi
exit 0
