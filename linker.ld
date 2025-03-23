/* 定义内存区域 */
MEMORY {
    FLASH (rx) : ORIGIN = 0x08000000, LENGTH = 1M   /* STM32F407 Flash */
    RAM (rwx)  : ORIGIN = 0x20000000, LENGTH = 128K  /* STM32F407 RAM */
}

/* 段分配 */
SECTIONS {
    .isr_vector : {
        . = ALIGN(4);
        KEEP(*(.isr_vector))
        . = ALIGN(4);
    } >FLASH

    .text : {
        . = ALIGN(4);
        *(.text)
        *(.text*)
        . = ALIGN(4);
        _etext = .;
    } >FLASH

    .data : {
        _sdata = .;
        *(.data)
        *(.data*)
        . = ALIGN(4);
        _edata = .;
    } >RAM AT>FLASH

    .bss : {
        _sbss = .;
        *(.bss)
        *(.bss*)
        . = ALIGN(4);
        _ebss = .;
    } >RAM

    /* 栈与堆定义 */
    _estack = ORIGIN(RAM) + LENGTH(RAM);
}
