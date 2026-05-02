-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    -- { import = "plugins" },
    {
      'nvim-telescope/telescope.nvim',
      branch = 'master',
      -- or                            , tag = '0.1.x',
      dependencies = { { 'nvim-lua/plenary.nvim' } },
      cond = not vim.g.vscode
    },
    {
      'rose-pine/neovim',
      name = 'rose-pine',
      config = function()
        require("rose-pine").setup({
          variant = "moon",
        })

        vim.cmd('colorscheme rose-pine')
      end
    },
    {
      "folke/trouble.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      opts = {
        auto_close = true,
      },
    },

    {
      'nvim-treesitter/nvim-treesitter',
      build = function()
        local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
        ts_update()
      end,
    },
    { "nvim-treesitter/playground" },
    {
      "theprimeagen/harpoon",
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
      "ThePrimeagen/refactoring.nvim",
      dependencies = {
        "lewis6991/async.nvim",
      },
      lazy = false,
    },
    { "mbbill/undotree" },
    { "tpope/vim-fugitive" },
    { "nvim-treesitter/nvim-treesitter-context" },
    { "towolf/vim-helm" },

    -- LSP Support
    {
      "mason-org/mason-lspconfig.nvim",
      opts = {},
      dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
      },
    },

    -- Autocompletion
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp'
    },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'hrsh7th/cmp-nvim-lua' },

    -- Snippets
    {
      'L3MON4D3/LuaSnip',
      dependencies = { "rafamadriz/friendly-snippets" }
    },

    { "folke/zen-mode.nvim" },
    { "eandrju/cellular-automaton.nvim" },
    {
      "laytan/cloak.nvim",
      cond = not vim.g.vscode
    },
    {
      "lewis6991/gitsigns.nvim",
      tag = "release",
    },
    {
      'nvim-tree/nvim-tree.lua',
      dependencies = {
        'nvim-tree/nvim-web-devicons', -- optional
      },
      enabled = not vim.g.vscode
    },
    {
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup()
      end
    },
    { "ellisonleao/glow.nvim", config = function() require("glow").setup() end },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      enabled = not vim.g.vscode
    },
    {
      "nvim-neotest/neotest",
      enabled = not vim.g.vscode,
      dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        { "fredrikaverpil/neotest-golang", version = "*" },
      },
      config = function()
        local neotest_golang_opts = {}
        require("neotest").setup({
          adapters = {
            require("neotest-golang")(neotest_golang_opts),
          },
          status = { virtual_text = true },
          output = { open_on_run = true },
          quickfix = {
            open = function()
              if LazyVim.has("trouble.nvim") then
                require("trouble").open({ mode = "quickfix", focus = false })
              else
                vim.cmd("copen")
              end
            end,
          },
        })
      end,
    },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = false },
})
