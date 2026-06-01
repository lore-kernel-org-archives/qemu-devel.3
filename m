Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AAFDCD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:49:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU18k-0004j9-14; Mon, 01 Jun 2026 07:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU18e-0004cr-GF; Mon, 01 Jun 2026 07:49:01 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU18Z-0004ww-Tc; Mon, 01 Jun 2026 07:48:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CL05cNBiiZB+wwlC+pDl3zlpF60hZu9W4S43t2vQtVNsxkAcwt3gfnzEDSyM8aytuor7kp+Pc64eA4LtFVl8XXGvQX8izFhW7OnrSp+Ck/PKngclB0pX9Dmsn1lg7xjUCnVcNy0xh42hrJJetmr5WwOEf02QJomOgx1WmMAAtZo4psRoZzBpEP1WMCaceqBlimTRrzcx9X6LxegDqCSmsQ3OJVrEeG0p4+b9bFBV8aeQtP84V1xbFC2KWOqHjjJQyL2TsFgQ4WGJXl8sc9sWdtcn4rdFRobUH5hLsm3I9xswyKjl0ubSJ16C+ZIl7zgC5Cl1CBqn51jEctGDsgCj9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IH4u9PW9lnocK+hhANt40X30OtDZmInB9Pr5onX109A=;
 b=f8L8xyAKOdjNgR2ISdiwAsd2I0dgGjoCxuXW1Od/h9g8xF2j3fWbzXn3Sx2D0DYPQz5trWy0AAaK6Imx4h6ReAt76cOr7bTp8RWZH/5D+W1gJ624j7V89+vFEeI+IiaL51aWaHIeOVKAN69w/yY+RhQ2Z4o8mAyEcQeX4pWWV7rq3H9MpV524lmnWa4MHzNvom0OfoqdA+rBnoVfuPvK9BmCTSqLJR+6YROhwZHtyM5LMs/XCgQsghmwI0QOSLtXgv75n/RRMpcHJJMzdSVzE9plP91asAbFS2QoQ4aDwafxpyZZAW6X5GXx6CGPj4nafjON5hhMdZiNTYhCsD8UCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IH4u9PW9lnocK+hhANt40X30OtDZmInB9Pr5onX109A=;
 b=Uwx1j8FF1RuXn9wuVYHEjVIk+wDtH8BWak8o1/HFBMmswSH0HKVRL/7gYW8wAKDHjbQ638tR+Jt2je9JBKEXyaTUYXvf9JB0ZupBJXZiE0Tw/2d9KBUuE9dQZvPl1Oc3u0r5LsDOv7G2hNL3XrzEZFKwhgkEWwimoFk8SrixkoucPiGZIRDGQfxJDiw4nrVtXpMTvYOTXxSjDq4z71Oq+aHblG0ojLBPocTAK0TT1jYK7aaeWWN/YXhFMjzX4YyvDYJB4kZyVnc0N+w8kYvh8p10Zy+gikFx8lq39ya8hjb86pSwyssmhkxFFEBU11bpDcWtx5DeL44i07rNAXZpzg==
