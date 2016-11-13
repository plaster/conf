se lisp expandtab

" Thanks to ayamada:
"   https://github.com/ayamada/copy-of-svn.tir.jp/blob/master/nekoie/scripts/scheme.vim
syn region schemeConstant start=+\%(\\\)\@<!#/+ skip=+\\[\\/]+ end=+/+

command -nargs=+ HiLink hi def link <args>
HiLink schemeRegexp     schemeString
