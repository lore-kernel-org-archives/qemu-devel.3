Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5BBC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 08:50:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXFbr-0006g4-I4; Thu, 03 Jul 2025 04:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uXFbo-0006el-IX; Thu, 03 Jul 2025 04:47:56 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uXFbm-00043e-7N; Thu, 03 Jul 2025 04:47:56 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bXr1J6P6vz6L5Kf;
 Thu,  3 Jul 2025 16:44:52 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 7882E1402F0;
 Thu,  3 Jul 2025 16:47:48 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.203.177.241) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 3 Jul 2025 10:47:39 +0200
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <imammedo@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <gustavo.romero@linaro.org>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <linuxarm@huawei.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: [PATCH v6 03/12] hw/arm/virt-acpi-build: Re-arrange SMMUv3 IORT build
Date: Thu, 3 Jul 2025 09:46:34 +0100
Message-ID: <20250703084643.85740-4-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20250703084643.85740-1-shameerali.kolothum.thodi@huawei.com>
References: <20250703084643.85740-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.203.177.241]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
From:  Shameer Kolothum via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Introduce a new struct AcpiIortSMMUv3Dev to hold all the information
required for SMMUv3 IORT node and use that for populating the node.

The current machine wide SMMUv3 is named as legacy SMMUv3 as we will
soon add support for user-creatable SMMUv3 devices. These changes will
be useful to have common code paths when we add that support.

Tested-by: Nathan Chen <nathanc@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 hw/arm/virt-acpi-build.c | 137 ++++++++++++++++++++++++++-------------
 hw/arm/virt.c            |   1 +
 include/hw/arm/virt.h    |   1 +
 3 files changed, 94 insertions(+), 45 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 724fad5ffa..cb11b316a2 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -266,29 +266,65 @@ static int iort_idmap_compare(gconstpointer a, gconstpointer b)
     return idmap_a->input_base - idmap_b->input_base;
 }
 
+typedef struct AcpiIortSMMUv3Dev {
+    int irq;
+    hwaddr base;
+    GArray *rc_smmu_idmaps;
+    /* Offset of the SMMUv3 IORT Node relative to the start of the IORT */
+    size_t offset;
+} AcpiIortSMMUv3Dev;
+
+/*
+ * Populate the struct AcpiIortSMMUv3Dev for the legacy SMMUv3 and
+ * return the total number of associated idmaps.
+ */
+static int populate_smmuv3_legacy_dev(GArray *sdev_blob)
+{
+    VirtMachineState *vms = VIRT_MACHINE(qdev_get_machine());
+    AcpiIortSMMUv3Dev sdev;
+
+    sdev.rc_smmu_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
+    object_child_foreach_recursive(object_get_root(), iort_host_bridges,
+                                   sdev.rc_smmu_idmaps);
+    /*
+     * There can be only one legacy SMMUv3("iommu=smmuv3") as it is a machine
+     * wide one. Since it may cover multiple PCIe RCs(based on "bypass_iommu"
+     * property), may have multiple SMMUv3 idmaps. Sort it by input_base.
+     */
+    g_array_sort(sdev.rc_smmu_idmaps, iort_idmap_compare);
+
+    sdev.base = vms->memmap[VIRT_SMMU].base;
+    sdev.irq = vms->irqmap[VIRT_SMMU] + ARM_SPI_BASE;
+    g_array_append_val(sdev_blob, sdev);
+    return sdev.rc_smmu_idmaps->len;
+}
+
 /* Compute ID ranges (RIDs) from RC that are directed to the ITS Group node */
