Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91370FC592B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvYyX-0004Cy-87; Thu, 26 Feb 2026 05:52:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYyV-0004Bc-Bz; Thu, 26 Feb 2026 05:52:07 -0500
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYyT-0000h0-PE; Thu, 26 Feb 2026 05:52:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nh24uY7/SXE/879/JjamxwCoQnIZwKKFIMMQj19gIkbvPftONx0ey0+Q9H+jObTxvPxCR5GiXCZkwli2xjb9BxjOUIKg7iCAer/1R1Y2P5INYG4VKJZVCRz2ga/8htoXGNEmXtxzc4RvSZSHa6jNL33PYE9xivANl3oKWBkqR9cYYQt/GYDK1RFEhSpj/zVmKwupOtyzKV3DEGfxdAd4Vac92X6PssoZjjxbO80rBJ1G75wcc5FF5XtP5ovEllgR/Mi6yI3r543Atrw62CZIsOF4vRPbc9dhr77vRtuyl4j/X580gx5xsT7Hd3nRqImcuXEGIkbwViOYjpWkFrTNKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4QPCro/BMPpVMIt9J5MQcjWLKO4Ir/6GgdQ/3tmy7+E=;
 b=QhX2tck3LvSevWSgKjfII5uDvjJW0AQuqXl5P7mQgBkAN/LYmJcNuDxJKVHWI9z2SZyqo6xw/12DxruPrnGBnDjw2I5GuTiNWJawgFaAKEJIKRR4Wb2qDhBZ1Yz0qjIxzXBl/wNfXFMkoSxlBGLd+khpCw3Ca4Q71YdIepYrUa858HHzLBTMiXXSvHRIQqyzT9YaZqIoWFdfvyeVKZw//WnaB8rrURlsQOCmetGbmXRGjkhPzu66iFu373knhqb+sMCiEg271jNkqPPbUs7Lwv+2i6viXN8FGThrPNVbQaOetoPtY4f9zRkvv1oO8/smUt0RtBBjK62OPiLrOUxksw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QPCro/BMPpVMIt9J5MQcjWLKO4Ir/6GgdQ/3tmy7+E=;
 b=YnJEoo+pRE3H0Gwxl4q+2upTj8WF2cp5raZvAJCVxfZhx0ENLnkjGvzxq1upzpun1EoJzKMc2pNOwUUX9hr7WzO49qj2fMdORk5NLogbdlPdiw0YJc6gdyUvg3bY3SfnYOZkqhLhvfl+TIhrIotG/+tVbI+1QCmU4fOTYuAjwOeVERwFn3Mr9QPf9yOjk6CagXWevVtJ0EaNG9gSQysuzrcQRiaHz0YyYHj3yzhOu3/k9ZA2DMuAtzVyhtWLujRPLNUlMUqcHpqO6U7WrRXxOsKbc+EgqCN3s4iVhLXKXUfpCECxWLssIO5BScPwmAmuEAZjQUwdU162fwjTMShnlw==
Received: from SA1P222CA0115.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::24)
 by CY1PR12MB9604.namprd12.prod.outlook.com (2603:10b6:930:108::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 10:51:56 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:806:3c5:cafe::78) by SA1P222CA0115.outlook.office365.com
 (2603:10b6:806:3c5::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.25 via Frontend Transport; Thu,
 26 Feb 2026 10:51:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 10:51:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:51:32 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:51:29 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v3 02/32] backends/iommufd: Update
 iommufd_backend_alloc_viommu to allow user ptr
Date: Thu, 26 Feb 2026 10:50:26 +0000
Message-ID: <20260226105056.897-3-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|CY1PR12MB9604:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c24e5d4-afec-4206-31c2-08de75250ef8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|7416014|82310400026; 
X-Microsoft-Antispam-Message-Info: f70oVBjFpuJXSZg9dGs81DdR7oYuHTBYxdPReSuw/xO/E048XVtCW7iNy4S9vtYbSh3bweLiIgrGJA+wu+3k745+XaBV60F/nxh1fwFjxwVF6OT2+4Oa+kyHvtm9WCg4N9cTPABe2FG6ISlF7P4+AQMZ9PA+REWfCrL3IK/+WjU96W2pg1lfxb65+4p218sEMdLG2YUkkAYSnovjIFiZLvdtRWO/PyvSrwz/2E+7rpKXG9F1TbotjRIPQOQpXOqV+vbm4j2KkQ+VPOo31MD2XsCq8F4jiObSWJ6el6Z64IXJfNzr0mvKspSC7In9en756F3z/VeeNs8WTtCb0WaP84H+C1jBVhAp7/hRj7eEHSp12uVeusZHeF1c133zYMfW9oIBbNm6sMhzqqBffi6E7U6IgZ3cfxcSgQ3dmSBD2BRfD8srt2y8+tXAKtGVnMYaufmK1vfpAoz8GURQA5cvbPUvGQyTaKNPTCHIfyUdSM5O9K2xX6zgKy3XictTYqaau1m49bSs0MnysZvLFo4+EbAd1Mvb+aKKm2OkhNYBaxFjKv97nZMVUcw6FwDOLq3NLl1D3aMdGq4GexP9xNsObbx3F+pwIS2jGNdviwk+WKmRXspKiOE7WT5eFO0RwZzq0KOpRmkc7NRA5k2jLEirc99QoPNhdBNqN8Vqm0paTDV8KwIGtZmQnw6p1qGLj5B8cyE5bYqVNMXhYdaY17xRlMyImfzzL9OLK+fXZ7wI6LIVQtXZ4UhtFfbJUlZaqyRqyKJxni8zTnjFqUQXvvcjdjJaWWagOvr6gcFFA+vCofRJn/0M8/3ptJksd8wi4RVs7sgntj0UPFVLsi3Z4ox8Hg==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qqwzCH8jq6StyQwFMNR8q7ChVBj9a+DckPgkyd3Z9XxzVVmW4lc0dP33SvWzIgJ1G9LsiOKHQ7LZrWu3d90kvaHK9KsP9kbcMh2cYCXkoLlQp9LZiSkcZjW4Dxlbwr1a1oq3gP5WqsmkqwaE11QilUxEFqv5sfg3Akj0fgv7CieOktAsgZt9IgPIT872i7ekjMaVMVSsQ09jfqEX2Jl/Of3c+5iZ52wscUcWd9sKZEy7vGcnGDgkigFrAvGpI/ikKn8z9Qjb8s6IvVndGG8Mbrr8MCCjwPeeVbHswO1mDCqYg/FaWFxVbrXX7VRYIEy5v45ld0KNAdgNxI0QjhYPLMK9cJsYrjHssi6pOLPc/TS1FjsyeEaa0Al/URgC8mhe44u8lbkk7l+gHf6O7l9LM3yWUuKSiFwW/yDNrSzWo1XpVyVHqxz7Otnix7fmUXOu
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 10:51:55.6460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c24e5d4-afec-4206-31c2-08de75250ef8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9604
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
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

