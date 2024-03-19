#include <stdint.h>
#include "pico/stdlib.h"
#include "hardware/uart.h"
#include "hardware/irq.h"
#include "ili9341.h"

uint16_t x = 0;
uint16_t y = 0;
uint16_t received = 0;

int main(){
  lcd_init();
  clear(BLACK);
  show_char(x,y,66,0);
  uart_init(uart1, 115200);
  gpio_set_function(9, GPIO_FUNC_UART);
  for(;;){
    if (uart_is_readable(uart1)) {
	  int ch = uart_getc(uart1);
	  if (ch > 32 && ch < 126) {
	    show_char(x, y, ch, 0);
	    received++;
	    x += 8;
	    if (received > 28) {
	      x = 0;
	      y += 16;
	      received = 0;
}}}}}
  
  //show_string(50,50,"ABCDEFG abc 123");
  //show_string(0,100,"123456789012345678901234567890");
  //return 0;}
    
    
    
