# Cortex-M4 Bare Metal Template

基于ARM Cortex-M4的裸机开发模板，适用于STM32F4系列芯片。包含启动文件、链接脚本及示例代码。

## 功能
- 启动文件（`startup_stm32f407.s`）：初始化堆栈、向量表、跳转至主程序。
- 链接脚本（`linker.ld`）：定义Flash与RAM内存布局。
- 示例代码（`main.c`）：实现LED闪烁功能。

## 使用说明
1. **编译工具链**：需安装ARM GCC工具链（如 `arm-none-eabi-gcc`）。
2. **编译命令**：
   ```bash
   arm-none-eabi-gcc -mcpu=cortex-m4 -T linker.ld -nostartfiles startup/*.c src/*.c -o firmware.elf
   arm-none-eabi-objcopy -O binary firmware.elf firmware.bin