Received: from BN9PR03CA0856.namprd03.prod.outlook.com (2603:10b6:408:13d::21)
 by IA1PR12MB9499.namprd12.prod.outlook.com (2603:10b6:208:595::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 11:48:50 +0000
Received: from BN2PEPF000055E0.namprd21.prod.outlook.com
 (2603:10b6:408:13d:cafe::5f) by BN9PR03CA0856.outlook.office365.com
 (2603:10b6:408:13d::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Mon, 1
 Jun 2026 11:48:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055E0.mail.protection.outlook.com (10.167.245.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Mon, 1 Jun 2026 11:48:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:48:37 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:48:33 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v6 09/31] hw/arm/virt: Use stored SMMUv3 device list for IORT
 build
Date: Mon, 1 Jun 2026 12:41:59 +0100
Message-ID: <20260601114221.457995-10-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601114221.457995-1-skolothumtho@nvidia.com>
References: <20260601114221.457995-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E0:EE_|IA1PR12MB9499:EE_
X-MS-Office365-Filtering-Correlation-Id: e0f3dec0-0a33-4874-08f2-08debfd3bf6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 7PmMdU2f2n2uhcJekl8wgKhk0wOCJQyf1aq7xcSLGRDmHEto1rtZyhTcQkmntBqT0UxwTsyZa3xYjajYqAZRfewglGPkNZQvXJYTr0BxOJdiGlV5zuddpXg5Bqv2HKs0QktYuFYIx4x4j8hpnISm//JcCW+qO3dN4jAmt5RgI/0BClroFc8SWRVP/zMRniUPlBKG+uLshgWb2Ugf//63lPTdcvbxoS/tXeh/7M+q3gWUBNBQWrpe88dYFXBDhxai3Bd4Dk7uDdx8TO/r1UTtg5wr7WvnTSp6iDAjQ5T7wHm6yw+y5hqsXuNPib8f1SMCSBuM5f9Paxr2HE2lNQna1CEjcdqYuLdw4x8hOcK2NxG0xuC67o6uoDcz8IMddJ2j9xiQuYId2i5ZfgaT2EZ8WZLKkp9XyGCPvOUMvLnzH5VJ62yOIhdVgcwkwoW8bpKg7IxsXcp9MUwFaeWWQBnqrLijPtwzr/Dc5E704wiavKh6IFE12MK0WNx+y0nnvkz68ULXSIRzfF3YPeLqeTKCgvBBhZ8RrbfcZ2quepl8ufqo5k2p8ZNst2bL+0xh9yQ2Vb4D25xRSjI3xGDpL9YEDkceNbnlVsDH0EaSEPnywIos6MImG+HDeaLMY7oe/JtN8Skj9RmTA3VgTws/yyvyGjuCOtKGTO1t5kfeSVH7EvOszzMPVchYzGREAkvIfDrForx7BuWNWsU5H2PlZBpQ/Fth/zU5VhtfM21TObRBp0U=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: y2rlixSzJRGqr5f7mxKTW95y4Hf+oHtc0oFA/f2g1ZHOdjwTjNBhf28pvnkUFkILNB27vnz7Qnri3D6m69/DWgNrCryY2pUx4Yf59N7oNrIqIEEvz+WY+M9E3RN4QW1wFLhmRQfhYRFbJxLBUz6mc5GoIXYRlk3PXz6Ejso9OTmmsSAsGdW7B2iKHv10Di46ho9bgjsdB3EsIbb3LI0AoCm05K7zEQep/jGclkmv1AWJr25Hq6fpcP2KV6LypxIcW1YotlP1/TO9y0JJksPsgL7jTDEga08sKKlfUQKXdlGQ1NnRotG0hF8Uf5r6uq+UqVAId+lvoFUSZnxz+k1NF7zcIHFA+5gwVVu+FGyYNuyWOfyv4SJlACrCEfg9PLl8V8Puf0S2cpQldQVLocVf+JUOIryyOuP9D8ZoWea6O4S5QrNNaE1BA3UIA8Uhbsq/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 11:48:50.2136 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f3dec0-0a33-4874-08f2-08debfd3bf6f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9499
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 include/hw/arm/virt.h    |  1 +
 hw/arm/virt-acpi-build.c | 70 ++++++++++++++++++----------------------
 hw/arm/virt.c            |  3 ++
 3 files changed, 35 insertions(+), 39 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 3ba33b4bd2..171d44c644 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -207,6 +207,7 @@ struct VirtMachineState {
     MemoryRegion *sysmem;
     MemoryRegion *secure_sysmem;
     bool pci_preserve_config;
+    GPtrArray *smmuv3_devices;
 };
 
 #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 3f285ff6c7..b00f3477ca 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -392,49 +392,41 @@ static int smmuv3_dev_idmap_compare(gconstpointer a, gconstpointer b)
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
@@ -568,7 +560,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     if (vms->legacy_smmuv3_present) {
         rc_smmu_idmaps_len = populate_smmuv3_legacy_dev(smmuv3_devs);
     } else {
-        rc_smmu_idmaps_len = populate_smmuv3_dev(smmuv3_devs);
+        rc_smmu_idmaps_len = populate_smmuv3_dev(vms, smmuv3_devs);
     }
 
     num_smmus = smmuv3_devs->len;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b090233893..ac0606fe87 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3865,6 +3865,7 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
             }
 
             create_smmuv3_dev_dtb(vms, dev, bus, errp);
+            g_ptr_array_add(vms->smmuv3_devices, dev);
         }
     }
 
@@ -4319,6 +4320,8 @@ static void virt_instance_init(Object *obj)
     vms->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
     vms->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
     cxl_machine_init(obj, &vms->cxl_devices_state);
+
+    vms->smmuv3_devices = g_ptr_array_new_with_free_func(NULL);
 }
 
 static void virt_instance_finalize(Object *obj)
-- 
2.43.0


