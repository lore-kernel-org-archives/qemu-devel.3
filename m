Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C00C44508
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 17:58:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vicTJ-00084e-T3; Wed, 21 Jan 2026 12:58:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicT3-0007Z7-1t; Wed, 21 Jan 2026 12:58:11 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicSw-00029A-T1; Wed, 21 Jan 2026 12:58:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KXZq5Sr20F0cVfnkO4bc/iLJvmHjfBzULSTO/vf7OSzEElHuieh9KcgnQTEiFY4kBDneLG4tgiPSEAoVSIn/J1MrqytiXCUxz5Eajxug1QKHaTL2TQLbgoVb4rXZEr8Ft2xHPVVh+8QXcjBbAzgXyoy4G3GHWXn7nl8YVa8e2qtTk5SK6PFMHYLUSslktXqFJdFBpBrA/NfiuQVvfMBcyykpWRWYBKHswFsBcbIsSDlyZJ93CJnAjiOzRrrawXNmJt5jm5E1VeSGHE3OEKiw/FAh9BDBMTyKJzdg9OgP9W9JxLHZBSa5d2twoxgbsUvt3zTjEfpbbybG3oRFi7GeYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6l/Kmst0gcUNnemNBH6kERu1ByNs74rUZ0mISGmMoyY=;
 b=bvv96OIncMMDAocPt+0cjB6jTTqVHoxLW4McbHSH9lRu8dIy+4HQtyI3kFFvEZzKH4sMiqzZ6jAurFwY84Q5qx+BcwwlWaM5FgPsMuEYZ9QQLQjKNpAY2Qt/BIS8G1fSlwwALAh0vTpIFcp1T+AthczIb2xgQXcVSlLWkjsUJD/g2C3baYPjBqjBUWrTTX1mvmpeRiSYzvkMdVj6f5Wh5O6RCcDgno7yKPIHQfLEMkYLFNbVRj3ESycxWmDVTlYVYujDg0apdHV94qQ7LJ6bro1UaCkpChrGqvn9wUSt/UQE5PeNr+p7C6gsGaawBssEw/kaQvYtg3N8kP1fd//hIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6l/Kmst0gcUNnemNBH6kERu1ByNs74rUZ0mISGmMoyY=;
 b=if0krppgluvq+l+H290pgVpfR0vPobN84F0zmr7UHJTpE21wPxZmWTcRYn+O1t9Mbchw6v3Rph1IkZKOC6XOp2CB1S84YfJWcRNwrW3rVmv1yOBm2hHXKUijGadkr065fIWtv0JGDeAl7N/2yZY4hvbSab/IIUp/hTI1V5XFqDpPVxAs5mGG6am4gccswhbE3l64UR1wIprr3r9Bvfx8hQPi8yd/kOglEQDJGFOqxMltL0nEjLHs0nul+15+2obZc2ZYeAueFwEJtlhYJGxFKU12LfI9FSLXLm+qzC0M3VJP83Vt1LyWA9DHi6GxpfynNzwekr7/g9uSJqvh4vOZsQ==
Received: from BN9PR03CA0956.namprd03.prod.outlook.com (2603:10b6:408:108::31)
 by LV5PR12MB9780.namprd12.prod.outlook.com (2603:10b6:408:304::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 17:57:56 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:408:108:cafe::a0) by BN9PR03CA0956.outlook.office365.com
 (2603:10b6:408:108::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.11 via Frontend Transport; Wed,
 21 Jan 2026 17:57:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.0 via Frontend Transport; Wed, 21 Jan 2026 17:57:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:57:32 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:57:27 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v8 28/37] hw/arm/smmuv3: Add accel property for SMMUv3 device
