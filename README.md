# ih8sn

- ih8sn allows you to modify system properties at runtime.
- It can be installed with ADB root or recovery.
- If you want to add your device, do a PR with your device config.

## Disclaimer:

```
- The user takes sole responsibility for any damage that might arise due to use of this tool.
- This includes physical damage (to device), injury, data loss, and also legal matters.
- The developers cannot be held liable in any way for the use of this tool.
```

# Inline building.

### 1: Clone ih8sn repo.

```
git clone https://github.com/althafvly/ih8sn ih8sn
```

### 2: Include makefile.

```
$(call inherit-product-if-exists, ih8sn/product.mk)
```

### 3: Apply patches.

```
curl https://raw.githubusercontent.com/althafvly/ih8sn/master/patches/patch.sh | bash
```

## Requirements for recovery/adb root.

- Android platform tools
- Android device

# Installation

## 1: Download ih8sn.

Check the "Releases" section on the right. Make sure to download correct zip for your device `<arch>`.

- aarch64 = arm64
- armv7a = arm

## 2: Check if your device is supported in example_configs dir else create new.

- If your device isn't available in the list then follow below steps to create ih8sn config for your device.
- If your model has spaces, then it must be replaced with underscore.
- If your device isn't available in the list and you don't create ih8sn config for it, default config (system/etc/props.conf) will be used.

### Configure props.conf for your device.

- Create props.conf for your device and save it as props.conf.`<codename>` in etc.
  Example:

```
BUILD_DESCRIPTION=OnePlus7Pro-user 10 QKQ1.190716.003 1910071200 release-keys
BUILD_FINGERPRINT=OnePlus/OnePlus7Pro_EEA/OnePlus7Pro:10/QKQ1.190716.003/1910071200:user/release-keys
BUILD_SECURITY_PATCH_DATE=2019-09-05
BUILD_TAGS=release-keys
BUILD_TYPE=user
BUILD_VERSION_RELEASE=10
BUILD_VERSION_RELEASE_OR_CODENAME=10
DEBUGGABLE=0
FORCE_BASIC_ATTESTATION=0
MANUFACTURER_NAME=OnePlus
PRODUCT_BRAND=OnePlus
PRODUCT_DEVICE=OnePlus7Pro
PRODUCT_FIRST_API_LEVEL=29
PRODUCT_MODEL=OnePlus 7 Pro
PRODUCT_NAME=OnePlus7Pro
VENDOR_SECURITY_PATCH_DATE=2019-09-05
```

Default values:

```
BUILD_TAGS=release-keys
BUILD_TYPE=user
DEBUGGABLE=0
FORCE_BASIC_ATTESTATION=1
```

- Example configs of marlin and dipper

```
BUILD_FINGERPRINT=google/marlin/marlin:7.1.2/NJH47F/4146041:user/release-keys
MANUFACTURER_NAME=Google
PRODUCT_BRAND=google
PRODUCT_DEVICE=marlin
PRODUCT_MODEL=Pixel XL
PRODUCT_NAME=marlin
```

```
BUILD_FINGERPRINT=Xiaomi/dipper/dipper:8.1.0/OPM1.171019.011/V9.5.5.0.OEAMIFA:user/release-keys
```

Notes:

- If you set FORCE_BASIC_ATTESTATION=1, Patched `libkeystore-attestation-application-id.so` will also copied to your system. Patch can be found [here](patches)
- Default values will be set even if its not set. or its commented in the config, Set it if you want to override that.
- Use # or remove it from config to disable spoofing that property.
- You don't need to spoof all the properties.

## 3: Push the files to your device.

#### 1. ADB root.

- Extract ih8sn-`<arch>`.zip in your PC.
- Enable usb debugging and rooted debugging in developer options in your phone.

Run the script according to your system.

Linux (Install) :

```
./push.sh
```

Linux (Uninstall) :

```
./uninstall.sh
```

#### 2. Recovery method.

- Reboot to recovery and select Apply update -> Apply from ADB
- Run this in terminal to install.

```
adb sideload ih8sn-<arch>.zip
```

To uninstall.

```
adb sideload ih8sn-uninstaller.zip
```

## 4: Reboot your device.
