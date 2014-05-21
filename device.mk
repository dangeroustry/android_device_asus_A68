#
# Copyright (C) 2011 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This file includes all definitions that apply to ALL qcom devices, and
# are also specific to qcom devices
#
# Everything in this directory will become public

DEVICE_PACKAGE_OVERLAYS := device/asus/A68/overlay

# This device is xhdpi.  However the platform doesn't
# currently contain all of the bitmaps at xhdpi density so
# we do this little trick to fall back to the hdpi version
# if the xhdpi doesn't exist.
PRODUCT_AAPT_CONFIG := normal hdpi xhdpi
PRODUCT_AAPT_PREF_CONFIG := xhdpi

PRODUCT_PACKAGES := \
	lights.qcom

PRODUCT_PACKAGES += \
    charger_res_images \
    charger

# Live Wallpapers
PRODUCT_PACKAGES += \
        LiveWallpapers \
        LiveWallpapersPicker \
        VisualizationWallpapers \
        librs_jni

PRODUCT_COPY_FILES += \
	device/asus/A68/WCNSS_cfg.dat:system/vendor/firmware/wlan/prima/WCNSS_cfg.dat \
	device/asus/A68/WCNSS_qcom_cfg.ini:system/etc/wifi/WCNSS_qcom_cfg.ini \
	device/asus/A68/WCNSS_qcom_wlan_nv.bin:system/etc/wifi/WCNSS_qcom_wlan_nv.bin

PRODUCT_COPY_FILES += \
	device/asus/A68/snd_soc_msm_2x_Fusion3:system/etc/snd_soc_msm/snd_soc_msm_2x_Fusion3 \
	device/asus/A68/audio_policy.conf:system/etc/audio_policy.conf

PRODUCT_COPY_FILES += \
	device/asus/A68/mixer_paths.xml:system/etc/mixer_paths.xml

#thermal conf
PRODUCT_COPY_FILES += \
	device/asus/A68/rootdir/etc/thermald.conf:system/etc/thermald.conf \
	device/asus/A68/rootdir/etc/thermald-pad.conf:system/etc/thermald-pad.conf \
	device/asus/A68/rootdir/etc/thermald-ultimate-mode.conf:system/etc/thermald-ultimate-mode.conf \
	device/asus/A68/rootdir/etc/thermald-disabled-mode.conf:system/etc/thermald-disabled-mode.conf

# root dir init+sh file
PRODUCT_COPY_FILES += \
	device/asus/A68/rootdir/fstab.qcom:root/fstab.qcom \
	device/asus/A68/rootdir/init.asus.rc:root/init.asus.rc \
	device/asus/A68/rootdir/init.asus.thermald.rc:root/init.asus.thermald.rc \
	device/asus/A68/rootdir/init.asus.usb.rc:root/init.asus.usb.rc \
	device/asus/A68/rootdir/init.goldfish.rc:root/init.goldfish.rc \
	device/asus/A68/rootdir/init.qcom.rc:root/init.qcom.rc \
	device/asus/A68/rootdir/init.qcom.usb.rc:root/init.qcom.usb.rc \
	device/asus/A68/rootdir/init.rc:root/init.rc \
	device/asus/A68/rootdir/init.target.rc:root/init.target.rc \
	device/asus/A68/rootdir/init.trace.rc:root/init.trace.rc \
	device/asus/A68/rootdir/init.usb.rc:root/init.usb.rc \
	device/asus/A68/rootdir/ueventd.goldfish.rc:root/ueventd.goldfish.rc \
	device/asus/A68/rootdir/ueventd.qcom.rc:root/ueventd.qcom.rc \
	device/asus/A68/rootdir/ueventd.rc:root/ueventd.rc \
	device/asus/A68/rootdir/init.asus.sdcard.sh:root/init.asus.sdcard.sh \
	device/asus/A68/rootdir/init.qcom.class_core.sh:root/init.qcom.class_core.sh \
	device/asus/A68/rootdir/init.qcom.class_main.sh:root/init.qcom.class_main.sh \
	device/asus/A68/rootdir/init.qcom.sh:root/init.qcom.sh \
	device/asus/A68/rootdir/init.qcom.usb.sh:root/init.qcom.usb.sh \
	device/asus/A68/rootdir/etc/init.asus.audbg.sh:etc/init.asus.audbg.sh

