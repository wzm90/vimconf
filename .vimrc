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
Bundle 'taglist.vim'
Bundle 'a.vim'
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
		let check_ctags='ctags'. ' --version 2>&1|grep Exuberant'
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
		let check_ctags='tags'. ' --version 2>&1|grep Exuberant'
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
	let loaded_taglist='no'
endif

" Location of the exuberant ctags tool
if !exists('Tlist_Ctags_Cmd')
	let Tlist_Ctags_Cmd=DetectExuberantCtags()
	if Tlist_Ctags_Cmd == 'null'
		echomsg 'Taglist: Exuberant ctags (http://ctags.sf.net) ' .
                        \ 'not found in PATH. Plugin is not loaded.'
		" Skip loading the plugin
		let loaded_taglist='no'
	else
		" Configurations for taglist
		let Tlist_Exit_OnlyWindow=1
		let Tlist_WinWidth=31
		let Tlist_Inc_Winwidth=1
		let Tlist_Auto_Update=1
		let Tlist_File_Fold_Auto_Close=1
		let Tlist_GainFocus_On_ToggleOpen=0
		nnoremap <c-t><c-l> :TlistToggle<cr>
		inoremap <c-t><c-l> <Esc>:TlistToggle<cr>
	endif
endif

" NERDTree configurations {{
let NERDTreeWinPos="right"
" ignore *.o file
let NERDTreeIgnore=['.o$[[file]]']
nnoremap <c-n><c-t> :NERDTreeToggle<cr>
inoremap <c-n><c-t> <Esc>:NERDTreeToggle<cr>
" }}


" Common configurations {{
syntax enable
colorscheme elflord
set number

filetype plugin indent on
autocmd FileType c setlocal ts=4 sts=4 sw=4 expandtab 
autocmd FileType cpp setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab

set laststatus=2
set ruler
set autoread
" set foldmethod
set fdm=indent
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

