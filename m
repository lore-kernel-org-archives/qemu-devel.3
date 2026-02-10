Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23222EA8118
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpoAC-00022V-G4; Tue, 10 Feb 2026 08:52:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpoA3-0001wc-Gh
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:52:15 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpoA1-0006JY-Du
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:52:15 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47edd6111b4so82572605e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 05:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770731531; x=1771336331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2HDpSufvcJSJA6ud+97uY5GnYwnUWYupJFSv2xK/Nuc=;
 b=E+GGB2spPJtJsZFPcDLjQRA1nZhLteD8dFX62TITn0yP4NmXiqcRw8RZxHdKLPAks1
 G2HphIW59MaPNuDUlc0IZ75rEfxuy7u4NruUoVCl+qkAocpGWDh10W+KhtqlIZYFyt5T
 P4nqSN/E2WgPcJ9kdWFqRRQyjGV/IC0gJSvMebEg9D/cxsNr5JqKzZAhanvHpgnNT3oj
 soDGp9er46zVqKbCEFI0elNQkxxOkoDUhD+7QgTF9I72sX5sOfp5P+z6cdAaI8qp9Pyw
 07DumJyBcG0S300JlHDB3O/5h+riRpzKVYQhxDei9VwrerkydL9h+7ZuphMBVw7MeXv1
 Axdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770731531; x=1771336331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2HDpSufvcJSJA6ud+97uY5GnYwnUWYupJFSv2xK/Nuc=;
 b=T+KWNR6N7CSxsC37uN6dfny1RtjiUZQvuSqPBTMh4Z8My2YvUnASUWNTsmnQVilm39
 X4d+MUhVTfnBQbo7ibX1u5ZgF8yswdbLf0EeBNfJp18lOgI94HAtRvfe9+J8NNV4EWtB
 l4CUcbzWYp19v2Rf26GPaVIHK23Glvy/aJryqScnyTbnP3qOaGyiQro0iPhixhtB//pE
 FYOlect7xhMgmwuk74A6DOcdX4TiVoHV4Yp7uYdsDKLP9xkIynlXs8/zJ69NpVuSpXgd
 soMsax+HMGMKXnmiQzlvL4SGpnVMy1yBOJfvghgAkNybJ1sgjNv+KwNMa1DRMbOnlLc6
 fBag==
X-Gm-Message-State: AOJu0YwmoLdivoymUQ16I4EeU8lX6xq7v2P2FaKGonMni/3NWYvpisbA
 /DbDSdPOlhCan0juVqdaEmBfu5cDTndWj5Up2lZg2Ip9gGe7rA51N0WYM2yfcagKGkUZRTX5JRK
 cM/a3
X-Gm-Gg: AZuq6aL+CBUEFtOmJJzRcABbLMjlega37j4JM8Gqc+H6pb6vePGiBlOVD8Udx9yuwHi
 DuzepqZaA6nRGFKT6OnUDk8wL7iEZMCpoFeOVp5xqEBwPnUB2ZfBC8rK/Ao+9soK9i4RuXmAfwM
 EAzv9SwLdwrMU7dx995y7J5PCTA3cKkMTrP4+pj5pVsa3eo+4z1nDvQj/0REassDiBKTWh0ZOsc
 RHeU2L8pRwGBS56jZh/8H8IqzO5X1zuGrMRRzS7ajn+cPFBEMovxfDAQ3Qg5EwbHndUFv6oj83M
 Itix0hwamXVd96qL02gWiHp/cH7Mzv923g+nRQqDpaLIsm3GqGNO4uDMsw8shAbC3XSMibgxlzz
 S237ssPLDmMoQfzP4buGq/hkqUJe7wo+yjSmZdulyNqajQOENsqaXjoVzNq1yXREK2COOixQg70
 s/JMHb4WgStSOZcv6HWKsV2o+K7+IVzQuI1ogWo+BSOMmeF6GvmIILSekMD9aYALWKAIyJC43Cz
 /Wzsz8CtL6BlBhic/2uS/ZKEbQccac=
