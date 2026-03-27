#!/usr/bin/env bash
set -e
REPO_DIR="$1"

echo "=== Instalando Node LTS via Mise ==="

# mise ya está instalado via Homebrew (Brewfile)
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

mise use --global node@lts

mkdir -p "${HOME}/.zsh.d"
cp "${REPO_DIR}/zsh/04_pnpm.zsh" "${HOME}/.zsh.d/04_pnpm.zsh"
echo "✓ Node LTS instalado via Mise"
