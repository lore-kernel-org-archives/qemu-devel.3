Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7864BCAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 13:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3E9C-000474-6n; Mon, 29 Sep 2025 09:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E8L-0003FJ-1K; Mon, 29 Sep 2025 09:41:42 -0400
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E8B-0003tq-Eb; Mon, 29 Sep 2025 09:41:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mhXztEEXpJAH7Oc1xCnxsLBuB2LuSE168tCg/BW0CIad/+A4HTWy7mBv/7xXP1Enadxbv+urlWVdMVYdXFcVAdBhkHK90vBtmmQYq1gRspP5k4VbbxMldYbUZbaTwOL7FfUQYP/pergHlnOPTWDSuBNpwfj5L33xSPjIZUzegx++crbEnpgWS2s1I3MW/6I6FLTOl/TCnlT44kvF9FRkQzY5N0WqqVqg4KqMrs9YS/4zbAS8ECK29OOZc0BYsydaRnBaj4F/cR5RTA0Wpkju+vTCWnArVh9uSRKrb7v6I9hDjpjhjk98skDLIIVMZTDNKFd4PVxMNfz+VWcegprOGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMwFvED0ISO2aoRjTxCCLHC7h13/YHjIqbzMUXJXRo4=;
 b=c85Kwpks9OA3xVA+QtfhznCbtdUxHIWIFQIqKWhOWqgiHr79S7sE9q/h2ohzMHQBl4qfWXXrDpbbenoSzjq2N1znPatZDe2gEN8ecuWUPEL+zJSPMLVX/kHxAUa1epE3PgDsAZO7j++oecVXN4N5d5ALGl+/VjJyRLkpcTzN0q6d3A8dh3Ab4zlKAWOwLxfsiomJ71smzsHLFLicc1K/w5qKyJScZuoN1zGH0GhWVbKd4SboP5Aj6cLXdImmiJamfxC+gEmMN5fMlJ6cIBDlL77cWTqJXFlQESOL1QmhTtiCpnh9oH2muDEokiQlMvs12oRKi+eJMoCAqgfU7QeEkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMwFvED0ISO2aoRjTxCCLHC7h13/YHjIqbzMUXJXRo4=;
 b=aM3QuqWIYtX7lJlDlgfsuhHXDCtk0pL1RI269xnFi4Up1AX4E7jEMAcalxt4grqkhb+7lOWtjZ4FyezgL5DXNI5W+qtA0NJAT6HpLSvL0N8k/FANNom3gSna70gc7PhU8H9ac7DF8e+Zhgm/wZkhImkFXUXivu0ZsSq9cm8SXIGuzlb4bPafuBe5bdl6rOPxoR1arlX3f50v9exerksqWGX78tinM5QIaOS25NO/aEZpagrlW2JbTwDGFSxzJ1I/5lJz91nOkbXK3/42yT3FG1/NQ/JlHf9UpegVmw2BIGZuIqhugeLA0/3L+cmSJzQURKVu0RyYYvtLTqdaFHuMww==
