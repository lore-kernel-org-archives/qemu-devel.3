Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B16BC83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 20:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udx1G-0006HI-C0; Mon, 21 Jul 2025 16:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fanyihao@rt-thread.org>)
 id 1udwyO-00038U-AM
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 16:19:02 -0400
Received: from mail-m8288.xmail.ntesmail.com ([156.224.82.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fanyihao@rt-thread.org>)
 id 1udwyK-0000Xw-Pm
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 16:18:56 -0400
Received: from DESKTOP-FHFCVTH.localdomain (unknown
 [IPV6:240e:360:9379:c800:30:bacc:21c0:5559])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1cc453b66;
 Tue, 22 Jul 2025 04:11:37 +0800 (GMT+08:00)
From: fanyihao@rt-thread.org
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yihao Fan <fanyihao@rt-thread.org>
Subject: [PATCH v2 1/3] Add-the-stm32f407-SoC
Date: Tue, 22 Jul 2025 04:11:32 +0800
Message-ID: <20250721201134.13270-2-fanyihao@rt-thread.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721201134.13270-1-fanyihao@rt-thread.org>
References: <20250721201134.13270-1-fanyihao@rt-thread.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSUlDVk9IQ0gaTx8ZTh9CTlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlJT0seQUhNS0FCSExCQRhDS0tBSEtBGRoYGEFJShhLQU5OTkJZV1kWGg
 8SFR0UWUFZT0tIVUpLSUJDQ0lVSktLVUtZBg++
X-HM-Tid: 0a982e9cfe6703a4kunm518c726929260c6
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PjI6Axw4GDEiCDo3Nw8CFTZK
 DjJPCQxVSlVKTE5ISklDTUJDSUpCVTMWGhIXVR0aFQISExoUOwkPVg8TCR4aH1UUCRxFWVdZEgtZ
 QVlJT0seQUhNS0FCSExCQRhDS0tBSEtBGRoYGEFJShhLQU5OTkJZV1kIAVlBQ09CQzcG
DKIM-Signature: a=rsa-sha256;
 b=KzyHIYTB+QDCc9sYUliuyDOnkwAFpQNah8T4hEWDSBFnc+rGi6O1osxYR4dJQQ30QxMvzVpa2vaYvB37lzV/hePxP/mFjRrUpUihFhb9jZ4BpY41XeXB59iTQH868p5zdLeZGtIv6T1V3OQXkmzgPKa3XFHW+VXxvRgy3zy7uAIuthB6bsju494kJuivO00DZGE/WsR4paMFBdy55VhRlrHJq61Oa1UI9Ym8fxbN7AWKMiS30IHod3L/znD2IVYbHEgKpDKsFhJO9sGFom4RmCHWy9M4riJMDoqNXr5zCCfMfetuCyGR17Ws1QM+XvT1M02XJ03oV8i0ZmZSajI4Zg==;
 c=relaxed/relaxed; s=default; d=rt-thread.org; v=1; 
 bh=mmOs2IbJ1iobGCcYuwGC/cVhsR6OQTKNHle8PCJkcX4=;
 h=date:mime-version:subject:message-id:from;
Received-SPF: pass client-ip=156.224.82.88;
 envelope-from=fanyihao@rt-thread.org; helo=mail-m8288.xmail.ntesmail.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Yihao Fan <fanyihao@rt-thread.org>

This patch introduces a new QEMU machine type for the STM32F407 SoC featuring a Cortex-M4 core.
This will be used by the RT-Spark to create a machine.

Signed-off-by: Yihao Fan <fanyihao@rt-thread.org>
---
 MAINTAINERS                    |   7 ++
 hw/arm/Kconfig                 |   6 ++
 hw/arm/meson.build             |   1 +
 hw/arm/stm32f407_soc.c         | 130 +++++++++++++++++++++++++++++++++
 include/hw/arm/stm32f407_soc.h |  39 ++++++++++
 5 files changed, 183 insertions(+)
 create mode 100644 hw/arm/stm32f407_soc.c
 create mode 100644 include/hw/arm/stm32f407_soc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index d1672fda8d..2744639a8b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1137,6 +1137,13 @@ F: hw/misc/stm32f4xx_exti.c
 F: hw/misc/stm32_rcc.c
 F: include/hw/misc/stm32_rcc.h
 
+STM32F407
+M: yanl1229 <yanl1229@rt-thread.org>
+M: Yihao Fan <fanyihao@rt-thread.org>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: hw/arm/stm32f407_soc.c
+
 Netduino 2
 M: Alistair Francis <alistair@alistair23.me>
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index f543d944c3..4b2f71e6e1 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -392,6 +392,12 @@ config STM32F405_SOC
     select STM32F4XX_SYSCFG
     select STM32F4XX_EXTI
 
+config STM32F407_SOC
+    bool
+    select ARM_V7M
+    select STM32F4XX_SYSCFG
+    select STM32F4XX_EXTI
+
 config B_L475E_IOT01A
     bool
     default y
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index d90be8f4c9..31621060ba 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -32,6 +32,7 @@ arm_common_ss.add(when: ['CONFIG_RASPI', 'TARGET_AARCH64'], if_true: files('bcm2
 arm_common_ss.add(when: 'CONFIG_STM32F100_SOC', if_true: files('stm32f100_soc.c'))
 arm_common_ss.add(when: 'CONFIG_STM32F205_SOC', if_true: files('stm32f205_soc.c'))
 arm_common_ss.add(when: 'CONFIG_STM32F405_SOC', if_true: files('stm32f405_soc.c'))
+arm_common_ss.add(when: 'CONFIG_STM32F407_SOC', if_true: files('stm32f407_soc.c'))
 arm_common_ss.add(when: 'CONFIG_B_L475E_IOT01A', if_true: files('b-l475e-iot01a.c'))
 arm_common_ss.add(when: 'CONFIG_STM32L4X5_SOC', if_true: files('stm32l4x5_soc.c'))
 arm_common_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx-zynqmp.c', 'xlnx-zcu102.c'))
diff --git a/hw/arm/stm32f407_soc.c b/hw/arm/stm32f407_soc.c
new file mode 100644
index 0000000000..0a91d4bb10
--- /dev/null
+++ b/hw/arm/stm32f407_soc.c
@@ -0,0 +1,130 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "system/address-spaces.h"
+#include "system/system.h"
+#include "hw/arm/stm32f407_soc.h"
+#include "hw/qdev-clock.h"
+#include "hw/sd/sd.h"
+#include "hw/boards.h"
+#include "qom/object.h"
+#include "hw/block/flash.h"
+#include "hw/misc/unimp.h"
+
+
+static const uint32_t syscfg_addr = 0x40013800;
+static const uint32_t exti_addr = 0x40013C00;
+static const int syscfg_irq = 71;
+static const int exti_irq[] = {
+    6, 7, 8, 9, 10, 23, 23, 23, 23, 23, 40,
+    40, 40, 40, 40, 40
+};
+
+
+static void stm32f407_soc_initfn(Object *obj)
+{
+    int i;
+
+    STM32F407State *s = STM32F407_SOC(obj);
+
+    object_initialize_child(obj, "armv7m", &s->armv7m, TYPE_ARMV7M);
+
+    object_initialize_child(obj, "syscfg", &s->syscfg, TYPE_STM32F4XX_SYSCFG);
+    object_initialize_child(obj, "exti", &s->exti, TYPE_STM32F4XX_EXTI);
+
+    s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
+    s->refclk = qdev_init_clock_in(DEVICE(s), "refclk", NULL, NULL, 0);
+}
+
+static void stm32f407_soc_realize(DeviceState *dev_soc, Error **errp)
+{
+    STM32F407State *s = STM32F407_SOC(dev_soc);
+    DeviceState *dev, *armv7m;
+    SysBusDevice *busdev;
+    DriveInfo *dinfo;
+    int i, j;
+
+    MemoryRegion *system_memory = get_system_memory();
+
+    /*
+     * We use s->refclk internally and only define it with qdev_init_clock_in()
+     * so it is correctly parented and not leaked on an init/deinit; it is not
+     * intended as an externally exposed clock.
+     */
+    if (clock_has_source(s->refclk)) {
+        error_setg(errp, "refclk clock must not be wired up by the board code");
+        return;
+    }
+
+    if (!clock_has_source(s->sysclk)) {
+        error_setg(errp, "sysclk clock must be wired up by the board code");
+        return;
+    }
+
+    /*
+     * TODO: ideally we should model the SoC RCC and its ability to
+     * change the sysclk frequency and define different sysclk sources.
+     */
+
+    /* The refclk always runs at frequency HCLK / 8 */
+    clock_set_mul_div(s->refclk, 8, 1);
+    clock_set_source(s->refclk, s->sysclk);
+
+
+    armv7m = DEVICE(&s->armv7m);
+    qdev_prop_set_uint32(armv7m, "num-irq", 98);
+    qdev_prop_set_string(armv7m, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m4"));
+    qdev_prop_set_bit(armv7m, "enable-bitband", true);
+    qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);
+    qdev_connect_clock_in(armv7m, "refclk", s->refclk);
+    object_property_set_link(OBJECT(&s->armv7m), "memory",
+                             OBJECT(system_memory), &error_abort);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), errp)) {
+        return;
+    }
+    /* System configuration controller */
+    dev = DEVICE(&s->syscfg);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->syscfg), errp)) {
+        return;
+    }
+    busdev = SYS_BUS_DEVICE(dev);
+    sysbus_mmio_map(busdev, 0, syscfg_addr);
+    sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, syscfg_irq));
+
+    /* EXTI device */
+    dev = DEVICE(&s->exti);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->exti), errp)) {
+        return;
+    }
+    busdev = SYS_BUS_DEVICE(dev);
+    sysbus_mmio_map(busdev, 0, exti_addr);
+    for (i = 0; i < 16; i) {
+        sysbus_connect_irq(busdev, i, qdev_get_gpio_in(armv7m, exti_irq[i]));
+    }
+    for (i = 0; i < 16; i) {
+        qdev_connect_gpio_out(DEVICE(&s->syscfg), i, qdev_get_gpio_in(dev, i));
+    }
+
+}
+
+static void stm32f407_soc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = stm32f407_soc_realize;
+}
+
+static const TypeInfo stm32f407_soc_info = {
+    .name          = TYPE_STM32F407_SOC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(STM32F407State),
+    .instance_init = stm32f407_soc_initfn,
+    .class_init    = stm32f407_soc_class_init,
+};
+
+static void stm32f407_soc_types(void)
+{
+    type_register_static(&stm32f407_soc_info);
+}
+
+type_init(stm32f407_soc_types)
diff --git a/include/hw/arm/stm32f407_soc.h b/include/hw/arm/stm32f407_soc.h
new file mode 100644
index 0000000000..19191dc44e
--- /dev/null
+++ b/include/hw/arm/stm32f407_soc.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef STM32F407_SOC_H
+#define STM32F407_SOC_H
+
+#include "hw/or-irq.h"
+#include "hw/arm/armv7m.h"
+#include "hw/misc/stm32f4xx_syscfg.h"
+#include "hw/misc/stm32f4xx_exti.h"
+
+#include "qom/object.h"
+
+#define TYPE_STM32F407_SOC "stm32f407-soc"
+OBJECT_DECLARE_SIMPLE_TYPE(STM32F407State, STM32F407_SOC)
+
+#define SYSCFG_BASE_ADDRESS 0x40013800
+#define SYSCFG_IRQ  71
+#define EXIT_BASE_ADDRESS   0x40013C00
+#define FLASH_BASE_ADDRESS  0x8000000
+#define FLASH_SIZE          0x100000
+#define SRAM_BASE_ADDRESS   0x20000000
+#define SRAM_SIZE           (192 * 1024)
+
+
+struct STM32F407State {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    char *kernel_filename;
+    ARMv7MState armv7m;
+
+    STM32F4xxSyscfgState syscfg;
+    STM32F4xxExtiState exti;
+
+    Clock *sysclk;
+    Clock *refclk;
+};
+
+#endif
-- 
2.43.0


