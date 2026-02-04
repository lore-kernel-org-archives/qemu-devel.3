Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA90EA7941
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vni8I-0004TW-0Y; Wed, 04 Feb 2026 14:01:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vni7x-0004R7-O7; Wed, 04 Feb 2026 14:01:27 -0500
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vni7u-0007PE-Ut; Wed, 04 Feb 2026 14:01:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+QEJ1Aa00K6PxKCGwypzWYcD/E2lAdImCUjl7sJ1oFmnYUXRqaSLYmGAgqigEbxYcs5r92EGyflS9/4kGKIoIfUE6dBW0q4KUrelB+7t5aSO7VmMNAPpOts7P1ItRV0XoBi9T7JoUDvdI4QHoG4VDICgPb8S9jzhG+FegsZ/0VHCZ67xYtE30kNF9TgNy5BImyLLXRuW2w/N1WZY76GG0prcm8Hy4IoLDaZLcbj/Y7TZ+vq2gqUNYhTx+rQ1AqOPjgVnoodzTPIHmQUy+eBumMMryAb8Z7N3S5+QYVF0VbLXcL+NiBXDmkUc0qpTLPUUpYou56QmEgubuBxRNZ0BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ycu09x5+AMl6CPx8Tqte/7f6H7C265/kylCqIiPBUmc=;
 b=syiWqrKpBvTJRARWKfiQRAFdlwObZC1vA2S9ev7ewEckaABUCm+Q1w1DcMfrRQO94z7j05aOtZehlsSjVz4RvdjitJ6jlPmTd4rzrzFNcCAtNtVYbcWwQTo1+ycV/o3H4+hFyjjy8SSrjDHjm1M5OLMch+lTsJA9qssv6CmDSvIeRhQe9kKVrxbVtQxejcC3LA3o0Hr1D5MJqxBCuXi4bQ6whwX0ywFu7xRe1cv21n0myYOCl/wEBruLfWk2njKGG1cguohMnvY58wucB+cfJj9wDYKaDLi+TlMGKb/HQjhEg+2MXs9fDXspN5oVAkSJQGSaX84eZ2f4tg1b7iK0og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ycu09x5+AMl6CPx8Tqte/7f6H7C265/kylCqIiPBUmc=;
 b=YyO86MxPVHFgyLPcZoAJ+b4H+hJW3oGECtNbn/s5hHLQtwPhCHTgx27QRdQLOWckWpgxeAfTSADI2z5XiMR3gLMMD/nXA1HBRh01XZc+al50Quy93eGJPFt1FxU5xHPcXPTwZzVc5peXIg0TBJH+9FX+AilhG5N+sfH+HX0hMHxRGpw/1lCazlrwfeZpup5G2ohcKp6xam6lF/SNI2x2ixVIPPUKbyy5nmPrOFnM2SNq8v5LY40EerhZd9f1oiVcb+wAAfnul2sM7O+MaAHIYeJq3/Uj6bLcEFyNDMxHKSCp3WY4Ee7XUozm/s8WWa5RU1T/KLqoZTum//0b5vpFcA==
Received: from MN2PR18CA0011.namprd18.prod.outlook.com (2603:10b6:208:23c::16)
 by CH1PR12MB9648.namprd12.prod.outlook.com (2603:10b6:610:2b0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 19:01:14 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:208:23c:cafe::5e) by MN2PR18CA0011.outlook.office365.com
 (2603:10b6:208:23c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Wed,
 4 Feb 2026 19:01:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 19:01:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 11:00:48 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 11:00:44 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v4 2/5] hw/arm/smmuv3-accel: Add viommu free helper
