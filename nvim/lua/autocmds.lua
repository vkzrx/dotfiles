local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

autocmd('BufWritePre', {
  pattern = "*.go",
  callback = function()
    require('go.format').goimport()
  end,
  group = vim.api.nvim_create_augroup("GoFormat", {})
})

-- Remove whitespace on save
autocmd('BufWritePre', {
  pattern = '',
  command = ':%s/\\s\\+$//e'
})

-- Don't auto comment new lines
autocmd('BufEnter', {
  pattern = '',
  command = 'set fo-=c fo-=r fo-=o'
})

-- Set indentation to 2 spaces
augroup('setIndent', { clear = true })
autocmd('Filetype', {
  group = 'setIndent',
  pattern = { 'typescript', 'javascript', 'html', 'css', 'scss', 'json', 'yaml', 'lua' },
  command = 'setlocal shiftwidth=2 tabstop=2'
})
autocmd('Filetype', {
  group = 'setIndent',
  pattern = { 'go' },
  command = 'setlocal shiftwidth=4 tabstop=4'
})
