vim.cmd('packadd vim-jetpack')
require('jetpack.packer').startup(function(use)
  use { 'tani/vim-jetpack', opt = 1 }
  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'ray-x/cmp-treesitter'
  use { 'wuelnerdotexe/vim-astro',
    config = function()
      vim.g.astro_typescript = 'enable'
    end,
  }
  use { 'nvim-lualine/lualine.nvim',
    config = function()
      vim.fn.setcellwidths({
        { 0xe0b0, 0xe0b3, 1 },
      })
      require('lualine').setup({
        options = {
          icons_enabled = false,
        },
        sections = {
          lualine_a = {{ 'mode', fmt = function(str) return str:sub(1,3) end }},
        },
      })
    end,
  }
  use { 'lambdalisue/fern.vim',
    config = function()
      vim.api.nvim_set_keymap('n', '<leader>e', ':Fern . -reveal=% -drawer -toggle<CR>', { noremap = true, silent = true })
    end,
  }
  use 'lambdalisue/fern-hijack.vim'
  use { 'lewis6991/gitsigns.nvim',
    config = function()
      vim.opt.signcolumn = 'yes'
      vim.fn.setcellwidths({
        { 0x2500, 0x257f, 1 },
      })
      require('gitsigns').setup()
    end,
  }
  use { 'terrortylor/nvim-comment',
    config = function()
      require('nvim_comment').setup()
    end,
  }
  use { 'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('indent_blankline').setup({
        space_char_blankline = ' ',
      })
      vim.g.indent_blankline_char = '|'
    end,
  }
  use 'lukoshkin/trailing-whitespace'
  use { 'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup()
    end,
  }
  use { 'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require'nvim-treesitter.configs'.setup({
        highlight = { enable = true },
      })
    end,
  }
  use { 'catppuccin/nvim',
    as = 'catppuccin',
    config = function()
      require('catppuccin').setup({
        no_italic = true,
      })
      vim.cmd('colorscheme catppuccin-mocha')
    end,
  }
end)

require('lsp')
