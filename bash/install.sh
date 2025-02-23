#!/bin/bash

# create vim directory in home directory
mkdir ~/vim

# clone git repo from Github
git clone git@github.com:jacques-navarro/vim-vimrc.git ~/vim

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
