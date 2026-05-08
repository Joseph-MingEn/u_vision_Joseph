        ORG 00H ; 主程式起點
        JMP START ; 跳至主程式
        ORG 03H ; 指到程式記憶體的03H位址
        JMP SUB_INT0 ; 跳至INT0中斷副程式
        ORG 13H ; 指到程式記憶體的13H位址
        JMP SUB_INT1 ;跳至INT1中斷副程式
START:
        MOV SP,#5FH ;設定堆疊指標(Stack Pointer)

        ; MOV A,#01H
        ; MOV P0, A ; 設定輸出埠初始值

        MOV R0,#00H        ; R0 當計數器，0~9
        ACALL DISPLAY

        SETB EA ;致能中斷系統
        MOV IE,#10000101B ; INT0, INT1 中斷致能
        MOV IP,#00000001B ; INT0 中斷優先於 INT1設定
        SETB IT0 ; INT0 負緣觸發
        SETB IT1 ; INT1 負緣觸發
D1:
        JMP D1 ; 無窮回路等待中斷; INT0中斷副程式

SUB_INT0:
        INC R0
        CJNE R0,#0AH,INT0_OK
        MOV R0,#00H        ; 超過9回到0
INT0_OK:
        CALL DISPLAY
        RETI

SUB_INT1:
        DEC R0
        CJNE R0,#00H,INT1_OK
        MOV R0,#09H        ; 0再減回到9

INT1_OK:
        CALL DISPLAY
        RETI


DISPLAY:
        MOV A,R0
        MOV DPTR,#TABLE
        MOVC A,@A+DPTR
        MOV P0,A
        RET

TABLE:
        DB 0fch    ; 0
        DB 060h    ; 1
        DB 0dah    ; 2
        DB 0f2h    ; 3
        DB 066h    ; 4
        DB 0b6h    ; 5
        DB 03eh    ; 6
        DB 0e0h    ; 7
        DB 0feh    ; 8
        DB 0e6h    ; 9

END