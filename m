Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0293CCFA0D
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 15:50:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGflO-0006fS-Hw; Wed, 05 Nov 2025 10:49:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vGflJ-0006ea-IJ; Wed, 05 Nov 2025 10:49:29 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vGflG-0002RX-BB; Wed, 05 Nov 2025 10:49:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qBP56VAW3DJlTv3s7VuOEf1wAMDgdhIN0XJOEDx0NATzRlWI4G7jjv2SWebk8xmrj516WISEBkeyJjDYAxOadPQ2JKfYLocFcQqHf86cRlE5g+XD9gu+wZ+iQ6349sOJC2Ik52OC5HJHSbTYTBIbe6T7hTN8CCJ+0f/AecHLXNNjzx7eWQyC+7khrXhXW5+J/Mw9FqA/K3/FGMXokIXM0nfPI7WNdVaYlxETq2kQUPEKr1+U1MOHTcqqy0eplbCKbpTsqvlfZ3KhClTAyFKktVMKpHSeCpXsaDyzm4OK4FAt0EuKVny44WnHyfenFnvXdHpoUkRo5Es8G0cvErhLnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4GrNg3JkaN0EKoJNisqYoPmBior2Iy2MIflSVR89h0=;
 b=bniz1Jltjj/wUSQQD9u8BY4butDBwcIZwl9by5fgXLEBOoMmikU1fDaMunNylesDjVIXK7cofMRSFn5hZblNBd3mnPbw9NIBw/o9y0i3RefxZ+FfaEWOnnJtkkLwdsHtmOdyz9EZvx4aut/nxGOLojumndCGrlb6GZCaKemyQC7mH9wuYkFFIXAYcb1mK10Jm/ND4SDGVrReuVoCApwRb4f+P3SbWJN3gkFWpmWNXy64Krx2RJnYwHHjvI3Bzu/x1JyjlkuWPZ1LHcDjPTURJ+OIkvW/tWcDIEwEK7ixcyY4gsRuzOGLvDZXpTnEs+gldxVNSejtd3WDcNvL90zhRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4GrNg3JkaN0EKoJNisqYoPmBior2Iy2MIflSVR89h0=;
 b=YXknmzkGR5wv+qg0QF50Jh4Zln+OD7iV7AXVKc7NKjnh5bUO1EJz44I1ywosZXMfAKrP04bkkwZQLnK4bU5cWbMmzwRlVvMVKy6GvtHgWSICGgRvz+mgZOVmsvJaa8ADLFjtQscwT3VJbFZnPSaITuFwlu/aNnnsUuA4KLtvrmgVVVo+Rwio6hss+OIToKpAiya/BzqAlnZEGt/dbdFyYvrN3hPmDNhCDkPYLmIzYeh7l95jRrmn85wI6j4WnBgX88kZL18X8KBozy/5+9XPawch1DIcBsxBZPUIF6PJVgoNsJXGtlsANScMOno0WGlO77+ifv1qmqy/YNsGov7Vzg==
