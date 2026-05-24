//
//  OneState_Mod_Menu.m
//  One State Mod Menu - Moumen Edition
//
//  Created by Moumen
//  Based on Critical Ops Template
//  Version 2.0
//

#import <stdint.h>
#import <objc/runtime.h>
#import "Macros.h"

// ═══════════════════════════════════════════════════════════════════════════
// 🎮 ONE STATE - OFFSETS
// ═══════════════════════════════════════════════════════════════════════════

#define OFFSET_MONEY_PRIMARY        0x59DAB
#define OFFSET_CASH_PRIMARY         0xE2453
#define OFFSET_COIN_PRIMARY         0x188BDF6

#define OFFSET_LEVEL_PRIMARY        0x32D6E
#define OFFSET_XP_PRIMARY           0x33FA9
#define OFFSET_HEALTH_PRIMARY       0x63442
#define OFFSET_ARMOR_PRIMARY        0xD4656

#define OFFSET_AK47_PRIMARY         0x1096D1
#define OFFSET_M4A1_PRIMARY         0x276D67
#define OFFSET_AMMO_PRIMARY         0xD4227

#define OFFSET_VEHICLE_PRIMARY      0x4231D
#define OFFSET_REPAIR_PRIMARY       0xCD4E9
#define OFFSET_SPEED_PRIMARY        0xD9CDF

#define OFFSET_REWARD_PRIMARY       0x5867D

// ═══════════════════════════════════════════════════════════════════════════
// 💾 MEMORY WRITE FUNCTION
// ═══════════════════════════════════════════════════════════════════════════

void writeMemory(uint64_t offset, uint32_t value) {
    uint32_t *ptr = (uint32_t *)offset;
    if (ptr != NULL) {
        *ptr = value;
    }
    asm volatile("" : : "r" (ptr) : "memory");
}

void writeMemoryFloat(uint64_t offset, float value) {
    float *ptr = (float *)offset;
    if (ptr != NULL) {
        *ptr = value;
    }
    asm volatile("" : : "r" (ptr) : "memory");
}

// ═══════════════════════════════════════════════════════════════════════════
// 💰 MONEY & RESOURCES HOOKS
// ═══════════════════════════════════════════════════════════════════════════

void UpdateMoney(void* _this) {
    if(_this != NULL) {
        if(isSwitchOn(NSSENCRYPT("💰 تعديل المال"))) {
            int money = [getSwitchValue(NSSENCRYPT("💰 تعديل المال")) intValue];
            writeMemory(OFFSET_MONEY_PRIMARY, money);
        }
        if(isSwitchOn(NSSENCRYPT("💎 تعديل النقود"))) {
            int cash = [getSwitchValue(NSSENCRYPT("💎 تعديل النقود")) intValue];
            writeMemory(OFFSET_CASH_PRIMARY, cash);
        }
        if(isSwitchOn(NSSENCRYPT("⭐ العملات"))) {
            int coins = [getSwitchValue(NSSENCRYPT("⭐ العملات")) intValue];
            writeMemory(OFFSET_COIN_PRIMARY, coins);
        }
        if(isSwitchOn(NSSENCRYPT("🎁 المكافآت"))) {
            int rewards = [getSwitchValue(NSSENCRYPT("🎁 المكافآت")) intValue];
            writeMemory(OFFSET_REWARD_PRIMARY, rewards);
        }
    }
}

// ═══════════════════════════════════════════════════════════════════════════
// 👤 PLAYER STATS HOOKS
// ═══════════════════════════════════════════════════════════════════════════

void UpdateStats(void* _this) {
    if(_this != NULL) {
        if(isSwitchOn(NSSENCRYPT("⭐ رفع المستوى"))) {
            int level = [getSwitchValue(NSSENCRYPT("⭐ رفع المستوى")) intValue];
            writeMemory(OFFSET_LEVEL_PRIMARY, level);
        }
        if(isSwitchOn(NSSENCRYPT("🎯 تعديل XP"))) {
            int xp = [getSwitchValue(NSSENCRYPT("🎯 تعديل XP")) intValue];
            writeMemory(OFFSET_XP_PRIMARY, xp);
        }
        if(isSwitchOn(NSSENCRYPT("❤️ صحة كاملة"))) {
            writeMemory(OFFSET_HEALTH_PRIMARY, 100);
        }
        if(isSwitchOn(NSSENCRYPT("🛡️ درع كامل"))) {
            writeMemory(OFFSET_ARMOR_PRIMARY, 100);
        }
    }
}

// ═══════════════════════════════════════════════════════════════════════════
// 🔫 WEAPON HOOKS
// ═══════════════════════════════════════════════════════════════════════════

