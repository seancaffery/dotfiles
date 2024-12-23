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
      branch = '0.1.x',
      -- or                            , tag = '0.1.x',
      dependencies = { { 'nvim-lua/plenary.nvim' } }
    },
    {
      'rose-pine/neovim',
      name = 'rose-pine',
      config = function()
        vim.cmd('colorscheme rose-pine')
      end
    },
    {
      "folke/trouble.nvim",
      config = function()
        require("trouble").setup {
          icons = true,
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      end
    },

    {
      'nvim-treesitter/nvim-treesitter',
      build = function()
        local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
        ts_update()
      end,
    },
    { "nvim-treesitter/playground" },
    { "theprimeagen/harpoon" },
    { "theprimeagen/refactoring.nvim" },
    { "mbbill/undotree" },
    { "tpope/vim-fugitive" },
    { "nvim-treesitter/nvim-treesitter-context" },

    { 'VonHeikemen/lsp-zero.nvim',              branch = 'v3.x' },
    -- LSP Support
    { 'neovim/nvim-lspconfig' },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },

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
    { "laytan/cloak.nvim" },
    { "lewis6991/gitsigns.nvim" },
    {
      'nvim-tree/nvim-tree.lua',
      dependencies = {
        'nvim-tree/nvim-web-devicons', -- optional
      }
    },
    {
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup()
      end
    },
    { "ellisonleao/glow.nvim",                    config = function() require("glow").setup() end },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    {
      'vim-test/vim-test',
      dependencies = {
        'preservim/vimux',
      },
    },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = false },
})
