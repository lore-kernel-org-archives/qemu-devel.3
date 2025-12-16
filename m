Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63AB2D5B874
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 00:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVIep-0003Ud-JA; Mon, 15 Dec 2025 19:11:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVIeo-0003UN-N6
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 19:11:14 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVIei-0005rE-9O
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 19:11:14 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7b9387df58cso6084854b3a.3
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 16:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765843858; x=1766448658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tqM4WjZaNWr596U1fZ4OoNin9tBHjUqqlV2FK8g9pRI=;
 b=ysxU7BuwRAbDQzuyoy1KXd6VLjx8tyhBKiNirkj7fZCNNJgEW13FuhtMTt3bvPFVnV
 WFBOk9Tmewmf29dW2Eiq0ZYHEi1lfzxb2g3s0VEuChcnPSsG6RTZMgvJtQjzNuc7R1wn
 2N+0B3LXHDi01vnJrCv8WusuORXlu7yYUBF4XBKWikPTLjHp+f8+RS7ug7JuUDPVeRBf
 CrrYIP9XsBX1CO4hWDRHyqWzKUr4ADyjXHiNdFeI1KfdqOGpEBxkN3N0sV2O4WD21pVG
 ZqPrJqRXYOst4Ge3UHx08KZN9fi7IiTaBruHwB7iveZUUBbj6WmQ0JpKkkNd4nrhFzrc
 xT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765843858; x=1766448658;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tqM4WjZaNWr596U1fZ4OoNin9tBHjUqqlV2FK8g9pRI=;
 b=TCPUgTUBhJWgLVbymS3Yj1Nv9hiuyZ80vNYZRBm/ivdqYpNBplNudCxNBaARMh+n4Y
 FYTQiJARoWl736JPDo+zajGM3p+ug3W/7PqEws6UFvpqT1gVlDWEhaOwUz10MKPfstsm
 P/B9+n1QtS0JW6YjYJozsmLcwC4CWE5UYG50Wcoe2YpJ9w7N5vzr2rq0h+VukjniocXF
 XFRVzsO9OuHuBU974UEtqQ3RoHvDgy09QBjWUVi0seCRBpoQTVTj9+Hgjt/hdUNjObn7
 Jd4NP2BeAt/7dBBiEpWYGB7f80W5WDM4g+HmKulKAEgbPMri9g+B1Syg7Nr4w0dMEbcQ
 x5dw==
X-Gm-Message-State: AOJu0YyTNEo+t214GEMbu22YphZFYxjXjcGCIaPQ39XAk2sATu4/8Dwx
 1Ws9kooOimv+wDUIByg+FTR2UuegS5xf+QaihrUi2BPSUAGdzo633ULJy9it3DP86BmHCO2kv6H
 IQwYscTM=
X-Gm-Gg: AY/fxX5Q+eGUvldQDdFuO+pVnHiOOx5MucBOIu+9WHHJWV1gQCWAgRd1wmT2OnWG4fP
 qUW3NYkEY7T8Qxoich/2E1rZlnYAmBRAKn3aBHGQ1SHCM0+rWbO0PE5udNcXiFUbnGrdUIDXGUM
 KCROJnCoLB6sFXvnSV2Wbi77iSjjXfbX4uacUO7XkFAU/F69vT7D88DncdY2ta6Psos7g4iSzzu
 mG7mZOBl+omaoYtdm+xPUR4QbbqTcN4xx4QrrZ26Wm9oFNwVBUY5iMpZOX2IfcacPDXVNxv2WQX
 tphqIQO2dr9aFHLA4C7dkgzYzAltLb/O5EeS2antGmmZkyKf1EuCmdKT2UUN/+hLsMb4PzP8drU
 qwIKOXx2Ur3RlLdVgd4kJWu/zBqmlIrty332D5bjuNiZDEYXeO+tRZVFB+kSyFR7ovDFdbrmcAk
 2o/Ch0HYwn8XvrrABN1hIJRIqNgXFVubHjE4Z11OIvbb/OmWmSJvR50jMjY3QswaQ=
X-Google-Smtp-Source: AGHT+IFakBhV7Jhjko0WnI4njLAB91KrW7TV/5ZFbMaG3jBd3jfw9/83JqwKk+CQp+tKE7E4BTKTKQ==
X-Received: by 2002:a05:6a20:7f81:b0:35d:b415:7124 with SMTP id
 adf61e73a8af0-369afa00d56mr11169285637.50.1765843858123; 
 Mon, 15 Dec 2025 16:10:58 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c0ec080cce0sm10473785a12.12.2025.12.15.16.10.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 16:10:57 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 tangtao1634@phytium.com.cn, Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2] hw/arm/smmu: add memory regions as property for an SMMU
 instance
