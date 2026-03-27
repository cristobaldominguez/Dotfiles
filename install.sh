#!/usr/bin/env bash
set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
SYNC_DIR="/tmp/dotfiles-install-$$"
mkdir -p "$SYNC_DIR"

cleanup() {
  rm -rf "$SYNC_DIR"
}
trap cleanup EXIT

run_step() {
  local name="$1"
  local script="${REPO_DIR}/scripts/$2"
  local exit_file="${SYNC_DIR}/${name}.exit"

  echo "→ Iniciando: ${name}"

  local window_id
  window_id=$(osascript \
    -e 'tell application "Terminal"' \
    -e '  activate' \
    -e "  do script \"bash '${REPO_DIR}/scripts/_runner.sh' '${script}' '${REPO_DIR}' '${exit_file}'\"" \
    -e '  return id of front window' \
    -e 'end tell')

  while [ ! -f "${exit_file}" ]; do
    sleep 2
  done

  local code
  code=$(cat "${exit_file}")
  if [ "${code}" != "0" ]; then
    echo "✗ Falló: ${name} (exit ${code}). Revisá la ventana de terminal."
    exit 1
  fi

  osascript \
    -e 'tell application "Terminal"' \
    -e "  close (first window whose id is ${window_id}) saving no" \
    -e 'end tell' 2>/dev/null || true

  echo "✓ Completado: ${name}"
}

echo "Comenzando la instalación!"

run_step "Rosetta"         "01_rosetta.sh"
run_step "Xcode"           "02_xcode.sh"
run_step "Dotfiles"        "03_dotfiles.sh"
run_step "Homebrew"        "04_homebrew.sh"
run_step "Oh-My-Zsh"       "05_ohmyzsh.sh"
run_step "Brew Packages"   "06_brew_packages.sh"
run_step "Zsh Plugins"     "07_zsh_plugins.sh"
run_step "Ruby"            "08_mise_ruby.sh"
run_step "Node LTS"        "09_node.sh"

echo "Listo, instalación completa!."
