" Pesist undo history
set undofile

let undo_dir = expand('$HOME/.vim/undodir')
if !isdirectory(undo_dir)
    call mkdir(undo_dir, "p")
endif
set undodir=undo_dir
