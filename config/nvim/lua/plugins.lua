-- Plugin definition and loading
-- local execute = vim.api.nvim_command
local fn = vim.fn
local cmd = vim.cmd

-- Boostrap Packer
local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path })
end

-- Load Packer
cmd([[packadd packer.nvim]])

-- Rerun PackerCompile everytime plugins.lua is updated
cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- Initialize pluggins
return require('packer').startup(function(use)
  -- Let Packer manage itself
  use({
    "wbthomason/packer.nvim",
    opt = true
  })

  -- LSP language server installation/uninstallation
  -- NOTE: needs to be before lspconfig
  use({ "williamboman/mason.nvim",
    config = function() require('plugins.mason') end
  })
  use({
    "williamboman/mason-lspconfig.nvim",
    requires = {
      'williamboman/mason.nvim',
    },
    config = function()
      require("mason-lspconfig").setup()
    end,
  })

  -- LSP Navigation
  use({
    'ray-x/navigator.lua',
    requires = {
      { 'ray-x/guihua.lua', run = 'cd lua/fzy && make' },
      { 'neovim/nvim-lspconfig' },
      { "nvim-treesitter/nvim-treesitter" }
    },
    config = function()
      require('plugins.navigator')
    end
  })

  -- LSP Config present in `plugins/lspconfig`
  -- kept it there to bootstrap neodev. See comments

  -- LSP Progress bars
  use({ 'j-hui/fidget.nvim',
    config = function() require('plugins.fidget') end
  })

  -- Autocomplete
  use({
    "hrsh7th/nvim-cmp",
    -- Sources for nvim-cmp
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function() require('plugins.cmp') end,
  })

  -- Treesitter
  use({
    'nvim-treesitter/nvim-treesitter',
    config = function() require('plugins.treesitter') end,
    run = ':TSUpdate'
  })

  -- Snippets
  use { "L3MON4D3/LuaSnip", config = function() require('plugins.snippets') end }
  use "rafamadriz/friendly-snippets"

  -- Telescope
  use({
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } },
    config = function() require('plugins.telescope') end,
  })

  use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })

  -- Bufferline
  use({
    'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require('plugins.bufferline') end,
    event = 'BufWinEnter',
  })

  -- Statusline
  use({
    'hoob3rt/lualine.nvim',
    config = function() require('plugins.lualine') end,
  })

  -- Rooter
  use({
    'notjedi/nvim-rooter.lua',
    config = function()
      require 'nvim-rooter'.setup({
        rooter_patterns = { '.git', '.hg', '.svn', 'Cargo.toml' },
      })
    end
  })

  -- NvimTree
  use({
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require('plugins.nvimtree') end, -- Must add this manually
  })

  -- Startify
  use({
    'mhinz/vim-startify',
    config = function()
      local path = vim.fn.stdpath('config') .. '/lua/plugins/startify.vim'
      vim.cmd('source ' .. path)
    end
  })

  -- Gitsigns
  use({
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('plugins.gitsigns') end
  })

  -- Formatting
  use 'tpope/vim-commentary'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'

  -- -- Debugging
  -- use({ 'mfussenegger/nvim-dap',
  --   config = function() require('plugins/nvim-dap') end
  -- })

  -- Rust

  use { "rcarriga/nvim-dap-ui",
    requires = { "mfussenegger/nvim-dap" },
    config = function() require('dapui').setup() end
  }
  use({ 'simrat39/rust-tools.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'neovim/nvim-lspconfig',
      'mfussenegger/nvim-dap'
    },
    config = function() require('plugins.rust-tools') end
  })

  -- Python formatting
  use "EgZvor/vim-black"
  use 'jeetsukumaran/vim-python-indent-black'

  -- Markdown
  use 'godlygeek/tabular'
  use 'ellisonleao/glow.nvim'

  -- TOML Files
  use 'cespare/vim-toml'

  -- kitty config syntax-highlight
  use "fladson/vim-kitty"


  -- -- Themes
  use 'folke/tokyonight.nvim'
  use 'marko-cerovac/material.nvim'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
