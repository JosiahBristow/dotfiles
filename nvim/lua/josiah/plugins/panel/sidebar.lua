return {
	"sidebar-nvim/sidebar.nvim",
	dependencies = "sidebar-nvim/sections-dap",
	config = function()
		local sidebar = require("sidebar-nvim")
		local opts = {
			open = false,
			sections = {
				"datetime",
				"git",
				"diagnostics",
				require("dap-sidebar-nvim.breakpoints"),
			},
			dap = {
				breakpoints = {
					icon = "🔍",
				},
			},
		}
		sidebar.setup(opts)
	end,
}
