require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "volar", "solargraph", "html", "cssls", "texlab" },
})

require("mason-null-ls").setup({
  ensure_installed = { "prettier" },
  automatic_installation = true,
  automatic_setup = false,
})

---------- Lsp Server configuration --------

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, bufopts)
  vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, bufopts)
  vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", bufopts)
  vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)

  -- format on save
  vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup,
    buffer = bufnr,
    callback = function()
      -- rubocop seems not to work with format()
      vim.lsp.buf.format({ bufnr = bufnr })
    end,
    desc = "[lsp] format on save",
  })
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig').lua_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
})

-------- Null-ls configuration ---------

local null_ls = require("null-ls")
null_ls.setup {
  filetypes = { "html" },
  sources = {
    null_ls.builtins.formatting.prettier,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      print("attached")
      vim.keymap.set("n", "<Leader>f", function()
        -- rubocop seems not to work with format()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = "[lsp] format" })

      -- format on save
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          -- rubocop seems not to work with format()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
        desc = "[lsp] format on save",
      })
    end
  end,
}

require('lspconfig').volar.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
})

require 'lspconfig'.solargraph.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

require 'lspconfig'.html.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

require 'lspconfig'.cssls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

require 'lspconfig'.texlab.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    texlab = {
      auxDirectory = ".",
      bibtexFormatter = "texlab",
      build = {
        args = { "--interaction=nonstopmode", "--synctex=1", "%f" },
        executable = "lualatex",
        forwardSearchAfter = false,
        onSave = true
      },
      chktex = {
        onEdit = false,
        onOpenAndSave = false
      },
      diagnosticsDelay = 300,
      formatterLineLength = 80,
      forwardSearch = {
        executable = 'zathura',
        args = {
          '--synctex-editor-command',
          [[nvim-texlabconfig -file '%{input}' -line %{line}]],
          '--synctex-forward',
          '%l:1:%f',
          '%p',
        },
      },
      latexFormatter = "latexindent",
      latexindent = {
        modifyLineBreaks = false
      },
    },
  },
}
