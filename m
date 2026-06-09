Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB9CCD8CAA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWudf-0001SY-2h; Tue, 09 Jun 2026 07:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWudE-0007Ww-MU; Tue, 09 Jun 2026 07:28:32 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWudC-00037E-Dl; Tue, 09 Jun 2026 07:28:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DP2tuwwKS80H8OQd0AthgSM3BMIRgB7K+iN+NDZAU4X53mh1ru0mKThN/wIPH+zVa2zQ2YCJysBbJrwD7LUTTenFUTQsmNlaFjKyXqxQpL/6OM3RJ4EtQ481azrq9OOBR4qV1Lit3KmI6yW+R+s0k5Oo9vGI7INFLAHzvKS9UOcv+USSZ2yLM2kICb+72NWD3LYqEPSJMOdK0QyUmiCtEQZ1WNZ2x7vAsDiFR+cL9mvzFp4wcUOtHAFQA5I62S55cSnuZSzKkS7e58GjAKgF6BOa42Hq1Jwk9Evht86eSU0UOS/cA/LTLEU59TXBV4ArL9rGSEvfmwUGDed32PaG5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJaeNCWfThODwzfTWKBVNzNq25C7uJIW6QFidQ6NS+A=;
 b=MrunRUiMHxsLwo6Axy74gi+vuVVPxuWusBxEY0FMM4dof3vmvTOzkEzzzYa5oocEtcN32Tgs4nr+Uqi4LquR6PIZfsXYHWZUSKTtOyl6h4ssRxELSwYrw9UuKmcqHVVvFheJCT5Vnf9rK7qaL5kCZwRwtzCm6uN0QbR3dD3cWKAuT3j6tW/bs6eckrr4ij2E4pDprHPDHDAL5HuFlfQiINQQ4tqDY7QQJGnX7K17k5wTQiTtuxK+76Pe8M89WxfJBTI99Azgk/AS0KJydOvHqI8x91mFGLMNdtRxy+2edu5/bc6m0NuMSvAiY9u+HAI0J4xGrGBJ5W6FlMWxcs69qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJaeNCWfThODwzfTWKBVNzNq25C7uJIW6QFidQ6NS+A=;
 b=VfCUxwbmuVDv32PWhxqiEJVr5DE+pJ7JpsdkxiIVVG0ids+VMdtCmRm8r4R56snLSJqNCBqbaq+9Efb28MhcqHSS/7xs1UZMSHGraaaMKwQ2qVTx/0cKBndGqtux5hVEV4I0OW+6hKKtm/svYfHLKy5mXT2qal+KiUBH1ef4rGkV+0rm590F9u3aVfhrYzWmh5CflY8i6UEU9Py8mjcWFmqR3af26ki1o2sbbaKpE3FtgYJEZ7U9VdHP6bJrlcl5jDQvYgooDsI2HcVarXxFvni3f+Y89GL046ngW8UPaZSxSNL6Ug9r8+ldtZ1eC6dqKn4mW9jWKRurbA3GFYzV9w==
