echo "loading gauche.vim"

if exists('g:loaded_syntastic_scheme_gauche_checker')
    finish
endif
let g:loaded_syntastic_scheme_gauche_checker=1

let s:save_cpo = &cpo
set cpo&vim

let &cpo = s:save_cpo
unlet s:save_cpo
