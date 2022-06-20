/*
 * Digit Right Slide LED Matrix
 *
 * Created: 6/20/2022 5:46:25 PM
 * Author : Fahim Shahriyar, Md. Asif Haider, and others
 */ 
#include <avr/io.h>
#define F_CPU 1000000 // Clock Frequency
#include <util/delay.h>

int main(void)
{
	int i=0, j;
	unsigned char c = 0;
	unsigned char d = 0; 
	unsigned char in;
		
	DDRC = 0b11111111;
	DDRD = 0b11111111;
	DDRA = 0b11111110;
	int slide_flag=0;
	
	unsigned char C[] = {1,2,4,8,16,32,64,128};
	// unsigned char C[] = {128, 64, 32, 16, 8, 4, 2, 1};
	// unsigned char D[] = {0x00,0x78,0x40,0x70,0x40,0x40,0x40,0x00};	
	unsigned char D[] = {0x00,0x77,0x15,0x77,0x54,0x77,0x00,0x00};
	for(i=0; i<8; i++)
	{
		D[i] = ~D[i];
	}
	i=0;
	int k =0,p,q;
	
	// For smooth operation on Port C
	MCUCSR = (1<<JTD);
	MCUCSR = (1<<JTD);
	
	
	while(1)
	{
		for (i=0;i<8*5;i++)
		{
			p= i % 8;	// for repeating across both dimension
			q= i % 8;
			
			PORTC = C[p];
			PORTD = D[q];
			_delay_ms(2);	// works best so far, no blinking issue
		}
		
		c=0; d=0;
		in = PINA;
		
		// switch button handling, swapping current state
		if(in & 1)
		{
			if(slide_flag)
			{
				slide_flag = 0;
			}
			else
			slide_flag = 1;
		} 
		
		
		
		while(slide_flag)
		
		{
			for(j=0; j<8; j++)
			{
			//left transition
			// c  = c | ( 1 & D[j] );
			// c = c << 7;
			
			//D[j] = D[j] >> 1;
			//D[j] = D[j] | c;
			
			//right transition
			
			d= (1<<7)&(D[j]);
			d=d>>7; 
			
			D[j] = D[j]<<1; 
			D[j]=D[j]|d; 
			}
		break;
		}
		
		//_delay_ms(100);
		
	}
}