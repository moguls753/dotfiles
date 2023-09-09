return require("packer").startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")

  -- telescope fzf finder, picker, filebrowser etc.
  use({
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      opt = true,
    },
  })

  use({
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
  })

  use("folke/tokyonight.nvim")

  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    "nvim-treesitter/playground",
  })

  use("mbbill/undotree")

  use("tpope/vim-fugitive")

  use("tpope/vim-rails")

  use("slim-template/vim-slim")

  -- nvim-tmux-navigator, ctrl-h,j,k,l ist auch in tmux möglich
  use({
    "alexghergh/nvim-tmux-navigation",
    config = function()
      require("nvim-tmux-navigation").setup({
        disable_when_zoomed = true, -- defaults to false
        keybindings = {
          left = "<C-h>",
          down = "<C-j>",
          up = "<C-k>",
          right = "<C-l>",
          last_active = "<C-\\>",
          next = "<C-Space>",
        },
      })
    end,
  })

  use({
    -- LSP Support
    "neovim/nvim-lspconfig",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "jayp0521/mason-null-ls.nvim",
    "jose-elias-alvarez/null-ls.nvim",

    -- Autocompletion
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "petertriho/cmp-git",
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
  })

  -- the lualine statusline
  use({
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
  })

  use("norcalli/nvim-colorizer.lua")

  use("onsails/lspkind.nvim")

  use("numToStr/Comment.nvim")

  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }
end)
