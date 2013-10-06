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
autocmd FileType c setlocal tabstop=2 softtabstop=2 shiftwidth=2 
autocmd FileType cpp setlocal tabstop=2 softtabstop=2 shiftwidth=2 
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
let CtagsVersion=system("ctags --version 2>&1|grep Exuberant")
:if empty(CtagsVersion)
	let g:winManagerWindowLayout="NERDTree"
:else
	let g:winManagerWindowLayout="NERDTree|TagList"
	" Configurations for taglist
	let Tlist_Ctags_Cmd=system("which ctags|tr -d '\n'")
	let Tlist_Show_One_File=1
	let Tlist_Exit_OnlyWindow=1
	let Tlist_Inc_Winwidth=1
	let Tlist_File_Fold_Auto_Close=1
	let Tlist_Show_Menu=1
	" Config for Ctags
	set tags+=./.git/tags
	" for generating ctags tag
	nnoremap <F5> :!ctags -R -f ./.git/tags --c++-kinds=+p --fields=+iaS --extra=+q --tag-relative=yes --exclude=.git .<CR>
	" }}

:endif
nnoremap <C-n> :WMToggle<CR>
