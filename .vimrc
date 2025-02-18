" Pesist undo history
set undofile

let undo_dir = expand('$HOME/.vim/undodir')
if !isdirectory(undo_dir)
    call mkdir(undo_dir, "p")
endif
set undodir=undo_dir

" Manage plugins with vim-plug
call plug#begin()
call plug#end()

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif
