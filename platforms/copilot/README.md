# GitHub Copilot Platform

Use GitHub Copilot for on-demand German practice sessions directly inside VS Code, without leaving your editor.

## What works

| Feature | Supported |
|---|---|
| Conversational sessions (daily, Sunday, grammar, reading, writing) | Yes — in Copilot Chat |
| Mistake corrections with 11-category taxonomy | Yes |
| B2 paraphrase after every turn | Yes |
| Session JSON output (for manual Notion save) | Yes |
| Automated Notion saving | No — no native Notion MCP |
| Automated scheduling (cron) | No — sessions are on-demand only |
| Cross-session memory (theme avoidance, warm-up words, adaptive quiz) | No — no Notion reads |
| Live article/audio fetch for reading/listening skills | No — no WebSearch |

**Copilot is best for:** quick on-demand practice while you are already working in VS Code. It does not replace Claude Code for the full automated, memory-aware experience.

## Setup

1. Ensure you have **GitHub Copilot** enabled in VS Code (extension + subscription).
2. Copy `.github/copilot-instructions.md` from this folder into your repo root's `.github/` directory (or the root itself, depending on your Copilot version).
3. Open **Copilot Chat** in VS Code (Ctrl+Alt+I).
4. Say: "Start my German B2 daily practice" — Copilot will follow the tutor instructions.

## Starting a session

Ask Copilot Chat in plain English:

- "Start my German B2 daily practice"
- "Run the German quiz session"
- "I want to do my German reading comprehension. Here is the article: [paste text]"
- "Let's do the German writing task"
- "Start the grammar deep-dive session"

## Saving session data

At the end of each session, Copilot will output the structured JSON block. To save it to Notion:

**Option A:** Copy the JSON, open a Claude Code session, and say: "Save this German session to my Deutsch lernen B2 Notion page" — paste the JSON.

**Option B:** Use the Notion web interface to create a page manually and paste the session summary.

## Recommended Copilot model

Use **GPT-4o** or **Claude Sonnet** (if available via Copilot) for best German language quality and instruction-following.