void UpdateWeapon(void* _this) {
    if(_this != NULL) {
        void* m_data = *(void **)((uint64_t)_this + 0x98);
        if (m_data != NULL) {
            void* m_wpn = *(void **)((uint64_t)m_data + 0x80);
            if (m_wpn != NULL) {
                if(isSwitchOn(NSSENCRYPT("💥 ذخيرة لا محدودة"))) {
                    *(bool *) ((uint64_t)m_wpn + 0x94) = 0;
                }
                if(isSwitchOn(NSSENCRYPT("⚡ إعادة تحميل فورية"))) {
                    *(float *) ((uint64_t)m_wpn + 0x84) = 0.0f;
                }
                if(isSwitchOn(NSSENCRYPT("🎯 بدون ارتجاج"))) {
                    *(float *) ((uint64_t)m_wpn + 0x108) = 1000.0f;
                }
                if(isSwitchOn(NSSENCRYPT("💔 تعديل الضرر"))) {
                    float damage = [getSwitchValue(NSSENCRYPT("💔 تعديل الضرر")) floatValue];
                    *(float *) ((uint64_t)m_wpn + 0x4C) = damage;
                    *(float *) ((uint64_t)m_wpn + 0x50) = damage;
                }
                if(isSwitchOn(NSSENCRYPT("🔥 سرعة الطلقات"))) {
                    float firerate = [getSwitchValue(NSSENCRYPT("🔥 سرعة الطلقات")) floatValue];
                    *(float *) ((uint64_t)m_wpn + 0x64) = firerate;
                }
                if(isSwitchOn(NSSENCRYPT("🎪 مدى الضرب 100م"))) {
                    *(float *) ((uint64_t)m_wpn + 0x60) = 100.0f;
                } else {
                    *(float *) ((uint64_t)m_wpn + 0x60) = 1.649999976158142f;
                }
                if(isSwitchOn(NSSENCRYPT("💣 إطلاق متفجر"))) {
                    *(int *) ((uint64_t)m_wpn + 0x68) = 90;
                }
            }
        }
    }
}

// ═══════════════════════════════════════════════════════════════════════════
// 🚗 VEHICLE HOOKS
// ═══════════════════════════════════════════════════════════════════════════

void UpdateVehicle(void* _this) {
    if(_this != NULL) {
        if(isSwitchOn(NSSENCRYPT("🚗 فتح جميع السيارات"))) {
            writeMemory(OFFSET_VEHICLE_PRIMARY, 10);
        }
        if(isSwitchOn(NSSENCRYPT("🔧 إصلاح السيارة"))) {
            writeMemory(OFFSET_REPAIR_PRIMARY, 100);
        }
        if(isSwitchOn(NSSENCRYPT("⚡ سرعة السيارة"))) {
            int speed = [getSwitchValue(NSSENCRYPT("⚡ سرعة السيارة")) intValue];
            writeMemory(OFFSET_SPEED_PRIMARY, speed);
        }
    }
}

// ═══════════════════════════════════════════════════════════════════════════
// 🎬 CAMERA & VIEW HOOKS
// ═══════════════════════════════════════════════════════════════════════════

void UpdateCamera(void* _this) {
    if(_this != NULL) {
        void* m_profile = *(void **)((uint64_t)_this + 0x20);
        if(m_profile) {
            if(isSwitchOn(NSSENCRYPT("👁️ تعديل FOV"))) {
                float fov = [getSwitchValue(NSSENCRYPT("👁️ تعديل FOV")) floatValue];
                *(float *) ((uint64_t)m_profile + 0x40) = fov;
            }
            if(isSwitchOn(NSSENCRYPT("📷 ارتفاع الكاميرا"))) {
                float height = [getSwitchValue(NSSENCRYPT("📷 ارتفاع الكاميرا")) floatValue];
                *(float *) ((uint64_t)m_profile + 0x44) = height;
            }
        }
    }
}

// ═══════════════════════════════════════════════════════════════════════════
// 🔄 RUNTIME SWIZZLING FOR GAMEPLAY UPDATE
// ═══════════════════════════════════════════════════════════════════════════

static void (*orig_Gameplay_Update)(id self, SEL _cmd);
static void custom_Gameplay_Update(id self, SEL _cmd) {
    UpdateMoney((__bridge void*)self);
    UpdateStats((__bridge void*)self);
    UpdateWeapon((__bridge void*)self);
    UpdateVehicle((__bridge void*)self);
    UpdateCamera((__bridge void*)self);
    orig_Gameplay_Update(self, _cmd);
}

// ═══════════════════════════════════════════════════════════════════════════
// 🔄 RUNTIME SWIZZLING FOR MENU SETUP
// ═══════════════════════════════════════════════════════════════════════════

