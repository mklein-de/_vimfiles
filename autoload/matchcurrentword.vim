function matchcurrentword#MatchCurrentWord()
  if exists('b:currentWordMatchId')
    call matchdelete(b:currentWordMatchId)
  endif
  let b:currentWordMatchId = matchadd('CurrentWord', '\<'.expand("<cword>").'\>')
endfun

