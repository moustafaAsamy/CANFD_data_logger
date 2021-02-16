/**
 ******************************************************************************
 * @file      startup_stm32g474retx.s
 * @author    Auto-generated by STM32CubeIDE
 * @brief     STM32G474RETx device vector table for GCC toolchain.
 *            This module performs:
 *                - Set the initial SP
 *                - Set the initial PC == Reset_Handler,
 *                - Set the vector table entries with the exceptions ISR address
 *                - Branches to main in the C library (which eventually
 *                  calls main()).
 ******************************************************************************
 * @attention
 *
 * <h2><center>&copy; Copyright (c) 2020 STMicroelectronics.
 * All rights reserved.</center></h2>
 *
 * This software component is licensed by ST under BSD 3-Clause license,
 * the "License"; You may not use this file except in compliance with the
 * License. You may obtain a copy of the License at:
 *                        opensource.org/licenses/BSD-3-Clause
 *
 ******************************************************************************
 */

.syntax unified
.cpu cortex-m4
.fpu softvfp
.thumb

.global g_pfnVectors
.global Default_Handler

/* start address for the initialization values of the .data section.
defined in linker script */
.word _sidata
/* start address for the .data section. defined in linker script */
.word _sdata
/* end address for the .data section. defined in linker script */
.word _edata
/* start address for the .bss section. defined in linker script */
.word _sbss
/* end address for the .bss section. defined in linker script */
.word _ebss

/**
 * @brief  This is the code that gets called when the processor first
 *          starts execution following a reset event. Only the absolutely
 *          necessary set is performed, after which the application
 *          supplied main() routine is called.
 * @param  None
 * @retval : None
*/

  .section .text.Reset_Handler
  .weak Reset_Handler
  .type Reset_Handler, %function
Reset_Handler:
  ldr   r0, =_estack
  mov   sp, r0          /* set stack pointer */
/* Call the clock system intitialization function.*/
  bl  SystemInit

/* Copy the data segment initializers from flash to SRAM */
  ldr r0, =_sdata
  ldr r1, =_edata
  ldr r2, =_sidata
  movs r3, #0
  b LoopCopyDataInit

CopyDataInit:
  ldr r4, [r2, r3]
  str r4, [r0, r3]
  adds r3, r3, #4

LoopCopyDataInit:
  adds r4, r0, r3
  cmp r4, r1
  bcc CopyDataInit

/* Zero fill the bss segment. */
  ldr r2, =_sbss
  ldr r4, =_ebss
  movs r3, #0
  b LoopFillZerobss

FillZerobss:
  str  r3, [r2]
  adds r2, r2, #4

LoopFillZerobss:
  cmp r2, r4
  bcc FillZerobss

/* Call static constructors */
  bl __libc_init_array
/* Call the application's entry point.*/
  bl main

LoopForever:
    b LoopForever

  .size Reset_Handler, .-Reset_Handler

/**
 * @brief  This is the code that gets called when the processor receives an
 *         unexpected interrupt.  This simply enters an infinite loop, preserving
 *         the system state for examination by a debugger.
 *
 * @param  None
 * @retval : None
*/
  .section .text.Default_Handler,"ax",%progbits
Default_Handler:
Infinite_Loop:
  b Infinite_Loop
  .size Default_Handler, .-Default_Handler

/******************************************************************************
*
* The STM32G474RETx vector table.  Note that the proper constructs
* must be placed on this to ensure that it ends up at physical address
* 0x0000.0000.
*
******************************************************************************/
  .section .isr_vector,"a",%progbits
  .type g_pfnVectors, %object
  .size g_pfnVectors, .-g_pfnVectors

