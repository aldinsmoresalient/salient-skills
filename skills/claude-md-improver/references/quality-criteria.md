# CLAUDE.md Quality Criteria

Use this rubric to score each CLAUDE-style file on a 100-point scale.

## Criteria and weights

| Criterion | Max | What to check |
|-----------|-----|---------------|
| Commands/workflows | 20 | Build, test, run, lint, and deploy commands are present and current |
| Architecture clarity | 20 | Clear module/service boundaries and important folder structure |
| Non-obvious patterns | 15 | Gotchas, quirks, and warnings are captured |
| Conciseness | 15 | Minimal verbosity, no obvious restatement |
| Currency | 15 | Reflects current codebase state and tooling |
| Actionability | 15 | Instructions are concrete and executable |

## Scoring guidance

- 90-100 (`A`): Comprehensive, current, actionable.
- 70-89 (`B`): Good coverage, minor gaps.
- 50-69 (`C`): Basic information, missing key sections.
- 30-49 (`D`): Sparse or partially outdated.
- 0-29 (`F`): Missing or severely outdated.

## Fast checks

- Are commands copy-paste ready?
- Are commands validated against current scripts/tooling?
- Can a new contributor understand where core logic lives?
- Are known footguns documented?
- Are stale sections removed rather than layered over?
