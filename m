Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CAD1F4198B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 11:01:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCxvu-0000aJ-QN; Wed, 15 Apr 2026 06:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxvn-0000Xq-3i; Wed, 15 Apr 2026 06:57:15 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxvl-0003vb-Gv; Wed, 15 Apr 2026 06:57:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KX1NXgCjDuBs56jR6Ox5lzIwiU/uFLL/7xZhLxwpWlJ+NkXjeK+MjJ9KJQBwBCb584puLCsiebpav5Y+P7wUAmbk4Eejh9j5UnKZdehmfJjYw/Fg+X6nEcK1kcI/qTuN5Hb8L0XGwlswtxPlwO6s/zlUylYg9vneSeBODttPf073HKxE8GzyNop8s8yD2H7VGwGVXSTwUFgM5teoLmL25j9PYywqF6+TdLzoIyczPXGJx0d/VsMmMb1aPrhfANQunC5L3FG2hOgrtBCZ2vqp9egQLzqSyi7hI1+OmifC3O7L668i3Eh1Qj7Rhtj8ytXytqxXD1KYYnDgKvTkFu52Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvHAiSRwfrlQV4BVH/F+7k34Ycj2J6PKN4x9mujRSD8=;
 b=J4VF2d5bQkg1jgPaooXFxR5iDY2CZ+v81/mzW3d0QhRz2lNRbCMA2EtaCw5dg2iczLcPyNZwHwyyhEyfbHdIkg4raSXKsbf731qAXOfZfc3cyALJmJDbb91lQsB0qLnSCf9oTnIm9ZSKeWnFzNZPFsi3F6SljCQmKiblb7qfXKdHFaKFmml8aQ4m+b9dgCgs5wiyIaLZQwqkytQKV7JmiEmV6UyxX5tD99sjyF1p8gw4reyui13KY4a0BGTHeY1e1bflRmgzJ7RJdKuqUuoQ7vWAXGbej5ZmsMlSRZT/fqfoA2fMCLt/6jggPbe26XtkPN1MuCsVkISsxdlRH/u3Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvHAiSRwfrlQV4BVH/F+7k34Ycj2J6PKN4x9mujRSD8=;
 b=j+DnZ7MS8tPGP5YP4hPjZpegea8ivuwti/i8jbGJqPndahOTEGGOMYpHVibT88pl6+Bp32K3xiiW/iRJevsjFD7iGLih1XWC76MprXtSHhzhZDn49QHOWqxuxJlgRBDwA/Fs0IjYUYDjz5Q8mGn4kZoesKcwd4OTI5LDO3PLs0Q7eR7jBwesKjvHa/Z55ROxP4TX4TpilrM/nRzUkrEhu0JBTgmRyU8U7Hu5j/NY+AsG4zW/kRKMOo6WsrYp/KoCRH06Mh0SykxkpTFzUKuwJTL9dIGvbFv/VdXAwzLSgdKGOFAG2R57fp3iwqxLt0BjA4JCaLye2NqiuLgtjg0iwA==
Received: from PH0P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::32)
 by IA1PR12MB6530.namprd12.prod.outlook.com (2603:10b6:208:3a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 10:57:04 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::2c) by PH0P220CA0019.outlook.office365.com
 (2603:10b6:510:d3::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Wed,
 15 Apr 2026 10:57:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 10:57:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:56:35 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:56:32 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v4 01/31] backends/iommufd: Update
 iommufd_backend_get_device_info
