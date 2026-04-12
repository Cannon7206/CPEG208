; PIC16F84A Configuration Bit Settings

; Assembly source line config statements

#include "p16f84a.inc"

; CONFIG
; __config 0xFFFB
 __CONFIG _FOSC_EXTRC & _WDTE_OFF & _PWRTE_OFF & _CP_OFF

    ORG	    0x00
    GOTO    MAIN
    ORG	    0x04
    RETFIE
MAIN
    CALL    SETPORT
    GOTO    A
    
SETPORT
    BSF	    STATUS, RP0	; Switch to Bank1
    MOVLW   0x07	; Port A: Pins 0-2 input, 3-4 output
    MOVWF   TRISA
    CLRF    TRISB	; Port B: All pins set to output
    BCF	    STATUS, RP0	; Switch to Bank0
    RETURN
    
A
    BTFSS   PORTA, 0	; Skip if RA0 = 1
    GOTO    A		
    
    BTFSS   PORTA, 2	; Skip if RA2 = 1
    GOTO    RA2_0
    GOTO    RA2_1
    
RA2_0
    BTFSS   PORTA, 1	; Skip if RA1 = 1
    GOTO    SET_00
    GOTO    SET_01
    
RA2_1
    BTFSS   PORTA, 1	; Skip if RA1 = 1
    GOTO    SET_04
    GOTO    SET_05
    
SET_00
    MOVLW   0x00
    MOVWF   PORTB	; Set PORTB to 0x00
    GOTO    A
    
SET_01
    MOVLW   0x01
    MOVWF   PORTB	; Set PORTB to 0x01
    GOTO    A
    
SET_04
    MOVLW   0x04
    MOVWF   PORTB	; Set PORTB to 0x04
    GOTO    A
    
SET_05
    MOVLW   0x05
    MOVWF   PORTB	; Set PORTB to 0x05
    GOTO    A

    END