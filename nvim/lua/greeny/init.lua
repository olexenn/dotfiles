local M = {}

M.setup = function ()
  local groups = require("greeny.groups").setup()

  vim.cmd("highlight clear")
  vim.o.background = "dark"
  vim.o_colors_name = "greeny"
  for group, setting in pairs(groups) do
    vim.api.nvim_set_hl(0, group, setting)
  end
end

return M
