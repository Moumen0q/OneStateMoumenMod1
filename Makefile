# ═══════════════════════════════════════════════════════════════════════════
# ONE STATE - MOUMEN MOD MENU - MAKEFILE
# Theos Build Configuration
# ═══════════════════════════════════════════════════════════════════════════

THEOS_PACKAGE_SCHEME=rootless
TARGET = iphone:clang:latest:13.0
ARCHS = arm64 arm64e
GO_EASY_ON_ME = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = OneStateMoumenMod
OneStateMoumenMod_FILES = OneState_Mod_Menu.m
OneStateMoumenMod_CFLAGS = -fobjc-arc
OneStateMoumenMod_FRAMEWORKS = UIKit Foundation
OneStateMoumenMod_PRIVATE_FRAMEWORKS = 

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 'One State' || true"