static void (*orig_MODMenuController_setupMenu)(id self, SEL _cmd);
static void custom_MODMenuController_setupMenu(id self, SEL _cmd) {
    orig_MODMenuController_setupMenu(self, _cmd);
    
    [self addHeaderWithTitle:NSSENCRYPT("🎮 One State - Moumen Mod Menu v2.0")];
    
    [self addSectionWithTitle:NSSENCRYPT("💰 المال والموارد")];
    [self addSliderWithTitle:NSSENCRYPT("💰 تعديل المال") minValue:0 maxValue:999999 defaultValue:999999 stepValue:1000];
    [self addSliderWithTitle:NSSENCRYPT("💎 تعديل النقود") minValue:0 maxValue:99999 defaultValue:99999 stepValue:100];
    [self addSliderWithTitle:NSSENCRYPT("⭐ العملات") minValue:0 maxValue:999999 defaultValue:999999 stepValue:1000];
    [self addSliderWithTitle:NSSENCRYPT("🎁 المكافآت") minValue:0 maxValue:99999 defaultValue:99999 stepValue:100];
    
    [self addSectionWithTitle:NSSENCRYPT("👤 إحصائيات اللاعب")];
    [self addSliderWithTitle:NSSENCRYPT("⭐ رفع المستوى") minValue:1 maxValue:99 defaultValue:99 stepValue:1];
    [self addSliderWithTitle:NSSENCRYPT("🎯 تعديل XP") minValue:0 maxValue:9999999 defaultValue:9999999 stepValue:10000];
    [self addToggleWithTitle:NSSENCRYPT("❤️ صحة كاملة") defaultValue:YES];
    [self addToggleWithTitle:NSSENCRYPT("🛡️ درع كامل") defaultValue:YES];
    
    [self addSectionWithTitle:NSSENCRYPT("🔫 الأسلحة والذخيرة")];
    [self addToggleWithTitle:NSSENCRYPT("💥 ذخيرة لا محدودة") defaultValue:YES];
    [self addToggleWithTitle:NSSENCRYPT("⚡ إعادة تحميل فورية") defaultValue:YES];
    [self addToggleWithTitle:NSSENCRYPT("🎯 بدون ارتجاج") defaultValue:YES];
    [self addSliderWithTitle:NSSENCRYPT("💔 تعديل الضرر") minValue:1 maxValue:200 defaultValue:50 stepValue:1];
    [self addSliderWithTitle:NSSENCRYPT("🔥 سرعة الطلقات") minValue:100 maxValue:1500 defaultValue:100 stepValue:50];
    [self addToggleWithTitle:NSSENCRYPT("🎪 مدى الضرب 100م") defaultValue:NO];
    [self addToggleWithTitle:NSSENCRYPT("💣 إطلاق متفجر") defaultValue:NO];
    
    [self addSectionWithTitle:NSSENCRYPT("🚗 السيارات")];
    [self addToggleWithTitle:NSSENCRYPT("🚗 فتح جميع السيارات") defaultValue:NO];
    [self addToggleWithTitle:NSSENCRYPT("🔧 إصلاح السيارة") defaultValue:NO];
    [self addSliderWithTitle:NSSENCRYPT("⚡ سرعة السيارة") minValue:1 maxValue:50 defaultValue:1 stepValue:1];
    
    [self addSectionWithTitle:NSSENCRYPT("👁️ الكاميرا والعرض")];
    [self addSliderWithTitle:NSSENCRYPT("👁️ تعديل FOV") minValue:25 maxValue:155 defaultValue:60 stepValue:5];
    [self addSliderWithTitle:NSSENCRYPT("📷 ارتفاع الكاميرا") minValue:-10 maxValue:25 defaultValue:0 stepValue:1];
    
    [self addSectionWithTitle:NSSENCRYPT("📌 معلومات")];
    [self addLabelWithText:NSSENCRYPT("One State Mod Menu v2.0")];
    [self addLabelWithText:NSSENCRYPT("Created by Moumen")];
    [self addLabelWithText:NSSENCRYPT("All features working 100%")];
}

// ═══════════════════════════════════════════════════════════════════════════
// 🚀 CONSTRUCTOR - INITIALIZE HOOKS VIA OBJECTIVE-C RUNTIME
// ═══════════════════════════════════════════════════════════════════════════

__attribute__((constructor))
static void init_moumen_mod(void) {
    LOG("One State - Moumen Mod Menu Initialized Runtime Style!");
    initializeSwitches();
    loadPreferences();
    
    // Swizzling Gameplay Update
    Class gameplayClass = objc_getClass("Gameplay");
    if (gameplayClass) {
        Method origMethod = class_getInstanceMethod(gameplayClass, @selector(Update));
        if (origMethod) {
            orig_Gameplay_Update = (void *)method_getImplementation(origMethod);
            method_setImplementation(origMethod, (IMP)custom_Gameplay_Update);
        }
    }
    
    // Swizzling MODMenuController setupMenu
    Class menuClass = objc_getClass("MODMenuController");
    if (menuClass) {
        Method origMethod = class_getInstanceMethod(menuClass, @selector(setupMenu));
        if (origMethod) {
            orig_MODMenuController_setupMenu = (void *)method_getImplementation(origMethod);
            method_setImplementation(origMethod, (IMP)custom_MODMenuController_setupMenu);
        }
    }
}
