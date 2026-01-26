Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C09CF65D6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 10:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkK5u-0007Cs-7D; Mon, 26 Jan 2026 05:45:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK5q-00079I-Af; Mon, 26 Jan 2026 05:45:14 -0500
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK5o-0005WT-PI; Mon, 26 Jan 2026 05:45:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AYplx+3KCy2/2KEGLorpfY4ducIRhZXe964+vwDvdzOUUHj9KmO+f2LIxV8h2vKmz56TKT22fzo3NgtOkeWnPjZusUaHj7wLsA8NZSGO9yWT7XHDPqC3wPZDfHuP1SHhoZIECUtzDovvOSkQ7t8N8LooOVYQYZblDe9mmzXXRvqMii1bjgKs65n5td34d4fcH9YMmvUFS3W+MWpJY2ZI/G+8G9CAuNCflpL85+JwJK9S9RnlzN8d4oxzzj6l4KtAm77xQooi8F1xmjVr2EPUiMgRf9RdR3dEmL4/gD3ej9gXuXuifMlw6QVRfe9n5jbeHLp4m2FZlWwXe1Rbfgf4pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wuORsJgSJ1EOp2fzKSUJZ2s6IuItU3PMCcW8TNslek=;
 b=KBski4CEchpwiT4RtRimYeE74TaB9Rdc6IS2s/xJUNqPMvEukSBMuqFejX54xrIrheUQ0Fc+xNENNCjHTKOVN1i4UYvF4MrdD0wWAHLgK+guWXTvxnep0Ki7m9C9AcwuCciuVyIOV5fULvFtxxZ34D6tJF4dI069LmKaQSa4NlkdxMgoxsyQda/SXzzm0ewQ81XUc2NoF83UGnOFUQLLb58gHez70rxUQzVWnr1S+ll5Q1bMXadtZFSwdMTxo6BqLm4Z8gRWEeXM25lg3iDim3adOEHNYSH8dCtj4XCMxe0w9M3bCCP5PjskJLZfz9dDfKjiF07b+x3t3UGNOuHj6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wuORsJgSJ1EOp2fzKSUJZ2s6IuItU3PMCcW8TNslek=;
 b=SnA1h1GXYv4MOdPWq7K8oULNAi484Jx/Qyqc6kZRQRJnpAi4rRoBuQyIGc5qWAm/z2G0hMO4pPab1jlfoqJhtvWKjWn2lgbrd8x0bpJTeihv1rXe/7ZyKd3tLGaJSilFF7LmNPHOLAFUVAyICwhJ+6URdlVZw+x+da+7xPKtiBBQoHZl6OxHjAy8z5MqL+MDic+JNWTRHHb5LnIP5b4zCcELb6rBEre2N79jDJAmZm2yoDrfBQ0QnHzD/ZzjrGA9+pwQzLdUJ9KMfYTObvjBYRNBIsTV3RgzaK109UlomJ2hqPGsBDlcHxvGmHnFPpD45TFcY/wF7TglDKNhnvjoxA==
Received: from BL0PR0102CA0043.prod.exchangelabs.com (2603:10b6:208:25::20) by
 DS4PR12MB999076.namprd12.prod.outlook.com (2603:10b6:8:2fa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Mon, 26 Jan
 2026 10:45:07 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:25:cafe::25) by BL0PR0102CA0043.outlook.office365.com
 (2603:10b6:208:25::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.14 via Frontend Transport; Mon,
 26 Jan 2026 10:46:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 10:45:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:44:55 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:44:50 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v9 06/37] hw/arm/smmuv3-accel: Initialize shared system
 address space
