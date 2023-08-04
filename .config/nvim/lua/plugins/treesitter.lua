return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = { 'windwp/nvim-ts-autotag' },
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = { 'typescript', 'tsx', 'javascript', 'rust', 'go', 'lua', 'json', 'vim', 'vimdoc' },
      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,
      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = false,
      -- List of parsers to ignore installing (for "all")
      ignore_install = {},
      highlight = {
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        -- disable = { "c", "rust" },

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
      autotag = {
        enable = true,
      },
    })
  end
}
