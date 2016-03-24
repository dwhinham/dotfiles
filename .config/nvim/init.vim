" ---------------------------------------------------------------------------------------
" Dale's custom Vim config
" 24/03/2016
" ---------------------------------------------------------------------------------------
" 1). Install vim-plug:
"    $ curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
" 2). Install Powerline patched fonts:
"    $ git clone https://github.com/powerline/fonts
"    $ cd fonts
"    $ ./install.sh
" 3). Launch Vim and pull all the plugins:
"    :PlugInstall
" ---------------------------------------------------------------------------------------

" Post-install hook to build YouCompleteMe
fun! BuildYCM(info)
    if a:info.status == 'installed' || a:info.force
        !./install.py --clang-completer
    endif
endfun

" Enable Plug
call plug#begin()
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'guns/xterm-color-table.vim'
Plug 'jceb/vim-orgmode'
Plug 'jiangmiao/auto-pairs'
Plug 'majutsushi/tagbar'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ntpeters/vim-better-whitespace'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'samsaga2/vim-z80'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'justinmk/molokai'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'xolox/vim-easytags'
"Plug 'xolox/vim-misc'
call plug#end()

" General settings
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
let g:indent_guides_exclude_filetypes=['help', 'vundle', 'nerdtree']
let g:indent_guides_auto_colors=0
au VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=234 ctermfg=240 guibg=#1c1c1c guifg=#303030
au VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=235 ctermfg=240 guibg=#262626 guifg=#303030

" Whitespace highlighting
set list lcs=space:·,tab:▸·,trail:·,eol:¬ "¶

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
"nnoremap <C-S-tab> :tabprevious<CR>
"nnoremap <C-tab>   :tabnext<CR>
"nnoremap <C-t>     :tabnew<CR>
"inoremap <C-S-tab> <Esc>:tabprevious<CR>i
"inoremap <C-tab>   <Esc>:tabnext<CR>i
"inoremap <C-t>     <Esc>:tabnew<CR>

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
no  <silent> <F5> :call ToggleGitStatus()<CR>   " F5 toggles Git status

" Unbind the cursor keys(!)
for prefix in ['i', 'n', 'v']
    for key in ['<Up>', '<Down>', '<Left>', '<Right>']
        exe prefix . "no " . key . " <Nop>"
    endfor
endfor

" YouCompleteMe
set completeopt=menu,menuone,longest
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

" Enable code folding
set fdm=syntax      " syntax-based folding
set fdls=20         " files open with code initially unfolded
let php_folding=1
let c_folding=1
let vimsyn_folding='af'

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

au CursorHold,BufWinEnter ?* call HasFolds()

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