Date: Wed, 4 Feb 2026 19:00:05 +0000
Message-ID: <20260204190008.20070-3-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204190008.20070-1-skolothumtho@nvidia.com>
References: <20260204190008.20070-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|CH1PR12MB9648:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dfb30da-8bb6-4cfb-5afc-08de641fc467
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IX6RBShtXLkJlLPJTREg2CZ6MR2brgS8QjbwpncYLkW6bDkNGoBQQj35xX2K?=
 =?us-ascii?Q?wZSACXJo1/jUUptxl8aKccNrHUBreKBFdToyC6vRhMadrkO0XbDlC8lI8ZtR?=
 =?us-ascii?Q?RHuQ1QcmIVXD2parrNoCILhH7ZJsBBFP9WPMbx9sLusAF9n1sP2M5QAE3PsX?=
 =?us-ascii?Q?lh6boxKhHqdbmcXzboLbaxFQmZXhPfKxngSEMzcGPmK72LzoPmRcfJwrP/CE?=
 =?us-ascii?Q?wgzTjbIUKyhbB259iXuGYMUDgO+zFmKtAJzOtGpM4ZfmmmUikL6lM4oVYYhy?=
 =?us-ascii?Q?DAMeGhZKAc/Z2BPsyotp3I5g8HlISxa1MrYpdx5DnEeOTsI1pfOvPXHHfUc3?=
 =?us-ascii?Q?NfHup6ygoklWpW9eIhE/N/x3lTuVIWWjVtPJe5g34ESb8gsxbpvR6jniGdha?=
 =?us-ascii?Q?vSXHTCXPZiMQcBd+bA+MdeZMueYR/UzvsGB85JRiOwOwNTSAyqtZnwmmmgla?=
 =?us-ascii?Q?nRpZfAe5zAd/hfCLwMlcMNI9seia7MUzcvMz2uztn+PgcTiH0ZTcnb0L0s1W?=
 =?us-ascii?Q?cVSvzbgFmAXtUwRbdoo0KBfYkY2dfrH9tngG4rSObEGQg2ry/fEpr8QHhwTU?=
 =?us-ascii?Q?szDWePZJd4uR3IUZsmzpPL7FTI6GLE1f/pxnyL7aw/zIsJI3vd22sR/21Tym?=
 =?us-ascii?Q?OYHAd2qbdoZRwUamu9lqIh32nZRo4FHjZUtl0IDPKWbcVxzxYfuWGVCigxGB?=
 =?us-ascii?Q?4HCWwjouZQJ1n8PiBofXSOT9reArfLUJoZ50tOGyNQIKkRbNRKEpdjE/z4FB?=
 =?us-ascii?Q?mwIWQ2n0NZPniDkcK3UudSfLh8xiFArlBhAiVQatuoVtTk1i3eaIoPzEEadT?=
 =?us-ascii?Q?HXps3h+//gE8ykn7Gm9NlDxOChUPn2xrwUbAlkk3u1dAFNH8OMR9DmSd82U/?=
 =?us-ascii?Q?1i3pEQLO0GbwvGR+8+Ky1AmC0zc6B3l5pFQ5dtZ6WYHmfGyOeW424Oj0uX43?=
 =?us-ascii?Q?eccux420CFMDezqTvQtVZPYdykACLB+0TVEN8UrWy0MSoVSS5nwoywPtHyfl?=
 =?us-ascii?Q?c6qUeungig13h7bc4Ru9kFEn0qiAt5hFTjlt2m6TTwwkXNmUqs7ESflGVKV/?=
 =?us-ascii?Q?+MNr5mvbFO8sI7kW88C2833NLW3g9C5BAMIXVgsBn1UTFmvPW/c2VwlD9ifG?=
 =?us-ascii?Q?0B2Lhdh9clxhWCKRYdG2RZipQNQbnkYX5POtVP2h9vM3YDhW3p3JfyFgsms8?=
 =?us-ascii?Q?HzpHiKHj8xl6r6SoObW9RPjL2rPA/JB6G3SJCQUw5SSZu8r3hRSv19l2komF?=
 =?us-ascii?Q?B7HlYyn5Tf3kwtd/gTrPD12XILtbyEUbz2ZjO2zj1lT5i2tje+rZsKlhnZ+B?=
 =?us-ascii?Q?riWJfqZffNzNuO4oRiij7Habh5kf36LkYC1T9Fupp9SxYynmLW343QT1Z6IU?=
 =?us-ascii?Q?ix4yjGpvepMVZir72jyA0jhaF2VuuQNx9xWeSr2SUp+SmVKHYRmBNFjmDjAI?=
 =?us-ascii?Q?wGS8JuxSeYqV2100Bk7WXtMbwsmBoDiijqVnzRxWF016vzRfDRqd7RDPdMZ1?=
 =?us-ascii?Q?KIUO2bTQYoFSRr0A1HCY3BGH5Dmu4MT++Ol0zUlkk7ckcKSQaBRU75Cz9CqS?=
 =?us-ascii?Q?PnUVkDVa4r/WKXcisS5861emobMh84a900CjXmqsfsl2bPZcxgeBT+wZN45l?=
 =?us-ascii?Q?JbfFXhR0tDZ7285+0fg34WnUaNNiFh/lknLFEn5943kQIrW7vy4iMu8kR8k1?=
 =?us-ascii?Q?EOX2hg=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: casGeviQFBuq1Sg3udrWw4imh2kS1x0cen7uJJ9M8j8jKW7l2jCaq5rhx1BoK9rX9XTOAiGEe0M+nt3gVd7nnrVbUlJrffHJeOy5yfanihsXcEMNluRV2zDlKMcwqA0v4KC9JVb3ozvsgGna9LGw0GDdjpt3gbx378QiFTqqmqPkAnkrp5vn7vUjvZqErONFyLhIFfgtg6WJ2ia5p/scIZBaIdX3qzYzQ1NibsD8vZhTQA7AbnSn5K3n35yvR8tfMTpAa8mZ1vQ/LiI8ucVNy8xJtlRILRpzM7oLVxyoqzDjeHz6zRJYE0qb9WG+96yxxA3S8dlKzFHVC/Pf313eaVyTFCwxuPjGOzQt75PlVooQbP2lnlntteu7KsULagnXZpfivuUV5d3Xt6K8oHqOf4QekdO8WFJvv6VKeCXh4Rmr/Rj9cmvP9ukIHM3kNI2o
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 19:01:13.3283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dfb30da-8bb6-4cfb-5afc-08de641fc467
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9648
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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

