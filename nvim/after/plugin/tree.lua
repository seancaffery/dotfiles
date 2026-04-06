-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

if not vim.g.vscode then
-- empty setup using defaults
require("nvim-tree").setup()
end