-static void create_rc_its_idmaps(GArray *its_idmaps, GArray *smmu_idmaps)
+static void create_rc_its_idmaps(GArray *its_idmaps, GArray *smmuv3_devs)
 {
     AcpiIortIdMapping *idmap;
     AcpiIortIdMapping next_range = {0};
+    AcpiIortSMMUv3Dev *sdev;
 
-    /*
-     * Based on the RID ranges that are directed to the SMMU, determine the
-     * bypassed RID ranges, i.e., the ones that are directed to the ITS Group
-     * node and do not pass through the SMMU, by subtracting the SMMU-bound
-     * ranges from the full RID range (0x0000–0xFFFF).
-     */
-     for (int i = 0; i < smmu_idmaps->len; i++) {
-        idmap = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
+    for (int i = 0; i < smmuv3_devs->len; i++) {
+        sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
+        /*
+         * Based on the RID ranges that are directed to the SMMU, determine the
+         * bypassed RID ranges, i.e., the ones that are directed to the ITS
+         * Group node and do not pass through the SMMU, by subtracting the
+         * SMMU-bound ranges from the full RID range (0x0000–0xFFFF).
+         */
+         for (int j = 0; j < sdev->rc_smmu_idmaps->len; j++) {
+            idmap = &g_array_index(sdev->rc_smmu_idmaps, AcpiIortIdMapping, j);
 
-        if (next_range.input_base < idmap->input_base) {
-            next_range.id_count = idmap->input_base - next_range.input_base;
-            g_array_append_val(its_idmaps, next_range);
-        }
+            if (next_range.input_base < idmap->input_base) {
+                next_range.id_count = idmap->input_base - next_range.input_base;
+                g_array_append_val(its_idmaps, next_range);
+            }
 
-        next_range.input_base = idmap->input_base + idmap->id_count;
+            next_range.input_base = idmap->input_base + idmap->id_count;
+        }
     }
-
     /*
      * Append the last RC -> ITS ID mapping.
      *
@@ -302,7 +338,6 @@ static void create_rc_its_idmaps(GArray *its_idmaps, GArray *smmu_idmaps)
     }
 }
 
-
 /*
  * Input Output Remapping Table (IORT)
  * Conforms to "IO Remapping Table System Software on ARM Platforms",
@@ -312,9 +347,12 @@ static void
 build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
     int i, nb_nodes, rc_mapping_count;
-    size_t node_size, smmu_offset = 0;
+    AcpiIortSMMUv3Dev *sdev;
+    size_t node_size;
+    int num_smmus = 0;
     uint32_t id = 0;
-    GArray *rc_smmu_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
+    int rc_smmu_idmaps_len = 0;
+    GArray *smmuv3_devs = g_array_new(false, true, sizeof(AcpiIortSMMUv3Dev));
     GArray *rc_its_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
 
     AcpiTable table = { .sig = "IORT", .rev = 3, .oem_id = vms->oem_id,
@@ -322,22 +360,21 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     /* Table 2 The IORT */
     acpi_table_begin(&table, table_data);
 
-    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
-        object_child_foreach_recursive(object_get_root(),
-                                       iort_host_bridges, rc_smmu_idmaps);
-
-        /* Sort the smmu idmap by input_base */
-        g_array_sort(rc_smmu_idmaps, iort_idmap_compare);
+    if (vms->legacy_smmuv3_present) {
+        rc_smmu_idmaps_len = populate_smmuv3_legacy_dev(smmuv3_devs);
+    }
 
-        nb_nodes = 2; /* RC and SMMUv3 */
-        rc_mapping_count = rc_smmu_idmaps->len;
+    num_smmus = smmuv3_devs->len;
+    if (num_smmus) {
+        nb_nodes = num_smmus + 1; /* RC and SMMUv3 */
+        rc_mapping_count = rc_smmu_idmaps_len;
 
         if (vms->its) {
             /*
              * Knowing the ID ranges from the RC to the SMMU, it's possible to
              * determine the ID ranges from RC that go directly to ITS.
              */
-            create_rc_its_idmaps(rc_its_idmaps, rc_smmu_idmaps);
+            create_rc_its_idmaps(rc_its_idmaps, smmuv3_devs);
 
             nb_nodes++; /* ITS */
             rc_mapping_count += rc_its_idmaps->len;
@@ -372,9 +409,10 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         build_append_int_noprefix(table_data, 0 /* MADT translation_id */, 4);
     }
 
-    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
-        int irq =  vms->irqmap[VIRT_SMMU] + ARM_SPI_BASE;
+    for (i = 0; i < num_smmus; i++) {
+        sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
         int smmu_mapping_count, offset_to_id_array;
+        int irq = sdev->irq;
 
         if (vms->its) {
             smmu_mapping_count = 1; /* ITS Group node */
@@ -383,7 +421,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             smmu_mapping_count = 0; /* No ID mappings */
             offset_to_id_array = 0; /* No ID mappings array */
         }
-        smmu_offset = table_data->len - table.table_offset;
+        sdev->offset = table_data->len - table.table_offset;
         /* Table 9 SMMUv3 Format */
         build_append_int_noprefix(table_data, 4 /* SMMUv3 */, 1); /* Type */
         node_size =  SMMU_V3_ENTRY_SIZE +
@@ -396,7 +434,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         /* Reference to ID Array */
         build_append_int_noprefix(table_data, offset_to_id_array, 4);
         /* Base address */
-        build_append_int_noprefix(table_data, vms->memmap[VIRT_SMMU].base, 8);
+        build_append_int_noprefix(table_data, sdev->base, 8);
         /* Flags */
         build_append_int_noprefix(table_data, 1 /* COHACC Override */, 4);
         build_append_int_noprefix(table_data, 0, 4); /* Reserved */
@@ -447,21 +485,26 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     build_append_int_noprefix(table_data, 0, 3); /* Reserved */
 
     /* Output Reference */
-    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
+    if (num_smmus) {
         AcpiIortIdMapping *range;
 
-        /*
-         * Map RIDs (input) from RC to SMMUv3 nodes: RC -> SMMUv3.
-         *
-         * N.B.: The mapping from SMMUv3 to ITS Group node (SMMUv3 -> ITS) is
-         * defined in the SMMUv3 table, where all SMMUv3 IDs are mapped to the
-         * ITS Group node, if ITS is available.
-         */
-        for (i = 0; i < rc_smmu_idmaps->len; i++) {
-            range = &g_array_index(rc_smmu_idmaps, AcpiIortIdMapping, i);
-            /* Output IORT node is the SMMUv3 node. */
-            build_iort_id_mapping(table_data, range->input_base,
-                                  range->id_count, smmu_offset);
+        for (i = 0; i < num_smmus; i++) {
+            sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
+
+            /*
+             * Map RIDs (input) from RC to SMMUv3 nodes: RC -> SMMUv3.
+             *
+             * N.B.: The mapping from SMMUv3 to ITS Group node (SMMUv3 -> ITS)
+             * is defined in the SMMUv3 table, where all SMMUv3 IDs are mapped
+             * to the ITS Group node, if ITS is available.
+             */
+             for (int j = 0; j < sdev->rc_smmu_idmaps->len; j++) {
+                range = &g_array_index(sdev->rc_smmu_idmaps,
+                                       AcpiIortIdMapping, j);
+                /* Output IORT node is the SMMUv3 node. */
+                build_iort_id_mapping(table_data, range->input_base,
+                                      range->id_count, sdev->offset);
+            }
         }
 
         if (vms->its) {
@@ -486,8 +529,12 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     }
 
     acpi_table_end(linker, &table);
-    g_array_free(rc_smmu_idmaps, true);
     g_array_free(rc_its_idmaps, true);
+    for (i = 0; i < num_smmus; i++) {
+        sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
+        g_array_free(sdev->rc_smmu_idmaps, true);
+    }
+    g_array_free(smmuv3_devs, true);
 }
 
 /*
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3bcdf92e2f..61a9a4fdc8 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1616,6 +1616,7 @@ static void create_pcie(VirtMachineState *vms)
                 qemu_fdt_setprop_cells(ms->fdt, nodename, "iommu-map",
                                        0x0, vms->iommu_phandle, 0x0, 0x10000);
             }
+            vms->legacy_smmuv3_present = true;
             break;
         default:
             g_assert_not_reached();
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 9a1b0f53d2..8b1404b5f6 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -174,6 +174,7 @@ struct VirtMachineState {
     char *oem_id;
     char *oem_table_id;
     bool ns_el2_virt_timer_irq;
+    bool legacy_smmuv3_present;
 };
 
 #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
-- 
2.34.1


