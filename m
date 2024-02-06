Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33694C4829A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 13:32:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXLWL-0000wt-Jz; Tue, 06 Feb 2024 08:29:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXLWC-0000eb-TX
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 08:29:44 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXLW7-0008Fa-92
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 08:29:44 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33b4b121de1so22089f8f.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 05:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707226178; x=1707830978; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=J5yMl9ruByZ2cE+u8xokLZN5yHG5tcwG0U9htQdpN5s=;
 b=C4jwr3tIuzk9Hwwqph03lWD6AOZ2oaIWffPAJIgdU4w3QiokXpr78aDkunZpiYA7+l
 FMZQ6RspLhjjsJBUM2kRSKZ+NgvVaJAYqYmemYEC39MdvKY0mFNsKkMCalxaNHsdeR36
 v8sSsBol54JRttECsE3yyFPV5/6Iwo13y7HrbGRhW1tMZYLiecS6V6XkaOZKEOX1FTnI
 pTWPm3lFukf4kvVmZqCWlu3dHomci5A1qWcn8UX0VkwzrYGLne4LjBXhkvhd/cB6h1s4
 6LxDKIO1UXoIgO8Bwgs52FkZbVha0UESX5SjZlamLnXH6hOeXOzqw7f2bdZwBnFGNMQq
 7tsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707226178; x=1707830978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J5yMl9ruByZ2cE+u8xokLZN5yHG5tcwG0U9htQdpN5s=;
 b=BjZHT7k9BWfYX/wjFnkrVMA9rYQnpyMoMwUiCTlNohAaA9w3fTCSJ5B750mCEl9+VI
 Lg5E6kRGkoeL0Bki9LoIQ1et5b/hz7vQp7JW8HSjgh4AOtsqF/Ugy3h7V71a342XXwpq
 Ut6JDX/25QZh2nzoKCPfPWlP395pw4A63ZMXb3J0vf5Eed/gEZHzjk3NQ4s0X8lt0Ggg
 iGt4IEOLrJ5o3UxzwuJJtJHsUiacdJrSqb75sZM/aaEHSj4rf/8jLPTXP2FrU+tDW7Q2
 8tViKpbLP1psgQUTZ8lWIrHA28r8QzJVlx4xvsdpDirv32BEGwz2B+2fEMmyy0bhXwld
 MOOw==
X-Gm-Message-State: AOJu0YygHyacwK7OJnnwWCC1Qc0XDFesAaXHg1XH3yzzXGE6Z9EbFkIL
 qgcHzfDLrXHZnLb09VuuSxFPLkaByJmN3R6P/IKLFEUsJljvyCcsaF/dIjkRKM1/fdo/Cp845t/
 6
X-Google-Smtp-Source: AGHT+IGJvFe6XqFhA1xaBxWHBA9Ghh+clmTanKzRnQWuoyED9yHlze9foDMZt4bqJnLnA9CxxQlUVA==
X-Received: by 2002:a5d:6149:0:b0:33b:3bad:d3ee with SMTP id
 y9-20020a5d6149000000b0033b3badd3eemr1086210wrt.43.1707226177904; 
 Tue, 06 Feb 2024 05:29:37 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUm3OJ+YgXMLd6kJSMRIxqT4sbIwJIZMJrMnDjLXvXMlACoLZFW3VVz/n6UR6uveoXDeeEmUZtD2D6m5ViNreTKdhtzkc4=
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a056000108700b0033b470a137esm1492932wrw.79.2024.02.06.05.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 05:29:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 11/13] hw/arm/mps3r: Add GPIO, watchdog, dual-timer,
 I2C devices
Date: Tue,  6 Feb 2024 13:29:29 +0000
Message-Id: <20240206132931.38376-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206132931.38376-1-peter.maydell@linaro.org>
References: <20240206132931.38376-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

Add the GPIO, watchdog, dual-timer and I2C devices to the mps3-an536
board.  These are all simple devices that just need to be created and
wired up.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/mps3r.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
index 8c790313790..803ed0ffb5c 100644
--- a/hw/arm/mps3r.c
+++ b/hw/arm/mps3r.c
@@ -33,11 +33,16 @@
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
 #include "hw/or-irq.h"
+#include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/bsa.h"
 #include "hw/char/cmsdk-apb-uart.h"
+#include "hw/i2c/arm_sbcon_i2c.h"
 #include "hw/intc/arm_gicv3.h"
