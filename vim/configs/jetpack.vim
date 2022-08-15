call jetpack#begin('~/.cache/vim-jetpack')

Jetpack 'itchyny/lightline.vim', {'opt': 1}
Jetpack 'lambdalisue/fern.vim', {'on': 'Fern'}
Jetpack 'lambdalisue/fern-hijack.vim'
Jetpack 'Yggdroot/indentLine'
Jetpack 'luochen1990/rainbow', {'opt': 1}
Jetpack 'tomtom/tcomment_vim', {'opt': 1}
Jetpack 'bronson/vim-trailing-whitespace', {'opt': 1}
Jetpack 'kato-k/vim-colorscheme-settings', {'on': ['SwitchBackGround', 'SwitchColorScheme']}
Jetpack 'prabirshrestha/async.vim', {'opt': 1}
Jetpack 'prabirshrestha/vim-lsp', {'opt': 1}
Jetpack 'mattn/vim-lsp-settings', {'opt': 1}
Jetpack 'prabirshrestha/asyncomplete.vim', {'opt': 1}
Jetpack 'prabirshrestha/asyncomplete-lsp.vim', {'opt': 1}
Jetpack 'airblade/vim-gitgutter', {'opt': 1}
Jetpack 'psf/black', {'for': 'python', 'opt': 1}
Jetpack 'laddge/skk.vim', {'opt': 1}
Jetpack 'laddge/vim-hathq', {'opt': 1}
Jetpack 'morhetz/gruvbox', {'opt': 1}

call jetpack#end()

function! s:vimenter()
    packadd lightline.vim
    packadd vim-hathq
    packadd gruvbox

    color gruvbox
    call lightline#enable()
    call timer_start(50, function('s:lazyload'))
endfunction

function! s:lazyload(t)
    packadd rainbow
    packadd tcomment_vim
    packadd vim-trailing-whitespace
    packadd async.vim
    packadd vim-lsp
    packadd vim-lsp-settings
    packadd asyncomplete.vim
    packadd asyncomplete-lsp.vim
    packadd vim-gitgutter
    packadd skk.vim

    call lsp#enable()
endfunction

autocmd VimEnter * call s:vimenter()
