#!/usr/bin/env bash
set -e
REPO_DIR="$1"

echo "=== Instalando Rosetta ==="

if [[ $(uname -m) == 'arm64' ]]; then
  softwareupdate --install-rosetta
  echo "✓ Rosetta instalada"
else
  echo "✓ No es ARM64, Rosetta no es necesaria"
fi
