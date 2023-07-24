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
;20230623       Jacob W.        initial commit 
;20230723       Jacob W.        issues with debugging
;20230723       Jacob W.        code is working now
;********************************************************

;------------------------ TODO --------------------------

;---------------------- INCLUDES ------------------------
	#include "mapping.inc"
    #include "stm8s103k.inc"

    segment 'rom'
;------------------------ INIT --------------------------
initilize:
    mov TIM2_PSCR, #$03 ;prescaler = 8 PC 0x8080
    mov TIM2_ARRH, #$00 ;high byte of 50,000
    mov TIM2_ARRL, #$AF ;low byte of 50,000
    mov TIM2_IER, #$01 ;enable interrupts
    mov TIM2_CR1, #$01 ;enable the timer
;------------------------ MAIN --------------------------
main:
    ld A,#$FF
    ;call naive_delay
    ld A,#$00
    mov $00, #$45
    jra main
;----------------------- DELAY --------------------------
naive_delay:
                ldw X, #$40 ;change duration of delay
delay_loop_out: ldw Y, #$20
delay_loop_in:  decw Y
                jrne delay_loop_in
                decw X
                jrne delay_loop_out
                ret               

    end
;------------------------ END ---------------------------