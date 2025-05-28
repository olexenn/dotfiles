return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",

    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("snippets.basic")
    end,
  },

  {
    'saadparwaiz1/cmp_luasnip',
  }
}
