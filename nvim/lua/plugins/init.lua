require('lazy').setup({
  {
    'catppuccin/nvim',
    lazy = false,
    priority = 1000,
    config = function()
      local options = require('plugins.configs.colorscheme')
      require('catppuccin').setup(options)
      vim.cmd([[colorscheme catppuccin]])
    end
  },
  {
    'rebelot/kanagawa.nvim',
    lazy = true,
    opts = {
      background = {
        dark = "wave",
        light = "lotus",
      }
    },
    -- config = function()
    --   vim.cmd([[colorscheme kanagawa]])
    -- end
  },
  require('plugins.configs.lsp'),
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = 'make install_jsregexp',
        dependencies = {
          'rafamadriz/friendly-snippets'
        },
      },
      'saadparwaiz1/cmp_luasnip',
      {
        'onsails/lspkind.nvim',
        config = function()
          require('lspkind').init({
            symbol_map = {
              Copilot = '',
            },
          })
        end
      },
    },
    opts = {},
    config = function()
      require('plugins.configs.cmp')
    end
  },
  {
    -- 'zbirenbaum/copilot-cmp',
    -- event = 'InsertEnter',
    -- dependencies = { 'zbirenbaum/copilot.lua' },
    -- config = function()
    --   vim.defer_fn(function()
    --     require('copilot').setup({
    --       suggestion = { enabled = false },
    --       panel = { enabled = false },
    --     })
    --     require('copilot_cmp').setup({
    --       fix_pairs = true,
    --     })
    --   end, 100)
    -- end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'windwp/nvim-ts-autotag' },
    config = function()
      local options = require('plugins.configs.treesitter')
      require('nvim-treesitter.configs').setup(options)
    end
  },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<C-p>',      '<cmd>Telescope find_files<cr>',                'Search files' },
      { '<leader>fw', '<cmd>Telescope live_grep<cr>',                 'Search expression' },
      { '<leader>b',  '<cmd>Telescope buffers<cr>',                   'Find buffers' },
      { '<leader>fb', '<cmd>Telescope current_buffer_fuzzy_find<cr>', 'Fuzzy find current buffer' },
    },
    opts = {
      pickers = {
        find_files = {
          theme = 'dropdown',
        },
        live_grep = {
          theme = 'dropdown',
        },
      },
    },
  },
  {
    'simrat39/symbols-outline.nvim',
    opts = {},
    keys = {
      { '<leader>ts', '<cmd>SymbolsOutline<cr>', 'Toggle symbols tree' },
    },
  },
  {
    'ray-x/go.nvim',
    dependencies = {
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('go').setup()
    end,
    event = { 'CmdlineEnter' },
    ft = { 'go', 'gomod' },
  },
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      local bufferline = require('bufferline')
      bufferline.setup({
        options = {
          style_preset = bufferline.style_preset.no_italic,
        },
      })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { '<C-n>', '<cmd>Neotree toggle position=float<cr>', 'Toggle file browser' },
    },
    opts = {
      popup_border_style = 'rounded',
      filesystem = {
        window = {
          popup = {
            position = { col = "100%", row = "2" },
            size = function(state)
              local root_name = vim.fn.fnamemodify(state.path, ":~")
              local root_len = string.len(root_name) + 4
              return {
                width = math.max(root_len, 50),
                height = vim.o.lines - 6
              }
            end
          },
        },
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true,
        },
        buffers = {
          follow_current_file = {
            enabled = true,
            leave_dirs_open = true,
          },
        },
      },
    },
  },
  {
    'kdheepak/lazygit.nvim',
    keys = {
      { '<leader>gg', '<cmd>LazyGit<cr>', 'Toggle LazyGit' },
    },
    config = function()
      require('telescope').load_extension('lazygit')
    end
  },
  { 'lewis6991/gitsigns.nvim', opts = {} },
  {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      require('mini.starter').setup()
      require('mini.surround').setup()
      require('mini.pairs').setup()
      require('mini.bracketed').setup()
      require('mini.comment').setup()
      require('mini.sessions').setup()
    end
  },
  { 'folke/trouble.nvim' },
  { 'simrat39/rust-tools.nvim' },
  {
    'ray-x/lsp_signature.nvim',
    event = 'VeryLazy',
    opts = {},
  },
  { 'nvim-lualine/lualine.nvim',   opts = {} },
  { 'nvim-tree/nvim-web-devicons', lazy = true },
  'lukas-reineke/indent-blankline.nvim',
}, {
  ui = {
    border = 'rounded',
  }
})
