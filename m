Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53FAAD2502E
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 19:59:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf1Xn-0006J3-Gd; Sun, 11 Jan 2026 14:56:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1Xi-0006GK-Ov; Sun, 11 Jan 2026 14:56:06 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1Xf-0003pu-6j; Sun, 11 Jan 2026 14:56:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MqFiy2OKIcTj2b9BTNUGxzfWMTKruXD8CS9ko/4YKiLoq9eWjQSAaJCpAyc9tKI2CZYH/mq72ngZlTQAC5ENZeJseGx9byBA5m3F3ni5/kBEvB24KhRJH+ApxnuORqH+o3lHRBo+d7rLYax4EgqpiTWYr2fXnvhvN/AnsMuXGHk0Y0AmEf9S26hi0JFzmCt8OjM5Vu0AT0LumJct78nSdgj0WU+vPdH05MsOERIbTRGQs1LPZXIcs1kbCSFD7AYtegsQFig8tWSyiXeoXgGAS5+qBohu8azi3ucCZXJdNpH7rqRm0cMvssu5wLO7Zvh8OOH7xUkH1URVRzIOaQGcnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjXt4UW1QCmyxZ56lkH1/AHugfhIXQUbdCuj3MM2duk=;
 b=n01KnIlyUOBpwUct+q58sktRQpJmQSxuXVvOPsArce4eRF0CRR880+Iv9OolV+jVtyvPNDLRH5XCWD8IxIVoDZ+i8UPx2ODj4U8XU6ruC/WaoX8BgRzRo2V+eWjnZhIE6LxHAtwDoqS8XWm4AYy3aE93VswZtY3ew+Om+p+YSXfDt8H7lC9mcNDrItD3vvJhgV6D2gIujP5xdUfK69GdhZ2Jkg5OMkzyQOJwqnf6frcSbZj2WxMTPhj7/DM4yTfbAm0uOukBITfeK5uSe9ZAy4SnePXCMfwPCPmQf5FPBGkZtSROS/RnUyj9DfTlEMEPE4o0onHh75FM2EkAnkPsog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjXt4UW1QCmyxZ56lkH1/AHugfhIXQUbdCuj3MM2duk=;
 b=c9dlrZCw7J1kpYKroaCdcEVPaahucxFCJ1SkjkPUkR7W27FaY26yD54Q787lFPAtvkN2vb8NiMLpM39sXCuNxGI/3phbSZpibN1zX9ivYKcsEeXg28cl3XfqNUPdA+hgxxdlE/US7XIN2+saJ5YpaYd6ttuycjsXZJH39DHwnzNRfJucJ8fW4z0wBX8GgduvSi6G1SUklQQGYpgQLlpK/lYeQcOyRoOQ6tB5ctr0R7SSViCYphVrZsGsIFTjEUYydae1oEhMhmyCGgCvBMnp3dyr/a084MhcNjkE2yeUMAgkzcrhoAZDvFs3QIKafVkLHHeQLhscB/2sWUm5n1XH2A==
