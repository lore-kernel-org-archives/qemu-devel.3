Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00EFBD2502D
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 19:58:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf1Y5-0006dL-OQ; Sun, 11 Jan 2026 14:56:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1Y3-0006bA-Lk; Sun, 11 Jan 2026 14:56:27 -0500
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1Y2-0003rl-6F; Sun, 11 Jan 2026 14:56:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igLWvcgrsn+xRMzLygz7cn48+g0y/VFiMhv1pXdWyhUcl+geCwXMCMdx23iUtV97IOuFVt3D2tbdIrDgNlXvIa04V2ekqLg6PFXQEand/EaRYPsuDTDFF5pQT0C8dl1djftVCaePFAmLxIhla7EPo4n/6TVkPnztZODoNbiHsRbpQSKLP8FqSYzAt8k8pZ4ARED3oEBCcIxxAf1rQYnnY3NAr9vVQgm7V+b/xPQsQ/KMzfrqolqF4xGHu/kbfpNv+iEZfzbqZQzk7lwzIqcuOaGxxp7pQDVlgHg5NIQf3EUD73ub8ArkVPQdpP8d4pw1TWeGOcrvybqfZA54LpeFhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RN7PnfvAxZ8lEdktDZXh3x7omBqft7TPgtsJp1rsThY=;
 b=ZNp8J5vR7PI2RGv1P0JFtW6dJj4W4nbQZhFUPWII1BNh2lX5h7QaJiz5aasZupwCdzT/DdjVmUZM/nDqurf6q2CU/P+cwxMJJhWOridESWc1Am/2jBc9qTh8wSxDt/NGi/3jVMKHdY6+0jayzYx5fP5mQ1PNugIrHrzlDTAzzxai1PKqlifMFZPbyH7Av7Ti+yoBTHiGBvKfIKBBdgxRxY98W8J9of7Mq/K8I6EfHruEcs8wV3wXzmNK5usNhOrouFDVixnjQHNZgyUCIYAZSJk++kqn29P66xFb8mMtADhW5Q7vjsSR7oSBbmKWxCZs9qy43z7lQbOF35gwjeq0Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RN7PnfvAxZ8lEdktDZXh3x7omBqft7TPgtsJp1rsThY=;
 b=dlPXhFDr2+ELWhfBYxi6wT1ztE3uD2ahYkH5Vevp9EWGI05QG7lmMY0QC1wWyTaLYWDHMrfd5iGTOTQG1ben8zzf/etRbN+F9Bb2igMQYEhEzV6dm0TzDLzdHFZDne3AbXA/kmxsLGpuDtGAsCIXgWB7B5nuPepLSOc+ogDNVzfLZto3AE89BaxX/VUz5Jb6dihiIRqEuTGX5PKu4JoKHpYR7QKOunnFUJKQbl8w4ZeevmuZ5OhK2mSH2TIkfE8ZOFIeyuzzJL1LVyMuNnWZ+STaNzFs/ChzTwtSeM2tQ+9FS+2EnRU+jUtcsjnc69DecuigEuYEkrNGG4eA2jRHxw==
