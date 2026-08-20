/*
 * GENERATED FILE - DO NOT EDIT
 * Copyright (c) 2008-2013 Code Red Technologies Ltd,
 * Copyright 2015, 2018-2019 NXP
 * (c) NXP Semiconductors 2013-2026
 * Generated linker script file for MIMXRT1052xxxxB
 * Created from linkscript.ldt by FMCreateLinkLibraries
 * Using Freemarker v2.3.30
 * MCUXpresso IDE v11.4.1 [Build 6260] [2021-09-15] on Aug 18, 2026, 11:18:07 PM
 */

INCLUDE "blinky_mpu-hard-evkb-imxrt1050_library.ld"
INCLUDE "blinky_mpu-hard-evkb-imxrt1050_memory.ld"

ENTRY(ResetISR)

SECTIONS
{
     /* Image Vector Table and Boot Data for booting from external flash */
    .boot_hdr : ALIGN(4)
    {
        FILL(0xff)
        __boot_hdr_start__ = ABSOLUTE(.) ;
        KEEP(*(.boot_hdr.conf))
        . = 0x1000 ;
        KEEP(*(.boot_hdr.ivt))
        . = 0x1020 ;
        KEEP(*(.boot_hdr.boot_data))
        . = 0x1030 ;
        KEEP(*(.boot_hdr.dcd_data))
        __boot_hdr_end__ = ABSOLUTE(.) ;
        . = 0x2000 ;
    } >BOARD_FLASH

    /* MAIN TEXT SECTION */
    .text : ALIGN(4)
    {
        FILL(0xff)
        __vectors_start__ = ABSOLUTE(.) ;
        KEEP(*(.isr_vector))
        /* Global Section Table */
        . = ALIGN(4) ;
        __section_table_start = .;
        __data_section_table = .;
        LONG(LOADADDR(.data));
        LONG(    ADDR(.data));
        LONG(  SIZEOF(.data));
        LONG(LOADADDR(.data_RAM2));
        LONG(    ADDR(.data_RAM2));
        LONG(  SIZEOF(.data_RAM2));
        LONG(LOADADDR(.data_RAM3));
        LONG(    ADDR(.data_RAM3));
        LONG(  SIZEOF(.data_RAM3));
        LONG(LOADADDR(.data_RAM4));
        LONG(    ADDR(.data_RAM4));
        LONG(  SIZEOF(.data_RAM4));
        LONG(LOADADDR(.data_RAM5));
        LONG(    ADDR(.data_RAM5));
        LONG(  SIZEOF(.data_RAM5));
        __data_section_table_end = .;
        __bss_section_table = .;
        LONG(    ADDR(.bss));
        LONG(  SIZEOF(.bss));
        LONG(    ADDR(.bss_RAM2));
        LONG(  SIZEOF(.bss_RAM2));
        LONG(    ADDR(.bss_RAM3));
        LONG(  SIZEOF(.bss_RAM3));
        LONG(    ADDR(.bss_RAM4));
        LONG(  SIZEOF(.bss_RAM4));
        LONG(    ADDR(.bss_RAM5));
        LONG(  SIZEOF(.bss_RAM5));
        __bss_section_table_end = .;
        __section_table_end = . ;
        /* End of Global Section Table */

        *(.after_vectors*)

    } > BOARD_FLASH

    .text : ALIGN(4)
    {
       *(.text*)
       *(.rodata .rodata.* .constdata .constdata.*)
       . = ALIGN(4);
            /* C++ constructors etc */
            . = ALIGN(4);
            KEEP(*(.init))
            
            . = ALIGN(4);
            __preinit_array_start = .;
            KEEP (*(.preinit_array))
            __preinit_array_end = .;
            
            . = ALIGN(4);
            __init_array_start = .;
            KEEP (*(SORT(.init_array.*)))
            KEEP (*(.init_array))
            __init_array_end = .;
            
            KEEP(*(.fini));
            
            . = ALIGN(4);
            KEEP (*crtbegin.o(.ctors))
            KEEP (*(EXCLUDE_FILE (*crtend.o) .ctors))
            KEEP (*(SORT(.ctors.*)))
            KEEP (*crtend.o(.ctors))
            
            . = ALIGN(4);
            KEEP (*crtbegin.o(.dtors))
            KEEP (*(EXCLUDE_FILE (*crtend.o) .dtors))
            KEEP (*(SORT(.dtors.*)))
            KEEP (*crtend.o(.dtors))
            . = ALIGN(4);
            /* End C++ */
    } > BOARD_FLASH
    /*
     * for exception handling/unwind - some Newlib functions (in common
     * with C++ and STDC++) use this.
     */
    .ARM.extab : ALIGN(4)
    {
        *(.ARM.extab* .gnu.linkonce.armextab.*)
    } > BOARD_FLASH

    .ARM.exidx : ALIGN(4)
    {
        __exidx_start = .;
        *(.ARM.exidx* .gnu.linkonce.armexidx.*)
        __exidx_end = .;
    } > BOARD_FLASH

    /* ======================================================================== */
    /* STK MPU: SHARED CODE WINDOW (BOARD_FLASH, RO+exec, priv+user)            */
    /* ARMv7-M (PMSAv7) requires the MPU region size to be a power of two, with */
    /* the base address naturally aligned to that same size - unlike PMSAv8,   */
    /* this section cannot just be sized to its actual content. It is padded   */
    /* out to a fixed, tunable window instead; the unused tail is just inert   */
    /* padding still covered by the region.                                    */
    /*                                                                          */
    /* STK_MPU_SHARED_CODE_WINDOW must equal the .size passed for this region  */
    /* in OnConfigureMpu() - not (end - start) as on PMSAv8 targets. Re-tune to */
    /* the smallest power of two that fits once real content size is known     */
    /* from the map file; add a STK_STATIC_ASSERT on the C++ side against the  */
    /* true __stk_mpu_shared_code_end - __stk_mpu_shared_code_start to catch   */
    /* silent overflow into the next section if it ever grows past this.       */
    /* ======================================================================== */
    STK_MPU_SHARED_CODE_WINDOW = 4K;
    .stk_mpu_shared_code : ALIGN(STK_MPU_SHARED_CODE_WINDOW)
    {
        __stk_mpu_shared_code_start = .;
        *(.stk_mpu_shared_code .stk_mpu_shared_code.*)
        . = __stk_mpu_shared_code_start + STK_MPU_SHARED_CODE_WINDOW;
        __stk_mpu_shared_code_end = .;
    } > BOARD_FLASH
    /* ======================================================================== */

    /* ======================================================================== */
    /* STK MPU: KERNEL-ONLY CODE WINDOW (BOARD_FLASH, RO+exec, priv-only)       */
    /* Same power-of-two padding requirement as above. Holds OnSchedulerSleep/  */
    /* OnSchedulerSleepOverride/OnSchedulerExit - reachable only via the        */
    /* kernel's own internal sleep/exit trap stacks, never a real task.        */
    /* ======================================================================== */
    STK_MPU_KERNEL_CODE_WINDOW = 2K;
    .stk_mpu_kernel_code : ALIGN(STK_MPU_KERNEL_CODE_WINDOW)
    {
        __stk_mpu_kernel_code_start = .;
        *(.stk_mpu_kernel_code .stk_mpu_kernel_code.*)
        . = __stk_mpu_kernel_code_start + STK_MPU_KERNEL_CODE_WINDOW;
        __stk_mpu_kernel_code_end = .;
    } > BOARD_FLASH
    /* ======================================================================== */
 
    _etext = .;
        
    /* DATA section for SRAM_ITC */

    .data_RAM2 : ALIGN(4)
    {
        FILL(0xff)
        PROVIDE(__start_data_RAM2 = .) ;
        PROVIDE(__start_data_SRAM_ITC = .) ;
        *(.ramfunc.$RAM2)
        *(.ramfunc.$SRAM_ITC)
        *(.data.$RAM2)
        *(.data.$SRAM_ITC)
        *(.data.$RAM2.*)
        *(.data.$SRAM_ITC.*)
        . = ALIGN(4) ;
        PROVIDE(__end_data_RAM2 = .) ;
        PROVIDE(__end_data_SRAM_ITC = .) ;
     } > SRAM_ITC AT>BOARD_FLASH

    /* DATA section for SRAM_OC */

    .data_RAM3 : ALIGN(4)
    {
        FILL(0xff)
        PROVIDE(__start_data_RAM3 = .) ;
        PROVIDE(__start_data_SRAM_OC = .) ;
        *(.ramfunc.$RAM3)
        *(.ramfunc.$SRAM_OC)
        *(.data.$RAM3)
        *(.data.$SRAM_OC)
        *(.data.$RAM3.*)
        *(.data.$SRAM_OC.*)
        . = ALIGN(4) ;
        PROVIDE(__end_data_RAM3 = .) ;
        PROVIDE(__end_data_SRAM_OC = .) ;
     } > SRAM_OC AT>BOARD_FLASH

    /* DATA section for BOARD_SDRAM */

    .data_RAM4 : ALIGN(4)
    {
        FILL(0xff)
        PROVIDE(__start_data_RAM4 = .) ;
        PROVIDE(__start_data_BOARD_SDRAM = .) ;
        *(.ramfunc.$RAM4)
        *(.ramfunc.$BOARD_SDRAM)
        *(.data.$RAM4)
        *(.data.$BOARD_SDRAM)
        *(.data.$RAM4.*)
        *(.data.$BOARD_SDRAM.*)
        . = ALIGN(4) ;
        PROVIDE(__end_data_RAM4 = .) ;
        PROVIDE(__end_data_BOARD_SDRAM = .) ;
     } > BOARD_SDRAM AT>BOARD_FLASH

    /* DATA section for NCACHE_REGION */

    .data_RAM5 : ALIGN(4)
    {
        FILL(0xff)
        PROVIDE(__start_data_RAM5 = .) ;
        PROVIDE(__start_data_NCACHE_REGION = .) ;
        *(.ramfunc.$RAM5)
        *(.ramfunc.$NCACHE_REGION)
        *(.data.$RAM5)
        *(.data.$NCACHE_REGION)
        *(.data.$RAM5.*)
        *(.data.$NCACHE_REGION.*)
        . = ALIGN(4) ;
        PROVIDE(__end_data_RAM5 = .) ;
        PROVIDE(__end_data_NCACHE_REGION = .) ;
     } > NCACHE_REGION AT>BOARD_FLASH

    /* MAIN DATA SECTION */
    .uninit_RESERVED (NOLOAD) : ALIGN(4)
    {
        _start_uninit_RESERVED = .;
        KEEP(*(.bss.$RESERVED*))
       . = ALIGN(4) ;
        _end_uninit_RESERVED = .;
    } > SRAM_DTC AT> SRAM_DTC

    /* Main DATA section (SRAM_DTC) */
    .data : ALIGN(4)
    {
       FILL(0xff)
       _data = . ;
       PROVIDE(__start_data_RAM = .) ;
       PROVIDE(__start_data_SRAM_DTC = .) ;
       *(vtable)
       *(.ramfunc*)
       KEEP(*(CodeQuickAccess))
       KEEP(*(DataQuickAccess))
       *(RamFunction)
       *(.data*)
       . = ALIGN(4) ;
       _edata = . ;
       PROVIDE(__end_data_RAM = .) ;
       PROVIDE(__end_data_SRAM_DTC = .) ;
    } > SRAM_DTC AT>BOARD_FLASH

    /* BSS section for SRAM_ITC */
    .bss_RAM2 : ALIGN(4)
    {
       PROVIDE(__start_bss_RAM2 = .) ;
       PROVIDE(__start_bss_SRAM_ITC = .) ;
       *(.bss.$RAM2)
       *(.bss.$SRAM_ITC)
       *(.bss.$RAM2.*)
       *(.bss.$SRAM_ITC.*)
       . = ALIGN (. != 0 ? 4 : 1) ; /* avoid empty segment */
       PROVIDE(__end_bss_RAM2 = .) ;
       PROVIDE(__end_bss_SRAM_ITC = .) ;
    } > SRAM_ITC AT> SRAM_ITC

    /* BSS section for SRAM_OC */
    .bss_RAM3 : ALIGN(4)
    {
       PROVIDE(__start_bss_RAM3 = .) ;
       PROVIDE(__start_bss_SRAM_OC = .) ;
       *(.bss.$RAM3)
       *(.bss.$SRAM_OC)
       *(.bss.$RAM3.*)
       *(.bss.$SRAM_OC.*)
       . = ALIGN (. != 0 ? 4 : 1) ; /* avoid empty segment */
       PROVIDE(__end_bss_RAM3 = .) ;
       PROVIDE(__end_bss_SRAM_OC = .) ;
    } > SRAM_OC AT> SRAM_OC

    /* BSS section for BOARD_SDRAM */
    .bss_RAM4 : ALIGN(4)
    {
       PROVIDE(__start_bss_RAM4 = .) ;
       PROVIDE(__start_bss_BOARD_SDRAM = .) ;
       *(.bss.$RAM4)
       *(.bss.$BOARD_SDRAM)
       *(.bss.$RAM4.*)
       *(.bss.$BOARD_SDRAM.*)
       . = ALIGN (. != 0 ? 4 : 1) ; /* avoid empty segment */
       PROVIDE(__end_bss_RAM4 = .) ;
       PROVIDE(__end_bss_BOARD_SDRAM = .) ;
    } > BOARD_SDRAM AT> BOARD_SDRAM

    /* BSS section for NCACHE_REGION */
    .bss_RAM5 : ALIGN(4)
    {
       PROVIDE(__start_bss_RAM5 = .) ;
       PROVIDE(__start_bss_NCACHE_REGION = .) ;
       *(.bss.$RAM5)
       *(.bss.$NCACHE_REGION)
       *(.bss.$RAM5.*)
       *(.bss.$NCACHE_REGION.*)
       . = ALIGN (. != 0 ? 4 : 1) ; /* avoid empty segment */
       PROVIDE(__end_bss_RAM5 = .) ;
       PROVIDE(__end_bss_NCACHE_REGION = .) ;
    } > NCACHE_REGION AT> NCACHE_REGION

    /* MAIN BSS SECTION */
    .bss : ALIGN(4)
    {
        _bss = .;
        PROVIDE(__start_bss_RAM = .) ;
        PROVIDE(__start_bss_SRAM_DTC = .) ;
        *(.bss*)
        *(COMMON)
        . = ALIGN(4) ;
        _ebss = .;
        PROVIDE(__end_bss_RAM = .) ;
        PROVIDE(__end_bss_SRAM_DTC = .) ;
        PROVIDE(end = .);
    } > SRAM_DTC AT> SRAM_DTC

    /* ======================================================================== */
    /* STK MPU: SHARED DATA/BSS WINDOW (SRAM_DTC, RW+XN, priv+user)             */
    /* One combined power-of-two window covering both the initialized and      */
    /* zero-initialized halves, matching the single MPU region OnConfigureMpu()  */
    /* will map over [__stk_mpu_shared_data_start, __stk_mpu_shared_bss_end).  */
    /* As with the code windows above, .size in that table must equal          */
    /* STK_MPU_SHARED_RAM_WINDOW exactly, not the actual content span.         */
    /* Placed in SRAM_DTC (DTCM): zero-wait-state, cache-transparent on the    */
    /* M7, which keeps scheduler-adjacent shared state deterministic.          */
    /* ======================================================================== */
    STK_MPU_SHARED_RAM_WINDOW = 4K;
    .stk_mpu_shared_data : ALIGN(STK_MPU_SHARED_RAM_WINDOW)
    {
        __stk_mpu_shared_data_start = .;
        *(.stk_mpu_shared_data .stk_mpu_shared_data.*)
        . = ALIGN(4);
        __stk_mpu_shared_data_end = .;
    } > SRAM_DTC AT> BOARD_FLASH

    __stk_mpu_shared_data_source__ = LOADADDR(.stk_mpu_shared_data);

    .stk_mpu_shared_bss : ALIGN(4)
    {
        __stk_mpu_shared_bss_start = .;
        *(.stk_mpu_shared_bss .stk_mpu_shared_bss.*)
        . = __stk_mpu_shared_data_start + STK_MPU_SHARED_RAM_WINDOW;
        __stk_mpu_shared_bss_end = .;
    } > SRAM_DTC
    /* ======================================================================== */

    /* ======================================================================== */
    /* STK MPU: KERNEL-ONLY DATA/BSS WINDOW (SRAM_DTC, RW+XN, priv-only)        */
    /* Holds s_StkPlatformContext, g_SecureCounter, s_StkSpinlockTimeoutIters,  */
    /* s_StkCortexmCsuLock, g_LastPanicId - mapped ACCESS_PRIV_RW_USER_NO, no   */
    /* unprivileged access at all. Same combined-window / fixed-size rule as   */
    /* the shared window above.                                                */
    /*                                                                          */
    /* Sized 8K rather than 2K after a link-time overflow (measured ~4220 bytes with only     */
    /* s_StkPlatformContext/g_SecureCounter/s_StkSpinlockTimeoutIters/s_StkCortexmCsuLock/     */
    /* g_LastPanicId tagged). Three more kernel-private statics were found and tagged after    */
    /* that measurement - the fault-context scratch buffer (which carries its own              */
    /* Region regions[STK_CORTEX_M_MPU_REGIONS_MAX] shadow table, 16 entries on this board)    */
    /* and the two HiResClock singletons - so re-verify actual usage against the .map file      */
    /* after rebuilding; shrink to the next power of two that fits with margin if 8K proves    */
    /* overly generous, or bump further if it still overflows.                                */
    /* ======================================================================== */
    STK_MPU_KERNEL_RAM_WINDOW = 8K;
    .stk_mpu_kernel_data : ALIGN(STK_MPU_KERNEL_RAM_WINDOW)
    {
        __stk_mpu_kernel_data_start = .;
        *(.stk_mpu_kernel_data .stk_mpu_kernel_data.*)
        . = ALIGN(4);
        __stk_mpu_kernel_data_end = .;
    } > SRAM_DTC AT> BOARD_FLASH

    __stk_mpu_kernel_data_source__ = LOADADDR(.stk_mpu_kernel_data);

    .stk_mpu_kernel_bss : ALIGN(4)
    {
        __stk_mpu_kernel_bss_start = .;
        *(.stk_mpu_kernel_bss .stk_mpu_kernel_bss.*)
        . = __stk_mpu_kernel_data_start + STK_MPU_KERNEL_RAM_WINDOW;
        __stk_mpu_kernel_bss_end = .;
    } > SRAM_DTC
    /* ======================================================================== */


    /* NOINIT section for SRAM_ITC */
    .noinit_RAM2 (NOLOAD) : ALIGN(4)
    {
       PROVIDE(__start_noinit_RAM2 = .) ;
       PROVIDE(__start_noinit_SRAM_ITC = .) ;
       *(.noinit.$RAM2)
       *(.noinit.$SRAM_ITC)
       *(.noinit.$RAM2.*)
       *(.noinit.$SRAM_ITC.*)
       . = ALIGN(4) ;
       PROVIDE(__end_noinit_RAM2 = .) ;
       PROVIDE(__end_noinit_SRAM_ITC = .) ;
    } > SRAM_ITC AT> SRAM_ITC

    /* NOINIT section for SRAM_OC */
    .noinit_RAM3 (NOLOAD) : ALIGN(4)
    {
       PROVIDE(__start_noinit_RAM3 = .) ;
       PROVIDE(__start_noinit_SRAM_OC = .) ;
       *(.noinit.$RAM3)
       *(.noinit.$SRAM_OC)
       *(.noinit.$RAM3.*)
       *(.noinit.$SRAM_OC.*)
       . = ALIGN(4) ;
       PROVIDE(__end_noinit_RAM3 = .) ;
       PROVIDE(__end_noinit_SRAM_OC = .) ;
    } > SRAM_OC AT> SRAM_OC

    /* NOINIT section for BOARD_SDRAM */
    .noinit_RAM4 (NOLOAD) : ALIGN(4)
    {
       PROVIDE(__start_noinit_RAM4 = .) ;
       PROVIDE(__start_noinit_BOARD_SDRAM = .) ;
       *(.noinit.$RAM4)
       *(.noinit.$BOARD_SDRAM)
       *(.noinit.$RAM4.*)
       *(.noinit.$BOARD_SDRAM.*)
       . = ALIGN(4) ;
       PROVIDE(__end_noinit_RAM4 = .) ;
       PROVIDE(__end_noinit_BOARD_SDRAM = .) ;
    } > BOARD_SDRAM AT> BOARD_SDRAM

    /* NOINIT section for NCACHE_REGION */
    .noinit_RAM5 (NOLOAD) : ALIGN(4)
    {
       PROVIDE(__start_noinit_RAM5 = .) ;
       PROVIDE(__start_noinit_NCACHE_REGION = .) ;
       *(.noinit.$RAM5)
       *(.noinit.$NCACHE_REGION)
       *(.noinit.$RAM5.*)
       *(.noinit.$NCACHE_REGION.*)
       . = ALIGN(4) ;
       PROVIDE(__end_noinit_RAM5 = .) ;
       PROVIDE(__end_noinit_NCACHE_REGION = .) ;
    } > NCACHE_REGION AT> NCACHE_REGION

    /* DEFAULT NOINIT SECTION */
    .noinit (NOLOAD): ALIGN(4)
    {
        _noinit = .;
        PROVIDE(__start_noinit_RAM = .) ;
        PROVIDE(__start_noinit_SRAM_DTC = .) ;
        *(.noinit*)
         . = ALIGN(4) ;
        _end_noinit = .;
       PROVIDE(__end_noinit_RAM = .) ;
       PROVIDE(__end_noinit_SRAM_DTC = .) ;        
    } > SRAM_DTC AT> SRAM_DTC

    /* Reserve and place Heap within memory map */
    _HeapSize = 0x1000;
    .heap :  ALIGN(4)
    {
        _pvHeapStart = .;
        . += _HeapSize;
        . = ALIGN(4);
        _pvHeapLimit = .;
    } > SRAM_DTC

     _StackSize = 0x1000;
     /* Reserve space in memory for Stack */
    .heap2stackfill  :
    {
        . += _StackSize;
    } > SRAM_DTC
    /* Locate actual Stack in memory map */
    .stack ORIGIN(SRAM_DTC) + LENGTH(SRAM_DTC) - _StackSize - 0:  ALIGN(4)
    {
        _vStackBase = .;
        . = ALIGN(4);
        _vStackTop = . + _StackSize;
    } > SRAM_DTC

    /* STK MPU: MSP/exception stack. No new placement needed - _vStackBase/_vStackTop
       above already sit at ORIGIN(SRAM_DTC)+LENGTH(SRAM_DTC)-_StackSize, which for
       _StackSize=0x1000 is already 4K-aligned (0x2001F000) - naturally power-of-two
       for PMSAv7 as-is. These are just stk_mpu_*-named aliases for consistency with
       OnConfigureMpu(). */
    PROVIDE(__stk_mpu_msp_stack_start = _vStackBase);
    PROVIDE(__stk_mpu_msp_stack_end   = _vStackTop);

    /* Provide basic symbols giving location and size of main text
     * block, including initial values of RW data sections. Note that
     * these will need extending to give a complete picture with
     * complex images (e.g multiple Flash banks).
     */
    _image_start = LOADADDR(.text);
    _image_end = LOADADDR(.data) + SIZEOF(.data);
    _image_size = _image_end - _image_start;
}