Received: from CH2PR14CA0059.namprd14.prod.outlook.com (2603:10b6:610:56::39)
 by SN7PR12MB8025.namprd12.prod.outlook.com (2603:10b6:806:340::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Mon, 29 Sep
 2025 13:41:01 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::f6) by CH2PR14CA0059.outlook.office365.com
 (2603:10b6:610:56::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Mon,
 29 Sep 2025 13:41:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 13:41:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Mon, 29 Sep
 2025 06:40:45 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Sep
 2025 06:40:41 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: [PATCH v4 24/27] backends/iommufd: Retrieve PASID width from
 iommufd_backend_get_device_info()
Date: Mon, 29 Sep 2025 14:36:40 +0100
Message-ID: <20250929133643.38961-25-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250929133643.38961-1-skolothumtho@nvidia.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|SN7PR12MB8025:EE_
X-MS-Office365-Filtering-Correlation-Id: 1097de44-d698-43bc-78c3-08ddff5dd459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rrPVg3hR9/YSWGBQBLXnFJpWI4xiYGH9R2lR4y2ZB1JDLeCJ4/rV9exDN1bX?=
 =?us-ascii?Q?hpAz1boQTkwqxy++YVrjfV9rfUNSs1GzU3V1zA0+iordUtF7kunCgPE5KKr6?=
 =?us-ascii?Q?gadjfDZ39ZkJ76GsUCTMeG2EirWgcLOQoh2KkV+pOt5kpGU29Vyb41xGPoDE?=
 =?us-ascii?Q?Htfa9bjDeVZX8tl2XPeF6Zn9Y5BAp71D67zY0lwluSTHNKPGhgcnE10fNxDh?=
 =?us-ascii?Q?Vyt7WKr1enoN5zxTIXtiMLrf5hdH9mKqK9KuQ20MsBXcLdIgwcd4dMep1yD7?=
 =?us-ascii?Q?Hn5HNH4kFQhZZXvyhiVwqh0m4BCV1vF2rxvPEoF0iFVcGovexuLUxIC4+xq9?=
 =?us-ascii?Q?KHXuFycYwUEj1rdemK3/9eYDgOX3fomnhx+w0T9jahKdwI5oZzqmQ5DVIGRq?=
 =?us-ascii?Q?gVUQEsZgKsBc1NA/aY+qoE1efG5qCqI1xGk4YUM0zDCMvn4TO+hbVjt8kAPZ?=
 =?us-ascii?Q?W/O/bBoQfmbesa8CoAwg+2Yytxu4VbnzCHB9QittncM1Pq42V75Lm1F4lZ/M?=
 =?us-ascii?Q?LBpKgf7Ehe2O83V0sgQL05Qx+yWjY72HItFGoXQ/rsoZecyBf5Tex/jFh4rH?=
 =?us-ascii?Q?wgALEKRPUkNLWjYvSMV6U6pAt68q2T8+U4d8jphd0zyXQtDL/xBaWQtvTmSq?=
 =?us-ascii?Q?atQqToYOgFZfM91+YxHvO3CCKh3SzL2lQwf6fv3cFW7QAzMXnV0M2Sl/5Tw0?=
 =?us-ascii?Q?m8dV30CwO3OLJCPC6GMS6SsFVUoW1i97y6BS1AgbFHsuGSyn5yDFHDGJTxcK?=
 =?us-ascii?Q?1A2n+HSC4paBjbYGORQA3LZv+G+hzetGMo4A+rBj47EgQcQx0MerXJsm0ELQ?=
 =?us-ascii?Q?2aQ7MO5NCcjx87H0us8tm/7oN+3yJS6QYVHLUOaZRV6D+oyeF0/Y86uJnhM2?=
 =?us-ascii?Q?/OcYrxr5atZ489Wt8KWyuoADo/Lt280A445UkgF5yLuQj96cfH44Axg73nL2?=
 =?us-ascii?Q?eTEbPu1JpWOtsoxFmV17Kaff+oq63awmrsPldnJT3V7pPJfaXkWG9qnCs6Q0?=
 =?us-ascii?Q?zaE23aL/+mLrqTADhhdJepvW9KTkH9bQA7tRCBbqJhv9VdMip4TBPawSUGgT?=
 =?us-ascii?Q?FkTocen96hdw2jWA5dkBOSzt61ffwGaEzHkPghD4qJV9Em2nBSCORUcBtahP?=
 =?us-ascii?Q?F1DNJMRfOwEje01IOaQKSrvgfAnHS3flxY1mbEvlePv4DJXzDaNhBH3EE0tC?=
 =?us-ascii?Q?aIZ+WKxkU1wuYmSNOBl9BgCA3erHJjH96nfQpYAhK+nVYBa3uj5uPfgX/Y9i?=
 =?us-ascii?Q?XmvOjGeOXFRQa6Bk/wNgn02iXz0whx80HaQaPDrpxPeWbeNBNxQ5+3kpXu1h?=
 =?us-ascii?Q?KGNtWgn682AjuhepqM7sfy2P0AzQ7nDdFNIjKynVngeYBwp1BYngoisf4uYq?=
 =?us-ascii?Q?uqfojBve/4ASA8Y6NmKLO5x3UZZwmzxGWp7RLCXuWVJIwyI1qy9Jwqt7NzKu?=
 =?us-ascii?Q?F+i5gVR1uMQnmX3rdNgEZiK96R0nyhczMG6Pwf0LCsR3hR1RGsMvzu/wWvKs?=
 =?us-ascii?Q?nQX0ziS2wwF0vZyQALtY9KLYoFdGfLGWS/QPANc3aGvraoowDGocm378OhRC?=
 =?us-ascii?Q?s+BmOXWo01IMPWUk8CE=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 13:41:01.4808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1097de44-d698-43bc-78c3-08ddff5dd459
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8025
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
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

And store it in HostIOMMUDeviceCaps for later use.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 backends/iommufd.c                 | 6 +++++-
 hw/arm/smmuv3-accel.c              | 3 ++-
 hw/vfio/iommufd.c                  | 7 +++++--
 include/system/host_iommu_device.h | 2 ++
 include/system/iommufd.h           | 3 ++-
 5 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index d3029d4658..023e67bc46 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -388,7 +388,8 @@ bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
 
 bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
                                      uint32_t *type, void *data, uint32_t len,
-                                     uint64_t *caps, Error **errp)
+                                     uint64_t *caps, uint8_t *pasid_log2,
+                                     Error **errp)
 {
     struct iommu_hw_info info = {
         .size = sizeof(info),
@@ -407,6 +408,9 @@ bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
     g_assert(caps);
     *caps = info.out_capabilities;
 
+    if (pasid_log2) {
+        *pasid_log2 = info.out_max_pasid_log2;
+    }
     return true;
 }
 
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index ba37d690ad..283d36e6cd 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -124,7 +124,8 @@ smmuv3_accel_hw_compatible(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
     uint64_t caps;
 
     if (!iommufd_backend_get_device_info(idev->iommufd, idev->devid, &data_type,
-                                         &info, sizeof(info), &caps, errp)) {
+                                         &info, sizeof(info), &caps, NULL,
+                                         errp)) {
         return false;
     }
 
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 525df30ed1..89aa1b76a8 100644
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
+    uint8_t pasid_log2;
     uint64_t hw_caps;
 
     hiod->agent = opaque;
 
     if (!iommufd_backend_get_device_info(vdev->iommufd, vdev->devid, &type,
                                          vendor_caps, sizeof(*vendor_caps),
-                                         &hw_caps, errp)) {
+                                         &hw_caps, &pasid_log2, errp)) {
         return false;
     }
 
     hiod->name = g_strdup(vdev->name);
     caps->type = type;
     caps->hw_caps = hw_caps;
