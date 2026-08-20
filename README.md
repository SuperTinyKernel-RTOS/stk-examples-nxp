# SuperTinyKernel™ RTOS examples for NXP MCUXpresso

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform: Arm Cortex-M](https://img.shields.io/badge/Platform-Arm%20Cortex--M-blue.svg)](https://developer.arm.com/ip-products/processors/cortex-m)

**SuperTinyKernel™ RTOS** (STK) is a high-performance, deterministic, bare-metal C++ real-time operating system designed for resource-constrained embedded systems.

> **Note:** This repository is related to examples configured exclusively for MCUXpresso. For details about SuperTinyKernel RTOS, visit its [project on GitHub](https://github.com/SuperTinyKernel-RTOS).

---

## 🛠 Getting Started with [MCUXpresso](https://www.nxp.com/design/design-center/software/development-software/mcuxpresso-software-and-tools-:MCUXPRESSO)

STK provides ready-to-use examples for popular development boards. Follow these steps to get up and running:

1.  **Clone the Repository:**
    ```bash
    git clone https://github.com/SuperTinyKernel-RTOS/stk-examples-nxp.git
    cd stk-examples-nxp
    ```

2.  **Initialize Dependencies:**
    Navigate to your chosen example folder and run the configuration script. This will automatically fetch the STK kernel and necessary HAL drivers.
    ```bash
    cd project/blinky-frdm-k66f
    python configure.py
    ```

3.  **Build & Flash:**
    Open or import the project to **MCUXpresso**, compile, and flash your board.

---

## 📂 Supported Examples

| Board              | Path                                             | Description                                                                  |
|:-------------------|:-------------------------------------------------|:-----------------------------------------------------------------------------|
| **FRDM-K66F**      | `project\blinky-frdm-k66f`                       | Basic LED toggle using STK C++ API.                                          |
| **MIMXRT1050-EVK** | `project\blinky-evkb-imxrt1050`                  | Basic LED toggle using STK C++ API.                                          |
| **MIMXRT1050-EVK** | `project\blinky_mpu-hard-evkb-imxrt1050`         | Advanced LED toggle example using security hardening with MPU.               |
| **FRDM-K66F**      | `project\blinky_c-frdm-k66f`                     | Basic LED toggle using STK C API.                                            |
| **FRDM-K66F**      | `stm\blinky_c-cmsis-rtos2-stm32f407g-disc1`      | Basic LED toggle using CMSIS-RTOS2 API via STK CMSIS-RTOS2 adapter.          |
| **FRDM-K66F**      | `stm\blinky_c-cmsis-rtos2-prio-stm32f407g-disc1` | Priority inheritance demo using CMSIS-RTOS2 API via STK CMSIS-RTOS2 adapter. |
| **FRDM-K66F**      | `stm\blinky_c-freertos-stm32f407g-disc1`         | Basic LED toggle using using FreeRTOS API via STK FreeRTOS adapter.          |

> **Note:** Using GCC/Eclipse? Examples for these environments are located in [STK Main Repo - Examples](https://github.com/SuperTinyKernel-RTOS/stk/tree/main/build/example/project).

> **Note:** Using MCUXpresso, or Arm Keil MDK/µVision, IAR EWARM? Examples for these environments are located in their [respective repositories](https://github.com/SuperTinyKernel-RTOS/).

---

## 🔗 Resources

* **Core:** [Repository](https://github.com/SuperTinyKernel-RTOS/stk)
* **Documentation:** [STK API](https://supertinykernel.org)
* **Issue Tracker:** [Report a bug](https://github.com/SuperTinyKernel-RTOS/stk-examples-nxp/issues)