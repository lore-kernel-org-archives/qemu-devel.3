Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA358EE20A8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 14:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voN9q-0000RU-GR; Fri, 06 Feb 2026 09:50:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voN9V-0000Pc-3Y; Fri, 06 Feb 2026 09:49:45 -0500
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voN9Q-0006xe-Ua; Fri, 06 Feb 2026 09:49:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FCRZ2AyBbaLhBFjI38xPXx5cDfvteIEeQgkbl75UHaHVY1c0z2k0R8u+H8Y1mM1gnKVaRxHkD71Ko3OyIc233NhTQg/QsWQXz1Zs8O1cyDPsgJl1QNQ9TNUzHcPGRCeozPXNYmcluVvSFCo2jH7sbC13NKkX0PyDFluOI51ZNml0tKfOpR0FmQMGLcB8gvivCsBpGHoPdtWAolqrNi+pX5mCyXFZliIn0COo1GQAsUpzs4emYxr9RpoFiDE7xaIjsKFP5CA/0QYsFvw28TpXU/ZtIZZjjzQIytozqhP02m5Ij0U/0a1V+vpcLvQ66uN6878UtIv7ZSLXlqEaoRcumQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWmQAhMAtEofl3zi13rS0Zyt/M7zrWlHjUzlaFWK1Qc=;
 b=HtjVED8qkLRfkJiYGmUnPAk/PGncVcGj0UPuIQmTO2rJ/KlOgFMmtcH/R3quGw2NgCDoAIL75bXcDAU8y8/FdLvFd6Zig1QOl9KnCo0LX195cJ+wBMDI4vEa2g1PGtQ28tqf6vytmAVeRtjv2LvNqwByxFLrxp5lKTfau71DR7d4J6reD1QIH9A2o/X6CyIAUddhOke308gqATpOl4oOZoiUw6lB9ONXnKp9ce9QtgmDXzP5qK+y0E02NAGlQA0pBiQL+CP75ST6PqZiUevanRjhn6x9DzuQQppIsElztZP1La/GhT+UOTKzQceT1xL/zj3iDx4xslzY5BSkRKUlAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWmQAhMAtEofl3zi13rS0Zyt/M7zrWlHjUzlaFWK1Qc=;
 b=V7l+JAH6BUi+cX2nPAnXhZSXR6Jt5wgfimofJJQJfI3qc14lmxAthEEOiTmjE0R9if6sT0iCDOZAFGOjczFja4vzOqWFWWr0VjKKnJ63QPdxl6KB+gUeYs62XC9IqDe4GVR5vPKF09G1QipE52ULf90NXo8Exf5mUb1VNBZPvRlp2dNwiddmFAmTL2Dj0sCPsjPSW4mlqC+BcNxXwrVmIdJZnHfN5ScPNzkEd0MJWMVO9vjhqCkWfS0QB+f/5NebM1tMxFbj5qeQHZ9cHmuNRPW8mIGvdT0nEd4gnzgLj12wVPqjK3UlnHGSNlftrl7E/fMU70g9uYniJDXL2FjAcg==
Received: from BY3PR04CA0028.namprd04.prod.outlook.com (2603:10b6:a03:217::33)
 by DM4PR12MB9735.namprd12.prod.outlook.com (2603:10b6:8:225::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 14:49:34 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::68) by BY3PR04CA0028.outlook.office365.com
 (2603:10b6:a03:217::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Fri,
 6 Feb 2026 14:49:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:49:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:49:12 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:49:08 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v2 02/24] backends/iommufd: Update
 iommufd_backend_alloc_viommu to allow user ptr
