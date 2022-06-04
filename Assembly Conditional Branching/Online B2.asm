.MODEL SMALL


.STACK 100H


.DATA
CR EQU 0DH
LF EQU 0AH    


PROMPT DB "INPUT A POINT SEPARATED BY SPACE: $" 
RESULT DB "THE POINT IS: $" 
OUT1 DB "IN 1st QUADRANT$"
OUT2 DB "IN 2nd QUADRANT$"
OUT3 DB "IN 3rd QUADRANT$"
OUT4 DB "IN 4th QUADRANT$"
OUTX DB "ON X AXIS$"
OUTY DB "ON Y AXIS$"
OUT0 DB "ORIGIN POINT$"

FIRST DB ?
SECOND DB ?
THIRD DB ?
FOURTH DB ?

.CODE

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
    
    ; AL INPUT 
    
    ;===============    INPUT TAKING     ================
        
    ; PROMPT POINT
    LEA DX, PROMPT
    MOV AH, 9
    INT 21H

    ; INPUT 
    MOV AH, 1
    INT 21H
    MOV FIRST, AL

    MOV AH, 1
    INT 21H
    MOV SECOND, AL  
    
    ; NEW LINE 
    MOV DL, CR
    MOV AH, 2
    INT 21H
    MOV DL, LF
    MOV AH, 2
    INT 21H 
    
    
    MOV AH, 1
    INT 21H
    MOV THIRD, AL
   
    MOV AH, 1
    INT 21H
    MOV FOURTH, AL
       
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
    
    MOV AL, FIRST
    CMP AL, '0'
    JE first_quad_check
    
    ; 1ST VALUE POSITIVE
    
    
    MOV AL, THIRD
    CMP AL, '-' 
    JE SEC_THIRD 
    
     
    
    MOV AL, FOURTH
    CMP AL, '0'
    JE X_AXIS_CHECK
    
       
    LEA DX, OUT2
    JMP END_CODE
    
    X_AXIS_CHECK:
        LEA DX, OUTX
        JMP END_CODE
 
    
    ; 2ND OR THIRD 
    
    SEC_THIRD:
        LEA DX, OUT3
        JMP END_CODE
    
    Y_AXIS_CHECK:
        MOV AL, second
        CMP AL, '0'
        JE ORIGIN_CHECK
    
    ; STILL IN 1ST VALUE POS 
    
    LEA DX, OUT1
    JMP END_CODE   
    
        
    
    FIRST_QUAD_CHECK:
        MOV AL, THIRD
        CMP AL, '0'
        JE y_axis_check
        
    ; NOT ORIGIN, y axis SURE  
    
    MOV AL, THIRD
    CMP AL, '-'
    JE Y_AXIS
    JMP END_CODE
    
    
    LEA DX, OUT4
    JMP END_CODE
    
    
    ORIGIN_CHECK:
        MOV AL, FOURTH
        CMP AL, '0'
        JE FINAL_CHECK
    
    Y_AXIS:    
    LEA DX, OUTY
    JMP END_CODE   
    
    FINAL_CHECK:
       MOV AL, SECOND
       CMP AL, '0'
       LEA DX, OUT0
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