Received: from SJ0PR05CA0029.namprd05.prod.outlook.com (2603:10b6:a03:33b::34)
 by DS0PR12MB8526.namprd12.prod.outlook.com (2603:10b6:8:163::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 11:28:21 +0000
Received: from MWH0EPF000C6184.namprd02.prod.outlook.com
 (2603:10b6:a03:33b:cafe::7f) by SJ0PR05CA0029.outlook.office365.com
 (2603:10b6:a03:33b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 11:28:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C6184.mail.protection.outlook.com (10.167.249.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 11:28:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:28:04 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:28:00 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v7 20/31] memory: Allow RAM device regions to skip IOMMU
 mapping
Date: Tue, 9 Jun 2026 12:25:41 +0100
Message-ID: <20260609112552.378999-21-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609112552.378999-1-skolothumtho@nvidia.com>
References: <20260609112552.378999-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6184:EE_|DS0PR12MB8526:EE_
X-MS-Office365-Filtering-Correlation-Id: 38306dcd-0460-4027-c59b-08dec61a360d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|22082099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: zXYbT76fxWX7dKw9VXAO2ME8LCEyBZJoqUh0Izvo6H1bg9dZj3zcGkqUJKyGhqdg9Qpq9TASosfBoLsAZH5hmzqY9aD8rUwtsFNJDKIF7kpxveNCjACReQ5zaSXtfK59lV86wvORRjs1sVOoB/IeG80wzaEv9C7j5uVGcCecabpdtxYV9ZisrmIFzFYAMiSYrGLBSdWMwLlCvvITpITmn4pbncdtkKo1qOBX6FAZh7p5xwQDpExfc6mFLobxRB/mvH+VJ5YyyMkPdkMoonpqT4rLUyee0/H+hNjP0T0lRFKYUAOYtUbgV9pKylbOu3J72Da5ThyyfZQqxe1hL+whG7M0vAFOzFsYhNd/qEatdtkfFe9F2AwGpj9Du6VLx7AD4kpC/cRtf3TC68Hc0BKeQxfOKA2yceS//dBZq7+MMqd+I4CjoMjicsyG1yNEIr4v+lbZLU7L9RRtaXZpCVS02D4fZO8ezn4N3Bn/mRLiAsMloZ2q/3XNqJlYF8sbjVbFYWN/LqwstsnXq+tP5qp7JtrVyIMu5qbnkJc7gccXcoe8z2XzHQbQsct2v+rJSojHpq1szgHoppj1xk7N46KSyuXHR3Ff2/Gf02URykcPQM79bW3iiv+JGsGiysLWLDFuZ7Tn7pFZ+REVBe+ohK45J6BDizq4llNJt+q0G5NgMoEZwA7ALQQba3Y3lKUjaEAPDEXS1g1PzolZ9OXFerRK6D6gzX2UTOgAKazGCP/2Ftw=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0c/NoNO77tFnVLnN8IMNOA1Nk6lqR9GxHntZEj5yMXXvyVIFfnvIfgf7Iy+GpmMKlpQ9hOSPhzsVMC0mQ6lGl+vgUMy0L1niS50v2ron/84EROpJa4JuZtzH0eyxkviu7V9yVGXaKMlNgX96e1lp93MA0Id9adYjcnTVm4PEksWmWOVHgDnuBK1JDOZ/DSYrZs8EO3MpmIVMoMEPTvOWRrFKabvaKSimrbmknDJX3kz9ZjHQHpic1eCeq9YhcLR2HmO6GpHKj3iCUKRP0OX2lvx/NGFJF+jFsY3ERvzlFS06uIdnBWU6WEkuGeoqL8dH5W22rl1BJB0TrflulNo29bz2aWRW0luwARENd8XyKMtCNDzgPhbxDkDtap4jnmSeultL0kv3273BNwPUtNlZiFHcjNdEXYbFyQvyYo4b5MY5GdM3CIUI6XoTRA9rmtXO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 11:28:20.9945 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38306dcd-0460-4027-c59b-08dec61a360d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6184.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8526
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Some RAM device regions created with memory_region_init_ram_device_ptr()
are not intended to be P2P DMA targets.

The VFIO listener currently treats all RAM device regions as DMA
capable and attempts to map them into the IOMMU. For regions without
dma-buf backing this fails and prints warnings such as:

  IOMMU_IOAS_MAP failed: Bad address, PCI BAR?

Introduce a MemoryRegion flag (ram_device_skip_iommu_map) to mark RAM
device regions that should not be IOMMU mapped, paired with
memory_region_skip_iommu_map() / memory_region_set_skip_iommu_map()
accessors. When the flag is set, the VFIO listener skips DMA mapping
for that region.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 include/system/memory.h | 21 +++++++++++++++++++++
 hw/vfio/listener.c      |  6 ++++++
 system/memory.c         | 10 ++++++++++
 hw/vfio/trace-events    |  1 +
 4 files changed, 38 insertions(+)

diff --git a/include/system/memory.h b/include/system/memory.h
index 1417132f6d..4560809013 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -864,6 +864,8 @@ struct MemoryRegion {
 
     /* For devices designed to perform re-entrant IO into their own IO MRs */
     bool disable_reentrancy_guard;
+    /* RAM device region that does not require IOMMU mapping for P2P */
+    bool ram_device_skip_iommu_map;
 };
 
 struct IOMMUMemoryRegion {
@@ -1743,6 +1745,25 @@ static inline bool memory_region_is_romd(const MemoryRegion *mr)
  */
 bool memory_region_is_protected(const MemoryRegion *mr);
 
+/**
+ * memory_region_skip_iommu_map: check whether a memory region is excluded
+ *                               from IOMMU mapping
+ *
+ * Returns %true if @mr is a RAM device region marked to skip IOMMU mapping.
+ *
+ * @mr: the memory region being queried
+ */
+bool memory_region_skip_iommu_map(const MemoryRegion *mr);
+
+/**
+ * memory_region_set_skip_iommu_map: mark a RAM device region to skip IOMMU
+ *                                   mapping
+ *
+ * @mr: the memory region being modified
+ * @skip: %true to skip IOMMU mapping, %false to allow it
+ */
+void memory_region_set_skip_iommu_map(MemoryRegion *mr, bool skip);
+
 /**
  * memory_region_has_guest_memfd: check whether a memory region has guest_memfd
  *     associated
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 0b72a2cf5e..14cca678ae 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -610,6 +610,12 @@ void vfio_container_region_add(VFIOContainer *bcontainer,
         }
     }
 
+    if (memory_region_skip_iommu_map(section->mr)) {
+        trace_vfio_listener_region_skip_dma_map(memory_region_name(section->mr),
+                                                iova, int128_get64(llsize));
+        return;
+    }
+
     ret = vfio_container_dma_map(bcontainer, iova, int128_get64(llsize),
                                  vaddr, section->readonly, section->mr);
     if (ret) {
diff --git a/system/memory.c b/system/memory.c
index 739ba11da6..48245fd01b 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1814,6 +1814,16 @@ bool memory_region_is_protected(const MemoryRegion *mr)
     return mr->ram && (mr->ram_block->flags & RAM_PROTECTED);
 }
 
+bool memory_region_skip_iommu_map(const MemoryRegion *mr)
+{
+    return memory_region_is_ram_device(mr) && mr->ram_device_skip_iommu_map;
+}
+
+void memory_region_set_skip_iommu_map(MemoryRegion *mr, bool skip)
+{
+    mr->ram_device_skip_iommu_map = skip;
+}
+
 bool memory_region_has_guest_memfd(const MemoryRegion *mr)
 {
     return mr->ram_block && mr->ram_block->guest_memfd >= 0;
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 2049159015..70c5aa1bcc 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -100,6 +100,7 @@ vfio_listener_region_del_iommu(const char *name) "region_del [iommu] %s"
 vfio_listener_region_add_ram(uint64_t iova_start, uint64_t iova_end, void *vaddr) "region_add [ram] 0x%"PRIx64" - 0x%"PRIx64" [%p]"
 vfio_known_safe_misalignment(const char *name, uint64_t iova, uint64_t offset_within_region, uintptr_t page_size) "Region \"%s\" iova=0x%"PRIx64" offset_within_region=0x%"PRIx64" qemu_real_host_page_size=0x%"PRIxPTR
 vfio_listener_region_add_no_dma_map(const char *name, uint64_t iova, uint64_t size, uint64_t page_size) "Region \"%s\" 0x%"PRIx64" size=0x%"PRIx64" is not aligned to 0x%"PRIx64" and cannot be mapped for DMA"
+vfio_listener_region_skip_dma_map(const char *name, uint64_t iova, uint64_t size) "Region \"%s\" 0x%"PRIx64" size=0x%"PRIx64" marked to skip IOMMU mapping"
 vfio_listener_region_del(uint64_t start, uint64_t end) "region_del 0x%"PRIx64" - 0x%"PRIx64
 vfio_device_dirty_tracking_update(uint64_t start, uint64_t end, uint64_t min, uint64_t max) "section 0x%"PRIx64" - 0x%"PRIx64" -> update [0x%"PRIx64" - 0x%"PRIx64"]"
 vfio_device_dirty_tracking_start(int nr_ranges, uint64_t min32, uint64_t max32, uint64_t min64, uint64_t max64, uint64_t minpci, uint64_t maxpci) "nr_ranges %d 32:[0x%"PRIx64" - 0x%"PRIx64"], 64:[0x%"PRIx64" - 0x%"PRIx64"], pci64:[0x%"PRIx64" - 0x%"PRIx64"]"
-- 
2.43.0


