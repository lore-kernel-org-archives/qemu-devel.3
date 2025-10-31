Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4232CCCF9FE
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 10:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEmkr-00039U-Ly; Fri, 31 Oct 2025 06:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmkm-00032d-Kv; Fri, 31 Oct 2025 06:53:08 -0400
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmkj-0002v3-VU; Fri, 31 Oct 2025 06:53:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xcy2Lulzg4A+OpztXzfJbYaYDz4yNAgFsigXx6rOfwsxJbeRkbSmP0VHoRo+lkEwvrIA7RqE2obJHlq9EfzLHC4RL44jbtTdiq77VlHtlq+V0pAJDuVhmEwrPUlOobuerxxtCdTw57NuXgXO71L82azsDqHh43AHQXI02gmL6itcgnrncgc/kpg4K7xakWvnnsEUeV/co4Mrf8zSyeQFhblyWrXXCVhJOz7wFr8Qqg91xYus7+2lGaEV7kRBpcPM3weZBFdeEWKK/xq4XSjVLlguZMOMss/e/ufTl5S6DGdlyepCdwEoWwIRaQF5rnCxexrhsZuG/g5ggI8qEyWNLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oypk9S5+rRPeViLyCYrFwyvMLCmkXsDiAmLZkcX6wxA=;
 b=USd3CGQNoyhfPNjN1h0epMKX9kR31YaafF9rWJ2CDdQXO21j4kZnPaKHCEOg/QikKooZXC+IbON3pjp5bt0uqUHRIRuQ+QRSB41cFKV44MFon/CzBmeM2loafWfQ3viR6HR94v0iDRtpvlgQBlT2DHHocHHBxuKzVdw/rRH/NNpVPhx9nCoq5x0ADVHQrsnM0sDpG2nygSRhGqeQFYvsRdiVQ4c3O65vBMrib6cr6/Mfg29yACt769YG2QtMOUDJq54nf/q2d9QMTHfHb8dOWT+PLF2u2Amu6naJXHowsGulLNbLE4UAiGPEcylHI1s3Jd9fF4hEiTwjHIGqyIc6Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oypk9S5+rRPeViLyCYrFwyvMLCmkXsDiAmLZkcX6wxA=;
 b=ShZ6owmS1j1sXHL7tcwl/9tAnRNg09LxH0Ko/ABZc5HLERLAPewmoiGU+LPF8Q9ENrek6yFc0dTPbK01tfSUo3NDTP8gTEXaTEu/FfGGhSDqHCr9Q1nY/YGlzoWpr1zP/7VLuKqmarf77IoWBGykSr6Py7s1lYD5vnwfjaRH5KG5I7EM2ySzshGt4wzVmJiiPrPiWQpUo1770S5GqOBw8cXywxL92pLmKid8dnazpKfDtvumrrV82ALYST8jcFa8rRJgfr+rZD5oi0sHPIlWh7BfpcIeRYZKWaHuwgEujtcxBjy+QHbFufVqW0f7ZfpUYMwyxBvxReYoxgX59qS+kg==
Received: from PH8PR21CA0003.namprd21.prod.outlook.com (2603:10b6:510:2ce::14)
 by LV9PR12MB9784.namprd12.prod.outlook.com (2603:10b6:408:2ed::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 10:52:58 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:510:2ce:cafe::8) by PH8PR21CA0003.outlook.office365.com
 (2603:10b6:510:2ce::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.5 via Frontend Transport; Fri,
 31 Oct 2025 10:52:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 10:52:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:52:47 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:52:44 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v5 06/32] hw/arm/smmuv3-accel: Initialize shared system
 address space
