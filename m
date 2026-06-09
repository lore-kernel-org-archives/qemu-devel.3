Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBC1CD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWudF-0007ZP-7q; Tue, 09 Jun 2026 07:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWucB-0006M1-10; Tue, 09 Jun 2026 07:27:37 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWuc9-0002y2-93; Tue, 09 Jun 2026 07:27:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jCdM8w2cJzNeXd9+JyaCMJYepZd9Fjlwy/lFYPt/LspwhBQoR7pn7MZ/R0rJAJsnq/CHuMRs7RazF7kTefyPjOAh6/MoguaK0fsWSlIOyX0uJ1JgQLKL42nYy+CCt2mssObmIxAy7tvLPRx8jtreoe7NmhK/AxBmhmiybxhrSkx5p4zWgjvp0VMEopb/oOKIFq8tIQK65rQRi+uukk/R1zYFg4ToHQHn3G2gLz5Qr2tRMMYtBeXQ7JEKFHLb21apMeKKxmQOSbVHrUJt0hXbr/inyP0QCMw5+IawYaBpiEkZRFmKPA8Jn525tHGoN3tT2mr5ijeJg2fS3uzPUC9caQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aC8KGMPb6q6TsTayKM4J5xOO0ls/3mlZ8CSEPKKIfao=;
 b=PbLVlc+bZPVvTbuGohe98VvkIw/K4zbZaz7O2G5phzq6cckj9WzTcvvBNpzZfLeCtmut5FQRqM7nmM1rZXxxo3Rbb5nXKFnun4E+UPX+Q4avA1AvDoyapGFY5Qi9g4AhcWjwcNVa0RsfocuQCkMhJVMGjxcAAm3/IOjC4wxVnr/DC3X6Jn4Urf0930diGSVbWKXXCgzquq6VdP948IBvXxW8a/5++/JkpfPP1wQkrITFhKOSAcg7dHEY2CM2y2XEPlJm8qi7go/E4BpR6U+Bq/B9ujop7nXRmRP1zmdZdRcQG6OzCOAncyPGv98BUb6tFjM/tBX7GChnUtaSo1K2jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aC8KGMPb6q6TsTayKM4J5xOO0ls/3mlZ8CSEPKKIfao=;
 b=jQ2s6XvSUFu12tn1f4QpGTOMgeGwhdE2V9eFP2AjBSpRlwiVpjHwVpsmAfDs9KT6KEQfXP9xrOatToeDGQB5FgJh/GZ+2aLwNwXw5LjOr7VU5vTlxreJIOLrtABSn+FA+Ik+9YbZXHHHadSqD3roA2tYlwtjGqQPUiEN7+x5pTVN4cJYfH5WBNoTDyGg8m5OtgIQyq83c2jZbm4FEuEEg+fkv/6g6WZq333np1RAytbTmT8UIe0mSssFFImbO8OnAImulmwCox5RXSaxhE1rhyCNAcLnfnT1WoOELEjPMrBJnVeo1sObxVo7EaBSq0qN7rJvsbwGVkZKWC75hWmONA==
Received: from SJ0PR03CA0282.namprd03.prod.outlook.com (2603:10b6:a03:39e::17)
 by MN0PR12MB5908.namprd12.prod.outlook.com (2603:10b6:208:37c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 11:27:16 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:39e:cafe::43) by SJ0PR03CA0282.outlook.office365.com
 (2603:10b6:a03:39e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 11:27:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 11:27:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:26:55 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:26:50 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v7 04/31] backends/iommufd: Introduce
 iommufd_backend_viommu_mmap
