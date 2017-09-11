[#ftl]
[@pp.dropOutputFile /]
[@pp.changeOutputFile name="lcdFunctions.h" /]

/*
 * lcdFunctions.h
 */

 [#list conf.instance.lcd_settings as group]
  [#assign size = group.working_mode.matrix_size.value[0] /]
  [#assign rows = group.working_mode.number_of_rows.value[0] /]
  [#assign transfer = group.working_mode.transfer_mode.value[0] /]
  [#assign cursdir = group.editing_mode.cursor_direction.value[0] /]
  [#assign display = group.editing_mode.show_display.value[0] /]
  [#assign cursor = group.editing_mode.show_cursor.value[0] /]
  [#assign blinking = group.editing_mode.blinking.value[0] /]
  [#assign mode = group.working_mode.transfer_mode.value[0] /]
  [#assign i2ccomp = group.working_mode.i2c_component.value[0] /]

#ifndef LCDFUNCTIONS_H_
#define LCDFUNCTIONS_H_


#include "lcd_conf.h"

void lcdDelayOneMicroSec (void);
void lcdInit (void);
void LcdPreparePort (unsigned char command);
void LcdPreparePortMSB (unsigned char command);
[#if mode=="gpio-8bits"]
void LcdPreparePortLSB (unsigned char command);
[/#if]
void LCDValidInstruction (void);
void LcdSendInitCommand(void);
void LcdSendFsetCommand(void);
void LcdSendCommand (unsigned char command);
void LCDValidData (void);
void LcdSendData (unsigned char command);
void LCDBusy(void);
void LcdBuild(unsigned char location, unsigned char *ptr);
void lcdPos(unsigned char line, unsigned char pos);
void LcdWriteString(char *str);
void LcdWriteStringl(char *str,unsigned char len);
[#if mode=="gpio-8bits"]
void setDB7 (void);
void ClearDB7 (void);
void setDB6 (void);
void ClearDB6 (void);
void setDB5 (void);
void ClearDB5 (void);
void setDB4 (void);
void ClearDB4 (void);
[/#if]
void setRS (void);
void ClearRS (void);
void setRW (void);
void ClearRW (void);
void setE (void);
void ClearE (void);

typedef enum Commands Commands;
enum Commands
{
	INIT=0x30,
	FSET=0x20[#if mode=="gpio-8bits"]|0x10[/#if][#if rows!="1"]|0x08[/#if][#if size="5X11"]|0x04[/#if],

	DISPON=0x08[#if display=="yes"]|0x04[/#if][#if cursor=="yes"]|0x02[/#if][#if blinking=="on"]|0x01[/#if],
	ENTRY=0x04[#if cursdir=="right"]|0x02[/#if],
	CLEAR = 0x01,

	FSTROW = 0x80,
	SNDROW = 0xC0,
	THRDROW = 0x94,
	FRTHROW = 0xD4
};

//flags for backlight control
#define LCD_BACKLIGHT  0x08
#define LCD_NOBACKLIGHT  0x00
[#if mode=="i2c"]
	[#if i2ccomp=="PCF8574"]
#define LCDADDR 0x4E
	[#else]
#define LCDADDR 0x7E
	[/#if]
[/#if]

#endif /* LCDFUNCTIONS_H_ */

[/#list]
