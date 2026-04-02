#!/usr/bin/env bash
set -euo pipefail

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPTS_DIR/utils.sh"

NVIM_DIR="$SCRIPTS_DIR/../nvim"

if command -v nvim &>/dev/null; then
  echo "Neovim already installed"
else
  echo "Installing Neovim..."
  if ensure_brew; then
    brew install -q neovim
  else
    apt_update
    sudo apt-get install -y software-properties-common
    sudo add-apt-repository -y ppa:neovim-ppa/unstable
    sudo apt-get update -qq
    sudo apt-get install -y neovim
  fi
fi

echo ""

if [[ -d "$HOME/.config/nvim" ]]; then
  echo "Warning: ~/.config/nvim already exists and will be overwritten."
  read -rp "Back it up manually first if needed. Continue? [y/N]: " confirm
  [[ "${confirm,,}" != "y" ]] && echo "Skipped." && exit 0
fi

cp -r "$NVIM_DIR" "$HOME/.config/nvim"
echo "Copied nvim config"

echo ""
echo "Done! Run nvim to complete plugin installation."
