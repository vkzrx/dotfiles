-- This should be loaded before plugins
vim.g.mapleader = " "

local opt = vim.opt

opt.hidden = true         -- Enable modified buffers in background
opt.number = true         -- Show line numbers
opt.relativenumber = true -- Show relative line numbers
opt.splitright = true     -- Open new windows to the right
opt.splitbelow = true     -- Open new windows to the bottom
opt.scrolloff = 8         -- Lines of context
opt.signcolumn = "yes"    -- Always show the signcolumn, otherwise it would shift the text each time
opt.ignorecase = true     -- Ignore case when searching
opt.smartcase = true      -- Ignore case when searching lowercase, match case when searching uppercase
opt.linebreak = true      -- Break lines at word boundaries
opt.termguicolors = true  -- Enable 24-bit RGB colors
opt.expandtab = true      -- Use spaces instead of tabs
opt.shiftwidth = 2        -- Number of spaces to use for autoindent
opt.tabstop = 2           -- Number of spaces that a <Tab> in the file counts for
opt.smartindent = true    -- Insert indents automatically
opt.wrap = false          -- Disable line wrap
