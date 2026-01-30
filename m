Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25232D73EBA
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 04:07:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlfmr-0000mE-So; Thu, 29 Jan 2026 23:07:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1vlfmq-0000la-DT
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 23:07:12 -0500
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1vlfmo-0002rJ-DE
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 23:07:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a78J+QmgwJsLY14g6zVw00HRriShCvEANz9Qcz5z9DlFOgwFxahRjrWmJb14rSANKfySKrrTCOYC3uJ4cUp+04D99bFZ1w4uCiRWqm4wcI3xvCFZZx9Qa+UuImU0bddOdWkEsh5EStg7iV29XsBqHW/10c4zrYH+fRWioBak6xFhGt2FkcxAsjZvJPiEiPC666byk9MuCosTzKhHrsCzSIKCULYpbBpxKrij+GEp2az4iGM7iBYUtw0f+0hgo1fOsysoN3Z3cDky/gm6vM5xStXUU7NwHp/VPlW+BtireOqijxBMLQsscfMk4zlBUXS29+3FfiKmSesyDvRh9E/Tmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDNxPti1Wqus0Ce6NVf66lv0v9ng0grriOTlEv9B2LY=;
 b=YxkqsmjOsC7C/4vZpjcgW/YG6LR5bdtsEUGPgORcWw4D2+3EtvXZ/0q0gjuOOyXgIKtNF9L+twkpHQvdxWqDG6t01Djp2zNoUEcD08jvrp/nt9U5MZ+farlJZ5U6UAJ6NKt11vDnYftisfh/pK8fEAi5QikWbotZ4KygefhBQWSqwtxDKiTpsQE0QyaQe7sL0rPOek7nT3uPRSj/gprbEJOn9Ah59l6/8CFBLpni1J4mpazp1yZxS8ub4fZ35iD0NG4zMZmJez78Jty3E3SHq2BGGfZdcYtsjorRP6QYbZK+e3bvdFsoMuXlnMz/4ww7mI1y6kKGQadE7oG7q8mCcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDNxPti1Wqus0Ce6NVf66lv0v9ng0grriOTlEv9B2LY=;
 b=OtAE+Dv0/lVLEVdSdSAcVK7kO5eIJ2HS+EavBoMrLFiFofxfto214SuCGfMI5lGRoOM8gsphvMIguge2ibss6GXMnjUurTD4bQ4yUkHY333QLunepmFUX3GOcacsgX/5pEitXmocRe5Y0BzjSzjio4iQOBTeLHvUlW84ABAw3P0FWIevG+finDOBLF/keaxZbXWttC9NuiLkVIH4QJxCiYAHGkk8g/7+DrHaGxMNEjRdw6S1I8RqJp+k/yQFCnd6u6Vdv+3sjJnBsXG2L7kmBazGW4ZqYFCol8YNPhlURq3bBpfyTnBsMT5SsgEFSzudZL1hDoZNj8i1O+TNQxtLhA==
