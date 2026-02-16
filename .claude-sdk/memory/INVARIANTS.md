# Invariants & Guardrails Registry
# Safety constraints that agents must respect
# Format: explicit, simple language, grep-friendly

## Critical Invariants

# These MUST NOT be violated by any agent action:

INVARIANT: [ID] [Description]
REASON: [Why this matters]
ENFORCED_BY: [How it's enforced - tests, CI, manual review]

### Example Invariants

INVARIANT: AUTH-001 All authentication logic lives in src/auth/
REASON: Security audit scope, single point of control
ENFORCED_BY: Code review, architectural tests

INVARIANT: DB-001 Database writes must go through repository layer
REASON: Transaction management, audit logging
ENFORCED_BY: Linting rules, code review

INVARIANT: API-001 All external API calls must include timeout
REASON: Prevent cascade failures
ENFORCED_BY: Custom lint rule

## Soft Constraints

# Strong preferences that can be overridden with justification:

PREFER: [Description]
INSTEAD_OF: [Anti-pattern]
BECAUSE: [Reasoning]

## Protected Paths

# Files/directories that require extra scrutiny before modification:

PROTECTED: src/auth/          # Security-critical
PROTECTED: src/billing/       # Financial logic
PROTECTED: migrations/        # Database schema

## Guardrail Index

# Quick reference:
GUARD: AUTH-001 - Auth in src/auth/ only
GUARD: DB-001 - Writes through repository
GUARD: API-001 - Timeouts on external calls
