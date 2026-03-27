#!/usr/bin/env bash
set -e
REPO_DIR="$1"

echo "=== Instalando Oh-My-Zsh ==="

cp -r "${REPO_DIR}/Fonts/." "${HOME}/Library/Fonts"
echo "✓ Fuentes copiadas"

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
echo "✓ Oh-My-Zsh instalado"

cp "${REPO_DIR}/terminal/com.apple.Terminal.plist" "${HOME}/Library/Preferences/com.apple.Terminal.plist"
echo "✓ Preferencias de Terminal copiadas"

mkdir -p "${HOME}/.zsh.d"
cp "${REPO_DIR}/zsh/02_ohmyzsh.zsh" "${HOME}/.zsh.d/02_ohmyzsh.zsh"
echo "✓ Configuración zsh de Oh-My-Zsh copiada"
