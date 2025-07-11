Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D46CAC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 13:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaDuj-0005nX-Fe; Fri, 11 Jul 2025 09:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDtr-0004QA-39
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:34:51 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDto-00032u-Bz
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:34:50 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-454aaade1fbso21792095e9.3
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 06:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752240887; x=1752845687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=554uR+tWHHbPvIB9l177CJtnBAnLDMfIkrvonXqbU0Y=;
 b=GsfUTWUbXV64bu6TVB7/LMTokB79DhnUrYH32Htk9KTXCMtJy5sXv0lp/k0AmgmLHn
 dDcbzp6vTlEEUZtq0F+GnDduc/+ziuWHJFNzePSaZkIe1cWiGsm94Ie/AMG4runr6BUH
 zSeP8tMrtNavuh6QYtxA6r/UHdKTBooDPGhBW8rx2+kH8pfpCTUd68mUcih8MPnFI8MF
 8NwbX6RwEcEyWen4HoJ0R+VTHmTjfyzVXdhFP2sE85B2V8c8RUHepKPWhnrX0NPqlrSZ
 XF+DPEY2bX+TqFOIpcZp+ByWFHzVLlJTopiI7cA7Fz9q2GDerlB0aUFvskf6scc6Xr/e
 yhxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752240887; x=1752845687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=554uR+tWHHbPvIB9l177CJtnBAnLDMfIkrvonXqbU0Y=;
 b=w1/1FhSQoBK7Ce+8gSDl7NR13NV8yS3ixn4R/dPHPyZvwbjTFZ5O1OgK/eUSiYX8rK
 nnNn/SjfOqF37tOA7MolmtTU7DGHWSgv5ulEEm4n9zlB6iQK9SCw8tVJMdzdFoBx+vmO
 OVO+HvYxnk1kwk5BMtZ30clUY59lcCXLKeuohEqLlGPzdPqoxqe5G0JFX7m8hOgRQwOn
 HgxwGWrsq6Ag01WCVdZ2pt9HNrx41k6xP5879DjFNkyNfS/7KlTW0IMxMAsauf7BmJN8
 wQ+iXxAMUu65ICU9AEMnTqhfOeok2wDl2DrXNYBnlB/sdeA6tFBwGy+unUQDVT0CFpj4
 VxTw==
X-Gm-Message-State: AOJu0YxxIxzdoYR740qspuXj0WizIqajtj2zf9AcAaWurU5P4i12rX7p
 5zcnd1XCUWBh2FnVIRM72OVgZJb8nVOLG2/yEj1NSpZ0kSe9SddszxdCMgRPrAUrJpbpFgB1pKI
 Spx3R
X-Gm-Gg: ASbGnct+gLljrNlDWUJFyXIlvDiSLhLixs0ArlpNNRifx1oj3deUD6FhQE4FbBN1gnP
 PSISMzWHpVlK/xzq3+uomhmjtzdYFhFjLRIi5drMdsFnfmsqv4E7NvhuC4NIavRVbS/JK7hVI17
 wyDVdfMlsUz1t6oVxdGCUWY5VTf1cYiBRaF3/SYVdaeMlI9g3iDPZVTLavNb9U5Q4DeAVIZsYc+
 YUXUnmZ84Buyv9QDi2Vgx53+m/yQu4fVXjbqWXNkxOOIXwlblU+8e+jDyE9GMQuibHK5x35lKpt
 URKIivqu2ciUgBPggL8y+njzK+JMYBG69Sg5GOYqKCRh48D3CEpoYTo4x2f41L9kCHKkKgsZ3qf
 g+zWEwFMsW7/Q/YyTxoH8ps2QUHGi
X-Google-Smtp-Source: AGHT+IHV/SoVnbOTV0TjQ9aK3UDZ4znKLKtl1G00ZdM2vWVxii1XL01+dpEr6lXdVd3Nu3jrLDgl6A==
X-Received: by 2002:a05:600c:3155:b0:441:ac58:eb31 with SMTP id
 5b1f17b1804b1-454f4257e83mr23164205e9.20.1752240886518; 
 Fri, 11 Jul 2025 06:34:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d50df0cdsm89734145e9.25.2025.07.11.06.34.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 06:34:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/36] hw/arm/virt: Basic CXL enablement on pci_expander_bridge
 instances pxb-cxl
Date: Fri, 11 Jul 2025 14:34:07 +0100
Message-ID: <20250711133429.1423030-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711133429.1423030-1-peter.maydell@linaro.org>
References: <20250711133429.1423030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Code based on i386/pc enablement.
The memory layout places space for 16 host bridge register regions after
the GIC_REDIST2 in the extended memmap. This is a hole in the current
map so adding them here has no impact on placement of other memory regions
(tested with enough CPUs for GIC_REDIST2 to be in use.)
The high memory map is GiB aligned so the hole is there whatever the
size of memory or device_memory below this point.

The CFMWs are placed above the extended memmap. Note the existing
variable highest_gpa is the highest GPA that has been allocated at
a particular point in setting up the memory map. Whilst this caused
some confusion in review there are existing comments explaining this
so nothing is added.

