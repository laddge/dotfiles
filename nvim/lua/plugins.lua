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
  use { 'vim-skk/eskk.vim',
    config = function()
      vim.g['eskk#directory'] = '~/.eskk'
      vim.g['eskk#dictionary'] = { path = '~/.eskk_jisyo', sorted = 1, encoding = 'utf-8' }
      vim.g['eskk#large_dictionary'] = { path = '~/.config/nvim/SKK-JISYO.L.txt', sorted = 1, encoding = 'euc-jp' }
    end,
  }
  use { 'wuelnerdotexe/vim-astro',
    config = function()
      vim.g.astro_typescript = 'enable'
    end,
  }
  use 'evanleck/vim-svelte'
  use { 'nvim-lualine/lualine.nvim',
    config = function()
      vim.fn.setcellwidths({
        { 0xe0b0, 0xe0b3, 1 },
      })
      local function skkmode()
        if vim.call('eskk#is_enabled') == 1 then
          return vim.g['eskk#statusline_mode_strings'][vim.call('eskk#get_mode')]
        else
          return ''
        end
      end
      vim.api.nvim_create_autocmd('user', {
        pattern = 'eskk-initialize-post',
        callback = function()
          require('lualine').setup({
            sections = {
              lualine_c = { 'filename', skkmode },
            },
          })
        end
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
