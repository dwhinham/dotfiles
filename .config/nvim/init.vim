" ---------------------------------------------------------------------------------------
" Dale's custom Vim config
" 11/04/2016
" ---------------------------------------------------------------------------------------
" 1). Install vim-plug:
"    $ curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" 2). Install Powerline patched fonts:
"    $ git clone https://github.com/powerline/fonts
"    $ cd fonts
"    $ ./install.sh
" 3). Launch Vim and pull all the plugins:
"    :PlugInstall
" ---------------------------------------------------------------------------------------

" Enable Plug
call plug#begin()
Plug 'ARM9/arm-syntax-vim'
Plug 'Konfekt/FastFold'
Plug 'Rip-Rip/clang_complete'
Plug 'Shougo/deoplete.nvim'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'c9s/perlomni.vim'
Plug 'critiqjo/lldb.nvim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'guns/xterm-color-table.vim'
Plug 'jceb/vim-orgmode'
Plug 'jiangmiao/auto-pairs'
Plug 'justinmk/molokai'
Plug 'majutsushi/tagbar'
Plug 'mhinz/vim-grepper'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ntpeters/vim-better-whitespace'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'rhysd/vim-clang-format'
Plug 'samsaga2/vim-z80'
Plug 'scottferg/armasm.vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'zchee/deoplete-clang'
Plug 'zchee/deoplete-jedi'
call plug#end()

" General settings
set lz                          " lazy redraw
set nu                          " line numbers
set rnu                         " relative line numbers
set ls=2                        " always show status bar
set shortmess+=I                " disable splash screen
syntax enable                   " enable syntax highlighting
set fillchars=vert:│,fold:─     " custom line drawing chars
set showbreak=↪                 " line wrap character
let mapleader='\'               " leader key
set tm=500                      " timeout for key sequence to complete
set updatetime=500              " timeout for cursor hold
set nosmd                       " hide redundant mode line
set noeb vb                     " disable beeping and flashing
set hid                         " hide buffers
set so=5                        " 5-line scrolloff
set tw=80                       " 80 column limit
au BufWinEnter * set cc=+1      " text width marker
set cot=menu

" Apply colorscheme
color molokai
set hlsearch
hi Normal ctermbg=none
hi Search ctermfg=235 ctermbg=121

" GUI tweaks
if has("gui_running")
    set go-=l go-=L go-=r go-=R     " get rid of scrollbars
    set go-=T                       " get rid of toolbar
    set lines=40 co=120             " resize window
endif

" Tab stops
set et ts=4 sts=4 sw=4

" Use <C-L> to clear the highlighting of search results
if maparg('<C-L>', 'n') ==# ''
    nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

" Mouse support
set mouse=a

" Indent guides
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1
let g:indent_guides_exclude_filetypes=['help', 'nerdtree']
let g:indent_guides_auto_colors=0
au VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=234 ctermfg=240 guibg=#1c1c1c guifg=#303030
au VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=235 ctermfg=240 guibg=#262626 guifg=#303030

" Whitespace highlighting
set list lcs=space:·,tab:▸·,trail:·,eol:¬

" Use system clipboard
set clipboard+=unnamedplus

" Enable patched fonts for Airline
if has("mac")
    set gfn=TerminusBold24:h12
    set lsp=2
elseif has ("unix")
    set gfn=Source\ Code\ Pro\ for\ Powerline\ Medium\ 10
else
    " TODO: Windows
endif
let g:airline_powerline_fonts=1

" Airline
let g:airline_theme='badwolf'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamemod=':t'
let g:airline#extensions#tabline#buffer_idx_mode=1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

nmap <c-tab> :bnext<cr>
nmap <c-s-tab> :bprevious<cr>

" CtrlP
let g:ctrlp_extensions=['dir', 'tag', 'buffertag', 'line']
let g:ctrlp_cmd='CtrlPLastMode --dir'
let g:ctrlp_user_command='ag %s -l --nocolor -g ""'
let g:ctrlp_open_multiple_files='1r'
let g:ctrlp_use_caching=0
let g:ctrlp_by_filename=1
let g:ctrlp_regexp=1

" Grepper
nmap <leader>g :Grepper<cr>

" NERDTree
let NERDTreeMinimalUI=1
let NERDTreeMouseMode=2
let NERDTreeShowBookmarks=1
let NERDTreeShowHidden=1
let g:NERDTreeDirArrowExpandable='▶'
let g:NERDTreeDirArrowCollapsible='▼'
au FileType nerdtree setlocal nolist

