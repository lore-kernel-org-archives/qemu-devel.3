Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE503CF8855
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 13:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM4dH-0005aG-RT; Thu, 20 Nov 2025 08:23:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4dA-0005Z1-9J; Thu, 20 Nov 2025 08:23:25 -0500
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4d6-0001xY-My; Thu, 20 Nov 2025 08:23:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DcY1LJ7g54ro31F+4jyBL4x8lOghAFgNBoInJ419iBLF9yVOGeDEsGpV+it2jHKrEVN6sFAFrWisH1tmuec/Ubf9StPeSMX9jvmKCyy3iZcxSqhc0kmetel+WeDk+r0bQG1FINsMw4nE67r1TY2VHRNFNDM4UURIJ16ScDXfV8AEdcUF0mc9O2bWtS09fbzJa1bkYL9z5aDZSmY4XZUuCHaIujB4/bI08i50tm9+bk9R9JDA0MQLARpD6hC3O92F7Io/kvnemyTwu+AdE2wI3X6GzbBeGjo2j8dsohhiP2Yz3kAltgPRgJ0fMqa2CfXitcKvwjS56GY1VAjXX7zJkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ia5kC+o0xmi7ZGMm1OaeSl7CQLzO+HThMtd8rA6ehqk=;
 b=ljSylSE+irMTlQJSVnnm6im+UBXTbdKrv4EokRzdm+f5Oe62yN6PzWdFYLVBLbD/YBx0ydQkgOIhraTQAe2zTOkOKlKeT7ME9iQfPgxyMRDzvRRMxoVq/ZXBphM2UrmUZC5dP6E09p7bQJdFzRyRF5zgAa/3jXxK4urOGwYIsPejs0vWnuwyGuuxi9/qD9OCxhEsvs6HWqqVYRIJ3P2cM8T2hqSB+7NAF87s6oIbas3t3QIWX89Fk+weUD8Xoxl4WTocmdUNY32yOCAdAnYdIq7dWyRuucajHe32yEYMlL6O9IfBTionE6KvXxtlY33GHiHSshfa0lyoNFlhx3/Nfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ia5kC+o0xmi7ZGMm1OaeSl7CQLzO+HThMtd8rA6ehqk=;
 b=XoTbFvRa6sxc9C8Z4gAQfN5Za2be8FYyG4KhR3GXXWbEmBm/t6hvIYuoBsuZatyTou6FvhdbNdloKNkxS1ZX4ZaryOxhHvUnnXhCG2nOMwRKlWnPKIbiKWLofROvCDGBujYh3Ay9ujhAmtzv1HVWZALVkHt9PiIY+kH+1xX/EhqKHoXrJ4ufdtpPB0LZvdQa72cb/nDoBE2qDNoNGC+1HNWZF1xyUuMznYgiNkyvDKN7f9zQU00KSqrij1OPxO9EyZO25X5O2CxAr8ypsFAZeb9MxPWLuHen8Qooyy1gr3vs+1TW1L/xPAmNQHQxreo5liXQYxvVkj9q/XZFX+wmNg==
Received: from CH5PR02CA0016.namprd02.prod.outlook.com (2603:10b6:610:1ed::13)
 by SA1PR12MB7175.namprd12.prod.outlook.com (2603:10b6:806:2b2::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Thu, 20 Nov
 2025 13:23:12 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::1d) by CH5PR02CA0016.outlook.office365.com
 (2603:10b6:610:1ed::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 13:23:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:23:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:22:58 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:22:54 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v6 01/33] backends/iommufd: Introduce
 iommufd_backend_alloc_viommu