Date: Tue, 9 Jun 2026 12:25:25 +0100
Message-ID: <20260609112552.378999-5-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|MN0PR12MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: 30bc3c8a-13c6-492c-39e0-08dec61a0ed6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099006|6133799003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: fdlw+XzKAWA1EIEZO57n1EhRrQrnJGZSJYFEl2aseD7wE/3he2oinyigd71MMDoXr1law+7bv2UjcVYDQNIqLvFhrraPpfF0kCWrT91MlCu3hM/cP+OoxjnB6ReaBOBQ5tBMY5NfDPOl0NoBvgEm+ezvvW5AAvpIlvxaJainAp+DlmceO3Pw6lVtq2oW6UFNvFrQbeJbkFA1d+N+M5h1fwN4gCuYZDHXkynmTfUEXHriTKPXoWcdgvLnRIZWpesAvwBdHPZawHGsBeLtn+L8ZPYHqSM/iNJRTW77RzSVawwCD/XeFkUl0hoxT/d4XjH2oeApsQHOnNCzS46GOduuS4B9EQ9Y5/X+7JaXYHQtWBaaWHh47D8xa/odNFfwzoocHwiLZhRTPsysotNV6hnsnajhRsXDU8UIciPp/GRMXpZuw48ckvyjFW8pByKy2LmjKlCfgY5JIAJfaF19iCWE7BxX061tJ5cQ2j5TeQXP6N6wyhZEdRjPWjvcGHs3m2wWfE15vgoIopGvHTcdDJg6PKMqR1QICkj1Mffqoishi/wLohKv7OsQu90plkQx74v+G6oe5NEMx/pMt/rTXkQ7rjNBO+mM3LQ+Uh+rkSjnKBWLckzrNIfKqwz1ZPqtehy7RfD+IrCroEe1YFFYzmoJ3vXBCKfmkZkq/Iz+ys+lHvYWL22u2WyRHw+XR20OwutZNWsulxZ6h+J1956gwOyrRAXoFsWW+JXZxtBqY+aOel4=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099006)(6133799003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: m3rLBZC4qqaRznytgFN+Hi6u6Cfb+XAQfmiRfeUC1Y+Gdp6SLBQpLiOaJommSkSx9b6J4De2dRKY+9mokDDF8VPioJQZnDTzzZMtEGq1vjDKG+EWMKVm8rPO6aAItWQPxt0B5LoRmW+H3YRvfaLItd6X/Dbq3x7FHpw2iSkmouq2PzCEYRwOi3UNjTy0Y4LGy1Pi/joMyeYlgC5IGtIS4O96VJGPb7uuG5kOin4s8tLrOEC94SRnxQRZ+xNvDi5r/0xg6q9bPexHw/sLY8wnZWQBVA89VXwE0uPMDbkGzdM8KvKsIlhcuKEkNxcP/Reokk0ukWUf+n91+Zm82RbjjbbLADWD8FXJy2p9BLaVv4dEWLDAUkjggYsljYp+cj8A3wTgA7rP52Zi7/WuSZZhRoDpGXh9mOvhswAirldXmmNYzJymxiFsmz8Maqd1kQvO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 11:27:15.2148 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30bc3c8a-13c6-492c-39e0-08dec61a0ed6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5908
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Add a backend helper to mmap hardware MMIO regions exposed via iommufd for
a vIOMMU instance. This allows user space to access HW-accelerated MMIO
pages provided by the vIOMMU.

The caller is responsible for unmapping the returned region.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 include/system/iommufd.h |  4 ++++
 backends/iommufd.c       | 22 ++++++++++++++++++++++
 backends/trace-events    |  1 +
 3 files changed, 27 insertions(+)

diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index c6f2e87a7e..bb8d5081d7 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -112,6 +112,10 @@ bool iommufd_backend_alloc_hw_queue(IOMMUFDBackend *be, uint32_t viommu_id,
                                     uint64_t addr, uint64_t length,
                                     uint32_t *out_hw_queue_id, Error **errp);
 
+bool iommufd_backend_viommu_mmap(IOMMUFDBackend *be, uint32_t viommu_id,
+                                 uint64_t size, off_t offset, void **out_ptr,
+                                 Error **errp);
+
 bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
                                         bool start, Error **errp);
 bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 8eaaf456e8..440c1b82bc 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -580,6 +580,28 @@ bool iommufd_backend_alloc_hw_queue(IOMMUFDBackend *be, uint32_t viommu_id,
     return true;
 }
 
+/*
+ * Helper to mmap HW MMIO regions exposed via iommufd for a vIOMMU instance.
+ * The caller is responsible for unmapping the mapped region.
+ */
+bool iommufd_backend_viommu_mmap(IOMMUFDBackend *be, uint32_t viommu_id,
+                                 uint64_t size, off_t offset, void **out_ptr,
+                                 Error **errp)
+{
+    g_assert(viommu_id);
+    g_assert(out_ptr);
+
+    *out_ptr = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, be->fd,
+                   offset);
+    trace_iommufd_backend_viommu_mmap(be->fd, viommu_id, size, offset);
+    if (*out_ptr == MAP_FAILED) {
+        error_setg_errno(errp, errno, "IOMMUFD vIOMMU mmap failed");
+        return false;
+    }
+
+    return true;
+}
+
 bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
                                            uint32_t hwpt_id, Error **errp)
 {
diff --git a/backends/trace-events b/backends/trace-events
index c5c1d95aad..b63420b73e 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -25,6 +25,7 @@ iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32
 iommufd_backend_alloc_vdev(int iommufd, uint32_t dev_id, uint32_t viommu_id, uint64_t virt_id, uint32_t vdev_id, int ret) " iommufd=%d dev_id=%u viommu_id=%u virt_id=0x%"PRIx64" vdev_id=%u (%d)"
 iommufd_viommu_alloc_eventq(int iommufd, uint32_t viommu_id, uint32_t type, uint32_t veventq_id, uint32_t veventq_fd, int ret) " iommufd=%d viommu_id=%u type=%u veventq_id=%u veventq_fd=%u (%d)"
 iommufd_backend_alloc_hw_queue(int iommufd, uint32_t viommu_id, uint32_t queue_type, uint32_t index, uint64_t addr, uint64_t size, uint32_t queue_id, int ret) " iommufd=%d viommu_id=%u queue_type=%u index=%u addr=0x%"PRIx64" size=0x%"PRIx64" queue_id=%u (%d)"
+iommufd_backend_viommu_mmap(int iommufd, uint32_t viommu_id, uint64_t size, uint64_t offset) " iommufd=%d viommu_id=%u size=0x%"PRIx64" offset=0x%"PRIx64
 
 # igvm-cfg.c
 igvm_reset_enter(int type) "type=%u"
-- 
2.43.0


