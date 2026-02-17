Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C066BE909C1
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 15:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsN2m-0005pP-Da; Tue, 17 Feb 2026 10:31:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1vsN2f-0005i2-Ro
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 10:31:14 -0500
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1vsN2P-0007CQ-Rs
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 10:31:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WwJjHv0Km7Q1CYroI+/UNPQ8rpkUIbT//z+JFDH/hSQhTb2qhdtP1NPcYtx7dqiPheEGQ078ax76MBXPhoFbFFY8IhH9hdKQiOMPy1xsCZNSItSj4ZHbcNwEiQQ/Gh9fh/Kh0v5BZSZQJOr/FiA3e327L/e9UeoEOKKfaEkJBdLDRdRFQpYRWR7t7AVstAF4PRPJBsWsCk6Xnhuo4DcYNUs7EDhGLvcznjnaExCf47Wh6ejsZgyJvLvOdzVvzHiYWYEk9JFhlUtaRQzfZhNFQJ5MOQdnX9tzwR+6RZj1X/rkYlqZMAPLqTW2HSfEBy3O6cM7NhlyEXR/KS8pwNPVQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HlRL3suLBLieIKap3hOgr63dNO8djVLJXac0h9mTY4=;
 b=MFQfCeU+edTtXdR3gFSrExRXUFDVZRXwyUqLfdD3B3edDctlj/PMrjQwnMu2B+KLI9vK7WVnkETh5kFFLqGy3edEU6jaZ3Of4Zw3uY5i2wDoddifpMsn/dxUplr4Py9r4ECYkSyBYUia3rfRyj5qNx754ZJRmmXUen+SWqMhznaN84456ci6tIhDf2pOaWnzQ/jfMhmC76G5VF/NFNBFXoSgV8nQ4dpuZHmhX3bPwHVSI6x9wy80u6WdHlLtKVmuXD3clQ8DiRQR0GxV978Pfzs+K/8nf818QLJ3zoKqOL5k29BvUtCvEdN8FNIvdVYM9OZkAcRFSNusPcht+B4i0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HlRL3suLBLieIKap3hOgr63dNO8djVLJXac0h9mTY4=;
 b=YSkWWvEiDH2zmHxEuSL1JXMyMPmGjnRt2dTkG97ow1uFTRPPATZoPWRD0mSTRF8oP8WhoKnp8iM2JW6XPGh8Rxq4rOhiU8T8sUJLAj/DgH2vTzDRsVug3a7bh4NBMI25OUfIHuY3nZnyGDbfWYOsyZl8/315/BPVIyYdGViueICitJj860v8vl79FFJFmMUvIMNpXL52KerIx9FUsLmf/tRbQxYYSF+5K6iO4vecG0wQVBY5VnjYFan1JEvzeEu1bcJIeq50sg/jeoTjgDZL4UddGRVzpC7JTSdruxtQcWCI3Pdw73xxJz9SZgP4li7Vu0Y6/BSbpPWkqOf9onGAbw==
