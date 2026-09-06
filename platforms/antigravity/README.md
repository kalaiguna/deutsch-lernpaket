# Google Antigravity Adapter

Google Antigravity (`agy` CLI, v1.1.27) uses a skill format identical to Claude Code:
skills live at `~/.gemini/config/skills/<name>/SKILL.md` and the MCP config format
(`mcpServers` in `~/.gemini/config/mcp_config.json`) is the same JSON shape.
This means the skill files in `skills/` drop in without modification.

---

## Capability Matrix

| Feature | Status |
|---|---|
| All 7 skills (conversational) | Yes — skill format is identical |
| Notion MCP | Yes — after manual config (see below) |
| Automatic scheduling | No — `agy` has no `schedule` subcommand; use Windows Task Scheduler |
| Skill hot-reload | Yes — copy or symlink and Antigravity picks up changes |

---

## Setup

### Step 1 — Copy or symlink the skill folders

For each skill you want to use, copy its folder into the Antigravity skills directory:

```powershell
# Example — copy all 7 skills at once (PowerShell)
$skills = @(
  "daily-german-practice",
  "german-weekend-review",
  "german-sunday-schreiben-und-hoeren",
  "schreib-skill",
  "lektuere-skill",
  "monatsrueckblick",
  "grammatik-vertiefung"
)
$dest = "$env:USERPROFILE\.gemini\config\skills"
foreach ($s in $skills) {
  Copy-Item -Recurse -Path "skills\$s" -Destination "$dest\$s" -Force
}
```

Or symlink so changes in this repo propagate automatically:

```powershell
foreach ($s in $skills) {
  New-Item -ItemType Junction -Path "$dest\$s" -Target (Resolve-Path "skills\$s")
}
```

After copying or linking, run `agy` and type `/daily-german-practice` — the skill should
load and start immediately.

### Step 2 — Add Notion MCP to Antigravity's config

Open (or create) `~/.gemini/config/mcp_config.json`. If it already has an `mcpServers` key,
add the `notion` entry alongside your existing servers. If the file is new, use the snippet
from `mcp_config_addition.json` directly.

Contents of `mcp_config_addition.json`:

```json
{
  "mcpServers": {
    "notion": {
      "command": "npx",
      "args": ["-y", "@notionhq/notion-mcp-server"],
      "env": {
        "OPENAPI_MCP_HEADERS": "{\"Authorization\": \"Bearer YOUR_NOTION_TOKEN\", \"Notion-Version\": \"2022-06-28\"}"
      }
    }
  }
}
```

Replace `YOUR_NOTION_TOKEN` with your actual Notion integration token
(Settings → Connections → Develop or manage integrations → New integration → copy the
Internal Integration Token).

Restart `agy` after saving the config. Confirm Notion tools are available by asking
Antigravity to list its MCP tools.

### Step 3 — (Optional) Add a pointer in AGENTS.md

`~/.gemini/config/AGENTS.md` is Antigravity's equivalent of `CLAUDE.md`. You can add a
reference to help Antigravity load context:

```markdown
# German Learning Skills

Seven German B2 learning skills are installed in ~/.gemini/config/skills/.
Invoke them with /daily-german-practice, /german-weekend-review, etc.
Session data is saved to a Notion page called "Deutsch lernen B2".
```

This is optional but helps when Antigravity needs context about your setup.

### Step 4 — Schedule sessions with Windows Task Scheduler

`agy` has no built-in scheduling (`schedule` subcommand does not exist). Use Windows Task
Scheduler instead. A ready-made PowerShell script is included:

```powershell
# Run from an elevated PowerShell prompt in the repo root:
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\platforms\antigravity\task-scheduler-setup.ps1
```

This registers all 7 skills as scheduled tasks under `\DeutschB2\` in Task Scheduler,
using these times:

| Skill | Schedule |
|---|---|
| daily-german-practice | Tue + Thu, 09:00 |
| german-weekend-review | Fri, 09:00 |
| german-sunday-schreiben-und-hoeren | Sun, 09:00 |
| schreib-skill | Sat, 09:00 |
| lektuere-skill | Every other Wed, 09:00 (registered weekly; set to 2-week interval in GUI) |
| monatsrueckblick | 1st of month, 09:00 |
| grammatik-vertiefung | 10th of month, 09:00 |

Each task runs:
```
agy --print --dangerously-skip-permissions "/skill-name"
```

Open `taskschd.msc` → Task Scheduler Library → DeutschB2 to verify tasks are registered.

---

## Verification

1. Copy `skills/daily-german-practice/` to `~/.gemini/config/skills/`.
2. Run `agy` and type `/daily-german-practice` — skill should load and start.
3. Confirm Notion MCP tools appear after adding the MCP config snippet and restarting.
4. Run `task-scheduler-setup.ps1` and open Task Scheduler to confirm the tasks appear
   under the `\DeutschB2\` folder.

---

## Differences from Claude Code

| Feature | Claude Code | Google Antigravity |
|---|---|---|
| Skill path | `~/.claude/skills/<name>/SKILL.md` | `~/.gemini/config/skills/<name>/SKILL.md` |
| MCP config | `~/.claude/mcp_config.json` | `~/.gemini/config/mcp_config.json` |
| Global instructions | `CLAUDE.md` | `AGENTS.md` |
| Native scheduling | Yes (`mcp__scheduled-tasks__*`) | No — use Windows Task Scheduler |
| Notion MCP | Enabled in Settings → Integrations | Manual config in mcp_config.json |
