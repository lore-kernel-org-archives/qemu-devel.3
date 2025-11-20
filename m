Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F01CF8858
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 13:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM4dM-0005bb-NC; Thu, 20 Nov 2025 08:23:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4dE-0005Zk-00; Thu, 20 Nov 2025 08:23:29 -0500
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4dB-0001yG-TK; Thu, 20 Nov 2025 08:23:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WSoVANHXMlGyejXKn9WE2IE633zTrO1PgC63TNODNlkbsVecegTyLzquiTBzltgMcl7343Mk4h9DU1qgOxI84NvIJWBR8jA3jhOFEGGUIeVKfFt2khzEoYybkdeuyVsuY+fjfY7yRxKtB2hBLEKDBpKGM8rVrkwglcmsXrzueDT9ZckJ+6HAtpMpStdmrO6tdNEPBfetbnuwHygXQchTKHpgpiCKM2jYKYAy1X0IO3LR+QE7veoCL/Fnuj4wGVT/oy4lXC9HA2Ce4owBrhsyoA1h6H4NwVZvgp8jOC4ruRNAxLGJ/SyRdkeNuVJNoLUHTjehu19yVhPHA80h8q873Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2YTS3iXzIG+DnCnRnItzlaG1sH31jn47M1SaiNks5Ew=;
 b=A3vpKa5OBq4A8bPxnrgjW8Q12REkTts0MZH9dAeso5+JURyF3L5a6B04NZ/OgZ42kHj4Ug4aLe1i5hOZRNhf/kLbotSetryiQwSs/WdQpjSV8hmckEvnggswT+COmdjtzNY3STGulC3Nryf5Tjsh3DS6e21HPgh5DqSuMYEuLzjHj2przkTz2AnAIf2hrdjP4qDaYo47tt4s37ZEErI1HZM8XyiAtuBtZCoplW/KO8Lid/ubhvsfFIxn+dvzS5zPxHHQmet0ZmfoOYeAgpTTkJgZ+ekX/xqMA/n0kJeC9pMNw6TTOJ42vuOj6t8mGEL160K5LgCyZcgn8zKH4hss+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YTS3iXzIG+DnCnRnItzlaG1sH31jn47M1SaiNks5Ew=;
 b=RrnuUMQ+NDM19qG5LvZy2/HD3SJ0loLSK32sZDZ3ouuBiM9mGy6YCfeZE0zPJy2yH4m7Qf8Q2nG3so6ta32at5F4lRM8TgQ89vQQ8Qb/3qHDHjfTSiKJAox1dQWwrlGHy3bDVCyUep/k6vSK3RhepOpVJyAJUoPmFPp9Iwx96dWKNvfmUJuxf6qtWyCH2/AU7xCB/pwFtknqaG7hwgVuFyNWhyp9QBAY6tbx7xwN6YKFIbxnMlcIimEO1yklq986No+nrtGmiya5vOANS/76Fjwzkq+1JGE4u3WvutjF0r4nFHM7Ib5e6rTt6i0EbfLnu74XdMfmmpSO/w3IsVEAIQ==
Received: from CH0P221CA0013.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::6)
 by LV2PR12MB5943.namprd12.prod.outlook.com (2603:10b6:408:170::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 13:23:20 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::d7) by CH0P221CA0013.outlook.office365.com
 (2603:10b6:610:11c::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 13:23:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:23:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:23:02 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:22:59 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v6 02/33] backends/iommufd: Introduce
 iommufd_backend_alloc_vdev
