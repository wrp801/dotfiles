vim.opt_local.formatoptions:remove "o"
local set = vim.opt_local
local keymap = vim.keymap

set.expandtab = false
set.tabstop = 4
set.shiftwidth = 4

keymap.set('n','<leader>rf', ':w<CR>:silent !tmux send-keys -t .+ "go run %" C-m<CR>', { noremap = true, silent = true} )

