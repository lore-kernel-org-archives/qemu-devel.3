Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DC110ED659
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65Du-0002HY-Mr; Fri, 27 Mar 2026 07:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65CY-0007aI-R6
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:18:07 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65CV-0000HU-9Q
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:18:06 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43b3d9d0695so1384743f8f.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774610281; x=1775215081; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ji4M7/zlXLPLxa6vnn4WlUzf8phK32eQHNKPiB6p3iM=;
 b=Gzb8LvQskAVU9rQmNYqnAXX/hHYLAYqNSyrzPD6LhpQtjEBpW6CHVe9kpSuwM4HZpl
 PFf1kRukH+Id/DH2OyG30Cz4z/xV5M/rZgjnw9LZEUM06IWbcEryLW3Ge6ztfAdvt4fv
 o0HmPSlAqExPpfx5Be1EPKKcerzKtg3p1AlwTBnw/eRJQ1sPpdRJJAtMiw0pbSF3D7oO
 AByXvaiEVKR7VkX9WZtudqxbFf6VksxYeBGt8gT7ddnQWhp7QGg6djN1eBKzVkn9I6D8
 ck1m3ew7vJXauJQXD5wFJfPgEeIaGlBJ56stjysvNb0BCbr+6iKOM0ks2ACKB9zB/QdH
 KsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610281; x=1775215081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ji4M7/zlXLPLxa6vnn4WlUzf8phK32eQHNKPiB6p3iM=;
 b=bS0Tk61Pw4DQWC4cst5aTCGs0jwP5ow5+GQcDkc58GKVp8WmEIvGg4dtVXSB8MCmtj
 9Q6Din7kTSgoGAJO9q3s2EDIHcUVnu0rt7k8+2M+tX3hilVJLB6hi9Ca+9p0cpnVvzK1
 p0HW3Ta4iMM++fU1S27Y5C8zuF1evjRFUbPOicmvNCrMvUjjUgTsbWElCBi/k6kcxWNX
 VpAKJcCiKD59dSGkXL7psViUsrrUa6TuyYVfQ+SMHkh2fqWR599ORxIP1+0/V+C9vF08
 lzOAikNyYWN1WmehJM0T4s4Qxg9QS2y8NXxFsYDtMEXd4zkYNsEuCy0HCREasHguYxpk
 gACQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfW9MXZzTPgJbrdBuS3c3dp1l3HUkGcizO2rfr7ggRKu/6irAm19jr3Op28tuy5T7t1/AN508kNuyZ@nongnu.org
X-Gm-Message-State: AOJu0YzXRMUKZjSdr8DEF5F9TXF92haESV5pSU/GII8dZAmmQnrivYEV
 NNm8m25ZlmshqjAWSjm7dLDz5HYJOQGkEFcraKS7FRLsycuO7Yn6f49a41r89eAlZKM=
X-Gm-Gg: ATEYQzw9T2J9u4co30sejut47H4XeO0lJQyrP/THz3AuHY7Qe+Ism1uAx8CuRNRLjv4
 rPYwHwDebGHJJaYJFjv3M+bmQzaTl8dlPIytFBeTemltEOcV4XYrUxjdl4SYJGOBX6gJqw/H+Ad
 ns+vrdOidOKrZWnGApdideKExty2bB9sT33W9vUJe4o7HKTNGyKvCRQtovCRINy91vlYTa622ak
 KVIZRLRXOSmMHTDCyIieqDbUJ5tR7W7wWLCyTn/wGORpWS3GEBmJeK7SME+8YImt6Gk2Ibf/MNY
 GB4BLjMMo3BwNobfat/dmA9gtOfTyCH7Csikv2OauTjoAcnoeJMT6EaGHUAZHTmoauaJsbQHJhs
 CCChrJr/6K+97JvK2j0t/zBoGeRbAU0jtZyKUjPStqtrz/X0iiXYslnbyUVGyeBSuR9x7EnoG/Q
 B96BnLamAEyoqH9pwnKBi2dhrdaLrC7ISfu9y5vN8e7vfnu+Lfjn7PITD/HL4hs9PN0+w88I3kD
 McqdubIVmPR0DKwfkQVw5MvtmaUET/nmKC/sMeMPQ==
X-Received: by 2002:a05:6000:410b:b0:439:cc5e:a6d5 with SMTP id
 ffacd0b85a97d-43b97a62151mr5327271f8f.23.1774610281203; 
 Fri, 27 Mar 2026 04:18:01 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm15484227f8f.18.2026.03.27.04.18.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 04:18:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 62/65] hw/arm/virt: Handle GICv5 in interrupt bindings for
 PPIs
Date: Fri, 27 Mar 2026 11:16:57 +0000
Message-ID: <20260327111700.795099-63-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327111700.795099-1-peter.maydell@linaro.org>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

