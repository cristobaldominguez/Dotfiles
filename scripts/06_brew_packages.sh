#!/usr/bin/env bash
set -e
REPO_DIR="$1"

echo "=== Instalando Packages de Brew ==="

eval "$(/opt/homebrew/bin/brew shellenv)"
brew bundle --file="${REPO_DIR}/Brewfile"

mkdir -p "${HOME}/.zsh.d"
cp "${REPO_DIR}/zsh/03_brew_tools.zsh" "${HOME}/.zsh.d/03_brew_tools.zsh"
echo "✓ Packages de Brew instalados"
