Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4145EC1112
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZMf-000553-Af; Mon, 23 Feb 2026 12:04:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZLH-0002wt-3z
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:03:32 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZL9-0000SL-Ta
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:03:29 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-483487335c2so42254275e9.2
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866199; x=1772470999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CoqKRxhjDS2lI+Y53YNGJHUzkXH7stjgCG6VH65poHk=;
 b=F7ORHXOGcVAMn2mLE+XsWIulVLu8F+QSWyH42y39NYs8/qmEVI0BakE0iAb0r2EwQ4
 7Y3xc2AkSpAqMhMNTaZ4ncl8UgB7pP+hlX+eavOJfr9x3ERiYak3TccNGzZD7oja2NP9
 ld8fqQAkEOvAZF3SRKWwf3Dd8J9yz/PKrwuglm5ATfIr/WT6rznOboJi0GYhQUVWOOJ3
 RyE+XPOwB1Jjqt6NSrbajK8BO4dCKtxk1SZRe+XVgbHpNtWWmZ6aZJS4nhBb/UjfDSuR
 MBGMlF6jZhYGCogZpeHAMgvjkF8uKWzwaMHIR40zsMVkSb9I+3NzLC7t4TBDwZUvZUK0
 y4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866199; x=1772470999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CoqKRxhjDS2lI+Y53YNGJHUzkXH7stjgCG6VH65poHk=;
 b=vX2Mu+umvqwfZQVtfXVK6bkNRcqHo/QZIUGaR9NsMWAdvQfzKn9oGq3YFKTNsX/qlt
 V611p9MwXNsUo//w7l/uqq/vaF6FYDLy34OogFBGLEWKqZRLXCq0UImsekiUOhf3BHqA
 UxBZAayynTEHMadXgNBMtX5ti3YmdhvC/GMmDsdNebyMjA9JyhfXaZXg1Db30eBGu2AT
 Z0RV7ZuE/33yw3ci77oj7zV52kE4ORlfoyoYB9wliJMCOBUoOuxuLa1JkdHedTIixcyv
 0znM8rgXnsMzohOC0RlNoJ5Gk6Wk2n+qBE61WcTNTpICZqZxAyvXfcZwnQ2kvqnhh6UC
 BrMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsx+5l2EO6mSeZI16OULGE/Cx1lOuugS3OR2sIubnxRQOggjcPQIu0vP7wpNr7+unUoQ/DI2GeLFDY@nongnu.org
X-Gm-Message-State: AOJu0YyFoAqWx7PgD00yHPcMMO93Rt+BNnLhAsqEfh8HaYukOXSVkq5H
 A/3X1lEjTwr6H7JZ0CTNxK4XNnw5sIcKKNn6MytswTRYUQJAnvkzGjP/Hce5IUTio8wZRA4I2Jc
 ex2pa
X-Gm-Gg: AZuq6aLV/H9j6zi62/sBq/TlWMvu3mTY1PvjBRmJvI7N44idge8WwnuH0mvDh1bCic0
 xmoy8lSroZLJPeO400ch9BtPn7v6qcaqga1XblWx8obbe6/L07UMCymQzGtZ2CLnhhAk+bW62LJ
 9+OQrmEhcurk3en9d5pYjVfusA+J+8O7Mdl2o3cX4k7SfjL7JCBup4J8s4DVHF7t71KkrIe/HuU
 PmtG4cB0U5f+RUgOv2DusEy+Uhj9CvMtb4gw3/qSNBYr+8ggQqgrsW5o0f411jkOMPDsvuKU7gy
 Co32VKj4pZoIsmyAGsuRIAnwunAFoVGXgObSO2uzcitmo1WiDULSqSLfmp/s3spqVYfGT9FfDVD
 LtT0cNYCpxseuq/ZnbfKShvfRDJbwS4OYcQmivg5axIp2DBjz9BdSG7SS+0hFk8aKEkN4d5CzcB
 jE1jpEGtccpV//QHKXrAom++X5CEEM9dv6AfXlYl6/UaHxKfvnXxJDb50jQY3iW/oEf91lHjlrc
 hCE2hs15p8Kiz63gZUvxDQy5lPbM8M=
X-Received: by 2002:a05:600c:3b0a:b0:480:4ae2:def1 with SMTP id
 5b1f17b1804b1-483a95be7c9mr180051565e9.13.1771866199191; 
 Mon, 23 Feb 2026 09:03:19 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.03.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:03:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 59/65] hw/arm/virt: Split GICv2 and GICv3/4 creation
