stm8/
;********************************************************
;Program Name:  "main.asm"
;Description: Blink LED light with naive delay
;
;Author:        Jacob Watts
;Device: STM8S003K3
;Revision History
;Date[YYYYMMDD] Author          Description
;----           ------          -----------
;20230623      Jacob W.        initial commit 
;********************************************************

;---------------------- INCLUDES ------------------------
	#include "mapping.inc"
    #include "stm8s103k.inc"

    segment byte at 000 'ram1'
timer_count ds.b

    segment 'rom'
init: 
    ld A, #$00
    ld timer_count, A

main:
    
    ld A, #$F0
    mov TIM1_CR1, #$10

    

infinite_loop:
	jra infinite_loop

	end
