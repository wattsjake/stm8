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
;********************************************************


;------------------------ TODO --------------------------

	#include "mapping.inc"

	segment 'rom'
;------------------ PORT CONFIGURATION ------------------
PD_ODR EQU $00500F  ;Port D data output latch register
PD_IDR EQU $005010  ;PD_IDR Port D input pin value register
PD_DDR EQU $005011  ;PD_DDR Port D data direction register
PD_CR1 EQU $005012  ;PD_CR1 Port D control register 1 
PD_CR2 EQU $005013  ;PD_CR2 Port D control register 2 

;------------------------ MAIN --------------------------
    bset PD_DDR, #0 ;sets PD0 as output
main:
    bres PD_ODR, #0 ;sets PD0 to high
    call naive_delay
    bset PD_ODR, #0 ;sets PD0 to high
    call naive_delay
    jra main
    
    
    ldw X,#00
fill_memory:
    ldw Y, X ;load x data into y
    ld A, #$00
    ld (Y), A
    ;clr (X) ;clears mem at location x
    incw X ;increments memory address
    cpw X,#$FF ;compares if equal to FF
    jrule fill_memory ;will continue if equal to FF

    call naive_delay
    mov $10, #$FF
    
    
naive_delay:
                ldw X, #$100
delay_loop_out: ldw Y, #$250
delay_loop_in:  decw Y
                jrne delay_loop_in
                decw X
                jrne delay_loop_out
                ret
                
    end






