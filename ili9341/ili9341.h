#include <stdint.h>

#ifndef __ILI9341_H__
#define __ILI9341_H__

#define LCD_W 240
#define LCD_H 320
#define WHITE         	 0xFFFF
#define RED           	 0xF800
#define BLUE         	 0x001F
#define BLACK            0x0000
#define BRED             0XF81F
#define GRED             0XFFE0
#define GBLUE            0X07FF
#define MAGENTA          0xF81F
#define GREEN            0x07E0
#define CYAN             0x7FFF
#define YELLOW           0xFFE0
#define BROWN            0XBC40 //Brown
#define BRRED            0XFC07 //Brownish red
#define GRAY             0X8430 //Gray

void lcd_init();
void clear(uint16_t Color);
void show_string(uint16_t x, uint16_t y, const uint8_t *p);
void show_char(uint16_t x, uint16_t y, uint8_t num, uint8_t mode);

#endif
