#!/bin/bash

# install llvm and clang

echo '************************'
echo '* Install LLVM & clang *'
echo '************************'
echo ''
apt-get -y install clang-format clang-tidy clang-tools clang clangd libc++-dev libc++1 libc++abi-dev libc++abi1 libclang-dev libclang1 liblldb-dev libllvm-ocaml-dev libomp-dev libomp5 lld lldb llvm-dev llvm-runtime llvm python3-clang

echo '************************'
echo '*  System git configs  *'
echo '************************'

git config --system core.editor 'vim'
git config --system init.defaultBranch main

# add git aliases
git config --system alias.alias 'config --get-regexp ^alias'
git config --system alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset - %Cgreen%<(16)%ah%Creset %C(bold blue)%<(16)<%an>%Creset %C(auto)%d%Creset%s' --abbrev-commit"
git config --system alias.ol "log --pretty=format:'%C(auto)%h%Creset %Cgreen%<(16)%ah%Creset %C(auto)%d%Creset %s'"

echo ''
git config --list

# run configure-git-vim.sh as regular user
# requires $USER as command line parameter when the current script is called
# The second bash script and the PWD must be the same as the first script
cd "$2"/vim/vim-vimrc/bash
exec su "$1" -- "configure-git-vim.sh"
