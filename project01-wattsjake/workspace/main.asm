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

	segment 'rom'
;------------------ PORT CONFIGURATION ------------------
;may not need to define the port addresses still need to
;research...
PD_ODR EQU $00500F  ;Port D data output latch register
PD_IDR EQU $005010  ;PD_IDR Port D input pin value register
PD_DDR EQU $005011  ;PD_DDR Port D data direction register
PD_CR1 EQU $005012  ;PD_CR1 Port D control register 1 
PD_CR2 EQU $005013  ;PD_CR2 Port D control register 2 

;------------------------ INIT --------------------------
    bset PD_DDR, #0 ;sets PD0 as output

;------------------------ MAIN --------------------------
main:
    bres PD_ODR, #0 ;sets PD0 to low
    call naive_delay
    bset PD_ODR, #0 ;sets PD0 to high
    call naive_delay
    jra main

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
    