# etc dir init+sh file
PRODUCT_COPY_FILES += \
	device/asus/A68/rootdir/etc/init.asus.check_asdf.sh:etc/init.asus.check_asdf.sh \
	device/asus/A68/rootdir/etc/init.asus.checkdatalog.sh:etc/init.asus.checkdatalog.sh \
	device/asus/A68/rootdir/etc/init.asus.evtlog.sh:etc/init.asus.evtlog.sh \
	device/asus/A68/rootdir/etc/init.asus.hcidump.sh:etc/init.asus.hcidump.sh \
	device/asus/A68/rootdir/etc/init.asus.kernelmessage.sh:etc/init.asus.kernelmessage.sh \
	device/asus/A68/rootdir/etc/init.asus.maxxaudio.sh:etc/init.asus.maxxaudio.sh \
	device/asus/A68/rootdir/etc/init.asus.p01dbg.sh:etc/init.asus.p01dbg.sh \
	device/asus/A68/rootdir/etc/init.asus.ramdump.sh:etc/init.asus.ramdump.sh \
	device/asus/A68/rootdir/etc/init.asus.rwctest.sh:etc/init.asus.rwctest.sh \
	device/asus/A68/rootdir/etc/init.asus.vibrator_voltage.sh:etc/init.asus.vibrator_voltage.sh \
	device/asus/A68/rootdir/etc/init.ath3k.bt.sh:etc/init.ath3k.bt.sh \
	device/asus/A68/rootdir/etc/init.goldfish.sh:etc/init.goldfish.sh \
	device/asus/A68/rootdir/etc/init.qcom.bt.sh:etc/init.qcom.bt.sh \
	device/asus/A68/rootdir/etc/init.qcom.coex.sh:etc/init.qcom.coex.sh \
	device/asus/A68/rootdir/etc/init.qcom.efs.sync.sh:etc/init.qcom.efs.sync.sh \
	device/asus/A68/rootdir/etc/init.qcom.fm.sh:etc/init.qcom.fm.sh \
	device/asus/A68/rootdir/etc/init.qcom.mdm_links.sh:etc/init.qcom.mdm_links.sh \
	device/asus/A68/rootdir/etc/init.qcom.modem_links.sh:etc/init.qcom.modem_links.sh \
	device/asus/A68/rootdir/etc/init.qcom.post_boot.sh:etc/init.qcom.post_boot.sh \
	device/asus/A68/rootdir/etc/init.qcom.post_fs.sh:etc/init.qcom.post_fs.sh \
	device/asus/A68/rootdir/etc/init.qcom.sdio.sh:etc/init.qcom.sdio.sh \
	device/asus/A68/rootdir/etc/init.qcom.thermald_conf.sh:etc/init.qcom.thermald_conf.sh \
	device/asus/A68/rootdir/etc/init.qcom.wifi.sh:etc/init.qcom.wifi.sh \
	device/asus/A68/rootdir/etc/onFgAppChanged.sh:etc/onFgAppChanged.sh \
	device/asus/A68/rootdir/etc/packlogs.sh:etc/packlogs.sh \
	device/asus/A68/rootdir/etc/prepare_asusdebug.sh:etc/prepare_asusdebug.sh \
	device/asus/A68/rootdir/etc/restore.sh:etc/restore.sh \
	device/asus/A68/rootdir/etc/savelogmtp.sh:etc/savelogmtp.sh \
	device/asus/A68/rootdir/etc/saveramdump.sh:etc/saveramdump.sh \
	device/asus/A68/rootdir/etc/thermald.conf:etc/thermald.conf \
	device/asus/A68/rootdir/etc/thermald-disabled-mode.conf:etc/thermald-disabled-mode.conf \
	device/asus/A68/rootdir/etc/thermald-pad.conf:etc/thermald-pad.conf \
	device/asus/A68/rootdir/etc/thermald-ultimate-mode.conf:etc/thermald-ultimate-mode.conf \
	device/asus/A68/rootdir/etc/usf_post_boot.sh:etc/usf_post_boot.sh \
	device/asus/A68/rootdir/etc/videoplay.sh:etc/videoplay.sh \
	device/asus/A68/rootdir/etc/web_browsing.sh:etc/web_browsing.sh \
	device/asus/A68/rootdir/etc/write_emmc.sh:etc/write_emmc.sh \

