Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB89D3C909
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 13:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTKPG-0007N9-UP; Wed, 10 Dec 2025 08:39:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTKP1-0007Ih-P9; Wed, 10 Dec 2025 08:38:49 -0500
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTKOz-0001HU-JG; Wed, 10 Dec 2025 08:38:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hSos+WyK1hrVjfvx5+u/aH6OMRlmyHj4m3uiCv2cR8kBWF3sJ8W2gf18gka40SUKoEhZi7gPfAUb39NZ+4rtIaHggheOJrRAN+RscDMEirYmH4ZfrODmgMjJdr89GzhSd50viDI/TBEtYgHyCl1Ny29RQRkvP3CsMSxeKF/vN4yB7bD6Lwd6FHurRlIcDKxypaiNwwYBdXqetkg/BP+E60JkXqtW7Dsz6vdTFH/Ty399hMir8roBqMaceOEUyuwYuQofVnobP9EJ2XxYP5gOxMuPAhgTF44Ba7s73ybucNWEtr5nUyEmY8vWqDkb7yrfaGzGL8WaIo75WAC+LgQ9Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNlquPfg1vtcgY49X/usDJucuWLdwkwpa5DjRpe//r0=;
 b=gqIou4ZvzzXY0d+MUHlo5kCdmj9UZaFVGR6qcVggkSLuvlBOJxsd7usv1vNBzaoYM0BKMvpnvoHWWRpwgszmFYGe0YjVpfPS3VcDLbTQ8nTCvKWK7zVdaKtwSqmzIzguHoDNycP1TejLxJu390DVGLy+8Ug9BSDWAbcft5uAo2Fb5lgxHd+zx1h6XwFqFrggci7NujFrtmaVH/2z1oL2DutWSEPN2tUsFmVJ3QhG4Bea91CiRDPYlFLMY0QgMzGMHX5FYP72BQ2NooYuyEmhyHoj3Of/BefDhu3TbLwO1T4YY2cesG31T8+7uVHPFOR4XngBxf/QQE9zegdj8vB/wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNlquPfg1vtcgY49X/usDJucuWLdwkwpa5DjRpe//r0=;
 b=ZgMMzAyZPeh6/sOJen6OuW2L5X2tOKbNt76Cc7sc4lvHHdchfxZLiTaY6LWFXG+FJSILXvbouEa/YTU7liVKzMNrKja0EVJQJOEcp93hKQFFOnqCveIkn32iBiMlqfbaQe1ktFU1QF7hiSUGti0VPVXv8AhbemM6K2jOBaNdy+7xedYHoZEjnjhFkA+m+zUywEkZTmSozL141Stg0T4ir/0QpL80H+hOFxDQazBNoJaVGg1Ssw3s/6lDg6Rax2r6k/ZZ+Jytp1CUT1P/iFt049RSbAPhv4vEvsBYXQJi/UVo5lrSBRZAi0kVq3qow9NRKYrHff0ZvJCFL6B69yg8EA==
