set number
set wrap
syntax on
        
" Use space characters instead of tabs.
set expandtab
	

" Set tab width to 4 columns.
set tabstop=4

" Ignore capital letters during search.
set ignorecase

" Pesist undo history
set undofile

let undo_dir = expand('$HOME/.vim/undodir')
if !isdirectory(undo_dir)
    call mkdir(undo_dir, "p")
endif
set undodir=undo_dir

" Manage plugins with vim-plug
call plug#begin()

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

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

" Airline/Powerline settings
let g:airline_powerline_fonts = 1
let g:airline_solarized_bg='dark'
let g:airline_section_z = "%3p%% %l:%c"
let g:airline_section_c = "%F"
