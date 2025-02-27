#!/bin/bash

# install llvm and clang

echo '************************'
echo '* Install LLVM & clang *'
echo '************************'

apt-get -y install clang-format clang-tidy clang-tools clang clangd libc++-dev libc++1 libc++abi-dev libc++abi1 libclang-dev libclang1 liblldb-dev libllvm-ocaml-dev libomp-dev libomp5 lld lldb llvm-dev llvm-runtime llvm python3-clang

# run configure-git-vim.sh as regular user
# requires $USER as command line parameter when the current script is called
# The second bash script and the PWD must be the same as the first script
cd "$2"/vim/vim-vimrc/bash
exec su "$1" -- "configure-git-vim.sh"
