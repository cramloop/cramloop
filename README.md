# Lorky

Claude Code plugin for coursework-based tutoring in **math** and **history**. Skills run structured quiz sessions: scope materials, build a private mark scheme, ask one question at a time, and score with feedback traced to the student's sources.

## Skills

| Skill | Invoke | Purpose |
| --- | --- | --- |
| Math tutor | `/lorky:math-tutor` | Practice and test prep from worksheets, textbook chapters, and course topics |
| History tutor | `/lorky:history-tutor` | Revision and exam practice from notes, past papers, and teacher materials |

## Install

### Local development

```bash
claude --plugin-dir /path/to/Lorky
```

After changes, run `/reload-plugins` in Claude Code.

### From this repository (team marketplace)

After pushing to GitHub, teammates add the catalog and install:

```bash
claude plugin marketplace add kkarski/Lorky
claude plugin install lorky@lorky
```

Or from a local clone during development:

```bash
claude plugin marketplace add /path/to/Lorky
claude plugin install lorky@lorky
```

Refresh after updates:

```bash
claude plugin marketplace update lorky
```

### Community marketplace

To submit for public review, use the [Claude plugin submission form](https://platform.claude.com/plugins/submit) after validating locally.

Validate before publishing:

```bash
claude plugin validate /path/to/Lorky
claude plugin validate /path/to/Lorky --strict
```

## Usage

1. Open a project with study materials (or attach files in chat).
2. Invoke a skill, e.g. `/lorky:history-tutor`.
3. Confirm scope (topics, grade level, question count, format).
4. Answer questions one at a time; receive scored feedback after each.

Quiz sessions are written to `quizzes/` in the working project.

## Structure

```
Lorky/
├── .claude-plugin/
│   ├── plugin.json          # Plugin manifest
│   └── marketplace.json     # Team marketplace catalog
├── skills/
│   ├── math-tutor/
│   │   └── SKILL.md
│   ├── history-tutor/
│   │   └── SKILL.md
│   └── references/
│       └── docling.md       # Converting PDF/DOCX materials to Markdown
└── materials/               # Example study materials (optional)
```

## License

MIT
