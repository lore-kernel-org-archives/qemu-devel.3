Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB508C5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:17:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7tF-00059R-FA; Wed, 12 Aug 2026 08:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7tD-0004xf-97
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:16:59 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7tA-00008v-LR
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:16:58 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-495590dde14so10845185e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786537015; x=1787141815; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e0YVN3WRoWrd/UG2bcPyhH+dTDALg7wvKBtIHRwrjZA=;
 b=Xn6uV2jQX/qrwF3WZAVlijIL1/TdEst1chnKV06BlhmLTz/3k+RrbxY1uGfmpV+3JC
 8pje08xymUz52isVEwx7PB2rjVNjhXgaDZcfLUXEn6In67/RgqNKMTcPkMX1sdIKLX/M
 Y1OGveQGq3rpPV80LVX3UrbzxTci/k10FCeiRki1t0uH0BExayX+txzoBt/WntX+YAJM
 xIBcAIhUwegZxSObLYTNowuCoKek8RITLMvvj7kqHM11rvLG58KeQSo3OMYzEdA4kSBR
 sRKYMIIZF3OGhE0Fi744Ac2yUInLgw7ZOd8tjrWkf4zQN+uPOksuOiYBxDoMlymk+GHG
 sbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786537015; x=1787141815;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e0YVN3WRoWrd/UG2bcPyhH+dTDALg7wvKBtIHRwrjZA=;
 b=KSlzIUG80PIdt4nKRBoDU8zg9DDP3KKWsWQNWfasABOxGoI+gLtrGVh/ybf8X+Z6Rp
 +TXphpgYNRymw3swc+9efnR+hS+HuNLKwzt2sY5ycOq0Et7yZvaj223ZIew3FjbdfXaK
 ypXxX5MiOx2M05IsQa9FUweOE5rDUz0nQ36zdpq2wy4GD7ZJhGL5RlvNIK7zd098L6Xg
 KmqiRIlMWO19c+krTJgTRTl10C5BPRzCPHFPhNMWJ+SLr1YCIuD+iNXLqAS1edwS7ohj
 wpeCOeGeRyx/D9IHEHwWJA58QvlEz7Ttt0hepYKFpjpsMpQDSqKRNYeMBkSmC/N12iF8
 0etA==
X-Gm-Message-State: AOJu0YzuFd4GK4VBdBkstN8D6Uw4pylKZ+7iycRoRqDfeJ9754n9ZBUq
 uLnXNrDkrB8/CIhmuHkt1iMIc6Fs340mhq0rUh1Wohwyji0LhpRdW7qTBxinga9Yc2uI0sbKdk/
 wbWaW
X-Gm-Gg: AR+sD13aiC3w4oB82X/D5vh8SJ0a7gupK4VjrbVYCv8zvAd1KKMQ88DFqpSMB5LdaUV
 GjC5CXBvbG/jVzsJk7bu0ucvvdwoN1XhC8B2gehLlq4zlVK+//Lq5XtJ2cZ/uScO3y8Nwy9l3Kg
 F524lBugqE6DWRhD0Y+2+tv5HfYrCinhN1cZqEDQPWUrIO+lNpIRXSznormkSPV6qpASAbEBlgx
 Rgs+pDQGv8UGkbKkU/dqiLHZ3hZ+fxtTzJ1sjrITFmRaHekNf9IJxbbZI81FlIzVrHLkmlZxvqk
 M+UuwX1fYBFsKnk4ufduKK3DpC0PpaI9/d02hFN4PjdIm728ePR7mCasYrBd1ipTCL21DiqgCEl
 Hjxu9gwpR+T5mD0VJ8h8fZQGxs/WEJHu5CsMVQ5rE4YEh5qjVOSqjBtj/vDVs7BmMzMZJ6ghBYq
 ECWQUJz4ToPKoq1yZj1HGjZd7hmTxmDWYZ83VOhXMuK+jE7lkp4Z8iX8n21mz6S7r2JMmsHlFWZ
 ws12KHaylyzl8ssU34sjjpunZt58C6ZNUQAYJBdSaBB3MopHHiljM73gGaOTmku2+8GUw==
X-Received: by 2002:a05:600c:1d0c:b0:495:7a5a:d96c with SMTP id
 5b1f17b1804b1-4997c163b3fmr57113335e9.18.1786537015162; 
 Wed, 12 Aug 2026 05:16:55 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997ad79e5csm36963805e9.3.2026.08.12.05.16.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 05:16:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/26] hw/arm: ax3000-soc: Enable Cadence GPIO controllers
Date: Wed, 12 Aug 2026 13:16:14 +0100
Message-ID: <20260812121622.649730-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812121622.649730-1-peter.maydell@linaro.org>
References: <20260812121622.649730-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

From: Kuan-Jui Chiu <kchiu@axiado.com>

Enable 8 Cadence GPIO controllers into Axiado AX3000 SoC

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260713073033.3883619-9-kchiu@axiado.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Kconfig              |  1 +
 hw/arm/ax3000-soc.c         | 30 ++++++++++++++++++++++++++++++
 include/hw/arm/ax3000-soc.h | 21 +++++++++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index d16b3d2f47..e22c34a2e1 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -731,6 +731,7 @@ config AXIADO_SOC
     select ARM_GIC
     select CADENCE # UART
     select AXIADO_CLK
+    select CADENCE_GPIO
     select AXIADO_SDHCI
     select UNIMP
 