Move viommu teardown into a helper function and use it from the
last device removal path. No functional change.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index f5cd4df336..c19c526fca 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -390,6 +390,20 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *bs, void *cmd, SMMUDevice *sdev,
                    sizeof(Cmd), &entry_num, cmd, errp);
 }
 
+static void smmuv3_accel_free_viommu(SMMUv3AccelState *accel)
+{
+    IOMMUFDViommu *viommu = accel->viommu;
+
+    if (!viommu) {
+        return;
+    }
+    iommufd_backend_free_id(viommu->iommufd, accel->bypass_hwpt_id);
+    iommufd_backend_free_id(viommu->iommufd, accel->abort_hwpt_id);
+    iommufd_backend_free_id(viommu->iommufd, accel->viommu->viommu_id);
+    g_free(viommu);
+    accel->viommu = NULL;
+}
+
 static bool
 smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
                           Error **errp)
@@ -549,12 +563,7 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
     trace_smmuv3_accel_unset_iommu_device(devfn, idev->devid);
 
     if (QLIST_EMPTY(&accel->device_list)) {
-        iommufd_backend_free_id(accel->viommu->iommufd, accel->bypass_hwpt_id);
-        iommufd_backend_free_id(accel->viommu->iommufd, accel->abort_hwpt_id);
-        iommufd_backend_free_id(accel->viommu->iommufd,
-                                accel->viommu->viommu_id);
-        g_free(accel->viommu);
-        accel->viommu = NULL;
+        smmuv3_accel_free_viommu(accel);
     }
 }
 
-- 
2.43.0


