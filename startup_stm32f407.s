.syntax unified
.cpu cortex-m4
.fpu softvfp
.thumb

.global g_pfnVectors
.global Default_Handler

/* 堆栈定义 */
.equ  Stack_Size, 0x400
.section .stack
.align 3
.space Stack_Size

/* 堆定义 */
.equ  Heap_Size, 0x200
.section .heap
.align 3
.space Heap_Size

/* 向量表 */
.section .isr_vector
.align 2
g_pfnVectors:
    .word  _estack                  /* 栈顶地址 */
    .word  Reset_Handler            /* 复位向量 */
    .word  NMI_Handler              /* NMI处理 */
    .word  HardFault_Handler        /* 硬件错误处理 */
    /* ... 其他中断向量（可根据需求补充） */
    .word  0                        /* 结尾 */

/* 复位处理函数 */
.section .text.Reset_Handler
.weak Reset_Handler
.type Reset_Handler, %function
Reset_Handler:
    ldr   sp, =_estack     /* 初始化栈指针 */
    bl    SystemInit       /* 系统初始化（需用户实现） */
    bl    main             /* 跳转至主程序 */
    b     .                /* 循环 */

/* 默认中断处理 */
.weak Default_Handler
.type Default_Handler, %function
Default_Handler:
    b .

/* 中断处理别名 */
.weak NMI_Handler
.set NMI_Handler, Default_Handler
.weak HardFault_Handler
.set HardFault_Handler, Default_Handler

/* 程序入口 */
.thumb_func
.section .text.main
