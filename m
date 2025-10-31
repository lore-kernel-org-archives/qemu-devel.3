Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A5DCCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:00:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEmo8-0000Ts-EJ; Fri, 31 Oct 2025 06:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmn2-0007PK-AA; Fri, 31 Oct 2025 06:55:30 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmmw-0003IP-BI; Fri, 31 Oct 2025 06:55:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=an3S8a8fsrucd4OeQZ8L/u3jbM1FvQX+j3bFbZHeoEW9m8Inbz8nmFQAbxLjYe68EjZ2cIe3HMCumr6P7jRsq94xpHC7ZB0Si4OgN+UbHz02dyf+mhWF2VMog44yt7J0YQyF54vu4H+SCYSmiEw7cFoBFhDIL2QSVlKNSFJDCn0/klQVZQ1Tath1MCeTAjFhLtIXFQJQ6nN5x8QoUcPwfbVCHX5/PaAZRnw1b+Rc3ytPt6K4CmR9K/UWD3ZOCLGfNHLw1kpHgUXISrndtdEgiwp0uUv/Jy4lWqx05spsTHvLCiCa3bhN5OBl4z2Nelde1utAubQz62jmkIPSL7XB4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcKJJZZzQ0hHx6VpRnYqYW6s+NGDULxYcYK5kb+ZzlE=;
 b=nXYdRPgzuQYLBLgZ3FKwhuf9t8zZgXQV7/of4KJLXEfq/ouxEtccGoSt81trvuUNme28NFqGS3tEzHYwF26LQ84Z+eSh3cPVPRTS4elZWyPduya6++tcQ2lxZjHNVa8Yv71AtrirNdh7i+Q45Bi06GWhBCeN/tlWgIi/K7APy68jC21mdfsjK7sOFjVwpfW7HDRf9lw+lD4sp3W0WCpSkP1eL1GuxThtjueLLBNvs22SWJPbyIaLq+froQSHnIhAeCzAjxuRi7342X7s+wQcpSVuBJiN2+dS7v7k4VQ1VtGbVpVn+c7516HcwCVZVBLQGrAmUmInUD97fTDYJrkgEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcKJJZZzQ0hHx6VpRnYqYW6s+NGDULxYcYK5kb+ZzlE=;
 b=CUDz5+qsw5t/snf54ViwVEvk2X8xfvIQTooyVTaNqpdjO/1udhLRdoUUH54cpvfeN1cVITxw4RV28f4Ihp221si1LAxdJ1iUwKL2R7pTxuoMi2SPFpRnduhJp/eIQDPgggSMRuMLJPSf5PSi+FfAJoZNvlYNrcWSbLdzFF0skKfHEtDgx2XPOQCHvy01RmK7/dP7On/xf5qLhVwdBIQfWqMPp9ewZrtHap0Ua+yyFNvkeMlVWWrfKXOkYwbAC/vLtvxm7TOe4rrxzOf3E2Z+OYudWC8kh5CIULfU9mxhJ8PToKD7OH+gWIPf+vUt8qRWNXzGLonQWwZpL2GBpR60Lg==
Received: from BLAPR03CA0068.namprd03.prod.outlook.com (2603:10b6:208:329::13)
 by SJ1PR12MB6361.namprd12.prod.outlook.com (2603:10b6:a03:455::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 10:54:58 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:329:cafe::66) by BLAPR03CA0068.outlook.office365.com
 (2603:10b6:208:329::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.19 via Frontend Transport; Fri,
 31 Oct 2025 10:54:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 10:54:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 31 Oct
 2025 03:54:49 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:54:45 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v5 29/32] backends/iommufd: Retrieve PASID width from
 iommufd_backend_get_device_info()
