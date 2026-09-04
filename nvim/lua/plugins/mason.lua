return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
  },

  config = function()
    require('mason').setup({
      ensure_installed = {
        'stylua',
      },
    })
    require('mason-lspconfig').setup({
      ensure_installed = {
        'clangd',
      },
    })

    -- SERVERS
    -- lsp config needs to be called after mason init
    vim.lsp.config('ts_ls', {})
    vim.lsp.config('tailwindcss', {})
    vim.lsp.config('html', {})
    vim.lsp.config('cssls', {})
    vim.lsp.config('jsonls', {})
    vim.lsp.config('clangd', {})
    vim.lsp.config('lua_ls', {
      settings = {
        Lua = { diagnostics = { globals = { 'vim' } } },
      },
    })
    vim.lsp.config('rust_analyzer', {})
    vim.lsp.config('eslint', {
      on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd('BufWritePre', {
          buffer = bufnr,
          command = 'EslintFixAll',
        })
      end,
    })
    -- vim.lsp.config('eslint', {
    --   on_attach = function (client, bufnr)
    --     vim.api.nvim_create_autocmd('BufWritePre', {
    --       context = { only = { 'source.fixAll.eslint' } },
    --     }) 
    --   end
    -- })
  end,

  opts = {
    ui = {
      border = "bold"
    },
  },
  --{ "jay-babu/mason-nvim-dap.nvim", dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
  --  config = function ()
  --    require("mason-nvim-dap").setup({
  --      ensure_installed = { "js" },
  --    })
  --  end
  --}
}
