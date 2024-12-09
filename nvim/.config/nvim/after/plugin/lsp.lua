local lsp = require('lsp-zero')
-- Function to toggle LSP warnings
local lsp_warnings_enabled = true

function ToggleLspWarnings()
  lsp_warnings_enabled = not lsp_warnings_enabled

  if lsp_warnings_enabled then
    vim.diagnostic.config({
      virtual_text = {
        severity = { min = vim.diagnostic.severity.WARN }
      },
      signs = {
        severity = { min = vim.diagnostic.severity.WARN }
      },
      underline = {
        severity = { min = vim.diagnostic.severity.WARN }
      }
    })
    vim.notify("LSP Warnings: ON")
  else
    vim.diagnostic.config({
      virtual_text = {
        severity = { min = vim.diagnostic.severity.ERROR }
      },
      signs = {
        severity = { min = vim.diagnostic.severity.ERROR }
      },
      underline = {
        severity = { min = vim.diagnostic.severity.ERROR }
      }
    })
    vim.notify("LSP Warnings: OFF")
  end
end

lsp.preset('recommended')

lsp.ensure_installed({
  'rust_analyzer',
  'pyright',
  'gopls',
  'julials'

})

lsp.configure('lua-language-server', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    },
  }
})

-- configure rust-analyzer to include support for proc macros and features (in libraries)
lsp.configure('rust-analyzer', {
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      procMacro = {
        enable = true,  -- Enable support for procedural macros
      },
    },
  },
})

lsp.configure('julials', { 
  on_new_config = function(new_config, _) 
    local julia = vim.fn.expand("~/.julia/environments/nvim-lspconfig/bin/julia") 
    if vim.fn.filereadable(julia) == 1 then 
      vim.notify("Hello") 
      new_config.cmd[1] = julia 
    end 
  end 
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ['<C-Space>'] = cmp.mapping.complete(),
})

lsp.setup_nvim_cmp({
  mapping = cmp_mappings,
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  }
})


lsp.set_preferences({
  suggest_lsp_servers = false,
  sign_icons = {
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I'
  }
})

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end,
    { buffer = bufnr, noremap = false, desc = "Go to Definition" })
  vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end,
    { buffer = bufnr, noremap = false, desc = "View workspace symbols" })
  vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end,
    { buffer = bufnr, noremap = false, desc = "Open diagnostic float" })
  vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end,
    { buffer = bufnr, remap = false, desc = "Go to next diagnostic" })
  vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end,
    { buffer = bufnr, remap = false, desc = "Go to previous diagnostic" })
  vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end,
    { buffer = bufnr, remap = false, desc = "View Code Action" })
  vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end,
    { buffer = bufnr, noremap = false, desc = "View LSP references" })
  vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end,
    { buffer = bufnr, noremap = false, desc = "Rename a variable/symbol" })
  vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end,
    { buffer = bufnr, noremap = false, desc = "View signature help" })
  vim.keymap.set('n', '<leader>nw', ToggleLspWarnings, { noremap = true, silent = true, desc = "Toggle LSP warnings" })
  vim.keymap.set('n', '<leader>F', vim.lsp.buf.format)
  vim.keymap.set('n', '<leader>gD', '<cmd>lua require"telescope.builtin".lsp_definitions({jump_type="vsplit"})<CR>',
    { noremap = true, silent = true }, { desc = 'Go to definition in a new split' })
  vim.keymap.set('n', "<leader>D", vim.lsp.buf.type_definition, { desc = 'Type definition' })
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
  vim.keymap.set('n', '<leader>K', vim.lsp.buf.signature_help, { desc = 'Signature Documentation' })
end)

lsp.setup()
local function setup_lsp_diags()
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
      virtual_text = true,
      signs = true,
      update_in_insert = false,
      underline = true,
    }
  )
end

setup_lsp_diags()
