local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', function() builtin.find_files({ hidden = true }) end, {})
vim.keymap.set('n', '<leader>of', function() builtin.oldfiles({ only_cwd = true }) end, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})
vim.keymap.set('n', '<leader>pg', builtin.grep_string, {})
vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})

require('telescope').setup {
  defaults = {
    path_display = { truncate = 2 }
  }
}
require('telescope').load_extension('fzf')
