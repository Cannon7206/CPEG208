#include "p16f84a.inc"

; CONFIG
; __config 0xFFFB
 __CONFIG _FOSC_EXTRC & _WDTE_OFF & _PWRTE_OFF & _CP_OFF
 	
X	EQU	0x13		; X register
Y	EQU	0x15		; Y register
COUNT   EQU     0x19		; Counter register
XADDY	EQU	0x20		; X + Y
XSUBY	EQU	0x22		; X - Y
XANDY	EQU	0x24		; X AND Y
XXORY	EQU	0x26		; X XOR Y
XORY	EQU	0x28		; X OR Y

	ORG     0x00
	GOTO    MAIN
	ORG     0x04
	RETFIE
MAIN
	MOVLW	0xB0		; Move 0xB0 into W
	MOVWF	X		; Copy W into X
	MOVLW	0x55		; Move 0x55 into W
	MOVWF	Y		; Copy W into Y

	MOVF	X,W		; Copy X into W
	ADDWF	Y,W		; ADD X to Y
	MOVWF	XADDY		; Copy W into X+Y
	MOVF	STATUS,W		; Copy STATUS into W
	MOVWF	0x21		; Copy W into 0x21
	
	MOVF	X,W		; Copy X into W
	SUBWF	Y,W		; Subtract X from Y
	MOVWF	XSUBY		; Copy W into X-Y
	MOVF	STATUS,W	; Copy STATUS into W
	MOVWF	0x23		; Copy W into 0x23
	
	MOVF	X,W		; Copy X into W
	ANDWF	Y,W		; X AND Y
	MOVWF	XANDY		; Copy W into XANDY
	MOVF	STATUS,W	; Copy STATUS into W
	MOVWF	0x25		; Copy W into 0x25
	
	MOVFW	X		; Copy X into W
	XORWF	Y,W		; X XOR Y
	MOVWF	XXORY		; Copy W into XXORY
	MOVF	STATUS,W	; Copy STATUS into W
	MOVWF	0x27		; Copy W into 0x27
	
	MOVFW	X		; Copy X into W
	IORWF	Y,W		; X OR Y
	MOVWF	XORY		; Copy W into XORY
	MOVF	STATUS,W	; Copy STATUS into W
	MOVWF	0x29		; Copy W into 0x29
	
	MOVLW   0x07       	; Loop 7 times
	MOVWF   COUNT
	MOVLW   0x40        	; Starting address
	MOVWF   FSR
	MOVLW   0x33        	; Starting data value
LOOP
	MOVWF   INDF        	; Store in [FSR]
	INCF    FSR, 1      	; Move to next address
	INCF	FSR, 1
	INCF	FSR, 1
	ADDLW   0x01        	; Add 3 to data
	DECF    COUNT, 1    	; Decrement counter
	BTFSS   STATUS, Z   	; Skip if counter = 0
	GOTO    LOOP
	GOTO    $
END