        org     00h
        mov     r4,#0 ;display counter
Loop:   mov     a,r4
;處理個位數
        anl     a,#0fh ; get one digit
        call Hex_To_7SEG
        mov     p1,a
        mov     a,r4
        ;處理十位數
        swap    a ; get ten digit
        anl     a,#0fh
        call Hex_To_7SEG
        mov     p2,a
        mov     r5,#50 ; display 1 second
        call DELAY
        inc     r4
        jmp     Loo

;delay time=r5*(20ms)
Delay:  mov     r6,40

Del:    mov     r7,#249

$1:     djnz    r7,$1
        djnz    r6,Del
        djnz    r5,Delay
        ret

Hex_To_7SEG:

        mov     dptr,#Segment_Table
        movc    a,@a+dptr
        ret

Segment_Table:
        
        db 0fch,060h,0dah,0f2h,066h ;0-4
        db 0b6h,03eh,0e0h,0feh,0e6h ;5-9
        db 0ffh,07fh,0bfh,0dfh,0efh,0f7h ;a-f