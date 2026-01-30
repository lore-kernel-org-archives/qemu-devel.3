Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B079D73EB8
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 04:08:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlfmq-0000lY-BD; Thu, 29 Jan 2026 23:07:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1vlfmn-0000kd-Do
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 23:07:09 -0500
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1vlfml-0002r6-8t
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 23:07:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNbSMMhMZVFD/uT/HQZs2kTH6yyyUXFvFyzGKxjduDScAOvBwIZGBZdfq8qF/CGub58DAZRTmkU4aRD2d+GVrmub93RJ0Y9fDjwUE7oEOq6udUtNMCEZHNkonbdH/XUb47TRv8JDXJ+3BPusMsiCAm/fIOsFeevQZWzOdoWwLEamb+Xb1bcZeed7VnOYejiOnmu5yUxPDMRb1pvTNIfumiM93NS1grPl9qXupdS07e8ErR1mXAVsdkOkmCs/YjJjQVvrADZmpennZN6BMK0OD1fEu2OpX7ihTWHwDxBKBPe2I+P8kxPjUpMZYVQih6CHycGwbqvGwimah2PiJjXg/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nilA26uQ9HOXscVqW3LzJpCr1kOlJHJK8FaD/R4e7uQ=;
 b=KDA/RNAOddeJ5kKgt8KwF8pUm4TYkhSklftuxg2GqE60DzQASNoTBiMNPr8HbdRxMVXUmiIiQeSVMilZ/dSzKUqpyV1wuoNJ3vaKNNwxT4MosOG/RI8TuARjJFL69lN/BhUg0l3aZbQoB/nhFFbwS+zK7YnqZkDluqi/4F5ULilMaVlCut/Bd+2u+P7zI+Yd1inNCK3qBH7BM5H8d6+F+45R/kSeJ6/bvksMcJl2tpHCRLdxYopBY4D/JQypEEMqvEvGW9nme1lXCvAJvW0UYrkg35dbgq12R2654RDtCqORru2dApY0cO4m0HPD3YiPXMXD8mjROCesl0X35Qo8BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nilA26uQ9HOXscVqW3LzJpCr1kOlJHJK8FaD/R4e7uQ=;
 b=RN3mYb5CglyegpYnAtX8/+i1jYjDBqU/XO9u0hd8d2PO8i0bfPpWp1CexVrSOTcQCWmDS2+8en+gn8xdpPbimjmdYCmaTynZR+gAtBpR4LtQjiov3jwUdMx/zV4hgpzYLqiKlvHzzF/HxKOlwvxARzchh1g/w8JZIF8rgG0LqEafAaqUIFhvd2Rjf9+AddM45Y1f3BcDDUV1Ve0RuNRlPBjUXWI07Om+DXvNXBCsa34TguKC4w9AZ1Jl1pFtcGC3mYCW9H3YZg8PfuI4jvoTa2iSM+FVy59h4rHbR/Wc24Ha1m3hvsgeKpJKotBTno89KOJVz4oeHm/sAZCAk7L/yQ==
