"#########################################################################
"#                  VINOD's Vimrc SETTINGS                               #
"#########################################################################
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
" see :h vundle for more details or wiki for FAQ
"#########################################################################
"######### Vundle Plugins #########
" Configured Vundle Plugins {{{1
filetype off
set runtimepath=$VIM,$VIMRUNTIME
set nocompatible
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'
    Plugin 'bundle/vim-surround'
    Plugin 'raimondi/delimitmate'
    "Auto Completion 
    Plugin 'c.vim' 

    "TAGBAR: A Class Outline Viewer For Vim
    Plugin 'majutsushi/tagbar'

    "Easy align
    Plugin 'junegunn/vim-easy-align'

    "Search plugins
    Plugin 'bundle/incsearch-easymotion.vim'
    Plugin 'bundle/incsearch-fuzzy.vim'
    Plugin 'bundle/incsearch.vim'
    Plugin 'pbogut/fzf-mru.vim'

    "Easy commenting
    Plugin 'bundle/vim-commentary'

    "Moving around
    Plugin 'bundle/vim-easymotion'

    "Indent guide lines.
    Plugin 'nathanaelkane/vim-indent-guides'

    "Plugin 'bundle/supertab'
    Plugin 'scrooloose/syntastic'
    
    "Plugin 'bundle/ctrlp.vim'

    "Highlighting C/C++ Functions
    Plugin 'esneider/vim-simlight'

    "Highlight typedef, enums etc
    Plugin 'TagHighlight'

    " Status line themes
    Plugin 'bundle/vim-airline'
    Plugin 'bundle/vim-airline-themes'
    Plugin 'bundle/vim-colors-solarized'
    "Plugin 'yggdroot/indentline'

    Plugin 'vimwiki/vimwiki'
    "Plugin 'tibabit/vim-todo'
    " Copy paste across tmux.
    Plugin 'gsiano/vmux-clipboard'

    "Zoom in/out multiple windows
    "Plugin 'ZoomWin'

    "Narrow Region
    "Plugin 'chrisbra/nrrwrgn'

    "Session Management
    "Plugin 'manasthakur/vimsessionist'
    "Plugin 'tpope/vim-obsession'
    "Tame the quickfix window
    Plugin 'romainl/vim-qf'
    "Plugin 'xolox/vim-misc'
    "Plugin 'xolox/vim-session'

    "Git Plugins
    Plugin 'airblade/vim-gitgutter'
    Plugin 'tpope/vim-fugitive'

    "vim Maps
    Plugin 'robcsi/viewmaps.vim'

    "vim Rainbow Paranthesis
    Plugin 'kien/rainbow_parentheses.vim'

    "Tab Renaming
    Plugin 'gcmt/taboo.vim'

    "vim NERDTree Plugin
    Plugin 'scrooloose/nerdtree'

    "Vim UndoTree
    "Plugin 'mbbill/undotree'

    "Vim exchange
    "Plugin 'tommcdo/vim-exchange'

    "Vim Unimpared
    "Plugin 'tpope/vim-unimpaired'
    
    call vundle#end()
