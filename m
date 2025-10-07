Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F193CCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68Qu-00061h-Qj; Tue, 07 Oct 2025 10:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68QS-0005oo-7d
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:25 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68QC-0002G4-7z
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:23 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46e2e363118so57806505e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846323; x=1760451123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GFnB0dE3EY2EnfVj9Zafs1tOQvVMrxpMd2tdX/02X84=;
 b=LXEshL99WHVoxqVYfa9ccSuv59ZB+m345u1tkGM+hxiqGBgYY1GG+RcuL75La/c599
 KdLtxOi4kxABREr73QI1AYtOzVxZ52AxtZC85GSWmJsNEwNGHq6QUttTMSQzK3m5lq4T
 KzI4cdZyAQm2HFf2VuTT7AA3Bk9WXf31WLMDZczxRzMsgqYIeCNYcQRlr6xc0aTyfbr9
 LZis8AXv4/2+yzDibGwosYuA3cn17XNDcC5IY2mPmrxODfknNwMIrYnL3BtX1NpEdCSV
 668CgaBo5l62AsbMEq9u1k3M2tt0lp1R+q99JV8lupTu8eIXH/wZdBpUoJENrEsNdsVP
 FMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846323; x=1760451123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GFnB0dE3EY2EnfVj9Zafs1tOQvVMrxpMd2tdX/02X84=;
 b=t42suFxbZbVQkE3EYvVsL22Ci0++4W0L7rAxOfg9z67Uq/0ksFdQYLhr21pW24tCGu
 pkyZPLeXbXSJLYfofQH19DogCeRmjX3nWcBeBYe4wILIaAgIERwfdr9ax/jjTbt4pQ6S
 +A1ZU/8FpPu8GT1PhKk5ghUXfi16rQkwCyLgRJrIfuYz7ISopu8ilUT4QhX+trV3JqbZ
 Z8yUig4SGUwlJWO5bgTCa787ORHnteQ57lhpDsEnJZD7IMO2hATyg4xhSMKPJzv+SlbK
 yO9aOLFSQrF2/kzNMuuZ8VZm2I+Skw4J8PaZQKhFL2AeuKWj1djdtUR+NjFrDwQmByC+
 Hkjw==
X-Gm-Message-State: AOJu0YyH+EV3f7dFM68eX380DYmD1+vZBsJ30F3Gp+raAQP8GMBaPt6Q
 sAh27MkFfCvloIKCHk6tP8ub3k8llTGrPEDOUhpUU+YLKdC6HRKWTATTrmfPSe4fT0zGclc6wMB
 swgwQ
X-Gm-Gg: ASbGncsUjKweOM1LRZNk+bDinAYS8Fh9Vxi4Z7Por8rlo6F2V0ezOkE/gf9VTjpjGs8
 9Nzcyi9GmT2St5yInrbO/KfFacdsglXiTR27rrQeW5kaKMsNTlWcDGLx0W7PoafZeUoVbKNg++H
 CkE27QBZmrSClfr6OdxRY/hzwHlSkNyOT0kI/nUu74qdh5+dlBCSaM3fe595DPbvtS7Azj1kS5h
 gYkixizsUsOW9L5w1F9Xmlnrv78OxwFc3Cd5yvlsYSk4g8b/T4/SIV6i7xVcO5xZGaHCmktfgEU
 wxKd1l3gsmElgznH5X+WjSGzVwG41lXdnz24RYDNde2m0yOMMrE6RSfV1BwGCeliCaaIOngK/oR
 jWZgqgEoAmc+gLQb+yILIjwu6dOMGozSyo9gIcB+a5gvKT5a6oUGiJWFw
X-Google-Smtp-Source: AGHT+IFxsS87KT6f2nDQRRwvz9VS7eu/kzpLb2WdBZkBvPrQECig8mgNI6z3nqWNzot8dyFlDWQLvQ==
X-Received: by 2002:a05:600c:6092:b0:46e:48fd:a1a9 with SMTP id
 5b1f17b1804b1-46e7117258cmr117242725e9.33.1759846322901; 
 Tue, 07 Oct 2025 07:12:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.12.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:12:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/62] hw/arm/xlnx-versal: use hw/arm/bsa.h for timer IRQ
 indices
Date: Tue,  7 Oct 2025 15:10:55 +0100
Message-ID: <20251007141123.3239867-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Luc Michel <luc.michel@amd.com>

Use the bsa.h header for ARM timer and maintainance IRQ indices instead
of redefining our owns.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250926070806.292065-35-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/xlnx-versal.h |  6 ------
 hw/arm/xlnx-versal.c         | 28 +++++++++++++++++-----------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 7bdf6dab629..da0260b83de 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -87,12 +87,6 @@ int versal_get_num_sdhci(VersalVersion version);
 /* Memory-map and IRQ definitions. Copied a subset from
  * auto-generated files.  */
 
