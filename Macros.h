//
//  Macros.h
//  One State - Moumen Mod Menu
//
//  Created by Moumen
//  All the important macros and utilities
//

#ifndef Macros_h
#define Macros_h

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <objc/runtime.h>
#import <Foundation/Foundation.h>

// ═══════════════════════════════════════════════════════════════════════════
// 🔐 STRING ENCRYPTION MACRO (تشفير النصوص)
// ═══════════════════════════════════════════════════════════════════════════

#define NSSENCRYPT(str) @str
#define STRENCRYPT(str) (str)

// ═══════════════════════════════════════════════════════════════════════════
// 🎯 MEMORY READ/WRITE MACROS
// ═══════════════════════════════════════════════════════════════════════════

#define ReadFloat(addr) (*(float*)addr)
#define ReadInt(addr) (*(int*)addr)
#define ReadBool(addr) (*(bool*)addr)
#define ReadDouble(addr) (*(double*)addr)

#define WriteFloat(addr, value) (*(float*)addr = value)
#define WriteInt(addr, value) (*(int*)addr = value)
#define WriteBool(addr, value) (*(bool*)addr = value)
#define WriteDouble(addr, value) (*(double*)addr = value)

// ═══════════════════════════════════════════════════════════════════════════
// 📊 SWITCH SYSTEM (نظام التبديل)
// ═══════════════════════════════════════════════════════════════════════════

extern NSMutableDictionary *switches;
void initializeSwitches(void);

BOOL isSwitchOn(NSString *key);
void setSwitchValue(NSString *key, id value);
id getSwitchValue(NSString *key);

// ═══════════════════════════════════════════════════════════════════════════
// 🎨 LOGGING MACROS (تسجيل الأخطاء)
// ═══════════════════════════════════════════════════════════════════════════

#define LOG(fmt, ...) NSLog(@"[OneState Mod] " fmt, ##__VA_ARGS__)
#define ERROR(fmt, ...) NSLog(@"[OneState Mod ERROR] " fmt, ##__VA_ARGS__)
#define WARNING(fmt, ...) NSLog(@"[OneState Mod WARNING] " fmt, ##__VA_ARGS__)
#define SUCCESS(fmt, ...) NSLog(@"[OneState Mod SUCCESS] " fmt, ##__VA_ARGS__)

// ═══════════════════════════════════════════════════════════════════════════
// 🔧 UTILITY FUNCTIONS
// ═══════════════════════════════════════════════════════════════════════════

static inline float clamp(float value, float min, float max) {
    if (value < min) return min;
    if (value > max) return max;
    return value;
}

static inline int clampi(int value, int min, int max) {
    if (value < min) return min;
    if (value > max) return max;
    return value;
}

extern BOOL modenabled;

// ═══════════════════════════════════════════════════════════════════════════
// 🎮 GAME CLASSES (تعريف كلاسات اللعبة)
// ═══════════════════════════════════════════════════════════════════════════

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
