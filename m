Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E68CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHsD-00023l-BT; Tue, 19 May 2026 06:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHrp-0001DY-LB; Tue, 19 May 2026 06:40:12 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHrm-0006Z3-Ld; Tue, 19 May 2026 06:40:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbQ+zas8w6pZEgnX4C5qaF4+6OSsf1CljdYk6D+wcf9uEMyCVyMCRwk0nBmSLXI7OaEfaDxPouroB42BcFdzoDcvd61tCExrsTcxfNQk4SuGVnw+yzjF5a0FCIzzU14fSG8bxucpFxQ3PgbFhbZn0ozFYDOsF6O7wlf3+MBsXSthvKxLJAV0fQGnSGX2CN+Fu+W1QDHkz9BTNSyyQTcyvpM62zqnAVhZ07bE0D5EZ30GYervBHK5VDUjQYpEtbXBtSGxuP57DpquZUuiP1nnSP7ljk+9NQlSZv0btu/WQwO/k/n55m7HcpOhMC8E4x8DxhBEDq52aIJDuQ9FYIdSyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRt38x4FhRYCtELyHTxGMV6x9z0Hw34kUIQW9+UYBG0=;
 b=WqcSMRgs6kAETGKnyj5/n/3+wX/c4G8pCVppSeuFxOXH2VXqhMw4iguH0KzimemyOeCE2qnHpRx5PlTDLCkGwlE7eruLaIUNIjrf4i2Xe76rp+n5YmUKFBrWBAeT9Xu4W2GPRxBmLADjxi2rTJSY0fknI9AVH1H89kuDpBeJNwEh0cTNSkCopKOqL0IXsfasZVhYdfSGVoRk8aqfZbomvqMidjqj8sxaOaB60H537LsieFqEIf2VE/lpqn6SaqbQVsvFpjRFYqJ7GIpZUt2SgjGwVi2fbH+aT80KFZMqXrpbhtA/Bla3MyKs2a3kOOIdSRCFlQVe19v5XFvcsfhK/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRt38x4FhRYCtELyHTxGMV6x9z0Hw34kUIQW9+UYBG0=;
 b=L0n1eYlhgecimantcUNKbjlQgkjmvC6T0u+orMDfpk1ZabiOOYe7e14EjqC1UhR84k39XGrTCquh9YeztCC75ArE6UjTzFvH8sbuMFH+5Ds2USyy3QmLiEB+7Mchi4544w4kyV8nbsvwBvN6gYYGdluHzCBh4llxNVang0EgC39+pW56m7o3HDYwRzHfsvEs7dhdSFwdHpMF9Z+4TmPUvXouhkwgtxcSMwX/6/9guicpNLoZvmqrXpXY+BRS456SVl/j2BzT9PU1Qszt9d7cFx72jo2/bf8zum5iEDtGa8kE2IJRVZHek4HTERmnNGc+4f0Pv5CMdBh7gnNweVdSIg==
Received: from BL1P222CA0021.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::26)
 by LV2PR12MB5751.namprd12.prod.outlook.com (2603:10b6:408:17d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 10:39:54 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:2c7:cafe::9f) by BL1P222CA0021.outlook.office365.com
 (2603:10b6:208:2c7::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Tue, 19
 May 2026 10:39:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 10:39:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:39:39 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:39:36 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v5 21/32] memory: Allow RAM device regions to skip IOMMU
 mapping
Date: Tue, 19 May 2026 11:36:59 +0100
Message-ID: <20260519103727.899332-22-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519103727.899332-1-skolothumtho@nvidia.com>
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|LV2PR12MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: 58e819ca-6086-4064-f332-08deb592f700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|22082099003|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: vAx5vdqP7n5K2hOg+xtBcOp/jb2SUX2aXhGN5lAhBTOnyQ4/moGoSfvk5sHhX/GfnKhhSR6w0pZmtF7zkKmw34Dkhmoh1VtnIK8ue1Tlc9PXeFvvnvOsEhhG0cuBsnamMlJmuwsPRWSkjJTHVqh4hcQupCwXD5Q5/ElkwvsxLsKl5ULcdGZQKKpMlYBNW8uxz6nPWgalXRUtkZe556Atv93GmaZZ442L3yeTNS6PH2A51UB1EF16B6pDKvWblZl7L83KCkaq6KoZQVB5keBUNMX5/mFxwlboSQJn6r4Y9IzXl1CjIh4kpvLoxN5cb6qRiOTZ43WTl3W8kUIGlgeo87YqHB5BocW++h7aiMItcb6FO56gBZF5AcSK28DTjNc0L2W5ANL0dy1ShpMXOm2s3GI0KtjhhUmTOTwQS5uKhWlxptMWJoKV+n8rJhDRAeo0OuUSj+chRE1HNFYHRj/dfvHwLap9R8ulRQqXUvckz0DsyirT2tQaQ/nOJPSIucCoGeWVlvpK2/HnputajEoOVzGSdko4tTTrmiJF7Hwa5/fPTMDwwcKwM06pl0kBt71FJk5Ucoe4JshcHB2zA55h0kjCfVqvSGDghJHKqcOJbkt8wNOtMmfQJfy4XIuyGoFExurci2mVCbx47O4XU0FemTBJefcnkTlUrKFSH4XtW0P9W6LQuRoVI0DBPtHy9ZsYePSdS8mYrZyZmWV5NktCQ6fwZ3CeaAWkJRhN0OeOuMg=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: d0fxa5Hmga8YLZ5qfJvoHlaj7EPHqEqSfzafEzcpEPFC+4F60k7q9QXY0achGM6BGsE4OHklMkA6apmujpBs1vhmnR+R7F9wLNMw6VsQG6LWTZ5SWYXnF8DwUR/lDcRon5AxfjM2WNxNMjm1iWnGXYrIpdR8dFD4ggrHE9+w/MyA+QYChjNkgFQ/jb+yy8Uao+YwiJ0bivnQosn2QzZVZVhR9ohkA4UN8d0HLl8Qctxidl9OW5D26IOfAJqDbVlcZV/4l+S0hnOoIAJ15WfOGnodP+xWC5+A4CAJ1Fx2PzX2XQglWTGEird2RJXgkC9MtfKriKkZCmI9rXgvLQJlN12+gbow3gy+ab5qSgXrycxhkfk9tuZ0h320IgrdAnh80Tuxg3QLpcDcBq5LdEPCvkhFoeHXjehazZ+Mk4oki5Fp/RfkRcT2yeCUrWtrjysj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:39:54.5131 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e819ca-6086-4064-f332-08deb592f700
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5751
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
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

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 include/system/memory.h | 21 +++++++++++++++++++++
 hw/vfio/listener.c      |  4 ++++
 system/memory.c         | 10 ++++++++++
 3 files changed, 35 insertions(+)

diff --git a/include/system/memory.h b/include/system/memory.h
index af5f96f6ff..b11d6bf07f 100644
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
index 0b72a2cf5e..18100e9897 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -610,6 +610,10 @@ void vfio_container_region_add(VFIOContainer *bcontainer,
         }
     }
 
+    if (memory_region_skip_iommu_map(section->mr)) {
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
-- 
2.43.0


