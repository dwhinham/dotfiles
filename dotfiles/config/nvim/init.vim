"less Packages
call plug#begin()
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
Plug 'iamcco/mathjax-support-for-mkdp'
Plug 'jalvesaq/Nvim-R'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'lilydjwg/colorizer'
Plug 'morhetz/gruvbox'
Plug 'ntpeters/vim-better-whitespace'
"Plug 'racer-rust/vim-racer'
Plug 'rust-lang/rust.vim'
"Plug 'shougo/deoplete-clangx'
Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'shougo/neosnippet-snippets'
Plug 'shougo/neosnippet.vim'
Plug 'shougo/neoinclude.vim'
Plug 'tell-k/vim-autopep8'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'yggdroot/indentline'
Plug 'zchee/deoplete-jedi'
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
call plug#end()

" Color scheme
set background=dark
colorscheme gruvbox
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

set spell spelllang=en_gb

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
let g:racer_experimental_completer=1
set completeopt-=preview
inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ deoplete#mappings#manual_complete()

function! s:check_back_space() abort "{{{
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}


let g:LanguageClient_serverCommands = {
  \ 'rust': ['rustup', 'run', 'stable', 'rls'],
  \ 'c': ['ccls'],
  \ 'cpp': ['ccls'],
  \ }


if exists('+termguicolors')
	let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
endif

" Markdown Preview
let g:mkdp_markdown_css = "/home/dale/node_modules/github-markdown-css/github-markdown.css"
let g:mkdp_browser = 'vimb'
let g:mkdp_auto_start = 1
