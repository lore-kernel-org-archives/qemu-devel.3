Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3D6CF65D5
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 10:50:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkK81-0002l9-DU; Mon, 26 Jan 2026 05:47:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK7j-0001N7-WD; Mon, 26 Jan 2026 05:47:13 -0500
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK7i-0005k0-Ak; Mon, 26 Jan 2026 05:47:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TEv61mri+QvDuicZsk4MydxBe2ubbMJsWj0VjBg9iEZwjmYJghBsJv87fSovkCBugE4RWtJJdoKEyq1oftOyGP027MX07uOiGTiCzqrYN3Nwd9i3RK8zWm80fGIZRgtlPx4qsacbVBkSRMFGkLMDLyC7Jfm0oIghxQuLX+vzgDzOBjHHjiKE6Wk6GGTK4ee0QSj4GOXGF2k7edLCZ0n2Yz0en91aVaBZ8JVtat81tbOWZC3uFpjMh6V+xJvsfHBfw82d4RKgRZq9graQbtAMtoo1DqWQSjTAaqgvCXN/29bsbXJD5CnPrEPR1ERefLR006o1D1YH2cPpueWzQNhNnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNxBEwVoxffxnC8GNALxIwk0s6QWYmH1UQApLenitbA=;
 b=RkQhkURk0G9BPcKL/RktPnhMBb5hi3ZVfQ3SKO3LjPzNDb1nJ8xO3Tl3gpvrtRubIRy2x9gXpzjyXV0X80f9Ygko1UMbbj56DGrz+XrhybtDa38mkrd8Tpke8Uo+U0DQeE5MhlGgyv+7ukGe3CcJN9GsXbmglisn/A9bWVx4wvedjb3lqSgEfE09//SjYtYheKLjtpzxbydrdTtSxaneCuYP6/6hCe3LR2y2cCVquhhVLsvyyuQk2UKy34g5gXvHPUBfLJ9TQMZ781gcVap2UqeZ3I7v+Nne3Y813/zFycGX8URc8EKbnt9FYRnD4zgP5EA5uM+gzK85gL9wezWh3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNxBEwVoxffxnC8GNALxIwk0s6QWYmH1UQApLenitbA=;
 b=eCjq8p3c3HTAsMMUR7x5h1OiumRPIacAB31/XDWmwXOatERW1lFprCmedNWf2BgBBSvTIT3DbPwfxQAwHAWx+EsqpXL0URmPleN1LF/s6g4gwoKKShIvvWcLTfrIyOlTV7mfUwTpm3trWFshLFx6iCnxVczOvhK1IfJBxksnLtBQoIuUxC1/vaLWt0r2DsROXALZGEbTKTNRbQevHX6w/hg+O5c9EqtBHWvwNxmZowqUxd2NkXNRTBUnrDWyjOe0neR2kaymgTY1Go69rwAnARG45bU/HsKK1ucPulYRO3tdXHJlP1gvEOqJiYsQWDPEaRh7zxOAJsOH1guo4Zyptg==
Received: from SN7PR04CA0007.namprd04.prod.outlook.com (2603:10b6:806:f2::12)
 by MN2PR12MB4485.namprd12.prod.outlook.com (2603:10b6:208:269::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 10:47:03 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:806:f2:cafe::38) by SN7PR04CA0007.outlook.office365.com
 (2603:10b6:806:f2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Mon,
 26 Jan 2026 10:46:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 10:47:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:46:49 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:46:45 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v9 28/37] hw/arm/smmuv3: Add accel property for SMMUv3 device
