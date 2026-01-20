-- Basic sane options (VS Code friendly)
vim.g.mapleader = " "

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




-- remaps 
if vim.g.vscode then
  local vscode = require('vscode')
  local function map(m, lhs, rhs, opt)
    opt = opt or { noremap = true, silent = true }
    vim.keymap.set(m, lhs, rhs, opt)
  end

  -- 1) <leader>vs — vertical split (VS Code: split editor to the right)
  -- Command: workbench.action.splitEditorRight
  -- https://stackoverflow.com/a/72772989 confirms the command id
  map('n', '<leader>vs', function()
    vscode.action('workbench.action.splitEditorRight')
  end, { desc = 'Split editor right' })  -- [2](https://stackoverflow.com/questions/72737085/vscode-how-to-move-an-editor-to-the-right)

  -- 2) <leader>sx — close a split (VS Code: close active editor/tab)
  -- Command: workbench.action.closeActiveEditor
  map('n', '<leader>sx', function()
    vscode.action('workbench.action.closeActiveEditor')
  end, { desc = 'Close editor (split)' })  -- [3](https://deepwiki.com/microsoft/vscode/8-source-control-management)[4](https://bobbyhadz.com/blog/close-all-tabs-in-vscode)

  -- 3) <leader>bn — "BufferNext"
  -- Use "next editor in *this group*" (closer to Vim's :bnext than global next).
  -- Commands: workbench.action.nextEditorInGroup / previousEditorInGroup
  map('n', '<leader>bn', function()
    vscode.action('workbench.action.nextEditorInGroup')
  end, { desc = 'Next editor in group' })  -- [5](https://stackoverflow.com/questions/69904611/keybindings-is-there-a-when-clause-for-the-index-of-the-focused-editor-in-its)

  -- 4) <leader>bp — "BufferPrevious"
  map('n', '<leader>bp', function()
    vscode.action('workbench.action.previousEditorInGroup')
  end, { desc = 'Previous editor in group' })  -- [5](https://stackoverflow.com/questions/69904611/keybindings-is-there-a-when-clause-for-the-index-of-the-focused-editor-in-its)

  -- 5) <leader>bc — like `:b# | bd#` (close *current* buffer, focus previous)
  -- VS Code equivalent: jump to previous MRU editor in *this* group, then close the
  -- previously active tab explicitly via the Tab API.

  -- map('n', '<leader>bc', function()
  --   vscode.eval([[
  --     const group = vscode.window.tabGroups.activeTabGroup;
  --     const old   = group?.activeTab;
  --     // Focus previous MRU editor in current group:
  --     await vscode.commands.executeCommand('workbench.action.openPreviousRecentlyUsedEditorInGroup');
  --     // Now close the previously active tab while we remain on the previous editor:
  --     if (old) { await vscode.window.tabGroups.close(old, true); }
  --   ]])
  -- end, { desc = 'Close current and focus previous (like :b#|bd#)' })  -- [1](https://github.com/vscode-neovim/vscode-neovim)[6](https://stackoverflow.com/questions/76887496/how-can-i-cycle-through-recently-used-editors-in-vs-code-without-the-intermediat)

  -- 6) <leader>wl / <leader>wh — move focus between splits (editor groups)
  -- Commands: workbench.action.focusRightGroup / focusLeftGroup
  map('n', '<leader>wl', function()
    vscode.action('workbench.action.focusRightGroup')
  end, { desc = 'Focus right editor group' })  -- [7](https://github.com/microsoft/vscode/issues/107873)

  map('n', '<leader>wh', function()
    vscode.action('workbench.action.focusLeftGroup')
  end, { desc = 'Focus left editor group' })   -- [7](https://github.com/microsoft/vscode/issues/107873)

  -- (Optional) add up/down too:
  -- map('n', '<leader>wk', function() vscode.action('workbench.action.focusAboveGroup') end, { desc = 'Focus above group' })
  -- map('n', '<leader>wj', function() vscode.action('workbench.action.focusBelowGroup') end, { desc = 'Focus below group' })

  -- 7) <leader>zm — toggle Zen Mode (VS Code's distraction‑free mode)
  -- Command: workbench.action.toggleZenMode
  map('n', '<leader>zm', function()
    vscode.action('workbench.action.toggleZenMode')
  end, { desc = 'Toggle Zen Mode' })  -- [8](https://www.oreilly.com/library/view/learn-powershell-core/9781788838986/af58dd0c-4572-41ca-b521-0d5e2e199ad1.xhtml)[9](https://techstacker.com/vscode-toggle-zen-mode/)
  vim.keymap.set('n', '<leader>pf', function()
    vscode.action('workbench.action.quickOpen')
  end, { noremap = true, silent = true, desc  = 'Quick Open (Ctrl+P)'})
  
  vim.keymap.set('n', '<leader>e', function()
    vscode.eval([[
      const activeView = vscode.window.activeViewColumn;
      const sidebarVisible = vscode.workspace.getConfiguration('workbench').get('sideBar.location') !== undefined;
      const explorerFocused = vscode.window.activeTextEditor === undefined;
      if (explorerFocused) {
        await vscode.commands.executeCommand('workbench.action.focusActiveEditorGroup');
      } else {
        await vscode.commands.executeCommand('workbench.view.explorer');
      }
    ]])
  end, { noremap = true, silent = true, desc = 'Toggle focus: editor <-> explorer' })

end
