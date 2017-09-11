[#ftl]
[@pp.dropOutputFile /]
[@pp.changeOutputFile name="i2cFunctions.h" /]

/*
 * i2cFunctions.h
 */

#ifndef I2CFUNCTIONS_H_
#define I2CFUNCTIONS_H_


#include "i2c_conf.h"

extern void i2cStart(void);
extern void i2cStop(void);
extern void delayOneMicroSec (void);
extern void delayTwoMicroSec (void);
extern void delayFiveMicroSec (void);
extern void delayThreeMicroSec (void);
extern bool i2cTx(unsigned char d);
extern unsigned char i2cRx (void);
extern void write2Slave (void);
extern void readFromSlave (void);
extern void switchOnP4A32 (void);
extern void switchOffP4A32 (void);
extern unsigned char readPorts (void);

#endif /* I2CFUNCTIONS_H_ */

