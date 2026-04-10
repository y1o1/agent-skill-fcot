#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_SOURCE="$SCRIPT_DIR/skills/fcot"
SKILL_TARGET="$HOME/.claude/skills/fcot"

if [ -L "$SKILL_TARGET" ]; then
    echo "Removing existing symlink: $SKILL_TARGET"
    rm "$SKILL_TARGET"
elif [ -d "$SKILL_TARGET" ]; then
    echo "Error: $SKILL_TARGET exists and is not a symlink. Remove it manually."
    exit 1
fi

mkdir -p "$HOME/.claude/skills"
ln -s "$SKILL_SOURCE" "$SKILL_TARGET"
echo "Installed: $SKILL_TARGET -> $SKILL_SOURCE"
echo ""
echo "Restart Claude Code to pick up the new skill."
