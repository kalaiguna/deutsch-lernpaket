# Deutsch B2 Lernpaket

Seven Claude skills that cover all four German language skills (Sprechen, Hören, Schreiben, Lesen)
across a structured weekly and monthly schedule — with every session saved to Notion and
visualised in a progress dashboard.

Designed for learners at **B1+ transitioning toward B2**, particularly those aiming for
professional fluency in a German-speaking workplace (IT, finance, enterprise). Works equally
well at any level — adjust the cron schedule and session frequency to your pace.

> **New to this repo?** Start with the One-Time Notion Setup section below.

---

## What's Inside

| Skill | Schedule | What it does |
|---|---|---|
| **daily-german-practice** | Tue + Thu, 9 AM | 30-min typed German conversation. Reads previous recommendations before starting, avoids repeating recent themes, surfaces vocabulary due for reuse. Every mistake gets a category label and B2 paraphrase. |
| **german-weekend-review** | Fri, 9 AM | Game-show quiz with 4–5 themed rounds and 10–15 questions. Adaptive Fehler-Rewind round weights questions toward your most recurring mistake categories. Pulls from full session history, not just the last 7 days. |
| **german-sunday-schreiben-und-hoeren** | Sun, 9 AM | Real German audio/video (Deutsche Welle / Easy German / Slow German) with 3 key words pre-taught before listening, comprehension questions, then a translation exercise on the same theme. |
| **schreib-skill** | Monthly, Sat | Free-form writing session with 6 rotating task types: informal email, formal letter, opinion paragraph, recruiter email, motivation paragraph, and professional description (100–150 words). Evaluated on register, coherence, paragraph structure, and B2 grammar. |
| **lektuere-skill** | Fortnightly, Wed | Reads a real 300–500 word German article (tagesschau.de, Spiegel, Zeit, Handelsblatt, Gründerszene, Heise). Pre-teaches 5 vocabulary items, then asks 6 comprehension questions: skimming, scanning, inference, vocabulary in context. |
| **monatsrueckblick** | 1st of month | Monthly report card. Aggregates all session data from the past 30 days: mistake patterns, vocabulary growth, reuse rate, B2 structures. Gives 3 concrete focus areas for next month. |
| **grammatik-vertiefung** | 10th of month | Dedicated grammar deep-dive. One B2 grammar point per session (Konjunktiv I/II, Passiv, Nominalisierung, Relativsätze, Modalpartikeln, etc.) with explicit rules, fill-in-the-blank exercises, transformation drills, and free production. |

All sessions save to a Notion page called **Deutsch lernen B2**, building a searchable
library of your own learning history. The included `core/dashboard/dashboard.html` reads those pages
and visualises your progress over time.

---

## Skills Covered

| Skill | Coverage | Sessions |
|---|---|---|
| Sprechen (Speaking) | Typed conversation with bilingual corrections and B2 paraphrases every turn | Tue + Thu |
| Hören (Listening) | Real audio/video with pre-taught vocabulary and comprehension questions | Sunday |
| Schreiben (Writing) | Typed conversation responses + sentence-by-sentence translation + free-form writing | Tue/Thu, Sun, monthly Sat |
| Lesen (Reading) | Dedicated reading comprehension with real German articles | Fortnightly Wed |

---

## Design Principles

- **One question at a time.** No message ever asks more than two questions. Predictable rhythm.
- **Bilingual formatting.** Every German line is bold with 🇩🇪, followed by a blank line and
  the English with 🇬🇧. Easy to scan, easy to have Edge read the German aloud.
- **B2 paraphrase after every turn.** Shows the upgrade from "correct but plain" to "B2 fluent"
  every single exchange.
- **11 fixed mistake categories.** (Artikel/Genus, Kasus, Wortstellung, Verbform, Präposition,
  Wortwahl, Vokabular, Rechtschreibung, Komposition, Anglizismus/False Friend, Sonstiges.)
  The Anglizismus category specifically tracks direct-translation errors from English — a
  common, high-impact problem for English speakers in professional German contexts. Consistent
  labelling across all skills so the dashboard can spot patterns over time.
- **No em dashes. Proper umlauts always.** (ä, ö, ü, ß — never ae/oe/ue/ss.)

---

## Requirements

