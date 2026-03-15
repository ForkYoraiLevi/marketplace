#!/usr/bin/env bash
set -euo pipefail

# Run the GitHub Actions CI workflow locally using act + podman.
#
# Usage:
#   ./tests/run-ci-local.sh          # full run
#   ./tests/run-ci-local.sh -n       # dry-run (no container)
#
# Prerequisites:
#   - podman (container runtime)
#   - act    (https://github.com/nektos/act)
#
# If act is not installed, this script downloads it automatically.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
ACT_IMAGE="catthehacker/ubuntu:act-latest"

# --- Locate or install act ------------------------------------------------ #

if command -v act &>/dev/null; then
    ACT="act"
elif [[ -x /tmp/act ]]; then
    ACT="/tmp/act"
else
    echo "act not found — installing to /tmp/act ..."
    ARCH=$(uname -m)
    case "$ARCH" in
        x86_64)  ARCH_SUFFIX="x86_64" ;;
        aarch64) ARCH_SUFFIX="arm64" ;;
        *)       echo "Unsupported arch: $ARCH"; exit 1 ;;
    esac
    curl -fsSL "https://github.com/nektos/act/releases/latest/download/act_Linux_${ARCH_SUFFIX}.tar.gz" \
        | tar xz -C /tmp act
    ACT="/tmp/act"
    echo "Installed $($ACT --version)"
fi

# --- Locate podman socket ------------------------------------------------- #

USER_SOCKET="/run/user/$(id -u)/podman/podman.sock"
SYSTEM_SOCKET="/run/podman/podman.sock"

if [[ -S "$USER_SOCKET" ]]; then
    SOCKET="$USER_SOCKET"
elif [[ -S "$SYSTEM_SOCKET" ]]; then
    SOCKET="$SYSTEM_SOCKET"
else
    # Try starting the user podman service
    echo "No podman socket found — starting podman system service ..."
    podman system service --time=0 &
    sleep 1
    if [[ -S "$USER_SOCKET" ]]; then
        SOCKET="$USER_SOCKET"
    else
        echo "Error: could not find or start a podman socket."
        echo "Try: systemctl --user start podman.socket"
        exit 1
    fi
fi

# --- Ensure actrc exists -------------------------------------------------- #

ACTRC="${HOME}/.config/act/actrc"
if [[ ! -f "$ACTRC" ]]; then
    mkdir -p "$(dirname "$ACTRC")"
    echo "-P ubuntu-latest=${ACT_IMAGE}" > "$ACTRC"
fi

# --- Run ------------------------------------------------------------------ #

echo "Using act=$($ACT --version), socket=$SOCKET"
echo ""

DOCKER_HOST="unix://$SOCKET" exec "$ACT" \
    --container-daemon-socket "$SOCKET" \
    -W "$REPO_ROOT/.github/workflows/ci.yml" \
    "$@"
