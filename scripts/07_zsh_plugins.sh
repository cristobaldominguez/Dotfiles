#!/usr/bin/env bash
set -e
REPO_DIR="$1"

echo "=== Instalando Plugins de Zsh ==="

ZSH_CUSTOM="${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}"

echo "Instalando zsh-autosuggestions"
[ ! -d "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" ] && \
  git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"

echo "Instalando zsh-syntax-highlighting"
[ ! -d "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting" ] && \
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"

echo "Instalando zsh-history-substring-search"
[ ! -d "${ZSH_CUSTOM}/plugins/zsh-history-substring-search" ] && \
  git clone https://github.com/zsh-users/zsh-history-substring-search "${ZSH_CUSTOM}/plugins/zsh-history-substring-search"

echo "✓ Plugins de Zsh instalados"
