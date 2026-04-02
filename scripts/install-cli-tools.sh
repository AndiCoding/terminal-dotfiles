#!/usr/bin/env bash
set -euo pipefail

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPTS_DIR/utils.sh"

if ! ensure_brew; then
  apt_update
fi

if command -v fzf &>/dev/null; then
  echo "fzf already installed"
else
  echo "Installing fzf..."
  if ensure_brew; then
    brew install -q fzf
  else
    sudo apt-get install -y fzf
  fi
fi

if command -v zoxide &>/dev/null; then
  echo "zoxide already installed"
else
  echo "Installing zoxide..."
  if ensure_brew; then
    brew install -q zoxide
  else
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
  fi
fi

if command -v eza &>/dev/null; then
  echo "eza already installed"
else
  echo "Installing eza..."
  if ensure_brew; then
    brew install -q eza
  else
    sudo apt-get install -y gpg
    sudo mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt-get update -qq
    sudo apt-get install -y eza
  fi
fi

if command -v bat &>/dev/null; then
  echo "bat already installed"
else
  echo "Installing bat..."
  if ensure_brew; then
    brew install -q bat
  else
    sudo apt-get install -y bat
    mkdir -p ~/.local/bin
    ln -sf /usr/bin/batcat ~/.local/bin/bat
  fi
fi

if command -v rg &>/dev/null; then
  echo "ripgrep already installed"
else
  echo "Installing ripgrep..."
  if ensure_brew; then
    brew install -q ripgrep
  else
    sudo apt-get install -y ripgrep
  fi
fi

echo ""
echo "Done!"