+#include "hw/misc/unimp.h"
+#include "hw/timer/cmsdk-apb-dualtimer.h"
+#include "hw/watchdog/cmsdk-apb-watchdog.h"
 
 /* Define the layout of RAM and ROM in a board */
 typedef struct RAMInfo {
@@ -97,6 +102,10 @@ struct MPS3RMachineState {
     CMSDKAPBUART uart[MPS3R_CPU_MAX + MPS3R_UART_MAX];
     OrIRQState cpu_uart_oflow[MPS3R_CPU_MAX];
     OrIRQState uart_oflow;
+    CMSDKAPBWatchdog watchdog;
+    CMSDKAPBDualTimer dualtimer;
+    ArmSbconI2CState i2c[5];
+    Clock *clk;
 };
 
 #define TYPE_MPS3R_MACHINE "mps3r"
@@ -329,6 +338,9 @@ static void mps3r_common_init(MachineState *machine)
     MemoryRegion *sysmem = get_system_memory();
     DeviceState *gicdev;
 
+    mms->clk = clock_new(OBJECT(machine), "CLK");
+    clock_set_hz(mms->clk, CLK_FRQ);
+
     for (const RAMInfo *ri = mmc->raminfo; ri->name; ri++) {
         MemoryRegion *mr = mr_for_raminfo(mms, ri);
         memory_region_add_subregion(sysmem, ri->base, mr);
@@ -421,6 +433,53 @@ static void mps3r_common_init(MachineState *machine)
                     qdev_get_gpio_in(gicdev, combirq));
     }
 
+    for (int i = 0; i < 4; i++) {
+        /* CMSDK GPIO controllers */
+        g_autofree char *s = g_strdup_printf("gpio%d", i);
+        create_unimplemented_device(s, 0xe0000000 + i * 0x1000, 0x1000);
+    }
+
+    object_initialize_child(OBJECT(mms), "watchdog", &mms->watchdog,
+                            TYPE_CMSDK_APB_WATCHDOG);
+    qdev_connect_clock_in(DEVICE(&mms->watchdog), "WDOGCLK", mms->clk);
+    sysbus_realize(SYS_BUS_DEVICE(&mms->watchdog), &error_fatal);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&mms->watchdog), 0,
+                       qdev_get_gpio_in(gicdev, 0));
+    sysbus_mmio_map(SYS_BUS_DEVICE(&mms->watchdog), 0, 0xe0100000);
+
+    object_initialize_child(OBJECT(mms), "dualtimer", &mms->dualtimer,
+                            TYPE_CMSDK_APB_DUALTIMER);
+    qdev_connect_clock_in(DEVICE(&mms->dualtimer), "TIMCLK", mms->clk);
+    sysbus_realize(SYS_BUS_DEVICE(&mms->dualtimer), &error_fatal);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&mms->dualtimer), 0,
+                       qdev_get_gpio_in(gicdev, 3));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&mms->dualtimer), 1,
+                       qdev_get_gpio_in(gicdev, 1));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&mms->dualtimer), 2,
+                       qdev_get_gpio_in(gicdev, 2));
+    sysbus_mmio_map(SYS_BUS_DEVICE(&mms->dualtimer), 0, 0xe0101000);
+
+    for (int i = 0; i < ARRAY_SIZE(mms->i2c); i++) {
+        static const hwaddr i2cbase[] = {0xe0102000,    /* Touch */
+                                         0xe0103000,    /* Audio */
+                                         0xe0107000,    /* Shield0 */
+                                         0xe0108000,    /* Shield1 */
+                                         0xe0109000};   /* DDR4 EEPROM */
+        g_autofree char *s = g_strdup_printf("i2c%d", i);
+
+        object_initialize_child(OBJECT(mms), s, &mms->i2c[i],
+                                TYPE_ARM_SBCON_I2C);
+        sysbus_realize(SYS_BUS_DEVICE(&mms->i2c[i]), &error_fatal);
+        sysbus_mmio_map(SYS_BUS_DEVICE(&mms->i2c[i]), 0, i2cbase[i]);
+        if (i != 2 && i != 3) {
+            /*
+             * internal-only bus: mark it full to avoid user-created
+             * i2c devices being plugged into it.
+             */
+            qbus_mark_full(qdev_get_child_bus(DEVICE(&mms->i2c[i]), "i2c"));
+        }
+    }
+
     mms->bootinfo.ram_size = machine->ram_size;
     mms->bootinfo.board_id = -1;
     mms->bootinfo.loader_start = mmc->loader_start;
-- 
2.34.1