Received: from BN0PR04CA0042.namprd04.prod.outlook.com (2603:10b6:408:e8::17)
 by DS0PR12MB9347.namprd12.prod.outlook.com (2603:10b6:8:193::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 04:07:02 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:e8:cafe::e1) by BN0PR04CA0042.outlook.office365.com
 (2603:10b6:408:e8::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.11 via Frontend Transport; Fri,
 30 Jan 2026 04:06:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 04:07:02 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 29 Jan
 2026 20:06:50 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 29 Jan 2026 20:06:50 -0800
Received: from localhost.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 29 Jan 2026 20:06:49 -0800
From: <ankita@nvidia.com>
To: <ankita@nvidia.com>, <vsethi@nvidia.com>, <jgg@nvidia.com>,
 <skolothumtho@nvidia.com>, <alex@shazbot.org>, <clg@redhat.com>
CC: <aniketa@nvidia.com>, <cjia@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <zhiw@nvidia.com>, <mochs@nvidia.com>,
 <kjaju@nvidia.com>, <qemu-devel@nongnu.org>
Subject: [PATCH v1 1/2] hw/vfio: sort and validate sparse mmap regions by
 offset
Date: Fri, 30 Jan 2026 04:06:48 +0000
Message-ID: <20260130040649.42485-2-ankita@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260130040649.42485-1-ankita@nvidia.com>
References: <20260130040649.42485-1-ankita@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|DS0PR12MB9347:EE_
X-MS-Office365-Filtering-Correlation-Id: e84a07e8-8156-45eb-ace3-08de5fb505ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kUi7zo2UZhgtcjDr4bbrm5uJiDZiuNyrM3k2n/6ARKrd41OfCx5CS3kqts9q?=
 =?us-ascii?Q?OD+JalWg37FXkKwmUnvrHDt533cp4dI1xqGY7uaQNDhnbezfZZGnn6kZr3em?=
 =?us-ascii?Q?uIOLVzg4lKy2j2tZGVFdJRVYERAIg/3scO0dRKmPE/3J2M6dB2hvUALz19qx?=
 =?us-ascii?Q?m2HhYJCQ6Mjm4P+B9VrsxlMkNvP9lVlVir+oGVW7ninl+d0zc/5XtgXw2Ofl?=
 =?us-ascii?Q?lWRMJnHJ6d3JAViQXLDBRnWZdWo7n3AKhYlOHYO9VRSU44IYuB/5m87X/HzJ?=
 =?us-ascii?Q?jCuLXaWIvZf82Uc+Zi4ar173QqdLjKeuQksI+R4TlpJdJjwrP26raphckBJt?=
 =?us-ascii?Q?mm5KEf+5q7zshpQmg//hziWoFUBzauAmBhFrrHeBqhh2hx4HU0iQkQTl31h8?=
 =?us-ascii?Q?c8QxER18RuqXXMPP01M+/V9qNTSrVi2vpzpMkyMFD+LerrAoFaNIFET7lgb6?=
 =?us-ascii?Q?0zJ16V4vLu7oj6MUuybvhqqvEUUTNOZJGxpVmvaryO0ZsyOajW+B+BnE9bNx?=
 =?us-ascii?Q?vGUVeDe1jh02Hm6KdwSPFv+A7nLg5GeG0AAIyoNpWlQe6G3NMGv9b943RQtw?=
 =?us-ascii?Q?gSmq+eeGN+Xv1PD7jCx+428hssocXQuXSllDnoTvEYN/sFYEBOTQki6T+YT8?=
 =?us-ascii?Q?qd20e0nSl/60eZ0JeFt76qgnujl2oIpVbM0SiglUWhcja3w+C3R4Sbl+jXI4?=
 =?us-ascii?Q?Kkt61JzQyztQcybvKEU1UkmAa+p0he03i+JnAA/jAreHnHJMMY04zqxLJTAh?=
 =?us-ascii?Q?OVcl4i5YVdqvnrMfCym9ZfQbbTBzahjsX7IE+D30/lgg7Nmqp6JRSpzKaXYU?=
 =?us-ascii?Q?jTqaq5vg6SobqKbYtR9Ls2Vq+3fq0H6722TvwQFm2w8lSooo+T5IQG4zTV0B?=
 =?us-ascii?Q?GIGS295BM6baWLUiPK4Kc6xSGUitwl954eX122f4k74TPP4QJ+Yde9qtt5Hx?=
 =?us-ascii?Q?8ZOBR4fw3mZaVElaq+RDirgb7vbPBymoyf6mNh2dpblgNII0Z8RoJQlC8B7x?=
 =?us-ascii?Q?lbuUvv2TEviEVK5bSjYxDYIJgtJmukudsDojDRExES3oNCkSjtLnhmaPe2gm?=
 =?us-ascii?Q?KSPLlM/CoBqusSnM3au5mSFvFBfWllgCBJwfuflcGDSW5/+Lhz8lF8THJ3JH?=
 =?us-ascii?Q?YztuuqiJhCksWi04q3l5rsLy51BVj8MxZdOlxREeBz/t+w2TEhMN4wUHNgGa?=
 =?us-ascii?Q?nmb8ny+evZvUl9zKVtAB8un/L/qyAoE8osYEOwbbRwri24BUFMFmgKeGZ0JB?=
 =?us-ascii?Q?y1cpYGdds1qzDOzGw/ydRdpCkjN0NK9KMnZT2uM48EvtA8qawFGtbHv4iy6x?=
 =?us-ascii?Q?XQGblzSTxr7VVu6v16V3gNg6EMhUMpBOgloH0rTjGPJMkwg2NrwmY39+Z4ot?=
 =?us-ascii?Q?GQ+ZvrZhj/XqXMyrYK4vGdDwIb5T4aOiRkhH/c5dS3e7ZnWtLuJUGZl9I/OF?=
 =?us-ascii?Q?qijmeGS6UZCUWRY5sdSJngy5PJhePIS8BvZ3Hesjiedlb0szlbgm5v21YM0q?=
 =?us-ascii?Q?vqTqGlzkipJsYb4yFy4SpqZ1L9ke6ZaJP7go5kt/3T2ZvG3BnaBBlF3+tKxZ?=
 =?us-ascii?Q?xbN5cKAM7KipD67icQ9YM0v/3+1rgKViOMIkRP8vhIIwmev3qJfFNiruRUxH?=
 =?us-ascii?Q?V10lQb3VU5k6OwTckwWIFFXWjVx4TdCXzBJIKen5EQZ38I6pQ8Pl0V1zws/3?=
 =?us-ascii?Q?fw67FA=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: d2gcWe8wquPu+QRrG8cDWnr2HydhUgLh6+XQ7cD7NCTt4PZIg3epWyEn9cDV4b+r1TatnshheFJBqcBIB/vExXwIX6gLZhKdCyt6SBUaUy8dWdTOmMdsgAr/7vMbk9VSDpbm63MqMLg9XMNpquhKX5jwbkX8r0+hz3XLckPLd0sH5R5C0V1GSsFlSmI7XXy2aHxzaCkeNLIU85Vh64sS0fAqXy0A3vf5fKJqLzWyzGqikuhjl/UkNGu5ex/bz/pzOsjCI2uyeun7KQ7+rgvXM5utL0xvc7n14cso9jHsb26ttJNdqsVXT4J3f8/g42nzAQjUu8C0TuGuZiOCTi3CGLF9qJkzvoR8Zzjbeg/DF3GGekD3n6BCjjLxJ9YraWQvnEuVxIKt7n6/oUhRcS4Jd29VMIpry2PRgLb/K8sqZbZoRq30S+g7xLm4p2DJAbI/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 04:07:02.0386 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e84a07e8-8156-45eb-ace3-08de5fb505ac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9347
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=ankita@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
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
Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
---
 hw/vfio/region.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index ab39d77574..7622ae5683 100644
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
+            } else {
+                return ret;
             }
         }
     }
-- 
2.34.1


