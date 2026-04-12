#include "p16f84a.inc"

; CONFIG
; __config 0xFFF9
 __CONFIG _FOSC_XT & _WDTE_OFF & _PWRTE_OFF & _CP_OFF

TEMP2	EQU 0X20
TEMP3	EQU 0X21
 
 
    ORG	    0X00
    GOTO    A
    ORG	    0X04
    RETFIE
A
    MOVLW   0X04
    MOVWF   TEMP2
L2
    MOVLW   0X05
    MOVWF   TEMP3
L3
    DECF    TEMP3, 1
    BTFSS   STATUS, 1
    GOTO    L3
    
    DECF    TEMP2, 1
    BTFSS   STATUS, 1
    GOTO    L2
    
    GOTO    $