-#define VERSAL_GIC_MAINT_IRQ        9
-#define VERSAL_TIMER_VIRT_IRQ       11
-#define VERSAL_TIMER_S_EL1_IRQ      13
-#define VERSAL_TIMER_NS_EL1_IRQ     14
-#define VERSAL_TIMER_NS_EL2_IRQ     10
-
 #define VERSAL_CRL_IRQ             10
 #define VERSAL_UART0_IRQ_0         18
 #define VERSAL_UART1_IRQ_0         19
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 6604e24a9cd..dc388300185 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -49,6 +49,7 @@
 #include "hw/core/split-irq.h"
 #include "target/arm/cpu.h"
 #include "hw/cpu/cluster.h"
+#include "hw/arm/bsa.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
@@ -673,7 +674,8 @@ static DeviceState *versal_create_gic(Versal *s,
         qemu_fdt_setprop_cell(s->cfg.fdt, node, "phandle", s->phandle.gic);
         qemu_fdt_setprop_cell(s->cfg.fdt, node, "#interrupt-cells", 3);
         qemu_fdt_setprop_cells(s->cfg.fdt, node, "interrupts",
-                               GIC_FDT_IRQ_TYPE_PPI, VERSAL_GIC_MAINT_IRQ,
+                               GIC_FDT_IRQ_TYPE_PPI,
+                               INTID_TO_PPI(ARCH_GIC_MAINT_IRQ),
                                GIC_FDT_IRQ_FLAGS_LEVEL_HI);
         qemu_fdt_setprop(s->cfg.fdt, node, "interrupt-controller", NULL, 0);
     }
@@ -698,10 +700,10 @@ static void connect_gic_to_cpu(const VersalCpuClusterMap *map,
      * GIC PPI inputs.
      */
     const int timer_irq[] = {
-        [GTIMER_PHYS] = VERSAL_TIMER_NS_EL1_IRQ,
-        [GTIMER_VIRT] = VERSAL_TIMER_VIRT_IRQ,
-        [GTIMER_HYP]  = VERSAL_TIMER_NS_EL2_IRQ,
-        [GTIMER_SEC]  = VERSAL_TIMER_S_EL1_IRQ,
+        [GTIMER_PHYS] = INTID_TO_PPI(ARCH_TIMER_NS_EL1_IRQ),
+        [GTIMER_VIRT] = INTID_TO_PPI(ARCH_TIMER_VIRT_IRQ),
+        [GTIMER_HYP]  = INTID_TO_PPI(ARCH_TIMER_NS_EL2_IRQ),
+        [GTIMER_SEC]  = INTID_TO_PPI(ARCH_TIMER_S_EL1_IRQ),
     };
 
     has_gtimer = arm_feature(&ARM_CPU(cpu)->env, ARM_FEATURE_GENERIC_TIMER);
@@ -716,9 +718,9 @@ static void connect_gic_to_cpu(const VersalCpuClusterMap *map,
 
     if (map->gic.version == 3) {
         qemu_irq maint_irq;
+        int maint_idx = ppibase + INTID_TO_PPI(ARCH_GIC_MAINT_IRQ);
 
-        maint_irq = qdev_get_gpio_in(gic,
-                                     ppibase + VERSAL_GIC_MAINT_IRQ);
+        maint_irq = qdev_get_gpio_in(gic, maint_idx);
         qdev_connect_gpio_out_named(cpu, "gicv3-maintenance-interrupt",
                                     0, maint_irq);
     }
@@ -842,13 +844,17 @@ static void versal_create_cpu_cluster(Versal *s, const VersalCpuClusterMap *map)
     if (map->dtb_expose && has_gtimer) {
         qemu_fdt_add_subnode(s->cfg.fdt, "/timer");
         qemu_fdt_setprop_cells(s->cfg.fdt, "/timer", "interrupts",
-                               GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_S_EL1_IRQ,
+                               GIC_FDT_IRQ_TYPE_PPI,
+                               INTID_TO_PPI(ARCH_TIMER_S_EL1_IRQ),
                                GIC_FDT_IRQ_FLAGS_LEVEL_HI,
-                               GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_NS_EL1_IRQ,
+                               GIC_FDT_IRQ_TYPE_PPI,
+                               INTID_TO_PPI(ARCH_TIMER_NS_EL1_IRQ),
                                GIC_FDT_IRQ_FLAGS_LEVEL_HI,
-                               GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_VIRT_IRQ,
+                               GIC_FDT_IRQ_TYPE_PPI,
+                               INTID_TO_PPI(ARCH_TIMER_VIRT_IRQ),
                                GIC_FDT_IRQ_FLAGS_LEVEL_HI,
-                               GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_NS_EL2_IRQ,
+                               GIC_FDT_IRQ_TYPE_PPI,
+                               INTID_TO_PPI(ARCH_TIMER_NS_EL2_IRQ),
                                GIC_FDT_IRQ_FLAGS_LEVEL_HI);
         qemu_fdt_setprop(s->cfg.fdt, "/timer", "compatible",
                          compatible, sizeof(compatible));
-- 
2.43.0


