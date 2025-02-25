#!/bin/bash

# configure git
echo 'Configuring git'

git config --global user.name 'jacques-navarro'
git config --global user.email '4421229+jacques-navarro@users.noreply.github.com'
git config --global core.editor 'vim'
git config --system init.defaultBranch main
git config --list

# add git aliases
git config --system alias.alias 'config --get-regexp ^alias'
git config --system alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset - %Cgreen%<(16)%ah%Creset %C(bold blue)%<(16)<%an>%Creset %C(auto)%d%Creset%s' --abbrev-commit"
git config --system alias.ol "log --pretty=format:'%C(auto)%h%Creset %Cgreen%<(16)%ah%Creset %C(auto)%d%Creset %s'"
git alias

# install vim-plug
curl -fLo /home/ubuntu/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install llvm and clang
apt-get -y install clang-format clang-tidy clang-tools clang clangd libc++-dev libc++1 libc++abi-dev libc++abi1 libclang-dev libclang1 liblldb-dev libllvm-ocaml-dev libomp-dev libomp5 lld lldb llvm-dev llvm-runtime llvm python3-clang

# install yegappan/lsp plugin
mkdir -p /home/ubuntu/.vim/pack/downloads/opt
cd /home/ubuntu/.vim/pack/downloads/opt
git clone https://github.com/yegappan/lsp
vim -u NONE -c "helptags /home/ubuntu/.vim/pack/downloads/opt/lsp/doc" -c q
chown -R ubuntu:ubuntu /home/ubuntu/.vim

# copy .vimrc to home directory
cd /home/ubuntu 
cp /home/ubuntu/vim/vim-vimrc/.vimrc /home/ubuntu
chown -R ubuntu:ubuntu /home/ubuntu/.vimrc

# generate ssh key
echo **********************
echo * Generating SSH key *
echo **********************
echo -e "\n\n\n" | ssh-keygen -t ed25519 -C "4421229+jacques-navarro@users.noreply.github.com" -N "" -f /home/ubuntu/.ssh/id_ed25519
eval "$(ssh-agent -s)"
ssh-add /home/ubuntu/.ssh/id_ed25519
cat /home/ubuntu/.ssh/id_ed25519.pub
