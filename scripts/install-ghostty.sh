#!/usr/bin/env bash
set -euo pipefail

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPTS_DIR/utils.sh"

GHOSTTY_CONFIG_DIR="$SCRIPTS_DIR/../ghostty"

if command -v ghostty &>/dev/null; then
  echo "Ghostty already installed"
else
  echo "Installing Ghostty..."
  if ensure_brew; then
    brew install --cask ghostty
  else
    echo "Ghostty does not support Linux via this installer. Download from https://ghostty.org/download"
    exit 1
  fi
fi

echo ""

TARGET="$HOME/.config/ghostty"

if [[ -d "$TARGET" ]]; then
  echo "Warning: ~/.config/ghostty already exists and will be overwritten."
  read -rp "Back it up manually first if needed. Continue? [y/N]: " confirm
  [[ "${confirm,,}" != "y" ]] && echo "Skipped." && exit 0
fi

mkdir -p "$TARGET"
cp "$GHOSTTY_CONFIG_DIR/config" "$TARGET/config"
echo "Copied ghostty config"

echo ""
echo "Done! Restart Ghostty to apply the config."
