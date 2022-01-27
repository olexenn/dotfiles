if !exists('g:loaded_vimtex') | finish | endif

filetype plugin indent on

syntax enable

let g:vimtex_compiler_latexmk = {
	\ 'backend': 'nvim',
	\ 'background' : 0,
	\ 'build_dir' : '',
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

map <C-d> :VimtexCompile<CR>
