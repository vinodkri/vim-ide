
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
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-repeat'
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

"Restore FocusGained and FocusLost events
Plugin 'tmux-plugins/vim-tmux-focus-events'

"Theme
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'edkolev/tmuxline.vim'

" ACK -- fast grep
Plugin 'mileszs/ack.vim'

"Plugin 'christoomey/vim-tmux-runner'
Plugin 'vinodkri/vim-tmux-runner'

Plugin 'Valloric/YouCompleteMe'
"Plugin 'ervandew/supertab'

"Plugin 'fatih/vim-go'
"Plugin 'rust-lang/rust'

Plugin 'majutsushi/tagbar'
call vundle#end()
"}}}1

set encoding=utf-8

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
        let g:fzf_colors =
        \ { 'fg':      ['fg', 'Normal'],
          \ 'bg':      ['bg', 'Normal'],
          \ 'hl':      ['fg', 'Comment'],
          \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
          \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
          \ 'hl+':     ['fg', 'Statement'],
          \ 'info':    ['fg', 'PreProc'],
          \ 'border':  ['fg', 'Ignore'],
          \ 'prompt':  ['fg', 'Conditional'],
          \ 'pointer': ['fg', 'Exception'],
          \ 'marker':  ['fg', 'Keyword'],
          \ 'spinner': ['fg', 'Label'],
          \ 'header':  ['fg', 'Comment'] }

        " Enable per-command history.
        " CTRL-N and CTRL-P will be automatically bound to next-history and
        " previous-history instead of down and up. If you don't like the change,
        " explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
        let g:fzf_history_dir = '~/.local/share/fzf-history'

        "FZF mapping {{{3
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
                echom 'Preparing tags'
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

            nmap <space>f  :Files<CR>
            nmap <space>g  :GFiles<CR>
            nmap <space>b  :Buffers<CR>
            nmap <space>w  :Windows<CR>
            nmap <space>l  :Lines<CR>
            nmap <space>bl :BLines<CR>
            nmap <space>t  :Tags<CR>
            nmap <space>bt :BTags<CR>
            nmap <space>s  :Snippets<CR>

            " Insert mode completion
            inoremap <c-x>t <plug>(fzf-complete-word)
            "imap <c-x><c-f> <plug>(fzf-complete-path)
            "imap <c-x><c-j> <plug>(fzf-complete-file-ag)
            imap <c-x><c-l> <plug>(fzf-complete-line)
            imap <c-x><c-b> <plug>(fzf-complete-buffer-line)

            " Better command history with q:
            command! CmdHist call fzf#vim#command_history({'down': '20'})
            nnoremap q: :CmdHist<CR>
        "}}}3
	"}}}2

	"Incsearch Plugin --- {{{2
        set hlsearch
        set incsearch
        map /  <Plug>(incsearch-forward)
        map ?  <Plug>(incsearch-backward)
        map g/ <Plug>(incsearch-stay)
        map n  <Plug>(incsearch-nohl-n)
        map N  <Plug>(incsearch-nohl-N)
        map *  <Plug>(incsearch-nohl-*)
        map #  <Plug>(incsearch-nohl-#)
        map g* <Plug>(incsearch-nohl-g*)
        map g# <Plug>(incsearch-nohl-g#)
    "}}}2

	" YouCompleteMe Plugin --- {{{2
    let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
    let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
    let g:ycm_complete_in_comments = 1
    let g:ycm_seed_identifiers_with_syntax = 1
    let g:ycm_collect_identifiers_from_comments_and_strings = 1
    "let g:ycm_key_invoke_completion = '<C-Space>'
    let g:ycm_key_list_select_completion = ['<Enter']
    let g:ycm_add_preview_to_completeopt = 1
    "let g:ycm_autoclose_preview_window_after_insertion = 1
    let g:ycm_autoclose_preview_window_after_completion = 1
    let g:ycm_enable_diagnostic_highlighting = 0
    let g:ycm_warning_symbol = '!'

    ""}}}2

	" SuperTab Plugin --- {{{2
    "let g:SuperTabDefaultCompletionType = '<c-n>'

    ""}}}2
	" UltiSnips Plugin --- {{{2
        let g:UltiSnipsExpandTrigger="<Tab>"
        let g:UltiSnipsJumpForwardTrigger="<c-n>"
        let g:UltiSnipsJumpBackwardTrigger="<c-k>"

        let g:UltiSnipsEditSplit="vertical"

        " If you want :UltiSnipsEdit to split your window.
        let g:UltiSnipsEditSplit='vertical'

        " explicitly tell UltiSnips to use python3
        let g:UltiSnipsUsePythonVersion = 3

        " Split vertically
        let g:UltiSnipsEditSplit = 'context'

        " Snippets Path
        let g:UltiSnipsSnippetsDir= '~/vim-wow-moments/mycoolsnips'
        let g:UltiSnipsSnippetDirectories=[".vim/bundle/vim-snippets/UltiSnips", "mycoolsnips"]
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

    "{{{2 Rusty
        let g:rustfmt_autosave = 1
    "}}}2

    "Airline Settings {{{2
        let g:airline_theme='ayu_dark'
        "Tmux settings
        let g:airline#extensions#tmuxline#enabled = 1
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
        let g:airline#extensions#tabline#show_buffers = 0
        let g:airline#extensions#taboo#enabled = 1
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
        "nmap <silent> ]w :%s/\s\+$// <CR>

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

		nmap <silent> <leader>x :set opfunc=CleanUp<CR>g@
    "}}}2

    "VTR {{{2
        let g:VtrUseVtrMaps = 1
    "}}}2

    "AutoTagBar {{{2
        nmap <F4> :TagbarToggle<CR>
    "}}}2
    
    "Indentation {{{2
        let g:indent_guides_enable_on_vim_startup = 1
        let g:indent_guides_guide_size = 1
        let g:indent_guides_start_level = 2
        let g:indent_guides_auto_colors = 0
        let g:indent_guides_indent_levels = 6
        let g:indent_guides_color_change_percent = 10
        autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=grey
        autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkgrey
        nmap <silent> yig <Plug>IndentGuidesToggle
    "}}}
    "vim-cpp-enhanced-highlight {{{2
        let g:cpp_class_scope_highlight = 1
        let g:cpp_member_variable_highlight = 1
        let g:cpp_class_decl_highlight = 1
        let g:cpp_posix_standard = 1
    ""}}}2
