return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require("lualine").setup({
        tabline = {
          lualine_a = {
            {
              'tabs',
              tab_max_length = 40,
              mode = 2,
              path = 0,

              fmt = function(name, context)
                local buflist = vim.fn.tabpagebuflist(context.tabnr)
                local winnr = vim.fn.tabpagewinnr(context.tabnr)
                local bufnr = buflist[winnr]
                local mod = vim.fn.getbufvar(bufnr, "&mod")
                return name .. (mod == 1 and '+' or '')
              end
            }
          },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {}
        }
      })
    end,
  },
}
