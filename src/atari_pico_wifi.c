#include <osbind.h>
#include <stdint.h>

#define CART_DATA   (*(volatile uint8_t*)0xFA0000)
#define CART_STATUS (*(volatile uint8_t*)0xFA0002)
#define CART_CTRL   (*(volatile uint8_t*)0xFA0004)

#define CMD_WIFI_INIT   0x01
#define CMD_WIFI_STATUS 0x07

static void cart_write(uint8_t b) {
    while (!(CART_STATUS & 0x01)); /* TX ready */
    CART_DATA = b;
}

static uint8_t cart_read(void) {
    while (!(CART_STATUS & 0x02)); /* RX ready */
    return CART_DATA;
}

int pico_wifi_init(void) {
    cart_write(CMD_WIFI_INIT);
    cart_write(0x00); /* no payload */

    return cart_read(); /* 0 = OK */
}

int pico_wifi_status(void) {
    cart_write(CMD_WIFI_STATUS);
    cart_write(0x00);
    return cart_read();
}
