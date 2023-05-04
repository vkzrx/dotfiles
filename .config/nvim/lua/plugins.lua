require("lazy").setup({
  -- LSP
  {
    "zbirenbaum/copilot-cmp",
    dependencies = {
      {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
      },
    },
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = false,
          keymap = {
            accept = "<C-TAB>",
          },
        },
        panel = { enabled = true },
      })
      require("copilot_cmp").setup()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      {
        "williamboman/mason-lspconfig.nvim",
        config = function()
          require("mason").setup()
          require("mason-lspconfig").setup({
            ensure_installed = { "tsserver", "rust_analyzer", "lua_ls" }
          })
        end
      },
      { "folke/neodev.nvim", opts = {} },
      { "j-hui/fidget.nvim", opts = {} },
    }
  },
  -- {
  --   "jay-babu/mason-null-ls.nvim",
  --   event = { "BufReadPre", "BufNewFile" },
  --   dependencies = {
  --     "jose-elias-alvarez/null-ls.nvim",
  --   },
  --   opts = {},
  -- },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "onsails/lspkind.nvim",
    },
  },
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  {
    "glepnir/lspsaga.nvim",
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
    event = "BufRead",
    opts = {
      symbol_in_winbar = {
        enable = false,
      },
      lightbulb = {
        enable = false,
      },
    },
    keys = {
      -- { "K",          "<cmd>Lspsaga hover_doc<CR>" },
      { "gD",         "<cmd>Lspsaga lsp_finder<CR>" },
      { "gl",         "<cmd>Lspsaga peek_definition<CR>" },
      { "go",         "<cmd>Lspsaga outline<CR>" },
      { "<leader>rn", "<cmd>Lspsaga rename<CR>" },
      { "<leader>ca", "<cmd>Lspsaga code_action<CR>" },
      { "d]",         "<cmd>Lspsaga diagnostic_jump_next<CR>" },
      { "d[",         "<cmd>Lspsaga diagnostic_jump_prev<CR>" },
    }
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },
  { "simrat39/rust-tools.nvim" },
  {
    "saecki/crates.nvim",
    lazy = true,
    event = { "BufEnter Cargo.toml" },
    tag = "v0.3.0",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    config = function()
      local crates = require('crates');
      crates.setup({
        popup = {
          autofocus = true,
        },
        -- null_ls = {
        --   enabled = true,
        --   name = "crates.nvim",
        -- },
      })

      local map = vim.api.nvim_set_keymap
      local opts = { noremap = true }
      map("n", "<leader>cv", ":lua require('crates').show_versions_popup()<CR>", opts)
      map("n", "<leader>cf", ":lua require('crates').show_features_popup()<CR>", opts)
      map("n", "<leader>cd", ":lua require('crates').show_dependencies_popup()<CR>", opts)
      map("n", "<leader>cR", ":lua require('crates').open_repository()<CR>", opts)
      map("n", "<leader>cD", ":lua require('crates').open_documentation()<CR>", opts)
    end,
  },
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", 'gomod' },
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },
  { "wuelnerdotexe/vim-astro" },

  -- Editor
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.0",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          file_ignore_patterns = { "node_modules", "target", ".next" },
        },
        extensions = {
          fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
          }
        },
        pickers = {
          live_grep = {
            theme = "dropdown"
          },
          find_files = {
            theme = "dropdown",
            find_command = { "rg", "--files", "--hidden", "--glob=!.git/" }
          },
          git_files = {
            theme = "dropdown"
          },
          buffers = {
            theme = "dropdown"
          },
          lsp_references = {
            theme = "dropdown"
          },
          lsp_document_symbols = {
            theme = "dropdown"
          },
        }
      })
      telescope.load_extension('fzf')
    end,
    keys = {
      { "<C-p>",      "<cmd>Telescope find_files<CR>" },
      { "<leader>fw", "<cmd>Telescope live_grep<CR>" },
      { "<leader>b",  "<cmd>Telescope buffers<CR>" },
      { ",r",         "<cmd>Telescope lsp_references<CR>" },
      { "<leader>s",  "<cmd>Telescope lsp_document_symbols<CR>" },
      { "<leader>S",  "<cmd>Telescope lsp_workspace_symbols<CR>" },
      { "<leader>gb", "<cmd>Telescope git_bcommits<CR>" },
    }
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },
  {
    "tpope/vim-fugitive",
    lazy = false,
    keys = {
      { "<leader>gg", "<cmd>Git<CR>" },
    }
  },
  { "sindrets/diffview.nvim" },
  { "lewis6991/gitsigns.nvim", config = true },
  { "tpope/vim-rhubarb" },
  {
    "ThePrimeagen/harpoon",
    keys = {
      { "<leader>a", ":lua require('harpoon.mark').add_file()<CR>",        silent = true },
      { "<leader>h", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", silent = true },
      { "<leader>j", ":lua require('harpoon.ui').nav_file(1)<CR>",         silent = true },
      { "<leader>k", ":lua require('harpoon.ui').nav_file(2)<CR>",         silent = true },
      { "<leader>l", ":lua require('harpoon.ui').nav_file(3)<CR>",         silent = true },
    }
  },
  {
    "ggandor/leap.nvim",
    dependencies = { "tpope/vim-repeat" },
    config = function()
      require("leap").add_default_mappings()
    end
  },
  { "kylechui/nvim-surround", config = true },
  { "numToStr/Comment.nvim",  config = true },
  { "windwp/nvim-ts-autotag" },
  { "windwp/nvim-autopairs",  config = true },
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        autotag = {
          enable = true
        },
        ensure_installed = { "rust", "typescript", "tsx", "lua", "json" },
        highlight = {
          enable = true,
          -- disable = { "c", "rust" },
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
        },
        textobjects = {
          select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              -- You can optionally set descriptions to the mappings (used in the desc parameter of
              -- nvim_buf_set_keymap) which plugins like which-key display
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            },
            -- You can choose the select mode (default is charwise 'v')
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            selection_modes = {
              ['@parameter.outer'] = 'v', -- charwise
              ['@function.outer'] = 'V',  -- linewise
              ['@class.outer'] = '<c-v>', -- blockwise
            },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * selection_mode: eg 'v'
            -- and should return true of false
            include_surrounding_whitespace = true,
          },
        }
      })
    end,
    build = ":TSUpdate",
  },
  { "nvim-treesitter/nvim-treesitter-textobjects" },
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf"
  },
  -- UI
  {
    "goolord/alpha-nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("alpha").setup(require("alpha.themes.startify").config)
    end
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

      require("neo-tree").setup({
        close_if_last_window = false,
        window = {
          width = 30,
          mappings = {
            ["z"] = "none"
          },
        },
        filesystem = {
          follow_current_file = true,
        },
        buffers = {
          follow_current_file = true,
        },
      })
    end,
    keys = {
      { "<C-n>", ":Neotree toggle<CR>", silent = true }
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {},
  },
  { "lukas-reineke/indent-blankline.nvim" },
  {
    "catppuccin/nvim",
    priority = 1000,
    config = function()
      local config = require('colorschemes.catppuccin')
      require("catppuccin").setup(config.config)
      vim.cmd("colorscheme catppuccin")
    end
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    config = function()
      -- vim.cmd("colorscheme tokyonight-night")
    end
  },
  {
    "Shatur/neovim-ayu",
    priority = 1000,
    config = function()
      -- vim.cmd("colorscheme ayu")
    end
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    -- priority = 1000,
    -- config = function()
    --   require("kanagawa").setup({
    --     colors = {
    --       theme = {
    --         all = {
    --           ui = {
    --             bg_gutter = "none"
    --           }
    --         }
    --       }
    --     }
    --   })
    --   vim.cmd("colorscheme kanagawa")
    -- end,
  }
})