g_pfnVectors:
  .word _estack
  .word Reset_Handler
  .word NMI_Handler
  .word HardFault_Handler
  .word	MemManage_Handler
  .word	BusFault_Handler
  .word	UsageFault_Handler
  .word	0
  .word	0
  .word	0
  .word	0
  .word	SVC_Handler
  .word	DebugMon_Handler
  .word	0
  .word	PendSV_Handler
  .word	SysTick_Handler
  .word	WWDG_IRQHandler              			/* Window Watchdog interrupt       */
  .word	PVD_PVM_IRQHandler           			/* PVD through EXTI line detection */
  .word	RTC_TAMP_CSS_LSE_IRQHandler  			/* RTC_TAMP_CSS_LSE                */
  .word	RTC_WKUP_IRQHandler          			/* RTC Wakeup timer                */
  .word	FLASH_IRQHandler             			/* FLASH                           */
  .word	RCC_IRQHandler               			/* RCC                             */
  .word	EXTI0_IRQHandler             			/* EXTI Line0 interrupt            */
  .word	EXTI1_IRQHandler             			/* EXTI Line1 interrupt            */
  .word	EXTI2_IRQHandler             			/* EXTI Line2 interrupt            */
  .word	EXTI3_IRQHandler             			/* EXTI Line3 interrupt            */
  .word	EXTI4_IRQHandler             			/* EXTI Line4 interrupt            */
  .word	DMA1_CH1_IRQHandler          			/* DMA1 channel 1 interrupt        */
  .word	DMA1_CH2_IRQHandler          			/* DMA1 channel 2 interrupt        */
  .word	DMA1_CH3_IRQHandler          			/* DMA1 channel 3 interrupt        */
  .word	DMA1_CH4_IRQHandler          			/* DMA1 channel 4 interrupt        */
  .word	DMA1_CH5_IRQHandler          			/* DMA1 channel 5 interrupt        */
  .word	DMA1_CH6_IRQHandler          			/* DMA1 channel 6 interrupt        */
  .word	DMA1_CH7_IRQHandler          			/* DMA1 channel 7 interrupt        */
  .word	ADC1_2_IRQHandler            			/* ADC1 and ADC2 global interrupt  */
  .word	USB_HP_IRQHandler            			/* USB_HP                          */
  .word	USB_LP_IRQHandler            			/* USB_LP                          */
  .word	fdcan1_intr1_it_IRQHandler   			/* FDCAN1 interrupt                */
  .word	fdcan1_intr0_it_IRQHandler   			/* FDCAN1 interrupt                */
  .word	EXTI9_5_IRQHandler           			/* EXTI9_5                         */
  .word	TIM1_BRK_TIM15_IRQHandler    			/* TIM1_BRK_TIM15                  */
  .word	TIM1_UP_TIM16_IRQHandler     			/* TIM1_UP_TIM16                   */
  .word	TIM1_TRG_COM_IRQHandler      			/* TIM1_TRG_COM/                   */
  .word	TIM1_CC_IRQHandler           			/* TIM1 capture compare interrupt  */
  .word	TIM2_IRQHandler              			/* TIM2                            */
  .word	TIM3_IRQHandler              			/* TIM3                            */
  .word	TIM4_IRQHandler              			/* TIM4                            */
  .word	I2C1_EV_IRQHandler           			/* I2C1_EV                         */
  .word	I2C1_ER_IRQHandler           			/* I2C1_ER                         */
  .word	I2C2_EV_IRQHandler           			/* I2C2_EV                         */
  .word	I2C2_ER_IRQHandler           			/* I2C2_ER                         */
  .word	SPI1_IRQHandler              			/* SPI1                            */
  .word	SPI2_IRQHandler              			/* SPI2                            */
  .word	USART1_IRQHandler            			/* USART1                          */
  .word	USART2_IRQHandler            			/* USART2                          */
  .word	USART3_IRQHandler            			/* USART3                          */
  .word	EXTI15_10_IRQHandler         			/* EXTI15_10                       */
  .word	RTC_ALARM_IRQHandler         			/* RTC_ALARM                       */
  .word	USBWakeUP_IRQHandler         			/* USBWakeUP                       */
  .word	TIM8_BRK_IRQHandler          			/* TIM8_BRK                        */
  .word	TIM8_UP_IRQHandler           			/* TIM8_UP                         */
  .word	TIM8_TRG_COM_IRQHandler      			/* TIM8_TRG_COM                    */
  .word	TIM8_CC_IRQHandler           			/* TIM8_CC                         */
  .word	ADC3_IRQHandler              			/* ADC3                            */
  .word	FMC_IRQHandler               			/* FMC                             */
  .word	LPTIM1_IRQHandler            			/* LPTIM1                          */
  .word	TIM5_IRQHandler              			/* TIM5                            */
  .word	SPI3_IRQHandler              			/* SPI3                            */
  .word	UART4_IRQHandler             			/* UART4                           */
  .word	UART5_IRQHandler             			/* UART5                           */
  .word	TIM6_DACUNDER_IRQHandler     			/* TIM6_DACUNDER                   */
  .word	TIM7_IRQHandler              			/* TIM7                            */
  .word	DMA2_CH1_IRQHandler          			/* DMA2_CH1                        */
  .word	DMA2_CH2_IRQHandler          			/* DMA2_CH2                        */
  .word	DMA2_CH3_IRQHandler          			/* DMA2_CH3                        */
  .word	DMA2_CH4_IRQHandler          			/* DMA2_CH4                        */
  .word	DMA2_CH5_IRQHandler          			/* DMA2_CH5                        */
  .word	ADC4_IRQHandler              			/* ADC4                            */
  .word	ADC5_IRQHandler              			/* ADC5                            */
  .word	UCPD1_IRQHandler             			/* UCPD1                           */
  .word	COMP1_2_3_IRQHandler         			/* COMP1_2_3                       */
  .word	COMP4_5_6_IRQHandler         			/* COMP4_5_6                       */
  .word	COMP7_IRQHandler             			/* COMP7                           */
  .word	HRTIM_Master_IRQn_IRQHandler 			/* HRTIM_Master_IRQn               */
  .word	HRTIM_TIMA_IRQn_IRQHandler   			/* HRTIM_TIMA_IRQn                 */
  .word	HRTIM_TIMB_IRQn_IRQHandler   			/* HRTIM_TIMB_IRQn                 */
  .word	HRTIM_TIMC_IRQn_IRQHandler   			/* HRTIM_TIMC_IRQn                 */
  .word	HRTIM_TIMD_IRQn_IRQHandler   			/* HRTIM_TIMD_IRQn                 */
  .word	HRTIM_TIME_IRQn_IRQHandler   			/* HRTIM_TIME_IRQn                 */
  .word	HRTIM_TIM_FLT_IRQn_IRQHandler			/* HRTIM_TIM_FLT_IRQn              */
  .word	HRTIM_TIMF_IRQn_IRQHandler   			/* HRTIM_TIMF_IRQn                 */
  .word	CRS_IRQHandler               			/* CRS                             */
  .word	SAI_IRQHandler               			/* SAI                             */
  .word	TIM20_BRK_IRQHandler         			/* TIM20_BRK                       */
  .word	TIM20_UP_IRQHandler          			/* TIM20_UP                        */
  .word	TIM20_TRG_COM_IRQHandler     			/* TIM20_TRG_COM                   */
  .word	TIM20_CC_IRQHandler          			/* TIM20_CC                        */
  .word	FPU_IRQHandler               			/* Floating point unit interrupt   */
  .word	I2C4_EV_IRQHandler           			/* I2C4_EV                         */
  .word	I2C4_ER_IRQHandler           			/* I2C4_ER                         */
  .word	SPI4_IRQHandler              			/* SPI4                            */
  .word	0                            			/* Reserved                        */
  .word	FDCAN2_intr0_IRQHandler      			/* FDCAN2 interrupt                */
  .word	FDCAN2_intr1_IRQHandler      			/* FDCAN2 interrupt                */
  .word	FDCAN3_intr0_IRQHandler      			/* FDCAN3 interrupt                */
  .word	FDCAN3_intr1_IRQHandler      			/* FDCAN3 interrupt                */
  .word	RNG_IRQHandler               			/* RNG                             */
  .word	LPUART_IRQHandler            			/* LPUART                          */
  .word	I2C3_EV_IRQHandler           			/* I2C3_EV                         */
  .word	I2C3_ER_IRQHandler           			/* I2C3_ER                         */
  .word	DMAMUX_OVR_IRQHandler        			/* DMAMUX_OVR                      */
  .word	QUADSPI_IRQHandler           			/* QUADSPI                         */
  .word	DMA1_CH8_IRQHandler          			/* DMA1_CH8                        */
  .word	DMA2_CH6_IRQHandler          			/* DMA2_CH6                        */
  .word	DMA2_CH7_IRQHandler          			/* DMA2_CH7                        */
  .word	DMA2_CH8_IRQHandler          			/* DMA2_CH8                        */
  .word	Cordic_IRQHandler            			/* Cordic                          */
  .word	FMAC_IRQHandler              			/* FMAC                            */