The cxl_devices_state.host_mr provides a small space in which to place
the individual host bridge register regions for whatever host bridges are
allocated via -device pxb-cxl on the command line. The existing dynamic
sysbus infrastructure is not reused because pxb-cxl is a PCI device not
a sysbus one but these registers are directly in the main memory map,
not the PCI address space.

Only create the CEDT table if cxl=on set for the machine. Default to off.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
Tested-by: Li Zhijian <lizhijian@fujitsu.com>
Message-id: 20250703104110.992379-4-Jonathan.Cameron@huawei.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/virt.rst |  9 +++++++++
 include/hw/arm/virt.h    |  4 ++++
 hw/arm/virt-acpi-build.c | 34 ++++++++++++++++++++++++++++++++++
 hw/arm/virt.c            | 30 ++++++++++++++++++++++++++++++
 4 files changed, 77 insertions(+)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index 6a719b95863..10cbffc8a70 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -31,6 +31,7 @@ Supported devices
 The virt board supports:
 
 - PCI/PCIe devices
+- CXL Fixed memory windows, root bridges and devices.
 - Flash memory
 - Either one or two PL011 UARTs for the NonSecure World
 - An RTC
@@ -189,6 +190,14 @@ ras
 acpi
   Set ``on``/``off``/``auto`` to enable/disable ACPI.
 
+cxl
+  Set  ``on``/``off`` to enable/disable CXL. More details in
+  :doc:`../devices/cxl`. The default is off.
+
+cxl-fmw
+  Array of CXL fixed memory windows describing fixed address routing to
+  target CXL host bridges. See :doc:`../devices/cxl`.
+
 dtb-randomness
   Set ``on``/``off`` to pass random seeds via the guest DTB
   rng-seed and kaslr-seed nodes (in both "/chosen" and
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 9a1b0f53d21..4375819ea06 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -36,6 +36,7 @@
 #include "hw/arm/boot.h"
 #include "hw/arm/bsa.h"
 #include "hw/block/flash.h"
+#include "hw/cxl/cxl.h"
 #include "system/kvm.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "qom/object.h"
@@ -85,6 +86,7 @@ enum {
 /* indices of IO regions located after the RAM */
 enum {
     VIRT_HIGH_GIC_REDIST2 =  VIRT_LOWMEMMAP_LAST,
+    VIRT_CXL_HOST,
     VIRT_HIGH_PCIE_ECAM,
     VIRT_HIGH_PCIE_MMIO,
 };
@@ -140,6 +142,7 @@ struct VirtMachineState {
     bool secure;
     bool highmem;
     bool highmem_compact;
+    bool highmem_cxl;
     bool highmem_ecam;
     bool highmem_mmio;
     bool highmem_redists;
@@ -174,6 +177,7 @@ struct VirtMachineState {
     char *oem_id;
     char *oem_table_id;
     bool ns_el2_virt_timer_irq;
+    CXLState cxl_devices_state;
 };
 
 #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index cd90c47976c..c3b9b3f6ea4 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -39,10 +39,12 @@
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/utils.h"
 #include "hw/acpi/pci.h"
+#include "hw/acpi/cxl.h"
 #include "hw/acpi/memory_hotplug.h"
 #include "hw/acpi/generic_event_device.h"
 #include "hw/acpi/tpm.h"
 #include "hw/acpi/hmat.h"
+#include "hw/cxl/cxl.h"
 #include "hw/pci/pcie_host.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
@@ -119,10 +121,29 @@ static void acpi_dsdt_add_flash(Aml *scope, const MemMapEntry *flash_memmap)
     aml_append(scope, dev);
 }
 
+static void build_acpi0017(Aml *table)
+{
+    Aml *dev, *scope, *method;
+
+    scope =  aml_scope("_SB");
+    dev = aml_device("CXLM");
+    aml_append(dev, aml_name_decl("_HID", aml_string("ACPI0017")));
+
+    method = aml_method("_STA", 0, AML_NOTSERIALIZED);
+    aml_append(method, aml_return(aml_int(0x0B)));
+    aml_append(dev, method);
+    build_cxl_dsm_method(dev);
+
+    aml_append(scope, dev);
+    aml_append(table, scope);
+}
+
 static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
                               uint32_t irq, VirtMachineState *vms)
 {
     int ecam_id = VIRT_ECAM_ID(vms->highmem_ecam);
+    bool cxl_present = false;
+    PCIBus *bus = vms->bus;
     struct GPEXConfig cfg = {
         .mmio32 = memmap[VIRT_PCIE_MMIO],
         .pio    = memmap[VIRT_PCIE_PIO],
@@ -136,6 +157,14 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
     }
 
     acpi_dsdt_add_gpex(scope, &cfg);
+    QLIST_FOREACH(bus, &vms->bus->child, sibling) {
+        if (pci_bus_is_cxl(bus)) {
+            cxl_present = true;
+        }
+    }
+    if (cxl_present) {
+        build_acpi0017(scope);
+    }
 }
 
 static void acpi_dsdt_add_gpio(Aml *scope, const MemMapEntry *gpio_memmap,
@@ -1027,6 +1056,11 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
         }
     }
 