Received: from SA1PR03CA0014.namprd03.prod.outlook.com (2603:10b6:806:2d3::10)
 by DS0PR12MB7777.namprd12.prod.outlook.com (2603:10b6:8:153::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Sun, 11 Jan
 2026 19:56:18 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:806:2d3:cafe::99) by SA1PR03CA0014.outlook.office365.com
 (2603:10b6:806:2d3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Sun,
 11 Jan 2026 19:56:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 19:56:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:56:08 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:56:04 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>
Subject: [PATCH v7 05/36] hw/arm/smmuv3-accel: Initialize shared system
 address space
Date: Sun, 11 Jan 2026 19:52:51 +0000
Message-ID: <20260111195508.106943-6-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|DS0PR12MB7777:EE_
X-MS-Office365-Filtering-Correlation-Id: f9bd64fe-cd31-42a3-e3c7-08de514b7c2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3JQHCc/9uo0QNJ2Ld8PkfFHOU3GqVAVRlj3YYptfnU97uL/B3O6xQ/XGHlY4?=
 =?us-ascii?Q?KDKtJ1sbJj+bLLpPBMxcwGL10qQRhdPhc8IsAFvp45ssAG4DNbCjz2kZHSnZ?=
 =?us-ascii?Q?8j6YA4DKovc8SbrklnJ3A35R2sSq1gpPWNshuJQRmXAMWQNJJJCrEHrz2xyZ?=
 =?us-ascii?Q?pQCjxFvj11GuToiHT2eGrl1Tng1yr+7/vSnFV1FiODgdZ24Kz34NBn7xO4uA?=
 =?us-ascii?Q?Yz703baG5dRnfjbvzifvbzylAufV4TKsqdvMmEpBdlPAH/sVJ83vA+GgSyjO?=
 =?us-ascii?Q?iuq54GbDEGStRXlaa21cllAknGzRG3JwlhUkVNV8+oRJE5FDYijNJqni8S5K?=
 =?us-ascii?Q?o2eej3CnQ1Pg6erUC1WX+zlaQCcnJUNGXUwXsxScm6BgVhMs9XWr/VcSezVP?=
 =?us-ascii?Q?DZfxb6hWxtdy+S6yUOQjuhIu4/j2xsYS4icJylDshxaB9ElbcYlHGf97/Qkv?=
 =?us-ascii?Q?J99OpWUUxXt5DIjW6vZ8jXN+uXUI+DSRG+/JTljKGsrqO0he0BXsIYoJmVkv?=
 =?us-ascii?Q?8m9Lp/uY1BjL5dj99GcTqWdJjugcuT57ujkZn33/IcJPfZ3Mk6QjJkk+WmYk?=
 =?us-ascii?Q?/Wyx9Ukric2KbfVGOR4y0F5IUs7x7YCNGsKTKCndmpyrbt+PccBHATRd/c/u?=
 =?us-ascii?Q?yuJdO3RhJV/u31lD6MiOQenBDWId9srMtp5LP+xHpUKj0zFWZDFDOXiRnThX?=
 =?us-ascii?Q?cNZkDCC6V/QdCd3K0cyz7Nhd9wdV4uguAF7XPuyK9gVy9ni21ayv/wwG7kZX?=
 =?us-ascii?Q?Oaq2z/vgMLRGIV7AZ7KH6iXFfVpS4wMHjxWvTLyUIfiTk47MNpk2mGAn7KRb?=
 =?us-ascii?Q?fqB6TsDg+g9xQe2wy1LekkBlR4dkKrnYhxFkzY//Cx6EEWMiig6spvoEnNMp?=
 =?us-ascii?Q?pmAd22gVuhZ5QHcxFFUXiVQVZQiDci4rERswmcAfIyd58YPXjInoDqy9ijJW?=
 =?us-ascii?Q?bq5CE9l6XO0PSUAb+7XPUPcSkhvm1LGzrb+b/rQA6Cetq/U+T8FzzhNgOL5M?=
 =?us-ascii?Q?aY3EmbbU+WzGrABRVjTlpt68M2VjTLfO00Qu9urVatdDp8HZovEl916k9WvU?=
 =?us-ascii?Q?s3I6jsKEUVwU8uy68wH4/Nn8v71QnKmgaYtWm/gy2BAxVY3ooPisGUDsY/an?=
 =?us-ascii?Q?kablL0np7pkLIUzJ6Ii+CtHU+6G/OL9lzkxTf1sq9uc8Lid0PkpHLu09fb/i?=
 =?us-ascii?Q?5h1UYAjDWwYoyrmA83zoS4P8RBaQxaE7Jds6WtsvU3/wWFFDJglexh4Wh2WU?=
 =?us-ascii?Q?t4JtXEu9jdJGpf1mlvP+CcmkJl7Qg9m7V86sM87QJePQkXMEd1Jq6snch4DB?=
 =?us-ascii?Q?TLq7lcYlI8QrtXk/5FkCyda7X7FtKKUwXaRqJKuYGW31wKnG42cGcSsHQ6KB?=
 =?us-ascii?Q?zoEbhFG2k7xwD/Nv0dsNUHQ0kD16fu1nXHdkHf1oGjUFIXjjuIOeXdD1Pwi2?=
 =?us-ascii?Q?o81VJ/vtPfWou4paGK4O0fgJqw4iEN8ZWgBMEeMR76SMTdtiI1W8iMIo95Qp?=
 =?us-ascii?Q?fTu6bB3+p/9v03fCjCfo8HSi9J1uACwTlnr3aw0uYDYXdD3ntf6mezsH6IXP?=
 =?us-ascii?Q?d4FMjAMWvvEhNMdbmhQ=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 19:56:17.9616 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9bd64fe-cd31-42a3-e3c7-08de514b7c2f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7777
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.001, SPF_HELO_PASS=-0.001,
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

To support accelerated SMMUv3 instances, introduce a shared system-wide
AddressSpace (shared_as_sysmem) that aliases the global system memory.
This shared AddressSpace will be used in a subsequent patch for all
vfio-pci devices behind all accelerated SMMUv3 instances within a VM.

Sharing a single system AddressSpace ensures that all devices behind
accelerated SMMUv3s use the same system address space pointer. This
allows VFIO/iommufd to reuse a single IOAS ID in iommufd_cdev_attach(),
enabling the Stage-2 page tables to be shared within the VM rather than
duplicated for each SMMUv3 instance.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 99ef0db8c4..b2eded743e 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -11,6 +11,14 @@
 #include "hw/arm/smmuv3.h"
 #include "smmuv3-accel.h"
 
+/*
+ * The root region aliases the global system memory, and shared_as_sysmem
+ * provides a shared Address Space referencing it. This Address Space is used
+ * by all vfio-pci devices behind all accelerated SMMUv3 instances within a VM.
+ */
+static MemoryRegion root, sysmem;
+static AddressSpace *shared_as_sysmem;
+
 static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
                                                PCIBus *bus, int devfn)
 {
@@ -51,9 +59,27 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
     .get_address_space = smmuv3_accel_find_add_as,
 };
 
+static void smmuv3_accel_as_init(SMMUv3State *s)
+{
+
+    if (shared_as_sysmem) {
+        return;
+    }
+
+    memory_region_init(&root, OBJECT(s), "root", UINT64_MAX);
+    memory_region_init_alias(&sysmem, OBJECT(s), "smmuv3-accel-sysmem",
+                             get_system_memory(), 0,
+                             memory_region_size(get_system_memory()));
+    memory_region_add_subregion(&root, 0, &sysmem);
+
+    shared_as_sysmem = g_new0(AddressSpace, 1);
+    address_space_init(shared_as_sysmem, &root, "smmuv3-accel-as-sysmem");
+}
+
 void smmuv3_accel_init(SMMUv3State *s)
 {
     SMMUState *bs = ARM_SMMU(s);
 
     bs->iommu_ops = &smmuv3_accel_ops;
+    smmuv3_accel_as_init(s);
 }
-- 
2.43.0