Date: Fri, 31 Oct 2025 10:50:02 +0000
Message-ID: <20251031105005.24618-30-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031105005.24618-1-skolothumtho@nvidia.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|SJ1PR12MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df561c4-6246-49c5-a134-08de186bef18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2nZJ7BZE8UfhI+1O2trU8GewhKM2Y0WQz6FyeMKHQPp+3mKY+5atRpNJVWWz?=
 =?us-ascii?Q?SA50kiip6bnImmS8ksFUf1OezfMXAtnBM0XHLgWauYwy5xuRmdHSQVd9W4Tw?=
 =?us-ascii?Q?jgDtpKdyLi8gdKYjG1w4VQZJLAk347/Chv/e8MugxDB+MzTQ3vqvXEOIA88Q?=
 =?us-ascii?Q?C4LdWx5ToY3ZeA37yBwgQ5EtUq/ufwuppHFFGctdows4LqEW+suwf10VTbEJ?=
 =?us-ascii?Q?zhnpb5y6dFPKqDY1e278gzn0qffC+NWy5WyPF8xI7iU5V5Z0FM3C5Pc1oPDx?=
 =?us-ascii?Q?GVA6nh0exqosUiavQZ0xaxRfx6zek9wdrQV8xvm9qUrRK5MMl8NLvIw+rkCO?=
 =?us-ascii?Q?++zSq5gGnBeXqJnSQlXnzdopj1LUIewIIC3rVZBVF3DjuSCnapHPsbrcDiBJ?=
 =?us-ascii?Q?aoocVUcsuUeoRtd030yyQtt5Ssb9LDLpuwWH4gKukjOXGcwWjJ/79tNQRCL5?=
 =?us-ascii?Q?Crzv0QSHJTC0QO+C+opZKNLCZaBVcv+PDezv0HgEf2IBqVcxpUW/gejOLo+4?=
 =?us-ascii?Q?XMSqcG6K85cR60c74nU4hbr0ukDwU4JDeIgjvgUPsbHNIL4Z2VlEjtMsb0us?=
 =?us-ascii?Q?Tw0dUX1Sy49TpeVwDUb9kXtS7EH7glpBDk/MbGc5lRZ1AxKyn/S4O77PpjDG?=
 =?us-ascii?Q?5v87AkEhLEwhL/YBKmFh/+HcAeD/7LeuCxEPcN6Vq+MEdYgdtdGxiuqPPY2F?=
 =?us-ascii?Q?hFSDB1Q8kQ1z/exYBj+BZGQoHh/v4IeU4srX5UrmQxlCKxEE9raLG8tufWGt?=
 =?us-ascii?Q?4Kyzmv6fQ9L7tu13A/pfUiCfeOtB5Nct+UOyHscZ60/L0l25zpwcRlbhZosq?=
 =?us-ascii?Q?oEg2aPzIRi5VVpUjRT1JWYzNpqmiSiKrCu/1IbPEUK+uY/Up0c+CvEYL1gdS?=
 =?us-ascii?Q?U+uxm7VVcCMqCSQZfn1OFkio2NOGMIUufbaLgfPHrKH589a7joeioZ3uN3E3?=
 =?us-ascii?Q?8aepKxdp5HfOdERhQKGAjJxJ0c0WxJolmWyV8l+b5XaR2os2wtTgvphlo0c2?=
 =?us-ascii?Q?dJhe9AR/Flp+um0k4KYB9U1rbD3tF0NlZ/YENJDXnAkm+skTjdD8s3pLDdkr?=
 =?us-ascii?Q?/IVuDt2Trqn9m1ue2XPqwU9pJa0sKGNVxII/FhkUIlelZwwoV/bSIj1ySr+i?=
 =?us-ascii?Q?VacCb4EM702VTTBohEAA69X1W9yYXQWAw6f58l2RO1grePRAoWKTYAclxMzp?=
 =?us-ascii?Q?8kTF0bRhj6yDL+/71Ebn158yYVrPPLSq5g5dIOvFflPKiw4u78GWADctB+vB?=
 =?us-ascii?Q?AzT/w0PXhdwRNHEajjCDMHQhtOKte8TLNs32iFaGYvLCvautOakh0wfRR9oo?=
 =?us-ascii?Q?q3OStWkznfGxHzSIhQzRe47Ri3JKauTBLPpzRAR5T2GbtXnERhYoa2+dwT9X?=
 =?us-ascii?Q?G39Cl7qg9ihYhn4rAoKQzyHSsT3eFdLU+nC+fV10k+d1lc1WWZpNSy533dUM?=
 =?us-ascii?Q?dXf08P2I3oY4Xj4wk1q12dagQ/XAzw3rtsSQ8jBXLr2Kzmr7ouHsFg4Bgv7/?=
 =?us-ascii?Q?0CQeb9Y+mHJaKR/u/pcyaWAPX97oVqnc6tq85CXsTGzhRmo0W0E5SvDp12Mp?=
 =?us-ascii?Q?I3FlDuHbTuUE8xP8HaA=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:54:58.3426 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df561c4-6246-49c5-a134-08de186bef18
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6361
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Retrieve PASID width from iommufd_backend_get_device_info() and store it
in HostIOMMUDeviceCaps for later use.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 backends/iommufd.c                 | 6 +++++-
 hw/arm/smmuv3-accel.c              | 3 ++-
 hw/vfio/iommufd.c                  | 7 +++++--
 include/system/host_iommu_device.h | 3 +++
 include/system/iommufd.h           | 3 ++-
 5 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index e68a2c934f..6381f9664b 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -388,7 +388,8 @@ bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
 
 bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
                                      uint32_t *type, void *data, uint32_t len,
