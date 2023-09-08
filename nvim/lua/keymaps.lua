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
map('n', '<leader>h', ':noh<cr>')
map('n', '<C-h>', '<C-w>h')
map('n', '<C-l>', '<C-w>l')
map('n', 'n', 'nzz')
map('n', 'N', 'Nzz')
map('n', '<C-o>', '<C-o>zz')
map('n', '<leader>x', ':bd<cr>')
-- lsp
map('n', '[d', vim.diagnostic.goto_prev)
map('n', ']d', vim.diagnostic.goto_next)
-- trouble
map('n', '<leader>tt', '<cmd>TroubleToggle<cr>')
-- bufferline
map('n', 'H', '<cmd>BufferLineCyclePrev<cr>')
map('n', 'L', '<cmd>BufferLineCycleNext<cr>')

-- visual
map('v', '<C-y>', '"*y')