Received: from DM6PR08CA0063.namprd08.prod.outlook.com (2603:10b6:5:1e0::37)
 by SJ2PR12MB8720.namprd12.prod.outlook.com (2603:10b6:a03:539::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Fri, 30 Jan
 2026 04:07:01 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:1e0:cafe::ea) by DM6PR08CA0063.outlook.office365.com
 (2603:10b6:5:1e0::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Fri,
 30 Jan 2026 04:06:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 04:07:01 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 29 Jan
 2026 20:06:51 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 29 Jan 2026 20:06:50 -0800
Received: from localhost.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 29 Jan 2026 20:06:50 -0800
From: <ankita@nvidia.com>
To: <ankita@nvidia.com>, <vsethi@nvidia.com>, <jgg@nvidia.com>,
 <skolothumtho@nvidia.com>, <alex@shazbot.org>, <clg@redhat.com>
CC: <aniketa@nvidia.com>, <cjia@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <zhiw@nvidia.com>, <mochs@nvidia.com>,
 <kjaju@nvidia.com>, <qemu-devel@nongnu.org>
Subject: [PATCH v1 2/2] hw/vfio: align mmap to power-of-2 of region size for
 hugepfnmap
Date: Fri, 30 Jan 2026 04:06:49 +0000
Message-ID: <20260130040649.42485-3-ankita@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260130040649.42485-1-ankita@nvidia.com>
References: <20260130040649.42485-1-ankita@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|SJ2PR12MB8720:EE_
X-MS-Office365-Filtering-Correlation-Id: f51c1c84-d058-44f5-fe1a-08de5fb50553
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wj/+zvrKufZiGzFXNBzmO/CxtqIhWn8gE5JD9f6hcIOHGRXKrPjpzwfNZHoV?=
 =?us-ascii?Q?YFaKmuxcy0XyayC6rp7BuHUHMd3WTVQIk2XoQWPUsAhSYpyJg7EpiySFIffT?=
 =?us-ascii?Q?n+FZGXbWUsys9yWXGF9AfBo3xh0W9WkNFSj54uz/bIcL6DtHCAfyWpxKjKye?=
 =?us-ascii?Q?l61iADOjme+fB6sKlDe6lncs5eeloG3cZRlp358ttTJ/rdrMIPLgMBTO9xeE?=
 =?us-ascii?Q?FldbVCOGEo0M0AaZ6edGhESk65WEgwzTagSEW4H58hIpF+DPGClL42rGA+dl?=
 =?us-ascii?Q?pMgEQk4ktxNfR+uPXL8sQQZOAIJkGX1Wc6z7uoG8qcHM0A/DoqT89PCTrsrL?=
 =?us-ascii?Q?xuGMeTUs4Ex5DaKYEuBfXSOWJWx297kuZSNEGGayGZx8r8AfN3MwhhYymvgJ?=
 =?us-ascii?Q?pBkFC2M8fYxLasv6eHVVrHM3Ii0tUzFev0yJOe2TD8jAiwosFXF90dzMB4ry?=
 =?us-ascii?Q?sZb6jwXm/airHQ0BJp8ZRw9JhYEPkj9G+n+ou5UhBMv7odolEjr2+4VXLPUK?=
 =?us-ascii?Q?3SCCbOEsoMnJ9cPQArXbXSqp3/SEWbeN4zNyN41C5bWCb7+8xvYFjHgL6RnQ?=
 =?us-ascii?Q?/khIrav61D5kqqJUSk2eZFpa25fFkjkztmwo4WEweeUMxkmJe0gRJh26PgZ9?=
 =?us-ascii?Q?r0ieq9rCBqpUtDKljkgiGsDMLYWYzTo6COsy/15FghprXhSu36QJfbzQ5lBc?=
 =?us-ascii?Q?Sfg2VYC6cgQMlMl/54UhxxvWDcRvkfSSTT9/vR5MVcggnL3f5dhuWSMPx+lr?=
 =?us-ascii?Q?tWR3cxCiioEG1AWet6flOa3G0+YPeZajFVibz05tQADEHuZmpNM5iWdxmzr1?=
 =?us-ascii?Q?NJ/14HJf4jvYWm043J7OD6VwGvq5pApNQ8phxSLEJXOrXMCAWpZKAuNY6XYw?=
 =?us-ascii?Q?WUqu/O6MckkhL7HMmBYXb3+Bt5zCnkFGbqyKjuwacZVGggx38H3TaLI8nW7U?=
 =?us-ascii?Q?dRt4JJ7SXF6Ykj/DTzSga3K4dDUQsjuo3QF2PlR//TuBeuoje3KzdzSU9Skt?=
 =?us-ascii?Q?0WNS0AbOzpHnUEAM3PpkbrSu6BCollFK8SmRL3c6ku2bJ5w8aan3Zm+8eZQC?=
 =?us-ascii?Q?4Rt/CiHLDAD2h60IxkkoEwUjbhaojXV7248ATfGHPi40ybERIuNjtCiPpDL2?=
 =?us-ascii?Q?cBDR+7suBuW0l0QMhv8E0flxSPd46Yah70PC8SGijzzoEIn1ue3AIBWPSGQu?=
 =?us-ascii?Q?FMaOR/uGYa+DDqepuIITG+yB8llBsA1/1Ke4iJpEIMZ5/iQcAvlnZvaJ9ndE?=
 =?us-ascii?Q?QxZXFv7lNgvOh0T4m4ZdLl4Sg5WEvXxRavKKhf0h6AxktIbqwpZF9nEB+gY/?=
 =?us-ascii?Q?o0/2efo+U6pyy3d90RLLd9bB5X3/RKlRifBN3e2XqkdZmqcSiHJ7F4ZlzqUu?=
 =?us-ascii?Q?FN9GpqddCQs/Uqyr1GWRFMdd9QsfhXkfUlmIOTthfuYCdY+FV4WXZRnAHXzD?=
 =?us-ascii?Q?CHBnqIu6GD4AOx/iEm8A4NK2ierDW2xp+CMTvJd+upszbkrNffaB2m0Mfh8w?=
 =?us-ascii?Q?W8EA80SH50FHb4+xtdK4S0uIqtfRZyMbCwRT7KuEgcqiI9Wx8IPGZWH3nhc0?=
 =?us-ascii?Q?2YbemeYbuDe5rj+DWSRd4xu9bjz1mmgIFeDLT8nOft5P/bouOfHNOvYXWV+7?=
 =?us-ascii?Q?VzGIQYuD40W+qh2NYq/Cd5/rH0q9q/Q5VaJir1r9zlg0Fony3WzL50WE8Wux?=
 =?us-ascii?Q?cPFGNQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XGur58L1dpHvRo5osEhKbL/9ePzD/s+rS0T0IGI+eTriAL63H5cR3b8lBd36r+90/7sTcrtntFUaSgX7O0RNe7AEjOFLq74N32xKLGAB/wnHvchA6RrdF982YRTtzDoNLFUpB7zSrM19U4DSOVohLwU9uPzP6diTmE87sYbjDi1s3Qn0jPb0rpblLPsUC+Q0SXq2L26ueM/8U8MmyvUWUmcZxnT7w7kjVm5y74IST0CNfLWSz9EPKTKjfSMU23YwcCjaVfl6D3EXhc4OYOYncCgrMgZmi8Hed0EPUeAzslIsVB1+k1dqGTmQA1Vpv6aFDx6jdzl6P7OgSY6EbmUTVeaRyikFGvj/JVuJZlYIfsNEHT3IOwhSJ9s4hA4i9tP9gCNgCXg7ZqhZTg70vUBisuo6SauJ5Fk5k67tOUGbJSsy31+c/DEtsw6ZynATvU9D
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 04:07:01.5006 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f51c1c84-d058-44f5-fe1a-08de5fb50553
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8720
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=ankita@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
---
 hw/vfio/region.c | 81 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 54 insertions(+), 27 deletions(-)

diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index 7622ae5683..49f9a42e71 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -341,8 +341,11 @@ static bool vfio_region_create_dma_buf(VFIORegion *region, Error **errp)
 
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
 
@@ -353,41 +356,56 @@ int vfio_region_mmap(VFIORegion *region)
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
 
@@ -405,6 +423,15 @@ int vfio_region_mmap(VFIORegion *region)
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


