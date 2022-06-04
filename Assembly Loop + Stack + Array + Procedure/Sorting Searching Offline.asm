; ASSEMBLY OFFLINE 1: SORTING AND SEARCHING
; AUTHOR: MD. ASIF HAIDER
; DATE: 04 JUNE 2022


.MODEL SMALL

.STACK 100H

.DATA

; INPUT OUPUT PROMPTS

PROMPT_SIZE DW "Enter the Array Size: $"
PROMPT_ARRAY DW "Enter the Array Elements Separated by Space: $"
PROMPT_OUTPUT DW "The Sorted Array is: $"
PROMPT_SEARCH DW "Press an Integer to Search from the Array: $"
PROMPT_FAIL DW "The Number You Pressed was not found in the Array$"
PROMPT_FOUND DW "The Number You Pressed was found at Index No. $"
PROMPT_ERROR DW "Invalid Input. Program Ended$"

; NEWLINE MACRO

CR EQU 0DH
LF EQU 0AH

; VARIABLES UNDECLARED

NUMBER_IN DW ?
SIGN DB ?
TEMP DW ?
LEN DW ?
POS1 DW ?
POS2 DW ?
POS3 DW ? 
START DW ?
END DW ?

; VARIABLES DECLARED

NUMBER_OUT DW '00000$' 

; ARRAY MUST BE DEFINED AT LAST, OTHERWISE INDEXING PROBLEM ARISES
ARR DW ?


.CODE

; MAIN PROCEDURE ==========================================

MAIN PROC
    ; DATA SEGMENT STORED
    MOV AX, @DATA
    MOV DS, AX
    
    ; ARRAY SIZE INPUT PROMP ==============================
    LEA DX, PROMPT_SIZE
    MOV AH, 9
    INT 21H
    
    CALL INTEGER_INPUT
    
    MOV AX, NUMBER_IN
        
    ; CHECKING IF LENGTH IS POSITIVE
    CMP AX, 0
    JNG END_PROGRAM
    
    MOV CX, AX ; ARRAY SIZE SAVED IN CX        
    
    ; ARRAY ELEMENTS INPUT PROMPT =========================
    
    CALL NEWLINE
    
    LEA DX, PROMPT_ARRAY
    MOV AH, 9
    INT 21H
    
    LEA SI, ARR
    
    ; INPUT TAKING ON LOOP ================================
    
    ELEMENT_INPUT_LOOP:
    
    CALL INTEGER_INPUT
    MOV AX, NUMBER_IN
    MOV [SI], AX
    ADD SI, 2
    INC LEN
    
    LOOP ELEMENT_INPUT_LOOP
    
    CALL NEWLINE
    
    
    ; ARRAY ELEMENTS OUTPUT ON LOOP AFTER SORTING =========
    
    LEA DX, PROMPT_OUTPUT
    MOV AH, 9
    INT 21H
    
    MOV CX, LEN
    
    ; SORTING PROCEDURE
    CALL INSERTION_SORT 
    
    LEA SI, ARR 
    
    ELEMENT_OUTPUT_LOOP:
    
    MOV AX, [SI]
    ADD SI, 2
        
    CALL INTEGER_OUTPUT
    MOV DL, ' ' ; SPACE SEPARATED OUTPUT
    MOV AH, 2
    INT 21H
    
    LOOP ELEMENT_OUTPUT_LOOP 
    
    ; SEARCHING ON LOOP ONE AFTER ANOTHER
    
    SEARCH_ON_LOOP:
    
    ; RESTORING THE START AND END INDICES
    LEA SI, ARR
    MOV AX, SI
    MOV START, AX
    MOV AX, LEN 
    MOV BX, 2
    MUL BX
    SUB AX, 2
    ADD AX, START
    MOV END, AX

    
    CALL NEWLINE
    
    LEA DX, PROMPT_SEARCH
    MOV AH, 9
    INT 21H
    
    ; BINARY SEARCH FROM ARRAY ============================
    
       
    CALL INTEGER_INPUT
    MOV AX, NUMBER_IN 
    MOV TEMP, AX
    
    ; SEARCHING PROCEDURE
    CALL BINARY_SEARCH
    
    CALL NEWLINE
    LEA DX, PROMPT_FOUND
    MOV AH, 9
    INT 21H
    
    MOV AX, TEMP
    INC AX
    CALL INTEGER_OUTPUT
    
    JMP SEARCH_ON_LOOP
    
    ; ENDPOINT OF MAIN PROCEDURE AND PROGRAM
    END_PROGRAM:
    CALL NEWLINE
    LEA DX, PROMPT_ERROR
    MOV AH, 9
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

