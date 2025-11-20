Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120E8CF8855
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 13:25:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM4dX-0005fR-6o; Thu, 20 Nov 2025 08:23:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4dV-0005el-BZ; Thu, 20 Nov 2025 08:23:45 -0500
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4dT-0001zm-N5; Thu, 20 Nov 2025 08:23:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPyFsGcwo6vhzUhDmENePYCwVL2GSE9JgiFXUR1ZUB/h45a6rgNd/z5wShiHJPyROL3nhjggYHptcY73cEbM5pXIjOjsK4ulmp3ln3fnA8aU7xS/zYxifvlKZoyphDPRqmIZvRRpDXca/zZhU5z0cJkt6Qq7j0hewV8xgMcQ/GiMrOX6oYdRJsNDHvHccWu7dF7v0WEH6wVU13Cl/sovX5Nls//ka35iYBLeOTTnoGv9/08eRyia2MYHsxLsOMy2WVY/rpiD1+sAQSRg1/iS/O/cg3R+Rda/z57LiayMiVjGUJGIvkd1LOe/u6QVSQJTHgYHL86AVwJenOYG68bAWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7pce/WrZcYjHNLHcZ/bEzp4ukTYuOk0WpJ9QXV1WKg=;
 b=Dk9YM9no0f+rtTTPAVWvo5BANU/dIIyvzyeM46V2SZinHenhvaxbWbBFF49QTxWfOEzxvEB0fSjeWw/8TT/7p1Hf7vhtm/Mmo3cm4LhtCYst7VTUdJgV5aTCzcyPshLhD7r5G+W3r2z1+HzbkmO0fFsmTulRY1sJkaB2AH/BHCKlTv2VbSdkzdsSi2Aj/2mvm3lS2DCef3L3Z9BnrYXnYrzxQzoBsJPdpHV1WBhdPn0qSLkziS1drbqy5Vp6m9idD5E0zFfBi3u8+v8iUUxnwTyXkG4f1FxCNIP9PBw7x3N8BuxNtog0U0v1WmXIAxznE8YBZiUrpFk/23J82lV++w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7pce/WrZcYjHNLHcZ/bEzp4ukTYuOk0WpJ9QXV1WKg=;
 b=U/aWuRi0Xpp/MJljLLLipYPICuRKTNpw5rSVXi9fzRFgIyA2R/nwlgU/DWfdYNJ0jIsFv5bqk9B+3rBYwYZraOT1GAYhv1Y81N5+qpXRyozgO6b5nw/jNAcVfYccigGRsJGQS3tasc0f1fW+j0jW+t15GiNrsllJkCUYucSfu+Acik0OvYpUXYaZFpzIYzVbpQuAVm5EgABdJMDU8oA3ODQEaYg5Esh3jbht8waL8i6y5h47XBXMxbXBA1aAeWSdm+WwjhcjMkZILTV5wAPPIxxb0ErM6sm17q7phQ45nP0eQbhW41fqKCqe6KC7l4GdWrxVhxF6aaqaZYkzFJj1uA==
Received: from CH5P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::29)
 by DM6PR12MB4420.namprd12.prod.outlook.com (2603:10b6:5:2a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 13:23:36 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::78) by CH5P220CA0006.outlook.office365.com
 (2603:10b6:610:1ef::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 13:23:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:23:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:23:21 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:23:17 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v6 06/33] hw/arm/smmuv3-accel: Initialize shared system
 address space
