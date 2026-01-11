Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C72D2502E
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 20:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf1ae-0003Mj-MT; Sun, 11 Jan 2026 14:59:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1a3-0002fd-VC; Sun, 11 Jan 2026 14:58:33 -0500
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1a1-0004CX-Vd; Sun, 11 Jan 2026 14:58:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iidE2t+QpSxEUrW6XQwmQVD9lZyaUG6VJMa3tmq9HBcazLrt1Q8etgCVchCIPIMY6scZId6q4IiOA76mZbTB3RqkGcf7PnqXBSWTV1N7K81P1t1TeochyeZ4XAis7uHLPlzRPp5t7rECTpmjv09k2iOFG/4rPXuGpiNYK97USM3ZIx5wCEhRNvMGIBlfBHmqGeEgEYHBssoDcnrXqpsaBY1Vvq5FWpQvVotZwIsK+/v69IcxJG9KhPZlN0dplyajunx0rWuD8rRABOkLvpLdZjDzO60SXv8XfflGquKAtfmK39BDdQIrdnh2UdDeKk94tlyj9MsDyxS/Jnv8JYRECA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1MaYb7GwQz8Jumn+Z8eOiQPDy6JDleqAgZf0yrjOqc=;
 b=sD8lzUFC4qJKoXkVBUMzJUO5niByEHaRGZoYbZ1znbnMqR5e4MQgYY/Jtr+oJO3VfoCwJ+erjkrl+X/M6jWglv8bypN1NCoUS453nELejm+CBI4HRPWpIhDo5UcZ994xR19g5BbwpBCzJzAUKbjLbrRvLAe0R/h3jT+9yFaRdLpQJ49F2+nMwg3jyDDTLItG4QP0Wt8bNUl92puuuWs22uPqLnNDYBLJR842GwbUl402cyy57YyrYttCzlvVtclvRHWwcrMhZB5Pr4W8eB1Cywr42HWu544jleYwTqiq0y8vQG2kUe/nZiayC9RpF3lBB8waIQMro75Cvb+w9oPuZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1MaYb7GwQz8Jumn+Z8eOiQPDy6JDleqAgZf0yrjOqc=;
 b=to2LRM/6ltfvIHLrj8asEmtbbeG+J4/YL4CNC0yvjYbbWvNTtd7u/TULMUzs8cCYS1T4kU1WBzK4u3oR2jW0bRWREr2DexkU8mngo7N+uhOpBtR4kRnUKWQFOaIDoTlIGGRPJsqOUO9PYDOtmleal69nuN65rBATQ5fBoLrrd7UiaeNKYBv4YfgYRIc9qv++2HN9KvBdnAFMYX6e/e08Mi69v2FXxilADAifmULofY97JsKyAzZwk2F67OnXiby2RkvlBUFYlAPmiImpqs3H4+g95xOvxlUuLQxCgMErsMU9EL+BZWknjOswdk5LvxmFFbHKyNvVQRwFCUSwnk2Sng==
