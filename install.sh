#!/usr/bin/env bash
set -e

echo "Comenzando!"

# Instalando Roseta en procesadores M
if [[ $(uname -m) == 'arm64' ]]; then
  softwareupdate --install-rosetta
fi


echo "Instalando Herramientas de xCode"
if ! xcode-select -p &>/dev/null; then
  xcode-select --install
fi


echo "Instalando Brew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

brew_check=$(brew doctor)
if ! [[ $brew_check =~ 'ready to brew' ]]; then
  echo "Error en Brew"
  exit 1
fi


echo "Instalando Oh-My-Zsh"
cp -r ./Fonts/. ${HOME}/Library/Fonts
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo "Copiando preferencias del Terminal"
cp ./terminal/com.apple.Terminal.plist ${HOME}/Library/Preferences/com.apple.Terminal.plist


echo "Instalando Packages de Brew"
brew bundle --file=./Brewfile


echo "Instalando plugines de Zsh"
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


echo "Copiando archivos"
cp ./zshrc ${HOME}/.zshrc
cp ./zsh_rvm ${HOME}/.zsh_rvm
cp ./gemrc ${HOME}/.gemrc
cp ./gitattributes ${HOME}/.gitattributes
cp ./gitconfig ${HOME}/.gitconfig
cp ./gitignore ${HOME}/.gitignore
cp ./shortcuts ${HOME}/.shortcuts
cp ./zsh_customization ${HOME}/.zsh_customization


echo "Instalando RVM"
gpg --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable
rvm install 3.3 --with-openssl-dir=$(brew --prefix openssl@3)


echo "Instalando la versión de Node LTS más nueva"
fnm install --lts

echo "Listo!"
