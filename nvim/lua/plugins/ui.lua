return {
    {
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
    },


    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup({
            options = {
                theme = 'dracula'
            }
            })

            require("lualine").setup({
            sections = {
                lualine_x = { "aerial" },

                -- Or you can customize it
                lualine_y = {
                {
                    "aerial",
                    -- The separator to be used to separate symbols in status line.
                    sep = " ) ",

                    -- The number of symbols to render top-down. In order to render only 'N' last
                    -- symbols, negative numbers may be supplied. For instance, 'depth = -1' can
                    -- be used in order to render only current symbol.
                    depth = nil,

                    -- When 'dense' mode is on, icons are not rendered near their symbols. Only
                    -- a single icon that represents the kind of current symbol is rendered at
                    -- the beginning of status line.
                    dense = false,

                    -- The separator to be used to separate symbols in dense mode.
                    dense_sep = ".",

                    -- Color the symbol icons.
                    colored = true,
                },
                },
            },
        })
        end
    },


    {
        "folke/tokyonight.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
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
    },

    {
        {
            'folke/noice.nvim',
            event = 'VeryLazy',
            opts = {
            -- add any options here
            },
            dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module='...'` entries
            'MunifTanjim/nui.nvim',
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            'rcarriga/nvim-notify',
            },
            config = function()
                require('noice').setup({
                    lsp = {
                            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                            override = {
                                    ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                                    ['vim.lsp.util.stylize_markdown'] = true,
                                    ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
                            },
                    },
                    -- you can enable a preset for easier configuration
                    presets = {
                            bottom_search = true,   -- use a classic bottom cmdline for search
                            command_palette = true, -- position the cmdline and popupmenu together
                            long_message_to_split = true, -- long messages will be sent to a split
                            inc_rename = false,     -- enables an input dialog for inc-rename.nvim
                            lsp_doc_border = false, -- add a border to hover docs and signature help
                    },
                })
            end
        }
    },

    {
        'stevearc/dressing.nvim',
        config = function()
            require('dressing').setup();
        end
    },
}
