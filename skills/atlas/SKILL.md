---
name: atlas
description: Maintain and evolve the project atlas and markdown context system for based-claude. Use when users ask to annotate a codebase, refresh CLAUDE.md, reverse-scaffold context from existing code, or keep docs and code in sync during implementation.
---

# Atlas

## Overview

Keep `CLAUDE.md` and `.claude/context/**` aligned with actual implementation so product requirements, domain docs, and code surfaces stay synchronized.

## When to use

- User asks to annotate the codebase.
- User asks to refresh or rebuild the atlas.
- User asks to reverse-scaffold docs from an existing repo.
- User asks to keep context docs in sync after code changes.

## Workflow

1. Confirm the context system exists
   - Ensure `CLAUDE.md` exists.
   - Ensure `.claude/context/PRD.md`, `.claude/context/functions/`, and `.claude/context/index.tsv` exist.
   - If missing, run `based-claude init` or `based-claude context init`.

2. Reverse-scaffold or refresh context
   - For existing repositories, run `based-claude context scaffold`.
   - For ongoing updates, run `based-claude context sync`.
   - Preserve non-managed sections in function docs.

3. Keep atlas-level guidance current
   - Update `CLAUDE.md` domains/cross-references/invariants when architecture changes.
   - Ensure ongoing usage instructions mention context sync flow.

4. Validate drift status
   - Run `based-claude context status`.
   - Run `based-claude doctor` to check both header-based and markdown-based health.

5. Report results
   - Summarize created/updated domain docs.
   - Highlight drift, missing docs, or missing code paths.
   - State next action clearly (for example, run `based-claude context sync`).

## Guardrails

- Keep product requirements in doc sections outside managed markers.
- Do not remove managed marker blocks from function docs.
- Prefer incremental updates over full rewrites unless explicitly requested.
