require('plugins')
require('keymappings')
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.hidden = true
vim.opt.wrap = false
vim.opt.scrolloff = 7
vim.opt.hlsearch = false
vim.g.copilot_enabled = false
--vim.g.netrw_banner = 0 
-- highlights the yanked words    
local group = vim.api.nvim_create_augroup("highlight_yank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", { callback = function()
  vim.highlight.on_yank({ higroup = "IncSearch", timeout = 700 })
end, group = group })
-- avoiding vim's override of filetype slim to html
vim.api.nvim_command([[
  autocmd BufNewFile,BufRead *.slim setlocal filetype=slim
]])
