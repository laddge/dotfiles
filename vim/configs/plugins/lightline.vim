set laststatus=2
set noshowmode

let g:lightline = {
    \ 'colorscheme': 'hathq',
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
    try
        let modestr = SkkGetModeStr()
    catch
        let modestr = ''
    endtry
    if modestr != ' '
        return modestr
    else
        return ''
    endif
endfunction
