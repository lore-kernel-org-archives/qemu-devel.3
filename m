Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28083FC5928
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvYyQ-0003yX-CU; Thu, 26 Feb 2026 05:52:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYyO-0003vj-N6; Thu, 26 Feb 2026 05:52:00 -0500
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYyN-0000g4-5I; Thu, 26 Feb 2026 05:52:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=esE4LfSp2i5vr2fcePTzEiLPhIs5/NWnQ9HSnxzLa5j3HXXXlfql45XeXA1o3BYnoGYk9CHvQI6q7ffIWv3Lu/TDRo6IhktkOLHBzAKM+ZNvMJiEfWexatbHGsi2AeCk/s4SL+7s6SxoCErcrZZE4zFIwzUttdLJIO8DtUl0NpL3bG5qKiLIw0R/TqHIkNxKwtobCLve/3zjAnORCb0cWQ1TMe/0syG/Dy2WuzuZ3pGsPoV1nkAaO3iEQhcZmt/Z0DtIjHZNwJ8Wb4IkZgslHQCs98OscgVY5F0/h6D0/KLm2gNP1YSR28GYqfWD1mXTSCcntCbnIS/rX3xyjZjLTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACaQSioSOPbokIXX0NRiWo1dG3iORgakhTMOTeD4hnE=;
 b=vPJZSHzvowNxiBdgrzu47X0rFLJljTpNZiaoHe/CcLq1dwkm3sZ/B59A0HrzOHl2Wf+LUz2TYTOHTBLqRUj0DWZZIxf5HGrfoihMuvgAOehyjRhSlhQnzpMzgudrdtOqDyxSSC0rbExwJNIPZziRfYlxLYx+Ck2xMLSLW/TyugWSfqTuBqxS28GAr1PxoQdKFqcVVehmE7NvqqKJ0p4J3qeqPGnBDo8b4t0Fo+WE6g5fDFl2S6gYsgUeNHt8BaCiBcs9CyeCpj0GENki0kg/r3kU3nQaCd+/TECWn+iazS8VO9fTBq5op1UIF7fUQWfXaXr/e8w5tqZqJIIPpV5PBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACaQSioSOPbokIXX0NRiWo1dG3iORgakhTMOTeD4hnE=;
 b=nQikfHgFTaqEXGZyMZ53DAwYWeJTJiCNUhJ21QU4vMLHdzHAHsJD3bgyRAWweqlrwde/vSX199Ld+RvXcJtRD2pDLQbl8R3AL1w5k5tE2h5FrJP7zjZZJGMvh2DTCmYLjMjegVJV/Yge8jywmI1Ybk75VL8FsCe/sKrYRq9T4jOBjAcI3F8aApAx3qX1Wm1JdMZogEg/3deouY59nxwBvOgWcwxxKAfHRoYfmCCF7mb4hTkypHSV7/QW6VOFNsQ7DwpuLarjfu84Ft8ttZ9RRk9OI3mnVVM9P4RqyV0oQ3E4Qxv3ppQagBNIsj07x2AkPAlvpcG041u8jW2Op44WlQ==
