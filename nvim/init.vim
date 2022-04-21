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
set cursorline

let g:gruvbox_material_transparent_background = 1
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_enable_italic=1
let g:gruvbox_material_palette = 'material'

"let g:nord_cursor_line_number_background = 1
"let g:nord_uniform_diff_background = 1
"let g:nord_italics = 1
"let g:nord_italic_comments = 1
"let g:nord_underline = 1

colorscheme gruvbox-material
hi! Normal ctermbg=NONE guibg=NONE

set exrc
