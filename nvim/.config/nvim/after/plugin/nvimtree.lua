-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
  return
end
nvimtree.setup({
  -- disable window_picker for
  -- explorer to work well with
  -- window splits
  actions = {
    open_file = {
      window_picker = {
        enable = false,
      },
    },
  },
  filters = {
    dotfiles = false
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 500

  }
  -- 	git = {
  -- 		ignore = false,
  -- 	},
})


-- open nvim-tree on setup

local function open_nvim_tree(data)
  -- buffer is a [No Name]
  local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not no_name and not directory then
    return
  end

  -- change to the directory
  if directory then
    vim.cmd.cd(data.file)
  end

  -- open the tree
  require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

local keymap = vim.keymap
local api = require('nvim-tree.api')

keymap.set("n", "<leader>nc", ":NvimTreeCollapse<CR>", { desc = "Collapse file explorer", noremap = true, silent = true }) -- collapse file explorer
keymap.set("n", "<leader>nr", ":NvimTreeRefresh<CR>", { desc = "Refresh file explorer", noremap = true, silent = true })   -- refresh file explorer

keymap.set("n", "<leader>nt", ':NvimTreeToggle<CR>', { desc = "Toggle file explorer", noremap = true, silent = true })     -- toggle file explorer
keymap.set("n", "<leader>nff", ":NvimTreeFindFile<CR>", { desc = "Find file in the file tree" })                           -- find file in file tree
keymap.set("n", "<leader>ncf", api.fs.create, { noremap = true, silent = true, desc = "Create a file in nvim tree" })                                                                                 -- create a file in nvim tree
keymap.set('n', '<leader>ncd', api.tree.change_root_to_node, { noremap = true, silent = true, desc = "Change root to node" })