Received: from DM6PR07CA0107.namprd07.prod.outlook.com (2603:10b6:5:330::21)
 by DM4PR12MB8571.namprd12.prod.outlook.com (2603:10b6:8:187::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 10:51:50 +0000
Received: from DM2PEPF00003FC8.namprd04.prod.outlook.com
 (2603:10b6:5:330:cafe::c4) by DM6PR07CA0107.outlook.office365.com
 (2603:10b6:5:330::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.25 via Frontend Transport; Thu,
 26 Feb 2026 10:51:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM2PEPF00003FC8.mail.protection.outlook.com (10.167.23.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 10:51:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:51:36 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:51:33 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v3 03/32] backends/iommufd: Introduce
 iommufd_backend_alloc_hw_queue
Date: Thu, 26 Feb 2026 10:50:27 +0000
Message-ID: <20260226105056.897-4-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226105056.897-1-skolothumtho@nvidia.com>
References: <20260226105056.897-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC8:EE_|DM4PR12MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: 66e871eb-4d2c-4224-4ece-08de75250bd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: Bq56ir3lw350zydWC8vqaPdbEe/VASeLxfynzHUPgdoTdfZBTvqogRFAUmemzzpKeuSVmao8eBiLLCxyrmidKeWmERZPLwcfzYaQJvynCEfbHqWTXLTCvkfjPUiGcWXkkeyWa85imHYF3o0KGFgFvDTLhQN0pjncZQa0o2+1VouDNqylaP7dpAEq3CwE9T0hlEeyIBFjx4W1xg0rfDnfWnwwGGMJOKKNoUj7RiCX8hsSAr52Egr81t9Dd2JDA9P+P7JM+2fZ4N/LLxcr8LJTDoJeWpnCmYHIrK/21r3In8fQryZolmIGReJzFtU5LmS+Y0HdN7/RNY2bpwhiPxcY6ssccQFJEHBunP1y1t1H/ykVBJnaqIrZyfgOfbYz/GrWuA34EPJNh57p5bl+ha6wD/RG+9siQ4wkp/217PkItzACBxCG/qW7mpT4Ee9aGUqizpOvdbHeL5qwmqw3N1ZemXvNzde4t6Q8SgYIeVROps2eJVSOFhkPuCpZoohZdTCsTzi23hwKEBbClp1sl5AgKa+hXcEflAWcmaNAvjXspEIxA5JJqGnrlUlV59bIlPAhciHkI0c2uJPgadDsXZidju8qBSJAf+nKtBCSdZ+B8mcG/7Dz6GaD5A04lO6rcpSHy0a6IOSFPpPSkl2c29p9MATZV/CBpNGcpXHw4mJEc6GUXUbK+s4tjkvkhf50DpKy8s0r35kyseamu9LuSw5k1rvme8h03u7dUv7pn2meYFif+tRXvHYs986oc1fqCneRyv9pPRemh4tt8S1qxcAILzyh4SunBDWUjDFWJWrFmDwisIA6Lj1kRO2k7nzMxfMkDLKLZUFXI6k8N/Wy6FpBFQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xp8rU9Wvdk9l4KaFisRuV2VAIzzVQaFVZIpG+R6x7TtRYEgy1Pe8Vy7xH6diVCRREN/o/gd4qeNpPyM0uQdrz5gm43AaTSIOft57kd8dXwTA9DcisUJ5sb6g16EYu4n3U7lhXnUdDNhj+LSiyd0zRmc2CblT1kzJNqzAvR6uzWFbX8ytvRqtY3dDQTQaOfvsymZWrnLYRH5V2v3ZtWQfX4agNiR74TkLN88qXP0OL9jDEzwJVdiHHe8z7SAKLF10odODf3hfz477Se1g5KUF/jVU3u7kp/6PMmWXvdHeF7wiT47F/i7nx/y06vjWQa1kUFFO/Lx5s2AfSoiwLTUROlFyYT5pFL5kIFx1SC6z3e3padnAfQuEk2Y00XkyNcPAnDxPYHqUvdyFMQSGX5vMr1f0qGzdJeKjoQP7+WC8juYm1/mR7UP7wbbsD9b+GyQb
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 10:51:50.4021 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e871eb-4d2c-4224-4ece-08de75250bd8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8571
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
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

From: Nicolin Chen <nicolinc@nvidia.com>

Add a helper to allocate an iommufd backed HW queue for a vIOMMU.

While at it, define a struct IOMMUFDHWqueue for use by vendor
implementations.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 include/system/iommufd.h | 11 +++++++++++
 backends/iommufd.c       | 31 +++++++++++++++++++++++++++++++
 backends/trace-events    |  1 +
 3 files changed, 43 insertions(+)

diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index e027800c91..8009ce3d31 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -65,6 +65,12 @@ typedef struct IOMMUFDVeventq {
     bool event_start; /* True after first valid event; cleared on overflow */
 } IOMMUFDVeventq;
 
+/* HW queue object for a vIOMMU-specific HW-accelerated queue */
+typedef struct IOMMUFDHWqueue {
+    IOMMUFDViommu *viommu;
+    uint32_t hw_queue_id;
+} IOMMUFDHWqueue;
+
 bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp);
 void iommufd_backend_disconnect(IOMMUFDBackend *be);
 
@@ -101,6 +107,11 @@ bool iommufd_backend_alloc_veventq(IOMMUFDBackend *be, uint32_t viommu_id,
                                    uint32_t *out_veventq_id,
                                    uint32_t *out_veventq_fd, Error **errp);
 
+bool iommufd_backend_alloc_hw_queue(IOMMUFDBackend *be, uint32_t viommu_id,
+                                    uint32_t queue_type, uint32_t index,
+                                    uint64_t addr, uint64_t length,
+                                    uint32_t *out_hw_queue_id, Error **errp);
+
 bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
                                         bool start, Error **errp);
 bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 400946810d..86f9c9f4cc 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -546,6 +546,37 @@ bool iommufd_backend_alloc_veventq(IOMMUFDBackend *be, uint32_t viommu_id,
     return true;
 }
 