The GICv5 devicetree binding specifies the "interrupts" property
differently to GICv2 and GICv3 for PPIs: the first field is the
architectural INTID.TYPE, and the second is the architectural
INTID.ID.  (The third field defining the level/edge trigger mode has
the same values for GICv5 as it did for the older GICs.)

In the places in the virt board where we wire up PPIs (the timer and
the PMU), handle the GICv5:

 * use the architectural constant GICV5_PPI for the type
 * use the architected GICv5 PPI numbers for the interrupt sources
   (which differ from the old ones and don't need to be adjusted via
   INTID_TO_PPI())
 * leave the irqflags as-is

Add some commentary in our include/hw/arm/fdt.h file about what the
the constants defined there are valid for.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 hw/arm/virt.c        | 23 +++++++++++++++++++----
 include/hw/arm/fdt.h | 10 ++++++++++
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7a34af766a..bc49cf244f 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -420,7 +420,15 @@ static void fdt_add_timer_nodes(const VirtMachineState *vms)
                                 "arm,armv7-timer");
     }
     qemu_fdt_setprop(ms->fdt, "/timer", "always-on", NULL, 0);
-    if (vms->ns_el2_virt_timer_irq) {
+    if (vms->gic_version == VIRT_GIC_VERSION_5) {
+        /* The GICv5 architects the PPI numbers differently */
+        qemu_fdt_setprop_cells(ms->fdt, "/timer", "interrupts",
+                               GICV5_PPI, GICV5_PPI_CNTPS, irqflags,
+                               GICV5_PPI, GICV5_PPI_CNTP, irqflags,
+                               GICV5_PPI, GICV5_PPI_CNTV, irqflags,
+                               GICV5_PPI, GICV5_PPI_CNTHP, irqflags,
+                               GICV5_PPI, GICV5_PPI_CNTHV, irqflags);
+    } else if (vms->ns_el2_virt_timer_irq) {
         qemu_fdt_setprop_cells(ms->fdt, "/timer", "interrupts",
                                GIC_FDT_IRQ_TYPE_PPI,
                                INTID_TO_PPI(ARCH_TIMER_S_EL1_IRQ), irqflags,
@@ -699,11 +707,18 @@ static void fdt_add_pmu_nodes(const VirtMachineState *vms)
     qemu_fdt_add_subnode(ms->fdt, "/pmu");
     if (arm_feature(&armcpu->env, ARM_FEATURE_V8)) {
         const char compat[] = "arm,armv8-pmuv3";
+
         qemu_fdt_setprop(ms->fdt, "/pmu", "compatible",
                          compat, sizeof(compat));
-        qemu_fdt_setprop_cells(ms->fdt, "/pmu", "interrupts",
-                               GIC_FDT_IRQ_TYPE_PPI,
-                               INTID_TO_PPI(VIRTUAL_PMU_IRQ), irqflags);
+        if (vms->gic_version == VIRT_GIC_VERSION_5) {
+            qemu_fdt_setprop_cells(ms->fdt, "/pmu", "interrupts",
+                                   GICV5_PPI, GICV5_PPI_PMUIRQ, irqflags);
+        } else {
+            qemu_fdt_setprop_cells(ms->fdt, "/pmu", "interrupts",
+                                   GIC_FDT_IRQ_TYPE_PPI,
+                                   INTID_TO_PPI(VIRTUAL_PMU_IRQ),
+                                   irqflags);
+        }
     }
 }
 
diff --git a/include/hw/arm/fdt.h b/include/hw/arm/fdt.h
index c3d5015013..995652c27a 100644
--- a/include/hw/arm/fdt.h
+++ b/include/hw/arm/fdt.h
@@ -20,9 +20,19 @@
 #ifndef QEMU_ARM_FDT_H
 #define QEMU_ARM_FDT_H
 
+/*
+ * These are for GICv2/v3/v4 only; GICv5 encodes the interrupt type in
+ * the DTB "interrupts" properties differently, using constants that
+ * match the architectural INTID.Type. In QEMU those are available as
+ * the GICV5_PPI and GICV5_SPI enum values in arm_gicv5_types.h.
+ */
 #define GIC_FDT_IRQ_TYPE_SPI 0
 #define GIC_FDT_IRQ_TYPE_PPI 1
 
+/*
+ * The trigger type/level field in the DTB "interrupts" property has
+ * the same encoding for GICv2/v3/v4 and v5.
+ */
 #define GIC_FDT_IRQ_FLAGS_EDGE_LO_HI 1
 #define GIC_FDT_IRQ_FLAGS_EDGE_HI_LO 2
 #define GIC_FDT_IRQ_FLAGS_LEVEL_HI 4
-- 
2.43.0


