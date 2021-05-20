set exrc "source .vimrc if present in working directory
set secure
set encoding=utf-8

set backspace=2
set ruler
set hlsearch
set laststatus=2
set number

syntax on
set background=dark
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set ai "Auto indent
set si "Smart indent
set cinoptions+=g0
set t_Co=256
set synmaxcol=200

set wildmenu
set incsearch
set ignorecase
set showmatch

set pastetoggle=<F2>
set showmode
set foldmethod=indent
set nofoldenable
set maxmempattern=2000
"set signcolumn=yes

au FileType yaml setlocal sw=2 sts=2 ts=2
au FileType jinja2 setlocal sw=2 sts=2 ts=2
au FileType gitcommit setlocal spell tw=80
au FileType json setlocal sw=2 sts=2 ts=2

"vim plug
call plug#begin(stdpath('data') . '/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'jiangmiao/auto-pairs'
Plug 'rizzatti/dash.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf'

Plug 'tomasiser/vim-code-dark'
Plug 'fneu/breezy'

Plug 'pearofducks/ansible-vim'
Plug 'hashivim/vim-terraform'
Plug 'juliosueiras/vim-terraform-completion'

Plug 'neoclide/coc.nvim'
call plug#end()

colorscheme breezy

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

" airline
let g:airline_theme='luna'
let g:airline#extensions#whitespace#enabled = 1

" terraform
let g:terraform_align=1
let g:terraform_fmt_on_save=1

" Terraform completion
" (Optional)Hide Info(Preview) window after completions
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
" (Optional) Default: 1, enable(1)/disable(0) terraform module registry completion
let g:terraform_registry_module_completion = 0

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" Show yank history
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)
" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)
" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'
" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)
" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

" coc-highlight
autocmd CursorHold * silent call CocActionAsync('highlight')

" coc-fzf-preview
nnoremap <C-b> :<C-u>CocCommand fzf-preview.Buffers<CR>
nnoremap <C-p> :<C-u>CocCommand fzf-preview.GitFiles<CR>
let g:fzf_preview_grep_cmd = 'ag --nogroup --column --color --numbers '
let g:fzf_preview_preview_key_bindings = 'ctrl-d:preview-page-down,ctrl-u:preview-page-up,?:toggle-preview'
let g:fzf_preview_command = 'bat --color=always --plain --number {-1}' " Installed bat
let g:fzf_preview_lines_command = 'bat --color=always --plain --number' " Installed bat
nnoremap  <leader>ag  :<C-u>CocCommand fzf-preview.ProjectGrep<Space>
let $FZF_PREVIEW_PREVIEW_BAT_THEME = 'ansi'

" Dash
nmap <silent> <leader>d <Plug>DashSearch
