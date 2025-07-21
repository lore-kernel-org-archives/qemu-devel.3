Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C460FC83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 20:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udx0x-0005gl-1V; Mon, 21 Jul 2025 16:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fanyihao@rt-thread.org>)
 id 1udwyQ-0003AF-Jz
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 16:19:02 -0400
Received: from mail-m93118.xmail.ntesmail.com ([103.126.93.118])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fanyihao@rt-thread.org>)
 id 1udwyM-0000YU-7Y
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 16:18:58 -0400
Received: from DESKTOP-FHFCVTH.localdomain (unknown
 [IPV6:240e:360:9379:c800:30:bacc:21c0:5559])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1cc453b67;
 Tue, 22 Jul 2025 04:11:38 +0800 (GMT+08:00)
From: fanyihao@rt-thread.org
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yihao Fan <fanyihao@rt-thread.org>
Subject: [PATCH v2 2/3] Add the STM32F4spark Machine
Date: Tue, 22 Jul 2025 04:11:33 +0800
Message-ID: <20250721201134.13270-3-fanyihao@rt-thread.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721201134.13270-1-fanyihao@rt-thread.org>
References: <20250721201134.13270-1-fanyihao@rt-thread.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZH0oYVk5JTRofQx0ZTElCHlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlJT0seQUhNS0FCSExCQRhDS0tBSEtBGRoYGEFJShhLQU5OTkJZV1kWGg
 8SFR0UWUFZT0tIVUpLSUJDQ0lVSktLVUtZBg++
X-HM-Tid: 0a982e9d038203a4kunm518c726929260df
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NC46Gjo5CjEiTToWCQhOFTcj
 DAkwCjpVSlVKTE5ISklDTUJCT09MVTMWGhIXVR0aFQISExoUOwkPVg8TCR4aH1UUCRxFWVdZEgtZ
 QVlJT0seQUhNS0FCSExCQRhDS0tBSEtBGRoYGEFJShhLQU5OTkJZV1kIAVlBT0lJSjcG
DKIM-Signature: a=rsa-sha256;
 b=LLxpfIlqLaNCMMadtDCbA4wUfR06QfnmLAhD6nrPxvu+24Qt4uZk4RmlC1PK/NeSjhKqjbv5CU9jDsqCYnGhrhUU+x+U5B9f6Die3YcD2LLuGwd+XYrm1x00zs8wWxhfk/IWjU1HidieekfmU0LH5btgI9a2lxlXB5VdvHnWOOhBlsUhRerfYBDwGWpWHbxjwQ+2vicutCHiXY3dcDPTQmv5F7leVrgq+afXi0JnmrpA8FejsOo+hDHEku5AGdsO1ya8UCMR6Y1ckdyZQ0SrLzQpoL3c7fbr/8BcXjMx/yJ3FYw9IXnBvXrvmx11mvDT0x681EsNB/j66/S/k2SCuw==;
 c=relaxed/relaxed; s=default; d=rt-thread.org; v=1; 
 bh=DhtHw8BoO83emuq5svR1hPIfwohhpo4OSgYOi+4ii5Y=;
 h=date:mime-version:subject:message-id:from;
Received-SPF: pass client-ip=103.126.93.118;
 envelope-from=fanyihao@rt-thread.org; helo=mail-m93118.xmail.ntesmail.com
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

Add the STM32F4spark machine model using the STM32F407 SoC.

Signed-off-by: Yihao Fan <fanyihao@rt-thread.org>
---
 MAINTAINERS           |  7 +++++++
 hw/arm/Kconfig        |  6 ++++++
 hw/arm/meson.build    |  1 +
 hw/arm/stm32f4spark.c | 48 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 62 insertions(+)
 create mode 100644 hw/arm/stm32f4spark.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2744639a8b..0dc7c7bf60 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1030,6 +1030,13 @@ S: Maintained
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
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 4b2f71e6e1..3706a65286 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -234,6 +234,12 @@ config STM32VLDISCOVERY
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
index 31621060ba..ec63ed7373 100644
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
index 0000000000..e1d656a3f9
--- /dev/null
+++ b/hw/arm/stm32f4spark.c
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/boards.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-clock.h"
+#include "qemu/error-report.h"
+#include "hw/arm/stm32f407_soc.h"
+#include "hw/arm/boot.h"
+
+/* stm32f4spark implementation is derived from netduinoplus2 */
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


