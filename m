Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F2C2C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 14:18:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEqQI-00045m-Df; Tue, 13 May 2025 10:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1uEqQ3-00043D-FK
 for qemu-devel@nongnu.org; Tue, 13 May 2025 10:15:43 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1uEqQ1-0005b0-9k
 for qemu-devel@nongnu.org; Tue, 13 May 2025 10:15:43 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-441d1ed82faso39761125e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 07:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1747145739; x=1747750539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e3t/nIVRg+2jwmgdqscl/THpDb4n/5JCjlQr5Qe7fL8=;
 b=Sry6ZYwpleV+byZK1JOUxOmixbn7WeItJOsf/MgVP1MRFwv9Srr0um2UUnQEmh614I
 JnqYmMWS8cT1i3SVl+3EJOWYQnFjkEk7RC2VRUjIa/OuQlhVLTVycOgsrrsXZFm5fpps
 lgwTjoemvd9W533qecwSkJjyh22jE7GuQ61Us1yO2DzHJdqKr+IbK8K4RLDOzrtOml4M
 1B+qjyEZWohJ37HeBIFmEjTX6PsI01L9aoAsgqAMjYdOBK0DNPMXmwkbWWTq99+zafCQ
 jUDOGn3VdBjiZQACagWgpuvoP6GAy9p757TFCu25oQwDbWjFhUfKuXTDRYT94GT75mx1
 XaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747145739; x=1747750539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e3t/nIVRg+2jwmgdqscl/THpDb4n/5JCjlQr5Qe7fL8=;
 b=hEHOxJUJBreT2yBESSuTymHuzt483aWeRhA6yb6wRQ4FUIwpkQH1sE/Qi09/779qf8
 SOZL727F2fyaVtRI64sbrGOGP14V4cv9dUw0Y9o49vMGHBsBfKrabmZrxomVcebAR6H8
 n6fJ8t2koeGqPy+XB7CfKWXOs8skCck2Hj8Y2R4MeoRMEQ1rbGFM8q7sk3cxV8BqXikF
 BtGGZIg70w9o7i4bNkf25D7BjNGWcGOo31XK8DZYzBYZjOdK9puLrT+IIaTVhGQws3zM
 NC0OBNdMD3FTEpHUQRQAmWQOGEloxR45+VfC2wdvJSu4GQ1xl1Rkk7XEShd9bSa0yXtc
 EMig==
X-Gm-Message-State: AOJu0Yw8Ez9kd+kTJxT8yqC8tI7bH+ZHCsvwqCnQSvJdTnJljillbiXJ
 KhLpZ6cSSbmF0gb8MCIWBFO32YNMBU2BjGJbEfqqKHI1WCDYSLPa+n1d39QE8Cb/AgxS7S/KOus
 =
X-Gm-Gg: ASbGnctiH082ahRN8eQ3eeOB6IJmS5F55dyJLzx9mGdxp/1VpsW9kakqXbDS0Qrao/m
 L/CF/yuAiLiEy59iUr3gHnU8eEh0v0rE6RpZiSRDLJjTbBjwoOItdeXEBWGE+O4yp7rHw/i9EVa
 Wbr6aA1iIYICsAu7wvLsQP8+e84botaAOAEPAmtKgoEwDi2IF3sz4mw692X84c5NWBsHjfT8BFz
 SgfuSEIpUAd0dG6PWEqApVp5r9NP4oefMB7E/JS6hHhnm1+HCUFvLkInSwMrhlkPZDDLYkhAbRp
 iKT1p/MX9s0vNjHVb8zdZ/ArR4YMf04llxMoXnO6EzrK49uFHyeo09fw8ok+DVgy2O5At4+yGsc
 apiEV9GGxZidd8XGPNnzG6gbCkRv8QaPyKNlkIP2fyLiyHlWQ
X-Google-Smtp-Source: AGHT+IHWSajJZ6WfViJEDnRWZO/QuobAgMzhlzMwcfuSCWNFAgIueY2VXPgfH7lHFDKOYZEmFhrX9Q==
X-Received: by 2002:a05:600c:3d14:b0:43c:fd27:a216 with SMTP id
 5b1f17b1804b1-442d6dd21demr135625765e9.23.1747145739335; 
 Tue, 13 May 2025 07:15:39 -0700 (PDT)
