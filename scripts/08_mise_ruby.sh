#!/usr/bin/env bash
set -e
REPO_DIR="$1"

echo "=== Instalando Ruby via Mise ==="

# mise ya está instalado via Homebrew (Brewfile)
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

if ! mise use --global ruby@latest 2>/dev/null; then
  echo "Latest Ruby no disponible, usando ruby@3..."
  mise use --global ruby@3
fi

cp "${REPO_DIR}/dotfiles/gemrc" "${HOME}/.gemrc"
echo "✓ Ruby instalado via Mise"
