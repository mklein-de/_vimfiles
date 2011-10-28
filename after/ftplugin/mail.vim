if version >= 602
  set formatoptions+=w
endif

nmap <silent> <buffer> <f2> mz:/^-- $/+1,$!makesig<CR>'z
