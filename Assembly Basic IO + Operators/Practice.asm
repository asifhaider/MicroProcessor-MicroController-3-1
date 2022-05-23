.MODEL SMALL


.STACK 100H


.DATA
CR EQU 0DH
LF EQU 0AH    

PROMPTX DB "ENTER X: $"
PROMPTY DB "ENTER Y: $"
PROMPTZ DB "ENTER Z: $" 
RESULT DB "RESULT: $"

X DB ?
Y DB ?
Z DB ?       


.CODE

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
    
    ; AL INPUT 
    
    ;===============    X, Y INPUT TAKING     ================
    
    ; PROMPT X
    LEA DX, PROMPTX
    MOV AH, 9
    INT 21H
    
    ; INPUT X
    MOV AH, 1
    INT 21H
    MOV X, AL
    
    ; NEW LINE 
    MOV DL, CR
    MOV AH, 2
    INT 21H
    MOV DL, LF
    MOV AH, 2
    INT 21H
    
    ; PROMPT Y
    LEA DX, PROMPTY
    MOV AH, 9
    INT 21H
    
    ; INPUT Y
    MOV AH, 1
    INT 21H
    MOV Y, AL
    
    ; NEW LINE 
    MOV DL, CR
    MOV AH, 2
    INT 21H
    MOV DL, LF
    MOV AH, 2
    INT 21H  
    
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
    
    ;===============    OPERATION     ================
    
    ; X - 2Y
    
    SUB X, '0'
    SUB Y, '0'
    
    MOV AL, X
    MOV BL, Y
    ADD BL, Y
    SUB AL, BL
    
        
    ; 25 - (X+Y)
    
    MOV BL, X
    ADD BL, Y
    MOV AL, 25
    SUB AL, BL
    
    
    ; 2X - 3Y
    
    MOV BL, Y
    ADD BL, Y
    ADD BL, Y
    MOV AL, X
    ADD AL, X
    SUB AL, BL
    
    ; Y-X+1
    
    MOV AL, Y
    ADD AL, 1
    MOV BL, X
    SUB AL, BL
    
     
    ADD AL, '0'  
    
    
    ; LOWERCASE BEFORE 
    
    SUB Z, 'A'
    
    MOV AL, Z
    ADD AL, 31
    
    ADD AL, 'A'
    
    
    ; 1'S COMPLEMENT
    
    MOV AL, Z
    NEG AL
    DEC AL
    
    
    

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
