Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD109D64060
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 23:57:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVevH-0008Te-Sm; Tue, 16 Dec 2025 18:57:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVevF-0008TJ-A7
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 18:57:41 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVevD-0000LX-BW
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 18:57:41 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2a0a33d0585so33107045ad.1
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 15:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765929457; x=1766534257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+4zbcGa/4l0ZXzsk4XdIp0i63IZMBGGVDcGp1NQ+/kk=;
 b=xg8rRrliZxwHGT3RLIoft59rVPqZH2vhPh/URvz93AAmfaPb+cgRC7w0kAQtQkckAx
 gtrJ5UcweEEc4LxDMjGu5X4c9vIwWLXR9KzWh4AJUfpEXyvuMNwVIhEe0aHJSiNMUPtM
 bzI4IVSsuija+z9SjkNYSIqECZEr2BPGP1pFUm2CLoUQaJg0HIXOZd3fj9BzaU73Y2r3
 D/hkgT52D6euanfxlyDG5uQqSg4jwbLilE6R0G1XAaXKH/rfCFscl+TCmt+vYelset5L
 QDusHYIlXVo/u8PGL4aH+YHJROqVqiHsrJAmJMtb7Qqwm+mMivbq1n44sZ3t+uGCIwRy
 4AHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765929457; x=1766534257;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+4zbcGa/4l0ZXzsk4XdIp0i63IZMBGGVDcGp1NQ+/kk=;
 b=WksONzHZrX9coNVIGoamBIMXe8pnPHPi5rLjSnCRdwO0MBrxVSxV2KHJmdXNDj+D65
 COHcTTjR0uWXMGNCTU6mtOiCDYIyxvZTmcbNrCfpBR052SER+QZFC5/j9Ww3OBaw1gCa
 CTMAhTHysXUvrpGPhZ1UQKp+dPJTr5Zc18jDZGc3qmAc/BWJm/sfhNg8594lERdcHqD/
 JS0pJALUAet/eeahNKYjTs8se1KPT1ccusbo1v+8sV0VqpGqOBc5ttgZcaXyssy0xzH9
 9P7Jeg4LlwvTIzC4fbSFSJKvdmDBLdNxWa0fcMZHlO2/9D2wUQsj+KH9A3qWbZ19GlsH
 4adQ==
X-Gm-Message-State: AOJu0YxNWFO135XdbrfNlFnrSvweej6jgWTY/FdTr3VTCk0Uzh/nl6pv
 qlq+ITti32jRUEyDD5V6DcLmqsWP6O2rrofiIAsNxKbNuEK322n131Nfiw8uvBxPuD/HODsB2h6
 ov0nyox07gQ==
X-Gm-Gg: AY/fxX7KstF0vCCVmPqApM6BZoX93NJtnwlfI0KA1TTMhUoptlmQoICWlLvamSIOhlx
 +M01zV/PXwU9ke1EEnr7QwHrrnOMrUBLNgnKlFDPBrdSlZ/p5jZMrug2IxMgtnelSyrGaBIbKG1
 lio2xaxQXCCPqTfS7lYoCM+AOCURbcioyc4bIMRP+W6UVHzRT4BNss0pQnNZsl+3hIA09jMGSgH
 C2EuJUtmfC8Alx64jtC2JWk6UZ0mSGNyNjU7zeQwxhmoSgsgm694DRAnWf/kBTWbBet9W5jv+Dt
 ml0a2bYcLAqD920kAvXseIkjMpL5KHppJf96kaUHhX27P7uKml96yZDee+Fx5sXoBba0vR1FTRy
 aox+cyK0w0ECVxp/yRxpfwioRzMBXZGpHKN75SOSM4jIc7TMFM9vBLF0LVkD6Dg7vFk4R7a867o
 VjNmermF8WHUNQJtKrTOOb5z5Rna6Kp0D/RyEwf+IP6ujgefjquyhHn9x1bXs4ybg=
X-Google-Smtp-Source: AGHT+IFURWklcwsHbBJyQPvxVjIgUE1/XtzJAra2mYblCMhJEMPBgkD+YEvbuxCnvWlG3S2DemDNwQ==
X-Received: by 2002:a17:902:ccc9:b0:2a0:c852:5f9f with SMTP id
 d9443c01a7336-2a0c8526625mr104282005ad.7.1765929457314; 
 Tue, 16 Dec 2025 15:57:37 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a095b251d8sm112169865ad.8.2025.12.16.15.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 15:57:36 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Radoslaw Biernacki <rad@semihalf.com>,
 tangtao1634@phytium.com.cn,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4] hw/arm/smmu: add memory regions as property for an SMMU
 instance
Date: Tue, 16 Dec 2025 15:57:31 -0800
Message-ID: <20251216235731.1793908-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/hw/arm/smmu-common.h |  4 ++++
 include/hw/arm/virt.h        |  2 ++
 hw/arm/sbsa-ref.c            | 16 ++++++++++++----
 hw/arm/smmu-common.c         | 25 +++++++++++++++++++++++++
 hw/arm/virt.c                | 13 +++++++++++--
 5 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 80d0fecfde8..d9bade3c803 100644
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
index c77a33f6df2..d3743810338 100644
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
index 62a76121841..9a67ce857fe 100644
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
index 25fb2bab568..603f4b6a1d7 100644
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


