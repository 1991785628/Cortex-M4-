#include <stdint.h>

// 简单延时函数
void delay(uint32_t count) {
    for (volatile uint32_t i = 0; i < count; i++);
}

// 主程序
int main(void) {
    // 假设LED连接在GPIOA Pin5（需根据硬件修改）
    volatile uint32_t *RCC_AHB1ENR = (uint32_t*)0x40023830;
    volatile uint32_t *GPIOA_MODER = (uint32_t*)0x40020000;
    volatile uint32_t *GPIOA_ODR   = (uint32_t*)0x40020014;

    // 使能GPIOA时钟
    *RCC_AHB1ENR |= 0x01;

    // 配置PA5为输出模式
    *GPIOA_MODER &= ~(0x03 << 10); // 清除原有配置
    *GPIOA_MODER |=  (0x01 << 10); // 设置为输出模式

    // LED闪烁
    while (1) {
        *GPIOA_ODR ^= (1 << 5); // 翻转PA5电平
        delay(1000000);
    }
}