Date: Mon, 26 Jan 2026 10:43:03 +0000
Message-ID: <20260126104342.253965-7-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|DS4PR12MB999076:EE_
X-MS-Office365-Filtering-Correlation-Id: 288f066b-de3d-4033-8fe9-08de5cc7f876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4zE6FqbECohzTH8wEEdYZrzvZunXpHOJkkLRwPap5yHAZd6ts2txJ4f/1C6S?=
 =?us-ascii?Q?ckb7PO/1jX3k8+nJ8zhpyN3w23y6zQdCbbDWIp93PQsF75dcADoJlHvcQXgT?=
 =?us-ascii?Q?pmsKbAS8qQY4xGcHVVTeMmZY3JXHIG45lv5cZlaGtdyBFvL8F4Qp9R7z1XFv?=
 =?us-ascii?Q?ASBDCOKLBSqTN6bpCJ7UZUVtU8N45Dz8Zo8p1TW5M/8tIvAO6FozxXCn7DQ7?=
 =?us-ascii?Q?udhe5Eu+mV0xfxTeOP99sB84/Obljef8lliO2r8C2Aw8AN0ZcQyXCP4iZFUx?=
 =?us-ascii?Q?9WGlFjhSFItN97nldbOsV3DLWkiFnX1V/nHHFvPu2nLfltGdBMeWb+heMVlA?=
 =?us-ascii?Q?8JaNq19WMYGNRW0QUV+AA5247vCKva7lN5AsfWTt4c9AF9ziM4LNjpcPNVNU?=
 =?us-ascii?Q?ELUTDSjnsF43YWd6MCAV4zNEOGLyZXq6FHyB0P0JInvIn+CAEgPpmoS3iCnw?=
 =?us-ascii?Q?xA1D5zlgAaJUTRoRCdLI48yOyXTwUT0hknxMaL8aydLj6hKo+A+5CsflgXh8?=
 =?us-ascii?Q?RZWQ2XQobPcFna/rY9dA3ppmiGD54bh7BSxHq35p0m2efQ8wVNhlOU4kcD/8?=
 =?us-ascii?Q?Xyd3s1tq3UXrGKM0FxGxO09WgwK4unC1nnVWq+I5yTFVxmPDszxBddOviQtd?=
 =?us-ascii?Q?6+AbKiwleGj4lKkhLCOTctkLkUEQyejyWpMTyTtqFNPAFf6zUF15KVtNAnO/?=
 =?us-ascii?Q?5HvcjYw5nwxmczj68kKnQOxUpl4Dc73PJpBnckrAH/z24U+TXALt5gpfsrWe?=
 =?us-ascii?Q?sUYZfPX5S8LgfYZuwaRzPKy/ek9yIJj0rtumO6AtmUrQZ8CDBIDYukCIhVrk?=
 =?us-ascii?Q?ePCt8vddG2Tfmj9LPtzIdqHtvDAPY0ZckYXsxePpDAZ0W1oz+Yn6wQSOk8AU?=
 =?us-ascii?Q?t1vwWQ7moL/Pe41Nc7moyHw2WDKhh0PYnW6/ebT+JJ7RKZijW/JyCHmRIm7U?=
 =?us-ascii?Q?76N5zC1Iv7NV8Lz55ozlB7Ba6nhrzFR9tT2SEeCYdNFWU5aLi4A9Db6MWhXj?=
 =?us-ascii?Q?wwMP3Af7PQs3AMPoDckyjA191QCbCsL0q0mYh2CFnuG1hcsnYogQNgxroI3E?=
 =?us-ascii?Q?/qz0QgMc+helXnn8pCUA4b1KINdsjDt9UTiNU3b2J1Rm+CGBlDc/A131a3QW?=
 =?us-ascii?Q?HYbSkygNtgaW44+S3UJ96RjDY2HnKZ82hc2GztPGEx7z/g6PdcCiA7KqGYdP?=
 =?us-ascii?Q?ps9O91U3iYLPGHoL6WVpga2gQswNGtLyq+Fxcuk2xlQ6Zo15qdikh58ttojZ?=
 =?us-ascii?Q?dIWyYq4XSCBHi3kvW9S+cRmM38RJ8ErO5eXiiPbSVfy54xUzk4JKL19atgVA?=
 =?us-ascii?Q?jhMG9w1/W4pVNyvI1FNWH0OxRoKiSxREcy7SofOvRtMLmFGGOmb2iQsjn3rG?=
 =?us-ascii?Q?svQpfWwkKpdgC1TLRxpx0Hf/JPptrBku6kpsSf/ZhYKTwIMbxozbLr1EM/1Q?=
 =?us-ascii?Q?TOcQsK+5ZYEZ/AXS69B3GOrh/bvrEqCIcMaRiXh8grbxKcUczBXxfGaHoigq?=
 =?us-ascii?Q?SLJHDe5aSXqXbM6fNoaoFtjPpEU2ralD0VOJ8xgC+bZyu57MiJwCNwr5b/vy?=
 =?us-ascii?Q?nnBNWs2S0GdqWf50YbmLu1pxsAZJJZQ0IIv14jg6lD+ZjWRfelryur1om8zf?=
 =?us-ascii?Q?uRW+lV4pfn/Qx3pBgaxkSQ2CS+6seCXECqHSZ5vrKUd8oKl4CT+PIqV8rcA4?=
 =?us-ascii?Q?llQBKw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:45:06.8174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 288f066b-de3d-4033-8fe9-08de5cc7f876
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB999076
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
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
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Tested-by: Eric Auger <eric.auger@redhat.com>
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


