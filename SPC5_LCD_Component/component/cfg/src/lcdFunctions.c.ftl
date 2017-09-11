[#ftl]
[@pp.dropOutputFile /]
[@pp.changeOutputFile name="lcdFunctions.c" /]


/* * lcdFunctions.c
 *
 */

#include "components.h"
#include "lcdFunctions.h"
[#list conf.instance.lcd_settings.working_mode as group]
 [#assign size = group.matrix_size.value[0] /]
 [#assign rows = group.number_of_rows[0] /]
 [#assign mode = group.transfer_mode.value[0] /]
 [#assign i2ccomp = group.i2c_component.value[0] /]

 [#if mode=="i2c"]
 #include "i2cFunctions.h"
 
 unsigned char i2cByte=0; // Global i2c byte used by PCF8574 port expander.

void i2c2Lcd(void) {
	i2cStart();
	i2cTx(LCDADDR); // Call PCF8574 
	i2cTx(i2cByte);
	i2cStop();
}

void setRS(void) {
	// Set P0 bit of PCF8574 port expander (0x1)
	i2cByte |= (1);
	i2c2Lcd();
}

void clearRS(void) {
	// Clear P0 bit of PCF8574 port expander (0x1)
	i2cByte &= ~(1);
	i2c2Lcd();
}

void setRW(void) {
	// Set P1 bit of PCF8574 port expander (0x2)
	i2cByte |= (1 << 1);
	i2c2Lcd();
}

void clearRW(void) {
	// Clear P1 bit of PCF8574 port expander (0x2)
	i2cByte &= ~(1 << 1);
	i2c2Lcd();
}

void setE(void) {
	// Set P2 bit of PCF8574 port expander (0x4)
	i2cByte |= (1 << 2);
	i2cByte |= LCD_BACKLIGHT;
	i2c2Lcd();
}

void clearE(void) {
	// Clear P2 bit of PCF8574 port expander (0x4)
	i2cByte &= ~(1 << 2);
	i2cByte |= LCD_BACKLIGHT;
	i2c2Lcd();
}

[#else]

void setDB7(void) {
[#if conf.instance.lcd_settings.io_settings_mapping.*.d7.value[0] != ""]
  pal_setpad(LCD_PORT_DB7, ${conf.instance.lcd_settings.io_settings_mapping.*.d7.value[0]});
[#else]
#error unknown pin identifier for LCD pin D7
[/#if]
}

void clearDB7(void) {
[#if conf.instance.lcd_settings.io_settings_mapping.*.d7.value[0] != ""]
  pal_clearpad(LCD_PORT_DB7, ${conf.instance.lcd_settings.io_settings_mapping.*.d7.value[0]});
[#else]
#error unknown pin identifier for LCD pin D7
[/#if]
}

void setDB6(void) {
[#if conf.instance.lcd_settings.io_settings_mapping.*.d6.value[0] != ""]
  pal_setpad(LCD_PORT_DB6, ${conf.instance.lcd_settings.io_settings_mapping.*.d6.value[0]});
[#else]
#error unknown pin identifier for LCD pin D6
[/#if]
}

void clearDB6(void) {
[#if conf.instance.lcd_settings.io_settings_mapping.*.d6.value[0] != ""]
  pal_clearpad(LCD_PORT_DB6, ${conf.instance.lcd_settings.io_settings_mapping.*.d6.value[0]});
[#else]
#error unknown pin identifier for LCD pin D6
[/#if]
}

void setDB5(void) {
[#if conf.instance.lcd_settings.io_settings_mapping.*.d5.value[0] != ""]
  pal_setpad(LCD_PORT_DB5, ${conf.instance.lcd_settings.io_settings_mapping.*.d5.value[0]});
[#else]
#error unknown pin identifier for LCD pin D5
[/#if]
}

void clearDB5(void) {
[#if conf.instance.lcd_settings.io_settings_mapping.*.d5.value[0] != ""]
  pal_clearpad(LCD_PORT_DB5, ${conf.instance.lcd_settings.io_settings_mapping.*.d5.value[0]});
[#else]
#error unknown pin identifier for LCD pin D5
[/#if]
}

void setDB4(void) {
[#if conf.instance.lcd_settings.io_settings_mapping.*.d4.value[0] != ""]
  pal_setpad(LCD_PORT_DB4, ${conf.instance.lcd_settings.io_settings_mapping.*.d4.value[0]});
[#else]
#error unknown pin identifier for LCD pin D4
[/#if]
}

void clearDB4(void) {
[#if conf.instance.lcd_settings.io_settings_mapping.*.d4.value[0] != ""]
  pal_clearpad(LCD_PORT_DB4, ${conf.instance.lcd_settings.io_settings_mapping.*.d4.value[0]});
[#else]
#error unknown pin identifier for LCD pin D4
[/#if]
}

void setRS(void) {
[#if conf.instance.lcd_settings.io_settings_mapping.*.rs.value[0] != ""]
  pal_setpad(LCD_PORT_RS, ${conf.instance.lcd_settings.io_settings_mapping.*.rs.value[0]});
[#else]
#error unknown pin identifier for LCD pin RS
[/#if]
}

void clearRS(void) {
[#if conf.instance.lcd_settings.io_settings_mapping.*.rs.value[0] != ""]
  pal_clearpad(LCD_PORT_RS, ${conf.instance.lcd_settings.io_settings_mapping.*.rs.value[0]});
[#else]
#error unknown pin identifier for LCD pin RS
[/#if]
}

void setRW(void) {
[#if conf.instance.lcd_settings.io_settings_mapping.*.rw.value[0] != ""]
  pal_setpad(LCD_PORT_RW, ${conf.instance.lcd_settings.io_settings_mapping.*.rw.value[0]});
[#else]
#error unknown pin identifier for LCD pin RW
[/#if]
}

void clearRW(void) {
[#if conf.instance.lcd_settings.io_settings_mapping.*.rw.value[0] != ""]
  pal_clearpad(LCD_PORT_RW, ${conf.instance.lcd_settings.io_settings_mapping.*.rw.value[0]});
[#else]
#error unknown pin identifier for LCD pin RW
[/#if]
}

void setE(void) {
[#if conf.instance.lcd_settings.io_settings_mapping.*.e.value[0] != ""]
  pal_setpad(LCD_PORT_E, ${conf.instance.lcd_settings.io_settings_mapping.*.e.value[0]});
[#else]
#error unknown pin identifier for LCD pin E
[/#if]
}

void clearE(void) {
[#if conf.instance.lcd_settings.io_settings_mapping.*.e.value[0] != ""]
  pal_clearpad(LCD_PORT_E, ${conf.instance.lcd_settings.io_settings_mapping.*.e.value[0]});
[#else]
#error unknown pin identifier for LCD pin E
[/#if]
}

[/#if]

/* One Micro second Tempo */
void lcdDelayOneMicroSec(void) {
  unsigned int i;
  for (i = 0; i < 12; i++)
    asm volatile("se_nop" : : : "memory");
}


/* Prepare the bits to be set on DB0 to DB7 */
void LcdPreparePort(unsigned char command) {
	 LcdPreparePortMSB(command);
	 [#if mode=="gpio-8bits"]
	 LcdPreparePortLSB(command);
	 [/#if]
}

[#if mode=="gpio-8bits"]
/* Prepare the lowest 4 bits to be set (DB0 to DB3) */
void LcdPreparePortLSB(unsigned char command) {
	if (command & 0x08) {
[#if conf.instance.lcd_settings.io_settings_mapping.*.d3.value[0] != ""]
        pal_setpad(LCD_PORT_DB3, ${conf.instance.lcd_settings.io_settings_mapping.*.d3.value[0]});
[#else]
#error unknown pin identifier for LCD pin D3
[/#if]
	}
	else {
[#if conf.instance.lcd_settings.io_settings_mapping.*.d3.value[0] != ""]
        pal_clearpad(LCD_PORT_DB3, ${conf.instance.lcd_settings.io_settings_mapping.*.d3.value[0]});
[#else]
#error unknown pin identifier for LCD pin D3
[/#if]
	}
	if (command & 0x04) {
[#if conf.instance.lcd_settings.io_settings_mapping.*.d2.value[0] != ""]
        pal_setpad(LCD_PORT_DB2, ${conf.instance.lcd_settings.io_settings_mapping.*.d2.value[0]});
[#else]
#error unknown pin identifier for LCD pin D2
[/#if]
	}
	else {
[#if conf.instance.lcd_settings.io_settings_mapping.*.d2.value[0] != ""]
        pal_clearpad(LCD_PORT_DB2, ${conf.instance.lcd_settings.io_settings_mapping.*.d2.value[0]});
[#else]
#error unknown pin identifier for LCD pin D2
[/#if]
	}
	if (command & 0x02) {
[#if conf.instance.lcd_settings.io_settings_mapping.*.d1.value[0] != ""]
        pal_setpad(LCD_PORT_DB1, ${conf.instance.lcd_settings.io_settings_mapping.*.d1.value[0]});
[#else]
#error unknown pin identifier for LCD pin D1
[/#if]
	}
	else {
[#if conf.instance.lcd_settings.io_settings_mapping.*.d1.value[0] != ""]
        pal_clearpad(LCD_PORT_DB1, ${conf.instance.lcd_settings.io_settings_mapping.*.d1.value[0]});
[#else]
#error unknown pin identifier for LCD pin D1
[/#if]
	}
	if (command & 0x01) {
[#if conf.instance.lcd_settings.io_settings_mapping.*.d0.value[0] != ""]
        pal_setpad(LCD_PORT_DB0, ${conf.instance.lcd_settings.io_settings_mapping.*.d0.value[0]});
[#else]
#error unknown pin identifier for LCD pin D0
[/#if]
	}
	else {
[#if conf.instance.lcd_settings.io_settings_mapping.*.d0.value[0] != ""]
        pal_clearpad(LCD_PORT_DB0, ${conf.instance.lcd_settings.io_settings_mapping.*.d0.value[0]});
[#else]
#error unknown pin identifier for LCD pin D0
[/#if]
	}
}
[/#if]

/* Prepare the highest 4 bits to be set (DB4 to DB7) */
void LcdPreparePortMSB(unsigned char command) {
	if (command & 0x80) {
		[#if mode=="i2c"]
		// Set P7 bit of PCF8574 port expander (0x80)
		i2cByte|= (1<<7);
		[#else]
		setDB7();
		[/#if]
	}
	else {
		[#if mode=="i2c"]
		// Clear P7 bit of PCF8574 port expander (0x80)
		i2cByte&= ~(1<<7);
		[#else]
		clearDB7();
		[/#if]
	}
	if (command & 0x40) {
		[#if mode=="i2c"]
		// Set P6 bit of PCF8574 port expander (0x40)
		i2cByte|= (1<<6);
		[#else]
		setDB6();
		[/#if]
	}
	else {
		[#if mode=="i2c"]
		// Clear P6 bit of PCF8574 port expander (0x40)
		i2cByte&= ~(1<<6);
		[#else]
		clearDB6();
		[/#if]
	}
	if (command & 0x20) {
		[#if mode=="i2c"]
		// Set P5 bit of PCF8574 port expander (0x20)
		i2cByte|= (1<<5);
		[#else]
		setDB5();
		[/#if]
	}
	else {
		[#if mode=="i2c"]
		// Clear P5 bit of PCF8574 port expander (0x20)
		i2cByte&= ~(1<<5);
		[#else]
		clearDB5();
		[/#if]
	}
	if (command & 0x10) {
		[#if mode=="i2c"]
		// Set P4 bit of PCF8574 port expander (0x10)
		i2cByte|= (1<<4);
		[#else]
		setDB4();
		[/#if]
	}
	else {
		[#if mode=="i2c"]
		// Clear P4 bit of PCF8574 port expander (0x10)
		i2cByte&= ~(1<<4);
		[#else]
		clearDB4();
		[/#if]
	}

	[#if mode=="i2c"]
	i2cByte|=LCD_BACKLIGHT;
	i2c2Lcd();
	[/#if]
}


void LcdInitializeCommand(void) {
	clearRS(); //Selected command register
	lcdDelayOneMicroSec();
	clearRW();  //We are writing in instruction register
	lcdDelayOneMicroSec();

}

void LcdInitializeData(void) {
	setRS(); //Selected data register
	lcdDelayOneMicroSec();
	clearRW();  //We are writing in instruction register
	lcdDelayOneMicroSec();
}

/*
 * Validate an instruction, and send it to the LCD
 * This is done by acting on the RS, RW and E signals
 * */

void LCDValidInstruction(void) {
	lcdDelayOneMicroSec();
	setE();  // Enable H->
	lcdDelayOneMicroSec();
	clearE();
	lcdDelayOneMicroSec();
}

/* Send a command instruction*/
void LcdSendCommand(unsigned char command) {
[#if mode=="i2c"]
	i2cByte=0;
[/#if]
	LcdInitializeCommand ();
[#if mode=="gpio-8bits"]
	/* 8 bits mode */
	LcdPreparePort(command);
[#else]
	/* 4 bits mode */
	LcdPreparePortMSB(command & 0xF0);
	LCDValidInstruction();
	//sysTimeWaitMilliseconds(1);
	command = ((command << 4) & 0xF0);
	LcdPreparePortMSB(command);
[/#if]
	LCDValidInstruction();
	//LCDBusy();
	sysTimeWaitMilliseconds(1);
}

/* Send a data instruction */
void LcdSendData(unsigned char command) {
[#if mode=="i2c"]
	i2cByte=0;
[/#if]
	LcdInitializeData ();
[#if mode=="gpio-8bits"]
	/* 8 bits mode */
	LcdPreparePort(command);
[#else]
	/* 4 bits mode */
	LcdPreparePortMSB(command & 0xF0);
	LCDValidInstruction();
	//sysTimeWaitMilliseconds(1);
	command = ((command << 4) & 0xF0);
	LcdPreparePortMSB(command);
[/#if]
	LCDValidInstruction();
	//LCDBusy();
	sysTimeWaitMilliseconds(1);
}

void LCDBusy() {
	unsigned char i, j;
	for (i = 0; i < 50; i++)        //A simple for loop for delay
		for (j = 0; j < 255; j++)
			;
}

/*
 Load a custom char in LCD CGRAM

 Input:
 location: location where you want to store
 0,1,2,....7
 ptr: Pointer to pattern data

 Usage:
 pattern[8]={0x04,0x0E,0x0E,0x0E,0x1F,0x00,0x04,0x00};
 LcdBuild(1,pattern);
 */

void LcdBuild(unsigned char location, unsigned char *ptr) {
	unsigned char i;
	if (location < 8) {
		LcdSendCommand(0x40 + (location * 8));
		for (i = 0; i < 8; i++)
			LcdSendData(ptr[i]);
	}
}

/*
 Position cursor at a specific location
 */

void lcdPos(unsigned char line, unsigned char pos) {
	unsigned char pos_new;
	pos--;
	if (line == 1)
		pos_new = pos;
	else if (line == 2)
		pos_new = 0x40 + pos;
	else if (line == 3)
		pos_new = 0x14 + pos;
	else if (line == 4)
		pos_new = 0x54 + pos;

	LcdSendCommand(0x80 + pos_new);
}

/* Write a string on the LCD*/

void LcdWriteString(char *str) {
	while (*str != '\0') {
		LcdSendData(*str++);
		sysTimeWaitMilliseconds(1);
	}
}

void LcdWriteStringl(char *str, unsigned char len) {
	char test;
	while (len > 0) {
		test = *str;
		if ((test == 13) || (test == 10)) {
			LcdSendData(32);
			str++;
		} else {
			LcdSendData(*str++);
		}
		sysTimeWaitMilliseconds(1);
		len--;
	}

}

/* LCD initialization sequence */

void lcdInit() {

	//setRW ();

	sysTimeWaitMilliseconds(1);

	// Send 3 init commands
	LcdSendCommand(INIT);
	LcdSendCommand(INIT);
	LcdSendCommand(INIT);
[#if mode=="i2c"]
	LcdSendCommand(0x02);
[/#if]

	// Set the LCD as : 4 or 8 bits data, 1 or 2 rows, 5*8 or 5*11 dots
	LcdSendCommand(FSET);

	// Set the display On (cursor or no, blinking or no)
	LcdSendCommand(DISPON);

	// Write from left to right or right to left
	LcdSendCommand(ENTRY);

	// Clear the screen
	LcdSendCommand(CLEAR);
}

[/#list]
