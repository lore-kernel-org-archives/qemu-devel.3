Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356EAC5AD55
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2026 13:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsgtz-0006Mp-QL; Sat, 08 Aug 2026 09:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leo-cheng@vip.qq.com>)
 id 1wsegD-0006gN-5X; Sat, 08 Aug 2026 06:53:30 -0400
Received: from out162-62-57-252.mail.qq.com ([162.62.57.252])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leo-cheng@vip.qq.com>)
 id 1wsegA-0003Nd-0j; Sat, 08 Aug 2026 06:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vip.qq.com;
 s=s201512; t=1786186400;
 bh=rtwktTzeZ3n0etR78ifiJwa8bJDYzkop4xBBwuOHetM=;
 h=In-Reply-To:References:Date:Subject:To:Cc:From;
 b=coQI4u7esE1JtWXsNuDK2fOhzw35n7Gy65GY77qLiFAaDsit7xlXganVO/jhneS+i
 FkEQFHBEUBq6oLgxYmYvlze+HBlopJ6m6j5jlsrk1UUdZ7oLC5cEwBGaPm72LKqUYm
 zPfvPKuXzsYM+BOFDn9DoZAXlspi7QoYfOyqE0pk=
Received: from localhost ([111.52.124.140])
 by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
 id B7403E35; Sat, 08 Aug 2026 18:45:52 +0800
X-QQ-mid: xmsmtpt1786185952tza2ep9mg
Message-ID: <tencent_6823C636A0CAF2060C4C66D523B10AAD3807@qq.com>
X-QQ-XMAILINFO: M5g+bqkaOkZDIUR58XO62x6XWnS+e4dn7OJpD4WmqB+LLto/kmFiDiaGuOL4dE
 vEBRIOkP5d+a8rn7lhdoUiSc4n5NwZk46Wdp5kORKD99hG/1HENnuA/7CULQdsXJ65THu85xedEx
 ieYn1EW2vPtWaKPktXh0Ywi3irhnyvXBLxjQfEfY6D1GCRtXLtfm5KC1dhJrzFs/UNKD/gRb0Kpw
 GAu5nAS6mSZS1ADoWoEoqzYKYlNgUtI+hhIk3MsVtng21mH9RnhwgIzFLULPfXvGyWuptEcmHDou
 0CKnvzAA6uvHGBw4kXYNjYD0gfuahUTuMYsGA7NJCmNbxUn+Dh2rfXDUyxjO02rHZdSI9c4NoT3X
 vaa7W4CM/WnYHi25Up6kqGH0gUVuez/Vrc0xLg0hgH+zGtj2ZJPtt6k08xqeBvViFY/udFXBIX6x
 JvbaUveKijWdNqTW8slmyRRU+U8kkevXR6BqL/QXruIvqP+PFWJVLzVk/KJqq9Q/fHNKupGtCQF9
 +VNdBkj9z2TOokrY/GeX33Ygl8JKk4MxtiIV9ZpFDj019dkdUzk/ltzRFO/OzhnSC15XJhkYwYo0
 T8+kgAYI7G7DVJYoibPq0gYyMGFcWvIkkYoRteLP9vpdovHi0mm7g2gQgQxxUKUNkrma8B7+slRc
 fIOtDFqRUY3ab2bEUGkeyBnyjPgbc3NHokhk/oO9soZrSab2KUGhQ/OAd3wb6fYpzDu5Yj9GGtGv
 q6n2QezRJz27sCoDKPg1e1AQfxPQM6qId77AJD/AAllCwjzZIXchjqAKpfJz7bPtyo2UoFRxIv5k
 1GJWOtktAJR+Nd7GdLDljYzPbcWXYCcKoAY40La+g5171wglitK3V5xB12HCreNa7pKrKk00rVUC
 sY8p4/+mssUy53xHxGoH/iK2tlKlrlzoRECa/yEGupHQrbnD276rku4eS0Ufq5sctjDOvJtUQiR+
 zg5vsKFoItpNYGksUSb/A8EOhAACXV5GiMCUKzpVeadFGUB13Y986yVnB9KU+iBFa+hoAKWJek8p
 gfJLdo3wLQTJoLKkKbE24zsw4q6Sfm4ZLWoWCbob0atmfamMbE4O1pvUCgMLD6oPNvj5whha1DN0
 VdFpqfoJs7QadQo/eGBeeJOujofZHVuoRJUkqTUZ6tI41Ty+0R+29Ehjx+Wt9ZTyjnjyZ47v6Zc8
 WHOBU=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-OQ-MSGID: <13768a7cf564f9c1562cf88c949fd1b187bd5ad6.1786185889.git.chengkelfan@qq.com>
