Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25D5F41986
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 10:57:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCxw9-0000iy-Qv; Wed, 15 Apr 2026 06:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxw7-0000gX-Kz; Wed, 15 Apr 2026 06:57:35 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxw5-00040d-RM; Wed, 15 Apr 2026 06:57:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zE2QKxSKECOrC7zfqhnjG+5ax2j35M+3LuGVaBH/Avm2l5mZHsKya1Q+kIFmjwDKWMYOn63Dwle1CsX2utk0jhMoEVZRcdKxPv/W+E7WILlHZCRc38Mfcf1H/GR+DMiKHEu5frbhO1KwclkBNLlZHLEB1mUnM87nAJMerMtbvNtDWSV5vRKTMQMZ2hA4j7iU/EuCrM5I03rl2FahdxigixdaJvwlFU29UAXS5Z6s8Yjgs3o68DhzjpamUOcz05+TM03zqXhP5ca3U5jdZkcmbRNlgSj+hkSgAi4+iSCMoCsTICRCY/o23hZRR6y6p9duq0NTIhqwX8iykCIAU89bbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7g+fBaIKw+zUbViL+Ym+yxdHMG7LJG8H7obXkC1euvE=;
 b=tF5zSTXhkOromdm3NxJR1HG/Os429q0NAhGOflhX15hO+goC1yf1yZH7rQNNwnRtdJNNrQyyQxIOqL137q6mkeEWspHYk5KsMxRxT4ZN3c7Dk6/+Fr4v0Y40TqqHR+cRjPuAkAFR50GC5vzxthv/LVxM+1jHxG96ubcwnp3eiqVRbqiaw258IOlya8eJMqkeo8QKbWwiUfgsRVdGwDzKUbLOvJgtI5SQKXG3yKQkXRwxQtVdNKr/k7SQ0Mh7GwlLdR9mGpo+U4Z7azI8GnIYzYNIbE5A48xYRngeVWRxpwt3cgs53L3qlOTPf3NFPSP0cnsv7QcQgAVrZB1+6cc2TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7g+fBaIKw+zUbViL+Ym+yxdHMG7LJG8H7obXkC1euvE=;
 b=QqztvOdpdvyr0oObKDgans+5gSnolve1AgO3Y2C9qzVN8hLhQN2B8ei52qY1K41IjvCkENucCcgq3Kv6sCSyQqrZr2UIszcKE5Y4AiC8YQcn+e4+GciFBE1BAZm/dQbsgksd4+PGQUfQIDlrmKBfr25YPM5jkgftmFbvG54QpnLH578bvrCLxS1iLDNwJqPj00geZW2EhoFZUXuo3Idmqh/THe8W2rWOyWZM+4mtzachHS5oX2JkOsOE6mVM3SNc+ECE4/C4oZL4DejcEB58JNkQm9tVHtHSv3Hn5z8nTkGVxIiXsgPDht+3hMN+6zKnELZPd5uxdniOPOYRoyqDZA==
Received: from MN0P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::13)
 by SJ2PR12MB8783.namprd12.prod.outlook.com (2603:10b6:a03:4d0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 10:57:25 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::ec) by MN0P223CA0012.outlook.office365.com
 (2603:10b6:208:52b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.50 via Frontend Transport; Wed,
 15 Apr 2026 10:57:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 10:57:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:57:06 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:57:03 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v4 09/31] hw/arm/virt: Use stored SMMUv3 device list for IORT
 build
