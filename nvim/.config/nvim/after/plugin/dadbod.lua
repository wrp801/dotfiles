vim.keymap.set('n','<leader>dbo',':DBUI <CR>', {noremap = true, silent = true, desc = "Opens the DB UI pane"})
vim.keymap.set('n','<leader>dbc', ':DBUIClose<CR>', {noremap = true, silent = true, desc = "Closes the DB UI pane"})
-- vim.keymap.set('n','<leader>rq','<PLUG>(DBUI_ExecuteQuery)', { buffer = true, desc = "run the selected query"})
init = function()
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
  vim.keymap.set('n', '<leader>rv', toggle_expanded_results_display, { buffer = true, desc = "Toggle expanded results display" })
  vim.keymap.set("n", "<leader>jr", jump_to_dbout, {buffer = true, desc="Jump to the sql output window"})
  -- Your DBUI configuration
  vim.g.db_ui_use_nerd_fonts = 1
  vim.g["db#adapter#sqlserver#shell_command"] = 'sqlcmd -W -y 50 -s","'
  vim.g.dbs = {
    fabric_dev = "sqlserver://$FABRIC_SERVER/wh__data_warehouse?authentication=ActiveDirectoryServicePrincipal;user=$FABRIC_USER;pasword=$SQLCMDPASSWORD",
    fabric_dev_meta = "sqlserver://$FABRIC_SERVER/wh__metadata?authentication=ActiveDirectoryServicePrincipal;user=$FABRIC_USER;pasword=$SQLCMDPASSWORD",
    fabric_wes_dev = "sqlserver://$FABRIC_SERVER/wh__dev_wes__data_warehouse?authentication=ActiveDirectoryServicePrincipal;user=$FABRIC_USER;pasword=$SQLCMDPASSWORD",
    fabric_prod = "sqlserver://$FABRIC_SERVER_PROD/wh__data_warehouse?authentication=ActiveDirectoryServicePrincipal;user=$FABRIC_USER;pasword=$SQLCMDPASSWORD",
    fabric_prod_meta = "sqlserver://$FABRIC_SERVER_PROD/wh__metadata?authentication=ActiveDirectoryServicePrincipal;user=$FABRIC_USER;pasword=$SQLCMDPASSWORD",
    duckdb = "duckdb:"
  }
end
init()
