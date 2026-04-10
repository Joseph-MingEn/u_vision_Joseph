        ORG     0H
INITIAL:
        MOV     DPTR,#TABLE
LOOP:
        MOV     A,#0 ;偏移量即顯示數字
        MOVC    A,@A+DPTR
        MOV     P0,A
        MOV     R5,#25 ;延遲0.5秒
        CALL    DELAY
        MOV     P0,#00000000B ;全熄
        MOV     R5,#15 ;延遲0.3秒
        CALL    DELAY
        MOV     P0,#00000000B
        MOV     R5,#100 ;延遲2秒
        CALL DELAY
        JMP LOOP

; delay time=R5*(20ms)
DELAY:
        MOV     R6,#40
DEL:    MOV     R7,#249
$1:     DJNZ    R7,$1
        DJNZ    R6,DEL
        DJNZ    R5,DELAY
RET

;修正成學號
Segment_Table:
        DB 11111100B ;共陰極之0
        DB 01100000B ;共陰極之1
        DB 11011010B ;共陰極之2
        DB 11110010B ;共陰極之3
        DB 01100110B ;共陰極之4
        DB 10110110B ;共陰極之5
        DB 00111110B ;共陰極之6
        DB 11100000B ;共陰極之7
        DB 11111110B ;共陰極之8
        DB 11100110B ;共陰極之9
        
        DB 11111100B ;共陰極之0
        DB 01100000B ;共陰極之1
        DB 11011010B ;共陰極之2
        DB 11110010B ;共陰極之3
        DB 01100110B ;共陰極之4
        DB 10110110B ;共陰極之5
        DB 00111110B ;共陰極之6
        DB 11100000B ;共陰極之7
        DB 11111110B ;共陰極之8
        DB 11100110B ;共陰極之9

LED_TABLE:
        DB 11111100B ;共陰極之0
        DB 01100000B ;共陰極之1
        DB 11011010B ;共陰極之2
        DB 11110010B ;共陰極之3
        DB 01100110B ;共陰極之4
        DB 10110110B ;共陰極之5
        DB 00111110B ;共陰極之6
        DB 11100000B ;共陰極之7
        DB 11111110B ;共陰極之8
        DB 11100110B ;共陰極之9