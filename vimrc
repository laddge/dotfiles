"                 o8o
"                 `"'
"    oooo    ooo oooo  ooo. .oo.  .oo.   oooo d8b  .ooooo.
"     `88.  .8'  `888  `888P"Y88bP"Y88b  `888""8P d88' `"Y8
"      `88..8'    888   888   888   888   888     888
".o.    `888'     888   888   888   888   888     888   .o8
"Y8P     `8'     o888o o888o o888o o888o d888b    `Y8bod8P'


" English
language C

" line number
set number
set cursorline

" encoding
set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8
scriptencoding utf-8
set ambiwidth=double

" indent
set smartindent

" search
set incsearch
set ignorecase
set smartcase
set hlsearch
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

" buffer
set hidden

" tabspace
set tabstop=4
set shiftwidth=4
set softtabstop=0
set expandtab
set smarttab
set shiftround

" complete
set completeopt+=menuone,menu,preview
set pumheight=12

" syntax highlight
syntax enable

" backspaceKey
set backspace=indent,eol,start

" visual complete in command mode
set wildmenu

" window size
set noequalalways

" show search number
set shortmess-=S

" enable mouse
set mouse=a

" colorscheme
set background=dark
color hybrid
set termguicolors

" leader key
let mapleader = "\<Space>"

" tabline
set showtabline=2
nnoremap <Leader>t :tabe<CR>

" save undo
if has('persistent_undo')
    if glob("~/.vim/undo") == ''
        call mkdir(expand('~/.vim/undo'))
    endif
    set undodir=~/.vim/undo
    set undofile
endif

" jetpack
runtime! configs/jetpack.vim
runtime! configs/plugins/*.vim

" local settings
if glob("~/.vimrc.local") != ''
    source ~/.vimrc.local
endif
