#!/bin/bash

set -euo pipefail

username="$1"
useremail="$2"

git config --global user.name "$username"
git config --global user.email "$useremail"

echo ''
git config --list
echo ''

echo
echo '************************'
echo '*   Install vim-plug   *'
echo '************************'
echo

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo
echo '************************'
echo '*  Install LSP plugin  *'
echo '************************'
echo

mkdir -p ~/.vim/pack/downloads/opt
cd ~/.vim/pack/downloads/opt
git clone https://github.com/yegappan/lsp
vim -u NONE -c "helptags ~/.vim/pack/downloads/opt/lsp/doc" -c q

echo
echo '************************'
echo '*     Copy .vimrc      *'
echo '************************'
echo

cd $HOME
cp ~/vim/vim-vimrc/.vimrc ~/ 

echo
echo '************************'
echo '*   Generate SSH key   *'
echo '************************'
echo

echo -e "\n\n\n" | ssh-keygen -t ed25519 -C "$useremail" -N "" -f ~/.ssh/id_ed25519
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
