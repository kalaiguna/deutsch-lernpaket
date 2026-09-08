# Testing

Two layers: automated consistency checks via `scripts/verify-repo.sh` and manual QA scenarios that must be verified with a real Notion account and live Claude session.

Adapted from the upstream testing framework (MohgaNabil/deutsch-lernpaket, `feature/add_onboarding_skill`), rewritten for our Notion-based, German B2-specific, 7-skill structure.

---

## Automated Checks

Run from the repo root after any edit to a skill prompt, the dashboard, or a platform adapter:

```
bash scripts/verify-repo.sh
```

Exits 0 on all pass, 1 on any failure. Usable as a pre-commit hook — add it to `.git/hooks/pre-commit` and mark it executable.

The script runs 12 checks:

| # | Check | What it verifies |
|---|---|---|
| 1 | **Structure** | All 7 `skills/*/SKILL.md` files exist; all 7 `platforms/claude/*.skill` zips exist; zip SKILL.md matches the on-disk SKILL.md |
| 2 | **Frontmatter** | Each SKILL.md has `name:` matching its folder name and a `model:` field |
| 3 | **Dashboard JS syntax** | Extracts the `<script>` block from `core/dashboard/dashboard.html` and runs `node --check`; skips with a warning if node is unavailable |
| 4 | **No stale README references** | README.md contains no references to deleted files: `GETTING_STARTED.md`, `ANDROID_WINDOWS_SETUP.md`, `SKILLS_AND_NOTION.md`, `IMPROVEMENTS.md`, `REVIEW.md` |
| 5 | **Notion MCP save calls** | Every SKILL.md contains `notion_create_page` |
| 6 | **No Apple Notes references** | No SKILL.md calls `apple_notes`, `add_note`, `list_notes`, or `get_note_content` |
| 7 | **No Austrian flag** | No SKILL.md contains 🇦🇹 — must use 🇩🇪 |
| 8 | **Gender-neutral pronouns** | Warns if any SKILL.md has explicit `she/her` or `he/him` config (they/them is our default) |
| 9 | **session-schema.json validity** | `core/session-schema.json` parses as valid JSON |
| 10 | **Platform adapter completeness** | All 6 platform directories exist under `platforms/` and each has a `README.md` |
| 11 | **CHANGELOG footer links** | `CHANGELOG.md` contains `[2.1.0]:` and `[2.0.0]:` link references |
| 12 | **Dashboard session type coverage** | `core/dashboard/dashboard.html` references all 7 session type strings |

---

## Manual QA Scenarios

These scenarios require a live Claude session with Notion MCP enabled.

### Prerequisites

- [ ] "Deutsch lernen B2" page exists in Notion
- [ ] Notion MCP connector enabled in Claude Code Settings → Integrations
- [ ] `notion_search` returns pages from within that parent page
- [ ] WebSearch and WebFetch enabled (needed for Sunday listening and reading skills)

---

### 1. Daily Practice (`daily-german-practice`)

- [ ] Session opens by reading the most recent Quiz and Sunday pages for recommendations
- [ ] Theme avoidance: does not repeat any of the last 4 themes
- [ ] Vocabulary warm-up: surfaces words learned 14+ days ago and not yet reused
- [ ] One question per turn — never multiple questions in one message
- [ ] Every learner answer gets a B2-Umformulierung paraphrase
- [ ] Every mistake tagged with exactly one of the 11 categories
- [ ] Dictation homophone detection fires on das/dass, seit/seid, wider/wieder
- [ ] Session saved as `Deutsch B2 Konversation, YYYY-MM-DD, Theme`
- [ ] First block of saved page is a JSON code block
- [ ] Same-day re-run: page title gets ` (2)` suffix — does not overwrite

---

### 2. Friday Quiz (`german-weekend-review`)

- [ ] 10–15 questions total, one per message
- [ ] Runde 3 Fehler-Rewind uses actual past mistakes from Notion (not placeholder text)
- [ ] Sticky Challenge fires when any category appears 3+ times in the last 14 days
- [ ] Score updates correctly after each answer
- [ ] Saved as `Deutsch B2 Quiz, YYYY-MM-DD`
- [ ] First block is a JSON code block

---

### 3. Sunday Listening (`german-sunday-schreiben-und-hoeren`)

