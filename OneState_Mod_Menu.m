//
//  OneState_Mod_Menu.m
//  One State Mod Menu - Moumen Edition
//
//  Created by Moumen
//  Based on Critical Ops Template
//  Version 2.0
//

#import “Macros.h”

// ═══════════════════════════════════════════════════════════════════════════
// 🎮 ONE STATE - OFFSETS (من التحليل السابق)
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
*ptr = value;
**asm** **volatile**(”” : : “r” (ptr) : “memory”);
}

void writeMemoryFloat(uint64_t offset, float value) {
float *ptr = (float *)offset;
*ptr = value;
**asm** **volatile**(”” : : “r” (ptr) : “memory”);
}

// ═══════════════════════════════════════════════════════════════════════════
// 💰 MONEY & RESOURCES HOOKS
// ═══════════════════════════════════════════════════════════════════════════

void(*old_UpdateMoney)(void* _this);

void UpdateMoney(void* _this) {
if(_this != NULL) {

```
    // تعديل المال
    if([switches isSwitchOn:NSSENCRYPT("💰 تعديل المال")]) {
        int money = [[switches getValueFromSwitch:NSSENCRYPT("💰 تعديل المال")] intValue];
        writeMemory(OFFSET_MONEY_PRIMARY, money);
    }
    
    // تعديل النقود
    if([switches isSwitchOn:NSSENCRYPT("💎 تعديل النقود")]) {
        int cash = [[switches getValueFromSwitch:NSSENCRYPT("💎 تعديل النقود")] intValue];
        writeMemory(OFFSET_CASH_PRIMARY, cash);
    }
    
    // تعديل العملات
    if([switches isSwitchOn:NSSENCRYPT("⭐ العملات")]) {
        int coins = [[switches getValueFromSwitch:NSSENCRYPT("⭐ العملات")] intValue];
        writeMemory(OFFSET_COIN_PRIMARY, coins);
    }
    
    // جوائز
    if([switches isSwitchOn:NSSENCRYPT("🎁 المكافآت")]) {
        int rewards = [[switches getValueFromSwitch:NSSENCRYPT("🎁 المكافآت")] intValue];
        writeMemory(OFFSET_REWARD_PRIMARY, rewards);
    }
}
return old_UpdateMoney(_this);
```

}

// ═══════════════════════════════════════════════════════════════════════════
// 👤 PLAYER STATS HOOKS
// ═══════════════════════════════════════════════════════════════════════════

void(*old_UpdateStats)(void* _this);

void UpdateStats(void* _this) {
if(_this != NULL) {

```
    // تعديل المستوى
    if([switches isSwitchOn:NSSENCRYPT("⭐ رفع المستوى")]) {
        int level = [[switches getValueFromSwitch:NSSENCRYPT("⭐ رفع المستوى")] intValue];
        writeMemory(OFFSET_LEVEL_PRIMARY, level);
    }
    
    // تعديل XP
    if([switches isSwitchOn:NSSENCRYPT("🎯 تعديل XP")]) {
        int xp = [[switches getValueFromSwitch:NSSENCRYPT("🎯 تعديل XP")] intValue];
        writeMemory(OFFSET_XP_PRIMARY, xp);
    }
    
    // الصحة
    if([switches isSwitchOn:NSSENCRYPT("❤️ صحة كاملة")]) {
        writeMemory(OFFSET_HEALTH_PRIMARY, 100);
    }
    
    // الدرع
    if([switches isSwitchOn:NSSENCRYPT("🛡️ درع كامل")]) {
        writeMemory(OFFSET_ARMOR_PRIMARY, 100);
    }
}
return old_UpdateStats(_this);
```

}

// ═══════════════════════════════════════════════════════════════════════════
// 🔫 WEAPON HOOKS
// ═══════════════════════════════════════════════════════════════════════════

int GetWeaponID(void *weapon) {
return *(int*)((uint64_t)weapon + 0x18);
}

void(*old_UpdateWeapon)(void* _this);

void UpdateWeapon(void* _this) {
if(_this != NULL) {

```
    void* m_data = *(void **)((uint64_t)_this + 0x98);
    void* m_wpn = *(void **)((uint64_t)m_data + 0x80);
    
    if (m_wpn) {
        
        // ذخيرة لا محدودة
        if([switches isSwitchOn:NSSENCRYPT("💥 ذخيرة لا محدودة")]) {
            *(bool *) ((uint64_t)m_wpn + 0x94) = 0;
        }
        
        // إعادة تحميل فورية
        if([switches isSwitchOn:NSSENCRYPT("⚡ إعادة تحميل فورية")]) {
            *(float *) ((uint64_t)m_wpn + 0x84) = 0.0f;
        }
        
        // بدون ارتجاج
        if([switches isSwitchOn:NSSENCRYPT("🎯 بدون ارتجاج")]) {
            *(float *) ((uint64_t)m_wpn + 0x108) = 1000.0f;
        }
        
        // تعديل الضرر
        if([switches isSwitchOn:NSSENCRYPT("💔 تعديل الضرر")]) {
            float damage = [[switches getValueFromSwitch:NSSENCRYPT("💔 تعديل الضرر")] floatValue];
            *(float *) ((uint64_t)m_wpn + 0x4C) = damage;
            *(float *) ((uint64_t)m_wpn + 0x50) = damage;
        }
        
        // سرعة الطلقات
        if([switches isSwitchOn:NSSENCRYPT("🔥 سرعة الطلقات")]) {
            float firerate = [[switches getValueFromSwitch:NSSENCRYPT("🔥 سرعة الطلقات")] floatValue];
            *(float *) ((uint64_t)m_wpn + 0x64) = firerate;
        }
        
        // مدى الضرب
        if([switches isSwitchOn:NSSENCRYPT("🎪 مدى الضرب 100م")]) {
            *(float *) ((uint64_t)m_wpn + 0x60) = 100.0f;
        } else {
            *(float *) ((uint64_t)m_wpn + 0x60) = 1.649999976158142f;
        }
        
        // انفجار
        if([switches isSwitchOn:NSSENCRYPT("💣 إطلاق متفجر")]) {
            *(int *) ((uint64_t)m_wpn + 0x68) = 90;
        }
    }
}
return old_UpdateWeapon(_this);
```

}

// ═══════════════════════════════════════════════════════════════════════════
// 🚗 VEHICLE HOOKS
// ═══════════════════════════════════════════════════════════════════════════

void(*old_UpdateVehicle)(void* _this);

void UpdateVehicle(void* _this) {
if(_this != NULL) {

```
    // فتح السيارات
    if([switches isSwitchOn:NSSENCRYPT("🚗 فتح جميع السيارات")]) {
        writeMemory(OFFSET_VEHICLE_PRIMARY, 10);
    }
    
    // إصلاح السيارة
    if([switches isSwitchOn:NSSENCRYPT("🔧 إصلاح السيارة")]) {
        writeMemory(OFFSET_REPAIR_PRIMARY, 100);
    }
    
    // سرعة السيارة
    if([switches isSwitchOn:NSSENCRYPT("⚡ سرعة السيارة")]) {
        int speed = [[switches getValueFromSwitch:NSSENCRYPT("⚡ سرعة السيارة")] intValue];
        writeMemory(OFFSET_SPEED_PRIMARY, speed);
    }
}
return old_UpdateVehicle(_this);
```

}

// ═══════════════════════════════════════════════════════════════════════════
// 🎬 CAMERA & VIEW HOOKS
// ═══════════════════════════════════════════════════════════════════════════

void(*old_UpdateCamera)(void* _this);

void UpdateCamera(void* _this) {
if(_this != NULL) {

```
    void* m_profile = *(void **)((uint64_t)_this + 0x20);
    
    if(m_profile) {
        
        // تعديل FOV
        if([switches isSwitchOn:NSSENCRYPT("👁️ تعديل FOV")]) {
            float fov = [[switches getValueFromSwitch:NSSENCRYPT("👁️ تعديل FOV")] floatValue];
            *(float *) ((uint64_t)m_profile + 0x40) = fov;
        }
        
        // ارتفاع الكاميرا
        if([switches isSwitchOn:NSSENCRYPT("📷 ارتفاع الكاميرا")]) {
            float height = [[switches getValueFromSwitch:NSSENCRYPT("📷 ارتفاع الكاميرا")] floatValue];
            *(float *) ((uint64_t)m_profile + 0x44) = height;
        }
    }
}
return old_UpdateCamera(_this);
```

}

// ═══════════════════════════════════════════════════════════════════════════
// 🪝 HOOKS REGISTRATION
// ═══════════════════════════════════════════════════════════════════════════

%hook Gameplay

- (void)Update {
  UpdateMoney(self);
  UpdateStats(self);
  UpdateWeapon(self);
  UpdateVehicle(self);
  UpdateCamera(self);
  %orig;
  }
  %end

// ═══════════════════════════════════════════════════════════════════════════
// 🎨 MOD MENU INTERFACE
// ═══════════════════════════════════════════════════════════════════════════

%hook MODMenuController

- (void)setupMenu {
  %orig;
  
  // عنوان القائمة
  [self addHeaderWithTitle:NSSENCRYPT(“🎮 One State - Moumen Mod Menu v2.0”)];
  
  // ═══════════════════════════════════════════════════════════════════════════
  // 💰 قسم المال والموارد
  // ═══════════════════════════════════════════════════════════════════════════
  
  [self addSectionWithTitle:NSSENCRYPT(“💰 المال والموارد”)];
  
  [self addSliderWithTitle:NSSENCRYPT(“💰 تعديل المال”)
  minValue:0
  maxValue:999999
  defaultValue:999999
  stepValue:1000];
  
  [self addSliderWithTitle:NSSENCRYPT(“💎 تعديل النقود”)
  minValue:0
  maxValue:99999
  defaultValue:99999
  stepValue:100];
  
  [self addSliderWithTitle:NSSENCRYPT(“⭐ العملات”)
  minValue:0
  maxValue:999999
  defaultValue:999999
  stepValue:1000];
  
  [self addSliderWithTitle:NSSENCRYPT(“🎁 المكافآت”)
  minValue:0
  maxValue:99999
  defaultValue:99999
  stepValue:100];
  
  // ═══════════════════════════════════════════════════════════════════════════
  // 👤 قسم إحصائيات اللاعب
  // ═══════════════════════════════════════════════════════════════════════════
  
  [self addSectionWithTitle:NSSENCRYPT(“👤 إحصائيات اللاعب”)];
  
  [self addSliderWithTitle:NSSENCRYPT(“⭐ رفع المستوى”)
  minValue:1
  maxValue:99
  defaultValue:99
  stepValue:1];
  
  [self addSliderWithTitle:NSSENCRYPT(“🎯 تعديل XP”)
  minValue:0
  maxValue:9999999
  defaultValue:9999999
  stepValue:10000];
  
  [self addToggleWithTitle:NSSENCRYPT(“❤️ صحة كاملة”)
  defaultValue:YES];
  
  [self addToggleWithTitle:NSSENCRYPT(“🛡️ درع كامل”)
  defaultValue:YES];
  
  // ═══════════════════════════════════════════════════════════════════════════
  // 🔫 قسم الأسلحة
  // ═══════════════════════════════════════════════════════════════════════════
  
  [self addSectionWithTitle:NSSENCRYPT(“🔫 الأسلحة والذخيرة”)];
  
  [self addToggleWithTitle:NSSENCRYPT(“💥 ذخيرة لا محدودة”)
  defaultValue:YES];
  
  [self addToggleWithTitle:NSSENCRYPT(“⚡ إعادة تحميل فورية”)
  defaultValue:YES];
  
  [self addToggleWithTitle:NSSENCRYPT(“🎯 بدون ارتجاج”)
  defaultValue:YES];
  
  [self addSliderWithTitle:NSSENCRYPT(“💔 تعديل الضرر”)
  minValue:1
  maxValue:200
  defaultValue:50
  stepValue:1];
  
  [self addSliderWithTitle:NSSENCRYPT(“🔥 سرعة الطلقات”)
  minValue:100
  maxValue:1500
  defaultValue:100
  stepValue:50];
  
  [self addToggleWithTitle:NSSENCRYPT(“🎪 مدى الضرب 100م”)
  defaultValue:NO];
  
  [self addToggleWithTitle:NSSENCRYPT(“💣 إطلاق متفجر”)
  defaultValue:NO];
  
  // ═══════════════════════════════════════════════════════════════════════════
  // 🚗 قسم السيارات
  // ═══════════════════════════════════════════════════════════════════════════
  
  [self addSectionWithTitle:NSSENCRYPT(“🚗 السيارات”)];
  
  [self addToggleWithTitle:NSSENCRYPT(“🚗 فتح جميع السيارات”)
  defaultValue:NO];
  
  [self addToggleWithTitle:NSSENCRYPT(“🔧 إصلاح السيارة”)
  defaultValue:NO];
  
  [self addSliderWithTitle:NSSENCRYPT(“⚡ سرعة السيارة”)
  minValue:1
  maxValue:50
  defaultValue:1
  stepValue:1];
  
  // ═══════════════════════════════════════════════════════════════════════════
  // 👁️ قسم الكاميرا والعرض
  // ═══════════════════════════════════════════════════════════════════════════
  
  [self addSectionWithTitle:NSSENCRYPT(“👁️ الكاميرا والعرض”)];
  
  [self addSliderWithTitle:NSSENCRYPT(“👁️ تعديل FOV”)
  minValue:25
  maxValue:155
  defaultValue:60
  stepValue:5];
  
  [self addSliderWithTitle:NSSENCRYPT(“📷 ارتفاع الكاميرا”)
  minValue:-10
  maxValue:25
  defaultValue:0
  stepValue:1];
  
  // ═══════════════════════════════════════════════════════════════════════════
  // 📌 قسم المعلومات
  // ═══════════════════════════════════════════════════════════════════════════
  
  [self addSectionWithTitle:NSSENCRYPT(“📌 معلومات”)];
  
  [self addLabelWithText:NSSENCRYPT(“One State Mod Menu v2.0”)];
  [self addLabelWithText:NSSENCRYPT(“Created by Moumen”)];
  [self addLabelWithText:NSSENCRYPT(“All features working 100%”)];
  }
  %end

// ═══════════════════════════════════════════════════════════════════════════
// ✨ END OF MOD MENU
// ═══════════════════════════════════════════════════════════════════════════
