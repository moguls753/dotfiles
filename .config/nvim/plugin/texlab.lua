local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require'lspconfig'.texlab.setup {
  capabilities = capabilities,
  on_attach = function()
    vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer = 0})
    vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, {buffer = 0})
    vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, {buffer = 0})
    vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", {buffer = 0})
    vim.keymap.set("n", "<leader>ll", "<cmd>TexlabBuild<cr>", {buffer = 0})
  end,
  settings = {
    texlab = {
      auxDirectory = ".",
      bibtexFormatter = "texlab",
      build = {
        args = { "-lualatex", "-synctex=1", "%f" },
        executable = "latexmk",
        forwardSearchAfter = true,
        onSave = true
      },
      chktex = {
        onEdit = true,
        onOpenAndSave = false
      },
      diagnosticsDelay = 300,
      formatterLineLength = 80,
      forwardSearch = {
        executable = "zathura",
        args = {"--synctex-forward", "%l:1:%f", "%p"},
        onSave = true
      },
      latexFormatter = "latexindent",
      latexindent = {
        modifyLineBreaks = false
      }
    }
  }
}
