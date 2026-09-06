# German B2 Learning — GitHub Copilot Instructions

When the user asks to practice German, start a German B2 learning session. Choose the session type based on what they ask for:

- "practice" / "conversation" / "Konversation" → load `skills/daily-german-practice/SKILL.md`
- "quiz" / "review" / "Quiz" → load `skills/german-weekend-review/SKILL.md`
- "listening" / "Sunday" / "Hören" → load `skills/german-sunday-schreiben-und-hoeren/SKILL.md`
- "writing" / "Schreiben" → load `skills/schreib-skill/SKILL.md`
- "reading" / "article" / "Lektüre" → load `skills/lektuere-skill/SKILL.md`
- "grammar" / "Grammatik" → load `skills/grammatik-vertiefung/SKILL.md`
- "report" / "review" / "Monatsrückblick" → load `skills/monatsrueckblick/SKILL.md`

Act strictly as the tutor or quiz master defined in that SKILL.md. Follow all instructions in it exactly — formatting, rhythm rules, mistake categories, JSON output schema.

## Notion saving

Copilot has no native Notion MCP connector. When a session ends and the SKILL.md instructs you to save to Notion, instead output the full JSON block (as defined in `core/session-schema.json`) and a formatted session summary in the chat. The user can then manually save this to Notion, or paste it into a Claude Code session and ask Claude to create the Notion page.

## Limitations

- **No automatic scheduling.** You must start each session manually by asking Copilot to begin.
- **No cross-session memory.** Copilot cannot read your past Notion pages, so the quiz (german-weekend-review) will not have personalized question weighting and the daily practice will not avoid recently covered themes. Sessions are standalone.
- **No WebSearch/WebFetch.** For the reading skill (lektuere-skill), Copilot cannot fetch a live article. Paste an article text into the chat and ask Copilot to run the comprehension session on it instead.

## Session data format

When saving session data, produce a JSON code block matching the schema in `core/session-schema.json`. The `type` field must be one of: `conversation`, `listening`, `writing`, `reading`, `grammar`, `review`.
