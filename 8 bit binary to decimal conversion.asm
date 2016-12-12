;Project: 8 bit Binary to Decimal Conversion
;Description: Assembly program to convert 8 bit binary digits to decimal digits
;Author: Sazzad Hossen
;Github: http://www.github.com/SazzadSH


;Segments:

.MODEL SMALL            ;Program of small model

.STACK 100H             ;Stack declaration of 100H 
                        
.DATA                   ;Data segment begins

;Variables:

DVAR DB 10              ;DVAR: Division variable of byte and value 10

MSG1  DW "Binary: $"    ;MSG1: Variable of word memory that store string "Binary: "
MSG2 DW "Decimal: $"    ;MSG2: Variable of word memory that store string "Decimal: "

MSG3 DW ?               ;MSG3: Variable of word memory to store data
MSG4 DW ?               ;MSG3: Variable of word memory to store data
                        ;Data segment ends

    
    
.CODE                   ;Code segment begins



MAIN PROC               ;Main procedure
    
    
    MOV AX,@DATA        ;Data segment cohesion with AX register
    MOV DS,AX           ;Data movement from AX to DS register

    MOV CH,2            ;Storing value 2 to CH register
    
    
;Loop codes:    
           
LOOP2:                  ;Loop label (Program continues two times)


    DEC CH              ;Decrement of CH by one
    
    AND BL,0H           ;AND operation of BL with 0 hexa decimal value
    
    
    
    ;MSG1 String print: 
    
    MOV AH,9            ;Storing value 9 into AH register
    LEA DX,MSG1         ;Loading effective address of MSG1 variable through DX register
    INT 21H             ;Interruption call 21 hexa decimal value
    
    
    
    CALL INPUT          ;Calling Input procedure
    
    
    
    JMP EXIT            ;Jumping into label name EXIT
    
    
    
    
            
    MAIN ENDP           ;End of main procedure
    
;Main procedure ends
    
    
;Procedure Input taking:

INPUT PROC              ;Beginning and declaration of input procedure


    POP MSG3            ;Withdrawing variable MSG3 from stack

    
    
    MOV CL,8            ;Storing value of 8 into CL register
    
    
    
    
INPUTN:                 ;Number input
    
    
    
    
    DEC CL              ;Decrement of CL register by one
    
    ;Input taking:
    
    MOV AH,1            ;Storing value of one into AH register
    INT 21H             ;Interruption call of 21 hexa decimal value
    
    SUB AL,48           ;Subtraction of 48 from AL register
    
    SHL BL,1            ;One time left shifting of BL register
    
    OR BL,AL            ;OR operation between BL and AL and storing operation value into BL
    
    ;Loop for 8 bit binary intput:
    
    CMP CL,0            ;Comparsion between the value of CL register and zero
    JNE INPUTN          ;Jumping into Number Input label if comparison result is inequal

    
    
    
    CALL OP             ;Calling of OP procedure
    
    PUSH MSG3           ;Storing MSG3 variable into stack
    
    RET                 ;Return of current procedure
    
    
    
    
    
    INPUT ENDP          ;Input procedure ends
     
     
;Output printing procedure:     

OP PROC                 ;Beginning and declaration of OP procedure
    
    
    POP MSG4            ;Withdrawing MSG4 from stack
    
    
    ;New Line Print:
    
    MOV AH,2            ;Storing value of 2 into AH register
    MOV DL,10           ;Storing value of 10 into DL register
    INT 21H             ;Interruption call of 21 hexa decimal value
    MOV DL,13           ;Storing value of 13 into DL register
    INT 21H             ;Interruption call of 21 hexa decimal value
    
    
    ;MSG2 string print:
    
    MOV AH,9            ;Storing value of 9 into AH register
    LEA DX,MSG2         ;Loading effective address MSG2 variable into DX register
    INT 21H             ;Interruption call of 21 hexa decimal value
    
   
    
    MOV BH,0H           ;Storing hexa decimal value of 0 into BH register
     
    MOV AX,BX           ;Storing current value of BX register into AX register
    
    
;Performing division:   
    
DIVOP:                  ;Division operation label
                        

    DIV DVAR            ;Division of DIVAR variable
    
    CMP AH,0            ;Comparison of the value of AH register with zero
    JE PN1              ;Jumping into PN1 label if inequal
    
    MOV DL,AH           ;Storing value of AH register into DL
    
    AND DH,0H           ;AND operation between value of DH register and hexa decimal value of zero and storing operation value into DH register
    
    MOV AH,0H           ;Storing hexa decimal value of zero into AH register
    
    PUSH DX             ;Storing value of DX register into stack
    
    JMP DIVOP           ;Jumping into Division operation label

                        ;Printing sement
PN1:    
    
    
    
PRINTF:                 ;Final print label

    
    MOV AH,2            ;Storing value of 2 into AH register
    
    POP DX              ;Withdrawing value of DX register from stack
    
    ADD DX,48           ;Addition of 48 with the current value of DX and storing result into DX register
    
    INT 21H             ;Interruption call of 21 hexa decimal value
    
    ;Stack comparison:
    
    CMP SP,100H         ;Comparison hexa decimal value of 100 with the value of stack pointer
    JNE PRINTF          ;Jumping into final print label if inequal
    
           
    PUSH MSG4           ;Storing MSG4 variable into stack
    
    RET                 ;Return of current procedure
    
    
    
    OP ENDP             ;OP procdure ends
    
    
;Program Exit:    
    
EXIT:                   ;Program exiting label


    
    ;New line print:
    
    MOV AH,2            ;Storing value of 2 into AH register
    MOV DL,10           ;Storing value of 10 into DL register
    INT 21H             ;Interruption call of 21 hexa decimal value
    MOV DL,13           ;Storing value of 13 into DL register
    INT 21H             ;Interruption call of 21 hexa decimal value
    
         
    ;Loop:
    
    CMP CH,0            ;Comparison of current value of CH register with 0
    JNE LOOP2           ;Jumping into LOOP label if comparsion result is inequal
    
    
    
    MOV AH,4CH          ;Storing hexa decimal value of 4C into AH register
    INT 21H             ;Interruption call of 21 hexa decimal value
    
    
    
    
END MAIN                ;End of program