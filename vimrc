set exrc "source .vimrc if present in working directory
set secure
set encoding=utf-8

set backspace=2
set ruler
set hlsearch
set laststatus=2
set number

syntax on
colorscheme codedark
set background=dark
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set ai "Auto indent
set si "Smart indent
set cinoptions+=g0
set t_Co=256

set wildmenu
set incsearch
set ignorecase
set showmatch

set pastetoggle=<F2>
set showmode
set foldmethod=indent
set nofoldenable
set maxmempattern=2000

"vim plug
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tomasiser/vim-code-dark'
Plug 'pearofducks/ansible-vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'vim-syntastic/syntastic'
call plug#end()

" tab
nnoremap <Tab> :tabn<CR>
nnoremap <S-Tab> :tabp<CR>

" tagbar
map <F8> :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_width = 60

" nerdtree
map <C-l> :NERDTreeToggle<CR>
map <C-f> :NERDTreeFind<CR>

" fzf
nnoremap <C-b> :Buffers<CR>
nnoremap <C-p> :GFiles<CR>

" airline
let g:airline_theme='codedark'

au FileType yaml setlocal sw=2 sts=2 ts=2
au FileType jinja2 setlocal sw=2 sts=2 ts=2
au FileType gitcommit setlocal spell tw=80
au FileType json setlocal sw=2 sts=2 ts=2

" vim-go
let g:go_fmt_command = "goimports"
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>
autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <leader>r <Plug>(go-run)
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint', 'errcheck']

" move cursor without using arrow keys
imap <C-h> <C-o>h
imap <C-j> <C-o>j
imap <C-k> <C-o>k
imap <C-l> <C-o>l

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_go_checkers = ['golint', 'govet', 'gometalinter']
let g:syntastic_go_gometalinter_args = ['--disable-all', '--enable=errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
let g:go_list_type = "quickfix"
