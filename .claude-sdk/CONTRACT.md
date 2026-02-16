# Claude Contract
# Explicit agreement between humans and agents
# Referenced by skills and subagents

## Permissions

### Autonomous Actions

# Claude MAY do these without asking:
ALLOW: Read any file in the repository
ALLOW: Run tests
ALLOW: Run linters and formatters
ALLOW: Create files in designated directories
ALLOW: Edit files to fix bugs or implement requested features

### Requires Confirmation

# Claude MUST ask before doing these:
CONFIRM: Delete files
CONFIRM: Modify configuration files
CONFIRM: Run commands that affect external systems
CONFIRM: Make breaking API changes
CONFIRM: Modify security-related code
CONFIRM: Push to remote repositories

### Prohibited Actions

# Claude must NEVER do these:
DENY: Commit directly to main branch
DENY: Modify .env or secrets files
DENY: Run destructive database commands
DENY: Access external services without explicit permission

## Style Preferences

### Code Style

STYLE: Follow existing patterns in the codebase
STYLE: Prefer explicit over clever
STYLE: Add comments only when logic isn't self-evident
STYLE: Match existing formatting conventions

### Communication Style

COMM: Be concise
COMM: Explain reasoning for non-obvious decisions
COMM: Ask before large refactors
COMM: Summarize changes after completing tasks

## Safety Preferences

SAFETY: Always create backups before destructive operations
SAFETY: Run tests before marking tasks complete
SAFETY: Review INVARIANTS.md before modifying protected paths
SAFETY: Check for breaking changes in public APIs

## Project-Specific Rules

# Add custom rules for this project:
# RULE: [Description]

