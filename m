Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E59D4A61A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 09:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vggB1-0002qF-KK; Fri, 16 Jan 2026 04:31:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vggB0-0002o7-Ds; Fri, 16 Jan 2026 04:31:30 -0500
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vggAy-0005Sr-7t; Fri, 16 Jan 2026 04:31:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QAj5WsOd9IZUjt348BFANslIZM2RhCZrO7t5qcfGlZHXKbxJcrJ95TjFrxubr9je6MtmgwrNan/kAuPNkIn8N8IAFVkF1Xpyzk0kq0dKavUVf+veuj/1/VyCxfHtmwVQ9TYsqOSsMKrv3spirl4XU0uqOVrLAtj7/kLYYSokQWRAqRpEOGWk3nSJ3Smy5MbJWCs7RQaI0OMREJ3sSjeDNGjhBTzjf5yyqIX0orYPyVwQKzM+atyd5fx8AlYpgnzJC5PpYG3PLD4ASLpnwZiUkXp/zu5C2DPgp18zxRTO4vHJRslz/wtNDWsgF4WH9egOR4cfI7tLSWTlHA1xvrNaKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzVuB3Zfw3DPe1Xle4ETdvT0a2715FF5A6tdvxG3fz4=;
 b=bL48wWft4wPEtEltwF+ZWh+DuI2K+rNDuVFTB7YFogJRME6QNMxTUTiGALxEvv6kvN2r6vbaXlaLHKQ0VWlfLVvKVMdaGcTnXlGbGSSMhK1dOpJ2Rs7YBLilL1wxv8KTXJEnJmBPbGnGiJsI4O/vZ5AZV2pf4WPJOftiIW4P4b/P95HxkHTCfi1fvzw6o876vtHDfHi75PBg4X0rqcVtrO7mxGaYf6vZegVcbVHChZrsKua5y2qEQKbuDpDibThB0H8Y9xBkG+AyvVCf9IrSCdwUyJPeXc4h+UYyBZgOvD5+k1Ox2XwtbyZDX3rNUqLfpmJedaoXwQZ+Y5/u4dvMyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzVuB3Zfw3DPe1Xle4ETdvT0a2715FF5A6tdvxG3fz4=;
 b=SelRdAJwNgaCYjnUMYlZb/DyGlcMz410PwJ/ZKIo9Go0bXF4oJ+HtGeturp15wkl5IZFZNuQNnZxMMGZ0A5D57EshYm80wYIDhxXCcVDXCizjX8KJhAnc4aSAIfybtX3o89s5Go7e3paBCqZ1OCm0Wkv6YUX9yNKvI2UPOmE+wP2py9rXBoExEbWpuu7+eUPSLdo1rEpKDxk4Mp3ENiadL2D79wh3mP2bk3G/Dwa1gH24LoFO1F/qsiBmm+GvtCrHHD5B9W0iL52ejvYbB37EfK4ifC9t5ysFnKHd1ZG6atQzjQWLLzhPijed6uyfkHd45B3VynmQswl1o79ocMPvg==
Received: from BY1P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::15)
 by PH0PR12MB7888.namprd12.prod.outlook.com (2603:10b6:510:28b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Fri, 16 Jan
 2026 09:31:21 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:59d:cafe::bc) by BY1P220CA0004.outlook.office365.com
 (2603:10b6:a03:59d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.8 via Frontend Transport; Fri,
 16 Jan 2026 09:31:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 09:31:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 01:31:09 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 01:31:06 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <alex@shazbot.org>, <clg@redhat.com>,
 <cohuck@redhat.com>, <mst@redhat.com>, <nicolinc@nvidia.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <vivek.kasireddy@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v3 4/4] hw/vfio/region: Create dmabuf for PCI BAR per region