+    caps->max_pasid_log2 = pasid_log2;
 
     idev = HOST_IOMMU_DEVICE_IOMMUFD(hiod);
     idev->iommufd = vdev->iommufd;
diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
index ab849a4a82..c6a2a3899a 100644
--- a/include/system/host_iommu_device.h
+++ b/include/system/host_iommu_device.h
@@ -29,6 +29,7 @@ typedef union VendorCaps {
  *
  * @hw_caps: host platform IOMMU capabilities (e.g. on IOMMUFD this represents
  *           the @out_capabilities value returned from IOMMU_GET_HW_INFO ioctl)
+ * @max_pasid_log2: width of PASIDs supported by host IOMMU device
  *
  * @vendor_caps: host platform IOMMU vendor specific capabilities (e.g. on
  *               IOMMUFD this represents a user-space buffer filled by kernel
@@ -37,6 +38,7 @@ typedef union VendorCaps {
 typedef struct HostIOMMUDeviceCaps {
     uint32_t type;
     uint64_t hw_caps;
+    uint8_t max_pasid_log2;
     VendorCaps vendor_caps;
 } HostIOMMUDeviceCaps;
 #endif
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index e852193f35..d3efcffc45 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -71,7 +71,8 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
                               hwaddr iova, ram_addr_t size);
 bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
                                      uint32_t *type, void *data, uint32_t len,
-                                     uint64_t *caps, Error **errp);
+                                     uint64_t *caps, uint8_t *pasid_log2,
+                                     Error **errp);
 bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
                                 uint32_t pt_id, uint32_t flags,
                                 uint32_t data_type, uint32_t data_len,
-- 
2.43.0


