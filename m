Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389E4CD5BA7
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHsN-00030M-Lv; Tue, 19 May 2026 06:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHrn-0001BY-H0; Tue, 19 May 2026 06:40:12 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHrk-0006Ym-Ps; Tue, 19 May 2026 06:40:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LaOJDpqq3wO6KfYBtfa4nqccKj3C0I3AY4wmd8MhxK3cGA2B8prm8WKL+pwIuUM936RgCmqgUG2okoQIcuSE+XlBvYClpVdDzyTyVe47szfMRj7Tw3zFDZiof58Q6Ft8OwT5OzfaGsKzkmneJ8E8GFa2M+vYqjc1n4e9/r2nZBdKzh4l6I6DSACV2w2X5x0uVWXh0pK4SeIHEbaq78H9ulEmOx+eV3QU2Jh7RTme2UHp7q7x8ca6tYdepTjeIw86Yixe39PQjHlAsqjt9Ji7HHjvdAwRJEvmb6riTsd4KsdavxXMwisamo7AkDsqT0hJCYhkbrTtvK1yGRgr0zc8wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2uMUnF1cRosH1w3Fn/DgzMuSdgaO+BRkRcabgUjd8U=;
 b=Ca9nUxXpPo3q7iZ90T7nCFr4Q7LW15+QGoKLGtBRtbCzTeKk6AvnRo7tFu6CyBTu5IdeQhWGj8MxuAvLKENqqHizfAa20h/lRaETSBSK7DefYCsejA+8pdn1uO1i6ubJo2FqHp9OReW7k1GGTDbLIFYmb9mAOz/Qv0IwyP9ZCc0r2WyKxtA70HvTm96sCn4zHcIvdM2XHBxSHKzin3lDkfn+r0QcWNUR7CTnpDI8+0ncC8vY3l1LFC+ahCQvz2fBx+tw7TRo3p1Dz33rAxK+R9I486uiqW0zcdVKJDkntUJdmw/I4XRceJMrH4Z3pYklEoo8X+yqiozz82qLom7Ang==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2uMUnF1cRosH1w3Fn/DgzMuSdgaO+BRkRcabgUjd8U=;
 b=oXqkL/jZsj9q36l9L172pO+rMD2H6B6yGmOMwUitUPHxsBYtq03IOPnBP3OU4Ht/SCCfAVr93s/ccXq5zjFl5LY8xC0R+XxCPMM1T5Xv1wzw7u7pL/H+TFyiD5SRTxHUzaE4rRwCG1RNsHHFCOmsIFbkFJBVUDg1oJJwAHcglDQlvdsdOfBHEuY2Vq+uhPkqBWmPpsz/5dL3r5K/LAFoc9ZmneNiz5DMyRbd+6C6PpDPBSMudSI2FXBq56zpBqkSHMTFkugVTlVSLsBtgAj2n3IYCzoK6SiWDgKUGwquk4yfCLiCzB1EexSChVYLqTyoNqZLpRKtlB/dNRmb3P6zwQ==
Received: from BLAPR05CA0013.namprd05.prod.outlook.com (2603:10b6:208:36e::28)
 by LV3PR12MB9144.namprd12.prod.outlook.com (2603:10b6:408:19d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 10:39:47 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:36e:cafe::44) by BLAPR05CA0013.outlook.office365.com
 (2603:10b6:208:36e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.15 via Frontend Transport; Tue, 19
 May 2026 10:39:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 10:39:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:39:31 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:39:28 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v5 19/32] hw/arm/tegra241-cmdqv: Allocate HW VCMDQs once
 configured
