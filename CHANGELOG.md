# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.1.0] - 2026-09-06

Multi-platform Core+Adapter restructure, full dashboard overhaul with dark-mode sidebar redesign, and cross-platform dictation support.

### Added
- `platforms/antigravity/` — Google Antigravity adapter; skill format is identical to Claude Code, Notion MCP config snippet provided, Windows Task Scheduler setup script included (`task-scheduler-setup.ps1`).
- `platforms/` directory with adapters for Claude Code/Cowork, GitHub Copilot, Roo Code, OpenWebUI, and n8n.
- `platforms/claude/` — seven `.skill` files for drag-and-drop installation; scheduled task cron table.
- `platforms/copilot/` — `.github/copilot-instructions.md` adapter; capability matrix; session save guide.
- `platforms/roo-code/` — `.roo/rules/german-learning.md` (Roo Code v3+ path), `mcp-config.json`, README.
- `platforms/openwebui/` — `system-prompt.md`, README.
- `platforms/n8n/` — `monatsrueckblick-workflow.json`, `github-actions/monthly-report.yml`, README (leads with scope warning: 5 conversational skills cannot be automated in n8n).
- `core/session-schema.json` — JSON Schema documenting the session data contract across all skill types.
- `skills/` parent directory consolidating all seven SKILL.md files.
- `.github/` — `CONTRIBUTING.md`, bug report template, platform adapter template, PR template.
- Dashboard: full dark-mode sidebar layout redesign — fixed 240px sidebar (logo, nav, user avatar), 64px sticky top header (greeting, search, date), Inter font from Google Fonts.
- Dashboard: dark slate colour palette (`--bg-base: #0F172A`, `--bg-surface: #1E293B`, `--accent: #8B5CF6`) with 40+ CSS custom properties.
- Dashboard: responsive hamburger — sidebar hidden on mobile (`≤768px`), overlay backdrop, smooth slide-in transition.
- Dashboard: Monthly Focus card (pinned above KPI grid, sourced from latest `type: review` session stats).
- Dashboard: Grammar Sessions card — sub-KPI row, topic tag cloud, score table (fill-in + transform).
- Dashboard: Writing Sessions card — sub-KPI row, task type tags, register accuracy %.
- Dashboard: Trend column in Sticky Categories table (▲/▼/→ with first-half vs. second-half comparison).
- Dashboard: Type column in Session Log with coloured badges (Conversation, Quiz, Listening, Reading, Writing, Grammar, Review).
- Dashboard: Session detail drawer — click any Session Log row to expand vocabulary tags and mistakes mini-table.
- Dashboard: Four additional session types in `tryLiveLoad()` — Schreiben, Lektüre, Grammatik, Monatsrückblick.
- Dashboard: Three new heatmap cell classes — `.cell.writing`, `.cell.grammar`, `.cell.monthly-review`; legend updated to 8 entries.
- Dashboard: `getTypeMeta()` function for consistent type badge generation.
- Dashboard: Three sample sessions in `SNAPSHOT_SESSIONS` (grammar, writing, review) for testing new cards.
- Dictation tips expanded to cover all platforms in `daily-german-practice` and `grammatik-vertiefung` SKILL.md files.

### Changed
- Dashboard: KPI tile renamed from "Streak (days)" to "Active Days (7d)" — now counts distinct session days in the last 7 days, not consecutive streak.
- Dashboard: Recommended Focus banner extracted from inline `style=""` to `.banner.focus` CSS class.
- Dashboard: `exportVocabCSV()` fixed — Map iteration now uses `Array.from((window._allNouns || new Map()).values())` for all four vocabulary types.
- Dashboard: `CATEGORY_COLORS` — `Artikel/Genus` updated to `#7c3aed`; `Anglizismus` added as 12th category (`#e879f9`).
- Dashboard: Chart.js colours — Cumulative Nouns/Adj `#7c3aed`, Verbs `#0891b2`, Idioms `#f59e0b`; B2 bar `#7c3aed`.
- Dashboard: Heatmap `renderHeatmap()` refactored — now buckets by actual session type instead of broad conv/listen split; handles writing, grammar, review cells.
- README: Installation section updated with full `platforms/claude/` paths; Multi-Platform Support section added with capability matrix.
- README: dashboard path updated to `core/dashboard/dashboard.html`.
- NOTION_DATABASE_SETUP.md: dashboard path reference updated.
- Dictation tip in SKILL.md files: Windows-only tip expanded to cover macOS (Fn×2) and Android/iOS (microphone key).

### Removed
- Light purple/violet theme from dashboard (replaced by dark-mode slate design).
- Green/earth-tone colour palette from dashboard (all replaced by CSS variables).

## [2.0.0] - 2026-09-05

Fork by Gunasekaran Chandrasekaran. Notion replaces Apple Notes throughout;
cross-platform support added (Claude Code, Copilot, Roo Code, OpenWebUI, n8n).

