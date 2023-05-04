vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.smartindent = true
vim.opt.shiftround = true

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.cmd(
  "autocmd FileType nix,typescript,typescriptreact,javascript,svelte,astro,vue,html,css,lua,json,md,svg setlocal shiftwidth=2 softtabstop=2 expandtab")
vim.cmd("autocmd FileType rust,python,solidity,sway,toml setlocal shiftwidth=4 softtabstop=4 expandtab")
-- vim.cmd("autocmd FileType go setlocal shiftwidth=8 softtabstop=8 expandtab")

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.rs", "*.tsx", "*.ts", "*.js", "*.cjs", "*.lua", "*.json", "*.toml" },
  callback = function()
    vim.lsp.buf.format()
  end
})

local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    require('go.format').goimport()
  end,
  group = format_sync_grp,
})