Received: from chigot-Dell.telnowedge.local
 (lmontsouris-659-1-24-67.w81-250.abo.wanadoo.fr. [81.250.175.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd3b7e7fsm213438805e9.39.2025.05.13.07.15.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 07:15:39 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, edgar.iglesias@gmail.com,
 alistair@alistair23.me, Frederic Konrad <konrad.frederic@yahoo.fr>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH 3/4] hw/arm/xlnx-zynqmp: wire a second GIC for the Cortex-R5
Date: Tue, 13 May 2025 16:14:47 +0200
Message-Id: <20250513141448.297946-4-chigot@adacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250513141448.297946-1-chigot@adacore.com>
References: <20250513141448.297946-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Frederic Konrad <konrad.frederic@yahoo.fr>

This wires a second GIC for the Cortex-R5, all the IRQs are split when there
is an RPU instanciated.

Signed-off-by: Clément Chigot <chigot@adacore.com>
---
 hw/arm/xlnx-zynqmp.c         | 88 +++++++++++++++++++++++++++++++++---
 include/hw/arm/xlnx-zynqmp.h |  6 +++
 2 files changed, 87 insertions(+), 7 deletions(-)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index ec96a46eec..be33669f87 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -26,8 +26,6 @@
 #include "target/arm/cpu-qom.h"
 #include "target/arm/gtimer.h"
 
-#define GIC_NUM_SPI_INTR 160
-
 #define ARM_PHYS_TIMER_PPI  30
 #define ARM_VIRT_TIMER_PPI  27
 #define ARM_HYP_TIMER_PPI   26
@@ -206,7 +204,7 @@ static const XlnxZynqMPGICRegion xlnx_zynqmp_gic_regions[] = {
 
 static inline int arm_gic_ppi_index(int cpu_nr, int ppi_index)
 {
-    return GIC_NUM_SPI_INTR + cpu_nr * GIC_INTERNAL + ppi_index;
+    return XLXN_ZYNQMP_GIC_NUM_SPI_INTR + cpu_nr * GIC_INTERNAL + ppi_index;
 }
 
 static void xlnx_zynqmp_create_rpu(MachineState *ms, XlnxZynqMPState *s,
@@ -377,6 +375,8 @@ static void xlnx_zynqmp_init(Object *obj)
     XlnxZynqMPState *s = XLNX_ZYNQMP(obj);
     int i;
     int num_apus = MIN(ms->smp.cpus, XLNX_ZYNQMP_NUM_APU_CPUS);
+    int num_rpus = MIN((int)(ms->smp.cpus - XLNX_ZYNQMP_NUM_APU_CPUS),
+                       XLNX_ZYNQMP_NUM_RPU_CPUS);
 
     object_initialize_child(obj, "apu-cluster", &s->apu_cluster,
                             TYPE_CPU_CLUSTER);
@@ -390,6 +390,12 @@ static void xlnx_zynqmp_init(Object *obj)
 
     object_initialize_child(obj, "gic", &s->gic, gic_class_name());
 
+    if (num_rpus > 0) {
+        /* Do not create the rpu_gic in case we don't have rpus..  */
+        object_initialize_child(obj, "rpu_gic", &s->rpu_gic,
+                                gic_class_name());
+    }
+
     for (i = 0; i < XLNX_ZYNQMP_NUM_GEMS; i++) {
         object_initialize_child(obj, "gem[*]", &s->gem[i], TYPE_CADENCE_GEM);
         object_initialize_child(obj, "gem-irq-orgate[*]",
@@ -439,6 +445,13 @@ static void xlnx_zynqmp_init(Object *obj)
     object_initialize_child(obj, "qspi-irq-orgate",
                             &s->qspi_irq_orgate, TYPE_OR_IRQ);
 
+    for (i = 0; i < ARRAY_SIZE(s->splitter); i++) {
+        g_autofree char *name = g_strdup_printf("irq-splitter%d", i);
+        object_initialize_child(obj, name, &s->splitter[i], TYPE_SPLIT_IRQ);
+    }
+
+
+
     for (i = 0; i < XLNX_ZYNQMP_NUM_USB; i++) {
         object_initialize_child(obj, "usb[*]", &s->usb[i], TYPE_USB_DWC3);
     }
@@ -452,10 +465,13 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     uint8_t i;
     uint64_t ram_size;
     int num_apus = MIN(ms->smp.cpus, XLNX_ZYNQMP_NUM_APU_CPUS);
+    int num_rpus = MIN((int)(ms->smp.cpus - XLNX_ZYNQMP_NUM_APU_CPUS),
+                       XLNX_ZYNQMP_NUM_RPU_CPUS);
     const char *boot_cpu = s->boot_cpu ? s->boot_cpu : "apu-cpu[0]";
     ram_addr_t ddr_low_size, ddr_high_size;
-    qemu_irq gic_spi[GIC_NUM_SPI_INTR];
+    qemu_irq gic_spi[XLXN_ZYNQMP_GIC_NUM_SPI_INTR];
     Error *err = NULL;
+    DeviceState *splitter;
 
     ram_size = memory_region_size(s->ddr_ram);
 
@@ -502,13 +518,21 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
         g_free(ocm_name);
     }
 
-    qdev_prop_set_uint32(DEVICE(&s->gic), "num-irq", GIC_NUM_SPI_INTR + 32);
+    qdev_prop_set_uint32(DEVICE(&s->gic), "num-irq", XLXN_ZYNQMP_GIC_NUM_SPI_INTR + 32);
     qdev_prop_set_uint32(DEVICE(&s->gic), "revision", 2);
     qdev_prop_set_uint32(DEVICE(&s->gic), "num-cpu", num_apus);
     qdev_prop_set_bit(DEVICE(&s->gic), "has-security-extensions", s->secure);
     qdev_prop_set_bit(DEVICE(&s->gic),
                       "has-virtualization-extensions", s->virt);
 
+    if (num_rpus > 0) {
+        qdev_prop_set_uint32(DEVICE(&s->rpu_gic), "num-irq",
+                             XLXN_ZYNQMP_GIC_NUM_SPI_INTR + 32);
+        qdev_prop_set_uint32(DEVICE(&s->rpu_gic), "revision", 1);
+        qdev_prop_set_uint32(DEVICE(&s->rpu_gic), "num-cpu", num_rpus);
+        qdev_prop_set_uint32(DEVICE(&s->rpu_gic), "first-cpu-index", 4);
+    }
+
     qdev_realize(DEVICE(&s->apu_cluster), NULL, &error_fatal);
 
     /* Realize APUs before realizing the GIC. KVM requires this.  */
@@ -608,13 +632,63 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (num_rpus > 0) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->rpu_gic), errp)) {
+            return;
+        }
+
+        for (i = 0; i < num_rpus; i++) {
+            qemu_irq irq;
+
+            sysbus_mmio_map(SYS_BUS_DEVICE(&s->rpu_gic), i + 1,
+                            GIC_BASE_ADDR + i * 0x1000);
+            sysbus_connect_irq(SYS_BUS_DEVICE(&s->rpu_gic), i,
+                               qdev_get_gpio_in(DEVICE(&s->rpu_cpu[i]),
+                                                ARM_CPU_IRQ));
+            sysbus_connect_irq(SYS_BUS_DEVICE(&s->rpu_gic), i + num_rpus,
+                               qdev_get_gpio_in(DEVICE(&s->rpu_cpu[i]),
+                                                ARM_CPU_FIQ));
+            sysbus_connect_irq(SYS_BUS_DEVICE(&s->rpu_gic), i + num_rpus * 2,
+                               qdev_get_gpio_in(DEVICE(&s->rpu_cpu[i]),
+                                                ARM_CPU_VIRQ));
+            sysbus_connect_irq(SYS_BUS_DEVICE(&s->rpu_gic), i + num_rpus * 3,
+                               qdev_get_gpio_in(DEVICE(&s->rpu_cpu[i]),
+                                                ARM_CPU_VFIQ));
+            irq = qdev_get_gpio_in(DEVICE(&s->rpu_gic),
+                                   arm_gic_ppi_index(i, ARM_PHYS_TIMER_PPI));
+            qdev_connect_gpio_out(DEVICE(&s->rpu_cpu[i]), GTIMER_PHYS, irq);
+            irq = qdev_get_gpio_in(DEVICE(&s->rpu_gic),
+                                   arm_gic_ppi_index(i, ARM_VIRT_TIMER_PPI));
+            qdev_connect_gpio_out(DEVICE(&s->rpu_cpu[i]), GTIMER_VIRT, irq);
+            irq = qdev_get_gpio_in(DEVICE(&s->rpu_gic),
+                                   arm_gic_ppi_index(i, ARM_HYP_TIMER_PPI));
+            qdev_connect_gpio_out(DEVICE(&s->rpu_cpu[i]), GTIMER_HYP, irq);
+            irq = qdev_get_gpio_in(DEVICE(&s->rpu_gic),
+                                   arm_gic_ppi_index(i, ARM_SEC_TIMER_PPI));
+            qdev_connect_gpio_out(DEVICE(&s->rpu_cpu[i]), GTIMER_SEC, irq);
+        }
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->rpu_gic), 0, GIC_BASE_ADDR);
+    }
+
     if (!s->boot_cpu_ptr) {
         error_setg(errp, "ZynqMP Boot cpu %s not found", boot_cpu);
         return;
     }
 
