#!/usr/bin/env bash
set -e
REPO_DIR="$1"

echo "=== Copiando Dotfiles ==="

cp "${REPO_DIR}/dotfiles/zshrc"             "${HOME}/.zshrc"
cp "${REPO_DIR}/dotfiles/gitattributes"     "${HOME}/.gitattributes"
cp "${REPO_DIR}/dotfiles/gitconfig"         "${HOME}/.gitconfig"
cp "${REPO_DIR}/dotfiles/gitignore"         "${HOME}/.gitignore"
cp "${REPO_DIR}/dotfiles/shortcuts"         "${HOME}/.shortcuts"
cp "${REPO_DIR}/dotfiles/zsh_customization" "${HOME}/.zsh_customization"

mkdir -p "${HOME}/.zsh.d"

echo "✓ Dotfiles copiados"
