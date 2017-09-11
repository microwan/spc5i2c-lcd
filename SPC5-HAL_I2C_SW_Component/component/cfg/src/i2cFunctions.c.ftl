[#ftl]
[@pp.dropOutputFile /]
[@pp.changeOutputFile name="i2cFunctions.c" /]
[#if conf.instance.i2c_settings.io_settings_mapping.sda.value[0] != ""]
	[#assign sda = conf.instance.i2c_settings.io_settings_mapping.sda.value[0] ]
[#else]
	[#assign sda = "error unknown pin identifier for I2C pin SDA"]
[/#if]
[#if conf.instance.i2c_settings.io_settings_mapping.scl.value[0] != ""]
	[#assign scl = conf.instance.i2c_settings.io_settings_mapping.scl.value[0] ]
[#else]
	[#assign scl = "error unknown pin identifier for I2C pin SCL"]
[/#if]
/* * i2cFunctions.c
 *
 */

#include "components.h"
#include "i2cFunctions.h"


void delayOneMicroSec(void) {
	unsigned int i;
	for (i = 0; i < 12; i++)
		asm volatile("nop" : : : "memory");
}

void delayTwoMicroSec(void) {
	unsigned int i;
	for (i = 0; i < 24; i++)
		asm volatile("nop" : : : "memory");
}
void delayThreeMicroSec(void) {
	unsigned int i;
	for (i = 0; i < 54; i++)
		asm volatile("nop" : : : "memory");
}

void delayFiveMicroSec(void) {
	unsigned int i;
	for (i = 0; i < 78; i++)
		asm volatile("nop" : : : "memory");
}

void i2cStart(void) {
	// i2c start bit sequence
	pal_clearpad(I2C_PORT_SCL, ${scl}); //SCL=0 modif iris
	delayFiveMicroSec();
	pal_setpad(I2C_PORT_SDA, ${sda});        //SDA=1
	pal_setpad(I2C_PORT_SCL, ${scl});  //SCL=1
	delayFiveMicroSec();
	pal_clearpad(I2C_PORT_SDA, ${sda}); //SDA=0
	delayFiveMicroSec();
	pal_clearpad(I2C_PORT_SCL, ${scl}); //SCL=0
	delayFiveMicroSec();
}

void i2cStop(void) {
	// i2c stop bit sequence
	pal_clearpad(I2C_PORT_SCL, ${scl}); //SCL=0
	pal_clearpad(I2C_PORT_SDA, ${sda});    //SDA=0
	delayFiveMicroSec();
	pal_setpad(I2C_PORT_SCL, ${scl}); //SCL=1
	delayFiveMicroSec();
	pal_setpad(I2C_PORT_SDA, ${sda}); //SDA=1
	delayFiveMicroSec();
}

bool i2cTx(unsigned char d) {
	char x;
	static unsigned char InputParam;
	static bool b = false;
	InputParam = d;
	for (x = 8; x; x--) {

		// Clock off
		pal_clearpad(I2C_PORT_SCL, ${scl}); //SCL=0
		// Test SDA bit
		if (InputParam & 0x80)
			pal_setpad(I2C_PORT_SDA, ${sda}); //SDA=1
		else
			pal_clearpad(I2C_PORT_SDA, ${sda}); //SDA=0
		delayFiveMicroSec();
		// Clock on
		pal_setpad(I2C_PORT_SCL, ${scl}); //SCL=1
		delayFiveMicroSec();
		do {

		} while (pal_readpad(I2C_PORT_SCL, ${scl}) == 0); // wait for any SCL clock stretching
		InputParam <<= 1;
	}

	// Clock off
	pal_clearpad(I2C_PORT_SCL, ${scl}); //SCL=0
	pal_setpad(I2C_PORT_SDA, ${sda}); //SDA=1
	delayFiveMicroSec();
	pal_setpad(I2C_PORT_SCL, ${scl}); //SCL=1
	delayFiveMicroSec();
	do {

	} while (pal_readpad(I2C_PORT_SCL, ${scl}) == 0); // wait for any SCL clock stretching
	// read acknowledge bit
	b = (pal_readpad(I2C_PORT_SDA, ${sda}) == 0);
	pal_clearpad(I2C_PORT_SCL, ${scl}); //SCL=0
	pal_clearpad(I2C_PORT_SDA, ${sda}); //SDA=0 modif iris
	delayFiveMicroSec();
	return b;
}

unsigned char i2cRx() {
	char x, d = 0;

	pal_clearpad(I2C_PORT_SCL, ${scl}); //SCL=0
	delayFiveMicroSec();
	pal_setpad(I2C_PORT_SDA, ${sda}); //SDA=1
	for (x = 0; x < 8; x++) {
		d <<= 1;
		// Clock off
		pal_clearpad(I2C_PORT_SCL, ${scl}); //SCL=0

		delayFiveMicroSec();
		pal_setpad(I2C_PORT_SCL, ${scl}); //SCL=1
		do {

		} while (pal_readpad(I2C_PORT_SCL, ${scl}) == 0); // wait for any SCL clock stretching
		delayThreeMicroSec();
		if (pal_readpad(I2C_PORT_SDA, ${sda}))
			d |= 1;
		delayTwoMicroSec();
	}

	// Clock off
	pal_clearpad(I2C_PORT_SCL, ${scl}); //SCL=0

	/*if(ack) pal_clearpad(I2C_PORT_SDA, ${sda});
	 else pal_setpad(I2C_PORT_SDA, ${sda});*/
	pal_clearpad(I2C_PORT_SDA, ${sda});
	delayFiveMicroSec();
	pal_setpad(I2C_PORT_SCL, ${scl}); //SCL=1
	delayFiveMicroSec();
	pal_clearpad(I2C_PORT_SCL, ${scl}); //SCL=0
	return d;
}

// Some example functions to be used with specific hardware for testing.

// Uncomment all if needed

/* Samples

 // Arduino

 // This function is used in junction with an arduino
 // running the I2C_receiver sketch
 // A string is sent to arduino.

 void write2Slave (void)
 {
 i2cStart();
 i2cTx (0x08); // Call arduino I2C slave at address 4.
 i2cTx (0x46); // F
 i2cTx (0x34); // 4
 i2cTx (0x48); // H
 i2cTx (0x47); // G
 i2cTx (0x41); // A
 i2cTx (0x20); // sp
 i2cTx (0x37); // 7
 i2cTx (0x33); // 3
 i2cTx (0x0D); // CR
 i2cTx (0x0A);// LF
 i2cStop();
 }

 // This function is used in junction with an arduino
 // running the I2C_sender sketch
 // A request for read is sent to the arduino.
 // Then the result is acquired in myString

 void readFromSlave (void)
 {
 int i=0;
 char myString [9];
 // Uncomment this part if restart condition is needed.
 // This is not the case for arduino skectch demo
 //i2cStart();
 //i2cTx (0x04); // Call arduino I2C slave at address 2.
 //i2cTx (0x06); // Request 7 bytes.
 i2cStart(); // Restart sequence
 i2cTx (0x05); // Call arduino I2C slave at address 2. (rw bit set)
 for (i=0;i<8;i++)
 {
 myString [i]=i2cRx();
 }
 myString [8] = 0; // End of string
 i2cStop();
 //chprintf((BaseSequentialStream *)&SD1, "%s",myString);

 }

 // PCF8574 chip
 // The chip is configured with I2C adress equal to 32 (A0,A1,A2 to GND)
 // Port 4 has a led attached with a resistor.
 // Port 3 has a push botton attached to GND

 // Turn on P4 led
 void switchOnP4A32 (void)
 {
 i2cStart();
 i2cTx (0x40); // Call PCF8574P @ 32
 i2cTx (0x10); // Turn on P4
 i2cStop();
 }

 // Turn off P4 led
 void switchOffP4A32 (void)
 {
 i2cStart();
 i2cTx (0x40); // Call PCF8574P @ 32
 i2cTx (0x00); // Turn off P4
 i2cStop();
 }

 // Read ports status.

 unsigned char readPorts (void)
 {
 unsigned char status;
 i2cStart();
 i2cTx (0x41); // Call PCF8574P @ 32
 status=i2cRx(); // Read P3 status
 i2cStop();
 return status;
 }

 Samples */