Date: Fri, 16 Jan 2026 09:29:49 +0000
Message-ID: <20260116092950.15796-5-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116092950.15796-1-skolothumtho@nvidia.com>
References: <20260116092950.15796-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|PH0PR12MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e9a66d5-a5a9-4f28-4e15-08de54e202ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026|7416014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RmVLeCtlMERpME1JUzZsQjRzTW5pREpJVS9OSTk5NC9WdTBFZ1M0N2dPeHR5?=
 =?utf-8?B?MzZIanNCdEpTUzFtU2ZwUjYzdk9IKys2aVBjcG9Od0owbnFicjBWckxwa0Fz?=
 =?utf-8?B?VU1ZVkJiM24rMFJ2TEphM3Bwc3ZoM0ZOSFNVVnBIZFZrOXFDaXh2U1NYSVFv?=
 =?utf-8?B?aWljZTVvTGFsT0dIYnEzVGhDS2diMUVkTXprdTJTTWxmN0xEZTlCMkMzYmpK?=
 =?utf-8?B?YVc1RFU4a1RGVXhZbkNibjVwYXlaQjV5WFc1YnRaNGVoWThRbnh0TkxIaFFI?=
 =?utf-8?B?ampFTkE4QThRdjB1Q2FLWUN5RXBKS3dYTFZwVVZ6QjRUVlQxSFNWMmRMTVF5?=
 =?utf-8?B?ZUZuWldGR0E1d2phRXFzRXo3M0xMZGt6YndlZnRteVdFQ1VqZ1FNRFJaNGhQ?=
 =?utf-8?B?eUtkOXpSM2ZabXVrWVEyVmtFcW4zdGZReDBjeU1kSjBXSC9GSlVyWGNtMEZR?=
 =?utf-8?B?eVBXOWdIYndNSUN0YlhXYU5KVng4ZXI5QVMyS3hrci80eHpNU3hPMVluZ3pz?=
 =?utf-8?B?QVhMNXlkY1B0TGdOOXFGQjhudnNwcmJUTzh2MTdVZHptRnRwQ0dnczQ1ZHcy?=
 =?utf-8?B?OFFtWFhaMzVkWlI4V3Z0aVNaU21TSXViYnhqV3pOdTdZZUs4Mjl3TWhvTCtE?=
 =?utf-8?B?eXREaUZEUlhZY2Z4d056NG16Sm05QUVHdVR1UHFpdVRiYWh5aWN5bzJNeE5H?=
 =?utf-8?B?OHZHbEx5NGphSlFvMDJWRkNZQlNQcm1TUXk3TCthdEY0RW81dzg2by9pKy8z?=
 =?utf-8?B?MDVjQmY1ZFp0T3lERmF1cGU5TFNacFVmRUpWUUhLUkRzUnFTM29tamlaK21a?=
 =?utf-8?B?QTl4Q25mM2xXY2RaN0N1RnorMWlkTTBnRndBTm1lQ2NyVWs4UG11eHlTTVRl?=
 =?utf-8?B?T3dSM3owL0p3OXp6ZFhrSGpnVUorRGNMVDE1Yi9KK3FQaDFDNnJZdlBKdkVr?=
 =?utf-8?B?QzQ0WlJaaHptbDA1STdKWlk4RnNsZllIdkdVblJhd0o4SjExM1dndjJJK1BM?=
 =?utf-8?B?a3hjSTVpaDRmT29sM2F4aTErL1ZTR2p5VHJ3ejVLUVJWM2JjTTJFekFWdVZF?=
 =?utf-8?B?dDlsTzhlUDlnNFRkNGY3MFVMdXRzV21lNlY2SmIzaGZKNUM3cmViYy9wcnBk?=
 =?utf-8?B?MVMwOW12OVBqb3IxVGNibDhlV09BbzBDNWFzZmJTVWUyT1JwZ1RoQk9PalJC?=
 =?utf-8?B?TEw3bEc3NVlQeXErY0FFT1ZtNEs5SXNqTkR4VGh2dllUQ29BWXZYUGdNUmxq?=
 =?utf-8?B?bEpPUTk5M3BYWU5Zbk9PdzVxd2lwaG5YNjR2cXN5SkRWVGRlcU1YMUs4dlJh?=
 =?utf-8?B?Y3pnbHBISVJFckNFWkNENXR5cGlWOVRPQjYySm1Xb2RtT3JoaDgwbTFmd0RX?=
 =?utf-8?B?U09ZVEdvenFuTGoydU5lNVU5RTErdGhUbmQ3cWR4MUdWbWZMTFJJY2lXNFUw?=
 =?utf-8?B?cWxSUURCMlZBcmdzSi9lWktLdnJUUlczZ3ZLRzFOek92Q3RkUnZpZ2xmOGVj?=
 =?utf-8?B?cnc5UFZrd0l6ZVFLUXFlR1ZjTVphQlJTMWc3bFhHeVl1LzU0bWRNMWZuZW5i?=
 =?utf-8?B?TDQvU1BhNC9BVDhFakpodEs0b0ZlRUJTMFRVVkFKNTYvQXBKdXl4d1NZREo3?=
 =?utf-8?B?MmE4ODdBMGZEd2dVYkdyeC9pN29yQVVvYm9oRmp1SS83MVBhOUFtYkVPWnFq?=
 =?utf-8?B?cTRod3pidXdwWEhNRmpubUVVaGxUSFQ5Z09aNzFVdWVTUW5JYWs2R1Q1TXFo?=
 =?utf-8?B?ZVBwaXlrMTgrZUp5bTY4UWdKTjdYRDU1TmNvTFdTd1p5eTFLUFlBSkg0VFI5?=
 =?utf-8?B?eG1VNnlmaGRRcVZ1TGNPS1hnQWM5c0pnaXlKRlpicldNQzBtR0k2bUZ0TlAr?=
 =?utf-8?B?RWd2Ni84eFpkYVc5UGpLbTJ0NG5jSDhDM09UWnZmVE5RSjIxSXpZZlFSblJT?=
 =?utf-8?B?RDdVSDV0VVBWbEc2dlNzU0lNa0VHTjlrdERNdG9PU21wREFpL3lGcmdkbld0?=
 =?utf-8?B?UVVkWi9FT1lTZTV0MDBWUytvR3owUFhVaU9NWFBEcWxxSFYzZXZaR3NiWGUr?=
 =?utf-8?B?SHdZYVpRdWwwT1FvOEF6cnprRWk5ZFFtaHRKaDZSaDdZWGk3S04vdmlQY3c2?=
 =?utf-8?B?RU8rWktCRXNNTDF3bVhIeEs2UXh2MXdqRXF3bTJ5TXYxVElUVjBJZ1o1TWUv?=
 =?utf-8?B?dDlLT05TK3dodlQwRjFsYXdUd1RPaFJLMFJSTS9SOUx2VHNXVUlqUXZWSmp2?=
 =?utf-8?B?eHlvbGRLOGhkckgyRDVtelQ2WmNnPT0=?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 09:31:21.7043 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9a66d5-a5a9-4f28-4e15-08de54e202ad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7888
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
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