; INSERTION SORT PROCEDURE ================================

; PERFORMS INSERTION SORT ON THE INPUT ARRAY
; INPUT: AX, BX
; OUTPUT: REARRANGES THE ARRAY IN ASCENDING ORDER
INSERTION_SORT PROC
    
    PUSH AX 
    PUSH BX
    
    ; LOCATING START AND END
    LEA SI, ARR
    MOV POS1, SI
    MOV START, SI
    MOV AX, LEN
    MOV END, AX
    DEC END
    MOV AX, 2
    MUL END
    MOV END, AX
    MOV AX, POS1
    ADD END, AX
    
    ; OUTER LOOP     
    ALL_PASS:
    
    ADD POS1, 2
    MOV AX, END
    CMP POS1, AX
    JG  END_ALL_PASS
    
    MOV AX, POS1
    MOV POS2, AX
    
    ; INNER LOOP
    ONE_PASS:
    
    MOV AX, POS2
    MOV POS3, AX
    SUB POS3, 2
    
    MOV AX, START
    CMP POS3, AX
    
    JL END_ONE_PASS
    
    MOV SI, POS2
    MOV AX, [SI]
    MOV SI, POS3
    MOV BX, [SI]
    CMP AX, BX
    JNL END_ONE_PASS
    
    MOV SI, POS2
    MOV [SI], BX
    MOV SI, POS3
    MOV [SI], AX
    
    SUB POS2, 2
    
    JMP ONE_PASS
    
    END_ONE_PASS:
    
    JMP ALL_PASS
    
    END_ALL_PASS:
    
    POP BX
    POP AX
    RET   
INSERTION_SORT ENDP

; BINARY SEARCH PROCEDURE =================================

; PERFORMS BINARY SEARCH ON A SORTED ARRAY
; INPUT:  
 
BINARY_SEARCH PROC
    
    PUSH AX
    PUSH BX
    PUSH DX
    
    LEA SI, ARR
    
    BINARY_SEARCH_LOOP: 
    
    ; COMPARING LOW AND HIGH
    MOV AX, START
    MOV BX, END
    CMP AX, BX
    JG END_SEARCH
    
    ; CREATING MID POINT
    ADD AX, BX
    ; SUB AX, 2
    MOV BX, 2
    DIV BX 
    
    ; ROUNDING TO A WORD INDEX
    TEST AX, 1
    JNZ INDEX_ROUNDED
    DEC AX
    
    INDEX_ROUNDED:
    MOV SI, AX
    MOV AX, TEMP
    MOV BX, [SI]
    CMP BX, AX
    JE FOUND
    JL UPPER_HALF
    JMP LOWER_HALF
    
    FOUND:
    MOV TEMP, SI
    LEA SI, ARR
    SUB TEMP, SI
    MOV AX, TEMP
    MOV BX, 2
    DIV BX
    MOV TEMP, AX
    
    POP DX
    POP BX
    POP AX
    RET
    
    UPPER_HALF:
    MOV AX, SI
    ADD AX, 2
    MOV START, AX
    JMP BINARY_SEARCH_LOOP
    
    LOWER_HALF:
    MOV AX, SI
    SUB AX, 2
    MOV END, AX
    JMP BINARY_SEARCH_LOOP
    
    END_SEARCH:
    CALL NEWLINE
    LEA DX, PROMPT_FAIL
    MOV AH, 9
    INT 21H
    
    POP DX
    POP BX
    POP AX
    JMP SEARCH_ON_LOOP
    
BINARY_SEARCH ENDP    
END MAIN 
