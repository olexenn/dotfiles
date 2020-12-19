syntax on

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

set background=dark

highlight Function cterm=none ctermfg=lightblue

" fix backspace
set backspace=indent,eol,start

call plug#begin()

Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', {'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdcommenter'
"Plug 'sheerun/vim-polyglot'

call plug#end()

nnoremap <C-p> :<C-u>FZF<CR>

vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle
