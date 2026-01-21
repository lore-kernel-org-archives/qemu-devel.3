Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8EA4C4451E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 11:49:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viWbb-0004Yl-PG; Wed, 21 Jan 2026 06:42:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1viWba-0004Xx-Pn; Wed, 21 Jan 2026 06:42:34 -0500
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1viWbZ-00039R-2G; Wed, 21 Jan 2026 06:42:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pe+tdCeT1ETjuAtmRQ+I9mOWTiioN1et6hpKRPeYzmKWLh9wVr2X4VXCTSKDTZL+uZu8v6apvqZet6kXauAZ1NMPlxFRFwLAQ7LjHo8HbDi6Sdhux/ximdTXy46UkOjscGl6KYRacs0DsmdBOJwG46fM4KfzqmAJGq/OJabk+tlz262U1MfYcMmRI0Ml0L8rkxpANgNCnIE9woZrRQYEL/3c2AHVDhOkBeKZeh9NVc5lxkUScHH76cVZI9o40XR/z4Vp6IpZ2ngGE0EiAEgfmSgmKm8ADjqBl5J9d+UQJQ8fYlaq3nnbe2Ii0nnFZagVkSj16IXGPSDs7krYsHae2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=566q0h9jIBTlLg23Fqgn3lAc+PLZZYWqOH+w14SwIKY=;
 b=J3BSk4eqNYiyRQDuj4D63zx2uVAV3SRPLWbDAM4zzx2is1pNEhJvz0+WIJJCxniLmB2MjM++X83GeWup1jW9Y19QdWcyDigV+Ax2f/ZqL7VKw7/iV0Lxt46gvtBTssUrb1d9XLHdzzRLxxll0qsh9SFzSktvKdIIOf5NkWIwGiRm4RAAea+Pvd+Jn16CeqVSCZgPnFJRa0FeURMmEkmfvQsaV8V5ke9OLOqx+3Gu/8X9iYsHu4R7I+9jVC3kOWVV3B8aAQDq8Zk77bdy8gbUixuibaqs+j4I7HL7fulQ/JP2cfCnTAyGWou/G9oK+hIKMpvq3sEPMtRXNxOWhro1Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=566q0h9jIBTlLg23Fqgn3lAc+PLZZYWqOH+w14SwIKY=;
 b=kWKGRzRD/uBdhsr6jQK+QAA5OGeQRmVIgVF6wurWdJRDU0LkLWyvS0OKVzRXSL4BVhQ3vuBuKgkF0vnO4+W1ZjGbyFreSmEMKFmO2YBKqb70y+/nY8sVEhPh+CCG+u0aloA6WZyePaMXzrh7ssPsna+1/k/f8wbZ6TkNniSW3KyJHuepIwqDAsmGdGaIxJA4YQQ125UwX6IeLbbISfalPBZLqwHenC+YL/kfizS7c1fqLZcmnSgbDEve6biu7+QinLivM67eIjDueaXA9tRykY6sbA10nO3zt/n7zTwX2dsniOhKFHVbbIa7qUmJh+jOrI92o0Wl32G0VcbSf7yMZw==
Received: from BL0PR05CA0018.namprd05.prod.outlook.com (2603:10b6:208:91::28)
 by DM6PR12MB4185.namprd12.prod.outlook.com (2603:10b6:5:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Wed, 21 Jan
 2026 11:42:24 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:91:cafe::c6) by BL0PR05CA0018.outlook.office365.com
 (2603:10b6:208:91::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3 via Frontend Transport; Wed,
 21 Jan 2026 11:42:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 11:42:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 03:42:11 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 03:42:08 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <alex@shazbot.org>, <clg@redhat.com>,
 <cohuck@redhat.com>, <mst@redhat.com>, <nicolinc@nvidia.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <vivek.kasireddy@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v4 3/3] hw/vfio/region: Create dmabuf for PCI BAR per region