Date: Mon, 26 Jan 2026 10:43:25 +0000
Message-ID: <20260126104342.253965-29-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126104342.253965-1-skolothumtho@nvidia.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|MN2PR12MB4485:EE_
X-MS-Office365-Filtering-Correlation-Id: b0e453f1-7372-45d7-ca85-08de5cc83e1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VBJE+ToSSWnNfQWj3DhLowBDXc8XRzro8CHWcrcmlbU/xYiv53oNkMw7MCCY?=
 =?us-ascii?Q?3VndWQKN+o03AaIr1058ovBmGjQ1r3yzQsPbITRqUYO5YHGThsWxTkW0kVLn?=
 =?us-ascii?Q?sipIahqVXgmnN9itrAky0vI6o9BvN2Ey1dlzpAxlhulEEmQr+qiorjVTSr9d?=
 =?us-ascii?Q?DybiNenA4RMryvGdXzhVFO+c4lbPY+yN9sQ6A6bF9RtU61f+tdGeP5wwGQT8?=
 =?us-ascii?Q?jC+WNm8pfEGUCGUPDHG0M1D0DHIOx5W7rC/9+ixDP2Aoml7MDU6Ji3lyL7CO?=
 =?us-ascii?Q?cfZkuccC8R+dO58EkWZPFOnZZXyk9qa3O0A6vTMfOwPe5zbiRfMt4SGvE903?=
 =?us-ascii?Q?UkAtn1Nf8zHwXJV5sWY5+qY0XVdMJVeauSnP+L09C0RcQX7Czp4U4Zn4cdBR?=
 =?us-ascii?Q?NV14DeWQxJssr1tuAWICH8YglJvipbJPaPt4lp11sUi8f+wp/IMwRqHMCSlG?=
 =?us-ascii?Q?xwn4J1HYbTWc1w9HLmvIEj8rjEt/YhOmo/38RdtvO0CNGBSSWGmQ31gbd5Ai?=
 =?us-ascii?Q?3zP8jvs0KdGuZFSgWFZShiUXR6xoCHVsPqiWwdFk7LLxR/ntThAgXl+AaLJU?=
 =?us-ascii?Q?Q4gbgKfsV12tk50iXDQfOA5tNJixkdHJZbMBG/LhkjyMr0W1GhP6VRHemXVf?=
 =?us-ascii?Q?Vf3wmJly435Zz6uEMu9xEBrDab68gGhwwM1piS0GXou2wbK+WJjOnsbtSNB6?=
 =?us-ascii?Q?a8+VqGza9/cl+MY51XVxzXIyJL1/G+dWn8EitbZka7eaIuV5SOy2EdHYNX6Z?=
 =?us-ascii?Q?A5q3qOFc9Sf7dCh75f81o8dhRnZrX87vdZe6RwfG/dLgt8piKTJZI52PT0pH?=
 =?us-ascii?Q?QTteig9Lbsh0mIiONs1OrIbjn8aEWRZM6DfLUON8lhh3dVweKEmO5f5GX+w1?=
 =?us-ascii?Q?yD1NKDY1nRTyw8yoB3aSK1qn+GXY1QNFzA5pyyfCyvQReB6/C3I11n1dZKn+?=
 =?us-ascii?Q?AD80qkMh8wsv+CtY4FTLnKV/wBm+NhZkEg6fx3hwvSvbeZiuIb0OxTlZP4E5?=
 =?us-ascii?Q?2LDG1EIQgzYVWP0VhLoGpLNm9ypdxDLv3R2HSiaFJ8hbresYaw4u53NxS+NN?=
 =?us-ascii?Q?5Hz9QVaoBiuPOa+wCy8d+slRDGomvetxAafB+83MFp2fVLk/kTu0P6kJ/fAA?=
 =?us-ascii?Q?ulS0a5E0EWFZZL5yxDDVkRDhsiCXHdxx5xEsR6aR7il1cLNF4mvdeyFHIzwm?=
 =?us-ascii?Q?VSigffsj3HZnP5hWM7nU16Neywg4s0Wru042b25TQVbkk/z5P7fZqcVnyo2t?=
 =?us-ascii?Q?rLnYopacocAv8eUZxTO5OCU8q9lgZOUGZQNEfBoqtqk7taUxgCgcuIxHKhGJ?=
 =?us-ascii?Q?UsAVtpdGos1vJXVTKefg8FjigGa6vPlTjHtUClAtxgk2IS1GR0rmACTM2WHB?=
 =?us-ascii?Q?FXv0M/Z2WNE7DIrjUY487vTbSDDr/0IggkcGDbLal93lhhe17uslSzGJh8pJ?=
 =?us-ascii?Q?jiV63QuTuAf6u6JGs9Pme3rmqxVYoQdYddv9/tJLS/jrSylzo/WB909/DHhk?=
 =?us-ascii?Q?ynuLFvWLHqWnSl18P12NHW/kwHLWh044WnSX/sJa/Q/hYKukQi0yFi6O9OYe?=
 =?us-ascii?Q?UzlYFZlbaej1uLbzpgj43CUEzfo34q6+PaYuSG/xd8x4nELoF1OCWJ3zmITS?=
 =?us-ascii?Q?EvFUZ4nqg1uS/8TjCroujPVOTUeYnAtIQlAN41SugFdKvaTNaK0xjABZ95Hm?=
 =?us-ascii?Q?h5ItBg=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:47:03.7115 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e453f1-7372-45d7-ca85-08de5cc83e1f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4485
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.587, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
index 4ae4cbc6cd..3126aca42c 100644
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
index 899b02e1f7..390845c503 100644
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