Date: Wed, 15 Apr 2026 11:55:22 +0100
Message-ID: <20260415105552.622421-2-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|IA1PR12MB6530:EE_
X-MS-Office365-Filtering-Correlation-Id: ffcd2715-c03d-42cc-10e3-08de9addba1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: vTuATJSJs19kRxa5j+uk/HTQemhCJJnYP/xDijQjhPwdlETtiXN50HgdR9mtNkalHIcK602Xj/9zoHgBfIVZd3tLwUbaHvQjIQum67VU6PxcjKmHF+AykCnw1amzkDIROxRqZeS0Z6ZDw8c+yq/GswgVIpYC2CvrOhKA2LtVLASuDp55WyfKXdBOykXFz+oxtMKN9+Qo9EW6sI2arTMEAEln721kwnOUxj3Pm+NRzQmugZuIJmWUn3YOKFoWXd/v+ilE7GkTogR6XjcrnU09DHLr2L/FL59EjycXNXVZR4NvKTjrhaIYJ64Z/OKAlMgnucH3V8qjGWSdcKSTrVE4vjRMtFPnQ8oqctuHxSFCtko8Kbc8KAR+HMuI1cs/yV8zuIajTYuTpfEMmg72xcRxnEUpkSnVQlXNE0/gWKyOzoCi0/R0qeyK8sLz6IalEJ8PmnOXtPDNQCixxmWWWF2YYiX1qstaTTf2X6HHOPq2Urldn9j2v3t9KWf2Jecr8NriGEoXp0bCP4nj6Mo2QagbO1Wk0bYlIapqD2sacoOQ/07GdxwCUShR68i+ECF3vYpCOGTZ59DyBk1LKc4AoteU5bWDtHHEu6teayF+2DwgC4Q9lLoIzhIOmNRcovfSoRstGt0RVzw0KwTH+nRWt83mnjj5K+71RRgMp8SUF1SnsGjyV9h0BIoXnOWydVNGw5XcOVZ22cAFnFyOTOsRIEFilRVKfdKSHtuj+kC5PK6d8i4mD1svjv/ZxAP6SMigycwQ/GaZfxgWyMo1cZgrIc5raQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BbJqyq+LfpoPmibi8lrgMtC+s+QxG5huKaUMEY/9tbaZ8yRNSvi/ZLIvyJd+/4z4SKrGeQPuoCUe/L2gINrXeXL/7+Enp2OApEbf5Qsl0cve5vo/BjUFrPOOUmx6n1vVhnCq1hL4cgZZUZG+StmHUWfT0v4K9ha9+zN3jtQkRWWqeLEFUK/EkrVAiOW4LIka4kefDp50rBYF1vHzqDV1+X8LApVZLZj+VEYNADpx6gKRpcYf7zf5kri+GQZgotowqJSyqbl3klVgcHMyvKlQp+uaaj7BNa99sJp0KrajXk1+vpjhxYmSgxjDndZfw4xaV1TD1babOwEk4nCb3pvWeSOmLsjGNrqmVFeq0Zn/DRbhQpFmEFsssskpsxUCqsSXimz4I3fTfqLqkUj39a7du4TFysOFzj4HclYgRo8cTdn7C2kh8B3ea8dsURtIYipM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 10:57:03.2726 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffcd2715-c03d-42cc-10e3-08de9addba1c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6530
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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
index 52cb060454..20d4186f29 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -397,16 +397,23 @@ bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
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
index 48f8017262..d68d4141a0 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -172,7 +172,7 @@ smmuv3_accel_hw_compatible(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
                            Error **errp)
 {
     struct iommu_hw_info_arm_smmuv3 info;
-    uint32_t data_type;
+    uint32_t data_type = IOMMU_HW_INFO_TYPE_DEFAULT;
     uint64_t caps;
 
     if (!iommufd_backend_get_device_info(idev->iommufd, idev->devid, &data_type,
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 3e33dfbb35..4043111667 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -352,7 +352,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
     ERRP_GUARD();
     IOMMUFDBackend *iommufd = vbasedev->iommufd;
     VFIOContainer *bcontainer = VFIO_IOMMU(container);
-    uint32_t type, flags = 0;
+    uint32_t type = IOMMU_HW_INFO_TYPE_DEFAULT, flags = 0;
     uint64_t hw_caps;
     VendorCaps caps;
     VFIOIOASHwpt *hwpt;
@@ -941,7 +941,7 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
     HostIOMMUDeviceIOMMUFD *idev;
     HostIOMMUDeviceCaps *caps = &hiod->caps;
     VendorCaps *vendor_caps = &caps->vendor_caps;
-    enum iommu_hw_info_type type;
+    uint32_t type = IOMMU_HW_INFO_TYPE_DEFAULT;
     uint8_t max_pasid_log2;
     uint64_t hw_caps;
 
-- 
2.43.0