| Requirement | Details |
|---|---|
| Claude subscription | Pro or Team (needed for scheduled tasks) |
| Claude Code or Cowork | To install skills and run scheduled tasks |
| Notion account | Free plan is enough — create one at notion.so |
| Notion MCP connector | Enable in Claude Code Settings → Integrations |
| WebSearch + WebFetch | Needed by the Sunday skill to fetch real audio episodes (on by default) |

---

## One-Time Notion Setup

1. Create a free Notion account at notion.so.
2. Create a top-level Notion page called exactly **Deutsch lernen B2** — this is the folder
   all session notes will be saved into.
3. In Claude Code, go to **Settings → Integrations** and enable the **Notion MCP connector**.
   Grant it permission to create and read pages.
4. On mobile, install the **Notion app** (iOS App Store or Google Play) and sign in with the same account.
   Your session notes will appear there automatically after each practice.

---

## Installation

### Option A — Install the `.skill` files (easiest)

Seven `.skill` files are in `platforms/claude/` (one per skill). Drag any of them into Claude Code or Cowork and click **Save skill** in the preview.

| File | Skill |
|---|---|
| `platforms/claude/daily-german-practice.skill` | Tue/Thu conversation |
| `platforms/claude/german-weekend-review.skill` | Friday quiz |
| `platforms/claude/german-sunday-schreiben-und-hoeren.skill` | Sunday listening + translation |
| `platforms/claude/schreib-skill.skill` | Monthly free-form writing |
| `platforms/claude/lektuere-skill.skill` | Fortnightly reading comprehension |
| `platforms/claude/monatsrueckblick.skill` | Monthly report card |
| `platforms/claude/grammatik-vertiefung.skill` | Monthly grammar deep-dive |

### Option B — Copy SKILL.md manually

1. Open the skill folder (e.g. `skills/daily-german-practice/`).
2. Copy the full contents of `SKILL.md`.
3. In Claude Code or Cowork, create a new scheduled task and paste it as the prompt.

---

## Scheduled Tasks

Set up seven scheduled tasks using these cron expressions (times in your local timezone):

| Skill | Cron | When |
|---|---|---|
| daily-german-practice | `0 9 * * 2,4` | Tuesday and Thursday at 9:00 AM |
| german-weekend-review | `0 9 * * 5` | Friday at 9:00 AM |
| german-sunday-schreiben-und-hoeren | `0 9 * * 0` | Sunday at 9:00 AM |
| lektuere-skill | `0 9 * * 3` | Every other Wednesday at 9:00 AM |
| schreib-skill | `0 9 * * 6` | Every Saturday at 9:00 AM (or first Saturday of month) |
| monatsrueckblick | `0 9 1 * *` | 1st of every month at 9:00 AM |
| grammatik-vertiefung | `0 9 10 * *` | 10th of every month at 9:00 AM |

**In Cowork:**
1. Open the Scheduled section in the sidebar.
2. New scheduled task → paste the SKILL.md prompt.
3. Set the cron expression from the table above and save.

**In Claude Code:**
Use the `mcp__scheduled-tasks__create_scheduled_task` MCP tool. Pass the SKILL.md content as
`prompt` and the cron string as `cronExpression`.

---

## Multi-Platform Support

This repo is designed to work beyond Claude Code. The skill prompts live in `skills/` and the session data contract is documented in `core/session-schema.json` — any AI platform that can follow instructions and connect to Notion can run these sessions.

| Platform | All 7 skills | Notion MCP | Auto-scheduling | Setup |
|---|---|---|---|---|
| **Claude Code / Cowork** | Yes | Yes | Yes (cron) | [platforms/claude/](platforms/claude/README.md) |
| **Roo Code** | Yes | Yes (local MCP) | Partial | [platforms/roo-code/](platforms/roo-code/README.md) |
| **OpenWebUI** | Yes | Yes (MCP) | Yes | [platforms/openwebui/](platforms/openwebui/README.md) |
| **GitHub Copilot** | Yes (no Notion save) | No | No | [platforms/copilot/](platforms/copilot/README.md) |
| **n8n / GitHub Actions** | monatsrueckblick only | Yes | Yes (cron) | [platforms/n8n/](platforms/n8n/README.md) |

Claude Code is the only platform that supports all features fully. The other platforms cover different trade-offs — see each platform's README for an honest capability breakdown.

---

## How Sessions Are Saved

