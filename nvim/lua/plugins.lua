vim.cmd('packadd vim-jetpack')
require('jetpack.packer').startup(function(use)
  use { 'tani/vim-jetpack', opt = 1 }
  use {
    'williamboman/mason.nvim',
    event = { 'VimEnter' },
    requires = {
      { 'neovim/nvim-lspconfig', event = { 'VimEnter' }, after = 'mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim', event = { 'VimEnter' }, after = 'mason.nvim' },
    },
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup_handlers({ function(server)
        require('lspconfig')[server].setup({})
      end })
      vim.cmd(':LspStart')
    end,
  }
  use {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter' },
    requires = {
      { 'hrsh7th/cmp-nvim-lsp', event = { 'InsertEnter' } },
      { 'hrsh7th/cmp-buffer', event = { 'InsertEnter' } },
      { 'hrsh7th/cmp-path', event = { 'InsertEnter' } },
      { 'hrsh7th/vim-vsnip', event = { 'InsertEnter' } },
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn['vsnip#anonymous'](args.body)
          end,
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path' },
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ['<C-l>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        experimental = {
          ghost_text = true,
        },
      })
    end,
  }
  use { 'vim-skk/eskk.vim',
    event = { 'VimEnter' },
    config = function()
      vim.g['eskk#directory'] = '~/.eskk'
      vim.g['eskk#dictionary'] = { path = '~/.eskk_jisyo', sorted = 1, encoding = 'utf-8' }
      vim.g['eskk#large_dictionary'] = { path = '~/.config/nvim/SKK-JISYO.L.txt', sorted = 1, encoding = 'euc-jp' }
    end,
  }
  use { 'wuelnerdotexe/vim-astro',
    ft = { 'astro' },
    config = function()
      vim.g.astro_typescript = 'enable'
    end,
  }
  use { 'evanleck/vim-svelte', ft = { 'svelte' } }
  use { 'nvim-lualine/lualine.nvim',
    event = { 'VimEnter' },
    config = function()
      local cellwidths = vim.fn.getcellwidths()
      table.insert(cellwidths, { 0xe0b0, 0xe0b3, 1 })
      vim.fn.setcellwidths(cellwidths)
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
    event = { 'VimEnter' },
    config = function()
      vim.opt.signcolumn = 'yes'
      local cellwidths = vim.fn.getcellwidths()
      table.insert(cellwidths, { 0x2500, 0x257f, 1 })
      vim.fn.setcellwidths(cellwidths)
      require('gitsigns').setup()
    end,
  }
  use { 'terrortylor/nvim-comment',
    event = { 'VimEnter' },
    config = function()
      require('nvim_comment').setup()
    end,
  }
  use { 'lukas-reineke/indent-blankline.nvim',
    event = { 'VimEnter' },
    config = function()
      require('indent_blankline').setup({
        space_char_blankline = ' ',
      })
      vim.g.indent_blankline_char = '|'
    end,
  }
  use { 'lukoshkin/trailing-whitespace', event = { 'VimEnter' } }
  use { 'kylechui/nvim-surround',
    event = { 'VimEnter' },
    config = function()
      require('nvim-surround').setup()
    end,
  }
  use { 'nvim-treesitter/nvim-treesitter',
    event = { 'VimEnter' },
    run = ':TSUpdate',
    config = function()
      require'nvim-treesitter.configs'.setup({
        highlight = { enable = true },
      })
    end,
  }
  use { 'catppuccin/nvim',
    event = { 'VimEnter' },
    as = 'catppuccin',
    config = function()
      require('catppuccin').setup({
        no_italic = true,
      })
      vim.cmd('colorscheme catppuccin-mocha')
    end,
  }
end)
