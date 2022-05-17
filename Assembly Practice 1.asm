.MODEL SMALL    
; SMALL SIZED CODE

.STACK 100H


.DATA   ; DATA VARIABLE DECLARE SECTION

CR EQU 0DH ; RENAMING READABILITY INCREASES, D -> CARRIAGE RETURN
LF EQU 0AH ; A -> LINE FEED
; LIKE MACRO IN C
; CR+LF = NEW LINE
; CARRIAGE RETURN = BACK TO THE START OF THE CURRENT LINE
; LINE FEED = STEPS DOWN FROM CURRENT POSITION



HW DB 'Hello, World!$' ; $ MEANS STRING END, DEFINE BYTE = DB, HW -> VARIABLE NAME     

N0 DB 'Small Character: $'
N1 DB 'Digit 1: $'
N2 DB 'Digit 2: $'  
N3 DB 'RESULT: $'

; ONLY TYPE DECLARATION
X DB ?
Y DB ?

.CODE

MAIN PROC
    ; DATA SEGMENT INITIALIZATION  
    
    ; AX, BX, CX, DX -> GENERAL PURPOSE REGISTER 

    MOV AX, @DATA
    MOV DS, AX  ; MOVING DATA TO DS = DATA SEGMENT  
    
    ; ========================================= HELLO WORLD PRINT =========================================
    
    LEA DX, HW     ; LEA = LOAD EFFECTIVE ADDRESS, LEA FOR STRING ONLY AND HW IS A PREDEFINED STRING, LOAD TO DX
    ; DX -> FIXED LOOKUP REGISTOR FOR STRING
    
    MOV AH, 9      ; MOV AH, 9 MEANS IT HAS TO PRINT STRING
    INT 21H        ; INT = INTERRUPT, HALTS AND DOES ANYTHING AS DIRECTED BY PREV LINE            
    
    ; ========================================= NEW LINE PRINT =========================================
    
    MOV DL, CR
    MOV AH, 2   ; MOV AH, 2 MEANS GIVE OUTPUT
    INT 21H
    
    MOV DL, LF
    MOV AH, 2
    INT 21H    
                 
    ; ========================================= CHARACTER CAPITALIZATION =========================================
    
    LEA DX, N0
    MOV AH, 9
    INT 21H
    
    ; DL FOR CHARACTER
    
    MOV AH, 1
    INT 21H
    MOV X, AL
    
    SUB X, 32  ; GOES BACK TO ITS CAPITAL 
    
    ; NEW LINE PRINT
    MOV DL, CR
    MOV AH, 2
    INT 21H
    
    MOV DL, LF
    MOV AH, 2
    INT 21H 
    
    ; PRINT THE UPDATED VALUE OF X
    MOV DL, X
    MOV AH, 2
    INT 21H
    
    MOV DL, CR
    MOV AH, 2
    INT 21H
    
    MOV DL, LF
    MOV AH, 2
    INT 21H     
             
    ; ========================================= SINGLE DIGIT ADDITION =========================================
    
    ; PROMPT NO 1
    LEA DX, N1
    MOV AH, 9
    INT 21H
    
    ; INPUT 1
    MOV AH, 1
    INT 21H   ; TAKES INPUT = 1
    MOV X, AL ; READS INTO AL, MOVED TO X     
    
    ; NEW LINE PRINT
    MOV DL, CR
    MOV AH, 2
    INT 21H
    
    MOV DL, LF
    MOV AH, 2
    INT 21H        
    
    ; PROMPT 2
    LEA DX, N2
    MOV AH, 9
    INT 21H  
    
    ; INPUT 2
    MOV AH, 1
    INT 21H
    MOV Y, AL 
    
    ; NEW LINE PRINT
    MOV DL, CR
    MOV AH, 2
    INT 21H
    
    MOV DL, LF
    MOV AH, 2
    INT 21H
    
    ; CONVERTS ASCII TO DIGIT 
    SUB X, 48
    SUB Y, 48
    
    MOV AH, X
    MOV BH, Y
    ADD AH, BH  
    
    MOV X, AH
    
    ADD X, 48 ; WORKS FOR 1 BYTE ONLY 
    
    ; PROMPT 3
    LEA DX, N3
    MOV AH, 9
    INT 21H 
    
    ; PRINT THE UPDATED VALUE OF X
    MOV DL, X
    MOV AH, 2  
    INT 21H 
    
    ; NEW LINE PRINT
    MOV DL, CR
    MOV AH, 2
    INT 21H
 
    ; ========================================= DOUBLE DIGIT ADDITION HANDLING BY DIVISION =========================================
        
    ; DIVISION PROCESS OF 15/10
    ; MOV AX, 0
    ; MOV AL, 15D ; D -> DECIMAL
    ; MOV BL, 10D
    ; DIV BL
    ; AL CONTAINS RESULT OR QUOTIENT
    ; AH CONTAINS REMAINDER
    ; 15/10 => AL = 1, AH = 5                
    
    MOV X, AH
    
    ; WORKS FOR 2 DIGIT OR BYTE SUM
    ; AX CONTAINS TWO BYTES
    ; AL + AH = AX 
    
    MOV AX, 0
    MOV AL, X
    MOV BL, 10D
    DIV BL
    
    MOV X, AL 
    MOV Y, AH  
    
    ADD X, 48
    ADD Y, 48  
    
    ; PROMPT 3
    LEA DX, N3
    MOV AH, 9
    INT 21H
    
    MOV DL, X
    MOV AH, 2  
    INT 21H 
     
    MOV DL, Y
    MOV AH, 2
    INT 21H
    
    
    
    ;DOS EXIT, ACTS AS RETURN 0
    MOV AH, 4CH
    INT 21H ; INTERRUPT 
    
MAIN ENDP
END MAIN                  


