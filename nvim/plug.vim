if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin()
Plug 'sainnhe/gruvbox-material'
Plug 'sickill/vim-monokai'
Plug 'gruvbox-community/gruvbox'

Plug 'nvim-treesitter/nvim-treesitter', { 'do': 'TSUpdate' }
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

Plug 'neovim/nvim-lspconfig'
Plug 'tami5/lspsaga.nvim'
Plug 'folke/lsp-colors.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'onsails/lspkind-nvim'

Plug 'L3MON4D3/LuaSnip'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'kristijanhusak/defx-git'
Plug 'kristijanhusak/defx-icons'
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'windwp/nvim-autopairs'
Plug 'windwp/nvim-ts-autotag'
Plug 'scrooloose/nerdcommenter'
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
Plug 'tpope/vim-fugitive'

Plug 'lervag/vimtex'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise'
call plug#end()
