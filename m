Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B59E3CD6E56
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:52:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU1Ae-0000mc-6c; Mon, 01 Jun 2026 07:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU19i-0007DS-97; Mon, 01 Jun 2026 07:50:08 -0400
Received: from mail-westus3azon11011064.outbound.protection.outlook.com
 ([40.107.208.64] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU19e-0005Be-SY; Mon, 01 Jun 2026 07:50:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mAmtyQ6Tg6Pz8tra/OCYbpCPIGWdKMV8a65nX6xYKqk7Qv73yY93D+FoUH4lDyZbN56ecV5QAqcSqcdRNigUMgBWcvjIYpcEDA2dedKihWbcvEjzBhWa74g+yVuKGo5E6EOvxtBIIWEFPwtvTFQVkStmUxjjWF2DSaLMdTSYK+6tbQ22hzOma59IYbFDJILiqwP8lEEZK7qQT7VQl+EVH5oLmQLKHKXcIGAssH4R4zxTIdNJNE/h2dLy8pIX7Dzz1I2n1xj0HtJ+7VggicRYQWijsRSzSQHAcSvh20VhlGpc4iIzsh9hrOo3gwJne+CzAPCUQpFThj7nAGqGI2KVZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72Jz1r++AEgYq8H/oz0Gm0FDYZ3lPQSGqmfphKCgLEY=;
 b=HY8AxrZpGPh/g9olvlqMqRTcF33xh+bw/KbG9ZT9wCAsWyGpobYuYKsJ3PLk9j3yDJKpTM34/CCE1WM79tBcrP8CRhIKIyAeHTbDhHvbQ54ti54raN4M0B371MJ2BL8A9eN6+MEsJ3lDkSfqe84SIamndpY3JfmG3G/CqsBtVpQoxF0Cdtmcx0dat+nutfQZAR7ShK0mkeLa8razFXS97j7sxzJDS4vuntASSMXk7oVE1tb9eNLQ/XUmH31x4Gnn+0bXf9D1/2dmzeptdnoAZymMiXcoKRCT1Mb8AfzSi/aldWfFp7l4ZLU6fAFzCXH1v4zRq7qCuhhOSECV54Kg+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72Jz1r++AEgYq8H/oz0Gm0FDYZ3lPQSGqmfphKCgLEY=;
 b=j69unnzjx6ruy6kchP6vGQ1KcRyYIVDDsAEE6JS8cQVqu4ErgOmbx/ycqbJAt9QmL+7H6AqFBlIm8riEQki33glETrV1zj893hQ97jCyTzjfp6mEHecDcIG7a0GMhFrx7qy5yKIndK8FX+xEl4/ck1jt8uaScofrUlZQNcC+qR6gJiNuh2aXlPdrQ2YhtllMxLF/zeGqNZ+DTs2BKWJc1HYpk9vfcZXJTQfKsp5AVOuE6toErrnQuZeqRxbzMwq8teaYYhVe5iwRifooTOe2VJLaZhpZF8fp90YP8nJaVWVV8tKye09soVuIiz4YcjVcGuO0Hsn1/X08c+HukSI9+A==
Received: from BL1P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::20)
 by CY8PR12MB8213.namprd12.prod.outlook.com (2603:10b6:930:71::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 11:49:28 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::41) by BL1P222CA0015.outlook.office365.com
 (2603:10b6:208:2c7::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.15 via Frontend Transport; Mon, 1
 Jun 2026 11:49:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 11:49:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:49:15 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:49:12 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v6 18/31] hw/arm/tegra241-cmdqv: Allocate HW VCMDQs once
 configured
Date: Mon, 1 Jun 2026 12:42:08 +0100
Message-ID: <20260601114221.457995-19-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601114221.457995-1-skolothumtho@nvidia.com>
References: <20260601114221.457995-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|CY8PR12MB8213:EE_
X-MS-Office365-Filtering-Correlation-Id: df9b4523-20f8-4c13-d892-08debfd3d5d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|3023799007|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fkcYxU3MvbxaMnq/Nt4yLv7Q25iB/BjMNbQ4wamVOhA0cbqmvupw7V1xGLQzhXkBlMATew27w2mTzCHhvWXu2fMUqtk6aaDA0C/2KecxjgS+6UrBMubuRxtUkqVgBCljU8georBMUOzTM2H+oxUgsrQhuet1Rgzk74+fzwoEhNFA7+KvSzN8xSXMLV4JBddFc0WFNBhFsfhj1UxMCKv4r/u4h3CnMtsl6cxkTF60jTLwRzqv3E3a4ELPHR0WvyxbvGc6znL7MKCq+3sFaUJnjl//ABz5Uy4PUyQ9ejoGDDbAIxWVoXlbzXfNO99WUIQxCJPcrMlXcgXRaDctpLQrspz4DlXKG+QZWwuTDA1/yD6uEvvbS0mVIg2TJn2XgazU5A9vK4u2li4tsJWYdGhi18OYztP6dIhW5LTZR8L63Z8pMTLqqBf6WxfrRdDtKyoN8wctdyQGVVBr5DO2cxgZBl43ulCAnSiZIRnMLHNVABxmaXULnraabVpiBFo3ZSWoINi0K6bOoVN7FDFVmNkhvYjacOQycAVjSKarw1Y2tS5DkcABc4Hl95QBULb0AHUSu4JW6k8fhnZSW65WCrdoWBBYhtV2UISdsfUQAtzzXaV7dXybhCyG6rMcXrI9cn3iqhtAHClX3/ykWEd0/Oe/hcsXwu/7dMZuBkUPr0ivuXQNGZY1fiFmEtJ8fX30XWIdTirEBcGmpPiFjVeJ6+ATDhqVIELNDjS+Y7QftKZqSKk=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(3023799007)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0yZTo3gfasIc2n7F9j9TB6ZW/ganlh1dzTcTLBOoW+bAvRReZiBA+k0G+hUD0oiyf5NB7o2Y2RLM6SWfAoxCArt85yK65a429XumH/zPoLRQ5aRqMRfMsSfj7Q8Ex0dS+1QKpDB1z89OJKdLh7EjAQsvGsAsbFxp4r3ff5ZgSg5w07MUrjGAA7LGe+y1wJzRTu+Vx/ozgI/wnC4Ij37AsFKvGFHNgLqAiZO/NISO3h8JfiUSQUoXOs05UNSRBcqkzb4ogtb25I6BZl3NT+eJta/GMlEimE1Ai3b9KH50nuhVRXFDOlg0fSFFEgPFgLYWVwNhJebWXz2baYvWGOgQwXDhEFYIDfZrEELOdpy+NF+T1C2t8UYfi+t+uC3nPd2y8vAm+A8eIZJYy1MAm2jIzwMzXPG3Vrs0KOtmJL6vJ+hILb69ZrfLEJn+G6FE0viE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 11:49:27.7948 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df9b4523-20f8-4c13-d892-08debfd3d5d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8213
Received-SPF: permerror client-ip=40.107.208.64;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
CMDQV or VINTF is disabled, or when the ALLOC bit is cleared.

