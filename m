Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF75C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riYA1-000713-Sx; Fri, 08 Mar 2024 06:13:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riY9y-0006qe-Gv
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:13:07 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riY9w-0001et-Ni
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:13:06 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6e62c65865cso1643259b3a.2
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 03:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709896382; x=1710501182; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1kSgZU2AdvqFnrasTSR2vgVn0JCXJwTKFHBsMEqoOao=;
 b=cem7GhVyLTh3Maq8/c+EsjBl2mTCpgoPa3Hme3BJ/hEFxgizSYm6apAdrr/FhHnqBO
 D8vx5K47hI11C6PWmHlwhne0N3ruA0lsXoXI5FrifSb7JzTOmm0ZXD0tyCdDt5DpVNWO
 mnn0cAarcBLIYDaAwadyQHc/T3cm4Q6XeHCn19e/uoMTalvXR3pgv/hqf8z2COfY7o9W
 aT38ZCHfUpKsV8gyaTIrAzILj8WqgVseF/ZI+IP5NvzozyJM8eGeAD1dGAUDF3ncgnr5
 awNqrllDx2F2Ls9VbfeSxBow2b+0U0CJaZo7iETYHPM8OJRd+D5XtPckD8v6ZB/psYBp
 ni9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709896382; x=1710501182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1kSgZU2AdvqFnrasTSR2vgVn0JCXJwTKFHBsMEqoOao=;
 b=SOuqyrqhhbYlHudgy/QtnnbW8t39eKY/R+TyDTMROauaQHX5lQ+wRSG6jEbNEIjsfH
 X7BFO4iRP0nO83yG21iyVKu91+4TKj6p2Nn5rSoIqbXOxDx3Ac/5JaO84O0Gnl3eb0Zh
 lL7Wc8pRputsBi11U2vBehuBpv1g8oDpXmPsrYH8VSwgJJbUqtM+rrLYKN2lnDVvC1JL
 ScEmIpwhRCc5z5iQceLCTUBufYz0KAjEsc3F32SzINKT2WC1UbGuspj9c/XvIHZCZrES
 aARIzyMmNBb2LIh7K3SCXFAZHgbZg0B8UA/c3AFPu1a33wgT2tGTVpILbxvYVbf/gvqe
 BQjg==
X-Gm-Message-State: AOJu0Yz+uyt0Ce12a391OzSRZuXuKTgt5rShOoI8diVNZAYoelBvbiLz
 jb934BUoYPJv/Lv5LuF1XcC3YjV6Et7TRJA8dxMwyK+JJrLvXN3lgDJnkh/HD/2KWw==
X-Google-Smtp-Source: AGHT+IGLi/8E6+o0FVX5E2a3BiYfH+N/tAb1p9L2n9Wuvni692tZhFIN8kNUGIeerIJFbJV3GMISQA==
X-Received: by 2002:a05:6a20:3d08:b0:1a1:67c7:3ba4 with SMTP id
 y8-20020a056a203d0800b001a167c73ba4mr7913195pzi.51.1709896382252; 
 Fri, 08 Mar 2024 03:13:02 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a170902ecc600b001dcfbbb1ca5sm12006468plh.35.2024.03.08.03.12.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 03:13:01 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 18/34] hw/riscv/virt.c: add virtio-iommu-pci hotplug support
Date: Fri,  8 Mar 2024 21:11:36 +1000
Message-ID: <20240308111152.2856137-19-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240308111152.2856137-1-alistair.francis@wdc.com>
References: <20240308111152.2856137-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

We want to add a RISC-V 'virt' libqos machine to increase our test
coverage. Some of the tests will try to plug a virtio-iommu-pci
device into the board and do some tests with it.

Enable virtio-iommu-pci in the 'virt' machine.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240217192607.32565-5-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index b540f4d3da..54ad809b44 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -53,6 +53,7 @@
 #include "hw/display/ramfb.h"
 #include "hw/acpi/aml-build.h"
 #include "qapi/qapi-visit-common.h"
+#include "hw/virtio/virtio-iommu.h"
 
 /* KVM AIA only supports APLIC MSI. APLIC Wired is always emulated by QEMU. */
 static bool virt_use_kvm_aia(RISCVVirtState *s)
@@ -971,6 +972,34 @@ static void create_fdt_fw_cfg(RISCVVirtState *s, const MemMapEntry *memmap)
     qemu_fdt_setprop(ms->fdt, nodename, "dma-coherent", NULL, 0);
 }
 
+static void create_fdt_virtio_iommu(RISCVVirtState *s, uint16_t bdf)
+{
+    const char compat[] = "virtio,pci-iommu\0pci1af4,1057";
+    void *fdt = MACHINE(s)->fdt;
+    uint32_t iommu_phandle;
+    g_autofree char *iommu_node = NULL;
+    g_autofree char *pci_node = NULL;
+
+    pci_node = g_strdup_printf("/soc/pci@%lx",
+                               (long) virt_memmap[VIRT_PCIE_ECAM].base);
+    iommu_node = g_strdup_printf("%s/virtio_iommu@%x,%x", pci_node,
+                                 PCI_SLOT(bdf), PCI_FUNC(bdf));
+    iommu_phandle = qemu_fdt_alloc_phandle(fdt);
+
+    qemu_fdt_add_subnode(fdt, iommu_node);
+
+    qemu_fdt_setprop(fdt, iommu_node, "compatible", compat, sizeof(compat));
+    qemu_fdt_setprop_sized_cells(fdt, iommu_node, "reg",
+                                 1, bdf << 8, 1, 0, 1, 0,
+                                 1, 0, 1, 0);
+    qemu_fdt_setprop_cell(fdt, iommu_node, "#iommu-cells", 1);
+    qemu_fdt_setprop_cell(fdt, iommu_node, "phandle", iommu_phandle);
+
+    qemu_fdt_setprop_cells(fdt, pci_node, "iommu-map",
+                           0, iommu_phandle, 0, bdf,
+                           bdf + 1, iommu_phandle, bdf + 1, 0xffff - bdf);
+}
+
 static void finalize_fdt(RISCVVirtState *s)
 {
     uint32_t phandle = 1, irq_mmio_phandle = 1, msi_pcie_phandle = 1;
@@ -1680,7 +1709,8 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
 {
     MachineClass *mc = MACHINE_GET_CLASS(machine);
 
-    if (device_is_dynamic_sysbus(mc, dev)) {
+    if (device_is_dynamic_sysbus(mc, dev) ||
+        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
         return HOTPLUG_HANDLER(machine);
     }
     return NULL;
@@ -1699,6 +1729,10 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
                                      SYS_BUS_DEVICE(dev));
         }
     }
+
+    if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
+        create_fdt_virtio_iommu(s, pci_get_bdf(PCI_DEVICE(dev)));
+    }
 }
 
 static void virt_machine_class_init(ObjectClass *oc, void *data)
-- 
2.44.0


