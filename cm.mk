# Boot animation
TARGET_SCREEN_HEIGHT := 1280
TARGET_SCREEN_WIDTH := 720

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Enhanced NFC
$(call inherit-product, vendor/cm/config/nfc_enhanced.mk)

# Inherit device configuration
$(call inherit-product, device/asus/A68/full_A68.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := A68
PRODUCT_NAME := cm_A68
PRODUCT_BRAND := Asus
PRODUCT_MODEL := Padfone 2
PRODUCT_MANUFACTURER := ASUS

PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=WWE_PadFone BUILD_FINGERPRINT=asus/WWE_PadFone/A68:4.4.2/KOT49H/WWE_PadFone-11:user/release-keys PRIVATE_BUILD_DESC="WWE_PadFone-user 4.4.2 KOT49H 937116 release-keys"

# Enable Torch
PRODUCT_PACKAGES += Torch

