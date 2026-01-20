-- Basic sane options (VS Code friendly)
vim.g.mapleader = " "

vim.keymap.set("n", "x", '"_x') -- won't copy the deleted character into a register

-- remaps for splits
vim.keymap.set("n", "<leader>vs", "<C-w>v") -- vertical split
vim.keymap.set("n", "<leader>hs", "<C-w>s") -- horizontal split
-- vim.keymap.set('n', "<leader>sx", ":close<CR>") -- close a split
vim.keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width
vim.keymap.set("n","<leader>wl", "<C-w>l") -- navigate to left split
vim.keymap.set("n","<leader>wh", "<C-w>h") -- navigate to right split
vim.keymap.set("n","<leader>wj", "<C-w>j") -- navigate to bottom split
vim.keymap.set("n","<leader>wk", "<C-w>k") -- navigate to top split



-- system clipboard 
vim.opt.clipboard:append("unnamedplus")
vim.g.clipboard = { name = "WslClipboard", copy = { ["+"] = "clip.exe", ["*"] = "clip.exe", }, paste = { ["+"] = [[powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))]], ["*"] = [[powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))]], }, cache_enabled = 0 }

-- aesthetics
vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

-- splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- set completeopt to have a better completion experience
-- vim.o.completeopt = true


-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- nerd font option 
vim.g.have_nerd_font=true

-- don't have `o` add a comment
vim.opt.formatoptions:remove "o"


-- remaps 
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



-- VS Code Neovim-only keymaps
-- 1) Ctrl+Y → accept completion (intellisense & inline)
--    Works even if a suggestion isn't visible (VS Code will no-op).
map('i', '<C-y>', function()
  vim.fn.VSCodeNotify('acceptSelectedSuggestion')          -- suggest widget
  vim.fn.VSCodeNotify('editor.action.inlineSuggest.commit') -- ghost text
end, { desc = 'Accept completion (widget/inline)' })

-- 2) Ctrl+N then T → toggle focus between Explorer and Editor
--    Note: This keeps its own toggle state; if you click with the mouse, it may desync.
--    See Option 2 below for a context-aware VS Code version.
local explorer_focused = false
map('n', '<C-n>t', function()
  if explorer_focused then
    vim.fn.VSCodeNotify('workbench.action.focusActiveEditorGroup')
  else
    vim.fn.VSCodeNotify('workbench.files.action.showActiveFileInExplorer')
  end
  explorer_focused = not explorer_focused
end, { desc = 'Toggle focus: Explorer <-> Editor' })

-- 3) Ctrl+B then C → close current tab (editor)
map('n', '<C-b>c', function()
  vim.fn.VSCodeNotify('workbench.action.closeActiveEditor')
end, { desc = 'Close current editor' })

-- 4) Ctrl+B then X → close all open tabs (editors)
map('n', '<C-b>x', function()
  vim.fn.VSCodeNotify('workbench.action.closeAllEditors')
end, { desc = 'Close all editors' })