Date: Mon, 15 Dec 2025 16:10:53 -0800
Message-ID: <20251216001053.784223-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/hw/arm/smmu-common.h |  4 ++++
 hw/arm/sbsa-ref.c            | 16 ++++++++++++----
 hw/arm/smmu-common.c         | 25 +++++++++++++++++++++++++
 hw/arm/virt.c                | 16 +++++++++++-----
 4 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 80d0fecfde8..c58797ce4aa 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -162,6 +162,10 @@ struct SMMUState {
     uint8_t bus_num;
     PCIBus *primary_bus;
     bool smmu_per_bus; /* SMMU is specific to the primary_bus */
+    MemoryRegion *memory;
+    AddressSpace as_memory;
+    MemoryRegion *secure_memory;
+    AddressSpace as_secure_memory;
 };
 
 struct SMMUBaseClass {
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 2205500a8da..cc9d4385826 100644
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
index 62a76121841..1d6a90561cb 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -944,6 +944,13 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    g_assert(s->memory);
+    address_space_init(&s->as_memory, s->memory, "smmu-memory-view");
+    if (s->secure_memory) {
+        address_space_init(&s->as_secure_memory, s->secure_memory,
+                           "smmu-secure-memory-view");
+    }
+
     /*
      * We only allow default PCIe Root Complex(pcie.0) or pxb-pcie based extra
      * root complexes to be associated with SMMU.
@@ -1008,10 +1015,28 @@ static void smmu_base_class_init(ObjectClass *klass, const void *data)
     rc->phases.exit = smmu_base_reset_exit;
 }
 
+static void smmu_base_instance_init(Object *obj)
+{
+    SMMUState *s = ARM_SMMU(obj);
+
+    object_property_add_link(obj, "memory",
+                             TYPE_MEMORY_REGION,
+                             (Object **)&s->memory,
+                             qdev_prop_allow_set_link_before_realize,
+                             OBJ_PROP_LINK_STRONG);
+
+    object_property_add_link(obj, "secure-memory",
+                             TYPE_MEMORY_REGION,
+                             (Object **)&s->secure_memory,
+                             qdev_prop_allow_set_link_before_realize,
+                             OBJ_PROP_LINK_STRONG);
+}
+
 static const TypeInfo smmu_base_info = {
     .name          = TYPE_ARM_SMMU,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(SMMUState),
+    .instance_init = smmu_base_instance_init,
     .class_data    = NULL,
     .class_size    = sizeof(SMMUBaseClass),
     .class_init    = smmu_base_class_init,
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 25fb2bab568..32ef51c3ad7 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1514,8 +1514,9 @@ static void create_smmuv3_dev_dtb(VirtMachineState *vms,
                            0x0, vms->iommu_phandle, 0x0, 0x10000);
 }
 
-static void create_smmu(const VirtMachineState *vms,
-                        PCIBus *bus)
+static void create_smmu(const VirtMachineState *vms, PCIBus *bus,
+                        MemoryRegion *sysmem,
+                        MemoryRegion *secure_sysmem)
 {
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     int irq =  vms->irqmap[VIRT_SMMU];
@@ -1535,6 +1536,10 @@ static void create_smmu(const VirtMachineState *vms,
     }
     object_property_set_link(OBJECT(dev), "primary-bus", OBJECT(bus),
                              &error_abort);
+    object_property_set_link(OBJECT(dev), "memory", OBJECT(sysmem),
+                             &error_abort);
+    object_property_set_link(OBJECT(dev), "secure-memory", OBJECT(secure_sysmem),
+                             &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     for (i = 0; i < NUM_SMMU_IRQS; i++) {
@@ -1573,7 +1578,8 @@ static void create_virtio_iommu_dt_bindings(VirtMachineState *vms)
     }
 }
 
-static void create_pcie(VirtMachineState *vms)
+static void create_pcie(VirtMachineState *vms,
+                        MemoryRegion *sysmem, MemoryRegion *secure_sysmem)
 {
     hwaddr base_mmio = vms->memmap[VIRT_PCIE_MMIO].base;
     hwaddr size_mmio = vms->memmap[VIRT_PCIE_MMIO].size;
@@ -1692,7 +1698,7 @@ static void create_pcie(VirtMachineState *vms)
 
         switch (vms->iommu) {
         case VIRT_IOMMU_SMMUV3:
-            create_smmu(vms, vms->bus);
+            create_smmu(vms, vms->bus, sysmem, secure_sysmem);
             if (!vms->default_bus_bypass_iommu) {
                 qemu_fdt_setprop_cells(ms->fdt, nodename, "iommu-map",
                                        0x0, vms->iommu_phandle, 0x0, 0x10000);
@@ -2506,7 +2512,7 @@ static void machvirt_init(MachineState *machine)
 
     create_rtc(vms);
 
-    create_pcie(vms);
+    create_pcie(vms, sysmem, secure_sysmem);
     create_cxl_host_reg_region(vms);
 
     if (aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
-- 
2.47.3


