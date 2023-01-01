return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- telescope fzf finder, picker, filebrowser etc.
  use {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    requires = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons', opt = true,
    }
  }

  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' } 

  use({
    'rose-pine/neovim',
    as = 'rose-pine',
    config = function()
      vim.cmd('colorscheme rose-pine')
    end
  })

  use({
    'nvim-treesitter/nvim-treesitter', 
    run = ':TSUpdate',
    'nvim-treesitter/playground',
  })

  use 'mbbill/undotree'

  use 'tpope/vim-fugitive'

  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
    }
  }

end)

