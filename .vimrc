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
let mapleader=','
nnoremap <c-l> gt
nnoremap <c-h> gT
nnoremap <leader>t :tabnew<CR>

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

autocmd vimenter * NERDTree

let g:winManagerAutoOpen=1

" integrate nerdtree into winManager
let g:NERDTree_title="[NERDTree]"
function! NERDTree_Start()
	execute "NERDTree"
endfunction

function! NERDTree_IsValid()
	return 1
endfunction
let g:winManagerWindowLayout="NERDTree|TagList"
nnoremap <C-n> :WMToggle<CR>

" }}

" Configurations for taglist
let Tlist_Ctags_Cmd="/usr/bin/exCtags"
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Inc_Winwidth=1
let Tlist_File_Fold_Auto_Close=1
let Tlist_Show_Menu=1
