/*
 * float2uart.h
 *
 *  Created on: 25 feb. 2018
 *      Author: Damian
 */

#ifndef FLOAT2UART_H_
#define FLOAT2UART_H_

#include "stm32f4xx_hal.h"

void float2uart(UART_HandleTypeDef *uart, float buff[], uint32_t len);



#endif /* FLOAT2UART_H_ */
