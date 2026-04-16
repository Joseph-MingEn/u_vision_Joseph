;***********************************************************; 
;程式名稱 : HW2Led-A5;  
;功  能  : 廣告燈;  
;說  明  : 使用建表的方式製作廣告燈; 
;開關設定 : 無;
;***********************************************************
        ORG     00H
        JMP     FIRST
        ORG     30H
FIRST:
        MOV     R0,#5          ; R0 : 迴圈計數
        MOV     DPTR,#LED_TABLE_FIRST ; DPTR 指向 LED 顯示資料表
d1:
        CALL    READ_LEDCODE    ; 讀LED 碼
        MOV     P0,A            ; 將LED 碼 送到PORT-0
        INC     DPTR            ; 指向下一筆 LED 顯示資料
        CALL    READ_LEDCODE    ; 讀LED 碼 
        MOV     P1,A            ; 將LED 碼 送到PORT-1
        INC     DPTR            ; 指向下一筆 LED 顯示資料
        CALL    READ_LEDCODE    ; 讀LED 碼
        MOV     P2,A            ; 將LED 碼 送到PORT-2
        INC     DPTR            ; 指向下一筆 LED 顯示資料
        CALL    READ_LEDCODE    ; 讀LED 碼
        MOV     P3,A            ; 將LED 碼 送到PORT-3
        INC     DPTR            ; 指向下一筆 LED 顯示資料
        CALL    DELAY_01S      ; 延遲時間 0.1 SECOND
        DJNZ    R0,d1
        JMP     SECOND;

SECOND:
        MOV     R1,#7          ; R1 : 迴圈計數
        MOV     DPTR,#LED_TABLE_SECOND ; DPTR 指向 LED 顯示資料表
d2:
        CALL    READ_LEDCODE    ; 讀LED 碼
        MOV     P0,A            ; 將LED 碼 送到PORT-0
        INC     DPTR            ; 指向下一筆 LED 顯示資料
        CALL    READ_LEDCODE    ; 讀LED 碼
        MOV     P1,A            ; 將LED 碼 送到PORT-1
        INC     DPTR            ; 指向下一筆 LED 顯示資料
        CALL    READ_LEDCODE    ; 讀LED 碼
        MOV     P2,A            ; 將LED 碼 送到PORT-2
        INC     DPTR            ; 指向下一筆 LED 顯示資料
        CALL    READ_LEDCODE    ; 讀LED 碼
        MOV     P3,A            ; 將LED 碼 送到PORT-3
        INC     DPTR            ; 指向下一筆 LED 顯示資料
        CALL    DELAY_025S      ; 延遲時間 0.5 SECOND
        DJNZ    R1,d2
        JMP     THIRD;

THIRD:
        MOV     R2,#4          ; R2 : 迴圈計數
        MOV     DPTR,#LED_TABLE_THIRD ; DPTR 指向 LED 顯示資料表
d3:
        CALL    READ_LEDCODE    ; 讀LED 碼
        MOV     P0,A            ; 將LED 碼 送到PORT-0
        INC     DPTR            ; 指向下一筆 LED 顯示資料
        CALL    READ_LEDCODE    ; 讀LED 碼
        MOV     P1,A            ; 將LED 碼 送到PORT-1
        INC     DPTR            ; 指向下一筆 LED 顯示資料
        CALL    READ_LEDCODE    ; 讀LED 碼
        MOV     P2,A            ; 將LED 碼 送到PORT-2
        INC     DPTR            ; 指向下一筆 LED 顯示資料
        CALL    READ_LEDCODE    ; 讀LED 碼
        MOV     P3,A            ; 將LED 碼 送到PORT-3
        INC     DPTR            ; 指向下一筆 LED 顯示資料
        CALL    DELAY_05S      ; 延遲時間 0.5 SECOND
        DJNZ    R2,d3
        JMP     FIRST;


;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
; 副程式名稱 ︰ READ_LEDCODE
; 功  能    ︰ 讀LED 碼儲存在累積器 ACC 中
;使用暫存器  ︰ A,DPTR
;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@



READ_LEDCODE:
        MOV     A,#0            ;
        MOVC    A,@A+DPTR       ; 將查表所得之資料送至 P0
        RET;



;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
; 副程式名稱 ︰ DELAY_05S
;  功  能    ︰ 延遲時間 0.5 SECOND
;使用暫存器  ︰ R7,R6,R5
;延遲時間    T=1+R7*[1+R6*(1+R5*2+2)+2]+2
;             =1+5*[1+200*(1+1+248*2+2)+2]+2
;             =500018 us = 0.5 SEC
;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

DELAY_05S:
        MOV     R7,#05
a3:        
        MOV     R6,#200  ; 需要１個機械週期
a2:
        MOV     R5,#248
        NOP              ; 需要１個機械週期
a1: 
        DJNZ    R5,a1    ; 需要２個機械週期
        DJNZ    R6,a2
        DJNZ    R7,a3
        RET

;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
; 副程式名稱 ︰ DELAY_25S
;  功  能    ︰ 延遲時間 0.25 SECOND
;使用暫存器  ︰ R7,R6,R5
;延遲時間    T=1+R7*[1+R6*(1+R5*2+2)+2]+2
;             =1+5*[1+100*(1+1+248*2+2)+2]+2
;             =250009 us = 0.25 SEC
;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

DELAY_25S:
        MOV     R7,#05
a6:        
        MOV     R6,#100  ; 需要１個機械週期
a5:
        MOV     R5,#248
        NOP              ; 需要１個機械週期
a4: 
        DJNZ    R5,a4    ; 需要２個機械週期
        DJNZ    R6,a5
        DJNZ    R7,a6
        RET

;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
; 副程式名稱 ︰ DELAY_01S
;  功  能    ︰ 延遲時間 0.1 SECOND
;使用暫存器  ︰ R7,R6,R5
;延遲時間    T=1+R7*[1+R6*(1+R5*2+2)+2]+2
;             =1+1*[1+200*(1+1+248*2+2)+2]+2
;             = us = 0.1 SEC
;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

DELAY_01S:
        MOV     R7,#01
a9:        
        MOV     R6,#200  ; 需要１個機械週期
a8:
        MOV     R5,#248
        NOP              ; 需要１個機械週期
a7: 
        DJNZ    R5,a7    ; 需要２個機械週期
        DJNZ    R6,a8
        DJNZ    R7,a9
        RET



;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
; LED_TABLE  的資料 1 表示LED 會亮
;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


LED_TABLE_FIRST:                ; LED 顯示資料表

        DB      0E0H,0E0H,0E0H,0E0H        
        DB      0EH,0EH,0EH,0EH        
        DB      0EEH,000H,000H,0EEH        
        DB      00H,0EEH,0EEH,00H
        DB      0EEH,0EEH,0EEH,0EEH
        ;以上間隔 0.5 秒

LED_TABLE_SECOND:               ; LED 顯示資料表

        DB      0AAH,0AAH,0AAH,0AAH        
        DB      55H,55H,55H,55H        
        DB      0CCH,0CCH,0CCH,0CCH        
        DB      11100011B, 10001110B, 00111000B, 11100011B        
        DB      00011100B, 01110001B, 11000111B, 00011100B 
        DB      00H, 00H, 00H, 00H
        ;以上間隔 0.1 秒

LED_TABLE_THIRD:                ; LED 顯示資料表

        DB      088H,088H,088H,088H
        DB      0BBH,0BBH,0BBH,0BBH
        DB      0EEH,0EEH,0EEH,0EEH
        DB      0FFH,0FFH,0FFH,0FFH
        ;以上間隔 0.5 秒


END