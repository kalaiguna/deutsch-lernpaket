# Claude Code / Cowork Platform

This folder contains `.skill` files for drag-and-drop installation into **Claude Code** or **Cowork**. All 7 skills work fully here — conversational sessions, automatic Notion saving, cross-session memory, and adaptive quiz weighting.

## Installation

### Option A — Drag and drop (easiest)

Drag any `.skill` file from this folder into Claude Code or Cowork and click **Save skill** in the preview.

| File | Skill |
|---|---|
| `daily-german-practice.skill` | Tue/Thu 30-min conversation |
| `german-weekend-review.skill` | Friday quiz |
| `german-sunday-schreiben-und-hoeren.skill` | Sunday listening + translation |
| `schreib-skill.skill` | Monthly free-form writing |
| `lektuere-skill.skill` | Fortnightly reading comprehension |
| `monatsrueckblick.skill` | Monthly report card |
| `grammatik-vertiefung.skill` | Monthly grammar deep-dive |

### Option B — Copy SKILL.md manually

1. Open the skill folder under `skills/` (e.g. `skills/daily-german-practice/`).
2. Copy the full contents of `SKILL.md`.
3. In Claude Code or Cowork, create a new scheduled task and paste it as the prompt.

## Scheduled Tasks

Set up seven scheduled tasks using these cron expressions (times in your local timezone):

| Skill | Cron | When |
|---|---|---|
| daily-german-practice | `0 9 * * 2,4` | Tuesday and Thursday at 9:00 AM |
| german-weekend-review | `0 9 * * 5` | Friday at 9:00 AM |
| german-sunday-schreiben-und-hoeren | `0 9 * * 0` | Sunday at 9:00 AM |
| lektuere-skill | `0 9 * * 3` | Every other Wednesday at 9:00 AM |
| schreib-skill | `0 9 * * 6` | Every Saturday at 9:00 AM (run on your chosen practice Saturday) |
| monatsrueckblick | `0 9 1 * *` | 1st of every month at 9:00 AM |
| grammatik-vertiefung | `0 9 10 * *` | 10th of every month at 9:00 AM |

**In Cowork:** Open the Scheduled section → New scheduled task → paste the SKILL.md prompt → set the cron → save.

**In Claude Code:** Use the `mcp__scheduled-tasks__create_scheduled_task` MCP tool. Pass the SKILL.md content as `prompt` and the cron string as `cronExpression`.

## What works here

| Feature | Supported |
|---|---|
| All 7 skills (conversational + one-shot) | Yes |
| Notion MCP (auto-save and cross-session reads) | Yes |
| Automated scheduling via cron | Yes |
| Dashboard live Notion load | Yes (via Cowork MCP bridge) |
| WebSearch / WebFetch for articles and audio | Yes |

## Requirements

- Claude Pro or Team subscription (needed for scheduled tasks)
- Notion MCP connector enabled in Settings → Integrations
- WebSearch and WebFetch enabled (on by default)
