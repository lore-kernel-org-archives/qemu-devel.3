Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3882CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 18:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uya5p-0004lS-SG; Tue, 16 Sep 2025 14:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4z-0003DH-B4
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:07:03 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4s-0001eC-19
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:07:00 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3d118d8fa91so46717f8f.1
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 11:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758046009; x=1758650809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Jie2b8L6LtBeITM9fRPk+VpBByVf977W976JKBwZNHE=;
 b=VC3TIjWwYYwOM+Qx3yKpBWlG3z7UdOYQuQzGFBwVmdQMj03PeQGSIqlwTe9hlK1vz/
 uGHYaeLcrycS8Is6qOdfTgNcwTXV2YTxlCFONDgSUrBtmOyPTrhqltcisrKQ1hG058uC
 Rxu3sgWzc1jJ6EeXAHEwVjz5JCNlwla1ncwNyKEyUdwYf6K8PAlpDrtPPGBq1zKL5RT9
 xYkGHeY6el+E06iX0VvNOHsKzhXFknl0fcOxvYhjMLDykwh7gGVTNC4BLMbTjn/RwTzg
 ZUL1sH/kEEPRPV8UYPfrfDGGrRFrAvgwOO0k+uDEHylJ6Ku78AtRY2ZKgIi6QprNDYSp
 aoQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758046009; x=1758650809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jie2b8L6LtBeITM9fRPk+VpBByVf977W976JKBwZNHE=;
 b=xH9BoYIzRHHeK8MFqI0wA455a2AfvUHzXPVH/tIbt9oJnv1KsIL6dSzgP6WM2ODwvu
 sEeXxLwuJ8OwtbahvEFTgYrfBX4Mi1U44l9nop0qqF09qL58mhe03N5QIKsvg66upqRx
 7C6jJ/+h820sFWBhDlGTZ6e0j98Sy8AhpTuAa3jowHj3GIQMCENXeSNfp2rHVmI1E1u2
 LWy9H+qa363CWS/xO7dKOe7OU7wC5MhBlUAJLDTm1o1Yu07bA957HCVZr7OeprmXRp8C
 0eVovdV6QBq5GCmBvAsT1diHumhYdzbvnScPWdbQghkxXBa1tH82Llodw4e33Q/QRlR9
 Fgww==
X-Gm-Message-State: AOJu0YyXWsbLUgGZN0Xw4p29RIvZB0fcWduFcOFbPxMRy+afDxfX2haM
 /btOVudn55N6CgQ1szPQxiJCeLknbWcWRgYXFtaJjyWtlz/H4CRLN7YVtbDVmFEgSgFnka4JDMC
 KDzHl
X-Gm-Gg: ASbGncvl8DIx+CFY8fU1Aq6UlALyzNGaBWiaLzGJR79BDWQugE0gx5nra9viBY7ZxI1
 +Zne5NkEgW131gs/kfMbhxz2D8Rupfpq3bQYMgX0O/vFkp3HEde0WOiYRZX1zefYRFLWW0Xam83
 +GiUoW7Yglxdv4o+5GAaKA39H0Aui7US+QEL6ow2acaV+2U2irBszPMBVzr6q5rT/mUw6Onf0KB
 2ZyzAoLyVgqAgBCsEv9pjWOfeZosJ9oy+WaaGeAtEsCGAsYMY7w5AheWRyxWTiq2dpKOBk3XB3Q
 VRoErKqGwmYyMh6uFYNc/lu8u+lgd73KQxo0Wfe0EwOeYFQEEV1iOR59Ucy3tieDtt+pKip1n0D
 rYd3ZaRYffpSZaQ9+S+KWB/D2dEt6
X-Google-Smtp-Source: AGHT+IErl2U4bI2jZlINn7pTP/daHLtMOtZIgJRfnqTbc9SPvPYrjuOK6BpKx5V83fV8+Uupt9Snig==
X-Received: by 2002:a5d:5d0e:0:b0:3ea:71c4:8e3a with SMTP id
 ffacd0b85a97d-3ec9e1af7camr3028978f8f.13.1758046008967; 
 Tue, 16 Sep 2025 11:06:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760775880sm23033286f8f.2.2025.09.16.11.06.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:06:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/36] hw/arm/virt: Allow user-creatable SMMUv3 dev
 instantiation