On allocation failure, set CMDQ_INIT_ERR and clear CMDQ_EN_OK in the
cache so trapped guest reads see the failure rather than a queue
that looks live. Clear them on a later successful allocation.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.h |  11 +++
 hw/arm/tegra241-cmdqv.c | 154 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 156 insertions(+), 9 deletions(-)

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
index a52e153501..54d95f4e4e 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -18,6 +18,96 @@
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
+static void tegra241_cmdqv_free_all_vcmdq(Tegra241CMDQV *cmdqv)
+{
+    /* uapi/linux/iommufd.h: hw_queue destroy must be in descending @index. */
+    for (int i = (TEGRA241_CMDQV_MAX_CMDQ - 1); i >= 0; i--) {
+        tegra241_cmdqv_free_vcmdq(cmdqv, i);
+    }
+}
+
+/*
+ * Allocate a host HW VCMDQ from the current cached BASE / size for @index.
+ *
+ * Setup is a no-op (returns true) when any of the following preconditions
+ * isn't met yet:
+ *  - BASE not prgrammed yet.
+ *  - VCMDQ is not mapped to a VINTF (CMDQ_ALLOC_MAP.ALLOC == 0)
+ *  - BASE / size don't resolve to a RAM region
+ *  - CMDQV global enable or VINTF enable is not yet asserted
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
+    /* BASE not programmed yet. */
+    if (!cmdqv->vcmdq_base[index]) {
+        return true;
+    }
+
+    /* VCMDQ not yet mapped to a VINTF. */
+    if (!(cmdqv->cmdq_alloc_map[index] & R_CMDQ_ALLOC_MAP_0_ALLOC_MASK)) {
+        return true;
+    }
+
+    if (!tegra241_cmdqv_enabled(cmdqv) || !tegra241_vintf_enabled(cmdqv)) {
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
@@ -145,7 +235,12 @@ static void tegra241_cmdqv_write_vcmdq_page0(Tegra241CMDQV *cmdqv,
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
@@ -169,16 +264,19 @@ static void tegra241_cmdqv_write_vcmdq_page0(Tegra241CMDQV *cmdqv,
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
@@ -202,11 +300,13 @@ static void tegra241_cmdqv_write_vcmdq_page1(Tegra241CMDQV *cmdqv,
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
@@ -272,8 +372,14 @@ static void tegra241_cmdqv_config_vintf_write(Tegra241CMDQV *cmdqv,
         if (value & R_VINTF0_CONFIG_ENABLE_MASK) {
             if (tegra241_cmdqv_mmap_vintf_page0(cmdqv, errp)) {
                 cmdqv->vintf_status |= R_VINTF0_STATUS_ENABLE_OK_MASK;
+                /*
+                 * VCMDQs whose BASE was programmed before VINTF was
+                 * enabled need their hw_queue allocated now.
+                 */
+                tegra241_cmdqv_setup_all_vcmdq(cmdqv, errp);
             }
         } else {
+            tegra241_cmdqv_free_all_vcmdq(cmdqv);
             tegra241_cmdqv_munmap_vintf_page0(cmdqv, errp);
             cmdqv->vintf_status &= ~R_VINTF0_STATUS_ENABLE_OK_MASK;
         }
@@ -388,16 +494,37 @@ static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
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
         tegra241_cmdqv_config_vintf_write(cmdqv, offset, value, &local_err);
         break;
@@ -427,12 +554,14 @@ static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
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
@@ -451,6 +580,7 @@ static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
 static void tegra241_cmdqv_writell_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
                                         uint64_t value)
 {
+    Error *local_err = NULL;
     int index;
 
     switch (offset) {
@@ -463,18 +593,24 @@ static void tegra241_cmdqv_writell_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
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
-- 
2.43.0


