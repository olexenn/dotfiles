" basics
set number

set autoindent
set enc=utf-8

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

set hlsearch
set incsearch
set ignorecase
set smartcase

set noerrorbells
set novisualbell

" disable neovim cursor
set guicursor=

"no --insert-- and other things
set noshowmode

" plugins
call plug#begin()

" autopairs, lol
Plug 'jiangmiao/auto-pairs'

" fuzzy search files in vim
Plug 'junegunn/fzf', {'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" commenting line(s)
Plug 'scrooloose/nerdcommenter'

" colorscheme
Plug 'arcticicestudio/nord-vim'

" better syntax highlighting
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'sheerun/vim-polyglot'

" cool statusline
Plug 'itchyny/lightline.vim'

call plug#end()

" colorscheme
colorscheme nord

" lightline config
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
      \}

" FZF keybinding
nnoremap <C-p> :<C-u>FZF<CR>

" commenting keybinding
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle
