# n8n Platform

> **Important:** Only `monatsrueckblick` and (partially) `schreib-skill` can run as n8n workflows. Read this before setting anything up.

## Why most skills cannot run in n8n

Five of the seven skills in this repo are **conversational** — they run as a live back-and-forth exchange where the AI asks one question, waits for the learner's typed answer, gives feedback, then asks the next question. A single session involves 10-30 turns over 20-30 minutes.

n8n is a workflow automation tool: it executes a fixed sequence of nodes and then stops. It cannot pause mid-workflow to wait for a human's typed reply, then resume. There is no "wait for chat input" node.

| Skill | Session type | n8n viable? | Reason |
|---|---|---|---|
| daily-german-practice | Conversational (30 min, ~15 turns) | No | Requires live chat |
| german-weekend-review | Conversational (quiz, up to 15 questions) | No | Requires live chat |
| german-sunday-schreiben-und-hoeren | Conversational (2-part, ~10 turns) | No | Requires live chat |
| lektuere-skill | Conversational (6 comprehension questions) | No | Requires live chat |
| grammatik-vertiefung | Conversational (lesson + 5 exercises) | No | Requires live chat |
| schreib-skill | Two turns (prompt → evaluate) | Partial | Can send the task prompt automatically; the learner still writes and gets feedback in a chat interface |
| monatsrueckblick | One-shot (automated, no learner input) | **Yes** | Reads Notion, generates report, saves back — fully automatable |

## What n8n can do

### monatsrueckblick (monthly report — fully automated)

n8n can automate the entire monthly report card:
1. Schedule trigger fires on the 1st of each month at 9 AM.
2. n8n reads all "Deutsch B2" Notion pages from the past 30 days via the Notion API.
3. n8n sends the data + the skill prompt to the Anthropic API.
4. n8n saves the report as a new Notion page.

See `monatsrueckblick-workflow.json` for a ready-to-import skeleton.

### schreib-skill (partial — task delivery only)

n8n can send you the writing task prompt on a schedule (e.g., first Saturday of the month). You then write your 100-150 word text and paste it into your preferred AI chat (Claude Code, Roo Code, OpenWebUI) to get the full structured feedback. The evaluation step must happen in a conversational interface.

## Importing the workflow

1. Open your n8n instance.
2. Go to **Workflows → Import from file**.
3. Import `monatsrueckblick-workflow.json`.
4. Set your credentials in the workflow nodes:
   - **Anthropic API:** add your API key in n8n credentials.
   - **Notion:** add your integration token in n8n credentials.
5. Activate the workflow.

## Credentials required

| Service | Where to get it |
|---|---|
| Anthropic API key | [console.anthropic.com](https://console.anthropic.com) |
| Notion integration token | [notion.so/my-integrations](https://www.notion.so/my-integrations) |

## GitHub Actions alternative

If you do not want to self-host n8n, see `github-actions/monthly-report.yml` for an equivalent GitHub Actions workflow. It uses GitHub's `schedule:` trigger and calls the Anthropic and Notion APIs directly via `curl`. No self-hosted infrastructure required.
