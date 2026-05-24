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

// تشفير بسيط جداً للنصوص
#define NSSENCRYPT(str) [@#str dataUsingEncoding:NSUTF8StringEncoding]

// أو يمكنك استخدام هذا للنصوص العادية
#define STRENCRYPT(str) (str)

// ═══════════════════════════════════════════════════════════════════════════
// 🎯 MEMORY READ/WRITE MACROS
// ═══════════════════════════════════════════════════════════════════════════

// قراءة من الذاكرة
#define ReadFloat(addr) (*(float*)addr)
#define ReadInt(addr) (*(int*)addr)
#define ReadBool(addr) (*(bool*)addr)
#define ReadDouble(addr) (*(double*)addr)

// كتابة في الذاكرة
#define WriteFloat(addr, value) (*(float*)addr = value)
#define WriteInt(addr, value) (*(int*)addr = value)
#define WriteBool(addr, value) (*(bool*)addr = value)
#define WriteDouble(addr, value) (*(double*)addr = value)

// ═══════════════════════════════════════════════════════════════════════════
// 🪝 HOOK MACROS (بدائل للـ Hooks)
// ═══════════════════════════════════════════════════════════════════════════

// For function hooking
#define HOOKFUNC(func) func##_original
#define HOOK_ORIG(func) func##_original

// ═══════════════════════════════════════════════════════════════════════════
// 📊 SWITCH SYSTEM (نظام التبديل)
// ═══════════════════════════════════════════════════════════════════════════

// Global switches dictionary
extern NSMutableDictionary *switches;

// Initialize switches
void initializeSwitches(void);

// Get/Set switch value
BOOL isSwitchOn(NSString *key);
void setSwitchValue(NSString *key, id value);
id getSwitchValue(NSString *key);

// ═══════════════════════════════════════════════════════════════════════════
// 🎨 LOGGING MACROS (تسجيل الأخطاء)
// ═══════════════════════════════════════════════════════════════════════════

#define LOG(fmt, …) NSLog(@”[OneState Mod] “ fmt, ##**VA_ARGS**)
#define ERROR(fmt, …) NSLog(@”[OneState Mod ERROR] “ fmt, ##**VA_ARGS**)
#define WARNING(fmt, …) NSLog(@”[OneState Mod WARNING] “ fmt, ##**VA_ARGS**)
#define SUCCESS(fmt, …) NSLog(@”[OneState Mod SUCCESS] “ fmt, ##**VA_ARGS**)

// ═══════════════════════════════════════════════════════════════════════════
// 🔧 UTILITY FUNCTIONS
// ═══════════════════════════════════════════════════════════════════════════

// String utilities
#define STRINGIFY(x) #x
#define TOSTRING(x) @#x

// Float operations
static inline float clamp(float value, float min, float max) {
if (value < min) return min;
if (value > max) return max;
return value;
}

// Integer operations
static inline int clampi(int value, int min, int max) {
if (value < min) return min;
if (value > max) return max;
return value;
}

// ═══════════════════════════════════════════════════════════════════════════
// 💾 GLOBAL VARIABLES
// ═══════════════════════════════════════════════════════════════════════════

extern NSMutableDictionary *switches;
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

// ═══════════════════════════════════════════════════════════════════════════
// 📦 PREFERENCES (حفظ التفضيلات)
// ═══════════════════════════════════════════════════════════════════════════

void savePreferences(void);
void loadPreferences(void);

// ═══════════════════════════════════════════════════════════════════════════
// 🚀 INITIALIZATION
// ═══════════════════════════════════════════════════════════════════════════

**attribute**((constructor))
static void init_moumen_mod(void) {
LOG(@“One State - Moumen Mod Menu Initialized!”);
initializeSwitches();
loadPreferences();
}

#endif /* Macros_h */
