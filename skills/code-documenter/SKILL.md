---
name: code-documenter
description: Generate product-focused documentation from an existing codebase. Use when asked to document a repo, create docs, write product documentation, explain what a project does, or generate user-facing guides from source code.
---

# Code Documenter

Generate clear, product-focused documentation from the codebase in the current repository. The output should help users understand what the product does, how to use it, and how to configure it — not just describe the code.

## Principles

- **Product over implementation** — Write for users of the product, not maintainers of the code. Lead with what things do, not how they're built.
- **Evidence-based** — Every claim must trace back to source code. Don't guess at behavior.
- **Practical** — Prioritize setup guides, configuration references, and usage examples over architecture overviews.
- **Concise** — Say it once, say it clearly. Avoid restating the same concept across pages.

## Workflow

1. **Understand the project**
   - Read the README, CLAUDE.md, package.json/pyproject.toml/Cargo.toml (or equivalent manifest).
   - Identify the project type: CLI tool, library, web app, API service, plugin, etc.
   - Note the primary language, framework, and build system.

2. **Map the product surface**
   - Identify user-facing features: commands, endpoints, UI pages, exports, configuration options, environment variables.
   - Capture evidence for each (file path + symbol/setting).
   - Focus on what users interact with, not internal modules.

3. **Survey existing docs**
   - Check for existing docs/ directory, README sections, inline docstrings, or generated API references.
   - Note what's already well-documented and what's missing or outdated.
   - Identify the existing docs style and conventions to stay consistent.

4. **Propose a documentation plan**
   - Recommend a set of docs to create or update, organized by user need:
     - **Getting started** — installation, prerequisites, quickstart
     - **Usage guide** — core workflows, common tasks, examples
     - **Configuration reference** — all options, defaults, environment variables
     - **API reference** (if applicable) — endpoints, parameters, responses
     - **CLI reference** (if applicable) — commands, flags, examples
   - Present the plan to the user and ask for approval before writing.

5. **Write the documentation**
   - Write in markdown by default.
   - Use the project's existing docs conventions if they exist (file structure, heading style, tone).
   - Include working code examples derived from the actual codebase.
   - Reference specific defaults and behaviors from source — don't paraphrase loosely.
   - Place docs in `docs/` unless the project uses a different convention.

6. **Verify**
   - Confirm all documented features, options, and defaults match the current code.
   - If the project has a docs build command, run it to verify the output builds cleanly.

## Output Format

When presenting a documentation plan, use this structure:

```
## Documentation Plan

### Proposed docs
- [page name] — what it covers, why it's needed
- [page name] — ...

### Existing docs to update
- [file] — what's missing or outdated

### Questions
- Any clarifications needed from the user
```

## References

- `references/doc-coverage-checklist.md`
