local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- format on save
autocmd('BufWritePre', {
  callback = function()
    vim.lsp.buf.format { async = false }
  end
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
