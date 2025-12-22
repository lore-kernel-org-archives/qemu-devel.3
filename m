Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F137E674B2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 13:57:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXgPI-0007c2-7o; Mon, 22 Dec 2025 08:57:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vXgOb-0007Mk-L4; Mon, 22 Dec 2025 08:56:23 -0500
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vXgOY-0004dn-E0; Mon, 22 Dec 2025 08:56:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yfGt4WJHilhQKwrxNLjZFhqEEacB8NGDyK2WkFhn3Nw1Rh78flbdoe+KOZytRZeWOrLIhFreHFqC+zT+6ypBTZrD0vWn2c9FlUkMwciEuKSu5Cek7NriBV19RbMn3SH/YGOR9doEk88dAPuiMUiDtblo9gJGmz4Xhr9fm8Jl9k0VrRny9UcsKN1cgg+e0CcdDlmgrqMgAmHi4nI/wK+0jieyPvz7FLasbc+3lcLrSyZSV3/X8Gd2xkJ/lUjoVjfm0lnGRg1uFQFGhWQoCscC5nzQuje/fykwjfVIdDndWXto7grTuOLjGCl5EWIvg+lCsEGAGtHnyN5bTAV5agvmqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnsJpwesN7HP6SQ3e7dlqXIIYn0XQAKJo9Co/bpOVZA=;
 b=lHJmUrZLqHVHisTQl/qInChgNZY0mo0KLuddHvigpYAe/cBkL3bZDTUPLx+a1paFEmi8xUzep2kVhEqkUv3wD/3Sshbv7B78MnbIMR0c5kLLHwNg4BoE+zCat+EJ/vECjuDkdgkU3MC0nC4ZXM9i4ot4pWOIBS4K7G8ebnzuCQL0FbsoGMIbRyZwmRbfofhP+5HOn/aYbrLdHNmPp52m7gB+o8R3yvQ0GxZlkXyofkl9ehfSHgpqZlngFNxbsF3KB6toaxBeuTV3IJKR6qp1U8n3sb8DeRt7K6gOsORtGJlBSTucV2tbpTbMGZg5wTOYuVKeRfd1eKaFPXBDNUTAJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnsJpwesN7HP6SQ3e7dlqXIIYn0XQAKJo9Co/bpOVZA=;
 b=Sh/c95yNxbC/MbWqWTPXdJIxqJc7gW2GB4J7Y27RL5+0aN1cqgVMTPmhfvZom554jUZuzU/6hhX7HUYSMG0lk8d6U8dRo+KarUR9pF0jYQNDfeyAMOMA93v5H7GUvyPJ46ZMHyl4nwlZR6vPb/r50A4RpIQggw2t40gPCzitKJ7pUSwYxUzWgDYSAL9N9tp76gOQNjKf6AfQ69nPQ1lttuiRRqMLDRRpv0JMXiYAEL1BuEvyN/0fHUU98aIZoRF1vev3PBt6a/gvR43PluBC3BjsEKywzCmat6qqZtvazaW8t4IzBYr1sELO3FKK6DYNbxX2xYFvwHj6Z21Nbgf4QQ==
