Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B800ECD8CAA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWudQ-0008Vg-Li; Tue, 09 Jun 2026 07:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWud8-000798-V5; Tue, 09 Jun 2026 07:28:27 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWud5-00035h-SU; Tue, 09 Jun 2026 07:28:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dFSZYJRGS+pUYJAnJl1jEMRf5NK815vRs9qTRbLtKAFdyUhNNWcrmnC2x8W7kYKervaPP1MsCNrCcjiuwwg60DsOeFJ++snooBXTgmNZnzZtQ2COFFun7N8J6al6yF3ZL+i5mlQEKD/uO9nCJzKOslBghJfudm1ajEvEIVIFhl176HfKqF4Tk9W2t2SNtLBMAfGmNoZVOoKODs58/7Mq9yWDWOCpE5V8qkxwurz/qasYdzJSwlwUfdA+dA1D/qzYujeCscs2lCQ+Y2PZEgvuA3H7IPsvQKKXs7IfMBEC9RMBe3PvG2a/hSypwb9/e+TLjxdyqDKBeCY8QuRn6sMXcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLj5kjilCJgNwoU6RYUcQwgSEKuTmIcUKfvk/FCFtmo=;
 b=U/Q3fdGre9QLH8zcgZAFSmByFa6se9BN4QCYUlKpOwUfdvpg2t8mQrLa1cbxuZatZ0QlwC1nbdDnZs5eDOoMl7YLkTTHgOp+eDnfS5WlCnOYMtbLSebvJEXN758AI97JGXJVmpYmFy0QapsuTEHoNJTvpXUrTvxbzzU8ZsQpLnfgKECpW9XhAgEzQuPBM1lqTka7c4wXClulAmvE3X3DW0BtelHVU5+BEYxnqcYEmkxA6XuoEW/kzlX0XwctaIFZ44mrcQVs5U6e6nD17jis70hRV2BUtxWgJnW76Ysbs/7UAl4Or1SDjmCdR8zRijj546bHcisDdMrrulMYwzRHTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLj5kjilCJgNwoU6RYUcQwgSEKuTmIcUKfvk/FCFtmo=;
 b=AaZZ+Qe03FbVNmWPZgltZqnRQPN67l8lOKBnkQR1eDUh+8b7tNjlji+Zs9G/x1KMNuno1Qi7gUtXjCAKKsqubFIV1XChVYXBcR5MI9KtnhJ37VNNEGKtGPCrYj++SFGdJXsIAeHQ20ZhH1El5x47psTa/LWbvxYRZHNntVkQByg+KAujbnYbIo4OSwiONyM1/egXdbn2NKDpYZx3Y6z+Jr9zjjRatgMkSHQcz8dAXNI2zKxYc0gJxjICJ6LLb+yr7egTqvQ/BZZYlYzlV+QiTHeb5J17wd51NvK0Az1XZamqIGSDTkDJldAXHiNg8LQvb3vBXkTUqFvgUkT1Vupxxg==
