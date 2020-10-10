" basics
syntax on
set number
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set cmdheight=2
set enc=utf-8
set cursorline

highlight Comment ctermfg=green
highlight PreProc ctermfg=red
highlight Exception ctermfg=red
highlight Operator ctermfg=red
highlight Function ctermfg=lightblue
hi CursorLine cterm=none
hi CursorLineNR ctermfg=blue cterm=none

" Search settisgs
set incsearch
set hlsearch
set ignorecase
set smartcase

call plug#begin()

"Autopairs
Plug 'jiangmiao/auto-pairs'

" Programming languges
Plug 'sheerun/vim-polyglot'
Plug 'octol/vim-cpp-enhanced-highlight'

Plug 'scrooloose/nerdcommenter'

call plug#end()

vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle
