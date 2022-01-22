set number
set nocompatible

set autoindent
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

set noshowmode
set backspace=start,eol,indent

runtime ./plug.vim
if has("unix")
  let s:uname = system("uname -s")
  if s:uname == "Darwin\n"
    set clipboard+=unnamedplus
  endif
endif

if has("termguicolros")
  set termguicolors
endif

"let g:gruvbox_material_palette='mix'
"let g:gruvbox_material_background='hard'
"let g:gruvbox_material_better_performance=0

colorscheme gruvbox

set exrc
