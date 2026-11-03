#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

USES_DEVICE_VIRT_VIRTIO_X86_64 := true

# Boot manager
TARGET_BOOT_MANAGER ?= grub

# GRUB
TARGET_GRUB_ARCH := x86_64-efi
TARGET_GRUB_2ND_ARCH := i386-pc

# Inherit from common
include device/virt/virtio-common/BoardConfigCommon.mk

# Arch
TARGET_CPU_ABI := x86_64
TARGET_ARCH := x86_64
TARGET_ARCH_VARIANT := sandybridge

# Prebuilt apps (microG / F-Droid / Obtainium / DAVx5 / Calendula / ConnectYou)
# skip dexpreopt: dex2oat on a 100MB+ prebuilt APK is very memory hungry on this
# 16GB box, and the apps get background-dexopted after first boot anyway.
DONT_DEXPREOPT_PREBUILTS := true

# Boot manager
TARGET_GRUB_BOOT_CONFIGS += $(DEVICE_PATH)/bootmgr/grub/grub-boot.cfg

# Graphics (Allocator)
$(call soong_config_set_string_list,minigbm_upstream,cflags,-DDRV_I915 -DDRV_XE)

# Graphics (Mesa)
BOARD_MESA3D_GALLIUM_DRIVERS += crocus iris
BOARD_MESA3D_VULKAN_DRIVERS += intel intel_hasvk

# Mesa 25.3 counts iris/intel as "drivers using OpenCL" and therefore asks
# pkg-config for libclc, which does not exist in this tree (the meson cross
# file limits pkg-config to the generated stub .pc files). Use the prebuilt
# mesa_clc from prebuilts/mesa-build-dep instead of building it locally, the
# same way device/mainline/common/optional/mesa/board.mk does.
BOARD_MESA3D_MESON_ARGS += \
    -Dmesa-clc=system

# Kernel
BOARD_KERNEL_CMDLINE += \
    8250.nr_uarts=1

TARGET_KERNEL_CONFIG_EXT += \
    $(DEVICE_PATH)/configs/kernel/virtio_x86_64.config \
    $(DEVICE_PATH)/configs/kernel/kernelsu.config \
    $(DEVICE_PATH)/configs/kernel/passthrough_gpus.config \
    $(DEVICE_PATH)/configs/kernel/no-ibt.config

BOARD_KERNEL_IMAGE_NAME := bzImage
BOARD_LINUX_SERIAL_DEVICE := ttyS0
TARGET_KERNEL_ARCH := x86

# SELinux
BOARD_VENDOR_SEPOLICY_DIRS += \
    $(DEVICE_PATH)/sepolicy/vendor

# Virtual Machine template
TARGET_VM_UTM_TEMPLATE_DIR := $(DEVICE_PATH)/vm_templates/utm
