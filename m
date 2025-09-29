Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20324CAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 13:41:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3E6i-0002Td-Ht; Mon, 29 Sep 2025 09:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E6b-0002RR-Qz; Mon, 29 Sep 2025 09:39:55 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E6G-000398-I8; Mon, 29 Sep 2025 09:39:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z8EXH4UGgeotAVr2en0RzPEzvzIfgAmM3UL1V7KSACZt2fidU1PhvQcqHPZtvYsi88iRO8PD72wKGdLoWDhrHCEh6zHR7gpXVfBgNrJ70E+J9wfwToqQqu+j9qh6rsKc8LcHJYi2BTULLXAzQSG+SuXYr++ymWNKW0T12ZetsgRHAacMdcCxM9vO/GhAGqsQU1CqjeovmVOTMbrLGyMl/Ed6t/wAJWJhgStO7c+OvCkx7lMYrBCj2yvGCxnRB6382EPtp8E3hM7hGTlVZ1Gp0hvbng9he4/QdQBZ/FHMa2ezzjGLrIPMhfedSEYJ2oC8IkFeSd8aRwbA2ghFoaqSmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxG6JabGVs+OjcVBIDuOhfHlN97W0+LzO4qTbDa/kWc=;
 b=v0Vz408Vxgu6r9cAwW1d5948CL+bVNCpAFiWiJL0YO0YGirmB5W3uGfjPnNq1wJxQLTSQaMeY33ppxSqcVNh0FZ0Hu5uXVOABkZc/Qo+kBikczVlx53i0mWKjYgmlSjqxunOBUlt4309ioQtzzQldlik4kFf6PQNWfBUy9+FG/0layRw9mBOVIYIsvbQnTA+yv9IjdTwTI8X/gKMj2Wgbon80y26mf5B0niPToOPtYLyR2vomiN/twnUUUkNlh1brdvLPkIuuEyv9OgLr8IvY8kWfswGZfOB19iyDQSBLafAdjSLxCEDGd9Gt0lPP1MMqTg36DZzB3jYY5Xy3PPXLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxG6JabGVs+OjcVBIDuOhfHlN97W0+LzO4qTbDa/kWc=;
 b=Uv4Ah8QpUynwHDvtkyddnD4DHMr3hE2B0YFpEP70QQQD6MHH/No2AUPuhwsVkH2FDJDGGFiAXfopeh+2Tsyn4L4/RPsMKYZwfxzm/s4ZdsWC99khEH1/SbcpY9GDmZZDxGUWl7iJiHO1TATBNPRrSPcCXIy8Jd/W6iva5e+LhvwpL/CTx+nhVt3gGDYJhvmLU6DM93eZpq5mPZtVybVp199supDchToPiHIDYDLw/hcRdeseMGuNb6JniauaOi9P2IOJhjew0PENNUklCiiyhN3/MiZR00GjiyDMXMgvEMMUvr1xcF4kBL7Neg46DdPtH37aVHSSFHwgQFiRt1pXNA==
