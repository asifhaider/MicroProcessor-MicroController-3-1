.MODEL SMALL


.STACK 100H


.DATA
CR EQU 0DH
LF EQU 0AH    

;PROMPTX DB "ENTER X: $"
;PROMPTY DB "ENTER Y: $"

PROMPTZ DB "ENTER Z: $" 
RESULT DB "RESULT: $"

;X DB ?
;Y DB ?
Z DB ?       


.CODE

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
    
    ; AL INPUT 
    
    ;===============    X, Y INPUT TAKING     ================
        
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
    
    ;Input->Output
    ;H -> 10
    ;G -> 11
    ;F -> 12
    ;E -> 13
    ;D -> 14
    ;C -> 15
    ;B -> 16
    ;A -> 17  
    
    MOV DL, '1'
    MOV AH, 2
    INT 21H
    
    MOV AL, 72
    SUB AL, Z
    ADD AL, 48  
    
    ;Input->Output
    ;a=>Z
    ;b=>X
    ;c=>V
    ;d=>T
    ;...
    ;m=>B
    
    MOV AL, Z
    SUB AL, 'a'
    MOV Z, AL
    
    MOV AL, Z
    MOV BL, 2
    MUL BL
    MOV BL, AL
    MOV AL, 'Z'
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
