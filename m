Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F075CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL122-0005n5-Ud; Thu, 07 May 2026 11:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL121-0005iy-PM
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:57 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11z-00042q-Ld
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:57 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-44509921fbcso570810f8f.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169174; x=1778773974; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bDQ9CNZN1AP0UdFin3eH4ri58X8eMrz779lTm/Wdc10=;
 b=gWM5v7yh0WSnGkEXILR9VYJZi/BIGt6+e/fAcbHNHI3ES7D5QUUya3oWisep1qchU+
 Z20VCz2I/I9w54Wgu4ARG/ybvTzE/z2P4RGibm/unfjbeJ7l8wyT0tKIsl8rfSPT/IKL
 409vIrYwp1f6T4p3Qd7oViUiXhlLSoludYcqHUWN16cHy0e0JxCA4HoYuDn2qgIkuShx
 7BDmu8bvxOU1L/UygwGGitMaqqgFgSVSNFLULVbZeVNh/2rFkowrwvKeximoxrCO4Nn2
 xWLiUTri3xP5s2DKEUfRhOx29tSvSbpS5eq7Imt0ng8NGvf7hKIcDGspwODG/TLc7u4x
 Yogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169174; x=1778773974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bDQ9CNZN1AP0UdFin3eH4ri58X8eMrz779lTm/Wdc10=;
 b=cKIdJeSRQ4f01sQOrdlRsgD0U/Vd6Fx6zz44Q7zcWdHpH3KUSQJMq0yDBEwR4bzyqv
 uJ61hU98mNsfGGfNEo2lCrtDO957wecLcDpZKoLa09M4X3JuAepj/bea9e7de2FBazD/
 ZmILFsMvSfFtpvHofJ5P9OiNsbfvGB1RvBXadu4jTTjuZVjx5cKnQLX8cA9WVkRA5wS3
 r6ZSjT9hBHc3WxRrEgWHcSYy7qCddIXWsEENy/AEGMb9vCddQtTAGuVWyhu3ow3aGftB
 YKuG51VR/eAqfdI9nr3SV+jeAJxDut8224FHZO/e5tXRqWQpQw7A4gJxOlVQDjZWRb9V
 nrbg==
X-Gm-Message-State: AOJu0YxCRU9fdyZWVbRxihC3aGO7BkE3ahx0QdQRWNtWhLYwYrRJ2Q4b
 +kxq+kKgYYOQnQaYV61Sq3iieO6ooK/xfjylOsJh6hJYR7nw+E8ZOnPfSbU9+mneRpxD3kN0ZSP
 JGFSD
X-Gm-Gg: AeBDietmysrzsKcKAp3CUgFUYoL3qieWAXUq+vYvMrXOUPY4j2tuyjC7JZDzGSno4b9
 OUKX8xlfCPTtscOlvTeY1OiE0XNAoRtchmhgVNXS9agYcDYnAdAZWyqcBAESGzvyPrnldVWVH6t
 Ut2I4x+vn3Zn5PWuZukKrEGWS3UswxneFgXW8QXMjfrz9JlkH4Ab6wR5ZEoxdnD88xTUD3UJ66U
 QNtqcBDcWS2JFztdoj/gxs98eTwF1GEV/GYd1bF5KSi6FOIZy8SLRTeLN+26V+2s6nP/6o1qqSE
 Aov9t8QbU3PyuiCeTavZjV19D5mKW83LMmesP7hhwYf+dHIjwoCXM2UNF4uyKiske0Eenfx/sAW
 qb/4tfivysq5Ye2+zcpXfD//hcvjEixvGfU1ET4iWFq9S+P/QZWCofdgycGyvZNjkMVOcqB4F1R
 TMBBtvvKJuMoPOAONgq5sT0Tl07eocs6wsDAa5Q2XrIGOvwMlER3C/YTAM3epp+z2kJ0/D3xCeq
 VmWRnabDxiLu0ocVG6PNoWd3WvSPpFLvdBmSJ8Woori6I5V/nJ/
X-Received: by 2002:a05:600c:a08b:b0:489:1ba8:5bf0 with SMTP id
 5b1f17b1804b1-48e51f4119bmr138775365e9.21.1778169173265; 
 Thu, 07 May 2026 08:52:53 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 59/67] hw/arm/virt: Split GICv2 and GICv3/4 creation
Date: Thu,  7 May 2026 16:51:46 +0100
Message-ID: <20260507155154.1886557-60-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
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

Currently create_gic() handles GICv2 and GICv3/4 in a single
function, with large sections that are conditional on the
vms->gic_version.  GICv5 will be different to both.

Refactor into create_gicv2() and create_gicv3().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-id: 20260327111700.795099-60-peter.maydell@linaro.org
---
 hw/arm/virt.c | 139 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 83 insertions(+), 56 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 57f56a86c9..2475d583cc 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1187,26 +1187,58 @@ static void gic_connect_ppis(VirtMachineState *vms)
     }
 }
 
-static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
+static void create_gicv2(VirtMachineState *vms, MemoryRegion *mem)
 {
     MachineState *ms = MACHINE(vms);
     /* We create a standalone GIC */
     SysBusDevice *gicbusdev;
-    const char *gictype;
     unsigned int smp_cpus = ms->smp.cpus;
-    uint32_t nb_redist_regions = 0;
-    int revision;
 
-    if (vms->gic_version == VIRT_GIC_VERSION_2) {
-        gictype = gic_class_name();
-    } else {
-        gictype = gicv3_class_name();
+    if (kvm_enabled() && vms->virt) {
+        error_report("KVM EL2 is only supported with in-kernel GICv3");
+        exit(1);
     }
 
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
+{
+    MachineState *ms = MACHINE(vms);
+    /* We create a standalone GIC */
+    SysBusDevice *gicbusdev;
+    unsigned int smp_cpus = ms->smp.cpus;
+    uint32_t nb_redist_regions;
+    int revision;
+    QList *redist_region_count;
+    uint32_t redist0_capacity = virt_redist_capacity(vms, VIRT_GIC_REDIST);
+    uint32_t redist0_count = MIN(smp_cpus, redist0_capacity);
+
     switch (vms->gic_version) {
-    case VIRT_GIC_VERSION_2:
-        revision = 2;
-        break;
     case VIRT_GIC_VERSION_3:
         revision = 3;
         break;
@@ -1223,10 +1255,11 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
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
@@ -1234,41 +1267,29 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
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
-        if (!kvm_irqchip_in_kernel() &&
-         !(hvf_enabled() && hvf_irqchip_in_kernel())) {
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
-        if (!kvm_irqchip_in_kernel() && !hvf_irqchip_in_kernel()) {
-            qdev_prop_set_bit(vms->gic, "has-virtualization-extensions",
-                              vms->virt);
+    if (!kvm_irqchip_in_kernel() &&
+        !(hvf_enabled() && hvf_irqchip_in_kernel())) {
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
@@ -1278,18 +1299,9 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
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
@@ -1297,6 +1309,21 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
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


