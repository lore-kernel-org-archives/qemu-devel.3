Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69978CD5BA4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:39:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHqd-0007T1-8l; Tue, 19 May 2026 06:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHqc-0007Sm-20; Tue, 19 May 2026 06:38:50 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHqa-0006Ov-Co; Tue, 19 May 2026 06:38:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L00ECBITNvO+YdBx2KS+ZM8pEZh30ZU6wAG+L6yW5Lp5FrwrNlK9zDAnbQnCFUkXHNjkzTcxR4AIFb5BnuYMGHp/5kmPjO9bA5p+p7vUedK5BQ9y/qsoXPd7q58La9DZDx542wZPg/Yr5dnscfJ8/O3mIPkknnZlvFSLR21JpoXUuy0E7cXdNQp7ymVwMwKCTB8tlw81dRUUZcNWm3QZ1QeY0/dfsdKSh/jN2W6f+9JKmu658cjfvCgIaGH1PzRDmCR36F+vzICQQgDnjabs/TUngObjR8ZSmdqTL8Qz9/9brg2XbdsaqAO8BusulcndPWckGTQIG3H1FnAxzyANTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DHalkl6U1SnjL4NrFI5rvhEuwvggRbVJd5vIrE2NmI=;
 b=f1++4DhMtBhjqAwBokdtshXh29DIab9XBe6r1qvH8kuwasYQsalIY0/Xv/6vkEaeWjQ87wLxwyWyPohWwE+HCK0gdNAHs1dhfdiFnzIR8MqlJ2frRsdVsfwNXzW5g9wDA7BbXZoAvmR5/EgQC6vdfpulaD7nfDvgBorzUVk4JcSQbgF7npprfDJOMAinqMlrrd2HfXXEF7DS1YCveDg2+E7MJ1rJAjUYLEl3p4Y8oBHj1+Wx2003YmBOzutKezLmIGUwYD7gsJOYWXSQDPDIXr+bXirw34pGhe0ExKHMFVvKU1jXX+Ug/lH2QkUX7wF+5cFI7OsU6DO/79/2yhgcBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DHalkl6U1SnjL4NrFI5rvhEuwvggRbVJd5vIrE2NmI=;
 b=hLjvq4d4kU5BYrRnO09pDt3gK+0Km+tvmTMXE4svvgmcdPe6qjmx1x43YRkvOH6Szmr1E/QGaRfVuMUX9J5aRK606f90H/nANbTJPwJlNLjPm7GY9sjdPTksvonOgmbE9mFh2zz4pKxEgRQCKwQYLpWz5IgdbHzjCrK4WR11+mNZIPbQDAc9LsMSOOBRK7CUp2dZARrygTygLRZRCbbgaw/Ko/LMLEZq3rPqdWA6EZwrh/EFfdApcvxUrNwNGEubo5f04Zl2esx2biNZx27wD+fcUe9hvgzMfD7gp9zSen2d7yg/ccJNKNCi1bj6l52kxbclKhvzZplcd0n8vxUJmg==
Received: from IA4P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::13)
 by BN7PPFED9549B84.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Tue, 19 May
 2026 10:38:39 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:558:cafe::e9) by IA4P220CA0002.outlook.office365.com
 (2603:10b6:208:558::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 10:38:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 10:38:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:38:22 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:38:19 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v5 02/32] backends/iommufd: Update
 iommufd_backend_alloc_viommu to allow user ptr
Date: Tue, 19 May 2026 11:36:40 +0100
Message-ID: <20260519103727.899332-3-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|BN7PPFED9549B84:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d911c3d-7780-420c-be6f-08deb592c9bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|22082099003|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: aMqitr3QZW7ffagpbLJ+Bzn2mYX/9fo9SKcjC8ZjP1mC/r6BN7/juwhv4nA3Ql/GAJBd1zGfbE/Y37sSalLgGH741b97ZmucSiOK+U0GRfoSgQsY/ZkRUwnBFW8J5gPHA3bx953FPR5oVmRnSOJv2XY9W9vbkHiEsn0pKIFO1FRnebL5fqLUqOYVul2sJCF1JLaBIzoNCEzMujF2Zxm3E1QHG90Jx4sb3cSBboQgY9pWF1PipmXK1UqI1S7Vu9fJe392E8oXWvZCf5DvVLGDta9LY+DY7BPnpIfqZB5LLoQQQPF/eVi/4kZCK1SGFKN5cbx6S1lUPtPMFdxd4EfMeLLMzrQk2+fq4s7iaDtc9aRRIm0HRSSBqnoc+HByX7/nNt0MhJ+HrrL/RSrWSC0Vv3Uu6HYIU44Sr/7RPPvjhYFI8wkTu640yl7P0VbKtBjY5ZhCFiXaw0xql6rAiAgxYUFnnnZeLS3rkGzg/AQVz9W++KBeqXReFZhf+g1R2KVz1s4V6i+InbloywwXKFeOzLvs08lUBtK/I8E0ggeevM9mq/IL0DDqSc8q51/CUTW/KLZvqiyRVw+KyDWeHATgQfgCMIZRU1D7TTDpgPci0/q1AQklkaV5FXn1ZhPpVvq8QvQhVRRDj7JBAIrdkQVYC5SDTn+XcDwxBZAGgUvKXZmhw7h1GGT2Jn1Bx3eTVeAlHEICztVMNhnsg3ZYpdaHaQnSKTFexd3AuKcMx5tv5MI=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(22082099003)(18002099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VlDqapv0cC00CzeCXV3hg94CGTLHkki72cl7cilB4moRPdkdWXKnhvlwdJx+tkmH1KMhVIZzcGU+mfmK/vCNEYAgrLRvWelO4y3KdRBeDEOD9AWfn496iDWI7Fmu4O+8yH+DRSkm8Q45ciDAUh6ZCdo/IpiQP3QEZIqUN9gx/ai5F9DfZzOLY+jmaKhYX86E8Xs2+ZWAnjNxyr7+9SnWuJl1HF44PTEko/oYUhW5twQgf3bHhD13IbnbIzwm5X+1HWnVWN13m8fFqin6vU4Y8r8KgFBp4H3C2TcUrlwPuZ8YfAl3rWsywwLRJi7g8ZQa6YvB881jhywn9Om3Tq3SEd0tw2AuOavvvWaouYZpw7bLmogC74RmxfO/F6y8w+uxhgw/OhaUhz7k/KwpIqxvwlqVJiqgMfAtxb6qoct83HdPDDAxWV+ooVoJxC9jgjgT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:38:38.6091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d911c3d-7780-420c-be6f-08deb592c9bf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFED9549B84
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
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
index eb13c0b91c..bfa6a03f9e 100644
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


