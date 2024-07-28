return {
  'akinsho/bufferline.nvim',
  event = { "BufReadPre", "BufNewFile" },
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    vim.opt.termguicolors = true
    local bufferline = require("bufferline")
    bufferline.setup {
      options = {
        style_preset = bufferline.style_preset.minimal,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          return " " .. count
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            text_align = "center",
            separator = true
          }
        },
        separator_style = "slant",
        always_show_bufferline = false,
      }
    }
    local wk = require("which-key")
    wk.register({
      b = {
        name = "Buffer",
        c = { "<cmd>bw<cr>", "Buffer Close" },
        p = { "<cmd>bp<cr>", "Previous Buffer" },
        n = { "<cmd>bn<cr>", "Next Buffer" },
      },
    }, { prefix = "<leader>" })
  end
}
