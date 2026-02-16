#!/usr/bin/env bash
#
# Based Claude - Sync Command (Deprecated)
#

sync_help() {
    cat <<EOF
based-claude sync - Deprecated

This command previously installed skills via .claude-skills.json.
The workflow is now marketplace-only.

Use Claude Code plugin commands instead:
  /plugin marketplace add <your-marketplace>
  /plugin install atlas@<your-marketplace>
  /plugin install docs-sync@<your-marketplace>
  /plugin install skill-creator@<your-marketplace>

EOF
}

cmd_sync() {
    local project_root
    project_root=$(get_project_root)

    if [[ "${1:-}" == "-h" ]] || [[ "${1:-}" == "--help" ]]; then
        sync_help
        return 0
    fi

    warn "'based-claude sync' is deprecated and no longer installs skills from .claude-skills.json"
    echo ""
    echo "Project: $project_root"
    echo ""
    echo "Use marketplace commands in Claude Code:"
    echo "  /plugin marketplace add <your-marketplace>"
    echo "  /plugin install atlas@<your-marketplace>"
    echo "  /plugin install docs-sync@<your-marketplace>"
    echo "  /plugin install skill-creator@<your-marketplace>"
    echo ""
    echo "If you previously used .claude-skills.json, migrate those entries into your private marketplace repo."
    return 1
}
