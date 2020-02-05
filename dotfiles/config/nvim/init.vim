"less Packages
call plug#begin()
"Plug 'shougo/neoinclude.vim'
"Plug 'shougo/neosnippet-snippets'
"Plug 'shougo/neosnippet.vim'
Plug 'airblade/vim-gitgutter'
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'editorconfig/editorconfig-vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
Plug 'iamcco/mathjax-support-for-mkdp'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'
Plug 'lilydjwg/colorizer'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'morhetz/gruvbox'
Plug 'ntpeters/vim-better-whitespace'
Plug 'rust-lang/rust.vim'
Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'shougo/echodoc.vim'
Plug 'tell-k/vim-autopep8'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
Plug 'yggdroot/indentline'
Plug 'yuezk/vim-js'
Plug 'zchee/deoplete-jedi'
call plug#end()

" Color scheme
set background=dark
colorscheme dracula
"hi Normal guibg=NONE ctermbg=NONE

" Misc settings
set mouse=a
set cb=unnamedplus
set ar
set list
set showbreak=↪\
set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨
set shortmess=I
set relativenumber
set ts=2
set sw=2
set hid

set spelllang=en_gb

" Airline
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#enabled=1
set noshowmode

" FZF
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noruler
  \| autocmd BufLeave <buffer> set laststatus=2 ruler

" Mapping selecting mappings
nmap <leader>b :Buffers<cr>
nmap <leader>h :Files ~<cr>
nmap <leader>f :Files<cr>
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

" Deoplete
let g:deoplete#enable_at_startup=1
set completeopt-=preview
inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ deoplete#mappings#manual_complete()

function! s:check_back_space() abort "{{{
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

" Echodoc
let g:echodoc#enable_at_startup=1

" LanguageClient
let g:LanguageClient_windowLogMessageLevel='Error'
let g:LanguageClient_serverCommands = {
  \ 'c': ['ccls'],
  \ 'cpp': ['ccls'],
  \ 'javascript': ['javascript-typescript-stdio'],
  \ 'typescript': ['javascript-typescript-stdio'],
  \ 'typescriptreact': ['javascript-typescript-stdio'],
  \ 'rust': ['rustup', 'run', 'stable', 'rls'],
  \ }

let g:LanguageClient_rootMarkers = {
  \ 'javascript': ['jsconfig.json'],
  \ 'typescript': ['tsconfig.json'],
  \ }

nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

if exists('+termguicolors')
	let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
endif

" Markdown Preview
let g:mkdp_markdown_css = "/home/dale/node_modules/github-markdown-css/github-markdown.css"
let g:mkdp_browser = 'vimb'
let g:mkdp_auto_start = 1

" <Ctrl-l> redraws the screen and removes any search highlighting
nnoremap <silent> <C-l> :nohl<CR><C-l>
