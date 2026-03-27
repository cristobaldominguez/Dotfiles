#!/usr/bin/env bash
set -e
REPO_DIR="$1"

echo "=== Instalando Homebrew ==="

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

brew_check=$(brew doctor 2>&1 || true)
if ! [[ $brew_check =~ 'ready to brew' ]]; then
  echo "✗ Error en Brew"
  exit 1
fi

mkdir -p "${HOME}/.zsh.d"
cp "${REPO_DIR}/zsh/01_homebrew.zsh" "${HOME}/.zsh.d/01_homebrew.zsh"
echo "✓ Homebrew listo"