Date: Tue, 16 Sep 2025 19:06:05 +0100
Message-ID: <20250916180611.1481266-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916180611.1481266-1-peter.maydell@linaro.org>
References: <20250916180611.1481266-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

Allow cold-plugging of an SMMUv3 device on the virt machine when no
global (legacy) SMMUv3 is present or when a virtio-iommu is specified.

This user-created SMMUv3 device is tied to a specific PCI bus provided
by the user, so ensure the IOMMU ops are configured accordingly.

Due to current limitations in QEMU’s device tree support, specifically
its inability to properly present pxb-pcie based root complexes and
their devices, the device tree support for the new SMMUv3 device is
limited to cases where it is attached to the default pcie.0 root complex.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nathan Chen <nathanc@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Donald Dutile <ddutile@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Message-id: 20250829082543.7680-8-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/smmu-common.h |  1 +
 hw/arm/smmu-common.c         |  8 +++++-
 hw/arm/smmuv3.c              |  2 ++
 hw/arm/virt.c                | 51 ++++++++++++++++++++++++++++++++++++
 hw/core/sysbus-fdt.c         |  3 +++
 5 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index e5e2d09294d..80d0fecfde8 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -161,6 +161,7 @@ struct SMMUState {
     QLIST_HEAD(, SMMUDevice) devices_with_notifiers;
     uint8_t bus_num;
     PCIBus *primary_bus;
+    bool smmu_per_bus; /* SMMU is specific to the primary_bus */
 };
 
 struct SMMUBaseClass {
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 7f64ea48d03..62a76121841 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -961,7 +961,12 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
                 goto out_err;
             }
         }
-        pci_setup_iommu(pci_bus, &smmu_ops, s);
+
+        if (s->smmu_per_bus) {
+            pci_setup_iommu_per_bus(pci_bus, &smmu_ops, s);
+        } else {
+            pci_setup_iommu(pci_bus, &smmu_ops, s);
+        }
         return;
     }
 out_err:
@@ -986,6 +991,7 @@ static void smmu_base_reset_exit(Object *obj, ResetType type)
 
 static const Property smmu_dev_properties[] = {
     DEFINE_PROP_UINT8("bus_num", SMMUState, bus_num, 0),
+    DEFINE_PROP_BOOL("smmu_per_bus", SMMUState, smmu_per_bus, false),
     DEFINE_PROP_LINK("primary-bus", SMMUState, primary_bus,
                      TYPE_PCI_BUS, PCIBus *),
 };
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index ab679723533..bcf8af8dc73 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1996,6 +1996,8 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
     device_class_set_parent_realize(dc, smmu_realize,
                                     &c->parent_realize);
     device_class_set_props(dc, smmuv3_properties);
+    dc->hotpluggable = false;
+    dc->user_creatable = true;
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 64b4dcf6071..7b3f9b1cdfe 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -57,6 +57,7 @@
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
+#include "hw/pci/pci_bus.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/pci-bridge/pci_expander_bridge.h"
 #include "hw/virtio/virtio-pci.h"
@@ -1475,6 +1476,29 @@ static void create_smmuv3_dt_bindings(const VirtMachineState *vms, hwaddr base,
     g_free(node);
 }
 
