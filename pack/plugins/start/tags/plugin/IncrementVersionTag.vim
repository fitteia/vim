function! IncrementVersionTag()
    " Determine the comment style based on filetype
    :filetype detect	
    let comment_char = {
	\ 'vim': '"',
        \ 'c': '//',
        \ 'cpp': '//',
        \ 'python': '#',
        \ 'sh': '#',
        \ 'javascript': '//',
        \ 'html': '<!--',
        \ 'perl': '#',
        \ 'raku': '#',
        \ 'fortran': '*',
        \}[&filetype]
	
"    call append(line('$'),&filetype . comment_char)

    let comment_suffix = {
        \ 'vim': '',
        \ 'c': '',
        \ 'cpp': '',
        \ 'python': '',
        \ 'sh': '',
        \ 'javascript': '',
        \ 'perl': '',
        \ 'raku': '',
        \ 'fortran': '',
 	\ 'html': ' -->',
        \}[&filetype]

    if empty(comment_char)
        return "Unsupported file type"
    endif

    " Get all lines from the file
    let lines = getline(1, '$')

    " Regex to match version comment
    let tag_pattern = '^' . escape(comment_char, '/') . ' vim .* \d\+\.\d\+\.\d\+' . (exists('comment_suffix') ? escape(comment_suffix, '/') : '')

    " Find the last line that matches the pattern
    let tag_line_index = -1
    for i in range(len(lines))
        if lines[i] =~# tag_pattern
            let tag_line_index = i
        endif
    endfor

    if tag_line_index != -1
        " Extract version number
        let match = matchstr(lines[tag_line_index], '\d\+\.\d\+\.\d\+')
        if match != ''
            let version_parts = split(match, '\.')
            let patch = str2nr(version_parts[2]) + 1
            let new_tag = version_parts[0] . '.' . version_parts[1] . '.' . patch
            let lines[tag_line_index] = substitute(lines[tag_line_index], match, new_tag, '')
        endif
    else
        " If no tag exists, create an initial one
        let new_tag = "1.0.0"
        let tag_line = comment_char . ' vim ' . strftime("%Y-%m-%d") . ' ' . new_tag
        if &filetype == 'html'
            let tag_line .= ' -->'
        endif
        call add(lines, tag_line)
    endif

    " Write updated lines back to the file
	 call setline(1,lines)
"    call writefile(lines, expand('%'))
endfunction

function! TagWhenWrite()
	call IncrementVersionTag()
endfunction

nnoremap <Leader>v :call IncrementVersionTag()<CR>
" vim 2025-01-30 1.0.290
