""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Author:
"     Zimin Wang
"     simon.zmwang@gmail.com
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable
colorscheme elflord

"common configurations {{
set number

filetype plugin indent on
autocmd FileType c setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab 
autocmd FileType cpp setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab

set laststatus=2
set ruler
set autoread

" }}

" key mappings {{
inoremap <c-h> <Left>
inoremap <c-j> <Down>
inoremap <c-k> <Up>
inoremap <c-l> <Right>
" brackets completion
inoremap { {}<Left>
inoremap {<CR> {<CR>}<Up><Esc>o
inoremap {{ {

inoremap ( ()<Left>
inoremap (( (
" The following map doesn't work in versions prior to Vim 7.0
inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"

inoremap [ []<Left>
inoremap [[ [

nnoremap <C-n> :WMToggle<CR>
" The following map doesn't work in versions prior to Vim 7.0
inoremap <expr> ] strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"

" }}

" config for plugins {{
execute pathogen#infect()

" load NERDTree upon entering vim
autocmd vimenter * NERDTree

" open winManager automatically
let g:winManagerAutoOpen=1

" integrate nerdtree into winManager
let g:NERDTree_title="[NERDTree]"
function! NERDTree_Start()
	execute "NERDTree"
endfunction

function! NERDTree_IsValid()
	return 1
endfunction

" detect if the user has installed exuberant ctags
" if not, disable Taglist
"
" The following are copied from taglist.vim
if !exists('*system')
	echomsg 'Taglist: Vim system() built-in function is not available. ' .
                    \ 'Plugin is not loaded.'
	let loaded_taglist = 'no'
endif

" Location of the exuberant ctags tool
if !exists('Tlist_Ctags_Cmd')
	if executable('exuberant-ctags')
		" On Debian Linux, exuberant ctags is installed
		" as exuberant-ctags
		let Tlist_Ctags_Cmd = 'exuberant-ctags'
	elseif executable('exctags')
		" On Free-BSD, exuberant ctags is installed as exctags
		let Tlist_Ctags_Cmd = 'exctags'
	elseif executable('ctags')
		let Tlist_Ctags_Cmd = 'ctags'
	elseif executable('ctags.exe')
		let Tlist_Ctags_Cmd = 'ctags.exe'
	elseif executable('tags')
		let Tlist_Ctags_Cmd = 'tags'
	else
		echomsg 'Taglist: Exuberant ctags (http://ctags.sf.net) ' .
                        \ 'not found in PATH. Plugin is not loaded.'
		" Skip loading the plugin
		let loaded_taglist = 'no'
		let g:winManagerWindowLayout = "NERDTree"
	endif
endif

if !exists('loaded_taglist')
	" On some systems, like Mac OS X, the old ctags is installed by
	" default instead of Exuberant Ctags. If this is the case, disable
	" taglist
	let check_ctags = Tlist_Ctags_Cmd . ' --version 2>&1|grep Exuberant'
	"let ctags_version=system("$Tlist_Ctags_Cmd --version 2>&1|grep Exuberant")
	let ctags_version = system(check_ctags)
	if empty(ctags_version)
		let g:winManagerWindowLayout = "NERDTree"
		let loaded_taglist = 'no'
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
	" }}

	endif
endif