Received: from PH7PR13CA0007.namprd13.prod.outlook.com (2603:10b6:510:174::17)
 by DM4PR12MB6087.namprd12.prod.outlook.com (2603:10b6:8:b1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Sun, 11 Jan
 2026 19:55:57 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::71) by PH7PR13CA0007.outlook.office365.com
 (2603:10b6:510:174::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Sun,
 11 Jan 2026 19:55:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 19:55:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:55:45 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:55:41 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>
Subject: [PATCH v7 01/36] backends/iommufd: Introduce
 iommufd_backend_alloc_vdev
Date: Sun, 11 Jan 2026 19:52:47 +0000
Message-ID: <20260111195508.106943-2-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111195508.106943-1-skolothumtho@nvidia.com>
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|DM4PR12MB6087:EE_
X-MS-Office365-Filtering-Correlation-Id: f20a8a62-0125-49b2-9157-08de514b6f26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pMEc2hpNlAxcJGiMQzSq8qdbJEQlhnUHXm3h+HfEq8p2HZu3AKsg3CyThPAV?=
 =?us-ascii?Q?nLyy/6SYDl9/8fk6GJfGznNV3O1G0/Vq+M2+epDwaSci5amjvMKMkkOwc0wm?=
 =?us-ascii?Q?WiZksCnQdIDghDVJMuDKYqNgK6zdYUg2V4BMk7BdzARZ2m7ig11tcax6HY4y?=
 =?us-ascii?Q?IkBIlEVtz6dmooedo8Wd96wiaShXokDmK9LIvdbZm31h+orihySyC/ugQHgG?=
 =?us-ascii?Q?o20Zy5IU0m02qKaCEeLsVXmtgqofGCqqIjRxqc1wbRejdp/RVXt0WqXN95Ws?=
 =?us-ascii?Q?CJ6zDIT+ejg+NGFfY/CqyIFj1xcvI8M7OQiGF464nvNc7a/hicKWaBxFZTD/?=
 =?us-ascii?Q?QrOXUltzWzP7lXA9D+gxUZ1iv92XlLrPvmDqzvlj4t2c6J64okuosBPPXxbp?=
 =?us-ascii?Q?vS7ZjLW/YUV+fbPan+gLievxyfpWa76TE6yw+Bx5wicTwGGjEAuhQ+ZE49CG?=
 =?us-ascii?Q?qFrSJcNU0yxIGjrCA5Zui3Y73nHIKDoeCYehbx3mYSUAl29N5er8DxJbEU8+?=
 =?us-ascii?Q?K3WGltDtoC/GBj6jGHblzZbTiSEUvOosVdsZCr2/+lC8L+cxww33CLjsTYo7?=
 =?us-ascii?Q?CeW6NBcm7QLDJtG2+5YbsRJ0gQVGwpqGk/sBzXrBIXUDTojAEZQTZAsZ+QIG?=
 =?us-ascii?Q?wN2RkGDOP/FsnRQcJ6RD6zHpQLg8NxaJ8gb5vGkiIUKdx07qKn6r/Xiu6l2K?=
 =?us-ascii?Q?qkOv88CXZTtcMVMmKmBfigQx6NJcShlMsCWNl2XTJEdgfspeMPx1Xiz4+6OW?=
 =?us-ascii?Q?k0biMRVZC/KSoadAy9KWc86qTCldlf4GYtmTDLj5rIcOrUtGVmMgaSXY5yhT?=
 =?us-ascii?Q?jiE+u28jFMzpnmz7NEPBUaRQk+pDAvgvkxX8f70RIgn4AsZvmeM2YH/s9IcL?=
 =?us-ascii?Q?03pcHRdGpyT096kE9UgqVelc4mu0HoCZ7iP2u8i8lJy++4Q1kmhQCTx4HZk3?=
 =?us-ascii?Q?TjlnnF0BVnvpV7UpOBjq72hjOe88ECpbfmGBIBUc5MnOMhpk87/Kwr6ykg3b?=
 =?us-ascii?Q?ougMtW27o7CaWtRrbW6E4jQRm6AubgFLe2Zej5AhqYORE8WhXfnFEpXX+xMS?=
 =?us-ascii?Q?+ml1xNN9fm/mSyyO7lOz6X+QAZiDPWx3/YOD+dfDIBGDl1MDOR1yLVd14Iyh?=
 =?us-ascii?Q?5Dlyz74xHbV+ao+xvXPJ45e6E7AvHI9f4zcVWPSEy0llEDo2HPoLASJkkkHe?=
 =?us-ascii?Q?DTfWYnHpKOz+aS0+6ZCCaPeIhCAav0/p33YZD23Rvf9xT5HFizXc4pf/WJFn?=
 =?us-ascii?Q?rKrhtgITnCnUz+uxxO5SticFpUyLzRaKrxtNOpib6Z5YYX7TLkbzYLWwWJNu?=
 =?us-ascii?Q?yYWYRTY9L8LOtfPLa0vjYJGIgvNy7E2PNwlJgtIgoAUVyvZrOOeJuOTG0yJq?=
 =?us-ascii?Q?OLS7BAMaziBJko8ezY/Im5r4PIPSBuK+Kv2eBd5K2fV9S32XTjD3aelV5eYy?=
 =?us-ascii?Q?+SvpIdtoZ6u9M9rTrDrUGziC/i1QawxDnEMLQodbY/Cq/EPO6G1BkWlFA2mU?=
 =?us-ascii?Q?TSwzO/JTlNHr3jOR/cCTRGSeC1oV3ENsV8/R+rH6BrcPvKxwzHJBiEhCHADY?=
 =?us-ascii?Q?WxdhLnLX0h5XEQ8r2yI=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 19:55:56.0980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f20a8a62-0125-49b2-9157-08de514b6f26
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6087
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Add a helper to allocate an iommufd device's virtual device (in the user
space) per a viommu instance.