Date: Wed, 15 Apr 2026 11:55:30 +0100
Message-ID: <20260415105552.622421-10-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415105552.622421-1-skolothumtho@nvidia.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|SJ2PR12MB8783:EE_
X-MS-Office365-Filtering-Correlation-Id: c901524c-dd05-4cf2-5c26-08de9addc73c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: TWxKDHbSnq7CZIweUqeqgFCAWClXxf7EJ9chtyIx+Kw86j1ruCUR27RQc98AG3uCl2sN79nmAoeDN1PgAtp0Y+FRwjaI01/03EA/hj41vuZk3wK8YH6ZkRRTjQqesyK22OKOXSY9Xy5jk0643T05/KbfajpuwkCDSff45wKWFY3TKUHoLIYb4+vQRU4bR2bvkSAh3bDMbm4z4Ya/zydG+1qAjEARP6R/QpodDSjTNgSrCGJPmCKgdGYeGSjlL4nuoXm8ABcSZEMKYcPoBUB0V/0A+os/DMZLkREYKBBSd+GsWbjhiaJgf7sj/JXOsYFe+ucOKW8YoBiStBWuITW9lGbtxUTZOA8xvHr1CQ1eYHQGiSY1kKuNaYmZHFxvHAyD6EC0K7D71oJIjEuzy5X3O3Z/1T+to+pUC7G+FGLG+ms3OawNWK+w5T8/1XKVhRJX/l0yJiAY5Lxz6tbayYeC9LuEQZcIeWVDc5/Wi/6CXfT7gEhhp7B4VBoDaeYprotl2gFYMjGhQg0abt2W/UupUaJX4WYgDePk18gRlI5n6yOot4SFhgZFM3TdXdPzWa0qrzk8Falrl0RE1jUidyhmRMbT55uZWuzk67w9es9Lt/Jl2RTPE5Wxa+lzGA/NZ+5zI+P19ciAvhIXYQeRcR1PI3hbmxyOIx2weiwqXyefuVeHYfrXdBTkHTDz35qZ1lCaikLDsXSj228erJRsCwionHnADd6s8mHj6CB4CZyD5LVrvy4pm7dWIQve5o1SH82JVS5PlG57QJScmcHt5voifA==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PlxV99behzvQOquYhy24KZN5KuWQzZuj+RCTM1NbKOjr3nlCwNwS/uwgurzz9A2pd1CUD6J7cbu/UXNFy8f0XmPaytwAc8fayrdJjELk/rpVCsBQaF1LMPxrg/njzWES79Fc8s0IgEiucfmJXj7vjG02lBFmEt8Vfn42IA/pxix72SCuTi/90DArJnT/SizdA6OPWfv7YfGYEd7sz42BvijmAuDBaZJCSyg32Y9X9gdbzs4flEpOwSBnkgL9QAm/+DLGSyQl7KXH1/QAq/f44QvXBAUA/xfI1ESDfTeN31pU6J0zU3+ZSCnDntzLM1V6ANL6hGMaWhS7DtHueAL0oVu+eMmnkym3p7/ncb8NbyHH1fBMZXIaVzK+4yDYTpsFF+DJtDFJfWAhrxOo5rQodlegU4uAE46h/qs27snHorhFEEO3DWvCv2t5CKx9FfeO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 10:57:25.2172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c901524c-dd05-4cf2-5c26-08de9addc73c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8783
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Introduce a GPtrArray in VirtMachineState to track all SMMUv3 devices
created on the virt machine, and use it when building the IORT table
instead of relying on object_child_foreach_recursive() walks of the
object tree.

This avoids recursive object traversal and provides a foundation for
subsequent patches that need direct access to SMMUv3 instances for
CMDQV-related handling.

No functional change. No bios-tables qtest failures observed.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 include/hw/arm/virt.h    |  1 +
 hw/arm/virt-acpi-build.c | 70 ++++++++++++++++++----------------------
 hw/arm/virt.c            |  3 ++
 3 files changed, 35 insertions(+), 39 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 5fcbd1c76f..a840a97de8 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -187,6 +187,7 @@ struct VirtMachineState {
     MemoryRegion *sysmem;
     MemoryRegion *secure_sysmem;
     bool pci_preserve_config;
+    GPtrArray *smmuv3_devices;
 };
 
 #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 591cfc993c..521443de87 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -385,49 +385,41 @@ static int smmuv3_dev_idmap_compare(gconstpointer a, gconstpointer b)
     return map_a->input_base - map_b->input_base;
 }
 
