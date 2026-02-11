Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76AB3EB594B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 03:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq0Z2-0003uh-GK; Tue, 10 Feb 2026 22:06:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1vq0Yz-0003tp-8U
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 22:06:49 -0500
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1vq0Yu-0004Eo-Vu
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 22:06:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gfgwd7M0sbDsDTzNgGZbf9K1/OhKqIgxvb4BzUOZH75LSPPp7zShUk2KYoF0mefHy5BwxBVJIcKW4o4h8ag7i6Cvk8s38D7oemYJA2pPcKU6kteZoHxcR/gGES+zZ/V+vc8b69D6zkhxqZ/jnoDUbrAR8h2wCB52gm/WnW1aA5FfdGUZVZDf7JTVzEdMx9PfuBxxLE5ygAlShk2pjeztJTW1XNKpBsl52HIkxhDFETpZJxwB9iYoqqRY90j1vDq2Hahi0Zk9uShM71cDNUdxY90vB697LBsDsbr0te2xtX1X0HMxG6LGBsInYmRvX0xOLYW56ioaNC3s8XtUfbIx2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95RL3Mh1H1kdrIcjxtOhVXM0T66n0BtN1RVWjon0+L8=;
 b=GLA22dSpH0OLX0DVS8ZeGBjwV7YUZaWQxsaiHJLhNsWwJZwPs02FKZIc/dVSDfvqt8FZH8zpsm1muaUIMIZTEHCVxRHM7ovUB36KTg8bn9qBfH+EimyqaJNxA5z6HmSmNYwqazjjQM5vUqnZMPW4VV5tiSbZ+wt57v90vR68D+sJkQ67zHF/07Tjp0bBNgO9Om8kYClduQEKOt+ANF1xuHfnmlIgjw2x5i63hLEQLi56TEl1c1oYL1SeqwAC6yxuaTzaP/erYVdEbwqU/j6eXZUDZBvn8fCQYcAUbtub98HnZzio1iNdli2lc8fAm6Ol8Ke+fBGLjJHIHjr9NAutfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95RL3Mh1H1kdrIcjxtOhVXM0T66n0BtN1RVWjon0+L8=;
 b=c/biyuRjAZRgVEBjJuq7q+Wg6MZsKtIdlg5NRADsUOQHfEQ6Z/Avqh1PshDd5AaICr0XvJ8p4+e5tD66eEtEc2h3TyniF2aBDIVIlQ3jE4YVTSbllzBElj+6vIPjsPp1t8UiIQaGhWUE0w0Tk2BA4q320MRj7/j/v54I2XVPVHeyvON58vWv/adcUWwudz8KFWJp+ReYgqAgGzxnsM8c3yj2+Q0rTj5SQ/eAh7nQDg9mVvr0rivCqUP6G7G1TmrmaGWRGlm63dijA2cN4OzVJubxMz0CJp9thZRng2cWJcsH7kqF3sYIZnhfXIfrro8/SfUPCbcM4wP65vYbV7POoQ==
