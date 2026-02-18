# salient-skills

A [Claude Code plugin](https://code.claude.com/docs/en/plugins) with skills for doc sync, CLAUDE.md improvement, skill creation, design, document generation, and Slack GIF creation. Built on the [Agent Skills](https://agentskills.io) open standard.

## About

Skills are folders of instructions, scripts, and resources that Claude loads dynamically to improve performance on specialized tasks. Each skill is self-contained with a `SKILL.md` file containing YAML frontmatter and markdown instructions.

For more information:
- [What are skills?](https://support.claude.com/en/articles/12512176-what-are-skills)
- [Using skills in Claude](https://support.claude.com/en/articles/12512180-using-skills-in-claude)
- [How to create custom skills](https://support.claude.com/en/articles/12512198-creating-custom-skills)
- [Equipping agents for the real world with Agent Skills](https://anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills)

## Plugin Manifest

The plugin manifest at `.claude-plugin/plugin.json` declares all metadata per the [plugin reference spec](https://code.claude.com/docs/en/plugins-reference):

| Field | Value |
|-------|-------|
| **name** | `salient-skills` |
| **version** | `1.0.0` |
| **license** | MIT |
| **author** | Alejandro Dinsmore |
| **skills** | `./skills/` (auto-discovered) |
| **keywords** | skills, claude-code, docs-sync, design, pdf, pptx, slack-gif, claude-md |

## Plugin Structure

```
salient-skills/
├── .claude-plugin/
│   └── plugin.json          # Plugin manifest
├── skills/                  # Skills directory (auto-discovered)
│   ├── brand-design/        # Brand design direction and guidelines
│   ├── canvas-design/       # Museum-quality visual art and design
│   ├── claude-md-improver/  # Audit and improve CLAUDE.md files
│   ├── docs-sync/           # Sync documentation with code
│   ├── frontend-design/     # Production-grade web interfaces
│   ├── pdf/                 # PDF manipulation and creation
│   ├── pptx/                # PowerPoint creation and editing
│   ├── skill-creator/       # Guide for creating new skills
│   └── slack-gif-creator/   # Animated GIFs for Slack
├── README.md
└── THIRD_PARTY_NOTICES.md
```

## Installation

### Claude Code

Install this plugin in Claude Code:
```
claude plugin add /path/to/salient-skills
```

Or test locally during development:
```
claude --plugin-dir ./salient-skills
```

After installing, skills are auto-discovered from `./skills/`. Use them by mentioning them directly (e.g. `docs-sync` or `claude-md-improver`).

### Claude.ai

These example skills are available to paid plans in Claude.ai. See [Using skills in Claude](https://support.claude.com/en/articles/12512180-using-skills-in-claude#h_a4222fa77b).

### Claude API

Use Anthropic's pre-built skills or upload custom skills via the API. See the [Skills API Quickstart](https://docs.claude.com/en/api/skills-guide#creating-a-skill).

## Creating a Skill

A skill is a directory with a `SKILL.md` containing YAML frontmatter and instructions:

```markdown
---
name: my-skill-name
description: A clear description of what this skill does and when to use it
---

# My Skill Name

Instructions, examples, and guidelines that Claude will follow.
```

The frontmatter requires two fields:
- `name` — unique identifier (lowercase, hyphens for spaces, must match directory name)
- `description` — what the skill does and when to use it

For details, see [How to create custom skills](https://support.claude.com/en/articles/12512198-creating-custom-skills).

## Disclaimer

**These skills are provided for demonstration and educational purposes only.** Implementations and behaviors may differ from what is shown. Test thoroughly in your own environment before relying on them for critical tasks.

## License

MIT. Some skills (pdf, pptx) are source-available under their own license terms — see individual `LICENSE.txt` files.
