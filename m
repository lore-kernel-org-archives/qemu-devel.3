Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94EFBC3ABAB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 12:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9kXc-0002QL-LV; Tue, 29 Apr 2025 08:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9kXb-0002Py-Ac
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:58:27 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9kXZ-00008Q-DM
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:58:27 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-af908bb32fdso5164591a12.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 05:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745931503; x=1746536303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5pT0LWSeK0R/lWuJyn5X/nLpAQ6h50ss9kPSbzEuGZs=;
 b=WZUaDYo/FDDRF7dZGDvEOsIQkYs8bjWx83V8532QBqI55CtmGcjZKa7RhTJBYLU3sb
 2qdS2kgZ8kNUV51UiothUuyZmXX7tnSid65ERrV1AJVx9d5rvHoPXCzazEZSeMt9k/TO
 RYvCDgffftOfAY5JPDhXwjsjCmghgpa9EcggmpAak4Kv5ARHS7U7z0SI+IretrOKNaTG
 8EsPbz+eMl2nUykvKs1r8G3qK9Z3rEj/jsCIksuFpbd8Y/2/lFyxPbY74EeO/Fgpf+fE
 SAqGRCMwKZIb73AYQiaO9dU4cib7BrY15kb5tKg5HmIJPaBGtSQewDdkptD7IgeTGFMG
 LybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745931503; x=1746536303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5pT0LWSeK0R/lWuJyn5X/nLpAQ6h50ss9kPSbzEuGZs=;
 b=fZD6TmLxivqSHzkdVdY1EnQQnPcQD7QwOze1rw16Ij4xBIo2mfnJKGCdLK09ELAm1A
 trAOTdIGfbR7+xF+MlNrlWbsAMzniomlu0BiVo88u35v6eBK8eSrWvPkUtVb0KFhMdod
 hv3FqZeEx3JWmfSS2/KRI+AiMH3nx5JlvDq7Kd1JA0o8I5bpAit2GybZYbmZ26APLeQR
 FkrwkjyaVeIgZC4Db+OOgCadecb2KeD+TcjIpVjco3jlK9aYv716IIMxm5mdaKvkHI19
 hf2Zr1zoBFQ10WAoBsokN1UP1YXV1ctbXyPvh/jdQ9l8KrAo/hIThp8y0ELZpEV9m+bn
 E2ag==
X-Gm-Message-State: AOJu0Yw1Dj8iu278VFI0ipk5jZhVDeH5UwB0ZPg2t2dHHaYcoTc0KY+W
 vStaXb6T0ZoQx+hvUsF6wrfcn3Th7lkH1n4Ly8wDXrdPF28qH/ijkuy4YHJZHNZVnY9RGImQ+BH
 H
X-Gm-Gg: ASbGncumrIrDwGRPolkHfCXZ/H0rwmZ7UKBvJZwlBj/+IuglosePgsM3KDpmGkVR5MA
 C5myBZOrGSONiMoyhR29h0IJ2A89Xe8RpgxW5XXpskjeINlQAuTqXCEF5Eo4UySJzRpDS2brfDm
 5KQYzbcJnDH+dI3nLMpNmxHZc5+lGi4Ue/npKuvLp2H90fVuOZsLjXT1+jbLDuMGrR7+tZ5q4UA
 mzQw17TI5Gs/mZN495Wpw+b7Raagshq2qxZIQKsKFrOtq5WyhQSjDg5i/T4OE0sZXqZcCXbFu0o
 n52QHCS6ncn6BFn1Rnh27LXOOAvEryZbdwD8HyZtzrk=
X-Google-Smtp-Source: AGHT+IG1jdjYA7tqsfh7cpG01C/RfYjYoI3BYBy9TeU3PYBNiwha8DeVLfKlsavhnbuRYl8xFsQ32A==
X-Received: by 2002:a05:6a20:2d2b:b0:204:661d:12d2 with SMTP id
 adf61e73a8af0-2094fd54248mr3898401637.12.1745931503517; 
 Tue, 29 Apr 2025 05:58:23 -0700 (PDT)
