#!/usr/bin/env bash
#
# Based Claude - Context Command
# Markdown-first product context system with bidirectional code/doc sync.
#

CONTEXT_DIR_REL=".claude/context"
CONTEXT_PRD_REL="$CONTEXT_DIR_REL/PRD.md"
CONTEXT_README_REL="$CONTEXT_DIR_REL/README.md"
CONTEXT_FUNCTIONS_REL="$CONTEXT_DIR_REL/functions"
CONTEXT_INDEX_REL="$CONTEXT_DIR_REL/index.tsv"

context_help() {
    cat <<EOF
based-claude context - Manage markdown product context synced with code

USAGE:
    based-claude context <subcommand> [options]

SUBCOMMANDS:
    init            Create markdown context system (PRD + function docs index)
    scaffold        Reverse-scaffold function docs from existing codebase
    sync            Sync code references/fingerprints into function docs
    status          Show drift and sync status

OPTIONS:
    --dry-run       Preview changes without writing files
    --force         Overwrite existing generated docs when applicable
    -h, --help      Show this help

EXAMPLES:
    based-claude context init
    based-claude context scaffold
    based-claude context sync
    based-claude context status

EOF
}

cmd_context() {
    local subcmd="${1:-}"
    shift || true

    case "$subcmd" in
        init)
            cmd_context_init "$@"
            ;;
        scaffold)
            cmd_context_scaffold "$@"
            ;;
        sync)
            cmd_context_sync "$@"
            ;;
        status)
            cmd_context_status "$@"
            ;;
        -h|--help|"")
            context_help
            ;;
        *)
            error "Unknown context subcommand: $subcmd"
            context_help
            return 1
            ;;
    esac
}

cmd_context_init() {
    local dry_run=false
    local force=false

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --dry-run)
                dry_run=true
                shift
                ;;
            --force)
                force=true
                shift
                ;;
            -h|--help)
                context_help
                return 0
                ;;
            *)
                error "Unknown option: $1"
                return 1
                ;;
        esac
    done

    local project_root
    project_root=$(get_project_root)

    _context_bootstrap "$project_root" "$dry_run" "$force"
}

cmd_context_scaffold() {
    local dry_run=false
    local force=false

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --dry-run)
                dry_run=true
                shift
                ;;
            --force)
                force=true
                shift
                ;;
            -h|--help)
                context_help
                return 0
                ;;
            *)
                error "Unknown option: $1"
                return 1
                ;;
        esac
    done

    local project_root
    project_root=$(get_project_root)

    _context_bootstrap "$project_root" "$dry_run" false
    _context_scaffold_from_code "$project_root" "$dry_run" "$force"
}

cmd_context_sync() {
    local dry_run=false

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --dry-run)
                dry_run=true
                shift
                ;;
            -h|--help)
                context_help
                return 0
                ;;
            *)
                error "Unknown option: $1"
                return 1
                ;;
        esac
    done

    local project_root
    project_root=$(get_project_root)

    _context_bootstrap "$project_root" "$dry_run" false
    # Sync always scaffolds missing domains, preserving existing docs.
    _context_scaffold_from_code "$project_root" "$dry_run" false
}

cmd_context_status() {
    local project_root
    project_root=$(get_project_root)

    _context_status "$project_root"
}

# Used by init.sh for bootstrapping in one pass.
context_bootstrap_and_scaffold() {
    local project_root="$1"
    local dry_run="$2"
    local force="$3"

    _context_bootstrap "$project_root" "$dry_run" "$force"
    _context_scaffold_from_code "$project_root" "$dry_run" "$force"
}

