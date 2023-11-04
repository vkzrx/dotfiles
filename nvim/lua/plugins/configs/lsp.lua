return {
  'VonHeikemen/lsp-zero.nvim',
  dependencies = {
    'neovim/nvim-lspconfig',
    { 'j-hui/fidget.nvim', tag = 'legacy', event = 'LspAttach', opts = {} },
  },
  config = function()
    local lsp_zero = require('lsp-zero')

    lsp_zero.set_preferences({
      call_servers = 'global',
    })

    lsp_zero.configure('lua_ls', {
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
          },
          diagnostics = {
            globals = { 'vim' },
          },
          telemetry = {
            enable = false,
          },
        },
      },
    })

    lsp_zero.setup_servers({
      'lua_ls',
      'gopls',
      'tsserver',
      'tailwindcss',
      'clangd',
    })

    lsp_zero.on_attach(function(client, bufnr)
      client.server_capabilities.semanticTokensProvider = nil

      lsp_zero.default_keymaps({ buffer = bufnr })

      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' })
      vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help,
        { border = 'single' })
    end)

    lsp_zero.format_on_save({
      format_opts = {
        async = false,
        timeout_ms = 10000,
      },
      servers = {
        ['tsserver'] = { 'javascript', 'typescript' },
        ['rust_analyzer'] = { 'rust' },
      }
    })

    lsp_zero.setup()

    require('rust-tools').setup()
  end,
}

