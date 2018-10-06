#!/bin/sh

echo "Comenzando!"

echo "Instalando wp-cli"
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp


echo "Copiando archivos"
cp ./bash_php ${HOME}/.bash_php
cp ./bash_profile ${HOME}/.bash_profile
cp ./bash_prompt ${HOME}/.bash_prompt
cp ./bashrc ${HOME}/.bashrc
cp ./gemrc ${HOME}/.gemrc
cp ./gitconfig ${HOME}/.gitconfig
cp ./gitignore ${HOME}/.gitignore
cp ./gitattributes ${HOME}/.gitattributes
cp ./inputrc ${HOME}/.inputrc
cp ./profile ${HOME}/.profile
cp ./rubocop ${HOME}/.rubocop
cp ./shortcuts ${HOME}/.shortcuts
cp ./Brewfile ${HOME}/Brewfile

echo "Instalando Packages de Brew"
brew bundle
rm ${HOME}/Brewfile

echo "Listo!"