+    if (vms->cxl_devices_state.is_enabled) {
+        cxl_build_cedt(table_offsets, tables_blob, tables->linker,
+                       vms->oem_id, vms->oem_table_id, &vms->cxl_devices_state);
+    }
+
     if (ms->nvdimms_state->is_enabled) {
         nvdimm_build_acpi(table_offsets, tables_blob, tables->linker,
                           ms->nvdimms_state, ms->ram_slots, vms->oem_id,
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3bcdf92e2ff..394e8b53018 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -57,6 +57,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "hw/pci-host/gpex.h"
+#include "hw/pci-bridge/pci_expander_bridge.h"
 #include "hw/virtio/virtio-pci.h"
 #include "hw/core/sysbus-fdt.h"
 #include "hw/platform-bus.h"
@@ -86,6 +87,8 @@
 #include "hw/virtio/virtio-md-pci.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/char/pl011.h"
+#include "hw/cxl/cxl.h"
+#include "hw/cxl/cxl_host.h"
 #include "qemu/guest-random.h"
 
 static GlobalProperty arm_virt_compat[] = {
@@ -220,9 +223,11 @@ static const MemMapEntry base_memmap[] = {
 static MemMapEntry extended_memmap[] = {
     /* Additional 64 MB redist region (can contain up to 512 redistributors) */
     [VIRT_HIGH_GIC_REDIST2] =   { 0x0, 64 * MiB },
+    [VIRT_CXL_HOST] =           { 0x0, 64 * KiB * 16 }, /* 16 UID */
     [VIRT_HIGH_PCIE_ECAM] =     { 0x0, 256 * MiB },
     /* Second PCIe window */
     [VIRT_HIGH_PCIE_MMIO] =     { 0x0, DEFAULT_HIGH_PCIE_MMIO_SIZE },
+    /* Any CXL Fixed memory windows come here */
 };
 
 static const int a15irqmap[] = {
@@ -1623,6 +1628,17 @@ static void create_pcie(VirtMachineState *vms)
     }
 }
 
+static void create_cxl_host_reg_region(VirtMachineState *vms)
+{
+    MemoryRegion *sysmem = get_system_memory();
+    MemoryRegion *mr = &vms->cxl_devices_state.host_mr;
+
+    memory_region_init(mr, OBJECT(vms), "cxl_host_reg",
+                       vms->memmap[VIRT_CXL_HOST].size);
+    memory_region_add_subregion(sysmem, vms->memmap[VIRT_CXL_HOST].base, mr);
+    vms->highmem_cxl = true;
+}
+
 static void create_platform_bus(VirtMachineState *vms)
 {
     DeviceState *dev;
@@ -1739,6 +1755,12 @@ void virt_machine_done(Notifier *notifier, void *data)
     struct arm_boot_info *info = &vms->bootinfo;
     AddressSpace *as = arm_boot_address_space(cpu, info);
 
+    cxl_hook_up_pxb_registers(vms->bus, &vms->cxl_devices_state,
+                              &error_fatal);
+
+    if (vms->cxl_devices_state.is_enabled) {
+        cxl_fmws_link_targets(&error_fatal);
+    }
     /*
      * If the user provided a dtb, we assume the dynamic sysbus nodes
      * already are integrated there. This corresponds to a use case where
@@ -1785,6 +1807,7 @@ static inline bool *virt_get_high_memmap_enabled(VirtMachineState *vms,
 {
     bool *enabled_array[] = {
         &vms->highmem_redists,
+        &vms->highmem_cxl,
         &vms->highmem_ecam,
         &vms->highmem_mmio,
     };
@@ -1892,6 +1915,9 @@ static void virt_set_memmap(VirtMachineState *vms, int pa_bits)
     if (device_memory_size > 0) {
         machine_memory_devices_init(ms, device_memory_base, device_memory_size);
     }
+    vms->highest_gpa = cxl_fmws_set_memmap(ROUND_UP(vms->highest_gpa + 1,
+                                                    256 * MiB),
+                                           BIT_ULL(pa_bits)) - 1;
 }
 
 static VirtGICType finalize_gic_version_do(const char *accel_name,
@@ -2343,6 +2369,8 @@ static void machvirt_init(MachineState *machine)
     memory_region_add_subregion(sysmem, vms->memmap[VIRT_MEM].base,
                                 machine->ram);
 
+    cxl_fmws_update_mmio();
+
     virt_flash_fdt(vms, sysmem, secure_sysmem ?: sysmem);
 
     create_gic(vms, sysmem);
@@ -2398,6 +2426,7 @@ static void machvirt_init(MachineState *machine)
     create_rtc(vms);
 
     create_pcie(vms);
+    create_cxl_host_reg_region(vms);
 
     if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
         vms->acpi_dev = create_acpi_ged(vms);
@@ -3364,6 +3393,7 @@ static void virt_instance_init(Object *obj)
 
     vms->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
     vms->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
+    cxl_machine_init(obj, &vms->cxl_devices_state);
 }
 
 static const TypeInfo virt_machine_info = {
-- 
2.43.0


