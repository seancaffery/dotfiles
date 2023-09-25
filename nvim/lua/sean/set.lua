vim.opt.guicursor      = ""

vim.opt.nu             = true
vim.opt.relativenumber = true

vim.opt.tabstop        = 2
vim.opt.softtabstop    = 2
vim.opt.shiftwidth     = 2
vim.opt.expandtab      = true

vim.opt.smartindent    = true

vim.opt.wrap           = false
vim.opt.backspace      = { "indent", "eol", "start" } -- " (indent,eol,start) backspace through everything in insert mode

vim.opt.swapfile       = false
vim.opt.backup         = false

vim.opt.undodir        = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile       = true

vim.opt.hlsearch       = true
vim.opt.incsearch      = true
vim.opt.ignorecase     = true -- searches are case insensitive...
vim.opt.smartcase      = true -- ... unless they contain at least one capital letter

vim.opt.termguicolors  = true

vim.opt.scrolloff      = 8
vim.opt.signcolumn     = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.list       = true -- " Show invisible characters
