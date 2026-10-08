return {
  "ej-shafran/compile-mode.nvim",
  version = "^5.0.0",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function ()
  ---@type CompileModeOpts
  vim.g.compile_mode = {
  }

  vim.keymap.set('n', '<leader>cc', "<cmd>Compile<CR>", { desc = "Run Comp Mode" })
  vim.keymap.set('n', '<leader>cr', "<cmd>Recompile<CR>", { desc = "Run Recomp Mode" })
  vim.keymap.set('n', '<leader>cn', "<cmd>NextError<CR>", { desc = "Run Next Err" })
  vim.keymap.set('n', '<leader>cp', "<cmd>PreviousError<CR>", { desc = "Run Prev Err" })
  end
}