/*******************************************************************************
*
* Provide weak aliases for each Exception handler to the Default_Handler.
* As they are weak aliases, any function with the same name will override
* this definition.
*
*******************************************************************************/

	.weak	NMI_Handler
	.thumb_set NMI_Handler,Default_Handler

	.weak	HardFault_Handler
	.thumb_set HardFault_Handler,Default_Handler

	.weak	MemManage_Handler
	.thumb_set MemManage_Handler,Default_Handler

	.weak	BusFault_Handler
	.thumb_set BusFault_Handler,Default_Handler

	.weak	UsageFault_Handler
	.thumb_set UsageFault_Handler,Default_Handler

	.weak	SVC_Handler
	.thumb_set SVC_Handler,Default_Handler

	.weak	DebugMon_Handler
	.thumb_set DebugMon_Handler,Default_Handler

	.weak	PendSV_Handler
	.thumb_set PendSV_Handler,Default_Handler

	.weak	SysTick_Handler
	.thumb_set SysTick_Handler,Default_Handler

	.weak	WWDG_IRQHandler
	.thumb_set WWDG_IRQHandler,Default_Handler

	.weak	PVD_PVM_IRQHandler
	.thumb_set PVD_PVM_IRQHandler,Default_Handler

	.weak	RTC_TAMP_CSS_LSE_IRQHandler
	.thumb_set RTC_TAMP_CSS_LSE_IRQHandler,Default_Handler

	.weak	RTC_WKUP_IRQHandler
	.thumb_set RTC_WKUP_IRQHandler,Default_Handler

	.weak	FLASH_IRQHandler
	.thumb_set FLASH_IRQHandler,Default_Handler

	.weak	RCC_IRQHandler
	.thumb_set RCC_IRQHandler,Default_Handler

	.weak	EXTI0_IRQHandler
	.thumb_set EXTI0_IRQHandler,Default_Handler

	.weak	EXTI1_IRQHandler
	.thumb_set EXTI1_IRQHandler,Default_Handler

	.weak	EXTI2_IRQHandler
	.thumb_set EXTI2_IRQHandler,Default_Handler

	.weak	EXTI3_IRQHandler
	.thumb_set EXTI3_IRQHandler,Default_Handler

	.weak	EXTI4_IRQHandler
	.thumb_set EXTI4_IRQHandler,Default_Handler

	.weak	DMA1_CH1_IRQHandler
	.thumb_set DMA1_CH1_IRQHandler,Default_Handler

	.weak	DMA1_CH2_IRQHandler
	.thumb_set DMA1_CH2_IRQHandler,Default_Handler

	.weak	DMA1_CH3_IRQHandler
	.thumb_set DMA1_CH3_IRQHandler,Default_Handler

	.weak	DMA1_CH4_IRQHandler
	.thumb_set DMA1_CH4_IRQHandler,Default_Handler

	.weak	DMA1_CH5_IRQHandler
	.thumb_set DMA1_CH5_IRQHandler,Default_Handler

	.weak	DMA1_CH6_IRQHandler
	.thumb_set DMA1_CH6_IRQHandler,Default_Handler

	.weak	DMA1_CH7_IRQHandler
	.thumb_set DMA1_CH7_IRQHandler,Default_Handler

	.weak	ADC1_2_IRQHandler
	.thumb_set ADC1_2_IRQHandler,Default_Handler

	.weak	USB_HP_IRQHandler
	.thumb_set USB_HP_IRQHandler,Default_Handler

	.weak	USB_LP_IRQHandler
	.thumb_set USB_LP_IRQHandler,Default_Handler

	.weak	fdcan1_intr1_it_IRQHandler
	.thumb_set fdcan1_intr1_it_IRQHandler,Default_Handler

	.weak	fdcan1_intr0_it_IRQHandler
	.thumb_set fdcan1_intr0_it_IRQHandler,Default_Handler

	.weak	EXTI9_5_IRQHandler
	.thumb_set EXTI9_5_IRQHandler,Default_Handler

	.weak	TIM1_BRK_TIM15_IRQHandler
	.thumb_set TIM1_BRK_TIM15_IRQHandler,Default_Handler

	.weak	TIM1_UP_TIM16_IRQHandler
	.thumb_set TIM1_UP_TIM16_IRQHandler,Default_Handler

	.weak	TIM1_TRG_COM_IRQHandler
	.thumb_set TIM1_TRG_COM_IRQHandler,Default_Handler

	.weak	TIM1_CC_IRQHandler
	.thumb_set TIM1_CC_IRQHandler,Default_Handler

	.weak	TIM2_IRQHandler
	.thumb_set TIM2_IRQHandler,Default_Handler

	.weak	TIM3_IRQHandler
	.thumb_set TIM3_IRQHandler,Default_Handler

	.weak	TIM4_IRQHandler
	.thumb_set TIM4_IRQHandler,Default_Handler

	.weak	I2C1_EV_IRQHandler
	.thumb_set I2C1_EV_IRQHandler,Default_Handler

	.weak	I2C1_ER_IRQHandler
	.thumb_set I2C1_ER_IRQHandler,Default_Handler

	.weak	I2C2_EV_IRQHandler
	.thumb_set I2C2_EV_IRQHandler,Default_Handler

	.weak	I2C2_ER_IRQHandler
	.thumb_set I2C2_ER_IRQHandler,Default_Handler

	.weak	SPI1_IRQHandler
	.thumb_set SPI1_IRQHandler,Default_Handler

	.weak	SPI2_IRQHandler
	.thumb_set SPI2_IRQHandler,Default_Handler

	.weak	USART1_IRQHandler
	.thumb_set USART1_IRQHandler,Default_Handler

	.weak	USART2_IRQHandler
	.thumb_set USART2_IRQHandler,Default_Handler

	.weak	USART3_IRQHandler
	.thumb_set USART3_IRQHandler,Default_Handler

	.weak	EXTI15_10_IRQHandler
	.thumb_set EXTI15_10_IRQHandler,Default_Handler

	.weak	RTC_ALARM_IRQHandler
	.thumb_set RTC_ALARM_IRQHandler,Default_Handler

	.weak	USBWakeUP_IRQHandler
	.thumb_set USBWakeUP_IRQHandler,Default_Handler

	.weak	TIM8_BRK_IRQHandler
	.thumb_set TIM8_BRK_IRQHandler,Default_Handler

	.weak	TIM8_UP_IRQHandler
	.thumb_set TIM8_UP_IRQHandler,Default_Handler

	.weak	TIM8_TRG_COM_IRQHandler
	.thumb_set TIM8_TRG_COM_IRQHandler,Default_Handler

	.weak	TIM8_CC_IRQHandler
	.thumb_set TIM8_CC_IRQHandler,Default_Handler

	.weak	ADC3_IRQHandler
	.thumb_set ADC3_IRQHandler,Default_Handler

	.weak	FMC_IRQHandler
	.thumb_set FMC_IRQHandler,Default_Handler

	.weak	LPTIM1_IRQHandler
	.thumb_set LPTIM1_IRQHandler,Default_Handler

	.weak	TIM5_IRQHandler
	.thumb_set TIM5_IRQHandler,Default_Handler

	.weak	SPI3_IRQHandler
	.thumb_set SPI3_IRQHandler,Default_Handler

	.weak	UART4_IRQHandler
	.thumb_set UART4_IRQHandler,Default_Handler

	.weak	UART5_IRQHandler
	.thumb_set UART5_IRQHandler,Default_Handler

	.weak	TIM6_DACUNDER_IRQHandler
	.thumb_set TIM6_DACUNDER_IRQHandler,Default_Handler

	.weak	TIM7_IRQHandler
	.thumb_set TIM7_IRQHandler,Default_Handler

	.weak	DMA2_CH1_IRQHandler
	.thumb_set DMA2_CH1_IRQHandler,Default_Handler

	.weak	DMA2_CH2_IRQHandler
	.thumb_set DMA2_CH2_IRQHandler,Default_Handler

	.weak	DMA2_CH3_IRQHandler
	.thumb_set DMA2_CH3_IRQHandler,Default_Handler

	.weak	DMA2_CH4_IRQHandler
	.thumb_set DMA2_CH4_IRQHandler,Default_Handler

	.weak	DMA2_CH5_IRQHandler
	.thumb_set DMA2_CH5_IRQHandler,Default_Handler

	.weak	ADC4_IRQHandler
	.thumb_set ADC4_IRQHandler,Default_Handler

	.weak	ADC5_IRQHandler
	.thumb_set ADC5_IRQHandler,Default_Handler

	.weak	UCPD1_IRQHandler
	.thumb_set UCPD1_IRQHandler,Default_Handler

	.weak	COMP1_2_3_IRQHandler
	.thumb_set COMP1_2_3_IRQHandler,Default_Handler

	.weak	COMP4_5_6_IRQHandler
	.thumb_set COMP4_5_6_IRQHandler,Default_Handler

	.weak	COMP7_IRQHandler
	.thumb_set COMP7_IRQHandler,Default_Handler

	.weak	HRTIM_Master_IRQn_IRQHandler
	.thumb_set HRTIM_Master_IRQn_IRQHandler,Default_Handler

	.weak	HRTIM_TIMA_IRQn_IRQHandler
	.thumb_set HRTIM_TIMA_IRQn_IRQHandler,Default_Handler

	.weak	HRTIM_TIMB_IRQn_IRQHandler
	.thumb_set HRTIM_TIMB_IRQn_IRQHandler,Default_Handler

	.weak	HRTIM_TIMC_IRQn_IRQHandler
	.thumb_set HRTIM_TIMC_IRQn_IRQHandler,Default_Handler

	.weak	HRTIM_TIMD_IRQn_IRQHandler
	.thumb_set HRTIM_TIMD_IRQn_IRQHandler,Default_Handler

	.weak	HRTIM_TIME_IRQn_IRQHandler
	.thumb_set HRTIM_TIME_IRQn_IRQHandler,Default_Handler

	.weak	HRTIM_TIM_FLT_IRQn_IRQHandler
	.thumb_set HRTIM_TIM_FLT_IRQn_IRQHandler,Default_Handler

	.weak	HRTIM_TIMF_IRQn_IRQHandler
	.thumb_set HRTIM_TIMF_IRQn_IRQHandler,Default_Handler

	.weak	CRS_IRQHandler
	.thumb_set CRS_IRQHandler,Default_Handler

	.weak	SAI_IRQHandler
	.thumb_set SAI_IRQHandler,Default_Handler

	.weak	TIM20_BRK_IRQHandler
	.thumb_set TIM20_BRK_IRQHandler,Default_Handler

	.weak	TIM20_UP_IRQHandler
	.thumb_set TIM20_UP_IRQHandler,Default_Handler

	.weak	TIM20_TRG_COM_IRQHandler
	.thumb_set TIM20_TRG_COM_IRQHandler,Default_Handler

	.weak	TIM20_CC_IRQHandler
	.thumb_set TIM20_CC_IRQHandler,Default_Handler

	.weak	FPU_IRQHandler
	.thumb_set FPU_IRQHandler,Default_Handler

	.weak	I2C4_EV_IRQHandler
	.thumb_set I2C4_EV_IRQHandler,Default_Handler

	.weak	I2C4_ER_IRQHandler
	.thumb_set I2C4_ER_IRQHandler,Default_Handler

	.weak	SPI4_IRQHandler
	.thumb_set SPI4_IRQHandler,Default_Handler

	.weak	FDCAN2_intr0_IRQHandler
	.thumb_set FDCAN2_intr0_IRQHandler,Default_Handler

	.weak	FDCAN2_intr1_IRQHandler
	.thumb_set FDCAN2_intr1_IRQHandler,Default_Handler

	.weak	FDCAN3_intr0_IRQHandler
	.thumb_set FDCAN3_intr0_IRQHandler,Default_Handler

	.weak	FDCAN3_intr1_IRQHandler
	.thumb_set FDCAN3_intr1_IRQHandler,Default_Handler

	.weak	RNG_IRQHandler
	.thumb_set RNG_IRQHandler,Default_Handler

	.weak	LPUART_IRQHandler
	.thumb_set LPUART_IRQHandler,Default_Handler

	.weak	I2C3_EV_IRQHandler
	.thumb_set I2C3_EV_IRQHandler,Default_Handler

	.weak	I2C3_ER_IRQHandler
	.thumb_set I2C3_ER_IRQHandler,Default_Handler

	.weak	DMAMUX_OVR_IRQHandler
	.thumb_set DMAMUX_OVR_IRQHandler,Default_Handler

	.weak	QUADSPI_IRQHandler
	.thumb_set QUADSPI_IRQHandler,Default_Handler

	.weak	DMA1_CH8_IRQHandler
	.thumb_set DMA1_CH8_IRQHandler,Default_Handler

	.weak	DMA2_CH6_IRQHandler
	.thumb_set DMA2_CH6_IRQHandler,Default_Handler

	.weak	DMA2_CH7_IRQHandler
	.thumb_set DMA2_CH7_IRQHandler,Default_Handler

	.weak	DMA2_CH8_IRQHandler
	.thumb_set DMA2_CH8_IRQHandler,Default_Handler

	.weak	Cordic_IRQHandler
	.thumb_set Cordic_IRQHandler,Default_Handler

	.weak	FMAC_IRQHandler
	.thumb_set FMAC_IRQHandler,Default_Handler

	.weak	SystemInit

/************************ (C) COPYRIGHT STMicroelectonics *****END OF FILE****/
