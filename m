Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1377CD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWucN-0006LM-AU; Tue, 09 Jun 2026 07:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWuc4-0006JY-GK; Tue, 09 Jun 2026 07:27:20 -0400
Received: from mail-westusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c001::5] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWuc1-0002x8-VO; Tue, 09 Jun 2026 07:27:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VUYp5IfA/zTv8AxqiFbMwT7pZiTDnKGHfD+czmWtDL6vMDY1g5c2p3Lmofbbrueae0WZ10eb/6aoto8vcIUxfrJImP+fUqMSgsMqNCKQmD7P0Xhqi8JLmQDCzz4I3vJBsyGsc9G5hqp+H9fjZ1oMCzH+MsZmxsVULDoxdtBb2HqHVgXLkZjsHEHb4sXz6us59U26aqQCeYaze8qY2JtPyjiB+7syTdUyqTar0y+fQSABekeY/BHr+i4PHv7iefArKA+l0RykMmFk6OvaFM0bqWeAWT3wzJV+/Ouy3S8n91VPhgA79ELvfcUJAsuX5+URVQjN+FF8zhPpon9xCYVW+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVkC/oNqi/PTBHyOnjIgwDp8OIkYvvV3m8HKo9BGDEc=;
 b=oepqaual0Tswlm8XAxATRGKlklZI7s0zeAmzA3V3i/kjqm/VLcDYs3pzB2PfZoVSXirCT0zOW2ptTQ6kBIEL4qiG2sGOVQ1IT/FK3beJQ4Qimxso9eSshWx3cg1450FTpAzISvobvfrZAFxw/4AEBM8szC4Aezmti8AbGLbEFWuwEc9IVb6BXJqKuRIQrz1Vg4Y5mBrmMK/jvtCHR3TKLPU2nSMVlNkMkRho4W0bcb+QqHyhJhl809E7iUuSXIu4k4NXpZrNIoA2yK5wIHbP/aTn90I8ca/pA1JyDUSVBPuc6Tjz/BhU1p5z/FddLnrY2B2iRWk96z4lLItb79UW6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVkC/oNqi/PTBHyOnjIgwDp8OIkYvvV3m8HKo9BGDEc=;
 b=ZziC0CUc9QU6tSyo0QFGqT1+0g/EKlfRSeAv9xo2YoOdjNeQNhp3cbt1vB5W5yN1pUNfUp9vYF5rGow3TeOfULKrz2pNqAEzSgCHTwpdyecxjbKquSxz+uT8n53cKLLhq1k/tjBQXUX6T8+ig+uPrGdIP1Y3NGcihBsSn2gIWu95+yxoyvZjEie0KJyoJHKhIl1gjbH4J938v2TnC3j+g6P2ib8BShiQ/gVUUPI2AwaUz/a0ysyTizZlsjQTu1EDks7RVEkYUY7hmm4jGDHC+uuohUkpu/zs6OR/Pr6f5IVFFFNWElZETGVpzRNRIIkvhOaEU3aFtbMHQgdhgIfmkA==
Received: from SJ0PR03CA0255.namprd03.prod.outlook.com (2603:10b6:a03:3a0::20)
 by SN7PR12MB8791.namprd12.prod.outlook.com (2603:10b6:806:32a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 11:27:10 +0000
Received: from MWH0EPF000C6186.namprd02.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::72) by SJ0PR03CA0255.outlook.office365.com
 (2603:10b6:a03:3a0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.15 via Frontend Transport; Tue, 9
 Jun 2026 11:27:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C6186.mail.protection.outlook.com (10.167.249.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 11:27:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:26:48 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:26:42 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v7 02/31] backends/iommufd: Update
 iommufd_backend_alloc_viommu to allow user ptr
Date: Tue, 9 Jun 2026 12:25:23 +0100
Message-ID: <20260609112552.378999-3-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6186:EE_|SN7PR12MB8791:EE_
X-MS-Office365-Filtering-Correlation-Id: 3226b364-a2c9-4b9a-8027-08dec61a0bcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: pYjTF8pcTeyGmNnjUAb4cpaAXJIuzp+KZmBQCkmfgUJGE9DJvtzwRZWLAbE3GrClJfmpjeYk30TIMHxFZToogg3oMgTLli/2xIOSAn5QbRhnwOLYZB5nVP11rvPvy6kcwqeLCWrAIXLruyUBKETgUW4RW1lJTLazyhjj716pOr9/oTymlw60ZnVyBMmtWH41/rnqGqbYHhkWbH5Y1nU6pIuZpHUdVGN1Ja9QOF333cAQ+LXxAUlZwL49f/fxQwaHG6Rv3C8VOUXK5D08Bs0VItYh9FKZMeMCvU/XyiuROR1iG657QxnIeI+Xlb5HMGoyxeSJL5ZuRW9VtJde1KE7Qn/DOMe4eCNutbX33xXYip7EvOR8bAz7LoKflYrzMcG2pwXqb8wAtBfd14ENIVesQqIDpqokZXoU0tXEtiGG16t1m8DlLERKd2Oip6PGiMbEyPygwAMIGOOmcLFb3DRF35Qc9pkeUEKCXlIK1W7v8w8NiyYeB68CSmoJwrSOLRthmEi0XkbjUoeCrDG1TR6g5ga+3QSgBnN3gL7xMjzqWvYKEVRP+WODIc75JNrfbnQLlgoA+ZUgcr9jbNeAsvx4EJxtUkjEfy8iylD296QT9TPG5T2gy+I+1w9ThvJ4K8gG/+pVPIT2aKKgJ28TV/LuSpDVMfPzOG/XialiZJDsTXAQkikuY6Lz8fWNJWRrWipR+q+Kj6PoyF/qo4u8JDPCN0LNFa7DzZXyRZF0gtE6tcU=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qEL1g3ysDpUdNMTx/1VqcnkSonKtWF3E3ap82tO2qoQz6Ce2egEElXcPa/qr6e6kAwFDqJZEi5ZjU/wp2vrNI4NkvgMU1Rvgr7WioBqN1c4aBYtCs5jZV5pZuQN2OfDG8PWuLToq5i8QprrO/5E5lhDXkWvh6V4l8TwO5PRDdtSYlRNXlOdGhwfH0jKacC9NPxBqf6tlnVmB5whG9FHYoqXnOeVXjnvpwZusVA2nrJkQVXim0WiZE0uIHJ24PREUj+efSmbyrXWjCeg3pstDOSmAQstxWumiVxvOw44ioz8HucBNk/Nk64dXAaD/FTwt8lgNAXmntjR0wgBPQKtF92ShABAXZZqGZiEzF2mbWRDB86JinO2pZmkCKoMoCDOY4vvPYD/+fcGlI8JWV48BUgM14nuiGw/zod9QlHlFgyQyx1/KFXfEr1SsGRe6WhkB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 11:27:10.1042 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3226b364-a2c9-4b9a-8027-08dec61a0bcc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6186.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8791
Received-SPF: permerror client-ip=2a01:111:f403:c001::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
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
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
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


