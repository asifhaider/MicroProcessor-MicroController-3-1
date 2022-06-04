.MODEL SMALL

.STACK 100H

.DATA

CR EQU 0DH
LF EQU 0AH

.CODE 

MAIN PROC
    MOV AH, 2
    MOV DL, '?'
    INT 21H
    
    MOV AH, 2
    MOV DL, CR
    INT 21H
    MOV AH, 2
    MOV DL, LF
    INT 21H  
    
    ; INITIALIZE CHARACTER COUNT 
    XOR CX, CX
    
    MOV AH, 1
    INT 21H
    
    WHILE:
    
        CMP AL, CR
        JE END_WHILE
        PUSH AX
        INC CX
    
        INT 21H
        JMP WHILE
    
    END_WHILE:
    
    MOV AH, 2
    MOV DL, CR
    INT 21H
    MOV AH, 2
    MOV DL, LF
    INT 21H
    
    JCXZ EXIT
    
    TOP: 
    
        POP DX
        INT 21H
        LOOP TOP
    
    EXIT:
    
        MOV AH, 4CH
        INT 21H
MAIN ENDP