" Close vim if NERDTree is the only remaining window
au WinEnter * call s:CloseIfOnlyNerdTreeLeft()
fun! s:CloseIfOnlyNerdTreeLeft()
    if exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1 && winnr("$") == 1
        q
    endif
endfun

" Key bindings for tmux
if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

nno <silent> <F2> :set list! list?<CR>          " F2 toggles showing invisibles
nno <silent> <F3> :NERDTreeToggle<CR>           " F3 toggles NERDTree
nno <silent> <F4> :TagbarToggle<CR>             " F4 toggles Tagbar
no  <silent> <F5> :SyntasticCheck<CR>           " F5 runs Syntastic
no  <silent> <F6> :call ToggleGitStatus()<CR>   " F6 toggles Git status

" Unbind the cursor keys(!)
for prefix in ['i', 'n', 'v']
    for key in ['<Up>', '<Down>', '<Left>', '<Right>']
        exe prefix . "no " . key . " <Nop>"
    endfor
endfor

" Tab and Shift-Tab indent
vnoremap <tab>   ><cr>gv
vnoremap <s-tab> <<cr>gv

" deoplete
let g:deoplete#enable_at_startup=1
let g:deoplete#max_menu_width=1000
let g:deoplete#sources#clang#libclang_path='/usr/lib/x86_64-linux-gnu/libclang-3.6.so.1'
let g:deoplete#sources#clang#clang_header='/usr/lib/clang'

" Tab-completion
inoremap <silent><expr> <tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr> <s-Tab> pumvisible() ? "\<C-p>" : "\<s-Tab>"

" Hide popup when leaving insert mode
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" clang_complete
let g:clang_library_path='/usr/lib/x86_64-linux-gnu/libclang-3.6.so.1'

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0
let g:syntastic_c_config_file='.clang_complete'

" clang-format
let g:clang_format#command='/usr/bin/clang-format-3.6'

" Enable code folding
set fdls=20                         " files open with code initially unfolded
let g:tex_fold_enabled=1
let g:vimsyn_folding='af'
let g:xml_syntax_folding=1
let g:php_folding=1
let g:perl_fold=1

" Nice conditional fold column function from:
" http://stackoverflow.com/questions/8757168/gvim-automatic-show-foldcolumn-when-there-are-folds-in-a-file
fun HasFolds()
    "Attempt to move between folds, checking line numbers to see if it worked.
    "If it did, there are folds.
    "
    if &bt == 'nofile'
        return
    endif

    fun! HasFoldsInner()
        let origline=line('.')
        norm zk
        if origline==line('.')
            norm zj
            if origline==line('.')
                return 0
            else
                return 1
            endif
        else
            return 1
        endif
        return 0
    endfun

    let l:winview=winsaveview() "save window and cursor position
    let foldsexist=HasFoldsInner()
    if foldsexist
        set foldcolumn=1
    else
        "Move to the end of the current fold and check again in case the
        "cursor was on the sole fold in the file when we checked
        if line('.')!=1
            norm [z
            norm k
        else
            norm ]z
            norm j
        endif
        let foldsexist=HasFoldsInner()
        if foldsexist
            set foldcolumn=1
        else
            set foldcolumn=0
        endif
    end
    call winrestview(l:winview) "restore window/cursor position
endfun

"au CursorHold,BufWinEnter ?* call HasFolds()

fun ToggleGitStatus()
    if !exists(':Gstatus')
        return
    endif

    fun! GitStatusWindowOpen()
        for n in range(1, winnr('$'))
            if getwinvar(n, '&pvw') == 1 && getwinvar(n, '&ft') == 'gitcommit'
                return 1
            endif
        endfor
        return 0
    endfun

    if GitStatusWindowOpen()
        pclo
    else
        Gstatus
    endif
endfun

" Set shell to bash if launched from fish
if &shell =~# 'fish$' || &shell =~# 'tcsh$'
    set shell=/bin/bash
    let $BASH_ENV="~/.bash_aliases"
endif

" Enable ARM ASM syntax highlighting
let asmsyntax='armasm'
let filetype_inc='armasm'
au BufNewFile,BufRead *.s,*.S if @% =~? "gcc" | set filetype=arm | endif
