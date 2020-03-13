
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
