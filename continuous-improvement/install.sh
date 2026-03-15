#!/usr/bin/env bash
set -euo pipefail

# Install continuous-improvement rule for AI agent tools.
# Supports: AGENTS.md, Windsurf, Cursor, Claude Code
#
# Usage:
#   ./install.sh                  # Install into current project
#   ./install.sh --global         # Install globally (all projects)
#   ./install.sh --format agents  # Install only AGENTS.md format
#
# Formats: agents, windsurf, cursor, claude, all (default)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RULE_FILE="$SCRIPT_DIR/rule.md"
FORMATS_DIR="$SCRIPT_DIR/formats"

SCOPE="project"
FORMAT="all"

while [[ $# -gt 0 ]]; do
    case "$1" in
        --global|-g) SCOPE="global"; shift ;;
        --format|-f) FORMAT="$2"; shift 2 ;;
        --help|-h)
            echo "Usage: ./install.sh [--global] [--format agents|windsurf|cursor|claude|all]"
            echo ""
            echo "Options:"
            echo "  --global, -g     Install globally (all projects)"
            echo "  --format, -f     Install for a specific tool (default: all)"
            exit 0
            ;;
        *) echo "Unknown option: $1"; exit 1 ;;
    esac
done

install_agents() {
    local target="$1"
    if [[ -f "$target" ]]; then
        if grep -q "Continuous Improvement" "$target" 2>/dev/null; then
            echo "  AGENTS.md: already contains continuous-improvement rule, skipping"
            return
        fi
        echo "" >> "$target"
        cat "$RULE_FILE" >> "$target"
        echo "  AGENTS.md: appended rule to $target"
    else
        cp "$RULE_FILE" "$target"
        echo "  AGENTS.md: created $target"
    fi
}

install_windsurf() {
    local dir="$1"
    mkdir -p "$dir"
    cp "$FORMATS_DIR/windsurf.md" "$dir/continuous-improvement.md"
    echo "  Windsurf: installed to $dir/continuous-improvement.md"
}

install_cursor() {
    local dir="$1"
    mkdir -p "$dir"
    cp "$FORMATS_DIR/cursor.md" "$dir/continuous-improvement.md"
    echo "  Cursor: installed to $dir/continuous-improvement.md"
}

install_claude() {
    local target="$1"
    if [[ -f "$target" ]]; then
        if grep -q "Continuous Improvement" "$target" 2>/dev/null; then
            echo "  Claude: already contains continuous-improvement rule, skipping"
            return
        fi
        echo "" >> "$target"
        cat "$RULE_FILE" >> "$target"
        echo "  Claude: appended rule to $target"
    else
        mkdir -p "$(dirname "$target")"
        cp "$RULE_FILE" "$target"
        echo "  Claude: created $target"
    fi
}

echo "Installing continuous-improvement rule ($SCOPE, format: $FORMAT)"
echo ""

if [[ "$SCOPE" == "global" ]]; then
    # Global installs
    [[ "$FORMAT" == "all" || "$FORMAT" == "agents" ]] && install_agents "$HOME/.config/cognition/AGENTS.md"
    [[ "$FORMAT" == "all" || "$FORMAT" == "windsurf" ]] && install_windsurf "$HOME/.windsurf/rules"
    [[ "$FORMAT" == "all" || "$FORMAT" == "cursor" ]] && install_cursor "$HOME/.cursor/rules"
    [[ "$FORMAT" == "all" || "$FORMAT" == "claude" ]] && install_claude "$HOME/.claude/CLAUDE.md"
else
    # Project installs (current directory)
    [[ "$FORMAT" == "all" || "$FORMAT" == "agents" ]] && install_agents "AGENTS.md"
    [[ "$FORMAT" == "all" || "$FORMAT" == "windsurf" ]] && install_windsurf ".windsurf/rules"
    [[ "$FORMAT" == "all" || "$FORMAT" == "cursor" ]] && install_cursor ".cursor/rules"
    [[ "$FORMAT" == "all" || "$FORMAT" == "claude" ]] && install_claude "CLAUDE.md"
fi

echo ""
echo "Done. The continuous-improvement rule is now active."
