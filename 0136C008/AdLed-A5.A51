;***********************************************************; 
;程式名稱 : ＬＥＤ－Ａ．ＡＳＭ;  
;功  能  : 廣告燈;  
;說  明  : 使用建表的方式製作廣告燈; 
;開關設定 : 無;
;***********************************************************
        ORG     00H
        JMP     START
        ORG     30H
START:
        MOV     R0,#30          ; R0 : 迴圈計數
        MOV     DPTR,#LED_TABLE ; DPTR 指向 LED 顯示資料表
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
        CALL    DELAY_05S      ; 延遲時間 0.5 SECOND
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



;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
; 副程式名稱 ︰ DELAY_0.2S
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
; LED_TABLE  的資料 1 表示LED 會亮
;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


LED_TABLE:                ; LED 顯示資料表

        DB      55H,55H,55H,000H        
        DB      0AAH,0AAH,0AAH,000H        
        DB      55H,55H,55H,55H        
        DB      0AAH,0AAH,0AAH,000H        
        DB      55H,55H,55H,00H        
        DB      0AAH,0AAH,0AAH,000H        
        DB      33H,33H,33H,00H        
        DB      0CCH,0CCH,0CCH,000H        
        DB      33H,33H,33H,00H        
        DB      0CCH,0CCH,0CCH,000H        
        DB      33H,33H,33H,00H        
        DB      0CCH,0CCH,0CCH,00H        
        DB      0C7H,71H,1CH,00H        
        DB      38H,8EH,E3H,00H        
        DB      0C7H,71H,01CH,00H        
        DB      38H,8EH,0E3H,00H        
        DB      0C7H,71H,1CH,00H        
        DB      38H,8EH,0E3H,00H        
        DB      1FH,7CH,0F0H,00H        
        DB      0E0H,83H,0FH,00H        
        DB      1FH,7CH,0F0H,00H        
        DB      0E0H,83H,0FH,00H        
        DB      1FH,7CH,0F0H,00H        
        DB      0E0H,83H,0FH,00H        
        DB      00H,00H,00H,00H        
        DB      0FFH,0FFH,0FFH,00H        
        DB      00H,00H,00H,00H        
        DB      0FFH,0FFH,0FFH,00H        
        DB      00H,00H,00H,00H        
        DB      0FFH,0FFH,0FFH,00H        

END