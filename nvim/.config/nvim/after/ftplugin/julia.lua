local set = vim.opt_local
local keymap = vim.keymap
vim.opt_local.formatoptions:remove "o"

set.expandtab = true
set.tabstop = 4
set.shiftwidth = 4



-- start a repl session
local function start_repl()
  return ':silent !tmux send-keys -t .+ "julia" C-m<CR>'
end
keymap.set('n', '<leader>jr', start_repl(), { noremap = true, silent = true,desc = "Julia: Starts a Julia REPL"})


-- run highlighted section in the repl
local function run_highlighted_section()
  local text = vim.fn.getreg('V')
  text = text:gsub('\n', ' ')
  return 'tmux send-keys -t .+ "' .. text .. '" Enter'
end

local text = run_highlighted_section()
keymap.set('v', '<leader>rh',text ..  '<CR>', { noremap = true, silent = true, desc = "Julia: Run highlighted section in the repl"})

-- run current file in the tmux pane
keymap.set('n', '<leader>rf',
  [[:w !tmux send-keys -t .+ 'julia %' Enter<CR>]],
  { noremap = true, silent = true, desc = "Julia: Runs the Julia file in the terminal" })

