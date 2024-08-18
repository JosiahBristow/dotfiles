return {
	"voldikss/vim-floaterm",
	config = function()
		vim.keymap.set("n", "<Leader>tf", ":FloatermToggle<CR>", opts)
	end,
}
