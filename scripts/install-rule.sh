#!/usr/bin/env bash
set -euo pipefail

# Shared rule installer. Called by each rule's install.sh wrapper.
#
# Usage (from wrapper):
#   exec "$(dirname "$0")/../scripts/install-rule.sh" "$(dirname "$0")" "$@"
#
# Arguments:
#   $1          Path to the rule directory (contains rule.md, formats/)
#   Remaining   User flags: --global, --format <name>, --help

RULE_DIR="$(cd "$1" && pwd)"
shift

RULE_NAME="$(basename "$RULE_DIR")"
RULE_FILE="$RULE_DIR/rule.md"
FORMATS_DIR="$RULE_DIR/formats"

# Extract the rule title from the first ## heading in rule.md
RULE_TITLE="$(head -5 "$RULE_FILE" | grep -oP '(?<=^## ).*' | head -1)"

SCOPE="project"
FORMAT="agents"

while [[ $# -gt 0 ]]; do
    case "$1" in
        --global|-g) SCOPE="global"; shift ;;
        --format|-f)
            [[ $# -lt 2 ]] && echo "Error: --format requires a value (agents|windsurf|cursor|all)" && exit 1
            FORMAT="$2"; shift 2 ;;
        --help|-h)
            echo "Usage: $RULE_NAME/install.sh [--global] [--format agents|windsurf|cursor|all]"
            echo ""
            echo "Options:"
            echo "  --global, -g     Install globally (all projects)"
            echo "  --format, -f     Install for a specific tool (default: agents)"
            exit 0
            ;;
        *) echo "Unknown option: $1"; exit 1 ;;
    esac
done

case "$FORMAT" in
    all|agents|windsurf|cursor) ;;
    *) echo "Unknown format: $FORMAT. Valid formats: agents, windsurf, cursor, all"; exit 1 ;;
esac

install_agents() {
    local target="$1"
    if [[ -f "$target" ]]; then
        if grep -q "$RULE_TITLE" "$target" 2>/dev/null; then
            echo "  AGENTS.md: already contains $RULE_NAME rule, skipping"
            return
        fi
        echo "" >> "$target"
        cat "$RULE_FILE" >> "$target"
        echo "  AGENTS.md: appended rule to $target"
    else
        mkdir -p "$(dirname "$target")"
        cp "$RULE_FILE" "$target"
        echo "  AGENTS.md: created $target"
    fi
}

install_windsurf() {
    local dir="$1"
    mkdir -p "$dir"
    cp "$FORMATS_DIR/windsurf.md" "$dir/$RULE_NAME.md"
    echo "  Windsurf: installed to $dir/$RULE_NAME.md"
}

install_cursor() {
    local dir="$1"
    mkdir -p "$dir"
    cp "$FORMATS_DIR/cursor.md" "$dir/$RULE_NAME.md"
    echo "  Cursor: installed to $dir/$RULE_NAME.md"
}

echo "Installing $RULE_NAME rule ($SCOPE, format: $FORMAT)"
echo ""

if [[ "$SCOPE" == "global" ]]; then
    if [[ "$FORMAT" == "all" || "$FORMAT" == "agents" ]]; then
        install_agents "$HOME/.config/cognition/AGENTS.md"
    fi
    if [[ "$FORMAT" == "all" || "$FORMAT" == "windsurf" ]]; then
        install_windsurf "$HOME/.windsurf/rules"
    fi
    if [[ "$FORMAT" == "all" || "$FORMAT" == "cursor" ]]; then
        install_cursor "$HOME/.cursor/rules"
    fi
else
    if [[ "$FORMAT" == "all" || "$FORMAT" == "agents" ]]; then
        install_agents "AGENTS.md"
    fi
    if [[ "$FORMAT" == "all" || "$FORMAT" == "windsurf" ]]; then
        install_windsurf ".windsurf/rules"
    fi
    if [[ "$FORMAT" == "all" || "$FORMAT" == "cursor" ]]; then
        install_cursor ".cursor/rules"
    fi
fi

echo ""
echo "Done. The $RULE_NAME rule is now active."