"}}}1
" Plugin Specific Configurations {{{1
    "Airline specific settings
    let g:airline_theme='base16_bright'
    
    "Rainbow Paranthesis
        "===========================================================================
        let g:rbpt_colorpairs = [
            \ ['brown',       'RoyalBlue3'],
            \ ['Darkblue',    'SeaGreen3'],
            \ ['darkgray',    'DarkOrchid3'],
            \ ['darkgreen',   'firebrick3'],
            \ ['darkcyan',    'RoyalBlue3'],
            \ ['darkred',     'SeaGreen3'],
            \ ['darkmagenta', 'DarkOrchid3'],
            \ ['brown',       'firebrick3'],
            \ ['gray',        'RoyalBlue3'],
            \ ['black',       'SeaGreen3'],
            \ ['darkmagenta', 'DarkOrchid3'],
            \ ['Darkblue',    'firebrick3'],
            \ ['darkgreen',   'RoyalBlue3'],
            \ ['darkcyan',    'SeaGreen3'],
            \ ['darkred',     'DarkOrchid3'],
            \ ['red',         'firebrick3'],
            \ ]
    
        let g:rbpt_max = 16
        let g:rbpt_loadcmd_toggle = 0
        au VimEnter * RainbowParenthesesToggle
        au Syntax * RainbowParenthesesLoadRound
        au Syntax * RainbowParenthesesLoadSquare
        au Syntax * RainbowParenthesesLoadBraces
    
    "Vim Sessions Settings
        "===========================================================================
        " If you don't want help windows to be restored:
     "   set sessionoptions-=help
     "   let g:session_autosave_periodic=1
     "   let g:session_autosave=1
    
    "Vim Taboo Setting
        "make vim remember tab names across sessions
         set sessionoptions+=tabpages,globals
         let g:taboo_tab_format="[%N:%W]%f "
    
    "Vim setting to load all files in the path
        com! -complete=file -nargs=* Edit silent! exec "!vim --servername " . v:servername . " --remote-silent ".escape(<q-args>,'\')
    
    " Tag Bar - IDE like features
        nmap <F8> :TagbarToggle<CR>
    " Start interactive EasyAlign in visual mode (e.g. vipga)
    "xmap ga <Plug>(EasyAlign)
    
    " Start interactive EasyAlign for a motion/text object (e.g. gaip)
    "nmap ga <Plug>(EasyAlign)

    " Turn on case insensitive feature
    let g:EasyMotion_smartcase = 1
    
    " JK motions: Line motions
    map <space>j <Plug>(easymotion-j)
    map <space>k <Plug>(easymotion-k)
    
    map  <space>f <Plug>(easymotion-bd-f)
    nmap <space>ff <Plug>(easymotion-overwin-f)
    
    " Move to line
    "map <space>l <Plug>(easymotion-bd-jk)
    nmap <space>ll <Plug>(easymotion-overwin-line)
    
    " Move to word
    map  <space>w <Plug>(easymotion-bd-w)
    nmap <space>ww <Plug>(easymotion-overwin-w)
    
    " You can use other keymappings like <C-l> instead of <CR> if you want to
    " use these mappings as default search and somtimes want to move cursor with
    " EasyMotion.
    "function! s:incsearch_config(...) abort
    "  return incsearch#util#deepextend(deepcopy({
    "  \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
    "  \   'keymap': {
    "  \     "\<CR>": '<Over>(easymotion)'
    "  \   },
    "  \   'is_expr': 0
    "  \ }), get(a:, 1, {}))
    "endfunction
    "
    "noremap <silent><expr> <space>/  incsearch#go(<SID>incsearch_config())
    "noremap <silent><expr> <space>?  incsearch#go(<SID>incsearch_config({'command': '?'}))
    "noremap <silent><expr> <space>g/ incsearch#go(<SID>incsearch_config({'is_stay': 1}))
    
    " Gif config
    nmap <space>s <Plug>(easymotion-s2)
    nmap <space>t <Plug>(easymotion-t2)
    " Gif config
    map  / <Plug>(easymotion-sn)
    omap / <Plug>(easymotion-tn)
    
    "Gif config
    "map <space>l <Plug>(easymotion-lineforward)
    "map <space>h <Plug>(easymotion-linebackward)
    
    let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
    
    " These `n` & `N` mappings are options. You do not have to map `n` & `N` to
    "EasyMotion.
    " Without these mappings, `n` & `N` works fine. (These mappings just provide
    " different highlight method and have some other features )
    "map  n <Plug>(easymotion-next)
    "map  N <Plug>(easymotion-prev)
    
    function! s:config_easyfuzzymotion(...) abort
        return extend(copy({
          \   'converters': [incsearch#config#fuzzyword#converter()],
          \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
          \   'keymap': {"\<CR>": '<Over>(easymotion)'},
          \   'is_expr': 0,
          \   'is_stay': 1
          \ }), get(a:, 1, {}))
    endfunction
    
    noremap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion())

    function! s:config_fuzzyall(...) abort
        return extend(copy({
          \   'converters': [
          \     incsearch#config#fuzzy#converter(),
          \     incsearch#config#fuzzyspell#converter()
          \   ],
          \ }), get(a:, 1, {}))
    endfunction
    
    "Fuzzy Finder
"    noremap <silent><expr> z/ incsearch#go(<SID>config_fuzzyall())
"    noremap <silent><expr> z? incsearch#go(<SID>config_fuzzyall({'command': '?'}))
"    noremap <silent><expr> zg? incsearch#go(<SID>config_fuzzyall({'is_stay': 1}))
    
    let g:EasyMotion_do_mapping = 0 " Disable default mappings
    
    " Jump to anywhere you want with minimal keystrokes, with just one key
    " binding.
    " `s{char}{label}`
    map <space>ss <Plug>(easymotion-overwin-f)
    " or
    " `s{char}{char}{label}`
    " Need one more keystroke, but on average, it may be more comfortable.
    nmap <space>ss <Plug>(easymotion-overwin-f2)
    " s{char}{char} to move to {char}{char}
"}}}1
" Command line spell corrections {{{1 
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))
cnoreabbrev <expr> Wq ((getcmdtype() is# ':' && getcmdline() is# 'Wq')?('wq'):('Wq'))
cnoreabbrev <expr> Wa ((getcmdtype() is# ':' && getcmdline() is# 'Wa')?('wa'):('Wa'))
cnoreabbrev <expr> Qa ((getcmdtype() is# ':' && getcmdline() is# 'Qa')?('qa'):('Qa'))
cnoreabbrev <expr> Q ((getcmdtype() is# ':' && getcmdline() is# 'Q')?('q'):('Q'))
"}}}1
" Default settings for vim {{{1
" Enable filetype plugins
filetype on
filetype plugin indent on

"if &diff
""    set background=light
"else
set background=dark
"endif

colorscheme desert

syntax enable
set syntax=on

" set t_ut=
" Send more characters for redraws
set ttyfast
set nocompatible
set lazyredraw

" Set this to the name of your terminal that supports mouse codes.
" Must be one of: xterm, xterm2, netterm, dec, jsbterm, pterm
set ttymouse=xterm2

set wildmenu
set path+=.**

" To Remember
" z. [z followed by a dot (.)] - to put the line with the cursor at the
" center,
" zt - to put the line with the cursor at the top
" zb - to put the line with the cursor at the bottom of the screen.
" z<return> - to put the line with the cursor at the top of the screen

" Set Mouse Scrolling For Normal Mode
set mouse=n
set history=1000                " Store a ton of history default
set ul=1000                     " Undo levels

" Enable persistent undo
"set undofile   " Maintain undo history between sessions
"set undodir=~/.vim/undodir

"UI config
set number "Show line numbers
set relativenumber "Show line numbers
set hlsearch
set laststatus=2
set foldenable

set backspace=indent,eol,start
highlight Search ctermbg=darkmagenta ctermfg=white
highlight VertSplit ctermbg=darkgreen ctermfg=darkgrey
autocmd FileType * setlocal foldmethod=manual

" Use backspace to jump back
nmap <bs> <C-t>
nmap <cr> <c-]>
" Moving Text Around {{{2
" the below line wont work due to C-support plugin, it binds <C-j>
"nnoremap <C-j> :m .+2<CR>==
nnoremap <C-k> :m .-2<CR>==
"inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
"vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
"}}}2
" Color cursor settings {{{2
"set colorcolumn=81 
"highlight ColorColumn ctermbg=3
set cursorline
hi CursorLine ctermbg=white ctermfg=black
hi CursorLine cterm=none
hi CursorLine gui=none
"}}}2
"}}}1
" LEADER KEY BINDINGS {{{1
let mapleader = ","
let maplocalleader = "\\"
" Disable highlight when <leader><cr> is pressed
noremap<silent> <leader><cr> :noh<cr>
set splitright
set splitbelow
"Close every window in the current tabview but the current one
noremap <leader>cw <C-W>o

"noremap<leader>tn :tabnew \| :copen<cr> \| <esc><c-w>k
noremap<leader>to :tabonly<cr>
noremap<leader>tc :tabclose<cr>
noremap<leader>tm :tabmove
noremap<leader>tf :tabfind
noremap<leader>tls :tabs<cr>
noremap<leader>tsp :tab split<cr>
noremap<leader>m gT
noremap<leader>. gt
noremap<leader>n <C-W><S-t>

""""""""""""""""""""""""""""""""""""""""""""
" Smart way to move between windows
"
noremap <leader>j <C-W>j
noremap <leader>k <C-W>k
noremap <leader>h <C-W>h
noremap <leader>l <C-W>l

"Cscope & Tag Settings {{{2
    "-----------------------------------------------------------
    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    "set cscopetag
    " My mappings for managing tabs
    "0 or s: Find this C symbol
    "1 or g: Find this definition
    "2 or d: Find functions called by this function
    "3 or c: Find functions calling this function
    "4 or t: Find this text string
    "6 or e: Find this egrep pattern
    "7 or f: Find this file
    "8 or i: Find files #including this file

    noremap<leader>s "zyiw:exe "tab cs find 0 ".@z.""<CR>
    noremap<leader>g "zyiw:exe "tab cs find 1 ".@z.""<CR>
    noremap<leader>d "zyiw:exe "tab cs find 2 ".@z.""<CR>
    noremap<leader>c "zyiw:exe "tab cs find 3 ".@z.""<CR>
    noremap<leader>t "zyiw:exe "tab cs find 4 ".@z.""<CR>
    noremap<leader>e "zyiw:exe "tab cs find 6 ".@z.""<CR>
    noremap<leader>f "zyiw:exe "tab cs find 7 ".@z.""<CR>
    noremap<leader>i "zyiw:exe "tab cs find 8 ".@z.""<CR>

    noremap<localleader>s "zyiw:exe "tab cs find 0 ".@z.""<CR>
    noremap<localleader>g "zyiw:exe "tab cs find 1 ".@z.""<CR>
    noremap<localleader>d "zyiw:exe "tab cs find 2 ".@z.""<CR>
    noremap<localleader>c "zyiw:exe "tab cs find 3 ".@z.""<CR>
    noremap<localleader>t "zyiw:exe "tab cs find 4 ".@z.""<CR>
    noremap<localleader>e "zyiw:exe "tab cs find 6 ".@z.""<CR>
    noremap<localleader>f "zyiw:exe "tab cs find 7 ".@z.""<CR>
    noremap<localleader>i "zyiw:exe "tab cs find 8 ".@z.""<CR>
    " Using ',hcX' searches current word and makes the vim
    " window split horizontally, with search result displayed
    " in the new window.
    noremap<leader>hs "zyiw:exe "scs find 0 ".@z.""<CR>
    noremap<leader>hg "zyiw:exe "scs find 1 ".@z.""<CR>
    noremap<leader>hd "zyiw:exe "scs find 2 ".@z.""<CR>
    noremap<leader>hc "zyiw:exe "scs find 3 ".@z.""<CR>
    noremap<leader>ht "zyiw:exe "scs find 4 ".@z.""<CR>
    noremap<leader>he "zyiw:exe "scs find 6 ".@z.""<CR>
    noremap<leader>hf "zyiw:exe "scs find 7 ".@z.""<CR>
    noremap<leader>hi "zyiw:exe "scs find 8 ".@z.""<CR>

    " Hitting ',vcsX' searches current word and does a vertical
    " split instead of a horizontal one
    noremap<leader>vs "zyiw:exe "vert scs find 0 ".@z.""<CR>
    noremap<leader>vg "zyiw:exe "vert scs find 1 ".@z.""<CR>
    noremap<leader>vd "zyiw:exe "vert scs find 2 ".@z.""<CR>
    noremap<leader>vc "zyiw:exe "vert scs find 3 ".@z.""<CR>
    noremap<leader>vt "zyiw:exe "vert scs find 4 ".@z.""<CR>
    noremap<leader>ve "zyiw:exe "vert scs find 6 ".@z.""<CR>
    noremap<leader>vf "zyiw:exe "vert scs find 7 ".@z.""<CR>
    noremap<leader>vi "zyiw:exe "vert scs find 8 ".@z.""<CR>

    "Cscope shortcuts
    " f: Find this file
    " g: Find this definition
    " c: Find functions calling this function
    " s: Find this C symbol
    " t: Find assignments to
    " d: Find functions called by this function 
    command -nargs=+ Cf cs find f <args>
    command -nargs=+ Cg cs find g <args>
    command -nargs=+ Cc cs find c <args>
    command -nargs=+ Cs cs find s <args>
    command -nargs=+ Ct cs find t <args>
    command -nargs=+ Cd cs find d <args>
    command -nargs=+ Ci cs find i <args>
    command -nargs=+ Ce cs find e <args>
    "}}}2
"}}}1    
" Editor settings for C/C++ Language {{{1
autocmd FileType c call SetCFiletypeSettings()
autocmd BufRead *.h  set filetype=c
autocmd FileType h call SetCFiletypeSettings()
autocmd FileType qf nmap <buffer> <CR> <CR>

function SetCFiletypeSettings()
    setlocal foldmethod=syntax
    setlocal foldlevel=4
    "noremap <CR> zO
    ":cw \| <ESC><C-w>k<CR>
    let @a = 'vi{:!column -tgv='
    let @s ='gv:!column -tgv='
    let @f =']]k"Wy$2j@f'
    let @d ='"wpf)a;@d'
    set cst
    set csto=1
    set tags=tags
    
    if &diff
    else
        set cscopequickfix=s-,c-,d-,i-,t-,e-,f-
    endif
    if filereadable("cscope.out")
        cs add cscope.out
    endif

    if filereadable("my_proj.vim")
	source my_proj.vim
    endif

    set backspace=2 
    set backspace=indent,eol,start
    set tabstop=4                   " Number of visual spaces per TAB
    set softtabstop=4               " Number of spaces in tab when editing
    set expandtab                   " Tabs are spaces
    set shiftwidth=4
    set smarttab
    set wrap                        " Wrap lines
    "set scrolloff=25                "Make search results appear in the middle of the screen
    set autoindent
    set cindent
    set textwidth=80
    set infercase

    " Vim Auto complete
    set complete=.,w,d,b,u,i,t
    set completeopt=menu,longest,preview
    highlight Pmenu ctermbg=darkgreen
    highlight PmenuSel ctermbg=white
    inoremap <C-n> <C-x><C-n>
    inoremap <C-l> <C-x><C-l>
    inoremap <C-Tab> <C-x><C-o>
    "Loop through pop completion
    inoremap <expr><tab>   pumvisible() ? "\<C-n>" : "\<tab>"
    inoremap <expr><s-tab> pumvisible() ? "\<C-p>" : "\<s-tab>"
    inoremap <expr> j pumvisible() ? "\<C-n>" : "j"
    inoremap <expr> k pumvisible() ? "\<C-p>" : "k"
    " Vim Quick Fix movement
    nnoremap <C-n> :cn<CR>
    nnoremap <C-b> :cp<CR>
endfunction

fun! TrimWhitespace()
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfun
" Close Preview winodow that open along with omnicomplete
autocmd CompleteDone * pclose
"}}}1
" My Mappings for managing tabs {{{1
    noremap <Tab> gt
    noremap <S-Tab> gT
    
    noremap 0<Tab> 0gt
    noremap 1<Tab> 1gt
    noremap 2<Tab> 2gt
    noremap 3<Tab> 3gt
    noremap 4<Tab> 4gt
    noremap 5<Tab> 5gt
    noremap 6<Tab> 6gt
    noremap 7<Tab> 7gt
    noremap 8<Tab> 8gt
    noremap 9<Tab> 9gt
    
    " Opens a new tab with the current buffer's path
    " Super useful when editing files in the same directory
    noremap<leader>te :tabedit <c-r>=expand("%:p:h")<cr>/
    
"}}}1
" Editor settings for Vimrc {{{1
autocmd BufRead *.vimrc  setlocal  foldmethod=marker foldlevel=-1
"}}}1
"My Quirky Hacks {{{1"{{{
    map bn :bn<cr>
    map bp :bp<cr>
    map bd :bd<cr>
    map <ScrollWheelUp> <C-y>
    map <ScrollWheelDown> <C-e>
    noremap xn a<space><esc>
    noremap xp i<space><esc>
    noremap Y  y$
    noremap up :s/\<./\u&/g<CR> & :noh<cr>
    noremap <C-@> i<C-@>

    " Seleting Window's
    noremap 1` 1<C-W>w 
    noremap 2` 2<C-W>w 
    noremap 3` 3<C-W>w 
    noremap 4` 4<C-W>w 
    noremap 5` 5<C-W>w 
    noremap 6` 6<C-W>w 

"My Quirky Aberrations {{{1
    iab typd    typedef struct
    iab stru    structure
    iab ins     instance
    iab desc    description
    iab po      pointer
"}}}
"Moving around command line {{{1
    cnoremap <C-A> <Home>
    cnoremap <C-F> <S-Right>
    cnoremap <C-B> <S-Left>
"}}}1
" Return to last edit position when opening files (You want this!) {{{1
autocmd BufReadPost *
 \ if line("'\"") > 0 && line("'\"") <= line("$") |
 \   exe "normal! g`\"" |
 \ endif

" Remember info about open buffers on close
set viminfo^=%
set viminfo='100,<50,s10,f1
"}}}1
"Function Key's Toggling! {{{1
    "--------------------------------------------------------------------------
    nnoremap <F6> :call QuickfixToggle()<cr>
    call togglebg#map("<F2>")
    map <F5> :!cscope -Rb <CR> & :ctags -R<CR> & :cs reset<CR><CR> 
    map <F7> :set scb!<CR> "set 2 window scroll
    map <F9> :GitGutterLineHighlightsToggle<CR>
    map <F4> :NERDTreeToggle<CR>
    map <F3> :buffers<CR>:buffer<Space>
"}}}1
" QuickFix Window Settings {{{1
"let g:quickfix_is_open = 0
"
"function! QuickfixToggle()
"    if g:quickfix_is_open
"        cclose
"        let g:quickfix_is_open = 0
"    else
"        " copen
"        let g:quickfix_is_open = 1
"    endif
"endfunction
"
"function! s:ExecuteInShell(command)
"    let command = join(map(split(a:command), 'expand(v:val)'))
"    let winnr = bufwinnr('^' . "__Scratch__" . '$')
"    "let winnr = bufwinnr('^' . command . '$')
"    silent! execute  winnr < 0 ? 'botright new ' . fnameescape("__Scratch__") : winnr . 'wincmd w'
"    "silent! execute  winnr < 0 ? 'botright new ' . fnameescape(command) : winnr . 'wincmd w'
"    setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
"    echo 'Execute ' . command . '...'
"    silent! execute 'silent %!'. command
"    silent! execute 'resize ' . line('$')
"    "silent! redraw
"    silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
"    silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>'
"    echo 'Shell command ' . command . ' executed.'
"endfunction
"command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)
"
""Funtion to close quickfix window if only one buffer exists.
"aug QFClose
"      au!
"        au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
"aug END
"}}}1
"NERDTree Settings {{{1
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

let g:NERDTreeDirArrowExpandable = '>'
let g:NERDTreeDirArrowCollapsible = '-'

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
"}}}1

