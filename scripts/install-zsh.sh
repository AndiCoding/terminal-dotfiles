#!/usr/bin/env bash
set -euo pipefail

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPTS_DIR/utils.sh"

ZSH_DIR="$SCRIPTS_DIR/../zsh"

if command -v zsh &>/dev/null; then
  echo "zsh already installed"
else
  echo "Installing zsh..."
  if ensure_brew; then
    brew install -q zsh
  else
    apt_update && sudo apt-get install -y zsh
  fi
fi

echo ""

if [[ -d "$HOME/.oh-my-zsh" ]]; then
  echo "Oh My Zsh already installed"
else
  echo "Installing Oh My Zsh..."
  RUNZSH=no CHSH=no sh -c \
    "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo ""

OMZ_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if ensure_brew; then
  if brew list powerlevel10k &>/dev/null; then
    echo "Powerlevel10k already installed"
  else
    echo "Installing Powerlevel10k..."
    brew install -q romkatv/powerlevel10k/powerlevel10k
  fi
else
  if [[ -d "$OMZ_CUSTOM/themes/powerlevel10k" ]]; then
    echo "Powerlevel10k already installed"
  else
    echo "Installing Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$OMZ_CUSTOM/themes/powerlevel10k"
  fi
fi

echo ""

install_omz_plugin() {
  local name="$1" url="$2"
  if [[ -d "$OMZ_CUSTOM/plugins/$name" ]]; then
    echo "Plugin '$name' already installed"
  else
    echo "Installing plugin '$name'..."
    git clone --depth=1 "$url" "$OMZ_CUSTOM/plugins/$name"
  fi
}

install_omz_plugin zsh-autosuggestions https://github.com/zsh-users/zsh-autosuggestions
install_omz_plugin zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting

echo ""

if [[ -f "$HOME/.zshrc" ]]; then
  echo "Using existing ~/.zshrc"
else
  if ensure_brew; then
    cp "$ZSH_DIR/.zshrc.mac" "$HOME/.zshrc"
  else
    cp "$ZSH_DIR/.zshrc.linux" "$HOME/.zshrc"
  fi
  echo "Copied .zshrc"
fi

echo ""

ZSH_PATH="$(which zsh)"
if [[ "$SHELL" == "$ZSH_PATH" ]]; then
  echo "zsh is already the default shell"
else
  echo "Setting zsh as default shell..."
  if ! grep -qF "$ZSH_PATH" /etc/shells; then
    echo "$ZSH_PATH" | sudo tee -a /etc/shells
  fi
  chsh -s "$ZSH_PATH"
fi

echo ""
echo "zsh installed with Oh My Zsh, Powerlevel10k, and plugins. Open a new terminal or run: exec zsh"