Date: Mon, 23 Feb 2026 17:02:06 +0000
Message-ID: <20260223170212.441276-60-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Currently create_gic() handles GICv2 and GICv3/4 in a single
function, with large sections that are conditional on the
vms->gic_version.  GICv5 will be different to both.

Refactor into create_gicv2() and create_gicv3().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 137 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 82 insertions(+), 55 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ec6e49099a..3d19eb0fee 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -863,26 +863,58 @@ static void gic_connect_ppis(VirtMachineState *vms)
     }
 }
 
-static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
+static void create_gicv2(VirtMachineState *vms, MemoryRegion *mem)
+{
+    MachineState *ms = MACHINE(vms);
+    /* We create a standalone GIC */
+    SysBusDevice *gicbusdev;
+    unsigned int smp_cpus = ms->smp.cpus;
+
+    if (kvm_enabled() && vms->virt) {
+        error_report("KVM EL2 is only supported with in-kernel GICv3");
+        exit(1);
+    }
+
+    vms->gic = qdev_new(gic_class_name());
+    qdev_prop_set_uint32(vms->gic, "revision", 2);
+    qdev_prop_set_uint32(vms->gic, "num-cpu", smp_cpus);
+    /*
+     * Note that the num-irq property counts both internal and external
+     * interrupts; there are always 32 of the former (mandated by GIC spec).
+     */
+    qdev_prop_set_uint32(vms->gic, "num-irq", NUM_IRQS + 32);
+    if (!kvm_irqchip_in_kernel()) {
+        qdev_prop_set_bit(vms->gic, "has-security-extensions", vms->secure);
+        qdev_prop_set_bit(vms->gic, "has-virtualization-extensions", vms->virt);
+    }
+
+    gicbusdev = SYS_BUS_DEVICE(vms->gic);
+    sysbus_realize_and_unref(gicbusdev, &error_fatal);
+    sysbus_mmio_map(gicbusdev, 0, vms->memmap[VIRT_GIC_DIST].base);
+    sysbus_mmio_map(gicbusdev, 1, vms->memmap[VIRT_GIC_CPU].base);
+    if (vms->virt) {
+        sysbus_mmio_map(gicbusdev, 2, vms->memmap[VIRT_GIC_HYP].base);
+        sysbus_mmio_map(gicbusdev, 3, vms->memmap[VIRT_GIC_VCPU].base);
+    }
+
+    gic_connect_ppis(vms);
+
+    fdt_add_gic_node(vms);
+}
+
+static void create_gicv3(VirtMachineState *vms, MemoryRegion *mem)
 {
     MachineState *ms = MACHINE(vms);
     /* We create a standalone GIC */
     SysBusDevice *gicbusdev;
-    const char *gictype;
     unsigned int smp_cpus = ms->smp.cpus;
     uint32_t nb_redist_regions = 0;
     int revision;
-
-    if (vms->gic_version == VIRT_GIC_VERSION_2) {
-        gictype = gic_class_name();
-    } else {
-        gictype = gicv3_class_name();
-    }
+    QList *redist_region_count;
+    uint32_t redist0_capacity = virt_redist_capacity(vms, VIRT_GIC_REDIST);
+    uint32_t redist0_count = MIN(smp_cpus, redist0_capacity);
 
     switch (vms->gic_version) {
-    case VIRT_GIC_VERSION_2:
-        revision = 2;
-        break;
     case VIRT_GIC_VERSION_3:
         revision = 3;
         break;
@@ -899,10 +931,11 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
         exit(1);
     }
 
-    vms->gic = qdev_new(gictype);
+    vms->gic = qdev_new(gicv3_class_name());
     qdev_prop_set_uint32(vms->gic, "revision", revision);
     qdev_prop_set_uint32(vms->gic, "num-cpu", smp_cpus);
-    /* Note that the num-irq property counts both internal and external
+    /*
+     * Note that the num-irq property counts both internal and external
      * interrupts; there are always 32 of the former (mandated by GIC spec).
      */
     qdev_prop_set_uint32(vms->gic, "num-irq", NUM_IRQS + 32);
@@ -910,40 +943,28 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
         qdev_prop_set_bit(vms->gic, "has-security-extensions", vms->secure);
     }
 
