Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C0E4CD4F57
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:41:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHrD-0008GB-Oo; Tue, 19 May 2026 06:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHr5-0008As-M9; Tue, 19 May 2026 06:39:19 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHr3-0006Ry-LK; Tue, 19 May 2026 06:39:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gz+ooDksxBdaUms/i9fQdIMA8fwMJBz6LmjAyH98ykdYdc+kd/x79M8b3/tkPQVR/2kt3mPQpFj3VKk/XSWckrtT76mcZyJ0pAAywg6UGvr7Gpf9e0yAFIb2EB8cQ/shd2jjTW0mF0SaAlRApLbxSgaVE8ELMaAOnlPAefuErjx8NAMDv3ALswS/A8P3Ly+1xMKYDksHCuKMnv/AQYt62zQva33HdCEOGrjIKy9mYcED6PAzBUhfATIhkvFhYQHah6h+VH+09SQPigajr5oOwU6azW/+GhDY8HMQIfVsnPhuvbQMxOb/mhMusd/Ct4r69TvHfKoz7it1d0Mzm6vFIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IH4u9PW9lnocK+hhANt40X30OtDZmInB9Pr5onX109A=;
 b=thCixS7PyDhRrTcxUIwAjxjkohhm3wZ18k6N+i60q2gV5Ab+IqyAgcd2ZaQE1Nl6fLUbnvHVQUj6vq+zvjYyPliDvEfnlMCbp874pNz+cNQ5QPG8fWZu+HEeQ/TIwg7SRwTueoLa6p8iVvJExJ59AzsGW4BIZ+pTqMNFUkG46mry0C5Pte5Uw9hfzKenk4cytFIS0Cn1lb6e1Th7h4Wm1zVENeoIm8UFXqs17LosAe7fMN98kiJwT6SLghpGEAV7qwxRV50grIVwbVsd8WiCWihC4sIa9oy3RBX1Z2Cp5VqQZZmeHj1V94Irr9x9ZXT+Rb/k1/YzF7TuvYvlSOL3gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IH4u9PW9lnocK+hhANt40X30OtDZmInB9Pr5onX109A=;
 b=ceUW5+zjGmNAF+51g8k0Jcpd7IwrEL8rrP7xvU5fuLhfBiJNV3df/2EYmWTkT2TMA86iZUGSzW6hK/SrlWrG7ZDDnIxfnzHPuRI7/YvJR5CUe9bcruAv/fongMZz2mTS8zzCuReO3j4mnRkSf5pJ2zb7IeB/AIhGN0Pd3InVkZJu0bGbTJEtZss5MZqyyuNZu/xVSt1qkCV0ILuINx3hB0eQuttIJGn8oTHjBDunENiHOcUT3hIZkhdavk/iQxjcTW9rHBjjDPGzjN8kCVU4HswVzaCydoJGItqLi555dTR6zrKy9nP4G8Ws0dwlRIP2+omYxPg4DmCB3fmJi3RJQA==
Received: from PH8PR07CA0048.namprd07.prod.outlook.com (2603:10b6:510:2cf::19)
 by SA5PPFB9BA66B77.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8df) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 19 May
 2026 10:39:09 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::77) by PH8PR07CA0048.outlook.office365.com
 (2603:10b6:510:2cf::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 10:39:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 10:39:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:38:50 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:38:47 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v5 09/32] hw/arm/virt: Use stored SMMUv3 device list for IORT
 build
Date: Tue, 19 May 2026 11:36:47 +0100
Message-ID: <20260519103727.899332-10-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519103727.899332-1-skolothumtho@nvidia.com>
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|SA5PPFB9BA66B77:EE_
X-MS-Office365-Filtering-Correlation-Id: 613ee3b5-5a64-437c-cee9-08deb592dbdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|11063799006|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: uyUJgsmoq8V8JINr8yAX02kEF7ICTXWBHYI2Q8BRz7vcbvcpfsCs0asI8U/zW+sr6slwoIHTYP+WkrN/OT9bcmcDntdjPBUlyPIo5i8ALM+ZJFCU0EefBQnWetIYAiSxNJ61/yE7qwECIS9W4mC7APHqGITksk6L9v8EG1COV4NnaoROWA7C1t7x7KCZUzqfmGOpu26QMHa9nKEUn2JhWqlSL8Pk8zvBC1Y5zQk8YHHHqeXqLij4dNVg2wV2MspE/vW+BuKoT7yKLBWsbY7cXUKW2yU8QdyqJP3h8FXO0/qkYq9fQkTIfnkq9U3Vmc7PL/MpQgoxiYnjDY3VXTbJklWo7Mt82NLdssxR2QP8rNr/lk2ye4t6EHpukWz/8YF2WC9w0qtDSMLbQnrBjlvCMISQHnhJx3g4v5b6/j4xBUSqBskH/anQZaE9gj43LSOS7SfYEEoNNcdQfiTbmd/EqK9UYf4EjmzW5s9DXK1wjmwykTIVFw26PkGFrpDZGn8vFz3pkotGYWvQjnaGwJc9YFtJWq0rULIB+sTmGysh15Cm7/CD+XYJ5uxGbfWQnxo4H6XmX0bEJIIiYAihZN73p6sFjwTVA1KuPdAxVGv+YDnxJAbIKfC1IS+rdlKiOcmYZLGe/WZivdYzB7ZbaS/UUk9GtXen4Im4JkJu/TbC3p/xbBM5LJh17AGya/Oc29qkX5RuZRYIA+NoG+wyfNbPNODemm+JmRWgaQJvdRa3h3A=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(11063799006)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jsw9KPpaFMT7iDRxJ/c6kQbCiR3RH81CunxdtUOUQB7mNAmy+k06dfg4rlVaNrpNoG6QNbRms11KIE05OXNS7j2nkIOmA9d2QOoKb/jZFvbtnmRk5nPqwBHPoiI/DuM60D2U9lCdkm06GqRbr6pTAZdFACk2yqi82VExgMBFlxpJcJzNx8exO8RtnqxGr26UP5WUvgAKbQ1Mz8AuuOVZ2NKR6hEHd65uB3W/t+cEfamnY+Ncx6vjRzNAwsDkGrE8HP5gnz7uGFqmKFelpVVAb5LkBnbkTqgl1ytLcncHNgf2mO75xOoFRlDeSUbDiib/xLLhz0Wtt0bBpkEbaJABYmAYVaB2rPaREs5yUZNWiGe82p5T8GkNS9WPKFJS8rvT6Zti9s/9egCRh8M1b8yI51B0uqW2dJWCvsQSvi/Suz00OjtMEETMhi4FYgbidVEy
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:39:09.0110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 613ee3b5-5a64-437c-cee9-08deb592dbdd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFB9BA66B77
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


