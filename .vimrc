""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Author:
"     Zimin Wang
"     simon.zmwang@gmail.com
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Begin vundle configurations (https://github.com/gmarik/vundle)
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

" End vundle configurations


" My Bundles
Bundle 'scrooloose/nerdtree'
Bundle 'winmanager'
Bundle 'taglist.vim'
"

" Config for my bundles {{

" Detect if the user has installed exuberant ctags
" If not, do not load Taglist

" The following function are adapted from taglist.vim
function! DetectExuberantCtags()
	if executable('exuberant-ctags')
		" On Debian Linux, exuberant ctags is installed
		" as exuberant-ctags
		return 'exuberant-ctags'
	elseif executable('exctags')
		" On Free-BSD, exuberant ctags is installed as exctags
		return 'exctags'
	elseif executable('ctags')
		" On some OS, ctags is installed instead of exuberant ctags
		" by default
		let check_ctags = 'ctags'. ' --version 2>&1|grep Exuberant'
		if empty(system(check_ctags))
			return 'null'
		else
			return 'ctags'
		endif	
	elseif executable('ctags.exe')
		return 'ctags.exe'
	elseif executable('tags')
		" On some OS, ctags is installed instead of exuberant ctags
		" by default
		let check_ctags = 'tags'. ' --version 2>&1|grep Exuberant'
		if empty(system(check_ctags))
			return 'null'
		else
			return 'tags'
		endif	
	else
		return 'null'
	endif
endfunction

if !exists('*system')
	echomsg 'Taglist: Vim system() built-in function is not available. ' .
                    \ 'Plugin is not loaded.'
	let loaded_taglist = 'no'
endif

" Location of the exuberant ctags tool
if !exists('Tlist_Ctags_Cmd')
	let Tlist_Ctags_Cmd = DetectExuberantCtags()
	if Tlist_Ctags_Cmd == 'null'
		echomsg 'Taglist: Exuberant ctags (http://ctags.sf.net) ' .
                        \ 'not found in PATH. Plugin is not loaded.'
		" Skip loading the plugin
		let loaded_taglist = 'no'
		let g:winManagerWindowLayout = "NERDTree"
	else
		let g:winManagerWindowLayout = "NERDTree|TagList"
		" Configurations for taglist
		let Tlist_Show_One_File = 1
		let Tlist_Exit_OnlyWindow = 1
		let Tlist_Inc_Winwidth = 1
		let Tlist_File_Fold_Auto_Close = 1
		let Tlist_Show_Menu = 1
		" Config for Ctags
		set tags+=./.git/tags
		" for generating ctags tag
		nnoremap <F5> :!ctags -R -f .tags --c++-kinds=+p --fields=+iaS --extra=+q --tag-relative=yes --exclude=.git .<CR>
	endif
endif

" Open winManager upon entering vim
" An additional empty window always shows up upon entering vim as a result of
" integrating NERDTree and winManager. Add the following line to fix it.
autocmd vimenter * if exists(':WManager') | execute ':WManager' | execute ':q' | endif

" Set the width of NERDTree area, default is 25
let g:winManagerWidth = 40
" Quit Vim when user quit editing window and leave only NERDTree/TagList windows.
let g:persistentBehaviour = 0

" Integrate nerdtree into winManager
let g:NERDTree_title = '[NERDTree]'
function! NERDTree_Start()
	execute 'NERDTree'
endfunction

function! NERDTree_IsValid()
	return 1
endfunction



" Common configurations {{
syntax enable
colorscheme elflord
set number

filetype plugin indent on
autocmd FileType c setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab 
autocmd FileType cpp setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab

set laststatus=2
set ruler
set autoread

" }}

" Key mappings {{
inoremap <c-h> <Left>
inoremap <c-j> <Down>
inoremap <c-k> <Up>
inoremap <c-l> <Right>
" Brackets completion
inoremap { {}<Left>
inoremap {<CR> {<CR>}<Up><Esc>o
inoremap {{ {

inoremap ( ()<Left>
inoremap (( (
" The following map doesn't work in versions prior to Vim 7.0
inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"

inoremap [ []<Left>
inoremap [[ [

" The following map doesn't work in versions prior to Vim 7.0
inoremap <expr> ] strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"

" }}

