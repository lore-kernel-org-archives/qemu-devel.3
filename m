Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D5EEF5868
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 08:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrXub-00024N-Am; Sun, 15 Feb 2026 03:55:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1vrXuM-0001yO-D6
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 03:55:17 -0500
Received: from mail-westcentralusazon11013057.outbound.protection.outlook.com
 ([40.93.201.57] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1vrXuI-0003L4-W0
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 03:55:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MDZ2N9HVJ/i3Na0VquYoF+NQkGF1h17xi4igk27+Cdmslh4sgoOccNiRlgjYibxQqy+7tX2m1qRxsP7+MB8rIy6Rct/ZhnYu6qsM5n3oVSU334SBfNj9MGS6MFGLA0+0TCwALpyYnnE1WHBIH76rhRj8D/uzMYtbc+vmDSE/Yx18thkovIXrPXHu8ONM871/51QP2/7OFoxYtw4Jl3J4ZEq8rFrETP2VFgJ6O0y3FEglLpBibKIg/yJ1v2NZcdAuL7YM3cDVILFlzNm7n/wNzJGOdgv/o/7Q4YTaDcEp7Q665vKysO1bNHZ/2B2qoX9of6idlZpNfGKrYp4O9+Ulxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCtaeA+J9txp0JDlPfz3mNWLzYpinIGsU51LoSBjUhs=;
 b=k6uGc8uxhQsN9GrLBVFeIKVKr1Gv86Zs3ncbMPaPeYACW26qph1SL0rel/WHvJlgOre6S1VzME4SWYOZKEdqjVk/zxij2J4R769w90YiDBZJijvwRVnaA0k8tKWigCAu6aqY7nukuPiaKiUUy62RLACFlUGA+3TdKC32dLFGdK1Z7F7nSlKLe54hCNCyBMWLqz2qqBwPA4XFkARhIj+aU0NtYmL4Z8p4HKp95nQT/1L8/Re446IZL9l+t88i4mUhGbLEwDZ53IfaudieKuKLE1oHFpOq4/h08N7MpTE3XyBC8v7uorOnYULhfUo4nMiF550Nr/TDT0N2d6dDNUsbPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCtaeA+J9txp0JDlPfz3mNWLzYpinIGsU51LoSBjUhs=;
 b=ZVgF8iyg0g4QpsOHzcGjembhdiYdnzjrbUpevrpEbh8lIrGCF6TCgj5bM5IzxmSwRLocglHs0iXDcrUlLKjAfG3osqd0gON6rAkaT7UiXZbS2Zu1RakMEwUO/byuqA8pvEa4cpm/mYhoQoS0xIKdWlQz1FVonrjB1D8FO1UkyvJb5+I5v0n40Nt/aBR4ken6PC6xbWtaz5OX7T5qN9xjc0qZ8BEM59CLiK/UrqhyCBAZAwE9oaTJqMtWQqlfXfcMBv1FPu4oS/il7A1ZcgHgCTW5YIB+0mLOypsn9+2uLJM8hQMDEBlCEGb1bGmXUVRrjdcWNkrMJZFErUlMK/LA0A==
Received: from BYAPR21CA0026.namprd21.prod.outlook.com (2603:10b6:a03:114::36)
 by SJ0PR12MB6943.namprd12.prod.outlook.com (2603:10b6:a03:44b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Sun, 15 Feb
 2026 08:50:04 +0000
Received: from MWH0EPF000C6185.namprd02.prod.outlook.com
 (2603:10b6:a03:114:cafe::5) by BYAPR21CA0026.outlook.office365.com
 (2603:10b6:a03:114::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.10 via Frontend Transport; Sun,
 15 Feb 2026 08:50:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C6185.mail.protection.outlook.com (10.167.249.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Sun, 15 Feb 2026 08:50:04 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 15 Feb
 2026 00:49:52 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 15 Feb
 2026 00:49:52 -0800
Received: from localhost.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 15 Feb 2026 00:49:51 -0800
From: <ankita@nvidia.com>
To: <ankita@nvidia.com>, <vsethi@nvidia.com>, <jgg@nvidia.com>,
 <skolothumtho@nvidia.com>, <alex@shazbot.org>, <clg@redhat.com>
CC: <aniketa@nvidia.com>, <cjia@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <zhiw@nvidia.com>, <mochs@nvidia.com>,
 <kjaju@nvidia.com>, <qemu-devel@nongnu.org>
Subject: [PATCH v3 3/3] hw/vfio: align mmap to power-of-2 of region size for
 hugepfnmap
Date: Sun, 15 Feb 2026 08:49:50 +0000
Message-ID: <20260215084950.4657-4-ankita@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260215084950.4657-1-ankita@nvidia.com>
References: <20260215084950.4657-1-ankita@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6185:EE_|SJ0PR12MB6943:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dc42f12-4d49-40f9-d133-08de6c6f36a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NlE2RKnzOdX5P3jTLtDyVrJFw1EZwpCw65dxzOB0E5ihQgHNro89PQuAfnpJ?=
 =?us-ascii?Q?J9J8OqCIgNy2K696h+HpGxjiiA/6Si+s9R6QZjsPrvtLpN4ySJHW9ByfD51j?=
 =?us-ascii?Q?ek/YlJVHVOGMfEaZexWIGX4dIQIy0p+eiM09Zd+Hl+QEHw5/o7hDHaIzRXdr?=
 =?us-ascii?Q?yoyONH4jMzeDG+camzLQ3P+H91NOqeC5DLzDJAJwCtVQtY8FgGvcmP4VlTbE?=
 =?us-ascii?Q?FXCe6dxlPrumRhame2GXbbB0l+LUH3gdZxE9C1U1chrtbF2QIb1Ub4/BoCXT?=
 =?us-ascii?Q?f2kIr8LYX1gs8PNdkjj/QZh6J9SMIe0r+fWRpWyaefNk0WSKBcyUjVyRtDL3?=
 =?us-ascii?Q?sJPjE/9c2K+l5yYdjY+gNOGtb9zNsXhyyXP+Qs3TpSHZhoQwmCDei6uSpbEp?=
 =?us-ascii?Q?FHRDUsV3oPthAy+v6MwJH6YJ0PmnKMtDwQ2c+d4nHEUP6K7FC8cdX9i+ZV04?=
 =?us-ascii?Q?JuIEPZiCBIB2aI9ea8UpuN1AKXDi0O6w9KhF7zLNKGxatWUtalQ6kzfIRVSc?=
 =?us-ascii?Q?OUfnSPfXQWg+EsqxzLi9y/byXQbvdalxYA9OcmoYZdHM9gnqe/nHLHsyKOQs?=
 =?us-ascii?Q?TNDR6aFgJBrgKIBN6gP4FAcDkaF/w4eoMY0EnH75MSHAbKfRL+iTUD+3SvSk?=
 =?us-ascii?Q?tNA1HVQAQHJ4CtpGvOlstoX491pDdNwnk28m4DeWtFv7AjcBJJ4DW6hQ8a+T?=
 =?us-ascii?Q?Ho+94F5/4v6+IFf65gu21pdgm9OEVZgGUxUgENRvN1DvRcMgXH5eTls66DTd?=
 =?us-ascii?Q?etrQRcluL0AgMI+okGcRb6TRC2VGHfnOOjJJrZvfH7Ww9RMM2dexlBfHj7c8?=
 =?us-ascii?Q?9+7R51g8C8BOrNzV+F5bf2V9Iw9lcso3pRjwBQLgTmFPCPCFl49cIogDNJVK?=
 =?us-ascii?Q?PXt1Svy7PFKQ2g/TyuEBDK+Ptag4+PT5uxfkmg+7puFuqCZaxWSANtrFYvqC?=
 =?us-ascii?Q?R6OK34llohwDD1FsDbg7p4GPA6W+0fGAKFIIfogRqPZoayMMZSARR9CZFIsP?=
 =?us-ascii?Q?Xy+59IADd17dXNy1THO/bI1mSv/nm+NFio7jvlpLje6r7Cst4hkpHim3QzkG?=
 =?us-ascii?Q?uuLlufzuu+k0a6vwjvTAIKekFDDiuLBTw1KdhmzyMOCTOP0QTLYWwxwNbCIi?=
 =?us-ascii?Q?kArWBRS77HhTuXwd6vcnEG3MYrsh1gEo4qym0eqtoniFpTmPL23H+Y7yGqdB?=
 =?us-ascii?Q?HTbdXLxRdKGa2yFei4A83U+CUnFXSTK1hcWYycFyIj/Od4YA+g0UOSDL8RKr?=
 =?us-ascii?Q?iCae53/4Wc98QdaAXu3WKbdnqZmIe0v0b9dqJayB7F+8iBck0WqMWHw4mQCn?=
 =?us-ascii?Q?mXadicZmfmHnXc/zr5n/YI1kYsToBiD2l5YzQB3gj7nywjDuGth3tPwmEa3x?=
 =?us-ascii?Q?bMZhA5mOCGZzUJK8u7SdgeiDr6GfTFj2TDQAEYeywi+x7PH8dhLVX67/bx7q?=
 =?us-ascii?Q?XIWab3x70nPTb0hF8qxPz9SoDRBwGMYH2UuW4Q1pUJ9yIq29JacE1JYI/HfW?=
 =?us-ascii?Q?+xQURp09zmVoQjtF/6LHPD4G4n04nNH699K8tBJFirxMsfH6sdMGA+8XJZ7X?=
 =?us-ascii?Q?9+45tGglJmFCBeeJZpXSiKnihH6Vs2FbDgwIQGptN7kSYRkMTLIeenJczHq/?=
 =?us-ascii?Q?yuSuZGXvmu9xwmJj4o8ib+vMU0Hrutkss3EHrWeikButmuLfoDbe16CczrqH?=
 =?us-ascii?Q?VSTy+g=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TFYXJKJWkmnZW2IYd60BrGuBdyXw4iCeLRvmw9MwGDtyZQpEvY7gA+hNmXHhXSnOR5Ftvtoe8RKDGTb4dBJnvOTJAe4GI/sBe1cdqf/5FTNDtcOk21VDGsTEdox970oHxifggx6J7AEBDe1a9IdHnxiz9TbBnpIf4l0Sipw+/AWDroGNd28C/418F7/clcF1wWaZWHhYexXd5iBo70P/3u81fDYbOflt/Vgy0EgZT2zr1TTo9a77zYDXGZ3oPzShREihq74kSpAf+RfKliYVm1gII7lPQ0L2NgeFqgfUJPHoNYzt26ZK9YENbLvnWuKPqyO97y38J9jaolhHrIRdCkUXEVLq9nsr7TS699RpugAugfC/KNc+YIwSG9V+PEKJ/sn0qArMWmTGu7k365w1ZekaL6QFHk19q0+2D2nKZ6RReqlObIaRn57+TCrj2TCT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 08:50:04.5845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc42f12-4d49-40f9-d133-08de6c6f36a6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6185.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6943
Received-SPF: permerror client-ip=40.93.201.57; envelope-from=ankita@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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
 hw/vfio/region.c | 81 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 54 insertions(+), 27 deletions(-)

diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index b83b09fa2f..51523a33b1 100644
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
 
@@ -356,41 +359,56 @@ int vfio_region_mmap(VFIORegion *region)
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
 
@@ -408,6 +426,15 @@ int vfio_region_mmap(VFIORegion *region)
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


