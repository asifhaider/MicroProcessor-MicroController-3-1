.MODEL SMALL


.STACK 100H


.DATA
CR EQU 0DH
LF EQU 0AH    


PROMPTZ DB "INPUT 3 SINGLE DIGITS: $" 
RESULT DB "THE TRIANGLE IS: $" 
OUT1 DB "EQUILITERAL$"
OUT2 DB "ISOSCALAR$"
OUT3 DB "SCALAR$"

A DB ?
B DB ?
C DB ?      


.CODE

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
    
    ; AL INPUT 
    
    ;===============    z INPUT TAKING     ================
        
    ; PROMPT Z
    LEA DX, PROMPTZ
    MOV AH, 9
    INT 21H
    
    ; NEW LINE 
    MOV DL, CR
    MOV AH, 2
    INT 21H
    MOV DL, LF
    MOV AH, 2
    INT 21H   

    ; INPUT A
    MOV AH, 1
    INT 21H
    MOV A, AL
    
    ; NEW LINE 
    MOV DL, CR
    MOV AH, 2
    INT 21H
    MOV DL, LF
    MOV AH, 2
    INT 21H   
    
    ; INPUT B
    MOV AH, 1
    INT 21H
    MOV B, AL
    
    ; NEW LINE 
    MOV DL, CR
    MOV AH, 2
    INT 21H
    MOV DL, LF
    MOV AH, 2
    INT 21H   
    
    ; INPUT C
    MOV AH, 1
    INT 21H
    MOV C, AL

    
    ; NEW LINE 
    MOV DL, CR
    MOV AH, 2
    INT 21H
    MOV DL, LF
    MOV AH, 2
    INT 21H  
    
    LEA DX, RESULT
    MOV AH, 9
    INT 21H 
    
    ;===============    OPERATION     ================
    
    
    ; IF (A==B) THEN 
    
    MOV AL, A
    MOV BL, B
    CMP AL, BL
    JNE CHECK
    
    MOV CL, C
    CMP BL, CL
    JE EQUILITERAL
    
    LEA DX, OUT2
    JMP END_CODE
        
    CHECK:
    MOV CL, C
    CMP AL, CL
    JNE CHECK_AGAIN
    
    LEA DX, OUT2
    JMP END_CODE 
        
    CHECK_AGAIN:
    CMP BL, CL
    JNE SCALAR 
    
    LEA DX, OUT2
    JMP END_CODE
    
    EQUILITERAL:
    LEA DX, OUT1
    JMP END_CODE  
    
    SCALAR:
    LEA DX, OUT3
    JMP END_CODE
    
    
    ;===============    OUTPUT     ================    
    
    ; DL OUTPUT 
    
    
    
    END_CODE:
    MOV AH, 9
    INT 21H 
    
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H



MAIN ENDP
END MAIN