Received: from BY3PR10CA0009.namprd10.prod.outlook.com (2603:10b6:a03:255::14)
 by BY5PR12MB4162.namprd12.prod.outlook.com (2603:10b6:a03:201::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 11:28:15 +0000
Received: from MWH0EPF000C6188.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::98) by BY3PR10CA0009.outlook.office365.com
 (2603:10b6:a03:255::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 11:28:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C6188.mail.protection.outlook.com (10.167.249.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 11:28:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:27:55 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:27:52 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v7 18/31] hw/arm/tegra241-cmdqv: Allocate HW VCMDQs once
 configured
Date: Tue, 9 Jun 2026 12:25:39 +0100
Message-ID: <20260609112552.378999-19-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609112552.378999-1-skolothumtho@nvidia.com>
References: <20260609112552.378999-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6188:EE_|BY5PR12MB4162:EE_
X-MS-Office365-Filtering-Correlation-Id: bca8fdb0-f6d4-4086-01f3-08dec61a3299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|22082099003|3023799007|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: pa5Eryz8Vq+QQHrwAmnIPG1iCGc916XMU/4MoKwgYyNcEoLro4pa3dGRHeRiTHF33p49rxVGbwCe9+uEkKOQIOvUSKaZgjfB190NfS6CpRHlzbSLJFEG7j3B3p2xK9M4Ufs3hGKVhgYcmLiPzElNx4Uk5oR38Bpm+uoBNEWG+QEtSQzr7yJw++xdX6ev0uCIJK9cby8CqO1zZUFlTT8tZ7c7BA8Y24OP80hEaZ9Kkh7ySzIdPdbW/uCBcIHpLkXV9mCbTo/vIXfFR5tBR85FBuK5wNz8msDpp8SxI4qN68iwqFWLZVHhArTELqFm3rVxZ6aOrZWzLfGd4pcbShw41LSmT35huuUWpuH4I3NBs2P5aPSUuJsI2icjsp2GEEc93INdPo0l++1jfD0jo+eQi+DUTDDGerNNg1eukF6enL4flFes/oLRde99pCzNMQe2O1nKFS5n8UR7bTQtLelObu/Wz+9Pl+DN04XkvLrZ/JbzKBmgD7JHnLDH0xHm735wfxfocRW0JTTWHXZFw4yvECHHtMRa2N/NBhQvDYQ+1c8DCwUI1vXBDowwOhRSsLeeuEMrq/OkSpLlrJ97jB/YLGXD+16AkMunALtpGkC92ddazxXx5eFKcvPieKOLG2EQGOIxYNPeA1BXHRkUqG7qTenUJgZ5J3eQL1rOVMODmdtupq4YsjrjNZ3Hd1EJ/PJtJQVq+QUqM8Ww8hI4AfOyKqdsQ59hY0mVp51koIieO0Q=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kOwaFplcxTxncfV11PCoVDAK0ziYQzHCCduxBVYG4EougcH/7O6LMi65HeojP1YS1K69soXbJSjtuoZmxtZPG/Uqe120l5vxOOJbaqZPPb04VZSZQ28ui+O84RxWoIAnDG5Vzkqrnf9LkSnWRjHed2LccgVVgHWCyOI0g8tlqZYs7KQZPMAuK7nxPaioIe2GsBuMmUN0A+MlfzVOG1oTTuI621nRnui8ynjt3RfYAMhobYIHx8IQmSYKpsTkU+WrF15rwktPBB8nPh6w0Ur+xS2XebYsaWqo06GUf6KfS0NUslUwrAbVcer+/i96U1eS3AfS5OzVQtWQnJCYUJfdiWPXs8+5EbZr072dzqnz+XvyZnKflmVM6MsMTXjV4/+ivU2tcSAHC0mrSgbfyXe18lvj2Spk7ZahUydneqytlGG934CdQHmESlm1TYjRpijp
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 11:28:15.2129 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bca8fdb0-f6d4-4086-01f3-08dec61a3299
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6188.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4162
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Add support for allocating IOMMUFD hardware queues when the guest
programs the VCMDQ BASE registers.

VCMDQ_EN lives in VCMDQ_CONFIG, which is on the VINTF Page0 region
that a later patch installs into guest MMIO — so QEMU won't trap its
writes. Allocate the hardware queue instead once all of these are
set: BASE programmed, CMDQ_ALLOC_MAP.ALLOC, and CMDQV / VINTF
enabled. Each precondition write retries the allocation, so the
guest may program them in any order.

iommufd_backend_alloc_hw_queue() needs the guest physical address of
the VCMDQ ring buffer, so allocation is deferred until the guest has
populated BASE.

If a hardware queue was previously allocated for the same VCMDQ,
free it before reallocation. All allocated VCMDQs are freed when
CMDQV or VINTF is disabled, when the ALLOC bit is cleared, or on reset.

On allocation failure, set CMDQ_INIT_ERR and clear CMDQ_EN_OK in the
cache so trapped guest reads see the failure rather than a queue
that looks live. Clear them on a later successful allocation. A guest
CMDQ_EN write then sets CMDQ_EN_OK only if CMDQ_INIT_ERR is clear.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.h |  11 +++
 hw/arm/tegra241-cmdqv.c | 171 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 171 insertions(+), 11 deletions(-)

diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index c4d327a9a5..84499b840d 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -47,6 +47,7 @@ typedef struct Tegra241CMDQV {
     MemoryRegion mmio_cmdqv;
     qemu_irq irq;
     IOMMUFDVeventq *veventq;
+    IOMMUFDHWqueue *vcmdq[TEGRA241_CMDQV_MAX_CMDQ];
     void *vintf_page0;
 
     /* CMDQ-V Config page register cache */
@@ -364,6 +365,16 @@ SMMU_CMDQV_VI_VCMDQi_BASE_H_(1)
 SMMU_CMDQV_VI_VCMDQi_CONS_INDX_BASE_DRAM_L_(1)
 SMMU_CMDQV_VI_VCMDQi_CONS_INDX_BASE_DRAM_H_(1)
 
+static inline bool tegra241_cmdqv_enabled(Tegra241CMDQV *cmdqv)
+{
+    return cmdqv->status & R_STATUS_CMDQV_ENABLED_MASK;
+}
+
+static inline bool tegra241_vintf_enabled(Tegra241CMDQV *cmdqv)
+{
+    return cmdqv->vintf_status & R_VINTF0_STATUS_ENABLE_OK_MASK;
+}
+
 const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void);
 
 #endif /* HW_ARM_TEGRA241_CMDQV_H */
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 1f3d883cfe..8cb39e87c4 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -16,6 +16,96 @@
 #include "tegra241-cmdqv.h"
 #include "trace.h"
 
+static void tegra241_cmdqv_free_vcmdq(Tegra241CMDQV *cmdqv, int index)
+{
+    IOMMUFDViommu *viommu = cmdqv->s_accel->viommu;
+    IOMMUFDHWqueue *vcmdq = cmdqv->vcmdq[index];
+
+    if (!vcmdq) {
+        return;
+    }
+    iommufd_backend_free_id(viommu->iommufd, vcmdq->hw_queue_id);
+    g_free(vcmdq);
+    cmdqv->vcmdq[index] = NULL;
+}
+
+/*
+ * A VCMDQ's HW queue can be allocated once the guest has programmed:
+ *  - VCMDQ_BASE (ring buffer GPA and size). This only checks that BASE is
+ *    non-zero, not that both the _L and _H halves have been written; a
+ *    half-written BASE may pass here, but the write of the second half
+ *    re-runs setup and reallocates with the complete address.
+ *  - the VINTF mapping (CMDQ_ALLOC_MAP.ALLOC).
+ *  - both the CMDQV global enable and the VINTF enable.
+ */
+static bool tegra241_cmdqv_vcmdq_ready_to_alloc(Tegra241CMDQV *cmdqv, int index)
+{
+    return cmdqv->vcmdq_base[index] &&
+           (cmdqv->cmdq_alloc_map[index] & R_CMDQ_ALLOC_MAP_0_ALLOC_MASK) &&
+           tegra241_cmdqv_enabled(cmdqv) && tegra241_vintf_enabled(cmdqv);
+}
+
+/*
+ * Allocate a host HW VCMDQ from the current cached BASE / size for @index.
+ * No-op (returns true) until the VCMDQ is ready to be allocated.
+ */
+static bool tegra241_cmdqv_setup_vcmdq(Tegra241CMDQV *cmdqv, int index,
+                                       Error **errp)
+{
+    SMMUv3AccelState *accel = cmdqv->s_accel;
+    uint64_t base_mask = (uint64_t)R_VCMDQ0_BASE_L_ADDR_MASK |
+                         (uint64_t)R_VCMDQ0_BASE_H_ADDR_MASK << 32;
+    uint64_t addr = cmdqv->vcmdq_base[index] & base_mask;
+    uint64_t log2 = cmdqv->vcmdq_base[index] & R_VCMDQ0_BASE_L_LOG2SIZE_MASK;
+    uint64_t size = 1ULL << (log2 + 4);
+    IOMMUFDViommu *viommu = accel->viommu;
+    IOMMUFDHWqueue *hw_queue;
+    uint32_t hw_queue_id;
+
+    if (!tegra241_cmdqv_vcmdq_ready_to_alloc(cmdqv, index)) {
+        return true;
+    }
+
+    tegra241_cmdqv_free_vcmdq(cmdqv, index);
+
+    if (!iommufd_backend_alloc_hw_queue(viommu->iommufd, viommu->viommu_id,
+                                        IOMMU_HW_QUEUE_TYPE_TEGRA241_CMDQV,
+                                        index, addr, size, &hw_queue_id,
+                                        errp)) {
+        /* Record the failure in the cache. */
+        cmdqv->vcmdq_gerror[index] |= R_VCMDQ0_GERROR_CMDQ_INIT_ERR_MASK;
+        cmdqv->vcmdq_status[index] &= ~R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
+        return false;
+    }
+    hw_queue = g_new(IOMMUFDHWqueue, 1);
+    hw_queue->hw_queue_id = hw_queue_id;
+    hw_queue->viommu = viommu;
+    cmdqv->vcmdq[index] = hw_queue;
+
+    cmdqv->vcmdq_gerror[index] &= ~R_VCMDQ0_GERROR_CMDQ_INIT_ERR_MASK;
+    cmdqv->vcmdq_status[index] |= R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
+
+    return true;
+}
+
+static void tegra241_cmdqv_free_all_vcmdq(Tegra241CMDQV *cmdqv)
+{
+    /* uapi/linux/iommufd.h: hw_queue destroy must be in descending @index. */
+    for (int i = (TEGRA241_CMDQV_MAX_CMDQ - 1); i >= 0; i--) {
+        tegra241_cmdqv_free_vcmdq(cmdqv, i);
+    }
+}
+
+static void tegra241_cmdqv_setup_all_vcmdq(Tegra241CMDQV *cmdqv,
+                                           Error **errp)
+{
+    for (int i = 0; i < TEGRA241_CMDQV_MAX_CMDQ; i++) {
+        if (!tegra241_cmdqv_setup_vcmdq(cmdqv, i, errp)) {
+            return;
+        }
+    }
+}
+
 /*
  * Read a VCMDQ Page 0 register (control/status) using VCMDQ0_* offsets.
  *
@@ -143,7 +233,12 @@ static void tegra241_cmdqv_write_vcmdq_page0(Tegra241CMDQV *cmdqv,
         break;
     case A_VCMDQ0_CONFIG:
         if (value & R_VCMDQ0_CONFIG_CMDQ_EN_MASK) {
-            cmdqv->vcmdq_status[index] |= R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
+            /* Report init error if any. */
+            if (!(cmdqv->vcmdq_gerror[index] &
+                  R_VCMDQ0_GERROR_CMDQ_INIT_ERR_MASK)) {
+                cmdqv->vcmdq_status[index] |=
+                    R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
+            }
         } else {
             cmdqv->vcmdq_status[index] &= ~R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
         }
