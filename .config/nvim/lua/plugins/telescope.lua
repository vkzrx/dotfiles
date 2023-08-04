return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    { '<C-p>',      '<cmd>Telescope find_files<cr>', 'Search files' },
    { '<leader>fw', '<cmd>Telescope live_grep<cr>',  'Search expression' },
  },
  config = function()
    require('telescope').setup({
      pickers = {
        find_files = {
          theme = 'dropdown',
        },
        live_grep = {
          theme = 'dropdown',
        },
      },
    })
  end
}
