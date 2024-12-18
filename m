Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6890DE7718A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 22:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO2ZE-00036k-Gs; Wed, 18 Dec 2024 17:30:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2Z9-00033m-7n
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:30:52 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2Yz-0002dz-A9
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:30:46 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2166360285dso1723615ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 14:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734561035; x=1735165835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vf7Bp36IZdmO9sF4T0jWx3aU8e+T/fZUXrxwKMlVMZY=;
 b=LTqCpNzBgdqohVL+LIXToOoFiRIrFl3Qsapt3SWrtru4hSke6r7RUTt+cD3w49Xdq5
 M41DFiR6WnplxfFvY/Re/J3AzRQ9xWFzBo48f9nm7+dLVXM9xyYCQKBIl6UAqYpEZ/Kp
 wWoQnZztbX31+ci08DImytLGDnn/TZ3TAi6sDf30M8WUIrDN1B81elQJVjvdN6CTB/Ow
 4cWTKaCyLeLBc+jMPDgnbVjAUs+kVFvFXVVQhzuAQgaodHvUgDE9YelIg8KxSkfuley9
 tnl61amX3D1vd81dGwL0FuZWHC0Zp2KuUS/pwbujy/9heD0j2Lx6jnJNwVMQ8X7iNcTI
 e5Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734561035; x=1735165835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vf7Bp36IZdmO9sF4T0jWx3aU8e+T/fZUXrxwKMlVMZY=;
 b=X7vxKODzV9b3i10oXhCc5scvVPaue+0BvMsJSauSc6Q4Cv+q7PjbqtKRYqQUiAGHOe
 5t3rlyKPEpura8uh9BSn2NoppLAV4Y/+UmwWoVytyY5834bO4Qlya4ow1y8rUYspMoZB
 kQCojji5qd3L4DHEz32yF/fe/DjNrVn8L5urnIxUJ8JY4bWsyG09WIw0BdV/qouDy0OD
 Z7ID/us9osAGZyPkFnYww1qrzqg38NoicZvRui2ajPwXYbWrEmY/ICd+fw2CpwHwdhCk
 F+n/qC/GbDU4Fgp5YZIZinW5Mmot3MTBcyuLwhmlRRIurnesTaKXVX2uKwHWi2BKT+7a
 r0Ew==
X-Gm-Message-State: AOJu0Yzhe9c19e7gfum+n7MD+FIrWgBPQWY8jpZgRl7jMHdYUtNpQ8TL
 OesZ5upe9kSwWBqTIiU7DYHy4Qh3B0CgxbfRMdiWDCvJjj7Ya3GpSnIohXkD
X-Gm-Gg: ASbGncsS3/JSVvHY/FkXmsm0THZzeOa7VIVQoiSHKLuxWmRUnS+NFhmOmpbWhh1xrBp
 nEcw3JJ7Cc6u6/Ph+hdRdZYXTT8f2nEHIwqd2I1NHZ33CQ4z5PQXM8W6dSax+NsyPJXQ+wPYGjv
 lMf4JDsyix+dE+pf1DofMrFazUBxj/0kYk6dWDC+qxiiiaxUwGMCSv9yWPXMv5t25pBP8i0cjRd
 /SQSS/EftCcOCseELOSc1ODTdwKCtdnweC1ZP6CcxZRpD9LIPMuk5uNJhqM+mavQnewjys+vLOf
 zVCpa/feJlb96Xp2WWLszadWze6anIsdfvDXBDMKMyzNUnLKe7ynrHVRuKYpkJ0=
X-Google-Smtp-Source: AGHT+IFSDZClTzONITGdusW1assmm9JGgc2bBsN7tlDj7fFuY2KENfetkdaC6AuFEu7m9POGcDH3nQ==
X-Received: by 2002:a17:903:283:b0:216:1367:7e3d with SMTP id
 d9443c01a7336-218d722d786mr67673045ad.31.1734561034945; 
 Wed, 18 Dec 2024 14:30:34 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9705d7sm375775ad.102.2024.12.18.14.30.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 14:30:34 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Sunil V L <sunilvl@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 06/39] hw/riscv/virt: Add IOMMU as platform device if the
 option is set
