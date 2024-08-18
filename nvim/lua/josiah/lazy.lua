local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	{ import = "josiah.plugins" },
	{ import = "josiah.plugins.lsp" },
	{ import = "josiah.plugins.dap" },
	{ import = "josiah.plugins.lang-support" },
	{ import = "josiah.plugins.terminal" },
	{ import = "josiah.plugins.commit" },
	{ import = "josiah.plugins.cmp" },
	{ import = "josiah.plugins.panel" },
	{ import = "josiah.plugins.fmt" },
	{ import = "josiah.plugins.colorscheme" },
}, {
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
})
