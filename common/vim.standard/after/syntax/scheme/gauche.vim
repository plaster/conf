se lisp expandtab
se nosmartindent

"se iskeyword=33,35-39,42-58,60-90,94,95,97-122,126,_
se  iskeyword=33,35-38,42-43,45-58,60-90,94,95,97-122,126,_

" Thanks to ayamada:
"   https://github.com/ayamada/copy-of-svn.tir.jp/blob/master/nekoie/scripts/scheme.vim
syn region schemeConstant start=+\%(\\\)\@<!#/+ skip=+\\[\\/]+ end=+/+
syn match schemeOther oneline "|[^|]\+|"
syn match schemeSharpBang oneline "#!.*"

syn region schemeStrucRestricted matchgroup=Delimiter start="#u8("  matchgroup=Delimiter end=")" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc
syn region schemeStrucRestricted matchgroup=Delimiter start="#u16(" matchgroup=Delimiter end=")" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc
syn region schemeStrucRestricted matchgroup=Delimiter start="#u32(" matchgroup=Delimiter end=")" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc
syn region schemeStrucRestricted matchgroup=Delimiter start="#u64(" matchgroup=Delimiter end=")" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc

syn region schemeStrucRestricted matchgroup=Delimiter start="#s8("  matchgroup=Delimiter end=")" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc
syn region schemeStrucRestricted matchgroup=Delimiter start="#s16(" matchgroup=Delimiter end=")" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc
syn region schemeStrucRestricted matchgroup=Delimiter start="#s32(" matchgroup=Delimiter end=")" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc
syn region schemeStrucRestricted matchgroup=Delimiter start="#s64(" matchgroup=Delimiter end=")" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc

syntax region schemeMultilineComment start=/#|/ end=/|#/ contains=@Spell,schemeMultilineComment

hi def link schemeRegexp     schemeString
hi def link schemeSharpBang  Special