Date: Tue, 19 May 2026 11:36:57 +0100
Message-ID: <20260519103727.899332-20-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519103727.899332-1-skolothumtho@nvidia.com>
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|LV3PR12MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: 982088f6-6919-4ec3-e470-08deb592f26e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: 334/qH1Qj31GIxgXpcUtn5gHWneIKs6rYq5bwAnMleXwZNFCcYe8CknzTW49ezRZkxYI69dkFFK71rCq90l3YZ2rJlX2V8YYNyUNNrNqHLBO62DhNh63Zuh+ixkwR4hMzgOqrE4bdqDoMs0/tH4F9J0QnF2k/+JNxdHUJQ/q2NPHKjFMlNyEMqk7Cu8ulbatdRcxB+ZOV/iM+T+FNlr/h6goPYG5WDZx9Zgkapg3jk3lU84ZXjVHtVFIhBdDsTFtNTu7EBgZ4S4ilnaoqJGsFwtOD/5wqTWKG+GwVmb1HIdIe9NgKazWlo1beBZkpN0J7tQQMwdQsn/iFxvByzrvWelpK/NCChRjJAGaDqO4lwq+9QQfrEDbLnbpsn4ehwBxsAqL6qWltCJoqtZmWsYe6gpPRr/B8XHw9/r2clf/4zO6WeesuMYuQiWYQceq9kjY5Hf1ccleJKRnyUB3KoPBo+pqvVamcr5SlzqSLrRiT9xvTg2ODc0YL94sAX65MIHKK5lIYs0C5D5Bftz3+/zqGoPTogd9Pq4cqUq8Gp8qxU5YUw363HfBw65J0CW+JA5u57IG2eucoZ1P9NtIrq4E2EKjA8eefMy4o3mXYFM6uTqu/lyWp6+Zy8u5FuVgC7UmP6pfXBDFb2SUb07r8NjU8aAQBgMOdUkA7FgbpS3OlTSTPULRXmso7qZY5OvJyffPk1xkp+GSCBOCj17eo5fuILb12U2NqEW6izn9ZSc8MZs=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5eG080n09WW/aPUgzT4PReoQXv+7ecIpBsdEUp1zZTwHqH00PILyeNe8/7a4B0EBObeHrYkasTljBpmiDGTS2U5PR4hSz9SZ9qGUJ3csSKvI4fHMh1gSxFevTDXi+4P01t2D/1Z+p559kEQycPyCvVPVFTB9Wy6Gov/Z+ecFf2F9ZvPFMG4SbthDrHZAfVO6kMdLi1R7IQ3L+Xsj8er1s0qHAzzDdJVTNsYbHoAf/+mc445z/9BK5vZVs+t+w+M8fB0tFCCPfNAFqh7/lHRS6t2DtxS8xjDkr/ox6MSjkiVm7hfgHJuNXeCEHtPAa2SUAIZ6ApZLZINzfJRcIVGkCunl/g1brPDDf0FcRa8iZppEUian2RTEma+EbRzleAAvBTJT7C8/0rrFxUZo+9N0345XfnoPvJtsJiwnckt1Sf5nuqtmSRCga6ck4Z4C3JBq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:39:46.8524 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 982088f6-6919-4ec3-e470-08deb592f26e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9144
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
that a later patch maps directly into the guest — so QEMU won't trap
its writes. Allocate the hardware queue instead once all of these
are set: a RAM-backed BASE, CMDQ_ALLOC_MAP.ALLOC, and CMDQV / VINTF
enabled. Each precondition write retries the allocation, so the
guest may program them in any order.

If a hardware queue was previously allocated for the same VCMDQ,
free it before reallocation.

Writes with invalid addresses are ignored.

All allocated VCMDQs are freed when CMDQV or VINTF is disabled, or
when the ALLOC bit is cleared.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.h |  11 ++++
 hw/arm/tegra241-cmdqv.c | 138 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 143 insertions(+), 6 deletions(-)

diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index f0b031b4dc..7a8cb2ebc7 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -45,6 +45,7 @@ typedef struct Tegra241CMDQV {
     MemoryRegion mmio_cmdqv;
     qemu_irq irq;
     IOMMUFDVeventq *veventq;
+    IOMMUFDHWqueue *vcmdq[TEGRA241_CMDQV_MAX_CMDQ];
     void *vintf_page0;
 
     /* CMDQ-V Config page register cache */
@@ -361,6 +362,16 @@ SMMU_CMDQV_VI_VCMDQi_CONS_INDX_BASE_DRAM_L_(1)
 SMMU_CMDQV_VI_VCMDQi_CONS_INDX_BASE_DRAM_H_(0)
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
index 4d9f094b2a..f4968520f3 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -18,6 +18,95 @@
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
+    /* Ignore any invalid address. This may come as part of reset etc. */
+    if (!address_space_range_is_ram(&address_space_memory, addr, size)) {
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
+        return false;
+    }
+    hw_queue = g_new(IOMMUFDHWqueue, 1);
+    hw_queue->hw_queue_id = hw_queue_id;
+    hw_queue->viommu = viommu;
+    cmdqv->vcmdq[index] = hw_queue;
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
  * Returns true if the per-VCMDQ CMDQ_EN_OK bit is set.
  */
@@ -172,7 +261,7 @@ static void tegra241_cmdqv_write_vcmdq_page0(Tegra241CMDQV *cmdqv,
  */
 static void tegra241_cmdqv_write_vcmdq_page1(Tegra241CMDQV *cmdqv,
                                              hwaddr offset0, int index,
-                                             uint32_t value)
+                                             uint32_t value, Error **errp)
 {
     switch (offset0) {
     case A_VCMDQ0_BASE_L:
@@ -181,6 +270,7 @@ static void tegra241_cmdqv_write_vcmdq_page1(Tegra241CMDQV *cmdqv,
         }
         cmdqv->vcmdq_base[index] =
             deposit64(cmdqv->vcmdq_base[index], 0, 32, value);
+        tegra241_cmdqv_setup_vcmdq(cmdqv, index, errp);
         break;
     case A_VCMDQ0_BASE_H:
         if (tegra241_vcmdq_enabled(cmdqv, index)) {
@@ -188,6 +278,7 @@ static void tegra241_cmdqv_write_vcmdq_page1(Tegra241CMDQV *cmdqv,
         }
         cmdqv->vcmdq_base[index] =
             deposit64(cmdqv->vcmdq_base[index], 32, 32, value);
+        tegra241_cmdqv_setup_vcmdq(cmdqv, index, errp);
         break;
     case A_VCMDQ0_CONS_INDX_BASE_DRAM_L:
         cmdqv->vcmdq_cons_indx_base[index] =
@@ -210,7 +301,7 @@ static void tegra241_cmdqv_write_vcmdq_page1(Tegra241CMDQV *cmdqv,
  */
 static void tegra241_cmdqv_write_vcmdq_page1_64(Tegra241CMDQV *cmdqv,
                                                 hwaddr offset0, int index,
-                                                uint64_t value)
+                                                uint64_t value, Error **errp)
 {
     switch (offset0) {
     case A_VCMDQ0_BASE_L:
@@ -218,6 +309,7 @@ static void tegra241_cmdqv_write_vcmdq_page1_64(Tegra241CMDQV *cmdqv,
             return;
         }
         cmdqv->vcmdq_base[index] = value;
+        tegra241_cmdqv_setup_vcmdq(cmdqv, index, errp);
         break;
     case A_VCMDQ0_CONS_INDX_BASE_DRAM_L:
         cmdqv->vcmdq_cons_indx_base[index] = value;
@@ -282,8 +374,14 @@ static void tegra241_cmdqv_config_vintf_write(Tegra241CMDQV *cmdqv,
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
@@ -394,16 +492,37 @@ static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
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
@@ -432,7 +551,8 @@ static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
     case A_VCMDQ0_BASE_L ... A_VCMDQ1_CONS_INDX_BASE_DRAM_H:
         index = (offset - CMDQV_VCMDQ_PAGE1_BASE) / CMDQV_VCMDQ_STRIDE;
         tegra241_cmdqv_write_vcmdq_page1(cmdqv,
-                offset - index * CMDQV_VCMDQ_STRIDE, index, value);
+                offset - index * CMDQV_VCMDQ_STRIDE, index, value,
+                &local_err);
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s unhandled write access at 0x%" PRIx64 "\n",
@@ -451,6 +571,7 @@ static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
 static void tegra241_cmdqv_writell_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
                                         uint64_t value)
 {
+    Error *local_err = NULL;
     int index;
 
     switch (offset) {
@@ -465,13 +586,18 @@ static void tegra241_cmdqv_writell_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
     case A_VCMDQ0_BASE_L ... A_VCMDQ1_CONS_INDX_BASE_DRAM_H:
         index = (offset - CMDQV_VCMDQ_PAGE1_BASE) / CMDQV_VCMDQ_STRIDE;
         tegra241_cmdqv_write_vcmdq_page1_64(cmdqv,
-                offset - index * CMDQV_VCMDQ_STRIDE, index, value);
+                offset - index * CMDQV_VCMDQ_STRIDE, index, value,
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


