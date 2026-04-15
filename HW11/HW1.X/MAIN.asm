#include "p16f84a.inc"
 __CONFIG _FOSC_HS & _WDTE_OFF & _PWRTE_OFF & _CP_OFF

 CBLOCK	    0X0C
    POWER
 ENDC

    ORG	    0X00
    GOTO    SETUP
    ORG	    0X04
    RETFIE
    
SETUP
    CALL    SETPORT
    GOTO    MAIN
    
SETPORT
    BSF	    STATUS, RP0
    MOVLW   0X0F
    MOVWF   TRISA
    CLRF    TRISB
    BCF	    STATUS, RP0
    RETURN
    
MAIN
    CALL    ON_OFF
    BTFSS   POWER, 0
    GOTO    MAIN
    CALL    BOX_SIZE
    GOTO    MAIN
    
ON_OFF
    BTFSS   PORTA, 0
    GOTO    ON_OFF_1
    CALL    MOTOR_ON
    RETURN
ON_OFF_1
    CALL    MOTOR_OFF
    RETURN
    
MOTOR_ON
    BSF	    PORTB, 0
    MOVLW   0X01
    MOVWF   POWER
    RETURN
    
MOTOR_OFF
    BCF	    PORTB, 0
    CLRF    POWER
    RETURN
    
BOX_SIZE
    BTFSC   PORTA, 1
    GOTO    BOX_SIZE_1
    CALL    NO_BOX
    RETURN
BOX_SIZE_1
    BTFSC   PORTA, 2
    GOTO    BOX_SIZE_2
    CALL    SMALL_BOX
    RETURN
BOX_SIZE_2
    BTFSC   PORTA, 3
    GOTO    BOX_SIZE_3
    CALL    MEDIUM_BOX
    RETURN
BOX_SIZE_3
    CALL    LARGE_BOX
    RETURN
    
NO_BOX
    BCF	    PORTB, 1
    BCF	    PORTB, 2
    BCF	    PORTB, 3
    RETURN
    
SMALL_BOX
    BSF	    PORTB, 1
    BCF	    PORTB, 2
    BCF	    PORTB, 3
    RETURN

MEDIUM_BOX
    BCF	    PORTB, 1
    BSF	    PORTB, 2
    BCF	    PORTB, 3
    RETURN
    
LARGE_BOX
    BCF	    PORTB, 1
    BCF	    PORTB, 2
    BSF	    PORTB, 3
    RETURN
    
    END