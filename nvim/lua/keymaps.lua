local map = function(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Disable arrow keys
map('', '<up>', '<nop>')
map('', '<down>', '<nop>')
map('', '<left>', '<nop>')
map('', '<right>', '<nop>')

-- insert
map('i', 'jk', '<esc>')
map('i', 'jj', '<esc>')

-- normal
map('n', 'j', 'gj')
map('n', 'k', 'gk')
map('n', '<leader>w', ':w<cr>')
map('n', '<leader>q', ':q<cr>')
map('n', '<leader>h', ':noh<cr>', { silent = false })
map('n', '<C-h>', '<C-w>h')
map('n', '<C-l>', '<C-w>l')
map('n', 'n', 'nzz')
map('n', 'N', 'Nzz')
map('n', '<C-o>', '<C-o>zz')
map('n', '<leader>x', ':bd<cr>')
-- lsp
map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>')
map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>')
-- trouble
map('n', '<leader>tt', '<cmd>TroubleToggle<cr>')
-- bufferline
map('n', 'L', '<cmd>BufferLineCycleNext<cr>')
map('n', 'H', '<cmd>BufferLineCyclePrev<cr>')
-- harpoon
map('n', '<leader>a', ':lua require("harpoon.mark").add_file()<cr>', { silent = false })
map('n', '<leader>A', ':lua require("harpoon.ui").toggle_quick_menu()<cr>')
map('n', '<leader>J', '<cmd>lua require("harpoon.ui").nav_prev()<cr>')
map('n', '<leader>K', '<cmd>lua require("harpoon.ui").nav_next()<cr>')

-- visual
map('v', '<C-y>', '"*y')