PRODUCT_COPY_FILES += \
	device/asus/A68/media_profiles.xml:system/etc/media_profiles.xml \
	device/asus/A68/media_codecs.xml:system/etc/media_codecs.xml
	
# Prebuilt kl and kcm keymaps
PRODUCT_COPY_FILES += \
	device/asus/A68/keypad_8064.kl:system/usr/keylayout/keypad_8960.kl \
	device/asus/A68/keypad_8064.kcm:system/usr/keychars/keypad_8960.kcm \


# Prebuilt input device calibration files
PRODUCT_COPY_FILES += \
	device/asus/A68/touch_dev.idc:system/usr/idc/touch_dev.idc

# These are the hardware-specific features
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
	frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
	frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
	frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
	frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
	frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
	frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
	frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
	frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
	frameworks/native/data/etc/android.hardware.sensor.barometer.xml:system/etc/permissions/android.hardware.sensor.barometer.xml \
	frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
	frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
	frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
	frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
	frameworks/native/data/etc/android.hardware.audio.low_latency.xml:system/etc/permissions/android.hardware.audio.low_latency.xml \
	frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml

# NFC packages
PRODUCT_PACKAGES += \
    nfc_nci.A68 \
    NfcNci \
    Tag \
    com.android.nfc_extras

# NFCEE access control
ifeq ($(TARGET_BUILD_VARIANT),user)
    NFCEE_ACCESS_PATH := device/asus/A68/nfc/nfcee_access.xml
else
    NFCEE_ACCESS_PATH := device/asus/A68/nfc/nfcee_access_debug.xml
endif

# NFC access control + feature files + configuration
PRODUCT_COPY_FILES += \
    $(NFCEE_ACCESS_PATH):system/etc/nfcee_access.xml \
    frameworks/native/data/etc/com.android.nfc_extras.xml:system/etc/permissions/com.android.nfc_extras.xml \
    frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml 


PRODUCT_PROPERTY_OVERRIDES += \
	ro.opengles.version=196608

PRODUCT_PROPERTY_OVERRIDES += \
	ro.sf.lcd_density=312

# Audio Configuration
# FIXME: Remove persist.audio.handset.mic and persist.audio.fluence.mode
#        while switching new audio HAL from legacy HAL
PRODUCT_PROPERTY_OVERRIDES += \
	persist.audio.handset.mic.type=digital \
	persist.audio.dualmic.config=endfire \
	persist.audio.fluence.voicecall=true \
	persist.audio.handset.mic=dmic \
	persist.audio.fluence.mode=endfire \
	persist.audio.lowlatency.rec=false \
	af.resampler.quality=4


# Do not power down SIM card when modem is sent to Low Power Mode.
PRODUCT_PROPERTY_OVERRIDES += \
	persist.radio.apm_sim_not_pwdn=1

# Ril sends only one RIL_UNSOL_CALL_RING, so set call_ring.multiple to false
PRODUCT_PROPERTY_OVERRIDES += \
	ro.telephony.call_ring.multiple=0

#Upto 3 layers can go through overlays
PRODUCT_PROPERTY_OVERRIDES += persist.hwc.mdpcomp.enable=true