-    for (i = 0; i < GIC_NUM_SPI_INTR; i++) {
-        gic_spi[i] = qdev_get_gpio_in(DEVICE(&s->gic), i);
+    for (i = 0; i < XLXN_ZYNQMP_GIC_NUM_SPI_INTR; i++) {
+        splitter = DEVICE(&s->splitter[i]);
+        qdev_prop_set_uint16(splitter, "num-lines", 2);
+        qdev_realize(splitter, NULL, &error_abort);
+        if (num_rpus > 0) {
+            gic_spi[i] = qdev_get_gpio_in(splitter, 0);
+            qdev_connect_gpio_out(splitter, 0,
+                                  qdev_get_gpio_in(DEVICE(&s->gic), i));
+            qdev_connect_gpio_out(splitter, 1,
+                                  qdev_get_gpio_in(DEVICE(&s->rpu_gic), i));
+        } else {
+            gic_spi[i] = qdev_get_gpio_in(DEVICE(&s->gic), i);
+        }
     }
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_GEMS; i++) {
diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
index c137ac59e8..a69953650d 100644
--- a/include/hw/arm/xlnx-zynqmp.h
+++ b/include/hw/arm/xlnx-zynqmp.h
@@ -42,6 +42,7 @@
 #include "hw/misc/xlnx-zynqmp-crf.h"
 #include "hw/timer/cadence_ttc.h"
 #include "hw/usb/hcd-dwc3.h"
+#include "hw/core/split-irq.h"
 
 #define TYPE_XLNX_ZYNQMP "xlnx-zynqmp"
 OBJECT_DECLARE_SIMPLE_TYPE(XlnxZynqMPState, XLNX_ZYNQMP)
@@ -87,12 +88,14 @@ OBJECT_DECLARE_SIMPLE_TYPE(XlnxZynqMPState, XLNX_ZYNQMP)
                                   XLNX_ZYNQMP_MAX_HIGH_RAM_SIZE)
 
 #define XLNX_ZYNQMP_NUM_TTC 4
+#define XLXN_ZYNQMP_GIC_NUM_SPI_INTR 160
 
 /*
  * Unimplemented mmio regions needed to boot some images.
  */
 #define XLNX_ZYNQMP_NUM_UNIMP_AREAS 1
 
+
 struct XlnxZynqMPState {
     /*< private >*/
     DeviceState parent_obj;
@@ -105,6 +108,9 @@ struct XlnxZynqMPState {
     GICState gic;
     MemoryRegion gic_mr[XLNX_ZYNQMP_GIC_REGIONS][XLNX_ZYNQMP_GIC_ALIASES];
 
+    GICState rpu_gic;
+    SplitIRQ splitter[XLXN_ZYNQMP_GIC_NUM_SPI_INTR];
+
     MemoryRegion ocm_ram[XLNX_ZYNQMP_NUM_OCM_BANKS];
 
     MemoryRegion *ddr_ram;
-- 
2.34.1


