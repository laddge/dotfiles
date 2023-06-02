-- line number
vim.opt.number = true
vim.opt.cursorline = true

-- hide mode
vim.opt.showmode = false

-- encoding
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.opt.ambiwidth = 'double'

-- indent
vim.opt.smartindent = true

-- search
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.api.nvim_set_keymap('n', '<Esc><Esc>', ':<C-u>set nohlsearch!<CR>', { noremap = true, silent = true })

-- buffer
vim.opt.hidden = true

-- tabspace
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 0
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.shiftround = true

-- backspaceKey
vim.opt.backspace = 'indent,eol,start'

-- visual complete in command mode
vim.opt.wildmenu = true

-- window size
vim.opt.equalalways = false

-- enable mouse
vim.opt.mouse = 'a'

-- leader key
vim.g.mapleader = ' '

-- tabline
vim.opt.showtabline = 2
vim.api.nvim_set_keymap('n', '<Leader>t', ':tabe<CR>', { noremap = true, silent = true })

-- undo
vim.opt.undofile = true

-- hide shortmess
vim.opt.shortmess = vim.o.shortmess .. 'I'

require('cellwidths')
require('plugins')
