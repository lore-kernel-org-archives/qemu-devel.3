Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C8D8CD379F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 16:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slW4p-0005m7-0p; Tue, 03 Sep 2024 12:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW4l-0005VT-EJ
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:08:15 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW4h-0002ix-Nn
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:08:14 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42bb81e795bso45456515e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 09:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725379690; x=1725984490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fBVF/JugwgOMfdgy7gC72oIyysi6l06cymbWqbyXhO0=;
 b=I/J82sytc0i0+/OOdtG1BcW/+LXPg/QJGdmx8OQZ6IHI6UfRaJFaGt2OVdEklLmyLv
 8h97DQplhNPOK38d8A111sgcTCZrf6zvVaKaJYIE16pIKLuWXiT3P1WzRvAEPSKYbbkn
 HuaDafltVw+rahHKN86q+cKqaNNS7g8PUfeNteW5BushwiNthNSkIoMJ2Dpl0T43b31r
 G/CCZEvju9d4lN+a5ZYxhSg7ypVOEpmjeYqXY0Fqen7ttyEhZKL3jzcHbqsnKBMJGyyY
 4XHEc40d1CZLOA9wtj+ZGhQ/1C/LHncxfKXw6+oXHo6pVViKEcUkLv8KGvUA5ROy1U7i
 ACxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725379690; x=1725984490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fBVF/JugwgOMfdgy7gC72oIyysi6l06cymbWqbyXhO0=;
 b=DjCx+DJZzUD4bw+O7nxNjtbHDWlkI3S8wNq/F0nIQxup9pTZtFrU4bG9NqcCVH5z0b
 k4Ri50Txh7wuUOT5HWwj1ejJP4TEF7tSiE7VYy3fK5yUnZ9y1fb3xVfivGyuUkxfNaFA
 YZ45WWynZE77mZ9N1y7IxJeSF/LHlx2IqK7XHT3i5EOdpeSZBjwsDlY7bpF+tktm7hx2
 k4XtjzWmCwXHcX9K+G/r2RAFTGyVY+ZzUbUu70Uwr2hhUZs5mL8aX8aUpblBt2S+PO3z
 vu8sOKzpXuJVgots7m4CJ/BBzh/pEfVEBxOchsbnjx2SGp3gnH1c4wyuXb64gTGGR5J9
 V55Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3LMZWehClwY62hlJ3zWXtzYdgrDOkocfY4mYUgGSO4oANEYdXlJVjralfybSMLGV8oFrb99pHDR4K@nongnu.org
X-Gm-Message-State: AOJu0Yya1d6UTFXocpAOZ4+ybWxwm0IGLXqWoIyqqlEzS78c/z0GQoBh
 oavg0PqYB4euCAs01VtxrxSfAl5TSVgNlzTXmLi3V8wAIgp/DrBmGrG9G/rgCaI=
X-Google-Smtp-Source: AGHT+IFAQmCbeZ0S3TTLPtcGu8G2kZNzsuJpqZSmLuq65lF7Z1s1RnfxUy639t5QincOddBB/LZolQ==
X-Received: by 2002:a05:600c:3c9e:b0:426:627e:37af with SMTP id
 5b1f17b1804b1-42bbb10d2d5mr98667595e9.3.1725379689902; 
 Tue, 03 Sep 2024 09:08:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df1066sm175123065e9.18.2024.09.03.09.08.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 09:08:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-9.2 08/53] hw/arm: Remove 'cheetah' machine
Date: Tue,  3 Sep 2024 17:07:06 +0100
Message-Id: <20240903160751.4100218-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903160751.4100218-1-peter.maydell@linaro.org>
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The 'cheetah' machine has been deprecated since 9.0, so we can
remove it for the 9.2 release.