Date: Fri, 6 Feb 2026 14:48:01 +0000
Message-ID: <20260206144823.80655-3-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206144823.80655-1-skolothumtho@nvidia.com>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|DM4PR12MB9735:EE_
X-MS-Office365-Filtering-Correlation-Id: fe25336a-5e8f-4a89-12a2-08de658ef070
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QJ5G23EQ57p4mkz4O3IyQ+gxZxWTaT+t1O5yxfKTgtHZva1jJ+IZysi8OmcZ?=
 =?us-ascii?Q?uknmlD9+7cJ8hzbJWGB870P2F11z/IAHLDrdsaXj5AdXbKZigZeP85Vhx5Hr?=
 =?us-ascii?Q?F05K/0AV326JHGgirOBHUfOKbTsXeskI8wmqHOMXWcvS7N+AN1EM+DkPsdTq?=
 =?us-ascii?Q?Q8aFfKeDt899yxsUKm9BFd2/d5OSDuRuEqSkSO/kzhjDOSjIJeDPD/7NF/Hl?=
 =?us-ascii?Q?yoZwhF/Kj/CePiYUNEAwkNluFxn0tV+KtCj3hjxlCSWqn2QUapglUBf2U7zd?=
 =?us-ascii?Q?Er7NiMuD15vz3Owkkrz9+1UXDwD4g+u7Lvh58iyq8VgjJfeWqlDwyMbF3mb/?=
 =?us-ascii?Q?Tj2HPPbzfKYkZK4B6qcXuakmDAkkc3b3QDWHndvhdCHDzyZZwgW9EX5SzzLI?=
 =?us-ascii?Q?eh0BBB8LMPcF4pGTHSR6qy0pir1BKKMBRk4ZLTt2GFc/Vj4Hxs7dWo9hzQbn?=
 =?us-ascii?Q?0qf0tr4e+oRpJUC5ZJZ22U3nm7WrBzB2NNBdvSDvs4vVIDGu5E5Q4160l9lH?=
 =?us-ascii?Q?bzWU8WbPtJ/UEZa5LSnV6Vo/smE/Inttb8Fms8DybSZeupHcNAwJvkDGoHTa?=
 =?us-ascii?Q?dG4MRg39RxOPJnDwQXza0j4SUe39rV7baDPeNmyD4tfLjD24gUHaKB0CVna+?=
 =?us-ascii?Q?GjKJ/xEkqiIWPgL9rIr5HRxhDszyiWUWgYv+ABRrMa40lQj197NcbZ+1pbhu?=
 =?us-ascii?Q?rf3gPhIsAGEWX94QezxuxdPnKWEDASeVnKz9GksaJnbSkQazas6xBYjJY480?=
 =?us-ascii?Q?i6dSf4cnv7ZNO9nV3RjOWY9TiLwTj6FLeA2/PSXnrT2zeoDE5iN4x9Il+9Og?=
 =?us-ascii?Q?2+SPFfTVDaBatNEtUGnY6AXeV8Uc5MDm1sOi0QLYowQkNXL0SMJkVM/5UAH8?=
 =?us-ascii?Q?pC/pfQUSgbVtMmzTedxrlreBni+OgQp335f4hNOHfludyar80J/K1yMrd0vv?=
 =?us-ascii?Q?W72+1dCgJpaPbu+OmKrSSDYodH1O6J4XgU9CeJwYrxO+TRvsXZZaloZaikJz?=
 =?us-ascii?Q?p0sagIWSrK/0N7smH6DbHJ3W/llbVtFgbnghCvB4lpzDXmfozjFN0t/Beb6p?=
 =?us-ascii?Q?zAN2HkpZQ/CUrcHnYfmlHbsX2slqCf8m4mQob9VUrHVyHu/gBuCAtWO6P+eR?=
 =?us-ascii?Q?5ykZG3cS9DpNULLarbqYqndoAMk0nrpMtBNotKUHB9cSphnfaW/M3zml2DZI?=
 =?us-ascii?Q?CvjIJ6NS5cTBvbEF6MA3fiRFKJmnLzv2A8jhZhYOvaRUT/BSHGLf7TjgrULz?=
 =?us-ascii?Q?MS7fT38P7Lpz7pzQfzswb9VemswzFCRPlYfTTLWwVeGsGRuPUwVm/Dqc1N+g?=
 =?us-ascii?Q?OuVlno8su9WVLAUw071yRqmBuabpTQIlW4SAHyUhv+2/+yK5dikgZ/aQwOX9?=
 =?us-ascii?Q?kFnRBd0/wwNgXW/fxoJaWQVbQgrahV2kLVdL4ms2Ax8KV8NSXBi/oIuDo26x?=
 =?us-ascii?Q?NhWeHX5uY42XVZdq02K5ilOHGph9SXketAVWxcF9S48Kv2A01yEjLz+W1DA+?=
 =?us-ascii?Q?rUX2DYenhTOtYEGqM8Ijm70JbBYASThpPTTsw77X24Fz3VOKrdbqus64Z8W9?=
 =?us-ascii?Q?sHzYX0CaQRpOtfHE3h+oYembPb+Cuya96pU4tgrC9DTMcxdy4KcqRttgkRkV?=
 =?us-ascii?Q?tf38DYAByVK7lFoHsdgyYRfXrHz9OQ9qKbgeIDZp4wG9H+HYMD28QKLQf1NE?=
 =?us-ascii?Q?UXfx8A=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /kqT6csXL5P70ohAEPOv5u3Ucvr328uyee1n1EPFxZOjtGplb6yOM+Eme1haIhCjOULwoBoMx7B5iTYaaEapRih5nVi6LA1mkjiputuHZ2RF51XmEXH2PnzMKoGATPWhYYUtfY02oNMfqCdIgjunwDs2cWZJis3xDs0KdP1dClf2PGazPkWgdqgzbayjBMaK4EpJy+p8iDZ1c1Ae8QKPgw6pFkJMN2O7buE1Xz/03e7tDCwY3Lolf2dhmYFTiZgVkwM7gHt8oUhhsdp0Ihdn3OSK9JBHr1fGDxw34uzDnlxzAM8nFOBaqSYMZQgmU3qepJNzAk+UYJi44bNi/c52bFIdBemMHjslCjDyRHCP2BH2Q/6XHgCBmW8embnBMJUnTweF2p+5BBhEaXcWPOA9+TSr3mINX+vOes+VQ7kaUiJi16/sK5ic93kCfnRHezaB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:49:32.5382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe25336a-5e8f-4a89-12a2-08de658ef070
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9735
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The updated IOMMUFD VIOMMU_ALLOC uAPI allows userspace to provide a data
buffer when creating a vIOMMU (e.g. for Tegra241 CMDQV). Extend
iommufd_backend_alloc_viommu() to pass a user pointer and size to the
kernel.

