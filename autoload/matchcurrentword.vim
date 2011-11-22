function! matchcurrentword#MatchCurrentWord()
  for m in getmatches()
    if m['group'] == 'CurrentWord'
      call matchdelete(m['id'])
    endif
  endfor
  if match(getline('.')[col('.')-1], '\w') == 0
    call matchadd('CurrentWord', '\<'.expand("<cword>").'\>', 0)
  endif
endfun

