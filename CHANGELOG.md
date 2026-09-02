# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Ideas or work in progress that will land in the next release.

### Changed
- Tweaks to existing behavior.

### Fixed
- Bugs squashed since the last release.

## [1.1.0] - 2026-09-02

### Added
- `dashboard-template.html` — a self-contained progress dashboard that reads the Apple Notes saved by the three skills and visualizes session streak, mistake categories, sticky category patterns, cumulative vocabulary growth, and a tabbed Vocabulary Explorer (Nouns & Adjectives / Verbs / Idioms / Ready to Reuse / Reused). Ships with sample data; ask Claude to rebuild it with your real sessions.
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

[Unreleased]: https://github.com/MohgaNabil/deutsch-lernpaket/compare/v1.1.0...HEAD
[1.1.0]: https://github.com/MohgaNabil/deutsch-lernpaket/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/MohgaNabil/deutsch-lernpaket/releases/tag/v1.0.0
