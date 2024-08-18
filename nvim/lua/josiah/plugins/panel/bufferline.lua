return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  opts = {
    options = {
      mode = "tabs",
      separator_style = "slant",
    },
  },
  config = function ()
    require("bufferline").setup()
		vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", {})
		vim.keymap.set("n", "<C-Tab>", ":BufferLineCyclePrev<CR>", {})
  end
}