### Added
- `schreib-skill` — monthly free-form writing session with 6 rotating task types: informal email, formal letter, opinion paragraph, recruiter email, motivation paragraph, professional description (100-150 words, 6-section structured evaluation).
- `lektuere-skill` — fortnightly reading comprehension on a real 300-500 word German article fetched from tagesschau.de, Spiegel, Zeit, Handelsblatt, Gründerszene, or Heise; pre-teaches 5 vocabulary items, asks 6 comprehension questions.
- `monatsrueckblick` — monthly report card that aggregates all session JSON from the past 30 days and outputs 3 concrete focus areas.
- `grammatik-vertiefung` — monthly grammar deep-dive (10th of each month). 12-topic rotation (Konjunktiv I/II, Passiv, Nominalisierung, Relativsätze, Modalpartikeln, etc.) with lesson, fill-in-the-blank, transformation drills, and free production.
- Dashboard: listening heatmap (teal cells), listening/reading KPI tile, Recommended Focus callout (top sticky mistake category), CSV export button (`exportVocabCSV()`), mobile layout (`@media max-width: 480px`, 18 px cells, 28-day mobile heatmap), dual-mode live load (page-search or database query via `NOTION_DB_ID`).
- `NOTION_DATABASE_SETUP.md` — step-by-step guide for optional Notion database mode.
- Optional database mode in all seven SKILL.md files.
- Seven updated `.skill` files (one per skill) in `platforms/claude/` for drag-and-drop installation.
- Anglizismus/False Friend added as an 11th fixed mistake category across all skills.
- Sticky Challenge micro-drill in german-weekend-review: categories recurring 3+ times in 14 days trigger a focused 3-question drill.
- Dictation error detection in daily-german-practice: flags das/dass, seit/seid, wider/wieder from voice input.
- 💼 professional theme prefix for recruiter email, motivation letter, and professional description tasks (schreib-skill) and Handelsblatt/Gründerszene/Heise articles (lektuere-skill).

### Changed
- All three original skills fully migrated from Apple Notes MCP to Notion MCP (`notion_create_page`, `notion_search`, `notion_retrieve_block_children`). Apple Notes MCP calls removed entirely.
- Every Notion page now starts with a JSON code block as its first block — machine-readable session data that powers the dashboard without HTML parsing.
- `daily-german-practice`: reads latest recommendations from the most recent Quiz and Sunday pages before each session; avoids last 4 themes; adds vocabulary warm-up (words learned 14+ days ago, not yet reused).
- `german-weekend-review`: quiz pool now covers full session history (RECENT 60% + OLDER 40%); Runde 3 Fehler-Rewind weighted by recurrence map across all sessions.
- `german-sunday-schreiben-und-hoeren`: teaches 3 key words *before* the learner opens the audio link (replaces post-listen Mini-Brücke); fallback to Edge Read Aloud instead of Mac Option+Esc.
- Learner pronouns centralised to a config comment at the top of each SKILL.md.
- README revised end-to-end: seven skills documented, Notion setup, cross-platform guidance, how sessions are saved, dashboard usage.
- LICENSE updated with dual copyright (original + fork).
- CHANGELOG updated.

### Fixed
- Dashboard: `reviewNotes` filter was matching `'Deutsch B2 Review'` instead of `'Deutsch B2 Quiz'` — Friday quiz sessions never populated the heatmap.
- Dashboard: Sunday sessions (`'Deutsch B2 Übersetzung & Hören'`) were never fetched or parsed — listening data was invisible.
- Dashboard: Apple Notes comment in source and stale `SNAPSHOT_ASOF` date replaced with Notion references and current date.

### Removed
- Apple Notes MCP connector dependency.
- GETTING_STARTED.md, ANDROID_WINDOWS_SETUP.md, SKILLS_AND_NOTION.md, REVIEW.md, IMPROVEMENTS.md (working documents, now superseded by the updated README and NOTION_DATABASE_SETUP.md).

## [1.1.0] - 2026-09-02

### Added
- `core/dashboard/dashboard.html` — a self-contained progress dashboard that reads the Apple Notes saved by the three skills and visualizes session streak, mistake categories, sticky category patterns, cumulative vocabulary growth, and a tabbed Vocabulary Explorer (Nouns & Adjectives / Verbs / Idioms / Ready to Reuse / Reused). Ships with sample data; ask Claude to rebuild it with your real sessions.
- README section explaining how to set up and refresh the dashboard.

## [1.0.0] - 2026-09-02

### Added
- `daily-german-practice.skill` — Tue/Thu 30-min live conversation with per-mistake categorization, mandatory B2-Umformulierung after every answer, and a rich Apple Note summary (Zusammenfassung, Wörter, Verben, Redewendungen, Fehler-Check, B2-Umformulierungen, Wiederverwendung, Statistik).
- `german-weekend-review.skill` — Friday quiz-show format with 10-15 questions grouped into 4-5 themed Runden (Vokabel-Roulette, Verb-Werkstatt, Fehler-Rewind, Redewendungen & Übersetzung, B2-Upgrade). One question per message, live score tracking, streak callouts.
- `german-sunday-schreiben-und-hoeren.skill` — Sunday listening + translation on the same theme. Fetches real 3-5 min content from DW, Easy German, Slow German, Nachrichtenleicht, or DW Jojo. Sentence-by-sentence translation feedback plus a full B2 reference translation.
- README with installation, cron schedule, connector requirements, and customization guide.
- Bilingual chat formatting standard (🇦🇹 bold German + 🇬🇧 English) documented in each SKILL.md.

### Design principles
- One question per message (max two).
- No em dashes; proper umlauts (ä, ö, ü, ß) required.
- Fixed 10-category mistake taxonomy for pattern tracking over time.
- B2 paraphrase after every corrected answer to show the "correct → fluent" upgrade path.

[2.1.0]: https://github.com/kalaiguna/deutsch-lernpaket/compare/v2.0.0...HEAD
[2.0.0]: https://github.com/kalaiguna/deutsch-lernpaket/compare/v1.1.0...v2.0.0
[1.1.0]: https://github.com/MohgaNabil/deutsch-lernpaket/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/MohgaNabil/deutsch-lernpaket/releases/tag/v1.0.0
