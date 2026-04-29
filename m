Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1F9FF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 23:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEQZ-0004pp-8S; Wed, 29 Apr 2026 19:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ericsonjoseph@gmail.com>)
 id 1wICoh-00010i-5l
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:51:35 -0400
Received: from mail-dy1-x132c.google.com ([2607:f8b0:4864:20::132c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ericsonjoseph@gmail.com>)
 id 1wICob-0004HY-Dq
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:51:34 -0400
Received: by mail-dy1-x132c.google.com with SMTP id
 5a478bee46e88-2bdd40d3c61so397587eec.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 14:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777499488; x=1778104288; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UMLAZrBshk7lDmkr+EUehCw1mWT2Ux6/wmvWENJvKdo=;
 b=Et3bubPycNu71sUhI8J0aBr/Mt36qCRfENDBUxKQDk4SVJ09YL6F1rMuwmwKzP0W44
 r2pqEoj8b06euqMvgHNISJCKmwQcXErwfQkog8YeyeSp3JCi5EeY1CDNke0i9VZMkrNx
 +cPD+LhbtdmS+SYm4OJQ8eadt80Docj8p8ryv8LyP79+PNSftMKAkfErVTekLEqLVDx+
 KifDI7H/Qx8kjPIq/kG/R9niZIbLGO5Sx3S9+mYt79yRq0f3gRMLUoV9fI/GhChMvMSK
 R/K85BBTe3X+Tg+WELm3FTPcLrshrVEf68ZjLKFufHN2ee3mNT1+GZmTbYQgtL4cYI5s
 zBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777499488; x=1778104288;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UMLAZrBshk7lDmkr+EUehCw1mWT2Ux6/wmvWENJvKdo=;
 b=kMeeFZA7RnrPgvE8CO5rsg8kcm8HGGJh24gW+KZRgpIDjvAW2Y+sT7AIotZJT4XCsp
 W96eG2a3sXdjNcbCfMJccfzTo5+O7dUVkVOjj4DcEK00h8RcKQxNJBzKCiPNBjHY1Wto
 HlL9g4r6Pmx2tn5yXfIpePvygbvfVrzfnGoBPKNWnyfcVxbVZkYC8Gf9K9likx5MtbiR
 5yilm4TzqrYxHA87w5y1JS7B5U4mGLd7Z+Syxb/lFbSDyZHJ1yHUKNZSGJ/bM3FGddVP
 c6gFW+Naue8b9cmfnkV8V/JLVU5pZDBO5NUH/R1/9Y7X2pxtFzmc6nCwMy4UmYpSuU18
 RcCA==
X-Gm-Message-State: AOJu0Yy7fV5bRH+UOxCbaNvSBK9u7XFVsdEiMy8Zmcc76xut2C6oX2RM
 ysUMDdx5xXPN2meZIHpuazOpS1x8qWRhSOrtzvwI7HtE+ByDZKR4CCyt
X-Gm-Gg: AeBDieuBhEvwpBUGWOtEiQKXaCsj5D0l6VQ4mSUQRVmGoVy66bmvcw/OV4EZ0qmrhZi
 EiE5TX59DXSFgZ2Ttaos0pt67bbFDLWH70m/f5FQtPqeIQpdWau++rMlbrIojKxjYSDi7uMbLbj
 EqnHZ4N4J5iVM+Q+Iieva5SU5CqUITaG38FZiCvj+7uF4F6WBqXl0Xcn1fjr+OhBjgi7WXlMFag
 UZia6gyqnXqze+r5NP94ZzfX9l3h35/p11LAwnRLZ/QYGAR73hpGIDNLd9dYzSXE5NyMzPQVAgC
 gfEoha4OtaWMbzh55oKLW0GC0EuGihumhDdIFpICTHsOSV56K3+do9kFHA1WvLQg2uZDgcG3nvB
 vir3VUTv5I4jM5Wr50F1mwoDbNoASZij8QzYq0QnXk9tpbKgu2PrbkPk/JsRCNR4asIw1OrTzmG
 2ngZgSZDxPFRwgyHpWrPuWjrRS1vniq/FzVAKWE0y9
X-Received: by 2002:a05:7301:3d11:b0:2d1:9b35:4ed3 with SMTP id
 5a478bee46e88-2ed3e67f822mr46261eec.28.1777499486963; 
 Wed, 29 Apr 2026 14:51:26 -0700 (PDT)
Received: from [127.0.1.1] ([2803:9800:9001:c4f0:5d16:7dac:ff8:d8ff])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1bf6d315sm4353878eec.1.2026.04.29.14.51.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 14:51:25 -0700 (PDT)
From: Ericson Joseph <ericsonjoseph@gmail.com>
Date: Wed, 29 Apr 2026 18:51:17 -0300
Subject: [PATCH RFC 1/3] hw/mips: add Microchip PIC32MK GPK/MCM board
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260429-pic32mk-board-support-v1-1-1dfac14f8e2d@voltumotor.com>
References: <20260429-pic32mk-board-support-v1-0-1dfac14f8e2d@voltumotor.com>
In-Reply-To: <20260429-pic32mk-board-support-v1-0-1dfac14f8e2d@voltumotor.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Ericson Joseph <ericsonjoseph@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::132c;
 envelope-from=ericsonjoseph@gmail.com; helo=mail-dy1-x132c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 29 Apr 2026 19:34:45 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add emulation for the Microchip PIC32MK GPK/MCM family of 32-bit MIPS
microcontrollers (DS60001519E). The family uses a MIPS32 microAptiv MCU
core running at up to 120 MHz with 256 KB SRAM and 1 MB program flash.

The following peripherals are modelled:

  - EVIC  — 216-source interrupt controller with SET/CLR/INV registers,
             single-vector and multi-vector modes, and OFFx vector offsets
  - UART  — 6 instances with TX/RX FIFOs and interrupt generation;
             UART1 wired to the first serial port
  - Timer — 9 instances using QEMU ptimer; Timer1 drives a 1 kHz tick
  - GPIO  — 7 ports (A–G) with TRIS/LAT/PORT/ANSEL/CNPU/CNPD registers
  - SPI   — 6 instances including master and slave modes
  - I2C   — 4 instances (register-level stub, interrupt capable)
  - DMA   — 8 channels with CELL/BLOCK/PATTERN transfer modes
  - CAN FD — 4 instances exposed via QEMU can-bus; SocketCAN accessible
             with -object can-bus,id=canbus<n>
  - USB   — 2 Full-Speed OTG instances exposed as chardev PTY
  - ADC   — ADCHS high-speed 12-bit ADC with 7 cores and FIFO
  - NVM   — Flash controller with backed host-file support for persistence
  - DataEE — Software data EEPROM layer over program flash
  - OC    — 16 Output Compare units
  - IC    — 16 Input Capture units
  - CRU   — Clock and Reset Unit (SYSCLK, PBCLK, RCON, RSWRST)
  - WDT   — Watchdog timer (write-once WDTKEY protocol)
  - CFG   — Configuration registers and SYSKEY unlock sequence

All unimplemented SFR ranges log LOG_UNIMP rather than silently ignoring
accesses. The SET (+4), CLR (+8), and INV (+C) sub-register convention
is implemented for all peripheral register banks.

The boot ROM at 0xBFC00000 contains a j 0xBFC40000 trampoline; firmware
is loaded into Boot Flash 1 at physical 0x1FC40000 via -bios.

Reference: Microchip DS60001519E (publicly available from microchip.com)

Signed-off-by: Ericson Joseph <ericsonjoseph@gmail.com>
---
 MAINTAINERS                                |    9 +
 configs/targets/mipsel-softmmu.mak         |    1 +
 hw/mips/Kconfig                            |    8 +
 hw/mips/meson.build                        |   21 +
 hw/mips/pic32mk.c                          |  815 ++++++++++++++++++++
 hw/mips/pic32mk_adchs.c                    |  583 ++++++++++++++
 hw/mips/pic32mk_canfd.c                    | 1143 ++++++++++++++++++++++++++++
 hw/mips/pic32mk_cfg.c                      |  247 ++++++
 hw/mips/pic32mk_cru.c                      |  375 +++++++++
 hw/mips/pic32mk_dataee.c                   |  463 +++++++++++
 hw/mips/pic32mk_dma.c                      |  255 +++++++
 hw/mips/pic32mk_evic.c                     |  399 ++++++++++
 hw/mips/pic32mk_gpio.c                     |  418 ++++++++++
 hw/mips/pic32mk_i2c.c                      |  184 +++++
 hw/mips/pic32mk_ic.c                       |  384 ++++++++++
 hw/mips/pic32mk_nvm.c                      |  572 ++++++++++++++
 hw/mips/pic32mk_oc.c                       |  293 +++++++
 hw/mips/pic32mk_spi.c                      |  532 +++++++++++++
 hw/mips/pic32mk_timer.c                    |  294 +++++++
 hw/mips/pic32mk_uart.c                     |  334 ++++++++
 hw/mips/pic32mk_usb.c                      | 1033 +++++++++++++++++++++++++
 hw/mips/pic32mk_wdt.c                      |  230 ++++++
 include/hw/mips/pic32mk.h                  |  952 +++++++++++++++++++++++
 include/hw/mips/pic32mk_adchs.h            |   87 +++
 include/hw/mips/pic32mk_canfd.h            |  210 +++++
 include/hw/mips/pic32mk_evic.h             |   45 ++
 include/hw/mips/pic32mk_usb.h              |  181 +++++
 tests/functional/mipsel/pic32mk_test_fw.S  |   64 ++
 tests/functional/mipsel/pic32mk_test_fw.ld |   20 +
 tests/functional/mipsel/test_pic32mk.py    |   92 +++
 tests/qtest/pic32mk-canfd-test.c           |  411 ++++++++++
 tests/qtest/pic32mk-test.c                 |  457 +++++++++++
 32 files changed, 11112 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 49f9bce818..5321eea58d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1506,6 +1506,15 @@ F: hw/mips/boston.c
 F: hw/pci-host/xilinx-pcie.c
 F: include/hw/pci-host/xilinx-pcie.h
 
+Microchip PIC32MK GPK/MCM
+M: Ericson Joseph <ericsonjoseph@gmail.com>
+S: Maintained
+F: hw/mips/pic32mk*.c
+F: hw/mips/pic32mk*.h
+F: include/hw/mips/pic32mk*.h
+F: tests/functional/mipsel/test_pic32mk.py
+F: tests/qtest/pic32mk*.c
+
 OpenRISC Machines
 -----------------
 or1k-sim
diff --git a/configs/targets/mipsel-softmmu.mak b/configs/targets/mipsel-softmmu.mak
index b0fba8a9d0..b2cbb3222d 100644
--- a/configs/targets/mipsel-softmmu.mak
+++ b/configs/targets/mipsel-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=mips
 TARGET_LONG_BITS=32
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
+CONFIG_PIC32MK=y
diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index b59cb2f111..a9766519f9 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -84,5 +84,13 @@ config MIPS_BOSTON
     select AHCI_ICH9
     select SERIAL_MM
 
+config PIC32MK
+    bool
+    default y
+    depends on MIPS && !TARGET_BIG_ENDIAN
+    select UNIMP
+    select PTIMER
+    select CAN_BUS
+
 config FW_CFG_MIPS
     bool
diff --git a/hw/mips/meson.build b/hw/mips/meson.build
index 390f0fd7f9..40364638a5 100644
--- a/hw/mips/meson.build
+++ b/hw/mips/meson.build
@@ -12,4 +12,25 @@ mips_ss.add(when: 'CONFIG_FULOONG', if_true: files('fuloong2e.c'))
 mips_ss.add(when: 'CONFIG_MIPS_BOSTON', if_true: files('boston.c'))
 endif
 
+mips_ss.add(when: 'CONFIG_PIC32MK', if_true: files(
+  'pic32mk.c',
+  'pic32mk_evic.c',
+  'pic32mk_uart.c',
+  'pic32mk_timer.c',
+  'pic32mk_gpio.c',
+  'pic32mk_spi.c',
+  'pic32mk_i2c.c',
+  'pic32mk_dma.c',
+  'pic32mk_canfd.c',
+  'pic32mk_usb.c',
+  'pic32mk_wdt.c',
+  'pic32mk_cru.c',
+  'pic32mk_cfg.c',
+  'pic32mk_adchs.c',
+  'pic32mk_dataee.c',
+  'pic32mk_nvm.c',
+  'pic32mk_oc.c',
+  'pic32mk_ic.c',
+))
+
 hw_arch += {'mips': mips_ss}
diff --git a/hw/mips/pic32mk.c b/hw/mips/pic32mk.c
new file mode 100644
index 0000000000..e3a8019507
--- /dev/null
+++ b/hw/mips/pic32mk.c
@@ -0,0 +1,815 @@
+/*
+ * Microchip PIC32MK GPK/MCM with CAN FD — board emulation
+ * Datasheet: DS60001519E
+ *
+ * Phase 2: CPU core, EVIC, UART×6, Timers×9, GPIO A-G, SPI×6, I2C×4, DMA×8
+ *
+ * Copyright (c) 2026 QEMU contributors
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qemu/log.h"
+#include "qemu/datadir.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "hw/core/boards.h"
+#include "hw/core/loader.h"
+#include "hw/core/clock.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/mips/mips.h"
+#include "hw/mips/pic32mk.h"
+#include "hw/mips/pic32mk_evic.h"
+#include "hw/mips/pic32mk_usb.h"
+#include "system/address-spaces.h"
+#include "system/system.h"
+#include "net/can_emu.h"
+#include "chardev/char.h"
+#include "cpu.h"
+
+/* Device type strings from our peripheral files */
+#define TYPE_PIC32MK_UART   "pic32mk-uart"
+#define TYPE_PIC32MK_TIMER  "pic32mk-timer"
+#define TYPE_PIC32MK_GPIO   "pic32mk-gpio"
+#define TYPE_PIC32MK_SPI    "pic32mk-spi"
+#define TYPE_PIC32MK_I2C    "pic32mk-i2c"
+#define TYPE_PIC32MK_DMA    "pic32mk-dma"
+#define TYPE_PIC32MK_CANFD  "pic32mk-canfd"
+#define TYPE_PIC32MK_USB    "pic32mk-usb"
+#define TYPE_PIC32MK_WDT    "pic32mk-wdt"
+#define TYPE_PIC32MK_CRU    "pic32mk-cru"
+#define TYPE_PIC32MK_CFG    "pic32mk-cfg"
+#define TYPE_PIC32MK_ADCHS  "pic32mk-adchs"
+#define TYPE_PIC32MK_NVM    "pic32mk-nvm"
+#define TYPE_PIC32MK_DATAEE "pic32mk-dataee"
+#define TYPE_PIC32MK_OC     "pic32mk-oc"
+#define TYPE_PIC32MK_IC     "pic32mk-ic"
+
+/*
+ * Board state.
+ */
+typedef struct {
+    MIPSCPU        *cpu;
+    MemoryRegion    boot_rom;
+    MemoryRegion    pflash;
+    MemoryRegion    bflash1;
+    MemoryRegion    bflash2;
+    MemoryRegion    sfr;
+    MemoryRegion    sfr_unimpl;
+    MemoryRegion    pps_stub;   /* PPS input/output regs 0xBF801400-0xBF8017FF */
+
+    DeviceState    *evic;
+} PIC32MKState;
+
+/*
+ * SFR catch-all stub — logs every unimplemented register access.
+ * -----------------------------------------------------------------------
+ */
+
+static uint64_t sfr_unimpl_read(void *opaque, hwaddr addr, unsigned size)
+{
+    qemu_log_mask(LOG_UNIMP,
+                  "pic32mk: unimplemented SFR read  @ 0x%08" HWADDR_PRIx
+                  " (size %u)\n",
+                  (hwaddr)(PIC32MK_SFR_BASE + addr), size);
+    return 0;
+}
+
+static void sfr_unimpl_write(void *opaque, hwaddr addr, uint64_t val,
+                             unsigned size)
+{
+    qemu_log_mask(LOG_UNIMP,
+                  "pic32mk: unimplemented SFR write @ 0x%08" HWADDR_PRIx
+                  " = 0x%08" PRIx64 " (size %u)\n",
+                  (hwaddr)(PIC32MK_SFR_BASE + addr), val, size);
+}
+
+static const MemoryRegionOps sfr_unimpl_ops = {
+    .read       = sfr_unimpl_read,
+    .write      = sfr_unimpl_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+/*
+ * Silent stub — used for PPS and other write-only config registers that
+ * need no emulation but should not generate unimplemented warnings.
+ */
+static uint64_t sfr_ignore_read(void *opaque, hwaddr addr, unsigned size)
+{
+    return 0;
+}
+static void sfr_ignore_write(void *opaque, hwaddr addr, uint64_t val,
+                             unsigned size)
+{
+    /* silently accept */
+}
+static const MemoryRegionOps sfr_ignore_ops = {
+    .read       = sfr_ignore_read,
+    .write      = sfr_ignore_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+
+
+/*
+ * Helper: create a peripheral SysBusDevice, map its MMIO into the SFR
+ * window at the given offset (overriding the catch-all at priority 1).
+ * Returns the DeviceState for further property/IRQ wiring.
+ * -----------------------------------------------------------------------
+ */
+
+static DeviceState *sfr_device_create(MemoryRegion *sfr, const char *type,
+                                      hwaddr sfr_offset, Error **errp)
+{
+    DeviceState *dev = qdev_new(type);
+    if (!sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), errp)) {
+        return NULL;
+    }
+
+    MemoryRegion *mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
+    memory_region_add_subregion_overlap(sfr, sfr_offset, mr, 1);
+    return dev;
+}
+
+/*
+ * Memory map initialisation
+ * -----------------------------------------------------------------------
+ */
+
+static void pic32mk_memory_init(PIC32MKState *s, MachineState *machine)
+{
+    MemoryRegion *sys_mem = get_system_memory();
+
+    /* 256 KB SRAM */
+    memory_region_add_subregion(sys_mem, PIC32MK_RAM_BASE, machine->ram);
+
+    /* 1 MB Program Flash — RAM-backed so NVM controller can write */
+    memory_region_init_ram(&s->pflash, NULL, "pic32mk.pflash",
+                           PIC32MK_PFLASH_SIZE, &error_fatal);
+    memory_region_add_subregion(sys_mem, PIC32MK_PFLASH_BASE, &s->pflash);
+
+    /* Boot Flash 1 — firmware loaded here via -bios */
+    memory_region_init_rom(&s->bflash1, NULL, "pic32mk.bflash1",
+                           PIC32MK_BFLASH1_SIZE, &error_fatal);
+    memory_region_add_subregion(sys_mem, PIC32MK_BFLASH1_BASE, &s->bflash1);
+
+    /* Boot Flash 2 */
+    memory_region_init_rom(&s->bflash2, NULL, "pic32mk.bflash2",
+                           PIC32MK_BFLASH2_SIZE, &error_fatal);
+    memory_region_add_subregion(sys_mem, PIC32MK_BFLASH2_BASE, &s->bflash2);
+
+    /*
+     * Boot vector ROM — physical 0x1FC00000 to 0x1FC3FFFF.
+     * Contains a two-instruction trampoline:
+     *   j  0xBFC40000   (Boot Flash 1, KSEG1)
+     *   nop             (branch delay slot)
+     *
+     * j-encoding when PC = 0xBFC00000:
+     *   instr_index = (0xBFC40000 >> 2) & 0x3FFFFFF = 0x03F10000
+     *   word = (2 << 26) | 0x03F10000 = 0x0BF10000
+     */
+    memory_region_init_rom(&s->boot_rom, NULL, "pic32mk.boot-rom",
+                           PIC32MK_BOOTVEC_SIZE, &error_fatal);
+    memory_region_add_subregion(sys_mem, PIC32MK_BOOTVEC_BASE, &s->boot_rom);
+    {
+        uint32_t *p = memory_region_get_ram_ptr(&s->boot_rom);
+        p[0] = 0x0BF10000;  /* j 0xBFC40000 */
+        p[1] = 0x00000000;  /* nop (delay slot) */
+    }
+
+    /* SFR window: 1 MB container */
+    memory_region_init(&s->sfr, NULL, "pic32mk.sfr", PIC32MK_SFR_SIZE);
+    memory_region_add_subregion(sys_mem, PIC32MK_SFR_BASE, &s->sfr);
+
+    /* Catch-all at priority 0 */
+    memory_region_init_io(&s->sfr_unimpl, NULL, &sfr_unimpl_ops, s,
+                          "pic32mk.sfr-unimpl", PIC32MK_SFR_SIZE);
+    memory_region_add_subregion_overlap(&s->sfr, 0, &s->sfr_unimpl, 0);
+
+    /* PPS (Peripheral Pin Select) 0xBF801400–0xBF8017FF — silent stub */
+    memory_region_init_io(&s->pps_stub, NULL, &sfr_ignore_ops, NULL,
+                          "pic32mk.pps", PIC32MK_PPS_SIZE);
+    memory_region_add_subregion_overlap(&s->sfr, PIC32MK_PPS_OFFSET,
+                                        &s->pps_stub, 1);
+}
+
+/*
+ * CPU initialisation
+ * -----------------------------------------------------------------------
+ */
+
+static void pic32mk_cpu_init(PIC32MKState *s, MachineState *machine)
+{
+    Clock *cpuclk;
+
+    cpuclk = clock_new(OBJECT(machine), "cpu-refclk");
+    clock_set_hz(cpuclk, PIC32MK_CPU_HZ);
+
+    s->cpu = mips_cpu_create_with_clock(machine->cpu_type, cpuclk, false);
+    if (!s->cpu) {
+        error_report("pic32mk: failed to create CPU '%s'", machine->cpu_type);
+        exit(1);
+    }
+
+    /*
+     * Allocate the 8 CPU interrupt lines (env->irq[0..7]).
+     * Must be called before wiring EVIC to CPU pins.
+     */
+    cpu_mips_irq_init_cpu(s->cpu);
+    cpu_mips_clock_init(s->cpu);
+}
+
+/*
+ * EVIC initialisation — create device, map MMIO, wire CPU pins
+ * -----------------------------------------------------------------------
+ */
+
+static void pic32mk_evic_init(PIC32MKState *s)
+{
+    DeviceState *evic = qdev_new(TYPE_PIC32MK_EVIC);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(evic), &error_fatal);
+
+    MemoryRegion *evic_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(evic), 0);
+    memory_region_add_subregion_overlap(&s->sfr, PIC32MK_EVIC_OFFSET,
+                                        evic_mr, 1);
+    s->evic = evic;
+
+    /*
+     * Wire EVIC output pins to CPU interrupt inputs.
+     * The EVIC device stores these handles and calls qemu_set_irq()
+     * when a pending+enabled interrupt is found at a given priority level.
+     */
+    PIC32MKEVICState *evic_s = PIC32MK_EVIC(evic);
+    CPUMIPSState *env = &s->cpu->env;
+    for (int i = 0; i < 8; i++) {
+        evic_s->cpu_irq[i] = env->irq[i];
+    }
+
+    /*
+     * Intercept the CP0 Core Timer's interrupt output (normally fires on
+     * env->irq[7]) and redirect it through EVIC source 0 (CT = Core Timer).
+     *
+     * This makes CP0 timer interrupts subject to IEC0[0] (CTIE) and
+     * IPC0 priority configuration, as on real hardware.
+     *
+     * cp0_timer.c calls: qemu_irq_raise(env->irq[IPTI & 7])
+     * With IPTI=7 (M14K default, CP0_IntCtl = 0xe0000000), that is irq[7].
+     * We replace irq[7] with the EVIC's irq_in[PIC32MK_IRQ_CT].
+     */
+    env->irq[7] = qdev_get_gpio_in(evic, PIC32MK_IRQ_CT);
+
+    /*
+     * Intercept CP0 Software Interrupts 0 and 1 (env->irq[0..1]) and
+     * redirect them through the EVIC (sources CS0=1, CS1=2).
+     *
+     * On real PIC32MK hardware, writing Cause.IP0 triggers EVIC source
+     * "Core Software Interrupt 0" (CS0) at whatever priority is configured
+     * in IPC0.  The EVIC then delivers the interrupt through the normal
+     * priority comparison, which prevents same-priority nesting.
+     *
+     * In QEMU VEIC mode the pending-vs-status comparison is
+     *   (Cause & 0xFF00) > (Status & 0xFF00)
+     * If IP0 (bit 8) is left in Cause while the tick ISR sets IPL=1
+     * (bit 10), 0x0500 > 0x0400 causes an unwanted nested interrupt.
+     *
+     * The custom handler below:
+     *   1) routes SW0/SW1 through the EVIC input lines, and
+     *   2) clears the direct Cause.IP0/IP1 bit so the VEIC comparison
+     *      only sees the EVIC-asserted priority pin (bit 10+).
+     */
+    env->irq[0] = qdev_get_gpio_in(evic, PIC32MK_IRQ_CS0);
+    env->irq[1] = qdev_get_gpio_in(evic, PIC32MK_IRQ_CS1);
+
+    /*
+     * Store a reference to the CPU env in the EVIC state so the
+     * evic_set_irq handler can clear the direct Cause.IP bits for
+     * software interrupt sources routed through the EVIC.
+     */
+    evic_s->cpu = s->cpu;
+}
+
+/*
+ * Peripheral initialisation helpers
+ * -----------------------------------------------------------------------
+ */
+
+/*
+ * Create a UART instance, attach a chardev, map into the SFR window,
+ * and connect its RX/TX/error IRQ outputs to the EVIC input lines.
+ */
+static void pic32mk_uart_create(PIC32MKState *s, int index,
+                                hwaddr sfr_offset,
+                                int irq_rx, int irq_tx, int irq_err,
+                                Chardev *chr)
+{
+    DeviceState *dev = qdev_new(TYPE_PIC32MK_UART);
+    if (chr) {
+        qdev_prop_set_chr(dev, "chardev", chr);
+    }
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    MemoryRegion *mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
+    memory_region_add_subregion_overlap(&s->sfr, sfr_offset, mr, 1);
+
+    /* Connect UART IRQ outputs → EVIC inputs */
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
+                       qdev_get_gpio_in(s->evic, irq_rx));
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 1,
+                       qdev_get_gpio_in(s->evic, irq_tx));
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 2,
+                       qdev_get_gpio_in(s->evic, irq_err));
+}
+
+/*
+ * Create a Timer instance, map into the SFR window, connect IRQ to EVIC.
+ */
+static void pic32mk_timer_create(PIC32MKState *s,
+                                 hwaddr sfr_offset, int irq_src, bool type_a)
+{
+    DeviceState *dev = qdev_new(TYPE_PIC32MK_TIMER);
+    qdev_prop_set_bit(dev, "type-a", type_a);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    memory_region_add_subregion_overlap(&s->sfr, sfr_offset,
+        sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0), 1);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
+                       qdev_get_gpio_in(s->evic, irq_src));
+}
+
+static void pic32mk_oc_create(PIC32MKState *s, int index,
+                              hwaddr sfr_offset, int irq_src)
+{
+    DeviceState *dev = qdev_new(TYPE_PIC32MK_OC);
+    qdev_prop_set_uint8(dev, "index", (uint8_t)index);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    memory_region_add_subregion_overlap(&s->sfr, sfr_offset,
+        sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0), 1);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
+                       qdev_get_gpio_in(s->evic, irq_src));
+    /* Optional chardev for waveform event streaming */
+    Chardev *chr = qemu_chr_find("oc-events");
+    if (chr) {
+        pic32mk_oc_set_chardev(dev, chr);
+    }
+}
+
+/*
+ * pic32mk_ic_create — instantiate one IC peripheral and map it into the SFR
+ * window.  irq_cap = capture IRQ index, irq_err = error IRQ index (Table 8-3).
+ * The optional chardev "ic-events" is used to inject capture events from the
+ * host; must be set before sysbus_realize_and_unref.
+ */
+static void pic32mk_ic_create(PIC32MKState *s, int index,
+                              hwaddr sfr_offset, int irq_cap, int irq_err)
+{
+    DeviceState *dev = qdev_new(TYPE_PIC32MK_IC);
+    qdev_prop_set_uint8(dev, "index", (uint8_t)index);
+    /*
+     * Only IC1 owns the "ic-events" chardev; it dispatches to all instances
+     * via a global routing table registered during realize.
+      */
+    if (index == 1) {
+        Chardev *chr = qemu_chr_find("ic-events");
+        if (chr) {
+            qdev_prop_set_chr(dev, "chardev", chr);
+        }
+    }
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    memory_region_add_subregion_overlap(&s->sfr, sfr_offset,
+        sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0), 1);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
+                       qdev_get_gpio_in(s->evic, irq_cap));
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 1,
+                       qdev_get_gpio_in(s->evic, irq_err));
+}
+
+static const char * const pic32mk_gpio_port_names[PIC32MK_GPIO_NPORTS] = {
+    "gpio-portA", "gpio-portB", "gpio-portC", "gpio-portD",
+    "gpio-portE", "gpio-portF", "gpio-portG",
+};
+
+/*
+ * Create a GPIO port instance, map into the SFR window.
+ * The CN interrupt output (sysbus IRQ 0) is wired to the EVIC.
+ * The device is registered as a named child of the machine object so that
+ * QOM paths are predictable: /machine/gpio-portA … /machine/gpio-portG.
+ */
+static void pic32mk_gpio_create(PIC32MKState *s, MachineState *machine,
+                                int port_idx, hwaddr sfr_offset, int cn_irq,
+                                Chardev *gpio_chr)
+{
+    /*
+     * Create the device first, register it as a named child of the machine
+     * BEFORE calling sysbus_realize_and_unref().  If the object already has
+     * a parent when device_realize() runs it will NOT be placed under the
+     * anonymous machine/unattached container, so object_property_add_child()
+     * won't hit the "!child->parent" assertion.
+     */
+    DeviceState *dev = qdev_new(TYPE_PIC32MK_GPIO);
+    qdev_prop_set_uint8(dev, "port-index", (uint8_t)port_idx);
+    object_property_add_child(OBJECT(machine),
+                              pic32mk_gpio_port_names[port_idx], OBJECT(dev));
+    if (!sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal)) {
+        return;
+    }
+
+    /* Shared chardev for GPIO event streaming (all ports write to same chardev) */
+    if (gpio_chr) {
+        pic32mk_gpio_set_chardev(dev, gpio_chr);
+    }
+
+    MemoryRegion *mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
+    memory_region_add_subregion_overlap(&s->sfr, sfr_offset, mr, 1);
+
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
+                       qdev_get_gpio_in(s->evic, cn_irq));
+}
+
+/*
+ * Create a SPI instance, map into the SFR window.
+ */
+static void pic32mk_spi_create(PIC32MKState *s, int index, hwaddr sfr_offset,
+                               int irq_rx, int irq_tx, int irq_err)
+{
+    DeviceState *dev = qdev_new(TYPE_PIC32MK_SPI);
+    char chr_name[16];
+
+    qdev_prop_set_uint8(dev, "spi-index", (uint8_t)index);
+    snprintf(chr_name, sizeof(chr_name), "spi%d", index);
+    Chardev *chr = qemu_chr_find(chr_name);
+    if (chr) {
+        qdev_prop_set_chr(dev, "chardev", chr);
+    }
+
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    MemoryRegion *mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
+    memory_region_add_subregion_overlap(&s->sfr, sfr_offset, mr, 1);
+
+    if (irq_rx >= 0) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
+                           qdev_get_gpio_in(s->evic, irq_rx));
+    }
+    if (irq_tx >= 0) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 1,
+                           qdev_get_gpio_in(s->evic, irq_tx));
+    }
+    if (irq_err >= 0) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 2,
+                           qdev_get_gpio_in(s->evic, irq_err));
+    }
+}
+
+/*
+ * Create an I2C instance, map into the SFR window.
+ */
+static void pic32mk_i2c_create(PIC32MKState *s, hwaddr sfr_offset)
+{
+    sfr_device_create(&s->sfr, TYPE_PIC32MK_I2C, sfr_offset, &error_fatal);
+}
+
+/*
+ * pic32mk_find_canbus — look up a can-bus object created with
+ *   -object can-bus,id=canbus<idx>
+ * Returns NULL if no such object exists (CAN instance runs standalone).
+ */
+static CanBusState *pic32mk_find_canbus(int idx)
+{
+    char path[32];
+    snprintf(path, sizeof(path), "/objects/canbus%d", idx);
+    Object *obj = object_resolve_path_type(path, TYPE_CAN_BUS, NULL);
+    return obj ? CAN_BUS(obj) : NULL;
+}
+
+/*
+ * Create a CAN FD instance:
+ *  - SFR region (mmio 0) mapped into the SFR window at sfr_offset
+ *  - Message RAM (mmio 1) mapped into system memory at msgram_phys_base
+ *  - Single IRQ wired to EVIC input irq_src
+ *  - canbus: optional virtual bus (NULL = standalone/loopback only)
+ */
+static void pic32mk_canfd_create(PIC32MKState *s,
+                                 hwaddr sfr_offset,
+                                 hwaddr msgram_phys_base,
+                                 int irq_src,
+                                 CanBusState *canbus,
+                                 uint32_t instance_id)
+{
+    DeviceState *dev = qdev_new(TYPE_PIC32MK_CANFD);
+    qdev_prop_set_uint32(dev, "msg-ram-base", (uint32_t)msgram_phys_base);
+    qdev_prop_set_uint32(dev, "instance-id", instance_id);
+    if (canbus) {
+        object_property_set_link(OBJECT(dev), "canbus",
+                                 OBJECT(canbus), &error_fatal);
+    }
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    /* SFR block overrides the catch-all at priority 1 */
+    memory_region_add_subregion_overlap(&s->sfr, sfr_offset,
+        sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0), 1);
+
+    /* Message RAM mapped into the flat system address space */
+    memory_region_add_subregion(get_system_memory(), msgram_phys_base,
+        sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1));
+
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
+                       qdev_get_gpio_in(s->evic, irq_src));
+}
+
+/*
+ * Create a USB OTG instance, map SFR into the SFR window, connect IRQ.
+ */
+static void pic32mk_usb_create(PIC32MKState *s,
+                               hwaddr sfr_offset, int irq_src,
+                               const char *chardev_id)
+{
+    DeviceState *dev = qdev_new(TYPE_PIC32MK_USB);
+    if (chardev_id) {
+        Chardev *chr = qemu_chr_find(chardev_id);
+        if (chr) {
+            qdev_prop_set_chr(dev, "chardev", chr);
+        }
+    }
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    memory_region_add_subregion_overlap(&s->sfr, sfr_offset,
+        sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0), 1);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
+                       qdev_get_gpio_in(s->evic, irq_src));
+}
+
+/*
+ * Firmware loading
+ * -----------------------------------------------------------------------
+ */
+
+static void pic32mk_load_firmware(MachineState *machine)
+{
+    if (!machine->firmware) {
+        return;
+    }
+
+    char *filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, machine->firmware);
+    if (!filename) {
+        error_report("pic32mk: could not find firmware '%s'",
+                     machine->firmware);
+        exit(1);
+    }
+
+    ssize_t bios_size = load_image_targphys(filename,
+                                            PIC32MK_BFLASH1_BASE,
+                                            PIC32MK_BFLASH1_SIZE,
+                                            NULL);
+    g_free(filename);
+
+    if (bios_size < 0) {
+        error_report("pic32mk: could not load firmware '%s'",
+                     machine->firmware);
+        exit(1);
+    }
+}
+
+/*
+ * Machine entry point
+ * -----------------------------------------------------------------------
+ */
+
+static void pic32mk_machine_init(MachineState *machine)
+{
+    PIC32MKState *s = g_new0(PIC32MKState, 1);
+
+    pic32mk_cpu_init(s, machine);
+    pic32mk_memory_init(s, machine);
+
+    /* EVIC — must come before peripherals so we can wire IRQs */
+    pic32mk_evic_init(s);
+
+    /* DMA — mapped into the EVIC's 4 KB page (DMA_OFFSET = EVIC+0x1000) */
+    {
+        DeviceState *dma = qdev_new(TYPE_PIC32MK_DMA);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(dma), &error_fatal);
+        MemoryRegion *mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dma), 0);
+        memory_region_add_subregion_overlap(&s->sfr, PIC32MK_DMA_OFFSET, mr, 1);
+        for (int i = 0; i < PIC32MK_DMA_NCHANNELS; i++) {
+            sysbus_connect_irq(SYS_BUS_DEVICE(dma), i,
+                               qdev_get_gpio_in(s->evic,
+                                                PIC32MK_IRQ_DMA0 + i));
+        }
+    }
+
+    /* UART1 on serial_hd(0), UART2–6 without chardev (stub only) */
+    pic32mk_uart_create(s, 1, PIC32MK_UART1_OFFSET,
+                        PIC32MK_IRQ_U1RX, PIC32MK_IRQ_U1TX, PIC32MK_IRQ_U1E,
+                        serial_hd(0));
+    pic32mk_uart_create(s, 2, PIC32MK_UART2_OFFSET,
+                        PIC32MK_IRQ_U2RX, PIC32MK_IRQ_U2TX, PIC32MK_IRQ_U2E,
+                        serial_hd(1));
+    pic32mk_uart_create(s, 3, PIC32MK_UART3_OFFSET,
+                        PIC32MK_IRQ_U3RX, PIC32MK_IRQ_U3TX, PIC32MK_IRQ_U3E,
+                        serial_hd(2));
+    pic32mk_uart_create(s, 4, PIC32MK_UART4_OFFSET,
+                        PIC32MK_IRQ_U4RX, PIC32MK_IRQ_U4TX, PIC32MK_IRQ_U4E,
+                        serial_hd(3));
+    pic32mk_uart_create(s, 5, PIC32MK_UART5_OFFSET,
+                        PIC32MK_IRQ_U5RX, PIC32MK_IRQ_U5TX, PIC32MK_IRQ_U5E,
+                        serial_hd(4));
+    pic32mk_uart_create(s, 6, PIC32MK_UART6_OFFSET,
+                        PIC32MK_IRQ_U6RX, PIC32MK_IRQ_U6TX, PIC32MK_IRQ_U6E,
+                        serial_hd(5));
+
+    /* Timers 1–9: Timer1 is Type A (2-bit TCKPS {1,8,64,256}); 2–9 are Type B/C */
+    pic32mk_timer_create(s, PIC32MK_T1_OFFSET, PIC32MK_IRQ_T1, true);
+    pic32mk_timer_create(s, PIC32MK_T2_OFFSET, PIC32MK_IRQ_T2, false);
+    pic32mk_timer_create(s, PIC32MK_T3_OFFSET, PIC32MK_IRQ_T3, false);
+    pic32mk_timer_create(s, PIC32MK_T4_OFFSET, PIC32MK_IRQ_T4, false);
+    pic32mk_timer_create(s, PIC32MK_T5_OFFSET, PIC32MK_IRQ_T5, false);
+    pic32mk_timer_create(s, PIC32MK_T6_OFFSET, PIC32MK_IRQ_T6, false);
+    pic32mk_timer_create(s, PIC32MK_T7_OFFSET, PIC32MK_IRQ_T7, false);
+    pic32mk_timer_create(s, PIC32MK_T8_OFFSET, PIC32MK_IRQ_T8, false);
+    pic32mk_timer_create(s, PIC32MK_T9_OFFSET, PIC32MK_IRQ_T9, false);
+
+    /* Output Compare OC1–OC16 (diagnostic emulation) */
+    pic32mk_oc_create(s, 1,  PIC32MK_OC1_OFFSET,  PIC32MK_IRQ_OC1);
+    pic32mk_oc_create(s, 2,  PIC32MK_OC2_OFFSET,  PIC32MK_IRQ_OC2);
+    pic32mk_oc_create(s, 3,  PIC32MK_OC3_OFFSET,  PIC32MK_IRQ_OC3);
+    pic32mk_oc_create(s, 4,  PIC32MK_OC4_OFFSET,  PIC32MK_IRQ_OC4);
+    pic32mk_oc_create(s, 5,  PIC32MK_OC5_OFFSET,  PIC32MK_IRQ_OC5);
+    pic32mk_oc_create(s, 6,  PIC32MK_OC6_OFFSET,  PIC32MK_IRQ_OC6);
+    pic32mk_oc_create(s, 7,  PIC32MK_OC7_OFFSET,  PIC32MK_IRQ_OC7);
+    pic32mk_oc_create(s, 8,  PIC32MK_OC8_OFFSET,  PIC32MK_IRQ_OC8);
+    pic32mk_oc_create(s, 9,  PIC32MK_OC9_OFFSET,  PIC32MK_IRQ_OC9);
+    pic32mk_oc_create(s, 10, PIC32MK_OC10_OFFSET, PIC32MK_IRQ_OC10);
+    pic32mk_oc_create(s, 11, PIC32MK_OC11_OFFSET, PIC32MK_IRQ_OC11);
+    pic32mk_oc_create(s, 12, PIC32MK_OC12_OFFSET, PIC32MK_IRQ_OC12);
+    pic32mk_oc_create(s, 13, PIC32MK_OC13_OFFSET, PIC32MK_IRQ_OC13);
+    pic32mk_oc_create(s, 14, PIC32MK_OC14_OFFSET, PIC32MK_IRQ_OC14);
+    pic32mk_oc_create(s, 15, PIC32MK_OC15_OFFSET, PIC32MK_IRQ_OC15);
+    pic32mk_oc_create(s, 16, PIC32MK_OC16_OFFSET, PIC32MK_IRQ_OC16);
+
+    /* Input Capture IC1–IC16 (full register model with FIFO) */
+    pic32mk_ic_create(s, 1,  PIC32MK_IC1_OFFSET,  PIC32MK_IRQ_IC1,  PIC32MK_IRQ_IC1E);
+    pic32mk_ic_create(s, 2,  PIC32MK_IC2_OFFSET,  PIC32MK_IRQ_IC2,  PIC32MK_IRQ_IC2E);
+    pic32mk_ic_create(s, 3,  PIC32MK_IC3_OFFSET,  PIC32MK_IRQ_IC3,  PIC32MK_IRQ_IC3E);
+    pic32mk_ic_create(s, 4,  PIC32MK_IC4_OFFSET,  PIC32MK_IRQ_IC4,  PIC32MK_IRQ_IC4E);
+    pic32mk_ic_create(s, 5,  PIC32MK_IC5_OFFSET,  PIC32MK_IRQ_IC5,  PIC32MK_IRQ_IC5E);
+    pic32mk_ic_create(s, 6,  PIC32MK_IC6_OFFSET,  PIC32MK_IRQ_IC6,  PIC32MK_IRQ_IC6E);
+    pic32mk_ic_create(s, 7,  PIC32MK_IC7_OFFSET,  PIC32MK_IRQ_IC7,  PIC32MK_IRQ_IC7E);
+    pic32mk_ic_create(s, 8,  PIC32MK_IC8_OFFSET,  PIC32MK_IRQ_IC8,  PIC32MK_IRQ_IC8E);
+    pic32mk_ic_create(s, 9,  PIC32MK_IC9_OFFSET,  PIC32MK_IRQ_IC9,  PIC32MK_IRQ_IC9E);
+    pic32mk_ic_create(s, 10, PIC32MK_IC10_OFFSET, PIC32MK_IRQ_IC10, PIC32MK_IRQ_IC10E);
+    pic32mk_ic_create(s, 11, PIC32MK_IC11_OFFSET, PIC32MK_IRQ_IC11, PIC32MK_IRQ_IC11E);
+    pic32mk_ic_create(s, 12, PIC32MK_IC12_OFFSET, PIC32MK_IRQ_IC12, PIC32MK_IRQ_IC12E);
+    pic32mk_ic_create(s, 13, PIC32MK_IC13_OFFSET, PIC32MK_IRQ_IC13, PIC32MK_IRQ_IC13E);
+    pic32mk_ic_create(s, 14, PIC32MK_IC14_OFFSET, PIC32MK_IRQ_IC14, PIC32MK_IRQ_IC14E);
+    pic32mk_ic_create(s, 15, PIC32MK_IC15_OFFSET, PIC32MK_IRQ_IC15, PIC32MK_IRQ_IC15E);
+    pic32mk_ic_create(s, 16, PIC32MK_IC16_OFFSET, PIC32MK_IRQ_IC16, PIC32MK_IRQ_IC16E);
+
+    /* GPIO ports A–G: CN interrupt vectors 44–50 (_CHANGE_NOTICE_x_VECTOR) */
+    static const int cn_irqs[PIC32MK_GPIO_NPORTS] = {
+        PIC32MK_IRQ_CNA, PIC32MK_IRQ_CNB, PIC32MK_IRQ_CNC, PIC32MK_IRQ_CND,
+        PIC32MK_IRQ_CNE, PIC32MK_IRQ_CNF, PIC32MK_IRQ_CNG,
+    };
+    /* Optional: look up shared chardev "gpio-events" for GUI event streaming */
+    Chardev *gpio_chr = qemu_chr_find("gpio-events");
+    for (int port = 0; port < PIC32MK_GPIO_NPORTS; port++) {
+        pic32mk_gpio_create(s, machine, port,
+                            PIC32MK_GPIO_OFFSET
+                            + (hwaddr)port * PIC32MK_GPIO_PORT_SIZE,
+                            cn_irqs[port], gpio_chr);
+    }
+
+    /* SPI 1–6 */
+    pic32mk_spi_create(s, 1, PIC32MK_SPI1_OFFSET,
+                       PIC32MK_IRQ_SPI1_RX,
+                       PIC32MK_IRQ_SPI1_TX,
+                       PIC32MK_IRQ_SPI1_FAULT);
+    pic32mk_spi_create(s, 2, PIC32MK_SPI2_OFFSET,
+                       PIC32MK_IRQ_SPI2_RX,
+                       PIC32MK_IRQ_SPI2_TX,
+                       PIC32MK_IRQ_SPI2_FAULT);
+    pic32mk_spi_create(s, 3, PIC32MK_SPI3_OFFSET,
+                       PIC32MK_IRQ_SPI3_RX,
+                       PIC32MK_IRQ_SPI3_TX,
+                       PIC32MK_IRQ_SPI3_FAULT);
+    pic32mk_spi_create(s, 4, PIC32MK_SPI4_OFFSET,
+                       PIC32MK_IRQ_SPI4_RX,
+                       PIC32MK_IRQ_SPI4_TX,
+                       PIC32MK_IRQ_SPI4_FAULT);
+    pic32mk_spi_create(s, 5, PIC32MK_SPI5_OFFSET,
+                       PIC32MK_IRQ_SPI5_RX,
+                       PIC32MK_IRQ_SPI5_TX,
+                       PIC32MK_IRQ_SPI5_FAULT);
+    pic32mk_spi_create(s, 6, PIC32MK_SPI6_OFFSET,
+                       PIC32MK_IRQ_SPI6_RX,
+                       PIC32MK_IRQ_SPI6_TX,
+                       PIC32MK_IRQ_SPI6_FAULT);
+
+    /* I2C 1–4 */
+    pic32mk_i2c_create(s, PIC32MK_I2C1_OFFSET);
+    pic32mk_i2c_create(s, PIC32MK_I2C2_OFFSET);
+    pic32mk_i2c_create(s, PIC32MK_I2C3_OFFSET);
+    pic32mk_i2c_create(s, PIC32MK_I2C4_OFFSET);
+
+    /* ADCHS — High-Speed ADC at 0xBF887000 */
+    {
+        DeviceState *adc = qdev_new(TYPE_PIC32MK_ADCHS);
+        object_property_add_child(OBJECT(machine), "adchs", OBJECT(adc));
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(adc), &error_fatal);
+        MemoryRegion *mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(adc), 0);
+        memory_region_add_subregion_overlap(&s->sfr, PIC32MK_ADC_OFFSET,
+                                            mr, 1);
+        /* IRQ 0 = EOS (101), IRQ 1 = main ADC (92) */
+        sysbus_connect_irq(SYS_BUS_DEVICE(adc), 0,
+                           qdev_get_gpio_in(s->evic, PIC32MK_IRQ_ADC_EOS));
+        sysbus_connect_irq(SYS_BUS_DEVICE(adc), 1,
+                           qdev_get_gpio_in(s->evic, PIC32MK_IRQ_ADC));
+    }
+
+    /* CAN FD 1–4 */
+    pic32mk_canfd_create(s, PIC32MK_CAN1_OFFSET,
+                         PIC32MK_CAN1_MSGRAM_BASE, PIC32MK_IRQ_CAN1,
+                         pic32mk_find_canbus(0), 0);
+    pic32mk_canfd_create(s, PIC32MK_CAN2_OFFSET,
+                         PIC32MK_CAN2_MSGRAM_BASE, PIC32MK_IRQ_CAN2,
+                         pic32mk_find_canbus(1), 1);
+    pic32mk_canfd_create(s, PIC32MK_CAN3_OFFSET,
+                         PIC32MK_CAN3_MSGRAM_BASE, PIC32MK_IRQ_CAN3,
+                         pic32mk_find_canbus(2), 2);
+    pic32mk_canfd_create(s, PIC32MK_CAN4_OFFSET,
+                         PIC32MK_CAN4_MSGRAM_BASE, PIC32MK_IRQ_CAN4,
+                         pic32mk_find_canbus(3), 3);
+
+    /* USB OTG 1–2 (Phase 4A — register-file stub) */
+    pic32mk_usb_create(s, PIC32MK_USB1_OFFSET, PIC32MK_IRQ_USB1, "usbcdc");
+    pic32mk_usb_create(s, PIC32MK_USB2_OFFSET, PIC32MK_IRQ_USB2, NULL);
+
+    /* WDT — register-file stub; absorbs WDTCON reads/writes and clear-key */
+    sfr_device_create(&s->sfr, TYPE_PIC32MK_WDT, PIC32MK_WDT_OFFSET,
+                      &error_fatal);
+
+    /* CFG / PMD / SYSKEY — register block at 0xBF800000 */
+    sfr_device_create(&s->sfr, TYPE_PIC32MK_CFG, PIC32MK_CFG_OFFSET,
+                      &error_fatal);
+
+    /* CRU — Clock Reference Unit at 0xBF801200 (includes RCON/RSWRST) */
+    sfr_device_create(&s->sfr, TYPE_PIC32MK_CRU, PIC32MK_CRU_OFFSET,
+                      &error_fatal);
+
+    /* NVM / Flash Controller at 0xBF800A00 */
+    {
+        DeviceState *nvm = qdev_new(TYPE_PIC32MK_NVM);
+        object_property_set_link(OBJECT(nvm), "pflash",
+                                 OBJECT(&s->pflash), &error_fatal);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(nvm), &error_fatal);
+        MemoryRegion *mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(nvm), 0);
+        memory_region_add_subregion_overlap(&s->sfr, PIC32MK_NVM_OFFSET,
+                                            mr, 1);
+        sysbus_connect_irq(SYS_BUS_DEVICE(nvm), 0,
+                           qdev_get_gpio_in(s->evic, PIC32MK_IRQ_FCE));
+    }
+
+    /* Data EEPROM at 0xBF829000 — 4 KB, optionally backed by host file */
+    {
+        DeviceState *ee = qdev_new(TYPE_PIC32MK_DATAEE);
+        /* Backing file: use -global pic32mk-dataee.filename=<path> */
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(ee), &error_fatal);
+        MemoryRegion *mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(ee), 0);
+        memory_region_add_subregion_overlap(&s->sfr, PIC32MK_DATAEE_OFFSET,
+                                            mr, 1);
+        sysbus_connect_irq(SYS_BUS_DEVICE(ee), 0,
+                           qdev_get_gpio_in(s->evic, PIC32MK_IRQ_DATAEE));
+    }
+
+    pic32mk_load_firmware(machine);
+}
+
+/*
+ * MachineClass registration
+ * -----------------------------------------------------------------------
+ */
+
+static void pic32mk_machine_class_init(MachineClass *mc)
+{
+    mc->desc           = "Microchip PIC32MK GPK/MCM with CAN FD";
+    mc->init           = pic32mk_machine_init;
+    mc->max_cpus       = 1;
+    /*
+     * microAptiv: MIPS32r2 + FPU + DSP R2 + microMIPS + MCU ASE,
+     * fixed-mapping MMU, VEIC — matches PIC32MK DS60001519E §3.
+     */
+    mc->default_cpu_type = MIPS_CPU_TYPE_NAME("microAptiv");
+    mc->default_ram_id   = "pic32mk.ram";
+    mc->default_ram_size = PIC32MK_RAM_SIZE;
+    mc->no_parallel      = 1;
+    mc->no_floppy        = 1;
+    mc->no_cdrom         = 1;
+}
+
+DEFINE_MACHINE("pic32mk", pic32mk_machine_class_init)
diff --git a/hw/mips/pic32mk_adchs.c b/hw/mips/pic32mk_adchs.c
new file mode 100644
index 0000000000..64d1079c02
--- /dev/null
+++ b/hw/mips/pic32mk_adchs.c
@@ -0,0 +1,583 @@
+/*
+ * PIC32MK ADCHS — High-Speed ADC peripheral emulation
+ * Datasheet: DS60001519E, §22
+ *
+ * Emulates the 12-bit pipelined SAR ADC found on PIC32MK GPK/MCM devices.
+ * 46 data channels (0–27, 33–41, 45–53), 7 ADC modules (0–5, 7).
+ *
+ * Key features implemented:
+ *   - All SFR registers with SET/CLR/INV sub-register support
+ *   - Software-triggered conversions (GSWTRG, GLSWTRG, RQCNVRT)
+ *   - Instant conversion model (no timing delays)
+ *   - Host-injectable analog values via QOM properties (adc-ch0 … adc-ch53)
+ *   - End-of-Scan (EOS) + main ADC interrupt outputs to EVIC
+ *   - BGVRRDY and WKRDYx bits always report ready (emulation shortcut)
+ *
+ * Stubs (LOG_UNIMP): digital filters, digital comparators, DMA, early IRQ.
+ *
+ * Copyright (c) 2026 QEMU contributors
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "qapi/visitor.h"
+#include "hw/core/sysbus.h"
+#include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/mips/pic32mk.h"
+#include "hw/mips/pic32mk_adchs.h"
+
+/*
+ * Channel validity table — true for channels present on PIC32MK1024MCM100
+ * Channels: 0–27, 33–41, 45–53.  Missing: 28–32, 42–44.
+ * -----------------------------------------------------------------------
+ */
+
+static bool adchs_channel_valid(unsigned ch)
+{
+    if (ch <= 27) {
+        return true;
+    }
+    if (ch >= 33 && ch <= 41) {
+        return true;
+    }
+    if (ch >= 45 && ch <= 53) {
+        return true;
+    }
+    return false;
+}
+
+/*
+ * Map channel number to its data-ready IRQ number.
+ * DATA0=106, DATA1=107, …, DATA27=133, (gap), DATA33=139, …, DATA41=147,
+ * (gap), DATA45=151, …, DATA53=159.
+ */
+static int G_GNUC_UNUSED adchs_channel_irq(unsigned ch)
+{
+    if (ch <= 27) {
+        return PIC32MK_IRQ_ADC_DATA0 + (int)ch;
+    }
+    if (ch >= 33 && ch <= 41) {
+        return 139 + (int)(ch - 33);
+    }
+    if (ch >= 45 && ch <= 53) {
+        return 151 + (int)(ch - 45);
+    }
+    return -1;
+}
+
+/*
+ * SET/CLR/INV helper (PIC32MK convention: +0=REG, +4=CLR, +8=SET, +C=INV)
+ * -----------------------------------------------------------------------
+ */
+
+static void apply_sci(uint32_t *reg, uint32_t val, int sub)
+{
+    switch (sub) {
+    case 0:
+        *reg  = val;
+        break;
+    case 4:
+        *reg &= ~val;
+        break;
+    case 8:
+        *reg |= val;
+        break;
+    case 12:
+        *reg ^= val;
+        break;
+    }
+}
+
+/*
+ * Conversion engine
+ * -----------------------------------------------------------------------
+ */
+
+/*
+ * Perform conversion for a single channel: copy the host-injected analog
+ * value into the data register, set the data-ready status bit, and fire
+ * the per-channel IRQ if the global interrupt-enable bit is set.
+ */
+static void adchs_convert_channel(PIC32MKADCHSState *s, unsigned ch)
+{
+    if (ch >= PIC32MK_ADC_MAX_CH || !adchs_channel_valid(ch)) {
+        return;
+    }
+
+    /* Store 12-bit result in data register (upper bits zero) */
+    s->adcdata[ch] = s->analog_input[ch] & 0xFFF;
+
+    /* Set data-ready status bit */
+    if (ch < 32) {
+        s->adcdstat[0] |= (1u << ch);
+    } else {
+        s->adcdstat[1] |= (1u << (ch - 32));
+    }
+
+    /* Fire per-channel IRQ if ADCGIRQEN bit is set */
+    bool girq_en;
+    if (ch < 32) {
+        girq_en = !!(s->adcgirqen[0] & (1u << ch));
+    } else {
+        girq_en = !!(s->adcgirqen[1] & (1u << (ch - 32)));
+    }
+
+    if (girq_en) {
+        /*
+         * Per-channel data IRQs go directly to EVIC IFS bits.
+         * We pulse the main ADC IRQ output for simplicity — the EVIC
+         * will latch IFS[irq_num].  Individual data channel IRQ wiring
+         * can be extended if firmware requires it.
+         */
+        qemu_irq_pulse(s->irq_main);
+    }
+}
+
+/*
+ * Scan conversion: iterate over all channels enabled in ADCCSS1/2,
+ * convert each, then signal End-of-Scan.
+ */
+static void adchs_scan_convert(PIC32MKADCHSState *s)
+{
+    /* Only convert if module is ON */
+    if (!(s->adccon1 & PIC32MK_ADCCON1_ON)) {
+        return;
+    }
+
+    /* Scan CSS1 (channels 0–31) */
+    for (int ch = 0; ch < 32; ch++) {
+        if (s->adccss[0] & (1u << ch)) {
+            adchs_convert_channel(s, ch);
+        }
+    }
+
+    /* Scan CSS2 (channels 32–53) */
+    for (int ch = 0; ch < 22; ch++) {
+        if (s->adccss[1] & (1u << ch)) {
+            adchs_convert_channel(s, ch + 32);
+        }
+    }
+
+    /* Signal End-of-Scan */
+    qemu_irq_pulse(s->irq_eos);
+}
+
+/*
+ * Register dispatch
+ * -----------------------------------------------------------------------
+ */
+
+/*
+ * Map an offset (base, i.e. aligned to 0x10) to a register pointer.
+ * Returns NULL for offsets that are read-only, data, or unimplemented.
+ */
+static uint32_t *adchs_find_reg(PIC32MKADCHSState *s, hwaddr base)
+{
+    switch (base) {
+    case PIC32MK_ADCCON1:
+        return &s->adccon1;
+    case PIC32MK_ADCCON2:
+        return &s->adccon2;
+    case PIC32MK_ADCCON3:
+        return &s->adccon3;
+    case PIC32MK_ADCTRGMODE:
+        return &s->adctrgmode;
+
+    case PIC32MK_ADCIMCON1:
+        return &s->adcimcon[0];
+    case PIC32MK_ADCIMCON2:
+        return &s->adcimcon[1];
+    case PIC32MK_ADCIMCON3:
+        return &s->adcimcon[2];
+    case PIC32MK_ADCIMCON4:
+        return &s->adcimcon[3];
+
+    case PIC32MK_ADCGIRQEN1:
+        return &s->adcgirqen[0];
+    case PIC32MK_ADCGIRQEN2:
+        return &s->adcgirqen[1];
+
+    case PIC32MK_ADCCSS1:
+        return &s->adccss[0];
+    case PIC32MK_ADCCSS2:
+        return &s->adccss[1];
+
+    case PIC32MK_ADCDSTAT1:
+        return &s->adcdstat[0];
+    case PIC32MK_ADCDSTAT2:
+        return &s->adcdstat[1];
+
+    case PIC32MK_ADCCMPEN1:
+        return &s->adccmpen[0];
+    case PIC32MK_ADCCMPEN2:
+        return &s->adccmpen[1];
+    case PIC32MK_ADCCMPEN3:
+        return &s->adccmpen[2];
+    case PIC32MK_ADCCMPEN4:
+        return &s->adccmpen[3];
+
+    case PIC32MK_ADCCMP1:
+        return &s->adccmp[0];
+    case PIC32MK_ADCCMP2:
+        return &s->adccmp[1];
+    case PIC32MK_ADCCMP3:
+        return &s->adccmp[2];
+    case PIC32MK_ADCCMP4:
+        return &s->adccmp[3];
+
+    case PIC32MK_ADCFLTR1:
+        return &s->adcfltr[0];
+    case PIC32MK_ADCFLTR2:
+        return &s->adcfltr[1];
+    case PIC32MK_ADCFLTR3:
+        return &s->adcfltr[2];
+    case PIC32MK_ADCFLTR4:
+        return &s->adcfltr[3];
+
+    case PIC32MK_ADCTRG1:
+        return &s->adctrg[0];
+    case PIC32MK_ADCTRG2:
+        return &s->adctrg[1];
+    case PIC32MK_ADCTRG3:
+        return &s->adctrg[2];
+    case PIC32MK_ADCTRG4:
+        return &s->adctrg[3];
+    case PIC32MK_ADCTRG5:
+        return &s->adctrg[4];
+    case PIC32MK_ADCTRG6:
+        return &s->adctrg[5];
+    case PIC32MK_ADCTRG7:
+        return &s->adctrg[6];
+
+    case PIC32MK_ADCCMPCON1:
+        return &s->adccmpcon[0];
+    case PIC32MK_ADCCMPCON2:
+        return &s->adccmpcon[1];
+    case PIC32MK_ADCCMPCON3:
+        return &s->adccmpcon[2];
+    case PIC32MK_ADCCMPCON4:
+        return &s->adccmpcon[3];
+
+    case PIC32MK_ADCBASE:
+        return &s->adcbase;
+    case PIC32MK_ADCTRGSNS:
+        return &s->adctrgsns;
+
+    case PIC32MK_ADC0TIME:
+        return &s->adctime[0];
+    case PIC32MK_ADC1TIME:
+        return &s->adctime[1];
+    case PIC32MK_ADC2TIME:
+        return &s->adctime[2];
+    case PIC32MK_ADC3TIME:
+        return &s->adctime[3];
+    case PIC32MK_ADC4TIME:
+        return &s->adctime[4];
+    case PIC32MK_ADC5TIME:
+        return &s->adctime[5];
+
+    case PIC32MK_ADCEIEN1:
+        return &s->adceien[0];
+    case PIC32MK_ADCEIEN2:
+        return &s->adceien[1];
+    case PIC32MK_ADCEISTAT1:
+        return &s->adceistat[0];
+    case PIC32MK_ADCEISTAT2:
+        return &s->adceistat[1];
+
+    case PIC32MK_ADCANCON:
+        return &s->adcancon;
+
+    case PIC32MK_ADC0CFG:
+        return &s->adccfg[0];
+    case PIC32MK_ADC1CFG:
+        return &s->adccfg[1];
+    case PIC32MK_ADC2CFG:
+        return &s->adccfg[2];
+    case PIC32MK_ADC3CFG:
+        return &s->adccfg[3];
+    case PIC32MK_ADC4CFG:
+        return &s->adccfg[4];
+    case PIC32MK_ADC5CFG:
+        return &s->adccfg[5];
+    case PIC32MK_ADC6CFG:
+        return &s->adccfg[6];
+    case PIC32MK_ADC7CFG:
+        return &s->adccfg[7];
+
+    case PIC32MK_ADCSYSCFG0:
+        return &s->adcsyscfg[0];
+    case PIC32MK_ADCSYSCFG1:
+        return &s->adcsyscfg[1];
+
+    default:
+        return NULL;
+    }
+}
+
+/*
+ * MMIO read
+ * -----------------------------------------------------------------------
+ */
+
+static uint64_t adchs_read(void *opaque, hwaddr addr, unsigned size)
+{
+    PIC32MKADCHSState *s = opaque;
+    hwaddr base = addr & ~(hwaddr)0xF;
+
+    /*
+     * ADCCON2: always report reference voltage ready and no fault.
+     * Firmware polls these bits during initialization.
+     */
+    if (base == PIC32MK_ADCCON2) {
+        return (s->adccon2 | PIC32MK_ADCCON2_BGVRRDY)
+               & ~PIC32MK_ADCCON2_REFFLT;
+    }
+
+    /*
+     * ADCANCON: mirror ANENx bits into WKRDYx positions.
+     * Firmware enables ANENx then polls WKRDYx until ready.
+     */
+    if (base == PIC32MK_ADCANCON) {
+        uint32_t anen = s->adcancon & 0xFFu;
+        return (s->adcancon & ~0xFF00u) | (anen << 8);
+    }
+
+    /* ADCDATA registers (0x600–0x950 range, stride 0x10) */
+    if (base >= PIC32MK_ADCDATA_BASE &&
+        base < PIC32MK_ADCDATA_BASE + PIC32MK_ADC_MAX_CH * PIC32MK_ADCDATA_STRIDE) {
+        unsigned ch = (base - PIC32MK_ADCDATA_BASE) / PIC32MK_ADCDATA_STRIDE;
+        if (ch < PIC32MK_ADC_MAX_CH && adchs_channel_valid(ch)) {
+            /* Auto-clear data-ready status on read */
+            if (ch < 32) {
+                s->adcdstat[0] &= ~(1u << ch);
+            } else {
+                s->adcdstat[1] &= ~(1u << (ch - 32));
+            }
+            return s->adcdata[ch];
+        }
+    }
+
+    /* Standard register dispatch */
+    uint32_t *reg = adchs_find_reg(s, base);
+    if (reg) {
+        return *reg;
+    }
+
+    qemu_log_mask(LOG_UNIMP,
+                  "pic32mk_adchs: unimplemented read @ 0x%04" HWADDR_PRIx "\n",
+                  addr);
+    return 0;
+}
+
+/*
+ * MMIO write
+ * -----------------------------------------------------------------------
+ */
+
+static void adchs_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
+{
+    PIC32MKADCHSState *s = opaque;
+    int sub     = (int)(addr & 0xF);
+    hwaddr base = addr & ~(hwaddr)0xF;
+
+    /* ADCDATA registers are read-only from firmware perspective */
+    if (base >= PIC32MK_ADCDATA_BASE &&
+        base < PIC32MK_ADCDATA_BASE + PIC32MK_ADC_MAX_CH * PIC32MK_ADCDATA_STRIDE) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "pic32mk_adchs: write to read-only ADCDATA @ 0x%04"
+                      HWADDR_PRIx "\n", addr);
+        return;
+    }
+
+    /* Special handling for ADCCON3 — trigger bits */
+    if (base == PIC32MK_ADCCON3) {
+        uint32_t old = s->adccon3;
+        apply_sci(&s->adccon3, (uint32_t)val, sub);
+
+        /* GSWTRG: global software trigger → scan conversion */
+        if ((s->adccon3 & PIC32MK_ADCCON3_GSWTRG) &&
+            !(old & PIC32MK_ADCCON3_GSWTRG)) {
+            adchs_scan_convert(s);
+            /* GSWTRG is self-clearing */
+            s->adccon3 &= ~PIC32MK_ADCCON3_GSWTRG;
+        }
+
+        /* GLSWTRG: global level software trigger → also scan */
+        if ((s->adccon3 & PIC32MK_ADCCON3_GLSWTRG) &&
+            !(old & PIC32MK_ADCCON3_GLSWTRG)) {
+            adchs_scan_convert(s);
+        }
+
+        /* RQCNVRT: request single-channel conversion */
+        if ((s->adccon3 & PIC32MK_ADCCON3_RQCNVRT) &&
+            !(old & PIC32MK_ADCCON3_RQCNVRT)) {
+            unsigned ch = s->adccon3 & PIC32MK_ADCCON3_ADINSEL_MASK;
+            adchs_convert_channel(s, ch);
+            /* RQCNVRT is self-clearing */
+            s->adccon3 &= ~PIC32MK_ADCCON3_RQCNVRT;
+        }
+        return;
+    }
+
+    /* Standard register dispatch */
+    uint32_t *reg = adchs_find_reg(s, base);
+    if (reg) {
+        apply_sci(reg, (uint32_t)val, sub);
+        return;
+    }
+
+    qemu_log_mask(LOG_UNIMP,
+                  "pic32mk_adchs: unimplemented write @ 0x%04" HWADDR_PRIx
+                  " = 0x%08" PRIx64 "\n",
+                  addr, val);
+}
+
+static const MemoryRegionOps adchs_ops = {
+    .read       = adchs_read,
+    .write      = adchs_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+/*
+ * QOM properties — host-side analog value injection
+ * -----------------------------------------------------------------------
+ */
+
+static void adchs_prop_ch_get(Object *obj, Visitor *v, const char *name,
+                              void *opaque, Error **errp)
+{
+    PIC32MKADCHSState *s = PIC32MK_ADCHS(obj);
+    unsigned ch = (unsigned)(uintptr_t)opaque;
+    int64_t val = s->analog_input[ch];
+    visit_type_int(v, name, &val, errp);
+}
+
+static void adchs_prop_ch_set(Object *obj, Visitor *v, const char *name,
+                              void *opaque, Error **errp)
+{
+    PIC32MKADCHSState *s = PIC32MK_ADCHS(obj);
+    unsigned ch = (unsigned)(uintptr_t)opaque;
+    int64_t val;
+
+    if (!visit_type_int(v, name, &val, errp)) {
+        return;
+    }
+    if (val < 0 || val > 4095) {
+        error_setg(errp, "adc-ch%u value must be 0–4095 (12-bit)", ch);
+        return;
+    }
+    s->analog_input[ch] = (uint16_t)val;
+    s->adcdata[ch]      = (uint16_t)(val & 0xFFF);
+}
+
+static void adchs_prop_data_get(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    PIC32MKADCHSState *s = PIC32MK_ADCHS(obj);
+    unsigned ch = (unsigned)(uintptr_t)opaque;
+    int64_t val = s->adcdata[ch];
+    visit_type_int(v, name, &val, errp);
+}
+
+/*
+ * Device lifecycle
+ * -----------------------------------------------------------------------
+ */
+
+static void pic32mk_adchs_reset(DeviceState *dev)
+{
+    PIC32MKADCHSState *s = PIC32MK_ADCHS(dev);
+
+    s->adccon1    = 0;
+    s->adccon2    = 0;
+    s->adccon3    = 0;
+    s->adctrgmode = 0;
+
+    memset(s->adcimcon, 0, sizeof(s->adcimcon));
+    memset(s->adcgirqen, 0, sizeof(s->adcgirqen));
+    memset(s->adccss, 0, sizeof(s->adccss));
+    memset(s->adcdstat, 0, sizeof(s->adcdstat));
+    memset(s->adccmpen, 0, sizeof(s->adccmpen));
+    memset(s->adccmp, 0, sizeof(s->adccmp));
+    memset(s->adccmpcon, 0, sizeof(s->adccmpcon));
+    memset(s->adcfltr, 0, sizeof(s->adcfltr));
+    memset(s->adctrg, 0, sizeof(s->adctrg));
+    s->adctrgsns = 0;
+    memset(s->adctime, 0, sizeof(s->adctime));
+    memset(s->adceien, 0, sizeof(s->adceien));
+    memset(s->adceistat, 0, sizeof(s->adceistat));
+    s->adcancon  = 0;
+    s->adcbase   = 0;
+    memset(s->adccfg, 0, sizeof(s->adccfg));
+    memset(s->adcsyscfg, 0, sizeof(s->adcsyscfg));
+    memset(s->adcdata, 0, sizeof(s->adcdata));
+    /* analog_input[] is NOT reset — host injections persist across resets */
+}
+
+static void pic32mk_adchs_init(Object *obj)
+{
+    PIC32MKADCHSState *s = PIC32MK_ADCHS(obj);
+
+    memory_region_init_io(&s->mr, obj, &adchs_ops, s,
+                          TYPE_PIC32MK_ADCHS, PIC32MK_ADC_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mr);
+
+    /* IRQ outputs: 0=EOS, 1=main */
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq_eos);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq_main);
+
+    /*
+     * QOM properties for host-side analog value injection.
+     * adc-ch<N>   — int r/w — set the 12-bit analog value for channel N
+     * adc-data<N> — int r/o — read the last conversion result for channel N
+     */
+    for (unsigned ch = 0; ch < PIC32MK_ADC_MAX_CH; ch++) {
+        if (!adchs_channel_valid(ch)) {
+            continue;
+        }
+
+        char name_ch[16], name_data[16];
+        snprintf(name_ch, sizeof(name_ch), "adc-ch%u", ch);
+        snprintf(name_data, sizeof(name_data), "adc-data%u", ch);
+
+        object_property_add(obj, name_ch, "int",
+                            adchs_prop_ch_get,
+                            adchs_prop_ch_set,
+                            NULL, (void *)(uintptr_t)ch);
+
+        object_property_add(obj, name_data, "int",
+                            adchs_prop_data_get,
+                            NULL,   /* read-only */
+                            NULL, (void *)(uintptr_t)ch);
+    }
+}
+
+static void pic32mk_adchs_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    device_class_set_legacy_reset(dc, pic32mk_adchs_reset);
+}
+
+static const TypeInfo pic32mk_adchs_info = {
+    .name          = TYPE_PIC32MK_ADCHS,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(PIC32MKADCHSState),
+    .instance_init = pic32mk_adchs_init,
+    .class_init    = pic32mk_adchs_class_init,
+};
+
+static void pic32mk_adchs_register_types(void)
+{
+    type_register_static(&pic32mk_adchs_info);
+}
+
+type_init(pic32mk_adchs_register_types)
diff --git a/hw/mips/pic32mk_canfd.c b/hw/mips/pic32mk_canfd.c
new file mode 100644
index 0000000000..eb2a89a2ce
--- /dev/null
+++ b/hw/mips/pic32mk_canfd.c
@@ -0,0 +1,1143 @@
+/*
+ * Microchip PIC32MK CAN FD controller emulation
+ * Based on PIC32MK GPK/MCM with CAN FD Family Datasheet (DS60001519E)
+ * and Microchip CAN FD Controller Reference Manual (DS60001507).
+ *
+ * Implements:
+ *  - Two MemoryRegions per instance: SFR block + Message RAM
+ *  - Operating mode transitions (Config / Normal / Internal Loopback / others)
+ *  - TX Queue (TXQ) and up to 31 configurable FIFOs
+ *  - UINC pointer-advance protocol (head/tail management)
+ *  - Internal loopback: TX → acceptance filter → RX FIFO
+ *  - CiINT two-level interrupt aggregator → single EVIC IRQ line
+ *  - 32 acceptance filters with mask
+ *  - SET/CLR/INV register aliasing for key registers
+ *
+ * Not yet implemented:
+ *  - CiFIFOBA register (message RAM base set by firmware; needed for
+ *    Harmony3-generated drivers that call CFD1FIFOBA = KVA_TO_PA(buf))
+ *  - TEF (TX Event FIFO) population on TX complete
+ *  - CiTBC free-running counter (timestamp)
+ *
+ * Copyright (c) 2026 QEMU contributors
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/units.h"
+#include "qapi/error.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/sysbus.h"
+#include "hw/core/irq.h"
+#include "hw/mips/pic32mk.h"
+#include "hw/mips/pic32mk_canfd.h"
+
+/*
+ * DLC / PLSIZE helpers
+ * -----------------------------------------------------------------------
+ */
+
+static const uint8_t dlc_to_bytes_fd[16] = {
+    0, 1, 2, 3, 4, 5, 6, 7, 8, 12, 16, 20, 24, 32, 48, 64
+};
+
+static uint8_t canfd_dlc_bytes(uint8_t dlc, bool fdf)
+{
+    if (dlc > 8 && !fdf) {
+        return 8;
+    }
+    return dlc_to_bytes_fd[dlc & 0xF];
+}
+
+/* PLSIZE field → payload bytes */
+static const uint8_t plsize_to_bytes[8] = { 8, 12, 16, 20, 24, 32, 48, 64 };
+
+static uint32_t canfd_obj_size(uint32_t fifocon)
+{
+    uint8_t plsize = (fifocon >> CANFD_FIFO_PLSIZE_SHIFT) & 0x7u;
+    return 8u + plsize_to_bytes[plsize];   /* 2 header words + payload */
+}
+
+/*
+ * Message RAM layout helpers
+ *
+ * Layout (sequential from msg_ram_phys):
+ *   [TXQ  region] if TXQEN
+ *   [TEF  region] if STEF
+ *   [FIFO 1..31]
+ *
+ * For simplicity we pre-allocate the maximum per region and compute
+ * offsets statically from the FIFO configuration registers.
+ * -----------------------------------------------------------------------
+ */
+
+#define CANFD_MAX_OBJ_SIZE  72u   /* 8 header + 64 payload */
+#define CANFD_MAX_DEPTH     32u   /* FSIZE+1 max */
+
+static uint32_t canfd_txq_ram_base(PIC32MKCANFDState *s)
+{
+    return s->msg_ram_phys;
+}
+
+static uint32_t canfd_txq_obj_size(PIC32MKCANFDState *s)
+{
+    return canfd_obj_size(s->txqcon);
+}
+
+static uint32_t canfd_txq_depth(PIC32MKCANFDState *s)
+{
+    return ((s->txqcon >> CANFD_FIFO_FSIZE_SHIFT) & 0x1Fu) + 1u;
+}
+
+/* Region base for FIFO n (1-based) within the message RAM buffer */
+static uint32_t canfd_fifo_ram_base(PIC32MKCANFDState *s, int n)
+{
+    /* TXQ region */
+    uint32_t off = 0;
+    if (s->con & CANFD_CON_TXQEN) {
+        off += canfd_txq_obj_size(s) * canfd_txq_depth(s);
+    }
+    /* TEF region (each TEF object = 8 bytes, no payload) */
+    if (s->con & CANFD_CON_STEF) {
+        uint32_t tef_depth = ((s->tefcon >> CANFD_FIFO_FSIZE_SHIFT) & 0x1Fu) + 1u;
+        off += 8u * tef_depth;
+    }
+    /* FIFOs 1..n-1 */
+    for (int i = 1; i < n; i++) {
+        uint32_t depth = ((s->fifocon[i] >> CANFD_FIFO_FSIZE_SHIFT) & 0x1Fu) + 1u;
+        off += canfd_obj_size(s->fifocon[i]) * depth;
+    }
+    return s->msg_ram_phys + off;
+}
+
+static uint32_t canfd_fifo_slot_ua(PIC32MKCANFDState *s, int n, uint8_t slot)
+{
+    return canfd_fifo_ram_base(s, n) + (uint32_t)slot * canfd_obj_size(s->fifocon[n]);
+}
+
+static uint32_t canfd_txq_slot_ua(PIC32MKCANFDState *s, uint8_t slot)
+{
+    return canfd_txq_ram_base(s) + (uint32_t)slot * canfd_txq_obj_size(s);
+}
+
+/*
+ * IRQ update — recomputes CiINT status bits and asserts/deasserts IRQ
+ * -----------------------------------------------------------------------
+ */
+
+static void canfd_update_irq(PIC32MKCANFDState *s)
+{
+    bool fire = false;
+
+    /* RXIF: any RX FIFO has data */
+    if (s->cint & CANFD_INT_RXIE) {
+        if (s->rxif) {
+            s->cint |= CANFD_INT_RXIF;
+            fire = true;
+        } else {
+            s->cint &= ~CANFD_INT_RXIF;
+        }
+    }
+
+    /* TXIF: any TX FIFO / TXQ completed */
+    if (s->cint & CANFD_INT_TXIE) {
+        if (s->txif) {
+            s->cint |= CANFD_INT_TXIF;
+            fire = true;
+        } else {
+            s->cint &= ~CANFD_INT_TXIF;
+        }
+    }
+
+    /* MODIF: mode changed and MODIE enabled */
+    if ((s->cint & CANFD_INT_MODIE) && (s->cint & CANFD_INT_MODIF)) {
+        fire = true;
+    }
+
+    /* RXOVIF: any RX overflow and RXOVIE enabled */
+    if ((s->cint & CANFD_INT_RXOVIE) && (s->cint & CANFD_INT_RXOVIF)) {
+        fire = true;
+    }
+
+    qemu_set_irq(s->irq, fire ? 1 : 0);
+}
+
+/*
+ * Acceptance filter matching
+ * Returns destination FIFO index (1-based) or -1 if no match.
+ * -----------------------------------------------------------------------
+ */
+
+static int canfd_find_fifo(PIC32MKCANFDState *s, uint32_t id, bool xtd)
+{
+    for (int n = 0; n < 32; n++) {
+        /* Each CiFLTCON register holds 4 filter bytes */
+        uint8_t fltcon_byte = (s->fltcon[n / 4] >> ((n % 4) * 8)) & 0xFFu;
+        if (!(fltcon_byte & 0x80u)) {
+            continue;   /* FLTEN = 0 */
+        }
+
+        uint32_t obj  = s->fltobj[n];
+        uint32_t msk  = s->mask[n];
+
+        /*
+         * MIDE bit (bit 29 of CiMASKn): when set, the filter only matches
+         * frames whose IDE bit equals FLTOBJ.IDE (bit 30).
+         * When MIDE=0, the filter accepts both standard and extended frames.
+         */
+        if (msk & (1u << 29u)) {
+            bool obj_xtd = (obj >> 30) & 1u;
+            if (obj_xtd != xtd) {
+                continue;
+            }
+        }
+
+        /* (frame_id XOR filter_id) AND mask == 0 means match */
+        if ((id ^ (obj & 0x1FFFFFFFu)) & (msk & 0x1FFFFFFFu)) {
+            continue;
+        }
+
+        return fltcon_byte & 0x1Fu;   /* destination FIFO */
+    }
+    return -1;
+}
+
+/*
+ * RX deliver — write an incoming frame into the matching RX FIFO
+ * -----------------------------------------------------------------------
+ */
+
+static void canfd_rx_deliver(PIC32MKCANFDState *s,
+                             uint32_t id, bool xtd, bool fdf,
+                             uint8_t dlc, const uint8_t *data, int len,
+                             int filter_hit)
+{
+    int dest = filter_hit;
+    if (dest < 1 || dest > 31) {
+        return;
+    }
+
+    uint32_t depth = ((s->fifocon[dest] >> CANFD_FIFO_FSIZE_SHIFT) & 0x1Fu) + 1u;
+    if (s->fifo_count[dest] >= (uint8_t)depth) {
+        /* Overflow */
+        s->rxovif |= (1u << dest);
+        s->cint   |= CANFD_INT_RXOVIF;
+        canfd_update_irq(s);
+        return;
+    }
+
+    /* Write message object to tail slot */
+    uint32_t ua = canfd_fifo_slot_ua(s, dest, s->fifo_tail[dest]);
+    uint32_t ram_off = ua - s->msg_ram_phys;
+    uint8_t *obj = s->msg_ram_buf + ram_off;
+    uint32_t payload_cap = canfd_obj_size(s->fifocon[dest]) - 8u;
+    uint8_t dlc_len = canfd_dlc_bytes(dlc, fdf);
+    uint8_t copy_len = (uint8_t)MIN((uint32_t)MAX(len, 0), payload_cap);
+    if (copy_len > dlc_len) {
+        copy_len = dlc_len;
+    }
+
+    /*
+     * RX message object R0/R1 layout (DS60001507 Table 38-2):
+     *   R0[10:0]  : SID[10:0]  (or upper 11 of 29-bit EID)
+     *   R0[28:11] : EID[17:0]  (lower 18 bits of 29-bit extended ID)
+     *   R0[30]    : EXIDE      (1 = extended frame) — matches CiFLTOBJ layout
+     *   R1[4]     : IDE        (1 = extended frame) — this is what plib_canfd checks
+     * Note: TX T0 has the same SID/EID layout but IDE is in T1[4], not T0[30].
+     */
+    uint32_t r0;
+    if (xtd) {
+        /* 29-bit extended: SID = ID[28:18], EID = ID[17:0] */
+        r0 = ((id >> 18) & 0x7FFu)          /* SID → r0 bits [10:0]  */
+           | ((id & 0x3FFFFu) << 11)         /* EID → r0 bits [28:11] */
+           | (1u << 30u);                    /* IDE = 1                */
+    } else {
+        r0 = id & 0x7FFu;                   /* SID → r0 bits [10:0]  */
+    }
+    *(uint32_t *)(obj + 0) = r0;
+
+    /* R1: DLC, flags, FILHIT, RXTS=0 */
+    uint32_t r1 = (uint32_t)dlc
+                | (xtd ? (1u << 4) : 0u)
+                | (fdf ? (1u << 7) : 0u)
+                | ((uint32_t)(filter_hit & 0x1F) << 11);
+    *(uint32_t *)(obj + 4) = r1;
+
+    /*
+     * RX message data area layout (DS60001507 Figure 3-2):
+     *   data[0..3] : RXMSGTS — 32-bit receive timestamp (always present when
+     *                RXTSEN=1 in FIFOCONn; firmware expects this field)
+     *   data[4..]  : Payload bytes
+     *
+     * Harmony3 plib_canfd always reads payload from data[4] onwards, so we
+     * must write a timestamp (even if 0) before the payload.
+     */
+    memset(obj + 8, 0, payload_cap);           /* Clear timestamp + payload */
+    *(uint32_t *)(obj + 8) = s->tbc;           /* Write timestamp at data[0..3] */
+    if (copy_len > 0 && data) {
+        memcpy(obj + 12, data, copy_len);      /* Payload starts at data[4] */
+    }
+
+    /* Advance tail */
+    s->fifo_tail[dest] = (s->fifo_tail[dest] + 1u) % (uint8_t)depth;
+    s->fifo_count[dest]++;
+
+    /*
+     * Set interrupt flags — TFNRFNIF signals data present.
+     * Only assert RXIF if TFNRFNIE (per-FIFO RX interrupt enable) is set;
+     * otherwise the frame waits silently until firmware arms reception
+     * via CAN_MessageReceive() which re-enables TFNRFNIE.
+      */
+    s->fifosta[dest] |= CANFD_FIFOSTA_TFNRFNIF;
+    if (s->fifocon[dest] & CANFD_FIFO_TFNRFNIE) {
+        s->rxif |= (1u << dest);
+    }
+
+    /*
+     * Update UA: RX has no write slot; keep head slot for firmware read.
+     */
+    s->fifoua[dest] = canfd_fifo_slot_ua(s, dest, s->fifo_head[dest]);
+
+    /* CiVEC.ICODE — firmware RX ISR reads this to learn which FIFO fired */
+    s->vec = (uint32_t)dest & 0x7Fu;
+
+    canfd_update_irq(s);
+}
+
+/*
+ * TX processing — triggered when TXREQ is set for a FIFO or TXQ
+ * -----------------------------------------------------------------------
+ */
+
+static void canfd_process_tx(PIC32MKCANFDState *s, int fifo)
+{
+    uint32_t ua;
+    if (fifo == 0) {
+        /* TXQ: transmit from head (oldest queued frame) */
+        ua = canfd_txq_slot_ua(s, s->txq_head);
+    } else {
+        /* TX FIFO: transmit from head (oldest pending frame) */
+        ua = canfd_fifo_slot_ua(s, fifo, s->fifo_head[fifo]);
+    }
+
+    uint32_t ram_off = ua - s->msg_ram_phys;
+    if (ram_off >= PIC32MK_CAN_MSGRAM_SIZE) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "pic32mk-canfd: TX UA 0x%08x out of message RAM\n", ua);
+        return;
+    }
+
+    const uint8_t *obj = s->msg_ram_buf + ram_off;
+    uint32_t t0  = *(const uint32_t *)(obj + 0);
+    uint32_t t1  = *(const uint32_t *)(obj + 4);
+    uint8_t  dlc = t1 & 0xFu;
+    bool     fdf = (t1 >> 7) & 1u;
+    bool     xtd = (t1 >> 4) & 1u;   /* IDE in T1[4], not T0[30] per DS60001507 s3.1 */
+    /* T0 ID layout: SID in bits[10:0], EID in bits[28:11] (same as R0/CiFLTOBJ) */
+    uint32_t id  = xtd ? (((t0 & 0x7FFu) << 18) | ((t0 >> 11) & 0x3FFFFu))
+                       : (t0 & 0x7FFu);
+    int      len = canfd_dlc_bytes(dlc, fdf);
+    const uint8_t *data = obj + 8;
+
+    uint8_t opmod = (s->con >> CANFD_CON_OPMOD_SHIFT) & 0x7u;
+    if (opmod == CANFD_OPMOD_INT_LOOP) {
+        /* Internal loopback: deliver frame through acceptance filters */
+        int dest = canfd_find_fifo(s, id, xtd);
+        if (dest >= 1) {
+            canfd_rx_deliver(s, id, xtd, fdf, dlc, data, len, dest);
+        }
+    } else {
+        /* External TX: send frame to the virtual CAN bus */
+        qemu_can_frame frame = {};
+        frame.can_id  = xtd ? (id | QEMU_CAN_EFF_FLAG) : id;
+        frame.can_dlc = (uint8_t)len;
+        frame.flags   = fdf ? QEMU_CAN_FRMF_TYPE_FD : 0u;
+        memcpy(frame.data, data, (size_t)len);
+        if (s->canbus) {
+            can_bus_client_send(&s->bus_client, &frame, 1);
+        } else {
+            qemu_log_mask(LOG_UNIMP,
+                          "pic32mk-canfd[%u]: no canbus connected, "
+                          "dropping TX frame id=0x%08x\n", s->instance_id, id);
+        }
+    }
+
+    /* TX complete bookkeeping */
+    if (fifo == 0) {
+        /* TXQ: advance head (oldest pending frame consumed) */
+        uint8_t depth = (uint8_t)canfd_txq_depth(s);
+        s->txq_head = (s->txq_head + 1u) % depth;
+        if (s->txq_count > 0) {
+            s->txq_count--;
+        }
+        s->txqcon  &= ~CANFD_FIFO_TXREQ;
+        s->txqsta  |= CANFD_TXQSTA_TXQNIF;  /* slot available */
+        s->txif    |= 1u;          /* bit 0 = TXQ */
+        s->vec      = 0u;          /* ICODE=0 for TXQ */
+    } else {
+        uint32_t depth = ((s->fifocon[fifo] >> CANFD_FIFO_FSIZE_SHIFT) & 0x1Fu) + 1u;
+        s->fifo_head[fifo] = (s->fifo_head[fifo] + 1u) % (uint8_t)depth;
+        if (s->fifo_count[fifo] > 0) {
+            s->fifo_count[fifo]--;
+        }
+        s->fifocon[fifo] &= ~CANFD_FIFO_TXREQ;
+        s->fifosta[fifo] |= CANFD_FIFOSTA_TXATIF;
+        /* TX slot freed — TX FIFO is no longer full */
+        s->fifosta[fifo] |= CANFD_FIFOSTA_TFNRFNIF;
+        s->txif |= (1u << fifo);
+        s->vec   = (uint32_t)fifo & 0x7Fu;  /* ICODE = FIFO number */
+    }
+
+    canfd_update_irq(s);
+}
+
+/* Forward declaration — defined below canfd_receive() */
+static void canfd_bus_buf_drain(PIC32MKCANFDState *s);
+
+/*
+ * UINC — advance head (RX) or tail (TX) pointer, clear UINC bit
+ * -----------------------------------------------------------------------
+ */
+
+static void canfd_uinc_fifo(PIC32MKCANFDState *s, int n)
+{
+    bool is_tx = (s->fifocon[n] & CANFD_FIFO_TXEN) != 0u;
+    uint32_t depth = ((s->fifocon[n] >> CANFD_FIFO_FSIZE_SHIFT) & 0x1Fu) + 1u;
+
+    if (is_tx) {
+        /* Firmware finished writing a TX object — advance tail */
+        s->fifo_tail[n] = (s->fifo_tail[n] + 1u) % (uint8_t)depth;
+        s->fifo_count[n]++;
+        s->fifoua[n] = canfd_fifo_slot_ua(s, n, s->fifo_tail[n]);
+        /* TX FIFO full — clear "not full" flag so firmware won't overwrite */
+        if (s->fifo_count[n] >= (uint8_t)depth) {
+            s->fifosta[n] &= ~CANFD_FIFOSTA_TFNRFNIF;
+        }
+    } else {
+        /* Firmware finished reading an RX object — advance head */
+        if (s->fifo_count[n] > 0) {
+            s->fifo_count[n]--;
+        }
+        s->fifo_head[n] = (s->fifo_head[n] + 1u) % (uint8_t)depth;
+        s->fifoua[n] = canfd_fifo_slot_ua(s, n, s->fifo_head[n]);
+
+        if (s->fifo_count[n] == 0) {
+            s->rxif     &= ~(1u << n);
+            s->fifosta[n] &= ~CANFD_FIFOSTA_TFNRFNIF;
+        }
+        canfd_update_irq(s);
+        /*
+         * Drain bus_buf after UINC: firmware just freed a FIFO slot, so the
+         * next buffered frame can be delivered immediately.  In polling mode
+         * the firmware checks FIFOSTA.TFNRFNIF directly after UINC; delivering
+         * here ensures that flag is set before the next poll.  In interrupt
+         * mode with TFNRFNIE enabled, canfd_rx_deliver will re-raise the IRQ
+         * for the newly delivered frame.
+          */
+        canfd_bus_buf_drain(s);
+    }
+}
+
+static void canfd_uinc_txq(PIC32MKCANFDState *s)
+{
+    uint8_t depth = (uint8_t)canfd_txq_depth(s);
+    /* Advance tail — firmware finished writing a TX object */
+    s->txq_tail = (s->txq_tail + 1u) % depth;
+    s->txq_count++;
+    /* UA now points at the next empty write slot */
+    s->txqua = canfd_txq_slot_ua(s, s->txq_tail);
+}
+
+/*
+ * FRESET — reset a FIFO to empty state
+ * -----------------------------------------------------------------------
+ */
+
+static void canfd_freset_fifo(PIC32MKCANFDState *s, int n)
+{
+    s->fifo_head[n]  = 0;
+    s->fifo_tail[n]  = 0;
+    s->fifo_count[n] = 0;
+    s->rxif         &= ~(1u << n);
+    s->txif         &= ~(1u << n);
+    s->fifosta[n]    = 0;
+    /* TX FIFO: empty after reset means "not full" → TFNRFNIF = 1 */
+    if (s->fifocon[n] & CANFD_FIFO_TXEN) {
+        s->fifosta[n] |= CANFD_FIFOSTA_TFNRFNIF;
+    }
+    s->fifoua[n]     = canfd_fifo_slot_ua(s, n, 0);
+    canfd_update_irq(s);
+}
+
+/*
+ * Abort all pending TX (CiCON.ABAT)
+ * -----------------------------------------------------------------------
+ */
+
+static void canfd_abort_all_tx(PIC32MKCANFDState *s)
+{
+    /* TXQ */
+    s->txqcon  &= ~CANFD_FIFO_TXREQ;
+    s->txqsta  |= CANFD_TXQSTA_TXQNIF;
+
+    /* TX FIFOs */
+    for (int i = 1; i < 32; i++) {
+        if (s->fifocon[i] & CANFD_FIFO_TXEN) {
+            s->fifocon[i] &= ~CANFD_FIFO_TXREQ;
+            s->fifosta[i] |= CANFD_FIFOSTA_TXATIF;
+            s->txif |= (1u << i);
+        }
+    }
+    canfd_update_irq(s);
+}
+
+/*
+ * SocketCAN virtual bus callbacks
+ *
+ * When a can-bus object is linked (via the "canbus" QOM property), the
+ * device behaves as a bus participant:
+ *   TX (non-loopback): canfd_process_tx() calls can_bus_client_send()
+ *   RX (from bus):     canfd_receive() delivers frames through the
+ *                      acceptance filter into an RX FIFO
+ * -----------------------------------------------------------------------
+ */
+
+static bool canfd_can_receive(CanBusClientState *client)
+{
+    PIC32MKCANFDState *s = container_of(client, PIC32MKCANFDState, bus_client);
+    uint8_t opmod = (s->con >> CANFD_CON_OPMOD_SHIFT) & 0x7u;
+    /*
+     * Accept incoming frames in Normal, External Loopback, Listen-only,
+     * and Restricted modes — not in Config or Internal Loopback mode.
+      */
+    return opmod == CANFD_OPMOD_NORMAL
+        || opmod == CANFD_OPMOD_EXT_LOOP
+        || opmod == CANFD_OPMOD_LISTEN
+        || opmod == CANFD_OPMOD_RESTRICTED;
+}
+
+/*
+ * Drain the software bus buffer into hardware RX FIFOs.
+ * Called after each RX UINC — the firmware just freed a FIFO slot so we can
+ * deliver at most one buffered frame per UINC (matching real FIFO depth-1
+ * behaviour).  Stops when the head frame's target FIFO is still full.
+ */
+static void canfd_bus_buf_drain(PIC32MKCANFDState *s)
+{
+    while (s->bus_buf_count > 0) {
+        int n = s->bus_buf_head;
+        int dest = s->bus_buf_dest[n];
+        uint32_t depth = ((s->fifocon[dest] >> CANFD_FIFO_FSIZE_SHIFT) & 0x1Fu) + 1u;
+        if (s->fifo_count[dest] >= (uint8_t)depth) {
+            break;  /* target FIFO still full — wait for next UINC */
+        }
+        canfd_rx_deliver(s,
+                         s->bus_buf_id[n], s->bus_buf_xtd[n],
+                         s->bus_buf_fdf[n], s->bus_buf_dlc[n],
+                         s->bus_buf_data[n], s->bus_buf_len[n], dest);
+        s->bus_buf_head = (s->bus_buf_head + 1) % 64;
+        s->bus_buf_count--;
+    }
+}
+
+static ssize_t canfd_receive(CanBusClientState *client,
+                             const qemu_can_frame *frames, size_t frames_cnt)
+{
+    PIC32MKCANFDState *s = container_of(client, PIC32MKCANFDState, bus_client);
+
+    for (size_t i = 0; i < frames_cnt; i++) {
+        const qemu_can_frame *f = &frames[i];
+        bool     xtd = (f->can_id & QEMU_CAN_EFF_FLAG) != 0;
+        uint32_t id  = xtd ? (f->can_id & QEMU_CAN_EFF_MASK)
+                           : (f->can_id & QEMU_CAN_SFF_MASK);
+        bool     fdf = (f->flags & QEMU_CAN_FRMF_TYPE_FD) != 0;
+        uint8_t  dlc = can_len2dlc(f->can_dlc);
+        uint8_t  rx_len = MIN((uint8_t)f->can_dlc, canfd_dlc_bytes(dlc, fdf));
+        int      dest = canfd_find_fifo(s, id, xtd);
+
+        /* Log received frame with full payload hex dump */
+
+        if (dest < 1) {
+            continue;  /* no filter match */
+        }
+
+        uint32_t depth = ((s->fifocon[dest] >> CANFD_FIFO_FSIZE_SHIFT) & 0x1Fu) + 1u;
+        if (s->fifo_count[dest] < (uint8_t)depth) {
+            /* FIFO has space — deliver directly */
+            canfd_rx_deliver(s, id, xtd, fdf, dlc, f->data, rx_len, dest);
+        } else if (s->bus_buf_count < 64) {
+            /* FIFO full — buffer for later delivery after UINC */
+            int slot = s->bus_buf_tail;
+            s->bus_buf_id[slot]  = id;
+            s->bus_buf_xtd[slot] = xtd;
+            s->bus_buf_fdf[slot] = fdf;
+            s->bus_buf_dlc[slot] = dlc;
+            s->bus_buf_len[slot] = rx_len;
+            s->bus_buf_dest[slot] = dest;
+            memcpy(s->bus_buf_data[slot], f->data, rx_len);
+            s->bus_buf_tail = (s->bus_buf_tail + 1) % 64;
+            s->bus_buf_count++;
+        } else {
+            /* Software buffer also full — real bus overflow */
+            s->rxovif |= (1u << dest);
+            s->cint   |= CANFD_INT_RXOVIF;
+            canfd_update_irq(s);
+        }
+    }
+    return (ssize_t)frames_cnt;
+}
+
+static CanBusClientInfo canfd_bus_client_info = {
+    .can_receive = canfd_can_receive,
+    .receive     = canfd_receive,
+};
+
+/*
+ * SFR MMIO read
+ *
+ * Each logical register occupies 0x10 bytes: +0=base, +4=SET, +8=CLR, +C=INV.
+ * Reads always return the base register value regardless of sub-offset.
+ * -----------------------------------------------------------------------
+ */
+
+static uint64_t canfd_sfr_read(void *opaque, hwaddr offset, unsigned size)
+{
+    PIC32MKCANFDState *s = opaque;
+    /* Strip SET/CLR/INV sub-offset: base is at (offset & ~0xCu) */
+    hwaddr base_off = offset & ~0xCu;
+
+    switch (base_off) {
+    case CANFD_CiCON:
+        return s->con;
+    case CANFD_CiNBTCFG:
+        return s->nbtcfg;
+    case CANFD_CiDBTCFG:
+        return s->dbtcfg;
+    case CANFD_CiTDC:
+        return s->tdc;
+    case CANFD_CiTBC:
+        return s->tbc;
+    case CANFD_CiTSCON:
+        return s->tscon;
+    case CANFD_CiVEC:
+        return s->vec;
+    case CANFD_CiINT:
+        return s->cint;
+    case CANFD_CiRXIF:
+        return s->rxif;
+    case CANFD_CiTXIF:
+        return s->txif;
+    case CANFD_CiRXOVIF:
+        return s->rxovif;
+    case CANFD_CiTXATIF:
+        return 0;
+    case CANFD_CiTXREQ:
+        return s->txreq;
+    case CANFD_CiTREC:
+        return s->trec;
+    case CANFD_CiTEFCON:
+        return s->tefcon;
+    case CANFD_CiTEFSTA:
+        return s->tefsta;
+    case CANFD_CiTEFUA:
+        return s->tefua;
+    case CANFD_CiFIFOBA:
+        return 0;
+    case CANFD_CiTXQCON:
+        return s->txqcon;
+    case CANFD_CiTXQSTA:
+        return s->txqsta;
+    case CANFD_CiTXQUA:
+        return s->txqua;
+    default:
+        break;
+    }
+
+    /*
+     * FIFO registers: base 0x170, stride 0x30 per FIFO (n=1..31)
+     *   +0x00: CiFIFOCONn, +0x10: CiFIFOSTAn, +0x20: CiFIFOUAn
+      */
+    if (base_off >= CANFD_CiFIFOCON(1) && base_off <= CANFD_CiFIFOCON(31) + 0x20u) {
+        int idx = (int)((base_off - 0x170u) / 0x30u) + 1;
+        int sub = (int)((base_off - 0x170u) % 0x30u);
+        if (idx >= 1 && idx <= 31) {
+            if (sub == 0x00) {
+                return s->fifocon[idx];
+            }
+            if (sub == 0x10) {
+                return s->fifosta[idx];
+            }
+            if (sub == 0x20) {
+                return s->fifoua[idx];
+            }
+        }
+    }
+
+    /* Filter control: stride 0x10 per register (r=0..7) */
+    if (base_off >= CANFD_CiFLTCON(0) && base_off <= CANFD_CiFLTCON(7)) {
+        return s->fltcon[(base_off - 0x740u) / 0x10u];
+    }
+
+    /* Filter obj/mask: stride 0x20 per pair (n=0..31) */
+    if (base_off >= CANFD_CiFLTOBJ(0) && base_off <= CANFD_CiMASK(31)) {
+        if (base_off >= 0x7C0u && base_off < 0x7C0u + 32u * 0x20u) {
+            int fn = (int)((base_off - 0x7C0u) / 0x20u);
+            return s->fltobj[fn];
+        }
+        if (base_off >= 0x7D0u && base_off < 0x7D0u + 32u * 0x20u) {
+            int fn = (int)((base_off - 0x7D0u) / 0x20u);
+            return s->mask[fn];
+        }
+    }
+
+    qemu_log_mask(LOG_UNIMP,
+                  "pic32mk-canfd: unimplemented SFR read @ +0x%03" HWADDR_PRIx "\n",
+                  offset);
+    return 0;
+}
+
+/*
+ * Apply a CLR/SET/INV write to a register value.
+ * PIC32MK convention: sub=0 → plain write, +4 → CLR, +8 → SET, +0xC → INV
+ * -----------------------------------------------------------------------
+ */
+static uint32_t apply_sci(uint32_t cur, uint32_t val, int sub)
+{
+    switch (sub) {
+    case 0:
+        return val;
+    case 4:
+        return cur & ~val;
+    case 8:
+        return cur | val;
+    case 0xC:
+        return cur ^ val;
+    default:
+        return cur;
+    }
+}
+
+/*
+ * SFR MMIO write
+ *
+ * Each logical register occupies 0x10 bytes: +0=base, +4=SET, +8=CLR, +C=INV.
+ * UINC, TXREQ, FRESET are pulse bits — handled then stripped from storage.
+ * -----------------------------------------------------------------------
+ */
+
+static void canfd_sfr_write(void *opaque, hwaddr offset, uint64_t val,
+                            unsigned size)
+{
+    PIC32MKCANFDState *s = opaque;
+    uint32_t v32     = (uint32_t)val;
+    hwaddr   base_off = offset & ~0xCu;
+    int      sub     = (int)(offset & 0xCu);
+    uint8_t  opmod   = (s->con >> CANFD_CON_OPMOD_SHIFT) & 0x7u;
+
+    switch (base_off) {
+
+    /* ---- CiCON ---- */
+    case CANFD_CiCON: {
+        uint8_t old_opmod = opmod;
+        uint32_t new_con  = apply_sci(s->con, v32, sub);
+
+        uint8_t reqop = (new_con >> CANFD_CON_REQOP_SHIFT) & 0x7u;
+        /* Reflect REQOP into OPMOD immediately; BUSY always 0 */
+        new_con = (new_con & ~CANFD_CON_OPMOD_MASK)
+                | ((uint32_t)reqop << CANFD_CON_OPMOD_SHIFT);
+        s->con = new_con;
+
+        if (reqop != old_opmod) {
+            s->cint |= CANFD_INT_MODIF;
+            canfd_update_irq(s);
+        }
+
+        /* Handle ABAT */
+        if (new_con & CANFD_CON_ABAT) {
+            canfd_abort_all_tx(s);
+            s->con &= ~CANFD_CON_ABAT;
+        }
+
+        /* Initialise TXQ UA when TXQEN becomes set */
+        if ((new_con & CANFD_CON_TXQEN) && !(s->txqua)) {
+            s->txqua = canfd_txq_slot_ua(s, s->txq_tail);
+        }
+        return;
+    }
+
+    /* ---- Bit-time / TDC — only writable in Config mode ---- */
+    case CANFD_CiNBTCFG:
+        if (opmod == CANFD_OPMOD_CONFIG) {
+            s->nbtcfg = apply_sci(s->nbtcfg, v32, sub);
+        }
+        return;
+    case CANFD_CiDBTCFG:
+        if (opmod == CANFD_OPMOD_CONFIG) {
+            s->dbtcfg = apply_sci(s->dbtcfg, v32, sub);
+        }
+        return;
+    case CANFD_CiTDC:
+        if (opmod == CANFD_OPMOD_CONFIG) {
+            s->tdc = apply_sci(s->tdc, v32, sub);
+        }
+        return;
+    case CANFD_CiTSCON:
+        s->tscon = apply_sci(s->tscon, v32, sub);
+        return;
+
+    /* CiINT: enable bits [31:16] writable; status [15:0] cleared by fw */
+    case CANFD_CiINT:
+        s->cint = apply_sci(s->cint, v32, sub);
+        canfd_update_irq(s);
+        return;
+
+    /* ---- CiRXIF / CiTXIF / CiRXOVIF — firmware clears by writing 0 ---- */
+    case CANFD_CiRXIF:
+        s->rxif = apply_sci(s->rxif, v32, sub);
+        canfd_update_irq(s);
+        return;
+    case CANFD_CiTXIF:
+        s->txif = apply_sci(s->txif, v32, sub);
+        canfd_update_irq(s);
+        return;
+    case CANFD_CiRXOVIF:
+        s->rxovif = apply_sci(s->rxovif, v32, sub);
+        return;
+
+    /* ---- CiTXREQ — writing 1 to a bit requests TX for that FIFO ---- */
+    case CANFD_CiTXREQ: {
+        uint32_t new_req = apply_sci(s->txreq, v32, sub);
+        uint32_t newly   = new_req & ~s->txreq;
+        s->txreq = new_req;
+        for (int i = 1; i < 32; i++) {
+            if (newly & (1u << i)) {
+                canfd_process_tx(s, i);
+            }
+        }
+        return;
+    }
+
+    /* ---- CiTXQCON ---- */
+    case CANFD_CiTXQCON: {
+        uint32_t new_con = apply_sci(s->txqcon, v32, sub);
+        bool uinc = (new_con & CANFD_FIFO_UINC)  != 0u;
+        bool req  = (new_con & CANFD_FIFO_TXREQ) != 0u;
+        s->txqcon = new_con & ~(CANFD_FIFO_UINC | CANFD_FIFO_TXREQ
+                                | CANFD_FIFO_FRESET);
+        /*
+         * Clearing TXQEIE (bit 4) acknowledges TX completion — deassert TXQ
+         * source in txif so TXIF is not re-asserted on the next irq update.
+          */
+        if (!(s->txqcon & (1u << 4u))) {
+            s->txif &= ~1u;
+            canfd_update_irq(s);
+        }
+        if (uinc) {
+            canfd_uinc_txq(s);
+        }
+        if (req) {
+            canfd_process_tx(s, 0);
+        }
+        return;
+    }
+
+    /* ---- CiTXQSTA / CiTXQUA — hardware-managed, ignore firmware writes ---- */
+    case CANFD_CiTXQSTA:
+    case CANFD_CiTXQUA:
+        return;
+
+    /* ---- TEF (stub) ---- */
+    case CANFD_CiTEFCON:
+        s->tefcon = apply_sci(s->tefcon, v32, sub);
+        return;
+    case CANFD_CiTEFSTA:
+        s->tefsta = apply_sci(s->tefsta, v32, sub);
+        return;
+    case CANFD_CiTEFUA:
+        return;
+
+    /* ---- CiFIFOBA — Phase 3C stub: log and ignore ---- */
+    case CANFD_CiFIFOBA:
+        if (sub == 0) {
+            qemu_log_mask(LOG_UNIMP,
+                "pic32mk-canfd: CiFIFOBA write 0x%08x (Phase 3C stub, "
+                "using fixed msg RAM base 0x%08x)\n",
+                v32, s->msg_ram_phys);
+        }
+        return;
+
+    default:
+        break;
+    }
+
+    /*
+     * ---- FIFO registers: base 0x170, stride 0x30 per FIFO (n=1..31)
+     *   +0x00: CiFIFOCONn, +0x10: CiFIFOSTAn, +0x20: CiFIFOUAn ----
+      */
+    if (base_off >= CANFD_CiFIFOCON(1) && base_off <= CANFD_CiFIFOCON(31) + 0x20u) {
+        int idx      = (int)((base_off - 0x170u) / 0x30u) + 1;
+        int field    = (int)((base_off - 0x170u) % 0x30u);
+        if (idx < 1 || idx > 31) {
+            return;
+        }
+
+        if (field == 0x00) {
+            /* CiFIFOCONn */
+            uint32_t new_con = apply_sci(s->fifocon[idx], v32, sub);
+
+            if (new_con & CANFD_FIFO_FRESET) {
+                s->fifocon[idx] = new_con & ~CANFD_FIFO_FRESET;
+                canfd_freset_fifo(s, idx);
+                return;
+            }
+
+            bool uinc  = (new_con & CANFD_FIFO_UINC)  != 0u;
+            bool txreq = (new_con & CANFD_FIFO_TXREQ)  != 0u;
+            s->fifocon[idx] = new_con & ~(CANFD_FIFO_UINC | CANFD_FIFO_TXREQ);
+
+            /*
+             * First-time TX FIFO configuration (Harmony CAN1..4 init pattern):
+             * firmware writes FIFOCONn with TXEN set; at this point the FIFO
+             * is empty so it is "not full" and FIFOUA must point to slot 0.
+             * Mirror the TXQ treatment: set TFNRFNIF=1 and initialise UA.
+              */
+            if ((s->fifocon[idx] & CANFD_FIFO_TXEN) && s->fifoua[idx] == 0) {
+                s->fifosta[idx] |= CANFD_FIFOSTA_TFNRFNIF;
+                s->fifoua[idx] = canfd_fifo_slot_ua(s, idx, 0);
+            }
+
+            /*
+             * Clearing TFERFFIE (bit 4) acknowledges TX completion for this
+             * FIFO — deassert its txif source bit.
+              */
+            if (!(s->fifocon[idx] & (1u << 4u))) {
+                s->txif &= ~(1u << idx);
+                canfd_update_irq(s);
+            }
+            if (uinc) {
+                canfd_uinc_fifo(s, idx);
+            }
+            if (txreq && (s->fifocon[idx] & CANFD_FIFO_TXEN)) {
+                canfd_process_tx(s, idx);
+            }
+
+            /*
+             * For RX FIFOs, honour TFNRFNIE: if the firmware just toggled it,
+             * update rxif to match the real hardware behaviour.
+             * Enabling  → IRQ rises  (frame already in FIFO fires interrupt)
+             * Disabling → IRQ falls  (flow-control)
+              */
+            if (!(s->fifocon[idx] & CANFD_FIFO_TXEN)) {
+                bool new_ie   = (s->fifocon[idx] & CANFD_FIFO_TFNRFNIE) != 0;
+                bool has_data = (s->fifosta[idx] & CANFD_FIFOSTA_TFNRFNIF) != 0;
+                if (has_data && new_ie) {
+                    s->rxif |= (1u << idx);
+                } else {
+                    s->rxif &= ~(1u << idx);
+                }
+                canfd_update_irq(s);
+            }
+
+        } else if (field == 0x10) {
+            /* CiFIFOSTAn — firmware can clear status flags */
+            s->fifosta[idx] = apply_sci(s->fifosta[idx], v32, sub);
+            if (!(s->fifosta[idx] & CANFD_FIFOSTA_TFNRFNIF)) {
+                if (s->fifo_count[idx] == 0) {
+                    s->rxif &= ~(1u << idx);
+                }
+            }
+            canfd_update_irq(s);
+        }
+        /* CiFIFOUA (+0x20) is hardware-owned, ignore writes */
+        return;
+    }
+
+    /* ---- Filter control: stride 0x10 per register (r=0..7) ---- */
+    if (base_off >= CANFD_CiFLTCON(0) && base_off <= CANFD_CiFLTCON(7)) {
+        int reg = (int)((base_off - 0x740u) / 0x10u);
+        s->fltcon[reg] = apply_sci(s->fltcon[reg], v32, sub);
+        return;
+    }
+
+    /* ---- Filter object / mask — only writable in Config mode ---- */
+    if (base_off >= CANFD_CiFLTOBJ(0) && base_off < 0x7D0u + 32u * 0x20u) {
+        if (opmod != CANFD_OPMOD_CONFIG) {
+            return;
+        }
+        if (base_off >= 0x7C0u && base_off < 0x7C0u + 32u * 0x20u) {
+            int fn = (int)((base_off - 0x7C0u) / 0x20u);
+            s->fltobj[fn] = apply_sci(s->fltobj[fn], v32, sub);
+        } else if (base_off >= 0x7D0u) {
+            int fn = (int)((base_off - 0x7D0u) / 0x20u);
+            if (fn < 32) {
+                s->mask[fn] = apply_sci(s->mask[fn], v32, sub);
+            }
+        }
+        return;
+    }
+
+    qemu_log_mask(LOG_UNIMP,
+                  "pic32mk-canfd: unimplemented SFR write @ +0x%03" HWADDR_PRIx
+                  " = 0x%08x\n", offset, v32);
+}
+
+static const MemoryRegionOps canfd_sfr_ops = {
+    .read       = canfd_sfr_read,
+    .write      = canfd_sfr_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+/*
+ * Device lifecycle
+ * -----------------------------------------------------------------------
+ */
+
+static void pic32mk_canfd_reset(DeviceState *dev)
+{
+    PIC32MKCANFDState *s = PIC32MK_CANFD(dev);
+
+    s->con     = CANFD_CON_RESET;    /* OPMOD=100 (Config), REQOP=100 */
+    s->nbtcfg  = 0;
+    s->dbtcfg  = 0;
+    s->tdc     = 0;
+    s->tbc     = 0;
+    s->tscon   = 0;
+    s->vec     = 0;
+    s->cint    = 0;
+    s->rxif    = 0;
+    s->txif    = 0;
+    s->rxovif  = 0;
+    s->txreq   = 0;
+    s->trec    = 0;
+    s->tefcon  = 0;
+    s->tefsta  = 0;
+    s->tefua   = 0;
+    s->txqcon  = 0;
+    s->txqsta   = CANFD_TXQSTA_TXQNIF;  /* TXQNIF=1 (bit 0) — slot available on reset */
+    s->txq_head  = 0;
+    s->txq_tail  = 0;
+    s->txq_count = 0;
+    s->txqua    = 0;          /* will be computed when TXQEN is set */
+
+    for (int i = 0; i < 32; i++) {
+        s->fifocon[i]   = 0;
+        s->fifosta[i]   = 0;
+        s->fifoua[i]    = 0;
+        s->fifo_head[i] = 0;
+        s->fifo_tail[i] = 0;
+        s->fifo_count[i] = 0;
+        s->fltobj[i]    = 0;
+        s->mask[i]      = 0;
+    }
+    for (int i = 0; i < 8; i++) {
+        s->fltcon[i] = 0;
+    }
+
+    /* Clear message RAM */
+    if (s->msg_ram_buf) {
+        memset(s->msg_ram_buf, 0, PIC32MK_CAN_MSGRAM_SIZE);
+    }
+
+    /* Reset software bus buffer */
+    s->bus_buf_head  = 0;
+    s->bus_buf_tail  = 0;
+    s->bus_buf_count = 0;
+
+    qemu_irq_lower(s->irq);
+}
+
+static void pic32mk_canfd_instance_init(Object *obj)
+{
+    PIC32MKCANFDState *s = PIC32MK_CANFD(obj);
+    object_property_add_link(obj, "canbus", TYPE_CAN_BUS,
+                             (Object **)&s->canbus,
+                             qdev_prop_allow_set_link_before_realize,
+                             0);
+}
+
+static void pic32mk_canfd_realize(DeviceState *dev, Error **errp)
+{
+    PIC32MKCANFDState *s = PIC32MK_CANFD(dev);
+
+    /* SFR region (index 0) */
+    memory_region_init_io(&s->sfr_mmio, OBJECT(s), &canfd_sfr_ops, s,
+                          "pic32mk-canfd-sfr", PIC32MK_CAN_SFR_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->sfr_mmio);
+
+    /* Message RAM backing store */
+    s->msg_ram_buf = g_malloc0(PIC32MK_CAN_MSGRAM_SIZE);
+
+    /* Message RAM region (index 1) — RAM-ptr so CPU can read/write freely */
+    memory_region_init_ram_ptr(&s->msg_ram, OBJECT(s),
+                               "pic32mk-canfd-msgram",
+                               PIC32MK_CAN_MSGRAM_SIZE,
+                               s->msg_ram_buf);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->msg_ram);
+
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
+
+    /* Connect to virtual CAN bus if one was linked */
+    s->bus_client.info    = &canfd_bus_client_info;
+    s->bus_client.fd_mode = true;
+    if (s->canbus) {
+        if (can_bus_insert_client(s->canbus, &s->bus_client) < 0) {
+            error_setg(errp, "pic32mk-canfd: can_bus_insert_client failed");
+            return;
+        }
+    }
+}
+
+static void pic32mk_canfd_unrealize(DeviceState *dev)
+{
+    PIC32MKCANFDState *s = PIC32MK_CANFD(dev);
+    can_bus_remove_client(&s->bus_client);
+    g_free(s->msg_ram_buf);
+    s->msg_ram_buf = NULL;
+}
+
+/*
+ * Properties
+ * -----------------------------------------------------------------------
+ */
+
+static const Property pic32mk_canfd_props[] = {
+    DEFINE_PROP_UINT32("msg-ram-base", PIC32MKCANFDState, msg_ram_phys, 0),
+    DEFINE_PROP_UINT32("instance-id", PIC32MKCANFDState, instance_id, 0),
+};
+
+/*
+ * Class / type registration
+ * -----------------------------------------------------------------------
+ */
+
+static void pic32mk_canfd_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize   = pic32mk_canfd_realize;
+    dc->unrealize = pic32mk_canfd_unrealize;
+    device_class_set_legacy_reset(dc, pic32mk_canfd_reset);
+    device_class_set_props(dc, pic32mk_canfd_props);
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->desc = "Microchip PIC32MK CAN FD controller";
+}
+
+static const TypeInfo pic32mk_canfd_info = {
+    .name          = TYPE_PIC32MK_CANFD,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(PIC32MKCANFDState),
+    .instance_init = pic32mk_canfd_instance_init,
+    .class_init    = pic32mk_canfd_class_init,
+};
+
+static void pic32mk_canfd_register_types(void)
+{
+    type_register_static(&pic32mk_canfd_info);
+}
+
+type_init(pic32mk_canfd_register_types)
diff --git a/hw/mips/pic32mk_cfg.c b/hw/mips/pic32mk_cfg.c
new file mode 100644
index 0000000000..736f0e84fd
--- /dev/null
+++ b/hw/mips/pic32mk_cfg.c
@@ -0,0 +1,247 @@
+/*
+ * Microchip PIC32MK — Configuration / PMD / SYSKEY registers
+ * Datasheet: DS60001519E §6
+ *
+ * Models the CFG register block at 0xBF800000–0xBF80011F:
+ *   CFGCON, SYSKEY, PMD1–PMD7, CFGCON2.
+ *
+ * SYSKEY implements the unlock state machine:
+ *   Write 0x00000000 → LOCKED
+ *   Write 0xAA996655 → FIRST_KEY
+ *   Write 0x556699AA when FIRST_KEY → UNLOCKED
+ *   Any wrong write → LOCKED
+ *   SYSKEY always reads 0.
+ *
+ * PMD1–PMD7 writes are gated by CFGCON.PMDLOCK (bit 29).
+ * When PMDLOCK=1, writes to PMDx are silently ignored.
+ *
+ * Copyright (c) 2026 QEMU contributors
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/core/sysbus.h"
+#include "hw/mips/pic32mk.h"
+
+#define TYPE_PIC32MK_CFG "pic32mk-cfg"
+OBJECT_DECLARE_SIMPLE_TYPE(PIC32MKCFGState, PIC32MK_CFG)
+
+/* SYSKEY unlock state machine */
+enum {
+    SYSKEY_LOCKED = 0,
+    SYSKEY_FIRST_KEY,
+    SYSKEY_UNLOCKED,
+};
+
+typedef struct PIC32MKCFGState {
+    SysBusDevice parent_obj;
+    MemoryRegion mmio;
+
+    uint32_t cfgcon;
+    uint32_t cfgcon2;
+    uint32_t checon;                    /* Prefetch Cache Control */
+    uint32_t pmd[PIC32MK_PMD_COUNT];    /* PMD1–PMD7 */
+    uint8_t  syskey_state;              /* SYSKEY unlock FSM */
+} PIC32MKCFGState;
+
+/* SET/CLR/INV helper */
+static uint32_t apply_sci(uint32_t old, uint32_t val, unsigned sub)
+{
+    switch (sub) {
+    case 0x0:
+        return val;
+    case 0x4:
+        return old | val;
+    case 0x8:
+        return old & ~val;
+    case 0xC:
+        return old ^ val;
+    default:
+        return old;
+    }
+}
+
+/*
+ * Read handler
+ * -----------------------------------------------------------------------
+ */
+static uint64_t pic32mk_cfg_read(void *opaque, hwaddr addr, unsigned size)
+{
+    PIC32MKCFGState *s = PIC32MK_CFG(opaque);
+    hwaddr base = addr & ~0xFu;
+
+    switch (base) {
+    case PIC32MK_CFGCON:
+        return s->cfgcon;
+
+    case PIC32MK_SYSKEY:
+        /* SYSKEY always reads 0 */
+        return 0;
+
+    case PIC32MK_PMD1:
+        return s->pmd[0];
+    case PIC32MK_PMD2:
+        return s->pmd[1];
+    case PIC32MK_PMD3:
+        return s->pmd[2];
+    case PIC32MK_PMD4:
+        return s->pmd[3];
+    case PIC32MK_PMD5:
+        return s->pmd[4];
+    case PIC32MK_PMD6:
+        return s->pmd[5];
+    case PIC32MK_PMD7:
+        return s->pmd[6];
+
+    case PIC32MK_CFGCON2:
+        return s->cfgcon2;
+
+    case PIC32MK_CHECON:
+        return s->checon;
+
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "pic32mk-cfg: unimplemented read @ 0x%03" HWADDR_PRIx "\n",
+                      addr);
+        return 0;
+    }
+}
+
+/*
+ * Write handler
+ * -----------------------------------------------------------------------
+ */
+static void pic32mk_cfg_write(void *opaque, hwaddr addr, uint64_t val,
+                               unsigned size)
+{
+    PIC32MKCFGState *s = PIC32MK_CFG(opaque);
+    hwaddr base = addr & ~0xFu;
+    unsigned sub = addr & 0xCu;
+    uint32_t v32 = (uint32_t)val;
+
+    /* Handle SYSKEY — no SET/CLR/INV, always direct write */
+    if (base == PIC32MK_SYSKEY) {
+        switch (s->syskey_state) {
+        case SYSKEY_LOCKED:
+            if (v32 == 0xAA996655u) {
+                s->syskey_state = SYSKEY_FIRST_KEY;
+            }
+            break;
+        case SYSKEY_FIRST_KEY:
+            if (v32 == 0x556699AAu) {
+                s->syskey_state = SYSKEY_UNLOCKED;
+            } else {
+                s->syskey_state = SYSKEY_LOCKED;
+            }
+            break;
+        case SYSKEY_UNLOCKED:
+            /* Any write re-locks (clearing 0x00000000 or random) */
+            if (v32 != 0xAA996655u && v32 != 0x556699AAu) {
+                s->syskey_state = SYSKEY_LOCKED;
+            }
+            break;
+        }
+        return;
+    }
+
+    switch (base) {
+    case PIC32MK_CFGCON:
+        s->cfgcon = apply_sci(s->cfgcon, v32, sub);
+        break;
+
+    case PIC32MK_CFGCON2:
+        s->cfgcon2 = apply_sci(s->cfgcon2, v32, sub);
+        break;
+
+    case PIC32MK_CHECON:
+        s->checon = apply_sci(s->checon, v32, sub);
+        break;
+
+    /* PMD1–PMD7: gated by PMDLOCK */
+    case PIC32MK_PMD1:
+    case PIC32MK_PMD2:
+    case PIC32MK_PMD3:
+    case PIC32MK_PMD4:
+    case PIC32MK_PMD5:
+    case PIC32MK_PMD6:
+    case PIC32MK_PMD7:
+        if (s->cfgcon & PIC32MK_CFGCON_PMDLOCK) {
+            /* Writes rejected when PMDLOCK = 1 */
+            return;
+        }
+        s->pmd[(base - PIC32MK_PMD1) / 0x10] =
+            apply_sci(s->pmd[(base - PIC32MK_PMD1) / 0x10], v32, sub);
+        break;
+
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "pic32mk-cfg: unimplemented write @ 0x%03" HWADDR_PRIx
+                      " = 0x%08x\n", addr, v32);
+        break;
+    }
+}
+
+static const MemoryRegionOps pic32mk_cfg_ops = {
+    .read       = pic32mk_cfg_read,
+    .write      = pic32mk_cfg_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+/*
+ * Realize / Reset
+ * -----------------------------------------------------------------------
+ */
+
+static void pic32mk_cfg_realize(DeviceState *dev, Error **errp)
+{
+    PIC32MKCFGState *s = PIC32MK_CFG(dev);
+    memory_region_init_io(&s->mmio, OBJECT(s), &pic32mk_cfg_ops, s,
+                          "pic32mk-cfg", PIC32MK_CFG_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
+}
+
+static void pic32mk_cfg_reset_hold(Object *obj, ResetType type)
+{
+    PIC32MKCFGState *s = PIC32MK_CFG(obj);
+    s->cfgcon  = 0;
+    s->cfgcon2 = 0;
+    s->checon  = 0;
+    s->syskey_state = SYSKEY_LOCKED;
+    for (int i = 0; i < PIC32MK_PMD_COUNT; i++) {
+        s->pmd[i] = 0;
+    }
+}
+
+/*
+ * QOM boilerplate
+ * -----------------------------------------------------------------------
+ */
+
+static void pic32mk_cfg_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    dc->realize = pic32mk_cfg_realize;
+    dc->desc    = "PIC32MK Configuration / PMD / SYSKEY";
+    rc->phases.hold = pic32mk_cfg_reset_hold;
+}
+
+static const TypeInfo pic32mk_cfg_info = {
+    .name          = TYPE_PIC32MK_CFG,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(PIC32MKCFGState),
+    .class_init    = pic32mk_cfg_class_init,
+};
+
+static void pic32mk_cfg_register_types(void)
+{
+    type_register_static(&pic32mk_cfg_info);
+}
+
+type_init(pic32mk_cfg_register_types)
diff --git a/hw/mips/pic32mk_cru.c b/hw/mips/pic32mk_cru.c
new file mode 100644
index 0000000000..3dead5107d
--- /dev/null
+++ b/hw/mips/pic32mk_cru.c
@@ -0,0 +1,375 @@
+/*
+ * Microchip PIC32MK — Clock Reference Unit (CRU)
+ * Datasheet: DS60001519E §9
+ *
+ * Models the CRU register block at 0xBF801200–0xBF80139F:
+ *   OSCCON, OSCTUN, SPLLCON, UPLLCON, RCON, RSWRST, RNMICON, PWRCON,
+ *   REFO1–4 CON/TRIM, PB1–7 DIV, CLKSTAT.
+ *
+ * All oscillator ready bits are returned set immediately — no PLL lock
+ * timing is simulated.  Register values are stored but no dynamic clock
+ * frequency propagation is performed; peripherals use the fixed
+ * PIC32MK_CPU_HZ constant.
+ *
+ * RCON (§7) is also handled here since it falls within the CRU address
+ * range (offset 0x40 = physical 0xBF801240).
+ *
+ * Copyright (c) 2026 QEMU contributors
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/core/sysbus.h"
+#include "hw/mips/pic32mk.h"
+#include "system/runstate.h"
+
+#define TYPE_PIC32MK_CRU "pic32mk-cru"
+OBJECT_DECLARE_SIMPLE_TYPE(PIC32MKCRUState, PIC32MK_CRU)
+
+typedef struct PIC32MKCRUState {
+    SysBusDevice parent_obj;
+    MemoryRegion mmio;
+
+    /* Oscillator / PLL */
+    uint32_t osccon;
+    uint32_t osctun;
+    uint32_t spllcon;
+    uint32_t upllcon;
+
+    /* Reset control (RCON / RSWRST / RNMICON / PWRCON) */
+    uint32_t rcon;
+    uint32_t rswrst;
+    uint32_t rnmicon;
+    uint32_t pwrcon;
+
+    /* Reference clock outputs 1–4 */
+    uint32_t refo_con[PIC32MK_CRU_NREFO];
+    uint32_t refo_trim[PIC32MK_CRU_NREFO];
+
+    /* Peripheral bus clock dividers 1–7 */
+    uint32_t pbdiv[PIC32MK_CRU_NPB];
+} PIC32MKCRUState;
+
+/*
+ * SET/CLR/INV helper — returns the new register value without applying it,
+ * so the caller can enforce read-only masks.
+ * sub == 0x0: direct write, 0x4: SET, 0x8: CLR, 0xC: INV
+ * -----------------------------------------------------------------------
+ */
+static uint32_t apply_sci(uint32_t old, uint32_t val, unsigned sub)
+{
+    switch (sub) {
+    case 0x0:
+        return val;
+    case 0x4:
+        return old | val;
+    case 0x8:
+        return old & ~val;
+    case 0xC:
+        return old ^ val;
+    default:
+        return old;
+        /* unreachable */;
+    }
+}
+
+/*
+ * Read handler
+ * -----------------------------------------------------------------------
+ */
+static uint64_t pic32mk_cru_read(void *opaque, hwaddr addr, unsigned size)
+{
+    PIC32MKCRUState *s = PIC32MK_CRU(opaque);
+    hwaddr base = addr & ~0xFu;     /* register base (strip SET/CLR/INV) */
+
+    switch (base) {
+    case PIC32MK_CRU_OSCCON:
+        return s->osccon;
+    case PIC32MK_CRU_OSCTUN:
+        return s->osctun;
+    case PIC32MK_CRU_SPLLCON:
+        return s->spllcon;
+    case PIC32MK_CRU_UPLLCON:
+        return s->upllcon;
+
+    case PIC32MK_CRU_RCON:
+        return s->rcon;
+    case PIC32MK_CRU_RSWRST:
+        return s->rswrst;
+    case PIC32MK_CRU_RNMICON:
+        return s->rnmicon;
+    case PIC32MK_CRU_PWRCON:
+        return s->pwrcon;
+
+    /* Reference clock outputs 1–4: CON then TRIM, 0x20 stride */
+    case PIC32MK_CRU_REFO1CON:
+        return s->refo_con[0];
+    case PIC32MK_CRU_REFO1TRIM:
+        return s->refo_trim[0];
+    case PIC32MK_CRU_REFO2CON:
+        return s->refo_con[1];
+    case PIC32MK_CRU_REFO2TRIM:
+        return s->refo_trim[1];
+    case PIC32MK_CRU_REFO3CON:
+        return s->refo_con[2];
+    case PIC32MK_CRU_REFO3TRIM:
+        return s->refo_trim[2];
+    case PIC32MK_CRU_REFO4CON:
+        return s->refo_con[3];
+    case PIC32MK_CRU_REFO4TRIM:
+        return s->refo_trim[3];
+
+    /* Peripheral bus dividers — 0x10 stride starting at 0x100 */
+    case PIC32MK_CRU_PB1DIV:
+        return s->pbdiv[0] | PIC32MK_PBDIV_PBDIVRDY;
+    case PIC32MK_CRU_PB2DIV:
+        return s->pbdiv[1] | PIC32MK_PBDIV_PBDIVRDY;
+    case PIC32MK_CRU_PB3DIV:
+        return s->pbdiv[2] | PIC32MK_PBDIV_PBDIVRDY;
+    case PIC32MK_CRU_PB4DIV:
+        return s->pbdiv[3] | PIC32MK_PBDIV_PBDIVRDY;
+    case PIC32MK_CRU_PB5DIV:
+        return s->pbdiv[4] | PIC32MK_PBDIV_PBDIVRDY;
+    case PIC32MK_CRU_PB6DIV:
+        return s->pbdiv[5] | PIC32MK_PBDIV_PBDIVRDY;
+    case PIC32MK_CRU_PB7DIV:
+        return s->pbdiv[6] | PIC32MK_PBDIV_PBDIVRDY;
+
+    /* CLKSTAT — always report all clocks ready */
+    case PIC32MK_CRU_CLKSTAT:
+        return PIC32MK_CLKSTAT_ALL_RDY;
+
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "pic32mk-cru: unimplemented read @ 0x%03" HWADDR_PRIx "\n",
+                      addr);
+        return 0;
+    }
+}
+
+/*
+ * Write handler
+ * -----------------------------------------------------------------------
+ */
+static void pic32mk_cru_write(void *opaque, hwaddr addr, uint64_t val,
+                               unsigned size)
+{
+    PIC32MKCRUState *s = PIC32MK_CRU(opaque);
+    hwaddr base = addr & ~0xFu;
+    unsigned sub = addr & 0xCu;
+    uint32_t v32 = (uint32_t)val;
+
+    switch (base) {
+    case PIC32MK_CRU_OSCCON:
+        s->osccon = apply_sci(s->osccon, v32, sub);
+        /*
+         * Mirror NOSC → COSC immediately and set SLOCK.
+         * Real hardware would do an oscillator switch sequence; in emulation
+         * the switch completes instantly.
+         */
+        if (s->osccon & PIC32MK_OSCCON_OSWEN) {
+            uint32_t nosc = (s->osccon & PIC32MK_OSCCON_NOSC_MASK)
+                            >> PIC32MK_OSCCON_NOSC_SHIFT;
+            s->osccon &= ~(PIC32MK_OSCCON_COSC_MASK | PIC32MK_OSCCON_OSWEN);
+            s->osccon |= nosc << PIC32MK_OSCCON_COSC_SHIFT;
+        }
+        break;
+
+    case PIC32MK_CRU_OSCTUN:
+        s->osctun = apply_sci(s->osctun, v32, sub);
+        break;
+
+    case PIC32MK_CRU_SPLLCON:
+        s->spllcon = apply_sci(s->spllcon, v32, sub);
+        break;
+
+    case PIC32MK_CRU_UPLLCON:
+        s->upllcon = apply_sci(s->upllcon, v32, sub);
+        break;
+
+    case PIC32MK_CRU_RCON:
+        s->rcon = apply_sci(s->rcon, v32, sub);
+        break;
+
+    case PIC32MK_CRU_RSWRST:
+        s->rswrst = apply_sci(s->rswrst, v32, sub);
+        if (s->rswrst & 1u) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "pic32mk-cru: software reset triggered (RSWRST)\n");
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+        }
+        break;
+
+    case PIC32MK_CRU_RNMICON:
+        s->rnmicon = apply_sci(s->rnmicon, v32, sub);
+        break;
+
+    case PIC32MK_CRU_PWRCON:
+        s->pwrcon = apply_sci(s->pwrcon, v32, sub);
+        break;
+
+    /* Reference clock outputs 1–4 */
+    case PIC32MK_CRU_REFO1CON:
+        s->refo_con[0] = apply_sci(s->refo_con[0], v32, sub);
+        if (s->refo_con[0] & PIC32MK_REFOCON_ON) {
+            s->refo_con[0] |= PIC32MK_REFOCON_ACTIVE;
+        } else {
+            s->refo_con[0] &= ~PIC32MK_REFOCON_ACTIVE;
+        }
+        break;
+    case PIC32MK_CRU_REFO1TRIM:
+        s->refo_trim[0] = apply_sci(s->refo_trim[0], v32, sub);
+        break;
+
+    case PIC32MK_CRU_REFO2CON:
+        s->refo_con[1] = apply_sci(s->refo_con[1], v32, sub);
+        if (s->refo_con[1] & PIC32MK_REFOCON_ON) {
+            s->refo_con[1] |= PIC32MK_REFOCON_ACTIVE;
+        } else {
+            s->refo_con[1] &= ~PIC32MK_REFOCON_ACTIVE;
+        }
+        break;
+    case PIC32MK_CRU_REFO2TRIM:
+        s->refo_trim[1] = apply_sci(s->refo_trim[1], v32, sub);
+        break;
+
+    case PIC32MK_CRU_REFO3CON:
+        s->refo_con[2] = apply_sci(s->refo_con[2], v32, sub);
+        if (s->refo_con[2] & PIC32MK_REFOCON_ON) {
+            s->refo_con[2] |= PIC32MK_REFOCON_ACTIVE;
+        } else {
+            s->refo_con[2] &= ~PIC32MK_REFOCON_ACTIVE;
+        }
+        break;
+    case PIC32MK_CRU_REFO3TRIM:
+        s->refo_trim[2] = apply_sci(s->refo_trim[2], v32, sub);
+        break;
+
+    case PIC32MK_CRU_REFO4CON:
+        s->refo_con[3] = apply_sci(s->refo_con[3], v32, sub);
+        if (s->refo_con[3] & PIC32MK_REFOCON_ON) {
+            s->refo_con[3] |= PIC32MK_REFOCON_ACTIVE;
+        } else {
+            s->refo_con[3] &= ~PIC32MK_REFOCON_ACTIVE;
+        }
+        break;
+    case PIC32MK_CRU_REFO4TRIM:
+        s->refo_trim[3] = apply_sci(s->refo_trim[3], v32, sub);
+        break;
+
+    /* Peripheral bus dividers (PBDIVRDY is read-only, masked out) */
+    case PIC32MK_CRU_PB1DIV:
+        s->pbdiv[0] = apply_sci(s->pbdiv[0], v32, sub) & ~PIC32MK_PBDIV_PBDIVRDY;
+        break;
+    case PIC32MK_CRU_PB2DIV:
+        s->pbdiv[1] = apply_sci(s->pbdiv[1], v32, sub) & ~PIC32MK_PBDIV_PBDIVRDY;
+        break;
+    case PIC32MK_CRU_PB3DIV:
+        s->pbdiv[2] = apply_sci(s->pbdiv[2], v32, sub) & ~PIC32MK_PBDIV_PBDIVRDY;
+        break;
+    case PIC32MK_CRU_PB4DIV:
+        s->pbdiv[3] = apply_sci(s->pbdiv[3], v32, sub) & ~PIC32MK_PBDIV_PBDIVRDY;
+        break;
+    case PIC32MK_CRU_PB5DIV:
+        s->pbdiv[4] = apply_sci(s->pbdiv[4], v32, sub) & ~PIC32MK_PBDIV_PBDIVRDY;
+        break;
+    case PIC32MK_CRU_PB6DIV:
+        s->pbdiv[5] = apply_sci(s->pbdiv[5], v32, sub) & ~PIC32MK_PBDIV_PBDIVRDY;
+        break;
+    case PIC32MK_CRU_PB7DIV:
+        s->pbdiv[6] = apply_sci(s->pbdiv[6], v32, sub) & ~PIC32MK_PBDIV_PBDIVRDY;
+        break;
+
+    case PIC32MK_CRU_CLKSTAT:
+        /* Read-only register */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "pic32mk-cru: write to read-only CLKSTAT ignored\n");
+        break;
+
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "pic32mk-cru: unimplemented write @ 0x%03" HWADDR_PRIx
+                      " = 0x%08x\n", addr, v32);
+        break;
+    }
+}
+
+static const MemoryRegionOps pic32mk_cru_ops = {
+    .read       = pic32mk_cru_read,
+    .write      = pic32mk_cru_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+/*
+ * Realize / Reset
+ * -----------------------------------------------------------------------
+ */
+
+static void pic32mk_cru_realize(DeviceState *dev, Error **errp)
+{
+    PIC32MKCRUState *s = PIC32MK_CRU(dev);
+    memory_region_init_io(&s->mmio, OBJECT(s), &pic32mk_cru_ops, s,
+                          "pic32mk-cru", PIC32MK_CRU_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
+}
+
+static void pic32mk_cru_reset_hold(Object *obj, ResetType type)
+{
+    PIC32MKCRUState *s = PIC32MK_CRU(obj);
+
+    /* OSCCON: COSC = 001 (SPLL), clock locked */
+    s->osccon = (1u << PIC32MK_OSCCON_COSC_SHIFT);
+    s->osctun = 0;
+    s->spllcon = 0;
+    s->upllcon = 0;
+
+    /* RCON: Power-on Reset + Brown-out Reset flags */
+    s->rcon = PIC32MK_RCON_POR | PIC32MK_RCON_BOR;
+    s->rswrst  = 0;
+    s->rnmicon = 0;
+    s->pwrcon  = 0;
+
+    for (int i = 0; i < PIC32MK_CRU_NREFO; i++) {
+        s->refo_con[i]  = 0;
+        s->refo_trim[i] = 0;
+    }
+
+    /* PB1 is always on; PB2–7 default ON */
+    for (int i = 0; i < PIC32MK_CRU_NPB; i++) {
+        s->pbdiv[i] = PIC32MK_PBDIV_ON;
+    }
+}
+
+/*
+ * QOM boilerplate
+ * -----------------------------------------------------------------------
+ */
+
+static void pic32mk_cru_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    dc->realize = pic32mk_cru_realize;
+    dc->desc    = "PIC32MK Clock Reference Unit";
+    rc->phases.hold = pic32mk_cru_reset_hold;
+}
+
+static const TypeInfo pic32mk_cru_info = {
+    .name          = TYPE_PIC32MK_CRU,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(PIC32MKCRUState),
+    .class_init    = pic32mk_cru_class_init,
+};
+
+static void pic32mk_cru_register_types(void)
+{
+    type_register_static(&pic32mk_cru_info);
+}
+
+type_init(pic32mk_cru_register_types)
diff --git a/hw/mips/pic32mk_dataee.c b/hw/mips/pic32mk_dataee.c
new file mode 100644
index 0000000000..c35a8326ad
--- /dev/null
+++ b/hw/mips/pic32mk_dataee.c
@@ -0,0 +1,463 @@
+/*
+ * PIC32MK Data EEPROM (DATAEE) emulation
+ * Datasheet: DS60001519E, §11
+ *
+ * 4 KB (1024 × 32-bit words) of on-chip data EEPROM emulated via SFR
+ * control registers EECON, EEKEY, EEADDR, EEDATA at 0xBF829000.
+ *
+ * Optional host-file backing: pass -global pic32mk-dataee.filename=eeprom.bin
+ * to persist EEPROM contents across QEMU sessions.  Without a backing file
+ * the data lives in RAM only and is lost on exit.
+ *
+ * Copyright (c) 2026 QEMU contributors
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "hw/core/sysbus.h"
+#include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/mips/pic32mk.h"
+
+#include <fcntl.h>
+#include <unistd.h>
+
+#define TYPE_PIC32MK_DATAEE "pic32mk-dataee"
+OBJECT_DECLARE_SIMPLE_TYPE(PIC32MKDataEEState, PIC32MK_DATAEE)
+
+/* EECON error codes (bits [5:4]) */
+#define EECON_ERR_NONE      0u
+#define EECON_ERR_VERIFY    1u
+#define EECON_ERR_INVALID   2u
+#define EECON_ERR_BOR       3u
+
+/* EEKEY unlock FSM states */
+#define EEKEY_LOCKED        0
+#define EEKEY_KEY1_OK       1
+#define EEKEY_UNLOCKED      2
+
+/* Number of DEVEE config words written during EEPROM_Initialize() */
+#define DATAEE_NUM_CONFIG   4
+
+struct PIC32MKDataEEState {
+    SysBusDevice parent_obj;
+    MemoryRegion mr;
+
+    /* SFR registers */
+    uint32_t eecon;
+    uint32_t eeaddr;
+    uint32_t eedata;
+    int      eekey_state;       /* unlock FSM */
+
+    /* EEPROM storage */
+    uint32_t data[PIC32MK_DATAEE_WORDS];
+    uint32_t config[DATAEE_NUM_CONFIG]; /* DEVEE0–3 shadow */
+
+    /* Host backing file */
+    char    *filename;          /* qdev string property */
+    int      backing_fd;
+    bool     dirty;
+
+    /* IRQ output → EVIC vector 186 */
+    qemu_irq irq;
+};
+
+/*
+ * Backing file helpers
+ * -----------------------------------------------------------------------
+ */
+
+static void dataee_load_backing(PIC32MKDataEEState *s)
+{
+    if (s->backing_fd < 0) {
+        return;
+    }
+    lseek(s->backing_fd, 0, SEEK_SET);
+    ssize_t n = read(s->backing_fd, s->data, sizeof(s->data));
+    if (n < 0) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "pic32mk_dataee: backing file read error\n");
+    } else if ((size_t)n < sizeof(s->data)) {
+        /* Short read — zero-pad remainder (first use: file is empty) */
+        memset((uint8_t *)s->data + n, 0xFF, sizeof(s->data) - (size_t)n);
+    }
+}
+
+static void dataee_flush_backing(PIC32MKDataEEState *s)
+{
+    if (s->backing_fd < 0 || !s->dirty) {
+        return;
+    }
+    lseek(s->backing_fd, 0, SEEK_SET);
+    ssize_t n = write(s->backing_fd, s->data, sizeof(s->data));
+    if (n < 0) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "pic32mk_dataee: backing file write error\n");
+    }
+    fdatasync(s->backing_fd);
+    s->dirty = false;
+}
+
+/*
+ * SET/CLR/INV helper (PIC32MK convention: +0=REG, +4=CLR, +8=SET, +C=INV)
+ * -----------------------------------------------------------------------
+ */
+
+static void apply_sci(uint32_t *reg, uint32_t val, int sub)
+{
+    switch (sub) {
+    case 0x0:
+        *reg  = val;
+        break;
+    case 0x4:
+        *reg &= ~val;
+        break;
+    case 0x8:
+        *reg |= val;
+        break;
+    case 0xC:
+        *reg ^= val;
+        break;
+    }
+}
+
+/*
+ * Command execution — triggered when RW transitions 0 → 1
+ * -----------------------------------------------------------------------
+ */
+
+static void dataee_set_err(PIC32MKDataEEState *s, uint32_t code)
+{
+    s->eecon = (s->eecon & ~PIC32MK_EECON_ERR_MASK)
+             | ((code << PIC32MK_EECON_ERR_SHIFT) & PIC32MK_EECON_ERR_MASK);
+}
+
+static void dataee_execute_cmd(PIC32MKDataEEState *s)
+{
+    uint32_t cmd  = s->eecon & PIC32MK_EECON_CMD_MASK;
+    uint32_t addr = s->eeaddr & PIC32MK_EEADDR_MASK;
+    uint32_t word_idx = addr >> 2;
+
+    /* Clear previous error */
+    dataee_set_err(s, EECON_ERR_NONE);
+
+    switch (cmd) {
+    case PIC32MK_EECMD_WORD_READ:
+        /* Read does NOT require WREN or unlock */
+        if (word_idx < PIC32MK_DATAEE_WORDS) {
+            s->eedata = s->data[word_idx];
+        } else {
+            s->eedata = 0xFFFFFFFFu;
+            dataee_set_err(s, EECON_ERR_INVALID);
+        }
+        break;
+
+    case PIC32MK_EECMD_WORD_WRITE:
+        if (!(s->eecon & PIC32MK_EECON_WREN)) {
+            dataee_set_err(s, EECON_ERR_INVALID);
+            break;
+        }
+        if (s->eekey_state != EEKEY_UNLOCKED) {
+            dataee_set_err(s, EECON_ERR_INVALID);
+            break;
+        }
+        if (word_idx < PIC32MK_DATAEE_WORDS) {
+            s->data[word_idx] = s->eedata;
+            s->dirty = true;
+            dataee_flush_backing(s);
+        } else {
+            dataee_set_err(s, EECON_ERR_INVALID);
+        }
+        break;
+
+    case PIC32MK_EECMD_PAGE_ERASE: {
+        if (!(s->eecon & PIC32MK_EECON_WREN)) {
+            dataee_set_err(s, EECON_ERR_INVALID);
+            break;
+        }
+        if (s->eekey_state != EEKEY_UNLOCKED) {
+            dataee_set_err(s, EECON_ERR_INVALID);
+            break;
+        }
+        /* Page-align the address */
+        uint32_t page_start = (word_idx / PIC32MK_DATAEE_PAGE_WORDS)
+                            * PIC32MK_DATAEE_PAGE_WORDS;
+        for (uint32_t i = 0; i < PIC32MK_DATAEE_PAGE_WORDS; i++) {
+            if (page_start + i < PIC32MK_DATAEE_WORDS) {
+                s->data[page_start + i] = 0xFFFFFFFFu;
+            }
+        }
+        s->dirty = true;
+        dataee_flush_backing(s);
+        break;
+    }
+
+    case PIC32MK_EECMD_BULK_ERASE:
+        if (!(s->eecon & PIC32MK_EECON_WREN)) {
+            dataee_set_err(s, EECON_ERR_INVALID);
+            break;
+        }
+        if (s->eekey_state != EEKEY_UNLOCKED) {
+            dataee_set_err(s, EECON_ERR_INVALID);
+            break;
+        }
+        memset(s->data, 0xFF, sizeof(s->data));
+        s->dirty = true;
+        dataee_flush_backing(s);
+        break;
+
+    case PIC32MK_EECMD_CONFIG_WRITE:
+        if (!(s->eecon & PIC32MK_EECON_WREN)) {
+            dataee_set_err(s, EECON_ERR_INVALID);
+            break;
+        }
+        if (s->eekey_state != EEKEY_UNLOCKED) {
+            dataee_set_err(s, EECON_ERR_INVALID);
+            break;
+        }
+        /* Config writes target DEVEE0–3 shadow (addr 0x00/04/08/0C) */
+        if (word_idx < DATAEE_NUM_CONFIG) {
+            s->config[word_idx] = s->eedata;
+        } else {
+            dataee_set_err(s, EECON_ERR_INVALID);
+        }
+        break;
+
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "pic32mk_dataee: unimplemented CMD %u\n", cmd);
+        dataee_set_err(s, EECON_ERR_INVALID);
+        break;
+    }
+
+    /* Operation complete — clear RW, reset unlock FSM */
+    s->eecon &= ~PIC32MK_EECON_RW;
+    s->eekey_state = EEKEY_LOCKED;
+
+    /* Pulse IRQ to signal completion */
+    qemu_irq_pulse(s->irq);
+}
+
+/*
+ * MMIO read
+ * -----------------------------------------------------------------------
+ */
+
+static uint64_t dataee_read(void *opaque, hwaddr addr, unsigned size)
+{
+    PIC32MKDataEEState *s = opaque;
+    hwaddr base = addr & ~(hwaddr)0xF;
+
+    switch (base) {
+    case PIC32MK_EECON:
+        return s->eecon;
+
+    case PIC32MK_EEKEY:
+        /* Write-only register — reads return 0 */
+        return 0;
+
+    case PIC32MK_EEADDR:
+        return s->eeaddr;
+
+    case PIC32MK_EEDATA_REG:
+        return s->eedata;
+
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "pic32mk_dataee: unimplemented read @ 0x%04"
+                      HWADDR_PRIx "\n", addr);
+        return 0;
+    }
+}
+
+/*
+ * MMIO write
+ * -----------------------------------------------------------------------
+ */
+
+static void dataee_write(void *opaque, hwaddr addr, uint64_t val,
+                         unsigned size)
+{
+    PIC32MKDataEEState *s = opaque;
+    int sub     = (int)(addr & 0xF);
+    hwaddr base = addr & ~(hwaddr)0xF;
+    uint32_t old_eecon;
+
+    switch (base) {
+    case PIC32MK_EECON:
+        old_eecon = s->eecon;
+        apply_sci(&s->eecon, (uint32_t)val, sub);
+
+        /* RDY is automatically set when ON is set (no startup delay in emu) */
+        if (s->eecon & PIC32MK_EECON_ON) {
+            s->eecon |= PIC32MK_EECON_RDY;
+        } else {
+            s->eecon &= ~PIC32MK_EECON_RDY;
+        }
+
+        /* Detect RW 0→1 transition: execute command */
+        if (!(old_eecon & PIC32MK_EECON_RW) &&
+             (s->eecon & PIC32MK_EECON_RW)) {
+            dataee_execute_cmd(s);
+        }
+        break;
+
+    case PIC32MK_EEKEY:
+        /*
+         * Unlock FSM: firmware writes 0xEDB7 then 0x1248.
+         * Any other value resets the FSM.  SET/CLR/INV are not
+         * meaningful for EEKEY — always treat as direct write.
+         */
+        {
+            uint32_t key = (uint32_t)val & 0xFFFFu;
+            if (s->eekey_state == EEKEY_LOCKED &&
+                key == PIC32MK_EEKEY1) {
+                s->eekey_state = EEKEY_KEY1_OK;
+            } else if (s->eekey_state == EEKEY_KEY1_OK &&
+                       key == PIC32MK_EEKEY2) {
+                s->eekey_state = EEKEY_UNLOCKED;
+            } else {
+                s->eekey_state = EEKEY_LOCKED;
+            }
+        }
+        break;
+
+    case PIC32MK_EEADDR:
+        apply_sci(&s->eeaddr, (uint32_t)val, sub);
+        s->eeaddr &= PIC32MK_EEADDR_MASK;
+        break;
+
+    case PIC32MK_EEDATA_REG:
+        apply_sci(&s->eedata, (uint32_t)val, sub);
+        break;
+
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "pic32mk_dataee: unimplemented write @ 0x%04"
+                      HWADDR_PRIx " = 0x%08" PRIx64 "\n",
+                      addr, val);
+        break;
+    }
+}
+
+static const MemoryRegionOps dataee_ops = {
+    .read       = dataee_read,
+    .write      = dataee_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = { .min_access_size = 4, .max_access_size = 4 },
+};
+
+/*
+ * Device lifecycle
+ * -----------------------------------------------------------------------
+ */
+
+static void pic32mk_dataee_reset(DeviceState *dev)
+{
+    PIC32MKDataEEState *s = PIC32MK_DATAEE(dev);
+
+    s->eecon       = 0;
+    s->eeaddr      = 0;
+    s->eedata      = 0;
+    s->eekey_state = EEKEY_LOCKED;
+
+    /* Erased state = all 0xFF */
+    memset(s->data, 0xFF, sizeof(s->data));
+    memset(s->config, 0xFF, sizeof(s->config));
+    s->dirty = false;
+
+    /* Load backing file contents (overwrites erased state if file exists) */
+    dataee_load_backing(s);
+
+    qemu_irq_lower(s->irq);
+}
+
+static void pic32mk_dataee_realize(DeviceState *dev, Error **errp)
+{
+    PIC32MKDataEEState *s = PIC32MK_DATAEE(dev);
+
+    s->backing_fd = -1;
+
+    if (s->filename && s->filename[0] != '\0') {
+        /* Open or create the backing file (read-write) */
+        s->backing_fd = open(s->filename, O_RDWR | O_CREAT, 0644);
+        if (s->backing_fd < 0) {
+            error_setg_errno(errp, errno,
+                             "pic32mk_dataee: cannot open '%s'",
+                             s->filename);
+            return;
+        }
+
+        /*
+         * If the file is new or undersized, initialize it with 0xFF
+         * (the erased state for EEPROM).  This avoids the user having
+         * to pre-create the file with the right content.
+         */
+        off_t fsize = lseek(s->backing_fd, 0, SEEK_END);
+        if (fsize < (off_t)sizeof(s->data)) {
+            uint8_t ff_buf[PIC32MK_DATAEE_WORDS * 4];
+            memset(ff_buf, 0xFF, sizeof(ff_buf));
+            lseek(s->backing_fd, 0, SEEK_SET);
+            if (write(s->backing_fd, ff_buf, sizeof(ff_buf)) < 0) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "pic32mk_dataee: cannot init '%s'\n",
+                              s->filename);
+            }
+            fdatasync(s->backing_fd);
+        }
+    }
+}
+
+static void pic32mk_dataee_unrealize(DeviceState *dev)
+{
+    PIC32MKDataEEState *s = PIC32MK_DATAEE(dev);
+
+    dataee_flush_backing(s);
+
+    if (s->backing_fd >= 0) {
+        close(s->backing_fd);
+        s->backing_fd = -1;
+    }
+}
+
+static void pic32mk_dataee_init(Object *obj)
+{
+    PIC32MKDataEEState *s = PIC32MK_DATAEE(obj);
+
+    memory_region_init_io(&s->mr, obj, &dataee_ops, s,
+                          TYPE_PIC32MK_DATAEE, PIC32MK_DATAEE_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mr);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
+}
+
+static const Property pic32mk_dataee_props[] = {
+    DEFINE_PROP_STRING("filename", PIC32MKDataEEState, filename),
+};
+
+static void pic32mk_dataee_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize   = pic32mk_dataee_realize;
+    dc->unrealize = pic32mk_dataee_unrealize;
+    device_class_set_legacy_reset(dc, pic32mk_dataee_reset);
+    device_class_set_props(dc, pic32mk_dataee_props);
+}
+
+static const TypeInfo pic32mk_dataee_info = {
+    .name          = TYPE_PIC32MK_DATAEE,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(PIC32MKDataEEState),
+    .instance_init = pic32mk_dataee_init,
+    .class_init    = pic32mk_dataee_class_init,
+};
+
+static void pic32mk_dataee_register_types(void)
+{
+    type_register_static(&pic32mk_dataee_info);
+}
+
+type_init(pic32mk_dataee_register_types)
diff --git a/hw/mips/pic32mk_dma.c b/hw/mips/pic32mk_dma.c
new file mode 100644
index 0000000000..c1fd503b16
--- /dev/null
+++ b/hw/mips/pic32mk_dma.c
@@ -0,0 +1,255 @@
+/*
+ * PIC32MK DMA Controller × 8 channels
+ * Datasheet: DS60001519E, §26
+ *
+ * Phase 2B stub: accepts all register reads/writes, logs unimplemented
+ * channel transfers.  Actual DMA transfer engine is deferred.
+ *
+ * Memory map (base physical 0x1F811000 = SFR_BASE + DMA_OFFSET):
+ *   +0x000: DMACON (global control)
+ *   +0x010: DMASTAT
+ *   +0x020: DMAADDR
+ *   +0x060: Channel 0 registers (DCH0CON, DCH0ECON, DCH0INT, ...)
+ *   +0x120: Channel 1 registers
+ *   ...  (stride 0xC0 per channel)
+ *
+ * Copyright (c) 2026 QEMU contributors
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/core/sysbus.h"
+#include "hw/core/irq.h"
+#include "hw/mips/pic32mk.h"
+
+/* Total MMIO size: channel 7 ends at 0x060 + 7*0xC0 + 0xC0 = 0x060 + 0x780 = 0x7E0 */
+#define DMA_MMIO_SIZE   0x1000u  /* full 4 KB page */
+
+#define TYPE_PIC32MK_DMA    "pic32mk-dma"
+OBJECT_DECLARE_SIMPLE_TYPE(PIC32MKDMAState, PIC32MK_DMA)
+
+/* Per-channel register state */
+typedef struct {
+    uint32_t con;   /* DCHxCON */
+    uint32_t econ;  /* DCHxECON */
+    uint32_t ireg;  /* DCHxINT */
+    uint32_t ssa;   /* source start address */
+    uint32_t dsa;   /* destination start address */
+    uint32_t ssiz;  /* source size */
+    uint32_t dsiz;  /* destination size */
+    uint32_t sptr;  /* source pointer */
+    uint32_t dptr;  /* destination pointer */
+    uint32_t csiz;  /* cell size */
+    uint32_t cptr;  /* cell pointer */
+    uint32_t dat;   /* pattern data */
+} DMAChannel;
+
+struct PIC32MKDMAState {
+    SysBusDevice parent_obj;
+    MemoryRegion mr;
+
+    uint32_t   con;     /* DMACON */
+    uint32_t   stat;    /* DMASTAT */
+    uint32_t   addr;    /* DMAADDR */
+
+    DMAChannel ch[PIC32MK_DMA_NCHANNELS];
+    qemu_irq   irq[PIC32MK_DMA_NCHANNELS];
+};
+
+/*
+ * Helpers
+ * -----------------------------------------------------------------------
+ */
+
+/* PIC32MK: base+0=REG, +4=CLR, +8=SET, +0xC=INV */
+static void apply_sci(uint32_t *reg, uint32_t val, int sub)
+{
+    switch (sub) {
+    case 0:
+        *reg  = val;
+        break;
+    case 4:
+        *reg &= ~val;
+        break;
+    case 8:
+        *reg |= val;
+        break;
+    case 12:
+        *reg ^= val;
+        break;
+    }
+}
+
+/* Map channel register offset to state field */
+static uint32_t *dma_ch_reg(DMAChannel *ch, hwaddr off)
+{
+    switch (off) {
+    case PIC32MK_DCHxCON:
+        return &ch->con;
+    case PIC32MK_DCHxECON:
+        return &ch->econ;
+    case PIC32MK_DCHxINT:
+        return &ch->ireg;
+    case PIC32MK_DCHxSSA:
+        return &ch->ssa;
+    case PIC32MK_DCHxDSA:
+        return &ch->dsa;
+    case PIC32MK_DCHxSSIZ:
+        return &ch->ssiz;
+    case PIC32MK_DCHxDSIZ:
+        return &ch->dsiz;
+    case PIC32MK_DCHxSPTR:
+        return &ch->sptr;
+    case PIC32MK_DCHxDPTR:
+        return &ch->dptr;
+    case PIC32MK_DCHxCSIZ:
+        return &ch->csiz;
+    case PIC32MK_DCHxCPTR:
+        return &ch->cptr;
+    case PIC32MK_DCHxDAT:
+        return &ch->dat;
+    default:
+        return NULL;
+    }
+}
+
+/*
+ * MMIO
+ * -----------------------------------------------------------------------
+ */
+
+static uint64_t dma_read(void *opaque, hwaddr addr, unsigned size)
+{
+    PIC32MKDMAState *s = opaque;
+    int sub     = (int)(addr & 0xF);
+    hwaddr base = addr & ~(hwaddr)0xF;
+
+    (void)sub;  /* reads always return base register value */
+
+    /* Global registers */
+    if (base == PIC32MK_DMACON_OFFSET) {
+        return s->con;
+    }
+    if (base == PIC32MK_DMASTAT_OFFSET) {
+        return s->stat;
+    }
+    if (base == PIC32MK_DMAADDR_OFFSET) {
+        return s->addr;
+    }
+
+    /* Channel registers */
+    if (addr >= PIC32MK_DMA_CH_BASE) {
+        hwaddr ch_off = base - PIC32MK_DMA_CH_BASE;
+        int ch_idx = (int)(ch_off / PIC32MK_DMA_CH_STRIDE);
+        hwaddr reg_off = ch_off % PIC32MK_DMA_CH_STRIDE;
+
+        if (ch_idx < PIC32MK_DMA_NCHANNELS) {
+            uint32_t *reg = dma_ch_reg(&s->ch[ch_idx], reg_off);
+            if (reg) {
+                return *reg;
+            }
+        }
+    }
+
+    qemu_log_mask(LOG_UNIMP,
+                  "pic32mk_dma: unimplemented read @ 0x%04" HWADDR_PRIx "\n",
+                  addr);
+    return 0;
+}
+
+static void dma_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
+{
+    PIC32MKDMAState *s = opaque;
+    int sub     = (int)(addr & 0xF);
+    hwaddr base = addr & ~(hwaddr)0xF;
+
+    /* Global registers */
+    if (base == PIC32MK_DMACON_OFFSET) {
+        apply_sci(&s->con, (uint32_t)val, sub);
+        return;
+    }
+    if (base == PIC32MK_DMASTAT_OFFSET || base == PIC32MK_DMAADDR_OFFSET) {
+        return;  /* read-only */
+    }
+
+    /* Channel registers */
+    if (addr >= PIC32MK_DMA_CH_BASE) {
+        hwaddr ch_off  = base - PIC32MK_DMA_CH_BASE;
+        int    ch_idx  = (int)(ch_off / PIC32MK_DMA_CH_STRIDE);
+        hwaddr reg_off = ch_off % PIC32MK_DMA_CH_STRIDE;
+
+        if (ch_idx < PIC32MK_DMA_NCHANNELS) {
+            uint32_t *reg = dma_ch_reg(&s->ch[ch_idx], reg_off);
+            if (reg) {
+                apply_sci(reg, (uint32_t)val, sub);
+                /* TODO: trigger DMA transfer if CHEN and FORCE bits set */
+                return;
+            }
+        }
+    }
+
+    qemu_log_mask(LOG_UNIMP,
+                  "pic32mk_dma: unimplemented write @ 0x%04"
+                  HWADDR_PRIx " = 0x%08" PRIx64 "\n",
+                  addr, val);
+}
+
+static const MemoryRegionOps dma_ops = {
+    .read       = dma_read,
+    .write      = dma_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = { .min_access_size = 4, .max_access_size = 4 },
+};
+
+/*
+ * Device lifecycle
+ * -----------------------------------------------------------------------
+ */
+
+static void pic32mk_dma_reset(DeviceState *dev)
+{
+    PIC32MKDMAState *s = PIC32MK_DMA(dev);
+    s->con  = 0x80000000u;  /* DMABUSY=0, ON=1 on reset per datasheet */
+    s->stat = 0;
+    s->addr = 0;
+    memset(s->ch, 0, sizeof(s->ch));
+    for (int i = 0; i < PIC32MK_DMA_NCHANNELS; i++) {
+        qemu_irq_lower(s->irq[i]);
+    }
+}
+
+static void pic32mk_dma_init(Object *obj)
+{
+    PIC32MKDMAState *s = PIC32MK_DMA(obj);
+
+    memory_region_init_io(&s->mr, obj, &dma_ops, s,
+                          TYPE_PIC32MK_DMA, DMA_MMIO_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mr);
+
+    for (int i = 0; i < PIC32MK_DMA_NCHANNELS; i++) {
+        sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq[i]);
+    }
+}
+
+static void pic32mk_dma_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    device_class_set_legacy_reset(dc, pic32mk_dma_reset);
+}
+
+static const TypeInfo pic32mk_dma_info = {
+    .name          = TYPE_PIC32MK_DMA,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(PIC32MKDMAState),
+    .instance_init = pic32mk_dma_init,
+    .class_init    = pic32mk_dma_class_init,
+};
+
+static void pic32mk_dma_register_types(void)
+{
+    type_register_static(&pic32mk_dma_info);
+}
+
+type_init(pic32mk_dma_register_types)
diff --git a/hw/mips/pic32mk_evic.c b/hw/mips/pic32mk_evic.c
new file mode 100644
index 0000000000..214fe7dd96
--- /dev/null
+++ b/hw/mips/pic32mk_evic.c
@@ -0,0 +1,399 @@
+/*
+ * PIC32MK Enhanced Vectored Interrupt Controller (EVIC)
+ * Datasheet: DS60001519E, §8 (pp. 121–166)
+ *
+ * 216 interrupt sources, 7 priority levels × 4 subpriority levels.
+ * Supports single-vector (INTCON.MVEC=0) and multi-vector (MVEC=1) modes.
+ * All register banks support atomic SET/CLR/INV sub-registers (+4/+8/+C).
+ *
+ * Copyright (c) 2026 QEMU contributors
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/mips/pic32mk_evic.h"
+
+/*
+ * EVIC MMIO layout (offsets from EVIC base 0x1F810000)
+ *
+ * Registers that have SET/CLR/INV sub-regs use a 16-byte stride:
+ *   REG at base+0, SET at base+4, CLR at base+8, INV at base+C
+ *
+ * OFFx registers are plain 4-byte (no SET/CLR/INV).
+ * -----------------------------------------------------------------------
+ */
+
+#define EVIC_MMIO_SIZE      0x1000u  /* 4 KB page */
+
+/* Number of IFS/IEC words (8 × 32 = 256 bits covers 216 sources + spare) */
+#define EVIC_IFS_COUNT      8
+#define EVIC_IEC_COUNT      8
+#define EVIC_IPC_COUNT      64
+#define EVIC_OFF_COUNT      191
+
+/* INTCON bits */
+#define INTCON_MVEC         (1u << 12)   /* multi-vector mode */
+
+/*
+ * Priority extraction helpers
+ * IPC register format: 4 sources per register, 8 bits per source
+ *   bits[4:2] = IP (priority, 3 bits)
+ *   bits[1:0] = IS (subpriority, 2 bits)
+ * -----------------------------------------------------------------------
+ */
+
+static int evic_get_priority(PIC32MKEVICState *s, int src)
+{
+    int reg   = src >> 2;
+    int shift = (src & 3) << 3;   /* 0, 8, 16, or 24 */
+    return (s->ipcreg[reg] >> (shift + 2)) & 0x7;
+}
+
+/*
+ * IRQ routing — called whenever IFS, IEC, or IPC registers change.
+ *
+ * Algorithm: find the highest pending+enabled priority level and assert
+ * the matching CPU interrupt pin.  Deassert all pins that have no
+ * pending work at that priority.
+ * -----------------------------------------------------------------------
+ */
+
+static void evic_update(PIC32MKEVICState *s)
+{
+    int best_prio = 0;
+    int best_src  = -1;
+
+    for (int i = 0; i < PIC32MK_NUM_IRQ_SOURCES; i++) {
+        int word = i >> 5;
+        int bit  = i & 31;
+        if ((s->ifsreg[word] >> bit & 1) && (s->iecreg[word] >> bit & 1)) {
+            int prio = evic_get_priority(s, i);
+            if (prio > best_prio) {
+                best_prio = prio;
+                best_src  = i;
+            }
+        }
+    }
+
+    /* Update INTSTAT: bits[7:0] = last interrupt source, bits[15:8] = priority */
+    if (best_src >= 0) {
+        s->intstat = ((uint32_t)best_prio << 8) | (uint32_t)(best_src & 0xFF);
+    }
+
+    /*
+     * Assert/deassert each CPU interrupt pin.
+     *
+     * VEIC RIPL encoding: portSAVE_CONTEXT does:
+     *   k0 = Cause >> 10          (extracts bits[17:10] as RIPL)
+     *   Status[16:10] = k0[6:0]   (sets IPL = RIPL in ISR)
+     *
+     * cpu_mips_irq_request(cpu, N, 1) sets Cause.bit(N+8).
+     * For portSAVE_CONTEXT to extract RIPL = priority P:
+     *   need Cause.bit(10+P) set, so Cause >> 10 = 1 << (P-1)... but actually
+     *   we want (Cause >> 10) to equal P so Status[16:10] = P = IPL.
+     *   Cause.bit(10+P) >> 10 = 1 << P, not P itself.
+     *
+     * Correct approach: priority P → cpu_irq[P+1] → Cause.bit(P+9).
+     *   Cause.bit(P+9) >> 10 = 1 << (P-1) (not P).
+     *
+     * Simplest correct mapping: encode priority as a single bit position.
+     * cpu_irq[2] → Cause.bit(10) → k0 = 1 after >>10 → IPL=1 → blocks
+     * same-priority re-entry (pending=0x0400 > status=0x0400 = FALSE).
+     * portDISABLE with IPL=3 → status=3<<10=0x0C00 → blocks prio1(0x0400)
+     * and prio2(0x0800) but not prio3(0x1000).  For our firmware only
+     * priority 1 is used, so this is sufficient.
+     *
+     * Mapping: EVIC priority pin → cpu_irq[pin+1].
+     *   pin=1 → cpu_irq[2] → Cause.bit(10) → RIPL = Cause>>10 = 1 ✓
+     *   pin=2 → cpu_irq[3] → Cause.bit(11) → RIPL = 2 ✓
+     *   pin=3 → cpu_irq[4] → Cause.bit(12) → RIPL = 4 (power-of-2, not equal)
+     *   ...
+     * This works perfectly for priority 1 and FreeRTOS configKERNEL_INTERRUPT_PRIORITY=1.
+     */
+    for (int pin = 1; pin <= 6; pin++) {
+        int cpu_pin = pin + 1;  /* priority P → cpu_irq[P+1] for correct RIPL */
+        int assert = 0;
+        if (s->cpu_irq[cpu_pin]) {
+            for (int i = 0; i < PIC32MK_NUM_IRQ_SOURCES && !assert; i++) {
+                int word = i >> 5, bit = i & 31;
+                if ((s->ifsreg[word] >> bit & 1) &&
+                    (s->iecreg[word] >> bit & 1) &&
+                    evic_get_priority(s, i) == pin) {
+                    assert = 1;
+                }
+            }
+            qemu_set_irq(s->cpu_irq[cpu_pin], assert);
+        }
+    }
+    /* Priority 7 has no available cpu_irq slot (would need irq[8]); unused. */
+}
+
+/*
+ * IRQ input handler — called when a peripheral asserts/deasserts its IRQ.
+ *
+ * On the real device, raising the IRQ sets the corresponding IFSx bit.
+ * Lowering it does NOT clear IFSx — that is software's responsibility
+ * (write to IFSxCLR in the interrupt service routine).
+ * -----------------------------------------------------------------------
+ */
+
+static void evic_set_irq(void *opaque, int irq, int level)
+{
+    PIC32MKEVICState *s = opaque;
+
+    if (irq < 0 || irq >= PIC32MK_NUM_IRQ_SOURCES) {
+        return;
+    }
+
+    int word = irq >> 5;
+    uint32_t mask = 1u << (irq & 31);
+
+    /* Track the current hardware level of this source */
+
+    if (level) {
+        s->irq_level[word] |= mask;
+        s->ifsreg[word]    |= mask;
+    } else {
+        s->irq_level[word] &= ~mask;
+    }
+
+    if (level) {
+        /*
+         * Software interrupts CS0 (source 1) and CS1 (source 2) arrive here
+         * because board code redirected env->irq[0..1] to EVIC inputs.
+         * cpu_mips_store_cause() already set the direct Cause.IP0/IP1 bit
+         * before calling us.  Clear it so the VEIC pending-vs-status
+         * comparison only sees the priority pin asserted by evic_update().
+         * This prevents same-priority nesting in VEIC mode.
+         *
+         * Also clear irq_level for these sources — they are edge/pulse
+         * triggered (software writes to Cause), not level-sensitive like
+         * hardware peripherals.  Without this, IFS re-assertion after
+         * firmware IFSxCLR would immediately re-set the flag.
+         */
+        if (s->cpu && (irq == PIC32MK_IRQ_CS0 || irq == PIC32MK_IRQ_CS1)) {
+            CPUMIPSState *env = &s->cpu->env;
+            int ip_bit = (irq == PIC32MK_IRQ_CS0) ? 0 : 1;
+            env->CP0_Cause &= ~(1u << (ip_bit + 8));
+            /* Treat as one-shot: IFS is set above, but don't persist level */
+            s->irq_level[word] &= ~mask;
+        }
+    }
+
+    evic_update(s);
+}
+
+/*
+ * Register pointer helper for SET/CLR/INV registers (base addresses only)
+ * -----------------------------------------------------------------------
+ */
+
+static uint32_t *evic_find_reg(PIC32MKEVICState *s, hwaddr base)
+{
+    if (base == PIC32MK_EVIC_INTCON) {
+        return &s->intcon;
+    }
+    if (base == PIC32MK_EVIC_PRISS) {
+        return &s->priss;
+    }
+    if (base == PIC32MK_EVIC_INTSTAT) {
+        return &s->intstat;
+    }
+    if (base == PIC32MK_EVIC_IPTMR) {
+        return &s->iptmr;
+    }
+
+    if (base >= PIC32MK_EVIC_IFS0 && base < PIC32MK_EVIC_IEC0) {
+        int i = (int)((base - PIC32MK_EVIC_IFS0) >> 4);
+        return (i < EVIC_IFS_COUNT) ? &s->ifsreg[i] : NULL;
+    }
+    if (base >= PIC32MK_EVIC_IEC0 && base < PIC32MK_EVIC_IPC0) {
+        int i = (int)((base - PIC32MK_EVIC_IEC0) >> 4);
+        return (i < EVIC_IEC_COUNT) ? &s->iecreg[i] : NULL;
+    }
+    if (base >= PIC32MK_EVIC_IPC0 && base < PIC32MK_EVIC_OFF0) {
+        int i = (int)((base - PIC32MK_EVIC_IPC0) >> 4);
+        return (i < EVIC_IPC_COUNT) ? &s->ipcreg[i] : NULL;
+    }
+    return NULL;
+}
+
+/* Apply SET/CLR/INV operation (sub = byte offset within 16-byte group) */
+/* PIC32MK: base+0=REG, +4=CLR, +8=SET, +0xC=INV */
+static void apply_sci(uint32_t *reg, uint32_t val, int sub)
+{
+    switch (sub) {
+    case 0:
+        *reg  = val;
+        break;
+    case 4:
+        *reg &= ~val;
+        break;
+    case 8:
+        *reg |= val;
+        break;
+    case 12:
+        *reg ^= val;
+        break;
+    }
+}
+
+/*
+ * MMIO read/write
+ * -----------------------------------------------------------------------
+ */
+
+static uint64_t evic_read(void *opaque, hwaddr addr, unsigned size)
+{
+    PIC32MKEVICState *s = opaque;
+
+    /* OFFx: plain 4-byte registers, no SET/CLR/INV */
+    if (addr >= PIC32MK_EVIC_OFF0) {
+        int idx = (int)((addr - PIC32MK_EVIC_OFF0) >> 2);
+        if (idx < EVIC_OFF_COUNT) {
+            return s->offreg[idx];
+        }
+    } else {
+        /* All other registers: 16-byte stride, all sub-addrs read base */
+        hwaddr base = addr & ~(hwaddr)0xF;
+        uint32_t *reg = evic_find_reg(s, base);
+        if (reg) {
+            return *reg;
+        }
+    }
+
+    qemu_log_mask(LOG_UNIMP,
+                  "pic32mk_evic: unimplemented read @ 0x%04" HWADDR_PRIx "\n",
+                  addr);
+    return 0;
+}
+
+static void evic_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
+{
+    PIC32MKEVICState *s = opaque;
+    bool need_update = false;
+
+    /* OFFx: plain 4-byte writes */
+    if (addr >= PIC32MK_EVIC_OFF0) {
+        int idx = (int)((addr - PIC32MK_EVIC_OFF0) >> 2);
+        if (idx < EVIC_OFF_COUNT) {
+            s->offreg[idx] = (uint32_t)val;
+        }
+        return;
+    }
+
+    int sub       = (int)(addr & 0xF);
+    hwaddr base   = addr & ~(hwaddr)0xF;
+    uint32_t *reg = evic_find_reg(s, base);
+
+    if (!reg) {
+        qemu_log_mask(LOG_UNIMP,
+                      "pic32mk_evic: unimplemented write @ 0x%04"
+                      HWADDR_PRIx " = 0x%08" PRIx64 "\n",
+                      addr, val);
+        return;
+    }
+
+    /* INTSTAT is read-only hardware status */
+    if (reg == &s->intstat) {
+        return;
+    }
+
+    apply_sci(reg, (uint32_t)val, sub);
+
+    /*
+     * After any IFS write (especially CLR), re-assert bits where the
+     * hardware source is still active.  On real Microchip devices, IFS
+     * flags are level-sensitive: if the peripheral still drives the
+     * interrupt line high, the flag is immediately re-set even after the
+     * firmware clears it.
+     */
+    if (base >= PIC32MK_EVIC_IFS0 && base < PIC32MK_EVIC_IEC0) {
+        int idx = (int)((base - PIC32MK_EVIC_IFS0) >> 4);
+        if (idx < EVIC_IFS_COUNT) {
+            s->ifsreg[idx] |= s->irq_level[idx];
+        }
+    }
+
+    /* IFS or IEC or IPC write → re-evaluate interrupt routing */
+    if (base >= PIC32MK_EVIC_IFS0 &&
+        base <  PIC32MK_EVIC_IPC0 + (hwaddr)(EVIC_IPC_COUNT * 0x10)) {
+        need_update = true;
+    }
+
+    if (need_update) {
+        evic_update(s);
+    }
+}
+
+static const MemoryRegionOps evic_ops = {
+    .read       = evic_read,
+    .write      = evic_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+/*
+ * Device lifecycle
+ * -----------------------------------------------------------------------
+ */
+
+static void pic32mk_evic_reset(DeviceState *dev)
+{
+    PIC32MKEVICState *s = PIC32MK_EVIC(dev);
+
+    s->intcon  = 0;
+    s->priss   = 0;
+    s->intstat = 0;
+    s->iptmr   = 0;
+    memset(s->ifsreg, 0, sizeof(s->ifsreg));
+    memset(s->iecreg, 0, sizeof(s->iecreg));
+    memset(s->ipcreg, 0, sizeof(s->ipcreg));
+    memset(s->offreg, 0, sizeof(s->offreg));
+    memset(s->irq_level, 0, sizeof(s->irq_level));
+
+    /* Deassert all CPU interrupt pins */
+    for (int i = 0; i < 8; i++) {
+        if (s->cpu_irq[i]) {
+            qemu_irq_lower(s->cpu_irq[i]);
+        }
+    }
+}
+
+static void pic32mk_evic_init(Object *obj)
+{
+    PIC32MKEVICState *s = PIC32MK_EVIC(obj);
+
+    memory_region_init_io(&s->mr, obj, &evic_ops, s,
+                          TYPE_PIC32MK_EVIC, EVIC_MMIO_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mr);
+
+    /* 216 GPIO input lines — one per interrupt source */
+    qdev_init_gpio_in(DEVICE(obj), evic_set_irq, PIC32MK_NUM_IRQ_SOURCES);
+}
+
+static void pic32mk_evic_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    device_class_set_legacy_reset(dc, pic32mk_evic_reset);
+}
+
+static const TypeInfo pic32mk_evic_info = {
+    .name          = TYPE_PIC32MK_EVIC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(PIC32MKEVICState),
+    .instance_init = pic32mk_evic_init,
+    .class_init    = pic32mk_evic_class_init,
+};
+
+static void pic32mk_evic_register_types(void)
+{
+    type_register_static(&pic32mk_evic_info);
+}
+
+type_init(pic32mk_evic_register_types)
diff --git a/hw/mips/pic32mk_gpio.c b/hw/mips/pic32mk_gpio.c
new file mode 100644
index 0000000000..ddbb6e6cd5
--- /dev/null
+++ b/hw/mips/pic32mk_gpio.c
@@ -0,0 +1,418 @@
+/*
+ * PIC32MK GPIO — PORTA through PORTG (7 ports)
+ * Datasheet: DS60001519E, §12
+ *
+ * Each port is a SysBusDevice that exposes a PIC32MK_GPIO_PORT_SIZE (0x100)
+ * byte MMIO region containing ANSEL, TRIS, PORT, LAT, ODC, CN* registers.
+ *
+ * All registers support SET/CLR/INV sub-registers (+4/+8/+C).
+ *
+ * External input model:
+ *   - 16 qdev GPIO input lines per port — driven by board wiring or test code.
+ *   - 16 qdev GPIO output lines per port — assert when an output pin's LAT changes.
+ *   - One IRQ output line → EVIC CN interrupt (fires when CNCON.ON and CNEN0
+ *     enabled bits detect a PORT change).
+ *
+ * QOM properties (accessible via qom-get / qom-set from HMP/QMP):
+ *   pin0..pin15 - bool, r/w - inject external input (write) or read PORT bit
+ *   lat-state     — uint32, r  — current LAT register value
+ *   port-state    — uint32, r  — current PORT register value (mix of ext & output)
+ *   tris-state    — uint32, r  — current TRIS register value
+ *
+ * Chardev event stream (optional "chardev" qdev property):
+ *   When connected, each state change emits a 13-byte little-endian message:
+ *     [port_idx:1] [tris:4] [lat:4] [port:4]
+ *   Enables event-driven host-side GPIO monitoring (gpio_tool.py gui).
+ *
+ * Copyright (c) 2026 QEMU contributors
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "qapi/visitor.h"
+#include "hw/core/irq.h"
+#include "hw/core/sysbus.h"
+#include "hw/core/qdev-properties.h"
+#include "chardev/char.h"
+#include "hw/mips/pic32mk.h"
+#include "qom/object.h"
+
+/*
+ * Device state — one instance per port (A–G)
+ * -----------------------------------------------------------------------
+ */
+
+#define TYPE_PIC32MK_GPIO   "pic32mk-gpio"
+OBJECT_DECLARE_SIMPLE_TYPE(PIC32MKGpioState, PIC32MK_GPIO)
+
+struct PIC32MKGpioState {
+    SysBusDevice parent_obj;
+    MemoryRegion mr;
+
+    /* SFR registers */
+    uint32_t ansel;
+    uint32_t tris;    /* 1 = input (reset default) */
+    uint32_t port;    /* pin state: input bits from ext_input, output bits from lat */
+    uint32_t lat;     /* output latch */
+    uint32_t odc;
+    uint32_t cnpu;
+    uint32_t cnpd;
+    uint32_t cncon;
+    uint32_t cnen0;
+    uint32_t cnstat;
+    uint32_t cnen1;
+    uint32_t cnf;
+
+    /* External input pin levels (driven by qdev GPIO input lines or QOM set) */
+    uint32_t ext_input;
+
+    /* CN reference: last PORT value read by firmware — used for mismatch detect */
+    uint32_t cn_ref;
+
+    /* IRQ output → EVIC CN interrupt */
+    qemu_irq cn_irq;
+
+    /* qdev GPIO output lines (16 per port): asserted when output LAT changes */
+    qemu_irq output[16];
+
+    /*
+     * Optional shared chardev for streaming state-change events to host tools.
+     * Multiple GPIO ports write to the same Chardev* (not CharFrontend,
+     * which enforces 1:1 ownership). Set by board init if chardev exists.
+      */
+    Chardev *chr_out;
+    uint8_t  port_idx;   /* 0=A, 1=B, …, 6=G */
+};
+
+/*
+ * MMIO helpers
+ * -----------------------------------------------------------------------
+ */
+
+/* PIC32MK: base+0=REG, +4=CLR, +8=SET, +0xC=INV */
+static void apply_sci(uint32_t *reg, uint32_t val, int sub)
+{
+    switch (sub) {
+    case 0:
+        *reg  = val;
+        break;
+    case 4:
+        *reg &= ~val;
+        break;
+    case 8:
+        *reg |= val;
+        break;
+    case 12:
+        *reg ^= val;
+        break;
+    }
+}
+
+static uint32_t *gpio_find_reg(PIC32MKGpioState *s, hwaddr base)
+{
+    switch (base) {
+    case PIC32MK_ANSEL:
+        return &s->ansel;
+    case PIC32MK_TRIS:
+        return &s->tris;
+    case PIC32MK_PORT:
+        return &s->port;
+    case PIC32MK_LAT:
+        return &s->lat;
+    case PIC32MK_ODC:
+        return &s->odc;
+    case PIC32MK_CNPU:
+        return &s->cnpu;
+    case PIC32MK_CNPD:
+        return &s->cnpd;
+    case PIC32MK_CNCON:
+        return &s->cncon;
+    case PIC32MK_CNEN0:
+        return &s->cnen0;
+    case PIC32MK_CNSTAT:
+        return &s->cnstat;
+    case PIC32MK_CNEN1:
+        return &s->cnen1;
+    case PIC32MK_CNF:
+        return &s->cnf;
+    default:
+        return NULL;
+    }
+}
+
+/* Recompute s->port from current lat, tris, and ext_input. */
+static void gpio_update_port(PIC32MKGpioState *s)
+{
+    /* Input pins reflect external levels; output pins reflect LAT. */
+    s->port = (s->ext_input & s->tris) | (s->lat & ~s->tris);
+}
+
+/*
+ * Emit a 13-byte state-change event on the optional chardev.
+ * Format (little-endian): [port_idx:1] [tris:4] [lat:4] [port:4]
+ */
+static void gpio_notify_state(PIC32MKGpioState *s)
+{
+    if (!s->chr_out) {
+        return;
+    }
+    uint8_t msg[13];
+    msg[0] = s->port_idx;
+    memcpy(&msg[1],  &s->tris, 4);
+    memcpy(&msg[5],  &s->lat,  4);
+    memcpy(&msg[9],  &s->port, 4);
+    qemu_chr_write_all(s->chr_out, msg, sizeof(msg));
+}
+
+/* Drive the 16 qdev output GPIO lines to match current LAT (output pins only). */
+static void gpio_drive_outputs(PIC32MKGpioState *s)
+{
+    uint32_t out = s->lat & ~s->tris;
+    for (int i = 0; i < 16; i++) {
+        qemu_set_irq(s->output[i], (out >> i) & 1);
+    }
+}
+
+/*
+ * Evaluate CN interrupt.
+ *
+ * PIC32MK CN is mismatch-based: CNSTAT bits are set when the current PORT
+ * value differs from the value captured at the last PORT read (cn_ref).
+ * The interrupt line is held HIGH as long as any enabled mismatch exists;
+ * reading PORT (in the ISR) updates cn_ref and clears the mismatch, which
+ * deasserts the interrupt so the EVIC doesn't immediately re-set IFS.
+ */
+static void gpio_eval_cn(PIC32MKGpioState *s)
+{
+#define CNCON_ON  (1u << 15)
+    if (!(s->cncon & CNCON_ON)) {
+        return;
+    }
+    /* Mismatch between current port and the reference snapshot */
+    uint32_t mismatch = (s->port ^ s->cn_ref) & s->cnen0;
+    s->cnstat = mismatch;
+
+    if (mismatch) {
+        qemu_set_irq(s->cn_irq, 1);   /* assert — EVIC sets IFS */
+    } else {
+        qemu_set_irq(s->cn_irq, 0);   /* deassert — no more mismatch */
+    }
+}
+
+/*
+ * qdev GPIO input handler (external pin injection)
+ * -----------------------------------------------------------------------
+ */
+
+static void gpio_set_input(PIC32MKGpioState *s, int pin, int level)
+{
+    uint32_t mask = 1u << pin;
+
+    if (level) {
+        s->ext_input |= mask;
+    } else {
+        s->ext_input &= ~mask;
+    }
+
+    gpio_update_port(s);
+    gpio_eval_cn(s);
+    gpio_notify_state(s);
+}
+
+static void gpio_set_input_line(void *opaque, int pin, int level)
+{
+    gpio_set_input(PIC32MK_GPIO(opaque), pin, level);
+}
+
+/*
+ * MMIO read/write
+ * -----------------------------------------------------------------------
+ */
+
+static uint64_t gpio_read(void *opaque, hwaddr addr, unsigned size)
+{
+    PIC32MKGpioState *s = opaque;
+    hwaddr base = addr & ~(hwaddr)0xF;
+    uint32_t *reg = gpio_find_reg(s, base);
+
+    if (reg) {
+        /*
+         * Reading PORT captures the current pin state into cn_ref.
+         * This clears the CN mismatch and deasserts the interrupt line,
+         * just like real PIC32MK hardware.
+         */
+        if (base == PIC32MK_PORT) {
+            s->cn_ref = s->port;
+            gpio_eval_cn(s);    /* deassert if no longer mismatching */
+        }
+        return *reg;
+    }
+
+    qemu_log_mask(LOG_UNIMP,
+                  "pic32mk_gpio: unimplemented read @ 0x%04" HWADDR_PRIx "\n",
+                  addr);
+    return 0;
+}
+
+static void gpio_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
+{
+    PIC32MKGpioState *s = opaque;
+    int sub       = (int)(addr & 0xF);
+    hwaddr base   = addr & ~(hwaddr)0xF;
+    uint32_t *reg = gpio_find_reg(s, base);
+
+    if (!reg) {
+        qemu_log_mask(LOG_UNIMP,
+                      "pic32mk_gpio: unimplemented write @ 0x%04"
+                      HWADDR_PRIx " = 0x%08" PRIx64 "\n",
+                      addr, val);
+        return;
+    }
+
+    apply_sci(reg, (uint32_t)val, sub);
+
+    /* Side-effects after write */
+    if (base == PIC32MK_LAT || base == PIC32MK_TRIS) {
+        /* Output pin levels or direction changed — update PORT and drive lines */
+        gpio_update_port(s);
+        gpio_drive_outputs(s);
+        gpio_eval_cn(s);
+        gpio_notify_state(s);
+    } else if (base == PIC32MK_ANSEL) {
+        gpio_notify_state(s);
+    }
+    if (base == PIC32MK_CNCON || base == PIC32MK_CNEN0 || base == PIC32MK_CNEN1) {
+        gpio_eval_cn(s);
+    }
+}
+
+static const MemoryRegionOps gpio_ops = {
+    .read       = gpio_read,
+    .write      = gpio_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+/*
+ * QOM properties — host access via qom-get / qom-set
+ * -----------------------------------------------------------------------
+ */
+
+static void gpio_prop_pin_get(Object *obj, Visitor *v, const char *name,
+                              void *opaque, Error **errp)
+{
+    PIC32MKGpioState *s = PIC32MK_GPIO(obj);
+    int pin = (int)(intptr_t)opaque;
+    bool val = (s->port >> pin) & 1;
+    visit_type_bool(v, name, &val, errp);
+}
+
+static void gpio_prop_pin_set(Object *obj, Visitor *v, const char *name,
+                              void *opaque, Error **errp)
+{
+    PIC32MKGpioState *s = PIC32MK_GPIO(obj);
+    int pin = (int)(intptr_t)opaque;
+    bool val;
+
+    if (!visit_type_bool(v, name, &val, errp)) {
+        return;
+    }
+    gpio_set_input(s, pin, val ? 1 : 0);
+}
+
+/*
+ * Device lifecycle
+ * -----------------------------------------------------------------------
+ */
+
+static void pic32mk_gpio_reset(DeviceState *dev)
+{
+    PIC32MKGpioState *s = PIC32MK_GPIO(dev);
+
+    s->ansel     = 0xFFFF;   /* all pins analog on reset */
+    s->tris      = 0xFFFF;   /* all pins input on reset */
+    s->port      = 0;
+    s->lat       = 0;
+    s->odc       = 0;
+    s->cnpu      = 0;
+    s->cnpd      = 0;
+    s->cncon     = 0;
+    s->cnen0     = 0;
+    s->cnstat    = 0;
+    s->cnen1     = 0;
+    s->cnf       = 0;
+    s->ext_input = 0;
+    s->cn_ref    = 0;
+}
+
+static void pic32mk_gpio_init(Object *obj)
+{
+    PIC32MKGpioState *s = PIC32MK_GPIO(obj);
+    DeviceState *dev = DEVICE(obj);
+
+    memory_region_init_io(&s->mr, obj, &gpio_ops, s,
+                          TYPE_PIC32MK_GPIO, PIC32MK_GPIO_PORT_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mr);
+
+    /* IRQ output → EVIC CN interrupt */
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->cn_irq);
+
+    /* 16 qdev GPIO input lines: board/test code drives external pin levels */
+    qdev_init_gpio_in(dev, gpio_set_input_line, 16);
+
+    /* 16 qdev GPIO output lines: driven when LAT output pins change */
+    qdev_init_gpio_out(dev, s->output, 16);
+
+    /* Per-pin bool QOM properties: pin0 … pin15 */
+    for (int i = 0; i < 16; i++) {
+        char name[8];
+        snprintf(name, sizeof(name), "pin%d", i);
+        object_property_add(obj, name, "bool",
+                            gpio_prop_pin_get,
+                            gpio_prop_pin_set,
+                            NULL, (void *)(intptr_t)i);
+    }
+
+    /* Whole-port read-only convenience properties */
+    object_property_add_uint32_ptr(obj, "lat-state",  &s->lat,  OBJ_PROP_FLAG_READ);
+    object_property_add_uint32_ptr(obj, "port-state", &s->port, OBJ_PROP_FLAG_READ);
+    object_property_add_uint32_ptr(obj, "tris-state", &s->tris, OBJ_PROP_FLAG_READ);
+}
+
+void pic32mk_gpio_set_chardev(DeviceState *dev, Chardev *chr)
+{
+    PIC32MKGpioState *s = PIC32MK_GPIO(dev);
+    s->chr_out = chr;
+}
+
+static const Property pic32mk_gpio_props[] = {
+    DEFINE_PROP_UINT8("port-index", PIC32MKGpioState, port_idx, 0),
+};
+
+static void pic32mk_gpio_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    device_class_set_legacy_reset(dc, pic32mk_gpio_reset);
+    device_class_set_props(dc, pic32mk_gpio_props);
+}
+
+static const TypeInfo pic32mk_gpio_info = {
+    .name          = TYPE_PIC32MK_GPIO,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(PIC32MKGpioState),
+    .instance_init = pic32mk_gpio_init,
+    .class_init    = pic32mk_gpio_class_init,
+};
+
+static void pic32mk_gpio_register_types(void)
+{
+    type_register_static(&pic32mk_gpio_info);
+}
+
+type_init(pic32mk_gpio_register_types)
diff --git a/hw/mips/pic32mk_i2c.c b/hw/mips/pic32mk_i2c.c
new file mode 100644
index 0000000000..b8c7220d92
--- /dev/null
+++ b/hw/mips/pic32mk_i2c.c
@@ -0,0 +1,184 @@
+/*
+ * PIC32MK I2C × 4 (I2C1–I2C4)
+ * Datasheet: DS60001519E, §24
+ *
+ * Each I2C instance is a SysBusDevice that stubs the register file and
+ * attaches a QEMU i2c_bus for downstream device models.
+ * Master-mode state machine is Phase 2B; firmware init (I2CxCON writes)
+ * succeeds silently.
+ *
+ * Copyright (c) 2026 QEMU contributors
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/core/sysbus.h"
+#include "hw/core/irq.h"
+#include "hw/i2c/i2c.h"
+#include "hw/mips/pic32mk.h"
+
+#define TYPE_PIC32MK_I2C    "pic32mk-i2c"
+OBJECT_DECLARE_SIMPLE_TYPE(PIC32MKI2CState, PIC32MK_I2C)
+
+struct PIC32MKI2CState {
+    SysBusDevice parent_obj;
+    MemoryRegion mr;
+
+    uint32_t con;   /* I2CxCON */
+    uint32_t stat;  /* I2CxSTAT */
+    uint32_t add;   /* I2CxADD */
+    uint32_t msk;   /* I2CxMSK */
+    uint32_t trn;   /* I2CxTRN — TX data */
+    uint32_t rcv;   /* I2CxRCV — RX data (read-only) */
+
+    I2CBus  *bus;
+    qemu_irq irq_master;   /* master interrupt */
+    qemu_irq irq_slave;    /* slave interrupt */
+    qemu_irq irq_bus;      /* bus-collision interrupt */
+};
+
+/* I2CxSTAT bits */
+#define I2C_STAT_TRSTAT     (1u << 14)  /* transmit status */
+#define I2C_STAT_ACKSTAT    (1u << 15)  /* ACK status */
+
+/* PIC32MK: base+0=REG, +4=CLR, +8=SET, +0xC=INV */
+static void apply_sci(uint32_t *reg, uint32_t val, int sub)
+{
+    switch (sub) {
+    case 0:
+        *reg  = val;
+        break;
+    case 4:
+        *reg &= ~val;
+        break;
+    case 8:
+        *reg |= val;
+        break;
+    case 12:
+        *reg ^= val;
+        break;
+    }
+}
+
+static uint32_t *i2c_find_reg(PIC32MKI2CState *s, hwaddr base)
+{
+    switch (base) {
+    case PIC32MK_I2CxCON:
+        return &s->con;
+    case PIC32MK_I2CxSTAT:
+        return &s->stat;
+    case PIC32MK_I2CxADD:
+        return &s->add;
+    case PIC32MK_I2CxMSK:
+        return &s->msk;
+    case PIC32MK_I2CxTRN:
+        return &s->trn;
+    case PIC32MK_I2CxRCV:
+        return &s->rcv;
+    default:
+        return NULL;
+    }
+}
+
+static uint64_t i2c_read(void *opaque, hwaddr addr, unsigned size)
+{
+    PIC32MKI2CState *s = opaque;
+    hwaddr base = addr & ~(hwaddr)0xF;
+    uint32_t *reg = i2c_find_reg(s, base);
+
+    if (reg) {
+        return *reg;
+    }
+
+    qemu_log_mask(LOG_UNIMP,
+                  "pic32mk_i2c: unimplemented read @ 0x%04" HWADDR_PRIx "\n",
+                  addr);
+    return 0;
+}
+
+static void i2c_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
+{
+    PIC32MKI2CState *s = opaque;
+    int sub     = (int)(addr & 0xF);
+    hwaddr base = addr & ~(hwaddr)0xF;
+    uint32_t *reg = i2c_find_reg(s, base);
+
+    if (!reg) {
+        qemu_log_mask(LOG_UNIMP,
+                      "pic32mk_i2c: unimplemented write @ 0x%04"
+                      HWADDR_PRIx " = 0x%08" PRIx64 "\n",
+                      addr, val);
+        return;
+    }
+
+    /* TRN write: transmit byte — stub logs but does not transfer */
+    if (base == PIC32MK_I2CxTRN) {
+        s->trn = (uint32_t)val;
+        qemu_log_mask(LOG_UNIMP,
+                      "pic32mk_i2c: TX write 0x%02x (I2C master not implemented)\n",
+                      (uint32_t)val & 0xFF);
+        return;
+    }
+
+    /* STAT is partially read-only; accept writes for CLR operations */
+    apply_sci(reg, (uint32_t)val, sub);
+}
+
+static const MemoryRegionOps i2c_ops = {
+    .read       = i2c_read,
+    .write      = i2c_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = { .min_access_size = 4, .max_access_size = 4 },
+};
+
+static void pic32mk_i2c_reset(DeviceState *dev)
+{
+    PIC32MKI2CState *s = PIC32MK_I2C(dev);
+    s->con  = 0;
+    s->stat = 0;
+    s->add  = 0;
+    s->msk  = 0;
+    s->trn  = 0xFF;
+    s->rcv  = 0;
+    qemu_irq_lower(s->irq_master);
+    qemu_irq_lower(s->irq_slave);
+    qemu_irq_lower(s->irq_bus);
+}
+
+static void pic32mk_i2c_init(Object *obj)
+{
+    PIC32MKI2CState *s = PIC32MK_I2C(obj);
+
+    memory_region_init_io(&s->mr, obj, &i2c_ops, s,
+                          TYPE_PIC32MK_I2C, PIC32MK_I2C_BLOCK_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mr);
+
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq_master);  /* index 0 */
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq_slave);   /* index 1 */
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq_bus);     /* index 2 */
+
+    s->bus = i2c_init_bus(DEVICE(obj), "i2c");
+}
+
+static void pic32mk_i2c_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    device_class_set_legacy_reset(dc, pic32mk_i2c_reset);
+}
+
+static const TypeInfo pic32mk_i2c_info = {
+    .name          = TYPE_PIC32MK_I2C,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(PIC32MKI2CState),
+    .instance_init = pic32mk_i2c_init,
+    .class_init    = pic32mk_i2c_class_init,
+};
+
+static void pic32mk_i2c_register_types(void)
+{
+    type_register_static(&pic32mk_i2c_info);
+}
+
+type_init(pic32mk_i2c_register_types)
diff --git a/hw/mips/pic32mk_ic.c b/hw/mips/pic32mk_ic.c
new file mode 100644
index 0000000000..5b709841fa
--- /dev/null
+++ b/hw/mips/pic32mk_ic.c
@@ -0,0 +1,384 @@
+/*
+ * PIC32MK Input Capture × 16 (IC1–IC16)
+ * Datasheet: DS60001519E, §18
+ *
+ * Emulation model: full register model with 4-entry FIFO.
+ * Two IRQ outputs per instance: capture IRQ and overflow-error IRQ.
+ *
+ * Capture injection via optional chardev ("ic-events"):
+ *   The chardev is receive-side: the host writes 8-byte packets to
+ *   inject capture events into the FIFO.
+ *
+ *   Packet format (8 bytes, little-endian):
+ *     [0]   index   — IC instance (1–16); packet ignored if != this instance
+ *     [1]   flags   — bit0=error inject, bit1=hi16 valid (32-bit capture pair)
+ *     [2–3] val_lo  — 16-bit capture value (low word), LE
+ *     [4–5] val_hi  — 16-bit capture value (high word), LE (C32 mode only)
+ *     [6–7] reserved
+ *
+ *   On inject: push val_lo to FIFO (and val_hi if flags.bit1 and C32=1),
+ *   set ICBNE, assert capture IRQ (if ICI != 0).  If FIFO full: set ICOV,
+ *   assert error IRQ.  Error-inject (flags.bit0=1): set ICOV, assert error IRQ.
+ *
+ * Register layout within each 0x200-byte block
+ * (SET/CLR/INV sub-regs at +4/+8/+C relative to register base):
+ *   ICxCON  +0x00  Control: ON, SIDL, FEDGE, C32, ICTMR, ICI, ICOV, ICBNE, ICM
+ *   ICxBUF  +0x10  Capture buffer (read-only FIFO pop; write ignored)
+ *
+ * FIFO: 4 entries × 16-bit.  ICBNE cleared when FIFO empties.
+ *       In C32 mode, two consecutive ICxBUF reads assemble one 32-bit value.
+ *
+ * Copyright (c) 2026 QEMU contributors
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/core/sysbus.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/qdev-properties-system.h"
+#include "hw/core/irq.h"
+#include "hw/mips/pic32mk.h"
+#include "chardev/char.h"
+#include "chardev/char-fe.h"
+
+/*
+ * ICM mode names (ICxCON bits 2:0)
+ * -----------------------------------------------------------------------
+ */
+static const char *icm_mode_names[] = {
+    [0] = "Disabled",
+    [1] = "Every edge",
+    [2] = "Every 2nd rising edge",
+    [3] = "Every 3rd rising edge",
+    [4] = "Every 4th rising edge",
+    [5] = "Every 5th rising edge (mode5)",
+    [6] = "Every 6th rising edge (mode6)",
+    [7] = "Every 7th rising edge (mode7)",
+};
+
+/*
+ * Global instance table — lets IC1 (the sole chardev owner) dispatch
+ * packets to any of the 16 IC instances by index.
+ * -----------------------------------------------------------------------
+ */
+
+static struct PIC32MKICState *g_ic_instances[17]; /* index 1–16 */
+
+/*
+ * Device state
+ * -----------------------------------------------------------------------
+ */
+
+#define TYPE_PIC32MK_IC  "pic32mk-ic"
+OBJECT_DECLARE_SIMPLE_TYPE(PIC32MKICState, PIC32MK_IC)
+
+#define PIC32MK_IC_FIFO_DEPTH  4
+
+struct PIC32MKICState {
+    SysBusDevice parent_obj;
+    MemoryRegion mr;
+
+    uint32_t con;                          /* ICxCON */
+    uint16_t fifo[PIC32MK_IC_FIFO_DEPTH]; /* capture FIFO */
+    uint8_t  fifo_head;                    /* read pointer  */
+    uint8_t  fifo_tail;                    /* write pointer */
+    uint8_t  fifo_count;                   /* entries in use */
+
+    qemu_irq irq_capture;   /* normal capture IRQ → EVIC */
+    qemu_irq irq_error;     /* overflow / error IRQ → EVIC */
+    uint8_t  index;         /* 1–16 */
+
+    CharFrontend chr;       /* optional chardev for capture injection */
+
+    /* Partial-packet accumulator for chardev receive */
+    uint8_t  pkt_buf[8];
+    int      pkt_len;
+};
+
+/*
+ * FIFO helpers
+ * -----------------------------------------------------------------------
+ */
+
+static void ic_fifo_reset(PIC32MKICState *s)
+{
+    s->fifo_head  = 0;
+    s->fifo_tail  = 0;
+    s->fifo_count = 0;
+    s->con &= ~(PIC32MK_ICCON_ICBNE | PIC32MK_ICCON_ICOV);
+}
+
+static void ic_fifo_push(PIC32MKICState *s, uint16_t val)
+{
+    if (s->fifo_count == PIC32MK_IC_FIFO_DEPTH) {
+        /* Overflow: set ICOV, pulse error IRQ */
+        s->con |= PIC32MK_ICCON_ICOV;
+        qemu_irq_pulse(s->irq_error);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "pic32mk_ic: IC%u FIFO overflow\n", s->index);
+        return;
+    }
+    s->fifo[s->fifo_tail] = val;
+    s->fifo_tail = (s->fifo_tail + 1) % PIC32MK_IC_FIFO_DEPTH;
+    s->fifo_count++;
+    s->con |= PIC32MK_ICCON_ICBNE;
+}
+
+static uint16_t ic_fifo_pop(PIC32MKICState *s)
+{
+    if (s->fifo_count == 0) {
+        return 0;
+    }
+    uint16_t val = s->fifo[s->fifo_head];
+    s->fifo_head = (s->fifo_head + 1) % PIC32MK_IC_FIFO_DEPTH;
+    s->fifo_count--;
+    if (s->fifo_count == 0) {
+        s->con &= ~PIC32MK_ICCON_ICBNE;
+    }
+    return val;
+}
+
+/*
+ * Capture injection — called from chardev receive handler
+ * -----------------------------------------------------------------------
+ */
+
+static void ic_inject_capture(PIC32MKICState *s, uint8_t flags,
+                               uint16_t val_lo, uint16_t val_hi)
+{
+    if (!(s->con & PIC32MK_ICCON_ON)) {
+        return;  /* IC not enabled — ignore */
+    }
+
+    if (flags & 1) {
+        /* Error inject: set ICOV, pulse error IRQ */
+        s->con |= PIC32MK_ICCON_ICOV;
+        qemu_irq_pulse(s->irq_error);
+        return;
+    }
+
+    ic_fifo_push(s, val_lo);
+    if ((flags & 2) && (s->con & PIC32MK_ICCON_C32)) {
+        ic_fifo_push(s, val_hi);
+    }
+
+    /*
+     * ICI<1:0>: 00=every 1st, 01=every 2nd, 10=every 3rd, 11=every 4th capture.
+     * Simplified model: always fire on every capture (ICI threshold ignored).
+      */
+    if (s->fifo_count > 0) {
+        qemu_irq_pulse(s->irq_capture);
+    }
+}
+
+/*
+ * Chardev receive handler
+ * -----------------------------------------------------------------------
+ */
+
+static int ic_chr_can_receive(void *opaque)
+{
+    /* Accept up to one full packet at a time */
+    return 8;
+}
+
+static void ic_chr_receive(void *opaque, const uint8_t *buf, int size)
+{
+    PIC32MKICState *s = opaque;
+    int i = 0;
+
+    while (i < size) {
+        int need = 8 - s->pkt_len;
+        int avail = size - i;
+        int copy = (avail < need) ? avail : need;
+
+        memcpy(s->pkt_buf + s->pkt_len, buf + i, copy);
+        s->pkt_len += copy;
+        i += copy;
+
+        if (s->pkt_len == 8) {
+            uint8_t  inst    = s->pkt_buf[0];
+            uint8_t  flags   = s->pkt_buf[1];
+            uint16_t val_lo, val_hi;
+            memcpy(&val_lo, &s->pkt_buf[2], 2);
+            memcpy(&val_hi, &s->pkt_buf[4], 2);
+            val_lo = le16_to_cpu(val_lo);
+            val_hi = le16_to_cpu(val_hi);
+            s->pkt_len = 0;
+
+            /* Route to target instance via global table */
+            if (inst >= 1 && inst <= 16 && g_ic_instances[inst]) {
+                ic_inject_capture(g_ic_instances[inst], flags, val_lo, val_hi);
+            }
+        }
+    }
+}
+
+/*
+ * MMIO helpers
+ * -----------------------------------------------------------------------
+ */
+
+/* PIC32MK: base+0=REG, +4=CLR, +8=SET, +0xC=INV */
+static void apply_sci(uint32_t *reg, uint32_t val, int sub)
+{
+    switch (sub) {
+    case 0:
+        *reg  = val;
+        break;
+    case 4:
+        *reg &= ~val;
+        break;
+    case 8:
+        *reg |= val;
+        break;
+    case 12:
+        *reg ^= val;
+        break;
+    }
+}
+
+/*
+ * MMIO read / write
+ * -----------------------------------------------------------------------
+ */
+
+static uint64_t ic_read(void *opaque, hwaddr addr, unsigned size)
+{
+    PIC32MKICState *s = opaque;
+    hwaddr base = addr & ~(hwaddr)0xF;
+
+    switch (base) {
+    case PIC32MK_ICxCON:
+        return s->con;
+    case PIC32MK_ICxBUF:
+        return ic_fifo_pop(s);
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "pic32mk_ic: IC%u unimplemented read @ 0x%04"
+                      HWADDR_PRIx "\n", s->index, addr);
+        return 0;
+    }
+}
+
+static void ic_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
+{
+    PIC32MKICState *s = opaque;
+    int    sub  = (int)(addr & 0xF);
+    hwaddr base = addr & ~(hwaddr)0xF;
+
+    switch (base) {
+    case PIC32MK_ICxCON: {
+        bool was_on = !!(s->con & PIC32MK_ICCON_ON);
+        apply_sci(&s->con, (uint32_t)val, sub);
+        bool now_on = !!(s->con & PIC32MK_ICCON_ON);
+
+        if (!was_on && now_on) {
+            /* ON 0→1: reset FIFO, log enable */
+            ic_fifo_reset(s);
+            uint32_t icm  = (s->con & PIC32MK_ICCON_ICM_MASK);
+            uint32_t ici  = (s->con & PIC32MK_ICCON_ICI_MASK) >> PIC32MK_ICCON_ICI_SHIFT;
+            bool     c32  = !!(s->con & PIC32MK_ICCON_C32);
+            bool     ictmr = !!(s->con & PIC32MK_ICCON_ICTMR);
+            bool     fedge = !!(s->con & PIC32MK_ICCON_FEDGE);
+            qemu_log("pic32mk_ic: IC%u enabled — mode=%s, ICI=%u, "
+                     "C32=%u, ICTMR=%u, FEDGE=%u\n",
+                     s->index, icm_mode_names[icm], ici, c32, ictmr, fedge);
+        } else if (was_on && !now_on) {
+            qemu_log("pic32mk_ic: IC%u disabled\n", s->index);
+        }
+        break;
+    }
+    case PIC32MK_ICxBUF:
+        /* ICxBUF is read-only; writes are ignored */
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "pic32mk_ic: IC%u unimplemented write @ 0x%04"
+                      HWADDR_PRIx " = 0x%08" PRIx64 "\n",
+                      s->index, addr, val);
+        break;
+    }
+}
+
+static const MemoryRegionOps ic_ops = {
+    .read       = ic_read,
+    .write      = ic_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+/*
+ * Device lifecycle
+ * -----------------------------------------------------------------------
+ */
+
+static void pic32mk_ic_reset(DeviceState *dev)
+{
+    PIC32MKICState *s = PIC32MK_IC(dev);
+    s->con     = 0;
+    s->pkt_len = 0;
+    ic_fifo_reset(s);
+}
+
+static void pic32mk_ic_realize(DeviceState *dev, Error **errp)
+{
+    PIC32MKICState *s = PIC32MK_IC(dev);
+
+    /* Register in global table so the chardev dispatcher can find us */
+    if (s->index >= 1 && s->index <= 16) {
+        g_ic_instances[s->index] = s;
+    }
+
+    /* Only IC1 owns the chardev — it dispatches packets to all instances */
+    if (qemu_chr_fe_backend_connected(&s->chr)) {
+        qemu_chr_fe_set_handlers(&s->chr,
+                                 ic_chr_can_receive,
+                                 ic_chr_receive,
+                                 NULL, NULL, s, NULL, true);
+    }
+}
+
+static void pic32mk_ic_init(Object *obj)
+{
+    PIC32MKICState *s = PIC32MK_IC(obj);
+
+    memory_region_init_io(&s->mr, obj, &ic_ops, s,
+                          TYPE_PIC32MK_IC, PIC32MK_IC_BLOCK_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mr);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq_capture);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq_error);
+}
+
+static Property pic32mk_ic_properties[] = {
+    DEFINE_PROP_UINT8("index",   PIC32MKICState, index, 1),
+    DEFINE_PROP_CHR("chardev",   PIC32MKICState, chr),
+};
+
+static void pic32mk_ic_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    dc->realize = pic32mk_ic_realize;
+    device_class_set_legacy_reset(dc, pic32mk_ic_reset);
+    device_class_set_props(dc, pic32mk_ic_properties);
+}
+
+static const TypeInfo pic32mk_ic_info = {
+    .name          = TYPE_PIC32MK_IC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(PIC32MKICState),
+    .instance_init = pic32mk_ic_init,
+    .class_init    = pic32mk_ic_class_init,
+};
+
+static void pic32mk_ic_register_types(void)
+{
+    type_register_static(&pic32mk_ic_info);
+}
+
+type_init(pic32mk_ic_register_types)
diff --git a/hw/mips/pic32mk_nvm.c b/hw/mips/pic32mk_nvm.c
new file mode 100644
index 0000000000..c7538ee1cf
--- /dev/null
+++ b/hw/mips/pic32mk_nvm.c
@@ -0,0 +1,572 @@
+/*
+ * PIC32MK NVM / Flash Controller emulation
+ * Datasheet: DS60001519E, §10
+ *
+ * Mediates program/erase operations on the 1 MB Program Flash
+ * (0x1D000000–0x1D0FFFFF) through the NVMCON register interface at
+ * SFR offset 0x0A00 (virtual 0xBF800A00).
+ *
+ * The flash memory region must be created as RAM (not ROM) by the board
+ * init code so that this device can write into it.  A QOM link property
+ * "pflash" connects to the MemoryRegion backing the program flash.
+ *
+ * Copyright (c) 2026 QEMU contributors
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "hw/core/sysbus.h"
+#include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/mips/pic32mk.h"
+#include "system/dma.h"
+
+#include <fcntl.h>
+#include <unistd.h>
+
+#define TYPE_PIC32MK_NVM "pic32mk-nvm"
+OBJECT_DECLARE_SIMPLE_TYPE(PIC32MKNVMState, PIC32MK_NVM)
+
+/* NVMKEY unlock FSM states */
+#define NVMKEY_LOCKED       0
+#define NVMKEY_KEY1_OK      1
+#define NVMKEY_UNLOCKED     2
+
+struct PIC32MKNVMState {
+    SysBusDevice parent_obj;
+    MemoryRegion mr;
+
+    /* SFR registers */
+    uint32_t nvmcon;
+    uint32_t nvmaddr;
+    uint32_t nvmdata[4];        /* NVMDATA0–3 */
+    uint32_t nvmsrcaddr;
+    uint32_t nvmpwp;
+    uint32_t nvmbwp;
+    uint32_t nvmcon2;
+    int      nvmkey_state;      /* unlock FSM */
+
+    /* QOM link to program flash MemoryRegion (must be RAM-backed) */
+    MemoryRegion *pflash_mr;
+
+    /* IRQ output → EVIC vector 31 (_FLASH_CONTROL_VECTOR) */
+    qemu_irq irq;
+
+    /* Host backing file for flash persistence */
+    char    *filename;          /* qdev string property */
+    int      backing_fd;
+};
+
+/*
+ * SET/CLR/INV helper (PIC32MK convention: +0=REG, +4=CLR, +8=SET, +C=INV)
+ * -----------------------------------------------------------------------
+ */
+
+static void apply_sci(uint32_t *reg, uint32_t val, int sub)
+{
+    switch (sub) {
+    case 0x0:
+        *reg  = val;
+        break;
+    case 0x4:
+        *reg &= ~val;
+        break;
+    case 0x8:
+        *reg |= val;
+        break;
+    case 0xC:
+        *reg ^= val;
+        break;
+    }
+}
+
+/*
+ * Flash access helpers
+ * -----------------------------------------------------------------------
+ */
+
+/*
+ * Convert a physical NVMADDR value to an offset within the program flash
+ * region.  Returns true on success, false if the address is out of range.
+ */
+static bool nvm_addr_to_offset(uint32_t phys_addr, uint32_t *offset)
+{
+    if (phys_addr >= PIC32MK_PFLASH_BASE &&
+        phys_addr < PIC32MK_PFLASH_BASE + PIC32MK_PFLASH_SIZE) {
+        *offset = phys_addr - PIC32MK_PFLASH_BASE;
+        return true;
+    }
+    return false;
+}
+
+static uint8_t *nvm_flash_ptr(PIC32MKNVMState *s)
+{
+    if (!s->pflash_mr) {
+        return NULL;
+    }
+    return memory_region_get_ram_ptr(s->pflash_mr);
+}
+
+/*
+ * Backing file helpers
+ * -----------------------------------------------------------------------
+ */
+
+static void nvm_load_backing(PIC32MKNVMState *s)
+{
+    if (s->backing_fd < 0 || !s->pflash_mr) {
+        return;
+    }
+    uint8_t *flash = nvm_flash_ptr(s);
+    if (!flash) {
+        return;
+    }
+    lseek(s->backing_fd, 0, SEEK_SET);
+    ssize_t n = read(s->backing_fd, flash, PIC32MK_PFLASH_SIZE);
+    if (n < 0) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "pic32mk_nvm: backing file read error\n");
+    } else if ((size_t)n < PIC32MK_PFLASH_SIZE) {
+        /* Short read — pad with 0xFF (erased flash) */
+        memset(flash + n, 0xFF, PIC32MK_PFLASH_SIZE - (size_t)n);
+    }
+}
+
+static void nvm_flush_backing(PIC32MKNVMState *s)
+{
+    if (s->backing_fd < 0 || !s->pflash_mr) {
+        return;
+    }
+    uint8_t *flash = nvm_flash_ptr(s);
+    if (!flash) {
+        return;
+    }
+    lseek(s->backing_fd, 0, SEEK_SET);
+    ssize_t n = write(s->backing_fd, flash, PIC32MK_PFLASH_SIZE);
+    if (n < 0) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "pic32mk_nvm: backing file write error\n");
+    }
+    fdatasync(s->backing_fd);
+}
+
+/*
+ * Command execution — triggered when WR transitions 0 → 1
+ * -----------------------------------------------------------------------
+ */
+
+static void nvm_execute_cmd(PIC32MKNVMState *s)
+{
+    uint32_t op = s->nvmcon & PIC32MK_NVMCON_NVMOP_MASK;
+    uint32_t offset;
+    uint8_t *flash;
+
+    /* Clear previous errors */
+    s->nvmcon &= ~(PIC32MK_NVMCON_WRERR | PIC32MK_NVMCON_LVDERR);
+
+    /* All write/erase operations require WREN + unlock */
+    if (op != PIC32MK_NVMOP_NOP) {
+        if (!(s->nvmcon & PIC32MK_NVMCON_WREN)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "pic32mk_nvm: operation 0x%x without WREN\n", op);
+            s->nvmcon |= PIC32MK_NVMCON_WRERR;
+            goto done;
+        }
+        if (s->nvmkey_state != NVMKEY_UNLOCKED) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "pic32mk_nvm: operation 0x%x without unlock\n", op);
+            s->nvmcon |= PIC32MK_NVMCON_WRERR;
+            goto done;
+        }
+    }
+
+    flash = nvm_flash_ptr(s);
+    if (!flash && op != PIC32MK_NVMOP_NOP) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "pic32mk_nvm: no pflash region linked\n");
+        s->nvmcon |= PIC32MK_NVMCON_WRERR;
+        goto done;
+    }
+
+    switch (op) {
+    case PIC32MK_NVMOP_NOP:
+        break;
+
+    case PIC32MK_NVMOP_WORD_PROG:
+        if (!nvm_addr_to_offset(s->nvmaddr, &offset)) {
+            s->nvmcon |= PIC32MK_NVMCON_WRERR;
+            break;
+        }
+        if (offset + 4 > PIC32MK_PFLASH_SIZE) {
+            s->nvmcon |= PIC32MK_NVMCON_WRERR;
+            break;
+        }
+        /* Word-aligned write */
+        offset &= ~3u;
+        memcpy(flash + offset, &s->nvmdata[0], 4);
+        memory_region_set_dirty(s->pflash_mr, offset, 4);
+        break;
+
+    case PIC32MK_NVMOP_QUAD_WORD_PROG:
+        if (!nvm_addr_to_offset(s->nvmaddr, &offset)) {
+            s->nvmcon |= PIC32MK_NVMCON_WRERR;
+            break;
+        }
+        /* Must be 16-byte aligned */
+        offset &= ~0xFu;
+        if (offset + 16 > PIC32MK_PFLASH_SIZE) {
+            s->nvmcon |= PIC32MK_NVMCON_WRERR;
+            break;
+        }
+        memcpy(flash + offset, s->nvmdata, 16);
+        memory_region_set_dirty(s->pflash_mr, offset, 16);
+        break;
+
+    case PIC32MK_NVMOP_ROW_PROG: {
+        if (!nvm_addr_to_offset(s->nvmaddr, &offset)) {
+            s->nvmcon |= PIC32MK_NVMCON_WRERR;
+            break;
+        }
+        /* Row-aligned destination */
+        offset &= ~(PIC32MK_NVM_ROW_SIZE - 1);
+        if (offset + PIC32MK_NVM_ROW_SIZE > PIC32MK_PFLASH_SIZE) {
+            s->nvmcon |= PIC32MK_NVMCON_WRERR;
+            break;
+        }
+        /*
+         * Copy ROW_SIZE bytes from guest physical address NVMSRCADDR
+         * into the program flash at the destination offset.
+         */
+        {
+            uint8_t row_buf[PIC32MK_NVM_ROW_SIZE];
+            MemTxResult res = dma_memory_read(
+                &address_space_memory, s->nvmsrcaddr,
+                row_buf, PIC32MK_NVM_ROW_SIZE, MEMTXATTRS_UNSPECIFIED);
+            if (res != MEMTX_OK) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "pic32mk_nvm: row read from 0x%08x failed\n",
+                              s->nvmsrcaddr);
+                s->nvmcon |= PIC32MK_NVMCON_WRERR;
+                break;
+            }
+            memcpy(flash + offset, row_buf, PIC32MK_NVM_ROW_SIZE);
+            memory_region_set_dirty(s->pflash_mr, offset,
+                                    PIC32MK_NVM_ROW_SIZE);
+        }
+        break;
+    }
+
+    case PIC32MK_NVMOP_PAGE_ERASE:
+        if (!nvm_addr_to_offset(s->nvmaddr, &offset)) {
+            s->nvmcon |= PIC32MK_NVMCON_WRERR;
+            break;
+        }
+        /* Page-align */
+        offset &= ~(PIC32MK_NVM_PAGE_SIZE - 1);
+        if (offset + PIC32MK_NVM_PAGE_SIZE > PIC32MK_PFLASH_SIZE) {
+            s->nvmcon |= PIC32MK_NVMCON_WRERR;
+            break;
+        }
+        memset(flash + offset, 0xFF, PIC32MK_NVM_PAGE_SIZE);
+        memory_region_set_dirty(s->pflash_mr, offset, PIC32MK_NVM_PAGE_SIZE);
+        break;
+
+    case PIC32MK_NVMOP_PFM_ERASE:
+        memset(flash, 0xFF, PIC32MK_PFLASH_SIZE);
+        memory_region_set_dirty(s->pflash_mr, 0, PIC32MK_PFLASH_SIZE);
+        break;
+
+    case PIC32MK_NVMOP_LOWER_PFM_ERASE:
+    case PIC32MK_NVMOP_UPPER_PFM_ERASE:
+        qemu_log_mask(LOG_UNIMP,
+                      "pic32mk_nvm: unimplemented NVMOP 0x%x\n", op);
+        break;
+
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "pic32mk_nvm: unknown NVMOP 0x%x\n", op);
+        s->nvmcon |= PIC32MK_NVMCON_WRERR;
+        break;
+    }
+
+done:
+    /* Operation complete — clear WR, reset unlock FSM */
+    s->nvmcon &= ~PIC32MK_NVMCON_WR;
+    s->nvmkey_state = NVMKEY_LOCKED;
+
+    /* Pulse IRQ to signal completion */
+    qemu_irq_pulse(s->irq);
+
+    /* Flush to backing file after any successful write/erase */
+    if (op != PIC32MK_NVMOP_NOP &&
+        !(s->nvmcon & (PIC32MK_NVMCON_WRERR | PIC32MK_NVMCON_LVDERR))) {
+        nvm_flush_backing(s);
+    }
+}
+
+/*
+ * MMIO read
+ * -----------------------------------------------------------------------
+ */
+
+static uint64_t nvm_read(void *opaque, hwaddr addr, unsigned size)
+{
+    PIC32MKNVMState *s = opaque;
+    hwaddr base = addr & ~(hwaddr)0xF;
+
+    switch (base) {
+    case PIC32MK_NVMCON:
+        return s->nvmcon;
+    case PIC32MK_NVMKEY:
+        return 0;
+        /* write-only */;
+    case PIC32MK_NVMADDR:
+        return s->nvmaddr;
+    case PIC32MK_NVMDATA0:
+        return s->nvmdata[0];
+    case PIC32MK_NVMDATA1:
+        return s->nvmdata[1];
+    case PIC32MK_NVMDATA2:
+        return s->nvmdata[2];
+    case PIC32MK_NVMDATA3:
+        return s->nvmdata[3];
+    case PIC32MK_NVMSRCADDR:
+        return s->nvmsrcaddr;
+    case PIC32MK_NVMPWP:
+        return s->nvmpwp;
+    case PIC32MK_NVMBWP:
+        return s->nvmbwp;
+    case PIC32MK_NVMCON2:
+        return s->nvmcon2;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "pic32mk_nvm: unimplemented read @ 0x%04"
+                      HWADDR_PRIx "\n", addr);
+        return 0;
+    }
+}
+
+/*
+ * MMIO write
+ * -----------------------------------------------------------------------
+ */
+
+static void nvm_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
+{
+    PIC32MKNVMState *s = opaque;
+    int sub     = (int)(addr & 0xF);
+    hwaddr base = addr & ~(hwaddr)0xF;
+    uint32_t old_nvmcon;
+
+    switch (base) {
+    case PIC32MK_NVMCON:
+        old_nvmcon = s->nvmcon;
+        apply_sci(&s->nvmcon, (uint32_t)val, sub);
+
+        /* Detect WR 0→1 transition: execute command */
+        if (!(old_nvmcon & PIC32MK_NVMCON_WR) &&
+             (s->nvmcon & PIC32MK_NVMCON_WR)) {
+            nvm_execute_cmd(s);
+        }
+        break;
+
+    case PIC32MK_NVMKEY:
+        /*
+         * Unlock FSM: firmware writes 0xAA996655 then 0x556699AA.
+         * Any other value resets the FSM.  SET/CLR/INV are not
+         * meaningful for NVMKEY — always treat as direct write.
+         */
+        {
+            uint32_t key = (uint32_t)val;
+            if (s->nvmkey_state == NVMKEY_LOCKED &&
+                key == PIC32MK_NVMKEY1) {
+                s->nvmkey_state = NVMKEY_KEY1_OK;
+            } else if (s->nvmkey_state == NVMKEY_KEY1_OK &&
+                       key == PIC32MK_NVMKEY2) {
+                s->nvmkey_state = NVMKEY_UNLOCKED;
+            } else {
+                s->nvmkey_state = NVMKEY_LOCKED;
+            }
+        }
+        break;
+
+    case PIC32MK_NVMADDR:
+        apply_sci(&s->nvmaddr, (uint32_t)val, sub);
+        break;
+
+    case PIC32MK_NVMDATA0:
+        apply_sci(&s->nvmdata[0], (uint32_t)val, sub);
+        break;
+
+    case PIC32MK_NVMDATA1:
+        apply_sci(&s->nvmdata[1], (uint32_t)val, sub);
+        break;
+
+    case PIC32MK_NVMDATA2:
+        apply_sci(&s->nvmdata[2], (uint32_t)val, sub);
+        break;
+
+    case PIC32MK_NVMDATA3:
+        apply_sci(&s->nvmdata[3], (uint32_t)val, sub);
+        break;
+
+    case PIC32MK_NVMSRCADDR:
+        apply_sci(&s->nvmsrcaddr, (uint32_t)val, sub);
+        break;
+
+    case PIC32MK_NVMPWP:
+        apply_sci(&s->nvmpwp, (uint32_t)val, sub);
+        break;
+
+    case PIC32MK_NVMBWP:
+        apply_sci(&s->nvmbwp, (uint32_t)val, sub);
+        break;
+
+    case PIC32MK_NVMCON2:
+        apply_sci(&s->nvmcon2, (uint32_t)val, sub);
+        break;
+
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "pic32mk_nvm: unimplemented write @ 0x%04"
+                      HWADDR_PRIx " = 0x%08" PRIx64 "\n",
+                      addr, val);
+        break;
+    }
+}
+
+static const MemoryRegionOps nvm_ops = {
+    .read       = nvm_read,
+    .write      = nvm_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = { .min_access_size = 4, .max_access_size = 4 },
+};
+
+/*
+ * Device lifecycle
+ * -----------------------------------------------------------------------
+ */
+
+static void pic32mk_nvm_reset(DeviceState *dev)
+{
+    PIC32MKNVMState *s = PIC32MK_NVM(dev);
+
+    s->nvmcon      = 0;
+    s->nvmaddr     = 0;
+    s->nvmdata[0]  = 0;
+    s->nvmdata[1]  = 0;
+    s->nvmdata[2]  = 0;
+    s->nvmdata[3]  = 0;
+    s->nvmsrcaddr  = 0;
+    s->nvmpwp      = 0;
+    s->nvmbwp      = 0;
+    s->nvmcon2     = 0;
+    s->nvmkey_state = NVMKEY_LOCKED;
+
+    qemu_irq_lower(s->irq);
+}
+
+static void pic32mk_nvm_realize(DeviceState *dev, Error **errp)
+{
+    PIC32MKNVMState *s = PIC32MK_NVM(dev);
+
+    if (!s->pflash_mr) {
+        error_setg(errp, "pic32mk_nvm: 'pflash' link property not set");
+        return;
+    }
+
+    s->backing_fd = -1;
+
+    if (s->filename && s->filename[0] != '\0') {
+        s->backing_fd = open(s->filename, O_RDWR | O_CREAT, 0644);
+        if (s->backing_fd < 0) {
+            error_setg_errno(errp, errno,
+                             "pic32mk_nvm: cannot open '%s'",
+                             s->filename);
+            return;
+        }
+
+        /*
+         * If the file is new or undersized, initialize it with 0xFF
+         * (erased flash state).
+         */
+        off_t fsize = lseek(s->backing_fd, 0, SEEK_END);
+        if (fsize < (off_t)PIC32MK_PFLASH_SIZE) {
+            /* Extend with 0xFF in chunks */
+            uint8_t ff_buf[4096];
+            memset(ff_buf, 0xFF, sizeof(ff_buf));
+            lseek(s->backing_fd, (fsize > 0) ? fsize : 0, SEEK_SET);
+            size_t remaining = PIC32MK_PFLASH_SIZE - (size_t)((fsize > 0) ? fsize : 0);
+            while (remaining > 0) {
+                size_t chunk = (remaining < sizeof(ff_buf)) ? remaining : sizeof(ff_buf);
+                if (write(s->backing_fd, ff_buf, chunk) < 0) {
+                    qemu_log_mask(LOG_GUEST_ERROR,
+                                  "pic32mk_nvm: cannot init '%s'\n",
+                                  s->filename);
+                    break;
+                }
+                remaining -= chunk;
+            }
+            fdatasync(s->backing_fd);
+        }
+
+        /* Load backing file into pflash RAM */
+        nvm_load_backing(s);
+    }
+}
+
+static void pic32mk_nvm_unrealize(DeviceState *dev)
+{
+    PIC32MKNVMState *s = PIC32MK_NVM(dev);
+
+    nvm_flush_backing(s);
+
+    if (s->backing_fd >= 0) {
+        close(s->backing_fd);
+        s->backing_fd = -1;
+    }
+}
+
+static void pic32mk_nvm_init(Object *obj)
+{
+    PIC32MKNVMState *s = PIC32MK_NVM(obj);
+
+    memory_region_init_io(&s->mr, obj, &nvm_ops, s,
+                          TYPE_PIC32MK_NVM, PIC32MK_NVM_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mr);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
+}
+
+static const Property pic32mk_nvm_props[] = {
+    DEFINE_PROP_LINK("pflash", PIC32MKNVMState, pflash_mr,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
+    DEFINE_PROP_STRING("filename", PIC32MKNVMState, filename),
+};
+
+static void pic32mk_nvm_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize   = pic32mk_nvm_realize;
+    dc->unrealize = pic32mk_nvm_unrealize;
+    device_class_set_legacy_reset(dc, pic32mk_nvm_reset);
+    device_class_set_props(dc, pic32mk_nvm_props);
+}
+
+static const TypeInfo pic32mk_nvm_info = {
+    .name          = TYPE_PIC32MK_NVM,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(PIC32MKNVMState),
+    .instance_init = pic32mk_nvm_init,
+    .class_init    = pic32mk_nvm_class_init,
+};
+
+static void pic32mk_nvm_register_types(void)
+{
+    type_register_static(&pic32mk_nvm_info);
+}
+
+type_init(pic32mk_nvm_register_types)
diff --git a/hw/mips/pic32mk_oc.c b/hw/mips/pic32mk_oc.c
new file mode 100644
index 0000000000..df47cba59f
--- /dev/null
+++ b/hw/mips/pic32mk_oc.c
@@ -0,0 +1,293 @@
+/*
+ * PIC32MK Output Compare × 16 (OC1–OC16)
+ * Datasheet: DS60001519E, §19
+ *
+ * Diagnostic-only emulation: when firmware enables an OC instance
+ * (OCxCON.ON goes 0→1), the emulator emits a 12-byte binary event
+ * to an optional chardev ("oc-events") for GUI waveform rendering,
+ * and also writes a human-readable fallback to qemu_log().
+ *
+ * Event message format (16 bytes, little-endian):
+ *   [0]     index   — OC instance number (1–16)
+ *   [1]     enabled — 1 = enabled, 0 = disabled
+ *   [2]     ocm     — OCM mode bits [2:0]
+ *   [3]     flags   — bit0=OC32, bit1=OCTSEL
+ *   [4..7]  ocr     — OCxR  (primary compare), uint32 LE
+ *   [8..11] ocrs    — OCxRS (secondary compare), uint32 LE
+ *   [12..15] pr     — timer PRx period register, uint32 LE (0 on disable)
+ *
+ * Consumer duty/pulse-width formula by mode:
+ *   PWM (ocm=6,7):              pulse_pct = ocrs / pr * 100
+ *   Single/continuous (ocm=4,5): pulse_pct = (ocrs - ocr) / pr * 100
+ *
+ * Register layout within each 0x200-byte block
+ * (registers have SET/CLR/INV sub-regs at +4/+8/+C):
+ *   OCxCON  +0x00  Control: ON, SIDL, OC32, OCFLT, OCTSEL, OCM
+ *   OCxR    +0x10  Primary compare value
+ *   OCxRS   +0x20  Secondary compare value
+ *
+ * Copyright (c) 2026 QEMU contributors
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/core/sysbus.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/mips/pic32mk.h"
+#include "chardev/char.h"
+#include "system/address-spaces.h"
+
+/* OCM mode decode table (bits 2:0 of OCxCON) */
+static const char *ocm_mode_names[] = {
+    [0] = "Disabled",
+    [1] = "High on match, then low",
+    [2] = "Init low, force high",
+    [3] = "Toggle on match",
+    [4] = "Single pulse",
+    [5] = "Continuous pulses",
+    [6] = "PWM (no fault)",
+    [7] = "PWM (fault enabled)",
+};
+
+/*
+ * Timer PRx KSEG1 addresses for OCTSEL=0 (Timer2) and OCTSEL=1 (Timer3).
+ * OC1-OC9 use the peripheral-1 timer block (SFR base 0xBF820000).
+ * T2 base = 0xBF820200, PR2 = T2 base + 0x20 = 0xBF820220
+ * T3 base = 0xBF820400, PR3 = T3 base + 0x20 = 0xBF820420
+ * TODO: OC10-OC16 use peripheral-2 block timers (T4-T9) — extend table if needed.
+ */
+static const uint32_t oc_timer_pr_addr[2] = {
+    0x1F820220u,   /* OCTSEL=0 → Timer2 PRx (physical: SFR_BASE + T2_OFFSET + 0x20) */
+    0x1F820420u,   /* OCTSEL=1 → Timer3 PRx (physical: SFR_BASE + T3_OFFSET + 0x20) */
+};
+
+/*
+ * Device state
+ * -----------------------------------------------------------------------
+ */
+
+#define TYPE_PIC32MK_OC  "pic32mk-oc"
+OBJECT_DECLARE_SIMPLE_TYPE(PIC32MKOCState, PIC32MK_OC)
+
+struct PIC32MKOCState {
+    SysBusDevice parent_obj;
+    MemoryRegion mr;
+
+    uint32_t con;   /* OCxCON */
+    uint32_t r;     /* OCxR   */
+    uint32_t rs;    /* OCxRS  */
+
+    qemu_irq irq;
+    uint8_t  index;    /* 1-16 */
+    Chardev *chr_out;  /* optional chardev for waveform event streaming */
+};
+
+/*
+ * MMIO helpers
+ * -----------------------------------------------------------------------
+ */
+
+/* PIC32MK: base+0=REG, +4=CLR, +8=SET, +0xC=INV */
+static void apply_sci(uint32_t *reg, uint32_t val, int sub)
+{
+    switch (sub) {
+    case 0:
+        *reg  = val;
+        break;
+    case 4:
+        *reg &= ~val;
+        break;
+    case 8:
+        *reg |= val;
+        break;
+    case 12:
+        *reg ^= val;
+        break;
+    }
+}
+
+static uint32_t *oc_find_reg(PIC32MKOCState *s, hwaddr base)
+{
+    switch (base) {
+    case PIC32MK_OCxCON:
+        return &s->con;
+    case PIC32MK_OCxR:
+        return &s->r;
+    case PIC32MK_OCxRS:
+        return &s->rs;
+    default:
+        return NULL;
+    }
+}
+
+/*
+ * Timer PRx read — needed for duty-cycle in event messages
+ * -----------------------------------------------------------------------
+ */
+
+static uint32_t oc_read_pr(PIC32MKOCState *s)
+{
+    int sel = !!(s->con & PIC32MK_OCCON_OCTSEL);
+    MemTxResult res;
+    return address_space_ldl_le(&address_space_memory,
+                                oc_timer_pr_addr[sel],
+                                MEMTXATTRS_UNSPECIFIED, &res);
+}
+
+/*
+ * Event emission — qemu_log fallback + optional chardev binary stream
+ * -----------------------------------------------------------------------
+ */
+
+static void oc_emit_event(PIC32MKOCState *s, bool enabled)
+{
+    uint32_t ocm   = (s->con & PIC32MK_OCCON_OCM_MASK) >> PIC32MK_OCCON_OCM_SHIFT;
+    bool     oc32  = !!(s->con & PIC32MK_OCCON_OC32);
+    bool     octsel = !!(s->con & PIC32MK_OCCON_OCTSEL);
+
+    /* Human-readable fallback always goes to qemu_log */
+    if (enabled) {
+        qemu_log("pic32mk_oc: OC%u enabled — mode=%s, OC32=%u, OCTSEL=%u, "
+                 "OCxR=0x%08X, OCxRS=0x%08X\n",
+                 s->index, ocm_mode_names[ocm], oc32, octsel, s->r, s->rs);
+    } else {
+        qemu_log("pic32mk_oc: OC%u disabled\n", s->index);
+    }
+
+    if (!s->chr_out) {
+        return;
+    }
+
+    uint32_t pr = enabled ? oc_read_pr(s) : 0;
+
+    uint8_t  msg[16];
+    uint32_t ocr_le  = cpu_to_le32(s->r);
+    uint32_t ocrs_le = cpu_to_le32(s->rs);
+    uint32_t pr_le   = cpu_to_le32(pr);
+
+    msg[0] = s->index;
+    msg[1] = enabled ? 1 : 0;
+    msg[2] = (uint8_t)ocm;
+    msg[3] = (uint8_t)(oc32 | (octsel << 1));
+    memcpy(&msg[4],  &ocr_le,  4);
+    memcpy(&msg[8],  &ocrs_le, 4);
+    memcpy(&msg[12], &pr_le,   4);
+    qemu_chr_write_all(s->chr_out, msg, sizeof(msg));
+}
+
+/* Public setter called by pic32mk.c after device realisation. */
+void pic32mk_oc_set_chardev(DeviceState *dev, Chardev *chr)
+{
+    PIC32MK_OC(dev)->chr_out = chr;
+}
+
+/*
+ * MMIO read/write
+ * -----------------------------------------------------------------------
+ */
+
+static uint64_t oc_read(void *opaque, hwaddr addr, unsigned size)
+{
+    PIC32MKOCState *s = opaque;
+    hwaddr base = addr & ~(hwaddr)0xF;
+    uint32_t *reg = oc_find_reg(s, base);
+
+    if (reg) {
+        return *reg;
+    }
+
+    qemu_log_mask(LOG_UNIMP,
+                  "pic32mk_oc: OC%u unimplemented read @ 0x%04" HWADDR_PRIx "\n",
+                  s->index, addr);
+    return 0;
+}
+
+static void oc_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
+{
+    PIC32MKOCState *s = opaque;
+    int sub       = (int)(addr & 0xF);
+    hwaddr base   = addr & ~(hwaddr)0xF;
+    uint32_t *reg = oc_find_reg(s, base);
+
+    if (!reg) {
+        qemu_log_mask(LOG_UNIMP,
+                      "pic32mk_oc: OC%u unimplemented write @ 0x%04"
+                      HWADDR_PRIx " = 0x%08" PRIx64 "\n",
+                      s->index, addr, val);
+        return;
+    }
+
+    bool was_on = !!(s->con & PIC32MK_OCCON_ON);
+    apply_sci(reg, (uint32_t)val, sub);
+
+    /* Handle ON bit transitions for OCxCON writes */
+    if (base == PIC32MK_OCxCON) {
+        bool now_on = !!(s->con & PIC32MK_OCCON_ON);
+        if (!was_on && now_on) {
+            oc_emit_event(s, true);
+        } else if (was_on && !now_on) {
+            oc_emit_event(s, false);
+        }
+    }
+}
+
+static const MemoryRegionOps oc_ops = {
+    .read       = oc_read,
+    .write      = oc_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+/*
+ * Device lifecycle
+ * -----------------------------------------------------------------------
+ */
+
+static void pic32mk_oc_reset(DeviceState *dev)
+{
+    PIC32MKOCState *s = PIC32MK_OC(dev);
+    s->con = 0;
+    s->r   = 0;
+    s->rs  = 0;
+}
+
+static void pic32mk_oc_init(Object *obj)
+{
+    PIC32MKOCState *s = PIC32MK_OC(obj);
+
+    memory_region_init_io(&s->mr, obj, &oc_ops, s,
+                          TYPE_PIC32MK_OC, PIC32MK_OC_BLOCK_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mr);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
+}
+
+static Property pic32mk_oc_properties[] = {
+    DEFINE_PROP_UINT8("index", PIC32MKOCState, index, 1),
+};
+
+static void pic32mk_oc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    device_class_set_legacy_reset(dc, pic32mk_oc_reset);
+    device_class_set_props(dc, pic32mk_oc_properties);
+}
+
+static const TypeInfo pic32mk_oc_info = {
+    .name          = TYPE_PIC32MK_OC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(PIC32MKOCState),
+    .instance_init = pic32mk_oc_init,
+    .class_init    = pic32mk_oc_class_init,
+};
+
+static void pic32mk_oc_register_types(void)
+{
+    type_register_static(&pic32mk_oc_info);
+}
+
+type_init(pic32mk_oc_register_types)
diff --git a/hw/mips/pic32mk_spi.c b/hw/mips/pic32mk_spi.c
new file mode 100644
index 0000000000..339a790a58
--- /dev/null
+++ b/hw/mips/pic32mk_spi.c
@@ -0,0 +1,532 @@
+/*
+ * PIC32MK SPI × 6 (SPI1–SPI6)
+ * Datasheet: DS60001519E, §23
+ *
+ * Each SPI instance is a SysBusDevice providing a stub register file.
+ * Full transfer emulation (loopback, slave select, IRQs) is Phase 2B.
+ * Firmware doing register-level init (SPIxCON, SPIxBRG) will succeed;
+ * actual data transfers log LOG_UNIMP.
+ *
+ * Copyright (c) 2026 QEMU contributors
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/core/sysbus.h"
+#include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/qdev-properties-system.h"
+#include "chardev/char-fe.h"
+#include "hw/mips/pic32mk.h"
+
+#define TYPE_PIC32MK_SPI    "pic32mk-spi"
+OBJECT_DECLARE_SIMPLE_TYPE(PIC32MKSpiState, PIC32MK_SPI)
+
+struct PIC32MKSpiState {
+    SysBusDevice parent_obj;
+    MemoryRegion mr;
+
+    uint32_t con;   /* SPIxCON */
+    uint32_t stat;  /* SPIxSTAT */
+    uint32_t buf;   /* SPIxBUF — TX write / RX read */
+    uint32_t brg;   /* SPIxBRG */
+    uint32_t con2;  /* SPIxCON2 */
+
+    uint8_t index;  /* SPI instance index (1..6) */
+
+    uint8_t tx_fifo[8];
+    uint8_t rx_fifo[8];
+    uint8_t tx_head;
+    uint8_t tx_tail;
+    uint8_t tx_count;
+    uint8_t rx_head;
+    uint8_t rx_tail;
+    uint8_t rx_count;
+
+    uint8_t frame_buf[260];
+    uint16_t frame_pos;
+    uint16_t frame_len;
+
+    bool cs_active;
+
+    CharFrontend chr;
+
+    qemu_irq irq_rx;   /* RX interrupt */
+    qemu_irq irq_tx;   /* TX interrupt */
+    qemu_irq irq_err;  /* Fault/overflow */
+};
+
+/* CON bits (subset used by emulation + Harmony plib) */
+#define SPI_CON_ON             (1u << 15)
+#define SPI_CON_MSTEN          (1u << 5)
+#define SPI_CON_MODE16         (1u << 10)
+#define SPI_CON_MODE32         (1u << 11)
+#define SPI_CON_ENHBUF         (1u << 16)
+#define SPI_CON_SRXISEL_MASK   (3u << 0)
+#define SPI_CON_STXISEL_MASK   (3u << 2)
+#define SPI_CON_SRXISEL_SHIFT  0
+#define SPI_CON_STXISEL_SHIFT  2
+
+/* STAT bits (subset used by emulation + Harmony plib) */
+#define SPI_STAT_SPIRBF  (1u << 0)   /* RX buffer full */
+#define SPI_STAT_SPITBF  (1u << 1)   /* TX buffer full */
+#define SPI_STAT_SPITBE  (1u << 3)   /* TX buffer empty */
+#define SPI_STAT_SPIRBE  (1u << 5)   /* RX buffer empty */
+#define SPI_STAT_SPIROV  (1u << 6)   /* RX overflow */
+#define SPI_STAT_SRMT    (1u << 11)  /* Shift register empty */
+
+/* Chardev frame flags */
+#define SPI_FRAME_CS_ASSERT    (1u << 0)
+#define SPI_FRAME_CS_DEASSERT  (1u << 1)
+
+/* PIC32MK: base+0=REG, +4=CLR, +8=SET, +0xC=INV */
+static void apply_sci(uint32_t *reg, uint32_t val, int sub)
+{
+    switch (sub) {
+    case 0:
+        *reg  = val;
+        break;
+    case 4:
+        *reg &= ~val;
+        break;
+    case 8:
+        *reg |= val;
+        break;
+    case 12:
+        *reg ^= val;
+        break;
+    }
+}
+
+static int spi_fifo_depth(PIC32MKSpiState *s)
+{
+    return (s->con & SPI_CON_ENHBUF) ? 8 : 1;
+}
+
+static void spi_update_stat(PIC32MKSpiState *s)
+{
+    const int depth = spi_fifo_depth(s);
+
+    if (s->rx_count > 0) {
+        s->stat |= SPI_STAT_SPIRBF;
+        s->stat &= ~SPI_STAT_SPIRBE;
+    } else {
+        s->stat &= ~SPI_STAT_SPIRBF;
+        s->stat |= SPI_STAT_SPIRBE;
+    }
+
+    if (s->tx_count == 0) {
+        s->stat |= SPI_STAT_SPITBE;
+        s->stat &= ~SPI_STAT_SPITBF;
+    } else if (s->tx_count >= depth) {
+        s->stat |= SPI_STAT_SPITBF;
+        s->stat &= ~SPI_STAT_SPITBE;
+    } else {
+        s->stat &= ~SPI_STAT_SPITBF;
+        s->stat &= ~SPI_STAT_SPITBE;
+    }
+
+    if (s->tx_count == 0) {
+        s->stat |= SPI_STAT_SRMT;
+    } else {
+        s->stat &= ~SPI_STAT_SRMT;
+    }
+}
+
+static void spi_update_irq(PIC32MKSpiState *s)
+{
+    if (!(s->con & SPI_CON_ON)) {
+        qemu_set_irq(s->irq_rx, 0);
+        qemu_set_irq(s->irq_tx, 0);
+        qemu_set_irq(s->irq_err, 0);
+        return;
+    }
+
+    /* SRXISEL: 0=empty, 1=not-empty, 2=half-full, 3=full */
+    int srxisel = (s->con & SPI_CON_SRXISEL_MASK) >> SPI_CON_SRXISEL_SHIFT;
+    const int depth = spi_fifo_depth(s);
+    bool rx_pending;
+    switch (srxisel) {
+    case 0:
+        rx_pending = (s->rx_count == 0);
+        break;
+    case 1:
+        rx_pending = (s->rx_count > 0);
+        break;
+    case 2:
+        rx_pending = (s->rx_count >= depth / 2);
+        break;
+    case 3:
+        rx_pending = (s->rx_count >= depth);
+        break;
+    default:
+        rx_pending = false;
+        break;
+    }
+
+    /* STXISEL: 0=empty, 1=empty, 2=half-empty, 3=not-full */
+    int stxisel = (s->con & SPI_CON_STXISEL_MASK) >> SPI_CON_STXISEL_SHIFT;
+    bool tx_pending;
+    switch (stxisel) {
+    case 0:
+        tx_pending = (s->tx_count == 0);
+        break;
+    case 1:
+        tx_pending = (s->tx_count == 0);
+        break;
+    case 2:
+        tx_pending = (s->tx_count <= depth / 2);
+        break;
+    case 3:
+        tx_pending = (s->tx_count < depth);
+        break;
+    default:
+        tx_pending = false;
+        break;
+    }
+
+    bool err_pending = (s->stat & SPI_STAT_SPIROV) != 0;
+
+    qemu_set_irq(s->irq_rx, rx_pending ? 1 : 0);
+    qemu_set_irq(s->irq_tx, tx_pending ? 1 : 0);
+    qemu_set_irq(s->irq_err, err_pending ? 1 : 0);
+}
+
+static void spi_rx_push(PIC32MKSpiState *s, uint8_t val)
+{
+    const int depth = spi_fifo_depth(s);
+    if (s->rx_count >= depth) {
+        s->stat |= SPI_STAT_SPIROV;
+        spi_update_irq(s);
+        return;
+    }
+
+    s->rx_fifo[s->rx_head] = val;
+    s->rx_head = (uint8_t)((s->rx_head + 1) % depth);
+    s->rx_count++;
+}
+
+static bool spi_rx_pop(PIC32MKSpiState *s, uint8_t *val)
+{
+    const int depth = spi_fifo_depth(s);
+    if (s->rx_count == 0) {
+        *val = 0;
+        return false;
+    }
+
+    *val = s->rx_fifo[s->rx_tail];
+    s->rx_tail = (uint8_t)((s->rx_tail + 1) % depth);
+    s->rx_count--;
+    return true;
+}
+
+static void spi_tx_push(PIC32MKSpiState *s, uint8_t val)
+{
+    const int depth = spi_fifo_depth(s);
+    if (s->tx_count >= depth) {
+        return;
+    }
+
+    s->tx_fifo[s->tx_head] = val;
+    s->tx_head = (uint8_t)((s->tx_head + 1) % depth);
+    s->tx_count++;
+}
+
+static bool spi_tx_pop(PIC32MKSpiState *s, uint8_t *val)
+{
+    const int depth = spi_fifo_depth(s);
+    if (s->tx_count == 0) {
+        *val = 0xFFu;
+        return false;
+    }
+
+    *val = s->tx_fifo[s->tx_tail];
+    s->tx_tail = (uint8_t)((s->tx_tail + 1) % depth);
+    s->tx_count--;
+    return true;
+}
+
+static void spi_send_frame(PIC32MKSpiState *s, uint8_t flags,
+                           const uint8_t *payload, uint8_t len)
+{
+    uint8_t hdr[2];
+
+    if (!qemu_chr_fe_backend_connected(&s->chr)) {
+        return;
+    }
+
+    hdr[0] = flags;
+    hdr[1] = len;
+    qemu_chr_fe_write_all(&s->chr, hdr, 2);
+    if (len) {
+        qemu_chr_fe_write_all(&s->chr, payload, len);
+    }
+}
+
+static void spi_handle_frame(PIC32MKSpiState *s, uint8_t flags,
+                             const uint8_t *payload, uint8_t len)
+{
+    uint8_t response[255];
+    uint8_t i;
+
+    if (flags & SPI_FRAME_CS_ASSERT) {
+        s->cs_active = true;
+    }
+
+    for (i = 0; i < len; i++) {
+        spi_rx_push(s, payload[i]);
+        (void)spi_tx_pop(s, &response[i]);
+    }
+
+    if (len) {
+        spi_send_frame(s, 0, response, len);
+    }
+
+    if (flags & SPI_FRAME_CS_DEASSERT) {
+        s->cs_active = false;
+    }
+
+    spi_update_stat(s);
+    spi_update_irq(s);
+}
+
+static int spi_chr_can_receive(void *opaque)
+{
+    PIC32MKSpiState *s = opaque;
+    return qemu_chr_fe_backend_connected(&s->chr) ? 1 : 0;
+}
+
+static void spi_chr_receive(void *opaque, const uint8_t *buf, int size)
+{
+    PIC32MKSpiState *s = opaque;
+
+    for (int i = 0; i < size; i++) {
+        s->frame_buf[s->frame_pos++] = buf[i];
+        if (s->frame_pos == 2) {
+            s->frame_len = (uint16_t)s->frame_buf[1];
+        }
+        if (s->frame_pos >= 2 && s->frame_pos == (uint16_t)(2 + s->frame_len)) {
+            uint8_t flags = s->frame_buf[0];
+            uint8_t len = (uint8_t)s->frame_len;
+            spi_handle_frame(s, flags, &s->frame_buf[2], len);
+            s->frame_pos = 0;
+            s->frame_len = 0;
+        }
+    }
+}
+
+static void spi_chr_event(void *opaque, QEMUChrEvent event)
+{
+    PIC32MKSpiState *s = opaque;
+
+    if (event == CHR_EVENT_CLOSED) {
+        s->frame_pos = 0;
+        s->frame_len = 0;
+    }
+}
+
+static uint32_t *spi_find_reg(PIC32MKSpiState *s, hwaddr base)
+{
+    switch (base) {
+    case PIC32MK_SPIxCON:
+        return &s->con;
+    case PIC32MK_SPIxSTAT:
+        return &s->stat;
+    case PIC32MK_SPIxBRG:
+        return &s->brg;
+    case PIC32MK_SPIxCON2:
+        return &s->con2;
+    default:
+        return NULL;
+    }
+}
+
+static uint64_t spi_read(void *opaque, hwaddr addr, unsigned size)
+{
+    PIC32MKSpiState *s = opaque;
+    hwaddr base = addr & ~(hwaddr)0xF;
+
+    /* BUF read: pop from RX FIFO */
+    if (base == PIC32MK_SPIxBUF) {
+        uint32_t val = 0;
+        uint8_t b0 = 0;
+        uint8_t b1 = 0;
+        uint8_t b2 = 0;
+        uint8_t b3 = 0;
+
+        if (s->con & SPI_CON_MODE32) {
+            spi_rx_pop(s, &b0);
+            spi_rx_pop(s, &b1);
+            spi_rx_pop(s, &b2);
+            spi_rx_pop(s, &b3);
+            val = (uint32_t)b0 | ((uint32_t)b1 << 8) |
+                  ((uint32_t)b2 << 16) | ((uint32_t)b3 << 24);
+        } else if (s->con & SPI_CON_MODE16) {
+            spi_rx_pop(s, &b0);
+            spi_rx_pop(s, &b1);
+            val = (uint32_t)b0 | ((uint32_t)b1 << 8);
+        } else {
+            spi_rx_pop(s, &b0);
+            val = b0;
+        }
+
+        spi_update_stat(s);
+        spi_update_irq(s);
+        return val;
+    }
+
+    uint32_t *reg = spi_find_reg(s, base);
+    if (reg) {
+        if (base == PIC32MK_SPIxSTAT) {
+            spi_update_stat(s);
+            spi_update_irq(s);
+        }
+        return *reg;
+    }
+
+    qemu_log_mask(LOG_UNIMP,
+                  "pic32mk_spi: unimplemented read @ 0x%04" HWADDR_PRIx "\n",
+                  addr);
+    return 0;
+}
+
+static void spi_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
+{
+    PIC32MKSpiState *s = opaque;
+    int sub     = (int)(addr & 0xF);
+    hwaddr base = addr & ~(hwaddr)0xF;
+
+    /* BUF write: transmit */
+    if (base == PIC32MK_SPIxBUF) {
+        uint8_t bytes[4];
+        int count = 1;
+
+        bytes[0] = (uint8_t)val;
+        bytes[1] = (uint8_t)(val >> 8);
+        bytes[2] = (uint8_t)(val >> 16);
+        bytes[3] = (uint8_t)(val >> 24);
+
+        if (s->con & SPI_CON_MODE32) {
+            count = 4;
+        } else if (s->con & SPI_CON_MODE16) {
+            count = 2;
+        }
+
+        for (int i = 0; i < count; i++) {
+            spi_tx_push(s, bytes[i]);
+
+            if (s->con & SPI_CON_MSTEN) {
+                if (qemu_chr_fe_backend_connected(&s->chr)) {
+                    uint8_t flags = SPI_FRAME_CS_ASSERT | SPI_FRAME_CS_DEASSERT;
+                    spi_send_frame(s, flags, &bytes[i], 1);
+                } else {
+                    spi_rx_push(s, bytes[i]);
+                }
+                spi_tx_pop(s, &bytes[i]);
+            }
+        }
+
+        spi_update_stat(s);
+        spi_update_irq(s);
+        return;
+    }
+
+    uint32_t *reg = spi_find_reg(s, base);
+    if (reg) {
+        apply_sci(reg, (uint32_t)val, sub);
+        if (base == PIC32MK_SPIxCON && !(s->con & SPI_CON_ON)) {
+            s->tx_head = s->tx_tail = s->tx_count = 0;
+            s->rx_head = s->rx_tail = s->rx_count = 0;
+            s->stat = SPI_STAT_SPITBE | SPI_STAT_SPIRBE | SPI_STAT_SRMT;
+        }
+        spi_update_stat(s);
+        spi_update_irq(s);
+        return;
+    }
+
+    qemu_log_mask(LOG_UNIMP,
+                  "pic32mk_spi: unimplemented write @ 0x%04"
+                  HWADDR_PRIx " = 0x%08" PRIx64 "\n",
+                  addr, val);
+}
+
+static const MemoryRegionOps spi_ops = {
+    .read       = spi_read,
+    .write      = spi_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = { .min_access_size = 4, .max_access_size = 4 },
+};
+
+static void pic32mk_spi_reset(DeviceState *dev)
+{
+    PIC32MKSpiState *s = PIC32MK_SPI(dev);
+    s->con  = 0;
+    s->stat = SPI_STAT_SPITBE | SPI_STAT_SPIRBE | SPI_STAT_SRMT;
+    s->buf  = 0;
+    s->brg  = 0;
+    s->con2 = 0;
+    s->tx_head = s->tx_tail = s->tx_count = 0;
+    s->rx_head = s->rx_tail = s->rx_count = 0;
+    s->frame_pos = 0;
+    s->frame_len = 0;
+    s->cs_active = false;
+    qemu_irq_lower(s->irq_rx);
+    qemu_irq_lower(s->irq_tx);
+    qemu_irq_lower(s->irq_err);
+}
+
+static void pic32mk_spi_init(Object *obj)
+{
+    PIC32MKSpiState *s = PIC32MK_SPI(obj);
+
+    memory_region_init_io(&s->mr, obj, &spi_ops, s,
+                          TYPE_PIC32MK_SPI, PIC32MK_SPI_BLOCK_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mr);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq_rx);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq_tx);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq_err);
+}
+
+static void pic32mk_spi_realize(DeviceState *dev, Error **errp)
+{
+    PIC32MKSpiState *s = PIC32MK_SPI(dev);
+
+    qemu_chr_fe_set_handlers(&s->chr,
+                             spi_chr_can_receive,
+                             spi_chr_receive,
+                             spi_chr_event,
+                             NULL,
+                             s,
+                             NULL,
+                             true);
+}
+
+static const Property pic32mk_spi_props[] = {
+    DEFINE_PROP_UINT8("spi-index", PIC32MKSpiState, index, 0),
+    DEFINE_PROP_CHR("chardev", PIC32MKSpiState, chr),
+};
+
+static void pic32mk_spi_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    device_class_set_legacy_reset(dc, pic32mk_spi_reset);
+    device_class_set_props(dc, pic32mk_spi_props);
+    dc->realize = pic32mk_spi_realize;
+}
+
+static const TypeInfo pic32mk_spi_info = {
+    .name          = TYPE_PIC32MK_SPI,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(PIC32MKSpiState),
+    .instance_init = pic32mk_spi_init,
+    .class_init    = pic32mk_spi_class_init,
+};
+
+static void pic32mk_spi_register_types(void)
+{
+    type_register_static(&pic32mk_spi_info);
+}
+
+type_init(pic32mk_spi_register_types)
diff --git a/hw/mips/pic32mk_timer.c b/hw/mips/pic32mk_timer.c
new file mode 100644
index 0000000000..d53d647d33
--- /dev/null
+++ b/hw/mips/pic32mk_timer.c
@@ -0,0 +1,294 @@
+/*
+ * PIC32MK General Purpose Timers × 9 (T1–T9)
+ * Datasheet: DS60001519E, §14
+ *
+ * Timer types:
+ *   Type A: Timer 1 only — 16-bit, asynchronous clock option
+ *   Type B: Timer 2, 4, 6, 8 — 16-bit, 32-bit pairable with Type C
+ *   Type C: Timer 3, 5, 7, 9 — 16-bit, pairs with preceding Type B
+ *
+ * Each timer instance is a SysBusDevice with:
+ *   - One MMIO region (PIC32MK_TIMER_BLOCK_SIZE bytes)
+ *   - QEMU ptimer for timing
+ *   - One IRQ output (connected to EVIC input)
+ *
+ * Register layout within each 0x200-byte block
+ * (registers have SET/CLR/INV sub-regs at +4/+8/+C):
+ *   TxCON  +0x00  Control: ON, TCKPS, T32(Type B only), TCS
+ *   TMRx   +0x10  Current count value (16 or 32-bit)
+ *   PRx    +0x20  Period register — fires IRQ when TMR == PR
+ *
+ * Copyright (c) 2026 QEMU contributors
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/core/sysbus.h"
+#include "hw/core/irq.h"
+#include "hw/core/ptimer.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/mips/pic32mk.h"
+
+/*
+ * Prescaler lookup tables:
+ * Type A (Timer1): 2-bit TCKPS at bits[5:4], values 0..3 → {1,8,64,256}
+ * Type B/C:        3-bit TCKPS at bits[6:4], values 0..7 → {1,2,4,8,16,32,64,256}
+ */
+static const uint32_t timer_prescalers_a[4] = { 1, 8, 64, 256 };
+static const uint32_t timer_prescalers_bc[8] = { 1, 2, 4, 8, 16, 32, 64, 256 };
+
+/*
+ * Device state
+ * -----------------------------------------------------------------------
+ */
+
+#define TYPE_PIC32MK_TIMER  "pic32mk-timer"
+OBJECT_DECLARE_SIMPLE_TYPE(PIC32MKTimerState, PIC32MK_TIMER)
+
+struct PIC32MKTimerState {
+    SysBusDevice parent_obj;
+    MemoryRegion mr;
+
+    uint32_t con;   /* TxCON */
+    uint32_t tmr;   /* TMRx  */
+    uint32_t pr;    /* PRx   — period (0xFFFF on reset for 16-bit) */
+
+    ptimer_state *ptimer;
+    qemu_irq irq;
+    bool type_a;    /* true = Timer1 (Type A, 2-bit TCKPS {1,8,64,256}) */
+};
+
+/*
+ * ptimer callback — fires when TMRx wraps (hits PRx)
+ * -----------------------------------------------------------------------
+ */
+
+static void pic32mk_timer_expired(void *opaque)
+{
+    PIC32MKTimerState *s = opaque;
+
+    /*
+     * The ptimer already reloaded with the period; just assert the IRQ.
+     * The EVIC input is level-sensitive: a pulse is sufficient because
+     * the EVIC latches IFSx on the rising edge.
+      */
+    qemu_irq_pulse(s->irq);
+}
+
+/*
+ * Start/stop/reload helpers
+ * -----------------------------------------------------------------------
+ */
+
+static void timer_reload(PIC32MKTimerState *s)
+{
+    uint32_t prescale_idx = (s->con & PIC32MK_TCON_TCKPS_MASK)
+                            >> PIC32MK_TCON_TCKPS_SHIFT;
+    uint32_t prescale = s->type_a
+        ? timer_prescalers_a[prescale_idx & 3]
+        : timer_prescalers_bc[prescale_idx & 7];
+    uint32_t period       = (s->pr == 0) ? 0xFFFFu : s->pr;
+
+    ptimer_transaction_begin(s->ptimer);
+    ptimer_set_freq(s->ptimer, PIC32MK_CPU_HZ / prescale);
+    ptimer_set_limit(s->ptimer, period, 1);
+    ptimer_run(s->ptimer, 0);   /* 0 = periodic */
+    ptimer_transaction_commit(s->ptimer);
+}
+
+static void timer_stop(PIC32MKTimerState *s)
+{
+    ptimer_transaction_begin(s->ptimer);
+    ptimer_stop(s->ptimer);
+    ptimer_transaction_commit(s->ptimer);
+}
+
+/*
+ * MMIO helpers
+ * -----------------------------------------------------------------------
+ */
+
+/* PIC32MK: base+0=REG, +4=CLR, +8=SET, +0xC=INV */
+static void apply_sci(uint32_t *reg, uint32_t val, int sub)
+{
+    switch (sub) {
+    case 0:
+        *reg  = val;
+        break;
+    case 4:
+        *reg &= ~val;
+        break;
+    case 8:
+        *reg |= val;
+        break;
+    case 12:
+        *reg ^= val;
+        break;
+    }
+}
+
+static uint32_t *timer_find_reg(PIC32MKTimerState *s, hwaddr base)
+{
+    switch (base) {
+    case PIC32MK_TxCON:
+        return &s->con;
+    case PIC32MK_TMRx:
+        return &s->tmr;
+    case PIC32MK_PRx:
+        return &s->pr;
+    default:
+        return NULL;
+    }
+}
+
+/*
+ * MMIO read/write
+ * -----------------------------------------------------------------------
+ */
+
+static uint64_t timer_read(void *opaque, hwaddr addr, unsigned size)
+{
+    PIC32MKTimerState *s = opaque;
+    hwaddr base = addr & ~(hwaddr)0xF;
+
+    /* TMRx: return ptimer current count when timer is running */
+    if (base == PIC32MK_TMRx) {
+        if (s->con & PIC32MK_TCON_ON) {
+            return (uint32_t)ptimer_get_count(s->ptimer);
+        }
+        return s->tmr;
+    }
+
+    uint32_t *reg = timer_find_reg(s, base);
+    if (reg) {
+        return *reg;
+    }
+
+    qemu_log_mask(LOG_UNIMP,
+                  "pic32mk_timer: unimplemented read @ 0x%04" HWADDR_PRIx "\n",
+                  addr);
+    return 0;
+}
+
+static void timer_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
+{
+    PIC32MKTimerState *s = opaque;
+    int sub       = (int)(addr & 0xF);
+    hwaddr base   = addr & ~(hwaddr)0xF;
+    uint32_t *reg = timer_find_reg(s, base);
+
+    if (!reg) {
+        qemu_log_mask(LOG_UNIMP,
+                      "pic32mk_timer: unimplemented write @ 0x%04"
+                      HWADDR_PRIx " = 0x%08" PRIx64 "\n",
+                      addr, val);
+        return;
+    }
+
+    bool was_on = !!(s->con & PIC32MK_TCON_ON);
+    apply_sci(reg, (uint32_t)val, sub);
+
+    /* TMRx write: update count when timer is stopped */
+    if (base == PIC32MK_TMRx) {
+        if (!was_on) {
+            ptimer_transaction_begin(s->ptimer);
+            ptimer_set_count(s->ptimer, s->tmr);
+            ptimer_transaction_commit(s->ptimer);
+        }
+        return;
+    }
+
+    /* TxCON write: handle ON bit transitions */
+    if (base == PIC32MK_TxCON) {
+        bool now_on = !!(s->con & PIC32MK_TCON_ON);
+        if (!was_on && now_on) {
+            timer_reload(s);
+        } else if (was_on && !now_on) {
+            timer_stop(s);
+            /* Save current count */
+            s->tmr = (uint32_t)ptimer_get_count(s->ptimer);
+        } else if (now_on) {
+            /* Prescaler may have changed; reload */
+            timer_reload(s);
+        }
+    }
+
+    /* PRx write: update period on the fly */
+    if (base == PIC32MK_PRx && (s->con & PIC32MK_TCON_ON)) {
+        timer_reload(s);
+    }
+}
+
+static const MemoryRegionOps timer_ops = {
+    .read       = timer_read,
+    .write      = timer_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+/*
+ * Device lifecycle
+ * -----------------------------------------------------------------------
+ */
+
+static void pic32mk_timer_reset(DeviceState *dev)
+{
+    PIC32MKTimerState *s = PIC32MK_TIMER(dev);
+
+    timer_stop(s);
+    s->con = 0;
+    s->tmr = 0;
+    s->pr  = 0xFFFF;   /* 16-bit period register reset value */
+    qemu_irq_lower(s->irq);
+}
+
+static void pic32mk_timer_init(Object *obj)
+{
+    PIC32MKTimerState *s = PIC32MK_TIMER(obj);
+
+    memory_region_init_io(&s->mr, obj, &timer_ops, s,
+                          TYPE_PIC32MK_TIMER, PIC32MK_TIMER_BLOCK_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mr);
+
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
+
+    s->ptimer = ptimer_init(pic32mk_timer_expired, s, PTIMER_POLICY_NO_IMMEDIATE_TRIGGER);
+}
+
+static void pic32mk_timer_finalize(Object *obj)
+{
+    PIC32MKTimerState *s = PIC32MK_TIMER(obj);
+    ptimer_free(s->ptimer);
+}
+
+static Property pic32mk_timer_properties[] = {
+    DEFINE_PROP_BOOL("type-a", PIC32MKTimerState, type_a, false),
+};
+
+static void pic32mk_timer_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    device_class_set_legacy_reset(dc, pic32mk_timer_reset);
+    device_class_set_props(dc, pic32mk_timer_properties);
+}
+
+static const TypeInfo pic32mk_timer_info = {
+    .name          = TYPE_PIC32MK_TIMER,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(PIC32MKTimerState),
+    .instance_init = pic32mk_timer_init,
+    .instance_finalize = pic32mk_timer_finalize,
+    .class_init    = pic32mk_timer_class_init,
+};
+
+static void pic32mk_timer_register_types(void)
+{
+    type_register_static(&pic32mk_timer_info);
+}
+
+type_init(pic32mk_timer_register_types)
diff --git a/hw/mips/pic32mk_uart.c b/hw/mips/pic32mk_uart.c
new file mode 100644
index 0000000000..e2e83a2b7e
--- /dev/null
+++ b/hw/mips/pic32mk_uart.c
@@ -0,0 +1,334 @@
+/*
+ * PIC32MK UART × 6 (U1–U6)
+ * Datasheet: DS60001519E, §21 (pp. 475–552)
+ *
+ * Each UART instance is a SysBusDevice with:
+ *   - One MMIO region (PIC32MK_UART_BLOCK_SIZE bytes)
+ *   - CharFrontend for TX/RX via QEMU backend (-serial stdio, etc.)
+ *   - Three IRQ outputs: index 0 = RX, 1 = TX, 2 = Error
+ *
+ * Register layout (all 4-byte registers with SET/CLR/INV at +4/+8/+C):
+ *   UxMODE  +0x00  Mode (UARTEN/ON bits, parity, stop bits)
+ *   UxSTA   +0x10  Status + TX/RX interrupt select
+ *   UxTXREG +0x20  TX data (write-only)
+ *   UxRXREG +0x30  RX data (read-only)
+ *   UxBRG   +0x40  Baud rate generator
+ *
+ * Copyright (c) 2026 QEMU contributors
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/core/sysbus.h"
+#include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/qdev-properties-system.h"
+#include "chardev/char-fe.h"
+#include "hw/mips/pic32mk.h"
+
+/*
+ * Device state
+ * -----------------------------------------------------------------------
+ */
+
+#define TYPE_PIC32MK_UART   "pic32mk-uart"
+OBJECT_DECLARE_SIMPLE_TYPE(PIC32MKUartState, PIC32MK_UART)
+
+struct PIC32MKUartState {
+    SysBusDevice parent_obj;
+    MemoryRegion mr;
+
+    /* Registers (base values; SET/CLR/INV are decoded in the write handler) */
+    uint32_t mode;  /* UxMODE */
+    uint32_t sta;   /* UxSTA  */
+    uint32_t brg;   /* UxBRG  */
+
+    /* RX single-byte buffer */
+    uint8_t  rxbuf;
+    bool     rxbuf_full;
+
+    CharFrontend chr;
+
+    /* IRQ outputs: 0=RX, 1=TX, 2=Error */
+    qemu_irq irq_rx;
+    qemu_irq irq_tx;
+    qemu_irq irq_err;
+};
+
+/*
+ * UxSTA status helpers
+ * -----------------------------------------------------------------------
+ */
+
+static void uart_update_sta(PIC32MKUartState *s)
+{
+    /* TRMT (bit 8): TX shift register empty — always 1 (we forward immediately) */
+    s->sta |= PIC32MK_USTA_TRMT;
+    /* UTXBF (bit 9): TX buffer full — always 0 */
+    s->sta &= ~PIC32MK_USTA_UTXBF;
+
+    /* URXDA (bit 0): RX data available */
+    if (s->rxbuf_full) {
+        s->sta |= PIC32MK_USTA_URXDA;
+    } else {
+        s->sta &= ~PIC32MK_USTA_URXDA;
+    }
+}
+
+static void uart_update_irq(PIC32MKUartState *s)
+{
+    /* RX IRQ: assert while URXDA=1 and URXEN is set */
+    bool rx_pending = s->rxbuf_full && (s->sta & PIC32MK_USTA_URXEN);
+    qemu_set_irq(s->irq_rx, rx_pending ? 1 : 0);
+
+    /*
+     * TX IRQ: level-based.  In QEMU the TX path is instantaneous — chars
+     * go out immediately via qemu_chr_fe_write_all(), so TRMT=1 and
+     * UTXBF=0 at all times.  Regardless of UTXISEL[1:0], the TX
+     * interrupt condition is always met whenever ON=1 and UTXEN=1.
+     *
+     * The EVIC tracks source levels (irq_level[]) and re-asserts IFS
+     * bits after firmware clears them, so keeping irq_tx asserted at
+     * level=1 causes the IFS flag to be re-set immediately after clear
+     * — matching real Microchip behavior.  The ISR must disable IEC
+     * (the enable bit) to stop re-entry, which is exactly what the
+     * Microchip plib does.
+     */
+    bool tx_active = (s->mode & PIC32MK_UMODE_ON) &&
+                     (s->sta & PIC32MK_USTA_UTXEN);
+    qemu_set_irq(s->irq_tx, tx_active ? 1 : 0);
+}
+
+/*
+ * CharFrontend callbacks (RX path)
+ * -----------------------------------------------------------------------
+ */
+
+static int uart_can_receive(void *opaque)
+{
+    PIC32MKUartState *s = opaque;
+    return s->rxbuf_full ? 0 : 1;
+}
+
+static void uart_receive(void *opaque, const uint8_t *buf, int size)
+{
+    PIC32MKUartState *s = opaque;
+
+    if (size == 0) {
+        return;
+    }
+
+    if (s->rxbuf_full) {
+        /* Overrun: set OERR bit */
+        s->sta |= PIC32MK_USTA_OERR;
+        qemu_set_irq(s->irq_err, 1);
+        return;
+    }
+
+    s->rxbuf      = buf[0];
+    s->rxbuf_full = true;
+    uart_update_sta(s);
+    uart_update_irq(s);
+}
+
+/*
+ * MMIO helpers
+ * -----------------------------------------------------------------------
+ */
+
+/* Apply SET/CLR/INV operation based on sub-register offset */
+/* PIC32MK: base+0=REG, +4=CLR, +8=SET, +0xC=INV */
+static void apply_sci(uint32_t *reg, uint32_t val, int sub)
+{
+    switch (sub) {
+    case 0:
+        *reg  = val;
+        break;
+    case 4:
+        *reg &= ~val;
+        break;
+    case 8:
+        *reg |= val;
+        break;
+    case 12:
+        *reg ^= val;
+        break;
+    }
+}
+
+/* Map UART register base address to state field */
+static uint32_t *uart_find_reg(PIC32MKUartState *s, hwaddr base)
+{
+    switch (base) {
+    case PIC32MK_UxMODE:
+        return &s->mode;
+    case PIC32MK_UxSTA:
+        return &s->sta;
+    case PIC32MK_UxBRG:
+        return &s->brg;
+    default:
+        return NULL;
+    }
+}
+
+/*
+ * MMIO read/write
+ * -----------------------------------------------------------------------
+ */
+
+static uint64_t uart_read(void *opaque, hwaddr addr, unsigned size)
+{
+    PIC32MKUartState *s = opaque;
+
+    uart_update_sta(s);
+
+    /* RX register is special: reading consumes the byte */
+    if ((addr & ~(hwaddr)0xF) == PIC32MK_UxRXREG) {
+        if (s->rxbuf_full) {
+            uint32_t val  = s->rxbuf;
+            s->rxbuf_full = false;
+            uart_update_sta(s);
+            uart_update_irq(s);
+            qemu_chr_fe_accept_input(&s->chr);
+            return val;
+        }
+        return 0;
+    }
+
+    /* TX register is write-only */
+    if ((addr & ~(hwaddr)0xF) == PIC32MK_UxTXREG) {
+        return 0;
+    }
+
+    hwaddr base   = addr & ~(hwaddr)0xF;
+    uint32_t *reg = uart_find_reg(s, base);
+    if (reg) {
+        return *reg;
+    }
+
+    qemu_log_mask(LOG_UNIMP,
+                  "pic32mk_uart: unimplemented read @ 0x%04" HWADDR_PRIx "\n",
+                  addr);
+    return 0;
+}
+
+static void uart_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
+{
+    PIC32MKUartState *s = opaque;
+
+    /* TX register: writing transmits a byte */
+    if ((addr & ~(hwaddr)0xF) == PIC32MK_UxTXREG) {
+        uint8_t ch = (uint8_t)(val & 0xFF);
+        qemu_chr_fe_write_all(&s->chr, &ch, 1);
+        return;
+    }
+
+    int sub       = (int)(addr & 0xF);
+    hwaddr base   = addr & ~(hwaddr)0xF;
+    uint32_t *reg = uart_find_reg(s, base);
+
+    if (!reg) {
+        qemu_log_mask(LOG_UNIMP,
+                      "pic32mk_uart: unimplemented write @ 0x%04"
+                      HWADDR_PRIx " = 0x%08" PRIx64 "\n",
+                      addr, val);
+        return;
+    }
+
+    apply_sci(reg, (uint32_t)val, sub);
+
+    /* Keep status bits consistent after firmware writes to STA */
+    if (base == PIC32MK_UxSTA) {
+        /* Firmware clears OERR by writing 0 to that bit */
+        if (!(s->sta & PIC32MK_USTA_OERR)) {
+            qemu_set_irq(s->irq_err, 0);
+        }
+        uart_update_irq(s);
+    }
+    if (base == PIC32MK_UxMODE) {
+        uart_update_irq(s);
+    }
+}
+
+static const MemoryRegionOps uart_ops = {
+    .read       = uart_read,
+    .write      = uart_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+/*
+ * Device lifecycle
+ * -----------------------------------------------------------------------
+ */
+
+static void pic32mk_uart_reset(DeviceState *dev)
+{
+    PIC32MKUartState *s = PIC32MK_UART(dev);
+
+    s->mode       = 0;
+    /* Reset STA: TRMT=1, TX buffer not full */
+    s->sta        = PIC32MK_USTA_TRMT;
+    s->brg        = 0;
+    s->rxbuf_full = false;
+    s->rxbuf      = 0;
+
+    qemu_set_irq(s->irq_rx,  0);
+    qemu_set_irq(s->irq_tx,  0);
+    qemu_set_irq(s->irq_err, 0);
+}
+
+static void pic32mk_uart_realize(DeviceState *dev, Error **errp)
+{
+    PIC32MKUartState *s = PIC32MK_UART(dev);
+
+    qemu_chr_fe_set_handlers(&s->chr,
+                             uart_can_receive, uart_receive,
+                             NULL, NULL,
+                             s, NULL, true);
+}
+
+static void pic32mk_uart_init(Object *obj)
+{
+    PIC32MKUartState *s = PIC32MK_UART(obj);
+
+    memory_region_init_io(&s->mr, obj, &uart_ops, s,
+                          TYPE_PIC32MK_UART, PIC32MK_UART_BLOCK_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mr);
+
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq_rx);   /* index 0 */
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq_tx);   /* index 1 */
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq_err);  /* index 2 */
+}
+
+static const Property pic32mk_uart_props[] = {
+    DEFINE_PROP_CHR("chardev", PIC32MKUartState, chr),
+};
+
+static void pic32mk_uart_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    device_class_set_legacy_reset(dc, pic32mk_uart_reset);
+    device_class_set_props(dc, pic32mk_uart_props);
+    dc->realize = pic32mk_uart_realize;
+}
+
+static const TypeInfo pic32mk_uart_info = {
+    .name          = TYPE_PIC32MK_UART,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(PIC32MKUartState),
+    .instance_init = pic32mk_uart_init,
+    .class_init    = pic32mk_uart_class_init,
+};
+
+static void pic32mk_uart_register_types(void)
+{
+    type_register_static(&pic32mk_uart_info);
+}
+
+type_init(pic32mk_uart_register_types)
diff --git a/hw/mips/pic32mk_usb.c b/hw/mips/pic32mk_usb.c
new file mode 100644
index 0000000000..24a877fbeb
--- /dev/null
+++ b/hw/mips/pic32mk_usb.c
@@ -0,0 +1,1033 @@
+/*
+ * Microchip PIC32MK USB OTG Full-Speed controller emulation
+ * Datasheet: DS60001519E §25
+ * Register addresses verified against p32mk1024mcm100.h (XC32 v4.60 pack).
+ *
+ * Phase 4A — register-file stub (complete)
+ * Phase 4B — USB enumeration simulation + CDC TX chardev output:
+ *   • QEMUTimer drives the EP0 state machine (USB Reset → enumerate)
+ *   • SETUP packet injection via BDT write + TRNIF interrupt
+ *   • CDC TX polling: EP1-IN BDT entry harvested → chardev write
+ *   • chardev property "chardev" exposes CDC output as host PTY/socket
+ *
+ * BDT layout (PIC32MK device mode, ping-pong off / PPBRST):
+ *   Each endpoint has 4 BDT entries (RX-even, RX-odd, TX-even, TX-odd).
+ *   Entry size = 8 bytes (4-byte ctrl word + 4-byte buffer address).
+ *   EP0-OUT-even = offset 0x00, EP0-IN-even = offset 0x10,
+ *   EP1-OUT-even = offset 0x20, EP1-IN-even = offset 0x30.
+ *
+ * Copyright (c) 2026 QEMU contributors
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/timer.h"
+#include "qapi/error.h"
+#include "hw/core/sysbus.h"
+#include "hw/core/irq.h"
+#include "hw/mips/pic32mk.h"
+#include "hw/mips/pic32mk_usb.h"
+#include "exec/cpu-common.h"   /* cpu_physical_memory_read/write */
+#include "chardev/char-fe.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/qdev-properties-system.h"
+
+/*
+ * Helpers
+ * -----------------------------------------------------------------------
+ */
+
+/*
+ * Apply SET / CLR / INV operation.
+ * sub = addr & 0xF: 0 → write, 4 → CLR, 8 → SET, C → INV
+ */
+static void apply_sci(uint32_t *reg, uint32_t val, int sub)
+{
+    switch (sub) {
+    case 0x0:
+        *reg  = val;
+        break;
+    case 0x4:
+        *reg &= ~val;
+        break;
+    case 0x8:
+        *reg |= val;
+        break;
+    case 0xC:
+        *reg ^= val;
+        break;
+    }
+}
+
+/*
+ * Apply write-1-clear (W1C) operation.
+ */
+static void apply_w1c(uint32_t *reg, uint32_t val, int sub)
+{
+    if (sub == 0x0 || sub == 0x4) {
+        *reg &= ~val;
+    }
+}
+
+static void usb_update_irq(PIC32MKUSBState *s)
+{
+    /*
+     * SESSION_VALID (OTGIR bit 3 / SESVDIF):
+     *
+     * On real PIC32MK hardware, SESVDIF is edge-triggered: it fires once when
+     * SESVD transitions.  To prevent an infinite ISR loop (the Harmony ISR
+     * clears SESVDIF but VBUS stays valid), we use an edge-latch flag:
+     * sesvd_edge_latched is set when SESVDIF is first asserted, and cleared
+     * when firmware W1C-clears SESVDIF from OTGIR.  We only include SESVDIF
+     * in the IRQ level calculation while the edge latch is active.
+     */
+    uint32_t otg_pending = s->otgir & s->otgie;
+    if (!s->sesvd_edge_latched) {
+        otg_pending &= ~USB_OTG_IR_SESSION_VALID;
+    }
+
+    bool fire = ((s->uir  & s->uie)  != 0)
+             || ((s->ueir & s->ueie) != 0)
+             || (otg_pending != 0);
+    qemu_set_irq(s->irq, fire ? 1 : 0);
+}
+
+/*
+ * USTAT FIFO helpers (PIC32MK has a 4-deep hardware FIFO)
+ *
+ * On real hardware, each completed transaction pushes an USTAT value onto
+ * the FIFO and asserts TRNIF.  When firmware W1C-clears TRNIF, the FIFO
+ * pops; if more entries remain, TRNIF is re-asserted immediately.
+ * Without this FIFO, two transactions completing in quick succession
+ * (e.g. chardev RX + timer TX poll) overwrite the single USTAT register,
+ * causing the firmware to miss one transaction entirely — the root cause
+ * of the write stall.
+ * -----------------------------------------------------------------------
+ */
+
+static void usb_stat_fifo_push(PIC32MKUSBState *s, uint32_t stat_val)
+{
+    if (s->stat_fifo_count >= 4) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "pic32mk_usb: USTAT FIFO overflow (dropped 0x%02x)\n",
+                      stat_val);
+        return;
+    }
+    s->stat_fifo[s->stat_fifo_head] = stat_val;
+    s->stat_fifo_head = (s->stat_fifo_head + 1) & 3;
+    s->stat_fifo_count++;
+    /* Expose the front of the FIFO via the USTAT register */
+    s->ustat = s->stat_fifo[s->stat_fifo_tail];
+    s->uir |= USB_IR_TRNIF;
+}
+
+/*
+ * Pop the front entry.  Called when firmware W1C-clears TRNIF.
+ * If more entries remain, re-assert TRNIF with the next USTAT value.
+ */
+static void usb_stat_fifo_pop(PIC32MKUSBState *s)
+{
+    if (s->stat_fifo_count == 0) {
+        return;
+    }
+    s->stat_fifo_tail = (s->stat_fifo_tail + 1) & 3;
+    s->stat_fifo_count--;
+    if (s->stat_fifo_count > 0) {
+        s->ustat = s->stat_fifo[s->stat_fifo_tail];
+        s->uir |= USB_IR_TRNIF;
+    }
+}
+
+/*
+ * BDT helpers
+ * -----------------------------------------------------------------------
+ */
+
+static hwaddr usb_bdt_phys(PIC32MKUSBState *s)
+{
+    /*
+     * BDT base = (BDTP3[7:0] << 24) | (BDTP2[7:0] << 16) | (BDTP1[7:1] << 8)
+     * BDTP1 bits [7:1] map to BDT address bits [15:9].
+      */
+    return ((hwaddr)(s->bdtp3 & 0xFFu) << 24)
+         | ((hwaddr)(s->bdtp2 & 0xFFu) << 16)
+         | ((hwaddr)(s->bdtp1 & 0xFEu) << 8);
+}
+
+/*
+ * Inject an 8-byte SETUP packet into the EP0-OUT-even BDT buffer.
+ * The BDT entry at offset 0x00 from BDT base must be UOWN=1 (firmware armed).
+ * On success: writes the SETUP data to the buffer, clears UOWN, sets
+ * TOK_PID=SETUP (0xD) in byte[0] bits[5:2]=0x34, bc=8 in shortWord[1]
+ * (bits[31:16]), sets ustat=EP0/OUT/EVEN, fires TRNIF.
+ *
+ * BDT 32-bit control word layout (Harmony DRV_USBFS_BDT_ENTRY union):
+ *   bits[ 7: 0] = byte[0]:  UOWN(7), DATA01(6), DTSEN(4), BSTALL(2), TOK_PID[5:2]
+ *   bits[15: 8] = byte[1]:  (reserved / padding)
+ *   bits[31:16] = shortWord[1]: byte count (BC)
+ *   word[1]                  = buffer physical address
+ *
+ * Harmony TRNIF switch uses (byte[0] & 0x3C):
+ *   0x34 → SETUP (TOK_PID=0xD)
+ *   0x04 → OUT   (TOK_PID=0x1)
+ *   0x24 → IN    (TOK_PID=0x9)
+ */
+static bool usb_inject_setup(PIC32MKUSBState *s, const uint8_t setup[8])
+{
+    hwaddr bdt = usb_bdt_phys(s);
+    if (!bdt) {
+        return false;
+    }
+
+    /* Check both ping-pong entries for EP0-OUT (even=BDT+0, odd=BDT+8). */
+    for (int ppbi = 0; ppbi < 2; ppbi++) {
+        hwaddr out_entry = bdt + (ppbi ? 8u : 0u);
+        uint8_t entry[8];
+        cpu_physical_memory_read(out_entry, entry, 8);
+
+        uint32_t ctrl = le32_to_cpu(*(uint32_t *)entry);
+        uint32_t addr = le32_to_cpu(*(uint32_t *)(entry + 4));
+
+        if (!(ctrl & BDT_UOWN) || !addr) {
+            continue;   /* not armed — try other ping-pong */
+        }
+
+        /* Write SETUP packet into the EP0-OUT buffer */
+        cpu_physical_memory_write(addr, setup, 8);
+
+        /*
+         * Return BDT entry to firmware:
+         *   byte[0] = 0x34: TOK_PID=SETUP(0xD) in bits[5:2], UOWN=0
+         *   shortWord[1] = 8: byte count
+         */
+        ctrl = 0x00000034u | (8u << 16);
+        *(uint32_t *)entry = cpu_to_le32(ctrl);
+        cpu_physical_memory_write(out_entry, entry, 8);
+
+        /* UxSTAT: EP=0, DIR=OUT(0), PPBI=ppbi */
+        usb_stat_fifo_push(s, (uint32_t)(ppbi ? 0x04u : 0x00u));
+        usb_update_irq(s);
+        return true;
+    }
+    return false;   /* neither entry armed yet */
+}
+
+/*
+ * Accept an EP0-IN response from the firmware: read the data the firmware
+ * placed in EP0-IN-even (BDT offset 0x10), set TOK_PID=IN in byte[0],
+ * clear UOWN, preserve bc in shortWord[1], fire TRNIF.
+ * Returns true if an IN entry was accepted, false if not armed yet.
+ */
+static bool usb_accept_ep0_in(PIC32MKUSBState *s)
+{
+    hwaddr bdt = usb_bdt_phys(s);
+    if (!bdt) {
+        return false;
+    }
+
+    /* Check both ping-pong entries for EP0-IN (even=BDT+0x10, odd=BDT+0x18). */
+    for (int ppbi = 0; ppbi < 2; ppbi++) {
+        hwaddr in_entry = bdt + 0x10u + (ppbi ? 8u : 0u);
+        uint8_t entry[8];
+        cpu_physical_memory_read(in_entry, entry, 8);
+
+        uint32_t ctrl = le32_to_cpu(*(uint32_t *)entry);
+        if (!(ctrl & BDT_UOWN)) {
+            continue;   /* not armed */
+        }
+
+        /*
+         * Return BDT entry to firmware:
+         *   byte[0] = 0x24: TOK_PID=IN(0x9), UOWN=0
+         *   shortWord[1]: preserve bc
+         */
+        ctrl = (ctrl & 0xFFFF0000u) | 0x24u;
+        *(uint32_t *)entry = cpu_to_le32(ctrl);
+        cpu_physical_memory_write(in_entry, entry, 8);
+
+        /* UxSTAT: EP=0, DIR=IN(bit3), PPBI=ppbi(bit2) */
+        usb_stat_fifo_push(s, 0x08u | (uint32_t)(ppbi ? 0x04u : 0x00u));
+        usb_update_irq(s);
+        return true;
+    }
+    return false;
+}
+
+/*
+ * Simulate the STATUS phase OUT for a control read (host→device ZLP).
+ * Write EP0-OUT-even BDT entry: TOK_PID=OUT(0x1)→byte[0]=0x04, UOWN=0,
+ * bc=0 in shortWord[1].  Then fire TRNIF so the Harmony TRNIF handler
+ * hits case 0x04, sees shortWord[1]=0 < maxPacketSize, marks the IRP
+ * complete, invokes the callback, and re-arms EP0-OUT for the next SETUP.
+ */
+static void usb_send_status_out(PIC32MKUSBState *s)
+{
+    hwaddr bdt = usb_bdt_phys(s);
+    if (!bdt) {
+        return;
+    }
+
+    /*
+     * Find the armed EP0-OUT ping-pong entry (even=BDT+0, odd=BDT+8).
+     * Write: byte[0]=0x04 (TOK_PID=OUT), UOWN=0, shortWord[1]=0 (ZLP).
+     */
+    for (int ppbi = 0; ppbi < 2; ppbi++) {
+        hwaddr out_entry = bdt + (ppbi ? 8u : 0u);
+        uint8_t entry[8];
+        cpu_physical_memory_read(out_entry, entry, 8);
+        uint32_t ctrl = le32_to_cpu(*(uint32_t *)entry);
+
+        if (ctrl & BDT_UOWN) {
+            ctrl = 0x00000004u;   /* TOK_PID=OUT, UOWN=0, bc=0 */
+            *(uint32_t *)entry = cpu_to_le32(ctrl);
+            cpu_physical_memory_write(out_entry, entry, 8);
+            usb_stat_fifo_push(s, (uint32_t)(ppbi ? 0x04u : 0x00u));
+            usb_update_irq(s);
+            return;
+        }
+    }
+
+    /* Neither armed — fire even anyway (fallback; should not happen) */
+    uint8_t entry[8];
+    cpu_physical_memory_read(bdt, entry, 8);
+    *(uint32_t *)entry = cpu_to_le32(0x00000004u);
+    cpu_physical_memory_write(bdt, entry, 8);
+    usb_stat_fifo_push(s, USB_STAT_EP0_OUT_EVEN);
+    usb_update_irq(s);
+}
+
+/*
+ * Chardev RX callbacks (CDC Host→Device path, EP2-OUT)
+ * -----------------------------------------------------------------------
+ */
+
+/*
+ * Returns 64 (max bulk packet) when enumeration is done and EP2-OUT BDT
+ * is armed by the firmware (UOWN=1). Returns 0 otherwise so the chardev
+ * layer does not deliver data before the firmware is ready.
+ */
+static int usb_chr_can_receive(void *opaque)
+{
+    PIC32MKUSBState *s = opaque;
+    if (s->ep0_sim != EP0_SIM_DONE) {
+        return 0;
+    }
+    hwaddr bdt = usb_bdt_phys(s);
+    if (!bdt) {
+        return 0;
+    }
+    /* EP2-OUT-even = BDT+0x40, EP2-OUT-odd = BDT+0x48 */
+    for (int ppbi = 0; ppbi < 2; ppbi++) {
+        uint8_t entry[4];
+        cpu_physical_memory_read(bdt + 0x40u + (ppbi ? 8u : 0u), entry, 4);
+        uint32_t ctrl = le32_to_cpu(*(uint32_t *)entry);
+        if (ctrl & BDT_UOWN) {
+            return 64;
+        }
+    }
+    return 0;
+}
+
+/*
+ * Called by the QEMU chardev layer when the host sends data over the PTY/socket.
+ * Writes the payload into the firmware's EP2-OUT buffer, returns the BDT entry
+ * to firmware (UOWN=0, TOK_PID=OUT, bc=n), and fires TRNIF so the Harmony ISR
+ * picks it up via USB_ReadByte() → circular_buf_get().
+ */
+static void usb_chr_receive(void *opaque, const uint8_t *buf, int size)
+{
+    PIC32MKUSBState *s = opaque;
+    hwaddr bdt = usb_bdt_phys(s);
+    if (!bdt) {
+        return;
+    }
+
+    for (int ppbi = 0; ppbi < 2; ppbi++) {
+        hwaddr ep2_out = bdt + 0x40u + (ppbi ? 8u : 0u);
+        uint8_t entry[8];
+        cpu_physical_memory_read(ep2_out, entry, 8);
+
+        uint32_t ctrl = le32_to_cpu(*(uint32_t *)entry);
+        uint32_t addr = le32_to_cpu(*(uint32_t *)(entry + 4));
+
+        if (!(ctrl & BDT_UOWN) || !addr) {
+            continue;   /* not armed — try other ping-pong */
+        }
+
+        int n = MIN(size, 64);
+        cpu_physical_memory_write(addr, buf, n);
+
+        /*
+         * Return BDT entry to firmware:
+         *   byte[0] = 0x04: TOK_PID=OUT(0x1) in bits[5:2], UOWN=0
+         *   shortWord[1] = n: byte count received
+         */
+        ctrl = 0x00000004u | ((uint32_t)n << 16);
+        *(uint32_t *)entry = cpu_to_le32(ctrl);
+        cpu_physical_memory_write(ep2_out, entry, 8);
+
+        /* UxSTAT: EP=2(bits[7:4]=0x20), DIR=OUT(bit3=0), PPBI=ppbi(bit2) */
+        usb_stat_fifo_push(s, 0x20u | (uint32_t)(ppbi ? 0x04u : 0x00u));
+        usb_update_irq(s);
+        return;
+    }
+}
+
+/*
+ * Poll the CDC TX endpoint (EP2-IN) and the CDC notification endpoint (EP1-IN).
+ * If the firmware has queued data (UOWN=1), drain it, release the BDT entry,
+ * and fire TRNIF so the firmware can refill.
+ *
+ * EP1-IN (BDT+0x30): CDC Serial State Notification — data discarded (host-side
+ * notification only), but BDT must be returned to prevent firmware stall.
+ * EP2-IN (BDT+0x50): CDC bulk TX — data forwarded to chardev.
+ */
+static void usb_check_cdc_bdt(PIC32MKUSBState *s)
+{
+    hwaddr bdt = usb_bdt_phys(s);
+    if (!bdt) {
+        return;
+    }
+
+    /*
+     * EP1-IN = CDC Serial State Notification (interrupt IN, 16 bytes max).
+     * BDT: EP1-IN-even = BDT+0x30, EP1-IN-odd = BDT+0x38.
+     * Drain and return to firmware without forwarding to chardev.
+     */
+    for (int ppbi = 0; ppbi < 2; ppbi++) {
+        hwaddr ep1_in = bdt + 0x30u + (ppbi ? 8u : 0u);
+        uint8_t entry[8];
+        cpu_physical_memory_read(ep1_in, entry, 8);
+
+        uint32_t ctrl = le32_to_cpu(*(uint32_t *)entry);
+        if (!(ctrl & BDT_UOWN)) {
+            continue;
+        }
+
+        /* Return BDT entry: TOK_PID=IN, UOWN=0, preserve bc */
+        ctrl = (ctrl & 0xFFFF0000u) | 0x24u;
+        *(uint32_t *)entry = cpu_to_le32(ctrl);
+        cpu_physical_memory_write(ep1_in, entry, 8);
+
+        /* UxSTAT: EP=1(bits[7:4]=0x10), DIR=IN(bit3=0x08), PPBI=ppbi(bit2) */
+        usb_stat_fifo_push(s, 0x18u | (uint32_t)(ppbi ? 0x04u : 0x00u));
+        usb_update_irq(s);
+        break;   /* one notification per tick is enough */
+    }
+
+    /*
+     * EP2-IN = CDC bulk TX.  BDT: EP2-IN-even = BDT+0x50, EP2-IN-odd = BDT+0x58.
+     * Forward data to chardev backend (PTY / socket / file).
+     */
+    for (int ppbi = 0; ppbi < 2; ppbi++) {
+        hwaddr ep2_in = bdt + 0x50u + (ppbi ? 8u : 0u);
+        uint8_t entry[8];
+        cpu_physical_memory_read(ep2_in, entry, 8);
+
+        uint32_t ctrl = le32_to_cpu(*(uint32_t *)entry);
+        if (!(ctrl & BDT_UOWN)) {
+            continue;
+        }
+
+        uint32_t bc   = ctrl >> 16;
+        uint32_t addr = le32_to_cpu(*(uint32_t *)(entry + 4));
+
+        if (bc > 0 && addr) {
+            uint8_t txbuf[64];
+            bc = MIN(bc, sizeof(txbuf));
+            cpu_physical_memory_read(addr, txbuf, bc);
+            if (qemu_chr_fe_backend_connected(&s->chr)) {
+                qemu_chr_fe_write_all(&s->chr, txbuf, bc);
+            }
+        }
+
+        /* Return BDT entry: TOK_PID=IN, UOWN=0, preserve bc */
+        ctrl = (ctrl & 0xFFFF0000u) | 0x24u;
+        *(uint32_t *)entry = cpu_to_le32(ctrl);
+        cpu_physical_memory_write(ep2_in, entry, 8);
+
+        /* UxSTAT: EP=2(bits[7:4]=0x20), DIR=IN(bit3=0x08), PPBI=ppbi(bit2) */
+        usb_stat_fifo_push(s, 0x28u | (uint32_t)(ppbi ? 0x04u : 0x00u));
+        usb_update_irq(s);
+        return;   /* drain one packet per tick; FIFO handles concurrency */
+    }
+}
+
+/*
+ * EP0 enumeration timer
+ * -----------------------------------------------------------------------
+ */
+
+static void usb_timer_cb(void *opaque)
+{
+    PIC32MKUSBState *s = opaque;
+
+    /* Standard USB SETUP packets for enumeration sequence */
+    static const uint8_t setup_get_dev_desc[8] = {
+        0x80, 0x06, 0x00, 0x01, 0x00, 0x00, 18, 0x00
+    };  /* GET_DESCRIPTOR(Device, length=18) */
+
+    static const uint8_t setup_set_address[8] = {
+        0x00, 0x05, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00
+    };  /* SET_ADDRESS(1) */
+
+    static const uint8_t setup_get_cfg_desc[8] = {
+        0x80, 0x06, 0x00, 0x02, 0x00, 0x00, 67, 0x00
+    };  /* GET_DESCRIPTOR(Configuration, length=67) */
+
+    static const uint8_t setup_set_config[8] = {
+        0x00, 0x09, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00
+    };  /* SET_CONFIGURATION(1) */
+
+    switch (s->ep0_sim) {
+
+    case EP0_SIM_IDLE:
+        /* Do nothing until USBPWR is set */
+        break;
+
+    case EP0_SIM_RESET:
+        /*
+         * Wait until firmware enables URSTIE (bit 0) in UIE.
+         * The UIE write handler fires URSTIF immediately when URSTIE is first
+         * enabled (edge-detected).  This path is a poll fallback: if URSTIE
+         * is already set by the time we arrive here, fire now; otherwise retry
+         * every 5ms.  The 50ms initial delay usually isn't long enough for the
+         * Harmony stack to complete Init→Attach→EnableInterrupts.
+          */
+        if (!(s->uie & USB_IR_URSTIF)) {
+            /*
+             * SESSION_VALID fallback: if the initial SESVDIF pulse was missed
+             * (e.g. IEC not enabled yet when pulse fired), re-latch SESVDIF
+             * every few retries so the EVIC can deliver the interrupt once
+             * IEC is enabled.
+              */
+            s->sesvd_retry_count++;
+            /*
+             * Only re-latch if firmware has never acknowledged SESVDIF.
+             * Once sesvd_acked is true, the Attach→URSTIE chain has
+             * started and retries would cause an IRQ storm.
+              */
+            if (!s->sesvd_acked &&
+                (s->sesvd_retry_count % 3) == 0 &&
+                (s->otgstat & USB_OTG_IR_SESSION_VALID) &&
+                (s->otgie & USB_OTG_IR_SESSION_VALID)) {
+                s->otgir |= USB_OTG_IR_SESSION_VALID;
+                s->sesvd_edge_latched = true;
+                usb_update_irq(s);
+            }
+            timer_mod(s->usb_timer,
+                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 5 * SCALE_MS);
+            return;
+        }
+        s->uir |= USB_IR_URSTIF;
+        usb_update_irq(s);
+        s->ep0_sim = EP0_SIM_GET_DEV_DESC;
+        timer_mod(s->usb_timer,
+                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 10 * SCALE_MS);
+        return;
+
+    case EP0_SIM_GET_DEV_DESC:
+        if (usb_inject_setup(s, setup_get_dev_desc)) {
+            s->ep0_sim = EP0_SIM_WAIT_DEV_DESC;
+            timer_mod(s->usb_timer,
+                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 5 * SCALE_MS);
+        } else {
+            /* Retry every 2 ms until BDT is armed */
+            timer_mod(s->usb_timer,
+                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 2 * SCALE_MS);
+        }
+        return;
+
+    case EP0_SIM_WAIT_DEV_DESC:
+        /* Consume the EP0-IN response(s) — may be multi-packet (64+3 bytes) */
+        if (usb_accept_ep0_in(s)) {
+            /* Give firmware 2ms to re-arm IN or finish */
+            timer_mod(s->usb_timer,
+                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 2 * SCALE_MS);
+        } else {
+            /* IN response not ready yet, or we just consumed last packet */
+            usb_send_status_out(s);  /* status phase complete */
+            s->ep0_sim = EP0_SIM_SET_ADDRESS;
+            timer_mod(s->usb_timer,
+                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 5 * SCALE_MS);
+        }
+        return;
+
+    case EP0_SIM_SET_ADDRESS:
+        if (usb_inject_setup(s, setup_set_address)) {
+            s->uaddr = 1;   /* pretend host acknowledged new address */
+            s->ep0_sim = EP0_SIM_WAIT_ADDRESS;
+            timer_mod(s->usb_timer,
+                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 5 * SCALE_MS);
+        } else {
+            timer_mod(s->usb_timer,
+                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 2 * SCALE_MS);
+        }
+        return;
+
+    case EP0_SIM_WAIT_ADDRESS:
+        /* Consume status-phase ZLP IN from SET_ADDRESS */
+        if (usb_accept_ep0_in(s)) {
+            s->ep0_sim = EP0_SIM_GET_CFG_DESC;
+            timer_mod(s->usb_timer,
+                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 5 * SCALE_MS);
+        } else {
+            /* Retry */
+            timer_mod(s->usb_timer,
+                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 2 * SCALE_MS);
+        }
+        return;
+
+    case EP0_SIM_GET_CFG_DESC:
+        if (usb_inject_setup(s, setup_get_cfg_desc)) {
+            s->ep0_sim = EP0_SIM_WAIT_CFG_DESC;
+            timer_mod(s->usb_timer,
+                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 5 * SCALE_MS);
+        } else {
+            timer_mod(s->usb_timer,
+                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 2 * SCALE_MS);
+        }
+        return;
+
+    case EP0_SIM_WAIT_CFG_DESC:
+        /* May be multi-packet; keep accepting until no more IN pending */
+        if (usb_accept_ep0_in(s)) {
+            timer_mod(s->usb_timer,
+                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 2 * SCALE_MS);
+        } else {
+            usb_send_status_out(s);  /* status phase */
+            s->ep0_sim = EP0_SIM_SET_CONFIG;
+            timer_mod(s->usb_timer,
+                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 5 * SCALE_MS);
+        }
+        return;
+
+    case EP0_SIM_SET_CONFIG:
+        if (usb_inject_setup(s, setup_set_config)) {
+            s->ep0_sim = EP0_SIM_WAIT_CONFIG;
+            timer_mod(s->usb_timer,
+                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 5 * SCALE_MS);
+        } else {
+            timer_mod(s->usb_timer,
+                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 2 * SCALE_MS);
+        }
+        return;
+
+    case EP0_SIM_WAIT_CONFIG:
+        /* Consume status-phase ZLP IN from SET_CONFIGURATION */
+        if (usb_accept_ep0_in(s)) {
+            s->configured = true;
+            s->ep0_sim = EP0_SIM_DONE;
+            qemu_log_mask(LOG_UNIMP, "pic32mk_usb: USB enumeration DONE\n");
+            timer_mod(s->usb_timer,
+                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 5 * SCALE_MS);
+        } else {
+            timer_mod(s->usb_timer,
+                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 2 * SCALE_MS);
+        }
+        return;
+
+    case EP0_SIM_DONE:
+        /*
+         * Poll CDC TX every 1 ms (was 5 ms — too slow for bootloader
+         * throughput; each WRITE command needs a response drained from
+         * EP2-IN before the firmware can process the next one).
+          */
+        usb_check_cdc_bdt(s);
+        /* Advance the frame counter (1 frame = 1 ms at full-speed) */
+        {
+            uint32_t frm = ((s->ufrmh & 0x07u) << 8) | s->ufrml;
+            frm = (frm + 1) & 0x7FFu;
+            s->ufrml = frm & 0xFFu;
+            s->ufrmh = (frm >> 8) & 0x07u;
+        }
+        timer_mod(s->usb_timer,
+                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 1 * SCALE_MS);
+        return;
+    }
+}
+
+/*
+ * MMIO read
+ * -----------------------------------------------------------------------
+ */
+
+static uint64_t usb_read(void *opaque, hwaddr addr, unsigned size)
+{
+    PIC32MKUSBState *s = opaque;
+    hwaddr base = addr & ~(hwaddr)0xFu;   /* strip sub-register bits */
+
+    switch (base) {
+    /* OTG block */
+    case PIC32MK_UxOTGIR:
+        return s->otgir;
+    case PIC32MK_UxOTGIE:
+        return s->otgie;
+    case PIC32MK_UxOTGSTAT:
+        return s->otgstat;
+    case PIC32MK_UxOTGCON:
+        return s->otgcon;
+    case PIC32MK_UxPWRC:
+        return s->pwrc;
+
+    /* Core registers */
+    case PIC32MK_UxIR:
+        return s->uir;
+    case PIC32MK_UxIE:
+        return s->uie;
+    case PIC32MK_UxEIR:
+        return s->ueir;
+    case PIC32MK_UxEIE:
+        return s->ueie;
+    case PIC32MK_UxSTAT:
+        return s->ustat;
+    case PIC32MK_UxCON:
+        return s->ucon;
+    case PIC32MK_UxADDR:
+        return s->uaddr;
+    case PIC32MK_UxBDTP1:
+        return s->bdtp1;
+    case PIC32MK_UxFRML:
+        return s->ufrml;
+    case PIC32MK_UxFRMH:
+        return s->ufrmh;
+    case PIC32MK_UxTOK:
+        return s->utok;
+    case PIC32MK_UxSOF:
+        return s->usof;
+    case PIC32MK_UxBDTP2:
+        return s->bdtp2;
+    case PIC32MK_UxBDTP3:
+        return s->bdtp3;
+    case PIC32MK_UxCNFG1:
+        return s->cnfg1;
+
+    default:
+        break;
+    }
+
+    /* Endpoint control registers UxEP0–UxEP15 */
+    if (base >= PIC32MK_UxEP_BASE &&
+        base < PIC32MK_UxEP_BASE + PIC32MK_USB_NEPS * PIC32MK_UxEP_STRIDE) {
+        unsigned ep = (base - PIC32MK_UxEP_BASE) / PIC32MK_UxEP_STRIDE;
+        return s->uep[ep];
+    }
+
+    qemu_log_mask(LOG_UNIMP,
+                  "pic32mk_usb: unimplemented read @ 0x%04" HWADDR_PRIx "\n",
+                  addr);
+    return 0;
+}
+
+/*
+ * MMIO write
+ * -----------------------------------------------------------------------
+ */
+
+static void usb_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
+{
+    PIC32MKUSBState *s = opaque;
+    hwaddr base = addr & ~(hwaddr)0xFu;
+    int    sub  = (int)(addr & 0xFu);
+    uint32_t v  = (uint32_t)val;
+
+    switch (base) {
+
+    /* ----- OTG block ----- */
+    case PIC32MK_UxOTGIR:
+        /*
+         * Clear the edge latch before W1C so that usb_update_irq() deasserts
+         * the IRQ line when SESVDIF is cleared by firmware.
+          */
+        if (v & USB_OTG_IR_SESSION_VALID) {
+            s->sesvd_edge_latched = false;
+            s->sesvd_acked = true;   /* firmware processed SESSION_VALID */
+        }
+        apply_w1c(&s->otgir, v, sub);
+        usb_update_irq(s);
+        return;
+
+    case PIC32MK_UxOTGIE: {
+        uint32_t old_otgie = s->otgie;
+        apply_sci(&s->otgie, v, sub);
+        /*
+         * SESSION_VALID edge simulation:
+         * Latch SESVDIF ONLY on the 0→1 transition of the SESSION_VALID enable
+         * bit, and only if firmware hasn't already acknowledged it.  Without
+         * edge detection, any OTGIE write (e.g. Harmony's Attach() enabling
+         * all OTG ints from inside the SESSION_VALID ISR) would re-latch
+         * SESVDIF and cause an infinite ISR loop.
+          */
+        if (!(old_otgie & USB_OTG_IR_SESSION_VALID) &&
+            (s->otgie & USB_OTG_IR_SESSION_VALID) &&
+            (s->otgstat & USB_OTG_IR_SESSION_VALID) &&
+            !s->sesvd_acked) {
+            s->otgir |= USB_OTG_IR_SESSION_VALID;
+            s->sesvd_edge_latched = true;
+            fprintf(stderr, "pic32mk_usb: SESSION_VALID latched → IRQ (persistent)\n");
+        }
+        usb_update_irq(s);
+        return;
+    }
+
+    case PIC32MK_UxOTGSTAT:
+        return;   /* read-only */
+
+    case PIC32MK_UxOTGCON:
+        apply_sci(&s->otgcon, v, sub);
+        return;
+
+    case PIC32MK_UxPWRC: {
+        uint32_t old_pwrc = s->pwrc;
+        apply_sci(&s->pwrc, v, sub);
+        /* When USBPWR first asserted: schedule USB Reset after 50 ms */
+        if ((s->pwrc & USB_PWRC_USBPWR) && !(old_pwrc & USB_PWRC_USBPWR)
+            && s->ep0_sim == EP0_SIM_IDLE) {
+            fprintf(stderr, "pic32mk_usb: USBPWR set — scheduling USB Reset in 50ms\n");
+            s->ep0_sim = EP0_SIM_RESET;
+            timer_mod(s->usb_timer,
+                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 50 * SCALE_MS);
+        }
+        return;
+    }
+
+    /* ----- Core interrupt registers ----- */
+    case PIC32MK_UxIR:
+        /*
+         * TRNIF W1C: pop the USTAT FIFO.  On real PIC32MK hardware, clearing
+         * TRNIF advances the 4-deep STAT FIFO.  If more entries remain,
+         * TRNIF is re-asserted immediately with the next USTAT value, so the
+         * Harmony ISR's while(TRNIF) loop processes all queued transactions.
+         */
+        if (v & USB_IR_TRNIF) {
+            usb_stat_fifo_pop(s);
+        }
+        apply_w1c(&s->uir, v, sub);
+        /*
+         * Opportunistic CDC TX check: firmware just cleared TRNIF, meaning it
+         * finished processing a transaction.  If it also armed EP2-IN (TX
+         * response) during that processing, drain it NOW instead of waiting
+         * for the next timer tick.  This brings TX latency close to zero.
+         */
+        if (s->configured) {
+            usb_check_cdc_bdt(s);
+        }
+        usb_update_irq(s);
+        return;
+
+    case PIC32MK_UxIE: {
+        uint32_t old_uie = s->uie;
+        apply_sci(&s->uie, v, sub);
+        /*
+         * When firmware enables URSTIE (bit 0) for the first time and the EP0
+         * state machine is armed (USBPWR was set earlier), fire URSTIF now.
+         * On real hardware the host drives USB Reset after D+ pullup is seen.
+         * We use the same edge-detection pattern as SESSION_VALID: pulse assert
+         * + deassert so EVIC latches IFS exactly once, then let usb_update_irq
+         * handle the persistent URSTIF level (UIR & UIE != 0).
+          */
+        if (!(old_uie & USB_IR_URSTIF) && (s->uie & USB_IR_URSTIF)
+            && s->ep0_sim == EP0_SIM_RESET) {
+            fprintf(stderr, "pic32mk_usb: URSTIE enabled → firing USB Reset\n");
+            s->uir |= USB_IR_URSTIF;
+        }
+        usb_update_irq(s);
+        return;
+    }
+
+    case PIC32MK_UxEIR:
+        apply_w1c(&s->ueir, v, sub);
+        usb_update_irq(s);
+        return;
+
+    case PIC32MK_UxEIE:
+        apply_sci(&s->ueie, v, sub);
+        usb_update_irq(s);
+        return;
+
+    case PIC32MK_UxSTAT:
+        return;   /* read-only */
+
+    case PIC32MK_UxCON:
+        apply_sci(&s->ucon, v, sub);
+        return;
+
+    case PIC32MK_UxADDR:
+        apply_sci(&s->uaddr, v, sub);
+        return;
+
+    case PIC32MK_UxBDTP1:
+        apply_sci(&s->bdtp1, v, sub);
+        return;
+
+    case PIC32MK_UxFRML:
+    case PIC32MK_UxFRMH:
+        return;   /* read-only */
+
+    case PIC32MK_UxTOK:
+        apply_sci(&s->utok, v, sub);
+        return;
+
+    case PIC32MK_UxSOF:
+        apply_sci(&s->usof, v, sub);
+        return;
+
+    case PIC32MK_UxBDTP2:
+        apply_sci(&s->bdtp2, v, sub);
+        return;
+
+    case PIC32MK_UxBDTP3:
+        apply_sci(&s->bdtp3, v, sub);
+        return;
+
+    case PIC32MK_UxCNFG1:
+        apply_sci(&s->cnfg1, v, sub);
+        return;
+
+    default:
+        break;
+    }
+
+    /* Endpoint control registers */
+    if (base >= PIC32MK_UxEP_BASE &&
+        base < PIC32MK_UxEP_BASE + PIC32MK_USB_NEPS * PIC32MK_UxEP_STRIDE) {
+        unsigned ep = (base - PIC32MK_UxEP_BASE) / PIC32MK_UxEP_STRIDE;
+        apply_sci(&s->uep[ep], v, sub);
+        return;
+    }
+
+    qemu_log_mask(LOG_UNIMP,
+                  "pic32mk_usb: unimplemented write @ 0x%04" HWADDR_PRIx
+                  " = 0x%08x\n", addr, v);
+}
+
+static const MemoryRegionOps usb_ops = {
+    .read       = usb_read,
+    .write      = usb_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+/*
+ * Device lifecycle
+ * -----------------------------------------------------------------------
+ */
+
+static void pic32mk_usb_reset(DeviceState *dev)
+{
+    PIC32MKUSBState *s = PIC32MK_USB(dev);
+
+    /* Reset values: all zero unless specified in DS60001519E §25 */
+    s->otgir   = 0;
+    s->otgie   = 0;
+    /*
+     * SESVD (bit 3): simulate VBUS present from power-on.
+     * The Harmony driver polls PLIB_USB_OTG_SessionValid() (reads SESVD) to
+     * decide whether to call USB_DEVICE_Attach().  If SESVD=0 at boot the
+     * driver never calls Attach(), USBPWR is never set, and our timer-based
+     * EP0 simulation never starts — a permanent deadlock.  Pre-setting SESVD
+     * breaks the cycle: firmware sees VBUS valid, calls Attach(), sets USBPWR,
+     * and our EP0 timer fires as expected.
+      */
+    s->otgstat = 0x08u;
+    s->otgcon  = 0;
+    s->pwrc    = 0;
+    s->uir     = 0;
+    s->uie     = 0;
+    s->ueir    = 0;
+    s->ueie    = 0;
+    s->ustat   = 0;
+    s->ucon    = 0;
+    s->uaddr   = 0;
+    s->bdtp1   = 0;
+    s->bdtp2   = 0;
+    s->bdtp3   = 0;
+    s->ufrml   = 0;
+    s->ufrmh   = 0;
+    s->utok    = 0;
+    s->usof    = 0x4Bu;
+    s->cnfg1   = 0;
+    memset(s->uep, 0, sizeof(s->uep));
+
+    s->ep0_sim   = EP0_SIM_IDLE;
+    s->configured = false;
+    s->sesvd_edge_latched = false;
+    s->sesvd_acked = false;
+    s->sesvd_retry_count = 0;
+
+    /* USTAT FIFO reset */
+    memset(s->stat_fifo, 0, sizeof(s->stat_fifo));
+    s->stat_fifo_head  = 0;
+    s->stat_fifo_tail  = 0;
+    s->stat_fifo_count = 0;
+
+    if (s->usb_timer) {
+        timer_del(s->usb_timer);
+    }
+
+    qemu_set_irq(s->irq, 0);
+}
+
+static void pic32mk_usb_init(Object *obj)
+{
+    PIC32MKUSBState *s = PIC32MK_USB(obj);
+
+    memory_region_init_io(&s->sfr_mmio, obj, &usb_ops, s,
+                          TYPE_PIC32MK_USB, PIC32MK_USB_SFR_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->sfr_mmio);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
+
+    s->usb_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, usb_timer_cb, s);
+    s->ep0_sim   = EP0_SIM_IDLE;
+    s->configured = false;
+    s->sesvd_edge_latched = false;
+    s->sesvd_acked = false;
+    s->sesvd_retry_count = 0;
+    s->stat_fifo_head  = 0;
+    s->stat_fifo_tail  = 0;
+    s->stat_fifo_count = 0;
+}
+
+static void pic32mk_usb_realize(DeviceState *dev, Error **errp)
+{
+    PIC32MKUSBState *s = PIC32MK_USB(dev);
+    if (qemu_chr_fe_backend_connected(&s->chr)) {
+        qemu_chr_fe_set_handlers(&s->chr,
+                                 usb_chr_can_receive,
+                                 usb_chr_receive,
+                                 NULL, NULL,
+                                 s, NULL, true);
+    }
+}
+
+static const Property pic32mk_usb_properties[] = {
+    DEFINE_PROP_CHR("chardev", PIC32MKUSBState, chr),
+};
+
+static void pic32mk_usb_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    device_class_set_legacy_reset(dc, pic32mk_usb_reset);
+    device_class_set_props(dc, pic32mk_usb_properties);
+    dc->realize = pic32mk_usb_realize;
+    dc->desc = "PIC32MK USB OTG Full-Speed";
+}
+
+static const TypeInfo pic32mk_usb_info = {
+    .name          = TYPE_PIC32MK_USB,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(PIC32MKUSBState),
+    .instance_init = pic32mk_usb_init,
+    .class_init    = pic32mk_usb_class_init,
+};
+
+static void pic32mk_usb_register_types(void)
+{
+    type_register_static(&pic32mk_usb_info);
+}
+
+type_init(pic32mk_usb_register_types)
diff --git a/hw/mips/pic32mk_wdt.c b/hw/mips/pic32mk_wdt.c
new file mode 100644
index 0000000000..93d61bf55f
--- /dev/null
+++ b/hw/mips/pic32mk_wdt.c
@@ -0,0 +1,230 @@
+/*
+ * Microchip PIC32MK — Watchdog Timer (WDT)
+ * Datasheet: DS60001519E §17, Register 17-1
+ *
+ * Models the WDTCON register, the clear-key mechanism (write 0x5743
+ * to upper 16 bits via 16-bit write to WDTCON+2), and a real countdown
+ * timer that triggers a system reset if firmware fails to clear the
+ * WDT in time.
+ *
+ * WDTCON layout:
+ *   bits[31:16] WDTCLRKEY  — write 0x5743 here to clear the counter
+ *   bit  15     ON         — WDT enable
+ *   bits[12:8]  RUNDIV     — read-only post-scaler (reflects config bits)
+ *   bits[5:1]   SLPDIV     — read-only post-scaler (reflects config bits)
+ *   bit  0      WDTWINEN   — windowed mode enable
+ *
+ * The timeout period is derived from the LPRC (32 kHz) oscillator
+ * and the RUNDIV post-scaler.  Default RUNDIV=0 ≈ 1 ms base period,
+ * giving a ~1 s timeout with the default post-scaler (WDTPS ≈ 20).
+ * In emulation we use a configurable period (default 2 s) that can
+ * be tuned via the "timeout-ms" qdev property.
+ *
+ * Copyright (c) 2026 QEMU contributors
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/timer.h"
+#include "hw/core/sysbus.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/mips/pic32mk.h"
+#include "system/runstate.h"
+
+/*
+ * WDTCON register bit positions (DS60001519E §17, Register 17-1)
+ * -----------------------------------------------------------------------
+ */
+#define WDTCON_ON       (1u << 15)  /* WDT enable */
+#define WDTCON_WDTWINEN (1u << 0)   /* Windowed mode enable — bit 0 */
+#define WDTCON_WR_MASK  (WDTCON_ON | WDTCON_WDTWINEN)  /* writable bits */
+
+/* Upper-halfword clear key written by firmware WDT_Clear() */
+#define WDT_CLRKEY      0x5743u
+
+/* Default timeout in milliseconds (~2 s, conservative for emulation) */
+#define WDT_DEFAULT_TIMEOUT_MS  2000
+
+#define TYPE_PIC32MK_WDT "pic32mk-wdt"
+OBJECT_DECLARE_SIMPLE_TYPE(PIC32MKWDTState, PIC32MK_WDT)
+
+typedef struct PIC32MKWDTState {
+    SysBusDevice parent_obj;
+    MemoryRegion  mmio;
+    uint32_t      wdtcon;       /* WDTCON register value */
+    QEMUTimer     timer;        /* Countdown timer */
+    uint32_t      timeout_ms;   /* Timeout period (ms), qdev property */
+} PIC32MKWDTState;
+
+/*
+ * Timer helpers
+ * -----------------------------------------------------------------------
+ */
+
+static void pic32mk_wdt_rearm(PIC32MKWDTState *s)
+{
+    int64_t now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
+    timer_mod(&s->timer, now + s->timeout_ms);
+}
+
+static void pic32mk_wdt_stop(PIC32MKWDTState *s)
+{
+    timer_del(&s->timer);
+}
+
+static void pic32mk_wdt_update(PIC32MKWDTState *s, uint32_t old)
+{
+    bool was_on = (old & WDTCON_ON) != 0;
+    bool is_on  = (s->wdtcon & WDTCON_ON) != 0;
+
+    if (is_on && !was_on) {
+        /* Turning ON — start countdown */
+        pic32mk_wdt_rearm(s);
+    } else if (!is_on && was_on) {
+        /* Turning OFF — stop countdown */
+        pic32mk_wdt_stop(s);
+    }
+}
+
+/* Timer callback — WDT expired, trigger system reset */
+static void pic32mk_wdt_expire(void *opaque)
+{
+    PIC32MKWDTState *s = PIC32MK_WDT(opaque);
+
+    if (!(s->wdtcon & WDTCON_ON)) {
+        return; /* Race: turned off between schedule and callback */
+    }
+
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "pic32mk-wdt: watchdog timeout — system reset\n");
+    qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+}
+
+/*
+ * Read handler — WDTCON + SET/CLR/INV aliases
+ * -----------------------------------------------------------------------
+ */
+static uint64_t pic32mk_wdt_read(void *opaque, hwaddr addr, unsigned size)
+{
+    PIC32MKWDTState *s = PIC32MK_WDT(opaque);
+
+    switch (addr & ~0x3u) {
+    case 0x00:
+        /* WDTCON (base, +4 SET, +8 CLR, +C INV all read same) */;
+    case 0x04:
+    case 0x08:
+    case 0x0C:
+        return s->wdtcon;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "pic32mk-wdt: unimplemented read @ 0x%" HWADDR_PRIx "\n",
+                      addr);
+        return 0;
+    }
+}
+
+/*
+ * Write handler — WDTCON + SET/CLR/INV; clear-key on upper 16 bits
+ * -----------------------------------------------------------------------
+ */
+static void pic32mk_wdt_write(void *opaque, hwaddr addr, uint64_t val,
+                              unsigned size)
+{
+    PIC32MKWDTState *s = PIC32MK_WDT(opaque);
+    uint32_t old = s->wdtcon;
+
+    /*
+     * firmware WDT_Clear() does a 16-bit write of 0x5743 to WDTCON+2
+     * (the upper halfword).  Detect by: addr==2, size==2, val==0x5743.
+     * Restart the countdown timer.
+     */
+    if (addr == 2 && size == 2 && (uint16_t)val == WDT_CLRKEY) {
+        if (s->wdtcon & WDTCON_ON) {
+            pic32mk_wdt_rearm(s);
+        }
+        return;
+    }
+
+    switch (addr & 0xCu) {
+    case 0x0:
+        /* WDTCON write */;
+        s->wdtcon = (uint32_t)val & WDTCON_WR_MASK;
+        break;
+    case 0x4:
+        /* SET */;
+        s->wdtcon |= (uint32_t)val & WDTCON_WR_MASK;
+        break;
+    case 0x8:
+        /* CLR */;
+        s->wdtcon &= ~((uint32_t)val & WDTCON_WR_MASK);
+        break;
+    case 0xC:
+        /* INV */;
+        s->wdtcon ^= (uint32_t)val & WDTCON_WR_MASK;
+        break;
+    }
+
+    pic32mk_wdt_update(s, old);
+}
+
+static const MemoryRegionOps pic32mk_wdt_ops = {
+    .read       = pic32mk_wdt_read,
+    .write      = pic32mk_wdt_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 2,
+        .max_access_size = 4,
+    },
+    .impl = {
+        .min_access_size = 2,
+        .max_access_size = 4,
+    },
+};
+
+static void pic32mk_wdt_realize(DeviceState *dev, Error **errp)
+{
+    PIC32MKWDTState *s = PIC32MK_WDT(dev);
+    memory_region_init_io(&s->mmio, OBJECT(s), &pic32mk_wdt_ops, s,
+                          "pic32mk-wdt", PIC32MK_WDT_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
+    timer_init_ms(&s->timer, QEMU_CLOCK_VIRTUAL,
+                  pic32mk_wdt_expire, s);
+}
+
+static void pic32mk_wdt_reset_hold(Object *obj, ResetType type)
+{
+    PIC32MKWDTState *s = PIC32MK_WDT(obj);
+    timer_del(&s->timer);
+    s->wdtcon = 0;
+}
+
+static const Property pic32mk_wdt_properties[] = {
+    DEFINE_PROP_UINT32("timeout-ms", PIC32MKWDTState, timeout_ms,
+                       WDT_DEFAULT_TIMEOUT_MS),
+};
+
+static void pic32mk_wdt_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    dc->realize = pic32mk_wdt_realize;
+    dc->desc    = "PIC32MK Watchdog Timer";
+    device_class_set_props(dc, pic32mk_wdt_properties);
+    rc->phases.hold = pic32mk_wdt_reset_hold;
+}
+
+static const TypeInfo pic32mk_wdt_info = {
+    .name          = TYPE_PIC32MK_WDT,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(PIC32MKWDTState),
+    .class_init    = pic32mk_wdt_class_init,
+};
+
+static void pic32mk_wdt_register_types(void)
+{
+    type_register_static(&pic32mk_wdt_info);
+}
+
+type_init(pic32mk_wdt_register_types)
diff --git a/include/hw/mips/pic32mk.h b/include/hw/mips/pic32mk.h
new file mode 100644
index 0000000000..e1317183d0
--- /dev/null
+++ b/include/hw/mips/pic32mk.h
@@ -0,0 +1,952 @@
+/*
+ * PIC32MK GPK/MCM with CAN FD — shared constants
+ * Datasheet: DS60001519E
+ *
+ * Copyright (c) 2026 QEMU contributors
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MIPS_PIC32MK_H
+#define HW_MIPS_PIC32MK_H
+
+/*
+ * Physical memory map (§4, pp. 70-73)
+ * -----------------------------------------------------------------------
+ */
+
+#define PIC32MK_RAM_BASE        0x00000000u   /* 256 KB SRAM */
+#define PIC32MK_RAM_SIZE        (256 * 1024)
+
+#define PIC32MK_PFLASH_BASE     0x1D000000u   /* 1 MB Program Flash */
+#define PIC32MK_PFLASH_SIZE     (1 * 1024 * 1024)
+
+/*
+ * Boot vector ROM — fills the gap between the MIPS reset vector (0x1FC00000)
+ * and Boot Flash 1 (0x1FC40000). Contains a trampoline that jumps to BFlash1.
+ */
+#define PIC32MK_BOOTVEC_BASE    0x1FC00000u   /* physical reset vector */
+#define PIC32MK_BOOTVEC_SIZE    0x00040000u   /* 256 KB gap to BFlash1 */
+
+#define PIC32MK_BFLASH1_BASE    0x1FC40000u   /* Boot Flash 1 — enlarged for firmware */
+#define PIC32MK_BFLASH1_SIZE    (256 * 1024)
+
+#define PIC32MK_BFLASH2_BASE    0x1FC60000u   /* Boot Flash 2 ~20 KB */
+#define PIC32MK_BFLASH2_SIZE    (20 * 1024)
+
+#define PIC32MK_SFR_BASE        0x1F800000u   /* SFR window, 1 MB */
+#define PIC32MK_SFR_SIZE        (1 * 1024 * 1024)
+
+/* Reset vector (KSEG1 uncached alias of 0x1FC00000) */
+#define PIC32MK_RESET_VECTOR    0xBFC00000u
+
+/*
+ * SFR sub-block bases (offsets within the 1 MB SFR window, Table 4-2)
+ * All addresses below are KSEG1 virtual (0xBF800000 + offset).
+ * -----------------------------------------------------------------------
+ */
+
+/* CFG / PMD block (0xBF800000)                                           */
+#define PIC32MK_CFG_OFFSET      0x000000u
+#define PIC32MK_CFG_SIZE        0x000900u   /* CFGCON..CFGCON2+INV + CHECON@0x800 */
+
+/* CRU — Clock Reference Unit (0xBF801200)                                 */
+#define PIC32MK_CRU_OFFSET      0x001200u
+#define PIC32MK_CRU_SIZE        0x0001A0u   /* OSCCON..CLKSTAT+INV inclusive */
+
+/* PPS (Peripheral Pin Select) input/output registers (0xBF801400–0xBF8017FF) */
+#define PIC32MK_PPS_OFFSET      0x001400u
+#define PIC32MK_PPS_SIZE        0x000400u
+
+/* WDT register block (0xBF800C00) */
+#define PIC32MK_WDT_OFFSET      0x000C00u
+#define PIC32MK_WDT_SIZE        0x000040u   /* WDTCON + SET/CLR/INV + padding */
+
+/* EVIC                                         0xBF810000 */
+#define PIC32MK_EVIC_OFFSET     0x010000u
+
+/* DMA (shares page with EVIC)                  0xBF811000 */
+#define PIC32MK_DMA_OFFSET      0x011000u
+
+/* Timers / IC / OC / I2C1-2 / SPI1-2 / UART1-2 / PWM / QEI / CMP / CDAC1 */
+#define PIC32MK_PER1_OFFSET     0x020000u   /* 0xBF820000, size 0xD000 */
+
+/* I2C3-4 / SPI3-6 / UART3-6 / CDAC2-3         0xBF840000 */
+#define PIC32MK_PER2_OFFSET     0x040000u
+
+/* GPIO PORTA-PORTG                             0xBF860000 */
+#define PIC32MK_GPIO_OFFSET     0x060000u
+
+/* CAN1-4 / ADC                                 0xBF880000 */
+#define PIC32MK_CAN_OFFSET      0x080000u
+
+/*
+ * CAN1–4 SFR offsets from SFR base
+ * Verified against DS60001519E / p32mk1024mcm100.h:
+ *   CFD1CON @ 0xBF880000, CFD2CON @ 0xBF881000,
+ *   CFD3CON @ 0xBF884000, CFD4CON @ 0xBF885000
+ */
+#define PIC32MK_CAN1_OFFSET     0x080000u   /* physical 0x1F880000 */
+#define PIC32MK_CAN2_OFFSET     0x081000u   /* physical 0x1F881000 */
+#define PIC32MK_CAN3_OFFSET     0x084000u   /* physical 0x1F884000 */
+#define PIC32MK_CAN4_OFFSET     0x085000u   /* physical 0x1F885000 */
+#define PIC32MK_CAN_SFR_SIZE    0x1000u     /* 4 KB SFR block per instance */
+
+/*
+ * Message RAM physical base per instance.
+ * Allocated just above the SFR window, beyond the ADC / USB blocks.
+ * ⚠  Verify exact addresses from DS60001519E §4 before final integration.
+ * Each instance gets 76 KB (75 KB data + alignment).
+ */
+#define PIC32MK_CAN1_MSGRAM_BASE 0x1F900000u
+#define PIC32MK_CAN2_MSGRAM_BASE 0x1F913000u
+#define PIC32MK_CAN3_MSGRAM_BASE 0x1F926000u
+#define PIC32MK_CAN4_MSGRAM_BASE 0x1F939000u
+#define PIC32MK_CAN_MSGRAM_SIZE  (75u * 1024u)  /* max 74 KB, rounded up */
+
+/*
+ * USB OTG 1   _USB_BASE_ADDRESS = 0xBF889040 (p32mk1024mcm100.h / xc.h)
+ * struct usb_registers_t pointer starts at 0xBF889040 (= device_base + 0x040).
+ * Device MMIO window starts at 0xBF889000 so UxOTGIR lands at offset 0x040.
+ */
+#define PIC32MK_USB1_OFFSET     0x089000u
+#define PIC32MK_USB_OFFSET      PIC32MK_USB1_OFFSET   /* legacy alias */
+
+/* USB OTG 2   _USB2_BASE_ADDRESS = 0xBF88A040 */
+#define PIC32MK_USB2_OFFSET     0x08A000u
+
+/* RTCC                                         0xBF8C0000 */
+#define PIC32MK_RTCC_OFFSET     0x0C0000u
+
+/*
+ * Reset-control registers (§7, p. 114) — offsets from SFR base
+ * -----------------------------------------------------------------------
+ */
+
+#define PIC32MK_RCON_OFFSET     0x001240u   /* Reset Control */
+#define PIC32MK_RSWRST_OFFSET   0x001250u   /* Software Reset trigger */
+#define PIC32MK_RNMICON_OFFSET  0x001260u   /* NMI Control */
+#define PIC32MK_PWRCON_OFFSET   0x001270u   /* Power Control */
+
+/* RCON reset flags (§7 register map) */
+#define PIC32MK_RCON_POR        (1u << 2)   /* Power-on Reset */
+#define PIC32MK_RCON_BOR        (1u << 3)   /* Brown-out Reset */
+
+/*
+ * CFG / PMD registers (§6) — offsets from PIC32MK_CFG_OFFSET (0xBF800000)
+ * -----------------------------------------------------------------------
+ */
+
+#define PIC32MK_CFGCON          0x0000u     /* Configuration control */
+#define PIC32MK_SYSKEY          0x0030u     /* System key unlock */
+#define PIC32MK_PMD1            0x0040u     /* Peripheral Module Disable 1 */
+#define PIC32MK_PMD2            0x0050u
+#define PIC32MK_PMD3            0x0060u
+#define PIC32MK_PMD4            0x0070u
+#define PIC32MK_PMD5            0x0080u
+#define PIC32MK_PMD6            0x0090u
+#define PIC32MK_PMD7            0x00A0u
+#define PIC32MK_CFGCON2         0x0110u     /* Extended configuration control */
+#define PIC32MK_CHECON          0x0800u     /* Prefetch Cache Control (CHECON) */
+
+/* CFGCON bits */
+#define PIC32MK_CFGCON_PGLOCK   (1u << 28)  /* Permission-group lock */
+#define PIC32MK_CFGCON_PMDLOCK  (1u << 29)  /* PMD lock */
+#define PIC32MK_CFGCON_IOLOCK   (1u << 30)  /* I/O lock */
+
+/* Number of PMD registers */
+#define PIC32MK_PMD_COUNT       7
+
+/*
+ * CRU registers (§9) — offsets from PIC32MK_CRU_OFFSET (0xBF801200)
+ * Each register has SET/CLR/INV aliases at +4/+8/+C.
+ * -----------------------------------------------------------------------
+ */
+
+/* Oscillator / PLL registers */
+#define PIC32MK_CRU_OSCCON      0x00u       /* Oscillator Control */
+#define PIC32MK_CRU_OSCTUN      0x10u       /* Oscillator Tuning */
+#define PIC32MK_CRU_SPLLCON     0x20u       /* System PLL Control */
+#define PIC32MK_CRU_UPLLCON     0x30u       /* USB PLL Control */
+
+/* Reset-control registers (formerly in separate RCON stub) */
+#define PIC32MK_CRU_RCON        0x40u       /* Reset Control */
+#define PIC32MK_CRU_RSWRST      0x50u       /* Software Reset trigger */
+#define PIC32MK_CRU_RNMICON     0x60u       /* NMI Control */
+#define PIC32MK_CRU_PWRCON      0x70u       /* Power Control */
+
+/* Reference clock outputs 1–4 (CON + TRIM pairs, 0x20 stride) */
+#define PIC32MK_CRU_REFO1CON    0x80u
+#define PIC32MK_CRU_REFO1TRIM   0x90u
+#define PIC32MK_CRU_REFO2CON    0xA0u
+#define PIC32MK_CRU_REFO2TRIM   0xB0u
+#define PIC32MK_CRU_REFO3CON    0xC0u
+#define PIC32MK_CRU_REFO3TRIM   0xD0u
+#define PIC32MK_CRU_REFO4CON    0xE0u
+#define PIC32MK_CRU_REFO4TRIM   0xF0u
+
+/* Peripheral bus clock dividers 1–7 (0x10 stride) */
+#define PIC32MK_CRU_PB1DIV      0x100u
+#define PIC32MK_CRU_PB2DIV      0x110u
+#define PIC32MK_CRU_PB3DIV      0x120u
+#define PIC32MK_CRU_PB4DIV      0x130u
+#define PIC32MK_CRU_PB5DIV      0x140u
+#define PIC32MK_CRU_PB6DIV      0x150u
+#define PIC32MK_CRU_PB7DIV      0x160u
+
+/* Clock status */
+#define PIC32MK_CRU_CLKSTAT     0x190u
+
+/* Number of reference clocks and peripheral buses */
+#define PIC32MK_CRU_NREFO       4
+#define PIC32MK_CRU_NPB         7
+
+/* OSCCON bits (§9, Register 9-1) */
+#define PIC32MK_OSCCON_OSWEN    (1u << 0)
+#define PIC32MK_OSCCON_SOSCEN   (1u << 1)
+#define PIC32MK_OSCCON_CF       (1u << 3)
+#define PIC32MK_OSCCON_SLPEN    (1u << 4)
+#define PIC32MK_OSCCON_CLKLOCK  (1u << 7)
+#define PIC32MK_OSCCON_NOSC_MASK  0x00000700u   /* bits [10:8] */
+#define PIC32MK_OSCCON_NOSC_SHIFT 8
+#define PIC32MK_OSCCON_COSC_MASK  0x00007000u   /* bits [14:12] */
+#define PIC32MK_OSCCON_COSC_SHIFT 12
+#define PIC32MK_OSCCON_FRCDIV_MASK  0x07000000u /* bits [26:24] */
+#define PIC32MK_OSCCON_FRCDIV_SHIFT 24
+
+/* SPLLCON bits (§9, Register 9-4) */
+#define PIC32MK_SPLLCON_PLLRANGE_MASK  0x00000007u /* bits [2:0] */
+#define PIC32MK_SPLLCON_PLLICLK  (1u << 7)
+#define PIC32MK_SPLLCON_PLLIDIV_MASK   0x00000700u /* bits [10:8] */
+#define PIC32MK_SPLLCON_PLLMULT_MASK   0x007F0000u /* bits [22:16] */
+#define PIC32MK_SPLLCON_PLLODIV_MASK   0x07000000u /* bits [26:24] */
+
+/* UPLLCON bits (§9) — same layout as SPLLCON plus UPOSCEN */
+#define PIC32MK_UPLLCON_UPOSCEN  (1u << 25)
+
+/* REFOxCON bits (§9, Register 9-16) */
+#define PIC32MK_REFOCON_ROSEL_MASK  0x0000000Fu /* bits [3:0] */
+#define PIC32MK_REFOCON_ACTIVE   (1u << 8)
+#define PIC32MK_REFOCON_DIVSWEN  (1u << 9)
+#define PIC32MK_REFOCON_RSLP     (1u << 11)
+#define PIC32MK_REFOCON_OE       (1u << 12)
+#define PIC32MK_REFOCON_SIDL     (1u << 13)
+#define PIC32MK_REFOCON_ON       (1u << 15)
+#define PIC32MK_REFOCON_RODIV_MASK  0xFFFF0000u /* bits [31:16] */
+
+/* PBxDIV bits (§9) */
+#define PIC32MK_PBDIV_PBDIV_MASK  0x0000007Fu  /* bits [6:0] */
+#define PIC32MK_PBDIV_PBDIVRDY   (1u << 11)
+#define PIC32MK_PBDIV_ON         (1u << 15)
+
+/* CLKSTAT bits (§9, Register 9-31) */
+#define PIC32MK_CLKSTAT_FRCRDY   (1u << 0)
+#define PIC32MK_CLKSTAT_POSCRDY  (1u << 2)
+#define PIC32MK_CLKSTAT_SOSCRDY  (1u << 4)
+#define PIC32MK_CLKSTAT_LPRCRDY  (1u << 5)
+#define PIC32MK_CLKSTAT_SPLLRDY  (1u << 7)
+#define PIC32MK_CLKSTAT_UPLLRDY  (1u << 8)
+#define PIC32MK_CLKSTAT_ALL_RDY  (PIC32MK_CLKSTAT_FRCRDY  | \
+                                  PIC32MK_CLKSTAT_POSCRDY  | \
+                                  PIC32MK_CLKSTAT_SOSCRDY  | \
+                                  PIC32MK_CLKSTAT_LPRCRDY  | \
+                                  PIC32MK_CLKSTAT_SPLLRDY  | \
+                                  PIC32MK_CLKSTAT_UPLLRDY)
+
+/*
+ * EVIC registers (§8, p. 159) — offsets from 0xBF810000
+ * -----------------------------------------------------------------------
+ */
+
+#define PIC32MK_EVIC_INTCON     0x0000u     /* MVEC, TPC, INTxEP */
+#define PIC32MK_EVIC_PRISS      0x0010u     /* Priority shadow reg select */
+#define PIC32MK_EVIC_INTSTAT    0x0020u     /* Last IRQ serviced, SRIPL */
+#define PIC32MK_EVIC_IPTMR      0x0030u     /* Interrupt proximity timer */
+#define PIC32MK_EVIC_IFS0       0x0040u     /* Interrupt flag status [0..7] */
+#define PIC32MK_EVIC_IEC0       0x00C0u     /* Interrupt enable control [0..7] */
+#define PIC32MK_EVIC_IPC0       0x0140u     /* Interrupt priority control [0..63] */
+#define PIC32MK_EVIC_OFF0       0x0540u     /* Vector address offsets [0..190] */
+
+/*
+ * Number of interrupt sources / vectors.
+ * The EVIC IFS/IEC registers span 8×32 = 256 bits; USB1 (244) and USB2 (246)
+ * are in IFS7.  Use 256 to cover the full IPC/IFS table.
+ */
+#define PIC32MK_NUM_IRQ_SOURCES 256
+#define PIC32MK_NUM_VECTORS     190
+
+/*
+ * UART1 registers (§21, Table 21-2) — U1MODE base 0xBF828000
+ * Offset from SFR base: 0x028000
+ * -----------------------------------------------------------------------
+ */
+
+#define PIC32MK_UART1_OFFSET    0x028000u   /* SFR offset → physical 0x1F828000 */
+#define PIC32MK_UART1_SIZE      0x000050u   /* U1MODE..U1BRG+INV */
+
+/* Register offsets within the UART block (same layout for all UARTs) */
+#define PIC32MK_UxMODE          0x00u       /* Mode */
+#define PIC32MK_UxSTA           0x10u       /* Status & control */
+#define PIC32MK_UxTXREG         0x20u       /* TX data */
+#define PIC32MK_UxRXREG         0x30u       /* RX data */
+#define PIC32MK_UxBRG           0x40u       /* Baud rate */
+
+/* U1STA bits relevant to TX polling */
+#define PIC32MK_USTA_TRMT       (1u << 8)   /* TX shift register empty (1=empty) */
+#define PIC32MK_USTA_UTXBF      (1u << 9)   /* TX buffer full (0=not full) */
+
+/*
+ * CPU clock (§3)
+ * -----------------------------------------------------------------------
+ */
+
+#define PIC32MK_CPU_HZ          120000000u  /* 120 MHz max */
+
+/*
+ * Interrupt source numbers (§8, Table 8-1, DS60001519E)
+ * TODO: verify each number against the actual datasheet table.
+ * -----------------------------------------------------------------------
+ */
+
+#define PIC32MK_IRQ_CT          0    /* Core Timer */
+#define PIC32MK_IRQ_CS0         1    /* Core Software Interrupt 0 */
+#define PIC32MK_IRQ_CS1         2    /* Core Software Interrupt 1 */
+#define PIC32MK_IRQ_INT0        3    /* External Interrupt 0 */
+#define PIC32MK_IRQ_T1          4    /* Timer 1 */
+#define PIC32MK_IRQ_T2          9    /* Timer 2 */
+#define PIC32MK_IRQ_T3          14   /* Timer 3 */
+#define PIC32MK_IRQ_T4          19   /* Timer 4 */
+#define PIC32MK_IRQ_T5          24   /* Timer 5 */
+#define PIC32MK_IRQ_T6          28   /* Timer 6 */
+#define PIC32MK_IRQ_T7          32   /* Timer 7 */
+#define PIC32MK_IRQ_T8          36   /* Timer 8 */
+#define PIC32MK_IRQ_T9          40   /* Timer 9 */
+/* UART1: error=38, RX=39, TX=40  (IFS1 bits 6/7/8, p32mk1024mcm100.h) */
+#define PIC32MK_IRQ_U1E         38
+#define PIC32MK_IRQ_U1RX        39
+#define PIC32MK_IRQ_U1TX        40
+#define PIC32MK_IRQ_U2E         115
+#define PIC32MK_IRQ_U2RX        116
+#define PIC32MK_IRQ_U2TX        117
+#define PIC32MK_IRQ_U3E         118
+#define PIC32MK_IRQ_U3RX        119
+#define PIC32MK_IRQ_U3TX        120
+#define PIC32MK_IRQ_U4E         121
+#define PIC32MK_IRQ_U4RX        122
+#define PIC32MK_IRQ_U4TX        123
+#define PIC32MK_IRQ_U5E         124
+#define PIC32MK_IRQ_U5RX        125
+#define PIC32MK_IRQ_U5TX        126
+#define PIC32MK_IRQ_U6E         127
+#define PIC32MK_IRQ_U6RX        128
+#define PIC32MK_IRQ_U6TX        129
+/* CAN FD — single IRQ per instance (§8, Table 8-1, DS60001519E) */
+#define PIC32MK_IRQ_CAN1        167
+#define PIC32MK_IRQ_CAN2        168
+#define PIC32MK_IRQ_CAN3        187
+#define PIC32MK_IRQ_CAN4        188
+
+/*
+ * USB OTG — interrupt vector numbers from XC32 p32mk1024mcm100.h
+ * USB1: vector 34 → IFS1 bit 2, IPC8[18:16]
+ * USB2: vector 244 → IFS7 bit 20, IPC61[2:0]
+ */
+#define PIC32MK_IRQ_USB1        34
+#define PIC32MK_IRQ_USB2        244
+
+/* DMA channels 0-7 */
+#define PIC32MK_IRQ_DMA0        134
+#define PIC32MK_IRQ_DMA1        135
+#define PIC32MK_IRQ_DMA2        136
+#define PIC32MK_IRQ_DMA3        137
+#define PIC32MK_IRQ_DMA4        138
+#define PIC32MK_IRQ_DMA5        139
+#define PIC32MK_IRQ_DMA6        140
+#define PIC32MK_IRQ_DMA7        141
+
+/*
+ * GPIO Change-Notice interrupt vectors (DS60001519E Table 8-1,
+ * _CHANGE_NOTICE_x_VECTOR from p32mk1024mcm100.h)
+ */
+#define PIC32MK_IRQ_CNA         44
+#define PIC32MK_IRQ_CNB         45
+#define PIC32MK_IRQ_CNC         46
+#define PIC32MK_IRQ_CND         47
+#define PIC32MK_IRQ_CNE         48
+#define PIC32MK_IRQ_CNF         49
+#define PIC32MK_IRQ_CNG         50
+
+/*
+ * Timer peripheral registers (§14, DS60001519E)
+ * Offsets from PIC32MK_PER1_OFFSET (0xBF820000).
+ * Each timer block is 0x200 bytes; register stride 0x10 (with SET/CLR/INV).
+ * TODO: verify exact base offsets for PIC32MK GPK from Table 4-2.
+ * -----------------------------------------------------------------------
+ */
+
+/* Timer base offsets from SFR base */
+#define PIC32MK_T1_OFFSET       0x020000u   /* Timer 1 (Type A, 16-bit) */
+#define PIC32MK_T2_OFFSET       0x020200u   /* Timer 2 (Type B) */
+#define PIC32MK_T3_OFFSET       0x020400u   /* Timer 3 (Type C) */
+#define PIC32MK_T4_OFFSET       0x020600u   /* Timer 4 (Type B) */
+#define PIC32MK_T5_OFFSET       0x020800u   /* Timer 5 (Type C) */
+#define PIC32MK_T6_OFFSET       0x020A00u   /* Timer 6 (Type B) */
+#define PIC32MK_T7_OFFSET       0x020C00u   /* Timer 7 (Type C) */
+#define PIC32MK_T8_OFFSET       0x020E00u   /* Timer 8 (Type B) */
+#define PIC32MK_T9_OFFSET       0x021000u   /* Timer 9 (Type C) */
+
+#define PIC32MK_TIMER_BLOCK_SIZE    0x200u  /* per-timer SFR block */
+
+/* Timer register offsets within block (with SET/CLR/INV at +4/+8/+C) */
+#define PIC32MK_TxCON           0x00u   /* Control: ON, TCKPS, T32, TCS... */
+#define PIC32MK_TMRx            0x10u   /* Current count */
+#define PIC32MK_PRx             0x20u   /* Period register */
+
+/* TxCON bits */
+#define PIC32MK_TCON_ON         (1u << 15)  /* Timer ON */
+#define PIC32MK_TCON_T32        (1u << 3)   /* 32-bit mode (Type B only) */
+#define PIC32MK_TCON_TCS        (1u << 1)   /* Clock source select */
+#define PIC32MK_TCON_TCKPS_MASK 0x0070u     /* Prescaler bits [6:4] */
+#define PIC32MK_TCON_TCKPS_SHIFT    4
+
+/*
+ * OC (Output Compare) register offsets from SFR base (§19, DS60001519E)
+ * OC1-OC9:  0xBF824000..0xBF825000 (0x200 stride)
+ * OC10-OC16: 0xBF845200..0xBF845E00 (0x200 stride)
+ * -----------------------------------------------------------------------
+ */
+#define PIC32MK_OC1_OFFSET      0x024000u
+#define PIC32MK_OC2_OFFSET      0x024200u
+#define PIC32MK_OC3_OFFSET      0x024400u
+#define PIC32MK_OC4_OFFSET      0x024600u
+#define PIC32MK_OC5_OFFSET      0x024800u
+#define PIC32MK_OC6_OFFSET      0x024A00u
+#define PIC32MK_OC7_OFFSET      0x024C00u
+#define PIC32MK_OC8_OFFSET      0x024E00u
+#define PIC32MK_OC9_OFFSET      0x025000u
+#define PIC32MK_OC10_OFFSET     0x045200u
+#define PIC32MK_OC11_OFFSET     0x045400u
+#define PIC32MK_OC12_OFFSET     0x045600u
+#define PIC32MK_OC13_OFFSET     0x045800u
+#define PIC32MK_OC14_OFFSET     0x045A00u
+#define PIC32MK_OC15_OFFSET     0x045C00u
+#define PIC32MK_OC16_OFFSET     0x045E00u
+
+#define PIC32MK_OC_BLOCK_SIZE   0x200u
+
+/* OC register offsets within each 0x200-byte block */
+#define PIC32MK_OCxCON          0x00u   /* Control */
+#define PIC32MK_OCxR            0x10u   /* Primary compare value */
+#define PIC32MK_OCxRS           0x20u   /* Secondary compare value */
+
+/* OCxCON bits (Register 19-1) */
+#define PIC32MK_OCCON_ON        (1u << 15)
+#define PIC32MK_OCCON_SIDL      (1u << 13)
+#define PIC32MK_OCCON_OC32      (1u << 5)
+#define PIC32MK_OCCON_OCFLT     (1u << 4)
+#define PIC32MK_OCCON_OCTSEL    (1u << 3)
+#define PIC32MK_OCCON_OCM_MASK  0x0007u
+#define PIC32MK_OCCON_OCM_SHIFT 0
+
+/* OC interrupt vector numbers */
+#define PIC32MK_IRQ_OC1         7
+#define PIC32MK_IRQ_OC2         12
+#define PIC32MK_IRQ_OC3         17
+#define PIC32MK_IRQ_OC4         22
+#define PIC32MK_IRQ_OC5         27
+#define PIC32MK_IRQ_OC6         79
+#define PIC32MK_IRQ_OC7         83
+#define PIC32MK_IRQ_OC8         87
+#define PIC32MK_IRQ_OC9         91
+#define PIC32MK_IRQ_OC10        199
+#define PIC32MK_IRQ_OC11        202
+#define PIC32MK_IRQ_OC12        205
+#define PIC32MK_IRQ_OC13        208
+#define PIC32MK_IRQ_OC14        211
+#define PIC32MK_IRQ_OC15        214
+#define PIC32MK_IRQ_OC16        217
+
+/*
+ * Input Capture (IC1–IC16) — §18, DS60001519E
+ * IC1–IC9:   SFR bank 1, base 0xBF822000, stride 0x200
+ * IC10–IC16: SFR bank 2, base 0xBF843200, stride 0x200
+ * -----------------------------------------------------------------------
+ */
+#define PIC32MK_IC1_OFFSET      0x022000u
+#define PIC32MK_IC2_OFFSET      0x022200u
+#define PIC32MK_IC3_OFFSET      0x022400u
+#define PIC32MK_IC4_OFFSET      0x022600u
+#define PIC32MK_IC5_OFFSET      0x022800u
+#define PIC32MK_IC6_OFFSET      0x022A00u
+#define PIC32MK_IC7_OFFSET      0x022C00u
+#define PIC32MK_IC8_OFFSET      0x022E00u
+#define PIC32MK_IC9_OFFSET      0x023000u
+#define PIC32MK_IC10_OFFSET     0x043200u
+#define PIC32MK_IC11_OFFSET     0x043400u
+#define PIC32MK_IC12_OFFSET     0x043600u
+#define PIC32MK_IC13_OFFSET     0x043800u
+#define PIC32MK_IC14_OFFSET     0x043A00u
+#define PIC32MK_IC15_OFFSET     0x043C00u
+#define PIC32MK_IC16_OFFSET     0x043E00u
+
+#define PIC32MK_IC_BLOCK_SIZE   0x200u
+
+/* IC register offsets within each block */
+#define PIC32MK_ICxCON          0x00u   /* Control (+ SET/CLR/INV at +4/+8/+C) */
+#define PIC32MK_ICxBUF          0x10u   /* Capture buffer (read-only FIFO pop) */
+
+/* ICxCON bits (Register 18-1, DS60001519E) */
+#define PIC32MK_ICCON_ON        (1u << 15)  /* Module enable */
+#define PIC32MK_ICCON_SIDL      (1u << 13)  /* Stop in idle */
+#define PIC32MK_ICCON_FEDGE     (1u << 9)   /* First edge select */
+#define PIC32MK_ICCON_C32       (1u << 8)   /* 32-bit capture mode */
+#define PIC32MK_ICCON_ICTMR     (1u << 7)   /* Timer source select */
+#define PIC32MK_ICCON_ICI_MASK  0x0060u     /* Interrupt on every Nth capture [6:5] */
+#define PIC32MK_ICCON_ICI_SHIFT 5
+#define PIC32MK_ICCON_ICOV      (1u << 4)   /* Overflow (buffer full) */
+#define PIC32MK_ICCON_ICBNE     (1u << 3)   /* Buffer not empty */
+#define PIC32MK_ICCON_ICM_MASK  0x0007u     /* Capture mode [2:0] */
+
+/* IC IRQ numbers (Table 8-3, DS60001519E) — paired: error IRQ, capture IRQ */
+#define PIC32MK_IRQ_IC1E        5
+#define PIC32MK_IRQ_IC1         6
+#define PIC32MK_IRQ_IC2E        10
+#define PIC32MK_IRQ_IC2         11
+#define PIC32MK_IRQ_IC3E        15
+#define PIC32MK_IRQ_IC3         16
+#define PIC32MK_IRQ_IC4E        20
+#define PIC32MK_IRQ_IC4         21
+#define PIC32MK_IRQ_IC5E        25
+#define PIC32MK_IRQ_IC5         26
+#define PIC32MK_IRQ_IC6E        77
+#define PIC32MK_IRQ_IC6         78
+#define PIC32MK_IRQ_IC7E        81
+#define PIC32MK_IRQ_IC7         82
+#define PIC32MK_IRQ_IC8E        85
+#define PIC32MK_IRQ_IC8         86
+#define PIC32MK_IRQ_IC9E        89
+#define PIC32MK_IRQ_IC9         90
+#define PIC32MK_IRQ_IC10E       197
+#define PIC32MK_IRQ_IC10        198
+#define PIC32MK_IRQ_IC11E       200
+#define PIC32MK_IRQ_IC11        201
+#define PIC32MK_IRQ_IC12E       203
+#define PIC32MK_IRQ_IC12        204
+#define PIC32MK_IRQ_IC13E       206
+#define PIC32MK_IRQ_IC13        207
+#define PIC32MK_IRQ_IC14E       209
+#define PIC32MK_IRQ_IC14        210
+#define PIC32MK_IRQ_IC15E       212
+#define PIC32MK_IRQ_IC15        213
+#define PIC32MK_IRQ_IC16E       215
+#define PIC32MK_IRQ_IC16        216
+
+/* SPI1-6 IRQ numbers (Table 8-3, DS60001519E) */
+#define PIC32MK_IRQ_SPI1_FAULT  35
+#define PIC32MK_IRQ_SPI1_RX     36
+#define PIC32MK_IRQ_SPI1_TX     37
+#define PIC32MK_IRQ_SPI2_FAULT  53
+#define PIC32MK_IRQ_SPI2_RX     54
+#define PIC32MK_IRQ_SPI2_TX     55
+#define PIC32MK_IRQ_SPI3_FAULT  154
+#define PIC32MK_IRQ_SPI3_RX     155
+#define PIC32MK_IRQ_SPI3_TX     156
+#define PIC32MK_IRQ_SPI4_FAULT  166
+#define PIC32MK_IRQ_SPI4_RX     167
+#define PIC32MK_IRQ_SPI4_TX     168
+#define PIC32MK_IRQ_SPI5_FAULT  169
+#define PIC32MK_IRQ_SPI5_RX     170
+#define PIC32MK_IRQ_SPI5_TX     171
+#define PIC32MK_IRQ_SPI6_FAULT  172
+#define PIC32MK_IRQ_SPI6_RX     173
+#define PIC32MK_IRQ_SPI6_TX     174
+
+/*
+ * UART2–6 register base offsets from SFR base
+ * UART1 is already defined as PIC32MK_UART1_OFFSET = 0x028000
+ * TODO: verify exact offsets against DS60001519E Table 4-2.
+ * -----------------------------------------------------------------------
+ */
+
+#define PIC32MK_UART2_OFFSET    0x028200u   /* UART2 (PER1 block) */
+#define PIC32MK_UART3_OFFSET    0x048400u   /* UART3 (PER2 block, 0xBF848400) */
+#define PIC32MK_UART4_OFFSET    0x048600u   /* UART4 (0xBF848600) */
+#define PIC32MK_UART5_OFFSET    0x048800u   /* UART5 (0xBF848800) */
+#define PIC32MK_UART6_OFFSET    0x048A00u   /* UART6 (0xBF848A00) */
+
+#define PIC32MK_UART_BLOCK_SIZE 0x200u      /* per-UART SFR block */
+
+/* Additional UxSTA bits */
+#define PIC32MK_USTA_URXDA      (1u << 0)   /* RX data available */
+#define PIC32MK_USTA_OERR       (1u << 1)   /* Overrun error */
+#define PIC32MK_USTA_FERR       (1u << 2)   /* Framing error */
+#define PIC32MK_USTA_PERR       (1u << 3)   /* Parity error */
+#define PIC32MK_USTA_RIDLE      (1u << 4)   /* Receiver idle */
+#define PIC32MK_USTA_UTXEN      (1u << 10)  /* TX enable */
+#define PIC32MK_USTA_UTXISEL1   (1u << 14)  /* TX interrupt select */
+#define PIC32MK_USTA_URXEN      (1u << 12)  /* RX enable */
+#define PIC32MK_USTA_URXISEL1   (1u << 6)   /* RX interrupt select */
+#define PIC32MK_UMODE_ON        (1u << 15)  /* UART enable */
+
+/*
+ * SPI peripheral registers (§23, DS60001519E)
+ * TODO: verify exact base offsets.
+ * -----------------------------------------------------------------------
+ */
+
+#define PIC32MK_SPI1_OFFSET     0x021800u
+#define PIC32MK_SPI2_OFFSET     0x021A00u
+#define PIC32MK_SPI3_OFFSET     0x040800u
+#define PIC32MK_SPI4_OFFSET     0x040A00u
+#define PIC32MK_SPI5_OFFSET     0x047800u   /* 0xBF847800 */
+#define PIC32MK_SPI6_OFFSET     0x040E00u
+#define PIC32MK_SPI_BLOCK_SIZE  0x200u
+
+/* SPI register offsets within block */
+#define PIC32MK_SPIxCON         0x00u
+#define PIC32MK_SPIxSTAT        0x10u
+#define PIC32MK_SPIxBUF         0x20u
+#define PIC32MK_SPIxBRG         0x30u
+#define PIC32MK_SPIxCON2        0x40u
+
+/*
+ * I2C peripheral registers (§24, DS60001519E)
+ * TODO: verify exact base offsets.
+ * -----------------------------------------------------------------------
+ */
+
+#define PIC32MK_I2C1_OFFSET     0x026000u   /* 0xBF826000 — §24, Table 4-2 */
+#define PIC32MK_I2C2_OFFSET     0x026200u   /* 0xBF826200 */
+#define PIC32MK_I2C3_OFFSET     0x046400u   /* 0xBF846400 (PER2 bank) */
+#define PIC32MK_I2C4_OFFSET     0x046600u   /* 0xBF846600 */
+#define PIC32MK_I2C_BLOCK_SIZE  0x200u
+
+/* I2C register offsets within block */
+#define PIC32MK_I2CxCON        0x00u
+#define PIC32MK_I2CxSTAT       0x10u
+#define PIC32MK_I2CxADD        0x20u
+#define PIC32MK_I2CxMSK        0x30u
+#define PIC32MK_I2CxTRN        0x40u
+#define PIC32MK_I2CxRCV        0x50u
+
+/*
+ * GPIO peripheral registers (§12, DS60001519E)
+ * Base: PIC32MK_GPIO_OFFSET = 0x060000 (0xBF860000)
+ * Each port (A–G) occupies 0x100 bytes.
+ * -----------------------------------------------------------------------
+ */
+
+#define PIC32MK_GPIO_PORT_SIZE  0x100u      /* per-port register block */
+
+/* GPIO register offsets within each port block */
+#define PIC32MK_ANSEL           0x00u   /* Analog select */
+#define PIC32MK_TRIS            0x10u   /* Direction (1=input) */
+#define PIC32MK_PORT            0x20u   /* Read pin state */
+#define PIC32MK_LAT             0x30u   /* Latch (write output) */
+#define PIC32MK_ODC             0x40u   /* Open-drain control */
+#define PIC32MK_CNPU            0x50u   /* Change-notice pull-up */
+#define PIC32MK_CNPD            0x60u   /* Change-notice pull-down */
+#define PIC32MK_CNCON           0x70u   /* Change-notice control */
+#define PIC32MK_CNEN0           0x80u   /* CN edge enable 0 */
+#define PIC32MK_CNSTAT          0x90u   /* CN status */
+#define PIC32MK_CNEN1           0xA0u   /* CN edge enable 1 */
+#define PIC32MK_CNF             0xB0u   /* CN flag */
+
+/* Number of GPIO ports (A–G) */
+#define PIC32MK_GPIO_NPORTS     7
+
+/*
+ * Set shared chardev for GPIO state-change event streaming.
+ * Called from board init; multiple ports share the same Chardev*.
+ */
+void pic32mk_gpio_set_chardev(DeviceState *dev, Chardev *chr);
+void pic32mk_oc_set_chardev(DeviceState *dev, Chardev *chr);
+
+/*
+ * DMA controller registers (§26, DS60001519E)
+ * Base: PIC32MK_DMA_OFFSET = 0x011000 (within EVIC page, 0xBF811000)
+ * Global registers at base, then 8 channel blocks at +0x60 each.
+ * -----------------------------------------------------------------------
+ */
+
+/* DMA global registers */
+#define PIC32MK_DMACON_OFFSET   0x00u   /* DMA control */
+#define PIC32MK_DMASTAT_OFFSET  0x10u   /* DMA status */
+#define PIC32MK_DMAADDR_OFFSET  0x20u   /* DMA address */
+
+/* DMA channel registers base: +0x60 + channel * 0xC0 */
+#define PIC32MK_DMA_CH_BASE     0x60u
+#define PIC32MK_DMA_CH_STRIDE   0xC0u
+#define PIC32MK_DMA_NCHANNELS   8
+
+/* DMA channel register offsets within each channel block */
+#define PIC32MK_DCHxCON         0x00u
+#define PIC32MK_DCHxECON        0x10u
+#define PIC32MK_DCHxINT         0x20u
+#define PIC32MK_DCHxSSA         0x30u
+#define PIC32MK_DCHxDSA         0x40u
+#define PIC32MK_DCHxSSIZ        0x50u
+#define PIC32MK_DCHxDSIZ        0x60u
+#define PIC32MK_DCHxSPTR        0x70u
+#define PIC32MK_DCHxDPTR        0x80u
+#define PIC32MK_DCHxCSIZ        0x90u
+#define PIC32MK_DCHxCPTR        0xA0u
+#define PIC32MK_DCHxDAT         0xB0u
+
+/*
+ * ADCHS peripheral registers (§22, DS60001519E)
+ * Base: 0xBF887000 (SFR offset 0x087000)
+ * Register block spans ~4 KB (0x000–0xE1C).
+ * Each register has SET/CLR/INV aliases at +4/+8/+C.
+ * -----------------------------------------------------------------------
+ */
+
+#define PIC32MK_ADC_OFFSET      0x087000u   /* 0xBF887000 */
+#define PIC32MK_ADC_SIZE        0x001000u   /* 4 KB register window */
+
+/* Control registers */
+#define PIC32MK_ADCCON1         0x000u
+#define PIC32MK_ADCCON2         0x010u
+#define PIC32MK_ADCCON3         0x020u
+#define PIC32MK_ADCTRGMODE      0x030u
+
+/* Input mode control (signed/unsigned per channel group) */
+#define PIC32MK_ADCIMCON1       0x040u
+#define PIC32MK_ADCIMCON2       0x050u
+#define PIC32MK_ADCIMCON3       0x060u
+#define PIC32MK_ADCIMCON4       0x070u
+
+/* Global interrupt enable (result ready, 2 × 32 bits) */
+#define PIC32MK_ADCGIRQEN1      0x080u
+#define PIC32MK_ADCGIRQEN2      0x090u
+
+/* Channel scan select */
+#define PIC32MK_ADCCSS1         0x0A0u
+#define PIC32MK_ADCCSS2         0x0B0u
+
+/* Data ready status */
+#define PIC32MK_ADCDSTAT1       0x0C0u
+#define PIC32MK_ADCDSTAT2       0x0D0u
+
+/* Compare enable */
+#define PIC32MK_ADCCMPEN1       0x0E0u
+#define PIC32MK_ADCCMPEN2       0x100u
+#define PIC32MK_ADCCMPEN3       0x120u
+#define PIC32MK_ADCCMPEN4       0x140u
+
+/* Compare values */
+#define PIC32MK_ADCCMP1         0x0F0u
+#define PIC32MK_ADCCMP2         0x110u
+#define PIC32MK_ADCCMP3         0x130u
+#define PIC32MK_ADCCMP4         0x150u
+
+/* Digital filter registers */
+#define PIC32MK_ADCFLTR1        0x1A0u
+#define PIC32MK_ADCFLTR2        0x1B0u
+#define PIC32MK_ADCFLTR3        0x1C0u
+#define PIC32MK_ADCFLTR4        0x1D0u
+
+/* Trigger configuration */
+#define PIC32MK_ADCTRG1         0x200u
+#define PIC32MK_ADCTRG2         0x210u
+#define PIC32MK_ADCTRG3         0x220u
+#define PIC32MK_ADCTRG4         0x230u
+#define PIC32MK_ADCTRG5         0x240u
+#define PIC32MK_ADCTRG6         0x250u
+#define PIC32MK_ADCTRG7         0x260u
+
+/* Compare control */
+#define PIC32MK_ADCCMPCON1      0x280u
+#define PIC32MK_ADCCMPCON2      0x290u
+#define PIC32MK_ADCCMPCON3      0x2A0u
+#define PIC32MK_ADCCMPCON4      0x2B0u
+
+/* Misc registers */
+#define PIC32MK_ADCBASE         0x300u
+#define PIC32MK_ADCTRGSNS       0x340u
+
+/* Sampling time (per-module) */
+#define PIC32MK_ADC0TIME        0x350u
+#define PIC32MK_ADC1TIME        0x360u
+#define PIC32MK_ADC2TIME        0x370u
+#define PIC32MK_ADC3TIME        0x380u
+#define PIC32MK_ADC4TIME        0x390u
+#define PIC32MK_ADC5TIME        0x3A0u
+
+/* Early interrupt enable / status */
+#define PIC32MK_ADCEIEN1        0x3C0u
+#define PIC32MK_ADCEIEN2        0x3D0u
+#define PIC32MK_ADCEISTAT1      0x3E0u
+#define PIC32MK_ADCEISTAT2      0x3F0u
+
+/* Analog module enable / warm-up control */
+#define PIC32MK_ADCANCON        0x400u
+
+/* Conversion data registers (stride 0x10 per channel index) */
+#define PIC32MK_ADCDATA_BASE    0x600u
+#define PIC32MK_ADCDATA_STRIDE  0x010u
+
+/* Per-module configuration */
+#define PIC32MK_ADC0CFG         0xD00u
+#define PIC32MK_ADC1CFG         0xD10u
+#define PIC32MK_ADC2CFG         0xD20u
+#define PIC32MK_ADC3CFG         0xD30u
+#define PIC32MK_ADC4CFG         0xD40u
+#define PIC32MK_ADC5CFG         0xD50u
+#define PIC32MK_ADC6CFG         0xD60u
+#define PIC32MK_ADC7CFG         0xD70u
+
+/* System configuration */
+#define PIC32MK_ADCSYSCFG0      0xE00u
+#define PIC32MK_ADCSYSCFG1      0xE10u
+
+/* Maximum channel index (0–53, with gaps) */
+#define PIC32MK_ADC_MAX_CH      54
+
+/* ADCCON1 bits */
+#define PIC32MK_ADCCON1_ON      (1u << 15)
+
+/* ADCCON2 bits */
+#define PIC32MK_ADCCON2_BGVRRDY (1u << 31)  /* Band-gap voltage ref ready */
+#define PIC32MK_ADCCON2_REFFLT  (1u << 30)  /* Reference fault */
+
+/* ADCCON3 bits */
+#define PIC32MK_ADCCON3_ADINSEL_MASK  0x3Fu        /* bits [5:0] channel select */
+#define PIC32MK_ADCCON3_RQCNVRT (1u << 8)          /* Request conversion */
+#define PIC32MK_ADCCON3_GSWTRG  (1u << 6)          /* Global software trigger */
+#define PIC32MK_ADCCON3_GLSWTRG (1u << 5)          /* Global level SW trigger */
+#define PIC32MK_ADCCON3_DIGEN_SHIFT  16             /* DIGENx at bits [23:16] */
+
+/* ADCANCON bits — ANENx and WKRDYx (modules 0–5, 7) */
+#define PIC32MK_ADCANCON_ANEN_SHIFT   0             /* ANENx at bits [7:0] */
+#define PIC32MK_ADCANCON_WKRDY_SHIFT  8             /* WKRDYx at bits [15:8] */
+
+/*
+ * ADCHS interrupt source numbers (§8, Table 8-1) — vector/IRQ numbers
+ * -----------------------------------------------------------------------
+ */
+
+#define PIC32MK_IRQ_ADC         92   /* Main ADC interrupt */
+#define PIC32MK_IRQ_ADC_DC1     94   /* Digital comparator 1 */
+#define PIC32MK_IRQ_ADC_DC2     95   /* Digital comparator 2 */
+#define PIC32MK_IRQ_ADC_DF1     96   /* Digital filter 1 */
+#define PIC32MK_IRQ_ADC_DF2     97   /* Digital filter 2 */
+#define PIC32MK_IRQ_ADC_DF3     98   /* Digital filter 3 */
+#define PIC32MK_IRQ_ADC_DF4     99   /* Digital filter 4 */
+#define PIC32MK_IRQ_ADC_FAULT   100  /* ADC fault */
+#define PIC32MK_IRQ_ADC_EOS     101  /* End of scan */
+#define PIC32MK_IRQ_ADC_ARDY    102  /* Analog ready */
+#define PIC32MK_IRQ_ADC_URDY    103  /* Update ready */
+#define PIC32MK_IRQ_ADC_DMA     104  /* DMA */
+#define PIC32MK_IRQ_ADC_EARLY   105  /* Early interrupt */
+#define PIC32MK_IRQ_ADC_DATA0   106  /* Data ready channel 0 (base) */
+/* DATA1..DATA27 = 107..133, DATA33..41 = 139..147, DATA45..53 = 151..159 */
+#define PIC32MK_IRQ_ADC_DC3     245  /* Digital comparator 3 */
+#define PIC32MK_IRQ_ADC_DC4     246  /* Digital comparator 4 */
+
+/*
+ * NVM / Flash Controller (§10, DS60001519E)
+ * Base: 0xBF800A00 (SFR offset 0x000A00)
+ * Register block: NVMCON, NVMKEY, NVMADDR, NVMDATA0–3, NVMSRCADDR,
+ * NVMPWP, NVMBWP, NVMCON2 (each 0x10 stride with SET/CLR/INV aliases,
+ * except NVMKEY which is write-only, no aliases).
+ * -----------------------------------------------------------------------
+ */
+
+#define PIC32MK_NVM_OFFSET      0x000A00u   /* 0xBF800A00 */
+#define PIC32MK_NVM_SIZE        0x0000B0u   /* NVMCON..NVMCON2+INV inclusive */
+
+/* Register offsets within the NVM block */
+#define PIC32MK_NVMCON          0x00u       /* +CLR/SET/INV at +4/+8/+C */
+#define PIC32MK_NVMKEY          0x10u
+#define PIC32MK_NVMADDR         0x20u       /* +CLR/SET/INV */
+#define PIC32MK_NVMDATA0        0x30u       /* +CLR/SET/INV */
+#define PIC32MK_NVMDATA1        0x40u
+#define PIC32MK_NVMDATA2        0x50u
+#define PIC32MK_NVMDATA3        0x60u
+#define PIC32MK_NVMSRCADDR      0x70u       /* +CLR/SET/INV */
+#define PIC32MK_NVMPWP          0x80u
+#define PIC32MK_NVMBWP          0x90u
+#define PIC32MK_NVMCON2         0xA0u
+
+/* NVMCON bits */
+#define PIC32MK_NVMCON_NVMOP_MASK  0x000Fu  /* bits [3:0] */
+#define PIC32MK_NVMCON_BFSWAP     (1u << 6)
+#define PIC32MK_NVMCON_PFSWAP     (1u << 7)
+#define PIC32MK_NVMCON_LVDERR     (1u << 12)
+#define PIC32MK_NVMCON_WRERR      (1u << 13)
+#define PIC32MK_NVMCON_WREN       (1u << 14)
+#define PIC32MK_NVMCON_WR         (1u << 15)
+
+/* NVM operation codes (NVMOP field, bits [3:0]) */
+#define PIC32MK_NVMOP_NOP              0x0u
+#define PIC32MK_NVMOP_WORD_PROG        0x1u
+#define PIC32MK_NVMOP_QUAD_WORD_PROG   0x2u
+#define PIC32MK_NVMOP_ROW_PROG         0x3u
+#define PIC32MK_NVMOP_PAGE_ERASE       0x4u
+#define PIC32MK_NVMOP_LOWER_PFM_ERASE  0x5u
+#define PIC32MK_NVMOP_UPPER_PFM_ERASE  0x6u
+#define PIC32MK_NVMOP_PFM_ERASE        0x7u
+
+/* Unlock keys (written sequentially to NVMKEY) */
+#define PIC32MK_NVMKEY1         0xAA996655u
+#define PIC32MK_NVMKEY2         0x556699AAu
+
+/* Flash geometry */
+#define PIC32MK_NVM_PAGE_SIZE   4096u       /* erase granularity */
+#define PIC32MK_NVM_ROW_SIZE    512u        /* write-row granularity */
+
+/* Interrupt — Flash Control Error vector 31 */
+#define PIC32MK_IRQ_FCE         31
+
+/*
+ * Data EEPROM (§11, DS60001519E)
+ * Base: 0xBF829000 (SFR offset 0x029000)
+ * Register block: EECON, EEKEY, EEADDR, EEDATA (each 0x10 stride with
+ * SET/CLR/INV aliases, except EEKEY which is write-only, no aliases).
+ * -----------------------------------------------------------------------
+ */
+
+#define PIC32MK_DATAEE_OFFSET   0x029000u   /* 0xBF829000 */
+#define PIC32MK_DATAEE_SIZE     0x000040u   /* EECON..EEDATA+INV inclusive */
+
+/* Register offsets within the DATAEE block */
+#define PIC32MK_EECON           0x00u
+#define PIC32MK_EEKEY           0x10u
+#define PIC32MK_EEADDR          0x20u
+#define PIC32MK_EEDATA_REG      0x30u       /* "_REG" avoids clash with EEDATA macro */
+
+/* EECON bits (p32mk1024mcm100.h) */
+#define PIC32MK_EECON_CMD_MASK  0x00000007u /* bits [2:0] */
+#define PIC32MK_EECON_CMD_SHIFT 0
+#define PIC32MK_EECON_ILW       (1u << 3)
+#define PIC32MK_EECON_ERR_MASK  0x00000030u /* bits [5:4] */
+#define PIC32MK_EECON_ERR_SHIFT 4
+#define PIC32MK_EECON_WREN      (1u << 6)
+#define PIC32MK_EECON_RW        (1u << 7)
+#define PIC32MK_EECON_ABORT     (1u << 12)
+#define PIC32MK_EECON_SIDL      (1u << 13)
+#define PIC32MK_EECON_RDY       (1u << 14)
+#define PIC32MK_EECON_ON        (1u << 15)
+
+/* EEADDR valid bits — 14-bit, word-aligned */
+#define PIC32MK_EEADDR_MASK     0x00003FFCu
+
+/* EEPROM storage geometry */
+#define PIC32MK_DATAEE_WORDS        1024    /* 4 KB = 1024 × 32-bit words */
+#define PIC32MK_DATAEE_PAGE_WORDS   32      /* 128-byte page */
+
+/* Unlock keys (written sequentially to EEKEY) */
+#define PIC32MK_EEKEY1          0xEDB7u
+#define PIC32MK_EEKEY2          0x1248u
+
+/* EECON CMD field values */
+#define PIC32MK_EECMD_WORD_READ     0
+#define PIC32MK_EECMD_WORD_WRITE    1
+#define PIC32MK_EECMD_PAGE_ERASE    2
+#define PIC32MK_EECMD_BULK_ERASE    3
+#define PIC32MK_EECMD_CONFIG_WRITE  4
+
+/* Interrupt — Data EEPROM vector 186 */
+#define PIC32MK_IRQ_DATAEE      186
+
+#endif /* HW_MIPS_PIC32MK_H */
diff --git a/include/hw/mips/pic32mk_adchs.h b/include/hw/mips/pic32mk_adchs.h
new file mode 100644
index 0000000000..2c4149c3a3
--- /dev/null
+++ b/include/hw/mips/pic32mk_adchs.h
@@ -0,0 +1,87 @@
+/*
+ * PIC32MK ADCHS (High-Speed ADC) peripheral — device interface
+ * Datasheet: DS60001519E, §22
+ *
+ * Copyright (c) 2026 QEMU contributors
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MIPS_PIC32MK_ADCHS_H
+#define HW_MIPS_PIC32MK_ADCHS_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+#include "hw/mips/pic32mk.h"
+
+#define TYPE_PIC32MK_ADCHS  "pic32mk-adchs"
+OBJECT_DECLARE_SIMPLE_TYPE(PIC32MKADCHSState, PIC32MK_ADCHS)
+
+struct PIC32MKADCHSState {
+    SysBusDevice parent_obj;
+    MemoryRegion mr;
+
+    /* Control registers */
+    uint32_t adccon1;
+    uint32_t adccon2;
+    uint32_t adccon3;
+    uint32_t adctrgmode;
+
+    /* Input mode control */
+    uint32_t adcimcon[4];
+
+    /* Interrupt enable (result ready) */
+    uint32_t adcgirqen[2];
+
+    /* Channel scan select */
+    uint32_t adccss[2];
+
+    /* Data ready status */
+    uint32_t adcdstat[2];
+
+    /* Compare enable & values */
+    uint32_t adccmpen[4];
+    uint32_t adccmp[4];
+    uint32_t adccmpcon[4];
+
+    /* Digital filters */
+    uint32_t adcfltr[4];
+
+    /* Trigger configuration */
+    uint32_t adctrg[7];
+    uint32_t adctrgsns;
+
+    /* Sampling time per module */
+    uint32_t adctime[6];   /* ADC0TIME … ADC5TIME */
+
+    /* Early interrupt enable / status */
+    uint32_t adceien[2];
+    uint32_t adceistat[2];
+
+    /* Analog module control */
+    uint32_t adcancon;
+
+    /* Misc */
+    uint32_t adcbase;
+
+    /* Per-module configuration */
+    uint32_t adccfg[8];    /* ADC0CFG … ADC7CFG */
+
+    /* System configuration */
+    uint32_t adcsyscfg[2];
+
+    /* Conversion data registers (indexed by channel 0–53) */
+    uint32_t adcdata[PIC32MK_ADC_MAX_CH];
+
+    /*
+     * Host-injectable analog input values (12-bit, 0–4095).
+     * When a conversion is triggered, analog_input[ch] is copied to
+     * adcdata[ch].  Set via QOM property "adc-ch<N>".
+     */
+    uint16_t analog_input[PIC32MK_ADC_MAX_CH];
+
+    /* IRQ outputs to EVIC */
+    qemu_irq irq_eos;     /* End-of-scan  (IRQ 101) */
+    qemu_irq irq_main;    /* Main ADC     (IRQ 92)  */
+};
+
+#endif /* HW_MIPS_PIC32MK_ADCHS_H */
diff --git a/include/hw/mips/pic32mk_canfd.h b/include/hw/mips/pic32mk_canfd.h
new file mode 100644
index 0000000000..3408c54e31
--- /dev/null
+++ b/include/hw/mips/pic32mk_canfd.h
@@ -0,0 +1,210 @@
+/*
+ * Microchip PIC32MK CAN FD controller — device interface
+ * Based on PIC32MK GPK/MCM with CAN FD Family Datasheet (DS60001519E)
+ * and Microchip CAN FD Controller Reference Manual (DS60001507).
+ *
+ * Copyright (c) 2026 QEMU contributors
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MIPS_PIC32MK_CANFD_H
+#define HW_MIPS_PIC32MK_CANFD_H
+
+#include "hw/core/sysbus.h"
+#include "net/can_emu.h"
+#include "qom/object.h"
+
+#define TYPE_PIC32MK_CANFD  "pic32mk-canfd"
+OBJECT_DECLARE_SIMPLE_TYPE(PIC32MKCANFDState, PIC32MK_CANFD)
+
+/*
+ * CAN FD SFR register offsets (from instance base).
+ *
+ * Layout verified against XC32 device header p32mk1024mcm100.h.
+ * Each logical register occupies 0x10 bytes:
+ *   +0x0 = base, +0x4 = SET, +0x8 = CLR, +0xC = INV
+ * -----------------------------------------------------------------------
+ */
+
+#define CANFD_CiCON         0x000u  /* Control */
+#define CANFD_CiNBTCFG      0x010u  /* Nominal bit-time config */
+#define CANFD_CiDBTCFG      0x020u  /* Data bit-time config */
+#define CANFD_CiTDC         0x030u  /* Transmitter delay compensation */
+#define CANFD_CiTBC         0x040u  /* Time base counter */
+#define CANFD_CiTSCON       0x050u  /* Timestamp control */
+#define CANFD_CiVEC         0x060u  /* Interrupt flag code */
+#define CANFD_CiINT         0x070u  /* Interrupt aggregator */
+#define CANFD_CiRXIF        0x080u  /* RX interrupt flags per FIFO */
+#define CANFD_CiTXIF        0x090u  /* TX interrupt flags per FIFO */
+#define CANFD_CiRXOVIF      0x0A0u  /* RX overflow flags per FIFO */
+#define CANFD_CiTXATIF      0x0B0u  /* TX attempts interrupt flags */
+#define CANFD_CiTXREQ       0x0C0u  /* TX request bits per FIFO */
+#define CANFD_CiTREC        0x0D0u  /* TX/RX error counters */
+#define CANFD_CiBDIAG0      0x0E0u  /* Bus diagnostic 0 */
+#define CANFD_CiBDIAG1      0x0F0u  /* Bus diagnostic 1 */
+#define CANFD_CiTEFCON      0x100u  /* TX Event FIFO control */
+#define CANFD_CiTEFSTA      0x110u  /* TX Event FIFO status */
+#define CANFD_CiTEFUA       0x120u  /* TX Event FIFO user address */
+#define CANFD_CiFIFOBA      0x130u  /* Message RAM base address (Phase 3C) */
+#define CANFD_CiTXQCON      0x140u  /* TX Queue control */
+#define CANFD_CiTXQSTA      0x150u  /* TX Queue status */
+#define CANFD_CiTXQUA       0x160u  /* TX Queue user address */
+/* FIFO n (n=1..31): stride 0x30 (3 registers × 0x10 each) */
+#define CANFD_CiFIFOCON(n)  (0x170u + ((n) - 1u) * 0x30u)
+#define CANFD_CiFIFOSTA(n)  (0x180u + ((n) - 1u) * 0x30u)
+#define CANFD_CiFIFOUA(n)   (0x190u + ((n) - 1u) * 0x30u)
+/* Filter control: stride 0x10 per register, 8 registers */
+#define CANFD_CiFLTCON(r)   (0x740u + (r) * 0x10u)
+/* Filter object/mask pairs: stride 0x20 per pair */
+#define CANFD_CiFLTOBJ(n)   (0x7C0u + (n) * 0x20u)
+#define CANFD_CiMASK(n)     (0x7D0u + (n) * 0x20u)
+
+/*
+ * CiCON bit fields
+ * -----------------------------------------------------------------------
+ */
+/*
+ * CiCON field positions verified against DS60001519E / MCP251xFD IP core:
+ *   reset value 0x04980760 → REQOP=4 (Config), OPMOD=4 (Config)
+ */
+#define CANFD_CON_REQOP_SHIFT   24u
+#define CANFD_CON_REQOP_MASK    (0x7u << CANFD_CON_REQOP_SHIFT)
+#define CANFD_CON_OPMOD_SHIFT   21u
+#define CANFD_CON_OPMOD_MASK    (0x7u << CANFD_CON_OPMOD_SHIFT)
+#define CANFD_CON_TXQEN         (1u << 20u)
+#define CANFD_CON_STEF          (1u << 19u)
+#define CANFD_CON_ABAT          (1u << 27u)
+#define CANFD_CON_RESET         0x04980760u  /* Config mode on reset */
+
+/* OPMOD values */
+#define CANFD_OPMOD_NORMAL      0u
+#define CANFD_OPMOD_RESTRICTED  1u
+#define CANFD_OPMOD_LISTEN      2u
+#define CANFD_OPMOD_CONFIG      4u
+#define CANFD_OPMOD_EXT_LOOP    5u
+#define CANFD_OPMOD_INT_LOOP    7u
+
+/*
+ * CiINT bit fields — verified against XC32 p32mk1024mcm100.h
+ * Lower 16 bits = status flags, upper 16 bits = enable bits.
+ * -----------------------------------------------------------------------
+ */
+#define CANFD_INT_TXIF      (1u << 0u)   /* TX FIFO interrupt flag */
+#define CANFD_INT_RXIF      (1u << 1u)   /* RX FIFO interrupt flag */
+#define CANFD_INT_MODIF     (1u << 3u)   /* Mode change flag */
+#define CANFD_INT_TEFIF     (1u << 4u)   /* TEF interrupt flag */
+#define CANFD_INT_TXATIF    (1u << 10u)  /* TX attempts flag */
+#define CANFD_INT_RXOVIF    (1u << 11u)  /* RX overflow flag */
+#define CANFD_INT_TXIE      (1u << 16u)  /* TX IRQ enable */
+#define CANFD_INT_RXIE      (1u << 17u)  /* RX IRQ enable */
+#define CANFD_INT_MODIE     (1u << 19u)  /* Mode change IRQ enable */
+#define CANFD_INT_RXOVIE    (1u << 27u)  /* RX overflow IRQ enable */
+#define CANFD_INT_SERRIE    (1u << 28u)  /* System error IRQ enable */
+#define CANFD_INT_CERRIE    (1u << 29u)  /* CAN bus error IRQ enable */
+#define CANFD_INT_IVMIE     (1u << 31u)  /* Invalid message IRQ enable */
+
+/*
+ * CiFIFOCONn / CiTXQCON bit fields
+ * Bit positions verified against XC32 p32mk1024mcm100.h device header.
+ * -----------------------------------------------------------------------
+ */
+#define CANFD_FIFO_PLSIZE_SHIFT 29u
+#define CANFD_FIFO_PLSIZE_MASK  (0x7u << CANFD_FIFO_PLSIZE_SHIFT)
+#define CANFD_FIFO_FSIZE_SHIFT  24u
+#define CANFD_FIFO_FSIZE_MASK   (0x1Fu << CANFD_FIFO_FSIZE_SHIFT)
+#define CANFD_FIFO_TFNRFNIE     (1u << 0u)   /* RX: FIFO Not Empty interrupt enable */
+#define CANFD_FIFO_TXEN         (1u << 7u)   /* TX enable (1=TX FIFO, 0=RX FIFO) */
+#define CANFD_FIFO_UINC         (1u << 8u)   /* User increment (pulse bit) */
+#define CANFD_FIFO_TXREQ        (1u << 9u)   /* TX request (pulse bit) */
+#define CANFD_FIFO_FRESET       (1u << 10u)  /* FIFO reset (pulse bit) */
+
+/* CiFIFOSTAn bit fields — verified against XC32 device header */
+#define CANFD_FIFOSTA_TFNRFNIF  (1u << 0u)  /* TX not full / RX not empty */
+#define CANFD_FIFOSTA_TXATIF    (1u << 4u)  /* TX attempts exhausted */
+#define CANFD_TXQSTA_TXQNIF     (1u << 0u)  /* CiTXQSTA: TX Queue not full */
+
+/*
+ * Device state
+ * -----------------------------------------------------------------------
+ */
+
+struct PIC32MKCANFDState {
+    SysBusDevice parent_obj;
+
+    /* Two MemoryRegions per instance */
+    MemoryRegion sfr_mmio;   /* SFR registers: PIC32MK_CAN_SFR_SIZE bytes */
+    MemoryRegion msg_ram;    /* Message RAM: PIC32MK_CAN_MSGRAM_SIZE bytes */
+
+    /* Key SFRs (reset values per DS60001507 §3) */
+    uint32_t con;            /* CiCON  — reset 0x04980760 */
+    uint32_t nbtcfg;         /* CiNBTCFG */
+    uint32_t dbtcfg;         /* CiDBTCFG */
+    uint32_t tdc;            /* CiTDC */
+    uint32_t tbc;            /* CiTBC (free-running) */
+    uint32_t tscon;          /* CiTSCON */
+    uint32_t vec;            /* CiVEC */
+    uint32_t cint;           /* CiINT */
+    uint32_t rxif;           /* CiRXIF */
+    uint32_t txif;           /* CiTXIF */
+    uint32_t rxovif;         /* CiRXOVIF */
+    uint32_t txreq;          /* CiTXREQ */
+    uint32_t trec;           /* CiTREC */
+
+    /* TXQ */
+    uint32_t txqcon;
+    uint32_t txqsta;
+    uint32_t txqua;
+    uint8_t  txq_head;       /* oldest pending frame (TX processes from here) */
+    uint8_t  txq_tail;       /* next empty slot firmware will write to */
+    uint8_t  txq_count;      /* number of frames queued */
+
+    /* TEF */
+    uint32_t tefcon;
+    uint32_t tefsta;
+    uint32_t tefua;
+
+    /* Per-FIFO state (index 1–31; [0] unused) */
+    uint32_t fifocon[32];
+    uint32_t fifosta[32];
+    uint32_t fifoua[32];
+    uint8_t  fifo_head[32];
+    uint8_t  fifo_tail[32];
+    uint8_t  fifo_count[32];
+
+    /* Acceptance filters */
+    uint32_t fltcon[8];      /* 4 filters per reg × 8 = 32 filters */
+    uint32_t fltobj[32];
+    uint32_t mask[32];
+
+    /* Message RAM backing store */
+    uint8_t  *msg_ram_buf;
+    uint32_t  msg_ram_phys;  /* physical base (injected via property) */
+
+    /* Instance index (0–3 for CAN1–4) */
+    uint32_t  instance_id;
+
+    /* Single IRQ line to EVIC */
+    qemu_irq irq;
+
+    /* SocketCAN virtual bus (Phase 3B) */
+    CanBusClientState bus_client;
+    CanBusState      *canbus;   /* linked can-bus object, or NULL */
+
+    /*
+     * Bus-side software ring buffer — decouples SocketCAN delivery timing
+     * from the guest CPU.  Frames land here when the target RX FIFO is full;
+     * canfd_bus_buf_drain() moves them into the FIFO after each UINC.
+      */
+    uint32_t bus_buf_id[64];
+    bool     bus_buf_xtd[64];
+    bool     bus_buf_fdf[64];
+    uint8_t  bus_buf_dlc[64];
+    uint8_t  bus_buf_data[64][64];
+    int      bus_buf_len[64];
+    int      bus_buf_dest[64];
+    int      bus_buf_head;
+    int      bus_buf_tail;
+    int      bus_buf_count;
+};
+
+#endif /* HW_MIPS_PIC32MK_CANFD_H */
diff --git a/include/hw/mips/pic32mk_evic.h b/include/hw/mips/pic32mk_evic.h
new file mode 100644
index 0000000000..207309719c
--- /dev/null
+++ b/include/hw/mips/pic32mk_evic.h
@@ -0,0 +1,45 @@
+/*
+ * PIC32MK EVIC — public API header
+ *
+ * Copyright (c) 2026 QEMU contributors
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MIPS_PIC32MK_EVIC_H
+#define HW_MIPS_PIC32MK_EVIC_H
+
+#include "qom/object.h"
+#include "hw/core/sysbus.h"
+#include "hw/core/irq.h"
+#include "hw/mips/pic32mk.h"
+#include "cpu.h"
+
+#define TYPE_PIC32MK_EVIC   "pic32mk-evic"
+OBJECT_DECLARE_SIMPLE_TYPE(PIC32MKEVICState, PIC32MK_EVIC)
+
+struct PIC32MKEVICState {
+    SysBusDevice parent_obj;
+    MemoryRegion mr;
+
+    uint32_t intcon;
+    uint32_t priss;
+    uint32_t intstat;
+    uint32_t iptmr;
+
+    uint32_t ifsreg[8];
+    uint32_t iecreg[8];
+    uint32_t ipcreg[64];
+    uint32_t offreg[191];
+
+    /*
+     * Current hardware IRQ levels for each source.  Microchip IFS flags
+     * are level-sensitive: if the source still asserts its line after
+     * firmware clears IFSx, the flag is immediately re-set.
+     */
+    uint32_t irq_level[8];
+
+    qemu_irq cpu_irq[8];
+    MIPSCPU *cpu;    /* set by board code for SW-IRQ Cause.IP fixup */
+};
+
+#endif /* HW_MIPS_PIC32MK_EVIC_H */
diff --git a/include/hw/mips/pic32mk_usb.h b/include/hw/mips/pic32mk_usb.h
new file mode 100644
index 0000000000..342444e9db
--- /dev/null
+++ b/include/hw/mips/pic32mk_usb.h
@@ -0,0 +1,181 @@
+/*
+ * Microchip PIC32MK USB OTG Full-Speed controller — device model header
+ * Datasheet: DS60001519E §25; register addresses from p32mk1024mcm100.h
+ *
+ * Copyright (c) 2026 QEMU contributors
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MIPS_PIC32MK_USB_H
+#define HW_MIPS_PIC32MK_USB_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+#include "chardev/char-fe.h"
+#include "qemu/timer.h"
+
+/*
+ * Register offsets from the USB instance SFR base (e.g. 0xBF889000)
+ * Derived from p32mk1024mcm100.h register addresses.
+ * All registers with CLR/SET/INV aliases follow the standard PIC32 convention
+ * (+4 = CLR, +8 = SET, +C = INV), except where noted.
+ * -----------------------------------------------------------------------
+ */
+
+/* OTG registers */
+#define PIC32MK_UxOTGIR     0x040u  /* OTG interrupt flags  (W1C, CLR alias only) */
+#define PIC32MK_UxOTGIE     0x050u  /* OTG interrupt enable (CLR/SET/INV) */
+#define PIC32MK_UxOTGSTAT   0x060u  /* OTG status           (read-only) */
+#define PIC32MK_UxOTGCON    0x070u  /* OTG control          (CLR/SET/INV) */
+#define PIC32MK_UxPWRC      0x080u  /* Power control        (CLR/SET/INV) */
+
+/* USB core registers */
+#define PIC32MK_UxIR        0x200u  /* Interrupt flags  (W1C, CLR alias only) */
+#define PIC32MK_UxIE        0x210u  /* Interrupt enable (CLR/SET/INV) */
+#define PIC32MK_UxEIR       0x220u  /* Error int flags  (W1C, CLR alias only) */
+#define PIC32MK_UxEIE       0x230u  /* Error int enable (CLR/SET/INV) */
+#define PIC32MK_UxSTAT      0x240u  /* Status           (read-only) */
+#define PIC32MK_UxCON       0x250u  /* Control          (CLR/SET/INV) */
+#define PIC32MK_UxADDR      0x260u  /* Device address   (CLR/SET/INV) */
+#define PIC32MK_UxBDTP1     0x270u  /* BDT ptr [15:9]   (CLR/SET/INV) */
+#define PIC32MK_UxFRML      0x280u  /* Frame# low       (read-only) */
+#define PIC32MK_UxFRMH      0x290u  /* Frame# high      (read-only) */
+#define PIC32MK_UxTOK       0x2A0u  /* Token register   (CLR/SET/INV) */
+#define PIC32MK_UxSOF       0x2B0u  /* SOF threshold    (CLR/SET/INV) */
+#define PIC32MK_UxBDTP2     0x2C0u  /* BDT ptr [23:16]  (CLR/SET/INV) */
+#define PIC32MK_UxBDTP3     0x2D0u  /* BDT ptr [31:24]  (CLR/SET/INV) */
+#define PIC32MK_UxCNFG1     0x2E0u  /* Config 1         (CLR/SET/INV) */
+
+/* Endpoint control registers UxEPn: base + 0x300 + n * 0x10, n = 0..15 */
+#define PIC32MK_UxEP_BASE   0x300u
+#define PIC32MK_UxEP_STRIDE 0x010u
+#define PIC32MK_USB_NEPS    16
+
+/* MMIO size per instance — covers all registers up to UxEP15+CLR/SET/INV */
+#define PIC32MK_USB_SFR_SIZE 0x1000u
+
+/* UxCON bits */
+#define USB_CON_USBEN   (1u << 0)   /* USB enable (device) / SOF (host) */
+#define USB_CON_PPBRST  (1u << 1)   /* Ping-pong buffer reset */
+#define USB_CON_RESUME  (1u << 3)   /* Resume signaling */
+#define USB_CON_HOSTEN  (1u << 4)   /* Host mode enable */
+#define USB_CON_RESET   (1u << 4)   /* Bus reset (host) */
+
+/* UxOTGSTAT bits */
+#define USB_OTGSTAT_SESVD  (1u << 3)  /* Session valid (VBUS > V_A_SESS_VLD) */
+
+/* UxOTGIR / UxOTGIE bits (Harmony: USB_OTG_INTERRUPTS enum) */
+#define USB_OTG_IR_SESSION_VALID   (1u << 3)  /* VBUS session valid change */
+#define USB_OTG_IR_ACTIVITY_DETECT (1u << 4)  /* USB activity detected */
+
+/* UxPWRC bits */
+#define USB_PWRC_USBPWR  (1u << 0)  /* USB power enable */
+#define USB_PWRC_USUSPND (1u << 1)  /* Suspend */
+
+/* UxIR interrupt bits (same layout for UxIE) */
+#define USB_IR_URSTIF   (1u << 0)   /* USB Reset */
+#define USB_IR_UERRIF   (1u << 1)   /* Error */
+#define USB_IR_SOFIF    (1u << 2)   /* Start-of-frame */
+#define USB_IR_TRNIF    (1u << 3)   /* Token done */
+#define USB_IR_IDLEIF   (1u << 4)   /* Idle detect */
+#define USB_IR_RESUMEIF (1u << 5)   /* Resume */
+#define USB_IR_ATTACHIF (1u << 6)   /* Attach (host mode) */
+#define USB_IR_STALLIF  (1u << 7)   /* Stall sent */
+
+/* UxSTAT encoding: EP[7:4] | DIR[3] | PPBI[2] */
+#define USB_STAT_EP0_OUT_EVEN   0x00u
+#define USB_STAT_EP0_IN_EVEN    0x08u
+#define USB_STAT_EP1_IN_EVEN    0x18u
+
+/* BDT entry control word bits */
+#define BDT_UOWN   (1u << 7)    /* USB owns this buffer (firmware arms it) */
+
+/*
+ * Phase 4B EP0 enumeration state machine
+ * -----------------------------------------------------------------------
+ */
+
+typedef enum {
+    EP0_SIM_IDLE,            /* waiting for USBPWR / USBEN */
+    EP0_SIM_RESET,           /* fire USB Reset interrupt */
+    EP0_SIM_GET_DEV_DESC,    /* inject GET_DESCRIPTOR(Device, 18) */
+    EP0_SIM_WAIT_DEV_DESC,   /* waiting for firmware to fill EP0-IN */
+    EP0_SIM_SET_ADDRESS,     /* inject SET_ADDRESS(1) */
+    EP0_SIM_WAIT_ADDRESS,    /* waiting for status phase */
+    EP0_SIM_GET_CFG_DESC,    /* inject GET_DESCRIPTOR(Config, 67) */
+    EP0_SIM_WAIT_CFG_DESC,   /* waiting for firmware */
+    EP0_SIM_SET_CONFIG,      /* inject SET_CONFIGURATION(1) */
+    EP0_SIM_WAIT_CONFIG,     /* waiting for status phase */
+    EP0_SIM_DONE,            /* fully enumerated — poll CDC TX BDT */
+} EP0SimState;
+
+/*
+ * QEMU device model
+ * -----------------------------------------------------------------------
+ */
+
+#define TYPE_PIC32MK_USB "pic32mk-usb"
+OBJECT_DECLARE_SIMPLE_TYPE(PIC32MKUSBState, PIC32MK_USB)
+
+struct PIC32MKUSBState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion sfr_mmio;   /* 0x1000 bytes */
+
+    /* OTG / Power registers */
+    uint32_t otgir;          /* UxOTGIR — OTG interrupt flags */
+    uint32_t otgie;          /* UxOTGIE */
+    uint32_t otgstat;        /* UxOTGSTAT (read-only) */
+    uint32_t otgcon;         /* UxOTGCON */
+    uint32_t pwrc;           /* UxPWRC */
+
+    /* Core interrupt registers */
+    uint32_t uir;            /* UxIR  — USB interrupt flags */
+    uint32_t uie;            /* UxIE */
+    uint32_t ueir;           /* UxEIR — USB error interrupt flags */
+    uint32_t ueie;           /* UxEIE */
+
+    /* Control / Status */
+    uint32_t ustat;          /* UxSTAT (read-only, updated by emulator) */
+    uint32_t ucon;           /* UxCON */
+    uint32_t uaddr;          /* UxADDR */
+
+    /* BDT address pages */
+    uint32_t bdtp1;          /* UxBDTP1 — bits [15:9] of BDT base */
+    uint32_t bdtp2;          /* UxBDTP2 — bits [23:16] */
+    uint32_t bdtp3;          /* UxBDTP3 — bits [31:24] */
+
+    /* Frame counter (read-only; advanced by timer) */
+    uint32_t ufrml;
+    uint32_t ufrmh;
+
+    /* Token / SOF */
+    uint32_t utok;
+    uint32_t usof;
+
+    /* Config */
+    uint32_t cnfg1;
+
+    /* Endpoint control UxEP0–UxEP15 */
+    uint32_t uep[PIC32MK_USB_NEPS];
+
+    /* IRQ line to EVIC */
+    qemu_irq irq;
+
+    /* ---- Phase 4B additions ---- */
+    QEMUTimer   *usb_timer;     /* drives enumeration + BDT poll */
+    CharFrontend chr;           /* virtual serial port for CDC data */
+    EP0SimState  ep0_sim;       /* enumeration state machine */
+    bool         configured;    /* SET_CONFIGURATION accepted */
+    bool         sesvd_edge_latched; /* SESSION_VALID edge latch for IRQ */
+    bool         sesvd_acked;        /* firmware has W1C-cleared SESVDIF at least once */
+    int          sesvd_retry_count;  /* fallback re-fire counter */
+
+    /* ---- USTAT FIFO (PIC32MK has a 4-deep hardware FIFO) ---- */
+    uint32_t stat_fifo[4];      /* circular buffer of pending USTAT values */
+    int      stat_fifo_head;    /* next write position */
+    int      stat_fifo_tail;    /* next read position */
+    int      stat_fifo_count;   /* number of entries in FIFO */
+};
+
+#endif /* HW_MIPS_PIC32MK_USB_H */
diff --git a/tests/functional/mipsel/pic32mk_test_fw.S b/tests/functional/mipsel/pic32mk_test_fw.S
new file mode 100644
index 0000000000..4e63bbd698
--- /dev/null
+++ b/tests/functional/mipsel/pic32mk_test_fw.S
@@ -0,0 +1,64 @@
+/*
+ * pic32mk_test_fw.S — Minimal boot firmware for PIC32MK functional test
+ *
+ * Loaded by QEMU at physical 0x1FC40000 (KSEG1: 0xBFC40000) via -bios.
+ * The board reset vector at 0xBFC00000 has a j 0xBFC40000 trampoline.
+ *
+ * Writes "Hello, PIC32MK!\r\n" to UART1 TX register then spins.
+ * The functional test waits for this string on the serial console.
+ *
+ * UART1 SFR addresses (DS60001519E §21, Table 21-2):
+ *   U1MODE  0xBF828000  bit 15 = UARTEN
+ *   U1STA   0xBF828010  bit 10 = UTXEN
+ *   U1TXREG 0xBF828020  TX data register (write-only)
+ *   U1BRG   0xBF828040  baud rate divisor
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+    .section .text
+    .set    noreorder
+    .set    mips32r2
+    .global _start
+    .type   _start, @function
+_start:
+    /* Disable all interrupts, enter kernel mode */
+    mtc0    $zero, $12          /* CP0 Status = 0 */
+    nop
+
+    /* Stack pointer = top of KSEG1 RAM (physical 256 KB = 0x00040000) */
+    lui     $sp, 0xA004         /* 0xA0040000 */
+    addiu   $sp, $sp, -8
+
+    /* ---- UART1 init ---- */
+    lui     $t0, 0xBF82
+    ori     $t0, $t0, 0x8000   /* t0 = 0xBF828000 (U1MODE base) */
+
+    addiu   $t1, $zero, 64
+    sw      $t1, 0x40($t0)     /* U1BRG  = 64   (baud ignored by emulator) */
+    ori     $t1, $zero, 0x0400
+    sw      $t1, 0x10($t0)     /* U1STA  = UTXEN (bit 10) */
+    lui     $t1, 0x8000
+    sw      $t1, 0x00($t0)     /* U1MODE = UARTEN (bit 15) */
+
+    /* ---- Transmit string byte-by-byte ---- */
+    addiu   $t2, $t0, 0x20     /* t2 = U1TXREG = 0xBF828020 */
+    la      $t1, _msg
+_putc:
+    lbu     $t3, 0($t1)
+    beq     $t3, $zero, _halt
+    nop
+    sw      $t3, 0($t2)
+    addiu   $t1, $t1, 1
+    b       _putc
+    nop
+
+_halt:
+    wait
+    b       _halt
+    nop
+
+    .size _start, . - _start
+
+_msg:
+    .ascii  "Hello, PIC32MK!\r\n\0"
diff --git a/tests/functional/mipsel/pic32mk_test_fw.ld b/tests/functional/mipsel/pic32mk_test_fw.ld
new file mode 100644
index 0000000000..7e817f276f
--- /dev/null
+++ b/tests/functional/mipsel/pic32mk_test_fw.ld
@@ -0,0 +1,20 @@
+/*
+ * pic32mk_test_fw.ld — Linker script for PIC32MK functional test firmware
+ *
+ * Links everything at Boot Flash 1 (KSEG1 0xBFC40000, physical 0x1FC40000).
+ * QEMU loads the raw binary there via load_image_targphys().
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+OUTPUT_ARCH(mips)
+ENTRY(_start)
+
+SECTIONS {
+    . = 0xBFC40000;
+    .text : {
+        *(.text*)
+        *(.rodata*)
+    }
+    /DISCARD/ : { *(*) }
+}
diff --git a/tests/functional/mipsel/test_pic32mk.py b/tests/functional/mipsel/test_pic32mk.py
new file mode 100644
index 0000000000..4af91c4f88
--- /dev/null
+++ b/tests/functional/mipsel/test_pic32mk.py
@@ -0,0 +1,92 @@
+#!/usr/bin/env python3
+#
+# Functional tests for the PIC32MK board emulation
+#
+# Copyright (c) 2026 QEMU contributors
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+
+from qemu_test import QemuSystemTest
+from qemu_test import wait_for_console_pattern
+
+
+class PIC32MKMachine(QemuSystemTest):
+    """
+    Tests for the PIC32MK MCU board (-M pic32mk).
+
+    The FreeRTOS firmware is expected to be pre-built at
+    tests/freertos/hello_freertos.bin relative to the source tree.
+    """
+
+    timeout = 30
+
+    def get_firmware_path(self):
+        """Locate the pre-built FreeRTOS firmware binary."""
+        # data_file() resolves relative to tests/functional/
+        # We need to go up two levels to reach the source root
+        src_root = os.path.join(
+            os.path.dirname(__file__), '..', '..', '..')
+        fw_path = os.path.realpath(
+            os.path.join(src_root, 'tests', 'freertos', 'hello_freertos.bin'))
+        if not os.path.isfile(fw_path):
+            self.skipTest(
+                f'FreeRTOS firmware not built: {fw_path}\n'
+                'Run: make -C tests/freertos')
+        return fw_path
+
+    def test_boot_message(self):
+        """PIC32MK boots and prints the FreeRTOS banner."""
+        self.set_machine('pic32mk')
+        self.vm.set_console()
+        self.vm.add_args('-bios', self.get_firmware_path(),
+                         '-nographic')
+        self.vm.launch()
+        wait_for_console_pattern(self,
+                                 'PIC32MK QEMU booting FreeRTOS...')
+
+    def test_freertos_hello_task(self):
+        """FreeRTOS scheduler starts and the Hello task fires."""
+        self.set_machine('pic32mk')
+        self.vm.set_console()
+        self.vm.add_args('-bios', self.get_firmware_path(),
+                         '-nographic')
+        self.vm.launch()
+        # First: boot banner
+        wait_for_console_pattern(self,
+                                 'PIC32MK QEMU booting FreeRTOS...')
+        # Second: at least one Hello message (proves Timer1 tick + UART TX IRQ)
+        wait_for_console_pattern(self,
+                                 'Hello from FreeRTOS!')
+
+    def test_freertos_recurring_ticks(self):
+        """Timer1 delivers recurring ticks — multiple Hello messages appear."""
+        self.set_machine('pic32mk')
+        self.vm.set_console()
+        self.vm.add_args('-bios', self.get_firmware_path(),
+                         '-nographic')
+        self.vm.launch()
+        wait_for_console_pattern(self,
+                                 'PIC32MK QEMU booting FreeRTOS...')
+        # Wait for a second Hello — proves the tick ISR fires repeatedly
+        # and context switches work (CS0 yield + Timer1 preemption).
+        wait_for_console_pattern(self,
+                                 'Hello from FreeRTOS!')
+        wait_for_console_pattern(self,
+                                 'Hello from FreeRTOS!')
+
+    def test_freertos_ping_task(self):
+        """Second FreeRTOS task (Ping) also runs — proves multitasking."""
+        self.set_machine('pic32mk')
+        self.vm.set_console()
+        self.vm.add_args('-bios', self.get_firmware_path(),
+                         '-nographic')
+        self.vm.launch()
+        wait_for_console_pattern(self,
+                                 'PIC32MK QEMU booting FreeRTOS...')
+        # Ping task fires every 5 seconds
+        wait_for_console_pattern(self, 'Ping')
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/qtest/pic32mk-canfd-test.c b/tests/qtest/pic32mk-canfd-test.c
new file mode 100644
index 0000000000..eafb28b3d6
--- /dev/null
+++ b/tests/qtest/pic32mk-canfd-test.c
@@ -0,0 +1,411 @@
+/*
+ * QTest for PIC32MK CAN FD controller emulation (pic32mk_canfd.c)
+ *
+ * Exercises:
+ *   - Reset state of CiCON, CiINT, CiTXQSTA
+ *   - Mode transitions: Config → Normal, Config → Internal Loopback
+ *   - CiINT.MODIF assertion and firmware clear via read-modify-write
+ *   - TXQ / FIFO configuration and UA register computation
+ *   - Internal loopback: TX frame → acceptance filter → RX FIFO
+ *   - UINC pointer protocol (TX and RX sides)
+ *   - RX overflow detection via CiRXOVIF / CiINT.RXOVIF
+ *   - IRQ flag propagation (CiRXIF, CiTXIF, CiINT.RXIF, CiINT.TXIF)
+ *
+ * All addresses are physical (QTest bypasses the MIPS KSEG1 mapping).
+ * CAN FD SFR registers use 0x10-byte blocks: base/+4(SET)/+8(CLR)/+C(INV).
+ * Tests use plain writes to the base address (sub=0).
+ *
+ * Register offsets verified against XC32 p32mk1024mcm100.h device header.
+ *
+ * Copyright (c) 2026 QEMU contributors
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest-single.h"
+
+/*
+ * Address map
+ * Physical SFR base = 0x1F800000
+ * CAN1 SFR  = SFR + 0x080000 = 0x1F880000
+ * CAN1 MSGRAM = 0x1F900000  (placeholder, Phase 3C will use CiFIFOBA)
+ * -----------------------------------------------------------------------
+  */
+
+#define SFR_BASE            0x1F800000u
+#define CAN1_BASE           (SFR_BASE + 0x080000u)
+#define CAN1_MSGRAM_BASE    0x1F900000u
+
+/* CiXxx register physical addresses for CAN1 (base of each 0x10-byte block) */
+#define CiCON               (CAN1_BASE + 0x000u)
+#define CiNBTCFG            (CAN1_BASE + 0x010u)
+#define CiDBTCFG            (CAN1_BASE + 0x020u)
+#define CiINT               (CAN1_BASE + 0x070u)
+#define CiRXIF              (CAN1_BASE + 0x080u)
+#define CiTXIF              (CAN1_BASE + 0x090u)
+#define CiRXOVIF            (CAN1_BASE + 0x0A0u)
+#define CiTXREQ             (CAN1_BASE + 0x0C0u)
+#define CiTEFCON            (CAN1_BASE + 0x100u)
+#define CiFIFOBA            (CAN1_BASE + 0x130u)
+#define CiTXQCON            (CAN1_BASE + 0x140u)
+#define CiTXQSTA            (CAN1_BASE + 0x150u)
+#define CiTXQUA             (CAN1_BASE + 0x160u)
+
+/* FIFO1 registers: base = 0x170 + (1-1)*0x30 = 0x170 */
+#define CiFIFOCON1          (CAN1_BASE + 0x170u)
+#define CiFIFOSTA1          (CAN1_BASE + 0x180u)
+#define CiFIFOUA1           (CAN1_BASE + 0x190u)
+
+/* FIFO2 registers: base = 0x170 + (2-1)*0x30 = 0x1A0 */
+#define CiFIFOCON2          (CAN1_BASE + 0x1A0u)
+#define CiFIFOSTA2          (CAN1_BASE + 0x1B0u)
+#define CiFIFOUA2           (CAN1_BASE + 0x1C0u)
+
+/* Filter control: stride 0x10 per reg (r=0..7) */
+#define CiFLTCON0           (CAN1_BASE + 0x740u)
+
+/* Filter object/mask: stride 0x20 per pair */
+#define CiFLTOBJ0           (CAN1_BASE + 0x7C0u)
+#define CiMASK0             (CAN1_BASE + 0x7D0u)
+
+/* SET/CLR aliases for key registers (used in some tests) */
+#define CiCON_SET           (CAN1_BASE + 0x004u)
+#define CiCON_CLR           (CAN1_BASE + 0x008u)
+
+/*
+ * CiCON field masks — verified against reset value 0x04980760
+ * -----------------------------------------------------------------------
+  */
+#define CON_REQOP_SHIFT     24u
+#define CON_REQOP_MASK      (0x7u << CON_REQOP_SHIFT)
+#define CON_OPMOD_SHIFT     21u
+#define CON_OPMOD_MASK      (0x7u << CON_OPMOD_SHIFT)
+#define CON_TXQEN           (1u << 20u)
+#define CON_RESET_VAL       0x04980760u
+
+#define OPMOD_NORMAL        0u
+#define OPMOD_CONFIG        4u
+#define OPMOD_INT_LOOP      7u
+
+/* CiINT bits — verified against XC32 device header */
+#define INT_TXIF            (1u << 0u)
+#define INT_RXIF            (1u << 1u)
+#define INT_MODIF           (1u << 3u)   /* bit 3 on real hardware */
+#define INT_RXOVIF          (1u << 11u)
+#define INT_TXIE            (1u << 16u)  /* bit 16 on real hardware */
+#define INT_RXIE            (1u << 17u)  /* bit 17 on real hardware */
+#define INT_MODIE           (1u << 19u)  /* bit 19 on real hardware */
+#define INT_RXOVIE          (1u << 27u)
+
+/* CiFIFOCONn / CiTXQCON bits — verified against XC32 device header */
+#define FIFO_PLSIZE_SHIFT   29u
+#define FIFO_FSIZE_SHIFT    24u
+#define FIFO_TXEN           (1u << 7u)   /* bit 7 on real hardware */
+#define FIFO_UINC           (1u << 8u)   /* bit 8 on real hardware */
+#define FIFO_TXREQ          (1u << 9u)   /* bit 9 on real hardware */
+#define FIFO_FRESET         (1u << 10u)  /* bit 10 on real hardware */
+
+/* CiFIFOSTAn bits */
+#define FIFOSTA_TFNRFNIF    (1u << 0u)   /* TX not full / RX not empty */
+#define FIFOSTA_TXATIF      (1u << 4u)
+
+/* CiTXQSTA bits */
+#define TXQSTA_TXQNIF       (1u << 0u)   /* bit 0 on real hardware */
+
+/*
+ * Helpers
+ * -----------------------------------------------------------------------
+  */
+
+/* Enter the requested mode; asserts OPMOD matches after write */
+static void set_mode(uint32_t opmod_val)
+{
+    uint32_t con = readl(CiCON);
+    con = (con & ~CON_REQOP_MASK) | (opmod_val << CON_REQOP_SHIFT);
+    writel(CiCON, con);
+    uint32_t result = readl(CiCON);
+    g_assert_cmphex((result & CON_OPMOD_MASK) >> CON_OPMOD_SHIFT,
+                    ==, opmod_val);
+}
+
+/* Clear specific bits in CiINT via read-modify-write */
+static void clear_cint_bits(uint32_t mask)
+{
+    writel(CiINT, readl(CiINT) & ~mask);
+}
+
+/*
+ * T1: Reset state
+ * -----------------------------------------------------------------------
+  */
+
+static void test_reset_state(void)
+{
+    /* CiCON must come up in Config mode */
+    uint32_t con = readl(CiCON);
+    g_assert_cmphex(con, ==, CON_RESET_VAL);
+
+    uint8_t opmod = (con & CON_OPMOD_MASK) >> CON_OPMOD_SHIFT;
+    g_assert_cmpuint(opmod, ==, OPMOD_CONFIG);
+
+    /* CiINT must be clear */
+    g_assert_cmphex(readl(CiINT), ==, 0u);
+
+    /* CiTXQSTA: TXQNIF (bit 0) should be set (slot available) */
+    g_assert_true((readl(CiTXQSTA) & TXQSTA_TXQNIF) != 0u);
+}
+
+/*
+ * T2: Mode transition Config → Normal, MODIF assertion, and clear
+ * -----------------------------------------------------------------------
+  */
+
+static void test_mode_transition(void)
+{
+    /* Start in Config mode (reset state) */
+    g_assert_cmpuint((readl(CiCON) & CON_OPMOD_MASK) >> CON_OPMOD_SHIFT,
+                     ==, OPMOD_CONFIG);
+
+    /* Request Normal mode */
+    set_mode(OPMOD_NORMAL);
+
+    /* MODIF (bit 3) must be set in CiINT */
+    g_assert_true((readl(CiINT) & INT_MODIF) != 0u);
+
+    /* Clear MODIF via read-modify-write */
+    clear_cint_bits(INT_MODIF);
+    g_assert_false((readl(CiINT) & INT_MODIF) != 0u);
+
+    /* Transition back to Config mode for subsequent tests */
+    set_mode(OPMOD_CONFIG);
+    clear_cint_bits(INT_MODIF);
+}
+
+/*
+ * T3: TXQ configuration and UA register computation
+ * -----------------------------------------------------------------------
+  */
+
+static void test_txq_configure(void)
+{
+    /* Must be in Config mode */
+    set_mode(OPMOD_CONFIG);
+
+    /*
+     * Configure TXQ: PLSIZE=0 (8-byte payload), FSIZE=0 (1 entry).
+     * Enable TXQ in CiCON via read-modify-write.
+     */
+    uint32_t txqcon = (0u << FIFO_PLSIZE_SHIFT) | (0u << FIFO_FSIZE_SHIFT);
+    writel(CiTXQCON, txqcon);
+    writel(CiCON, readl(CiCON) | CON_TXQEN);
+
+    /* UA must point to the message RAM base for CAN1 */
+    uint32_t ua = readl(CiTXQUA);
+    g_assert_cmphex(ua, ==, CAN1_MSGRAM_BASE);
+}
+
+/*
+ * T4: Internal loopback — TX a frame via TXQ, receive it in FIFO1
+ * -----------------------------------------------------------------------
+  */
+
+static void test_loopback_tx_rx(void)
+{
+    /* --- Configure in Config mode --- */
+    set_mode(OPMOD_CONFIG);
+
+    /* TXQ: 8-byte payload, depth 2 (FSIZE=1) */
+    uint32_t txqcon = (0u << FIFO_PLSIZE_SHIFT) | (1u << FIFO_FSIZE_SHIFT);
+    writel(CiTXQCON, txqcon);
+    writel(CiCON, readl(CiCON) | CON_TXQEN);
+
+    /* FIFO1 as RX: TXEN=0, PLSIZE=0 (8B), FSIZE=1 (2 entries), FRESET */
+    uint32_t fifocon1 = (0u << FIFO_PLSIZE_SHIFT) | (1u << FIFO_FSIZE_SHIFT)
+                      | FIFO_FRESET;
+    writel(CiFIFOCON1, fifocon1);
+
+    /*
+     * Filter 0: match SID 0x123 exactly.
+     * CiFLTOBJ0: standard ID in bits [10:0] (XTD=0).
+     * CiMASK0: 0x1FFFFFFF forces all SID bits to match.
+     * CiFLTCON0 byte 0: FLTEN=1 (bit7), FIFO=1 (bits [4:0]) → 0x81.
+     */
+    writel(CiFLTOBJ0, 0x00000123u);  /* SID=0x123, XTD=0 */
+    writel(CiMASK0,   0x1FFFFFFFu);  /* exact match */
+    /* CiFLTCON0: byte 0 = 0x81 (FLTEN=1, FIFO destination=1) */
+    writel(CiFLTCON0, 0x00000081u);
+
+    /* Enable RXIE and TXIE */
+    writel(CiINT, readl(CiINT) | INT_RXIE | INT_TXIE);
+
+    /* Enter internal loopback mode */
+    set_mode(OPMOD_INT_LOOP);
+    clear_cint_bits(INT_MODIF);
+
+    /* --- Write TX object at TXQ UA --- */
+    uint32_t txqua = readl(CiTXQUA);
+    g_assert_cmphex(txqua, !=, 0u);
+
+    /*
+     * T0: Standard ID 0x123 in bits [28:18] (shifted left by 18).
+     * T1: DLC=2 (2 bytes), classic CAN (FDF=0).
+     * Payload: 0xDEAD in first two bytes (little-endian word).
+     */
+    uint32_t t0 = 0x123u << 18u;
+    uint32_t t1 = 2u;
+    uint32_t payload = 0x0000DEADu;
+
+    writel(txqua + 0u, t0);
+    writel(txqua + 4u, t1);
+    writel(txqua + 8u, payload);
+
+    /* UINC — advance write pointer (hardware clears the bit) */
+    writel(CiTXQCON, readl(CiTXQCON) | FIFO_UINC);
+    g_assert_false((readl(CiTXQCON) & FIFO_UINC) != 0u);
+
+    /* TXREQ — trigger transmission */
+    writel(CiTXQCON, readl(CiTXQCON) | FIFO_TXREQ);
+
+    /* --- Verify RX delivery --- */
+
+    /* CiRXIF bit 1 (FIFO1) must be set */
+    g_assert_true((readl(CiRXIF) & (1u << 1u)) != 0u);
+
+    /* CiINT.RXIF must be set */
+    g_assert_true((readl(CiINT) & INT_RXIF) != 0u);
+
+    /* CiINT.TXIF must be set */
+    g_assert_true((readl(CiINT) & INT_TXIF) != 0u);
+
+    /* Read RX object from FIFO1 UA */
+    uint32_t fifoua1 = readl(CiFIFOUA1);
+    g_assert_cmphex(fifoua1, !=, 0u);
+
+    uint32_t r0    = readl(fifoua1 + 0u);
+    uint32_t r1    = readl(fifoua1 + 4u);
+    uint32_t rdata = readl(fifoua1 + 8u);
+
+    /* R0: standard ID in [28:18] */
+    uint32_t rx_sid = (r0 >> 18u) & 0x7FFu;
+    g_assert_cmphex(rx_sid, ==, 0x123u);
+
+    /* R1: DLC=2 */
+    g_assert_cmpuint(r1 & 0xFu, ==, 2u);
+
+    /* FILHIT in R1[15:11] should be 1 (filter 0 maps to FIFO 1) */
+    uint32_t filhit = (r1 >> 11u) & 0x1Fu;
+    g_assert_cmpuint(filhit, ==, 1u);
+
+    /* Payload: first word */
+    g_assert_cmphex(rdata & 0x0000FFFFu, ==, 0x0000DEADu);
+
+    /* UINC on FIFO1 — firmware done reading, advance read pointer */
+    writel(CiFIFOCON1, readl(CiFIFOCON1) | FIFO_UINC);
+    g_assert_false((readl(CiFIFOCON1) & FIFO_UINC) != 0u);
+
+    /* CiRXIF bit 1 must now be clear (FIFO empty) */
+    g_assert_false((readl(CiRXIF) & (1u << 1u)) != 0u);
+
+    /* CiINT.RXIF must be clear */
+    g_assert_false((readl(CiINT) & INT_RXIF) != 0u);
+
+    /* --- Cleanup --- */
+    clear_cint_bits(INT_RXIE | INT_TXIE | INT_TXIF | INT_RXIF | INT_MODIF);
+    set_mode(OPMOD_CONFIG);
+    clear_cint_bits(INT_MODIF);
+}
+
+/*
+ * T5: RX overflow — FIFO depth 1, deliver 2 frames, verify RXOVIF
+ * -----------------------------------------------------------------------
+  */
+
+static void test_rx_overflow(void)
+{
+    set_mode(OPMOD_CONFIG);
+
+    /* TXQ: 8-byte payload, depth 4 (FSIZE=3) */
+    uint32_t txqcon = (0u << FIFO_PLSIZE_SHIFT) | (3u << FIFO_FSIZE_SHIFT);
+    writel(CiTXQCON, txqcon);
+    writel(CiCON, readl(CiCON) | CON_TXQEN);
+
+    /* FIFO2 as RX, depth 1 (FSIZE=0) — will overflow on 2nd frame */
+    writel(CiFIFOCON2, (0u << FIFO_PLSIZE_SHIFT) | (0u << FIFO_FSIZE_SHIFT)
+                     | FIFO_FRESET);
+
+    /*
+     * Filter 1 (byte 1 in CiFLTCON0): match all IDs → FIFO2.
+     * byte0 = 0x00 (filter 0 disabled), byte1 = 0x82 (FLTEN=1, FIFO=2).
+     */
+    writel(CiFLTOBJ0, 0x00000000u);
+    writel(CiMASK0,   0x00000000u);  /* no bits required to match */
+    writel(CiFLTCON0, 0x00008200u);
+
+    /* Enable RXOVIE */
+    writel(CiINT, readl(CiINT) | INT_RXOVIE | INT_RXIE);
+
+    set_mode(OPMOD_INT_LOOP);
+    clear_cint_bits(INT_MODIF);
+
+    /* Send two frames via TXQ */
+    for (int i = 0; i < 2; i++) {
+        uint32_t ua = readl(CiTXQUA);
+        writel(ua + 0u, 0u);           /* T0: SID=0, XTD=0 */
+        writel(ua + 4u, 1u);           /* T1: DLC=1 */
+        writel(ua + 8u, (uint32_t)i);  /* payload */
+        writel(CiTXQCON, readl(CiTXQCON) | FIFO_UINC);
+        writel(CiTXQCON, readl(CiTXQCON) | FIFO_TXREQ);
+    }
+
+    /* CiRXOVIF bit 2 (FIFO2) must be set */
+    g_assert_true((readl(CiRXOVIF) & (1u << 2u)) != 0u);
+
+    /* CiINT.RXOVIF must be set */
+    g_assert_true((readl(CiINT) & INT_RXOVIF) != 0u);
+
+    /* Cleanup */
+    writel(CiRXOVIF, 0u);
+    clear_cint_bits(INT_RXOVIE | INT_RXIE | INT_RXOVIF | INT_RXIF | INT_MODIF);
+    set_mode(OPMOD_CONFIG);
+    clear_cint_bits(INT_MODIF);
+}
+
+/*
+ * T6: CiCON TXQEN bit set/clear via read-modify-write
+ * -----------------------------------------------------------------------
+  */
+
+static void test_con_rmw(void)
+{
+    set_mode(OPMOD_CONFIG);
+
+    /* Clear TXQEN */
+    writel(CiCON, readl(CiCON) & ~CON_TXQEN);
+    g_assert_false((readl(CiCON) & CON_TXQEN) != 0u);
+
+    /* Set TXQEN */
+    writel(CiCON, readl(CiCON) | CON_TXQEN);
+    g_assert_true((readl(CiCON) & CON_TXQEN) != 0u);
+}
+
+/*
+ * Main
+ * -----------------------------------------------------------------------
+  */
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_start("-machine pic32mk");
+
+    qtest_add_func("/pic32mk-canfd/reset_state",      test_reset_state);
+    qtest_add_func("/pic32mk-canfd/mode_transition",  test_mode_transition);
+    qtest_add_func("/pic32mk-canfd/txq_configure",    test_txq_configure);
+    qtest_add_func("/pic32mk-canfd/loopback_tx_rx",   test_loopback_tx_rx);
+    qtest_add_func("/pic32mk-canfd/rx_overflow",      test_rx_overflow);
+    qtest_add_func("/pic32mk-canfd/con_rmw",          test_con_rmw);
+
+    int r = g_test_run();
+    qtest_end();
+    return r;
+}
diff --git a/tests/qtest/pic32mk-test.c b/tests/qtest/pic32mk-test.c
new file mode 100644
index 0000000000..6f7a1088ba
--- /dev/null
+++ b/tests/qtest/pic32mk-test.c
@@ -0,0 +1,457 @@
+/*
+ * QTest for PIC32MK peripheral device models
+ *
+ * Tests MMIO register access, SET/CLR/INV operations, IRQ assertion,
+ * and timer tick generation for the PIC32MK board emulation.
+ *
+ * Peripherals tested:
+ *   - UART  (pic32mk_uart.c) — register reset values, SET/CLR, TX, IRQ
+ *   - Timer (pic32mk_timer.c) — ON/OFF, prescaler, period match, IRQ
+ *   - EVIC  (pic32mk_evic.c) — IFS/IEC/IPC, interrupt routing
+ *
+ * Copyright (c) 2026 QEMU contributors
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest-single.h"
+
+/*
+ * PIC32MK physical addresses (QTest uses physical, not KSEG1 virtual)
+ * SFR base = 0x1F800000
+ * -----------------------------------------------------------------------
+  */
+
+#define SFR_BASE            0x1F800000u
+
+/* UART1 base = SFR + 0x028000 */
+#define UART1_BASE          (SFR_BASE + 0x028000u)
+#define UART1_MODE          (UART1_BASE + 0x00u)
+#define UART1_MODECLR       (UART1_BASE + 0x04u)
+#define UART1_MODESET       (UART1_BASE + 0x08u)
+#define UART1_MODEINV       (UART1_BASE + 0x0Cu)
+#define UART1_STA           (UART1_BASE + 0x10u)
+#define UART1_STACLR        (UART1_BASE + 0x14u)
+#define UART1_STASET        (UART1_BASE + 0x18u)
+#define UART1_STAINV        (UART1_BASE + 0x1Cu)
+#define UART1_TXREG         (UART1_BASE + 0x20u)
+#define UART1_RXREG         (UART1_BASE + 0x30u)
+#define UART1_BRG            (UART1_BASE + 0x40u)
+
+/* UART bits */
+#define UMODE_ON            (1u << 15)
+#define USTA_URXDA           (1u << 0)
+#define USTA_OERR            (1u << 1)
+#define USTA_TRMT            (1u << 8)
+#define USTA_UTXBF           (1u << 9)
+#define USTA_UTXEN           (1u << 10)
+#define USTA_URXEN           (1u << 12)
+
+/* Timer1 base = SFR + 0x020000 */
+#define T1_BASE             (SFR_BASE + 0x020000u)
+#define T1CON               (T1_BASE + 0x00u)
+#define T1CONCLR            (T1_BASE + 0x04u)
+#define T1CONSET            (T1_BASE + 0x08u)
+#define TMR1                (T1_BASE + 0x10u)
+#define PR1                 (T1_BASE + 0x20u)
+
+/* Timer bits */
+#define TCON_ON             (1u << 15)
+
+/* EVIC base = SFR + 0x010000 */
+#define EVIC_BASE           (SFR_BASE + 0x010000u)
+#define EVIC_INTCON         (EVIC_BASE + 0x0000u)
+#define EVIC_INTSTAT        (EVIC_BASE + 0x0020u)
+#define EVIC_IFS0           (EVIC_BASE + 0x0040u)
+#define EVIC_IFS0CLR        (EVIC_BASE + 0x0044u)
+#define EVIC_IFS0SET        (EVIC_BASE + 0x0048u)
+#define EVIC_IFS1           (EVIC_BASE + 0x0050u)
+#define EVIC_IFS1CLR        (EVIC_BASE + 0x0054u)
+#define EVIC_IFS1SET        (EVIC_BASE + 0x0058u)
+#define EVIC_IEC0           (EVIC_BASE + 0x00C0u)
+#define EVIC_IEC0CLR        (EVIC_BASE + 0x00C4u)
+#define EVIC_IEC0SET        (EVIC_BASE + 0x00C8u)
+#define EVIC_IEC1           (EVIC_BASE + 0x00D0u)
+#define EVIC_IEC1CLR        (EVIC_BASE + 0x00D4u)
+#define EVIC_IEC1SET        (EVIC_BASE + 0x00D8u)
+#define EVIC_IPC0           (EVIC_BASE + 0x0140u)
+#define EVIC_IPC1           (EVIC_BASE + 0x0150u)
+
+/* EVIC source bit positions */
+#define IRQ_T1_BIT          (1u << 4)       /* Timer1 = source 4, IFS0 bit 4 */
+#define IRQ_U1E_BIT         (1u << 6)       /* U1E = source 38 = IFS1 bit 6 */
+#define IRQ_U1RX_BIT        (1u << 7)       /* U1RX = source 39 = IFS1 bit 7 */
+#define IRQ_U1TX_BIT        (1u << 8)       /* U1TX = source 40 = IFS1 bit 8 */
+
+/*
+ * ===================================================================
+ * UART1 register tests
+ * ===================================================================
+  */
+
+static void test_uart_reset_values(void)
+{
+    /* After machine reset: MODE=0, STA=TRMT (shift register empty), BRG=0 */
+    g_assert_cmphex(readl(UART1_MODE), ==, 0x00000000);
+    g_assert_cmphex(readl(UART1_STA) & (USTA_TRMT | USTA_UTXBF), ==, USTA_TRMT);
+    g_assert_cmphex(readl(UART1_BRG), ==, 0x00000000);
+}
+
+static void test_uart_set_clr_inv(void)
+{
+    /* Write BRG via direct write */
+    writel(UART1_BRG, 29);
+    g_assert_cmphex(readl(UART1_BRG), ==, 29);
+
+    /* SET operation: set bit 0 of MODE (STSEL) */
+    writel(UART1_MODESET, 0x1);
+    g_assert_cmphex(readl(UART1_MODE) & 0x1, ==, 0x1);
+
+    /* CLR operation: clear bit 0 */
+    writel(UART1_MODECLR, 0x1);
+    g_assert_cmphex(readl(UART1_MODE) & 0x1, ==, 0x0);
+
+    /* INV operation: toggle bit 3 (BRGH) */
+    uint32_t before = readl(UART1_MODE);
+    writel(UART1_MODEINV, 0x8);
+    g_assert_cmphex(readl(UART1_MODE), ==, before ^ 0x8);
+
+    /* INV again to toggle back */
+    writel(UART1_MODEINV, 0x8);
+    g_assert_cmphex(readl(UART1_MODE), ==, before);
+
+    /* Clean up */
+    writel(UART1_MODE, 0);
+    writel(UART1_BRG, 0);
+}
+
+static void test_uart_enable(void)
+{
+    /* Enable UART: MODESET ON, STASET UTXEN | URXEN */
+    writel(UART1_MODESET, UMODE_ON);
+    g_assert_cmphex(readl(UART1_MODE) & UMODE_ON, ==, UMODE_ON);
+
+    writel(UART1_STASET, USTA_UTXEN | USTA_URXEN);
+    g_assert_cmphex(readl(UART1_STA) & (USTA_UTXEN | USTA_URXEN),
+                    ==, USTA_UTXEN | USTA_URXEN);
+
+    /* TRMT should still be 1 (TX buffer always empty in QEMU) */
+    g_assert_cmphex(readl(UART1_STA) & USTA_TRMT, ==, USTA_TRMT);
+
+    /* UTXBF should be 0 (transmission is instantaneous) */
+    g_assert_cmphex(readl(UART1_STA) & USTA_UTXBF, ==, 0);
+
+    /* Disable UART */
+    writel(UART1_MODECLR, UMODE_ON);
+    g_assert_cmphex(readl(UART1_MODE) & UMODE_ON, ==, 0);
+}
+
+static void test_uart_tx_write(void)
+{
+    /* Enable UART TX */
+    writel(UART1_MODESET, UMODE_ON);
+    writel(UART1_STASET, USTA_UTXEN);
+
+    /* Write a character — should not crash, TRMT stays 1 */
+    writel(UART1_TXREG, 'A');
+    g_assert_cmphex(readl(UART1_STA) & USTA_TRMT, ==, USTA_TRMT);
+
+    /* Write multiple characters */
+    writel(UART1_TXREG, 'B');
+    writel(UART1_TXREG, 'C');
+    g_assert_cmphex(readl(UART1_STA) & USTA_TRMT, ==, USTA_TRMT);
+
+    /* Clean up */
+    writel(UART1_MODECLR, UMODE_ON);
+}
+
+static void test_uart_rx_not_ready(void)
+{
+    /* No byte received yet: URXDA should be 0 */
+    g_assert_cmphex(readl(UART1_STA) & USTA_URXDA, ==, 0);
+
+    /* Reading RXREG when empty returns 0 */
+    g_assert_cmphex(readl(UART1_RXREG), ==, 0);
+}
+
+/*
+ * ===================================================================
+ * EVIC register tests
+ * ===================================================================
+  */
+
+static void test_evic_reset_values(void)
+{
+    /* After reset: IFS0=0, IEC0=0, INTCON=0 */
+    g_assert_cmphex(readl(EVIC_IFS0), ==, 0x00000000);
+    g_assert_cmphex(readl(EVIC_IEC0), ==, 0x00000000);
+    g_assert_cmphex(readl(EVIC_INTCON), ==, 0x00000000);
+}
+
+static void test_evic_ifs_set_clr(void)
+{
+    /* SET a flag in IFS0 — e.g. Timer1 (bit 4) */
+    writel(EVIC_IFS0SET, IRQ_T1_BIT);
+    g_assert_cmphex(readl(EVIC_IFS0) & IRQ_T1_BIT, ==, IRQ_T1_BIT);
+
+    /* CLR the flag */
+    writel(EVIC_IFS0CLR, IRQ_T1_BIT);
+    g_assert_cmphex(readl(EVIC_IFS0) & IRQ_T1_BIT, ==, 0);
+}
+
+static void test_evic_iec_set_clr(void)
+{
+    /* Enable Timer1 interrupt */
+    writel(EVIC_IEC0SET, IRQ_T1_BIT);
+    g_assert_cmphex(readl(EVIC_IEC0) & IRQ_T1_BIT, ==, IRQ_T1_BIT);
+
+    /* Disable it */
+    writel(EVIC_IEC0CLR, IRQ_T1_BIT);
+    g_assert_cmphex(readl(EVIC_IEC0) & IRQ_T1_BIT, ==, 0);
+}
+
+static void test_evic_ipc_priority(void)
+{
+    /* IPC1 holds Timer1 priority (source 4 → IPC1, shift=0, bits[4:2]=IP) */
+    /* Set T1 priority to 3: write (3 << 2) = 0x0C into IPC1 bits [4:2] */
+    writel(EVIC_IPC1, 0x0C);
+    g_assert_cmphex(readl(EVIC_IPC1) & 0x1F, ==, 0x0C);
+
+    /* Clear it back */
+    writel(EVIC_IPC1, 0x00);
+    g_assert_cmphex(readl(EVIC_IPC1) & 0x1F, ==, 0x00);
+}
+
+static void test_evic_uart_ifs1(void)
+{
+    /* UART1 sources are in IFS1: U1E=bit6, U1RX=bit7, U1TX=bit8 */
+    writel(EVIC_IFS1SET, IRQ_U1TX_BIT);
+    g_assert_cmphex(readl(EVIC_IFS1) & IRQ_U1TX_BIT, ==, IRQ_U1TX_BIT);
+
+    writel(EVIC_IFS1CLR, IRQ_U1TX_BIT);
+    g_assert_cmphex(readl(EVIC_IFS1) & IRQ_U1TX_BIT, ==, 0);
+
+    /* Set all three UART1 flags */
+    writel(EVIC_IFS1SET, IRQ_U1E_BIT | IRQ_U1RX_BIT | IRQ_U1TX_BIT);
+    g_assert_cmphex(readl(EVIC_IFS1) & (IRQ_U1E_BIT | IRQ_U1RX_BIT | IRQ_U1TX_BIT),
+                    ==, IRQ_U1E_BIT | IRQ_U1RX_BIT | IRQ_U1TX_BIT);
+
+    /* Clear all */
+    writel(EVIC_IFS1CLR, IRQ_U1E_BIT | IRQ_U1RX_BIT | IRQ_U1TX_BIT);
+    g_assert_cmphex(readl(EVIC_IFS1) & (IRQ_U1E_BIT | IRQ_U1RX_BIT | IRQ_U1TX_BIT),
+                    ==, 0);
+}
+
+static void test_evic_intstat_readonly(void)
+{
+    /* Write to INTSTAT should be ignored (read-only) */
+    uint32_t before = readl(EVIC_INTSTAT);
+    writel(EVIC_INTSTAT, 0xDEADBEEF);
+    g_assert_cmphex(readl(EVIC_INTSTAT), ==, before);
+}
+
+/*
+ * ===================================================================
+ * Timer1 register tests
+ * ===================================================================
+  */
+
+static void test_timer_reset_values(void)
+{
+    /* After reset: T1CON=0 (OFF), TMR1=0, PR1=0xFFFF (16-bit max) */
+    g_assert_cmphex(readl(T1CON), ==, 0x00000000);
+    g_assert_cmphex(readl(TMR1), ==, 0x00000000);
+    g_assert_cmphex(readl(PR1), ==, 0x0000FFFF);
+}
+
+static void test_timer_on_off(void)
+{
+    /* Set period */
+    writel(PR1, 14999);
+
+    /* Turn ON via SET register */
+    writel(T1CONSET, TCON_ON);
+    g_assert_cmphex(readl(T1CON) & TCON_ON, ==, TCON_ON);
+
+    /* Turn OFF via CLR register */
+    writel(T1CONCLR, TCON_ON);
+    g_assert_cmphex(readl(T1CON) & TCON_ON, ==, 0);
+
+    /* Clean up */
+    writel(PR1, 0);
+}
+
+static void test_timer_period_register(void)
+{
+    /* Write period value and read back */
+    writel(PR1, 14999);
+    g_assert_cmpuint(readl(PR1), ==, 14999);
+
+    /* Different value */
+    writel(PR1, 999);
+    g_assert_cmpuint(readl(PR1), ==, 999);
+
+    /* Clean up */
+    writel(PR1, 0);
+}
+
+static void test_timer_prescaler_config(void)
+{
+    /*
+     * Timer1 (Type A) prescaler: bits[5:4] of T1CON
+     * 00=1:1, 01=1:8, 10=1:64, 11=1:256
+      */
+    writel(T1CONSET, (1u << 4));  /* TCKPS=01 → 1:8 */
+    g_assert_cmphex(readl(T1CON) & 0x30, ==, 0x10);
+
+    writel(T1CON, 0);  /* reset */
+    writel(T1CONSET, (3u << 4));  /* TCKPS=11 → 1:256 */
+    g_assert_cmphex(readl(T1CON) & 0x30, ==, 0x30);
+
+    writel(T1CON, 0);
+}
+
+static void test_timer_tick_fires_irq(void)
+{
+    /*
+     * Configure Timer1:
+     *   Prescaler 1:1 (default), PR1=9 → fires after 10 ticks
+     *   Timer clock = 120 MHz internal / 2 (ptimer counts in ns)
+     *   ptimer period = (PR1+1) ticks at system clock
+     *
+     * Timer1 is wired to EVIC source 4 (IFS0 bit 4).
+     * Enable IEC0.T1IE and set IPC1.T1IP=1 so the EVIC routes it.
+     */
+
+    /* Ensure timer is off and clean */
+    writel(T1CON, 0);
+    writel(TMR1, 0);
+
+    /* Set period to 9 (fires after 10 timer ticks) */
+    writel(PR1, 9);
+
+    /* Enable T1 interrupt in EVIC: IEC0 bit 4, priority 1 in IPC1 */
+    writel(EVIC_IFS0CLR, IRQ_T1_BIT);
+    writel(EVIC_IEC0SET, IRQ_T1_BIT);
+    writel(EVIC_IPC1, (1u << 2));  /* T1IP = 1 */
+
+    /* IFS0 should be clear before starting */
+    g_assert_cmphex(readl(EVIC_IFS0) & IRQ_T1_BIT, ==, 0);
+
+    /* Start Timer1: prescaler 1:8 (Type A: TCKPS=01), ON */
+    writel(T1CON, (1u << 4) | TCON_ON);
+
+    /*
+     * Timer clock = 120 MHz / 8 = 15 MHz → 66.67 ns per tick.
+     * With ptimer driven by per-CPU clock, the exact virtual time
+     * depends on ptimer frequency setting.  Step enough virtual time
+     * for the timer to expire: (PR1+1) * tick_period + margin.
+     *
+     * ptimer is typically configured at 15 MHz (120/8), so period
+     * of 10 ticks = 10 * 66.67ns ≈ 667 ns.  Step 2000 ns to be safe.
+     */
+    clock_step(2000);
+
+    /* Timer should have fired: IFS0.T1IF should be set */
+    g_assert_cmphex(readl(EVIC_IFS0) & IRQ_T1_BIT, ==, IRQ_T1_BIT);
+
+    /* Clear it */
+    writel(EVIC_IFS0CLR, IRQ_T1_BIT);
+    g_assert_cmphex(readl(EVIC_IFS0) & IRQ_T1_BIT, ==, 0);
+
+    /* Stop timer, clean up */
+    writel(T1CON, 0);
+    writel(EVIC_IEC0CLR, IRQ_T1_BIT);
+    writel(EVIC_IPC1, 0);
+}
+
+/*
+ * ===================================================================
+ * UART1 TX IRQ integration test
+ *
+ * When UART1 is enabled (ON + UTXEN), the TX IRQ line is asserted.
+ * The EVIC should latch IFS1.U1TXIF.
+ * ===================================================================
+  */
+
+static void test_uart_tx_irq_asserts_ifs(void)
+{
+    /* Clean initial state */
+    writel(EVIC_IFS1CLR, IRQ_U1TX_BIT);
+    writel(UART1_MODE, 0);
+
+    /* IFS1.U1TXIF should be clear before UART is enabled */
+    g_assert_cmphex(readl(EVIC_IFS1) & IRQ_U1TX_BIT, ==, 0);
+
+    /* Enable UART1: ON + UTXEN */
+    writel(UART1_MODESET, UMODE_ON);
+    writel(UART1_STASET, USTA_UTXEN);
+
+    /*
+     * The UART TX IRQ is level-based — enabling ON+UTXEN asserts it.
+     * The EVIC should have set IFS1.U1TXIF.
+      */
+    g_assert_cmphex(readl(EVIC_IFS1) & IRQ_U1TX_BIT, ==, IRQ_U1TX_BIT);
+
+    /* Clear the flag in IFS1 */
+    writel(EVIC_IFS1CLR, IRQ_U1TX_BIT);
+
+    /* Since IRQ line is still high (level-based), EVIC re-asserts IFS */
+    g_assert_cmphex(readl(EVIC_IFS1) & IRQ_U1TX_BIT, ==, IRQ_U1TX_BIT);
+
+    /* Disable UART TX — IRQ should deassert */
+    writel(UART1_STACLR, USTA_UTXEN);
+
+    /* Now clear IFS1 — it should stay clear since the line is low */
+    writel(EVIC_IFS1CLR, IRQ_U1TX_BIT);
+    g_assert_cmphex(readl(EVIC_IFS1) & IRQ_U1TX_BIT, ==, 0);
+
+    /* Clean up */
+    writel(UART1_MODECLR, UMODE_ON);
+}
+
+/*
+ * ===================================================================
+ * main
+ * ===================================================================
+  */
+
+int main(int argc, char **argv)
+{
+    int r;
+
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_start("-machine pic32mk");
+
+    /* UART1 tests */
+    qtest_add_func("/pic32mk/uart/reset-values", test_uart_reset_values);
+    qtest_add_func("/pic32mk/uart/set-clr-inv", test_uart_set_clr_inv);
+    qtest_add_func("/pic32mk/uart/enable", test_uart_enable);
+    qtest_add_func("/pic32mk/uart/tx-write", test_uart_tx_write);
+    qtest_add_func("/pic32mk/uart/rx-not-ready", test_uart_rx_not_ready);
+
+    /* EVIC tests */
+    qtest_add_func("/pic32mk/evic/reset-values", test_evic_reset_values);
+    qtest_add_func("/pic32mk/evic/ifs-set-clr", test_evic_ifs_set_clr);
+    qtest_add_func("/pic32mk/evic/iec-set-clr", test_evic_iec_set_clr);
+    qtest_add_func("/pic32mk/evic/ipc-priority", test_evic_ipc_priority);
+    qtest_add_func("/pic32mk/evic/uart-ifs1", test_evic_uart_ifs1);
+    qtest_add_func("/pic32mk/evic/intstat-readonly", test_evic_intstat_readonly);
+
+    /* Timer1 tests */
+    qtest_add_func("/pic32mk/timer/reset-values", test_timer_reset_values);
+    qtest_add_func("/pic32mk/timer/on-off", test_timer_on_off);
+    qtest_add_func("/pic32mk/timer/period-register", test_timer_period_register);
+    qtest_add_func("/pic32mk/timer/prescaler-config", test_timer_prescaler_config);
+    qtest_add_func("/pic32mk/timer/tick-fires-irq", test_timer_tick_fires_irq);
+
+    /* Integration: UART TX IRQ → EVIC */
+    qtest_add_func("/pic32mk/integration/uart-tx-irq", test_uart_tx_irq_asserts_ifs);
+
+    r = g_test_run();
+
+    qtest_end();
+
+    return r;
+}

-- 
2.48.1


