return {
  {
    'voldikss/vim-floaterm',
    config = function()
      vim.keymap.set('n', '<C-t>', ':FloatermToggle<CR>', opts)
    end
  },

  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = true
  }
}
