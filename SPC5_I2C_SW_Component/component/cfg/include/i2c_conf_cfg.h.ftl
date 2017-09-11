[#ftl]
[@pp.dropOutputFile /]
[@pp.changeOutputFile name="i2c_conf.h" /]

 /*
  * i2c_conf.h
  */

#ifndef _I2CCONF_H_
#define _I2CCONF_H_


/*
 * I2C driver system settings.
 */

[#assign ok = false]
[#list global.instances["com.st.spc5.components.board.spc560dxx_rla"].i_o_settings.pins_list.pin_settings as ss ]
[#if conf.instance.i2c_settings.io_settings_mapping.sda.value[0] == ss.pin_identification.identifier.value[0]]
[#assign ok = true]
[#assign pin = ss.pin_identification.identifier.value[0]]
[#assign port = ss.pin_identification.port.value[0]]
[/#if]
[/#list]
[#if ok == true]
#define I2C_PORT_SDA	${port}
[#else]
#define I2C_PORT_SDA	#error please choose a valid pin identifier	
[#assign ok = false]
[/#if]
[#list global.instances["com.st.spc5.components.board.spc560dxx_rla"].i_o_settings.pins_list.pin_settings as ss ]
[#if conf.instance.i2c_settings.io_settings_mapping.scl.value[0] == ss.pin_identification.identifier.value[0]]
[#assign ok = true]
[#assign pin = ss.pin_identification.identifier.value[0]]
[#assign port = ss.pin_identification.port.value[0]]
[/#if]
[/#list]
[#if ok == true]
#define I2C_PORT_SCL	${port}
[#else]
#define I2C_PORT_SCL	#error please choose a valid pin identifier	
[/#if]

#endif /* _I2CCONF_H_ */
