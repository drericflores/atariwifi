#include "pico/stdlib.h"
#include "hardware/spi.h"
#include "lwip/tcp.h"
#include "pico/cyw43_arch.h"

static void handle_command(uint8_t cmd) {
    switch (cmd) {
        case 0x01: /* INIT WIFI */
            cyw43_arch_init();
            cyw43_arch_enable_sta_mode();
            // reply OK
            break;

        case 0x07: /* STATUS */
            // return WiFi status byte
            break;
    }
}

int main() {
    stdio_init_all();
    cyw43_arch_init();

    while (1) {
        uint8_t cmd = spi_read_blocking(spi0, 0x00, &cmd, 1);
        handle_command(cmd);
    }
}
