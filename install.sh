#!/usr/bin/env bash
set -euo pipefail

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/scripts"
source "$SCRIPTS_DIR/utils.sh"

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
echo "Optional tools (enter numbers separated by spaces, e.g. 1 3):"
echo "  0) All"
echo "  1) Neovim"
echo "  2) Docker"
echo "  3) Kubernetes (kubectl, rancher desktop/k3s, helm)"
echo "  4) GitHub CLI (gh)"
echo "  5) tmux"
echo "  6) lazygit"
echo "  7) Ghostty"
echo ""
read -rp "Tools to install: " tool_input
echo ""

# ── Dependencies ──────────────────────────────────────────────────────────────
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
echo ""
echo "Installing user selected tools..."
if echo "$tool_input" | grep -qw 0; then
  tool_input="1 2 3 4 5 6 7"
fi

for num in $tool_input; do
  case "$num" in
    1) bash "$SCRIPTS_DIR/install-nvim.sh" ;;
    2) bash "$SCRIPTS_DIR/install-docker.sh" ;;
    3) bash "$SCRIPTS_DIR/install-kubernetes.sh" ;;
    4) bash "$SCRIPTS_DIR/install-gh.sh" ;;
    5) bash "$SCRIPTS_DIR/install-tmux.sh" ;;
    6) bash "$SCRIPTS_DIR/install-lazygit.sh" ;;
    7) bash "$SCRIPTS_DIR/install-ghostty.sh" ;;
  esac
done

echo ""
echo "All done! Open a new terminal to start using your setup."
