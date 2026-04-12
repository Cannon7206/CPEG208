#include "p16f84a.inc"

; CONFIG
; __config 0xFFF9
 __CONFIG _FOSC_XT & _WDTE_OFF & _PWRTE_OFF & _CP_OFF

CBLOCK 0X10
    COIN
ENDC
    
    ORG	    0X00
    GOTO    SETUP
    ORG	    0X04
    RETFIE
    
SETPORT
    BSF	    STATUS, RP0
    MOVLW   0XFF
    MOVWF   TRISA
    CLRF    TRISB
    CLRF    W
    BCF	    STATUS, RP0
    RETURN
    
SETUP
    CALL    SETPORT
    GOTO    MAIN
    
MAIN
    CALL    MONITOR
    GOTO    MAIN
    
    
MONITOR
    BTFSS   PORTA, 1
    BCF	    PORTB, 0
    BTFSS   PORTA, 1
    GOTO    MONITOR
    BSF	    PORTB, 0
    RETURN

    END

