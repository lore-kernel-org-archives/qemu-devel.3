Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E32CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68Qz-00065W-7r; Tue, 07 Oct 2025 10:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Qi-0005s3-JW
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:43 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68QU-0002Ml-1w
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:40 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46e2e6a708fso41817055e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846342; x=1760451142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VSPvfoJk8tL01udiQoFnoSbF4UodUrjktsNUrDzx8iI=;
 b=ZRWY+I+RtGb40/BWRKj2RpqjiFlsWXMAhocCxTFnT7VnOqa3ECQGgrd37Zyml3VGQ5
 WopSPOG3wzAxUMQqUMDFbQbj3cTz2u8FsqG0FXJywBorqkqZerHVMtro2zB0/BRSTdhP
 pm6UnLKmnpbaWunYlYtUoAlAAF/rHFpb30zW6RU1vvD1QUaWgqbcTlWcj97lWMlR5P1A
 nEtRgDfTk/Ql6gFwlKQB/dGUYIdOS3KOjl2f8MTYlhLTb9wlZUom2Qn0qU0QuSjO4O2e
 1sW66UWtFXlzF7/6Psx3gkwhWah4zCiBm9s/dk7mlj9ix92HT7HIKLs0Pt85blqRVwFv
 vVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846342; x=1760451142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VSPvfoJk8tL01udiQoFnoSbF4UodUrjktsNUrDzx8iI=;
 b=Chf35SlhzUefXaJCErKyK9Vf7QpQFLh89ry3VhlVAVIvzGIUWDE/Bb5ld12LfpduiY
 VMBZ8OKhPdkkRGItzVAkGu0ahBTUDbzGVTESTxhISKs9tbxddZNqKDHs4oPkSFQJrbs0
 3RepQlI0jerxYE66uVcfNsjDPA54khxKGyPTEnshus4AkwcE12X3s5k9gNkHOQctE7vg
 0TxXCQYVAWh/l6Klu6aXCmavuWighc+koelVUA32tJ5Oq6IIK7uxgX5VGstixqtCS9ma
 IhjdqwUDKl/aMcbbShbjW4eYPL2VDzuGCsHu+Xj2RwxgSuN+GceU2Wu49omvE/NOM6lT
 a1TQ==
X-Gm-Message-State: AOJu0Yyx4W18Or5uvlfn08j+tzjptAd8sXG1RdJoXOPWqjZcMxXRPktE
 fLXiZw/QSncV8C+LYmAmmdBqgxXaeVydQfkKrMUZp94YnQhCggfLPWB1a6spD7AYF0DEAAC5pCH
 gehDj
X-Gm-Gg: ASbGncusiSJ0rGR64lB4IbIPbbmUgdtsrSXX6HKlRTc+VHurBXQrwjQpnWa3fGSMbHV
 Ry4VABMgq14s1Vyy1YfXN+EEAtRnTqChTo5oS4/HgCxCLZj89EltvbmaWZ6mZ7jPNJE3pshdeJM
 ZvVXoZaXqgxyJnMpKokcmnhnvF6WSk7QN3COtx0LBd5RXx0u6tT4Y6pVRW7W5BQ3jhfxFvI7C9b
 5MtVNv/C0F2pQ8MuBweAS75HWVB5CM2s9rcROqW3gBXWGQgljrDmMFI0mm3krrr9G0GeVNZwcjz
 WVdpY3m1+LsexYm9cVUKz+TBibbwC072f1ckdYIqNfThJZV7HQDX28ZS5p1LXmtX2sRHgvknesX
 YzapUxPfQ18gLTiuL89HCyDhqVp/nVcQ1c6o0PqGunNVOmr8VYS/OObAB
X-Google-Smtp-Source: AGHT+IEvB0RJXMGBT0J8DcX8yvDU+JJYWhGWX1bZOnSUxTowafzy6IFW45Ow45fp+XtxGAic5yMWNQ==
X-Received: by 2002:a05:600c:4ec6:b0:46e:1a14:a81b with SMTP id
 5b1f17b1804b1-46e7115b667mr116100945e9.36.1759846341668; 
 Tue, 07 Oct 2025 07:12:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.12.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:12:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 51/62] hw/arm/xlnx-zynqmp: wire a second GIC for the Cortex-R5
Date: Tue,  7 Oct 2025 15:11:11 +0100
Message-ID: <20251007141123.3239867-52-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Frederic Konrad <konrad.frederic@yahoo.fr>

This wires a second GIC for the Cortex-R5, all the IRQs are split when there
is an RPU instanciated.

Signed-off-by: Clément Chigot <chigot@adacore.com>
Acked-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-id: 20250930115718.437100-4-chigot@adacore.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/xlnx-zynqmp.h |  4 ++
 hw/arm/xlnx-zynqmp.c         | 77 +++++++++++++++++++++++++++++++++++-
 2 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
