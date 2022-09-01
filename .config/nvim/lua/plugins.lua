return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- colorscheme
  use { "ellisonleao/gruvbox.nvim" }

  -- better and easier commenting with Comment.nvim
  use {
    'numToStr/Comment.nvim',
  }

  -- the lualine statusline
  use {
    'nvim-lualine/lualine.nvim',
  }

  -- Configurations for Nvim LSP, managed alle eingehenden completion Vorschläge folgender Plugins
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    }
  }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }

  -- nvim-autopair parenthesis
  use {
    "windwp/nvim-autopairs",
  }

  -- java lsp extension
  use {
    'mfussenegger/nvim-jdtls'
  }

  -- telescope fzf finder, picker, filebrowser etc.
  use {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    requires = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons', opt = true,
      'nvim-telescope/telescope-ui-select.nvim',
    }
  }

  -- a native telescope sorter written in c
  use {
    'nvim-telescope/telescope-fzf-native.nvim', run = 'make'
  }


  -- hopping/highlighting when finding multiple occosions of a char
  use {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  }

  -- null-ls, for me its just for google-style-formatting on java
  use {
    'jose-elias-alvarez/null-ls.nvim'
  }

end)
