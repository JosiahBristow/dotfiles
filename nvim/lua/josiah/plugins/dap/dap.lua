return {
	{
		"jay-babu/mason-nvim-dap.nvim",
		event = "VeryLazy",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		opts = {
			handlers = {},
			ensure_installed = { "codelldb" },
		},
	},

	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		config = function()
			local dap = require("dap")

			vim.keymap.set("n", "<F5>", function()
				require("dap").continue()
			end)
			vim.keymap.set("n", "<F10>", function()
				require("dap").step_over()
			end)
			vim.keymap.set("n", "<F11>", function()
				require("dap").step_into()
			end)
			vim.keymap.set("n", "<s-F11>", function()
				require("dap").step_out()
			end)
			vim.keymap.set("n", "<sc-F5>", function()
				require("dap").restart_frame()
			end)
			vim.keymap.set("n", "><s-F5>", function()
				require("dap").terminate()
			end)
			vim.keymap.set("n", "<Leader>dt", function()
				require("dap").toggle_breakpoint()
			end)

			-- 设置调试相关的字符和颜色
			local dap_breakpoint_color = {
				breakpoint = {
					ctermbg = 0,
					fg = "#993939",
					bg = "#31353f",
				},
				logpoing = {
					ctermbg = 0,
					fg = "#61afef",
					bg = "#31353f",
				},
				stopped = {
					ctermbg = 0,
					fg = "#98c379",
					bg = "#31353f",
				},
			}

			vim.api.nvim_set_hl(0, "DapBreakpoint", dap_breakpoint_color.breakpoint)
			vim.api.nvim_set_hl(0, "DapLogPoint", dap_breakpoint_color.logpoing)
			vim.api.nvim_set_hl(0, "DapStopped", dap_breakpoint_color.stopped)

			-- 输入unicode的方法：ctrl + v + u 再输入unicode码
			-- 可在https://www.nerdfonts.com/cheat-sheet查询想要的字符
			local dap_breakpoint = {
				error = {
					text = "",
					texthl = "DapBreakpoint",
					linehl = "DapBreakpoint",
					numhl = "DapBreakpoint",
				},
				condition = {
					text = "",
					texthl = "DapBreakpoint",
					linehl = "DapBreakpoint",
					numhl = "DapBreakpoint",
				},
				rejected = {
					text = "",
					texthl = "DapBreakpoint",
					linehl = "DapBreakpoint",
					numhl = "DapBreakpoint",
				},
				logpoint = {
					text = "",
					texthl = "DapLogPoint",
					linehl = "DapLogPoint",
					numhl = "DapLogPoint",
				},
				stopped = {
					text = "",
					texthl = "DapStopped",
					linehl = "DapStopped",
					numhl = "DapStopped",
				},
			}

			vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
			vim.fn.sign_define("DapBreakpointCondition", dap_breakpoint.condition)
			vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
			vim.fn.sign_define("DapLogPoint", dap_breakpoint.logpoint)
			vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
		end,
	},
}
