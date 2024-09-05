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
      vim.keymap.set('n', 'K',  vim.lsp.buf.hover)
      vim.keymap.set('n', 'gf', vim.lsp.buf.format)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
      vim.keymap.set('n', 'gtd', vim.lsp.buf.type_definition)
      vim.keymap.set('n', 'gn', vim.lsp.buf.rename)
      vim.keymap.set('n', 'ga', vim.lsp.buf.code_action)
      vim.keymap.set('n', 'ge', vim.diagnostic.open_float)
      vim.keymap.set('n', 'g]', vim.diagnostic.goto_next)
      vim.keymap.set('n', 'g[', vim.diagnostic.goto_prev)
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
        sections = {
          lualine_a = {{ 'mode', fmt = function(str) return str:sub(1,3) end }},
        },
      })
    end,
  }
  use { 'nvim-tree/nvim-tree.lua',
    event = { 'VimEnter' },
    requires = {
      { 'nvim-tree/nvim-web-devicons', event = { 'VimEnter' } },
    },
    config = function()
      require('nvim-web-devicons').setup({
        override = {
          ts = {
            icon = '',
            color = "#519aba",
            cterm_color = "74",
            name = "Ts",
          },
          cjs = {
            icon = '󰌞',
            color = "#f1e05a",
            cterm_color = "185",
            name = "Cjs",
          },
          js = {
            icon = '󰌞',
            color = "#f1e05a",
            cterm_color = "185",
            name = "Js",
          },
          mjs = {
            icon = '󰌞',
            color = "#f1e05a",
            cterm_color = "185",
            name = "Mjs",
          },
        },
      })
      require('nvim-tree').setup({
        disable_netrw = true,
        hijack_cursor = true,
        hijack_netrw = true,
        respect_buf_cwd = true,
        sync_root_with_cwd = true,
        filters = {
          git_ignored = false,
        },
      })
      vim.keymap.set('n', '<Leader>e', require('nvim-tree.api').tree.toggle)
    end,
  }
  use { 'lewis6991/gitsigns.nvim',
    event = { 'VimEnter' },
    config = function()
      vim.opt.signcolumn = 'yes'
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
    as = 'ibl',
    event = { 'VimEnter' },
    config = function()
      require('ibl').setup({
        indent = { char = '|' },
      })
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
  use { 'EdenEast/nightfox.nvim',
    event = { 'VimEnter' },
    config = function()
      vim.cmd('colorscheme nightfox')
    end,
  }
end)
