//
//  Macros.h
//  One State - Moumen Mod Menu
//
//  Created by Moumen
//

#ifndef Macros_h
#define Macros_h

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <objc/runtime.h>
#import <Foundation/Foundation.h>

#define NSSENCRYPT(str) @str

#define ReadFloat(addr) (*(float*)addr)
#define ReadInt(addr) (*(int*)addr)
#define ReadBool(addr) (*(bool*)addr)

#define WriteFloat(addr, value) (*(float*)addr = value)
#define WriteInt(addr, value) (*(int*)addr = value)
#define WriteBool(addr, value) (*(bool*)addr = value)

extern NSMutableDictionary *switches;
void initializeSwitches(void);
BOOL isSwitchOn(NSString *key);
void setSwitchValue(NSString *key, id value);
id getSwitchValue(NSString *key);

#define LOG(fmt, ...) NSLog(@"[OneState Mod] " fmt, ##__VA_ARGS__)

@interface Gameplay : NSObject
- (void)Update;
@end

@interface MODMenuController : NSObject
- (void)setupMenu;
- (void)addHeaderWithTitle:(NSString *)title;
- (void)addSectionWithTitle:(NSString *)title;
- (void)addToggleWithTitle:(NSString *)title defaultValue:(BOOL)def;
- (void)addSliderWithTitle:(NSString *)title minValue:(float)min maxValue:(float)max defaultValue:(float)def stepValue:(float)step;
- (void)addLabelWithText:(NSString *)text;
@end

void savePreferences(void);
void loadPreferences(void);

#endif /* Macros_h */
