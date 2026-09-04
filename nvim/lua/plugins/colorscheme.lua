return {
  -- {
  --    "sainnhe/gruvbox-material",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.g.gruvbox_material_background = "hard"
  --     vim.g.gruvbox_material_transparent_background = "1"
  --     vim.cmd.colorscheme("gruvbox-material")
  --   end,
  -- }
  {
    "RostislavArts/naysayer.nvim",
    priority = 1000,
    lazy = false,
    config = function ()
      vim.cmd.colorscheme('naysayer')
    end
  }
}
