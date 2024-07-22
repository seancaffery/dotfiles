vim.keymap.set("n", "<leader>gt", function()
  vim.cmd("!go test -v .")
end)
