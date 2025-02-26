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

### Clone repo and run install bash script

```
# create vim directory in home directory
mkdir ~/vim
cd ~/vim
 
 # clone git repo from Github
git clone https://github.com/jacques-navarro/vim-vimrc.git 

# switch to location of bash scripts
cd /vim-vimrc/bash

# run install Bash script
sudo ~/vim/vim-vimrc/bash/install-llvm-clang.sh $USER $HOME
```
