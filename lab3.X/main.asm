#include "p16f84a.inc"
 __CONFIG _FOSC_EXTRC & _WDTE_OFF & _PWRTE_OFF & _CP_OFF

    PHILPOT     EQU 0x20
    COUNT       EQU 0x45
    SUML        EQU 0x4F
    SUMH        EQU 0x4E
    STATUS_SAVE EQU 0x4D

    org     0x00
    goto    SETUP
    org     0x04
    retfie

; PART 1 - Generate sequence
; First=0x23, Increment=0x02, Length=0x21 (33 values)
SETUP
    CLRF    SUML
    CLRF    SUMH
    MOVLW   0x21            ; COUNT = 33
    MOVWF   COUNT
    MOVLW   0x20            ; FSR = address 0x20
    MOVWF   FSR
    MOVLW   0x23            ; W = first value

LOOP
    MOVWF   INDF            ; [FSR] = W
    INCF    FSR,1           ; FSR++
    ADDLW   0x02            ; W += 2
    DECF    COUNT,1
    BTFSS   STATUS,Z
    GOTO    LOOP

; PART 2 - Sum the sequence
    MOVLW   0x21            ; Reload COUNT
    MOVWF   COUNT
    MOVLW   0x20            ; Reset FSR to 0x20
    MOVWF   FSR
    CLRW                    ; W = 0

LOOP2
    ADDWF   INDF,0          ; W = W + [FSR]
    BTFSC   STATUS,C        ; If carry, increment high byte
    INCF    SUMH,1
    INCF    FSR,1
    DECF    COUNT,1
    BTFSS   STATUS,Z
    GOTO    LOOP2

    MOVWF   SUML            ; Store low byte at 0x4F
    MOVF    STATUS,W
    MOVWF   STATUS_SAVE     ; Save STATUS at 0x4D

    GOTO $                  ; Halt
    end