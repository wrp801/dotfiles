vim.opt.nu = true
vim.opt.relativenumber = true
-- make line numbers default
vim.wo.number = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.mouse = 'a'

vim.opt.wrap = false
vim.opt.showmode = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true


vim.opt.scrolloff = 8
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.g.mapleader = " " 

vim.opt.wildmode=longest,list

-- backspace 
vim.opt.backspace = "indent,eol,start"

-- system clipboard 
vim.opt.clipboard:append("unnamedplus")

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


-- telescope hidden files toggle 
vim.g.show_hidden_files=false
