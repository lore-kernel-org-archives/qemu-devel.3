Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ECB8C021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 21:39:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlEGJ-0003cb-Qs; Thu, 20 Feb 2025 16:39:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tlEGG-0003bq-Ii; Thu, 20 Feb 2025 16:39:12 -0500
Received: from mail-sn1nam02on20629.outbound.protection.outlook.com
 ([2a01:111:f403:2406::629]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tlEGE-0006jL-JZ; Thu, 20 Feb 2025 16:39:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBLyCEM/w1Rf55eVVUPhSYK5vzqcoKCvGU7ZpJIaJlA83s5jqubdO0j8o/QpWCNLTdegmW/v5MHzP9KtZVjfiOblAF/6E1u9b0vpl3oXryhS2LFyomAaY5PodgIfkanpOHkIaAVJPaFN9hvpqkmEb/4o0VMjwMr9oQJB+y7vwUdVEvydAcxorXy4cZgede9GCzYfLL9IgUu2GArPeFJvjw/Z/YH0Qj8EOEmYUGw0X4am4GN+v6N1wM3H3sHq6UiU9ypfPdGAiPmTQfVvIGzDasZtagbkNd4dQh/CM5QmeVXFXWBbqrVHuU8tNTnQJzuVrCUcJAxSpBBYCm8HRWErLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OkLWlLEZ5OBUGv6BS2YbatOvQgPH/3HBipNwtBANew=;
 b=wWTu2nlNs+oVuYjjO0bujG5OfHQfygVSYqRRf4mrKbW7KSPHWD3iZ5dlrFJZUINv/Z6LzstTOkvstzlm0/LOHixfRwCA5OyI7W993AeCRMa6JsrOdCWPcTo/yHfzxvh5F1GHfZWoqJ/ZgAlRaxtWIC75keg8Y+WTFEF1SfhnVl5di3XlzPaEC+H/rYb7CvkwuV1i1OokmQhUcLT93qcx7SjIAI+4MRdpQHhTH7g7tV34lgxjYOQ4XXYyiTXz1DrSEf6YPHCrWXWN1eU8/A6WOYImJZWODkrg8Ym66blzKaBc0Ssh00bAc8I0tZlbNz781pjxcx8rKGowKPVL/QTOqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OkLWlLEZ5OBUGv6BS2YbatOvQgPH/3HBipNwtBANew=;
 b=ZJZyeGMCWjpSrrZWt2Ps/tGjS7yh6gsWsCLOhehDwxJ/GfHqgsEGT5kjRETekrnxLJMa1sRMjE3ecO6wDte5rSHD9REuoj1ou76KboL3nWCla/bioFfnfOYsR7t5CamSaN75qzFZf8FsAClxML5Qs6MxmvjYigqU+Qb+eNn8RN7krASJvAftDX+B/pjrr8ebp2LXpB0CP4VVbP/DpgBstLaRszrw6OEeQ9977p6s1ooLlqCZ4lx1QjzYgSbnR5iz7Gnb9zEXBjiDVk5Qh1NgpB/Zj6/TENcevQDk+0hOa/LFZWSw/KvWwkK0newAwV+OJ5d0g9jJIF8mwegkzXob/g==
Received: from MN2PR19CA0047.namprd19.prod.outlook.com (2603:10b6:208:19b::24)
 by SA0PR12MB7001.namprd12.prod.outlook.com (2603:10b6:806:2c0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 21:39:00 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:208:19b:cafe::19) by MN2PR19CA0047.outlook.office365.com
 (2603:10b6:208:19b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Thu,
 20 Feb 2025 21:38:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 21:38:59 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Feb
 2025 13:38:37 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 20 Feb
 2025 13:38:37 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 20 Feb 2025 13:38:36 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <peter.maydell@linaro.org>, <eric.auger@redhat.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: [PATCH] hw/arm/smmuv3: Fill u.f_cd_fetch.addr for SMMU_EVT_F_CD_FETCH
Date: Thu, 20 Feb 2025 13:38:31 -0800
Message-ID: <20250220213832.80289-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|SA0PR12MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: d860601a-87e5-4914-aa4a-08dd51f6fc69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xWoruRy/+aFd0oLTeVb0cC/PquXVF0Eb/amb3alQOoQuDYEpWtmyYGZvsf5c?=
 =?us-ascii?Q?mW3b3x+vCIlNnF2L06ddgN2BG/stv8kyuvR2CMW+2Z8rNOwe1MiyBHy7UAsk?=
 =?us-ascii?Q?R3IoNgJUfYq3PQmiJMGtPjttib2bc0lneDBbzERNa5P5SyvDM0ry/JmJXhx6?=
 =?us-ascii?Q?7HkNNlPcm7vgdABmc02HzgCBpglxgtQEhDybWU2gB9eOfqgLrXUmFM/rOljN?=
 =?us-ascii?Q?OkaJukfCImqU6dgGgath0CvYRoXtxYRoaNK8cSYqBXXCxxVv/xTK/sDPb0jv?=
 =?us-ascii?Q?CJO9dss7NvCuRXGwKtzjRTClQ35nTtIOV/Ep50grZqbdfj/nadheI/vNzWD9?=
 =?us-ascii?Q?SiGIROm+2LSarPHOTX9snB4e+7+10Ar5j0ctFezxTTintfO5JdLuYKlVpRII?=
 =?us-ascii?Q?IlM2vIivcZHdg1iYoMP9upR5VJsp3iNeJjr4ZNbrDI+eEeGRjTrXnGPp4ouz?=
 =?us-ascii?Q?E7H4TEReB36nQKzrWuTjRzCrzqVZL5jk0rlXWxuTtgVtKJH7g/qNXpi8wQh6?=
 =?us-ascii?Q?iiBCCG76lB8c8feya2/xmWKf/PyeZnVGIzdmZa/enxjG12JKysKtc9mKto0P?=
 =?us-ascii?Q?YmWI1sclGvEZ0HMwLbxiwkBIeQExknYWBJXU+3gp1lr0knA1NnJNvmtVTXBd?=
 =?us-ascii?Q?VfOGMUB0I2yDvIbWx82pHGtTbQ/VpezE+YZPF0Pd6meGRrnu9VujzhOIx0nY?=
 =?us-ascii?Q?Mdl22SCFPfp5FKIwl5LC9kGOmF+O353HXbgEoMJSz3/Shwt8gEabF6TII9k7?=
 =?us-ascii?Q?zSdRBVJpgXq6Xsg0kuCbs84ScUduM1HNmn8kx5srjXfC7SDpdtHFdDryKqF9?=
 =?us-ascii?Q?kTI/0eAPJt2SB2LLrbI5cU//cfPtU3JQ1rmBSP0nyGpZexowiws6NxpBc2jt?=
 =?us-ascii?Q?j0OBQWjayLij08zjsS6LHQgD6y+7drNRQiC1D+9QpeheaJMA9nQ6P58bVgSQ?=
 =?us-ascii?Q?T9XfgrsbzYYo5QXNQM7hhLaSvyNo3pqfCVUbQluwbB7MBrOuTBNuDKaSYYoO?=
 =?us-ascii?Q?t9DtBLKDqD1/AoZ/eC8KI4yPvtJNHymrS8TYZJs3mQFwRGi0JLK+OhJumqQ/?=
 =?us-ascii?Q?CW7lRSsAe49WlfVYRzsqzR9Zdwco/rTQ6QI8h02b+JUCvJC2lxAe6eJIVPbL?=
 =?us-ascii?Q?8eo+KWS5PoXMDYZPZZtQ+8X96xdNqB9L98MJRgBpVPD13T8WcsemduFMMNGy?=
 =?us-ascii?Q?kFpJV2GpbYLJrywLYOqy1XZlfvEl3gu82HxpMC2iB+iGSuFjJhfr3c/zcWF2?=
 =?us-ascii?Q?ID6sSB5ld3WE/LVNI3SfuHfO+eScJsLod/ZvUB/S93RBPKw+llS374c09BjP?=
 =?us-ascii?Q?Nm82CduFijGjJS6xYjtSvOSymqnamh15jEGsol9mqqi8LnZHRVqrMKEnT/Ct?=
 =?us-ascii?Q?hgbDSZMiB9V90WgS4Sq3V/HBffUs3dSnK30O0+TO6nHMrwpNsZ9fIC8jKKIk?=
 =?us-ascii?Q?sJ1Nf/38lQqShmjf2Aa9HGPoAU1DF+nSZCpG4wpumJi8JEdrmjgyG0x8Rea3?=
 =?us-ascii?Q?cBHscIu1jA7Xoro=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 21:38:59.3035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d860601a-87e5-4914-aa4a-08dd51f6fc69
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7001
Received-SPF: softfail client-ip=2a01:111:f403:2406::629;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is more like a cosmetics fix since the f_cd_fetch and f_ste_fetch are
basically the same field since they are in the exact same union with exact
same type.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 hw/arm/smmuv3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index c0cf5df0f6..a6ffe124ea 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -377,7 +377,7 @@ static int smmu_get_cd(SMMUv3State *s, STE *ste, SMMUTransCfg *cfg,
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Cannot fetch pte at address=0x%"PRIx64"\n", addr);
         event->type = SMMU_EVT_F_CD_FETCH;
-        event->u.f_ste_fetch.addr = addr;
+        event->u.f_cd_fetch.addr = addr;
         return -EINVAL;
     }
     for (i = 0; i < ARRAY_SIZE(buf->word); i++) {
-- 
2.43.0


