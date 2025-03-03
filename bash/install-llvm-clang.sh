#!/bin/bash

set -euo pipefail

username=""
useremail=""

# Prompt user for a Github username
# The http status code is checked and accepts the username,
# if the status code is between 200 and 399.
# If an incorrect username is entered the user prompted
# again to enter a username up to two more times.
# The program exits after the third incorrect username is entered.

getUsername() {

echo
echo '************************'
echo '*   Github username    *'
echo '************************'
echo

local errorCounter=3

while true; do

    # prompt user for user name
    # store value in username variable
    read -p  "Enter Github username: " username

    # check if username is empty
    if [[ -z "$username"  ]]; then
        echo
        echo "Enter a username"
        echo
        continue
    fi

    # request http headers
    # use cut to extract the second column of text
    # use awk to extract the response status code
    local code=$(curl -Is https://github.com/"$username" | stdbuf -o0 cut -d " " -f 2  | awk 'NR==1{print $1}')

    local pattern="(2|3)[[:digit:]]{2}"

    # match a patter that is either 2XX or 3XX status code
    if [[ "$code" =~ $pattern ]]; then
        echo
        echo "A valid Github username was entered." >&2
        echo
        break
    else
        ((errorCounter--))

        if (($errorCounter == 0)); then
            echo
            echo "You have entered too many incorrect usernames."
            echo "Exiting program." 
            echo
            return "2"
        fi

        echo
        echo "$username is not a valid Github username!" >&2
        echo "You have $errorCounter tries left." >&2
        echo
        continue
    fi

    return "0"
done
}

# prompt user for an email address
# validate email address
# If an incorrect email address is entered the user prompted
# again to enter an email address up to two more times.
# The program exits after the third incorrect email address is entered.

getUseremail() {

echo
echo '************************'
echo '*     Github email     *'
echo '************************'
echo

local errorCounter=3

while true; do
    
    # prompt user for user name
    # store value in username variable
    read -p  "Enter Github email address: " useremail

    # check if useremail is empty
    if [[ -z "$useremail"  ]]; then
        echo
        echo "Enter an email address" >&2
        echo
        continue
    fi

    # source: https://gist.github.com/guessi/82a73ee7eb2b1216eb9db17bb8d65dd1
    local pattern="^(([A-Za-z0-9]+((\.|\-|\_|\+)?[A-Za-z0-9]?)*[A-Za-z0-9]+)|[A-Za-z0-9]+)@(([A-Za-z0-9]+)+((\.|\-|\_)?([A-Za-z0-9]+)+)*)+\.([A-Za-z]{2,})+$"

    if [[ "$useremail" =~ $pattern ]]; then
        echo
        echo "$useremail is a valid email address." >&2
        echo
        break
    else
        ((errorCounter--))

        if (($errorCounter == 0)); then
            echo
            echo "You have entered too many incorrect email addresses." >&2
            echo "Exiting program." >&2
            echo
            return "2"
        fi

        echo
        echo "$useremail is not a valid email address." >&2
        echo "You have $errorCounter tries left." >&2
        echo
        continue
    fi

    return "0"
    
done
}

getUsername

getUseremail

echo
echo '************************'
echo '* Install LLVM & clang *'
echo '************************'
echo

apt-get -y install clang-format clang-tidy clang-tools clang clangd libc++-dev libc++1 libc++abi-dev libc++abi1 libclang-dev libclang1 liblldb-dev libllvm-ocaml-dev libomp-dev libomp5 lld lldb llvm-dev llvm-runtime llvm python3-clang

echo
echo '************************'
echo '*  System git configs  *'
echo '************************'
echo

echo "Setting up vim as git code editor"
echo "Setting 'main' as default git branch"

git config --system core.editor 'vim'
git config --system init.defaultBranch main

echo "Setting up git aliases"

# add git aliases
git config --system alias.alias 'config --get-regexp ^alias'
git config --system alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset - %Cgreen%<(16)%ah%Creset %C(bold blue)%<(16)<%an>%Creset %C(auto)%d%Creset%s' --abbrev-commit"
git config --system alias.ol "log --pretty=format:'%C(auto)%h%Creset %Cgreen%<(16)%ah%Creset %C(auto)%d%Creset %s'"

# run configure-git-vim.sh as regular user
# requires $USER as command line parameter when the current script is called
# The second bash script and the PWD must be the same as the first script
cd "$2"/vim/vim-vimrc/bash
exec su "$1" -- "configure-git-vim.sh" "$username" "$useremail"
