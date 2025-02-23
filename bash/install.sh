#!/bin/bash

# switch to home directory and create vim directory
mkdir ~/vim
cd ~/vim

# clone git repo from Github
git clone git@github.com:jacques-navarro/vim-vimrc.git ~/vim


# install git
echo 'Installing git'
apt install -y git
echo 'git installed successfully:'
git --version

# install Vim
echo 'Installing Vim'
apt intall -y vim
echo 'Vim installed successfully:'
vim --version

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