Received: from grind.. ([152.234.125.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f7fb7e54sm8889440a12.30.2025.04.29.05.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 05:58:23 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, joel@jms.id.au,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 2/9] hw/riscv/virt.c: remove trivial virt_memmap references
Date: Tue, 29 Apr 2025 09:58:04 -0300
Message-ID: <20250429125811.224803-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429125811.224803-1-dbarboza@ventanamicro.com>
References: <20250429125811.224803-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x530.google.com
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

We should use s->memmap instead of virt_memmap to be able to use an
updated memmap when we start versioning the board.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/virt.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index bcf0ddd6c6..b4a6916abb 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -166,8 +166,8 @@ static void virt_flash_map1(PFlashCFI01 *flash,
 static void virt_flash_map(RISCVVirtState *s,
                            MemoryRegion *sysmem)
 {
-    hwaddr flashsize = virt_memmap[VIRT_FLASH].size / 2;
-    hwaddr flashbase = virt_memmap[VIRT_FLASH].base;
+    hwaddr flashsize = s->memmap[VIRT_FLASH].size / 2;
+    hwaddr flashbase = s->memmap[VIRT_FLASH].base;
 
     virt_flash_map1(s->flash[0], flashbase, flashsize,
                     sysmem);
@@ -998,8 +998,8 @@ static void create_fdt_rtc(RISCVVirtState *s, const MemMapEntry *memmap,
 static void create_fdt_flash(RISCVVirtState *s, const MemMapEntry *memmap)
 {
     MachineState *ms = MACHINE(s);
-    hwaddr flashsize = virt_memmap[VIRT_FLASH].size / 2;
-    hwaddr flashbase = virt_memmap[VIRT_FLASH].base;
+    hwaddr flashsize = s->memmap[VIRT_FLASH].size / 2;
+    hwaddr flashbase = s->memmap[VIRT_FLASH].base;
     g_autofree char *name = g_strdup_printf("/flash@%" PRIx64, flashbase);
 
     qemu_fdt_add_subnode(ms->fdt, name);
@@ -1034,7 +1034,7 @@ static void create_fdt_virtio_iommu(RISCVVirtState *s, uint16_t bdf)
     g_autofree char *pci_node = NULL;
 
     pci_node = g_strdup_printf("/soc/pci@%lx",
-                               (long) virt_memmap[VIRT_PCIE_ECAM].base);
+                               (long) s->memmap[VIRT_PCIE_ECAM].base);
     iommu_node = g_strdup_printf("%s/virtio_iommu@%x,%x", pci_node,
                                  PCI_SLOT(bdf), PCI_FUNC(bdf));
     iommu_phandle = qemu_fdt_alloc_phandle(fdt);
@@ -1103,7 +1103,7 @@ static void create_fdt_iommu(RISCVVirtState *s, uint16_t bdf)
     g_autofree char *pci_node = NULL;
 
     pci_node = g_strdup_printf("/soc/pci@%lx",
-                               (long) virt_memmap[VIRT_PCIE_ECAM].base);
+                               (long) s->memmap[VIRT_PCIE_ECAM].base);
     iommu_node = g_strdup_printf("%s/iommu@%x", pci_node, bdf);
     iommu_phandle = qemu_fdt_alloc_phandle(fdt);
     qemu_fdt_add_subnode(fdt, iommu_node);
@@ -1125,24 +1125,24 @@ static void finalize_fdt(RISCVVirtState *s)
     uint32_t irq_pcie_phandle = 1, irq_virtio_phandle = 1;
     uint32_t iommu_sys_phandle = 1;
 
-    create_fdt_sockets(s, virt_memmap, &phandle, &irq_mmio_phandle,
+    create_fdt_sockets(s, s->memmap, &phandle, &irq_mmio_phandle,
                        &irq_pcie_phandle, &irq_virtio_phandle,
                        &msi_pcie_phandle);
 
-    create_fdt_virtio(s, virt_memmap, irq_virtio_phandle);
+    create_fdt_virtio(s, s->memmap, irq_virtio_phandle);
 
     if (virt_is_iommu_sys_enabled(s)) {
         create_fdt_iommu_sys(s, irq_mmio_phandle, msi_pcie_phandle,
                              &iommu_sys_phandle);
     }
-    create_fdt_pcie(s, virt_memmap, irq_pcie_phandle, msi_pcie_phandle,
+    create_fdt_pcie(s, s->memmap, irq_pcie_phandle, msi_pcie_phandle,
                     iommu_sys_phandle);
 
-    create_fdt_reset(s, virt_memmap, &phandle);
+    create_fdt_reset(s, s->memmap, &phandle);
 
-    create_fdt_uart(s, virt_memmap, irq_mmio_phandle);
+    create_fdt_uart(s, s->memmap, irq_mmio_phandle);
 
-    create_fdt_rtc(s, virt_memmap, irq_mmio_phandle);
+    create_fdt_rtc(s, s->memmap, irq_mmio_phandle);
 }
 
 static void create_fdt(RISCVVirtState *s, const MemMapEntry *memmap)
@@ -1365,14 +1365,13 @@ static void create_platform_bus(RISCVVirtState *s, DeviceState *irqchip)
 {
     DeviceState *dev;
     SysBusDevice *sysbus;
-    const MemMapEntry *memmap = virt_memmap;
     int i;
     MemoryRegion *sysmem = get_system_memory();
 
     dev = qdev_new(TYPE_PLATFORM_BUS_DEVICE);
     dev->id = g_strdup(TYPE_PLATFORM_BUS_DEVICE);
     qdev_prop_set_uint32(dev, "num_irqs", VIRT_PLATFORM_BUS_NUM_IRQS);
-    qdev_prop_set_uint32(dev, "mmio_size", memmap[VIRT_PLATFORM_BUS].size);
+    qdev_prop_set_uint32(dev, "mmio_size", s->memmap[VIRT_PLATFORM_BUS].size);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     s->platform_bus_dev = dev;
 
@@ -1383,7 +1382,7 @@ static void create_platform_bus(RISCVVirtState *s, DeviceState *irqchip)
     }
 
     memory_region_add_subregion(sysmem,
-                                memmap[VIRT_PLATFORM_BUS].base,
+                                s->memmap[VIRT_PLATFORM_BUS].base,
                                 sysbus_mmio_get_region(sysbus, 0));
 }
 
-- 
2.49.0


