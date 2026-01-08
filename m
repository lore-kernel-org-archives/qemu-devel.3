Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6AB4D1D492
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 21:05:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdxBl-0001d4-Pz; Thu, 08 Jan 2026 16:05:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdxBk-0001ZF-HK
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:05:00 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdxBi-0003uT-L0
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:05:00 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-29f0f875bc5so32328415ad.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 13:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767906297; x=1768511097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=v1aBY6A8cBD1OKOxMjdAuPrSZ5MtDuhg2wd8a2VotKw=;
 b=kJ4Ur/dX7oHDXV8CP1h6OM+ZDI+tpOJBw8EU4Rw70oZEhozcokhnOw+fgjY292gn69
 OxrHaqY8YBJDYRQMcdinIZjTYmCJVHVBML0uNCbYdePzfGQx5DIM/CMFkSyYXyhk8rIS
 37ZTOp9lkzW2JNV6oFLDTRxvZjEhT3+nhff4NNpzAO/YMcVLee+B+PjvB9kYVvd2MCOG
 oBVP7U3Lrt4I+aeqU5i+Wg4+p/ymBeMV4Ar1xbUJE8DmKJ3AeMqiLxRoynzpINfBLQhA
 h25HFQZaPzCqI7KTb0hQuy3QT4vL6qswMmZRvAVV5CxGvcW8N2Vhwm4xYVOCMJ4MhO0G
 lUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767906297; x=1768511097;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v1aBY6A8cBD1OKOxMjdAuPrSZ5MtDuhg2wd8a2VotKw=;
 b=TESyNWuu47B5A0linQfRf52zGzfq3JgJdNG5DFj6HH5ykGL2FlOWm0PacQUnbOya0c
 oZkdJAuvGj9UK0N0gitSypB/m9iRQYWkDdM/bMtyWM06U4eOqdQ8XNoB4Bn5VS650j9o
 Joh5xmzZ8Cdr1aSq5JeEgwbDST4C5BP4FvSNjVlIaNQS8rkAIH49k8OxU44841PsEicu
 aDourTkzp1CGKPtWIduJXXEE2vuVOVBzbCFGg6gJMMHNvgzo8D85IqD1NUnxwLmCYqCV
 aydkP/54Rt0f5SFX+EULKPZcVSyKADZH/XW1ocy+RqHfaBIxbRhIaHeS059qklFUO1i6
 tesA==
X-Gm-Message-State: AOJu0YzZn4WquSYA1uw5e5FQaWdvHEF9X209i6dT1CDdClNENcA6tLet
 s556l1YOGyAk8cZPQDxWra6iUy3ni9s/bsKIUp8050azenpvMrvnpRAEwSUA+OboDnQ4bzgGhS/
 m2x2h
X-Gm-Gg: AY/fxX6jCTvf/KK0zx9KY1vmBI6/bWpcixpqGPcNrcgcvmnsudN33UHFe6RMPThCoa6
 Md4yY3zyTkWaMU3Xp4DiZOhhj9WZ9lXFEAjM3uZwlG20ZNxMe16wRZhdX4ITVk17+OipV9KqNej
 HM8/LT3AePEt6TCOYT3xEeyf5/QxJfNFX2FSAv4DAr9kWkd4dDEY/B8XWWnQP5IBCnZK7GZF6pX
 +Bpf4gCCfFHUZC6LrMR9ngK5M2GGoJCUBO5Uu5u4H2JASpIzqJeKo7OrNRaFvAfSto5raFQpzbw
 4o3UTyd/CDFLSrX+F/H7iRyasBFT6LWMi6rBCcG+Xc7It1o/ZIc3+AQmBBc7+vfYl4py+4k1Ne6
 esg2/aNfPqKIx8WuOhxug3f+N8S0v/0fww75XsgHBwV8zpuEjUJGRp0MHt8YTk4LzCFxyrz0oa2
 7KHGD1ddOD2vgatfrrBg+XVTHAcMgNtyA6iua4Y9XgdIIVH/tAN3JLbOBVMDAQjElS