Date: Thu, 20 Nov 2025 13:21:41 +0000
Message-ID: <20251120132213.56581-2-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|SA1PR12MB7175:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bef4002-3f25-4b6a-0d26-08de2837f47c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|7416014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7J9Ok83uw0fEr6dlUwB/pp8QYqjNZPK7Ut6vrXHnIyiIaNF0gOnfHMzq0iWW?=
 =?us-ascii?Q?vZf7BtNkJqMXrHPx7nnv2+UkilD2uWM7jWMWWcS/KBTZJVayvtLvbVvCQcqJ?=
 =?us-ascii?Q?CMMHF8m4AXQhS59RfLeAbJ/KCZHTmuKel3hBcKIN1XmCKEMvy+Wo/oRMXRD9?=
 =?us-ascii?Q?wR/Ok3+KSBfYua1e9TG6yXlUZ9CNmc9+7MhOEObOZqtsgIfMEY44Z/5C2DUe?=
 =?us-ascii?Q?PW4D0GlsbqmIZj+QAhzGPuNDLXqbkuKNCoNJH31XvpLqR0N/9iAafKgbUYog?=
 =?us-ascii?Q?Y5bhZYPHSpYcbbf67v9xGvx8d6Ngp/O1PImgKQwdIjNrHJ9hnHnKr6i/Sqk5?=
 =?us-ascii?Q?JgaArEUSKEa9/m0y268SmQInXH1Mh6fdfZqEW/EswDe06+iigxEt2L8jF40e?=
 =?us-ascii?Q?ATePIQ6kJkBCK/JiIdFlzh1jB81x1ybEw6Npz8Su5/sy6g9u+yHyCHfAPc3q?=
 =?us-ascii?Q?q7jBBtxcUZTfLSk2Avrq9jQfHE/WODIw+YPXW7L815ILGX7cGpn6O0BUjOez?=
 =?us-ascii?Q?M3NBT/R3GR1ArdusvSy6n00qUx/1/1yZMUqugRPliRJdbsCDwVKqoiZfKx6m?=
 =?us-ascii?Q?6NbPVHzwkdfB4weuVAIO/78k59fnLXYFV9/3dS07Cjh10pVvsgcsKOPt1PvA?=
 =?us-ascii?Q?gFGbJwxiX/dfoBpGtibtffFYvFrTUC7tjl4uA1YQ7qiOkS9dmqOhZFRuJss4?=
 =?us-ascii?Q?wQZcIHzRdAYe5/6mfoJm9bhtUw8R9xGiCUr5t+jfS0E1vfp2C+y5IijEkODJ?=
 =?us-ascii?Q?/y67n8DVoB7JztuwFJKEoLI3N+cxCny96y2lt3MgsEctdnquXbD1Wu8Rmjbm?=
 =?us-ascii?Q?7zJ8mkW/xv0g1T+ohsrUn6KfWFcPtAd7Fzh78CZOrujJo6YjYwJ4JETzCfHp?=
 =?us-ascii?Q?Yfi19nZQSNROXgeNTc2/kVSYbZK0f4qBdb9VPHsCQaHNtgvq6s9ecAES5PnE?=
 =?us-ascii?Q?+8x3CNTH2mxyb1h5hcCjUdZwstlSd+LoGwYRvw7ClZDEZiWlTe74eEtiqAoR?=
 =?us-ascii?Q?ZaqRKdQ6fjdO06Ilpcyc1lFIBIYwgMvA0bB7lsDhJrlvRVCt1uTAF0/lcwgs?=
 =?us-ascii?Q?bm6adVsq2WNX7RngLFuIrn2SGG8lp1LN+QvZh5vhRxqfViK2xr5ZGTp/HUN1?=
 =?us-ascii?Q?y4XvvfgrE/Udj+afNhay6nsjBe0HI4KyOrjqyRe5b2F+7BzcH8IRbjleNacp?=
 =?us-ascii?Q?h3PxpiZPOGndNNqR5zH19DWXeEab5QIXZFyFfiSXQFFrod748B5oiEGETVEo?=
 =?us-ascii?Q?G2BFm/xelrDpqQ2MerJWMfprA0MNgVHx2k1Esfyl5dmqfzjcN2ltp1z+XqxX?=
 =?us-ascii?Q?J7U50hFYeOI1CTg8RHrE9+7h8EgInvO9Qju5bMKhAzVPihvcD5Qr/WRSyY8l?=
 =?us-ascii?Q?vL4EzgpT/mqve0i3UszwetWevNKl3JnkLm1JjJCm9eLwYjLBs/4/LZ9uTIn+?=
 =?us-ascii?Q?DkQTSz/sDHag2NBcY1m4KJN5NEoOhrvCXNmavVshmzCe4um1bpv0fHoCJdfX?=
 =?us-ascii?Q?2IE3K870HNvrt9tVnjtsOTTt0p3YEEHpfjspThhJ4VIOHk+I9fo5h1pyWsgD?=
 =?us-ascii?Q?u4fVodeLjQGQQcKtCbg=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(7416014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:23:12.1539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bef4002-3f25-4b6a-0d26-08de2837f47c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7175
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
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

Add a helper to allocate a viommu object.

Also introduce a struct IOMMUFDViommu that can be used later by vendor
IOMMU implementations.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 backends/iommufd.c       | 26 ++++++++++++++++++++++++++
 backends/trace-events    |  1 +
 include/system/iommufd.h | 14 ++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index fdfb7c9d67..3d4a4ae736 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -446,6 +446,32 @@ bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
     return !ret;
 }
 
+bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
+                                  uint32_t viommu_type, uint32_t hwpt_id,
+                                  uint32_t *out_viommu_id, Error **errp)
+{
+    int ret;
+    struct iommu_viommu_alloc alloc_viommu = {
+        .size = sizeof(alloc_viommu),
+        .type = viommu_type,
+        .dev_id = dev_id,
+        .hwpt_id = hwpt_id,
+    };
+
+    ret = ioctl(be->fd, IOMMU_VIOMMU_ALLOC, &alloc_viommu);
+
+    trace_iommufd_backend_alloc_viommu(be->fd, dev_id, viommu_type, hwpt_id,
+                                       alloc_viommu.out_viommu_id, ret);
+    if (ret) {
+        error_setg_errno(errp, errno, "IOMMU_VIOMMU_ALLOC failed");
+        return false;
+    }
+
+    g_assert(out_viommu_id);
+    *out_viommu_id = alloc_viommu.out_viommu_id;
+    return true;
+}
+
 bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
                                            uint32_t hwpt_id, Error **errp)
 {
diff --git a/backends/trace-events b/backends/trace-events
index 56132d3fd2..01c2d9bde9 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -21,3 +21,4 @@ iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%
 iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"
 iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
 iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint64_t data_ptr, int ret) " iommufd=%d id=%u data_type=%u entry_len=%u entry_num=%u done_num=%u data_ptr=0x%"PRIx64" (%d)"
+iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32_t hwpt_id, uint32_t viommu_id, int ret) " iommufd=%d type=%u dev_id=%u hwpt_id=%u viommu_id=%u (%d)"
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index a659f36a20..11b8413c3f 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -38,6 +38,16 @@ struct IOMMUFDBackend {
     /*< public >*/
 };
 
+/*
+ * Virtual IOMMU object that represents physical IOMMU's virtualization
+ * support
+ */
+typedef struct IOMMUFDViommu {
+    IOMMUFDBackend *iommufd;
+    uint32_t s2_hwpt_id; /* ID of stage 2 HWPT */
+    uint32_t viommu_id;  /* virtual IOMMU ID of allocated object */
+} IOMMUFDViommu;
+
 bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp);
 void iommufd_backend_disconnect(IOMMUFDBackend *be);
 
@@ -59,6 +69,10 @@ bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
                                 uint32_t data_type, uint32_t data_len,
                                 void *data_ptr, uint32_t *out_hwpt,
                                 Error **errp);
+bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
+                                  uint32_t viommu_type, uint32_t hwpt_id,
+                                  uint32_t *out_hwpt, Error **errp);
+
 bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
                                         bool start, Error **errp);
 bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
-- 
2.43.0


