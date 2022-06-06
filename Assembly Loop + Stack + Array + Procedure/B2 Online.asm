; B2 ONLINE LOOP 
; AUTHOR: 1805112

.MODEL SMALL

.STACK 100H

.DATA

; INPUT OUPUT PROMPTS

PROMPT_NUM DW "Enter the Number: $"
PROMPT_OUTPUT DW "# OF CO-PRIMES: $"
; NEWLINE MACRO

CR EQU 0DH
LF EQU 0AH

; VARIABLES UNDECLARED
NUMBER_IN DW ?
TEMP DW ?
SIGN DB ?
VAR DW ?
RESULT DW ?
NUMBER_OUT DW '00000$' 


.CODE

; MAIN PROCEDURE ==========================================

MAIN PROC
    ; DATA SEGMENT STORED
    MOV AX, @DATA
    MOV DS, AX
    
    
    ; ARRAY SIZE INPUT PROMP ==============================
    LEA DX, PROMPT_NUM
    MOV AH, 9
    INT 21H 
    
    CALL INTEGER_INPUT
    
    MOV AX, NUMBER_IN
        
    ; CHECKING IF LENGTH IS POSITIVE
    CMP AX, 2
    JNG END_PROGRAM
    
    MOV CX, AX        
    
    MOV VAR, 2
    XOR AX, AX
    XOR BX, BX 
    MOV RESULT, 0
    
    ; ==================== GCD LOOP ================
    
    OUTER_LOOP:
    
    MOV BX, VAR
    INC BX
    MOV VAR, BX
    MOV AX, CX
    CMP AX, BX
    JE END_PROGRAM
    
    MOV AX, CX
    MOV BX, VAR
    
    
    INNER_LOOP:
    
    CMP AX, BX
    JE GCD_FOUND
    
    CMP AX, BX
    JG MODIFY
    
    SUB BX, AX
    JMP INNER_LOOP
    
    MODIFY:
    SUB AX, BX
    JMP INNER_LOOP
    
    GCD_FOUND:
    CMP AX, 1
    JE COPRIME_FOUND
    
    MOV BX, VAR
    INC BX
    MOV VAR, BX
    XOR BX, BX 
    JMP OUTER_LOOP
    
    
    COPRIME_FOUND:
    MOV BX, RESULT
    INC BX
    MOV RESULT, BX
    XOR BX, BX
    JMP OUTER_LOOP  
    
    
    
    END_PROGRAM:
    CALL NEWLINE 
    LEA DX, PROMPT_OUTPUT
    MOV AH, 9
    INT 21H
    MOV AX, RESULT
    CALL INTEGER_OUTPUT
    INT 21H 
    MOV AH, 4CH
    INT 21H
    
MAIN ENDP
    



; NEWLINE PROCEDURE =======================================

; PRINTS NEWLINE
; NO INPUT OUTPUT 
NEWLINE PROC
    MOV AH, 2
    MOV DL, CR
    INT 21H
    MOV DL, LF
    INT 21H
    RET
NEWLINE ENDP

; INTEGER INPUT PROCEDURE =================================

; TAKES AN INTEGER INPUT
; INPUT: AX, BX
; OUTPUT: NUMBER_IN
INTEGER_INPUT PROC
    
    PUSH AX
    PUSH BX
    
    ; BX RESET
    XOR BX, BX 
    
    MOV AH, 1
    INT 21H
    
    ; CHECKING FOR NEW LINE AND SPACE VALUE TO HALT
    CMP AL, CR
    JE END_NUMBER_INPUT_LOOP
    CMP AL, LF
    JE END_NUMBER_INPUT_LOOP
    CMP AL, 20H
    JE END_NUMBER_INPUT_LOOP
    
    CMP AL, '-'
    JE NEGATIVE_FLAG
    
    JMP CHAR_TO_DIGIT
    
    
    ; NUMBER INPUT LOOP
    
    
    NUMBER_INPUT_LOOP:    
    MOV AH, 1
    INT 21H
    
    CMP AL, CR
    JE END_NUMBER_INPUT_LOOP
    CMP AL, LF
    JE END_NUMBER_INPUT_LOOP
    CMP AL, 20H
    JE END_NUMBER_INPUT_LOOP
    
        
    CHAR_TO_DIGIT:
    ; CHAR TO DIGIT CONVERSION
    AND AX, 000FH
    
    MOV TEMP, AX
    
    MOV AX, 10
    MUL BX
    ADD AX, TEMP
    MOV BX, AX
    JMP NUMBER_INPUT_LOOP
    
    
    END_NUMBER_INPUT_LOOP:
    CMP SIGN, '-'
    JE NEGATIVE_RETURN
    MOV NUMBER_IN, BX
    JMP EXIT_INPUT_PROC

    ; STORING NEGATIVE SIGN INFO
    NEGATIVE_FLAG:
    MOV SIGN, AL
    JMP NUMBER_INPUT_LOOP 
    
    ; ACTUALLY RETURNING THE NEGATION
    NEGATIVE_RETURN:
    NEG BX
    MOV NUMBER_IN, BX
    MOV SIGN, 0
    
    EXIT_INPUT_PROC:
    
    POP BX
    POP AX
    RET
    
INTEGER_INPUT ENDP 

; INTEGER OUTPUT PROCEDURE ================================

; RETURNS AN INTEGER OUTPUT
; INPUT: AX, BX, DX
; OUTPUT: SHOWS THE INTEGER FROM DX

INTEGER_OUTPUT PROC
    
    PUSH AX
    PUSH BX
    PUSH DX
    
    CMP AX, 0
    JL SHOW_NEGATIVE 
    
    CONVERT_TO_CHAR:
    
    LEA DI, NUMBER_OUT
    ADD DI, 5
    
    PRINT_LOOP:
    DEC DI
    MOV DX, 0
    
    MOV BX, 10
    DIV BX
    
    ADD DL, '0'
    MOV [DI], DL 
    
    CMP AX, 0
    JNE PRINT_LOOP
     
    MOV DX, DI
    MOV AH, 9
    INT 21H    
    
    POP DX
    POP BX
    POP AX
    
    RET
    
    SHOW_NEGATIVE:
    MOV DL, '-'
    MOV TEMP, AX
    MOV AH, 2
    INT 21H
    NEG TEMP
    MOV AX, TEMP
    JMP CONVERT_TO_CHAR
    
INTEGER_OUTPUT ENDP

    