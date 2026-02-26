Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB745FC5928
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvYyp-0004KU-7h; Thu, 26 Feb 2026 05:52:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYyo-0004Jo-3D; Thu, 26 Feb 2026 05:52:26 -0500
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYym-0000kD-Gg; Thu, 26 Feb 2026 05:52:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cf8saBvMnf5k3QqMTu28fMQOIcpyTT4czSfPBXAkc14oXLOBBZqJZ7McjJMmiJMV9K4UKblxQWVrkMTCL5JAM71Fs9qYifdj0HKtuIFgb6BdcaWJSl/82E8nHMOZsSw5mWdrcaYBuYLhd0In+Xwof/++g4Ev4RgF6onkBSD3Dy1HwSlAsuj/A4A/I5q+v7/+TZ+gyvIhuGOOMNaJkYR3orjysAULOUoaQxKcC4A7GbbThzdZIN1auZCBWQ+k9atUzNwk2wbDNLtx8WmmVnRSBxMcqYUAWxZZcNo9SVdR4KxdAneq/rez3A+b7Xk9xHnyhdmziEKA6EkbZf7F3D9Aqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMfvPe8+EXJP/qfD/3eMNEOfmzgMjT4VxgjP4q9/Fjc=;
 b=ofhGOQ7zzQISERns/ce3HawQNmSG+5nWlk1C4Mqmal4ga4eRaMVHdDNyS00muzMWRc5IDlEA9+04DDiQ/0ClF2nyrjje4+I0MYaSN0wwd7gsmB+kybiV0mE84ioiOY+QkavKtZnxlIvs/0mO8f2hOluQvW1NzmE6i0OoLPr8QuaHiHNb6mVQe8J3vq/NFdW3xN1AC68bZqtIFs9+jI7PDUI6IEFRFlSqIlL+SZH4QKLM/q0CJEHKpxns8PiA98MPmtYlSEVhgiioQLCxjjpGSY/ofkXlPg5THG1Q9B++OrgYkUGIi09YwNwkzgS9xrEKVkD8FXE3vXDzY1Kx1fuiXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMfvPe8+EXJP/qfD/3eMNEOfmzgMjT4VxgjP4q9/Fjc=;
 b=c105DCGfgJhgc23OZmVgOIBtQo9+rYwGPgq691uq7/UwoRGhO9JNbF1bxtSa2lLfOiEYKY3RZMtSAJ/s2Ly+FpaQYhjEcEqcx/+DfDKDHtvEY+TwYx5KyJROKTi61X6t/jLQzkF813ZWwnQiDrnKuRC4cbmIU3TmPdj1qdR0cPqtF1BENELJYNmukHr8zCw0Gix2O2UlxfMnm6ZYB2Rmbx1UgFop+8L+BxbBcd+NDbGI/Px4vQNMSPPLoD85S3qapwgRz+5Jb9hA+iHfFPLDbev1AJDAxHRMG6UEfTgC3ANseeVinnd7iNJGCk47a1YlPfNaz+kP2ueG2E5Nvh1weA==