_context_bootstrap() {
    local project_root="$1"
    local dry_run="$2"
    local force="$3"

    local context_dir="$project_root/$CONTEXT_DIR_REL"
    local functions_dir="$project_root/$CONTEXT_FUNCTIONS_REL"
    local prd_file="$project_root/$CONTEXT_PRD_REL"
    local readme_file="$project_root/$CONTEXT_README_REL"
    local index_file="$project_root/$CONTEXT_INDEX_REL"

    if $dry_run; then
        dry_run_msg "Ensure $context_dir/"
        dry_run_msg "Ensure $functions_dir/"
        if [[ ! -f "$prd_file" ]] || $force; then
            dry_run_msg "Create $prd_file"
        fi
        if [[ ! -f "$readme_file" ]] || $force; then
            dry_run_msg "Create $readme_file"
        fi
        if [[ ! -f "$index_file" ]] || $force; then
            dry_run_msg "Create $index_file"
        fi
        return 0
    fi

    ensure_dir "$context_dir"
    ensure_dir "$functions_dir"

    if [[ ! -f "$prd_file" ]] || $force; then
        _context_write_prd_template "$prd_file"
        success "Created ${CONTEXT_PRD_REL}"
    fi

    if [[ ! -f "$readme_file" ]] || $force; then
        _context_write_readme_template "$readme_file"
        success "Created ${CONTEXT_README_REL}"
    fi

    if [[ ! -f "$index_file" ]] || $force; then
        printf '# doc_path\tdomain\tcode_paths\tfingerprint\tlast_synced\n' > "$index_file"
        success "Created ${CONTEXT_INDEX_REL}"
    fi
}

_context_write_prd_template() {
    local file="$1"

    cat > "$file" << 'EOF'
# Product Requirements Document (PRD)

## Product Vision
Describe the user outcome this product should deliver.

## User Personas
- Persona 1:
- Persona 2:

## Core User Journeys
1. Journey 1
2. Journey 2

## Functional Requirements
- [ ] FR-001:
- [ ] FR-002:

## Non-Functional Requirements
- [ ] Performance:
- [ ] Reliability:
- [ ] Security:

## Release Milestones
- Milestone 1:
- Milestone 2:

## Open Questions
- Question 1

## Notes for Agents
When implementing, decompose requirements into `.claude/context/functions/*.md`
and keep those docs synced with code using `based-claude context sync`.
EOF
}

_context_write_readme_template() {
    local file="$1"

    cat > "$file" << 'EOF'
# Based Claude Context System

This folder keeps product intent and implementation context in markdown files that
stay synchronized with the codebase.

## Files
- `PRD.md`: Top-level product requirements and goals.
- `functions/*.md`: One markdown file per core domain/function in code.
- `index.tsv`: Machine-readable mapping between function docs and code paths.

## Workflow
1. Greenfield repo:
   - Fill `PRD.md`.
   - Ask an agent to implement requirements and create/update `functions/*.md`.
2. Existing repo:
   - Run `based-claude context scaffold` to reverse-scaffold docs from code.
   - Enrich each function doc with product-level requirements.
3. Ongoing changes:
   - After code changes, run `based-claude context sync`.
   - The sync process updates managed code-surface and fingerprint blocks.

## Managed Blocks
Each function doc contains managed blocks with these markers:
- `<!-- BEGIN:BASED-CLAUDE-CODE-SURFACE -->`
- `<!-- END:BASED-CLAUDE-CODE-SURFACE -->`
- `<!-- BEGIN:BASED-CLAUDE-SYNC -->`
- `<!-- END:BASED-CLAUDE-SYNC -->`

Do not remove these markers. Keep all product requirements outside those blocks.
EOF
}

