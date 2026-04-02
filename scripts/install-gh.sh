#!/usr/bin/env bash
set -euo pipefail

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPTS_DIR/utils.sh"

if command -v gh &>/dev/null; then
  echo "gh already installed"
  exit 0
fi

echo "Installing gh..."

if ensure_brew; then
  brew install -q gh
else
  apt_update
  sudo apt-get install -y curl
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/githubcli.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/githubcli.list
  sudo apt-get update -qq
  sudo apt-get install -y gh
fi

echo "GitHub CLI (gh) installed."