@@ -167,16 +262,19 @@ static void tegra241_cmdqv_write_vcmdq_page0(Tegra241CMDQV *cmdqv,
  */
 static void tegra241_cmdqv_write_vcmdq_page1(Tegra241CMDQV *cmdqv,
                                              hwaddr offset0, int index,
-                                             uint32_t value, bool direct)
+                                             uint32_t value, bool direct,
+                                             Error **errp)
 {
     switch (offset0) {
     case A_VCMDQ0_BASE_L:
         cmdqv->vcmdq_base[index] =
             deposit64(cmdqv->vcmdq_base[index], 0, 32, value);
+        tegra241_cmdqv_setup_vcmdq(cmdqv, index, errp);
         break;
     case A_VCMDQ0_BASE_H:
         cmdqv->vcmdq_base[index] =
             deposit64(cmdqv->vcmdq_base[index], 32, 32, value);
+        tegra241_cmdqv_setup_vcmdq(cmdqv, index, errp);
         break;
     case A_VCMDQ0_CONS_INDX_BASE_DRAM_L:
         cmdqv->vcmdq_cons_indx_base[index] =
@@ -200,11 +298,13 @@ static void tegra241_cmdqv_write_vcmdq_page1(Tegra241CMDQV *cmdqv,
  */
 static void tegra241_cmdqv_write_vcmdq_page1_64(Tegra241CMDQV *cmdqv,
                                                 hwaddr offset0, int index,
-                                                uint64_t value, bool direct)
+                                                uint64_t value, bool direct,
+                                                Error **errp)
 {
     switch (offset0) {
     case A_VCMDQ0_BASE_L:
         cmdqv->vcmdq_base[index] = value;
+        tegra241_cmdqv_setup_vcmdq(cmdqv, index, errp);
         break;
     case A_VCMDQ0_CONS_INDX_BASE_DRAM_L:
         cmdqv->vcmdq_cons_indx_base[index] = value;
@@ -219,7 +319,8 @@ static void tegra241_cmdqv_write_vcmdq_page1_64(Tegra241CMDQV *cmdqv,
 }
 
 static void tegra241_cmdqv_config_vintf_write(Tegra241CMDQV *cmdqv,
-                                              hwaddr offset, uint64_t value)
+                                              hwaddr offset, uint64_t value,
+                                              Error **errp)
 {
     int i;
 
@@ -235,7 +336,13 @@ static void tegra241_cmdqv_config_vintf_write(Tegra241CMDQV *cmdqv,
         cmdqv->vintf_config = value;
         if (value & R_VINTF0_CONFIG_ENABLE_MASK) {
             cmdqv->vintf_status |= R_VINTF0_STATUS_ENABLE_OK_MASK;
+            /*
+             * VCMDQs whose BASE was programmed before VINTF was
+             * enabled need their hw_queue allocated now.
+             */
+            tegra241_cmdqv_setup_all_vcmdq(cmdqv, errp);
         } else {
+            tegra241_cmdqv_free_all_vcmdq(cmdqv);
             cmdqv->vintf_status &= ~R_VINTF0_STATUS_ENABLE_OK_MASK;
         }
         break;
@@ -341,6 +448,7 @@ out:
 static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
                                        uint32_t value)
 {
+    Error *local_err = NULL;
     int index;
 
     switch (offset) {
@@ -348,18 +456,39 @@ static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
         cmdqv->config = value;
         if (value & R_CONFIG_CMDQV_EN_MASK) {
             cmdqv->status |= R_STATUS_CMDQV_ENABLED_MASK;
+            /*
+             * VCMDQs whose BASE was programmed before CMDQV was enabled
+             * need their hw_queue allocated now.
+             */
+            tegra241_cmdqv_setup_all_vcmdq(cmdqv, &local_err);
         } else {
+            tegra241_cmdqv_free_all_vcmdq(cmdqv);
             cmdqv->status &= ~R_STATUS_CMDQV_ENABLED_MASK;
         }
         break;
     case A_VI_INT_MASK_0 ... A_VI_INT_MASK_1:
         cmdqv->vi_int_mask[(offset - A_VI_INT_MASK_0) / 4] = value;
         break;
-    case A_CMDQ_ALLOC_MAP_0 ... A_CMDQ_ALLOC_MAP_1:
-        cmdqv->cmdq_alloc_map[(offset - A_CMDQ_ALLOC_MAP_0) / 4] = value;
+    case A_CMDQ_ALLOC_MAP_0 ... A_CMDQ_ALLOC_MAP_1: {
+        int idx = (offset - A_CMDQ_ALLOC_MAP_0) / 4;
+        bool was_alloc = cmdqv->cmdq_alloc_map[idx] &
+                         R_CMDQ_ALLOC_MAP_0_ALLOC_MASK;
+        bool now_alloc = value & R_CMDQ_ALLOC_MAP_0_ALLOC_MASK;
+
+        cmdqv->cmdq_alloc_map[idx] = value;
+        /*
+         * If the VCMDQ was already programmed (BASE) before mapping, fire
+         * setup on the ALLOC 0->1 transition; tear down on 1->0.
+         */
+        if (!was_alloc && now_alloc) {
+            tegra241_cmdqv_setup_vcmdq(cmdqv, idx, &local_err);
+        } else if (was_alloc && !now_alloc) {
+            tegra241_cmdqv_free_vcmdq(cmdqv, idx);
+        }
         break;
+    }
     case A_VINTF0_CONFIG ... A_VINTF0_LVCMDQ_ERR_MAP_3:
-        tegra241_cmdqv_config_vintf_write(cmdqv, offset, value);
+        tegra241_cmdqv_config_vintf_write(cmdqv, offset, value, &local_err);
         break;
     case A_VI_VCMDQ0_CONS_INDX ... A_VI_VCMDQ1_GERRORN:
         /*
@@ -387,17 +516,23 @@ static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
         offset -= CMDQV_VINTF_PAGE1_BASE - CMDQV_VCMDQ_PAGE1_BASE;
         index = (offset - CMDQV_VCMDQ_PAGE1_BASE) / CMDQV_VCMDQ_STRIDE;
         tegra241_cmdqv_write_vcmdq_page1(cmdqv,
-                offset - index * CMDQV_VCMDQ_STRIDE, index, value, false);
+                offset - index * CMDQV_VCMDQ_STRIDE, index, value, false,
+                &local_err);
         break;
     case A_VCMDQ0_BASE_L ... A_VCMDQ1_CONS_INDX_BASE_DRAM_H:
         index = (offset - CMDQV_VCMDQ_PAGE1_BASE) / CMDQV_VCMDQ_STRIDE;
         tegra241_cmdqv_write_vcmdq_page1(cmdqv,
-                offset - index * CMDQV_VCMDQ_STRIDE, index, value, true);
+                offset - index * CMDQV_VCMDQ_STRIDE, index, value, true,
+                &local_err);
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s unhandled write access at 0x%" PRIx64 "\n",
                       __func__, offset);
     }
+
+    if (local_err) {
+        error_report_err(local_err);
+    }
 }
 
 /*
@@ -407,6 +542,7 @@ static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
 static void tegra241_cmdqv_writell_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
                                         uint64_t value)
 {
+    Error *local_err = NULL;
     int index;
 
     switch (offset) {
@@ -419,18 +555,24 @@ static void tegra241_cmdqv_writell_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
         offset -= CMDQV_VINTF_PAGE1_BASE - CMDQV_VCMDQ_PAGE1_BASE;
         index = (offset - CMDQV_VCMDQ_PAGE1_BASE) / CMDQV_VCMDQ_STRIDE;
         tegra241_cmdqv_write_vcmdq_page1_64(cmdqv,
-                offset - index * CMDQV_VCMDQ_STRIDE, index, value, false);
+                offset - index * CMDQV_VCMDQ_STRIDE, index, value, false,
+                &local_err);
         break;
     case A_VCMDQ0_BASE_L ... A_VCMDQ1_CONS_INDX_BASE_DRAM_H:
         index = (offset - CMDQV_VCMDQ_PAGE1_BASE) / CMDQV_VCMDQ_STRIDE;
         tegra241_cmdqv_write_vcmdq_page1_64(cmdqv,
-                offset - index * CMDQV_VCMDQ_STRIDE, index, value, true);
+                offset - index * CMDQV_VCMDQ_STRIDE, index, value, true,
+                &local_err);
         break;
     default:
         qemu_log_mask(LOG_UNIMP,
                       "%s unhandled 64-bit write at 0x%" PRIx64 " (WI)\n",
                       __func__, offset);
     }
+
+    if (local_err) {
+        error_report_err(local_err);
+    }
 }
 
 static void tegra241_cmdqv_write_mmio(void *opaque, hwaddr offset,
@@ -535,6 +677,13 @@ free_viommu:
 
 static void tegra241_cmdqv_reset(SMMUv3State *s)
 {
+    Tegra241CMDQV *cmdqv = s->s_accel->cmdqv;
+
+    if (!cmdqv) {
+        return;
+    }
+
+    tegra241_cmdqv_free_all_vcmdq(cmdqv);
 }
 
 static const MemoryRegionOps mmio_cmdqv_ops = {
-- 
2.43.0


