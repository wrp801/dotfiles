vim.opt_local.formatoptions:remove "o"
local set = vim.opt_local
local keymap = vim.keymap
local builtin = require('telescope.builtin')

set.expandtab = true
set.tabstop = 4
set.shiftwidth = 4

local function show_diagnostics()
  local opts = {
    bufnr = 0,
    severity = { min = vim.diagnostic.severity.WARN }
  }
  builtin.diagnostics(opts)
end
keymap.set('n', '<leader>db', ':lua show_diagnostics()<CR>', { noremap = true, silent = true })
-- filter