Received: from SA1P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::23)
 by SA5PPFE91247D15.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Sun, 11 Jan
 2026 19:58:20 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:22c:cafe::77) by SA1P222CA0014.outlook.office365.com
 (2603:10b6:806:22c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Sun,
 11 Jan 2026 19:58:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 19:58:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:58:09 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:58:04 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>
Subject: [PATCH v7 27/36] hw/arm/smmuv3: Add accel property for SMMUv3 device
Date: Sun, 11 Jan 2026 19:53:13 +0000
Message-ID: <20260111195508.106943-28-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111195508.106943-1-skolothumtho@nvidia.com>
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|SA5PPFE91247D15:EE_
X-MS-Office365-Filtering-Correlation-Id: f26a2c81-864f-4162-c94d-08de514bc52a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b02hHYi5c22NIyiDKCZF/JktRIK3LcTqi1UerBTNq1/lo/Uk5e4pa0jxucE3?=
 =?us-ascii?Q?Icr0467g7YZJY3TGPb5ksHplM8e8i7aL8xqqnHX7D/WROOFbfZAaU/kaOzZV?=
 =?us-ascii?Q?pephTJ/CZ3Oglcv5tL7MXDsHUoGwisyZZrK2PHakvBTeKn519l9+NpYOKVUB?=
 =?us-ascii?Q?4L38dUka2AiK0ZwEN2IDndRGfcpthgkxjfhfT/eZuBnvHk7YEaJzU2djGJ8j?=
 =?us-ascii?Q?KW9hHIJhuaekGLHu0z8ShKxmYp7vLMkD2n67EBeUZHRcWrdz08Fp9GskPUf2?=
 =?us-ascii?Q?5xpq8ynp0zv/NiteJvBcZ6L53oHHaf4PYs6V28+eSzTN/G6hOJDeRfFlWa0x?=
 =?us-ascii?Q?I0Uh29DH34YW7w/EJWomxg7rZPuFlRm6w59jvkCuxPtJarWIrIAbdejkZrX2?=
 =?us-ascii?Q?sEha3OFPnvqad3VN4Fy/teoIo0K/kbKQZ9dRIkn/xVhiTgLX9lmebfmu3tJz?=
 =?us-ascii?Q?w2C5YfRhMky3dZdeCHneScHLlPDrWWeKLL64u38Y41qS9iVwH5v+dJGqXZGE?=
 =?us-ascii?Q?mjRE8N24O9OBALQ1jk338zPJYNmy8gFreA/R9QX1+tGroaBbUFbsJNs/YCBX?=
 =?us-ascii?Q?0bQU/f6RmF8DzcHW2XVwt+2d10GsNqGkAUpq/bl2i5P2mYdk/NiQJQm6wY5B?=
 =?us-ascii?Q?YYHiijuSXCKylANz1p3QtS0oomDBfAgSEUGawQrhmuSXSb2bsU+aQNBpJubd?=
 =?us-ascii?Q?jAzEA+/RLUqrGMPlPJdKFob+y+Z+SfjIvlAQZAOTU5ntrQUi6qSyPsm63fqc?=
 =?us-ascii?Q?wB2P0AhZsmC/N8vYWbB+UbNI/XRwoScbCeXsRXFK/nMfKxKra3APLv1qihSZ?=
 =?us-ascii?Q?iyjPdOTA4DO0ZZ0k/yeH2/RMDz4zse+7N+Hq3MP1220IghQLY7lgOUB10Lal?=
 =?us-ascii?Q?+lG76yvIXHDWnL2wilGCLtacJAUIQcTf+x8u13pCP+Kpx/WBW+bBagzTFjTp?=
 =?us-ascii?Q?JCKB7mm5cLItgBz1ePw9cQ8cJ55j4Mz65LknY3+vBkYiBhWK9uUZHGzTGxHl?=
 =?us-ascii?Q?IHsu2EiVPJ2slNMFMvw9xdRilZvofNkJ45mztNQcTagDXWi36Q585I0mxb+/?=
 =?us-ascii?Q?Ch8Yws0b+VvLU6XfJYH48GdMdrHO+CVV7mma45YKR3+VA5nCjEBu5Gc5nzdF?=
 =?us-ascii?Q?kuhvQxhhYpzqvpemPwYUN2odjeynYYdpSTjxUasPzPH0snjDGIJbds4D6aoI?=
 =?us-ascii?Q?QpvyiPUbpA4pwq1MUEIria3EmNSB95rfqdHI0+kxM1iwkqEQdBCifHGCIpEX?=
 =?us-ascii?Q?Je4zKlSvL1P3jO2RAfur45FGzMR8n3hX2TBczmc0AW0z3uUk2V+3+qrH1yRR?=
 =?us-ascii?Q?kYnW7DAR7y6v+dm4Wmywwo7XKmYLNJi0J66y0yLtKIwyhNOXzCbwXgNFVw4n?=
 =?us-ascii?Q?nGFl6SRv0jfxsD2ojhBK7g6Zoqtr1OqhGEw86yNFJ/hDUSnxqqU0C012kvUJ?=
 =?us-ascii?Q?rRft1k0X9FCGfDyGNkSvSYlyHPGUgfOLqYLl1jXDoRjKcdvkeAJWm2ZA2bde?=
 =?us-ascii?Q?QbXDg2gkz5sCws+Cw0Cm9lYEtpwST2PshByMTqGKJFuf1aHOXdHfc7OHHnD0?=
 =?us-ascii?Q?oVIasEmf/xRv2kGPwX0=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 19:58:20.4038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f26a2c81-864f-4162-c94d-08de514bc52a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFE91247D15
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3.c          | 32 ++++++++++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c |  4 +---
 hw/arm/virt.c            | 23 ++++++++++++++---------
 3 files changed, 47 insertions(+), 12 deletions(-)

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
index d0321cea2d..c7de5fe185 100644
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
@@ -1500,11 +1500,17 @@ static void create_smmuv3_dev_dtb(VirtMachineState *vms,
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
+
     base += vms->memmap[VIRT_PLATFORM_BUS].base;
     irq += vms->irqmap[VIRT_PLATFORM_BUS];
 
@@ -3052,8 +3058,7 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
             /* The new SMMUv3 device is specific to the PCI bus */
             object_property_set_bool(OBJECT(dev), "smmu_per_bus", true, NULL);
         }
-        if (object_property_find(OBJECT(dev), "accel") &&
-            object_property_get_bool(OBJECT(dev), "accel", &error_abort)) {
+        if (object_property_get_bool(OBJECT(dev), "accel", &error_abort)) {
             hwaddr db_start;
 
             if (!kvm_enabled() || !kvm_irqchip_in_kernel()) {
@@ -3108,7 +3113,7 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
                 return;
             }
 
-            create_smmuv3_dev_dtb(vms, dev, bus);
+            create_smmuv3_dev_dtb(vms, dev, bus, errp);
         }
     }
 
-- 
2.43.0