+static void create_smmuv3_dev_dtb(VirtMachineState *vms,
+                                  DeviceState *dev, PCIBus *bus)
+{
+    PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
+    SysBusDevice *sbdev = SYS_BUS_DEVICE(dev);
+    int irq = platform_bus_get_irqn(pbus, sbdev, 0);
+    hwaddr base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
+    MachineState *ms = MACHINE(vms);
+
+    if (!(vms->bootinfo.firmware_loaded && virt_is_acpi_enabled(vms)) &&
+        strcmp("pcie.0", bus->qbus.name)) {
+        warn_report("SMMUv3 device only supported with pcie.0 for DT");
+        return;
+    }
+    base += vms->memmap[VIRT_PLATFORM_BUS].base;
+    irq += vms->irqmap[VIRT_PLATFORM_BUS];
+
+    vms->iommu_phandle = qemu_fdt_alloc_phandle(ms->fdt);
+    create_smmuv3_dt_bindings(vms, base, SMMU_IO_LEN, irq);
+    qemu_fdt_setprop_cells(ms->fdt, vms->pciehb_nodename, "iommu-map",
+                           0x0, vms->iommu_phandle, 0x0, 0x10000);
+}
+
 static void create_smmu(const VirtMachineState *vms,
                         PCIBus *bus)
 {
@@ -3006,6 +3030,16 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
         qlist_append_str(reserved_regions, resv_prop_str);
         qdev_prop_set_array(dev, "reserved-regions", reserved_regions);
         g_free(resv_prop_str);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_ARM_SMMUV3)) {
+        if (vms->legacy_smmuv3_present || vms->iommu == VIRT_IOMMU_VIRTIO) {
+            error_setg(errp, "virt machine already has %s set. "
+                       "Doesn't support incompatible iommus",
+                       (vms->legacy_smmuv3_present) ?
+                       "iommu=smmuv3" : "virtio-iommu");
+        } else if (vms->iommu == VIRT_IOMMU_NONE) {
+            /* The new SMMUv3 device is specific to the PCI bus */
+            object_property_set_bool(OBJECT(dev), "smmu_per_bus", true, NULL);
+        }
     }
 }
 
@@ -3029,6 +3063,22 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
         virtio_md_pci_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
     }
 
+    if (object_dynamic_cast(OBJECT(dev), TYPE_ARM_SMMUV3)) {
+        if (!vms->legacy_smmuv3_present && vms->platform_bus_dev) {
+            PCIBus *bus;
+
+            bus = PCI_BUS(object_property_get_link(OBJECT(dev), "primary-bus",
+                                                   &error_abort));
+            if (pci_bus_bypass_iommu(bus)) {
+                error_setg(errp, "Bypass option cannot be set for SMMUv3 "
+                           "associated PCIe RC");
+                return;
+            }
+
+            create_smmuv3_dev_dtb(vms, dev, bus);
+        }
+    }
+
     if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
         PCIDevice *pdev = PCI_DEVICE(dev);
 
@@ -3231,6 +3281,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_PLATFORM);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_UEFI_VARS_SYSBUS);
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_ARM_SMMUV3);
 #ifdef CONFIG_TPM
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
 #endif
diff --git a/hw/core/sysbus-fdt.c b/hw/core/sysbus-fdt.c
index c339a27875c..e80776080be 100644
--- a/hw/core/sysbus-fdt.c
+++ b/hw/core/sysbus-fdt.c
@@ -31,6 +31,7 @@
 #include "qemu/error-report.h"
 #include "system/device_tree.h"
 #include "system/tpm.h"
+#include "hw/arm/smmuv3.h"
 #include "hw/platform-bus.h"
 #include "hw/vfio/vfio-platform.h"
 #include "hw/vfio/vfio-calxeda-xgmac.h"
@@ -518,6 +519,8 @@ static const BindingEntry bindings[] = {
 #ifdef CONFIG_TPM
     TYPE_BINDING(TYPE_TPM_TIS_SYSBUS, add_tpm_tis_fdt_node),
 #endif
+    /* No generic DT support for smmuv3 dev. Support added for arm virt only */
+    TYPE_BINDING(TYPE_ARM_SMMUV3, no_fdt_node),
     TYPE_BINDING(TYPE_RAMFB_DEVICE, no_fdt_node),
     TYPE_BINDING(TYPE_UEFI_VARS_SYSBUS, add_uefi_vars_node),
     TYPE_BINDING("", NULL), /* last element */
-- 
2.43.0