From: Nicolin Chen <nicolinc@nvidia.com>

Linux now provides a VFIO dmabuf exporter to expose PCI BAR memory for P2P
use cases. Create a dmabuf for each mapped BAR region after the mmap is set
up, and store the returned fd in the region’s RAMBlock. This allows QEMU to
pass the fd to dma_map_file(), enabling iommufd to import the dmabuf and map
the BAR correctly in the host IOMMU page table.

If the kernel lacks support or dmabuf setup fails, QEMU skips the setup
and continues with normal mmap handling.

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/vfio/region.c     | 65 +++++++++++++++++++++++++++++++++++++++++++-
 hw/vfio/trace-events |  1 +
 2 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index ca75ab1be4..ab39d77574 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -29,6 +29,7 @@
 #include "qemu/error-report.h"
 #include "qemu/units.h"
 #include "monitor/monitor.h"
+#include "system/ramblock.h"
 #include "vfio-helpers.h"
 
 /*
@@ -238,13 +239,71 @@ static void vfio_subregion_unmap(VFIORegion *region, int index)
     region->mmaps[index].mmap = NULL;
 }
 
+static bool vfio_region_create_dma_buf(VFIORegion *region, Error **errp)
+{
+    g_autofree struct vfio_device_feature *feature = NULL;
+    VFIODevice *vbasedev = region->vbasedev;
+    struct vfio_device_feature_dma_buf *dma_buf;
+    size_t total_size;
+    int i, ret;
+
+    total_size = sizeof(*feature) + sizeof(*dma_buf) +
+                 sizeof(struct vfio_region_dma_range) * region->nr_mmaps;
+    feature = g_malloc0(total_size);
+    *feature = (struct vfio_device_feature) {
+        .argsz = total_size,
+        .flags = VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_DMA_BUF,
+    };
+
+    dma_buf = (void *)feature->data;
+    *dma_buf = (struct vfio_device_feature_dma_buf) {
+        .region_index = region->nr,
+        .open_flags = O_RDWR,
+        .nr_ranges = region->nr_mmaps,
+    };
+
+    for (i = 0; i < region->nr_mmaps; i++) {
+        dma_buf->dma_ranges[i].offset = region->mmaps[i].offset;
+        dma_buf->dma_ranges[i].length = region->mmaps[i].size;
+    }
+
+    ret = vfio_device_get_feature(vbasedev, feature);
+    if (ret < 0) {
+        if (ret == -ENOTTY) {
+            warn_report_once("VFIO dma-buf not supported in kernel: "
+                             "PCI BAR IOMMU mappings may fail");
+            return true;
+        }
+        /* P2P DMA or exposing device memory use cases are not supported. */
+        error_setg_errno(errp, -ret, "%s: failed to create dma-buf: "
+                         "PCI BAR IOMMU mappings may fail",
+                         memory_region_name(region->mem));
+        return false;
+    }
+
+    /* Assign the dmabuf fd to associated RAMBlock */
+    for (i = 0; i < region->nr_mmaps; i++) {
+        MemoryRegion *mr = &region->mmaps[i].mem;
+        RAMBlock *ram_block = mr->ram_block;
+
+        ram_block->fd = ret;
+        ram_block->fd_offset = region->mmaps[i].offset;
+        trace_vfio_region_dmabuf(region->vbasedev->name, ret, region->nr,
+                                 memory_region_name(region->mem),
+                                 region->mmaps[i].offset,
+                                 region->mmaps[i].size);
+    }
+    return true;
+}
+
 int vfio_region_mmap(VFIORegion *region)
 {
     int i, ret, prot = 0;
+    Error *local_err = NULL;
     char *name;
     int fd;
 
-    if (!region->mem) {
+    if (!region->mem || !region->nr_mmaps) {
         return 0;
     }
 
@@ -305,6 +364,10 @@ int vfio_region_mmap(VFIORegion *region)
                                region->mmaps[i].size - 1);
     }
 
