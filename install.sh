#!/bin/sh

echo "Comenzando!"

# Instalando Roseta en procesadores M
if [[ $(uname -m) == 'arm64' ]]; then
  softwareupdate --install-rosetta
fi


# echo "Instalando Herramientas de xCode"
xcode-select --install


# echo "Instalando Brew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew_check=$(brew doctor)

if ! [[ $brew_check =~ 'ready to brew' ]]; then
  echo "Error en Brew"
  exit 1
fi


# echo "Instalando Oh-My-Zsh"
cp -r ./Fonts/. ${HOME}/Library/Fonts
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# echo "Copiando preferencias del Terminal"
cp ./terminal/com.apple.Terminal.plist ${HOME}/Library/Preferences/com.apple.Terminal.plist


echo "Instalando Packages de Brew"
cp ./Brewfile ${HOME}/Brewfile
brew bundle
rm ${HOME}/Brewfile

# brew_bash=$(brew info bash)
# directory=$(print $brew_bash | grep -wi "$(brew --prefix)/Cellar/bash/[0-9]......" | awk '{print $1}')
# sudo sh -c "echo $directory/bin/bash >> /etc/shells"


echo "Instalando plugines de Zsh"
# zsh-autosuggestions
echo "Instalando zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# zsh-syntax-highlighting
echo "Instalando zsh-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# zsh-history-substring-search
echo "Instalando zsh-history-substring-search"
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search


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
rvm get head
rvm install 4.0 --with-openssl-dir=$(brew --prefix openssl@3)


echo "Instalando la versión de Node LTS más nueva"
fnm install --lts

echo "Listo!"