The updated IOMMUFD VIOMMU_ALLOC uAPI allows userspace to provide a data
buffer when creating a vIOMMU (e.g. for Tegra241 CMDQV). Extend
iommufd_backend_alloc_viommu() to pass a user pointer and size to the
kernel.

Update the caller accordingly.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 include/system/iommufd.h | 1 +
 backends/iommufd.c       | 4 ++++
 hw/arm/smmuv3-accel.c    | 4 ++--
 backends/trace-events    | 2 +-
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index 7062944fe6..e027800c91 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -89,6 +89,7 @@ bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
                                 Error **errp);
 bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
                                   uint32_t viommu_type, uint32_t hwpt_id,
+                                  void *data_ptr, uint32_t data_len,
                                   uint32_t *out_hwpt, Error **errp);
 
 bool iommufd_backend_alloc_vdev(IOMMUFDBackend *be, uint32_t dev_id,
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 5daefe505e..400946810d 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -460,6 +460,7 @@ bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
 
 bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
                                   uint32_t viommu_type, uint32_t hwpt_id,
+                                  void *data_ptr, uint32_t data_len,
                                   uint32_t *out_viommu_id, Error **errp)
 {
     int ret;
@@ -468,11 +469,14 @@ bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
         .type = viommu_type,
         .dev_id = dev_id,
         .hwpt_id = hwpt_id,
+        .data_len = data_len,
+        .data_uptr = (uintptr_t)data_ptr,
     };
 
     ret = ioctl(be->fd, IOMMU_VIOMMU_ALLOC, &alloc_viommu);
 
     trace_iommufd_backend_alloc_viommu(be->fd, dev_id, viommu_type, hwpt_id,
+                                       (uintptr_t)data_ptr, data_len,
                                        alloc_viommu.out_viommu_id, ret);
     if (ret) {
         error_setg_errno(errp, errno, "IOMMU_VIOMMU_ALLOC failed");
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 2c4228b7bd..ab1b0a3669 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -533,8 +533,8 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
     IOMMUFDViommu *viommu;
 
     if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
-                                      IOMMU_VIOMMU_TYPE_ARM_SMMUV3,
-                                      s2_hwpt_id, &viommu_id, errp)) {
+                                      IOMMU_VIOMMU_TYPE_ARM_SMMUV3, s2_hwpt_id,
+                                      NULL, 0, &viommu_id, errp)) {
         return false;
     }
 
diff --git a/backends/trace-events b/backends/trace-events
index b9365113e7..3ba0c3503c 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -21,7 +21,7 @@ iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%
 iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"
 iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t flags, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" flags=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
 iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint64_t data_ptr, int ret) " iommufd=%d id=%u data_type=%u entry_len=%u entry_num=%u done_num=%u data_ptr=0x%"PRIx64" (%d)"
-iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32_t hwpt_id, uint32_t viommu_id, int ret) " iommufd=%d type=%u dev_id=%u hwpt_id=%u viommu_id=%u (%d)"
+iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32_t hwpt_id, uint64_t data_ptr, uint32_t data_len, uint32_t viommu_id, int ret) " iommufd=%d type=%u dev_id=%u hwpt_id=%u data_ptr=0x%"PRIx64" data_len=0x%x viommu_id=%u (%d)"
 iommufd_backend_alloc_vdev(int iommufd, uint32_t dev_id, uint32_t viommu_id, uint64_t virt_id, uint32_t vdev_id, int ret) " iommufd=%d dev_id=%u viommu_id=%u virt_id=0x%"PRIx64" vdev_id=%u (%d)"
 iommufd_viommu_alloc_eventq(int iommufd, uint32_t viommu_id, uint32_t type, uint32_t veventq_id, uint32_t veventq_fd, int ret) " iommufd=%d viommu_id=%u type=%u veventq_id=%u veventq_fd=%u (%d)"
 
-- 
2.43.0


