if !exists('g:loaded_vimtex') | finish | endif

filetype plugin indent on

syntax enable

let g:vimtex_compiler_latexmk = {
	\ 'backend': 'nvim',
	\ 'background' : 0,
	\ 'build_dir' : 'build',
	\ 'continuous' : 1,
	\ 'options' : [
	\   '-pdf',
	\   '--file-line-error',
	\   '--synctex=1',
	\   '--interaction=nonstopmode',
	\   '--shell-escape',
	\ ],
	\}
let g:vimtex_view_method = 'skim'
let g:vimtex_compiler_method = 'latexmk'
set conceallevel=1
let g:tex_conceal='abdmg'

map <C-d> :VimtexCompile<CR>
