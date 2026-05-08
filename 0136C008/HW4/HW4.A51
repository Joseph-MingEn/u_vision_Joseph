        ORG 00H ; 主程式起點
        JMP START ; 跳至主程式
        ORG 03H ; 指到程式記憶體的03H位址
        JMP SUB_INT0 ; 跳至INT0中斷副程式
        ORG 13H ; 指到程式記憶體的13H位址
        JMP SUB_INT1 ;跳至INT1中斷副程式
START:
        MOV SP,#5FH ;設定堆疊指標(Stack Pointer)
        MOV A,#01H
        MOV P0, A ; 設定輸出埠初始值
        SETB EA ;致能中斷系統
        MOV IE,#10000101B ; INT0, INT1 中斷致能
        MOV IP,#00000001B ; INT0 中斷優先於 INT1設定
        SETB IT0 ; INT0 負緣觸發
        SETB IT1 ; INT1 負緣觸發
D1:
        JMP D1 ; 無窮回路等待中斷; INT0中斷副程式

SUB_INT0:
        MOV P0,A ; 輸出 P0資料
        INC A ; A 加一
        RETI ; INT1中斷副程式
SUB_INT1:
        MOV P0,A ; 輸出 P0資料
        DEC A ; A減一
        RETI

END