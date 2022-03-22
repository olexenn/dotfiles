set number
set nocompatible

set autoindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

set mouse=a

set hlsearch
set incsearch
set ignorecase
set smartcase

set noerrorbells
set novisualbell

set noshowmode
set backspace=start,eol,indent

runtime ./plug.vim
if has("unix")
  let s:uname = system("uname -s")
  if s:uname == "Darwin\n"
    set clipboard+=unnamedplus
  endif
endif

set termguicolors

set background=dark

let g:gruvbox_material_transparent_background = 1
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_palette = 'material'
colorscheme gruvbox-material

set exrc
