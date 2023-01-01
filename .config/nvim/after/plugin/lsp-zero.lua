vim.opt.signcolumn = 'yes' -- Reserve space for diagnostic icons

local lsp = require('lsp-zero')
lsp.preset('recommended')

lsp.ensure_installed({
  'tsserver',
  'eslint',
  'sumneko_lua',
})

lsp.nvim_workspace()

-- the function below will be executed whenever
-- a language server is attached to a buffer
lsp.on_attach(function(client, bufnr)
  local noremap = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "K", vim.lsp.buf.hover, noremap)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, noremap)
  vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, noremap)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, noremap)
  vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, noremap)
  vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, noremap)
  vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", noremap)
  vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, noremap)
  -- more code  ...
end)

-- setup must be the last function
-- this one does all the things
lsp.setup()
