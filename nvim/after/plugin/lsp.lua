local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'bashls',
    'efm',
    'gopls',
    'lua_ls',
    'ruby_ls',
    'rust_analyzer',
    'terraformls',
    'tsserver',
  },
  handlers = {
    lsp.default_setup,
    bashls = function()
      require('lspconfig').bashls.setup({})
    end,
    efm = function()
      require 'lspconfig'.efm.setup {}
    end,
    gopls = function()
      require 'lspconfig'.gopls.setup {}
    end,
    lua_ls = function()
      require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
    end,
    ruby_ls = function()
      require('lspconfig').ruby_ls.setup({})
    end,
    rust_analyzer = function()
      require('lspconfig').rust_analyzer.setup({})
    end,
    terraformls = function()
      require('lspconfig').terraformls.setup({})
    end,
    tsserver = function()
      local function organize_imports()
        local params = {
          command = "_typescript.organizeImports",
          arguments = { vim.api.nvim_buf_get_name(0) },
          title = ""
        }
        vim.lsp.buf.execute_command(params)
      end
      require('lspconfig').tsserver.setup {
        commands = {
          OrganizeImports = {
            organize_imports,
            description = "Organize Imports"
          },
        }
      }
    end,
  }
})

require('lsp-zero').extend_cmp()

local cmp = require('cmp')

cmp.setup({
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  },
})
