# CLAUDE.md Templates

Use these as lightweight starting points. Keep only sections relevant to the repo.

## Template: Single service repository

```markdown
# Project Context

## Quick Commands
- Install: `...`
- Dev: `...`
- Test: `...`
- Lint: `...`

## Architecture
- Entry point: `...`
- Core modules: `...`
- Data layer: `...`

## Environment
- Required variables: `...`

## Testing Notes
- Unit tests: `...`
- Integration tests: `...`

## Gotchas
- ...
```

## Template: Monorepo root

```markdown
# Monorepo Context

## Workspace Commands
- Install: `...`
- Build all: `...`
- Test all: `...`

## Packages
- `packages/api`: ...
- `packages/web`: ...
- `packages/shared`: ...

## Cross-Package Rules
- ...

## Environment
- Shared env vars: `...`

## Gotchas
- ...
```

## Template: Package-level CLAUDE.md

```markdown
# Package Context: <name>

## Purpose
- ...

## Local Commands
- Build: `...`
- Test: `...`

## Dependencies
- Internal: `...`
- External: `...`

## Key Files
- `src/...`: ...

## Gotchas
- ...
```
