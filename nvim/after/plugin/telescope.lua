local builtin = require('telescope.builtin')
local utils = require("telescope.utils")
vim.keymap.set('n', '<leader>pf', function() builtin.find_files({ hidden = true }) end, {})
vim.keymap.set('n', '<leader>of', function() builtin.oldfiles({ only_cwd = true }) end, {})
vim.keymap.set('n', '<C-p>', function()
  -- fall back to file search if not in a git dir
  if not pcall(builtin.git_files) then
    builtin.find_files({ hidden = true })
  end
end, {})
vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})
vim.keymap.set('n', '<leader>pg', builtin.grep_string, {})
vim.keymap.set('n', '<leader>pd', function() builtin.live_grep({ cwd = utils.buffer_dir() }) end, {})
vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})

require('telescope').setup {
  defaults = {
    path_display = { truncate = 2 }
  }
}
require('telescope').load_extension('fzf')
