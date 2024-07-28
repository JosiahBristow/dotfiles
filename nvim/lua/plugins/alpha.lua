return {
  'goolord/alpha-nvim',
  event = "VimEnter",
  enabled = true,
  init = false,
  opts = function()
    local dashboard = require('alpha.themes.dashboard')
    dashboard.section.header.val = {
        [[                                                        ]],
        [[                                                        ]],
        [[ ███    ██  ███████   ██████   ██    ██  ██  ███    ███ ]],
        [[ ████   ██  ██       ██    ██  ██    ██  ██  ████  ████ ]],
        [[ ██ ██  ██  █████    ██    ██  ██    ██  ██  ██ ████ ██ ]],
        [[ ██  ██ ██  ██       ██    ██   ██  ██   ██  ██  ██  ██ ]],
        [[ ██   ████  ███████   ██████     ████    ██  ██      ██ ]],
        [[                                                        ]],
        [[                                                        ]],
    }
    dashboard.section.buttons.val = {
      dashboard.button("f", " " .. " Find file", "<cmd> Telescope find_files <cr>"),
      dashboard.button("n", " " .. " New file", "<cmd> ene <BAR> startinsert <cr>"),
      dashboard.button("r", " " .. " Recent files", "<cmd> Telescope oldfiles <cr>"),
      dashboard.button("g", " " .. " Find text", "<cmd> Telescope live_grep <cr>"),
      dashboard.button("l", "󰒲 " .. " Lazy", "<cmd> Lazy <cr>"),
      dashboard.button("q", " " .. " Quit", "<cmd> qa <cr>"),
    }
    return dashboard
  end,
  config = function(_, dashboard)
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        once = true,
        pattern = "AlphaReady",
        callback = function()
          require("lazy").show()
        end,
      })
    end
    local alpha = require('alpha')
    alpha.setup(dashboard.config)
    vim.api.nvim_create_autocmd("User", {
      once = true,
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        dashboard.section.footer.val = os.date("󰃰 %d-%m-%Y   %H:%M:%S")
            .. "  ⚡ Neovim loaded "
            .. stats.loaded
            .. "/"
            .. stats.count
            .. " plugins in "
            .. ms
            .. "ms "
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end
}
