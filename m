Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BC6CD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWudJ-00081s-Vy; Tue, 09 Jun 2026 07:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWucV-0006TR-Gi; Tue, 09 Jun 2026 07:27:53 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWucT-0002zz-M6; Tue, 09 Jun 2026 07:27:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZwJwC5Cbk7E98W/IIRz/shBVJa+rwox1mQFQrwzP6ZxZu5KbxvpvJ30nLsD+Dftww2jQBvA6U9npU6wM+J61IxkeGaHhOpMJHPFxh3WRa1IBDOuQygNDAjhx9PWMNT6ifrgF3GslKvIlwQi9u/ewYdz3VA5ou0L3nIANElAvcbB4esQm8INoE4ksC3a3rQ1jtpldQWV99u3qJRS/OFbsVKc6QtXzn72aL7j4I0utbDfNHly4AS7Gb7GMFbuuUaBSV/FELyfCy/U74trX/A0A4rk+aaMu/d9jOC6OJa+r/tsXIptz5pT7nA8v+7424Bj9NMC6bj/OTNEXni1ORDYjqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k80w7UQyoMv64vWvVDlxwFl3VRXy5l4b42l02kfSCro=;
 b=dYIKhSDxGYQzEiUFd1B5GHICH4oQ6ou55deFsd4ipYNRf1MmK1ozHDGDComFpHONefzbM6Vm4KtRWhjYf0/4vSpv6EBcqnJOVa1SQAfpK4xmeuzNpuAkcDt2JZxl84FDvjyrQrv7aroafbhqibFi3bz6uuDf6fpyJnyWc0sTZ8+4ljTWUaa8toiDC3cnlg4lS1pzTEKvDmsuBlXuYNajk/YtOXh6/fzP7Lb9di7/uMZwuxoB6f/oZqdfwVVPSo1vWiXfpMr2gSoHQG68HOv75HPuhujt4Q1G5pM4QFNKhM8fJu/BSXfur+1OqP2suL2OP4HOiECAKseahefSagFaaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k80w7UQyoMv64vWvVDlxwFl3VRXy5l4b42l02kfSCro=;
 b=aNp2cm1F/PTYITR3o2A7Dfek/DJawLYbtY7I+BVQSfrcT9zCmXPzK2Pzj9zej/nS7k9tR1SLFUrSgv7U1J0XNLOkqB6bsFQQ+whXpNSdPWnW00ynsSSawlrcPllcXR8FNg+alG04Hou8PDhxP50aEyRWS4fWdvYrn101PFCsHanfV6XfSDcZoYjf1/KAn2EDEGLtbbesBh/xYmQ0eOhWSAV+ZNn1HgQo88ZOpeUt7zv/kldbPoWqZNdnq5GjPi4XA294/sM11KsRvSgonzr/Zx+ApsE6rwZJNIKNtOXBMfEG0bRkY4pK7mxspiNZ7oThhL4HHel0GnYpYBO5xRTCRw==
Received: from BYAPR21CA0009.namprd21.prod.outlook.com (2603:10b6:a03:114::19)
 by BY5PR12MB4244.namprd12.prod.outlook.com (2603:10b6:a03:204::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 11:27:33 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:114:cafe::6b) by BYAPR21CA0009.outlook.office365.com
 (2603:10b6:a03:114::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 11:27:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 11:27:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:27:15 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:27:11 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v7 09/31] hw/arm/virt: Use stored SMMUv3 device list for IORT
 build
Date: Tue, 9 Jun 2026 12:25:30 +0100
Message-ID: <20260609112552.378999-10-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609112552.378999-1-skolothumtho@nvidia.com>
References: <20260609112552.378999-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|BY5PR12MB4244:EE_
X-MS-Office365-Filtering-Correlation-Id: ecbc13f8-39cb-4227-fefc-08dec61a195a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: zOTKUbOLuWkcSACriUh9tejiY6u61Vzo3XbjM+DeKFan+mEqKYa26iLbZqmd1QBxk/rtYcAR7daGS2dsiJFLRjxonK1T/sk3HFT3uM4nemJ87s8zJnfO61ZItc/GxG8Nuza2agA2LaDrhGan8GZaB9qUxzmLf1kidjmsUsZ0hiAfjaqt7KsBMA1OytmmzdDG9Iof78VcRHF/3aYvtYGE1sQ7mz4vDggY+mav6IJcIVXe71WjTXsEs7Ek9aPE9mIL+oR1k8qo648IbNWaSItlRLTwEwnSdPGVzwG+AUZEgpBOwUCls2Y9HwLoG0zTXDoJ24NzrjSJPJTOfVDuYydQjSS6Z/FXgkHRpZRTKRVdWwEB1UDo8eRbOwvbR6V1nnscTL52Fa9l6BpmVes3ztP4TCOmJjzzK6T/TLRIUot7N0kJ0SKW7H+8RxMHX3ZGHxmRVh1zIbdZNFiJtWIRJ+0J9yXUmPgBd4TZ0Se2WBaPo0QaY0btFGYeIZXBpjNxDkzcDCzGn9DSqA89qfSQ8y3gb//yfBxK+CwHJx9paHFik4uvXtw9ACoESFzT+cJ+NU4lJy7UBZM6NT5sjGofLN8w3GOXYQQk3NZ/JNosjUQCrY1nB3tU88OHMM4RmCf6jpzWgKLmzi/0zzDgbGEcEnoEi2/4qhIE3V5+QtEryPcK2uRV/4vuz/vtrk9+Esa7cOHBf43biaQCLIMuFUgcXrhjbudxf3ndzxPVRCQlbb9VtTM=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JHwaMj5KPkcCGDvQRUD5hiq2yOEJLZNJNNOxUjXEOoj5X9N4Tn6vF3VMzXR0YU7rVhXmxbiUz+tKpVYi8CrgdJO8GM69GgNWtk27nzRZlq8mjngo75WqMtnFodv/JI8GKXcA/ied73ex/remBKh56+O66dpaNkEXDIWIj7xd6erD2hMQw85qdJgLRW4STW/u7bFdOH4Vd91lYVDqx/Qe/N0mXCxkL3zPywWFeaGHTZnRIEoz21YTMEGqc+NmWlYQa64mG21OOya8UNk4o4v3dLpASaaOtoPs7iXuRAgr3ktl8kg57XGmxKS1o6YpboQOvKHhqA+kGqkGnxX9Q2Ua6dI1iSAHdmD1hyipjiulXxembtveSeJfgsmdnljK6dzPgtf8EMXW/lQwtZuQ4qX3gqmGSrpOt9kq64sAJwwcS6DkIfMrPjGJP+5L6vW4o+vX
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 11:27:32.8423 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecbc13f8-39cb-4227-fefc-08dec61a195a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4244
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
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


