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
;20230521       Jacob W.        initial commit 
;20230522       Jacob W.        added comments
;********************************************************

;------------------------ TODO --------------------------

;---------------------- INCLUDES ------------------------
	#include "mapping.inc"
    #include "stm8s003k3.inc"
    
    segment byte at 100 'ram1'
button  ds.b
buffer0 ds.b

	segment 'rom'
main.l
	; initialize SP
	ldw X,#stack_end
	ldw SP,X

	#ifdef RAM0	
	; clear RAM0
ram0_start.b EQU $ram0_segment_start
ram0_end.b EQU $ram0_segment_end
	ldw X,#ram0_start
clear_ram0.l
	clr (X)
	incw X
	cpw X,#ram0_end	
	jrule clear_ram0
	#endif

	#ifdef RAM1
	; clear RAM1
ram1_start.w EQU $ram1_segment_start
ram1_end.w EQU $ram1_segment_end	
	ldw X,#ram1_start
clear_ram1.l
	clr (X)
	incw X
	cpw X,#ram1_end	
	jrule clear_ram1
	#endif

	; clear stack
stack_start.w EQU $stack_segment_start
stack_end.w EQU $stack_segment_end
	ldw X,#stack_start
clear_stack.l
	clr (X)
	incw X
	cpw X,#stack_end	
	jrule clear_stack

;----------------------- MEMORY -------------------------
button_state EQU $000000


;------------------------ INIT --------------------------
    bset PD_DDR, #0 ;sets PD0 as output

    bres PB_DDR, #7 ;sets PB7 as input
    bset PB_CR1, #7 ;sets PB7 as pull-up without interrupt
    bres PB_CR2, #7 ;sets PB7 as pull-up without interrupt
    
    bset button, #7

;------------------------ MAIN --------------------------
check_button:
    ld A, PB_IDR ;load A with state of button
    and A, #$80 ;and it with 80
    ld button_state, A
    cp A, #$80 ;check to see if button has been pressed
    jreq button_on ;jump to button_on if Z=1
    mov PD_ODR, #$00 ;sets PD0 to low
    jra check_button

button_on:
    mov PD_ODR, #$FF ;sets PD0 to high
    jra check_button

;----------------------- DELAY --------------------------
naive_delay:
                ldw X, #$400 ;change duration of delay
delay_loop_out: ldw Y, #$250
delay_loop_in:  decw Y
                jrne delay_loop_in
                decw X
                jrne delay_loop_out
                ret

    end
;------------------------ END ---------------------------
    
; stm8/

; 	#include "mapping.inc"

; 	segment 'rom'
; main.l
; 	; initialize SP
; 	ldw X,#stack_end
; 	ldw SP,X

; 	#ifdef RAM0	
; 	; clear RAM0
; ram0_start.b EQU $ram0_segment_start
; ram0_end.b EQU $ram0_segment_end
; 	ldw X,#ram0_start
; clear_ram0.l
; 	clr (X)
; 	incw X
; 	cpw X,#ram0_end	
; 	jrule clear_ram0
; 	#endif

; 	#ifdef RAM1
; 	; clear RAM1
; ram1_start.w EQU $ram1_segment_start
; ram1_end.w EQU $ram1_segment_end	
; 	ldw X,#ram1_start
; clear_ram1.l
; 	clr (X)
; 	incw X
; 	cpw X,#ram1_end	
; 	jrule clear_ram1
; 	#endif

; 	; clear stack
; stack_start.w EQU $stack_segment_start
; stack_end.w EQU $stack_segment_end
; 	ldw X,#stack_start
; clear_stack.l
; 	clr (X)
; 	incw X
; 	cpw X,#stack_end	
; 	jrule clear_stack

; infinite_loop.l
; 	jra infinite_loop

; 	end
