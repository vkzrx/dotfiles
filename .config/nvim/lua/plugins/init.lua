require('lazy').setup({
  require('plugins.colorscheme'),
  { 'neovim/nvim-lspconfig' },
  require('plugins.cmp'),
  require('plugins.copilot'),
  require('plugins.treesitter'),
  require('plugins.telescope'),
  require('plugins.lazygit'),
  { 'lewis6991/gitsigns.nvim', opts = {} },
  require('plugins.mini'),
  { 'folke/trouble.nvim' },
  require('plugins.flash'),
  require('plugins.fidget'),
  {
    'ray-x/lsp_signature.nvim',
    event = 'VeryLazy',
    opts = {},
  },
  -- require('plugins.bqf'),
  require('plugins.bufferline'),
  require('plugins.neo-tree'),
  { 'nvim-lualine/lualine.nvim',   opts = {} },
  { 'nvim-tree/nvim-web-devicons', lazy = true },
  'lukas-reineke/indent-blankline.nvim',
})

require('plugins.lspconfig')
