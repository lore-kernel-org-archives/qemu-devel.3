Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD5AEF586F
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 08:56:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrXuh-00025j-Gw; Sun, 15 Feb 2026 03:55:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1vrXuK-0001yE-L1
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 03:55:15 -0500
Received: from mail-westus3azon11010042.outbound.protection.outlook.com
 ([52.101.201.42] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1vrXuI-0003Kt-Bt
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 03:55:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GPTOCR1OPIKjSK1jJd3aadl95vSDdRQyZcTNi9qYS7F2Or+hJjjRxiRstME9UMdXMKANnoCu2X8ST6zg2nWj4NwpP3+R6NRQvwH+sRsYgsycNpoXx9RUgk7rM5RU3PJOa+UMmn+pHP4F4rvVYQPWFGv4mJ0y5GR/qRMs3VRPmXfy71ZWfdttUDKIWp5zV59dbNtWnZCI0n7db+MWWWQWK9qHtTQL2rXU8XUzAmw4czjVjnVNWrOsdarfDSvAf0gXVhWXO1thKFCpvnGAXVzGVMaUXUWeKxr64BL6yXLsJDUyBFtQH9Wce3n+vz/uYQhWB7d1sDM9SHbZLjHhAWaoxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cptZhIlRWTwoR+uNE8PDuG3WAnUlxHkFhhPc8Knl+tM=;
 b=Le/sxLzN6qixKtmAv1Esqpt0kPjCa1lEvQx9rqDzDQbRjKe43v7wsjQOiXEqbSKbqbGmJXK05DF8cXmJEgYhypkNSnmIjaM/7cFh92qh02jy+0ug6G5HOKORuiDiVhBBCR4vmjlDY4uObMWjiTqPAiikzJ3zwN7a8PAbd+ftsU4AAWNjZo24R0R40cVOTYTus5Aj4ZevfOSBiZ5QZ9lTzXTMsFOv95J9+tGBlFZd8cFMn9WPN/qOMb0Nbk2mDwK3mHFnCpJlKg8SWSuIU8aTx9dPmbRa72pHLjNVckWatzd7GKgNYRjJH6hEFSxG80gBlm411glqev+DqIT6vZDvFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cptZhIlRWTwoR+uNE8PDuG3WAnUlxHkFhhPc8Knl+tM=;
 b=Se1TQ+kPHGEYLH4aoW1dJDsgR5b4LiwNq51rCzAUc3ZFgwhBTSj4Hba/XwZhdaFCxCvFV9buVclaQa4MLAWvcvOSIWAnga5EWvoZzHwx8XWRt805KLZnhklRmTaw+4EkZIgmemoSyTJ7TkCJlb4xbqdUnNzvOD6yRMscaaR8h4rV/8TjsU7xDyVF5rRkBQj8ZLuUCnE5GcQB8TUQ9Oz4bx0g+1IgrUj1nvI4Dzuhc8ez3VUoSa7FzmvSUOAS0Vf0DTOZwvJVKRSyw/AU3bL6pPShOr6k9vj6Hnb6NF70L0fwEW+vsrW8CCs2sud20RNq7EZ+sJJLr/9JUb3Wm4tXLw==
Received: from MN0PR02CA0005.namprd02.prod.outlook.com (2603:10b6:208:530::26)
 by SA5PPFCB4F033D6.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Sun, 15 Feb
 2026 08:50:03 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:530:cafe::6d) by MN0PR02CA0005.outlook.office365.com
 (2603:10b6:208:530::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.15 via Frontend Transport; Sun,
 15 Feb 2026 08:49:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Sun, 15 Feb 2026 08:50:02 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 15 Feb
 2026 00:49:51 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 15 Feb
 2026 00:49:50 -0800
Received: from localhost.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 15 Feb 2026 00:49:50 -0800
From: <ankita@nvidia.com>
To: <ankita@nvidia.com>, <vsethi@nvidia.com>, <jgg@nvidia.com>,
 <skolothumtho@nvidia.com>, <alex@shazbot.org>, <clg@redhat.com>
CC: <aniketa@nvidia.com>, <cjia@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <zhiw@nvidia.com>, <mochs@nvidia.com>,
 <kjaju@nvidia.com>, <qemu-devel@nongnu.org>
Subject: [PATCH v3 1/3] hw/vfio: sort and validate sparse mmap regions by
 offset
Date: Sun, 15 Feb 2026 08:49:48 +0000
Message-ID: <20260215084950.4657-2-ankita@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260215084950.4657-1-ankita@nvidia.com>
References: <20260215084950.4657-1-ankita@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|SA5PPFCB4F033D6:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b2385d1-9f48-4290-3572-08de6c6f356e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b99aMedxKKZH6xpOAiuaeJ8bbhAUX5p6zbvkBYAOo09xPG8D/Hnt3SFt0zOf?=
 =?us-ascii?Q?W1X8xvmoyd5ECxeBbbojsoQ8JgnP4jwAVeEmhaZ7wvdbqNleoo20vKJzC5vX?=
 =?us-ascii?Q?qCvAalei9Evsyyy0rbKfr7ip0wpi8adrviB8jlUlkBjNaezkmN2TadxemMG2?=
 =?us-ascii?Q?G/B5ZENenA+LHuJwAvPr2eY3tUHpg93X8+IJxagAfYWyaGzrrs9pljL0DS2m?=
 =?us-ascii?Q?J7apyjjw5MM8P0gCGUBca5K/n2OCSLLZNRGiXI566ojH0uYufeV5sSUcv2B3?=
 =?us-ascii?Q?HrYZ8W2m0s5JiOhc6fpuQXPb/ZbB6pruiEar/mGBH3eM0CwhqT3aZcypcsmB?=
 =?us-ascii?Q?a3XhXkwNfP17jQE6MWn6yeleGL4C2oPZIczc/vaFDsT4nSPnvwqOrELCI/69?=
 =?us-ascii?Q?A4wtYw6kW0tFFW1zpWoORA2VA5v3M1jIqHKYJaVcAT73cnUM28XpVqtFYK4P?=
 =?us-ascii?Q?B7V1ldl5jFQypGYBGZSmJ7IRsJWUrf5wCZLOpuDPctSDkS05hthG7lASY5kP?=
 =?us-ascii?Q?PZ5QYu2cfgM2YzlhANxE8yo1M3+Le2nlI/BKaBpxI+nHAIAiik73maE+zh5a?=
 =?us-ascii?Q?6iZaG+qgcT/N6SNbavBXByDeyi9RDoKju49/n7GXXBa+ZlA6cyCq95TdIa25?=
 =?us-ascii?Q?uKE4hMnrwOPSCtw9TaZ+nq9SgPGS3AxBBqOT4EyQ9kcF8Beo8kX2U3Cx6mAX?=
 =?us-ascii?Q?QuntONsD1nu8OsldrJsbIakPHfn5W2/BDbm/Nys/ckkmKdXdZAXGgxQTFTs0?=
 =?us-ascii?Q?VXPzW4RwKsTPtADoiwBu8b0pE8YcpgFDCaivToQXfQeY7yvwERqGe/9V8nkF?=
 =?us-ascii?Q?f++9UGF6ICO36X9qcdIMJ/ORdROC3E8ACZrjocxiQ6xU10tNmwRQndEm4VO8?=
 =?us-ascii?Q?9iNP+55xYVpOyDq92mGTuGQqm11TehVfVdP/aTf5IT8Lv+FjnWMdUL1Ab80S?=
 =?us-ascii?Q?Tu5bj5SXjqUcZEguELc9yL71h3ScZb6CqOOz+1n2hbtYseVgj0e97TIOfTr0?=
 =?us-ascii?Q?btke8sqmJGpkQWkk1hLRCNcYhLefIuqXMgzn1cTrlRI6XM/xKTQUH/XoXpK1?=
 =?us-ascii?Q?zfL4+ZkDRAEaM3TInoBGcFEk3K5hIDuMLgfn1XOGzRREOn/XtTXNK91j4j3R?=
 =?us-ascii?Q?CqKkSBPnvAyM2/KsAq8Xn+ZBAwUyGD1nrs3XFqFXCGQiuQCQtVqBwoEflu8Q?=
 =?us-ascii?Q?WMZS+uEv7kRTEuYmXagPS2p+8g7Vg6SmCuMEZCKZ4FFHFbvoKJg0gL7uYPwO?=
 =?us-ascii?Q?7bYMXlghPuX1rWeY/xwO3/jRPJSfw9NFXKky93H6FhTfMvm7LdazSca4oftC?=
 =?us-ascii?Q?vT3eOBhPhOtTkLvCYmHupaviVa/DKJK2xMI1hC2yCoIIm5LDcIE9/JdP3zVS?=
 =?us-ascii?Q?DbTlDg+J9RGfQA2bpmG9a0PG44z6GzrQZlGo4Cig5mZziuNi27IMHaedcilK?=
 =?us-ascii?Q?iPhkeFKBRGjTi59r2Ev/w3e2/qnLtj0+HQCUTv1akEqlk6iycGSWoaFEBjLW?=
 =?us-ascii?Q?bvrRJwQVppGhz2ryMRXyufTE05jXpUZlJs789GNOGYntTB8SA9IbfIgC32Gi?=
 =?us-ascii?Q?PL06kxOytZ627epLIPBKuPSmU+GT4d0FQ8YdpLaJ5KE6xZHQyJDqCYq3teTK?=
 =?us-ascii?Q?BIJKet7z4T86b/rG7P8rTVdDeXlPW6t2Yp0Y1h8FlCClKumyc7jfJHpgOdkg?=
 =?us-ascii?Q?QFUjyg=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: k811FZM3iiy+nFjkTFUO/j/eC01RhhoZ14MhratyTkq6GvX904JxwOCieBEWRY0c7paml7kFW4HwwXNnCxJGmVMCNVRzh9lsDvbaZB3j+lec8+Pyo9Szw+hWn+hrg2cqAPaL8qdGigqsccWimc7v28Wu5EgGDIzzBcn0X7K3NRfduxRbkVLxqp41UkzvVbYGPRcZl7Vgz2Dp9yvgZIGO0ZT9pleV2rQsbfc2nzwAJPCzA1vAwLKNMReJFzuFcUVKUefjUIuRKf346+17J0ZDhyHaUSqUHJvKIVv7r+sTf23vCCZ3QFB4KG/JW//hFj3JeT2QtysFFPmp1tc1KS66tg4wDdgmhRJKv5LV5bxU8C3G6uEhcdwiITfM1u5Wa9yXha26yP8ziutbgJyKJGUvudeDT52QgjPbaNWyPRKnpQUarA7RD5tBsIGmt5Z1R7dV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 08:50:02.4876 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b2385d1-9f48-4290-3572-08de6c6f356e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFCB4F033D6
Received-SPF: permerror client-ip=52.101.201.42;
 envelope-from=ankita@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
 hw/vfio/region.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index ab39d77574..177494c379 100644
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
@@ -182,6 +195,34 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
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
+         * Validate that sparse regions dont overlap after sorting.
+         */
+        for (i = 1; i < region->nr_mmaps; i++) {
+            off_t prev_end = region->mmaps[i - 1].offset +
+                             region->mmaps[i - 1].size;
+            if (prev_end > region->mmaps[i].offset) {
+                error_report("%s: overlapping sparse mmap regions detected "
+                             "in region %d: [0x%lx-0x%lx] overlaps with [0x%lx-0x%lx]",
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
 
@@ -213,11 +254,13 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
 
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


