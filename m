Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35114D4660D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 18:56:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgSVb-00010w-L2; Thu, 15 Jan 2026 13:55:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSVO-0000i5-3v
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:39 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSVE-0005vU-Oh
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:36 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4327555464cso714742f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 10:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768503325; x=1769108125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pqPVb0Qg9mDq1j6XkxF6FMXRLHCRpoZyrstm/uoCxio=;
 b=HMkhcfATlFwdD94M6co8vkHTSO9Q+e3QD1la21oDR3KqoD87qaWBs+WtZieD5LMeKx
 CoOm7Gi0nkfeygMfBphLpf33soLmCbuMuS+heFngSq9/3ci8dPPeXQUWeGSkXdyTmt9n
 fVVu1mjYLTmFQHB0Gcm2myCTNqK2ZIkBxK5J3avFpEjcF2MegFkN2CMDmo+7l3RtnWHw
 8BCMA4NCkNq82rYhrq+dKroxvhpKLpZi0js1V7dHJcrJ8Bil2qZmTY/I2v1eVmitPU30
 Tjg2tl/i4aGcLgABIJMsLFW1YpUOW1y4jE7gBReK3yjwYpnIbMp+Ltw2kONum7ohqlFW
 Ea4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768503325; x=1769108125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pqPVb0Qg9mDq1j6XkxF6FMXRLHCRpoZyrstm/uoCxio=;
 b=QtmHg8d9R5X3IT19Tj9gvYCd7qn9L/RYNmkedEbFUeqkfrVJZtYttI7dwqhtuumN7i
 Ku9S/edYKbT+GwFozmtyJk1UpZ5pQi+8jBLUgfwdX5okuptm007uYgMFOK8FAN9MUGH7
 7iivGGjjCluaF7H1arjhV6t6vVXZA+7Y0uI/5PQtwb1PgYAE4MZFBoGYDOrrfncTNXt4
 F1HDG49+1QNu13yCVm99zrlL/OdSOoJ6ZaEKZVPTgTwoHsoKEJjkNCc0KduaeYDLlYk6
 Drg1VPG8H9Iy/IwEAW1cQb1FJeVxsLJK7syUnfpNkS3Q7b7s8yb83zisfHiEWw/lpIqq
 0pEw==
X-Gm-Message-State: AOJu0Ywwk77d8GEJkVTckxugWrlLQJWzwA+nSbtDwPjJvlFAk+b/PqY4
 5HmXeKILaRmgfYL3jJ+sqT5t0534kIJCuqjo9a60hOv4IxUt/bDbQxned8ZFUVkicGC4WjIeNki
 35/kt
X-Gm-Gg: AY/fxX6Xr5l2NrtUxMGtgBJqv/EomZBHztSsRXxSGBf9+E5/KzGzZyoPMNUXEvY8dtJ
 TWXQS6XzehJXGWhDJDKgbzcBszFwPJ22HVaz6Qss8iVjMr3I9/zJ/Mf6yM7snxe824IXoM6Jpvu
 wBg/yC1CD6lnnH6Aw8hC+cfRvjIY1ViZT7D5afewpJzcj0H3tGcdw1x7FxnsjxfrCLoZsUEaXkX
 n/4DLpsX6xeIR7t7EsdtVESQLFeRvP4PIpX2jRmzL03OEqvrZJU9s4AvCjLqg/Tmta0sTMWS9+6
 JCWIbvrXhkRw2KoPmCXsNlC8Rm8MIlg4YrMkGsdvhaJYrH6hpuA5OS1No52Vxr1cU9TZxiZ3Vhj
 t6JB1MbobljON6pw6wg7sK9/mBmzBKr45fNGoriT376DxeyTuoLWZC+XuUvPFlmS8KmoeFOXNAZ
 M84xhN+T+Z1lJviuIaPocV99fVlK6zDvUXzGsNb/ny3ezGEA9xgkXvCN06PeMts3jdc9X9gaHUL
 tEyxpheGj2fBNCrMCfiEkA8sJ3bNux+PFL1pZmOSrwJgA==
X-Received: by 2002:a5d:5848:0:b0:42c:b8fd:21b4 with SMTP id
 ffacd0b85a97d-43569bd3483mr440211f8f.57.1768503324858; 
 Thu, 15 Jan 2026 10:55:24 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cecasm514207f8f.26.2026.01.15.10.55.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 10:55:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/25] hw/arm/smmu: add memory regions as property for an SMMU
 instance
Date: Thu, 15 Jan 2026 18:54:59 +0000
Message-ID: <20260115185508.786428-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115185508.786428-1-peter.maydell@linaro.org>
References: <20260115185508.786428-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

This will be used to access non-secure and secure memory. Secure support
and Granule Protection Check (for RME) for SMMU need to access secure
memory.

As well, it allows to remove usage of global address_space_memory,
allowing different SMMU instances to have a specific view of memory.

User creatable SMMU are handled as well for virt machine,
by setting the memory properties when device is plugged in.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20260108210453.2280733-1-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/sbsa-ref.c            | 16 ++++++++++++----
 hw/arm/smmu-common.c         | 11 +++++++++++
 hw/arm/virt.c                | 13 +++++++++++--
 include/hw/arm/smmu-common.h |  4 ++++
 include/hw/arm/virt.h        |  2 ++
 5 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index d86b470686..52c35e10c2 100644
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
index e1b77cc55f..cdcfb1343d 100644
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
index 9d0568a7d5..4badc1a734 100644
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
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 48368c8e89..b49b2f27fa 100644
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
index 8694aaa4e2..5907d41dbb 100644
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
-- 
2.47.3


