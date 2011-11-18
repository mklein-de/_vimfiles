function matchcurrentword#MatchCurrentWord()
  silent! call matchdelete(b:currentWordMatchId)
  if match(getline('.')[col('.')-1], '\w') == 0
    let b:currentWordMatchId = matchadd('CurrentWord', '\<'.expand("<cword>").'\>', 0)
  else
    silent! unlet b:currentWordMatchId
  endif
endfun

