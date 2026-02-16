# Doc Coverage Checklist

Use this checklist while preparing a docs sync report.

## Feature Surface

- Public APIs and exported symbols are documented.
- New configuration options and defaults are documented.
- Required environment variables are documented.
- CLI commands and flags are documented.
- User-visible behavior changes are documented.

## Accuracy

- Names match implementation exactly.
- Defaults match implementation exactly.
- Behavioral notes reflect current code paths.
- Deprecations and removals are explicitly noted.

## Information Architecture

- Features appear in discoverable pages and sections.
- Navigation (`mkdocs.yml`) includes any new pages.
- Duplicate or conflicting guidance is resolved.

## Scope Guardrails

- Only edit English docs under `docs/**`.
- Do not edit translated docs under `docs/ja`, `docs/ko`, or `docs/zh`.
- Ask for user approval before applying doc edits.