-    if (vms->gic_version != VIRT_GIC_VERSION_2) {
-        QList *redist_region_count;
-        uint32_t redist0_capacity = virt_redist_capacity(vms, VIRT_GIC_REDIST);
-        uint32_t redist0_count = MIN(smp_cpus, redist0_capacity);
+    nb_redist_regions = virt_gicv3_redist_region_count(vms);
 
-        nb_redist_regions = virt_gicv3_redist_region_count(vms);
+    redist_region_count = qlist_new();
+    qlist_append_int(redist_region_count, redist0_count);
+    if (nb_redist_regions == 2) {
+        uint32_t redist1_capacity =
+            virt_redist_capacity(vms, VIRT_HIGH_GIC_REDIST2);
 
-        redist_region_count = qlist_new();
-        qlist_append_int(redist_region_count, redist0_count);
-        if (nb_redist_regions == 2) {
-            uint32_t redist1_capacity =
-                virt_redist_capacity(vms, VIRT_HIGH_GIC_REDIST2);
+        qlist_append_int(redist_region_count,
+                         MIN(smp_cpus - redist0_count, redist1_capacity));
+    }
+    qdev_prop_set_array(vms->gic, "redist-region-count", redist_region_count);
 
-            qlist_append_int(redist_region_count,
-                MIN(smp_cpus - redist0_count, redist1_capacity));
-        }
-        qdev_prop_set_array(vms->gic, "redist-region-count",
-                            redist_region_count);
-
-        if (!kvm_irqchip_in_kernel()) {
-            if (vms->tcg_its) {
-                object_property_set_link(OBJECT(vms->gic), "sysmem",
-                                         OBJECT(mem), &error_fatal);
-                qdev_prop_set_bit(vms->gic, "has-lpi", true);
-            }
-        } else if (vms->virt) {
-            qdev_prop_set_uint32(vms->gic, "maintenance-interrupt-id",
-                                 ARCH_GIC_MAINT_IRQ);
-        }
-    } else {
-        if (!kvm_irqchip_in_kernel()) {
-            qdev_prop_set_bit(vms->gic, "has-virtualization-extensions",
-                              vms->virt);
+    if (!kvm_irqchip_in_kernel()) {
+        if (vms->tcg_its) {
+            object_property_set_link(OBJECT(vms->gic), "sysmem", OBJECT(mem),
+                                     &error_fatal);
+            qdev_prop_set_bit(vms->gic, "has-lpi", true);
         }
+    } else if (vms->virt) {
+        qdev_prop_set_uint32(vms->gic, "maintenance-interrupt-id",
+                             ARCH_GIC_MAINT_IRQ);
     }
 
     if (gicv3_nmi_present(vms)) {
@@ -953,18 +974,9 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
     gicbusdev = SYS_BUS_DEVICE(vms->gic);
     sysbus_realize_and_unref(gicbusdev, &error_fatal);
     sysbus_mmio_map(gicbusdev, 0, vms->memmap[VIRT_GIC_DIST].base);
-    if (vms->gic_version != VIRT_GIC_VERSION_2) {
-        sysbus_mmio_map(gicbusdev, 1, vms->memmap[VIRT_GIC_REDIST].base);
-        if (nb_redist_regions == 2) {
-            sysbus_mmio_map(gicbusdev, 2,
-                            vms->memmap[VIRT_HIGH_GIC_REDIST2].base);
-        }
-    } else {
-        sysbus_mmio_map(gicbusdev, 1, vms->memmap[VIRT_GIC_CPU].base);
-        if (vms->virt) {
-            sysbus_mmio_map(gicbusdev, 2, vms->memmap[VIRT_GIC_HYP].base);
-            sysbus_mmio_map(gicbusdev, 3, vms->memmap[VIRT_GIC_VCPU].base);
-        }
+    sysbus_mmio_map(gicbusdev, 1, vms->memmap[VIRT_GIC_REDIST].base);
+    if (nb_redist_regions == 2) {
+        sysbus_mmio_map(gicbusdev, 2, vms->memmap[VIRT_HIGH_GIC_REDIST2].base);
     }
 
     gic_connect_ppis(vms);
@@ -972,6 +984,21 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
     fdt_add_gic_node(vms);
 }
 
+static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
+{
+    switch (vms->gic_version) {
+    case VIRT_GIC_VERSION_2:
+        create_gicv2(vms, mem);
+        break;
+    case VIRT_GIC_VERSION_3:
+    case VIRT_GIC_VERSION_4:
+        create_gicv3(vms, mem);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static void create_msi_controller(VirtMachineState *vms)
 {
     switch (vms->msi_controller) {
-- 
2.43.0