Received: from BYAPR04CA0003.namprd04.prod.outlook.com (2603:10b6:a03:40::16)
 by BN5PR12MB9487.namprd12.prod.outlook.com (2603:10b6:408:2aa::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 15:49:21 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:40:cafe::7c) by BYAPR04CA0003.outlook.office365.com
 (2603:10b6:a03:40::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Wed,
 5 Nov 2025 15:49:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 15:49:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 07:49:03 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 07:49:01 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <jgg@nvidia.com>, <kjaju@nvidia.com>
Subject: [RFC PATCH 1/4] backends/iommufd: Introduce
 iommufd_backend_alloc_veventq
Date: Wed, 5 Nov 2025 15:46:49 +0000
Message-ID: <20251105154657.37386-2-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251105154657.37386-1-skolothumtho@nvidia.com>
References: <20251105154657.37386-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|BN5PR12MB9487:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dc7c509-08af-44c6-85b9-08de1c82e2a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JmraPKGlOMPE7gRWLBRmFC+oI8G1lx7eo4kEGD47i8CfY43qOTMSxgsyEY5s?=
 =?us-ascii?Q?lHpdsewQgdn2JomQfuyvILEYO9TcNjLgFdl1wYNRhryL68ZlzJuLwwnx/R/S?=
 =?us-ascii?Q?63ALTzk8fI9DNklfAcl/dbEGQBNu91/tcYjZuJy2AjrYC7jjypvC757GlUh3?=
 =?us-ascii?Q?kVe8z+FiyU2v2rzkinDDVX+yQWT0SqIvTbOvhWr26hoEx5KKy0mbl8lKsY2L?=
 =?us-ascii?Q?KV/vWb/SroDzuWolNjaI1PmxZa5gSUkcicF7vnoxnUgSLVZcn7xllWX0ERnF?=
 =?us-ascii?Q?9s8PxV+shJLulhwQ5o4KHF2DjRckq6tpPz+PpTUsMvE+if+iQpX3jn/cNuhj?=
 =?us-ascii?Q?+TnoPMe++tRi93P0EgNdPUiJ1KiMdiGtENLSbnTQqKNKj3tI/nPDBT2pXRmb?=
 =?us-ascii?Q?lYw6N0JaaRTWnXkVxgT62ZU2xnvJJhDzmfeNV+3x5rWeggd3WmOquvhcISd7?=
 =?us-ascii?Q?N9vrP0sr9t5q8tGURgYDBWQQF6HxG7lcinsoslwWUEc+fpkLMEvZ/p1XrOff?=
 =?us-ascii?Q?SvnV2LM1sGGyRiFI1m5l52257Zk8JfAOoNFDOpsdkRM9sEzZIa1v+G7rfWED?=
 =?us-ascii?Q?ISgqNJjeOtx2mFAGBK6HT/xWuHcAk5eN1/ziZquEsySqWX/i1ndk09GSEp5K?=
 =?us-ascii?Q?svGhrLi+tvPDo0M0Gvljjc88/M00o/f/BYyjQg3zlQS98FOTqvDc290EMyW6?=
 =?us-ascii?Q?jqJxYZ9c440Cgc5bZDIY7YtwqHDaeUT7ruTYnaxvf/15VrrTiScPrjBn0OpX?=
 =?us-ascii?Q?LUmJcS0iqCM/qOvUUyw/BH0QEauIWvU39e6FvybGn/a0NBwRGrkb62yuYYQv?=
 =?us-ascii?Q?gwx1AIZQB5p1lMLSfRgMXbHkvCh0Fd0ig94k3moyWcLLan7lDKcGJyn+JUtj?=
 =?us-ascii?Q?h7KQ/EyWbwqkQVVjVcVlRoFMvroWL2aaQQq3NuTEU4AeQCZyKk9kd3bPsYBN?=
 =?us-ascii?Q?egxCme2OWEWbsR4MapHrS/L0G7u65FzLBAOp5wSCDupyEt/a07t8vew+4Iu5?=
 =?us-ascii?Q?eRdAu3gVZnzh4mEga8y6civXJF0n9DbF3u1TB5BtvwsDHTRy6RkyX6P+LMAe?=
 =?us-ascii?Q?4/qLOdFCVt2XVDwN6dsSW4BqGnQKbOBYjIH0z+dDDHQ+61h9XtxFg/dk48ro?=
 =?us-ascii?Q?BjvuobhZqUVWAe1ZmD/czkQlKCsYuGRF3sUpgYjMymDFKlVxEMyY07iN+ONJ?=
 =?us-ascii?Q?93e8OtO7hQ3eqY7MTy+ynQrjSDnziPdZovOFnOvzawY6TSx2St8Sz7cicQB5?=
 =?us-ascii?Q?2xzyzr9P1doJ0TryB/q6kHUlIXHB52YWz0KGOVzehpfDZiAZ2uIdqi7JfKLt?=
 =?us-ascii?Q?CsJE5aHe/OLbPhXNXg18GmdNZxm08YcpQmirmmt9kEOJxxBdzODR62AAJacp?=
 =?us-ascii?Q?4zRvA7zw4/2DP1bBm6EFZIWVgt7Vfg2BjGmJQ4Io03w1Ui46yywdVzg10w4b?=
 =?us-ascii?Q?xgPlXzLWT0WZdvS6OFesS4+S65hQ4yMznYZV1JihaZze/ANN9eAk8M1oVoGt?=
 =?us-ascii?Q?ugJ3AIKGD/Sifpyg2XrFo/EJRQV5JoBUtkL80fZYP9J1MGt8kDXohP1TTUbE?=
 =?us-ascii?Q?FvVj0uEIUfFoE0cYnvI=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 15:49:20.6473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc7c509-08af-44c6-85b9-08de1c82e2a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9487
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
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

Add a new helper for IOMMU_VEVENTQ_ALLOC ioctl to allocate a virtual event
queue (vEVENTQ) for a vIOMMU object.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 backends/iommufd.c       | 31 +++++++++++++++++++++++++++++++
 backends/trace-events    |  1 +
 include/system/iommufd.h | 12 ++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 392f9cf2a8..4a6aebdb42 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -503,6 +503,37 @@ bool iommufd_backend_alloc_vdev(IOMMUFDBackend *be, uint32_t dev_id,
     return true;
 }
 
+bool iommufd_backend_alloc_veventq(IOMMUFDBackend *be, uint32_t viommu_id,
+                                   uint32_t type, uint32_t depth,
+                                   uint32_t *out_veventq_id,
+                                   uint32_t *out_veventq_fd, Error **errp)
+{
+    int ret;
+    struct iommu_veventq_alloc alloc_veventq = {
+        .size = sizeof(alloc_veventq),
+        .flags = 0,
+        .type = type,
+        .veventq_depth = depth,
+        .viommu_id = viommu_id,
+    };
+
+    ret = ioctl(be->fd, IOMMU_VEVENTQ_ALLOC, &alloc_veventq);
+
+    trace_iommufd_viommu_alloc_eventq(be->fd, viommu_id, type,
+                                      alloc_veventq.out_veventq_id,
+                                      alloc_veventq.out_veventq_fd, ret);
+    if (ret) {
+        error_setg_errno(errp, errno, "IOMMU_VEVENTQ_ALLOC failed");
+        return false;
+    }
+
+    g_assert(out_veventq_id);
+    g_assert(out_veventq_fd);
+    *out_veventq_id = alloc_veventq.out_veventq_id;
+    *out_veventq_fd = alloc_veventq.out_veventq_fd;
+    return true;
+}
+
 bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
                                            uint32_t hwpt_id, Error **errp)
 {
diff --git a/backends/trace-events b/backends/trace-events
index 8408dc8701..5afa7a40be 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -23,3 +23,4 @@ iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, u
 iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint64_t data_ptr, int ret) " iommufd=%d id=%u data_type=%u entry_len=%u entry_num=%u done_num=%u data_ptr=0x%"PRIx64" (%d)"
 iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32_t hwpt_id, uint32_t viommu_id, int ret) " iommufd=%d type=%u dev_id=%u hwpt_id=%u viommu_id=%u (%d)"
 iommufd_backend_alloc_vdev(int iommufd, uint32_t dev_id, uint32_t viommu_id, uint64_t virt_id, uint32_t vdev_id, int ret) " iommufd=%d dev_id=%u viommu_id=%u virt_id=0x%"PRIx64" vdev_id=%u (%d)"
