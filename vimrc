""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Author:
"     Zimin Wang
"     simon.zmwang@gmail.com
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible               " be iMproved

" Common configurations
syntax enable
colorscheme elflord
set number

filetype plugin indent on
autocmd FileType c setlocal ts=4 sts=4 sw=4 expandtab 
autocmd FileType cpp setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType php setlocal ts=2 sts=2 sw=2 expandtab

set laststatus=2
set ruler
set autoread
set incsearch
set hlsearch

" Show matching brackets
set showmatch
set matchtime=3

" Key mappings
inoremap <c-h> <Left>
inoremap <c-j> <Down>
inoremap <c-k> <Up>
inoremap <c-l> <Right>