Date: Wed, 21 Jan 2026 11:41:11 +0000
Message-ID: <20260121114111.34045-4-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260121114111.34045-1-skolothumtho@nvidia.com>
References: <20260121114111.34045-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|DM6PR12MB4185:EE_
X-MS-Office365-Filtering-Correlation-Id: f1b24b95-a961-49ad-21cc-08de58e2256e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YzdJQm41Y0FLNGZjelZLcVF0bGlKQ24ySGs2MnlibXZ6UHdWNDk0RFFBVjBs?=
 =?utf-8?B?c3RoSjltdkl2Zy9XNkNIZm15dFJ6Rmo0K3crSG9XMC9VbzErb2x2MkNOSERa?=
 =?utf-8?B?aDdIWEhadFcyTzVIeGtyMk9GRFpmSHpVNjJYZEZidmNqbkZST0JYdk1xTG4r?=
 =?utf-8?B?ck9xczFGT2prNWcxS01od25adG42OFY3bFNSYjZSbWdLQnV6Mk9SUEYvODMy?=
 =?utf-8?B?blNDSlZwVHN1Mk1HVk9NN1V4alluaWtId3gwVEhzeHNVOXVKNjdYeDhHSmpi?=
 =?utf-8?B?VnYyajFGN0MxWlFOSHdYR0RuVlJyWHMwNGRMUjJMbmtuc1VxWkIwdlNUbkRH?=
 =?utf-8?B?RHRoYm1ybFh0RTJVZ212ZXg5K0FLZVpBaWR2NFhsVC9QVC8ycFlpamJISENE?=
 =?utf-8?B?K01BNzFyNGRIRkRoTGN0R2xzOE1paW13NlNwZWcwcjBad3R5a2cyZHFZZHR3?=
 =?utf-8?B?S3dwaVd3dDZOcHl6K3Fycngvdkh5eTIwMTA1ejlSSlpCWW5RZVgzd2xxU3lB?=
 =?utf-8?B?NWVMN2MyZHBJUEorYlBOenE5eTBUQUo2ZnBwQ0M3M09CZ0dDN3NMZlpXUUV3?=
 =?utf-8?B?Vml4bTRtbFBad3BDYTI2KzRnZ3FJd25CNnY2TXYrTHpubU95YU5UbGh6bkhu?=
 =?utf-8?B?SXZjbVN5YmFObW5ZSktlcE10Wk90dFRaZGd5bm4vdjU1U0w3YTIwbVRqZXhG?=
 =?utf-8?B?VHVDOXZ2d05pZTZaM1FRUUhhOERxdTBIQWhoWGtBT05VcDhjY2JwWEFrTG1m?=
 =?utf-8?B?d2luWWlaVWtUYmJ5WXZHTkxtNVhYMk9lOFo5SEFSRlBLQUd1ajFsbTgvK3Zh?=
 =?utf-8?B?YzNFVi9KMDlBQk80L0hFY2xFZ09jeGFYbmlFS1h0bzRlSnFxR05jQjI2cldq?=
 =?utf-8?B?NlF6U3B2anNvZ2FpaEdmNUtTL2QrODNvem14dDNvSVRLUkUvT0U4cW81aTlI?=
 =?utf-8?B?eERsL0VJVU9FZkx1QXFBMEgxVVF4aDRMWHk0cis0S0I4ek5CM0E2dHNFVTZR?=
 =?utf-8?B?NFB2cHA0c3pIM0JTZ1R5b3dKQno2amVrWWxhaHpsYVlqZnFTcEFVK1lSUUtu?=
 =?utf-8?B?dzNteHhCeUZpb2JiczF5QjVFT0Fndi85U3JwbVBHYUhHdVM1RHJGU1lrS3Zk?=
 =?utf-8?B?RXRLK2VOeU0vM1hUVHBDaTkvVS9JNzlsYjRaRkFWaEJraGd6eTRRVlZmS2JJ?=
 =?utf-8?B?NWVWcy9SSkx2dUgra1BvUVhHWE1kSVI2eDhrVFRZR2FMb3lyZXpSSjd4eWpk?=
 =?utf-8?B?RXorOHJsOW14di9EN2J2b3ZqaFgvTUt1cXJKaUtMU3IyVm0reFEvZDhXWTRP?=
 =?utf-8?B?YXB4SE85ZFc3UGVlaTJ3WTJIT2JHRnNjdHV3U0dZTEE3ZkdhSURBNGdTZEZq?=
 =?utf-8?B?a0Jwd0pnNktzT28zNVMrTzYrNjV0QmZ6c2d1UkZHUnYrcWJDMENQanVYTXNI?=
 =?utf-8?B?Qk1NSC9mcVFWaEduS3pnOWxEaXBRTlIrS2tWc3BFU3UxOWZYUXhjK2kyVm9q?=
 =?utf-8?B?anI0K015TzNkc1VUWks4SkVSeU92STN6Q0ViZEwzdFVnU0lDSUYyZzZLUkNn?=
 =?utf-8?B?Z2RhUlFLR3JTd3NpRWtGMUl1ZU1tb0RYOHQ1V0VOajJOeHZ1bm9ZbW5Hcm1i?=
 =?utf-8?B?dVVQK2hBOEhqSFY2K0RHU0o3RlZPbzVlTHcxaFM3RVJua3pZY1JyREdQaktV?=
 =?utf-8?B?L1p5RXRHM1YrTnQvYU1wQ1R4WWRhYlNDaVgzeUxmVEdwSGI2ekFnTUF6YWsr?=
 =?utf-8?B?VWtPU3FZRlJIakF0LzI0WFduUVU4SjhoVVlGUDlLdFYrZk81RjFNN041eGZw?=
 =?utf-8?B?ZE1OODFKRU1SR0lTZVhvODdBMGdMSzJTU1dhRjZucE9OWSs4TTdFVEg1R3pV?=
 =?utf-8?B?OUtlZGpIU21vOExySzRKQkgvbHNNT2JBWkNhRFNiUVI2TTdMbVQ2ZkNMYXRJ?=
 =?utf-8?B?WFI0VDNETTkwRjU0SlJHeVdKbjJhV1gxdWJRVGdxOHhqekxEQ0tsdmFaaktD?=
 =?utf-8?B?ZTRrb2VLcXBjTUpjOFd3eU95M1ZiUGNSTThUTkVDRjFaMFdlMHBtNXMwWWYx?=
 =?utf-8?B?cStZRGxNa2NuTkh0dzNoZjZBU1gvV3hkS2taYmJQdlFZK3dvOGp5YXpPcXlF?=
 =?utf-8?B?Sk9FV3JtUEpsWVh5S3V4WVA2b0psY1pwSnN4QUl2d3REUFZEMHpBQ0twc1Fn?=
 =?utf-8?B?TEdsam1uSnR1T0wwckN3aFpXY3A1bStramh5QmorWUgwS1NBUUJHRkJIbk9y?=
 =?utf-8?B?U01TOTJxWDRCZG9wcldjVmFJTkd3PT0=?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 11:42:24.5217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b24b95-a961-49ad-21cc-08de58e2256e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4185
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
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
Reviewed-by: Cédric Le Goater <clg@redhat.com>
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


