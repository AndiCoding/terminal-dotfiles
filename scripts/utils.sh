#!/usr/bin/env bash

detect_os() {
  case "$(uname -s)" in
    Darwin) echo "macos" ;;
    Linux)  echo "linux" ;;
    *)      echo "unsupported" ;;
  esac
}

OS=$(detect_os)

require_os() {
  local required="$1"
  if [[ "$OS" != "$required" ]]; then
    echo "This script requires $required"
    exit 1
  fi
}


ensure_brew() {
  if [[ "$OS" != "macos" ]]; then
    echo "Not macOS, skipping Homebrew"
    return 1
  fi
  if ! command -v brew &>/dev/null; then
    echo "Homebrew not found, installing..."
    bash "$(dirname "${BASH_SOURCE[0]}")/install-homebrew.sh"
  fi
}

apt_update() {
  sudo apt-get update -qq
  sudo apt-get upgrade -y
  sudo apt-get autoremove -y
}