Received: from DS7PR03CA0058.namprd03.prod.outlook.com (2603:10b6:5:3b5::33)
 by CH3PR12MB8902.namprd12.prod.outlook.com (2603:10b6:610:17d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 10:52:14 +0000
Received: from DM2PEPF00003FC3.namprd04.prod.outlook.com
 (2603:10b6:5:3b5:cafe::fe) by DS7PR03CA0058.outlook.office365.com
 (2603:10b6:5:3b5::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Thu,
 26 Feb 2026 10:52:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM2PEPF00003FC3.mail.protection.outlook.com (10.167.23.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 10:52:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:51:59 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:51:56 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v3 09/32] hw/arm/virt-acpi-build: Use stored SMMUv3 devices
 for IORT build
Date: Thu, 26 Feb 2026 10:50:33 +0000
Message-ID: <20260226105056.897-10-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226105056.897-1-skolothumtho@nvidia.com>
References: <20260226105056.897-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC3:EE_|CH3PR12MB8902:EE_
X-MS-Office365-Filtering-Correlation-Id: 11b10a4f-857e-4635-7eb3-08de752519df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: AOdL6mEPn76iQ7D6ug8uB5F5KP2rg96NPlhmt5dYiyqALsTU6dTfRSU98yX2b+bVT1pRyvB+6s/cdbzNaTJA6l/GVinOzu6L7MAEXePqGOmPUpeKi9XSEYYuMHwnA0ub2PA6MWh8J4iBg1+WiKmhHpiPyXvTd5rHE4My4VFR1uyqAh8gImavGZxnO1/00DabXB/MM+tXUeMVQCIl1yMfPDf6YhQld636f8OgAwtm5Vli7Ye8jHSVl5BOS17gNYGG8DRGCG+rqvEFWqzSTqWdZrDegnpiqblbFvwSgerge+TpZu3vy86IQgh4hO/vqsLIzaQ/JOU5sT7gp+YXP9n83jIKmnR1cqUiMWvySSdidmudeceEIPsrT4i2tsdntJS6o1zH311M2lzf+hCsAz55CD/wAQ4kEtMP3fsRfvi8YSPe13y18VbSUaWHo32KpaVpLyRWKGeWFlDHOiwkc4VNygsywYVy/9CHplbCoUEKMP+KCcNBxiD7sAzzCGCap1YLh+NOjEQNyuuaMVha2g4zNz3n9hkWnQA2yUVY3tbdi/kSIlB761/OujOicOni3MxPsywsRgwMSe2JKsDbhhIL+f1C0+ntO1NXAFOOJBFZHsuT4IiqfiZE9N3RNaY6snWW4x7pa3p79VdsmzBAz+fwP7a38zWXyL2xyU4xx16Qmo0YcODxXqFs44B0kSCckK1eEctkcMHEMR7KE/fk/lQbot2KrvBs6iPUMhgxkd9jbgd3JhBEuSF4vCfvRLkypKEHF9lywNDpo5jnsOYZAqabWUchkE3v1psWQJu2Zd3s2iKQ2QO1F4AI5sYcrXhb8b+BY9RewKMWHPslm0wTnifp1A==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: R7Vu62Rha+rW6dqkHMd47qx/6NNgfChppmUhvGB/ddJ/gzDQAvA36sBUVgc3wsVxK2EmS5NFT7Az/bNncJGJ/l92Sga6s1L7llSaFn+BMfdRCU+Rb+idcxk03iHw25Zl2OZwvV0M0E+zeCBKmVm4OJAxC4g5k0YB5szLEVPsDATSpnDv53vRVfTST3rDz/BAzzYynmUXzQgNL28qEv26H12Ilt5L0bMgdXUyv7zjr4QCowr4oMty4Q7Ce6XZBtZmUw2C0F+zP0QD9Hadv0CHcKdSQCni9N8dTGgenUeOjTJ4/N9LDLBLXzurnsYnw7tHryScijQpn2qV5AxOAgIl4Ncc5z6P8A7EssnrDNaVMCZU8cE9GxKy/yZQlV0YlhYNJTGZpQNu4tjjsCdJdZkFIw+9iCW5IOr+kKA57VvvHZNnccWOC1fQ05iHoCqPkZbG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 10:52:13.8661 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b10a4f-857e-4635-7eb3-08de752519df
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8902
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Stop walking the object tree to discover SMMUv3 devices when building
the IORT table.

Use the SMMUv3 device array maintained by the virt machine instead,
avoiding recursive object traversal.

No functional change intended.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/virt-acpi-build.c | 70 ++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 39 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 544004615d..ae78e9b9e0 100644
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
-    sdev.ats = object_property_get_bool(obj, "ats", &error_abort);
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
+static int populate_smmuv3_dev(GArray *sdev_blob, VirtMachineState *vms)
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
+        sdev.ats = object_property_get_bool(obj, "ats", &error_abort);
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
+        rc_smmu_idmaps_len = populate_smmuv3_dev(smmuv3_devs, vms);
     }
 
     num_smmus = smmuv3_devs->len;
-- 
2.43.0


