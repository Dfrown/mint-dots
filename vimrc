set encoding=utf-8
colorscheme wombat256 
" set background=dark
syntax on
set timeoutlen=1000 ttimeoutlen=0
set cmdheight=2
set t_Co=256
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" User Customization
" Bundles
Bundle 'SirVer/ultisnips'
Bundle 'gmarik/vundle'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-fugitive'
Bundle 'bling/vim-airline'
Bundle 'flazz/vim-colorschemes'
Bundle 'Shougo/neocomplcache'
Bundle 'mattn/emmet-vim'
" Bundle 'tpope/vim-surround'
" Bundle 'Townk/vim-autoclose'
Bundle 'jiangmiao/auto-pairs'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/syntastic'
Plugin 'honza/vim-snippets'
" Plugin 'Valloric/YouCompleteMe'
" Bundle 'msanders/snipmate.vim'
" Bundle 'fholgado/minibufexpl.vim'
" Bundle 'jmcantrell/vim-virtualenv'
" Bundle 'airblade/vim-gitgutter'
" Bundle 'davidhalter/jedi-vim'
Bundle 'edkolev/promptline.vim'
filetype plugin indent on
" Bundle 'vim-scripts/Conque-Shell'
" map <F2>:NERDTreeToggle<CR>
let mapleader = ","
let g:mapleader = ","
map <f2> :NERDTreeToggle<CR>
nmap <leader>w :w!<cr>
nmap <leader>q :q!<cr>
set ruler
set backspace=eol,start,indent
set ignorecase
set smartcase
syntax enable
set noshowmode
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set ai
set si
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
inoremap <Nul> <C-n>
" switch buffers
map <S-j> :bprevious<cr>
map <S-k> :bnext<cr>
set number
set laststatus=2
let g:airline_theme='bubblegum'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:UltiSnipsExpandTrigger="<TAB>"
" let g:UltiSnipsJumpForardTrigger="<c-b>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"
set autochdir
set numberwidth=5
set nostartofline
set virtualedit=block
set backspace=2
" set wildmenu
" let g:airline_symbols.space = "\ua0"
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 10
let g:user_emmet_leader_key='<C-Z>'