In-Reply-To: <cover.1786185889.git.chengkelfan@qq.com>
References: <cover.1786185889.git.chengkelfan@qq.com>
Date: Sat, 8 Aug 2026 18:44:26 +0800
Subject: [PATCH 5/5] hw/riscv: wire K230 peripherals into the machine.
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
From: Leo Cheng <leo-cheng@vip.qq.com>
Received-SPF: pass client-ip=162.62.57.252; envelope-from=leo-cheng@vip.qq.com;
 helo=out162-62-57-252.mail.qq.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FROM=0.001,
 HELO_STATIC_HOST=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 08 Aug 2026 09:15:46 -0400
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

Instantiate the GPIO, RTC, IOMUX, mailbox and SD/eMMC models on the k230 machine, add two SiFive PWM instances, and register the qtests. Also add a satellite-safety fault-injection qtest (watchdog timeout, protected-register tamper, GPIO interrupt storm/loss) exercising the modelled devices, update the machine documentation and MAINTAINERS.

Signed-off-by: Leo Cheng <leo-cheng@vip.qq.com>
---
 MAINTAINERS                    |  12 +++-
 docs/system/riscv/k230.rst     |   6 ++
 hw/riscv/Kconfig               |   7 ++
 hw/riscv/k230.c                |  89 +++++++++++++++++++----
 include/hw/riscv/k230.h        |  18 +++++
 tests/qtest/k230-pwm-test.c    |  43 +++++++++++
 tests/qtest/k230-safety-test.c | 127 +++++++++++++++++++++++++++++++++
 tests/qtest/meson.build        |   2 +-
 8 files changed, 290 insertions(+), 14 deletions(-)
 create mode 100644 tests/qtest/k230-pwm-test.c
 create mode 100644 tests/qtest/k230-safety-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6171cc7..987a58f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1825,10 +1825,20 @@ L: qemu-riscv@nongnu.org
 S: Maintained
 F: docs/system/riscv/k230.rst
 F: hw/riscv/k230.c
+F: hw/gpio/k230_gpio.c
+F: hw/rtc/k230_rtc.c
+F: hw/misc/k230_iomux.c
+F: hw/misc/k230_mailbox.c
+F: hw/sd/k230_dwmmc.c
 F: hw/watchdog/k230_wdt.c
 F: include/hw/riscv/k230.h
+F: include/hw/gpio/k230_gpio.h
+F: include/hw/rtc/k230_rtc.h
+F: include/hw/misc/k230_iomux.h
+F: include/hw/misc/k230_mailbox.h
+F: include/hw/sd/k230_dwmmc.h
 F: include/hw/watchdog/k230_wdt.h
-F: tests/qtest/k230-wdt-test.c
+F: tests/qtest/k230-*-test.c
 
 RX Machines
 -----------
diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
index cea8202..7adafaf 100644
--- a/docs/system/riscv/k230.rst
+++ b/docs/system/riscv/k230.rst
@@ -20,6 +20,12 @@ The ``k230`` machine supports the following devices:
 * Platform-Level Interrupt Controller (PLIC)
 * 2 K230 Watchdog Timer
 * 5 UART
+* 2 GPIO controllers (DesignWare APB GPIO, one PLIC line per pin)
+* 2 PWM controllers (SiFive PWM)
+* RTC (date/time, alarm and periodic tick interrupts)
+* IOMUX pin-configuration controller
+* Mailbox / IPCM block (inter-core doorbell interrupts + hardware spinlock)
+* SD/eMMC host (DesignWare dw_mmc, register model)
 
 Boot options
 ------------
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index de37c08..82c9d7a 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -106,6 +106,7 @@ config SIFIVE_U
     select SIFIVE_U_OTP
     select SIFIVE_U_PRCI
     select SIFIVE_PWM
