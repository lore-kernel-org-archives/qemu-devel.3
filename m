Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 365B0E909C1
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 15:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsN2k-0005na-ME; Tue, 17 Feb 2026 10:31:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1vsN2X-0005hO-TF
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 10:31:11 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1vsN2L-00077H-Gh
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 10:30:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hyA7Ljb82lz9lJIClAjK5KHq8nQ6OnRVv0JAjIU3OSN2FjXviWSwJXn88Zy9EfJNYb9DxGsauQNpFeo+zVaC+dc136qGhWq+DuntbEA4kTo+9BE7Tt65kazg/K1itvtn0uuchIWioFRSihJPRkTQmB1EIYd5dsIu0G+10NG8aQvm3dnYIfQs4o8/vUWAzQm+BbcLgxWQXyjK6S9i2AvU8Td09yWZ6w21WuubGbyY3X1LZsozda9+mByKVopQ3xCuOMxEVVyIwTy1XfWO/nbJS32f0Qkr0mqvXVFS/ZRkjzLA8Pc4tQWt3hpv2dGv+qEx/SB7zpS1cIilKvhRKsAnRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TuyBaWoelCVx18qm29+HVbKaglucZ6HTet0RqaDEb/4=;
 b=julPst6sX/LVrG5wLsi0F1hzxGf5wDS58ZRw/iIg+uvZ0MRXfDPnuwYQnqxckD/uCSgUWCKjy+nBJge1u2CjAv3IXb9v9tEThcS4TKZizB56Dtw/kddb5E8OrFZEEgYVdYeOE++f4iAUgwObmp3PAi18njV5yZSncQXNWv/tXB8LsnlYw9PmQz8R3K0IVlkqAPnp8p9vUEScG6Q+9nYI6+7JSkmGnLiKy0k83dCYgp8Qp6+dDCPGU6l+UMsB9PggYA+PnrfgI2IZ508blhXEenSxquHK2DDIYCg567Pg6CCNEXd3BHDKcP+pBzaGcxW71uS2N0SiWuP2dx4p6p+hqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TuyBaWoelCVx18qm29+HVbKaglucZ6HTet0RqaDEb/4=;
 b=S0WC6Q8oMWAxQ5lgIBGYfTd3pG3yGSFNlND64AyH8y/CLw58+HluRNAhGQsLya88gus7N/zhRSoD3ujbQGSm8HnjErz0n2dQpbZ/omip63i/69zvURZUxPgEOtmkGEpG/+nLtyQby2ReGui1yftRh9e+dgHAVr80w+ygotpdqcIIcM1eyAlmwIij/P15rdpgnkNvmUZ5DP5zD9xmM1a7nSoA/qyaoL+8skCXZd+KKFektGxBuIt8/zGqhwgJkgvj+Se3lqID5n+GtjTGqTyrdVzAyzkgBJ24eDcQsXCqpZYtUkMH3Wg7BGgANoI5yJ7hIIL74Slx8vr5vd3km5Gh+w==
