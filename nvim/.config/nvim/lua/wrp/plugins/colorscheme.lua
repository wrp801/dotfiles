return {
  -- Everforest theme with config
  {
    "neanias/everforest-nvim",
    priority = 1000, -- Load before other plugins
    config = function()
      require("everforest").setup({
        background = 'hard',
      })
    end,
  },

  {
    'Mofiqul/vscode.nvim'
  }


  -- Optional: evergarden theme, commented out
  -- {
  --   "comfysage/evergarden",
  --   priority = 1000,
  --   opts = {
  --     transparent_background = true,
  --     variant = 'hard',
  --     overrides = {},
  --   },
  -- },
}

