#!/usr/bin/env bash
set -e
REPO_DIR="$1"

echo "=== Instalando Ollama ==="

curl -fsSL https://ollama.com/install.sh | sh

mkdir -p "${HOME}/.zsh.d"
cp "${REPO_DIR}/zsh/05_ollama.zsh" "${HOME}/.zsh.d/05_ollama.zsh"
echo "✓ Ollama instalado"
