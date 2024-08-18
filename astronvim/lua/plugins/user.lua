-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        " █████  ███████ ████████ ██████   ██████",
        "██   ██ ██         ██    ██   ██ ██    ██",
        "███████ ███████    ██    ██████  ██    ██",
        "██   ██      ██    ██    ██   ██ ██    ██",
        "██   ██ ███████    ██    ██   ██  ██████",
      }
      return opts
    end,
  },
  {
    "rebelot/heirline.nvim",
    opts = function(_, opts)
      local status = require "astroui.status"

      opts.statusline = { -- statusline
        hl = { fg = "fg", bg = "bg" },
        status.component.mode {
          mode_text = { padding = { left = 1, right = 1 } },
          h1 = { fg = "#1e1e2e", bold = true },
        },
        status.component.git_branch(),
        status.component.file_info(),
        status.component.git_diff(),
        status.component.diagnostics(),
        status.component.fill(),
        status.component.cmd_info(),
        status.component.fill(),
        status.component.lsp(),
        status.component.virtual_env(),
        status.component.treesitter(),
        status.component.nav(),
        status.component.builder {
          {
            provider = function()
              local time = os.date "%H:%M" -- show hour and minute in 24 hour format
              ---@cast time string
              return status.utils.stylize(time, {
                icon = { kind = "Clock", padding = { right = 1 } }, -- use our new clock icon
                padding = { right = 1 }, -- pad the right side so it's not cramped
              })
            end,
          },
          update = { -- update should happen when the mode has changed as well as when the time has changed
            "User", -- We can use the User autocmd event space to tell the component when to update
            "ModeChanged",
            callback = vim.schedule_wrap(function(_, args)
              if -- update on user UpdateTime event and mode change
                (args.event == "User" and args.match == "UpdateTime")
                or (args.event == "ModeChanged" and args.match:match ".*:.*")
              then
                vim.cmd.redrawstatus() -- redraw on update
              end
            end),
          },
          hl = status.hl.get_attributes "mode", -- highlight based on mode attributes
          surround = { separator = "right", color = status.hl.mode_bg }, -- background highlight based on mode
        },
      }

      -- Now that we have the component, we need a timer to emit the User UpdateTime event
      vim.uv.new_timer():start( -- timer for updating the time
        (60 - tonumber(os.date "%S")) * 1000, -- offset timer based on current seconds past the minute
        60000, -- update every 60 seconds
        vim.schedule_wrap(function()
          vim.api.nvim_exec_autocmds( -- emit our new User event
            "User",
            { pattern = "UpdateTime", modeline = false }
          )
        end)
      )
    end,
  },
}
