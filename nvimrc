set encoding=utf-8
colorscheme wombat256
" set background=dark
" visuals
set cmdheight=2
set t_Co=256
set noshowmode
set number
set laststatus=2
set numberwidth=5
set nowrap
set ruler
call plug#begin('~/.nvim/plugged')

" Plugins
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'flazz/vim-colorschemes'
Plug 'scrooloose/syntastic'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-airline'
Plug 'majutsushi/tagbar'
Plug 'Raimondi/delimitMate'
Plug 'davidhalter/jedi-vim'
" Plugin Graveyard
" End Plugins
call plug#end()
" Key Mappings
let mapleader = ","
let g:mapleader = ","
" Remap Save and Quit
nmap <leader>w :w!<cr>
nmap <leader>q :q!<cr>
" Create Splits
" Navigate Open Splits
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
" Navigate Buffers
map <S-j> :bprevious<cr>
map <S-k> :bnext<cr>
" Map ; to : in Normal Mode
" nnoremap <Left> :bd<cr>
" nnoremap <Right> <C-W>q
" Enter Normal Mode
" inoremap jj <Esc>
" Switch n And Space
inoremap <Nul> <C-n>
" General Editor Behaviour
syntax on
set timeoutlen=1000 ttimeoutlen=0
set nocompatible
filetype plugin indent on
set backspace=eol,start,indent
set ignorecase
set smartcase
" syntax enable
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set ai
set si
set autochdir
set nostartofline
set virtualedit=block
set backspace=2
"Plugin Configs
"
"NERDTree
map <f2> :NERDTreeToggle<cr>

" UltiSnips
" let g:UltiSnipsExpandTrigger="<Tab>"
" let g:UltiSnipsJumpForardTrigger="<C-b>"
" let g:UltiSnipsJumpBackwardTrigger="<C-z>"

" Fugitive

" Neocomplcache

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Airline
let g:airline_theme='bubblegum'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