Received: from BYAPR01CA0040.prod.exchangelabs.com (2603:10b6:a03:94::17) by
 SN7PR12MB6669.namprd12.prod.outlook.com (2603:10b6:806:26f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Wed, 10 Dec
 2025 13:38:37 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a03:94:cafe::d2) by BYAPR01CA0040.outlook.office365.com
 (2603:10b6:a03:94::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.8 via Frontend Transport; Wed,
 10 Dec 2025 13:38:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Wed, 10 Dec 2025 13:38:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 05:38:22 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 05:38:19 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: [RFC PATCH 02/16] backends/iommufd: Update
 iommufd_backend_alloc_viommu to allow user ptr
Date: Wed, 10 Dec 2025 13:37:23 +0000
Message-ID: <20251210133737.78257-3-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251210133737.78257-1-skolothumtho@nvidia.com>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|SN7PR12MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: a572f815-3101-454f-5b71-08de37f16bc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EHf01C0nDByj7P4wxQ91mwd3OeiB2DSuVwIpVR+Eq/V5UcX+yr1xpa+slWC5?=
 =?us-ascii?Q?FB08+FCtL/kzbQ/HHQtMG7lLVkggC3tz5wvyLirVpES/UXDRZNboYatTsBxf?=
 =?us-ascii?Q?X5Zv3ENQi1Lig1xeWU0Z81w4K58ITPVwuaQ4lTaNqtIJX98t7WocTAcuW/av?=
 =?us-ascii?Q?1l7/lYituVxWRdpwfqF7i0jK3Q9bVqQPFwRBUGMWnlvapAF9iq2ICZNcmxUZ?=
 =?us-ascii?Q?l0rjLZwGdfIGSmwYRttoiZLXBVR5LtK3m1OqnlAKXs3SVCaRoNF6q8uYHzoT?=
 =?us-ascii?Q?nIEIBAUHHJO50pftaoCxRvWUO0KCUKMR4LOdrJ2E4ZODSZPaLj0kikHHJUzd?=
 =?us-ascii?Q?ztVI9bvDqzja08P5WLh0ZojVeWtx66m7pho5ERkHSbvHNHLctPEPxnCgOK41?=
 =?us-ascii?Q?EXpKXVVGHLEbcwM4525M+j3qA8pUsST6zb5nHghGP3yk4o/070vUoxD2Wz5o?=
 =?us-ascii?Q?lOE6Z16iUPTZTFWQy1MhA0y3JQSmvlHIwyLceh63CsoHeJ88ca5y7J8F+mYv?=
 =?us-ascii?Q?Yqxk45YcCDw1dLCjSa7RKphIAqDNh+nT3xYvHPENsssp2iZSMbZbeq+NtN/1?=
 =?us-ascii?Q?SCzl820VcUFRSWBZGcerK27VbfPrHoux54c/9scI52eFzoJGq7QmTWFArIRN?=
 =?us-ascii?Q?oO9aS0Ryz3jyhHBdqXq6G7qQE6TSk3Ir/OPSo9Sda4Y0xn8GneKkpG85QcIn?=
 =?us-ascii?Q?nrIo4XZRC8paAc8FFC2IfWycJUB6drhW0BkPskWqxEjuCOen9Yl8NBtfLqO/?=
 =?us-ascii?Q?tnPXxpFKF5QHLZ1xT1Tb87SIoWDkeW/WXIX8oQlRRJ6cYW/da1JextXoL6ZI?=
 =?us-ascii?Q?iyld4NEDW78+P3xR57IcQTUBiEKkmivOdASjhTzcsXayyNCqbEy+V5HHrn24?=
 =?us-ascii?Q?lnkzU/RYvmLjG+tuV7HQ5BhtefezPPJJQvBAREbZ/ncm7U/Zt5vhuiCbBExs?=
 =?us-ascii?Q?qJv6kgB6BPcxTYhBpZPCAkqYif1vRLmTMDlu0rd6Iv49Wj50/i5cWSmLFwwS?=
 =?us-ascii?Q?jiDVSdL+wFf8GEbREVyfa7w0P9wd3jX8GovaakvMxwPszHl9lYxsDkZQYSME?=
 =?us-ascii?Q?VK5qIAjdipHflBZHGYGDT2Tr9rBVTBKkVL0H2hG4WfEF5kbz87Ny/K30PexH?=
 =?us-ascii?Q?28GJ6xSr7cmxur3QDV6ei4uRVNjZdbQvZKRzzn5MetTrAVHioQZS1IyXgdrn?=
 =?us-ascii?Q?VCSw+qnFfnzgtl1g6TzmBk8v+r6y4u88qbCqHgxTjg8pR0ygKvrwFeXvLL0j?=
 =?us-ascii?Q?zG9jjUrCLJ8zQq7KH2TOMJM7Xz9AzoNHfiSEEhOTogixl+zMP6N3/HX3c+Lp?=
 =?us-ascii?Q?YmwGOeNMjH3cdWNVglqOZxqsIpyUSZv54hvp3otRQggIr+LvdaX8U13nTOSf?=
 =?us-ascii?Q?3RMnnluL3ZSmNnV4VG4xnHYYpWO4Kzsfpy2z7m8ZtWl1nkbcOBMgibjpnuBA?=
 =?us-ascii?Q?aL9bC49Zzh60Pb7U6h8eGhnnCKnJUdChGswYPh3DoprqxmWCXsXc+n7mytt7?=
 =?us-ascii?Q?06GoJGVhUeB9rO+x+Sidaw9dEMnuhaeVdHYOwaq6AC6g7kazT/7FYE77V0fR?=
 =?us-ascii?Q?3mnuROcWdQiltPvIe8g=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 13:38:36.7188 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a572f815-3101-454f-5b71-08de37f16bc0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6669
Received-SPF: softfail client-ip=2a01:111:f403:c107::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 backends/iommufd.c       | 3 +++
 hw/arm/smmuv3-accel.c    | 4 ++--
 include/system/iommufd.h | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 938c8fe669..2f6fa832a7 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -459,6 +459,7 @@ bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
 
 bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
                                   uint32_t viommu_type, uint32_t hwpt_id,
+                                  void *data_ptr, uint32_t len,
                                   uint32_t *out_viommu_id, Error **errp)
 {
     int ret;
@@ -467,6 +468,8 @@ bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
         .type = viommu_type,
         .dev_id = dev_id,
         .hwpt_id = hwpt_id,
+        .data_len = len,
+        .data_uptr = (uintptr_t)data_ptr,
     };
 
     ret = ioctl(be->fd, IOMMU_VIOMMU_ALLOC, &alloc_viommu);
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 300c35ccb5..939898c9b0 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -503,8 +503,8 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
     SMMUv3AccelState *accel;
 
     if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
-                                      IOMMU_VIOMMU_TYPE_ARM_SMMUV3,
-                                      s2_hwpt_id, &viommu_id, errp)) {
+                                      IOMMU_VIOMMU_TYPE_ARM_SMMUV3, s2_hwpt_id,
+                                      NULL, 0, &viommu_id, errp)) {
         return false;
     }
 
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index 9770ff1484..a3e8087b3a 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -87,6 +87,7 @@ bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
                                 Error **errp);
 bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
                                   uint32_t viommu_type, uint32_t hwpt_id,
+                                  void *data_ptr, uint32_t len,
                                   uint32_t *out_hwpt, Error **errp);
 
 bool iommufd_backend_alloc_vdev(IOMMUFDBackend *be, uint32_t dev_id,
-- 
2.43.0


