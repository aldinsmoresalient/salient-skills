---
name: claude-md-improver
description: Audit and improve CLAUDE.md files in repositories. Use when user asks to check, audit, update, improve, or fix CLAUDE.md files. Scans for all CLAUDE.md files, evaluates quality against templates, outputs quality report, then makes targeted updates. Also use when the user mentions "CLAUDE.md maintenance" or "project memory optimization".
---

# CLAUDE.md Improver

Audit, evaluate, and improve `CLAUDE.md` files across a codebase to ensure Claude Code has optimal project context.

This skill can write to `CLAUDE.md` files. After presenting a quality report and getting user approval, it updates files with targeted improvements.

## Tools

- Read
- Glob
- Grep
- Bash
- Edit

## Workflow

### Phase 1: Discovery

Find all CLAUDE-style files in the repository:

```bash
find . -name "CLAUDE.md" -o -name ".claude.md" -o -name ".claude.local.md" 2>/dev/null | head -50
```

File types and locations:

| Type | Location | Purpose |
|------|----------|---------|
| Project root | `./CLAUDE.md` | Primary project context (checked into git, shared with team) |
| Local overrides | `./.claude.local.md` | Personal/local settings (gitignored, not shared) |
| Global defaults | `~/.claude/CLAUDE.md` | User-wide defaults across all projects |
| Package-specific | `./packages/*/CLAUDE.md` | Module-level context in monorepos |
| Subdirectory | Any nested location | Feature/domain-specific context |

Note: Claude auto-discovers `CLAUDE.md` files in parent directories, making monorepo setups work automatically.

### Phase 2: Quality Assessment

For each discovered file, evaluate against quality criteria. See `references/quality-criteria.md` for detailed rubrics.

Quick assessment checklist:

| Criterion | Weight | Check |
|----------|--------|-------|
| Commands/workflows documented | High | Are build/test/deploy commands present? |
| Architecture clarity | High | Can Claude understand the codebase structure? |
| Non-obvious patterns | Medium | Are gotchas and quirks documented? |
| Conciseness | Medium | No verbose explanations or obvious info? |
| Currency | High | Does it reflect current codebase state? |
| Actionability | High | Are instructions executable, not vague? |

Quality scores:

- `A (90-100)`: Comprehensive, current, actionable
- `B (70-89)`: Good coverage, minor gaps
- `C (50-69)`: Basic info, missing key sections
- `D (30-49)`: Sparse or outdated
- `F (0-29)`: Missing or severely outdated

### Phase 3: Quality Report Output

Always output the quality report before making any updates.

Format:

```markdown
## CLAUDE.md Quality Report

### Summary
- Files found: X
- Average score: X/100
- Files needing update: X

### File-by-File Assessment

#### 1. ./CLAUDE.md (Project Root)
**Score: XX/100 (Grade: X)**

| Criterion | Score | Notes |
|-----------|-------|-------|
| Commands/workflows | X/20 | ... |
| Architecture clarity | X/20 | ... |
| Non-obvious patterns | X/15 | ... |
| Conciseness | X/15 | ... |
| Currency | X/15 | ... |
| Actionability | X/15 | ... |

**Issues:**
- [List specific problems]

**Recommended additions:**
- [List what should be added]
```

### Phase 4: Targeted Updates

After outputting the quality report, ask user for confirmation before updating.

Update guidelines:

- Propose targeted additions only:
  - Commands/workflows discovered during analysis
  - Gotchas or non-obvious patterns found in code
  - Package relationships that were unclear
  - Testing approaches that work
  - Configuration quirks
- Keep it minimal:
  - Avoid restating obvious code facts
  - Avoid generic best practices already covered
  - Avoid one-off fixes unlikely to recur
  - Avoid verbose explanations when a one-liner is enough

Show diffs for each proposed change:

- Which `CLAUDE.md` file to update
- The specific addition as diff or quoted block
- Brief reason why it improves future sessions

Diff format:

### Update: ./CLAUDE.md

**Why:** Build command was missing, causing confusion about how to run the project.

```diff
+ ## Quick Start
+
+ ```bash
+ npm install
+ npm run dev  # Start development server on port 3000
+ ```
```

### Phase 5: Apply Updates

After user approval, apply changes using the Edit tool and preserve existing structure.

## Templates

See `references/templates.md` for CLAUDE.md templates by project type.

## Common Issues to Flag

1. Stale commands: build commands that no longer work.
2. Missing dependencies: required tools not mentioned.
3. Outdated architecture: file structure that changed.
4. Missing environment setup: required env vars or config.
5. Broken test commands: test scripts that changed.
6. Undocumented gotchas: non-obvious patterns not captured.

## User Tips to Share

- `#` key shortcut: during a Claude session, press `#` to have Claude auto-incorporate learnings into CLAUDE.md.
- Keep it concise: CLAUDE.md should be human-readable; dense is better than verbose.
- Actionable commands: all documented commands should be copy-paste ready.
- Use `.claude.local.md`: for personal preferences not shared with team (add to `.gitignore`).
- Global defaults: put user-wide preferences in `~/.claude/CLAUDE.md`.

## What Makes a Great CLAUDE.md

Key principles:

- Concise and human-readable.
- Actionable commands that can be copy-pasted.
- Project-specific patterns, not generic advice.
- Non-obvious gotchas and warnings.

Recommended sections (use only what is relevant):

- Commands (build, test, dev, lint)
- Architecture (directory structure)
- Key Files (entry points, config)
- Code Style (project conventions)
- Environment (required vars, setup)
- Testing (commands, patterns)
- Gotchas (quirks, common mistakes)
- Workflow (when to do what)
