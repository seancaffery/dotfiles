vim.keymap.set("n", "<leader>/", function() require('Comment.api').toggle.linewise.current() end,
  { noremap = true, silent = true })
vim.keymap.set(
  'x',
  "<leader>/",
  '<Plug>(comment_toggle_linewise_visual)',
  { desc = 'Comment toggle linewise (visual)' }
)