While at it, introduce a struct IOMMUFDVdev for later use by vendor
IOMMU implementations.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 backends/iommufd.c       | 27 +++++++++++++++++++++++++++
 backends/trace-events    |  1 +
 include/system/iommufd.h | 12 ++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 3d4a4ae736..e68a2c934f 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -472,6 +472,33 @@ bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
     return true;
 }
 
+bool iommufd_backend_alloc_vdev(IOMMUFDBackend *be, uint32_t dev_id,
+                                uint32_t viommu_id, uint64_t virt_id,
+                                uint32_t *out_vdev_id, Error **errp)
+{
+    int ret;
+    struct iommu_vdevice_alloc alloc_vdev = {
+        .size = sizeof(alloc_vdev),
+        .viommu_id = viommu_id,
+        .dev_id = dev_id,
+        .virt_id = virt_id,
+    };
+
+    ret = ioctl(be->fd, IOMMU_VDEVICE_ALLOC, &alloc_vdev);
+
+    trace_iommufd_backend_alloc_vdev(be->fd, dev_id, viommu_id, virt_id,
+                                     alloc_vdev.out_vdevice_id, ret);
+
+    if (ret) {
+        error_setg_errno(errp, errno, "IOMMU_VDEVICE_ALLOC failed");
+        return false;
+    }
+
+    g_assert(out_vdev_id);
+    *out_vdev_id = alloc_vdev.out_vdevice_id;
+    return true;
+}
+
 bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
                                            uint32_t hwpt_id, Error **errp)
 {
diff --git a/backends/trace-events b/backends/trace-events
index 01c2d9bde9..8408dc8701 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -22,3 +22,4 @@ iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) "
 iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
 iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint64_t data_ptr, int ret) " iommufd=%d id=%u data_type=%u entry_len=%u entry_num=%u done_num=%u data_ptr=0x%"PRIx64" (%d)"
 iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32_t hwpt_id, uint32_t viommu_id, int ret) " iommufd=%d type=%u dev_id=%u hwpt_id=%u viommu_id=%u (%d)"
+iommufd_backend_alloc_vdev(int iommufd, uint32_t dev_id, uint32_t viommu_id, uint64_t virt_id, uint32_t vdev_id, int ret) " iommufd=%d dev_id=%u viommu_id=%u virt_id=0x%"PRIx64" vdev_id=%u (%d)"
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index c0d7c50f7e..67c42f78a3 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -48,6 +48,14 @@ typedef struct IOMMUFDViommu {
     uint32_t viommu_id;  /* virtual IOMMU ID of allocated object */
 } IOMMUFDViommu;
 
+/*
+ * Virtual device object for a physical device bind to a vIOMMU.
+ */
+typedef struct IOMMUFDVdev {
+    uint32_t vdevice_id; /* object handle for vDevice */
+    uint32_t virt_id;  /* virtual device ID */
+} IOMMUFDVdev;
+
 bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp);
 void iommufd_backend_disconnect(IOMMUFDBackend *be);
 
@@ -73,6 +81,10 @@ bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
                                   uint32_t viommu_type, uint32_t hwpt_id,
                                   uint32_t *out_hwpt, Error **errp);
 
+bool iommufd_backend_alloc_vdev(IOMMUFDBackend *be, uint32_t dev_id,
+                                uint32_t viommu_id, uint64_t virt_id,
+                                uint32_t *out_vdev_id, Error **errp);
+
 bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
                                         bool start, Error **errp);
 bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
-- 
2.43.0


