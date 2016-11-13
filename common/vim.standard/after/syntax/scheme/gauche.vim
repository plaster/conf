se lisp expandtab

" Thanks to ayamada:
"   https://github.com/ayamada/copy-of-svn.tir.jp/blob/master/nekoie/scripts/scheme.vim
syn region schemeConstant start=+\%(\\\)\@<!#/+ skip=+\\[\\/]+ end=+/+
syn match schemeOther oneline "|[^|]\+|"
syn match schemeSharpBang oneline "#!.*"

hi def link schemeRegexp     schemeString
hi def link schemeSharpBang  Special
