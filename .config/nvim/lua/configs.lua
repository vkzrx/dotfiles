vim.cmd("set completeopt=menu,menuone,noselect")

local cmp = require("cmp")

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<TAB>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "copilot" },
    { name = "nvim_lsp" },
    { name = "nvim_lsp_signature_help" },
    { name = "luasnip" },
    { name = "path" },
  }, {
    { name = "buffer" },
    { name = "crates" },
  }),
  formatting = {
    format = require("lspkind").cmp_format({
      maxwidth = 50
    }),
  },
  window = {
    completion = cmp.config.window.bordered({
      col_offset = -3,
      side_padding = 0,
      winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
    }),
    documentation = cmp.config.window.bordered({
      winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
    }),
  },
})

cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- local opts = { noremap = true, silent = true }
-- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
-- vim.keymap.set('n', 'd[', vim.diagnostic.goto_prev, opts)
-- vim.keymap.set('n', 'd]', vim.diagnostic.goto_next, opts)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)


local function show_documentation()
  if vim.fn.expand('%:t') == 'Cargo.toml' and require('crates').popup_available() then
    require('crates').show_popup()
  else
    vim.lsp.buf.hover()
  end
end

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { border = 'rounded' }
)

local on_attach = function(client, bufnr)
  -- https://www.reddit.com/r/neovim/comments/12gvms4/this_is_why_your_higlights_look_different_in_90
  client.server_capabilities.semanticTokensProvider = nil

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', show_documentation, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  -- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  -- vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
end

local servers = { "jsonls" }
local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

if not configs.solidity then
  configs.solidity = {
    default_config = {
      cmd = { 'nomicfoundation-solidity-language-server', '--stdio' },
      filetypes = { 'solidity' },
      root_dir = lspconfig.util.find_git_ancestor,
      single_file_support = true,
    },
  }
end

for _, v in ipairs(servers) do
  lspconfig[v].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

lspconfig['rnix'].setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

require("rust-tools").setup({
  server = {
    capabilities = capabilities,
    on_attach = on_attach,
  }
})

lspconfig['tsserver'].setup({
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = lspconfig.util.root_pattern("package.json")
})

lspconfig['solidity'].setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- lspconfig["denols"].setup({
--   on_attach = on_attach,
--   capabilities = capabilities,
--   root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
-- })

lspconfig['volar'].setup({})

-- lspconfig["volar"].setup({
--   init_options = {
--     typescript = {
--       -- tsdk = '/path/to/.npm/lib/node_modules/typescript/lib'
--       -- Alternative location if installed as root:
--       tsdk = '/usr/local/lib/node_modules/typescript/lib'
--     }
--   },
--   on_attach = on_attach,
--   capabilities = capabilities,
--   root_dir = lspconfig.util.root_pattern("nuxt.config.ts"),
--   filetypes = { 'vue' }
-- })

lspconfig["svelte"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig["astro"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig["tailwindcss"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = lspconfig.util.root_pattern("tailwind.config.cjs", "tailwind.config.js", ".nuxt/tailwind.config.cjs"),
})

lspconfig["html"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig["cssls"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig["gopls"].setup({
  gopls_cmd = { '~/go/bin/gopls' },
  on_attach = function(_, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    buf_set_option('tabstop', 4)
    buf_set_option('softtabstop', 4)
    buf_set_option('shiftwidth', 4)
    buf_set_option('expandtab', false)
  end,
  capabilities = capabilities,
  fillstruct = 'gopls',
  dap_debug = true,
  dap_debug_gui = true,
})

lspconfig["pylsp"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig["lua_ls"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { "vim" },
      },
      -- workspace = {
      --   -- Make the server aware of Neovim runtime files
      --   library = vim.api.nvim_get_runtime_file("", true),
      -- },
    },
  },
})