Received: from MN2PR18CA0004.namprd18.prod.outlook.com (2603:10b6:208:23c::9)
 by CH8PR12MB9837.namprd12.prod.outlook.com (2603:10b6:610:2b4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 15:30:41 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:208:23c:cafe::f3) by MN2PR18CA0004.outlook.office365.com
 (2603:10b6:208:23c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Tue,
 17 Feb 2026 15:30:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Tue, 17 Feb 2026 15:30:41 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 07:30:12 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 07:30:12 -0800
Received: from localhost.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Feb 2026 07:30:11 -0800
From: <ankita@nvidia.com>
To: <ankita@nvidia.com>, <vsethi@nvidia.com>, <jgg@nvidia.com>,
 <skolothumtho@nvidia.com>, <alex@shazbot.org>, <clg@redhat.com>
CC: <aniketa@nvidia.com>, <cjia@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <zhiw@nvidia.com>, <mochs@nvidia.com>,
 <kjaju@nvidia.com>, <qemu-devel@nongnu.org>
Subject: [PATCH v4 1/3] hw/vfio: sort and validate sparse mmap regions by
 offset
Date: Tue, 17 Feb 2026 15:30:08 +0000
Message-ID: <20260217153010.408739-2-ankita@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217153010.408739-1-ankita@nvidia.com>
References: <20260217153010.408739-1-ankita@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|CH8PR12MB9837:EE_
X-MS-Office365-Filtering-Correlation-Id: b52db2f2-3377-4afc-6061-08de6e398267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3NDSMjlxu4pfdnrSKSmDREuk4w+sSLP6e2A8xjRGi05iDb2Zr9u2RI4826fI?=
 =?us-ascii?Q?ZbT3Kzb/xyf+M7Nm7yBKailh801AGiM7Etwp8qeMm5tnl7MhzoPjNp1R0hUA?=
 =?us-ascii?Q?auXCEjXDTg2zGQ0EZ6CnJPSNlJptW7Ma8Z3ZjcGrMa1z/GlNgtWnyBB3Ul2Z?=
 =?us-ascii?Q?Z54EDhWcRBb+QP9Z8GeNavNIv/6G5Mx6Y73N7OQ6rnBzmFNR77X0sCEWj966?=
 =?us-ascii?Q?1Rq2ttD5m4ECH665FKcTRzhcW+kRM7R0uXUuCXyeQAgTQRuyrqi9XK3ei9gt?=
 =?us-ascii?Q?68AatwUQo6hhmszI7NqoY3b8RHtJly6k3Xq4UsMreaOlW4W/zPJSmbYKWBpC?=
 =?us-ascii?Q?q60e2LSSqt28LjOaz0TbtJ/t61UHGb5bCsNHvgHfnubTYtSrB4/owT/FFCEi?=
 =?us-ascii?Q?YfLHppks2DM9ie2dQQ3VAYccgKu5xf6KgE6KSZnEjGJcJzb2CtxyWoi7TOQH?=
 =?us-ascii?Q?Q1z7wJfXIorsaR37aiEmODzNHhuzvvgLzuXKMYirWJ7DZ+iNqtcrNz64oLcm?=
 =?us-ascii?Q?ub4JDN+oe+2WlSwsRl+Feoy6RksoYv/OuodMufYFiOY0a2DRmQBQD9o6f1iU?=
 =?us-ascii?Q?z7g4AQOIsqHX4hThf07Xwm1Do7VzcwZkjgTZBe8MQbHvrbJopFueLlE3Cj7K?=
 =?us-ascii?Q?DXh5dXED5xEOpovybQsGb6nlcUuXm8dyLdGt5LLzMelHCS/Aoo04UKTdeOSc?=
 =?us-ascii?Q?J4WrHEwETa/z7ZGhNSYhN27H/IDMtjSBXL7M3KeMkXxTS904N+HfJVO8soWl?=
 =?us-ascii?Q?2TRTT4E4Y3HorRuhrV5v6QTVMe9DeoumlcNf0716YemmXrzIVsBjHCCULj4r?=
 =?us-ascii?Q?YqUZI/G/avzee4ERrsoA77b7IvjzTe/YKAsGsqqAF6M6qVxPOY3CkgUbifP0?=
 =?us-ascii?Q?ZKpOE492Mw0RmBFBaPXWAuXkx32w9qD8EtOKq5Mv9FfQMcA65TM5yooGcCKr?=
 =?us-ascii?Q?4iQ+Fcm2u/YPqltKNwg/omnEen8OlYi1qb+DJgPJTPCpPYOS/bTYgQ9JaF3P?=
 =?us-ascii?Q?syXBXNXn8LNaq9ElS5Z4TI5+c2e5f0OLI11/hg3b/7jienHowSjC4j9OzDbY?=
 =?us-ascii?Q?NIVKageQfymrJL0DX5Y+gCnq9ASpkIruqZCnNK+sO/O7OdBOcWmPewhg1RZk?=
 =?us-ascii?Q?7oYMzN6imszkkWvuUMbbfXeiHvRXkILifFFnRY78fZydBoTaL9aVmjX1qgkP?=
 =?us-ascii?Q?6pZFiHumNP7694Q0aLAaSABTslslGXcS+zmlXOWFfzmGHnbwcnykakTep4kR?=
 =?us-ascii?Q?RXgIHPmKjHY5Jchoh6v+aRkLgsUz8ooeNA9K3BbLaJnG2bEde/Xc88X379Rt?=
 =?us-ascii?Q?fepDpPRgO+jGyllJlgFFYIdKRJ34kok5yu1SU9s3pCd3JorYlMqyGOUlB7+u?=
 =?us-ascii?Q?932sVGlpZre7nnay13TJ/dLRT5nOiv1XTgSRflsIO5OjqX+u04RCRUkVkiiJ?=
 =?us-ascii?Q?/6LsV8mA6Q0H6DRidRsgIgtcHyVJp94VRnppTM9BmC1pCnU5N6ZUQ8EIQ55f?=
 =?us-ascii?Q?FoEJUTPEvkI8zcL0ECHwhy/cHXMNBWtTtxu3dQ4hHF0T1iJ5psrbzTmRr/yN?=
 =?us-ascii?Q?5pe50sxxZu8Rm2RRVqklZkDvEeHSx+f0UX46pCt3c+gZH8e5aTD8kp2zXDJ/?=
 =?us-ascii?Q?SVgew3sn1c2vWS+TNJHhPp1nHAmjDombS1qHZvVen8YKpypMilathSmz2b4D?=
 =?us-ascii?Q?kuw50Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: l9NnRZTJLTqrhKwpBYnVIdzeD/hh/QvWsKZun7EQgU0O0+grwrqL6buA895cPFNP42SQrNGrTTkQzOXUDA/XVk0IbqFIeNqxx/6LAcJRXsR6LGWveJSSFJ9fJPbtY+r6pOduYZ2ycwL11P6u8S5qh/l5yQsepVdF7spaqxi62cF+d2gVz8VpxHtWnOHAwpN576k5B1prszanh6+8hd3tzhr31Q140srBDhOLvkCd0Dl7eiFzR2DEBYPVZt6cuYwJuim5mSyW0VjadWOSQJ5JYAmaM0p/KjzOT85IHHU+8f8b4O6Chbe2N56UuqMKW5F8hJI25BBf2Cxs4urKB/JFLZfKTuuW3aFmQquDUiNIJEy3HAS/FGMLIpgnNbygUZrckEFzHZoDRPcR7UeGRQlkvAE6kMs3cRVfi7dP7XNM9lxHUD+mXa3BNb60a8usxi1i
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 15:30:41.1256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b52db2f2-3377-4afc-6061-08de6e398267
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9837
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=ankita@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
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

From: Ankit Agrawal <ankita@nvidia.com>

Sort sparse mmap regions by offset during region setup to ensure
predictable mapping order, avoid overlaps and a proper handling
of the gaps between sub-regions.

Add validation to detect overlapping sparse regions early during
setup before any mapping operations begin.

The sorting is performed on the subregions ranges during
vfio_setup_region_sparse_mmaps(). This also ensures that subsequent
mapping code can rely on subregions being in ascending offset order.

This is preparatory work for alignment adjustments needed to support
hugepfnmap on systems where device memory (e.g., Grace-based systems)
may have non-power-of-2 sizes.

cc: Alex Williamson <alex@shazbot.org>
Reviewed-by: Alex Williamson <alex@shazbot.org>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
---
 hw/vfio/region.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index ab39d77574..8fbc98918f 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -149,6 +149,19 @@ static const MemoryRegionOps vfio_region_ops = {
     },
 };
 
