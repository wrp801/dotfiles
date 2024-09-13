vim.keymap.set("n", "x", '"_x') -- won't copy the deleted character into a register

-- remaps for splits
vim.keymap.set("n", "<leader>vs", "<C-w>v") -- vertical split
vim.keymap.set("n", "<leader>hs", "<C-w>s") -- horizontal split
vim.keymap.set('n', "<leader>sx", ":close<CR>") -- close a split
vim.keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width
vim.keymap.set("n","<leader>wl", "<C-w>l") -- navigate to left split
vim.keymap.set("n","<leader>wh", "<C-w>h") -- navigate to right split
vim.keymap.set("n","<leader>wj", "<C-w>j") -- navigate to bottom split
vim.keymap.set("n","<leader>wk", "<C-w>k") -- navigate to top split

-- remaps for splits
vim.keymap.set("n", "<leader>vs", "<C-w>v") -- vertical split
vim.keymap.set("n", "<leader>hs", "<C-w>s") -- horizontal split
vim.keymap.set('n', "<leader>sx", ":close<CR>") -- close a split
vim.keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width
vim.keymap.set("n","<leader>wl", "<C-w>l") -- navigate to left split
vim.keymap.set("n","<leader>wh", "<C-w>h") -- navigate to right split
vim.keymap.set("n","<leader>wj", "<C-w>j") -- navigate to bottom split
vim.keymap.set("n","<leader>wk", "<C-w>k") -- navigate to top split

-- quit all
vim.keymap.set('n', '<leader>qa', ':qall<CR>')

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>ql', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('wrp-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- remaps for buffers
vim.keymap.set("n", "<leader>bn", vim.cmd.BufferNext)
vim.keymap.set("n","<leader>bp", vim.cmd.BufferPrevious)
vim.keymap.set("n", '<leader>bc', vim.cmd.BufferClose)
function CloseOtherBuffers()
  local current = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current and vim.api.nvim_buf_is_loaded(buf) then
      vim.api.nvim_buf_delete(buf, {})
    end
  end
end
vim.keymap.set('n', '<leader>bx', ':lua CloseOtherBuffers()<CR>', { noremap = true, silent = true, desc = "Clsoe all buffers except the current one in focus" })

-- vim-maximizer
vim.keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle split window maximization


-- reload vim config
vim.keymap.set('n', '<leader>nv', ':so ~/.config/nvim/init.lua <CR>', { noremap = true, silent = true, desc = "Reload the entire nvim config"})

-- source single file
vim.keymap.set('n', "<leader>so", ':so % <CR>', { noremap = true, silent = true, desc = "Source the current file in the buffer"})





