- [ ] 3 vocabulary items pre-taught BEFORE the audio link is shown
- [ ] Audio link fetched from DW / Easy German / Slow German / Nachrichtenleicht / DW Jojo
- [ ] Comprehension questions answered from the actual fetched transcript
- [ ] Translation section is sentence-by-sentence with corrections
- [ ] Saved as `Deutsch B2 Übersetzung & Hören, YYYY-MM-DD, Theme`
- [ ] First block is a JSON code block

---

### 4. Writing Session (`schreib-skill`)

- [ ] Task type rotates across 6 types (A–F): informal email, formal letter, opinion paragraph, recruiter email, motivation paragraph, professional description
- [ ] Types D/E/F have 💼 prefix in the Notion page title
- [ ] No feedback given until learner sends the complete text
- [ ] 6-section structured evaluation after submission
- [ ] Saved as `Deutsch B2 Schreiben, YYYY-MM-DD, Task type`
- [ ] First block is a JSON code block

---

### 5. Reading Session (`lektuere-skill`)

- [ ] Article fetched from one of: tagesschau.de, Spiegel, Zeit, Handelsblatt, Gründerszene, Heise
- [ ] 5 vocabulary items pre-taught before the article is shown
- [ ] Exactly 6 comprehension questions, one at a time
- [ ] Handelsblatt / Gründerszene / Heise articles get 💼 prefix in page title
- [ ] Saved as `Deutsch B2 Lektüre, YYYY-MM-DD, Topic`
- [ ] First block is a JSON code block

---

### 6. Monthly Report (`monatsrueckblick`)

- [ ] Reads all "Deutsch B2" pages from the past 30 days (all 7 session types)
- [ ] Correctly aggregates mistake patterns, vocabulary growth, reuse rate
- [ ] Outputs exactly 3 concrete focus areas for next month
- [ ] Saved as `Deutsch B2 Monatsrückblick, YYYY-MM, Month in German`
- [ ] First block is a JSON code block

---

### 7. Grammar Deep-Dive (`grammatik-vertiefung`)

- [ ] Reads latest Monatsrückblick for topic hint; falls back to 12-topic rotation if none found
- [ ] Lesson delivered first, then 3 fill-in-the-blank exercises
- [ ] 2 transformation drills after the Lückentext section
- [ ] Free production exercise at the end
- [ ] Each exercise presented one at a time with feedback before the next
- [ ] Saved as `Deutsch B2 Grammatik, YYYY-MM-DD, Topic`
- [ ] First block is a JSON code block

---

### 8. Dashboard

Open `core/dashboard/dashboard.html` in Microsoft Edge or Chrome.

- [ ] Dark theme renders correctly (#0F172A base, #8B5CF6 violet accent) — no white-on-white text
- [ ] Fixed 240px sidebar visible with logo, nav links, and "GC" / "Guna" avatar
- [ ] KPI tiles show correct data from `SNAPSHOT_SESSIONS`
- [ ] "Active Days (7d)" tile label (not "Streak (days)")
- [ ] Heatmap shows 8 colour-coded session types with correct legend
- [ ] Monthly Focus card visible above the KPI grid (sourced from review session)
- [ ] Grammar Sessions card visible (topic tag cloud, fill-in + transform scores)
- [ ] Writing Sessions card visible (task type tags, register accuracy)
- [ ] Sticky Categories table has Trend column (▲/▼/→)
- [ ] Session Log has Type badge column
- [ ] Click a Session Log row → detail drawer expands; click again → collapses
- [ ] CSV export downloads a valid `.csv` file
- [ ] All 5 Vocabulary Explorer tabs render: Nouns & Adj / Verbs / Idioms / Ready to Reuse / Reused
- [ ] "Try live again" button attempts Notion load (requires MCP connector in environment)
- [ ] No console errors in browser DevTools

---

### Cross-Cutting

- [ ] No em dashes in any skill output (use commas, colons, or rephrase instead)
- [ ] Proper umlauts throughout: ä ö ü ß — never ae/oe/ue/ss
- [ ] Sessions always created with `notion_create_page`, never `notion_update_page`
- [ ] All sessions land inside the "Deutsch lernen B2" parent page in Notion
- [ ] All session pages: first block is a valid JSON code block
- [ ] German flag emoji is 🇩🇪 everywhere — no 🇦🇹
- [ ] Learner referred to with they/them pronouns unless the config comment is updated