X-Google-Smtp-Source: AGHT+IFhzW+mBq6VGH/Eh2kJrs6OOI2ylO5GfW8bS5LmZ6pFjvzdPG00jXZ7m478yfCSej+WF9N6Bw==
X-Received: by 2002:a17:903:240d:b0:2a0:f469:1f5f with SMTP id
 d9443c01a7336-2a3ee47d198mr70972575ad.13.1767906297015; 
 Thu, 08 Jan 2026 13:04:57 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c3a464sm85718355ad.2.2026.01.08.13.04.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 13:04:56 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 tangtao1634@phytium.com.cn, richard.henderson@linaro.org,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5] hw/arm/smmu: add memory regions as property for an SMMU
 instance
Date: Thu,  8 Jan 2026 13:04:53 -0800
Message-ID: <20260108210453.2280733-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

This will be used to access non-secure and secure memory. Secure support
and Granule Protection Check (for RME) for SMMU need to access secure
memory.

As well, it allows to remove usage of global address_space_memory,
allowing different SMMU instances to have a specific view of memory.

User creatable SMMU are handled as well for virt machine,
by setting the memory properties when device is plugged in.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/hw/arm/smmu-common.h |  4 ++++
 include/hw/arm/virt.h        |  2 ++
 hw/arm/sbsa-ref.c            | 16 ++++++++++++----
 hw/arm/smmu-common.c         | 11 +++++++++++
 hw/arm/virt.c                | 13 +++++++++++--
 5 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 48368c8e894..b49b2f27fa9 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -162,6 +162,10 @@ struct SMMUState {
     uint8_t bus_num;
     PCIBus *primary_bus;
     bool smmu_per_bus; /* SMMU is specific to the primary_bus */
+    MemoryRegion *memory;
+    AddressSpace memory_as;
+    MemoryRegion *secure_memory;
+    AddressSpace secure_memory_as;
 };
 
 struct SMMUBaseClass {
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 8694aaa4e2a..5907d41dbb2 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -180,6 +180,8 @@ struct VirtMachineState {
     bool ns_el2_virt_timer_irq;
     CXLState cxl_devices_state;
     bool legacy_smmuv3_present;
+    MemoryRegion *sysmem;
+    MemoryRegion *secure_sysmem;
 };
 
 #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index d86b4706869..52c35e10c2d 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -613,7 +613,9 @@ static void create_xhci(const SBSAMachineState *sms)
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(sms->gic, irq));
 }
 
