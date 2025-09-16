Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C0C1CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 18:12:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uya5i-0004Ub-Td; Tue, 16 Sep 2025 14:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4z-0003DJ-Al
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:07:03 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4v-0001dt-Tl
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:07:00 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3e9ca387425so2284407f8f.0
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 11:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758046006; x=1758650806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WKrPXfhV0yZcHSRkAd9uqCS4QKSHcYCg0rne8WnkpnI=;
 b=ER8lvKoSqFqzfCfLj1NDCd6bmPyc/Q08usr2BgC1z3TuRPWwZ+wjJgHOKxxYmfTAc6
 nfLbQsrVR1fCB0rfRLfQIjGEUdvEPmXxW8wQqNPVu6pB3pFbeMvi74Gciyj8bqFOjQET
 uZouIxUC0oEZ9vqW8p0pxhTrUQMH27LmSOcOx9aqQj3CzujWDYwPezFSe0JoBKAYbWta
 DC8PRhFNDGElxNOcrKhGwnNTHQuWIXlFszJ15B33/vq+Kt/dKb156opDnPtoaZPG2rU5
 Cu51uTHyWrMoNYPX9n67tekQq2PHu1EGvLkKAOxjjgWtXzxoaXTtsNRwtY40sA/M9U2M
 Ah/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758046006; x=1758650806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WKrPXfhV0yZcHSRkAd9uqCS4QKSHcYCg0rne8WnkpnI=;
 b=q6U3nZCcC+tCArTNmX0GnCyORQ1e5ZgYughiFqeLoGwzz+rYWa1x9+J2KbV5SvJcvq
 oC32DokkI6JHBu//R1q+P5ZjqsSOpUtxmEUCr0/qjk0bFXTIO+rNbXNmYu18VldPADMi
 yemJS0tsCviTVAq1CwlcOrULzDj26JUeazUeZ9UvBWBQRYtNO83f9QOLCRXX5CIRZ+uP
 OTvUNJK/Jkk84Jg21TJkL09nZjTDBAXWFztNf1h2mG5MtVEIJFUKI8vcBHX4D4Y/u0RY
 ZDb2uRZSdFe5MJY3pV7JP8QwONwXYtOMBgq47TU5JclAF2cnwdjBIuiwgfSXP8REIbfX
 cTiQ==
X-Gm-Message-State: AOJu0YwOha+PcQu9U6sIM4+DdIKW9j4Qx094Gnem/GvUTp6/rbyGqkfl
 8kXUB4rNzQN9XLGIC8GKNtE+IXIQYrBHuVMzzeRCVcbzGDBtkadPBHCMH7H90xzahjfKecrGtAS
 d5YOQ
X-Gm-Gg: ASbGncuBdHQPGvJXApiDCuO9mDqOrVqW+5aO9T575nKO0FvX9ssr9HzBO/1+SGVz599
 IzEP7/bKYmRhWAckAmbqwMyh3q4XDlBPzizky3j5Dc5W9QMeSoyLE1RB+B21s6ADDQGdUmUUE8Z
 esTTKluYb6oq/hWieHsWP87YOegydOjraaYJOQ+moQPGMTY4U33RH4kWnBuOk8LlVt1X05ppMmx
 wuha4mGImdQmAzRXXHoHQV5Urz8FwE1BBvBJcUQ1219wHbeY+1/EpT6p8fMOOs8ivQnZLC/AgdS
 8Uuufr+BEs16jugEplZIj8xQ3eskWMa8a7O/T2VdA1hRjmkHLV2M5WvxhnZqGbivh7jUr45r4Qs
 POrNOTEBXqFEpWePRbzxiRucLWXfG
X-Google-Smtp-Source: AGHT+IGG/xL9OT5ukmdFF6iyS38WHQqljS5zhtvsweQV6Si2QyaUwWa1ZhbRurwpdy4mMpFX8+JCmQ==
X-Received: by 2002:a05:6000:40de:b0:3e9:978e:48fd with SMTP id
 ffacd0b85a97d-3e9978e8e25mr10239585f8f.23.1758046005711; 
 Tue, 16 Sep 2025 11:06:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760775880sm23033286f8f.2.2025.09.16.11.06.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:06:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/36] hw/arm/virt: Factor out common SMMUV3 dt bindings code
Date: Tue, 16 Sep 2025 19:06:02 +0100
Message-ID: <20250916180611.1481266-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916180611.1481266-1-peter.maydell@linaro.org>
References: <20250916180611.1481266-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

