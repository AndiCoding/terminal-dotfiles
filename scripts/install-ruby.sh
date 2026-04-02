#!/usr/bin/env bash
set -euo pipefail

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPTS_DIR/utils.sh"

if command -v ruby &>/dev/null; then
  echo "ruby already installed"
  exit 0
fi

echo "Installing ruby..."

if ensure_brew; then
  brew install -q ruby
else
  apt_update
  sudo apt-get install -y ruby-full
fi

echo "Ruby installed."
