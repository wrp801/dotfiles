return{
  -- NOTE: everforest may be the best
  "neanias/everforest-nvim",
  -- Optional; default configuration will be used if setup isn't called.
  --NOTE: config below is for everforest
  config = function()
    require("everforest").setup({
      background = 'hard',
    }
    )
  end,
  -- NOTE: evergarden theme below
  -- 'comfysage/evergarden',
  -- priority = 1000, -- Colorscheme plugin is loaded first before any other plugins
  -- opts = {
  --   transparent_background = true,
  --   variant = 'hard', -- 'hard'|'medium'|'soft'
  --   overrides = { }, -- add custom overrides
  -- }

}
