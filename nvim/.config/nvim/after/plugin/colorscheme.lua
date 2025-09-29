vim.g.default_theme = true
local function change_theme()
  if vim.g.default_theme then 
      -- vim.g.sonokai_enable_italic = true 
      -- vim.g.sonokai_better_performance = 1
      -- vim.g.sonokai_style = 'maia'
      -- vim.cmd('colorscheme sonokai')
    vim.cmd('colorscheme vscode')
    vim.g.default_theme = false
  else
    vim.cmd("colorscheme everforest")
    vim.g.default_theme = true
  end
end
vim.cmd("colorscheme everforest")
-- vim.cmd("colorscheme evergarden")
-- Keymap to toggle theme
vim.keymap.set('n', '<leader>ct', change_theme, { desc = 'Toggle between everforest and nightfox themes' })
