Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 877D5FC591F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:52:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvYyG-0003uD-TM; Thu, 26 Feb 2026 05:51:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYyF-0003tu-MX; Thu, 26 Feb 2026 05:51:51 -0500
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYyE-0000eI-56; Thu, 26 Feb 2026 05:51:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNra6h9dOK3mpHlI5U2qqSkb6zJaTCh2PmOCHTQ+6SF6x6U4yAdmsUQm5MQhOorEUO2dKQ8Lp/kTs2q+wcgonIxaNax0+4ccOQJB85uyiULKmfQdXZ7eLcrQjFN0qRuO3gboW4GEO6yx0R+jdhGteZkv+9SFPs7HrVaRg5dlaD9DFmJC+E91j1NJT3G746QttnwnNpe5k6vT/3Q1CXz/bMzidfpPNm8fqhSyhLykfsRDeu9tOcrALSUp5yUCuBD2D+5ZhNUe7W6SeeZ1nV7ThXUh6mLJBUgqlJb4zSLMfUqIuHq5Few9KCFCN4ftO2aSmgaHkmdfT0kxACPcgSL5+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ONLCUQq6/niJ1wZevZA1o31zgACYvo7hNkXNtpPUJ8=;
 b=Nu4leG+sfXhC0DJrXjL/Gx0uKegQS3/nkdSX9V9AngqTTgQCXsLyCKJWeUoqiHpzoCjJTcxPKLb01iGdGGIUS8TGgPxkcb6tGloPB68nEnvDryu5DndaM9DdDil3FsCiNICn6OKjrq/dBuY2JqMkioNmxQFzdIv7ipEBhBjX1r6Djefy0+9C7WZjl+YG5rHjSL7sX6CrrIaoNhG+p7DXBdSUIIscPHZ4nXKJ6fN6AHMv+7a6lLsU2vek6bSrLhSzAwgfXjj0kCGnS7gK2nK+NA4lf9KemE+YePGuCvbtEGWbVvbdWIDIWDBu+UCr6bBMZjmivm4da0Sf9bcnGRDX7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ONLCUQq6/niJ1wZevZA1o31zgACYvo7hNkXNtpPUJ8=;
 b=au4wyf5GXSAWlzOM8PjYgSN0sr9z7Fyi5mJhUnOyGaV2DDfiJ5MFuLQou2K/9GW/u8DLW1Pn6qbIyiCxEgmP0bJoKAZ40iqvm3AhJ43jkDms9y15YgmhMQ2MJgi/R6eaRFAScO+JiOpUlbTql6EABN4rhUBff0H73sQw6AdaQiW2t2Mj+erEpMqJmvmf6Gvv2BEwTmye5TXEYWKvFvI4msfpad8RT3mT+KpQZ6KL+eUE+NsgcTWfmtbhxFDpXYTCA0yTSxYCNPzrSPjG/Uy20elKc1FeDaPk0mB7EeZ+nr+uPihvyetly9QnRzIIW4MiaxY1/Vz6gY399s+Qx0Z4GQ==
Received: from DM6PR07CA0113.namprd07.prod.outlook.com (2603:10b6:5:330::16)
 by LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 10:51:42 +0000
Received: from DM2PEPF00003FC8.namprd04.prod.outlook.com
 (2603:10b6:5:330:cafe::a3) by DM6PR07CA0113.outlook.office365.com
 (2603:10b6:5:330::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Thu,
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
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 10:51:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:51:28 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:51:25 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v3 01/32] backends/iommufd: Update
 iommufd_backend_get_device_info