+iommufd_viommu_alloc_eventq(int iommufd, uint32_t viommu_id, uint32_t type, uint32_t veventq_id, uint32_t veventq_fd, int ret) " iommufd=%d viommu_id=%u type=%u veventq_id=%u veventq_fd=%u (%d)"
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index aa78bf1e1d..9770ff1484 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -56,6 +56,13 @@ typedef struct IOMMUFDVdev {
     uint32_t virt_id;  /* virtual device ID */
 } IOMMUFDVdev;
 
+/* Virtual event queue interface for a vIOMMU */
+typedef struct IOMMUFDVeventq {
+    IOMMUFDViommu *viommu;
+    uint32_t veventq_id;
+    uint32_t veventq_fd;
+} IOMMUFDVeventq;
+
 bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp);
 void iommufd_backend_disconnect(IOMMUFDBackend *be);
 
@@ -86,6 +93,11 @@ bool iommufd_backend_alloc_vdev(IOMMUFDBackend *be, uint32_t dev_id,
                                 uint32_t viommu_id, uint64_t virt_id,
                                 uint32_t *out_vdev_id, Error **errp);
 
+bool iommufd_backend_alloc_veventq(IOMMUFDBackend *be, uint32_t viommu_id,
+                                   uint32_t type, uint32_t depth,
+                                   uint32_t *out_veventq_id,
+                                   uint32_t *out_veventq_fd, Error **errp);
+
 bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
                                         bool start, Error **errp);
 bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
-- 
2.43.0


