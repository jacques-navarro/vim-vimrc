![](images/Vimlogo.svg.png)

# .vimrc

My personal Vim setup

![](images/vim-c.png)

## Plugins

- [vim-airline/vim-airline](https://github.com/vim-airline/vim-airline)
- [vim-airline/vim-airline-themes](https://github.com/vim-airline/vim-airline-themes)
- [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive)
- [yegappan/lsp](https://github.com/yegappan/lsp)

## Installation

### Generate SSH key and add it to Github

```
echo -e "\n\n\n" | ssh-keygen -t ed25519 -C "4421229+jacques-navarro@users.noreply.github.com" -N "" -f ~/.ssh/id_ed25519
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
```

### Clone repo and run install bash script

```
# create vim directory in home directory
mkdir ~/vim
cd ~/vim
 
 # clone git repo from Github
git clone https://github.com/jacques-navarro/vim-vimrc.git 

# run install Bash script
sudo ~/vim/vim-vimrc/bash/install.sh
```
