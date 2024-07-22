local lsp = require('lsp-zero').preset({})

-- adds ShowRubyDeps command to show dependencies in the quickfix list.
-- add the `all` argument to show indirect dependencies as well
local function add_ruby_deps_command(client, bufnr)
  vim.api.nvim_buf_create_user_command(bufnr, "ShowRubyDeps",
    function(opts)
      local params = vim.lsp.util.make_text_document_params()

      local showAll = opts.args == "all"

      client.request("rubyLsp/workspace/dependencies", params,
        function(error, result)
          if error then
            print("Error showing deps: " .. error)
            return
          end

          local qf_list = {}
          for _, item in ipairs(result) do
            if showAll or item.dependency then
              table.insert(qf_list, {
                text = string.format("%s (%s) - %s",
                  item.name,
                  item.version,
                  item.dependency),

                filename = item.path
              })
            end
          end

          vim.fn.setqflist(qf_list)
          vim.cmd('copen')
        end, bufnr)
    end, {
      nargs = "?",
      complete = function()
        return { "all" }
      end
    })
end


lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("n", "<leader>ih", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

require 'lspconfig'.syntax_tree.setup {}

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'bashls',
    'efm',
    'gopls',
    'lua_ls',
    'ruby_lsp',
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
      require 'lspconfig'.efm.setup {
        init_options = { documentFormatting = true },
        settings = {
          rootMarkers = { ".git/" },
          languages = {
            -- ruby = {
            --   { formatCommand = "rubyfmt", formatStdin = true }
            -- }
          }
        }
      }
    end,
    gopls = function()
      require 'lspconfig'.gopls.setup {
        settings = {
          gopls = {
            hints = {
              rangeVariableTypes = true,
              functionTypeParameters = true,
              compositeLiteralTypes = true,
              parameterNames = true,
            },
            usePlaceholders = true,
          },
        },
      }
    end,
    lua_ls = function()
      require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
    end,
    ruby_lsp = function()
      require('lspconfig').ruby_lsp.setup({
        on_attach = function(client, buffer)
          add_ruby_deps_command(client, buffer)
        end,
      })
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
        settings = {
          typescript = {
            format = { insertSpaceAfterOpeningAndBeforeClosingEmptyBraces = false },
            preferences = {
              quotePreference = "single",
            },
            inlayHints = {
              includeInlayParameterNameHints = 'all',
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
              importModuleSpecifierPreference = 'non-relative',
            } } },
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
    { name = 'luasnip' },
    { name = 'buffer',  keyword_length = 5 },
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format { async = false, id = args.data.client_id }
        end,
      })
    end
  end
})
