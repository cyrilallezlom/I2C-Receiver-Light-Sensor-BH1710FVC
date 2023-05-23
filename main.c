
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <time.h>
#include <sys/mman.h>
#include <stdbool.h>
#include "mmap_hw_regs.h"
#include "led.h"
#include "dipsw_pio.h"
#include "key_pio.h"
#include "led_gpio.h"
#include "key_gpio.h"
#include "driver.h"

#include "pio_reg_in.h"
#include "pio_reg_inout.h"
//#include "pio_reg_out.h"

#include "DRIVER_read.h"



int main(int argc, char **argv) {
	MMAP_open();
	LEDR_setup();
	DIPSW_setup();
	KEY_PIO_setup();
	LED_gpio_setup();
	KEY_gpio_setup();
	DRIVER_setup();
	
	printf("test\n");

	float temp = 0;
	while(1) {
		temp = DRIVER_readTemp();

		printf("hello world, value: %f \n", temp);
	}
	MMAP_close();
	
	return 0;
}
