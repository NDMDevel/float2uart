/*
 * float2uart.c
 *
 *  Created on: 25 feb. 2018
 *      Author: Damian
 */

#include "float2uart.h"

void float2uart(UART_HandleTypeDef *uart, float buff[], uint32_t len)
{
	union
	{
		float f;
		union
		{
			uint32_t word;
			uint8_t byte[4];
		}uint32;
	}float32;

	for( uint32_t k=0 ; k<len ; k++ )
	{
		float32.f = buff[k];
		HAL_UART_Transmit(uart,float32.uint32.byte,4,100000);
	}
}



