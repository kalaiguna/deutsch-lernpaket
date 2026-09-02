# Deutsch B2 Lernpaket

Three Claude skills for a full weekly German B2 practice routine, designed for a learner working toward fluent B2 conversation.

## What's inside

| Skill | When it runs | What it does |
|---|---|---|
| **daily-german-practice** | Tue + Thu, 9 AM | Live 30-min German conversation. Catches every mistake with a category label, always adds a B2 paraphrase, saves a rich Apple Note with vocabulary, verbs, idioms, mistakes, reused items, and stats. |
| **german-weekend-review** | Fri, 9 AM | Game-show quiz format with 4-5 themed Runden and 10-15 questions max. Mandatory "Fehler-Rewind" round that re-tests past mistakes. Saves a scored quiz note. |
| **german-sunday-schreiben-und-hoeren** | Sun, 9 AM | Listening round using real audio/video from Deutsche Welle, Easy German, or Slow German (3-5 min with transcript), plus a translation round on the same theme. Sentence-by-sentence corrections with B2 reformulations. |

All three save summary notes into a single Apple Notes folder called **Deutsch lernen B2 🇦🇹**, which lets you build a growing library of your own German learning history and (optionally) power a progress dashboard.

## Design principles

- **One question at a time.** Gentle rhythm that's easy to follow. No message ever asks more than two questions.
- **Bilingual formatting.** Every German line is bold with the 🇦🇹 flag, followed by a blank line and the English translation with the 🇬🇧 flag. Easy to scan, easy to have your Mac read the German aloud.
- **No em dashes.** Uses commas, periods, pipes, or middle dots as separators.
- **Proper umlauts always** (ä, ö, ü, ß). No "ae/oe/ue/ss" substitutes.
- **B2 paraphrase after every mistake.** Shows the upgrade path from "correct but plain" to "B2 fluent" on every turn.
- **Mistake categories.** Each mistake gets one of 10 fixed labels (Artikel/Genus, Kasus, Wortstellung, Verbform, Präposition, Wortwahl, Vokabular, Rechtschreibung, Komposition, Sonstiges) so you can spot patterns over time.

## Installation

### Option A: Install the `.skill` files (easiest)

1. Download the `.skill` file you want from the [releases page](../../releases) or from this repo.
2. Drag the file into Claude (Claude Code, Cowork, or claude.ai).
3. Click **Save skill** in the file preview.
4. The skill is now available for scheduled tasks and manual invocation.

### Option B: Copy the SKILL.md manually

1. Open the folder for the skill you want (e.g. `daily-german-practice/`).
2. Copy the entire content of `SKILL.md`.
3. In Cowork or Claude Code, create a new scheduled task and paste the content as the prompt.

## Setting up the scheduled tasks

Each skill runs as a scheduled task with these cron expressions (times in your local timezone):

| Skill | Cron | Human-readable |
|---|---|---|
| daily-german-practice | `0 9 * * 2,4` | Tuesday & Thursday at 9:00 AM |
| german-weekend-review | `0 9 * * 5` | Friday at 9:00 AM |
| german-sunday-schreiben-und-hoeren | `0 9 * * 0` | Sunday at 9:00 AM |

In **Cowork**:
1. Open the Scheduled section in the sidebar.
2. New scheduled task → paste the SKILL.md prompt.
3. Set the cron expression from the table above.
4. Save.

In **Claude Code**:
1. Use the `mcp__scheduled-tasks__create_scheduled_task` MCP tool.
2. Pass the SKILL.md content as `prompt`, and the cron string as `cronExpression`.

## Required connectors

All three skills need **Read and Write Apple Notes** access (macOS only) to save session summaries. Grant permission when Claude first asks.

The **Sunday Schreiben & Hören** skill also uses **WebSearch and WebFetch** to find a fresh German podcast or video episode each week. Both are typically available by default.

## Customization

- **Learner name.** The prompts refer to "the learner" (generic). Search and replace with your name for a personal touch.
- **Time of day.** Change the `0 9` in the cron to any hour that fits your schedule (`0 7` for 7 AM, `30 20` for 8:30 PM, etc.).
- **Frequency.** The daily practice runs Tue/Thu (`* * 2,4`). Swap to Mon-Fri with `* * 1-5`, or every day with `* * *`.
- **Folder name.** All notes save into "Deutsch lernen B2 🇦🇹". If you prefer a different folder name, find that string in each SKILL.md and replace it.
- **CEFR level.** The prompts are calibrated for B2. To retarget for B1 or C1, adjust: the "B2 paraphrase" language, the mistake bar (looser corrections for B1, stricter for C1), and the required grammar structures (e.g. drop Konjunktiv II for B1, add Konjunktiv I for C1).

## Recommended companion: progress dashboard

I built a small HTML dashboard that reads all the Apple Notes saved by these skills and visualizes progress over time: session streak, mistake categories (pie chart), sticky category patterns, cumulative vocabulary growth, B2 structures used, Ready-to-Reuse list, etc. Not included in this repo but easy to build if you want one; open an issue and I can share the template.

## License

MIT. Use freely, remix, share. Attribution appreciated but not required.

## Feedback

If you use these skills and something feels off (too strict, too gentle, too much scaffolding, unclear formatting), open an issue with a concrete example. The skills have been iterated many times based on real-world use by a B2 learner, and every new use case makes them better.

Viel Erfolg beim Deutschlernen!
