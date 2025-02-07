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
	let num1 = str2nr(matchstr(matchstr(here,'DO\s\+\d\+'),'\d\+'))
	let new_line = substitute(here,'DO\s\+\d\+',printf('DO %d',num1-1),'')
	call setline('.',new_line)
endfunction

function DOPLUS()
	let here=getline('.')
	let num1 = str2nr(matchstr(matchstr(here,'DO\s\+\d\+'),'\d\+'))
	let new_line = substitute(here,'DO\s\+\d\+',printf('DO %d',num1+1),'')
	call setline('.',new_line)
endfunction

function COMPILE()
	write
	execute '! gcc -O3 -fpic -c %' 
endfunction

function TEST()
	write
	execute '! make' 
	execute '! cp libminuit.a ~/.local/OneFit-Engine/lib/'
	execute '! cd ~/public_html/ && onefite fit "Mz(x,a,b,t)=a\+b*exp(-x/t)" zone12.dat --logx --autox --ssz=0.2'
   execute '! cd ~/public_html/ && diff ofe-tmp/fit1.log /tmp'	
endfunction

nnoremap <Leader>d :call CONTINUE1()<CR>
nnoremap <Leader>dd :call CONTINUE2()<CR>
nnoremap <Leader>- :call DOMINUS()<CR>
nnoremap <Leader>+ :call DOPLUS()<CR>
nnoremap <Leader>t :call TEST()<CR>
nnoremap <Leader>gcc :call COMPILE()<CR>