Date: Wed, 21 Jan 2026 17:52:33 +0000
Message-ID: <20260121175248.87649-29-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260121175248.87649-1-skolothumtho@nvidia.com>
References: <20260121175248.87649-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|LV5PR12MB9780:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b4b4d45-0718-45df-88ca-08de59169b85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H+Pp0Jwhf70IEaiKgW1Y9SpndxlXt61b9uDbsPKRKRyOZ3TZMicrMldrXSon?=
 =?us-ascii?Q?Tlzg6sIspc6e+KrUl8oCtsanoLxS556HugU8byiEFB0dvZ2+O0HqOJGbSA8s?=
 =?us-ascii?Q?p5JwS8dujZiemuQrnI5xmCA3hGnj2pQKmvNXuZrPh8OsYeiEVNXbKlkY5kiB?=
 =?us-ascii?Q?cOGOgw0ICmg9MyiPHr3zyN6KeUAOJ3Ua8Rnt9Tp6JsI6vtw693V2s38GfxYq?=
 =?us-ascii?Q?OqYJC+Fe7z8miGLHY6uvxEBXjQtcj++L3Ck7E/vcoS1Y2oR8VyUl3nueO+hh?=
 =?us-ascii?Q?at+wt04zhjMmeSZlT8H/rl3Vv4A5Q6fH2nCfOxvZWWaCmWdWqDTtsly1GWdU?=
 =?us-ascii?Q?JZRX//3kQ2BFsSfKG92pRjqvsPOuI4PwdYxpRRwnHjEKpNvjiOVGXpA0NFqV?=
 =?us-ascii?Q?uplceBJYzZnarNtFEXG3hnewpFlIIusjbLR/S7KyPmTO5LUAq/Pfgwcm32DO?=
 =?us-ascii?Q?rRA1mS3qpmO8eMwjIXbtJnp1KJ+l5F/bW/OcJZSgzLkQdm0Zk4BXGwiAMo7M?=
 =?us-ascii?Q?TBb44M5g/2gN1tPj5pW20nLjY7QiUWzOEQON0S6ld4K8q4SiMqt9Lx6SpyRC?=
 =?us-ascii?Q?CBIEHxdOTSfNhOstHDjgE/P4w02khO0we3QSeVxqkNoznPEiQA3E93OXYAbF?=
 =?us-ascii?Q?mrkp4+UOGv+U1YyYSmv7ll6VyqjZIrixdOXWsIni48rj6959if1T8O+/Am6G?=
 =?us-ascii?Q?z8PNCoFw+A9OHO56n75GruPf6Z+bg3bZUdRxsWjtHBhY/9VurUV9bFpRzqWd?=
 =?us-ascii?Q?T/0OcaE2f8Q8Akhuq+l6BxHu/LHgY8gQYhuyWy2lRNE6YA0yEii3BiIqTgYg?=
 =?us-ascii?Q?cNpxIWwUB+UijKokMFheAalhd8yqR0nvcfQ62aN7xkrKNr4ISCw30TOBO7oB?=
 =?us-ascii?Q?MgW8tQT42IGrdd+9WgdxFZxSzlKKhwQEaUXt82BbW+AVF4THf1knaQL0GC0v?=
 =?us-ascii?Q?8b8BSAWz7QzLomhhF7btbYTw0vRzIatdMfXT2kbc7/rZlLwsHS9aPy5il5AP?=
 =?us-ascii?Q?S807IbmFew0IhsqlYAwIe3RCtjarHUXXuJBbAD/fjbM/GCeY+OxE/2heGfDK?=
 =?us-ascii?Q?hwWjEYGKARpr+Eqe8VStGO0ra+Bp+GYEZ5oPzDrSWB5KLRgcoqXoNTV4TbI5?=
 =?us-ascii?Q?bTFeTZM4/d5L20GXQGO8PVJp8ued8I+czdYJ/2TiqZZOW2a8l4s93LKQqARz?=
 =?us-ascii?Q?EGMs4e1TxYOQgshC1vOiftOfmR2lvG8vLXR/jpKVJooSNqSr4c/B31ivcnvv?=
 =?us-ascii?Q?DIDBYhSIjOPAvdN8FCrff1bFCmheE1L0kOhk3VG7+tE8Qqk3VHQPXx4G5zcp?=
 =?us-ascii?Q?cpaeV5+9mzzjO5m911O8Pikea2Tik3q5g9gmk1KOTP+b6NVPoQtwUzESMpKz?=
 =?us-ascii?Q?bZQQUGgyunKFwfZRi4gAZmwmLrccdV7e7gRjTduRYhwjPbpyGuwT9mQ75+c2?=
 =?us-ascii?Q?5mtP1W40qZZa6aos/rjc6sNe7ua0zPJERYsVCdLcMMDCsXt8p/asgKXTui0l?=
 =?us-ascii?Q?HktRNhsP4gPdGy0XYBR9yGZVaRWnr3zQB+Cqq2tpKeA2fj7oJwK0/p1W19Kq?=
 =?us-ascii?Q?YgYgdizdwO948NsxxZOozJFcOcPvE2trgA8HoyU9RdQd3J3v2AN+49jpweG4?=
 =?us-ascii?Q?XRUZycDsbR6uYpFL0VWsSZ+AqAgIsU9+udAD8PPZUf+VWF6L7CEtPff/kNZX?=
 =?us-ascii?Q?kaKE4A=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:57:56.4625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4b4d45-0718-45df-88ca-08de59169b85
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9780
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

Add an "accel" property to enable SMMUv3 accelerator mode.

Accelerator mode relies on IORT RMR entries for MSI support and is
therefore not supported when booting with a device tree.

In this mode, the host SMMUv3 operates in nested translation
(Stage-1 + Stage-2), with the guest owning the Stage-1 page tables.
Expose only Stage-1 to the guest to ensure it uses the correct page
table format

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3.c          | 32 ++++++++++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c |  4 +---
 hw/arm/virt.c            | 22 +++++++++++++---------
 3 files changed, 46 insertions(+), 12 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 2be056d792..8ca1d4ad35 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1916,6 +1916,29 @@ static void smmu_reset_exit(Object *obj, ResetType type)
     smmuv3_accel_reset(s);
 }
 
