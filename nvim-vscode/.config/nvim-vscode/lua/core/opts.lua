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