X-Received: by 2002:a05:600c:828e:b0:47d:6140:3284 with SMTP id
 5b1f17b1804b1-48350835edfmr28495215e9.37.1770731531246; 
 Tue, 10 Feb 2026 05:52:11 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5d77f9sm64344875e9.3.2026.02.10.05.52.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 05:52:10 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/26] hw: arm: virt: rework MSI-X configuration
Date: Tue, 10 Feb 2026 13:51:44 +0000
Message-ID: <20260210135206.229528-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210135206.229528-1-peter.maydell@linaro.org>
References: <20260210135206.229528-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Introduce a -M msi= argument to be able to control MSI-X support independently
from ITS, as part of supporting GICv3 + GICv2m platforms.

Remove vms->its as it's no longer needed after that change.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt-acpi-build.c |  20 ++++---
 hw/arm/virt.c            | 119 ++++++++++++++++++++++++++++++++++++---
 include/hw/arm/virt.h    |   5 +-
 3 files changed, 128 insertions(+), 16 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index c145678185..544004615d 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -569,7 +569,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         nb_nodes = num_smmus + 1; /* RC and SMMUv3 */
         rc_mapping_count = rc_smmu_idmaps_len;
 
-        if (vms->its) {
+        if (vms->msi_controller == VIRT_MSI_CTRL_ITS) {
             /*
              * Knowing the ID ranges from the RC to the SMMU, it's possible to
              * determine the ID ranges from RC that go directly to ITS.
@@ -590,7 +590,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             }
         }
     } else {
-        if (vms->its) {
+        if (vms->msi_controller == VIRT_MSI_CTRL_ITS) {
             nb_nodes = 2; /* RC and ITS */
             rc_mapping_count = 1; /* Direct map to ITS */
         } else {
@@ -605,7 +605,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     build_append_int_noprefix(table_data, IORT_NODE_OFFSET, 4);
     build_append_int_noprefix(table_data, 0, 4); /* Reserved */
 
-    if (vms->its) {
+    if (vms->msi_controller == VIRT_MSI_CTRL_ITS) {
         /* Table 12 ITS Group Format */
         build_append_int_noprefix(table_data, 0 /* ITS Group */, 1); /* Type */
         node_size =  20 /* fixed header size */ + 4 /* 1 GIC ITS Identifier */;
@@ -624,7 +624,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         int smmu_mapping_count, offset_to_id_array;
         int irq = sdev->irq;
 
-        if (vms->its) {
+        if (vms->msi_controller == VIRT_MSI_CTRL_ITS) {
             smmu_mapping_count = 1; /* ITS Group node */
             offset_to_id_array = SMMU_V3_ENTRY_SIZE; /* Just after the header */
         } else {
@@ -717,7 +717,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             }
         }
 
-        if (vms->its) {
+        if (vms->msi_controller == VIRT_MSI_CTRL_ITS) {
             /*
              * Map bypassed (don't go through the SMMU) RIDs (input) to
              * ITS Group node directly: RC -> ITS.
@@ -735,7 +735,9 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
          * SMMU: RC -> ITS.
          * Output IORT node is the ITS Group node (the first node).
          */
-        build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET, 0);
+        if (vms->msi_controller == VIRT_MSI_CTRL_ITS) {
+            build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET, 0);
+        }
     }
 
     build_iort_rmr_nodes(table_data, smmuv3_devs, &id);
@@ -1053,7 +1055,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
                                           memmap[VIRT_HIGH_GIC_REDIST2].size);
         }
 
-        if (vms->its) {
+        if (vms->msi_controller == VIRT_MSI_CTRL_ITS) {
             /*
              * ACPI spec, Revision 6.0 Errata A
              * (original 6.0 definition has invalid Length)
@@ -1067,7 +1069,9 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             build_append_int_noprefix(table_data, memmap[VIRT_GIC_ITS].base, 8);
             build_append_int_noprefix(table_data, 0, 4);    /* Reserved */
         }
-    } else {
+    }
+
+    if (vms->msi_controller == VIRT_MSI_CTRL_GICV2M) {
         const uint16_t spi_base = vms->irqmap[VIRT_GIC_V2M] + ARM_SPI_BASE;
 
         /* 5.2.12.16 GIC MSI Frame Structure */
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 390845c503..aa5e992712 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -737,7 +737,6 @@ static void create_its(VirtMachineState *vms)
 {
     DeviceState *dev;
 
-    assert(vms->its);
     if (!kvm_irqchip_in_kernel() && !vms->tcg_its) {
         /*
          * Do nothing if ITS is neither supported by the host nor emulated by
@@ -957,9 +956,9 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
 
     fdt_add_gic_node(vms);
 
-    if (vms->gic_version != VIRT_GIC_VERSION_2 && vms->its) {
+    if (vms->msi_controller == VIRT_MSI_CTRL_ITS) {
         create_its(vms);
-    } else if (vms->gic_version == VIRT_GIC_VERSION_2) {
+    } else if (vms->msi_controller == VIRT_MSI_CTRL_GICV2M) {
         create_v2m(vms);
     }
 }
@@ -2137,6 +2136,44 @@ static void finalize_gic_version(VirtMachineState *vms)
                                                gics_supported, max_cpus);
 }
 
+static void finalize_msi_controller(VirtMachineState *vms)
+{
+    /*
+     * VIRT_MSI_LEGACY_OPT_ITS_OFF is an option to replicate
+     * behavior of its=off when running with a GICv2, where a
+     * GICv2m is still present. Otherwise, it behaves the same
+     * as msi=off.
+     */
+    if (vms->msi_controller == VIRT_MSI_LEGACY_OPT_ITS_OFF) {
+        if (vms->gic_version == 2) {
+            vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
+        } else {
+            vms->msi_controller = VIRT_MSI_CTRL_NONE;
+        }
+    }
+    if (vms->msi_controller == VIRT_MSI_CTRL_AUTO) {
+        if (vms->gic_version == VIRT_GIC_VERSION_2) {
+            vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
+        } else {
+            vms->msi_controller = VIRT_MSI_CTRL_ITS;
+        }
+    }
+
+    if (vms->msi_controller == VIRT_MSI_CTRL_ITS) {
+        if (vms->gic_version == VIRT_GIC_VERSION_2) {
+            /*
+             * The legacy its= option in earlier releases allowed specifying
+             * this configuration and treated it as GICv3 + GICv2m.
+             * Diagnose it as an error even for that case.
+             */
+            error_report("GICv2 + ITS is an invalid configuration.");
+            exit(1);
+        }
+    }
+
+    assert(vms->msi_controller != VIRT_MSI_CTRL_AUTO);
+}
+
 /*
  * virt_post_cpus_gic_realized() must be called after the CPUs and
  * the GIC have both been realized.
@@ -2256,6 +2293,7 @@ static void machvirt_init(MachineState *machine)
      * KVM is not available yet
      */
     finalize_gic_version(vms);
+    finalize_msi_controller(vms);
 
     if (vms->secure) {
         /*
@@ -2705,18 +2743,76 @@ static void virt_set_highmem_mmio_size(Object *obj, Visitor *v,
     extended_memmap[VIRT_HIGH_PCIE_MMIO].size = size;
 }
 
+static char *virt_get_msi(Object *obj, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+    const char *val;
+
+    switch (vms->msi_controller) {
+    case VIRT_MSI_CTRL_NONE:
+    case VIRT_MSI_LEGACY_OPT_ITS_OFF:
+        val = "off";
+        break;
+    case VIRT_MSI_CTRL_ITS:
+        val = "its";
+        break;
+    case VIRT_MSI_CTRL_GICV2M:
+        val = "gicv2m";
+        break;
+    case VIRT_MSI_CTRL_AUTO:
+        val = "auto";
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return g_strdup(val);
+}
+
+static void virt_set_msi(Object *obj, const char *value, Error **errp)
+{
+    ERRP_GUARD();
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    if (!strcmp(value, "auto")) {
+        vms->msi_controller = VIRT_MSI_CTRL_AUTO; /* Will be overriden later */
+    } else if (!strcmp(value, "its")) {
+        vms->msi_controller = VIRT_MSI_CTRL_ITS;
+    } else if (!strcmp(value, "gicv2m")) {
+        vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
+    } else if (!strcmp(value, "off")) {
+        vms->msi_controller = VIRT_MSI_CTRL_NONE;
+    } else {
+        error_setg(errp, "Invalid msi value");
+        error_append_hint(errp, "Valid values are auto, gicv2m, its, off\n");
+    }
+}
+
 static bool virt_get_its(Object *obj, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
 
-    return vms->its;
+    switch (vms->msi_controller) {
+    case VIRT_MSI_CTRL_AUTO:
+    case VIRT_MSI_CTRL_ITS:
+        return true;
+    case VIRT_MSI_CTRL_NONE:
+    case VIRT_MSI_CTRL_GICV2M:
+    case VIRT_MSI_LEGACY_OPT_ITS_OFF:
+        return false;
+    default:
+        g_assert_not_reached();
+    }
 }
 
 static void virt_set_its(Object *obj, bool value, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
 
-    vms->its = value;
+    if (value) {
+        vms->msi_controller = VIRT_MSI_CTRL_ITS;
+    } else {
+        vms->msi_controller = VIRT_MSI_LEGACY_OPT_ITS_OFF;
+    }
 }
 
 static bool virt_get_dtb_randomness(Object *obj, Error **errp)
@@ -3043,6 +3139,9 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
             db_start = base_memmap[VIRT_GIC_V2M].base;
             db_end = db_start + base_memmap[VIRT_GIC_V2M].size - 1;
             break;
+        case VIRT_MSI_CTRL_AUTO:
+        case VIRT_MSI_LEGACY_OPT_ITS_OFF:
+            g_assert_not_reached();
         }
         resv_prop_str = g_strdup_printf("0x%"PRIx64":0x%"PRIx64":%u",
                                         db_start, db_end,
@@ -3463,6 +3562,12 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
                                           "Set on/off to enable/disable "
                                           "ITS instantiation");
 
+    object_class_property_add_str(oc, "msi", virt_get_msi,
+                                  virt_set_msi);
+    object_class_property_set_description(oc, "msi",
+                                          "Set MSI settings. "
+                                          "Valid values are auto, gicv2m, its and off");
+
     object_class_property_add_bool(oc, "dtb-randomness",
                                    virt_get_dtb_randomness,
                                    virt_set_dtb_randomness);
@@ -3518,8 +3623,8 @@ static void virt_instance_init(Object *obj)
     vms->highmem_mmio = true;
     vms->highmem_redists = true;
 
-    /* Default allows ITS instantiation */
-    vms->its = true;
+    /* Default allows ITS instantiation if available */
+    vms->msi_controller = VIRT_MSI_CTRL_AUTO;
     /* Allow ITS emulation if the machine version supports it */
     vms->tcg_its = !vmc->no_tcg_its;
 
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 3b382bdf49..8069422769 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -101,6 +101,10 @@ typedef enum VirtIOMMUType {
 
 typedef enum VirtMSIControllerType {
     VIRT_MSI_CTRL_NONE,
+    /* This value is overriden at runtime.*/
+    VIRT_MSI_CTRL_AUTO,
+    /* Legacy option: its=off provides a GICv2m when using GICv2 */
+    VIRT_MSI_LEGACY_OPT_ITS_OFF,
     VIRT_MSI_CTRL_GICV2M,
     VIRT_MSI_CTRL_ITS,
 } VirtMSIControllerType;
@@ -146,7 +150,6 @@ struct VirtMachineState {
     bool highmem_ecam;
     bool highmem_mmio;
     bool highmem_redists;
-    bool its;
     bool tcg_its;
     bool virt;
     bool ras;
-- 
2.43.0


