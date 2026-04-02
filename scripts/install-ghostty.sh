#!/usr/bin/env bash
set -euo pipefail

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPTS_DIR/utils.sh"

GHOSTTY_CONFIG_DIR="$SCRIPTS_DIR/../ghostty"

if command -v ghostty &>/dev/null || [[ -d "/Applications/Ghostty.app" ]]; then
  echo "Ghostty already installed"
else
  echo "Installing Ghostty..."
  if ensure_brew; then
    brew install -q --cask ghostty
  else
    echo "Ghostty does not support Linux via this installer. Download from https://ghostty.org/download"
    exit 1
  fi
fi

echo ""

TARGET="$HOME/.config/ghostty"

if [[ -d "$TARGET" ]]; then
  echo "Using existing ~/.config/ghostty"
else
  mkdir -p "$TARGET"
  cp "$GHOSTTY_CONFIG_DIR/config" "$TARGET/config"
  echo "Copied ghostty config"
fi

echo ""
echo "Ghostty installed. Restart Ghostty to apply the config."
