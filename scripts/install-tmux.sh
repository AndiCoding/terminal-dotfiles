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
  echo "Using existing ~/.tmux.conf"
else
  cp "$TMUX_DIR/.tmux.conf" "$HOME/.tmux.conf"
  echo "Copied .tmux.conf"
fi

echo ""

echo "Installing tmux plugins..."
tmux start-server \; set-environment -g TMUX_PLUGIN_MANAGER_PATH "$HOME/.tmux/plugins/"
"$HOME/.tmux/plugins/tpm/bin/install_plugins"

echo ""
echo "tmux installed with TPM and plugins. Start tmux and press Prefix + r to reload config."
