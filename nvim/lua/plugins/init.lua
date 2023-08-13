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
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'williamboman/mason.nvim',
        cmd = { 'Mason' },
        config = true
      },
      'williamboman/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim', tag = 'legacy', event = 'LspAttach', opts = {} },
      'folke/neodev.nvim',
    },
    config = function()
      require('plugins.configs.lsp')
    end
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
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
    'zbirenbaum/copilot-cmp',
    event = 'InsertEnter',
    dependencies = { 'zbirenbaum/copilot.lua' },
    config = function()
      vim.defer_fn(function()
        require('copilot').setup({
          suggestion = { enabled = false },
          panel = { enabled = false },
        })
        require('copilot_cmp').setup()
      end, 100)
    end,
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
      { '<C-p>',      '<cmd>Telescope find_files<cr>', 'Search files' },
      { '<leader>fw', '<cmd>Telescope live_grep<cr>',  'Search expression' },
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
        }
      }
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
    version = '*',
    config = function()
      require('mini.surround').setup()
      require('mini.pairs').setup()
      require('mini.comment').setup()
    end
  },
  { 'folke/trouble.nvim' },
  {
    'ray-x/lsp_signature.nvim',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'akinsho/bufferline.nvim',
    version = '*',
    opts = {},
  },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {},
    keys = {
      { 'gs', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end,              desc = 'Flash' },
      { 'gS', mode = { 'n', 'o', 'x' }, function() require('flash').treesitter() end,        desc = 'Flash Treesitter' },
      { 'r',  mode = 'o',               function() require('flash').remote() end,            desc = 'Remote Flash' },
      { 'R',  mode = { 'o', 'x' },      function() require('flash').treesitter_search() end, desc = 'Treesitter Search' },
      {
        '<c-s>',
        mode = { 'c' },
        function() require('flash').toggle() end,
        desc =
        'Toggle Flash Search'
      },
    },
  },
  { 'nvim-lualine/lualine.nvim',   opts = {} },
  { 'nvim-tree/nvim-web-devicons', lazy = true },
  'lukas-reineke/indent-blankline.nvim',
}, {
  ui = {
    border = 'rounded',
  }
})
