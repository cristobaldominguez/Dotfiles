#!/usr/bin/env bash
set -e
REPO_DIR="$1"

echo "=== Instalando Herramientas de Xcode ==="

if ! xcode-select -p &>/dev/null; then
  xcode-select --install
  echo "Completá la instalación en el diálogo que se abrió. Esperando..."
  until xcode-select -p &>/dev/null; do
    sleep 5
  done
fi

echo "✓ Xcode CLI tools listo"
