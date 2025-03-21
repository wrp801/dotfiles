-- FIXME: This is not working properly, producing an error when I call either
  local function toggle_expanded_results_display()
    local dbout_win, dbout_buf = get_dbout_win_buf()
    vim.api.nvim_buf_call(dbout_buf, function()
      vim.fn['db_ui#dbout#toggle_layout']()
    end)
  end

  local function jump_to_dbout()
    local dbout_win, dbout_buf = get_dbout_win_buf()
    vim.cmd(dbout_win .. ' wincmd w')
  end
  vim.keymap.set('n', '<localleader>rv', toggle_expanded_results_display, { buffer = true, desc = "Toggle expanded results display" })
  vim.keymap.set("n", "<leader>jr", jump_to_dbout, {buffer = true, desc="Jump to the sql output window"})
