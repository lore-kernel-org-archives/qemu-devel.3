Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 689AFCCF9EB
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Oct 2025 11:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCyUU-0000A3-EF; Sun, 26 Oct 2025 07:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fanyihao@rt-thread.org>)
 id 1vCyUO-00008T-Sm
 for qemu-devel@nongnu.org; Sun, 26 Oct 2025 07:00:45 -0400
Received: from mail-m1089.netease.com ([154.81.10.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fanyihao@rt-thread.org>)
 id 1vCyUK-0001DO-4F
 for qemu-devel@nongnu.org; Sun, 26 Oct 2025 07:00:43 -0400
Received: from DESKTOP-FHFCVTH.localdomain (unknown [117.67.70.197])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2734efe90;
 Sun, 26 Oct 2025 18:53:30 +0800 (GMT+08:00)
From: fanyihao@rt-thread.org
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yihao Fan <fanyihao@rt-thread.org>
Subject: [PATCH v3 2/3] hw/arm: Add support for the STM32F407-RT-SPARk board
Date: Sun, 26 Oct 2025 18:53:19 +0800
Message-ID: <20251026105320.5591-3-fanyihao@rt-thread.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251026105320.5591-1-fanyihao@rt-thread.org>
References: <20251026105320.5591-1-fanyihao@rt-thread.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a2026e31e03a4kunmcecdce756fb9eb
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaQ0NJVk8fTx0ZSU1ISx1KGVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSkxVTUxVTEtVSkJMWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg++
DKIM-Signature: a=rsa-sha256;
 b=W3/44YD8BaxwQqK/j2/hVBSMnA+Nqt4Iwq8bg/noDUMa0QmhmiH1eYnj5gFc0fVrt4n/8VpKz9uX8F9G4ZZqhN9YPs5cRd+kUGR8o2ijBlwoCkBrZMeAif9gHlIFOWfCPTdOS1SxvYIF/HIar8PSmkKcX+ZxNKLLeypc1lmLW1XLtbe/Y+UH0F+kYlpTxesNQUb9NFBURNqloD8ePnkHmiLC/q9DH9kH2tpdWWA41wvw3TzyM1KcKVXjj0kFdbm61oEThiiYOlWmD6u+Oqnv8AHKQ2HdBPhWUd45pD/Zupsb1g2xorzB1dVWWZJH10qgUjL62VbT/Le804no6pY57w==;
 s=default; c=relaxed/relaxed; d=rt-thread.org; v=1; 
 bh=6VniVlTO18O9n31v8+LgNkmq4kkTWG4R1RzBlnyUSa4=;
 h=date:mime-version:subject:message-id:from;
Received-SPF: pass client-ip=154.81.10.89; envelope-from=fanyihao@rt-thread.org;
 helo=mail-m1089.netease.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

This commit adds a new STM32F4spark machine broad using the STM32F407 SoC.
The implementation is derived from the Netduino Plus 2 machine.

Signed-off-by: Yihao Fan <fanyihao@rt-thread.org>
---
 MAINTAINERS                            |  7 ++++
 docs/system/arm/STM32F407-RT-SPARK.rst | 41 +++++++++++++++++++
 docs/system/arm/stm32.rst              |  1 +
 docs/system/target-arm.rst             |  1 +
 hw/arm/Kconfig                         |  6 +++
 hw/arm/meson.build                     |  1 +
 hw/arm/stm32f4spark.c                  | 56 ++++++++++++++++++++++++++
 7 files changed, 113 insertions(+)
 create mode 100644 docs/system/arm/STM32F407-RT-SPARK.rst
 create mode 100644 hw/arm/stm32f4spark.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ceef177740b..4934e3733d2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1056,6 +1056,13 @@ S: Maintained
 F: hw/arm/stm32vldiscovery.c
 F: docs/system/arm/stm32.rst
 
+STM32F4SPARK
+M: yanl1229 <yanl1229@rt-thread.org>
+M: Yihao Fan <fanyihao@rt-thread.org>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: hw/arm/stm32f4spark.c
+
 Versatile Express
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
diff --git a/docs/system/arm/STM32F407-RT-SPARK.rst b/docs/system/arm/STM32F407-RT-SPARK.rst
new file mode 100644
index 00000000000..27bc8574387
--- /dev/null
+++ b/docs/system/arm/STM32F407-RT-SPARK.rst
@@ -0,0 +1,41 @@
+STM32F407-RT-SPARK (``stm32_f4spark``)
+============================================
+
+The STM32F407-RT-SPARK uses the STM32F407ZG SoC which is based on
+ARM Cortex-M4 core. TThe STM32F407 series runs at up to 168 MHz,
+integrating 196 KiB of SRAM (including 64 KiB CCM) and 1 MiB of
+on-chip Flash. The STM32F407-RT-SPARK board further features
+8 MiB NorFlash, an SD card holder, USB, RS-485, CAN bus.It also
+integrates the RW007 SPI high-speed Wi-Fi module, providing
+convenient network connectivity for IoT and RTOS development.
+
+Supported devices
+"""""""""""""""""
+
+Currently STM32F407-RT-SPARK machines support the following devices:
+
+- Cortex-M4 based STM32F407 SoC
+- stm32f4xx EXTI (Extended interrupts and events controller)
+- stm32f2xx SYSCFG (System configuration controller)
+- stm32 RCC (Reset and clock control)
+- stm32f2xx USARTs, UARTs and LPUART (Serial ports)
+
+Missing devices
+"""""""""""""""
+
+The STM32F407-RT-SPARK does *not* support the following devices:
+
+- Analog to Digital Converter (ADC)
+- SPI controller
+- Timer controller (TIMER)
+- GPIOs (General-purpose I/Os)
+
+Boot options
+""""""""""""
+
+The STM32F407-RT-SPARK machine can be started using the ``-kernel``
+option to load a firmware. Example:
+
+.. code-block:: bash
+
+  $ qemu-system-arm -M rt-spark -kernel firmware.bin
diff --git a/docs/system/arm/stm32.rst b/docs/system/arm/stm32.rst
index 511e3eb9ac1..3f085eb35ee 100644
--- a/docs/system/arm/stm32.rst
+++ b/docs/system/arm/stm32.rst
@@ -23,6 +23,7 @@ The following machines are based on this ARM Cortex-M4F chip :
 - ``netduinoplus2``     Netduino Plus 2 board with STM32F405RGT6 microcontroller
 - ``olimex-stm32-h405`` Olimex STM32 H405 board with STM32F405RGT6 microcontroller
 - ``b-l475e-iot01a``     :doc:`B-L475E-IOT01A IoT Node </system/arm/b-l475e-iot01a>` board with STM32L475VG microcontroller
+- ``STM32F407-RT-SPARK`` STM32F407-RT-SPARK board with STM32F407ZG microcontroller
 
 There are many other STM32 series that are currently not supported by QEMU.
 
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index a96d1867df1..475135d2eaa 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -82,6 +82,7 @@ Board-specific documentation
    arm/aspeed
    arm/bananapi_m2u.rst
    arm/b-l475e-iot01a.rst
+   arm/STM32F407-RT-SPARK.rst
    arm/sabrelite
    arm/highbank
    arm/digic
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index bbf675c158c..ddb2da45ae9 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -239,6 +239,12 @@ config STM32VLDISCOVERY
     depends on TCG && ARM
     select STM32F100_SOC
 
+config STM32F4SPARK
+    bool
+    default y
+    depends on TCG && ARM
+    select STM32F407_SOC
+
 config STRONGARM
     bool
     select PXA2XX_TIMER
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 1de2642620a..16f1938c29a 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -17,6 +17,7 @@ arm_common_ss.add(when: 'CONFIG_REALVIEW', if_true: files('realview.c'))
 arm_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa-ref.c'))
 arm_common_ss.add(when: 'CONFIG_STELLARIS', if_true: files('stellaris.c'))
 arm_common_ss.add(when: 'CONFIG_STM32VLDISCOVERY', if_true: files('stm32vldiscovery.c'))
+arm_common_ss.add(when: 'CONFIG_STM32F4SPARK', if_true: files('stm32f4spark.c'))
 arm_common_ss.add(when: 'CONFIG_ZYNQ', if_true: files('xilinx_zynq.c'))
 arm_common_ss.add(when: 'CONFIG_SABRELITE', if_true: files('sabrelite.c'))
 
diff --git a/hw/arm/stm32f4spark.c b/hw/arm/stm32f4spark.c
new file mode 100644
index 00000000000..1e241f6bf1b
--- /dev/null
+++ b/hw/arm/stm32f4spark.c
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/*
+ * Copyright (c) liang yan <yanl1229@rt-thread.org>
+ * Copyright (c) Yihao Fan <fanyihao@rt-thread.org>
+ * The reference used is the STMicroElectronics RM0090 Reference manual
+ * stm32f4spark implementation is derived from netduinoplus2
+ * https://github.com/RT-Thread-Studio/sdk-bsp-stm32f407-spark
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/boards.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-clock.h"
+#include "qemu/error-report.h"
+#include "hw/arm/stm32f407_soc.h"
+#include "hw/arm/boot.h"
+
+
+/* Main SYSCLK frequency in Hz (72MHz) */
+#define SYSCLK_FRQ 72000000ULL
+
+
+static void stm32f4spark_init(MachineState *machine)
+{
+    DeviceState *dev;
+    Clock *sysclk;
+
+    /* This clock doesn't need migration because it is fixed-frequency */
+    sysclk = clock_new(OBJECT(machine), "SYSCLK");
+    clock_set_hz(sysclk, SYSCLK_FRQ);
+
+    dev = qdev_new(TYPE_STM32F407_SOC);
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
+    qdev_connect_clock_in(dev, "sysclk", sysclk);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    armv7m_load_kernel(ARM_CPU(first_cpu),
+                       machine->kernel_filename,
+                       0, FLASH_SIZE);
+}
+
+static void stm32f4spark_machine_init(MachineClass *mc)
+{
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-m4"),
+        NULL
+    };
+
+    mc->desc = "ST RT-spark (Cortex-M4)";
+    mc->init = stm32f4spark_init;
+    mc->valid_cpu_types = valid_cpu_types;
+}
+
+DEFINE_MACHINE("rt-spark", stm32f4spark_machine_init)
-- 
2.43.0


