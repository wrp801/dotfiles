local keymap = vim.keymap

local neogen = require('neogen')
keymap.set('n','<leader>ng', neogen.generate, {noremap = true, silent = true})
