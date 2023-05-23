#include "DRIVER_read.h"
#include "pio_reg_in.h"
#include "pio_reg_inout.h"

#define RESOLUTION 0.0625
float DRIVER_readTemp() {
   unsigned int firstByte = PIO_REG_IN_read();
   unsigned int secondByte = PIO_REG_INOUT_read();
   int intPart;
   int decPart;

   if (firstByte <= 127)
	intPart = (int)firstByte;
   else
	intPart = -(int)~firstByte - 1;


   if (secondByte <= 127)
	decPart = (int)secondByte;
   else
	decPart = -(int)~secondByte - 1;


   
   float temp = intPart;
   temp += decPart*RESOLUTION;
   
   return temp;
}
