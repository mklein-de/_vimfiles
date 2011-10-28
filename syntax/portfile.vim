syn match portfileTab "\t"
syn match portfileTrailingSpace "\s\+$"
syn match Comment "#.*$"
syn match Identifier "\${\(\w\|\.\)*}"

syn region String   start=+"+  skip=+\\\\\|\\"+  end=+"+ contains=Identifier

hi link portfileTab Error
hi link portfileTrailingSpace Error
"hi link portfileComment Comment
"hi link portfileVariable Identifier
