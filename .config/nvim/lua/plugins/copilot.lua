return {
  'zbirenbaum/copilot-cmp',
  event = 'InsertEnter',
  dependencies = { 'zbirenbaum/copilot.lua' },
  config = function()
    vim.defer_fn(function()
      require('copilot').setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
      require('copilot_cmp').setup()
    end, 100)
  end,
}
