return function(use)
  use { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim'
    },
  }
  use {
    'mfussenegger/nvim-dap',
    requires = {
      -- Creates a beautiful debugger UI
      'rcarriga/nvim-dap-ui',
      -- Installs the debug adapters for you
      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',
      -- custom debuggers
      'leoluz/nvim-dap-go',
    },
  }
  use { -- Autocompletion
    'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'hrsh7th/cmp-cmdline',
      'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip', 'rafamadriz/friendly-snippets' },
  }
  use { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  }
  use { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }
  -- Themes
  use 'rebelot/kanagawa.nvim'
  -- Git related plugins
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'lewis6991/gitsigns.nvim'
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

  -- Quality of live
  use 'nvim-lualine/lualine.nvim' -- Statusline
  use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
  use 'windwp/nvim-autopairs'
  use 'numToStr/Comment.nvim'
  use 'tpope/vim-sleuth'
  -- Fuzzy Finder (files, lsp, etc)
  use {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    requires = {
      'nvim-lua/plenary.nvim',
    }
  }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }
  use { "akinsho/toggleterm.nvim", tag = '*' }
  -- Filetree
  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    }
  }
  -- Bookmarks
  -- use 'ThePrimeagen/harpoon'
  -- Which Key (keystroke highlights)
  use 'folke/which-key.nvim'
  -- better diagnostics
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons"
  }

end
