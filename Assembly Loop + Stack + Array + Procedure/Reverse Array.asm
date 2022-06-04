.MODEL SMALL

.STACK 100H

.DATA

CR EQU 0DH
LF EQU 0AH     

W DW 10, 20, 30, 40, 50

.CODE

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
    
    
REVERSE PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH SI
    PUSH DI
    
    MOV DI, SI   ; 1ST ELEMENT 
    MOV CX, BX   ; TOTAL ELEMENTS
    DEC BX
    SHL BX, 1
    ADD DI, BX  ; LAST ELEMENT
    SHR CX, 1   ; SWAP NO HALVED
    
    XCNG_LOOP:
        MOV AX, [SI]
        XCHG AX, [DI]
        MOV [SI], AX
    
        ADD SI, 2
        SUB DI, 2
        LOOP XCNG_LOOP
   
    POP DI
    POP SI
    POP CX
    POP BX
    POP AX
    RET
REVERSE ENDP

    
    
        
               
    
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
