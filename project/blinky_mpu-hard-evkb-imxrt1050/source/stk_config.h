/*
 * SuperTinyKernel(TM) (STK): Lightweight High-Performance Deterministic C++ RTOS for Embedded Systems.
 *
 * Source: https://github.com/SuperTinyKernel-RTOS
 *
 * Copyright (c) 2022-2026 Neutron Code Limited <stk@neutroncode.com>. All Rights Reserved.
 * License: MIT License, see LICENSE for a full text.
 */

#ifndef STK_CONFIG_H_
#define STK_CONFIG_H_

#include "MIMXRT1052.h"
#include "core_cm7.h"

// ARM Cortex-M7 platform
#define _STK_ARCH_ARM_CORTEX_M

// Enable MPU support
#define STK_MPU              (1U)
#define STK_MPU_STACK_GUARD  (1U)
#define STK_MPU_TASK_REGIONS (4U)

// Disable stack guard because access to background memory is disabled in this example, we rely on MPU stack guard (STK_MPU_STACK_GUARD=1)
#define STK_STACK_GUARD      (0U)

// i.MX RT1050 supports 16 MPU regions
#define STK_CORTEX_M_MPU_REGIONS_MAX (16U)

// Let STK process MemManage and HardFault ISRs
#define STK_USE_MEMMANAGE_HANDLER (1U)
#define STK_USE_HARDFAULT_HANDLER (1U)

// Redefine assert to own handler
//#define _STK_ASSERT_REDIRECT

#endif /* STK_CONFIG_H_ */
