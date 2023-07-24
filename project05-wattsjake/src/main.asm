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
main:
    
    

    ld A, #$45
    
    mov TIM2_PSCR, #$03 ;prescaler = 8
    mov TIM2_ARRH, #$00 ;high byte of 50,000
    mov TIM2_ARRL, #$AF ;low byte of 50,000
    mov TIM2_IER, #$01
    mov TIM2_CR1, #$01
    
infinite_loop:
    jra infinite_loop
 
    end
