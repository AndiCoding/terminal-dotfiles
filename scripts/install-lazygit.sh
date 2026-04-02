#!/usr/bin/env bash
set -euo pipefail

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPTS_DIR/utils.sh"

if command -v lazygit &>/dev/null; then
  echo "lazygit already installed"
  exit 0
fi

echo "Installing lazygit..."

if ensure_brew; then
  brew install -q lazygit
else
  apt_update
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep '"tag_name"' | sed 's/.*"v\([^"]*\)".*/\1/')
  curl -Lo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar -xf /tmp/lazygit.tar.gz -C /tmp lazygit
  sudo install /tmp/lazygit -D -t /usr/local/bin/
  rm /tmp/lazygit.tar.gz /tmp/lazygit
fi

echo ""
echo "Done!"