Date: Thu, 19 Dec 2024 08:29:36 +1000
Message-ID: <20241218223010.1931245-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218223010.1931245-1-alistair.francis@wdc.com>
References: <20241218223010.1931245-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Sunil V L <sunilvl@ventanamicro.com>

Add a new machine option called 'iommu-sys' that enables a
riscv-iommu-sys platform device for the 'virt' machine. The option is
default 'off'.

The device will use IRQs 36 to 39.

We will not support both riscv-iommu-sys and riscv-iommu-pci devices in
the same board in this first implementation. If a riscv-iommu-pci device
is added in the command line we will disable the riscv-iommu-sys device.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241106133407.604587-5-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/iommu.h |   2 +
 include/hw/riscv/virt.h  |   6 ++-
 hw/riscv/virt.c          | 104 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 109 insertions(+), 3 deletions(-)

diff --git a/include/hw/riscv/iommu.h b/include/hw/riscv/iommu.h
index fc20808553..8a8acfc3f0 100644
--- a/include/hw/riscv/iommu.h
+++ b/include/hw/riscv/iommu.h
@@ -37,4 +37,6 @@ typedef struct RISCVIOMMUStatePci RISCVIOMMUStatePci;
 OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUStateSys, RISCV_IOMMU_SYS)
 typedef struct RISCVIOMMUStateSys RISCVIOMMUStateSys;
 