_context_scaffold_from_code() {
    local project_root="$1"
    local dry_run="$2"
    local force="$3"

    local mapping_file
    mapping_file=$(mktemp)
    local domains_file
    domains_file=$(mktemp)
    local new_index
    new_index=$(mktemp)

    while IFS= read -r rel_path; do
        [[ -n "$rel_path" ]] || continue
        local domain
        domain=$(path_to_domain "$rel_path")
        printf '%s|%s\n' "$domain" "$rel_path" >> "$mapping_file"
    done < <(list_source_files "$project_root")

    if [[ ! -s "$mapping_file" ]]; then
        warn "No source files found to scaffold"
        rm -f "$mapping_file" "$domains_file" "$new_index"
        return 0
    fi

    cut -d'|' -f1 "$mapping_file" | sort -u > "$domains_file"

    local index_file="$project_root/$CONTEXT_INDEX_REL"
    printf '# doc_path\tdomain\tcode_paths\tfingerprint\tlast_synced\n' > "$new_index"

    local created=0
    local updated=0
    local now
    now=$(timestamp_utc)

    while IFS= read -r domain; do
        [[ -n "$domain" ]] || continue

        local doc_rel="$CONTEXT_FUNCTIONS_REL/$domain.md"
        local doc_abs="$project_root/$doc_rel"
        local code_paths_csv
        code_paths_csv=$(awk -F'|' -v d="$domain" '$1==d {print $2}' "$mapping_file" | sort -u | paste -sd, -)
        local fingerprint
        fingerprint=$(compute_paths_fingerprint "$project_root" "$code_paths_csv")

        if [[ ! -f "$doc_abs" ]] || $force; then
            if $dry_run; then
                dry_run_msg "Create $doc_rel"
            else
                _context_write_function_doc "$doc_abs" "$domain" "$code_paths_csv" "$fingerprint" "$now"
            fi
            created=$((created + 1))
        else
            if $dry_run; then
                dry_run_msg "Update managed blocks in $doc_rel"
            else
                _context_update_function_doc "$doc_abs" "$domain" "$code_paths_csv" "$fingerprint" "$now"
            fi
            updated=$((updated + 1))
        fi

        printf '%s\t%s\t%s\t%s\t%s\n' "$doc_rel" "$domain" "$code_paths_csv" "$fingerprint" "$now" >> "$new_index"
    done < "$domains_file"

    if $dry_run; then
        dry_run_msg "Rewrite $CONTEXT_INDEX_REL"
    else
        cat "$new_index" > "$index_file"
        success "Updated ${CONTEXT_INDEX_REL}"
    fi

    echo ""
    info "Context scaffold complete"
    echo "  Created docs: $created"
    echo "  Updated docs: $updated"

    rm -f "$mapping_file" "$domains_file" "$new_index"
}

_context_write_function_doc() {
    local file="$1"
    local domain="$2"
    local code_paths_csv="$3"
    local fingerprint="$4"
    local now="$5"

    local code_surface
    code_surface=$(_context_render_code_surface "$code_paths_csv")
    local sync_block
    sync_block=$(_context_render_sync_block "$domain" "$code_paths_csv" "$fingerprint" "$now")

    cat > "$file" << EOF
# Function: $domain

## Product Intent
Describe the user-facing outcome this domain must deliver.

## Product Requirements
- [ ] Requirement 1
- [ ] Requirement 2

## Acceptance Criteria
- [ ] Criteria 1
- [ ] Criteria 2

## Failure Modes
- What can fail?
- What is the expected fallback?

## Agent Implementation Plan
Capture the implementation strategy and rollout details.

<!-- BEGIN:BASED-CLAUDE-CODE-SURFACE -->
$code_surface
<!-- END:BASED-CLAUDE-CODE-SURFACE -->

<!-- BEGIN:BASED-CLAUDE-SYNC -->
$sync_block
<!-- END:BASED-CLAUDE-SYNC -->
EOF
}

_context_update_function_doc() {
    local file="$1"
    local domain="$2"
    local code_paths_csv="$3"
    local fingerprint="$4"
    local now="$5"

    local tmp_code
    tmp_code=$(mktemp)
    local tmp_sync
    tmp_sync=$(mktemp)

    _context_render_code_surface "$code_paths_csv" > "$tmp_code"
    _context_render_sync_block "$domain" "$code_paths_csv" "$fingerprint" "$now" > "$tmp_sync"

    _context_replace_managed_block "$file" "<!-- BEGIN:BASED-CLAUDE-CODE-SURFACE -->" "<!-- END:BASED-CLAUDE-CODE-SURFACE -->" "$tmp_code"
    _context_replace_managed_block "$file" "<!-- BEGIN:BASED-CLAUDE-SYNC -->" "<!-- END:BASED-CLAUDE-SYNC -->" "$tmp_sync"

    rm -f "$tmp_code" "$tmp_sync"
}

