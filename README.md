# salient-product-skills

A [Claude Code plugin](https://code.claude.com/docs/en/plugins) with skills for design, documentation, and developer tooling. Built on the [Agent Skills](https://agentskills.io) open standard.

## Skills

### Design & Creative

| Skill | Description |
|-------|-------------|
| **brand-design** | Apply Salient's visual identity and brand guidelines to design and copy |
| **frontend-design** | Create distinctive, production-grade frontend interfaces with high design quality |
| **slack-gif-creator** | Create animated GIFs optimized for Slack with proper dimensions and file sizes |

### Documentation & Developer Tools

| Skill | Description |
|-------|-------------|
| **code-documenter** | Generate product-focused documentation from an existing codebase |
| **claude-md-improver** | Audit and improve CLAUDE.md files in repositories |
| **skill-creator** | Guide for creating and packaging new Claude Code skills |

## Installation

### Claude Code (marketplace)

Register the marketplace and install:
```
/plugin marketplace add aldinsmoresalient/salient-skills
/plugin install salient-product-skills
```

### Claude Code (direct)

Install as a plugin directly:
```
claude plugin add /path/to/salient-skills
```

Or test locally during development:
```
claude --plugin-dir ./salient-skills
```

After installing, skills are auto-discovered from `./skills/`. Use them by describing the task — Claude matches your request to the right skill automatically.

### Claude.ai

These example skills are available to paid plans in Claude.ai. See [Using skills in Claude](https://support.claude.com/en/articles/12512180-using-skills-in-claude#h_a4222fa77b).

### Claude API

Use Anthropic's pre-built skills or upload custom skills via the API. See the [Skills API Quickstart](https://docs.claude.com/en/api/skills-guide#creating-a-skill).

## Plugin Structure

```
salient-skills/
├── .claude-plugin/
│   └── plugin.json              # Plugin manifest
├── skills/
│   ├── brand-design/            # Salient brand identity and guidelines
│   ├── claude-md-improver/      # CLAUDE.md auditing and improvement
│   ├── code-documenter/         # Product-focused documentation generation
│   ├── frontend-design/         # Production-grade web interfaces
│   ├── skill-creator/           # Skill authoring guide
│   └── slack-gif-creator/       # Animated GIFs for Slack
├── README.md
└── THIRD_PARTY_NOTICES.md
```

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

## Learn More

- [What are skills?](https://support.claude.com/en/articles/12512176-what-are-skills)
- [Using skills in Claude](https://support.claude.com/en/articles/12512180-using-skills-in-claude)
- [How to create custom skills](https://support.claude.com/en/articles/12512198-creating-custom-skills)
- [Equipping agents for the real world with Agent Skills](https://anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills)

## Disclaimer

**These skills are provided for demonstration and educational purposes only.** Implementations and behaviors may differ from what is shown. Test thoroughly in your own environment before relying on them for critical tasks.

## License

MIT. Some skills include their own license terms — see individual `LICENSE.txt` files.