Each skill saves a Notion page inside **Deutsch lernen B2** with this naming convention:

| Session type | Page title format |
|---|---|
| Conversation (Tue/Thu) | `Deutsch B2 Konversation, YYYY-MM-DD, Theme` |
| Quiz (Fri) | `Deutsch B2 Quiz, YYYY-MM-DD` |
| Listening + Translation (Sun) | `Deutsch B2 Übersetzung & Hören, YYYY-MM-DD, Theme` |
| Writing (monthly Sat) | `Deutsch B2 Schreiben, YYYY-MM-DD, Task type` |
| Reading (fortnightly Wed) | `Deutsch B2 Lektüre, YYYY-MM-DD, Topic` |
| Grammar deep-dive (10th of month) | `Deutsch B2 Grammatik, YYYY-MM-DD, Topic` |
| Monthly report card (1st of month) | `Deutsch B2 Monatsrückblick, YYYY-MM, Month in German` |

The first block of every session page is a JSON code block containing the full structured
session data (vocabulary, mistakes, stats). The dashboard reads this block directly — no HTML
parsing required.

---

## Progress Dashboard

`core/dashboard/dashboard.html` is a self-contained HTML file that visualises your session history:

- Session streak heatmap (conversation sessions in blue, listening sessions in teal)
- KPI tiles: total sessions, vocabulary items, mistakes, and a combined listening/reading tile
- Recommended Focus callout: your top recurring mistake category, pinned above the charts
- Mistake category breakdown (pie chart)
- Sticky mistake categories (which errors keep recurring across sessions)
- Cumulative vocabulary growth (nouns, verbs, idioms over time)
- B2 grammar structures used
- Tabbed Vocabulary Explorer: Nouns & Adjectives / Verbs / Idioms / Ready to Reuse / Reused
- CSV export button — download your full vocabulary list as a spreadsheet

**To use it:**

1. Open `core/dashboard/dashboard.html` in Microsoft Edge or Chrome.
2. It loads with sample data by default so you can see the layout immediately.
3. After your first few real sessions, ask Claude Code:

   > "Read all pages inside my Deutsch lernen B2 Notion page and update the
   > SNAPSHOT_SESSIONS array in core/dashboard/dashboard.html with my real session data.
   > Also update SNAPSHOT_ASOF to today's date."

4. Refresh the browser tab. Your real data will now appear.

The dashboard can also attempt a live Notion load via the **"Try live again"** button if the
Notion MCP connector is available in your environment. If it is not, it falls back to the
embedded snapshot data — just ask Claude to refresh the snapshot after each session instead.

---

## Customization

- **Learner name.** The prompts use "the learner" throughout. Find and replace with your name
  in each SKILL.md for a personal touch.
- **Pronouns.** Each SKILL.md defaults to gender-neutral `they/them`. To switch to `she/her`
  or `he/him`, update the config comment on line 7 of each SKILL.md and do a find-and-replace
  for `they`/`them`/`their` in that file.
- **Time of day.** Change `0 9` in the cron to your preferred hour (`0 7` = 7 AM, `30 20` = 8:30 PM).
- **Frequency.** Daily practice runs Tue/Thu (`2,4`). Change to Mon–Fri with `1-5` or every day
  with `*`.
- **Notion page name.** All sessions save to "Deutsch lernen B2". If you rename it, find that
  string in each SKILL.md and replace it consistently.
- **CEFR level.** Skills are calibrated for B2. To retarget for B1 (loosen corrections, drop
  Konjunktiv II) or C1 (stricter bar, add Konjunktiv I), adjust the paraphrase language and
  grammar structure tracking in each SKILL.md.

---

## Additional Guides

| File | Contents |
|---|---|
| [NOTION_DATABASE_SETUP.md](NOTION_DATABASE_SETUP.md) | Optional: migrate from free-form Notion pages to a structured Notion database for calendar view and faster queries |

---

## License

MIT. Forked from the original [deutsch-lernpaket by MohgaNabil](https://github.com/MohgaNabil/deutsch-lernpaket). This fork adds Notion integration, cross-platform support, four new skill files (schreib-skill, lektuere-skill, monatsrueckblick, grammatik-vertiefung), dashboard improvements, and all documentation. Both the original and this fork's contributions are MIT licensed — use freely, remix, share.

---

Viel Erfolg beim Deutschlernen!