Received: from BLAPR03CA0127.namprd03.prod.outlook.com (2603:10b6:208:32e::12)
 by SA1PR12MB8945.namprd12.prod.outlook.com (2603:10b6:806:375::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 15:30:45 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:208:32e:cafe::40) by BLAPR03CA0127.outlook.office365.com
 (2603:10b6:208:32e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Tue,
 17 Feb 2026 15:30:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Tue, 17 Feb 2026 15:30:43 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 07:30:14 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 07:30:14 -0800
Received: from localhost.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Feb 2026 07:30:13 -0800
From: <ankita@nvidia.com>
To: <ankita@nvidia.com>, <vsethi@nvidia.com>, <jgg@nvidia.com>,
 <skolothumtho@nvidia.com>, <alex@shazbot.org>, <clg@redhat.com>
CC: <aniketa@nvidia.com>, <cjia@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <zhiw@nvidia.com>, <mochs@nvidia.com>,
 <kjaju@nvidia.com>, <qemu-devel@nongnu.org>
Subject: [PATCH v4 3/3] hw/vfio: align mmap to power-of-2 of region size for
 hugepfnmap
Date: Tue, 17 Feb 2026 15:30:10 +0000
Message-ID: <20260217153010.408739-4-ankita@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217153010.408739-1-ankita@nvidia.com>
References: <20260217153010.408739-1-ankita@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|SA1PR12MB8945:EE_
X-MS-Office365-Filtering-Correlation-Id: 01fdb252-d158-47c4-0073-08de6e3983bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R7jVD28kXacMJ6x1lJHBy/5jWSNK+733eJchgHR/BdGFULFpquazn3i/s5Zj?=
 =?us-ascii?Q?1eAr1yygKQToa/PhwZIS24kOfFiSj4O836KnoXoHFii8dLaXP3zRgEdRVfqR?=
 =?us-ascii?Q?Ghzl9fCAr6w3IcPCOH6f2SXJgsKYN6w4ThUO3X0mXNGvE4JyRw2Y150V8vpZ?=
 =?us-ascii?Q?i/KaUIPpY4npzme07lMIPFGlAdjDgDAT/yFGd+7pGu2ih2Jx2Y2nXqGflVuq?=
 =?us-ascii?Q?zBUafEzsYtB4VJ995KjAkUAcyhxsNilIX6yh93SOVs+lzu2ElM6bzhsHGq4S?=
 =?us-ascii?Q?wIZ7Q6dg4HDoXPVVRV1zl0MeTTxF0VucZBEG9rsbi25it/0Ct7H2AKhdzr9+?=
 =?us-ascii?Q?miYIkPWo7cjrDZ/o2PvfuNyp7I5MJWE6dCmdWqXuezLYy0sUwCT0GTcFX4Mk?=
 =?us-ascii?Q?a86d2mkv18CpQ2RoXFpxyGxFUKBdQvGctG4/KnyqMYTmPioi2WfZq/RA7Hgi?=
 =?us-ascii?Q?Y2sp9kwuka3i22GWc2MZ667gdrquPvvRK6UolOQN84aOeD6ZoZCPG9a40Dky?=
 =?us-ascii?Q?FKQ0o8o4PfPd5lh04J65xRPHywQeHhjEZz224bveqBBAdl+4o5fuYJUvMXeJ?=
 =?us-ascii?Q?/bdCLJneW3BOZXufzGhIaVBFYOwZQVp3ZS/iqyh6zfub4pMHOAoHTqxfn723?=
 =?us-ascii?Q?cVya94hFNrXoGkf6AYt+PZnutTTNSjjveY2/rFd1BJJD2zBsCcTCXzZmcwF2?=
 =?us-ascii?Q?GU8e2JCIbbspvjwwfikq3Y5cLkAORZdUnpD5AR9IpbdINj75C6vIBWsNP2RI?=
 =?us-ascii?Q?1e7t40tZAee02cjQTtvFvArvijpyh4LAGqttOTJPgvduxs8TLNwWmYD5JU8M?=
 =?us-ascii?Q?DD2I7Gzhg8gD3oXn6MFZ1wucrDGIZvt0LcU+QIOFkSQHE0I+1Cfrk0D9vRib?=
 =?us-ascii?Q?3zNTOmV2H1Jl8fzV6PZVUcdJPxkGYLzE7EfZB9HQxXOV2xiiE5PN7wgNwVhE?=
 =?us-ascii?Q?2pP5WVOTBun0ruafnOiAToiQQ4Wc96N/LAKN/THnWFViBgBngGbaYD9tSdcr?=
 =?us-ascii?Q?FbI3w0ex5+bn+Xa5SXI10TWaELhl1pSbnhCQl4QekFWpNKIq9J459zfgZDxt?=
 =?us-ascii?Q?vFCh+XnV6YzK5snQWAdCzLBhJKjA5V2JADmi6o4Lp2ymt/5Ls0eKuqZI33z1?=
 =?us-ascii?Q?9bofniaC0zIVObFmiXyucGqANkRQgAptvte+XeioPLPmETpmIG4XmzFeQIu6?=
 =?us-ascii?Q?RAdNujTQXkIg77eY9admyH9WR/FSLYhNZokpPlqh9Yqomczr1NZYDjFQo9CE?=
 =?us-ascii?Q?aioOPu/lTIXd15r9aZfMIN7eNT7JN5iwiSYEUdK69IkN8RVCWMtksNpX1YHS?=
 =?us-ascii?Q?Pgua36OHQTU1zHcftHDW7ZA0OgD+GoOUw0Y/MMEeyZ9qu+yun68fCeRZ5MWM?=
 =?us-ascii?Q?tDhD/lngN5J4krL2vDr9aAkLF9vQLLE/3Eu0m1eAKNfTx/wjlstqaebb+4Xm?=
 =?us-ascii?Q?7xt8lPh4q2EFCJpf1vkzM8GfOR0C2Gu5SmPxFRcnK29vLky3V1l4xFQk5yAf?=
 =?us-ascii?Q?TRUtejOoYk3ap1qvEf2TCVhI1fnSLwFY8FRmVxfDorzriXJUvKBxpMp8cvDG?=
 =?us-ascii?Q?VzM3CDymNtNauG52N3hKpVbJLzD6QXrX+XCPGxlo7w66xTmGqTeqFkm5jkjg?=
 =?us-ascii?Q?+fbSM8DpRTh3MJR0Ny2/wL+IzrJk1p7eIQRL1P7y9VM9zERfWvYu+Cjckujc?=
 =?us-ascii?Q?6yq30g=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /1rIosDGlYOQ7K4iuLTqx95S1WcaLCCxwnABmEndeJ7d1DU4lLnMZ6FtHUonycE3hmMxRHdEFWCBplGuCUGGEXkRfBAN1t+KmOV/Btg+YFVoNNGOXgln8sHDN18tcsSa3ATXR4HLNSEgw4f3kY/mILUXqKva+FnDCvQb9jYoXBjMZ8uhJoCIgTkLAMZSGwwtzK8hV9ucNb7k3h2HKfp+ieHQu00EKYUatwJ+7qpNECsjMtsb9QxiizseJWVYvEg/8pUsNI4ZjCBxpusW252brA4GhcFwH4JpGwSbYbFtg0oZctTxCi5mDL2nzCJDafVQ9hEvAQnLFGAx4zcQDkWVkw3YTV/nu67MqDk25Pz8+PBflnjJ3x/hu3KJcu2wt05uGK/jYGPhUKkhtV4GyQ+5JMXr0ibd1+uU5i4pZ9ZNyFUPV3ZsPuVyqhEv3lGqok6k
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 15:30:43.3796 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01fdb252-d158-47c4-0073-08de6e3983bd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8945
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=ankita@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

On Grace-based systems such as GB200, device memory is exposed as a
BAR but the actual mappable size is not power-of-2 aligned. The
previous algorithm aligned each sparse mmap area based on its
individual size using ctz64() which prevented efficient huge page
usage by the kernel.

Adjust VFIO region mapping alignment to use the next power-of-2 of
the total region size and place the sparse subregions at their
appropriate offset. This provides better opportunities to get huge
alignment allowing the kernel to use larger page sizes for the VMA.

This enables the use of PMD-level huge pages which can significantly
improve memory access performance and reduce TLB pressure for large
device memory regions.

With this change:
- Create a single aligned base mapping for the entire region
- Change Alignment to be based on pow2ceil(region->size), capped at 1GiB
- Unmap gaps between sparse regions
- Use MAP_FIXED to overlay sparse mmap areas at their offsets

Example VMA for device memory of size 0x2F00F00000 on GB200:

Before (misaligned, no hugepfnmap):
ff88ff000000-ffb7fff00000 rw-s 400000000000 00:06 727                    /dev/vfio/devices/vfio1

After (aligned to 1GiB boundary, hugepfnmap enabled):
ff8ac0000000-ffb9c0f00000 rw-s 400000000000 00:06 727                    /dev/vfio/devices/vfio1

Requires sparse regions to be sorted by offset (done in previous
patch) to correctly identify and handle gaps.

cc: Alex Williamson <alex@shazbot.org>
Reviewed-by: Alex Williamson <alex@shazbot.org>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
---
 hw/vfio/region.c | 86 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 59 insertions(+), 27 deletions(-)

diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index d464eadf9c..47fdc2df34 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -344,8 +344,11 @@ static bool vfio_region_create_dma_buf(VFIORegion *region, Error **errp)
 
 int vfio_region_mmap(VFIORegion *region)
 {
-    int i, ret, prot = 0;
+    void *map_base, *map_align;
     Error *local_err = NULL;
+    int i, ret, prot = 0;
+    off_t map_offset = 0;
+    size_t align;
     char *name;
     int fd;
 
@@ -356,41 +359,61 @@ int vfio_region_mmap(VFIORegion *region)
     prot |= region->flags & VFIO_REGION_INFO_FLAG_READ ? PROT_READ : 0;
     prot |= region->flags & VFIO_REGION_INFO_FLAG_WRITE ? PROT_WRITE : 0;
 
-    for (i = 0; i < region->nr_mmaps; i++) {
-        size_t align = MIN(1ULL << ctz64(region->mmaps[i].size), 1 * GiB);
-        void *map_base, *map_align;
+    /*
+     * Align the mmap for more efficient mapping in the kernel. Ideally
+     * we'd know the PMD and PUD mapping sizes to use as discrete alignment
+     * intervals, but we don't. As of Linux v6.19, the largest PUD size
+     * supporting huge pfnmap is 1GiB (ARCH_SUPPORTS_PUD_PFNMAP is only set
+     * on x86_64).
+     *
+     * Align by power-of-two of the size of the entire region - capped
+     * by 1G - and place the sparse subregions at their appropriate offset.
+     * This will get maximum alignment.
+     *
+     * NB. qemu_memalign() and friends actually allocate memory, whereas
+     * the region size here can exceed host memory, therefore we manually
+     * create an oversized anonymous mapping and clean it up for alignment.
+     */
 
-        /*
-         * Align the mmap for more efficient mapping in the kernel.  Ideally
-         * we'd know the PMD and PUD mapping sizes to use as discrete alignment
-         * intervals, but we don't.  As of Linux v6.12, the largest PUD size
-         * supporting huge pfnmap is 1GiB (ARCH_SUPPORTS_PUD_PFNMAP is only set
-         * on x86_64).  Align by power-of-two size, capped at 1GiB.
-         *
-         * NB. qemu_memalign() and friends actually allocate memory, whereas
-         * the region size here can exceed host memory, therefore we manually
-         * create an oversized anonymous mapping and clean it up for alignment.
-         */
-        map_base = mmap(0, region->mmaps[i].size + align, PROT_NONE,
-                        MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
-        if (map_base == MAP_FAILED) {
-            ret = -errno;
-            goto no_mmap;
-        }
+    align = MIN(pow2ceil(region->size), 1 * GiB);
 
-        fd = vfio_device_get_region_fd(region->vbasedev, region->nr);
+    map_base = mmap(0, region->size + align, PROT_NONE,
+                    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    if (map_base == MAP_FAILED) {
+        ret = -errno;
+        trace_vfio_region_mmap_fault(memory_region_name(region->mem), -1,
+                                     region->fd_offset,
+                                     region->fd_offset + region->size - 1, ret);
+        return ret;
+    }
+
+    fd = vfio_device_get_region_fd(region->vbasedev, region->nr);
 
-        map_align = (void *)ROUND_UP((uintptr_t)map_base, (uintptr_t)align);
-        munmap(map_base, map_align - map_base);
-        munmap(map_align + region->mmaps[i].size,
-               align - (map_align - map_base));
+    map_align = (void *)ROUND_UP((uintptr_t)map_base, (uintptr_t)align);
+    munmap(map_base, map_align - map_base);
+    munmap(map_align + region->size,
+           align - (map_align - map_base));
 
-        region->mmaps[i].mmap = mmap(map_align, region->mmaps[i].size, prot,
+    /*
+     * Regions should already be sorted by vfio_setup_region_sparse_mmaps().
+     * This is critical for the following algorithm which relies on range
+     * offsets being in ascending order.
+     */
+    for (i = 0; i < region->nr_mmaps; i++) {
+        munmap(map_align + map_offset, region->mmaps[i].offset - map_offset);
+        region->mmaps[i].mmap = mmap(map_align + region->mmaps[i].offset,
+                                     region->mmaps[i].size, prot,
                                      MAP_SHARED | MAP_FIXED, fd,
                                      region->fd_offset +
                                      region->mmaps[i].offset);
         if (region->mmaps[i].mmap == MAP_FAILED) {
             ret = -errno;
+            /*
+             * Only unmap the rest of the region. Any mmaps that were successful
+             * will be unmapped in no_mmap.
+             */
+            munmap(map_align + region->mmaps[i].offset,
+                   region->size - region->mmaps[i].offset);
             goto no_mmap;
         }
 
@@ -408,6 +431,15 @@ int vfio_region_mmap(VFIORegion *region)
                                region->mmaps[i].offset,
                                region->mmaps[i].offset +
                                region->mmaps[i].size - 1);
+
+        map_offset = region->mmaps[i].offset + region->mmaps[i].size;
+    }
+
+    /*
+     * Unmap the rest of the region not covered by sparse mmap.
+     */
+    if (map_offset < region->size) {
+        munmap(map_align + map_offset, region->size - map_offset);
     }
 
     if (!vfio_region_create_dma_buf(region, &local_err)) {
-- 
2.34.1


