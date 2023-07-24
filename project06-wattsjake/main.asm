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
;********************************************************

;------------------------ TODO --------------------------

;---------------------- INCLUDES ------------------------
	#include "mapping.inc"

    segment 'rom'
;------------------------ MAIN --------------------------
main:
    ld A,#$FF
    call naive_delay
    ld A,#$00
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