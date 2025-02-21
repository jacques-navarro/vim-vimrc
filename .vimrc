set number
set wrap
syntax on
        
" Use space characters instead of tabs.
set expandtab
set softtabstop=4
set shiftwidth=4
set expandtab
	

" Set tab width to 4 columns.
set tabstop=4

" Ignore capital letters during search.
set ignorecase

" Show partial command you type in the last line of the screen.
set showcmd

" Wrap text
set textwidth=80
set wrapmargin=0
set formatoptions+=t
set linebreak

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

Plug 'tpope/vim-fugitive'

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
let g:airline_theme='papercolor'
let g:airline_section_z = "%3p%% %l:%c"
let g:airline_section_c = "%F %M"

" Required for Language Server Protocol (LSP) plugin for Vim.
packadd lsp

"Register Clangd language server
call LspAddServer([#{
	\    name: 'clangd',
	\    filetype: ['c', 'cpp'],
	\    path: '/usr/bin/clangd',
	\    args: ['--background-index']
	\  }])


" LSP options
call LspOptionsSet(#{
        \   aleSupport: v:false,
        \   autoComplete: v:true,
        \   autoHighlight: v:false,
        \   autoHighlightDiags: v:true,
        \   autoPopulateDiags: v:false,
        \   completionMatcher: 'case',
        \   completionMatcherValue: 1,
        \   diagSignErrorText: 'E>',
        \   diagSignHintText: 'H>',
        \   diagSignInfoText: 'I>',
        \   diagSignWarningText: 'W>',
        \   echoSignature: v:false,
        \   hideDisabledCodeActions: v:false,
        \   highlightDiagInline: v:true,
        \   hoverInPreview: v:false,
        \   ignoreMissingServer: v:false,
        \   keepFocusInDiags: v:true,
        \   keepFocusInReferences: v:true,
        \   completionTextEdit: v:true,
        \   diagVirtualTextAlign: 'above',
        \   diagVirtualTextWrap: 'default',
        \   noNewlineInCompletion: v:false,
        \   omniComplete: v:null,
        \   outlineOnRight: v:false,
        \   outlineWinSize: 20,
        \   semanticHighlight: v:true,
        \   showDiagInBalloon: v:true,
        \   showDiagInPopup: v:true,
        \   showDiagOnStatusLine: v:false,
        \   showDiagWithSign: v:true,
        \   showDiagWithVirtualText: v:false,
        \   showInlayHints: v:false,
        \   showSignature: v:true,
        \   snippetSupport: v:false,
        \   ultisnipsSupport: v:false,
        \   useBufferCompletion: v:false,
        \   usePopupInCodeAction: v:false,
        \   useQuickfixForLocations: v:false,
        \   vsnipSupport: v:false,
        \   bufferCompletionTimeout: 100,
        \   customCompletionKinds: v:false,
        \   completionKinds: {},
        \   filterCompletionDuplicates: v:false,
	\ })