"}}}1

" Default settings for vim {{{1
    " Enable filetype plugins
    filetype on
    filetype plugin indent on
    set nopaste
    set background=dark
    if &diff
        colorscheme zellner 
    else
        colorscheme desert
    endif

    syntax enable
    set syntax=on

    set t_ut=
    " Send more characters for redraws
    set ttyfast
    "set lazyredraw

    " Set this to the name of your terminal that supports mouse codes.
    " Must be one of: xterm, xterm2, netterm, dec, jsbterm, pterm
    set ttymouse=xterm2

    set path=$PWD/**
    set wildmenu
    set wildmode=list:longest
    " To Remember
    " z. [z followed by a dot (.)] - to put the line with the cursor at the
    " center,
    " zt - to put the line with the cursor at the top
    " zb - to put the line with the cursor at the bottom of the screen.
    " z<return> - to put the line with the cursor at the top of the screen

    " Set Mouse Scrolling For Normal Mode
    set mouse=n
    set history=1000  " Store a ton of history default
    set ul=1000  " Undo levels

    " Enable persistent undo
    "set undofile   " Maintain undo history between sessions
    "set undodir=~/.vim/undodir

    "UI config
    set number "Show line numbers
    set relativenumber "Show line numbers
    set laststatus=2

    "set nomagic
    "highlight Search ctermbg=darkmagenta ctermfg=black
    highlight Search ctermbg=darkgreen ctermfg=black
    "highlight IncSearch cterm=underline,bold  ctermbg=white ctermfg=black
    highlight IncSearch cterm=underline,bold  ctermbg=darkgreen ctermfg=black
    highlight VertSplit ctermbg=darkgreen ctermfg=black
    highlight VertSplit ctermbg=black ctermfg=darkgreen
    "highlight MatchParen cterm=bold ctermfg=white ctermbg=lightgrey

    set foldenable
    setlocal foldmethod=syntax
    setlocal foldminlines=10
    setlocal foldlevel=4

    set backspace=2
    set backspace+=indent,eol,start
    set tabstop=4                   " Number of visual spaces per TAB
    set softtabstop=4               " Number of spaces in tab when editing
    set expandtab                   " Tabs are spaces
    set shiftwidth=4
    set smarttab
    set wrap                        " Wrap lines
    "set scrolloff=25                "Make search results appear in the middle of the screen
    set autoindent
    "set cindent
    "set smartindent
    set infercase
    set smartcase

    " Set vim to save the file on focus out.
    au FocusLost * :wa \| :redraw!
    "Auto redraw when focus gained
    au FocusGained * :redraw!

    " Vim Auto complete
    set complete=.,t,w,d,b,u
    "set complete-=i
    set completeopt=menu,longest,preview
    highlight Pmenu ctermbg=darkgreen
    highlight PmenuSel ctermbg=yellow
    "Loop through pop completion
    "inoremap <expr><tab>   pumvisible() ? \"\<c-n>" : \"\<tab>"
    "inoremap <expr><s-tab> pumvisible() ? \"\<c-p>" : \"\<s-tab>"
    "inoremap <expr> j pumvisible() ? \"\<c-n>" : \"j"
    "inoremap <expr> k pumvisible() ? \"\<c-p>" : \"k"
    " Vim Quick Fix movement
    nnoremap gn :cn<CR>
    nnoremap gp :cp<CR>
    nnoremap * g*
    nnoremap # g#
    " Close Preview winodow that open along with omnicomplete
    autocmd CompleteDone * pclose
    "Moving around command line
    cnoremap <c-a> <Home>
    cnoremap <c-f> <S-Right>
    cnoremap <c-b> <S-Left>
    cnoremap <c-e> <End>
    inoremap <c-a> <c-o>^
    inoremap <c-a><c-a> <c-o>0
    inoremap <c-e> <c-o>$

    "My Quirky Hacks
    " Tag- Use backspace to jump back {{{2
    nmap <bs> <C-t>
    nmap <cr> <c-]>
    nmap <C-n> :cn<CR>
    nmap <C-p> :cp<CR>
    map <ScrollWheelUp> <c-y>
    map <ScrollWheelDown> <c-e>
    noremap [{ [{zz
    noremap [[ [[zz
    noremap ]] ]]zz
    noremap %  %zz
    noremap xn a<space><esc>
    noremap xp i<space><esc>
    noremap <space> <c-d>
    noremap <s-space> <c-u>
    noremap Y  y$
    noremap gup :s/\<./\u&/g<CR> & :noh<CR>
    noremap <C-@> i<C-@>
    " Remember info about open buffers on close
    set viminfo^=%
    set viminfo='100,<50,s10,f1
    "Command line spell corrections
    cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))
    cnoreabbrev <expr> Wq ((getcmdtype() is# ':' && getcmdline() is# 'Wq')?('wq'):('Wq'))
    cnoreabbrev <expr> Wa ((getcmdtype() is# ':' && getcmdline() is# 'Wa')?('wa'):('Wa'))
    cnoreabbrev <expr> Qa ((getcmdtype() is# ':' && getcmdline() is# 'Qa')?('qa'):('Qa'))
    cnoreabbrev <expr> Q ((getcmdtype() is# ':' && getcmdline() is# 'Q')?('q'):('Q'))

    command VKGrep !grep --line-buffered --color=never -r "" * | fzf

    function! SortBetweenBracketsAndIndent()
        let @x = 'vi{:!column -tgv='
        normal! @x
        let @x=''
    endfunction
    command! VKSortBrackets call SortBetweenBracketsAndIndent()

    function! SortSelectedLinesAndIndent()
        let @x ='gv:!column -tgv='
        normal! @x
        let @x=''
    endfunction
    command! VKSortLines call SortSelectedLinesAndIndent()

    function! CHeaderDefines()
        let @x='G"%p0i#ifndef wgUWi_f.s_A_yypldwidefine yypldwiendif // '
        normal! @x
        let @x=''
    endfunction
    command! VKCHeader call CHeaderDefines()

    function! GatherFunctionDefinitions()
        let @z=''
        let @x=''
        wincmd h
        normal! gg
        let @x =']]j"Zy((]]2j@x'
        normal! @x
        wincmd l
        normal! "zpGo
        let @x ='ddkA;'
        normal! [[
        while line(".") > 1
            normal! @x
            normal! [[
        endwhile
        let @z=''
        let @x=''
    endfunction
    command! VKFuncDef call GatherFunctionDefinitions()

    command! VKWipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor

    function! ConvertEnum2Switch()
        let @x ='gv:!column -tgv='
        normal! @x
        let @x=''
    endfunction
    command! VKEnum2Switch call ConvertEnum2Switch()

    function! ConvertHashDefine2Switch()
        let @x=''
        let @y=''
        let @y ='02dwicase €ýaea: break;D€ýa' 
        let @x ='gv:g/define/norm!@ygv='
        normal! @x
        let @x=''
        let @y=''
    endfunction
    command! VKHashDefine2Switch call ConvertHashDefine2Switch()

    "Function Key's Toggling! {{{2
    "--------------------------------------------------------------------------
    "nnoremap <F6> :call QuickfixToggle()<cr>
    "set 2 window scroll
    map <F1> :set scb!<CR>
    map <F2> :GitGutterLineHighlightsToggle<CR>
    map <F3> :buffers<CR>:buffer<Space>
    nmap <F10> :!source ./.git/hooks/ide<CR>:silent cscope add ./.git/hooks/cscope.out<CR><CR>:silent cscope reset<CR><CR>
    autocmd BufWritePost c,cpp :!source ./.git/hooks/ide<CR>:silent cscope add ./.git/hooks/cscope.out<CR><CR>:silent cscope reset<CR><CR>
    "}}}2
"}}}1

"Leader Key Bindings {{{1
    let mapleader = ";"
    let maplocalleader = "\\"

    " Disable highlight when <leader><cr> is pressed
    noremap<silent> <leader><cr> :noh<cr>
    noremap<silent> <leader><Esc> :ccl<cr>

    " Managing windows {{{2
        noremap gj <C-W>j
        noremap gk <C-W>k
        noremap gh <C-W>h
        noremap gl <C-W>l
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

        " Window resizing mappings
        nnoremap <C-k>  <C-w>+
        nnoremap <C-j>  <C-w>-
        nnoremap <C-h>  <C-w><
        nnoremap <C-l> <C-w>>
    "}}}2

    " Search and Replace like a boss {{{2
        nnoremap // /\v
        command -nargs=1 S2 :2match search /<args>/
        command -nargs=1 S3 :3match search /<args>/
        command -nargs=1 IS2 :match incsearch /<args>/
        nnoremap gr :%s///gc<Left><Left><Left><Left>
        nnoremap grw :%s/<C-r><C-w>//gc<Left><Left><Left>
        nnoremap griw :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>
    "}}}2

    " Fold Toggle {{{2
	nnoremap zf :call FoldColumnToggle()<cr>

	function! FoldColumnToggle()
        if &foldlevel
        	setlocal foldmethod=syntax
            setlocal foldminlines=0
            setlocal foldlevel=0
        else
        	setlocal foldmethod=syntax
            setlocal foldminlines=10
            setlocal foldlevel=4
        endif
	endfunction
    "}}}2
    "Cscope & Tag Settings {{{2
    "-----------------------------------------------------------
        set cst
        set csto=1
        set tags=./tags;,tags;,.git/hooks/tags;
        
        if &diff
        else
            set cscopequickfix=s-,c-,d-,i-,t-,e-,f-
        endif

        if filereadable("cscope.out")
            cs add cscope.out
        endif

        " Autoloading Cscope Database
        function! LoadCscope()
            let db = findfile("cscope.out", ".git/hooks/;")
            if (!empty(db))
                let path = strpart(db, 0, match(db, "/cscope.out$"))
                set nocscopeverbose " suppress duplicate connection error
                exe "cs add " . db . " " . path
                set cscopeverbose
                set autowrite
            endif
        endfunction

        call LoadCscope()

        if filereadable(".git/hooks/my_proj.vim") 
            source .git/hooks/my_proj.vim 
        endif 

        " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
        "set cscopetag
        " My mappings for managing tabs
	    " 0 or s: Find this C symbol
	    " 1 or g: Find this definition
	    " 2 or d: Find functions called by this function
	    " 3 or c: Find functions calling this function
	    " 4 or t: Find this text string
	    " 6 or e: Find this egrep pattern
	    " 7 or f: Find this file
	    " 8 or i: Find files #including this file
	    " 9 or a: Find places where this symbol is assigned a value

        " Hitting '\s' symbol searches current word 
        "noremap<localleader>s "zyiw:exe "tab cs find 0 ".@z.""<CR>
        "noremap<localleader>g "zyiw:exe "tab cs find 1 ".@z.""<CR>
        "noremap<localleader>d "zyiw:exe "tab cs find 2 ".@z.""<CR>
        "noremap<localleader>c "zyiw:exe "tab cs find 3 ".@z.""<CR>
        "noremap<localleader>t "zyiw:exe "tab cs find 4 ".@z.""<CR>
        "noremap<localleader>e "zyiw:exe "tab cs find 6 ".@z.""<CR>
        "noremap<localleader>f "zyiw:exe "tab cs find 7 ".@z.""<CR>
        "noremap<localleader>i "zyiw:exe "tab cs find 8 ".@z.""<CR>

        nmap <silent> <localleader>s :call Cscope('0', expand('<cword>'))<CR>
        nmap <silent> <localleader>g :call Cscope('1', expand('<cword>'))<CR>
        nmap <silent> <localleader>d :call Cscope('2', expand('<cword>'))<CR>
        nmap <silent> <localleader>c :call Cscope('3', expand('<cword>'))<CR>
        nmap <silent> <localleader>t :call Cscope('4', expand('<cword>'))<CR>
        nmap <silent> <localleader>e :call Cscope('6', expand('<cword>'))<CR>
        nmap <silent> <localleader>f :call Cscope('7', expand('<cword>'))<CR>
        nmap <silent> <localleader>i :call Cscope('8', expand('<cword>'))<CR>
        nmap <silent> <localleader>a :call Cscope('9', expand('<cword>'))<CR>

        " Using '\hcX' searches current word and makes the vim
        " window split horizontally, with search result displayed
        " in the new window.
        nmap<localleader>hs "zyiw:exe "scs find 0 ".@z.""<CR>
        nmap<localleader>hg "zyiw:exe "scs find 1 ".@z.""<CR>
        nmap<localleader>hd "zyiw:exe "scs find 2 ".@z.""<CR>
        nmap<localleader>hc "zyiw:exe "scs find 3 ".@z.""<CR>
        nmap<localleader>ht "zyiw:exe "scs find 4 ".@z.""<CR>
        nmap<localleader>he "zyiw:exe "scs find 6 ".@z.""<CR>
        nmap<localleader>hf "zyiw:exe "scs find 7 ".@z.""<CR>
        nmap<localleader>hi "zyiw:exe "scs find 8 ".@z.""<CR>

        " Hitting '\vcsX' searches current word and does a vertical
        " split instead of a horizontal one
        nmap<localleader>vs "zyiw:exe "vert scs find 0 ".@z.""<CR>
        nmap<localleader>vg "zyiw:exe "vert scs find 1 ".@z.""<CR>
        nmap<localleader>vd "zyiw:exe "vert scs find 2 ".@z.""<CR>
        nmap<localleader>vc "zyiw:exe "vert scs find 3 ".@z.""<CR>
        nmap<localleader>vt "zyiw:exe "vert scs find 4 ".@z.""<CR>
        nmap<localleader>ve "zyiw:exe "vert scs find 6 ".@z.""<CR>
        nmap<localleader>vf "zyiw:exe "vert scs find 7 ".@z.""<CR>
        nmap<localleader>vi "zyiw:exe "vert scs find 8 ".@z.""<CR>

        command -nargs=+ Cf cs find f <args>
        command -nargs=+ Cg cs find g <args>
        command -nargs=+ Cc cs find c <args>
        command -nargs=+ Cs cs find s <args>
        command -nargs=+ Ct cs find t <args>
        command -nargs=+ Cd cs find d <args>
        command -nargs=+ Ci cs find i <args>
        command -nargs=+ Ce cs find e <args>
        command -nargs=+ Ca cs find a <args>
    "}}}2
"}}}1

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
	    noremap<leader>te :tabedit <c-r>=expand("%:p:h")<CR>/
	"}}}2

    "VTR Functions {{{2
    :source ~/.vim/flexranVtrFunction.vim
    :source ~/.vim/adkVtrFunction.vim
    :source ~/.vim/fzfCscope.vim
    "}}}2
    
    "SurroundMe {{{2
        vmap [ :norm!Tab [Tab<CR>
    "}}}2
"}}}1

"Autocmd Configs {{{1
    "Vim File Settings{{{2
        function VimFileSettings()
            setlocal foldmethod=marker
            setlocal foldlevel=1
            setlocal foldminlines=10
            setlocal foldenable
            highlight Folded ctermbg=darkgrey ctermfg=white
        endfunction
        autocmd Filetype vim call VimFileSettings()
    "}}}2

    "Cpp File Settings{{{2
        function CppFileSettings()
             setlocal cindent 
             setlocal cino=j1,(0,ws,Ws)
             setlocal textwidth=80
             let c_space_errors=1
             let java_space_errors=1 
             let java_space_errors=1 
             let c_no_trail_space_error=1
             let c_no_tab_space_error=1
        endfunction
        autocmd Filetype cpp call CppFileSettings()
    "}}}2

    "C File Settings{{{2
        function CFileSettings()
            setlocal textwidth=80
            let c_space_errors=1
            let java_space_errors=1 
            let java_space_errors=1 
            let c_no_trail_space_error=1
            let c_no_tab_space_error=1
        endfunction
        autocmd Filetype cpp call CFileSettings()
    "}}}2

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif
"}}}1
