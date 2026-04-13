#include "p16f84a.inc"

    __CONFIG _FOSC_XT & _WDTE_OFF & _PWRTE_OFF & _CP_OFF

CBLOCK 0x0C
    REDLED
    GREENLED
ENDC

    ORG     0x00
    GOTO    SETUP
    ORG     0x04
    RETFIE

;--------------------------------------------------
SETPORT
    BSF     STATUS, RP0     ; Bank 1
    CLRF    TRISA           ; PORTA all outputs
    MOVLW   0xFF
    MOVWF   TRISB           ; PORTB all inputs
    BCF     STATUS, RP0     ; Bank 0
    RETURN

;--------------------------------------------------
SETUP
    CALL    SETPORT
    CLRF    PORTA
    MOVLW   0x01
    MOVWF   REDLED          ; RA0 = Red LED
    MOVLW   0x02
    MOVWF   GREENLED        ; RA1 = Green LED
    GOTO    MAIN


MAIN
    MOVF    PORTB, W        ; Read weight
    ADDLW   D'245'          ; Carry set if PORTB >= 11 (WEIGHT > 10)
    BTFSC   STATUS, C
    GOTO    GREEN           ; Yes -> GREENON -> BB
    GOTO    RED             ; No  -> REDON  -> BB
GREEN                       ; GREENON
    CALL    GREENLEDON
    GOTO    MAIN            ; BB -> back to AA

RED                         ; REDON
    CALL    REDLEDON
    GOTO    MAIN            ; BB -> back to AA
REDLEDON
    MOVF    REDLED, W
    MOVWF   PORTA
    RETURN

GREENLEDON
    MOVF    GREENLED, W
    MOVWF   PORTA
    RETURN

    END