_context_render_code_surface() {
    local code_paths_csv="$1"
    local IFS=','
    local p

    echo "## Code Surface (managed by based-claude)"
    for p in $code_paths_csv; do
        p=$(echo "$p" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
        [[ -n "$p" ]] || continue
        echo "- \`$p\`"
    done
}

_context_render_sync_block() {
    local domain="$1"
    local code_paths_csv="$2"
    local fingerprint="$3"
    local now="$4"

    cat << EOF
## Sync Metadata (managed by based-claude)
- Domain: \`$domain\`
- Fingerprint: \`$fingerprint\`
- Last Synced (UTC): \`$now\`
- Code Paths: \`$code_paths_csv\`
EOF
}

_context_replace_managed_block() {
    local file="$1"
    local begin_marker="$2"
    local end_marker="$3"
    local replacement_file="$4"

    local tmp_out
    tmp_out=$(mktemp)

    awk -v b="$begin_marker" -v e="$end_marker" -v repl="$replacement_file" '
        BEGIN {
            in_block = 0
            n = 0
            while ((getline line < repl) > 0) {
                replacement[++n] = line
            }
            close(repl)
            saw_begin = 0
            saw_end = 0
        }
        {
            if ($0 == b) {
                saw_begin = 1
                print $0
                for (i = 1; i <= n; i++) {
                    print replacement[i]
                }
                in_block = 1
                next
            }

            if ($0 == e) {
                saw_end = 1
                in_block = 0
                print $0
                next
            }

            if (!in_block) {
                print $0
            }
        }
        END {
            if (!saw_begin || !saw_end) {
                # signal missing markers with a non-zero exit code
                exit 99
            }
        }
    ' "$file" > "$tmp_out"

    local awk_status=$?
    if [[ $awk_status -eq 99 ]]; then
        rm -f "$tmp_out"
        _context_append_missing_block "$file" "$begin_marker" "$end_marker" "$replacement_file"
        return 0
    fi

    if [[ $awk_status -ne 0 ]]; then
        rm -f "$tmp_out"
        return $awk_status
    fi

    mv "$tmp_out" "$file"
}

_context_append_missing_block() {
    local file="$1"
    local begin_marker="$2"
    local end_marker="$3"
    local replacement_file="$4"

    {
        echo ""
        echo "$begin_marker"
        cat "$replacement_file"
        echo "$end_marker"
    } >> "$file"
}

_context_status() {
    local project_root="$1"
    local index_file="$project_root/$CONTEXT_INDEX_REL"

    if [[ ! -f "$index_file" ]]; then
        warn "Context index not found: $CONTEXT_INDEX_REL"
        echo "Run: based-claude context init"
        return 1
    fi

    header "Context Sync Status"
    echo ""
    echo "Project: $project_root"
    echo ""

    local total=0
    local in_sync=0
    local drift=0
    local missing_docs=0
    local missing_code=0

    while IFS=$'\t' read -r doc_path domain code_paths fingerprint last_synced; do
        [[ -z "$doc_path" ]] && continue
        [[ "$doc_path" =~ ^# ]] && continue

        total=$((total + 1))

        if [[ ! -f "$project_root/$doc_path" ]]; then
            warn "Missing doc: $doc_path"
            missing_docs=$((missing_docs + 1))
            continue
        fi

        local recalculated
        recalculated=$(compute_paths_fingerprint "$project_root" "$code_paths")

        if [[ "$recalculated" == "$fingerprint" ]]; then
            in_sync=$((in_sync + 1))
        else
            warn "Drift: $domain"
            echo "  doc: $doc_path"
            echo "  last synced: $last_synced"
            drift=$((drift + 1))
        fi

        local IFS=','
        local p
        for p in $code_paths; do
            p=$(echo "$p" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
            [[ -n "$p" ]] || continue
            if [[ ! -f "$project_root/$p" ]]; then
                warn "Missing code path: $p (domain: $domain)"
                missing_code=$((missing_code + 1))
            fi
        done
    done < "$index_file"

    echo ""
    echo "Summary"
    echo "  Indexed domains: $total"
    echo "  In sync: $in_sync"
    echo "  Drifted: $drift"
    echo "  Missing docs: $missing_docs"
    echo "  Missing code paths: $missing_code"

    if [[ $drift -gt 0 || $missing_docs -gt 0 || $missing_code -gt 0 ]]; then
        echo ""
        echo "Recommended: based-claude context sync"
        return 1
    fi

    return 0
}