Received: from CH2PR14CA0033.namprd14.prod.outlook.com (2603:10b6:610:56::13)
 by DM3PR12MB9288.namprd12.prod.outlook.com (2603:10b6:0:4a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 13:39:19 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::f2) by CH2PR14CA0033.outlook.office365.com
 (2603:10b6:610:56::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Mon,
 29 Sep 2025 13:39:19 +0000
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
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 13:39:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Mon, 29 Sep
 2025 06:39:04 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Sep
 2025 06:39:00 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: [PATCH v4 02/27] backends/iommufd: Introduce iommufd_vdev_alloc
Date: Mon, 29 Sep 2025 14:36:18 +0100
Message-ID: <20250929133643.38961-3-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|DM3PR12MB9288:EE_
X-MS-Office365-Filtering-Correlation-Id: 800a16bc-8215-4508-0632-08ddff5d9742
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oJCgKsAYRKYMhqMUncPenyCh5qGktc23U6dn1BvZXD25tvoe2JBdRRwXq10p?=
 =?us-ascii?Q?hnE+mMJvJu2Od5/qQPoGhVSASviq1jAL2Ekh5xuMDlYD90uCWnnFQm746Nbr?=
 =?us-ascii?Q?dqY1nPLJ1kUtbrLeXU5oDy3R4GQkO1BUd57aCb5XzYzYiPl9KugJWTUMeYGd?=
 =?us-ascii?Q?jX0K/agqPWsGyxSNxs+5Q/QRTLheS+tXSzWNiQUHia+kD5VacIHEkmVIAGxH?=
 =?us-ascii?Q?bvC2FoHomasmvGsqdCwMeHdKkzyZT11tn3rWg7tG72SoP5/tvsPFfvRNsBNF?=
 =?us-ascii?Q?8uZ5MmPOGX0RQRtpBgqiJW11LNF467zJirB0myBnUepEN5aboXFs5Y+4iTSq?=
 =?us-ascii?Q?4x4PBjkCo3uYqbuZiULM5EWbsCKzTQwHO2MCong3jnidLNYZd8KFeGl0bSNF?=
 =?us-ascii?Q?NNEn2y9yyYzzJwxCL8FYnTT0Y7Px6xRcKEMUvB/TO1Nh+ZYL5y46CrYV1qg3?=
 =?us-ascii?Q?TkP7HWlhTaA3NhqEiPM7eXzfWsVgnoOyvehRT9it4c/aUHRvArLYmp3GN85c?=
 =?us-ascii?Q?ZRERqSbR86y7PHmh5RQQPZbm67H8ndmWEQV39K8d1OMJxgNVPaZSxQPQsbXi?=
 =?us-ascii?Q?Su+mhCrXuS29Yfd2vq2CF4JcnTYM4fQbqfySlXFqRCzVbXILzV4sjDs2SFyV?=
 =?us-ascii?Q?2u096H+R+Xf9VGNAWQwElu5UvrnLr2WUOX0m/9FPXXbbff4ZHkbRlrMjuu4Y?=
 =?us-ascii?Q?YzqGHyWrjTGjrt4/0n/hQodFSEciW//f0xZwmZsLMvJmUmiQ64FoWl6D/doU?=
 =?us-ascii?Q?OUTr6w2/ehr68/3auCcOcEZA7H1WqP+WR+pek9ghNJMsLdfLd0C10Iw3H7Vo?=
 =?us-ascii?Q?mnUcQN3s59a/tLI8X74+7oJs+TmFKGhwDQLvC+AICuk+1q8TKlMuwSkcOQ0k?=
 =?us-ascii?Q?ZFNHsWvtDfH6+FKhx/Yo4bVNMkR45oi24tUFyKe4BIyNdr1sP8heP8evYiiG?=
 =?us-ascii?Q?seUB05egxQqXyd4Pij48rCbEY58ZHn11qH+fyO0MYgfynOUSg3zFVAtCVGF0?=
 =?us-ascii?Q?9rKoeu1dx/hSWrOnh1kA2HxZcQ0suxjpShv+37n+hyTr+FUrjCgngrVexTmf?=
 =?us-ascii?Q?UvIflMYRVTvpM/HnbND014aPk18mbmJhvLL+lBQ9H7WuYGtaans0p/lMxVfb?=
 =?us-ascii?Q?GRC9TjOp0Ss8D9gx5xoDAoejHVOaB8Mu5blXhOeT5Vye2WM7SrsvBZ24phOr?=
 =?us-ascii?Q?R1e61xzkg7EeScp5o2fbrr+bgRmVL+bJPcxUW5b4HDgY73gI/csd6IVE6r69?=
 =?us-ascii?Q?+IzTMK8q2hDTPdNTURgH2EqNFhMYPZlqhpC+NNg/7sBoO9mX2hYfMs2M7PzH?=
 =?us-ascii?Q?nfqPW0IH4Dq7NVc2SuQO1EHYB4sEv6FPKoSLqbpiTI0yvDulDzf3ODgSXOZU?=
 =?us-ascii?Q?FgYTnc/HbFcZnaDlecNqT8J8AO98mjQwOco7YiIcRcrPIt//JjWee7QXQeXV?=
 =?us-ascii?Q?EPC3+sFmPwPVB7ceSQT9dNT0000lgR7KtYajNWZSQlckfTCr1x6E7zR0RlQx?=
 =?us-ascii?Q?8A2PXs0gFKSogHq4FhH6MC4ugpOC+q6Uem+c8Xrquvb/oZTpnT0/D+ulYu8k?=
 =?us-ascii?Q?PCTRUofnrjeWYxl4iew=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 13:39:18.9736 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 800a16bc-8215-4508-0632-08ddff5d9742
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9288
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
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

From: Nicolin Chen <nicolinc@nvidia.com>

Add a helper to allocate an iommufd device's virtual device (in the user
space) per a viommu instance.

While at it, introduce a struct IOMMUFDVdev for later use by vendor
IOMMU implementations.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 backends/iommufd.c       | 27 +++++++++++++++++++++++++++
 backends/trace-events    |  1 +
 include/system/iommufd.h | 12 ++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 7b2e5ace2d..d3029d4658 100644
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
index dfe1dc2850..e852193f35 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -48,6 +48,14 @@ typedef struct IOMMUFDViommu {
     uint32_t viommu_id;  /* virtual IOMMU ID of allocated object */
 } IOMMUFDViommu;
 
+/*
+ * Virtual device object for a physical device bind to a vIOMMU.
+ */
+typedef struct IOMMUFDVdev {
+    uint32_t vdev_id; /*  Virtual device ID */
+    uint32_t dev_id;  /*  Physical device ID */
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


