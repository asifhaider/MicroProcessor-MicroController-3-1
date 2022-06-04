.MODEL SMALL


.STACK 100H


.DATA
CR EQU 0DH
LF EQU 0AH    


PROMPTZ DB "INPUT A LETTER: $" 
RESULT DB "THE LETTER IS A: $" 
OUT1 DB "VOWEL$"
OUT2 DB "CONSONANT$"


.CODE

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
    
    ; AL INPUT 
    
    ;===============    INPUT TAKING     ================
        
    ; PROMPT Z
    LEA DX, PROMPTZ
    MOV AH, 9
    INT 21H

    ; INPUT Z
    MOV AH, 1
    INT 21H
    
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
    
    
    ; IF VOWEL
    
    CMP AL, 'A'
    JZ VOWEL
    
    CMP AL, 'E'
    JZ VOWEL
    
    CMP AL, 'I'
    JZ VOWEL
    
    CMP AL, 'O'
    JZ VOWEL
    
    CMP AL, 'U'
    JZ VOWEL      
    
    LEA DX, OUT2
    JMP END_CODE
    
    VOWEL:
    LEA DX, OUT1
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
