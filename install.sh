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
chmod 755 /usr/local/share/zsh
chmod 755 /usr/local/share/zsh/site-functions
cp ./oh-my-zsh-themes/agnoster.zsh-theme ${HOME}/.oh-my-zsh/themes/


# echo "Copiando preferencias del Terminal"
cp ./terminal/com.apple.Terminal.plist ${HOME}/Library/Preferences/com.apple.Terminal.plist


echo "Instalando RVM"
curl -L https://get.rvm.io | bash -s stable --ruby
rvm requirements


echo "Instalando Packages de Brew"
cp ./Brewfile ${HOME}/Brewfile
brew bundle
rm ${HOME}/Brewfile
rm ${HOME}/Brewfile.lock.json

brew_bash=$(brew info bash)
directory=$(print $brew_bash | grep -wi "$(brew --prefix)/Cellar/bash/[0-9]......" | awk '{print $1}')
echo "$directory/bin/bash" >> /etc/shells


echo "Copiando archivos"
cp ./zshrc ${HOME}/.zshrc
cp ./zsh_rvm ${HOME}/.zsh_rvm
cp ./gemrc ${HOME}/.gemrc
# cp ./rubocop ${HOME}/.rubocop
cp ./gitattributes ${HOME}/.gitattributes
cp ./gitconfig ${HOME}/.gitconfig
cp ./gitignore ${HOME}/.gitignore
# cp ./hub ${HOME}/.hub
cp ./shortcuts ${HOME}/.shortcuts


echo "Instalando la versión de Node LTS más nueva"
fnm install --lts


echo "Configuraciones finales"
brew services start postgresql@15
createdb cristobaldominguez


echo "Listo!"
