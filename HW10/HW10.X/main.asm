#include "p16f84a.inc"

; CONFIG
; __config 0xFFFA
 __CONFIG _FOSC_HS & _WDTE_OFF & _PWRTE_OFF & _CP_OFF

    ORG	    0X00
    GOTO    SETUP
    ORG	    0X04
    RETFIE
    
SETUP
    CALL    SETPORT
    GOTO    MAIN

SETPORT
    BSF	    STATUS, RP0
    BCF	    TRISA, 0
    BCF	    TRISA, 1
    BCF	    TRISA, 2
    BSF	    TRISA, 3
    BCF	    STATUS, RP0
    RETURN
    
MAIN
    BTFSS   PORTA, 3
    CALL    MAIN1
    BTFSC   PORTA, 3
    CALL    MAIN2
    GOTO    MAIN
    
MAIN1
    CALL    REDLED
    CALL    MOTOROFF
    RETURN
    
MAIN2
    CALL    GREENLED
    CALL    MOTORON
    RETURN

GREENLED
    BSF	    PORTA, 2
    BCF	    PORTA, 1
    RETURN
    
REDLED
    BSF	    PORTA, 1
    BCF	    PORTA, 2
    RETURN
    
MOTOROFF
    BCF	    PORTA, 0
    RETURN
    
MOTORON
    BSF	    PORTA, 0
    RETURN

    END