Date: Thu, 26 Feb 2026 10:50:25 +0000
Message-ID: <20260226105056.897-2-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC8:EE_|LV2PR12MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: 07c9f858-11db-4a54-1596-08de75250726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|7416014|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: 8xLwQ1fkY/AtkRFVaAr+nAwxKDYTQZlz6moqfBxYK1c1OSPjFdDnHxUkKce3Sn6AcoVB6pmJr+5t56eWTU3ZhnKyFBZ/wPkYe972/j6ur3V7g5ouuX/wF5pe9lvI/iIEnoToHUFs8ZsWNCxOQrlrrbLK0ZmSoNAqgILldOIJDPDgyGKootrAjvorxZoW6JI2MGQ3BvfAVcfmV0HUuzb1TgNykj4TJGNkTPrr5xURueo43PsgB2nTfZDw2ptPXFHfeE0y6Psig01UJ8BczLcdy6ZJqX2pI/67ebPAxGFt+VfZoNno7ZFjnUjmUAeSWdKyEBN4uq8KYAcP32Khaw24HlpNF80/F/XeP0srZ4e8a/6mJkr0gfVdNct/hLFuLMjCll/1unOmCZHsRbh3za1iq3IB2msbrvNe5YUdgfNRoRgvhT67FdnyV3U4EvmDUUgYlqxTWN+76bj3GmhRFVpJhkdCb3f2eIPtHjVRNRhZQGMt/h15qTDQXDxzz2kkzgfa1rtWjbWY1U3vD3tiMFRBGfPG8ZxpBhMHuvNSiFVAqZmkB2R2tOJkwJwcwijqx11iDOBfB1WJfDHnpuqa7C80bvYqJXj7XgqTauMKrMsvhXqhN/Lg4l5nb42npCbLfNumwy5HdBYRMD9KieznuMHd6WaqsKxsZkMDHye5Uk9b93ovPOWpGotIMX6d2TKyRf5yVd79hU9noN3ta59Z7QSqApSq042pQtZs2Ebq0gmqzPecQkh0w+1X9z04YmrwAj55UIT2zKJ9iFqoTFlZiKA+OVl7Xu2y9RVRD0aM+a197qHG4Hsz7IwjGnIPSiD7XRc8SbL1hQ3mz2yxW3zvbzlLVA==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uWJqoYURJm/UnKLg1UEVYlooh/+I76FkKm57SUf+ZvQmVeBR6iWDK2VtOrrQDO+0TfO+5MqDoorxmA3u0S1xEjKF3kf7BJ/gLivwLP6IkLgmG2L7X8+4qDTO4gjKTIChMhMzwHrG381nxXn9k88NAtubTyqUaoSXD60HM1257oErJvf76v9vWxGcXoAdGfygCQRx2xiAYNyQ1N0H/uB00K0L1ABuEuFI92uFkz3GnRStrhOl5yW5rw2SiqMS3zuLqv83URR+fxnnjve8uiqRfRLfhdPetoXzONCT+pkNs2lSN21YLOSqmotvvmPuY0qvbX8WR65LYpFpRLnZyC0EO3u3faI90prk8tcs1tlst/oLHrpsz9XetBJ87TApoMzRMnZ9tYDnrTNpuG9lPUzK6DrRkGOJ95ZhDyWMtXdL1lrj7oe6txCk66Aq0XJW0lt9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 10:51:42.5744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c9f858-11db-4a54-1596-08de75250726
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5966
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
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

The updated IOMMUFD uAPI introduces the ability for userspace to request
a specific hardware info data type via IOMMU_GET_HW_INFO. Update
iommufd_backend_get_device_info() to set IOMMU_HW_INFO_FLAG_INPUT_TYPE
when a non-zero type is supplied, and adjust all callers to pass a type
value explicitly initialised to zero (IOMMU_HW_INFO_TYPE_DEFAULT) when
no specific type is requested.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 backends/iommufd.c    | 7 +++++++
 hw/arm/smmuv3-accel.c | 2 +-
 hw/vfio/iommufd.c     | 4 ++--
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index acfab907c0..5daefe505e 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -387,16 +387,23 @@ bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
     return true;
 }
 
+/*
+ * @type can carry a desired HW info type defined in the uapi headers. If caller
+ * doesn't have one, indicating it wants the default type, then @type should be
+ * zeroed (i.e. IOMMU_HW_INFO_TYPE_DEFAULT).
+ */
 bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
                                      uint32_t *type, void *data, uint32_t len,
                                      uint64_t *caps, uint8_t *max_pasid_log2,
                                      Error **errp)
 {
     struct iommu_hw_info info = {
+        .flags = (*type) ? IOMMU_HW_INFO_FLAG_INPUT_TYPE : 0,
         .size = sizeof(info),
         .dev_id = devid,
         .data_len = len,
         .data_uptr = (uintptr_t)data,
+        .in_data_type = *type,
     };
 
     if (ioctl(be->fd, IOMMU_GET_HW_INFO, &info)) {
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index f2fd926160..2c4228b7bd 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -127,7 +127,7 @@ smmuv3_accel_hw_compatible(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
                            Error **errp)
 {
     struct iommu_hw_info_arm_smmuv3 info;
-    uint32_t data_type;
+    uint32_t data_type = IOMMU_HW_INFO_TYPE_DEFAULT;
     uint64_t caps;
 
     if (!iommufd_backend_get_device_info(idev->iommufd, idev->devid, &data_type,
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 131612eb83..3854f8b9fd 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -349,7 +349,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
     ERRP_GUARD();
     IOMMUFDBackend *iommufd = vbasedev->iommufd;
     VFIOContainer *bcontainer = VFIO_IOMMU(container);
-    uint32_t type, flags = 0;
+    uint32_t type = IOMMU_HW_INFO_TYPE_DEFAULT, flags = 0;
     uint64_t hw_caps;
     VendorCaps caps;
     VFIOIOASHwpt *hwpt;
@@ -938,7 +938,7 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
     HostIOMMUDeviceIOMMUFD *idev;
     HostIOMMUDeviceCaps *caps = &hiod->caps;
     VendorCaps *vendor_caps = &caps->vendor_caps;
-    enum iommu_hw_info_type type;
+    uint32_t type = IOMMU_HW_INFO_TYPE_DEFAULT;
     uint8_t max_pasid_log2;
     uint64_t hw_caps;
 
-- 
2.43.0