Date: Fri, 31 Oct 2025 10:49:39 +0000
Message-ID: <20251031105005.24618-7-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031105005.24618-1-skolothumtho@nvidia.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|LV9PR12MB9784:EE_
X-MS-Office365-Filtering-Correlation-Id: 8edba7c5-9d4a-4d3a-0ad5-08de186ba711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|7416014|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1NWx3jkKJRTcSNYyfxD/8aVEHObWg6bDFeQTZnCui24yd4b88LBoswh+4+8e?=
 =?us-ascii?Q?AVSXL4HCvXtnbqGnAR9qaejen9rCGnDQvc0oq/wBXznW55n4Jo52X7oLK7Hi?=
 =?us-ascii?Q?+AAjjGC/VGbUCm5xX5atZX5wLSpgVQk178BgL4h1vpqsy+Rt+Ul4dyryCV1u?=
 =?us-ascii?Q?/V7VoVcaKMquHJ2S8dcjLDchPz66G33RX96czGgZvfjosjiyJG8EM+rhu544?=
 =?us-ascii?Q?Xy/2GZbWmks+cdRSLMJspWckWJhLnWRyUaXw59Va4DkvUd/7ANEXXq8PTH+c?=
 =?us-ascii?Q?32EjkjaHtywjDoNnMuKn4otR/Jd/lfFxPcdcbDAtKdL5B+nNItshro5vp41D?=
 =?us-ascii?Q?6Z3fhAAGhqlY/JutS0ld7ClSlWpxFRlXXDynB7nediOeZd6dMV/8k47wH1yb?=
 =?us-ascii?Q?Xf4NQq00vG3WKU91qiX8EqRyJLdkaIUDn8V9HgSK+XocDrT34Yy7BAse8ciL?=
 =?us-ascii?Q?GQ2/2Gh58r62lca4CJlLqLworPxBN5r1JGhaiZQ/EbmADVwJ0gPGSKbuTCwP?=
 =?us-ascii?Q?/6v0NAjLLFCW1xvaeL8rbKXautiOwsfWmIKEaaiBrWFcSlA21BriUQzuvmXG?=
 =?us-ascii?Q?iQ2S4oHw9FjVT9OBGR+AiK33gE7GKf2AqUCKHUOAweRRLzJvHQgK3Kduhls8?=
 =?us-ascii?Q?+K0tbgYkc37hFWVYr1KV/EXKEaNUuLdO/iU81owzDoab21FGyHHnXznqRisi?=
 =?us-ascii?Q?chKFieY7ikFKHuziSVmKxw1ZOVl8aHVzu+UJWc41vjjQIlXBbW1/rqrY8TLP?=
 =?us-ascii?Q?lsj1dQbjHLmfkE3Wz2le2EwDc7a4IQw9/A4QihkMUeQg7m+Zxtj3680VI6yD?=
 =?us-ascii?Q?2HJYtOD5SW6QEB0QNYHbG4n4rMxOEtMbHPJ3yiYKd11n+Reuv4WQ7L1Zr47U?=
 =?us-ascii?Q?LtPsT63UTHyzSNe5kNjcQwBPlvimraMbMniQpojZHlv83PIhS/5RPPJNyi+f?=
 =?us-ascii?Q?pjINmS5u1BLNzxicy9aZ0vBIIRQYP5eMRBb3y9tmH5iIsEbSmCaoFtkeC8rw?=
 =?us-ascii?Q?guVGHWFho2rjFH3UrGXzqMbOn5QRGkPnnGgP4eHpXoLnaZznSphC9TBBmkT/?=
 =?us-ascii?Q?PPQMkMckpjnhnjSEENfFBp0Ln4zd6fF8EutQvThuufQMrF425Yk5s3YKokyu?=
 =?us-ascii?Q?ijo8pmCAs09ZOBEKgjjs6sh4QBMktX9F6lmYuQWvnf1JgbqrsMjX/o7SXoFy?=
 =?us-ascii?Q?BbLcPcPozJUZqED41FLxN2X34jqCMYmzPVYkGCRjvv5S4vssb171x5j0rnIO?=
 =?us-ascii?Q?tpNOCLarMZzv3SGQijBqCX1zFHF5k3bUc4g2WMpwH1drmKqU8rj3HQ8NMzsg?=
 =?us-ascii?Q?6kOrB1wjIvJLOz+Tq2MhecyEtwgix1HRlyGman4ZBQNJSC3I0nudUNAZBLZT?=
 =?us-ascii?Q?80ft4mEA4OZ2WpSx0pBfafo5dRZml5y6L6PcvF1tzs/7mXnbB3Yw1H+OFcOq?=
 =?us-ascii?Q?p+XJOcjWYPX58jv6EklPTDYrTDaNFJVIInrD6VBw4ptZBh+z7K3pp5EOwXxZ?=
 =?us-ascii?Q?qvovAsYakbbfrZHjkRsFmUZuUTMtMCHqkQhfaM0TX8TOVSc43O/euLSNKKMx?=
 =?us-ascii?Q?MShzn1uTtt2VhVvUDlc=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:52:57.5621 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8edba7c5-9d4a-4d3a-0ad5-08de186ba711
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9784
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

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 99ef0db8c4..f62b6cf2c9 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -11,6 +11,15 @@
 #include "hw/arm/smmuv3.h"
 #include "smmuv3-accel.h"
 
+/*
+ * The root region aliases the global system memory, and shared_as_sysmem
+ * provides a shared Address Space referencing it. This Address Space is used
+ * by all vfio-pci devices behind all accelerated SMMUv3 instances within a VM.
+ */
+MemoryRegion root;
+MemoryRegion sysmem;
+static AddressSpace *shared_as_sysmem;
+
 static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
                                                PCIBus *bus, int devfn)
 {
@@ -51,9 +60,27 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
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