index 6a407c29624..a3117bd6c50 100644
--- a/include/hw/arm/xlnx-zynqmp.h
+++ b/include/hw/arm/xlnx-zynqmp.h
@@ -42,6 +42,7 @@
 #include "hw/misc/xlnx-zynqmp-crf.h"
 #include "hw/timer/cadence_ttc.h"
 #include "hw/usb/hcd-dwc3.h"
+#include "hw/core/split-irq.h"
 
 #define TYPE_XLNX_ZYNQMP "xlnx-zynqmp"
 OBJECT_DECLARE_SIMPLE_TYPE(XlnxZynqMPState, XLNX_ZYNQMP)
@@ -106,6 +107,9 @@ struct XlnxZynqMPState {
     GICState gic;
     MemoryRegion gic_mr[XLNX_ZYNQMP_GIC_REGIONS][XLNX_ZYNQMP_GIC_ALIASES];
 
+    GICState rpu_gic;
+    SplitIRQ splitter[XLNX_ZYNQMP_GIC_NUM_SPI_INTR];
+
     MemoryRegion ocm_ram[XLNX_ZYNQMP_NUM_OCM_BANKS];
 
     MemoryRegion *ddr_ram;
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 3d8c46986eb..ffed6e5126e 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -384,6 +384,7 @@ static void xlnx_zynqmp_init(Object *obj)
     XlnxZynqMPState *s = XLNX_ZYNQMP(obj);
     int i;
     int num_apus = MIN(ms->smp.cpus, XLNX_ZYNQMP_NUM_APU_CPUS);
+    int num_rpus = xlnx_zynqmp_get_rpu_number(ms);
 
     object_initialize_child(obj, "apu-cluster", &s->apu_cluster,
                             TYPE_CPU_CLUSTER);
@@ -397,6 +398,12 @@ static void xlnx_zynqmp_init(Object *obj)
 
     object_initialize_child(obj, "gic", &s->gic, gic_class_name());
 
+    if (num_rpus) {
+        /* Do not create the rpu_gic if we don't have rpus */
+        object_initialize_child(obj, "rpu_gic", &s->rpu_gic,
+                                gic_class_name());
+    }
+
     for (i = 0; i < XLNX_ZYNQMP_NUM_GEMS; i++) {
         object_initialize_child(obj, "gem[*]", &s->gem[i], TYPE_CADENCE_GEM);
         object_initialize_child(obj, "gem-irq-orgate[*]",
@@ -446,6 +453,15 @@ static void xlnx_zynqmp_init(Object *obj)
     object_initialize_child(obj, "qspi-irq-orgate",
                             &s->qspi_irq_orgate, TYPE_OR_IRQ);
 
+    if (num_rpus) {
+        for (i = 0; i < ARRAY_SIZE(s->splitter); i++) {
+            g_autofree char *name = g_strdup_printf("irq-splitter%d", i);
+            object_initialize_child(obj, name, &s->splitter[i], TYPE_SPLIT_IRQ);
+        }
+    }
+
+
+
     for (i = 0; i < XLNX_ZYNQMP_NUM_USB; i++) {
         object_initialize_child(obj, "usb[*]", &s->usb[i], TYPE_USB_DWC3);
     }
@@ -459,6 +475,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     uint8_t i;
     uint64_t ram_size;
     int num_apus = MIN(ms->smp.cpus, XLNX_ZYNQMP_NUM_APU_CPUS);
+    int num_rpus = xlnx_zynqmp_get_rpu_number(ms);
     const char *boot_cpu = s->boot_cpu ? s->boot_cpu : "apu-cpu[0]";
     ram_addr_t ddr_low_size, ddr_high_size;
     qemu_irq gic_spi[XLNX_ZYNQMP_GIC_NUM_SPI_INTR];
@@ -517,6 +534,14 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     qdev_prop_set_bit(DEVICE(&s->gic),
                       "has-virtualization-extensions", s->virt);
 
+    if (num_rpus) {
+        qdev_prop_set_uint32(DEVICE(&s->rpu_gic), "num-irq",
+                             XLNX_ZYNQMP_GIC_NUM_SPI_INTR + 32);
+        qdev_prop_set_uint32(DEVICE(&s->rpu_gic), "revision", 1);
+        qdev_prop_set_uint32(DEVICE(&s->rpu_gic), "num-cpu", num_rpus);
+        qdev_prop_set_uint32(DEVICE(&s->rpu_gic), "first-cpu-index", 4);
+    }
+
     qdev_realize(DEVICE(&s->apu_cluster), NULL, &error_fatal);
 
     /* Realize APUs before realizing the GIC. KVM requires this.  */
@@ -616,13 +641,63 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (num_rpus) {
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
 
     for (i = 0; i < XLNX_ZYNQMP_GIC_NUM_SPI_INTR; i++) {
-        gic_spi[i] = qdev_get_gpio_in(DEVICE(&s->gic), i);
+        if (num_rpus) {
+            DeviceState *splitter = DEVICE(&s->splitter[i]);
+            qdev_prop_set_uint16(splitter, "num-lines", 2);
+            qdev_realize(splitter, NULL, &error_abort);
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
-- 
2.43.0