Date: Thu, 20 Nov 2025 13:21:42 +0000
Message-ID: <20251120132213.56581-3-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120132213.56581-1-skolothumtho@nvidia.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|LV2PR12MB5943:EE_
X-MS-Office365-Filtering-Correlation-Id: e301b13a-342f-45e2-a8ce-08de2837f917
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|7416014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y+ZQEu0KesQNbnrIyIARiQQB8LV6/mPrTwVj3yAwtUOTPm/aaK+AA4NIHBNK?=
 =?us-ascii?Q?Yy6PrSmB58UWfrYIBSDHyXewwtCYVV1W7qELfDmwTD0OHtOr0dvWPsBbNBYr?=
 =?us-ascii?Q?pX2NaceVu2VFNJz+VkSoZ9LzTzw2OLrd3nupuQ/WewQ3cmm9YPdl6RNKyQPG?=
 =?us-ascii?Q?avjn6+9wCoV6tyHET3GpmggvX+LZyZxdKO8NN2L8h9R1JP8Ev2q0SQ/U8fCZ?=
 =?us-ascii?Q?TWOBj+/xHnggfFUOWom3qxOFftcLvoTl7BbEW3jeMckmh0hqwbGf22ogW+8B?=
 =?us-ascii?Q?iDuw7E0kRnVmLud7cMHQK9RNphopGilpIfeGDDhAsvxxsUMsHGuyinAobCcf?=
 =?us-ascii?Q?PxRU3QIfwVG8lSbp5gH8TfSrm2vVwRXlqcCz9U9prVKBZY95Y6lYXMklNxjb?=
 =?us-ascii?Q?UbW0WmosxNZ8njMPKaUXRCv1ZQ5VdKHRVgSxVbomEl9SQzNUg5prhk+xvtKk?=
 =?us-ascii?Q?g9iGXslNFV6blfq3OQf1WpNkehdtQSR714C9USj35uf270Pd0jyuW7BGvacy?=
 =?us-ascii?Q?bc5h2gIrAHizvYybF0UUXs5azC4c2jFoiwa0OdGlCKEorDSpcT+e28blFXCG?=
 =?us-ascii?Q?cV2O2sDAc2kRaELnTcf0qbgZn3h1RXcY8xJKtCdHC9tTEC/ZFiDQK7n4Uzhn?=
 =?us-ascii?Q?F8Dbr6x+Wi5mB0hkBoevTYwAlOVvQd2JB2SJid+ZzBORib3oUyFWZZ2y/aVT?=
 =?us-ascii?Q?OtYSkYA+V071uU0qZ6zs5rl+EUoHZJQcF5EYX1oX+xj/B1wwDq7bDl6rKNIl?=
 =?us-ascii?Q?RyueToA0YyxN58lbe0n/57xbCAHoJ1uV+30QxpmonBBdbmVh+8Y+VUcoBZPy?=
 =?us-ascii?Q?UZ87e8Rzunswl7fpxDya3yzTHJTZnKZE0T7lZc3m23pAtRGmk4KzDmtSg1G4?=
 =?us-ascii?Q?8qbzzWgxYuFrj6lRYVrThC8Oz3dQfVVqpfOzPWKETsPUnhbvSdj/LxhbvDuq?=
 =?us-ascii?Q?dSSSM+PotTbTIXvYvzBY00IECUUG1PaeMc/QueRLV2IJf7LpGTxZgUf2Bqrq?=
 =?us-ascii?Q?xw4hs+VrUnfNZGB6FtE7Q3Je7hijPN2Tcd1dxvPQAKGoKiJ2JXIpy78MRR6g?=
 =?us-ascii?Q?GGnrkTlG5N1cYW8V8hMo9aPmWtsHbq+RJbFg3JjTkCsaipYwfRp5yxUDm1To?=
 =?us-ascii?Q?Q1onLzdKr1tKJPzq+STc3OjCBJg/aSQgUAKka6B+UiysjgiI3ZVXPjSVJOl+?=
 =?us-ascii?Q?b1hOPyq8Rq86zUFXdiBYSCL15P34M/ZUPqMl6LtNaoMYVXJNXnO/BjZzAm46?=
 =?us-ascii?Q?bSaEUuK28MGe/kLKKE4UEJUIVgIfGzz+xe5wI1ZvpF+nB43iIk3wNxDF+1Z7?=
 =?us-ascii?Q?/9LKZpr7njPMuXg11aUA8FWA6bPQj2YEiECiSdQ0qGD99409EHWft2ojrwD+?=
 =?us-ascii?Q?hs8B3Qd4+20hgJValYpu49Y9FikDSoIFi7hrodjrc7u0t+gwo3vy0VJTCoS6?=
 =?us-ascii?Q?fEzqnTdZ/EgOC+0XWGlBYZ+kRkiPUIprQAZRLBvhGZ/VRum5H1Zg4ZEi/IbB?=
 =?us-ascii?Q?Jm532j/ZqAE6gTYfey2Ae2vvT8OHF7qAKGdBBF9BHcMWCshKmoZgnVc7ixyc?=
 =?us-ascii?Q?fl8JB+nAraPbr3/ZjWc=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:23:19.8896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e301b13a-342f-45e2-a8ce-08de2837f917
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5943
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
index 11b8413c3f..41e216c677 100644
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