+static int vfio_mmap_compare_offset(const void *a, const void *b)
+{
+    const VFIOMmap *mmap_a = a;
+    const VFIOMmap *mmap_b = b;
+
+    if (mmap_a->offset < mmap_b->offset) {
+        return -1;
+    } else if (mmap_a->offset > mmap_b->offset) {
+        return 1;
+    }
+    return 0;
+}
+
 static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
                                           struct vfio_region_info *info)
 {
@@ -182,6 +195,35 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
     region->nr_mmaps = j;
     region->mmaps = g_realloc(region->mmaps, j * sizeof(VFIOMmap));
 
+    /*
+     * Sort sparse mmaps by offset to ensure proper handling of gaps
+     * and predictable mapping order in vfio_region_mmap().
+     */
+    if (region->nr_mmaps > 1) {
+        qsort(region->mmaps, region->nr_mmaps, sizeof(VFIOMmap),
+              vfio_mmap_compare_offset);
+
+        /*
+         * Validate that sparse regions don't overlap after sorting.
+         */
+        for (i = 1; i < region->nr_mmaps; i++) {
+            off_t prev_end = region->mmaps[i - 1].offset +
+                             region->mmaps[i - 1].size;
+            if (prev_end > region->mmaps[i].offset) {
+                error_report("%s: overlapping sparse mmap regions detected "
+                             "in region %d: [0x%"PRIx64"-0x%"PRIx64"] overlaps "
+                             "with [0x%"PRIx64"-0x%"PRIx64"]",
+                             __func__, region->nr, region->mmaps[i - 1].offset,
+                             prev_end - 1, region->mmaps[i].offset,
+                             region->mmaps[i].offset + region->mmaps[i].size - 1);
+                g_free(region->mmaps);
+                region->mmaps = NULL;
+                region->nr_mmaps = 0;
+                return -EINVAL;
+            }
+        }
+    }
+
     return 0;
 }
 
@@ -213,11 +255,13 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
 
             ret = vfio_setup_region_sparse_mmaps(region, info);
 
-            if (ret) {
+            if (ret == -ENODEV) {
                 region->nr_mmaps = 1;
                 region->mmaps = g_new0(VFIOMmap, region->nr_mmaps);
                 region->mmaps[0].offset = 0;
                 region->mmaps[0].size = region->size;
+            } else if (ret) {
+                return ret;
             }
         }
     }
-- 
2.34.1


