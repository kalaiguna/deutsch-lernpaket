# OpenWebUI Platform

[OpenWebUI](https://openwebui.com) is a self-hosted, model-agnostic chat interface that supports MCP and custom system prompts. It is ideal for learners who want a clean chat experience without an IDE, and who prefer to self-host rather than use Claude Code or Cowork.

## What works

| Feature | Supported |
|---|---|
| All 7 skills (conversational sessions) | Yes — via system prompt |
| Notion MCP (auto-save) | Yes — via OpenWebUI MCP connector |
| Automated scheduling | Yes — via OpenWebUI's built-in task scheduler |
| WebSearch / WebFetch | Yes — if enabled in OpenWebUI settings |
| Cross-session Notion reads (adaptive quiz, theme avoidance) | Yes — via Notion MCP |
| Dashboard live load | No — uses `window.cowork.callMcpTool()` (Claude Code specific) |

## Setup

### 1. Install OpenWebUI

Follow the [OpenWebUI installation guide](https://docs.openwebui.com). The simplest option on Windows is Docker Desktop:

```
docker run -d -p 3000:8080 -v open-webui:/app/backend/data --name open-webui ghcr.io/open-webui/open-webui:main
```

Then open `http://localhost:3000` in your browser.

### 2. Connect a model

Add your preferred provider in OpenWebUI settings:
- **Anthropic API** (Claude) — best German quality
- **OpenAI API** (GPT-4o) — good alternative
- **Local Ollama** — privacy-preserving, works offline

### 3. Add Notion MCP

In OpenWebUI settings, add the Notion MCP server. Use the same config as `platforms/roo-code/mcp-config.json`. Replace `YOUR_NOTION_INTEGRATION_TOKEN` with your actual token.

### 4. Create a custom model

1. In OpenWebUI, go to **Models → Create model**.
2. Name it "German B2 Tutor".
3. Paste the contents of `system-prompt.md` (from this folder) as the system prompt.
4. Save the model.

### 5. Set up scheduling (optional)

OpenWebUI has a built-in **Task Scheduler** (Settings → Tasks). Create tasks for each skill using the cron expressions from `platforms/claude/README.md`. Set the first message to "Start my German [daily practice / quiz / writing / etc.] session."

## Starting a session manually

Open the "German B2 Tutor" model in OpenWebUI chat and say:
- "Start my German daily practice"
- "I want to do the quiz today"
- "Reading comprehension please"

## Notes

- OpenWebUI's MCP support means it can call Notion directly, unlike Copilot. This enables cross-session memory for the daily practice and quiz skills.
- For the reading and Sunday listening skills, WebSearch/WebFetch must be enabled in OpenWebUI settings for Claude or another capable model.
- The dashboard (`core/dashboard/dashboard.html`) will work in snapshot mode regardless of platform, but the live Notion load requires Claude Code/Cowork. Use the snapshot refresh method instead (ask the AI to rebuild the `SNAPSHOT_SESSIONS` array).
