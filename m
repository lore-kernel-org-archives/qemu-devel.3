Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC784C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 20:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn2R4-00078N-8i; Wed, 20 Mar 2024 16:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balbi@kernel.org>) id 1rn2R3-00078B-6I
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 16:21:17 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balbi@kernel.org>) id 1rn2Qq-0007ry-35
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 16:21:16 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id EFB726110F;
 Wed, 20 Mar 2024 20:21:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D387C43394;
 Wed, 20 Mar 2024 20:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1710966062;
 bh=ahnMh3m/Zd0rZMZP73wO7LSJn46f4JGV8PXWQVn6I1s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nCrGdflOZXOkAF/oDYO3/71pD4jYwMRyXotljBO+oUhmyG7HVuKeewBMp+RO9vq24
 Ssgw+iFt+cyjJYnXqu3FEGuOBQ2MFaFAzNkn0wyTUEzGZSJ9gQDsl7kVIrZ/LmDGEk
 Z0IBtVc4t6K6NWLNhk7D3NVTIFjiCke5/OeJKqCXIVT3pRGqkpxzCyYKuoaJ29gdA2
 Umj6vwDvxTDB/n05SMXB6NbsNND7v7HE36y//VzrHTySxj65PRWiKuM50+RXyMrlN3
 3fm47mxdrAwYk7POMGMdkyN69bZRN3JR4lJ8J4lxbPbT51MjGhBs4GN7WoScM/aL91
 PZ0KtfclTZGjA==
From: Felipe Balbi <balbi@kernel.org>
To: qemu-devel@nongnu.org
Cc: Samuel Tardieu <sam@rfc1149.net>,
	Felipe Balbi <balbi@kernel.org>
Subject: [PATCH v2 2/2] hw/arm: Add nucleo-g071rb board
Date: Wed, 20 Mar 2024 22:21:00 +0200
Message-ID: <20240320202100.820228-3-balbi@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240320202100.820228-1-balbi@kernel.org>
References: <20240320202100.820228-1-balbi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=balbi@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This board is based around STM32G071RB SoC, a Cortex-M0 based
device. More information can be found at:

https://www.st.com/en/product/nucleo-g071rb.html

Signed-off-by: Felipe Balbi <balbi@kernel.org>
---

Changes since v1:

    - Convert tabs to spaces (checkpatch.pl)

 MAINTAINERS            |  6 ++++
 hw/arm/Kconfig         |  6 ++++
 hw/arm/meson.build     |  1 +
 hw/arm/nucleo-g071rb.c | 70 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 83 insertions(+)
 create mode 100644 hw/arm/nucleo-g071rb.c

diff --git a/MAINTAINERS b/MAINTAINERS
index bce2eb3ad70b..052ce4dcfb97 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1116,6 +1116,12 @@ L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/netduinoplus2.c
 
+Nucleo G071RB
+M: Felipe Balbi <balbi@kernel.org>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: hw/arm/nucleo-g071rb.c
+
 Olimex STM32 H405
 M: Felipe Balbi <balbi@kernel.org>
 L: qemu-arm@nongnu.org
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 28a46d2b1ad3..5938bb8208a1 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -310,6 +310,12 @@ config STM32VLDISCOVERY
     depends on TCG && ARM
     select STM32F100_SOC
 
+config NUCLEO_G071RB
+    bool
+    default y
+    depends on TCG && ARM
+    select STM32G000_SOC
+
 config STRONGARM
     bool
     select PXA2XX
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 9c4137a988e1..580c2d55fc3f 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -18,6 +18,7 @@ arm_ss.add(when: 'CONFIG_REALVIEW', if_true: files('realview.c'))
 arm_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa-ref.c'))
 arm_ss.add(when: 'CONFIG_STELLARIS', if_true: files('stellaris.c'))
 arm_ss.add(when: 'CONFIG_STM32VLDISCOVERY', if_true: files('stm32vldiscovery.c'))
+arm_ss.add(when: 'CONFIG_NUCLEO_G071RB', if_true: files('nucleo-g071rb.c'))
 arm_ss.add(when: 'CONFIG_ZYNQ', if_true: files('xilinx_zynq.c'))
 arm_ss.add(when: 'CONFIG_SABRELITE', if_true: files('sabrelite.c'))
 
diff --git a/hw/arm/nucleo-g071rb.c b/hw/arm/nucleo-g071rb.c
new file mode 100644
index 000000000000..580b52bacf2c
--- /dev/null
+++ b/hw/arm/nucleo-g071rb.c
@@ -0,0 +1,70 @@
+/*
+ * ST Nucleo G071RB
+ *
+ * Copyright (c) 2024 Felipe Balbi <felipe@balbi.sh>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/boards.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-clock.h"
+#include "qemu/error-report.h"
+#include "hw/arm/stm32g000_soc.h"
+#include "hw/arm/boot.h"
+
+/* nucleo_g071rb implementation is derived from olimex-stm32-h405.c */
+
+/* Main SYSCLK frequency in Hz (48MHz) */
+#define SYSCLK_FRQ 48000000ULL
+
+static void nucleo_g071rb_init(MachineState *machine)
+{
+    DeviceState *dev;
+    Clock *sysclk;
+
+    /* This clock doesn't need migration because it is fixed-frequency */
+    sysclk = clock_new(OBJECT(machine), "SYSCLK");
+    clock_set_hz(sysclk, SYSCLK_FRQ);
+
+    dev = qdev_new(TYPE_STM32G000_SOC);
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
+    qdev_connect_clock_in(dev, "sysclk", sysclk);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    armv7m_load_kernel(ARM_CPU(first_cpu),
+                       machine->kernel_filename,
+                       0, FLASH_SIZE);
+}
+
+static void nucleo_g071rb_machine_init(MachineClass *mc)
+{
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-m0"),
+        NULL
+    };
+
+    mc->desc = "ST Nucleo-G071RB (Cortex-M0)";
+    mc->init = nucleo_g071rb_init;
+    mc->valid_cpu_types = valid_cpu_types;
+}
+
+DEFINE_MACHINE("nucleo-g071rb", nucleo_g071rb_machine_init)
-- 
2.44.0


