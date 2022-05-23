.MODEL SMALL


.STACK 100H


.DATA
CR EQU 0DH
LF EQU 0AH    


PROMPTZ DB "INPUT A SINGLE CHARACTER FROM 'A' TO 'Z': $" 
RESULT DB "THE MAPPED OUTPUT CHARACTER IS: $"

Z DB ?      


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
    
    ; INPUT Z
    MOV AH, 1
    INT 21H
    MOV Z, AL
    
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
    
    
    MOV AL, Z
    SUB AL, 'A'
    XOR AL, 1
    MOV Z, AL
    
    MOV AL, 'z'
    MOV BL, Z
    SUB AL, BL

    ;===============    OUTPUT     ================    
    
    ; DL OUTPUT 
    
   
    
    MOV DL, AL
    MOV AH, 2
    INT 21H 
    
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H



MAIN ENDP
END MAIN