From: Shameer Kolothum <skolothumtho@nvidia.com>

No functional changes intended. This will be useful when we
add support for user-creatable smmuv3 device.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nathan Chen <nathanc@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Donald Dutile <ddutile@redhat.com>
Message-id: 20250829082543.7680-5-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 54 +++++++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 16a1ac3c2d9..bebe2d8cea9 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1444,19 +1444,43 @@ static void create_pcie_irq_map(const MachineState *ms,
                            0x7           /* PCI irq */);
 }
 
+static void create_smmuv3_dt_bindings(const VirtMachineState *vms, hwaddr base,
+                                      hwaddr size, int irq)
+{
+    char *node;
+    const char compat[] = "arm,smmu-v3";
+    const char irq_names[] = "eventq\0priq\0cmdq-sync\0gerror";
+    MachineState *ms = MACHINE(vms);
+
+    node = g_strdup_printf("/smmuv3@%" PRIx64, base);
+    qemu_fdt_add_subnode(ms->fdt, node);
+    qemu_fdt_setprop(ms->fdt, node, "compatible", compat, sizeof(compat));
+    qemu_fdt_setprop_sized_cells(ms->fdt, node, "reg", 2, base, 2, size);
+
+    qemu_fdt_setprop_cells(ms->fdt, node, "interrupts",
+            GIC_FDT_IRQ_TYPE_SPI, irq    , GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
+            GIC_FDT_IRQ_TYPE_SPI, irq + 1, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
+            GIC_FDT_IRQ_TYPE_SPI, irq + 2, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
+            GIC_FDT_IRQ_TYPE_SPI, irq + 3, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI);
+
+    qemu_fdt_setprop(ms->fdt, node, "interrupt-names", irq_names,
+                     sizeof(irq_names));
+
+    qemu_fdt_setprop(ms->fdt, node, "dma-coherent", NULL, 0);
+    qemu_fdt_setprop_cell(ms->fdt, node, "#iommu-cells", 1);
+    qemu_fdt_setprop_cell(ms->fdt, node, "phandle", vms->iommu_phandle);
+    g_free(node);
+}
+
 static void create_smmu(const VirtMachineState *vms,
                         PCIBus *bus)
 {
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
-    char *node;
-    const char compat[] = "arm,smmu-v3";
     int irq =  vms->irqmap[VIRT_SMMU];
     int i;
     hwaddr base = vms->memmap[VIRT_SMMU].base;
     hwaddr size = vms->memmap[VIRT_SMMU].size;
-    const char irq_names[] = "eventq\0priq\0cmdq-sync\0gerror";
     DeviceState *dev;
-    MachineState *ms = MACHINE(vms);
 
     if (vms->iommu != VIRT_IOMMU_SMMUV3 || !vms->iommu_phandle) {
         return;
@@ -1475,27 +1499,7 @@ static void create_smmu(const VirtMachineState *vms,
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
                            qdev_get_gpio_in(vms->gic, irq + i));
     }
-
-    node = g_strdup_printf("/smmuv3@%" PRIx64, base);
-    qemu_fdt_add_subnode(ms->fdt, node);
-    qemu_fdt_setprop(ms->fdt, node, "compatible", compat, sizeof(compat));
-    qemu_fdt_setprop_sized_cells(ms->fdt, node, "reg", 2, base, 2, size);
-
-    qemu_fdt_setprop_cells(ms->fdt, node, "interrupts",
-            GIC_FDT_IRQ_TYPE_SPI, irq    , GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
-            GIC_FDT_IRQ_TYPE_SPI, irq + 1, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
-            GIC_FDT_IRQ_TYPE_SPI, irq + 2, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
-            GIC_FDT_IRQ_TYPE_SPI, irq + 3, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI);
-
-    qemu_fdt_setprop(ms->fdt, node, "interrupt-names", irq_names,
-                     sizeof(irq_names));
-
-    qemu_fdt_setprop(ms->fdt, node, "dma-coherent", NULL, 0);
-
-    qemu_fdt_setprop_cell(ms->fdt, node, "#iommu-cells", 1);
-
-    qemu_fdt_setprop_cell(ms->fdt, node, "phandle", vms->iommu_phandle);
-    g_free(node);
+    create_smmuv3_dt_bindings(vms, base, size, irq);
 }
 
 static void create_virtio_iommu_dt_bindings(VirtMachineState *vms)
-- 
2.43.0


