#!/bin/sh

echo "Comenzando!"

# echo "Instalando wp-cli"
# /bin/bash -c "$(curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar)"
# chmod +x wp-cli.phar
# sudo mv wp-cli.phar /usr/local/bin/wp


echo "Instalando Brew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew doctor


echo "Instalando Oh-My-Zsh"
cp -r ./Fonts/. ${HOME}/Library/Fonts
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chmod 755 /usr/local/share/zsh
chmod 755 /usr/local/share/zsh/site-functions
cp ./oh-my-zsh-themes/agnoster.zsh-theme ${HOME}/.oh-my-zsh/themes/


echo "Copiando preferencias del Terminal"
cp ./terminal/com.apple.Terminal.plist ${HOME}/Library/Preferences/com.apple.Terminal.plist


echo "Instalando NPM"
curl -sSL https://get.rvm.io | bash -s stable --ruby


echo "Instalando NVM"
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash


echo "Copiando archivos"
cp ./zshrc ${HOME}/.zshrc
cp ./gemrc ${HOME}/.gemrc
cp ./gitattributes ${HOME}/.gitattributes
cp ./gitconfig ${HOME}/.gitconfig
cp ./gitignore ${HOME}/.gitignore
cp ./shortcuts ${HOME}/.shortcuts
cp ./hub ${HOME}/.hub
cp ./rubocop ${HOME}/.rubocop
cp ./zsh_rvm ${HOME}/.zsh_rvm


echo "Instalando Packages de Brew"
cp ./Brewfile ${HOME}/Brewfile
brew bundle
rm ${HOME}/Brewfile
rm ${HOME}/Brewfile.lock.json


echo "Instalando versiones de Ruby"
rvm requirements
rvm install ruby-2.7.2
rvm --default use 2.7.2


echo "Instalando versiones de Node"
nvm install 15.9.0


echo "Configuraciones finales"
pg_ctl -D /usr/local/var/postgres -l logfile start
createdb cristobaldominguez


echo "Listo!"