+    select K230_RTC
     select SSI_M25P80
     select SSI_SD
     select UNIMP
@@ -162,3 +163,9 @@ config K230
     select SERIAL_MM
     select UNIMP
     select K230_WDT
+    select K230_GPIO
+    select SIFIVE_PWM
+    select K230_RTC
+    select K230_IOMUX
+    select K230_MAILBOX
+    select K230_DWMMC
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 656f281..e81b434 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -110,6 +110,16 @@ static void k230_soc_init(Object *obj)
     object_initialize_child(obj, "c908-cpu", cpu0, TYPE_RISCV_HART_ARRAY);
     object_initialize_child(obj, "k230-wdt0", &s->wdt[0], TYPE_K230_WDT);
     object_initialize_child(obj, "k230-wdt1", &s->wdt[1], TYPE_K230_WDT);
+    object_initialize_child(obj, "k230-gpio0", &s->gpio[0], TYPE_K230_GPIO);
+    object_initialize_child(obj, "k230-gpio1", &s->gpio[1], TYPE_K230_GPIO);
+    object_initialize_child(obj, "k230-pwm0", &s->pwm[0], TYPE_SIFIVE_PWM);
+    object_initialize_child(obj, "k230-pwm1", &s->pwm[1], TYPE_SIFIVE_PWM);
+    object_initialize_child(obj, "k230-rtc", &s->rtc, TYPE_K230_RTC);
+    object_initialize_child(obj, "k230-iomux", &s->iomux, TYPE_K230_IOMUX);
+    object_initialize_child(obj, "k230-mailbox", &s->mailbox,
+                            TYPE_K230_MAILBOX);
+    object_initialize_child(obj, "k230-sd0", &s->sd[0], TYPE_K230_DWMMC);
+    object_initialize_child(obj, "k230-sd1", &s->sd[1], TYPE_K230_DWMMC);
 
     qdev_prop_set_uint32(DEVICE(cpu0), "hartid-base", 0);
     qdev_prop_set_string(DEVICE(cpu0), "cpu-type", TYPE_RISCV_CPU_THEAD_C908);
@@ -206,6 +216,73 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[1]), 0,
                        qdev_get_gpio_in(DEVICE(s->c908_plic), K230_WDT1_IRQ));
 
