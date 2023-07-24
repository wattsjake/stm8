stm8/

	#include "mapping.inc"
    #include "stm8s103k.inc"

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
    
;------------------------ INIT --------------------------
initilize:
    sim ;disable interrupts
    mov TIM2_PSCR, #$03 ;prescaler = 8 PC 0x8080
    mov TIM2_ARRH, #$00 ;high byte of 50,000
    mov TIM2_ARRL, #$AF ;low byte of 50,000
    bset TIM2_IER, #0 ;enable update interrupt
    rim ;Enable interrupts
    bset TIM2_CR1, #0 ;enable the timer
;------------------------ MAIN --------------------------
loop:
    ld A,#$FF
    ;call naive_delay
    ld A,#$00
    mov $00, #$45
    jra loop

; TIM2 update/overflow handler
tim2_overflow:
    mov TIM2_SR1, #$00 ;reset interupt
    mov $01, #$50
    iret


    end ;need to do an 'Enter' after end statement
    