Received: from DS7PR05CA0029.namprd05.prod.outlook.com (2603:10b6:5:3b9::34)
 by LV2PR12MB5750.namprd12.prod.outlook.com (2603:10b6:408:17e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Wed, 11 Feb
 2026 03:06:38 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::d8) by DS7PR05CA0029.outlook.office365.com
 (2603:10b6:5:3b9::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.7 via Frontend Transport; Wed,
 11 Feb 2026 03:06:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 03:06:37 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Feb
 2026 19:06:18 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Feb
 2026 19:06:18 -0800
Received: from localhost.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 10 Feb 2026 19:06:17 -0800
From: <ankita@nvidia.com>
To: <ankita@nvidia.com>, <vsethi@nvidia.com>, <jgg@nvidia.com>,
 <skolothumtho@nvidia.com>, <alex@shazbot.org>, <clg@redhat.com>
CC: <aniketa@nvidia.com>, <cjia@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <zhiw@nvidia.com>, <mochs@nvidia.com>,
 <kjaju@nvidia.com>, <qemu-devel@nongnu.org>
Subject: [PATCH v2 2/2] hw/vfio: align mmap to power-of-2 of region size for
 hugepfnmap
Date: Wed, 11 Feb 2026 03:06:15 +0000
Message-ID: <20260211030615.3202-3-ankita@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260211030615.3202-1-ankita@nvidia.com>
References: <20260211030615.3202-1-ankita@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|LV2PR12MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: 49241299-f041-49b6-9a54-08de691a924a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YktJinRHn3+6xa/ogV9TeVh7hSes4YY1BXC/cNaTWfvehDGDodkXuFhyf4Lo?=
 =?us-ascii?Q?8YKYXXr8QL5+GDMelc56Rod4UgMBKo4dmdpJcrOxPQ314CjS1pME2tbxtTDV?=
 =?us-ascii?Q?udEjWrUGTIdu0eVyOf/nXAAxhtYV+H4pCRcJrSBI9gCpXPaGQnkFyVglzzOt?=
 =?us-ascii?Q?VCsYhsNBbgK/fIq6Yv1pVwr8MCCo3c6A5b654QK/n0VCL3TjnubzDD7olWDn?=
 =?us-ascii?Q?uR19L3106mp2imJvREfiD9xMLcC0mu6KkfmUaeYNWd8OVBthLaXs9klwpTnc?=
 =?us-ascii?Q?Odcjeshbe2ndO23pAFviptebqGoLt0Z+S2r9L7SdOwhDlcAo+r59YvnuKm/V?=
 =?us-ascii?Q?2cRiek25j8CXJilY/fYNL5MymENXEnNd0Yi5rR7mOSLKu39W4/ntXyyPQLa2?=
 =?us-ascii?Q?p/C1zYYn+4fYZDxJnH3M/nF69yJ40CAEQKLSu+0ftsJjXC0b0RZUKqJetzQk?=
 =?us-ascii?Q?MDbGV76L+ZEBrexyq5ildX66J6edvRiNfx0bPoBAkQBwvVGC+D+cxOnZvgLf?=
 =?us-ascii?Q?iS43C+rx6CTqdwp5FIyXaOGVvYPvzeM1PQm6uwhf4KsleB6Icy+a3qZi+Yft?=
 =?us-ascii?Q?WOV17LdijgyrWnryDPXelqOXgAmshZtVGcQc88ORW8tXxpRhxlqtESMdOZXH?=
 =?us-ascii?Q?XKq2rfOo+m2xcWaaubMs1dQbS2pN+hnZjH8pQDALN2WDzEkvEl+tOn/Aa0oV?=
 =?us-ascii?Q?ht6O75qOW9Zj9sOGhIN8YW3rRT1kyY75YSMGVUUzuk6NWT/JJcikZEAgH5/s?=
 =?us-ascii?Q?3uuo/bFv7jju06sFz6cNMdmWs9E5VmihE+/X4oTE10J5XG4xpGFEbQnDUw0M?=
 =?us-ascii?Q?COH4/YIRsI7rC/30oNlyiBwZFkmGAbioounxlOyEYLoB9vI5Ly3kEUSXSiC6?=
 =?us-ascii?Q?ZacbpEXij/opuKmci0N8D4Ii+9is8IsMErd337wah4PgZn7qisgXbYIsxzXm?=
 =?us-ascii?Q?R/kxLwGn8573QqKeodt56ispKrrM9DosZyWzNOhsAxlyiECkczYL2kBXo8Ey?=
 =?us-ascii?Q?j1XGNPdXnleksgJL4SrYBv+zyld1zux5OoDqL/rKYUCjgSqAPDhyLNOgrEub?=
 =?us-ascii?Q?XeSYdxgjp1FvLoV7FzZBaIMD2GwuEG9n3i16UUdOSxZ0x1zEY01ndUDKErik?=
 =?us-ascii?Q?OcMN90vzxvQD83ZwVZM0JQbZnN9YqFx63jiuNFLmcFM+7zomV9W1E4akTIt+?=
 =?us-ascii?Q?52L9X0G0b0gKb7gAzRCwxbXw7m9kX/Y8DX5tTTFAx0FtuQl4N8HUj8Za7dRj?=
 =?us-ascii?Q?rP/1W+9Q/oZqSuyEreGh+Hncc5MUpJp+8Gda4Gh0CSsJqgcgZ8fqkLoTe3wB?=
 =?us-ascii?Q?fPSg5p85BxNBZFE79VdQzffCq7BuQEYdlGPGI4XzhXrNHE/Y+EjN2BPbRU6d?=
 =?us-ascii?Q?ekGgjXr13BtkPC6mLhL8Ro+vGEdcbk9UWbZxuOA1iRyQjP86ISgy/Fy0tCX8?=
 =?us-ascii?Q?DbvBodp32BPthu7BVAnuZ14euBFjLzOvm+4dkM4nbDnEH/XhoAh5MKC4rhQE?=
 =?us-ascii?Q?0+5fULiiJvE5VTc1CHLUFvCf97OYwE2TKRV2OvrgsKiVG9lZC4BkdByBR92n?=
 =?us-ascii?Q?kB5APXhOuX2clIt0y24HLhmc/8VATCzJac7v+Km03hz5cx6nw0nQQ+DAIQPr?=
 =?us-ascii?Q?3QQU6kznW1mrAEuJNduhYr4DLwPrCquC8D3nSxBizS5RVXWh0K7Zw0r0T7CZ?=
 =?us-ascii?Q?dL29mQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AWr6S9/WCB60ChlV1Y9lhRW0tWJuiy6dqemZ5Zo6lbO4Q92NEORFdS3ftQxH0eEBuBYhHHSSwnULVIl8scf20Jwofvf3G3tknCLxenN4REHe8ZLVmk0Vfr5x8uaDlZiJznClbeUTC6TwSTGoyv6jHvBo6RBUXAf+nXDBBdoewkeGVyLHuNL0aa5SaxwNkgVqzOI87mVX4aXczTdTkNU/Bspm4afwp34QqiqBuCjFdD5UxuuKiFV3BWC4W7qMgMEtwk8r0vPjm4E09fCk1XWIOsR0Rgc0EgyovPaRr+A7b9Y9/7bCBfhdcualLgMhZgbp+5FjJP8StLQLBCHirmptA5SzR9yTIbry99Rwrwl3iRcQCyknDtSYTz3jxwDnx11bzxIIv8O5q9e+idNHOpnvdrR3YAy+DCky3wzEvVzQL3T2UVKU7GvjbPQKb5nNYRwl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 03:06:37.6198 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49241299-f041-49b6-9a54-08de691a924a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5750
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=ankita@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
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
index 177494c379..3f2d72dbc5 100644
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


