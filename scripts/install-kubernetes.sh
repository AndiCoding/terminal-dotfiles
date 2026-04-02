#!/usr/bin/env bash
set -euo pipefail

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPTS_DIR/utils.sh"

if ! ensure_brew; then
  apt_update
fi

if command -v kubectl &>/dev/null; then
  echo "kubectl already installed"
else
  echo "Installing kubectl..."
  if ensure_brew; then
    brew install -q kubectl
  else
    sudo apt-get install -y apt-transport-https ca-certificates curl gnupg
    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
    echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list
    sudo apt-get update -qq
    sudo apt-get install -y kubectl
  fi
fi

if ensure_brew; then
  if command -v rdctl &>/dev/null; then
    echo "Rancher Desktop already installed"
  else
    echo "k3s is not supported on macOS natively, installing Rancher Desktop instead (k3s in a VM)..."
    brew install -q --cask rancher
  fi
else
  if command -v k3s &>/dev/null; then
    echo "k3s already installed"
  else
    echo "Installing k3s..."
    curl -sfL https://get.k3s.io | sh -
  fi
fi

if command -v helm &>/dev/null; then
  echo "helm already installed"
else
  echo "Installing helm..."
  if ensure_brew; then
    brew install -q helm
  else
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
  fi
fi

echo ""
echo "Kubernetes tools installed: kubectl, helm, rancher desktop (macOS) / k3s (Linux)."
