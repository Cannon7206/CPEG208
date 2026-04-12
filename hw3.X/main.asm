#include "p16f84a.inc"

; CONFIG
; __config 0xFFF3
 __CONFIG _FOSC_EXTRC & _WDTE_OFF & _PWRTE_ON & _CP_OFF
 
    org	    0x00
    goto    setup
    org	    0x04
    retfie
setup
temp EQU    0x20
    MOVLW   0X42	
    MOVWF   temp	
    BCF	    temp,3
    nop 
    end