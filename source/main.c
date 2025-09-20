#include <avr/io.h>
#include <util/delay.h>

int main()
{
  DDRB = 0b11111111;
  PORTB = 0b00000000;

  while(1){
    PORTB = ~PORTB;
    _delay_ms(500);
  }

  return 0;
}