+bool iommufd_backend_alloc_hw_queue(IOMMUFDBackend *be, uint32_t viommu_id,
+                                    uint32_t queue_type, uint32_t index,
+                                    uint64_t addr, uint64_t length,
+                                    uint32_t *out_hw_queue_id, Error **errp)
+{
+    int ret;
+    struct iommu_hw_queue_alloc alloc_hw_queue = {
+        .size = sizeof(alloc_hw_queue),
+        .flags = 0,
+        .viommu_id = viommu_id,
+        .type = queue_type,
+        .index = index,
+        .nesting_parent_iova = addr,
+        .length = length,
+    };
+
+    ret = ioctl(be->fd, IOMMU_HW_QUEUE_ALLOC, &alloc_hw_queue);
+
+    trace_iommufd_backend_alloc_hw_queue(be->fd, viommu_id, queue_type,
+                                         index, addr, length,
+                                         alloc_hw_queue.out_hw_queue_id, ret);
+    if (ret) {
+        error_setg_errno(errp, errno, "IOMMU_HW_QUEUE_ALLOC failed");
+        return false;
+    }
+
+    g_assert(out_hw_queue_id);
+    *out_hw_queue_id = alloc_hw_queue.out_hw_queue_id;
+    return true;
+}
+
 bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
                                            uint32_t hwpt_id, Error **errp)
 {
diff --git a/backends/trace-events b/backends/trace-events
index 3ba0c3503c..c5c1d95aad 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -24,6 +24,7 @@ iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, u
 iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32_t hwpt_id, uint64_t data_ptr, uint32_t data_len, uint32_t viommu_id, int ret) " iommufd=%d type=%u dev_id=%u hwpt_id=%u data_ptr=0x%"PRIx64" data_len=0x%x viommu_id=%u (%d)"
 iommufd_backend_alloc_vdev(int iommufd, uint32_t dev_id, uint32_t viommu_id, uint64_t virt_id, uint32_t vdev_id, int ret) " iommufd=%d dev_id=%u viommu_id=%u virt_id=0x%"PRIx64" vdev_id=%u (%d)"
 iommufd_viommu_alloc_eventq(int iommufd, uint32_t viommu_id, uint32_t type, uint32_t veventq_id, uint32_t veventq_fd, int ret) " iommufd=%d viommu_id=%u type=%u veventq_id=%u veventq_fd=%u (%d)"
+iommufd_backend_alloc_hw_queue(int iommufd, uint32_t viommu_id, uint32_t queue_type, uint32_t index, uint64_t addr, uint64_t size, uint32_t queue_id, int ret) " iommufd=%d viommu_id=%u queue_type=%u index=%u addr=0x%"PRIx64" size=0x%"PRIx64" queue_id=%u (%d)"
 
 # igvm-cfg.c
 igvm_reset_enter(int type) "type=%u"
-- 
2.43.0


