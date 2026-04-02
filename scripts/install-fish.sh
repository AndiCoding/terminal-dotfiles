#!/usr/bin/env bash
set -euo pipefail

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPTS_DIR/utils.sh"

FISH_DIR="$SCRIPTS_DIR/../fish"

if command -v fish &>/dev/null; then
  echo "fish already installed"
else
  echo "Installing fish..."
  if ensure_brew; then
    brew install -q fish
  else
    apt_update
    sudo apt-get install -y fish
  fi
fi

echo ""

if ! fish -c "fisher --version" &>/dev/null; then
  echo "Installing Fisher..."
  fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
else
  echo "Fisher already installed"
fi

if ! fish -c "fisher list | grep -q IlanCosman/tide" &>/dev/null; then
  echo "Installing Tide..."
  fish -c "fisher install IlanCosman/tide@v6"
else
  echo "Tide already installed"
fi

if ! fish -c "fisher list | grep -q PatrickF1/fzf.fish" &>/dev/null; then
  echo "Installing fzf.fish..."
  fish -c "fisher install PatrickF1/fzf.fish"
else
  echo "fzf.fish already installed"
fi

echo ""

mkdir -p "$HOME/.config/fish"

if [[ -f "$HOME/.config/fish/config.fish" ]]; then
  echo "Using existing ~/.config/fish/config.fish"
else
  if ensure_brew; then
    cp "$FISH_DIR/config.fish.mac" "$HOME/.config/fish/config.fish"
  else
    cp "$FISH_DIR/config.fish.linux" "$HOME/.config/fish/config.fish"
  fi
  echo "Copied config.fish"
fi

echo ""

FISH_PATH="$(which fish)"
if [[ "$SHELL" == "$FISH_PATH" ]]; then
  echo "fish is already the default shell"
else
  echo "Setting fish as default shell..."
  if ! grep -qF "$FISH_PATH" /etc/shells; then
    echo "$FISH_PATH" | sudo tee -a /etc/shells
  fi
  chsh -s "$FISH_PATH"
fi

echo ""
echo "Done! Open a new terminal. Tide will walk you through prompt setup on first launch."