(tsc210x.c is also used by nseries, so move its MAINTAINER file
line there; the nseries boards are also about to be removed.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                             |  10 +-
 docs/system/arm/palm.rst                |  23 --
 docs/system/target-arm.rst              |   1 -
 configs/devices/arm-softmmu/default.mak |   1 -
 hw/arm/palm.c                           | 324 ------------------------
 hw/arm/Kconfig                          |   7 -
 hw/arm/meson.build                      |   1 -
 7 files changed, 1 insertion(+), 366 deletions(-)
 delete mode 100644 docs/system/arm/palm.rst
 delete mode 100644 hw/arm/palm.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 52bf3a22e01..cf297e6d626 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -879,6 +879,7 @@ F: hw/arm/nseries.c
 F: hw/display/blizzard.c
 F: hw/input/lm832x.c
 F: hw/input/tsc2005.c
+F: hw/input/tsc210x.c
 F: hw/misc/cbus.c
 F: hw/rtc/twl92230.c
 F: include/hw/display/blizzard.h
@@ -888,15 +889,6 @@ F: include/hw/misc/cbus.h
 F: tests/avocado/machine_arm_n8x0.py
 F: docs/system/arm/nseries.rst
 
-Palm
-M: Peter Maydell <peter.maydell@linaro.org>
-L: qemu-arm@nongnu.org
-S: Odd Fixes
-F: hw/arm/palm.c
-F: hw/input/tsc210x.c
-F: include/hw/input/tsc2xxx.h
-F: docs/system/arm/palm.rst
-
 Raspberry Pi
 M: Peter Maydell <peter.maydell@linaro.org>
 R: Philippe Mathieu-Daudé <philmd@linaro.org>
diff --git a/docs/system/arm/palm.rst b/docs/system/arm/palm.rst
deleted file mode 100644
index 61bc8d34f40..00000000000
--- a/docs/system/arm/palm.rst
+++ /dev/null
@@ -1,23 +0,0 @@
-Palm Tungsten|E PDA (``cheetah``)
-=================================
-
-The Palm Tungsten|E PDA (codename \"Cheetah\") emulation includes the
-following elements:
-
--  Texas Instruments OMAP310 System-on-chip (ARM925T core)
-
--  ROM and RAM memories (ROM firmware image can be loaded with
-   -option-rom)
-
--  On-chip LCD controller
-
--  On-chip Real Time Clock
-
--  TI TSC2102i touchscreen controller / analog-digital converter /
-   Audio CODEC, connected through MicroWire and |I2S| buses
-
--  GPIO-connected matrix keypad
-
--  Secure Digital card connected to OMAP MMC/SD host
-
--  Three on-chip UARTs
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index 326b69502b5..fde37385224 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -99,7 +99,6 @@ undocumented; you can get a complete list by running
    arm/nuvoton
    arm/imx25-pdk
    arm/orangepi
-   arm/palm
    arm/raspi
    arm/collie
    arm/sx1
diff --git a/configs/devices/arm-softmmu/default.mak b/configs/devices/arm-softmmu/default.mak
index 4cbe04ffbf1..6ed821be220 100644
--- a/configs/devices/arm-softmmu/default.mak
+++ b/configs/devices/arm-softmmu/default.mak
@@ -18,7 +18,6 @@
 # CONFIG_MUSICPAL=n
 # CONFIG_MPS3R=n
 # CONFIG_MUSCA=n
-# CONFIG_CHEETAH=n
 # CONFIG_SX1=n
 # CONFIG_NSERIES=n
 # CONFIG_STELLARIS=n
diff --git a/hw/arm/palm.c b/hw/arm/palm.c
deleted file mode 100644
index e04ac92eb7f..00000000000
--- a/hw/arm/palm.c
+++ /dev/null
@@ -1,324 +0,0 @@
-/*
- * PalmOne's (TM) PDAs.
- *
- * Copyright (C) 2006-2007 Andrzej Zaborowski  <balrog@zabor.org>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 or
- * (at your option) version 3 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#include "qemu/osdep.h"
-#include "qapi/error.h"
-#include "audio/audio.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/qtest.h"
-#include "ui/console.h"
-#include "hw/arm/omap.h"
-#include "hw/boards.h"
-#include "hw/arm/boot.h"
-#include "hw/input/tsc2xxx.h"
-#include "hw/irq.h"
-#include "hw/loader.h"
-#include "qemu/cutils.h"
-#include "qom/object.h"
-#include "qemu/error-report.h"
-
-
-static uint64_t static_read(void *opaque, hwaddr offset, unsigned size)
-{
-    uint32_t *val = (uint32_t *)opaque;
-    uint32_t sizemask = 7 >> size;
-
-    return *val >> ((offset & sizemask) << 3);
-}
-
-static void static_write(void *opaque, hwaddr offset, uint64_t value,
-                         unsigned size)
-{
-#ifdef SPY
-    printf("%s: value %08lx written at " PA_FMT "\n",
-                    __func__, value, offset);
-#endif
-}
-
-static const MemoryRegionOps static_ops = {
-    .read = static_read,
-    .write = static_write,
-    .valid.min_access_size = 1,
-    .valid.max_access_size = 4,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-};
-
-/* Palm Tunsgten|E support */
-
-/* Shared GPIOs */
-#define PALMTE_USBDETECT_GPIO   0
-#define PALMTE_USB_OR_DC_GPIO   1
-#define PALMTE_TSC_GPIO                 4
-#define PALMTE_PINTDAV_GPIO     6
-#define PALMTE_MMC_WP_GPIO      8
-#define PALMTE_MMC_POWER_GPIO   9
-#define PALMTE_HDQ_GPIO                 11
-#define PALMTE_HEADPHONES_GPIO  14
-#define PALMTE_SPEAKER_GPIO     15
-/* MPU private GPIOs */
-#define PALMTE_DC_GPIO          2
-#define PALMTE_MMC_SWITCH_GPIO  4
-#define PALMTE_MMC1_GPIO        6
-#define PALMTE_MMC2_GPIO        7
-#define PALMTE_MMC3_GPIO        11
-
-static MouseTransformInfo palmte_pointercal = {
-    .x = 320,
-    .y = 320,
-    .a = { -5909, 8, 22465308, 104, 7644, -1219972, 65536 },
-};
-
-static void palmte_microwire_setup(struct omap_mpu_state_s *cpu)
-{
-    uWireSlave *tsc;
-
-    tsc = tsc2102_init(qdev_get_gpio_in(cpu->gpio, PALMTE_PINTDAV_GPIO));
-
-    omap_uwire_attach(cpu->microwire, tsc, 0);
-    omap_mcbsp_i2s_attach(cpu->mcbsp1, tsc210x_codec(tsc));
-
-    tsc210x_set_transform(tsc, &palmte_pointercal);
-}
-
-static struct {
-    int row;
-    int column;
-} palmte_keymap[0x80] = {
-    [0 ... 0x7f] = { -1, -1 },
-    [0x3b] = { 0, 0 },  /* F1   -> Calendar */
-    [0x3c] = { 1, 0 },  /* F2   -> Contacts */
-    [0x3d] = { 2, 0 },  /* F3   -> Tasks List */
-    [0x3e] = { 3, 0 },  /* F4   -> Note Pad */
-    [0x01] = { 4, 0 },  /* Esc  -> Power */
-    [0x4b] = { 0, 1 },  /*         Left */
-    [0x50] = { 1, 1 },  /*         Down */
-    [0x48] = { 2, 1 },  /*         Up */
-    [0x4d] = { 3, 1 },  /*         Right */
-    [0x4c] = { 4, 1 },  /*         Centre */
-    [0x39] = { 4, 1 },  /* Spc  -> Centre */
-};
-
-static void palmte_button_event(void *opaque, int keycode)
-{
-    struct omap_mpu_state_s *cpu = opaque;
-
-    if (palmte_keymap[keycode & 0x7f].row != -1)
-        omap_mpuio_key(cpu->mpuio,
-                        palmte_keymap[keycode & 0x7f].row,
-                        palmte_keymap[keycode & 0x7f].column,
-                        !(keycode & 0x80));
-}
-
-/*
- * Encapsulation of some GPIO line behaviour for the Palm board
- *
- * QEMU interface:
- *  + unnamed GPIO inputs 0..6: for the various miscellaneous input lines
- */
-
-#define TYPE_PALM_MISC_GPIO "palm-misc-gpio"
-OBJECT_DECLARE_SIMPLE_TYPE(PalmMiscGPIOState, PALM_MISC_GPIO)
-
-struct PalmMiscGPIOState {
-    SysBusDevice parent_obj;
-};
-
-static void palmte_onoff_gpios(void *opaque, int line, int level)
-{
-    switch (line) {
-    case 0:
-        printf("%s: current to MMC/SD card %sabled.\n",
-                        __func__, level ? "dis" : "en");
-        break;
-    case 1:
-        printf("%s: internal speaker amplifier %s.\n",
-                        __func__, level ? "down" : "on");
-        break;
-
-    /* These LCD & Audio output signals have not been identified yet.  */
-    case 2:
-    case 3:
-    case 4:
-        printf("%s: LCD GPIO%i %s.\n",
-                        __func__, line - 1, level ? "high" : "low");
-        break;
-    case 5:
-    case 6:
-        printf("%s: Audio GPIO%i %s.\n",
-                        __func__, line - 4, level ? "high" : "low");
-        break;
-    }
-}
-
-static void palm_misc_gpio_init(Object *obj)
-{
-    DeviceState *dev = DEVICE(obj);
-
-    qdev_init_gpio_in(dev, palmte_onoff_gpios, 7);
-}
-
-static const TypeInfo palm_misc_gpio_info = {
-    .name = TYPE_PALM_MISC_GPIO,
-    .parent = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(PalmMiscGPIOState),
-    .instance_init = palm_misc_gpio_init,
-    /*
-     * No class init required: device has no internal state so does not
-     * need to set up reset or vmstate, and has no realize method.
-     */
-};
-
-static void palmte_gpio_setup(struct omap_mpu_state_s *cpu)
-{
-    DeviceState *misc_gpio;
-
-    misc_gpio = sysbus_create_simple(TYPE_PALM_MISC_GPIO, -1, NULL);
-
-    omap_mmc_handlers(cpu->mmc,
-                    qdev_get_gpio_in(cpu->gpio, PALMTE_MMC_WP_GPIO),
-                    qemu_irq_invert(omap_mpuio_in_get(cpu->mpuio)
-                            [PALMTE_MMC_SWITCH_GPIO]));
-
-    qdev_connect_gpio_out(cpu->gpio, PALMTE_MMC_POWER_GPIO,
-                          qdev_get_gpio_in(misc_gpio, 0));
-    qdev_connect_gpio_out(cpu->gpio, PALMTE_SPEAKER_GPIO,
-                          qdev_get_gpio_in(misc_gpio, 1));
-    qdev_connect_gpio_out(cpu->gpio, 11, qdev_get_gpio_in(misc_gpio, 2));
-    qdev_connect_gpio_out(cpu->gpio, 12, qdev_get_gpio_in(misc_gpio, 3));
-    qdev_connect_gpio_out(cpu->gpio, 13, qdev_get_gpio_in(misc_gpio, 4));
-    omap_mpuio_out_set(cpu->mpuio, 1, qdev_get_gpio_in(misc_gpio, 5));
-    omap_mpuio_out_set(cpu->mpuio, 3, qdev_get_gpio_in(misc_gpio, 6));
-
-    /* Reset some inputs to initial state.  */
-    qemu_irq_lower(qdev_get_gpio_in(cpu->gpio, PALMTE_USBDETECT_GPIO));
-    qemu_irq_lower(qdev_get_gpio_in(cpu->gpio, PALMTE_USB_OR_DC_GPIO));
-    qemu_irq_lower(qdev_get_gpio_in(cpu->gpio, 4));
-    qemu_irq_lower(qdev_get_gpio_in(cpu->gpio, PALMTE_HEADPHONES_GPIO));
-    qemu_irq_lower(omap_mpuio_in_get(cpu->mpuio)[PALMTE_DC_GPIO]);
-    qemu_irq_raise(omap_mpuio_in_get(cpu->mpuio)[6]);
-    qemu_irq_raise(omap_mpuio_in_get(cpu->mpuio)[7]);
-    qemu_irq_raise(omap_mpuio_in_get(cpu->mpuio)[11]);
-}
-
-static struct arm_boot_info palmte_binfo = {
-    .loader_start = OMAP_EMIFF_BASE,
-    .ram_size = 0x02000000,
-    .board_id = 0x331,
-};
-
-static void palmte_init(MachineState *machine)
-{
-    MemoryRegion *address_space_mem = get_system_memory();
-    struct omap_mpu_state_s *mpu;
-    int flash_size = 0x00800000;
-    static uint32_t cs0val = 0xffffffff;
-    static uint32_t cs1val = 0x0000e1a0;
-    static uint32_t cs2val = 0x0000e1a0;
-    static uint32_t cs3val = 0xe1a0e1a0;
-    int rom_size, rom_loaded = 0;
-    MachineClass *mc = MACHINE_GET_CLASS(machine);
-    MemoryRegion *flash = g_new(MemoryRegion, 1);
-    MemoryRegion *cs = g_new(MemoryRegion, 4);
-
-    if (machine->ram_size != mc->default_ram_size) {
-        char *sz = size_to_str(mc->default_ram_size);
-        error_report("Invalid RAM size, should be %s", sz);
-        g_free(sz);
-        exit(EXIT_FAILURE);
-    }
-
-    memory_region_add_subregion(address_space_mem, OMAP_EMIFF_BASE,
-                                machine->ram);
-
-    mpu = omap310_mpu_init(machine->ram, machine->cpu_type);
-
-    /* External Flash (EMIFS) */
-    memory_region_init_rom(flash, NULL, "palmte.flash", flash_size,
-                           &error_fatal);
-    memory_region_add_subregion(address_space_mem, OMAP_CS0_BASE, flash);
-
-    memory_region_init_io(&cs[0], NULL, &static_ops, &cs0val, "palmte-cs0",
-                          OMAP_CS0_SIZE - flash_size);
-    memory_region_add_subregion(address_space_mem, OMAP_CS0_BASE + flash_size,
-                                &cs[0]);
-    memory_region_init_io(&cs[1], NULL, &static_ops, &cs1val, "palmte-cs1",
-                          OMAP_CS1_SIZE);
-    memory_region_add_subregion(address_space_mem, OMAP_CS1_BASE, &cs[1]);
-    memory_region_init_io(&cs[2], NULL, &static_ops, &cs2val, "palmte-cs2",
-                          OMAP_CS2_SIZE);
-    memory_region_add_subregion(address_space_mem, OMAP_CS2_BASE, &cs[2]);
-    memory_region_init_io(&cs[3], NULL, &static_ops, &cs3val, "palmte-cs3",
-                          OMAP_CS3_SIZE);
-    memory_region_add_subregion(address_space_mem, OMAP_CS3_BASE, &cs[3]);
-
-    palmte_microwire_setup(mpu);
-
-    qemu_add_kbd_event_handler(palmte_button_event, mpu);
-
-    palmte_gpio_setup(mpu);
-
-    /* Setup initial (reset) machine state */
-    if (nb_option_roms) {
-        rom_size = get_image_size(option_rom[0].name);
-        if (rom_size > flash_size) {
-            fprintf(stderr, "%s: ROM image too big (%x > %x)\n",
-                            __func__, rom_size, flash_size);
-            rom_size = 0;
-        }
-        if (rom_size > 0) {
-            rom_size = load_image_targphys(option_rom[0].name, OMAP_CS0_BASE,
-                                           flash_size);
-            rom_loaded = 1;
-        }
-        if (rom_size < 0) {
-            fprintf(stderr, "%s: error loading '%s'\n",
-                            __func__, option_rom[0].name);
-        }
-    }
-
-    if (!rom_loaded && !machine->kernel_filename && !qtest_enabled()) {
-        fprintf(stderr, "Kernel or ROM image must be specified\n");
-        exit(1);
-    }
-
-    /* Load the kernel.  */
-    arm_load_kernel(mpu->cpu, machine, &palmte_binfo);
-}
-
-static void palmte_machine_init(MachineClass *mc)
-{
-    mc->desc = "Palm Tungsten|E aka. Cheetah PDA (OMAP310)";
-    mc->init = palmte_init;
-    mc->ignore_memory_transaction_failures = true;
-    mc->default_cpu_type = ARM_CPU_TYPE_NAME("ti925t");
-    mc->default_ram_size = 0x02000000;
-    mc->default_ram_id = "omap1.dram";
-    mc->deprecation_reason = "machine is old and unmaintained";
-
-    machine_add_audiodev_property(mc);
-}
-
-DEFINE_MACHINE("cheetah", palmte_machine_init)
-
-static void palm_register_types(void)
-{
-    type_register_static(&palm_misc_gpio_info);
-}
-
-type_init(palm_register_types)
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index c8c57497c5b..3261618ea74 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -37,13 +37,6 @@ config ARM_VIRT
     select ACPI_CXL
     select ACPI_HMAT
 
-config CHEETAH
-    bool
-    default y
-    depends on TCG && ARM
-    select OMAP
-    select TSC210X
-
 config CUBIEBOARD
     bool
     default y
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index b099319a223..4a8fd54586b 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -62,7 +62,6 @@ arm_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
 arm_ss.add(when: 'CONFIG_XEN', if_true: files('xen_arm.c'))
 
 system_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmu-common.c'))
-system_ss.add(when: 'CONFIG_CHEETAH', if_true: files('palm.c'))
 system_ss.add(when: 'CONFIG_COLLIE', if_true: files('collie.c'))
 system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4_boards.c'))
 system_ss.add(when: 'CONFIG_GUMSTIX', if_true: files('gumstix.c'))
-- 
2.34.1


