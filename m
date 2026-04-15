Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF97F4198B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 10:57:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCxvr-0000a1-Oq; Wed, 15 Apr 2026 06:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxvg-0000Vd-OH; Wed, 15 Apr 2026 06:57:08 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxve-0003rh-Vi; Wed, 15 Apr 2026 06:57:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0Jc61nztRu6fY8GbTFpYs/YJ9HHAVWER9jcq4kit/8GYNeQaVBtOo6Xza08sT+zVBHBJ6xs/Rf0TvK8itH0GgK97nlNiVCzcF85kvpID8shs0jCgZQ7B/qkPlizM0GL8K0qKrOoiLgN4M7zU75EkquDMPTHolbBU23ToVyZkdA7wVnoIrqoV64o3p2sB0MCPT8OiZIgmTPKjouqvKGiYYPxDCvrB4qIEDBCUQt8p1tZ2orcqAnNAV/R8kvLG5hBodXKqNVSyKatUIzEPa6Ss2yJz+auQLi4dfpaNUZcGTuoMM5nxRjtlQLrJli7D2VWFL/lw2z4tdf5sVon/kRy2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBn/XubousQmUacm7NgjOv+SlCOKGc9Ei9PZYipAYGw=;
 b=uEfBnjdMVKpLcXzDcC2mSBhnuOMcQGYibftx9aCWyN7Fd6dUUuAY/5yVesIgUEssTaMe3ev/2Ko0D2hz+czgIEP1gtduaSVmJs9OeTOXLsVBg5R8Fj71V10W6lXr0uvaFRt9wpnXbsTuqSTmisAG/xs05SIDUNR9kxlGiYqspMupSzKxugT/0W6SWgmhj+nDzOK5Yd5eMRpzFOsuPtS9PnqbukzMPefNIboEbRZ5Xaz/sIcntcxLqEaosSsuVlJuG9Kvsreg0bbgukgr6mYp8MyJPQxjoMpmC8VMwyLpk8NWLvAXilE1rVrmSKOzY4e6dSbf3NmLjq+LVjnOwd0DcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBn/XubousQmUacm7NgjOv+SlCOKGc9Ei9PZYipAYGw=;
 b=ggv3hm+Gi27eaQl5DqJ+D8dGeG9oTf7njWenixYqo8uDkVstFC6hXrdca/YgRx7xrojXnQIzg2t4QFIUPl+gUtcJ6LFOuog8Vn4EhfrqPKebnRLzj+2TcuQ3ylowkfOIcqoTw0ug5s9vjJ1+TogppmDwXrxg/FunToMWCaL0AAcG9LP1OL9FLOKuwNmbG0XdNm4kge1zCaHFrwlXRDKlhFbnEXJ035Kqug2FUJzzWzBucVphCNDPaJyFb70++WFf4elK2EDnXLOM+M22kJEEGztKHQPmFlFOf5LqpmgjabX9Ta1Mk+mMkIxmwIPa+rdW/iDP/zKAoWM0AqzPHXWz5g==
Received: from BLAPR03CA0149.namprd03.prod.outlook.com (2603:10b6:208:32e::34)
 by DS0PR12MB7971.namprd12.prod.outlook.com (2603:10b6:8:14e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 10:56:57 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:208:32e:cafe::69) by BLAPR03CA0149.outlook.office365.com
 (2603:10b6:208:32e::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Wed,
 15 Apr 2026 10:56:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 10:56:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:56:39 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:56:36 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v4 02/31] backends/iommufd: Update
 iommufd_backend_alloc_viommu to allow user ptr
Date: Wed, 15 Apr 2026 11:55:23 +0100
Message-ID: <20260415105552.622421-3-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415105552.622421-1-skolothumtho@nvidia.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|DS0PR12MB7971:EE_
X-MS-Office365-Filtering-Correlation-Id: 74b81f0a-39e4-4573-6284-08de9addb672
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qVDYPbx7Rcer8WpxHrMTC6zbr2ETKgOlzxQ3FISX8lTyQiySIOKYgHTzsD0lNJAVMJYZqNgpxArRzU5zGbEEIrPeRAm9VYVkcoYXNSiW+9t1arBn+zXL1WGmDreXzVzgP1NgIR14pPZzLJ0kKZmsozycvkMKNiLNmipmj1Hi25nDOQ8QN6C1Zc4rAn20Im8DKtejqKh5krVX3iSLPYVd9FzSrRYDridYSNpKjZ+EmIuZ6y6JmEl9PXm9Whiwo4U703ruupihf6NAqP4dO7WtBkGF4/n9iLGSUqZBkIOkOsH30mL4Lvx8DRHn1a8SeqsWct53kZy6d9QwhCYTW9zR4yvBtyhzWoWenY8T8WxVj7zwGRa0dEBO7N1TnvMQ4jnyPbIaGiiN2vE4VXwCE4mZdgdyt1k4mrRFNsUGZ6hWqiC2ovl1nI/rNdWGNWQc0RJk8vCfvRpAidzpcXDlXaQdonU5WkLEkEYUXhvb063t3Nep15i3uRISMETv+mpefFkUN9Il5FtbUCY1uoFvy21PTW5S5x5Dvuch9GUlSL13fl1/MHr8hDYpXNlSAnboPPrT63c2gcBXDgdR+92jsy23jhdK1G26C+uh+LPNoHmOfr55ScNqqUHOJTeX+/9R0ssHfmRMwsxTrDIqZBk9XrFdlFAjgjAb2PmRsSlVY3ydjvrpv6TejxDPfK7lH/OEfeDn7JVvbT7vKbnGHA/XmzBwHSrHsDDxD/ABslS8HueDCMuxP8rpxvjeDpBPgcsZP/d5rHjQ6zaJ8Jq7DcigxCdixQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LZcUHSxqWbxvLGjFBurgg2UfAxjNN9PUocHlhpMnqwauTCacfkQHPZNUO2ioT8UduMSCJrqC7cuMQizQ+UN2Ns4hJtIXAry1rfnOplD9T7M0NWG+41y4DaUX6u6I69MeFBRJjk1Obp9okiXMmSE1aap9fU2HeElch1tOGDliNlCb2ou218/60+g5HvVkg9sxPJ8PkhPCeZkXlawZMkuW9yEnwgt8RP97yTzFkdB33Qpx92zH8yyVtnW11AtJS+4x1KwWNaZWCq9LXv9qWa0jkkEtNoLc5jB6uwU97FJ8Zi71Ocleywdx4pUP78MgSatEgbuApD7ZINVD+mQjHILeL+SKdxkpVV7ayblHZJldIEGxYp/VAvseox20tBHXNdE5l/gNN7XAHB3phYl6zonNgtSUWU5cQviAaswLFX0DmXVGtJlz3b8ImtR0SszAyesE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 10:56:57.0792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b81f0a-39e4-4573-6284-08de9addb672
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7971
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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
index 20d4186f29..9b07ac19c2 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -470,6 +470,7 @@ bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
 
 bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
                                   uint32_t viommu_type, uint32_t hwpt_id,
+                                  void *data_ptr, uint32_t data_len,
                                   uint32_t *out_viommu_id, Error **errp)
 {
     int ret;
@@ -478,11 +479,14 @@ bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
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
index d68d4141a0..c356ff9708 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -578,8 +578,8 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
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


