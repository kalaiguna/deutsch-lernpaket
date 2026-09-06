# Contributing to deutsch-lernpaket

Thank you for your interest in contributing. This project is an open-source German B2 learning framework that works across multiple AI platforms.

## Ways to contribute

### 1. Add a new platform adapter

If you have set up this learning framework on a platform not yet listed in `platforms/`, we welcome a new adapter. Use an existing platform folder as a template (e.g., `platforms/roo-code/`). Your PR should include:

- A `README.md` explaining what the platform is, what works and what does not, and step-by-step setup instructions
- Any platform-specific config files (system prompts, MCP configs, workflow files)
- Honest capability notes — especially if conversational skills have limitations

Use the `platform_adapter` issue template to describe your platform before opening a PR.

### 2. Improve an existing skill prompt

The skill definitions live in `skills/*/SKILL.md`. These prompts are carefully tuned; please test any changes thoroughly with Claude Code before proposing them.

When editing a SKILL.md:
- Test the full session flow (not just the part you changed)
- Check that the JSON output still matches `core/session-schema.json`
- Verify bilingual formatting rules are still correct (🇩🇪 bold + 🇬🇧 plain)
- Do not change the 11 mistake category names — these are referenced by the dashboard

### 3. Report a bug

Use the `bug_report` issue template. Include the platform you are using, the skill name, and what happened vs. what you expected.

### 4. Improve documentation

README improvements, clearer setup steps, and additional examples are always welcome. Keep the tone practical and honest — if something does not work on a platform, say so clearly.

## Development workflow

1. Fork the repository.
2. Create a branch from `main`: `git checkout -b your-feature-name`.
3. Make your changes.
4. Test with your actual Notion setup if you are changing skill prompts.
5. Open a PR using the PR template.

## Code of conduct

Be kind, be honest, be helpful. This is a learning tool for real people — accuracy and clarity matter more than cleverness.
