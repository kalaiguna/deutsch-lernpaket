# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
- `platforms/` directory with adapters for Copilot, Roo Code, OpenWebUI, and n8n.
- `core/session-schema.json` — JSON Schema documenting the session data contract across all skill types.
- `.github/` — CONTRIBUTING.md, issue templates, PR template.
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

[2.0.0]: https://github.com/kalaiguna/deutsch-lernpaket/compare/v1.1.0...HEAD
[1.1.0]: https://github.com/MohgaNabil/deutsch-lernpaket/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/MohgaNabil/deutsch-lernpaket/releases/tag/v1.0.0
