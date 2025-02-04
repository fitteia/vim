:set ts=3 sw=3 
:syntax enable
function CONTINUE1()
	let here=getline('.')
	let num1 = matchstr(here,'^\s*\d\+\s*')
	let new_line = substitute(here,'^\s*\d\+\s*',printf('      '),'')
	call setline('.',new_line)
	let continue_line= printf('%5s',num1) . 'CONTINUE'
	call append('.',continue_line)
endfunction

function CONTINUE2()
	let here=getline('.')
	let num1 = str2nr(matchstr(here,'^\s*\d\+\s*'))
	let new_line = substitute(here,'^\s*\d\+\s*',printf('      '),'')
	call setline('.',new_line)
	let continue_line= printf('%5d ',num1) . 'CONTINUE'
	call append('.',continue_line)
	let continue_line= printf('%5d ',num1-1) . 'CONTINUE'
	call append('.',continue_line)
endfunction

function DOMINUS()
	let here=getline('.')
	let num1 = str2nr(matchstr(matchstr(here,'DO \d\+'),'\d\+'))
	let new_line = substitute(here,'DO \d\+',printf('DO %d',num1-1),'')
	call setline('.',new_line)
endfunction

function DOPLUS()
	let here=getline('.')
	let num1 = str2nr(matchstr(matchstr(here,'DO \d\+'),'\d\+'))
	let new_line = substitute(here,'DO \d\+',printf('DO %d',num1+1),'')
	call setline('.',new_line)
endfunction
nnoremap <Leader>c :call CONTINUE1()<CR>
nnoremap <Leader>cc :call CONTINUE2()<CR>
nnoremap <Leader>- :call DOMINUS()<CR>
nnoremap <Leader>+ :call DOPLUS()<CR>

