require('todo-comments').setup()

vim.keymap.set('n', '<leader>tt', ':TodoTelescope<CR>', {desc = "List of TODO's in telescope format"})
vim.keymap.set('n', '<leader>tx', ':TodoTrouble<CR>', {desc = 'List of trouble items'})
vim.keymap.set('n', '<leader>td', ':TodoTelescope keywords=TODO,NOTE <CR>', { desc = 'List the TODO and NOTE items'})
vim.keymap.set('n', '<leader>tb', ':TodoTelescope keywords=FIXME,BUG,FIX <CR>', {desc = 'List the FIXME, BUG and FIX items'})
