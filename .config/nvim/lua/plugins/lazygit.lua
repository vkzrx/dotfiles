return {
  'kdheepak/lazygit.nvim',
  keys = {
    { '<leader>gg', '<cmd>LazyGit<cr>', 'Toggle LazyGit' },
  },
  config = function()
    require('telescope').load_extension('lazygit')
  end
}