Update the caller accordingly.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 backends/iommufd.c       | 4 ++++
 backends/trace-events    | 2 +-
 hw/arm/smmuv3-accel.c    | 4 ++--
 include/system/iommufd.h | 1 +
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 5daefe505e..8ab26eb786 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -460,6 +460,7 @@ bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
 
 bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
                                   uint32_t viommu_type, uint32_t hwpt_id,
+                                  void *data_ptr, uint32_t data_len,
                                   uint32_t *out_viommu_id, Error **errp)
 {
     int ret;
@@ -468,11 +469,14 @@ bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
         .type = viommu_type,
         .dev_id = dev_id,
         .hwpt_id = hwpt_id,
+        .data_len = data_len,
+        .data_uptr = (uintptr_t)data_ptr,
     };
 
     ret = ioctl(be->fd, IOMMU_VIOMMU_ALLOC, &alloc_viommu);
 
     trace_iommufd_backend_alloc_viommu(be->fd, dev_id, viommu_type, hwpt_id,
+                                       data_len, (uintptr_t)data_ptr,
                                        alloc_viommu.out_viommu_id, ret);
     if (ret) {
         error_setg_errno(errp, errno, "IOMMU_VIOMMU_ALLOC failed");
diff --git a/backends/trace-events b/backends/trace-events
index b9365113e7..332888a576 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -21,7 +21,7 @@ iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%
 iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"
 iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t flags, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" flags=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
 iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint64_t data_ptr, int ret) " iommufd=%d id=%u data_type=%u entry_len=%u entry_num=%u done_num=%u data_ptr=0x%"PRIx64" (%d)"
-iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32_t hwpt_id, uint32_t viommu_id, int ret) " iommufd=%d type=%u dev_id=%u hwpt_id=%u viommu_id=%u (%d)"
+iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32_t hwpt_id, uint32_t data_len, uint64_t data_ptr, uint32_t viommu_id, int ret) " iommufd=%d type=%u dev_id=%u hwpt_id=%u data_len=%u data_ptr=0x%"PRIx64" viommu_id=%u (%d)"
 iommufd_backend_alloc_vdev(int iommufd, uint32_t dev_id, uint32_t viommu_id, uint64_t virt_id, uint32_t vdev_id, int ret) " iommufd=%d dev_id=%u viommu_id=%u virt_id=0x%"PRIx64" vdev_id=%u (%d)"
 iommufd_viommu_alloc_eventq(int iommufd, uint32_t viommu_id, uint32_t type, uint32_t veventq_id, uint32_t veventq_fd, int ret) " iommufd=%d viommu_id=%u type=%u veventq_id=%u veventq_fd=%u (%d)"
 
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 14ea4eac37..9036b14601 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -531,8 +531,8 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
     IOMMUFDViommu *viommu;
 
     if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
-                                      IOMMU_VIOMMU_TYPE_ARM_SMMUV3,
-                                      s2_hwpt_id, &viommu_id, errp)) {
+                                      IOMMU_VIOMMU_TYPE_ARM_SMMUV3, s2_hwpt_id,
+                                      NULL, 0, &viommu_id, errp)) {
         return false;
     }
 
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index e4ca16da70..5ef23ad9e1 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -87,6 +87,7 @@ bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
                                 Error **errp);
 bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
                                   uint32_t viommu_type, uint32_t hwpt_id,
+                                  void *data_ptr, uint32_t data_len,
                                   uint32_t *out_hwpt, Error **errp);
 
 bool iommufd_backend_alloc_vdev(IOMMUFDBackend *be, uint32_t dev_id,
-- 
2.43.0