-static int iort_smmuv3_devices(Object *obj, void *opaque)
-{
-    VirtMachineState *vms = VIRT_MACHINE(qdev_get_machine());
-    AcpiIortSMMUv3Dev sdev = {0};
-    GArray *sdev_blob = opaque;
-    AcpiIortIdMapping idmap;
-    PlatformBusDevice *pbus;
-    int min_bus, max_bus;
-    SysBusDevice *sbdev;
-    PCIBus *bus;
-
-    if (!object_dynamic_cast(obj, TYPE_ARM_SMMUV3)) {
-        return 0;
-    }
-
-    bus = PCI_BUS(object_property_get_link(obj, "primary-bus", &error_abort));
-    sdev.accel = object_property_get_bool(obj, "accel", &error_abort);
-    sdev.ats = smmuv3_ats_enabled(ARM_SMMUV3(obj));
-    pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
-    sbdev = SYS_BUS_DEVICE(obj);
-    sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
-    sdev.base += vms->memmap[VIRT_PLATFORM_BUS].base;
-    sdev.irq = platform_bus_get_irqn(pbus, sbdev, 0);
-    sdev.irq += vms->irqmap[VIRT_PLATFORM_BUS];
-    sdev.irq += ARM_SPI_BASE;
-
-    pci_bus_range(bus, &min_bus, &max_bus);
-    sdev.rc_smmu_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
-    idmap.input_base = min_bus << 8,
-    idmap.id_count = (max_bus - min_bus + 1) << 8,
-    g_array_append_val(sdev.rc_smmu_idmaps, idmap);
-    g_array_append_val(sdev_blob, sdev);
-    return 0;
-}
-
 /*
  * Populate the struct AcpiIortSMMUv3Dev for all SMMUv3 devices and
  * return the total number of idmaps.
  */
-static int populate_smmuv3_dev(GArray *sdev_blob)
+static int populate_smmuv3_dev(VirtMachineState *vms, GArray *sdev_blob)
 {
-    object_child_foreach_recursive(object_get_root(),
-                                   iort_smmuv3_devices, sdev_blob);
+    for (int i = 0; i < vms->smmuv3_devices->len; i++) {
+        Object *obj = OBJECT(g_ptr_array_index(vms->smmuv3_devices, i));
+        AcpiIortSMMUv3Dev sdev = {0};
+        AcpiIortIdMapping idmap;
+        PlatformBusDevice *pbus;
+        int min_bus, max_bus;
+        SysBusDevice *sbdev;
+        PCIBus *bus;
+
+        bus = PCI_BUS(object_property_get_link(obj, "primary-bus",
+                                               &error_abort));
+        sdev.accel = object_property_get_bool(obj, "accel", &error_abort);
+        sdev.ats = smmuv3_ats_enabled(ARM_SMMUV3(obj));
+        pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
+        sbdev = SYS_BUS_DEVICE(obj);
+        sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
+        sdev.base += vms->memmap[VIRT_PLATFORM_BUS].base;
+        sdev.irq = platform_bus_get_irqn(pbus, sbdev, 0);
+        sdev.irq += vms->irqmap[VIRT_PLATFORM_BUS];
+        sdev.irq += ARM_SPI_BASE;
+
+        pci_bus_range(bus, &min_bus, &max_bus);
+        sdev.rc_smmu_idmaps = g_array_new(false, true,
+                                          sizeof(AcpiIortIdMapping));
+        idmap.input_base = min_bus << 8;
+        idmap.id_count = (max_bus - min_bus + 1) << 8;
+        g_array_append_val(sdev.rc_smmu_idmaps, idmap);
+        g_array_append_val(sdev_blob, sdev);
+    }
     /* Sort the smmuv3 devices(if any) by smmu idmap input_base */
     g_array_sort(sdev_blob, smmuv3_dev_idmap_compare);
     /*
@@ -561,7 +553,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     if (vms->legacy_smmuv3_present) {
         rc_smmu_idmaps_len = populate_smmuv3_legacy_dev(smmuv3_devs);
     } else {
-        rc_smmu_idmaps_len = populate_smmuv3_dev(smmuv3_devs);
+        rc_smmu_idmaps_len = populate_smmuv3_dev(vms, smmuv3_devs);
     }
 
     num_smmus = smmuv3_devs->len;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ec0d8475ca..68464ceb14 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3261,6 +3261,7 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
             }
 
             create_smmuv3_dev_dtb(vms, dev, bus, errp);
+            g_ptr_array_add(vms->smmuv3_devices, dev);
         }
     }
 
@@ -3697,6 +3698,8 @@ static void virt_instance_init(Object *obj)
     vms->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
     vms->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
     cxl_machine_init(obj, &vms->cxl_devices_state);
+
+    vms->smmuv3_devices = g_ptr_array_new_with_free_func(NULL);
 }
 
 static const TypeInfo virt_machine_info = {
-- 
2.43.0