-                                     uint64_t *caps, Error **errp)
+                                     uint64_t *caps, uint8_t *max_pasid_log2,
+                                     Error **errp)
 {
     struct iommu_hw_info info = {
         .size = sizeof(info),
@@ -407,6 +408,9 @@ bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
     g_assert(caps);
     *caps = info.out_capabilities;
 
+    if (max_pasid_log2) {
+        *max_pasid_log2 = info.out_max_pasid_log2;
+    }
     return true;
 }
 
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index c46510150e..caa4a1d82d 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -122,7 +122,8 @@ smmuv3_accel_hw_compatible(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
     uint64_t caps;
 
     if (!iommufd_backend_get_device_info(idev->iommufd, idev->devid, &data_type,
-                                         &info, sizeof(info), &caps, errp)) {
+                                         &info, sizeof(info), &caps, NULL,
+                                         errp)) {
         return false;
     }
 
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 2ab52723c6..212970e2e2 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -366,7 +366,8 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
      * instead.
      */
     if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev->devid,
-                                         &type, NULL, 0, &hw_caps, errp)) {
+                                         &type, NULL, 0, &hw_caps, NULL,
+                                         errp)) {
         return false;
     }
 
@@ -901,19 +902,21 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
     HostIOMMUDeviceCaps *caps = &hiod->caps;
     VendorCaps *vendor_caps = &caps->vendor_caps;
     enum iommu_hw_info_type type;
+    uint8_t max_pasid_log2;
     uint64_t hw_caps;
 
     hiod->agent = opaque;
 
     if (!iommufd_backend_get_device_info(vdev->iommufd, vdev->devid, &type,
                                          vendor_caps, sizeof(*vendor_caps),
-                                         &hw_caps, errp)) {
+                                         &hw_caps, &max_pasid_log2, errp)) {
         return false;
     }
 
     hiod->name = g_strdup(vdev->name);
     caps->type = type;
     caps->hw_caps = hw_caps;
+    caps->max_pasid_log2 = max_pasid_log2;
 
     idev = HOST_IOMMU_DEVICE_IOMMUFD(hiod);
     idev->iommufd = vdev->iommufd;
diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
index ab849a4a82..bfb2b60478 100644
--- a/include/system/host_iommu_device.h
+++ b/include/system/host_iommu_device.h
@@ -30,6 +30,8 @@ typedef union VendorCaps {
  * @hw_caps: host platform IOMMU capabilities (e.g. on IOMMUFD this represents
  *           the @out_capabilities value returned from IOMMU_GET_HW_INFO ioctl)
  *
+ * @max_pasid_log2: width of PASIDs supported by host IOMMU device
+ *
  * @vendor_caps: host platform IOMMU vendor specific capabilities (e.g. on
  *               IOMMUFD this represents a user-space buffer filled by kernel
  *               with host IOMMU @type specific hardware information data)
@@ -37,6 +39,7 @@ typedef union VendorCaps {
 typedef struct HostIOMMUDeviceCaps {
     uint32_t type;
     uint64_t hw_caps;
+    uint8_t max_pasid_log2;
     VendorCaps vendor_caps;
 } HostIOMMUDeviceCaps;
 #endif
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index 41e216c677..aa78bf1e1d 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -71,7 +71,8 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
                               hwaddr iova, uint64_t size);
 bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
                                      uint32_t *type, void *data, uint32_t len,
-                                     uint64_t *caps, Error **errp);
+                                     uint64_t *caps, uint8_t *max_pasid_log2,
+                                     Error **errp);
 bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
                                 uint32_t pt_id, uint32_t flags,
                                 uint32_t data_type, uint32_t data_len,
-- 
2.43.0


