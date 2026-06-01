Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C80D1CD6E56
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:53:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU19W-0006mw-4g; Mon, 01 Jun 2026 07:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU19M-0006a2-5c; Mon, 01 Jun 2026 07:49:44 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU19K-00057v-3P; Mon, 01 Jun 2026 07:49:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sj5s6E0jG2S1hyx8Z+8Wjywsy1W8IKL/gH58mos/LLcUYxZuVMzU9aTaIkgF9R/tMhuSTwwwfrhGkmX+aMy0Qwugk3YE+uv3Wdcp3FhdfcOPbaRVE+Tr8qcVd3YIZbDFLxqefJwrmt41xglMfqMTaMxNT8JLrPQzbj7vDxgnt70W9TuLtPI/0dDhbItNWjc6vD0EfS2IeNbna3Sl2pQxcskmEutkYLcZjZkZIszi8mksN3mOtxwBdEUIqwKdI7fnGCizJZowWoDblHfhbgjJ4CVrdDQdektn5XFmdM6JEuY4UIOQcaI/CzRoi4T56N55hD0rt4Mrcs24erOT7ZzuRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+Ey0RJeFvQiD0ihTSSQ1W9xj8xRC6Z0D1Jh4aEXVBY=;
 b=uvDkbZ4PzCztX1fApQPkOl0EfVYKrg5U8WCLyIC4I83NJzi+wtmZ3Wh11m6BxN6W1yjS33XRKwvtye9PtlojTPT5YyscF/wA4lATVNTArsQOj3CWy4pyBkZqH9Vt8FKlm/rKB3N9NggU6kShJS+U1mLjjjSz6bMQcWJXUj5aGPAVtYMiTh8VTbVwcR9yKeuqW78mfB6o6TFSpaIghBbNkGXYImApypWT99IuXh1atP280pxLK1hJ/SmcZI78dcOhmS/F6OdgZwN9zL0FX7WLAMtrI8oC5p/U+oR9dn8PsUgWEhawR04lI0znG9rrBHZohGXwGHtzBQrQgV8LHyeKQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+Ey0RJeFvQiD0ihTSSQ1W9xj8xRC6Z0D1Jh4aEXVBY=;
 b=pj8NFLDrA2U618TYUxzvI2Eiwcaq758BTmMjwVgNbyZWAumMKvzDCslwh25/541zSgEpi659RXkW58xLoZGJA8CKDUYkJsHwVRZist5YZ/FXGaNcMqseY82oBH6Nubg4Fpuls3FnLXwsSWPhrjDOsk5DkqWTupqFcNls6Y1/UiOVgNzMk0Ra5b7QM+6SfOt2d/3nJtmAAhusrj0cCysAZladxtOcy+pvTyzwjlaHEyFlSd/J0fVCHh3UZDtu/aEc//mO0sw8vPd8TRxVou7cq3TsWeGtO2UlyHylTZEzCrxg9/+JPGgSBtDQ+OS5Orw5LkdjVx3fbX3QqiS9076QlQ==
Received: from MN0P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::16)
 by IA1PR12MB6187.namprd12.prod.outlook.com (2603:10b6:208:3e5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 11:49:35 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:52e:cafe::24) by MN0P220CA0018.outlook.office365.com
 (2603:10b6:208:52e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.15 via Frontend Transport; Mon, 1
 Jun 2026 11:49:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Mon, 1 Jun 2026 11:49:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:49:24 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:49:20 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v6 20/31] memory: Allow RAM device regions to skip IOMMU
 mapping
Date: Mon, 1 Jun 2026 12:42:10 +0100
Message-ID: <20260601114221.457995-21-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601114221.457995-1-skolothumtho@nvidia.com>
References: <20260601114221.457995-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|IA1PR12MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: bd318e22-b600-4fe0-b236-08debfd3da5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|22082099003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: XU64nZdbdXF42CDhu6pRRpRJP4FjAUjmdTFPzw1ylylGFHRFnCguNide+R4vCT3r5Z7auFSISWsIbaBDMznGpXaRYrFoBt0nWoxFT2Wnia6HDfErI/QUoF/oIqVn7fYTuWs8X/LOf57shRH4YqhXJHurAv1np2lUsUg2mn19YvUtz3pBVybEAZVbfyxAggqnO20Chnvpyu7hp+0gLhEmZVa0a0JfTHP656MR8/3Eik9+/GYWcXnzSidmrIOVNbzGrIL6tBerqlj2GCEKTF6l6QIla876W6EmQtSsfoQz8JTEjPAfltbfx6OPyCPDi7C3+MqroauGKc2QKvfvsif6bSWxKl10Ka15ZCmdgsy+SMl+ebWsaCKSvGnI2G9+L4zmZcd2QwcqpVONkfjhh0b9n+uaoGO77wWGoLxqYV2hYhvQuywsVxNyh+HanfASMSq+kE3CMbNRpsn1Rmxu+pxFTOsXVdgxzdOuXiJYZ7QR56ve6xVWL3x7eBWWHTfJcCVgMmxSRCt+qI2BB7+E1K2VzoJ9tDKs166K/aCqpL33pppPgXwreIaqp9HjkBzXCdrHGjG2iETGWO38A+oZip22JRDNPvicyUBQuAcI81S0XF4rJBvG2NvpdQa67ORcd1i928YlD18O9gW21dtbd1ifjZdEDsbjCARS10pWGCs55bFKfeZun4Ldc0hbw3g+on4wW3hDqJkX3FcsqnG0DXsEVchEnQSuOKyp6ZQVJTiZQ3I=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(22082099003)(11063799006)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qJ+HfOVVDyPKS7BVcAiDoiiSLz3j/pZyHSPylo9qa18scehD4PvphX3hjfNUJmtbQ6y1k09OZWRlFoaoBxrW5RLsZO32yGg6CkKR+/tVXrEqkfGrGyvVM9EF2jXfZPh0c5c7msdEEoJuhtXuf8Y7KGXrZjkAbK96E5Pv0O8P0S7j4HHbyydGQKNp6QF6Z7+QO7qfiwtFBWl8cbhFZhzeV7yRldDNVkrRIBnYFtRlpfSxqCQPrw+npn3aR7ETzPwTNj97iMYltooWVE8NCoz8UpP1ffFtu23W0/Rm+Y3dIGjL0DvR/LBG/37/WDZiVKkJvsPmr42kcr2R0YR0gvm/Ehs9q15nv87V+TN+deZJKDqBudA3w2b28YMThtIroaa/96K8CtBeKJ7XFMGKljDe3Io/6TaCxzE6RPl2o2c1TflrbNq5jte5PgWsT50yPIrQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 11:49:35.3912 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd318e22-b600-4fe0-b236-08debfd3da5d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6187
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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


