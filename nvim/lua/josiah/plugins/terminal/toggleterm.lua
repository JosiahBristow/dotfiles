return {
	"akinsho/toggleterm.nvim",
	config = true,
	cmd = "ToggleTerm",
	-- keys = { { "", "ToggleTerm", desc = "Toggle floating terminal" } },
	-- opts = {
	-- open_mapping = [[]],
	-- direction = "horizontal",
	-- shade_filetypes = {},
	-- hide_numbers = true,
	-- insert_mappings = true,
	-- terminal_mappings = true,
	-- start_in_insert = true,
	-- close_on_exit = true,
	-- },
	keys = {
		{
			"<leader>tv",
			function()
				local count = vim.v.count1
				require("toggleterm").toggle(count, 0, vim.loop.cwd(), "vertical")
			end,
			desc = "ToggleTerm (vertical)",
		},
		{
			"<leader>th",
			function()
				local count = vim.v.count1
				require("toggleterm").toggle(count, 10, vim.loop.cwd(), "horizontal")
			end,
			desc = "ToggleTerm (horizontal)",
		},
	},
}
