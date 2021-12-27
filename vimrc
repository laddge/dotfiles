"                 o8o
"                 `"'
"    oooo    ooo oooo  ooo. .oo.  .oo.   oooo d8b  .ooooo.
"     `88.  .8'  `888  `888P"Y88bP"Y88b  `888""8P d88' `"Y8
"      `88..8'    888   888   888   888   888     888
".o.    `888'     888   888   888   888   888     888   .o8
"Y8P     `8'     o888o o888o o888o o888o d888b    `Y8bod8P'

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.cache/vundle')

Plugin 'VundleVim/Vundle.vim'

let pluginlist=$HOME.'/.vim/plugins.list'
for line in readfile(pluginlist)
    Plugin line
endfor

call vundle#end()
filetype plugin indent on

" Ctrl-@でペーストモード
set pastetoggle=<C-@>

set encoding=utf-8
scriptencoding utf-8

" English
language C

"行番号・行のライン
set number
set cursorline

"文字コード
set fileencoding=utf-8
scriptencoding utf-8
set ambiwidth=double

"インデント
set smartindent

"サーチ
set incsearch
set ignorecase
set smartcase
set hlsearch
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

"バッファ
set hidden

"タブの扱い
set tabstop=4
set shiftwidth=4
set softtabstop=0
set expandtab
set smarttab
set shiftround


"for complete
set completeopt+=menuone,menu,preview
set pumheight=12

"Use syntax highlight
syntax enable

"for terminalMod
set splitbelow

"for backspaceKey
set backspace=indent,eol,start

"for command mode
set wildmenu

"window
set noequalalways

"検索件数の表示
set shortmess-=S

"Undoポイントの設置
inoremap <silent><C-w> <C-g>u<C-w>
inoremap <silent><C-u> <C-g>u<C-u>
inoremap <silent><C-m> <C-g>u<C-m>
inoremap <silent><C-j> <C-g>u<C-j>

" Enable mouse
set mouse=a

" jk
nnoremap j gj
nnoremap k gk

" colorscheme
set background=dark
color hybrid
set termguicolors

"leader key
let mapleader = "\<Space>"

"myKeyMapping
noremap <silent><Leader>e :NERDTreeToggle<CR>

"quickrun settings
let g:quickrun_config = {
    \  'python': {
    \    'command': 'python3'
    \  },
    \}

"for tabpage
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    if title == ''
        let title = '[No Name]'
    else
        let title = ' ' . title . ' '
    endif
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= ' ' . no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    <leader> [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]t :tablast <bar> tabnew<CR>
" <Leader>t 新しいタブを一番右に作る
map <silent> [Tag]w :tabclose<CR>
" <Leader>x タブを閉じる
map <silent> [Tag]l :tabnext<CR>
" <Leader>n 次のタブ
map <silent> [Tag]h :tabprevious<CR>
" <Leader>p 前のタブ

" statusline
set laststatus=2
set noshowmode
function! SetStatusLine()
  let c = 2
  let mode_name = 'N'
  if mode() =~ 'i'
    let c = 1
    let mode_name = 'I'
  elseif mode() =~ 'n'
    let c = 2
    let mode_name = 'N'
  elseif mode() =~ 'R'
    let c = 3
    let mode_name = 'R'
  elseif mode() =~ 'V'
    let c = 4
    let mode_name = 'V'
  endif
  return '%' . c . '* ' . mode_name . ' %* %<%F%=%m%r %18([%{toupper(&ft)}][%l/%L][%{b:charCount}]%)'
endfunction

" hilights

hi User1 term=bold cterm=bold ctermfg=234 guifg=#1d1f21 ctermbg=193 guibg=#d7ffaf
hi User2 term=bold cterm=bold ctermfg=234 guifg=#1d1f21 ctermbg=110 guibg=#81a2be
hi User3 term=bold cterm=bold ctermfg=234 guifg=#1d1f21 ctermbg=173 guibg=#de935f
hi User4 term=bold cterm=bold ctermfg=234 guifg=#1d1f21 ctermbg=139 guibg=#b294bb
hi StatusLine term=NONE cterm=NONE ctermfg=250 ctermbg=237 gui=NONE guifg=#c5c8c6 guibg=#373b41
hi TabLineFill term=NONE cterm=NONE ctermfg=250 ctermbg=237 gui=NONE guifg=#c5c8c6 guibg=#373b41

set statusline=%!SetStatusLine()

" for rainbow
let g:rainbow_active = 1

" add my template
let g:sonictemplate_vim_template_dir = [
    \ '~/.vim/template'
    \]

" lsp settings
function Fix()
    if &filetype == 'python'
        if executable('black')
            if exists("g:load_black")
                Black
                return 0
            endif
        endif
    endif
    LspDocumentFormat
endfunction
set signcolumn=yes
let g:lsp_diagnostics_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_signs_error = {'text': 'E>'}
let g:lsp_diagnostics_signs_warning = {'text': 'W>'}
let g:lsp_diagnostics_signs_hint = {'text': 'I>'}
noremap <silent><Leader>f :call Fix()<CR>

" Translate settings
let g:translate_source = "en"
let g:translate_target = "ja"
nmap gr <Plug>(Translate)
vmap t <Plug>(VTranslate)

" black settings
let g:black_virtualenv = '~/.cache/black_venv'

" SKK settings
let skk_large_jisyo = '~/.vim/SKK-JISYO.L'
let skk_auto_save_jisyo = 1

" save undo
if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
endif

" local settings
if glob("~/.vimrc.local") != ''
    source ~/.vimrc.local
endif
