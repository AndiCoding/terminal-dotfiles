#!/usr/bin/env bash
set -euo pipefail

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPTS_DIR/utils.sh"

TMUX_DIR="$SCRIPTS_DIR/../tmux"

if command -v tmux &>/dev/null; then
  echo "tmux already installed"
else
  echo "Installing tmux..."
  if ensure_brew; then
    brew install -q tmux
  else
    apt_update
    sudo apt-get install -y tmux
  fi
fi

if [[ -d "$HOME/.tmux/plugins/tpm" ]]; then
  echo "TPM already installed"
else
  echo "Installing TPM..."
  git clone --depth=1 https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

echo ""

if [[ -f "$HOME/.tmux.conf" ]]; then
  echo "Warning: ~/.tmux.conf already exists and will be overwritten."
  read -rp "Back it up manually first if needed. Continue? [y/N]: " confirm
  [[ "${confirm,,}" != "y" ]] && echo "Skipped." && exit 0
fi

cp "$TMUX_DIR/.tmux.conf" "$HOME/.tmux.conf"
echo "Copied .tmux.conf"

echo ""

echo "Installing tmux plugins..."
"$HOME/.tmux/plugins/tpm/bin/install_plugins"

echo ""
echo "Done! Start tmux and press Prefix + r to reload config."