+    if (!vfio_region_create_dma_buf(region, &local_err)) {
+        error_report_err(local_err);
+    }
+
     return 0;
 
 no_mmap:
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 180e3d526b..466695507b 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -118,6 +118,7 @@ vfio_device_put(int fd) "close vdev->fd=%d"
 vfio_region_write(const char *name, int index, uint64_t addr, uint64_t data, unsigned size) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)"
 vfio_region_read(char *name, int index, uint64_t addr, unsigned size, uint64_t data) " (%s:region%d+0x%"PRIx64", %d) = 0x%"PRIx64
 vfio_region_setup(const char *dev, int index, const char *name, unsigned long flags, unsigned long offset, unsigned long size) "Device %s, region %d \"%s\", flags: 0x%lx, offset: 0x%lx, size: 0x%lx"
+vfio_region_dmabuf(const char *dev, int fd, int index,  const char *name, unsigned long offset, unsigned long size) "Device %s, dmabuf fd %d region %d \"%s\", offset: 0x%lx, size: 0x%lx"
 vfio_region_mmap_fault(const char *name, int index, unsigned long offset, unsigned long size, int fault) "Region %s mmaps[%d], [0x%lx - 0x%lx], fault: %d"
 vfio_region_mmap(const char *name, unsigned long offset, unsigned long end) "Region %s [0x%lx - 0x%lx]"
 vfio_region_exit(const char *name, int index) "Device %s, region %d"
-- 
2.43.0


