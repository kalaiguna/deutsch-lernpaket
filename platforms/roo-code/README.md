# Roo Code Platform

[Roo Code](https://github.com/RooVetGit/Roo-Code) is a VS Code extension that provides an agentic AI coding assistant with native MCP support. It is the closest 1:1 alternative to Claude Code for this repo — it supports Notion MCP, can follow long multi-step instructions, and works with multiple model providers.

## What works

| Feature | Supported |
|---|---|
| All 7 skills (conversational + one-shot) | Yes |
| Notion MCP (auto-save) | Yes — via local MCP server |
| Notion reads for cross-session memory | Yes (daily practice, weekend quiz) |
| WebSearch / WebFetch for articles and audio | Depends on model provider |
| Automated scheduling | Partial — see scheduling section below |

## Setup

### 1. Install Roo Code

In VS Code, install the **Roo Code** extension from the marketplace.

### 2. Configure your model

Roo Code supports multiple providers. Recommended for best German language quality:

| Provider | Model | Notes |
|---|---|---|
| Anthropic | claude-sonnet-4-6 | Best instruction-following and German quality |
| OpenAI | gpt-4o | Good alternative |
| Google | gemini-1.5-pro | Good for long context (monatsrueckblick) |
| Local (Ollama) | llama3.1:70b or similar | Privacy-preserving but slower, lower quality |

### 3. Set up Notion MCP

1. Create a Notion integration at [notion.so/my-integrations](https://www.notion.so/my-integrations) and copy the token.
2. Copy `mcp-config.json` from this folder to your Roo Code MCP config location:
   - Windows: `%APPDATA%\Code\User\globalStorage\rooveterinaryinc.roo-cline\settings\mcp_settings.json`
   - Or add the `notion` server block to your existing config.
3. Replace `YOUR_NOTION_INTEGRATION_TOKEN` with your actual token.
4. Share your "Deutsch lernen B2" Notion page with the integration.

### 4. Load the system prompt

Copy `.roo/rules/german-learning.md` from this folder to your project's `.roo/rules/` directory. Roo Code loads all `.md` files in that directory as system prompt additions.

### 5. Start a session

In the Roo Code chat panel, say:
- "Start my German daily practice"
- "Run the German quiz"
- "German reading comprehension session"

## Scheduling

Roo Code itself does not have a built-in cron scheduler. Options:

**Option A — Windows Task Scheduler:** Create a scheduled task that runs a script opening VS Code with the Roo Code chat pre-populated. This is approximate and requires VS Code to be running.

**Option B — Pair with n8n or GitHub Actions (one-shot skills only):** For `monatsrueckblick`, use the n8n or GitHub Actions workflow in `platforms/n8n/` to trigger the session via API. Conversational skills still need to be started manually.

**Option C — Morning routine:** Simply open VS Code each morning on practice days and ask Roo Code to start the session. For many learners this is the most practical approach.

## Notes

- The `.skill` files in `platforms/claude/` are Claude Code-specific ZIP archives and cannot be imported into Roo Code directly. Use the SKILL.md files in `skills/` instead.
- Roo Code's file-reading capability means it can read `skills/*/SKILL.md` directly — you do not need to paste the prompt manually.
