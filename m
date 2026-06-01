Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30CACD6E5D
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:50:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU18C-0004W9-4J; Mon, 01 Jun 2026 07:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU18A-0004V1-MV; Mon, 01 Jun 2026 07:48:30 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU187-0004mh-Vm; Mon, 01 Jun 2026 07:48:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KB6/rP5iDqs4mReCFSPmESQfEwdNBYhFwmGIrhlDxLfXUQvRza2vCbvq6fFX4nhwXKRmJRUiOVbhy9HkCmqOxEaEG1Nm485kdHDasXbz2V7esH92sMtQV6vj/57c0HpBhQboxaBec+QLixF4aQZ0ihqwkW3p+fiVfVCEXLJXHkZ3jYhRxeLqvsgBPfr+b7kZDSk3jrNPdpmwUT0MYG421/357du3ZCwZsqv0RJXZJ4wpwQ5TSNq4gN8bZd72JdhKtdsNBpnHPgnVnUpVtbMrmV0GbqeNhb6mRIJMTxWw/ZyZUf6amW16+KPW2tGRBfYujI5Up97OwZcTjYH6UZE/FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cR5DjdlwRjdDDQKN8JHudn1jhwx3ZbkQluvZA8XNkmk=;
 b=qt1jM5Fhtyyxb+TT6oVqNQooNm+mBYvW6hser24m8Nny+zQ199Lz6N1uZv8upDPyaYnufQH8J1GHu9Bz4Q3Ye8Qd5NCAIAa8HIb7Dd+xuLCkCW9HeCwumeRICyLjrJZ0sJKx8t0Bxed6KevN7MQz5VEqX2p2T2rX+jHcaYx+TzO/UDc6cr9zr6kdGUN18EzvYaIDvOXZgR91MbPXVz/jkjvfXMGJTVbxB6zlauDWGi61F+2FyRnnlsDWep33x7dS8fFkZEJweye+zFDRSlxho4VkFGll+vCVD3muIZQ/fa9yYAIHPluEq/qTP6Ud8nfZ5zr1g6gUsk5Rivp4vRDNrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cR5DjdlwRjdDDQKN8JHudn1jhwx3ZbkQluvZA8XNkmk=;
 b=IjMd0N1rlfqlu/V98MsxlQZ/vz8OedS65BrTGjOOTVy+oU/RUpOCa893FfuA6ZpyQ9QHW/s//4rNXWhPqgJnUquckFcVw6Zpzmvius/xVE+bsZjqdm42jOAn3kwiwYO/NbjoOuSAPyC4ywLBXmGafLPBZJZ22T1VXTKnAm7Y6BA30o2E6YTOj7hXchqI4gaRvLCHvrrTI5SmZ5/TrbysCdnPFhLnZMZG0OfMJQK87V1M0KT8v543QOShHPYh24iGLNiHumOrwOMVYmzJO+kCIoA8y2qWxS63m0Cb+ZYfgEBkxVCL9cyK+KFwCVUk11VR3BZ37wv11dBmionlfmSiwg==
Received: from BN9P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::32)
 by LV8PR12MB9261.namprd12.prod.outlook.com (2603:10b6:408:1ed::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 11:48:18 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:408:13e:cafe::11) by BN9P220CA0027.outlook.office365.com
 (2603:10b6:408:13e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Mon, 1
 Jun 2026 11:48:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Mon, 1 Jun 2026 11:48:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:48:02 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:47:58 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v6 02/31] backends/iommufd: Update
 iommufd_backend_alloc_viommu to allow user ptr
Date: Mon, 1 Jun 2026 12:41:52 +0100
Message-ID: <20260601114221.457995-3-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|LV8PR12MB9261:EE_
X-MS-Office365-Filtering-Correlation-Id: be5fe330-ca78-4d2e-a057-08debfd3abe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: gM9oiS5p7AHp3xxMuulTdVUg8/PUIRPO+Y9nzLXP870AFlAS1S/GytIfhKypKPjd0VtSEjVFhd6XxN0az+tkkZMYo9FZaLpYI+8d8o8l0kVyyUeAI8DO5nKygZe/nuYfP9EUjTv1aZalK/wSj4B+1bOgO6xx8WVL5vNRgBJqaBIKhFb4THiuHPLOwB9/jqIBDxAKsI0eRKJnNkXet+AQQ8I2zuBMBmobASC3CHM6YuNVGSrFNSrIbbP/9xAbEE2oq1+55m72MdwcrJrv99QUPgBQB5fALzv354CKPGKHgUMxepWoeMT18BhRAAyfRn4tHTculCl7zYyYfSGwqlX8jqyguPM7xV0uZgF5IoUBb43Y7xYIwK2cA6UiAMr/H9+MExsLt9QZOIaN7VeJkzvLuQWD8SqBlEv8buZ1B96IDm4EULjXp6GWONDxUPl+NkA1WyvxxD+LgaWsYfJG4F8BwonwsWQm0l5cBu3jqvMFw3ymIeMWne0i3E9wNMXeLUPMraY8cZIVrR2jBFMg/ZgUs0XlDB7R7qEAhGPMx3R3rlI0FkrSfSPkGv5ZsTWpnOKS7h0rkbEnQfplMdTe5/bcI9H6XwqgQhawTbOvuoD4eiBtcQqonTkZZM2yblcpl/JqM9mAvzSL1Rw6rWUFLSeb/aGrsDgeXzrBH9/DM/RVI0f12sxRfmlawgUVXyxrrNHBKoQpj3V4XoJ6vk3evnmvSjwKFCEocw5B89C7Sv5Dzf0=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RKNwgPyEFq6l7ajcBquwrYpT2dsSPHthANMpnRqWP2LGDjulJ2gm7ZJwiHA+3AKjIAUUGFofCqB0FpPe0oPXG4gijv8FdtKzLUjUBOVAQO0wbqM5mfMPFBJmeGi1BoDU/QTSxdpGpELmW+op3H8FfLC4xLcS6umgUFtSn07KkPmoAb7i00OVUA8PDnMjHLwhCDudo8dtYf0eQ0HdIrCWF8rbdZeFAKAqliFhEVaKAauSul0XtVZaVV6R0hTvT0rK7wPeVxDcGjOtTAhqG7jiXOiTNt7EtUhnQu4+b2+HSFsOaQi8Uq6ukCQBwqBKbG/Yrg2xHdxAmEJJc9r+3rauA8Na1eNdZ4lVS7U33r0HeoMTvbdqWYBiv7cnwcQsSMtLFX6MYUOHMj5Pvc9AMJmAWZg4kVI5dMoCvaSG+32jRrZX0pqHWzeuP4+IAJU/oO3T
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 11:48:17.4312 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be5fe330-ca78-4d2e-a057-08debfd3abe5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9261
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
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
index 2925d116ac..1b0266f660 100644
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
index 8c3a981392..c745dbd2b1 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -463,6 +463,7 @@ bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
 
 bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
                                   uint32_t viommu_type, uint32_t hwpt_id,
+                                  void *data_ptr, uint32_t data_len,
                                   uint32_t *out_viommu_id, Error **errp)
 {
     int ret;
@@ -471,11 +472,14 @@ bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
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
index 163d3e7279..4cef487679 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -582,8 +582,8 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *hiodi,
     IOMMUFDViommu *viommu;
 
     if (!iommufd_backend_alloc_viommu(hiodi->iommufd, hiodi->devid,
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