PRODUCT_PROPERTY_OVERRIDES += ro.hardware=qcom

PRODUCT_CHARACTERISTICS := nosdcard

PRODUCT_TAGS += dalvik.gc.type-precise

PRODUCT_PACKAGES += \
	librs_jni \
	com.android.future.usb.accessory

# Filesystem management tools
PRODUCT_PACKAGES += \
	e2fsck

PRODUCT_PACKAGES += \
	libgenlock \
	liboverlay \
	hwcomposer.msm8960 \
	gralloc.msm8960 \
	copybit.msm8960 \
	memtrack.msm8960

PRODUCT_PACKAGES += \
	audio_policy.msm8960 \
	audio.primary.msm8960 \
	audio.a2dp.default \
	audio.usb.default \
	audio.r_submix.default \
	libaudio-resampler

# Voice processing
PRODUCT_PACKAGES += libqcomvoiceprocessing
PRODUCT_COPY_FILES += \
    device/asus/A68/audio_effects.conf:system/vendor/etc/audio_effects.conf

PRODUCT_PACKAGES += \
	hci_qcomm_init

PRODUCT_PACKAGES += \
	power.msm8960


PRODUCT_PROPERTY_OVERRIDES += \
	ro.qualcomm.bt.hci_transport=smd

PRODUCT_PACKAGES += \
	camera.msm8960 \
	libmmcamera_interface2 \
	libmmcamera_interface

PRODUCT_PACKAGES += \
    libmm-omxcore \
	libdivxdrmdecrypt \
	libOmxVdec \
	libOmxVenc \
	libOmxCore \
	libstagefrighthw \
	libc2dcolorconvert

# GPS configuration
PRODUCT_COPY_FILES += \
        device/asus/A68/gps.conf:system/etc/gps.conf

# GPS
PRODUCT_PACKAGES += \
        libloc_adapter \
        libloc_eng \
        libloc_api_v02 \
        libloc_ds_api \
        libloc_core \
        libizat_core \
        libgeofence \
        libgps.utils \
        gps.msm8960 \
        flp.msm8960

PRODUCT_PACKAGES += \
	bdAddrLoader \
	libwfcu \
	conn_init

PRODUCT_PACKAGES += \
	keystore.msm8960

PRODUCT_PACKAGES += \
	hostapd_default.conf \
	wpa_supplicant_overlay.conf \
	p2p_supplicant_overlay.conf

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
	rild.libpath=/system/lib/libril-qc-qmi-1.so

PRODUCT_PROPERTY_OVERRIDES += \
	telephony.lteOnCdmaDevice=1
	telephony.lteOnGsmDevice=1

PRODUCT_PROPERTY_OVERRIDES += \
	drm.service.enabled=true

PRODUCT_PROPERTY_OVERRIDES += \
	wifi.interface=wlan0 \
	wifi.supplicant_scan_interval=15

# Enable AAC 5.1 output
PRODUCT_PROPERTY_OVERRIDES += \
    media.aac_51_output_enabled=true

PRODUCT_PROPERTY_OVERRIDES += \
        debug.egl.recordable.rgba8888=1

PRODUCT_PROPERTY_OVERRIDES += \
	ro.qc.sensors.wl_dis=true \
	ro.qualcomm.sensors.smd=true

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
	persist.sys.usb.config=mtp

# Hardware codecs
PRODUCT_PROPERTY_OVERRIDES += \
    qcom.hw.aac.encoder=true

PRODUCT_PACKAGES += \
    libOmxAacEnc \
    libOmxAmrEnc \
    libOmxEvrcEnc \
    libOmxQcelp13Enc

# QRNGD
PRODUCT_PACKAGES += qrngd

$(call inherit-product, frameworks/native/build/phone-xhdpi-2048-dalvik-heap.mk)

# This is the A68-specific audio package
$(call inherit-product, frameworks/base/data/sounds/AudioPackage10.mk)

$(call inherit-product, hardware/qcom/msm8960/msm8960.mk)
