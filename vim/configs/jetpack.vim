filetype off

call jetpack#begin('~/.cache/vim-jetpack')

Jetpack 'itchyny/lightline.vim'
Jetpack 'lambdalisue/fern.vim', {'on': 'Fern'}
Jetpack 'lambdalisue/fern-hijack.vim'
Jetpack 'Yggdroot/indentLine'
Jetpack 'luochen1990/rainbow'
Jetpack 'tomtom/tcomment_vim'
Jetpack 'bronson/vim-trailing-whitespace'
Jetpack 'kato-k/vim-colorscheme-settings', {'on': ['SwitchBackGround', 'SwitchColorScheme']}
Jetpack 'prabirshrestha/async.vim'
Jetpack 'prabirshrestha/vim-lsp'
Jetpack 'mattn/vim-lsp-settings'
Jetpack 'prabirshrestha/asyncomplete.vim'
Jetpack 'prabirshrestha/asyncomplete-lsp.vim'
Jetpack 'airblade/vim-gitgutter'
Jetpack 'psf/black', {'for': 'python'}
Jetpack 'laddge/skk.vim'
Jetpack 'laddge/vim-hathq'
Jetpack 'morhetz/gruvbox'
Jetpack 'wuelnerdotexe/vim-astro'

call jetpack#end()

filetype plugin on
color gruvbox
