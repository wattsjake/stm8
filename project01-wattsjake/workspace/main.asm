stm8/

	#include "mapping.inc"

	segment 'rom'
main:

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
                ldw X, #$4
delay_loop_out: ldw Y, #$250
delay_loop_in:  decw Y
                jrne delay_loop_in
                decw X
                jrne delay_loop_out
                ret
                
    end






