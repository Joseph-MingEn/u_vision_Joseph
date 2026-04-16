        ORG     0H
INITIAL:
        MOV     DPTR,#TABLE
        MOV     R0,#0
LOOP:
        MOV     A,R0
        MOVC    A,@A+DPTR
        MOV     P0,A
        CALL DELAY
        INC     R0
        CJNE    R0,#10,LOOP
        MOV     R0,#0
        MOV     P0,#00000000B
        CALL DELAY
        JMP     LOOP

;延遲時間 T=1+R7*[1+R6*(1+R5*2+2)+2]+2
DELAY:
        MOV     R7,#05
$3:
        MOV     R6,#200 ; 需要１個機械週期
$2:
        MOV     R5,#248
        NOP ; 需要１個機械週期
$1:
        DJNZ    R5,$1 ; 需要２個機械週期
        DJNZ    R6,$2
        DJNZ    R7,$3
        RET

TABLE:
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