+#define FDT_IRQ_TYPE_EDGE_LOW 1
+
 #endif
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index c0dc41ff9a..48a14bea2e 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -62,6 +62,7 @@ struct RISCVVirtState {
     OnOffAuto acpi;
     const MemMapEntry *memmap;
     struct GPEXHost *gpex_host;
+    OnOffAuto iommu_sys;
 };
 
 enum {
@@ -84,7 +85,8 @@ enum {
     VIRT_PCIE_MMIO,
     VIRT_PCIE_PIO,
     VIRT_PLATFORM_BUS,
-    VIRT_PCIE_ECAM
+    VIRT_PCIE_ECAM,
+    VIRT_IOMMU_SYS,
 };
 
 enum {
@@ -93,6 +95,7 @@ enum {
     VIRTIO_IRQ = 1, /* 1 to 8 */
     VIRTIO_COUNT = 8,
     PCIE_IRQ = 0x20, /* 32 to 35 */
+    IOMMU_SYS_IRQ = 0x24, /* 36-39 */
     VIRT_PLATFORM_BUS_IRQ = 64, /* 64 to 95 */
 };
 
@@ -129,6 +132,7 @@ enum {
                                  1 + FDT_APLIC_INT_CELLS)
 
 bool virt_is_acpi_enabled(RISCVVirtState *s);
+bool virt_is_iommu_sys_enabled(RISCVVirtState *s);
 void virt_acpi_setup(RISCVVirtState *vms);
 uint32_t imsic_num_bits(uint32_t count);
 
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 2feb851f15..c5ada635f1 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -33,6 +33,7 @@
 #include "target/riscv/pmu.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/iommu.h"
+#include "hw/riscv/riscv-iommu-bits.h"
 #include "hw/riscv/virt.h"
 #include "hw/riscv/boot.h"
 #include "hw/riscv/numa.h"
@@ -76,6 +77,7 @@ static const MemMapEntry virt_memmap[] = {
     [VIRT_CLINT] =        {  0x2000000,       0x10000 },
     [VIRT_ACLINT_SSWI] =  {  0x2F00000,        0x4000 },
     [VIRT_PCIE_PIO] =     {  0x3000000,       0x10000 },
+    [VIRT_IOMMU_SYS] =    {  0x3010000,        0x1000 },
     [VIRT_PLATFORM_BUS] = {  0x4000000,     0x2000000 },
     [VIRT_PLIC] =         {  0xc000000, VIRT_PLIC_SIZE(VIRT_CPUS_MAX * 2) },
     [VIRT_APLIC_M] =      {  0xc000000, APLIC_SIZE(VIRT_CPUS_MAX) },
@@ -853,7 +855,8 @@ static void create_fdt_virtio(RISCVVirtState *s, const MemMapEntry *memmap,
 
 static void create_fdt_pcie(RISCVVirtState *s, const MemMapEntry *memmap,
                             uint32_t irq_pcie_phandle,
-                            uint32_t msi_pcie_phandle)
+                            uint32_t msi_pcie_phandle,
+                            uint32_t iommu_sys_phandle)
 {
     g_autofree char *name = NULL;
     MachineState *ms = MACHINE(s);
@@ -887,6 +890,12 @@ static void create_fdt_pcie(RISCVVirtState *s, const MemMapEntry *memmap,
         2, virt_high_pcie_memmap.base,
         2, virt_high_pcie_memmap.base, 2, virt_high_pcie_memmap.size);
 
+    if (virt_is_iommu_sys_enabled(s)) {
+        qemu_fdt_setprop_cells(ms->fdt, name, "iommu-map",
+                               0, iommu_sys_phandle, 0, 0, 0,
+                               iommu_sys_phandle, 0, 0xffff);
+    }
+
     create_pcie_irq_map(s, ms->fdt, name, irq_pcie_phandle);
 }
 
@@ -1033,6 +1042,44 @@ static void create_fdt_virtio_iommu(RISCVVirtState *s, uint16_t bdf)
                            bdf + 1, iommu_phandle, bdf + 1, 0xffff - bdf);
 }
 
+static void create_fdt_iommu_sys(RISCVVirtState *s, uint32_t irq_chip,
+                                 uint32_t *iommu_sys_phandle)
+{
+    const char comp[] = "riscv,iommu";
+    void *fdt = MACHINE(s)->fdt;
+    uint32_t iommu_phandle;
+    g_autofree char *iommu_node = NULL;
+    hwaddr addr = s->memmap[VIRT_IOMMU_SYS].base;
+    hwaddr size = s->memmap[VIRT_IOMMU_SYS].size;
+    uint32_t iommu_irq_map[RISCV_IOMMU_INTR_COUNT] = {
+        IOMMU_SYS_IRQ + RISCV_IOMMU_INTR_CQ,
+        IOMMU_SYS_IRQ + RISCV_IOMMU_INTR_FQ,
+        IOMMU_SYS_IRQ + RISCV_IOMMU_INTR_PM,
+        IOMMU_SYS_IRQ + RISCV_IOMMU_INTR_PQ,
+    };
+
+    iommu_node = g_strdup_printf("/soc/iommu@%x",
+                               (unsigned int) s->memmap[VIRT_IOMMU_SYS].base);
+    iommu_phandle = qemu_fdt_alloc_phandle(fdt);
+    qemu_fdt_add_subnode(fdt, iommu_node);
+
+    qemu_fdt_setprop(fdt, iommu_node, "compatible", comp, sizeof(comp));
+    qemu_fdt_setprop_cell(fdt, iommu_node, "#iommu-cells", 1);
+    qemu_fdt_setprop_cell(fdt, iommu_node, "phandle", iommu_phandle);
+
+    qemu_fdt_setprop_cells(fdt, iommu_node, "reg",
+                           addr >> 32, addr, size >> 32, size);
+    qemu_fdt_setprop_cell(fdt, iommu_node, "interrupt-parent", irq_chip);
+
+    qemu_fdt_setprop_cells(fdt, iommu_node, "interrupts",
+        iommu_irq_map[0], FDT_IRQ_TYPE_EDGE_LOW,
+        iommu_irq_map[1], FDT_IRQ_TYPE_EDGE_LOW,
+        iommu_irq_map[2], FDT_IRQ_TYPE_EDGE_LOW,
+        iommu_irq_map[3], FDT_IRQ_TYPE_EDGE_LOW);
+
+    *iommu_sys_phandle = iommu_phandle;
+}
+
 static void create_fdt_iommu(RISCVVirtState *s, uint16_t bdf)
 {
     const char comp[] = "riscv,pci-iommu";
@@ -1061,6 +1108,7 @@ static void finalize_fdt(RISCVVirtState *s)
 {
     uint32_t phandle = 1, irq_mmio_phandle = 1, msi_pcie_phandle = 1;
     uint32_t irq_pcie_phandle = 1, irq_virtio_phandle = 1;
+    uint32_t iommu_sys_phandle = 1;
 
     create_fdt_sockets(s, virt_memmap, &phandle, &irq_mmio_phandle,
                        &irq_pcie_phandle, &irq_virtio_phandle,
@@ -1068,7 +1116,11 @@ static void finalize_fdt(RISCVVirtState *s)
 
     create_fdt_virtio(s, virt_memmap, irq_virtio_phandle);
 
-    create_fdt_pcie(s, virt_memmap, irq_pcie_phandle, msi_pcie_phandle);
+    if (virt_is_iommu_sys_enabled(s)) {
+        create_fdt_iommu_sys(s, irq_mmio_phandle, &iommu_sys_phandle);
+    }
+    create_fdt_pcie(s, virt_memmap, irq_pcie_phandle, msi_pcie_phandle,
+                    iommu_sys_phandle);
 
     create_fdt_reset(s, virt_memmap, &phandle);
 
@@ -1648,6 +1700,22 @@ static void virt_machine_init(MachineState *machine)
         create_fdt(s, memmap);
     }
 
+    if (virt_is_iommu_sys_enabled(s)) {
+        DeviceState *iommu_sys = qdev_new(TYPE_RISCV_IOMMU_SYS);
+
+        object_property_set_uint(OBJECT(iommu_sys), "addr",
+                                 s->memmap[VIRT_IOMMU_SYS].base,
+                                 &error_fatal);
+        object_property_set_uint(OBJECT(iommu_sys), "base-irq",
+                                 IOMMU_SYS_IRQ,
+                                 &error_fatal);
+        object_property_set_link(OBJECT(iommu_sys), "irqchip",
+                                 OBJECT(mmio_irqchip),
+                                 &error_fatal);
+
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(iommu_sys), &error_fatal);
+    }
+
     s->machine_done.notify = virt_machine_done;
     qemu_add_machine_init_done_notifier(&s->machine_done);
 }
@@ -1661,6 +1729,7 @@ static void virt_machine_instance_init(Object *obj)
     s->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
     s->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
     s->acpi = ON_OFF_AUTO_AUTO;
+    s->iommu_sys = ON_OFF_AUTO_AUTO;
 }
 
 static char *virt_get_aia_guests(Object *obj, Error **errp)