+static bool smmu_validate_property(SMMUv3State *s, Error **errp)
+{
+#ifndef CONFIG_ARM_SMMUV3_ACCEL
+    if (s->accel) {
+        error_setg(errp, "accel=on support not compiled in");
+        return false;
+    }
+#endif
+
+    if (!s->accel) {
+        return true;
+    }
+
+    /* If no stage specified, SMMUv3 defaults to stage 1 */
+    if (s->stage && strcmp(s->stage, "1")) {
+        error_setg(errp,
+                   "Only stage1 is supported for SMMUv3 with accel=on");
+        return false;
+    }
+
+    return true;
+}
+
 static void smmu_realize(DeviceState *d, Error **errp)
 {
     SMMUState *sys = ARM_SMMU(d);
@@ -1924,6 +1947,10 @@ static void smmu_realize(DeviceState *d, Error **errp)
     SysBusDevice *dev = SYS_BUS_DEVICE(d);
     Error *local_err = NULL;
 
+    if (!smmu_validate_property(s, errp)) {
+        return;
+    }
+
     if (s->accel) {
         smmuv3_accel_init(s);
         error_setg(&s->migration_blocker, "Migration not supported with SMMUv3 "
@@ -2029,6 +2056,7 @@ static const Property smmuv3_properties[] = {
      * Defaults to stage 1
      */
     DEFINE_PROP_STRING("stage", SMMUv3State, stage),
+    DEFINE_PROP_BOOL("accel", SMMUv3State, accel, false),
     /* GPA of MSI doorbell, for SMMUv3 accel use. */
     DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
 };
@@ -2052,6 +2080,10 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
     device_class_set_props(dc, smmuv3_properties);
     dc->hotpluggable = false;
     dc->user_creatable = true;
+
+    object_class_property_set_description(klass, "accel",
+        "Enable SMMUv3 accelerator support. Allows host SMMUv3 to be "
+        "configured in nested mode for vfio-pci dev assignment");
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 89abbf641b..bb408de43a 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -400,9 +400,7 @@ static int iort_smmuv3_devices(Object *obj, void *opaque)
     }
 
     bus = PCI_BUS(object_property_get_link(obj, "primary-bus", &error_abort));
-    if (object_property_find(obj, "accel")) {
-        sdev.accel = object_property_get_bool(obj, "accel", &error_abort);
-    }
+    sdev.accel = object_property_get_bool(obj, "accel", &error_abort);
     pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
     sbdev = SYS_BUS_DEVICE(obj);
     sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 987bfba7d7..f58fc89b06 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1491,8 +1491,8 @@ static void create_smmuv3_dt_bindings(const VirtMachineState *vms, hwaddr base,
     g_free(node);
 }
 
-static void create_smmuv3_dev_dtb(VirtMachineState *vms,
-                                  DeviceState *dev, PCIBus *bus)
+static void create_smmuv3_dev_dtb(VirtMachineState *vms, DeviceState *dev,
+                                  PCIBus *bus, Error **errp)
 {
     PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
     SysBusDevice *sbdev = SYS_BUS_DEVICE(dev);
@@ -1500,10 +1500,15 @@ static void create_smmuv3_dev_dtb(VirtMachineState *vms,
     hwaddr base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
     MachineState *ms = MACHINE(vms);
 
-    if (!(vms->bootinfo.firmware_loaded && virt_is_acpi_enabled(vms)) &&
-        strcmp("pcie.0", bus->qbus.name)) {
-        warn_report("SMMUv3 device only supported with pcie.0 for DT");
-        return;
+    if (!(vms->bootinfo.firmware_loaded && virt_is_acpi_enabled(vms))) {
+        if (object_property_get_bool(OBJECT(dev), "accel", &error_abort)) {
+            error_setg(errp, "SMMUv3 with accel=on not supported for DT");
+            return;
+        }
+        if (strcmp("pcie.0", bus->qbus.name)) {
+            warn_report("SMMUv3 device only supported with pcie.0 for DT");
+            return;
+        }
     }
     base += vms->memmap[VIRT_PLATFORM_BUS].base;
     irq += vms->irqmap[VIRT_PLATFORM_BUS];
@@ -3061,8 +3066,7 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
             object_property_set_link(OBJECT(dev), "secure-memory",
                                      OBJECT(vms->secure_sysmem), NULL);
         }
-        if (object_property_find(OBJECT(dev), "accel") &&
-            object_property_get_bool(OBJECT(dev), "accel", &error_abort)) {
+        if (object_property_get_bool(OBJECT(dev), "accel", &error_abort)) {
             hwaddr db_start = 0;
 
             if (!kvm_enabled() || !kvm_irqchip_in_kernel()) {
@@ -3117,7 +3121,7 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
                 return;
             }
 
-            create_smmuv3_dev_dtb(vms, dev, bus);
+            create_smmuv3_dev_dtb(vms, dev, bus, errp);
         }
     }
 
-- 
2.43.0


