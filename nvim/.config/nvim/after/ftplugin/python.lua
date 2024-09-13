local set = vim.opt_local
local keymap = vim.keymap

set.expandtab = true
set.tabstop = 4
set.shiftwidth = 4


-- run the file in a tumx session
keymap.set('n', '<leader>rf', ':w<CR>:silent !tmux send-keys -t .+ "python3 %" C-m<CR>', { noremap = true, silent = true, desc = "Run the current python file in the next tmux pane"})

-- run black
keymap.set('n', '<leader>rb', ':!black %<CR>', { noremap = true, silent = true, desc = "Run black for the current python file"})

-- comment string
