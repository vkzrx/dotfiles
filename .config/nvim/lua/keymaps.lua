vim.g.mapleader = " "

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Insert mode
map("i", "jj", "<ESC>", opts)
map("i", "jk", "<ESC>", opts)

-- Normal mode
map("n", "<leader>w", ":w<CR>", opts)
map("n", "j", "gj", opts)
map("n", "k", "gk", opts)
map("n", "n", "nzz", opts)
map("n", "N", "Nzz", opts)
-- map("n", ",d", "bp/|bd #", opts)

-- Visual mode
map("v", "<C-y>", '"*y', opts)