@@ -1733,6 +1802,28 @@ static void virt_set_aclint(Object *obj, bool value, Error **errp)
     s->have_aclint = value;
 }
 
+bool virt_is_iommu_sys_enabled(RISCVVirtState *s)
+{
+    return s->iommu_sys == ON_OFF_AUTO_ON;
+}
+
+static void virt_get_iommu_sys(Object *obj, Visitor *v, const char *name,
+                               void *opaque, Error **errp)
+{
+    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
+    OnOffAuto iommu_sys = s->iommu_sys;
+
+    visit_type_OnOffAuto(v, name, &iommu_sys, errp);
+}
+
+static void virt_set_iommu_sys(Object *obj, Visitor *v, const char *name,
+                               void *opaque, Error **errp)
+{
+    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
+
+    visit_type_OnOffAuto(v, name, &s->iommu_sys, errp);
+}
+
 bool virt_is_acpi_enabled(RISCVVirtState *s)
 {
     return s->acpi != ON_OFF_AUTO_OFF;
@@ -1759,10 +1850,12 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
                                                         DeviceState *dev)
 {
     MachineClass *mc = MACHINE_GET_CLASS(machine);
+    RISCVVirtState *s = RISCV_VIRT_MACHINE(machine);
 
     if (device_is_dynamic_sysbus(mc, dev) ||
         object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI) ||
         object_dynamic_cast(OBJECT(dev), TYPE_RISCV_IOMMU_PCI)) {
+        s->iommu_sys = ON_OFF_AUTO_OFF;
         return HOTPLUG_HANDLER(machine);
     }
 
@@ -1789,6 +1882,7 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_RISCV_IOMMU_PCI)) {
         create_fdt_iommu(s, pci_get_bdf(PCI_DEVICE(dev)));
+        s->iommu_sys = ON_OFF_AUTO_OFF;
     }
 }
 
@@ -1851,6 +1945,12 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
                               NULL, NULL);
     object_class_property_set_description(oc, "acpi",
                                           "Enable ACPI");
+
+    object_class_property_add(oc, "iommu-sys", "OnOffAuto",
+                              virt_get_iommu_sys, virt_set_iommu_sys,
+                              NULL, NULL);
+    object_class_property_set_description(oc, "iommu-sys",
+                                          "Enable IOMMU platform device");
 }
 
 static const TypeInfo virt_machine_typeinfo = {
-- 
2.47.1