Received: from SJ0PR13CA0144.namprd13.prod.outlook.com (2603:10b6:a03:2c6::29)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 13:56:12 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::9e) by SJ0PR13CA0144.outlook.office365.com
 (2603:10b6:a03:2c6::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.9 via Frontend Transport; Mon,
 22 Dec 2025 13:56:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Mon, 22 Dec 2025 13:56:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Dec
 2025 05:55:58 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Dec
 2025 05:55:55 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <alex@shazbot.org>, <clg@redhat.com>,
 <cohuck@redhat.com>, <mst@redhat.com>, <nicolinc@nvidia.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jgg@nvidia.com>,
 <kjaju@nvidia.com>
Subject: [PATCH 3/3] hw/vfio/region: Create dmabuf for PCI BAR per region
Date: Mon, 22 Dec 2025 13:53:57 +0000
Message-ID: <20251222135357.143339-4-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251222135357.143339-1-skolothumtho@nvidia.com>
References: <20251222135357.143339-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|MN2PR12MB4063:EE_
X-MS-Office365-Filtering-Correlation-Id: ecb728f9-d639-493a-fcc6-08de4161dd88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QTVoLzE5VnY4UThNUVZLeFo0d2hXRytGZkl5RHFzbjVOMDJLS2tXYlI4SmpN?=
 =?utf-8?B?MGZDSUZxMlIyeTRyYkJkOGl0KzAydmpqRHZFNVpaQytvc3pYQ0JQcGMrZ3RR?=
 =?utf-8?B?TjhxZ0Juc1pSZ2NHcFA4WFFqRzVySHloSVBaRDlKY2Y3bXl3VjRROVhrVnRZ?=
 =?utf-8?B?U1M3TFJ1dzFGKysweUlzT2tnbjljak9hclVNZVozamZUekdoaHhVNzNGWWVP?=
 =?utf-8?B?L2ZvblpSeFREZC80c2dpdmVXZnoxNmlPV21JL2RmRElyUHkwcFpDaktYTC9z?=
 =?utf-8?B?OXpIU3F5dTJOckhCaHdXOTJuSFlodERYZkJ1QjY0dmdaNTB1S0FQQ1lJN0Nh?=
 =?utf-8?B?T05sWTlNdldBRWNMOGNTdDRUK0l3aWllM256Zll3MUR2SVBoOXltaVZ5b0Zm?=
 =?utf-8?B?MDVKMjk2Wi9ab2NXSUY1NHJOcjJiM0xNbHNxQWZjaGI4REFUeCtDZDZkbVdh?=
 =?utf-8?B?b2tldGV3NUNkTTFaaGlZbGRrYTlUclV5UW40Tm1uTWhCQ0Flc2RTODV3MWNM?=
 =?utf-8?B?YStHcDN4VGEzN1lhdExBMkxtcXZsdFcxVUFwTXV6OXVwTzNRVnhkY1J4R2Vt?=
 =?utf-8?B?NjhMNGh1eXZXUnBZNGJOaS9tK2dJanUzVlNHR3ZuYS83NG96YmZ1YmpZT1BZ?=
 =?utf-8?B?bVJ1R0JtOGFhMUFzZWtkTFBWVTNCdzljS0RoUDRLTkh0R1RrbzcrbUlNV0hO?=
 =?utf-8?B?YVVROHRkWm1ra20vbUVhZEtRc3BLN3RlMnU4b3lMQ1Q1TmgvRlE4K2tTZVBz?=
 =?utf-8?B?ejJlL0V3ZjVNZWxQREtZT3VoMEpaOXUxRmxhTVd2Vm1kcTZRQncxMnFRbFZR?=
 =?utf-8?B?NWNiblZWMEhqNnVWazJLM1NURVNsTDkwRHFqVjNnalJMVE82d0tYeWxSajJV?=
 =?utf-8?B?R1lZRVFNbm0zdi9tZ2h2anUzTHJ6WC9iSi96V3lVQ21kNDVqS0JXWnNIQzA0?=
 =?utf-8?B?czJmeFdPQ2MvelpGK0lQSWF0R3VOSDFXK09QT1h5eVVjSnVTVlVrQlZYYkE1?=
 =?utf-8?B?T3pmWXJLK0pyUXNIaEN0Si9oVmRlSTNINTQ2T3dncC80MG1RWGs0ZGFMMDNI?=
 =?utf-8?B?amdlUG1NczVsWU9iMmJhazBBUjVHWS9YMWw0WHRnZGY3SGhOY2JXZlRNN0xR?=
 =?utf-8?B?TGxPbUQ2WW1OVW0wLzhZSnRnbGxpbkJ2aElpd2JlTXU4WXh4ZFNNaFAyOVRZ?=
 =?utf-8?B?c1Q5L2k3SnJvQ1BaQTRkazdDeTE5b0lSbTNia3BpRHcwVXhFcDhFeWVxbTk0?=
 =?utf-8?B?dTFjM0FGOVR6VGJkdlNiL2J3d1BlL1E5Sk1jdmdRRVNzYlNrTlFpSld0OFIv?=
 =?utf-8?B?NEFqcDhvOTVEWnNNQm8zLys1bDFrd3MyV0V5bkdwWDEySkVJV1pjOTgzck5C?=
 =?utf-8?B?N01QZjNjRXpyTEtoZ0dNbk9vZVEwL2lRdHJjWFNkZzJKbzJKcEh3Nm9Wdlow?=
 =?utf-8?B?MFRCZ0gvck85N3I5YmlnOGtlUjl5bXBwbDBCQVhHdllUVzMwQU9xOWRlMEpI?=
 =?utf-8?B?bUVpVVV0SGNzM1BMOGhrRis2b1k1WTBwWFM0SWVyamJrZ2M2UWhzR24vcUp1?=
 =?utf-8?B?Ti9ncVlmbTJBRmhiV2VjV1dxSURtN1lnb0RhckhzN20zOGtydDVoYmsxd0Ex?=
 =?utf-8?B?MGlMbzVIY3ZVM2trQmNtZUVUVW1hTWdvTlNGY2Y3VGRtZnlkaTdkSnRxQlVn?=
 =?utf-8?B?TzkvMDFjZk5OR2pSdTBsRCs2dHl2T1hFWC8zNnUrTkFwS3JKTmVUNDMwc25o?=
 =?utf-8?B?anRiM3NxSFgrQkFIL2VXcGVoWnVSS3hzT2xOOEtveTh2RTAyc3JzQnpVRXdQ?=
 =?utf-8?B?dWtHOWVMaVREeFl0K3UwMTRnU3ZUY29xQklSbEZBZVhheU5PUHJwSktTOVhB?=
 =?utf-8?B?YTR4K1RhdlpLM3VuL2ZlRjA0ZlBtYlh3TGZXd0E1ZjdXMUtFMDNROWdsY1F4?=
 =?utf-8?B?cVpUbXFPYnJqYzhpdmhVTGZ1bTFTUHRkWm1BLzFROVdoUUZXSm83dVV6R0Ny?=
 =?utf-8?B?YmNpclI2SHhiV1FzQXNKVUcrNmpOUU5QVXJya0tiUkpQM2ZERWhleGpud3lZ?=
 =?utf-8?B?U2R2NmlIZFRSQkVNNU50aStaVFIzNTIxc3lSZ1dHMEZLUWR4RHAvQjdEUmZr?=
 =?utf-8?Q?57pk=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 13:56:11.7287 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb728f9-d639-493a-fcc6-08de4161dd88
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063
Received-SPF: softfail client-ip=2a01:111:f403:c005::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

From: Nicolin Chen <nicolinc@nvidia.com>

Linux now provides a VFIO dmabuf exporter to expose PCI BAR memory for P2P
use cases. Create a dmabuf for each mapped BAR region after the mmap is set
up, and store the returned fd in the region’s RAMBlock. This allows QEMU to
pass the fd to dma_map_file(), enabling iommufd to import the dmabuf and map
the BAR correctly in the host IOMMU page table.

If the kernel lacks support or dmabuf setup fails, QEMU skips the setup
and continues with normal mmap handling.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/vfio/region.c     | 57 +++++++++++++++++++++++++++++++++++++++++++-
 hw/vfio/trace-events |  1 +
 2 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index b165ab0b93..6949f6779c 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -29,6 +29,7 @@
 #include "qemu/error-report.h"
 #include "qemu/units.h"
 #include "monitor/monitor.h"
+#include "system/ramblock.h"
 #include "vfio-helpers.h"
 
 /*
@@ -238,13 +239,52 @@ static void vfio_subregion_unmap(VFIORegion *region, int index)
     region->mmaps[index].mmap = NULL;
 }
 
+static int vfio_region_create_dma_buf(VFIORegion *region)
+{
+    g_autofree struct vfio_device_feature *feature = NULL;
+    VFIODevice *vbasedev = region->vbasedev;
+    struct vfio_device_feature_dma_buf *dma_buf;
+    size_t total_size;
+    int i, ret;
+
+    g_assert(region->nr_mmaps);
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
+    ret = vbasedev->io_ops->device_feature(vbasedev, feature);
+    for (i = 0; i < region->nr_mmaps; i++) {
+        trace_vfio_region_dmabuf(region->vbasedev->name, ret, region->nr,
+                                 region->mem->name, region->mmaps[i].offset,
+                                 region->mmaps[i].size);
+    }
+    return ret;
+}
+
 int vfio_region_mmap(VFIORegion *region)
 {
     int i, ret, prot = 0;
     char *name;
     int fd;
 
-    if (!region->mem) {
+    if (!region->mem || !region->nr_mmaps) {
         return 0;
     }
 
@@ -305,6 +345,21 @@ int vfio_region_mmap(VFIORegion *region)
                                region->mmaps[i].size - 1);
     }
 
+    ret = vfio_region_create_dma_buf(region);
+    if (ret < 0) {
+        if (ret == -ENOTTY) {
+            warn_report_once("VFIO dmabuf not supported in kernel");
+        } else {
+            error_report("%s: failed to create dmabuf: %s",
+                         memory_region_name(region->mem), strerror(errno));
+        }
+    } else {
+        MemoryRegion *mr = &region->mmaps[0].mem;
+        RAMBlock *ram_block = mr->ram_block;
+
+        ram_block->fd = ret;
+    }
+
     return 0;
 
 no_mmap:
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 1e895448cd..592a0349d4 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -117,6 +117,7 @@ vfio_device_put(int fd) "close vdev->fd=%d"
 vfio_region_write(const char *name, int index, uint64_t addr, uint64_t data, unsigned size) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)"
 vfio_region_read(char *name, int index, uint64_t addr, unsigned size, uint64_t data) " (%s:region%d+0x%"PRIx64", %d) = 0x%"PRIx64
 vfio_region_setup(const char *dev, int index, const char *name, unsigned long flags, unsigned long offset, unsigned long size) "Device %s, region %d \"%s\", flags: 0x%lx, offset: 0x%lx, size: 0x%lx"
+vfio_region_dmabuf(const char *dev, int fd, int index,  const char *name, unsigned long offset, unsigned long size) "Device %s, dmabuf fd %d region %d \"%s\", offset: 0x%lx, size: 0x%lx"
 vfio_region_mmap_fault(const char *name, int index, unsigned long offset, unsigned long size, int fault) "Region %s mmaps[%d], [0x%lx - 0x%lx], fault: %d"
 vfio_region_mmap(const char *name, unsigned long offset, unsigned long end) "Region %s [0x%lx - 0x%lx]"
 vfio_region_exit(const char *name, int index) "Device %s, region %d"
-- 
2.43.0


