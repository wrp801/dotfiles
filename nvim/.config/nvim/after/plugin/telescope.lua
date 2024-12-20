config = function()
  -- Telescope is a fuzzy finder that comes with a lot of different things that
  -- it can fuzzy find! It's more than just a "file finder", it can search
  -- many different aspects of Neovim, your workspace, LSP, and more!
  --
  -- The easiest way to use Telescope, is to start by doing something like:
  --  :Telescope help_tags
  --
  -- After running this command, a window will open up and you're able to
  -- type in the prompt window. You'll see a list of `help_tags` options and
  -- a corresponding preview of the help.
  --
  -- Two important keymaps to use while in Telescope are:
  --  - Insert mode: <c-/>
  --  - Normal mode: ?
  --
  -- This opens a window that shows you all of the keymaps for the current
  -- Telescope picker. This is really useful to discover what Telescope can
  -- do as well as how to actually do it!

  -- [[ Configure Telescope ]]
  -- See `:help telescope` and `:help telescope.setup()`
  require('telescope').setup {
    -- You can put your default mappings / updates / etc. in here
    --  All the info you're looking for is in `:help telescope.setup()`
    --
    -- defaults = {
    --   mappings = {
    --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
    --   },
    -- },
    -- pickers = {}
    extensions = {
      ['ui-select'] = {
        require('telescope.themes').get_dropdown(),
      },
    },
  }

  -- Enable Telescope extensions if they are installed
  pcall(require('telescope').load_extension, 'fzf')
  pcall(require('telescope').load_extension, 'ui-select')

  local function find_files()
    local builtin = require 'telescope.builtin'
    if vim.g.show_hidden_files then
      builtin.find_files({ hidden = true, no_ignore = true })
    else
      builtin.find_files()
    end
  end

  local function toggle_hidden_flag()
    if vim.g.show_hidden_files then
      vim.notify("Setting hidden files flag to false")
      vim.g.show_hidden_files = false
    else
      vim.notify("Setting hidden files flag to true")
      vim.g.show_hidden_files = true
    end
  end

  -- See `:help telescope.builtin`
  local builtin = require 'telescope.builtin'
  vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
  vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
  vim.keymap.set('n', '<leader>pf', find_files, { desc = 'Search files. If the `show_hidden_files` is true, it will show all files, otherwise it will only show not dotfiles and what is not git ignored' })
  vim.keymap.set("n", '<leader>th', toggle_hidden_flag, { desc = "Turn the hidden files flag on for telescope" })
  vim.keymap.set('n', '<leader>fe',
    function() require('telescope.builtin').find_files({ hidden = true, search_file = '.env' }) end,
    { desc = 'Find the .env files' })
  vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
  vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
  vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
  vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
  vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
  vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
  vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

  vim.keymap.set('n', '<leader>lds', function()
    builtin.lsp_document_symbols({ symbols = { 'class', 'function', 'method', 'struct', 'enum' } })
  end, { desc = "List document symbols (excluding variables)" })
  vim.keymap.set('n', '<leader>lws', builtin.lsp_workspace_symbols, { desc = "List workspace symbols" })
  vim.keymap.set('n', '<leader>lr', builtin.lsp_references, { desc = 'List references' })
  vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
  end, { desc = "Grep string in project" })
  -- telescope git commands
  vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = "Search for git files" })
  vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = "Git status" })
  vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = "Git branches" })

  -- Slightly advanced example of overriding default behavior and theme
  vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to Telescope to change the theme, layout, etc.
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end, { desc = '[/] Fuzzily search in current buffer' })

  -- It's also possible to pass additional configuration options.
  --  See `:help telescope.builtin.live_grep()` for information about particular keys
  vim.keymap.set('n', '<leader>s/', function()
    builtin.live_grep {
      grep_open_files = true,
      prompt_title = 'Live Grep in Open Files',
    }
  end, { desc = '[S]earch [/] in Open Files' })

  -- Shortcut for searching your Neovim configuration files
  vim.keymap.set('n', '<leader>sn', function()
    builtin.find_files { cwd = vim.fn.stdpath 'config' }
  end, { desc = '[S]earch [N]eovim files' })
end

config()
