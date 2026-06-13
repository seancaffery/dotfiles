require("tree-sitter-manager").setup({
  -- Default Options
  parser_dir = vim.fn.stdpath("data") .. "/site/parser",
  query_dir = vim.fn.stdpath("data") .. "/site/queries",
  assume_installed = {}, -- ban languages
  ensure_installed = { "vimdoc", "javascript", "typescript", "c", "lua", "rust", "go", "markdown" },
  border = "rounded",    -- border style for the TUI window
  auto_install = true,   -- auto-install when a new filetype is encountered
  noauto_install = {},   -- ban from auto_install
  highlight = true,      -- enable treesitter highlighting (use list to whitelist)
  nohighlight = {},      -- ban from highlight
  languages = {},        -- custom languages
  nerdfont = true,       -- use Nerd Font icons in the manager UI
})