-static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
+static void create_smmu(const SBSAMachineState *sms, PCIBus *bus,
+                        MemoryRegion *sysmem,
+                        MemoryRegion *secure_sysmem)
 {
     hwaddr base = sbsa_ref_memmap[SBSA_SMMU].base;
     int irq =  sbsa_ref_irqmap[SBSA_SMMU];
@@ -625,6 +627,10 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
     object_property_set_str(OBJECT(dev), "stage", "nested", &error_abort);
     object_property_set_link(OBJECT(dev), "primary-bus", OBJECT(bus),
                              &error_abort);
+    object_property_set_link(OBJECT(dev), "memory", OBJECT(sysmem),
+                             &error_abort);
+    object_property_set_link(OBJECT(dev), "secure-memory", OBJECT(secure_sysmem),
+                             &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     for (i = 0; i < NUM_SMMU_IRQS; i++) {
@@ -633,7 +639,9 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
     }
 }
 
-static void create_pcie(SBSAMachineState *sms)
+static void create_pcie(SBSAMachineState *sms,
+                        MemoryRegion *sysmem,
+                        MemoryRegion *secure_sysmem)
 {
     hwaddr base_ecam = sbsa_ref_memmap[SBSA_PCIE_ECAM].base;
     hwaddr size_ecam = sbsa_ref_memmap[SBSA_PCIE_ECAM].size;
@@ -689,7 +697,7 @@ static void create_pcie(SBSAMachineState *sms)
 
     pci_create_simple(pci->bus, -1, "bochs-display");
 
-    create_smmu(sms, pci->bus);
+    create_smmu(sms, pci->bus, sysmem, secure_sysmem);
 }
 
 static void *sbsa_ref_dtb(const struct arm_boot_info *binfo, int *fdt_size)
@@ -825,7 +833,7 @@ static void sbsa_ref_init(MachineState *machine)
 
     create_xhci(sms);
 
-    create_pcie(sms);
+    create_pcie(sms, sysmem, secure_sysmem);
 
     create_secure_ec(secure_sysmem);
 
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index e1b77cc55fc..cdcfb1343da 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -944,6 +944,13 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    g_assert(s->memory);
+    address_space_init(&s->memory_as, s->memory, "smmu-memory-view");
+    if (s->secure_memory) {
+        address_space_init(&s->secure_memory_as, s->secure_memory,
+                           "smmu-secure-memory-view");
+    }
+
     /*
      * We only allow default PCIe Root Complex(pcie.0) or pxb-pcie based extra
      * root complexes to be associated with SMMU.
@@ -994,6 +1001,10 @@ static const Property smmu_dev_properties[] = {
     DEFINE_PROP_BOOL("smmu_per_bus", SMMUState, smmu_per_bus, false),
     DEFINE_PROP_LINK("primary-bus", SMMUState, primary_bus,
                      TYPE_PCI_BUS, PCIBus *),
+    DEFINE_PROP_LINK("memory", SMMUState, memory,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
+    DEFINE_PROP_LINK("secure-memory", SMMUState, secure_memory,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
 };
 
 static void smmu_base_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9d0568a7d56..4badc1a7348 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1514,8 +1514,7 @@ static void create_smmuv3_dev_dtb(VirtMachineState *vms,
                            0x0, vms->iommu_phandle, 0x0, 0x10000);
 }
 
-static void create_smmu(const VirtMachineState *vms,
-                        PCIBus *bus)
+static void create_smmu(const VirtMachineState *vms, PCIBus *bus)
 {
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     int irq =  vms->irqmap[VIRT_SMMU];
@@ -1535,6 +1534,10 @@ static void create_smmu(const VirtMachineState *vms,
     }
     object_property_set_link(OBJECT(dev), "primary-bus", OBJECT(bus),
                              &error_abort);
+    object_property_set_link(OBJECT(dev), "memory", OBJECT(vms->sysmem),
+                             &error_abort);
+    object_property_set_link(OBJECT(dev), "secure-memory", OBJECT(vms->secure_sysmem),
+                             &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     for (i = 0; i < NUM_SMMU_IRQS; i++) {
@@ -1609,6 +1612,7 @@ static void create_pcie(VirtMachineState *vms)
     memory_region_init_alias(ecam_alias, OBJECT(dev), "pcie-ecam",
                              ecam_reg, 0, size_ecam);
     memory_region_add_subregion(get_system_memory(), base_ecam, ecam_alias);
+    vms->sysmem = get_system_memory();
 
     /* Map the MMIO window into system address space so as to expose
      * the section of PCI MMIO space which starts at the same base address
@@ -2256,6 +2260,7 @@ static void machvirt_init(MachineState *machine)
          * devices go in at higher priority and take precedence.
          */
         secure_sysmem = g_new(MemoryRegion, 1);
+        vms->secure_sysmem = secure_sysmem;
         memory_region_init(secure_sysmem, OBJECT(machine), "secure-memory",
                            UINT64_MAX);
         memory_region_add_subregion_overlap(secure_sysmem, 0, sysmem, -1);
@@ -3051,6 +3056,10 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
         } else if (vms->iommu == VIRT_IOMMU_NONE) {
             /* The new SMMUv3 device is specific to the PCI bus */
             object_property_set_bool(OBJECT(dev), "smmu_per_bus", true, NULL);
+            object_property_set_link(OBJECT(dev), "memory",
+                                     OBJECT(vms->sysmem), NULL);
+            object_property_set_link(OBJECT(dev), "secure-memory",
+                                     OBJECT(vms->secure_sysmem), NULL);
         }
     }
 }
-- 
2.47.3


