" FZF Plugin
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
    let g:fzf_history_dir = '~/.fzf-history'

"FZF mapping
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
    "inoremap <c-x>t <plug>(fzf-complete-word)
    "imap <c-x><c-f> <plug>(fzf-complete-path)
    "imap <c-x><c-j> <plug>(fzf-complete-file-ag)
    "imap <c-x><c-l> <plug>(fzf-complete-line)
    "imap <c-x><c-b> <plug>(fzf-complete-buffer-line)

    " Better command history with q:
    command! CmdHist call fzf#vim#command_history({'down': '20'})
    nnoremap q: :CmdHist<CR>
