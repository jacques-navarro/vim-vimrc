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

echo '************************'
echo '*   User git config    *'
echo '************************'

getUsername

getUseremail

git config --global user.name "$username"
git config --global user.email "$useremail"

echo ''
git config --list
echo ''

# install vim-plug

echo '************************'
echo '*   Install vim-plug   *'
echo '************************'

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install yegappan/lsp plugin

echo '************************'
echo '*  Install LSP plugin  *'
echo '************************'

mkdir -p ~/.vim/pack/downloads/opt
cd ~/.vim/pack/downloads/opt
git clone https://github.com/yegappan/lsp
vim -u NONE -c "helptags ~/.vim/pack/downloads/opt/lsp/doc" -c q
# chown -R ubuntu:ubuntu /home/ubuntu/.vim

# copy .vimrc to home directory

echo '************************'
echo '*     Copy .vimrc      *'
echo '************************'

cd $HOME
cp ~/vim/vim-vimrc/.vimrc /home/ubuntu
# chown -R ubuntu:ubuntu /home/ubuntu/.vimrc

# generate ssh key

echo '************************'
echo '*   Generate SSH key   *'
echo '************************'

echo -e "\n\n\n" | ssh-keygen -t ed25519 -C "4421229+jacques-navarro@users.noreply.github.com" -N "" -f ~/.ssh/id_ed25519
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
