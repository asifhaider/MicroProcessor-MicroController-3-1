/*
 * LabWork1.c
 *
 * Created: 6/13/2022 1:51:43 PM
 * Author : User
 */ 
#include <stdio.h>
#include <avr/io.h>
#define F_CPU 1000000 
#include <util/delay.h>

int main(void)
{
	DDRA = 0b01111000; //configuring output for Port A
	
    
	int counter = 0;
	unsigned char in=0;
	unsigned char temp = 0;
	
    while (1) 
    {
		in = PINA; //reading input for down counter at PA1
		
	
		if(in & 0x02)
		{
			if(counter == 0) counter = 16;
			counter-- ;
			
			temp = counter;
			temp = temp << 3;
			PORTA = temp;//showing output to port B
			
			
			_delay_ms(1000);
		}
		
    }
}