Date: Thu, 20 Nov 2025 13:21:46 +0000
Message-ID: <20251120132213.56581-7-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120132213.56581-1-skolothumtho@nvidia.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|DM6PR12MB4420:EE_
X-MS-Office365-Filtering-Correlation-Id: 03db350c-be4d-4058-1253-08de283802ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Bw9io7hHhfp4wz+uSfUae2+ckJ84xTgFeCr3f/TRVaDvUsq4Ui3oQFTVYxCs?=
 =?us-ascii?Q?QRHJoym94p7qRc8QyK78G+DQSIa9HYxxubzI+rVU6mt2hQvaHl992cN1OByY?=
 =?us-ascii?Q?co+xIgdcjj2IDGzI3/QmU74ZFBfvlD4EyOL4moGpuATJ2DvLMCX7+EcoCxA2?=
 =?us-ascii?Q?Gn+aQN8r0Ez8XVGwM883F2A9Ee8YWP/8YW26Ldg+OifILG3GfEDAp8Mtt86L?=
 =?us-ascii?Q?h4vPAHWY8OctrXvXSqHQIImz/kFE6OKVsrehrsehDgfRB1y8vjPWVJGJ8Do2?=
 =?us-ascii?Q?PaIm2//2vHx5/xhPlnpHgRRsFQ9jpM5Dm6YfEtPgj/0QtXmvWJQxTYGyOAWg?=
 =?us-ascii?Q?G1ISBLPXWgCY/lAwkr1Nfod2vwuRvIE0sBnK0GsCOeor/cK/458dJiPs+IC1?=
 =?us-ascii?Q?jgKuFH1v4cT/9QKjLdDNpZ9CCQwPP19Pkg721SECUVXbEgV2mKWZ/O3g5kWJ?=
 =?us-ascii?Q?ELX0FjV6AvmxbiNNHLnMFZ2pxi5RqzPavk+pLyLd2IkrzjQy8VYopcGkGQ4Y?=
 =?us-ascii?Q?D8S9aboVjkLIWXoDW7tUWcghTVye+AoC6LwQR/+g2vJ+WulZEswYrZX4Gdd5?=
 =?us-ascii?Q?zIAbWjHcXSyDljcGugDjjr0bneOKKDR3+oR6McglPlLuu71S5LTiUZUUCSsE?=
 =?us-ascii?Q?nyZeO5fUp9KcF8kPRHK/4s6ZuU9FAeTbfDe9nYGG81y13WXWF/44TSyYRgdd?=
 =?us-ascii?Q?o72SGtvM3wR8in8Ec6pNy6RsKOoeD1NSB1zGRbIgHA342xoVSPeF6wdlEbUb?=
 =?us-ascii?Q?o0lwTAgcKtY5eA2CfguGHEWaMiCVH1gFH6R42LBt7wJe5o5FOCDfBWE6ilPD?=
 =?us-ascii?Q?BN45OwK9JLV8IbhTKnimRRTLLphQjnhwmbR7xsPOe07XZRfInRNLJOptUBSy?=
 =?us-ascii?Q?rklNDbJD0cEVPzHFQCHoZ7qY4w+F7SRVxlMRVbr/0N8hrGyfd3OOrlX/4zoy?=
 =?us-ascii?Q?JnwLJ4MB636JeM5Zf5N3rU0CzRdVfQyDEGMm8G9PQ8Ho9J+XuIwpTxJi6TkA?=
 =?us-ascii?Q?0MPAm2AYz/gom1f+7H2Hpqg3Sld+RfAXBFa1G1Rv5H8tTpBBm6x6eyk1MDy1?=
 =?us-ascii?Q?CRW0IdSITcnP3DGhV4cu7rfr0YKEl9fBpUr8VFdu97uLVDp9gjcP5It3seTp?=
 =?us-ascii?Q?PB/ThyF/qBcnkKpSMoRhEBxFywc/rB30txiSHcEQ6V+KAe/uJSd+EiFHajvy?=
 =?us-ascii?Q?6NHc+9qH4K2p6K2QYTztKiN4m/fWSWslaPHbI4kOA8XfhxrEblnpNvJrA0g6?=
 =?us-ascii?Q?buSqWZi/Qke+BMPtLSyOeR4i53EiS/r+gSKS86lUi0kq/iRHhERiSaPB7W2E?=
 =?us-ascii?Q?x/bYEVvszhzj9PEkgrrHxFZe8TpMd1VMq6CB2KcP13Ew659irztaAb2B6J1J?=
 =?us-ascii?Q?uVssmLCa7MalibJhfbCZEHnwmzwKdTjEDXgRgjMY5OJZ+UOKBE/4ASUMH2pp?=
 =?us-ascii?Q?7o8CDE2As7+HzdVJNlY6IvoMWYokBv53VAPitLvuCUiFItU2A/HDuTakkZHX?=
 =?us-ascii?Q?QfQTRqQ3tbjFyR7ykaqe+Vjszlj/vGlqPQnSUbM5H7ivuOpf2kkR+dZdBvdD?=
 =?us-ascii?Q?vKRKXL9k4djjQa4wW+k=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:23:36.4005 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03db350c-be4d-4058-1253-08de283802ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4420
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
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
List-Id: <qemu-devel.nongnu.org>
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