diff --git a/hw/arm/ax3000-soc.c b/hw/arm/ax3000-soc.c
index 23903b081b..71e31c6fb4 100644
--- a/hw/arm/ax3000-soc.c
+++ b/hw/arm/ax3000-soc.c
@@ -36,6 +36,11 @@ static void ax3000_init(Object *obj)
 
     object_initialize_child(obj, "clk", &s->ax3000_clk, TYPE_AX3000_CLK);
     object_initialize_child(obj, "sdhci0", &s->sdhci0, TYPE_AXIADO_SDHCI);
+
+    for (int i = 0; i < AX3000_NUM_GPIOS; i++) {
+        g_autofree char *name = g_strdup_printf("gpio%d", i);
+        object_initialize_child(obj, name, &s->gpio[i], TYPE_CADENCE_GPIO);
+    }
 }
 
 static void ax3000_realize(DeviceState *dev, Error **errp)
@@ -187,6 +192,31 @@ static void ax3000_realize(DeviceState *dev, Error **errp)
                                 &error_fatal);
         qdev_realize_and_unref(card, s->sdhci0.sd_bus, &error_fatal);
     }
+
+    /* GPIOs */
+    const struct {
+        hwaddr addr;
+        unsigned int irq;
+    } gpio_table[] = {
+        { AX3000_GPIO0_BASE, AX3000_GPIO0_IRQ },
+        { AX3000_GPIO1_BASE, AX3000_GPIO1_IRQ },
+        { AX3000_GPIO2_BASE, AX3000_GPIO2_IRQ },
+        { AX3000_GPIO3_BASE, AX3000_GPIO3_IRQ },
+        { AX3000_GPIO4_BASE, AX3000_GPIO4_IRQ },
+        { AX3000_GPIO5_BASE, AX3000_GPIO5_IRQ },
+        { AX3000_GPIO6_BASE, AX3000_GPIO6_IRQ },
+        { AX3000_GPIO7_BASE, AX3000_GPIO7_IRQ }
+    };
+
+    for (int i = 0; i < AX3000_NUM_GPIOS; i++) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), errp)) {
+            return;
+        }
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio[i]), 0, gpio_table[i].addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio[i]), 0,
+                           qdev_get_gpio_in(gic_dev, gpio_table[i].irq));
+    }
 }
 
 static void ax3000_class_init(ObjectClass *oc, const void *data)
diff --git a/include/hw/arm/ax3000-soc.h b/include/hw/arm/ax3000-soc.h
index 52b47aa829..344fcb6f3c 100644
--- a/include/hw/arm/ax3000-soc.h
+++ b/include/hw/arm/ax3000-soc.h
@@ -13,6 +13,7 @@
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/char/cadence_uart.h"
 #include "hw/misc/axiado_clk.h"
+#include "hw/gpio/cadence_gpio.h"
 #include "hw/sd/axiado_sdhci.h"
 #include "hw/core/sysbus.h"
 #include "qemu/units.h"
@@ -38,6 +39,15 @@ OBJECT_DECLARE_TYPE(Ax3000SoCState, Ax3000SoCClass, AX3000_SOC)
 #define AX3000_SDHCI0_BASE      0x86000000
 #define AX3000_EMMC_PHY_BASE    0x80801C00
 
+#define AX3000_GPIO0_BASE       0x80500000
+#define AX3000_GPIO1_BASE       0x80580000
+#define AX3000_GPIO2_BASE       0x80600000
+#define AX3000_GPIO3_BASE       0x80680000
+#define AX3000_GPIO4_BASE       0x80700000
+#define AX3000_GPIO5_BASE       0x80780000
+#define AX3000_GPIO6_BASE       0x80800000
+#define AX3000_GPIO7_BASE       0x80880000
+
 #define AX3000_TIMER_CTRL       0x8A020000
 #define AX3000_PLL_BASE         0x80000000
 
@@ -46,6 +56,7 @@ enum Ax3000Configuration {
     AX3000_NUM_IRQS     = 224,
     AX3000_NUM_BANKS    = 2,
     AX3000_NUM_UARTS    = 4,
+    AX3000_NUM_GPIOS    = 8,
 };
 
 typedef struct Ax3000SoCState {
@@ -56,6 +67,7 @@ typedef struct Ax3000SoCState {
     MemoryRegion        dram[AX3000_NUM_BANKS];
     Ax3000ClkState      ax3000_clk;
     CadenceUARTState    uart[AX3000_NUM_UARTS];
+    CadenceGPIOState    gpio[AX3000_NUM_GPIOS];
     AxiadoSDHCIState    sdhci0;
 } Ax3000SoCState;
 
@@ -72,6 +84,15 @@ enum Ax3000Irqs {
     AX3000_UART3_IRQ    = 170,
 
     AX3000_SDHCI0_IRQ   = 123,
+
+    AX3000_GPIO0_IRQ    = 183,
+    AX3000_GPIO1_IRQ    = 184,
+    AX3000_GPIO2_IRQ    = 185,
+    AX3000_GPIO3_IRQ    = 186,
+    AX3000_GPIO4_IRQ    = 187,
+    AX3000_GPIO5_IRQ    = 188,
+    AX3000_GPIO6_IRQ    = 189,
+    AX3000_GPIO7_IRQ    = 190,
 };
 
 #endif /* AXIADO_AX3000_H */
-- 
2.43.0


