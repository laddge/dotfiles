set laststatus=2
set noshowmode

let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
        \     'left': [['mode', 'paste'], ['readonly', 'filename', 'modified'], ['skk']],
    \ },
    \ 'component': {
    \     'mode': '%{g:lightline#mode()[0]}'
    \ },
    \ 'component_function': {
    \     'skk': 'SkkStatus'
    \ }
    \ }

function! SkkStatus()
    let modestr = SkkGetModeStr()
    if modestr != ' '
        return modestr
    else
        return ''
    endif
endfunction
