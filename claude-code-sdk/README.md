# Based Claude v2

Context-anchored memory layer for Claude Code. Four anchors keep Claude oriented and keep markdown product context synced with code.

## The Problem

Claude Code is great at exploration, but:
- **Greps something, jumps to conclusions** - finds one file, misses related context
- **Partial understanding** - modifies code without knowing what depends on it
- **Context loss** - forgets architectural decisions across sessions
- **Blind spots** - doesn't know what it doesn't know

## The Solution: Four Anchors

```
┌─────────────────────────────────────────────────────────────────┐
│  ANCHOR 1: CLAUDE.md                                             │
│  - Auto-loaded on session start                                  │
│  - Contains: domains, cross-references, invariants               │
│  - Points to generated skills                                    │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│  ANCHOR 2: Generated Skills (.claude/skills/)                    │
│  - Created during annotation, specific to YOUR codebase          │
│  - /modify-auth → checklist for auth changes                     │
│  - /modify-db → database change workflow                         │
│  - Loaded when needed, focused context                           │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│  ANCHOR 3: @claude Headers (in code files)                       │
│  - PURPOSE: what this file does                                  │
│  - RISK: how dangerous to modify                                 │
│  - USED_BY: what depends on this (BLAST RADIUS)                  │
│  - Lives with code, can't drift                                  │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│  ANCHOR 4: Markdown Context (.claude/context/)                   │
│  - PRD.md for product requirements                               │
│  - functions/*.md for domain-level requirements                  │
│  - index.tsv mapping docs ↔ code fingerprints                    │
└─────────────────────────────────────────────────────────────────┘
```

## Installation

```bash
npx based-claude init
```

That creates `CLAUDE.md`, `.claude/skills/`, and `.claude/context/`.

Helper skills are distributed via plugin marketplaces (recommended for private org skills),
not bundled in the npm package.

Typical helper-skill install flow in Claude Code:

```text
/plugin marketplace add <your-marketplace>
/plugin install atlas@<your-marketplace>
/plugin install docs-sync@<your-marketplace>
/plugin install skill-creator@<your-marketplace>
```

## Workflow

### 1. Initialize

```bash
npx based-claude init
```

### 2. Annotate (tell Claude)

```
You: "annotate this codebase"
```

Claude will:
1. Explore your codebase structure
2. Build an import graph (discover what depends on what)
3. Add `@claude` headers to key files (with USED_BY for blast radius)
4. Generate domain-specific skills in `.claude/skills/`
5. Complete the atlas in `CLAUDE.md`

### 3. Build Product Context (new + existing repos)

For a new build from PRD:

1. Fill `.claude/context/PRD.md`
2. Decompose into `.claude/context/functions/*.md` requirements
3. Ask Claude/Codex to implement from those docs
4. Run `based-claude context sync` after code changes

For an existing repository:

1. Run `based-claude context scaffold`
2. Review generated `functions/*.md`
3. Add product-level requirements
4. Keep in sync with `based-claude context sync`

### 4. Work with Context

Now when Claude works on your codebase:

```
Task: "Fix the login bug"
  ↓
CLAUDE.md: "auth is CRITICAL, check /modify-auth skill"
  ↓
/modify-auth skill: "files to check, invariants, test commands"
  ↓
@claude header: "USED_BY: api/auth-routes.ts, middleware/auth.ts"
  ↓
Claude makes changes, verifies consumers
```

Context stays anchored at every step.

## The Key Innovation: USED_BY

Most tools track what a file imports. We track **what imports it**.

```typescript
/**
 * @claude
 * PURPOSE: User login - validates credentials, creates session
 * RISK: critical
 * USED_BY: src/api/auth-routes.ts, src/middleware/auth.ts
 * DEPENDS: src/db/users.ts, src/crypto/hash.ts
 */
```

**USED_BY is the blast radius.** When Claude modifies this file, it knows to check those consumers.

## Generated Skills

Unlike generic skills, these are **generated from your actual codebase**:

```markdown
---
name: modify-auth
description: Use when modifying any code in src/auth/. This is CRITICAL risk code.
---

# Modifying Auth Code

## Files in This Domain

| File | Purpose | USED_BY |
|------|---------|---------|
| login.ts | User login flow | api/auth-routes.ts, middleware/auth.ts |
| session.ts | Session management | middleware/auth.ts |

## Invariants

- Passwords only via bcrypt.compare()
- Never log credentials or session tokens

## After Changes

1. Run: `npm test -- --grep auth`
2. Verify: src/api/auth-routes.ts still works
```

Skills are created during annotation based on what Claude discovers about your codebase.

## What Gets Created

```
your-project/
├── CLAUDE.md              # Anchor 1: Atlas + instructions (auto-loaded)
├── .claude/
│   ├── skills/            # Anchor 2: Generated skills
│   │   ├── modify-auth/SKILL.md
│   │   ├── modify-db/SKILL.md
│   │   └── add-endpoint/SKILL.md
│   └── context/           # Anchor 4: Product markdown system
│       ├── PRD.md
│       ├── index.tsv
│       └── functions/
│           ├── auth.md
│           └── billing.md
└── src/
    └── auth/
        └── login.ts       # Anchor 3: @claude header with USED_BY
```

## Commands

| Command | Description |
|---------|-------------|
| `based-claude init` | Initialize CLAUDE.md, skills, and markdown context system |
| `based-claude context init` | Initialize markdown context system manually |
| `based-claude context scaffold` | Reverse-scaffold function docs from existing code |
| `based-claude context sync` | Update managed markdown blocks and fingerprints |
| `based-claude context status` | Show markdown↔code sync status |
| `based-claude doctor` | Check health, detect drift |

After init, all other commands are natural language to Claude:
- "annotate this codebase" - Build the atlas/skills/header anchors
- "refresh the atlas" - Update after major changes
- "check for drift" - Verify atlas matches current code

## CLI Options

```bash
# Initialize
based-claude init
based-claude init --force  # Overwrite existing

# Health check
based-claude doctor
based-claude doctor --verbose

# Context sync
based-claude context scaffold
based-claude context sync
based-claude context status
```

## How It Helps Claude

| Without Based Claude | With Based Claude |
|---------------------|-------------------|
| Greps, finds one file, misses context | Cross-references show related files |
| Modifies code, breaks consumers | USED_BY shows blast radius |
| Generic understanding | Domain-specific skills with checklists |
| Rediscovers architecture each session | CLAUDE.md auto-loaded with overview |
| Misses implicit rules | Invariants documented and checked |
| Product docs drift from implementation | Function markdown docs stay fingerprint-synced |

## Design Principles

1. **Context anchoring** - Multiple layers keep Claude oriented
2. **Blast radius awareness** - USED_BY prevents breaking changes
3. **Generated, not generic** - Skills come from YOUR codebase
4. **Lives with code** - Headers can't drift from reality
5. **Minimal footprint** - CLAUDE.md + skills + markdown context

## Requirements

- macOS or Linux
- Node.js 14+ (for npx)
- git (for commit tracking)

## License

Apache 2.0
