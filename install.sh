#!/usr/bin/env bash
set -euo pipefail

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/scripts"
source "$SCRIPTS_DIR/utils.sh"

# ── Checkbox menu ──────────────────────────────────────────────────────────────
# Usage: checkbox_menu items_array result_array
# Populates result_array with selected item names.
checkbox_menu() {
  local -n _items=$1
  local -n _result=$2
  local current=0
  local count=${#_items[@]}
  local toggled=()

  for ((i = 0; i < count; i++)); do toggled[$i]=1; done

  _draw() {
    for ((i = 0; i < count; i++)); do
      local mark=" "
      [[ ${toggled[$i]} -eq 1 ]] && mark="x"
      local prefix="  "
      [[ $i -eq $current ]] && prefix="> "
      printf "%s[%s] %s\033[K\n" "$prefix" "$mark" "${_items[$i]}"
    done
  }

  tput civis
  _draw

  while true; do
    tput cuu "$count"
    IFS= read -rsn1 key
    if [[ $key == $'\x1b' ]]; then
      read -rsn2 -t 0.1 rest && key+="$rest" || true
    fi
    case "$key" in
    $'\x1b[A') ((current > 0)) && ((current--)) || true ;;
    $'\x1b[B') ((current < count - 1)) && ((current++)) || true ;;
    ' ') [[ ${toggled[$current]} -eq 1 ]] && toggled[$current]=0 || toggled[$current]=1 ;;
    '') break ;;
    esac
    _draw
  done

  tput cnorm
  echo ""

  for ((i = 0; i < count; i++)); do
    [[ ${toggled[$i]} -eq 1 ]] && _result+=("${_items[$i]}")
  done
}

echo ""
echo "Dotfiles installer"
echo ""

# ── Shell choice ──────────────────────────────────────────────────────────────
echo "Default shell:"
echo "  1) zsh (default)"
echo "  2) fish"
echo ""
read -rp "Choice [1/2]: " shell_choice
shell_choice="${shell_choice:-1}"
echo ""

# ── Optional tools ────────────────────────────────────────────────────────────
echo "Select tools to install (↑↓ to move, space to toggle, enter to confirm):"
echo ""

tools=(
  "Neovim"
  "Docker"
  "Kubernetes (kubectl, rancher desktop/k3s, helm)"
  "GitHub CLI (gh)"
  "tmux"
  "lazygit"
  "Ghostty"
)
selected=()
checkbox_menu tools selected

# ── Dependencies ──────────────────────────────────────────────────────────────
clear
echo "Installing needed dependencies..."
echo ""
bash "$SCRIPTS_DIR/install-homebrew.sh"
bash "$SCRIPTS_DIR/install-ruby.sh"
bash "$SCRIPTS_DIR/install-cli-tools.sh"

if [[ "$shell_choice" == "2" ]]; then
  bash "$SCRIPTS_DIR/install-fish.sh"
else
  bash "$SCRIPTS_DIR/install-zsh.sh"
fi

# ── Optional ──────────────────────────────────────────────────────────────────
if [[ ${#selected[@]} -gt 0 ]]; then
  echo ""
  echo "Installing user selected tools..."

  for tool in "${selected[@]}"; do
    case "$tool" in
    "Neovim") bash "$SCRIPTS_DIR/install-nvim.sh" ;;
    "Docker") bash "$SCRIPTS_DIR/install-docker.sh" ;;
    "Kubernetes (kubectl, rancher desktop/k3s, helm)") bash "$SCRIPTS_DIR/install-kubernetes.sh" ;;
    "GitHub CLI (gh)") bash "$SCRIPTS_DIR/install-gh.sh" ;;
    "tmux") bash "$SCRIPTS_DIR/install-tmux.sh" ;;
    "lazygit") bash "$SCRIPTS_DIR/install-lazygit.sh" ;;
    "Ghostty") bash "$SCRIPTS_DIR/install-ghostty.sh" ;;
    esac
  done

fi

echo ""
echo "All done! Open a new terminal to start using your setup."
