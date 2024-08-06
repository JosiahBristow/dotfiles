return {
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },

  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<C-p>", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
      vim.keymap.set("n", "<leader><leader>", builtin.oldfiles, {})

      require("telescope").load_extension("ui-select")
      require("telescope").load_extension("aerial")
    end,
  },

  {
    'stevearc/aerial.nvim',
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    opts = function()
      local opts = {
        attach_mode = "global",
        backends = { "lsp", "treesitter", "markdown", "man" },
        show_guides = true,
        layout = {
          resize_to_content = false,
          win_opts = {
            winhl = "Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB",
            signcolumn = "yes",
            statuscolumn = " ",
          },
        },
        icons = icons,
        filter_kind = filter_kind,
        -- stylua: ignore
        guides = {
          mid_item   = "├╴",
          last_item  = "└╴",
          nested_top = "│ ",
          whitespace = "  ",
        },
      }
      return opts
    end,
    keys = {
      { "<leader>a", "<cmd>AerialToggle<cr>", desc = "Aerial (Symbols)" },
    },
    config = function()
      require("aerial").setup({
        -- optionally use on_attach to set keymaps when aerial has attached to a buffer
        on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
        vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
        end,
      })
    end,
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      local wk = require("which-key")
      wk.register({
        c = {
          name = "code",
        },
        w = {
          name = "windows",
        },
        r = {
          name = "re"
        }
      }, { prefix = "<leader>" })
    end
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local config = require("nvim-treesitter.configs")
      config.setup({
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        rainbow = {
          enable = true,
          extended_mode = true,
          max_file_lines = nil,
        }
      })
    end
  },

  {
    "folke/trouble.nvim",
    opts = {},     -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },

  {
    "stevearc/oil.nvim",
    config = function()
      local oil = require("oil")
      oil.setup()
      vim.keymap.set("n", "-", oil.toggle_float, {})
    end,
  },

  {
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
  },

  {
    "vinnymeller/swagger-preview.nvim",
    build = "npm install -g swagger-ui-watcher",
    config = true,
  },

  {
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = {
      { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
    },
    opts = {},
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    config = function()
      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }

      local hooks = require "ibl.hooks"
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      end)

      require("ibl").setup { indent = { highlight = highlight } }
    end
  },

  {
    "dnlhc/glance.nvim",
    config = function()
      require('glance').setup({})
      vim.keymap.set('n', 'gD', '<CMD>Glance definitions<CR>')
      vim.keymap.set('n', 'gR', '<CMD>Glance references<CR>')
      vim.keymap.set('n', 'gY', '<CMD>Glance type_definitions<CR>')
      vim.keymap.set('n', 'gM', '<CMD>Glance implementations<CR>')
    end,
  },

  {
    "utilyre/sentiment.nvim",
    version = "*",
    event = "VeryLazy", -- keep for lazy loading
    opts = {
      -- config
    },
    init = function()
      -- `matchparen.vim` needs to be disabled manually in case of lazy loading
      vim.g.loaded_matchparen = 1
    end,
  },

  {
    "sidebar-nvim/sidebar.nvim",
    dependencies = "sidebar-nvim/sections-dap";
    config = function()
      local sidebar = require("sidebar-nvim")
      local opts = {
        open = false,
        sections = {
          "datetime",
          "git",
          "diagnostics",
          require("dap-sidebar-nvim.breakpoints")
        },
        dap = {
          breakpoints = {
              icon = "🔍"
          }
        }
      }
      sidebar.setup(opts)
    end
  },

  {
    "luukvbaal/statuscol.nvim",
    config = function()
      -- local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        -- configuration goes here, for example:
        -- relculright = true,
        -- segments = {
        --   { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
        --   {
        --     sign = { namespace = { "diagnostic/signs" }, maxwidth = 2, auto = true },
        --     click = "v:lua.ScSa"
        --   },
        --   { text = { builtin.lnumfunc }, click = "v:lua.ScLa", },
        --   {
        --     sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
        --     click = "v:lua.ScSa"
        --   },
        -- }
      })
    end,
  },

  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require 'colorizer'.setup()
    end
  },
}
