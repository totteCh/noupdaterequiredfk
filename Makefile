ARCHS = arm64
TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = fkapp2


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = NoUpdateRequiredFK

NoUpdateRequiredFK_FILES = Tweak.x
NoUpdateRequiredFK_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
