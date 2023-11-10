stm8/
;***********************************************************
;Program Name:  "main.asm"
;Description: Interface the STM8S003K3 with 23LCV1024
;             1 Mbit SPI Serial SRAM
;
;Author: Jacob Watts
;Device: STM8S003K3
;Revision History
;Date[YYYYMMDD] Author          Description
;----           ------          -----------
;20230809       Jacob W.        initial commit
;20230823       Jacob W.        external clk 
;***********************************************************

;------------------------ TODO -----------------------------
;
;---------------------- INCLUDES ---------------------------
	#include "mapping.inc"
    #include "stm8s103k.inc"
    
    segment byte at 100 'ram1'
led_state  ds.b

	segment 'rom'
;--------------------- CLEAR MEM ---------------------------
main
	; initialize SP
	ldw X,#stack_end
	ldw SP,X

;--------------------- CLEAR RAM0 --------------------------
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

;--------------------- CLEAR RAM1 --------------------------
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

;--------------------- CLEAR STACK -------------------------
	; clear stack
stack_start.w EQU $stack_segment_start
stack_end.w EQU $stack_segment_end
	ldw X,#stack_start
clear_stack.l
	clr (X)
	incw X
	cpw X,#stack_end	
	jrule clear_stack
    
;------------------------ CLK ------------------------------
clk_init:
    bset CLK_SWCR, #1 ;Enable clock switch execution
    mov CLK_SWR, #$B4 ;0xB4: HSE selected as master clk src

;------------------------ INIT -----------------------------
initilize:
        
    bset PD_DDR, #0 ;sets PD0 as output
    
    sim ;disable interrupts
    mov TIM2_PSCR, #$03 ;3 = prescaler = 8 PC 0x8080
    mov TIM2_ARRH, #$00 ;high byte of 50,000
    mov TIM2_ARRL, #$08 ;low byte of 50,000
    bset TIM2_IER, #0 ;enable update interrupt
    rim ;Enable interrupts
    bset TIM2_CR1, #0 ;enable the timer
    
    bres PD_ODR, #0 ;sets PD0 to low led on
    bset led_state, #0 ;set bit0 to 1
;------------------------ MAIN -----------------------------
loop:
    ld A, led_state
    mov PD_ODR, led_state
    
    ;ld led_state, A
    jra loop

; TIM2 update/overflow handler
    interrupt tim2_overflow
tim2_overflow.l
    mov TIM2_SR1, #$00 ;reset interupt
    xor A, #$FF
    ld led_state, A
    iret
    
	interrupt NonHandledInterrupt
NonHandledInterrupt.l
	iret
    
	segment 'vectit'
	dc.l {$82000000+main}							 ; reset
	dc.l {$82000000+NonHandledInterrupt}	; trap
	dc.l {$82000000+NonHandledInterrupt}	; irq0
	dc.l {$82000000+NonHandledInterrupt}	; irq1
	dc.l {$82000000+NonHandledInterrupt}	; irq2
	dc.l {$82000000+NonHandledInterrupt}	; irq3
	dc.l {$82000000+NonHandledInterrupt}	; irq4
	dc.l {$82000000+NonHandledInterrupt}	; irq5
	dc.l {$82000000+NonHandledInterrupt}	; irq6
	dc.l {$82000000+NonHandledInterrupt}	; irq7
	dc.l {$82000000+NonHandledInterrupt}	; irq8
	dc.l {$82000000+NonHandledInterrupt}	; irq9
	dc.l {$82000000+NonHandledInterrupt}	; irq10
	dc.l {$82000000+NonHandledInterrupt}	; irq11
	dc.l {$82000000+NonHandledInterrupt}	; irq12
	dc.l {$82000000+tim2_overflow}	; irq13
	dc.l {$82000000+NonHandledInterrupt}	; irq14
	dc.l {$82000000+NonHandledInterrupt}	; irq15
	dc.l {$82000000+NonHandledInterrupt}	; irq16
	dc.l {$82000000+NonHandledInterrupt}	; irq17
	dc.l {$82000000+NonHandledInterrupt}	; irq18
	dc.l {$82000000+NonHandledInterrupt}	; irq19
	dc.l {$82000000+NonHandledInterrupt}	; irq20
	dc.l {$82000000+NonHandledInterrupt}	; irq21
	dc.l {$82000000+NonHandledInterrupt}	; irq22
	dc.l {$82000000+NonHandledInterrupt}	; irq23
	dc.l {$82000000+NonHandledInterrupt}	; irq24
	dc.l {$82000000+NonHandledInterrupt}	; irq25
	dc.l {$82000000+NonHandledInterrupt}	; irq26
	dc.l {$82000000+NonHandledInterrupt}	; irq27
	dc.l {$82000000+NonHandledInterrupt}	; irq28
	dc.l {$82000000+NonHandledInterrupt}	; irq29

	end
