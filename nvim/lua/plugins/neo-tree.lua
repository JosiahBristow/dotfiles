return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    vim.keymap.set('n', '<C-n>', ':Neotree toggle<CR>', {})
    require("neo-tree").setup({
      default_component_configs = {
        window = {
          auto_expand_width = true,
        }
      },
      event_handlers = {
        {
          event = "file_opened",
          handler = function(file_path)
            vim.cmd("Neotree close")
          end
        }
      }
    })
  end
}
