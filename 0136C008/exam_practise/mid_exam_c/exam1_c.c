#include <REGX51.H>

typedef unsigned char u8;

/* =========================
   LED 資料表
   每 4 bytes = 一個畫面
   依序輸出到 P0, P1, P2, P3
   ========================= */

const u8 LED_TABLE_FIRST[] = {
    0xF0, 0xF0, 0xF0, 0xF0,
    0x0F, 0x0F, 0x0F, 0x0F,
    0xFF, 0x00, 0x00, 0xFF,
    0x00, 0xFF, 0xFF, 0x00,
    0xFF, 0xFF, 0xFF, 0xFF}; 

const u8 LED_TABLE_SECOND[] = {
    0xAA, 0xAA, 0xAA, 0xAA,
    0x55, 0x55, 0x55, 0x55,
    0xCC, 0xCC, 0xCC, 0xCC,
    0xE3, 0x8E, 0x38, 0xE3,
    0x1C, 0x71, 0xC7, 0x1C,
    0x00, 0x00, 0x00, 0x00};

const u8 LED_TABLE_THIRD[] = {
    0x88, 0x88, 0x88, 0x88,
    0xCC, 0xCC, 0xCC, 0xCC,
    0xEE, 0xEE, 0xEE, 0xEE,
    0xFF, 0xFF, 0xFF, 0xFF};

/* =========================
   延遲副程式
   ========================= */

void DELAY_05S(void)
{
    u8 r7, r6, r5;

    for (r7 = 5; r7 > 0; r7--)
    {
        for (r6 = 200; r6 > 0; r6--)
        {
            for (r5 = 248; r5 > 0; r5--)
            {
                ; // 對應組語中的 NOP / 空迴圈
            }
        }
    }
}

void DELAY_01S(void)
{
    u8 r7, r6, r5;

    for (r7 = 1; r7 > 0; r7--)
    {
        for (r6 = 200; r6 > 0; r6--)
        {
            for (r5 = 248; r5 > 0; r5--)
            {
                ;
            }
        }
    }
}

void DELAY_025S(void)
{
    u8 r7, r6, r5;

    for (r7 = 5; r7 > 0; r7--)
    {
        for (r6 = 100; r6 > 0; r6--)
        {
            for (r5 = 248; r5 > 0; r5--)
            {
                ; // 對應組語中的 NOP / 空迴圈
            }
        }
    }
}
/* =========================
   顯示一個畫面
   ptr 指向 4 個 bytes
   ========================= */

void SHOW_FRAME(const u8 *ptr)
{
    P0 = ptr[0];
    P1 = ptr[1];
    P2 = ptr[2];
    P3 = ptr[3];
}

/* =========================
   主程式
   ========================= */

void main(void)
{
    u8 i;
    const u8 *ptr;

    while (1)
    {
        /* FIRST */
        ptr = LED_TABLE_FIRST;
        for (i = 0; i < 5; i++)
        {
            SHOW_FRAME(ptr);
            ptr += 4;
            DELAY_01S();
        }

        /* SECOND */
        ptr = LED_TABLE_SECOND;
        for (i = 0; i < 6; i++)
        {
            SHOW_FRAME(ptr);
            ptr += 4;
            DELAY_025S();
        }

        /* THIRD */
        ptr = LED_TABLE_THIRD;
        for (i = 0; i < 4; i++)
        {
            SHOW_FRAME(ptr);
            ptr += 4;
            DELAY_05S();
        
    }
}