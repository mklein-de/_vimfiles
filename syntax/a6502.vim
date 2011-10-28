" Vim syntax file
" Language:	6502 assembler
" Maintainer:	Maciej Witkowiak <ytm@elysium.pl>
" Last Change:	2000 August 21
" Based on Z80 syntax

" Remove any old syntax
syn clear
syn case ignore

" Common 6502 Assembly instructions
syn keyword a65Instruction adc and asl bcc bcs beq bit bmi bne bpl brk bvc bvs
syn keyword a65Instruction clc cld cli clv cmp cpx cpy dec dex dey eor
syn keyword a65Instruction inc inx iny jmp jsr lda ldx ldy lsr nop ora
syn keyword a65Instruction pha php pla plp rol ror rti rts
syn keyword a65Instruction sbc sec sed sei sta stx sty
syn keyword a65Instruction tax tay tsx txa txs tya

" Any other stuff
syn match a65Identifier		"[a-z_][a-z0-9_]*"

"Labels
syn match a65Label		"^[a-z_\.][a-z0-9_]*"

" most common assembler commands
syn match a65PreProc	"\.org"
syn match a65PreProc	"\*.*="
syn match a65PreProc	"\.byte"
syn match a65PreProc	"\.word"
syn match a65PreProc	"\.text"
syn match a65PreProc	"\.ascii"
syn match a65PreProc	"\.asciz"
syn match a65PreProc	"\.page"
syn match a65PreProc	"\.endp"
syn match a65Include	"\.include"
syn match a65PreCondit	"\.if"
syn match a65PreCondit	"\.else"
syn match a65PreCondit	"\.endif"
syn match a65PreCondit	"\.fi"
syn match a65Instruction "\.macro"
syn match a65Instruction "\.endm"

" some (not all) ACME assembler commands
syn match a65PreProc	"\!cpu"
syn match a65PreProc	"\!byte"
syn match a65PreProc	"\!word"
syn match a65PreProc	"\!text"
syn match a65PreProc	"\!set"
syn match a65PreProc	"\!zone"
syn match a65PreProc	"\!subzone"
syn match a65Include	"\!source"
syn match a65Include	"\!to"
syn match a65PreCondit	"\!if"
syn match a65PreCondit	"\!else"
syn match a65Instruction "+[a-z_]*"

" Common strings
syn match a65String		"\".*\""
syn match a65String		"\'.*\'"

" Numbers
syn match a65Number             "#\=[0-9]\+\>"
syn match a65Number             "#\=\$[0-9a-f]\+\>"
syn match a65Number             "#\=%[01]\+\>"

" Character constant
syn match a65String             "#\='."hs=s+1

" Comments
syn match a65Comment		";.*"

syn case match

if !exists("did_a65_syntax_inits")
  let did_a65_syntax_inits = 1

  " The default methods for highlighting
  hi link a65Section		Special
  hi link a65Label		Label
  hi link a65Comment		Comment
  hi link a65Instruction	Statement
  hi link a65SpecInst		Statement
  hi link a65Include		Include
  hi link a65PreCondit		PreCondit
  hi link a65PreProc		PreProc
  hi link a65Number		Number
"  hi link a65String		String
  hi a65String		ctermfg=lightgreen

  hi a65Label	ctermfg=green


endif

set tabstop=8

let b:current_syntax = "a6502"
" vim: ts=8
