return {
  {
    "zaldih/themery.nvim",
    config = function()
      require("themery").setup({
        themes = {
          "tokyonight-day",
          "tokyonight-moon",
          "tokyonight-night",
          "tokyonight-storm",
          "catppuccin-frappe",
          "catppuccin-latte",
          "catppuccin-macchiato",
          "catppuccin-mocha",
          "github_dark",
          "github_light",
          "github_dark_dimmed",
          "github_dark_default",
          "github_light_default",
          "github_dark_high_contrast",
          "github_light_high_contrast",
          "github_dark_colorblind",
          "github_light_colorblind",
          "github_dark_tritanopia",
          "github_light_tritanopia"
        }, -- Your list of installed colorschemes.
        livePreview = true,                                                                                                                                                            -- Apply theme while picking. Default to true.
      })
    end
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000
  },

  {
    "folke/tokyonight.nvim",
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      }
    },
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight]])
    end,
  },

  {
    'projekt0n/github-nvim-theme'
  }
}