+    /* GPIO0/GPIO1: DW_apb_gpio, one PLIC line per pin */
+    for (int i = 0; i < 2; i++) {
+        SysBusDevice *sbd = SYS_BUS_DEVICE(&s->gpio[i]);
+        hwaddr base = i == 0 ? memmap[K230_DEV_GPIO0].base
+                          : memmap[K230_DEV_GPIO1].base;
+        int irq_base = i == 0 ? K230_GPIO0_IRQ : K230_GPIO1_IRQ;
+
+        if (!sysbus_realize(sbd, errp)) {
+            return;
+        }
+        sysbus_mmio_map(sbd, 0, base);
+        for (int pin = 0; pin < K230_GPIO_PINS; pin++) {
+            sysbus_connect_irq(sbd, pin,
+                qdev_get_gpio_in(DEVICE(s->c908_plic), irq_base + pin));
+        }
+    }
+
+    /* PWM: two SiFive PWM instances at +0x00/+0x40; K230 leaves IRQs unwired */
+    for (int i = 0; i < 2; i++) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->pwm[i]), errp)) {
+            return;
+        }
+    }
+    memory_region_add_subregion(sys_mem, memmap[K230_DEV_PWM].base,
+        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->pwm[0]), 0));
+    memory_region_add_subregion_overlap(sys_mem,
+        memmap[K230_DEV_PWM].base + 0x40,
+        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->pwm[1]), 0), 1);
+
+    /* RTC */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rtc), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->rtc), 0, memmap[K230_DEV_RTC].base);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->rtc), 0,
+                       qdev_get_gpio_in(DEVICE(s->c908_plic), K230_RTC_IRQ));
+
+    /* IOMUX (pinctrl) */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->iomux), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->iomux), 0, memmap[K230_DEV_IOMUX].base);
+
+    /* Mailbox/IPCM block: doorbell interrupts + hardware spinlock at 0xA0 */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->mailbox), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->mailbox), 0,
+                    memmap[K230_DEV_MAILBOX].base);
+    for (int i = 0; i < K230_MB_CHANNELS; i++) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->mailbox), i,
+            qdev_get_gpio_in(DEVICE(s->c908_plic), K230_MAILBOX_IRQ + i));
+    }
+
+    /* SD/eMMC (DesignWare dw_mmc) */
+    for (int i = 0; i < 2; i++) {
+        int devid = i == 0 ? K230_DEV_SD0 : K230_DEV_SD1;
+        int irq = i == 0 ? K230_SD0_IRQ : K230_SD1_IRQ;
+
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->sd[i]), errp)) {
+            return;
+        }
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->sd[i]), 0, memmap[devid].base);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->sd[i]), 0,
+                           qdev_get_gpio_in(DEVICE(s->c908_plic), irq));
+    }
+
     /* unimplemented devices */
     create_unimplemented_device("kpu.l2-cache",
                                 memmap[K230_DEV_KPU_L2_CACHE].base,
@@ -262,9 +339,6 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("pmu", memmap[K230_DEV_PMU].base,
                                 memmap[K230_DEV_PMU].size);
 
-    create_unimplemented_device("rtc", memmap[K230_DEV_RTC].base,
-                                memmap[K230_DEV_RTC].size);
-
     create_unimplemented_device("cmu", memmap[K230_DEV_CMU].base,
                                 memmap[K230_DEV_CMU].size);
 
@@ -319,15 +393,6 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("i2c4", memmap[K230_DEV_I2C4].base,
                                 memmap[K230_DEV_I2C4].size);
 
-    create_unimplemented_device("pwm", memmap[K230_DEV_PWM].base,
-                                memmap[K230_DEV_PWM].size);
-
-    create_unimplemented_device("gpio0", memmap[K230_DEV_GPIO0].base,
-                                memmap[K230_DEV_GPIO0].size);
-
-    create_unimplemented_device("gpio1", memmap[K230_DEV_GPIO1].base,
-                                memmap[K230_DEV_GPIO1].size);
-
     create_unimplemented_device("adc", memmap[K230_DEV_ADC].base,
                                 memmap[K230_DEV_ADC].size);
 
diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
index 592e1c2..e045f96 100644
--- a/include/hw/riscv/k230.h
+++ b/include/hw/riscv/k230.h
@@ -18,6 +18,12 @@
 #include "hw/core/boards.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/watchdog/k230_wdt.h"
+#include "hw/gpio/k230_gpio.h"
+#include "hw/timer/sifive_pwm.h"
+#include "hw/rtc/k230_rtc.h"
+#include "hw/misc/k230_iomux.h"
+#include "hw/misc/k230_mailbox.h"
+#include "hw/sd/k230_dwmmc.h"
 
 #define C908_CPU_HARTID   (0)
 
@@ -33,6 +39,12 @@ typedef struct K230SoCState {
     RISCVHartArrayState c908_cpu; /* Small core */
 
     K230WdtState wdt[2];
+    K230GpioState gpio[2];
+    SiFivePwmState pwm[2];
+    K230RtcState rtc;
+    K230IomuxState iomux;
+    K230MailboxState mailbox;
+    K230DwmmcState sd[2];
     MemoryRegion sram;
     MemoryRegion bootrom;
 
@@ -127,8 +139,14 @@ enum {
     K230_UART2_IRQ  = 18,
     K230_UART3_IRQ  = 19,
     K230_UART4_IRQ  = 20,
+    K230_GPIO0_IRQ  = 32,   /* per-pin: 32..63 */
+    K230_GPIO1_IRQ  = 64,   /* per-pin: 64..95 */
+    K230_RTC_IRQ    = 175,  /* shared PMU/RTC */
     K230_WDT0_IRQ   = 107,
     K230_WDT1_IRQ   = 108,
+    K230_MAILBOX_IRQ = 109,  /* IPCM doorbell 109..112; ch0/ch1 use 109/110 */
+    K230_SD0_IRQ    = 142,
+    K230_SD1_IRQ    = 144,
 };
 
 #define K230_UART_COUNT 5
diff --git a/tests/qtest/k230-pwm-test.c b/tests/qtest/k230-pwm-test.c
new file mode 100644
index 0000000..a8b3dc3
--- /dev/null
+++ b/tests/qtest/k230-pwm-test.c
@@ -0,0 +1,43 @@
+/*
+ * QTest testcase for K230 PWM (two SiFive PWM instances)
+ *
+ * Copyright (c) 2026 Leo Cheng <chengkelfan@qq.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+#define PWM0_BASE 0x9140A000
+#define PWM1_BASE 0x9140A040
+
+#define PWM_PWMCMP0 0x20
+#define PWM_PWMCMP1 0x24
+
+/* Both instances are mapped and independently addressable */
+static void test_two_instances(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    qtest_writel(qts, PWM0_BASE + PWM_PWMCMP0, 0x1234);
+    qtest_writel(qts, PWM1_BASE + PWM_PWMCMP0, 0x5678);
+
+    g_assert_cmphex(qtest_readl(qts, PWM0_BASE + PWM_PWMCMP0), ==, 0x1234);
+    g_assert_cmphex(qtest_readl(qts, PWM1_BASE + PWM_PWMCMP0), ==, 0x5678);
+
+    /* Independent compare registers within an instance */
+    qtest_writel(qts, PWM0_BASE + PWM_PWMCMP1, 0x0abc);
+    g_assert_cmphex(qtest_readl(qts, PWM0_BASE + PWM_PWMCMP1), ==, 0x0abc);
+    g_assert_cmphex(qtest_readl(qts, PWM0_BASE + PWM_PWMCMP0), ==, 0x1234);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/k230-pwm/two_instances", test_two_instances);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/k230-safety-test.c b/tests/qtest/k230-safety-test.c
new file mode 100644
index 0000000..9d6cddf
--- /dev/null
+++ b/tests/qtest/k230-safety-test.c
@@ -0,0 +1,127 @@
+/*
+ * QTest testcase for K230 satellite-safety fault-injection scenarios
+ *
+ * Copyright (c) 2026 Leo Cheng <chengkelfan@qq.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Each scenario injects a fault through the modelled devices and checks a
+ * detect -> respond -> recover flow observable from the guest side (register
+ * status, PLIC pending, masked-vs-raw divergence).
+ */
+#include "qemu/osdep.h"
+#include "qemu/timer.h"
+#include "qemu/bitops.h"
+#include "libqtest.h"
+#include "hw/watchdog/k230_wdt.h"
+#include "hw/rtc/k230_rtc.h"
+#include "hw/gpio/k230_gpio.h"
+
+#define WDT0_BASE    0x91106000
+#define RTC_BASE     0x91000C00
+#define GPIO0_BASE   0x9140B000
+#define PLIC_BASE    0xF00000000ULL
+#define PLIC_PENDING (PLIC_BASE + 0x1000)
+#define WDT0_IRQ     107
+#define GPIO0_PIN0_IRQ 32
+
+static bool plic_pending(QTestState *qts, int irq)
+{
+    uint32_t word = qtest_readl(qts, PLIC_PENDING + (irq / 32) * 4);
+    return (word >> (irq % 32)) & 1;
+}
+
+/* Fault: watchdog timeout. Detect via STAT/PLIC, recover via EOI + restart. */
+static void test_wdt_timeout(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    qtest_writel(qts, WDT0_BASE + K230_WDT_CR,
+                 K230_WDT_CR_RMOD | K230_WDT_CR_WDT_EN);
+    qtest_writel(qts, WDT0_BASE + K230_WDT_TORR, 0x1);
+
+    qtest_clock_step(qts, NANOSECONDS_PER_SECOND * 10);   /* let it expire */
+
+    /* detect */
+    g_assert_cmphex(qtest_readl(qts, WDT0_BASE + K230_WDT_STAT) &
+                    K230_WDT_STAT_INT, ==, K230_WDT_STAT_INT);
+    g_assert_true(plic_pending(qts, WDT0_IRQ));
+
+    /* recover: ack + kick */
+    qtest_writel(qts, WDT0_BASE + K230_WDT_EOI, 0x1);
+    g_assert_cmphex(qtest_readl(qts, WDT0_BASE + K230_WDT_STAT) &
+                    K230_WDT_STAT_INT, ==, 0);
+    qtest_writel(qts, WDT0_BASE + K230_WDT_CRR, K230_WDT_CRR_RESTART);
+
+    qtest_quit(qts);
+}
+
+/* Fault: tamper a protected register with the write lock closed. */
+static void test_rtc_tamper_rejected(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+    uint32_t golden = (12 << 16) | (30 << 8) | 45;
+
+    /* establish golden state under the write-enable gate */
+    qtest_writel(qts, RTC_BASE + K230_RTC_INT_CTRL, K230_RTC_TIMER_W_EN);
+    qtest_writel(qts, RTC_BASE + K230_RTC_TIME, golden);
+    g_assert_cmphex(qtest_readl(qts, RTC_BASE + K230_RTC_TIME), ==, golden);
+
+    /* inject: close the gate, then attempt to tamper */
+    qtest_writel(qts, RTC_BASE + K230_RTC_INT_CTRL, 0);
+    qtest_writel(qts, RTC_BASE + K230_RTC_TIME, 0xdeadbeef);
+
+    /* detect: read-back still equals golden -> tamper rejected */
+    g_assert_cmphex(qtest_readl(qts, RTC_BASE + K230_RTC_TIME), ==, golden);
+
+    qtest_quit(qts);
+}
+
+/* Fault: interrupt storm, then masked loss. Detect via raw-vs-masked. */
+static void test_gpio_storm_and_loss(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    /* pin0: output, rising-edge interrupt, unmasked */
+    qtest_writel(qts, GPIO0_BASE + K230_GPIO_SWPORTA_DDR, 0x1);
+    qtest_writel(qts, GPIO0_BASE + K230_GPIO_INTTYPE_LEVEL, 0x1);
+    qtest_writel(qts, GPIO0_BASE + K230_GPIO_INT_POLARITY, 0x1);
+    qtest_writel(qts, GPIO0_BASE + K230_GPIO_INTEN, 0x1);
+
+    /* storm: repeated rising edges */
+    for (int i = 0; i < 16; i++) {
+        qtest_writel(qts, GPIO0_BASE + K230_GPIO_SWPORTA_DR, 0x0);
+        qtest_writel(qts, GPIO0_BASE + K230_GPIO_SWPORTA_DR, 0x1);
+    }
+    /* detect the storm: status latched + PLIC pending */
+    g_assert_cmphex(qtest_readl(qts, GPIO0_BASE + K230_GPIO_INTSTATUS) & 1,
+                    ==, 1);
+    g_assert_true(plic_pending(qts, GPIO0_PIN0_IRQ));
+    qtest_writel(qts, GPIO0_BASE + K230_GPIO_PORTA_EOI, 0x1);   /* recover */
+
+    /* inject loss: mask pin0, generate an edge */
+    qtest_writel(qts, GPIO0_BASE + K230_GPIO_INTMASK, 0x1);
+    qtest_writel(qts, GPIO0_BASE + K230_GPIO_SWPORTA_DR, 0x0);
+    qtest_writel(qts, GPIO0_BASE + K230_GPIO_SWPORTA_DR, 0x1);
+
+    /* detect loss: raw sees the edge, masked status does not */
+    g_assert_cmphex(qtest_readl(qts, GPIO0_BASE + K230_GPIO_RAW_INTSTATUS) & 1,
+                    ==, 1);
+    g_assert_cmphex(qtest_readl(qts, GPIO0_BASE + K230_GPIO_INTSTATUS) & 1,
+                    ==, 0);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/k230-safety/wdt_timeout", test_wdt_timeout);
+    qtest_add_func("/k230-safety/rtc_tamper_rejected",
+                   test_rtc_tamper_rejected);
+    qtest_add_func("/k230-safety/gpio_storm_and_loss",
+                   test_gpio_storm_and_loss);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 56ff860..be9e9ce 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -297,7 +297,7 @@ qtests_riscv64 = ['riscv-csr-test'] + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
    ['iommu-riscv-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : [])
+  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test', 'k230-gpio-test', 'k230-pwm-test', 'k230-rtc-test', 'k230-iomux-test', 'k230-mailbox-test', 'k230-safety-test', 'k230-dwmmc-test'] : [])
 
 qtests_hexagon = ['boot-serial-test']
 
-- 
2.43.0


