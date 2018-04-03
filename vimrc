
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
set rtp+=~/.fzf
set rtp+=~/vim-wow-moments
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
"FZF
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
"Incremental search
Plugin 'haya14busa/incsearch.vim'
"Git help
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
"Indent guide lines.
Plugin 'nathanaelkane/vim-indent-guides'
"Snippets manager
Plugin 'honza/vim-snippets'
"Snippet engine
Plugin 'sirver/ultisnips'
"Highlighting C/C++ Functions
Plugin 'octol/vim-cpp-enhanced-highlight'
"Highlight typedef, enums etc
Plugin 'TagHighlight'
"Tab Renaming
"Plugin 'gcmt/taboo.vim'
"Tame QuickFix
Plugin 'romainl/vim-qf'
"Tame code comments
Plugin 'scrooloose/nerdcommenter'
"Auto insert closing parentheses
Plugin 'raimondi/delimitmate'
"Enable yanking and pasting text between vim buffers across panes/windows
Plugin 'gsiano/vmux-clipboard'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'edkolev/tmuxline.vim'

call vundle#end()
"}}}1

" Plugin Specific Configurations {{{1
	" FZF Plugin --- {{{2
        " An action can be a reference to a function that processes selected lines
        function! s:build_quickfix_list(lines)
          call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
          copen
          cc
        endfunction

        let g:fzf_action = {
          \ 'ctrl-q': function('s:build_quickfix_list'),
          \ 'ctrl-t': 'tab split',
          \ 'ctrl-x': 'split',
          \ 'ctrl-v': 'vsplit' }

        " Default fzf layout
        " - down / up / left / right
        let g:fzf_layout = { 'down': '~40%' }

        " Customize fzf colors to match your color scheme
        "let g:fzf_colors =
        "\ { 'fg':      ['fg', 'Normal'],
        "  \ 'bg':      ['bg', 'Normal'],
        "  \ 'hl':      ['fg', 'Comment'],
        "  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
        "  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
        "  \ 'hl+':     ['fg', 'Statement'],
        "  \ 'info':    ['fg', 'PreProc'],
        "  \ 'border':  ['fg', 'Ignore'],
        "  \ 'prompt':  ['fg', 'Conditional'],
        "  \ 'pointer': ['fg', 'Exception'],
        "  \ 'marker':  ['fg', 'Keyword'],
        "  \ 'spinner': ['fg', 'Label'],
        "  \ 'header':  ['fg', 'Comment'] }

        " Enable per-command history.
        " CTRL-N and CTRL-P will be automatically bound to next-history and
        " previous-history instead of down and up. If you don't like the change,
        " explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
        let g:fzf_history_dir = '~/.local/share/fzf-history'

        "FZF mapping {{{3
            nmap <C-f>  :Files<CR>
            nmap <C-f>g :GFiles<CR>
            nmap <C-f>b  :Buffers<CR>
            nmap <C-f>w  :Windows<CR>
            nmap <C-f>l  :Lines<CR>
            nmap <C-f>bl :BLines<CR>
            nmap <C-f>t  :Tag<CR>
            nmap <C-f>bt :BTag<CR>
            nmap <C-f>s  :Snippets<CR>

            " Insert mode completion
            imap <c-x><c-k> <plug>(fzf-complete-word)
            imap <c-x><c-f> <plug>(fzf-complete-path)
            "imap <c-x><c-j> <plug>(fzf-complete-file-ag)
            imap <c-x><c-l> <plug>(fzf-complete-line)
            imap <c-x><c-b> <plug>(fzf-complete-buffer-line)

            "Simple MRU search
            command! FZFMru call fzf#run({
                        \ 'source':  reverse(s:all_files()),
                        \ 'sink':    'edit',
                        \ 'options': '-m -x +s',
                        \ 'down':    '40%' })

            function! s:all_files()
                return extend(
                            \ filter(copy(v:oldfiles),
                            \        "v:val !~ 'fugitive:\\|NERD_tree\\|^/tmp/\\|.git/'"),
                            \ map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), 'bufname(v:val)'))
            endfunction

            "Jump to tags
            function! s:tags_sink(line)
                let parts = split(a:line, '\t\zs')
                let excmd = matchstr(parts[2:], '^.*\ze;"\t')
                execute 'silent e' parts[1][:-2]
                let [magic, &magic] = [&magic, 0]
                execute excmd
                let &magic = magic
            endfunction

            function! s:tags()
                if empty(tagfiles())
                    echohl WarningMsg
                    echom 'Preparing tags'
                    echohl None
                    call system('ctags -R')
                endif

                call fzf#run({
                            \ 'source':  'cat '.join(map(tagfiles(), 'fnamemodify(v:val, ":S")')).
                            \            '| grep -v -a ^!',
                            \ 'options': '+m -d "\t" --with-nth 1,4.. -n 1 --tiebreak=index',
                            \ 'down':    '40%',
                            \ 'sink':    function('s:tags_sink')})
            endfunction

            command! Tags call s:tags()

            "Jump to tags in the current buffer
            function! s:align_lists(lists)
                let maxes = {}
                for list in a:lists
                    let i = 0
                    while i < len(list)
                        let maxes[i] = max([get(maxes, i, 0), len(list[i])])
                        let i += 1
                    endwhile
                endfor
                for list in a:lists
                    call map(list, "printf('%-'.maxes[v:key].'s', v:val)")
                endfor
                return a:lists
            endfunction

            function! s:btags_source()
                let lines = map(split(system(printf(
                            \ 'ctags -f - --sort=no --excmd=number --language-force=%s %s',
                            \ &filetype, expand('%:S'))), "\n"), 'split(v:val, "\t")')
                if v:shell_error
                    throw 'failed to extract tags'
                endif
                return map(s:align_lists(lines), 'join(v:val, "\t")')
            endfunction

            function! s:btags_sink(line)
                execute split(a:line, "\t")[2]
            endfunction

            function! s:btags()
                try
                    call fzf#run({
                                \ 'source':  s:btags_source(),
                                \ 'options': '+m -d "\t" --with-nth 1,4.. -n 1 --tiebreak=index',
                                \ 'down':    '40%',
                                \ 'sink':    function('s:btags_sink')})
                catch
                    echohl WarningMsg
                    echom v:exception
                    echohl None
                endtry
            endfunction

            command! BTags call s:btags()

            function! s:line_handler(l)
                let keys = split(a:l, ':\t')
                exec 'buf' keys[0]
                exec keys[1]
                normal! ^zz
            endfunction

            "Search lines in all open vim buffers
            function! s:buffer_lines()
                let res = []
                for b in filter(range(1, bufnr('$')), 'buflisted(v:val)')
                    call extend(res, map(getbufline(b,0,"$"), 'b . ":\t" . (v:key + 1) . ":\t" . v:val '))
                endfor
                return res
            endfunction

            command! FZFLines call fzf#run({
                        \   'source':  <sid>buffer_lines(),
                        \   'sink':    function('<sid>line_handler'),
                        \   'options': '--extended --nth=3..',
                        \   'down':    '60%'
                        \})

            "Fuzzy search files in parent directory of current file
            function! s:fzf_neighbouring_files()
                let current_file =expand("%")
                let cwd = fnamemodify(current_file, ':p:h')
                let command = 'ag -g "" -f ' . cwd . ' --depth 0'

                call fzf#run({
                            \ 'source': command,
                            \ 'sink':   'e',
                            \ 'options': '-m -x +s',
                            \ 'window':  'enew' })
            endfunction

            command! FZFNeigh call s:fzf_neighbouring_files()
        "}}}3
	"}}}2

	"Incsearch Plugin --- {{{2
        map /  <Plug>(incsearch-forward)
        map ?  <Plug>(incsearch-backward)
        map g/ <Plug>(incsearch-stay)
        set hlsearch
        set incsearch
        map n  <Plug>(incsearch-nohl-n)
        map N  <Plug>(incsearch-nohl-N)
        map *  <Plug>(incsearch-nohl-*)
        map #  <Plug>(incsearch-nohl-#)
        map g* <Plug>(incsearch-nohl-g*)
        map g# <Plug>(incsearch-nohl-g#)
    "}}}2

	" UltiSnips Plugin --- {{{2
        let g:UltiSnipsExpandTrigger="<tab>"
        let g:UltiSnipsJumpForwardTrigger="<c-j>"
        let g:UltiSnipsJumpBackwardTrigger="<c-k>"

        " If you want :UltiSnipsEdit to split your window.
        let g:UltiSnipsEditSplit='vertical'

        " explicitly tell UltiSnips to use python3
        let g:UltiSnipsUsePythonVersion = 3

        " Split vertically
        let g:UltiSnipsEditSplit = 'context'

        " Snippets Path
        let g:UltiSnipsSnippetsDir= $HOME.'/vim-wow-moments/mycoolsnips'
        let g:UltiSnipsSnippetDirectories=["UltiSnips", "mycoolsnips"]
	"}}}2

    "Vim Taboo Setting {{{2
        "make vim remember tab names across sessions
         "set sessionoptions+=tabpages,globals
         "let g:taboo_tab_format="[%N:%W]%f "
    "}}}2
    "{{{2 NerdCommentery
        "Add your own custom formats or override the defaults
        let g:NERDCustomDelimiters = { 'c': { 'left': '//'} }
        " Use compact syntax for prettified multi-line comments
        let g:NERDCompactSexyComs = 1
        " Align line-wise comment delimiters flush left instead of following code
        " indentation
        let g:NERDDefaultAlign = 'left'
    "}}}2
    "Airline Settings {{{2
        "Tmux settings
        let g:airline_theme='wombat'
        let g:tmuxline_separators = {
            \ 'left' : '',
            \ 'left_alt': '|',
            \ 'right' : '',
            \ 'right_alt' : '|',
            \ 'space' : ' '}
        "Vim Settings
        let g:airline#extensions#default#layout = [
              \ [ 'a', 'b', 'c' ],
              \ [ 'x', 'z' ]
              \ ]
        let g:airline_extensions = ['branch', 'tabline']
        let g:airline#extensions#branch#enabled = 1
        let g:airline#extensions#tabline#left_sep = '||'
        let g:airline#extensions#tabline#left_alt_sep = '||'
        let g:airline#extensions#quickfix#quickfix_text = 'Quickfix'
        let g:airline#extensions#quickfix#location_text = 'Location'
        let g:airline#extensions#tabline#enabled = 1
        let g:airline#extensions#tabline#tab_nr_type = 2
        let g:airline#extensions#tabline#show_splits = 1
        let g:airline#extensions#tabline#show_tabs = 1
        let g:airline#extensions#tabline#tabs_label = 'TABS'
        let g:airline#extensions#tabline#buffers_label = 'BUFFERS'
         let g:airline#extensions#tabline#formatter = 'unique_tail'
        "let g:airline#extensions#taboo#enabled = 0
    "}}}2
    "GitGutter Mappings {{{2
        "Cycle through all hunk changes in all files
        function! NextHunkAllBuffers()
			let line = line('.')
			GitGutterNextHunk
			if line('.') != line
				return
			endif

			let bufnr = bufnr('')
			while 1
				bnext
				if bufnr('') == bufnr
					return
				endif
				if !empty(GitGutterGetHunks())
					normal! 1G
					GitGutterNextHunk
					return
				endif
			endwhile
		endfunction

		function! PrevHunkAllBuffers()
			let line = line('.')
			GitGutterPrevHunk
			if line('.') != line
				return
			endif

			let bufnr = bufnr('')
			while 1
				bprevious
				if bufnr('') == bufnr
					return
				endif
				if !empty(GitGutterGetHunks())
					normal! G
					GitGutterPrevHunk
					return
				endif
			endwhile
		endfunction

		nmap <silent> ]c :call NextHunkAllBuffers()<CR>
		nmap <silent> [c :call PrevHunkAllBuffers()<CR>
        nmap <silent> <leader>w s/\s\+$//

		function! CleanUp(...)
			if a:0  " opfunc
				let [first, last] = [line("'["), line("']")]
			else
				let [first, last] = [line("'<"), line("'>")]
			endif
			for lnum in range(first, last)
				let line = getline(lnum)

				" clean up the text, e.g.:
				let line = substitute(line, '\s\+$', '', '')

				call setline(lnum, line)
			endfor
		endfunction

		nmap <silent> <Leader>x :set opfunc=CleanUp<CR>g@
    "}}}2
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

    colorscheme default

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

    setlocal foldmethod=syntax
    setlocal foldlevel=4
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
    set smartindent
    set textwidth=80
    set infercase

    " Vim Auto complete
    set complete=.,t,w,d,b,u,i,
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
    " Close Preview winodow that open along with omnicomplete
    autocmd CompleteDone * pclose
    "Moving around command line
    cnoremap <C-a> <Home>
    cnoremap <C-f> <S-Right>
    cnoremap <C-b> <S-Left>
    "My Quirky Hacks
    map <ScrollWheelUp> <C-y>
    map <ScrollWheelDown> <C-e>
    noremap xn a<space><esc>
    noremap xp i<space><esc>
    noremap Y  y$
    noremap up :s/\<./\u&/g<CR> & :noh<cr>
    noremap <C-@> i<C-@>
    " Return to last edit position when opening files (You want this!)
    autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
    " Remember info about open buffers on close
    set viminfo^=%
    set viminfo='100,<50,s10,f1
    "Command line spell corrections
    cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))
    cnoreabbrev <expr> Wq ((getcmdtype() is# ':' && getcmdline() is# 'Wq')?('wq'):('Wq'))
    cnoreabbrev <expr> Wa ((getcmdtype() is# ':' && getcmdline() is# 'Wa')?('wa'):('Wa'))
    cnoreabbrev <expr> Qa ((getcmdtype() is# ':' && getcmdline() is# 'Qa')?('qa'):('Qa'))
    cnoreabbrev <expr> Q ((getcmdtype() is# ':' && getcmdline() is# 'Q')?('q'):('Q'))
    "Function Key's Toggling! {{{2
    "--------------------------------------------------------------------------
    nnoremap <F6> :call QuickfixToggle()<cr>
    map <F5> :!cscope -Rb <CR> & :ctags -R<CR> & :cs reset<CR><CR>
    "set 2 window scroll
    map <F7> :set scb!<CR>
    map <F9> :GitGutterLineHighlightsToggle<CR>
    map <F3> :buffers<CR>:buffer<Space>
    "}}}2
"}}}1

"Leader Key Bindings {{{1
    let mapleader = ","
    let maplocalleader = "\\"

    " Disable highlight when <leader><cr> is pressed
    noremap<silent> <leader><cr> :noh<cr>

    " Managing windows {{{2
        noremap <leader>j <C-W>j
        noremap <leader>k <C-W>k
        noremap <leader>h <C-W>h
        noremap <leader>l <C-W>l
        set splitright
        set splitbelow
        " Seleting Window's
        noremap 1` 1<C-W>w
        noremap 2` 2<C-W>w
        noremap 3` 3<C-W>w
        noremap 4` 4<C-W>w
        noremap 5` 5<C-W>w
        noremap 6` 6<C-W>w
        noremap 7` 7<C-W>w
        noremap 8` 8<C-W>w
        noremap 9` 9<C-W>w
    "}}}2

    "Cscope & Tag Settings {{{2
    "-----------------------------------------------------------
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

" My Mappings {{{1
    " Tag- Use backspace to jump back {{{2
		nmap <bs> <C-t>
		nmap <cr> <c-]>
    "}}}2
    " Command line spell corrections {{{2
    cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))
    cnoreabbrev <expr> Wq ((getcmdtype() is# ':' && getcmdline() is# 'Wq')?('wq'):('Wq'))
    cnoreabbrev <expr> Wa ((getcmdtype() is# ':' && getcmdline() is# 'Wa')?('wa'):('Wa'))
    cnoreabbrev <expr> Qa ((getcmdtype() is# ':' && getcmdline() is# 'Qa')?('qa'):('Qa'))
    cnoreabbrev <expr> Q ((getcmdtype() is# ':' && getcmdline() is# 'Q')?('q'):('Q'))
    "}}}2
	" Managing tabs {{{2
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
	"}}}2
"}}}1
