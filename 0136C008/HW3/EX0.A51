        ORG     00H
        JMP     START
        ORG     30H
START:
        MOV     R0,#10          ; R0 : 迴圈計數
        MOV     DPTR,#TABLE ; DPTR 指向 LED 顯示資料表
d1:
        CALL    READ_LEDCODE    ; 讀LED 碼
        MOV     P0,A            ; 將LED 碼 送到PORT-0
        INC     DPTR            ; 指向下一筆 LED 顯示資料
        MOV     R5,#25 ;延遲0.5秒
        CALL    DELAY
        MOV     P0,#00000000B ;全熄
        MOV     R5,#15 ;延遲0.3秒
        CALL    DELAY
        MOV     P0,#00000000B
        MOV     R5,#100 ;延遲2秒
        CALL DELAY
        DJNZ    R0,d1
        JMP     START;



;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
; 副程式名稱 ︰ READ_LEDCODE
; 功  能    ︰ 讀LED 碼儲存在累積器 ACC 中
;使用暫存器  ︰ A,DPTR
;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@



READ_LEDCODE:
        MOV     A,#0            ;
        MOVC    A,@A+DPTR       ; 將查表所得之資料送至 P0
        RET;



; delay time=R5*(20ms)
DELAY:
        MOV     R6,#40
DEL:    MOV     R7,#249
a1:     DJNZ    R7,a1
        DJNZ    R6,DEL
        DJNZ    R5,DELAY
RET



;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
; LED_TABLE  的資料 1 表示LED 會亮
;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


TABLE:
        DB 11111100B ;共陰極之0
        DB 01100000B ;共陰極之1
        DB 11110010B ;共陰極之3
        DB 00111110B ;共陰極之6
        DB 10011100B ;共陰極之C
        DB 11111100B ;共陰極之0
        DB 11111100B ;共陰極之0
        DB 11111110B ;共陰極之8    

END