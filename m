Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1790FC592F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvYzn-0006qN-Hb; Thu, 26 Feb 2026 05:53:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYzm-0006pb-0m; Thu, 26 Feb 2026 05:53:26 -0500
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYzk-0000z8-A7; Thu, 26 Feb 2026 05:53:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JszreLvQoTw7+j1mgxC67HWNISN0+GNCzFHlFGVFGsxUV6JU5DRJeydocpcfI5pC413YGByrr0Dh8b3JYezV61Eg7cznbyxk39KYTzwF76gu7v1phKpRTW2CMMbN4vPMAvnMwFPfL1n/wy1OLVxhYIyV4BcpWH8BjEvmRERQvycdq6R6Vxs7Dfkypbx42KcVdjRt8EDjOWSe9FdNf/Thd0adSoqh24x3iAUDdnIbVjdPiz5UZwz+5pSuQFb4RK+i5IoDZ06FzAopqIWCASETvBCney0CC0gG2x+Sxm6bV+hbi5HTGy4kXUtKR7RHoNBiI/UFrF5bx/p9OwMf1rhARQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/x6Z53vYtwzADwrqfdwqpRtrFNsOWyKn1F8ehpLf3w=;
 b=yaI8b87XdtithWyRWv3P0Kun5ezRN0j94ogHBAEFMPIAyJCTbS60zYEPcg+jcMgu32UZoFRBjI+mBz/WMTAMEN7iY+0vKWVh1WDQgEpVeyueoPwhUrE66OA5UhDEhPwNxd7d7ywfcJS6jpAoQprk6kbJbf7KnO15Hg+1LILZhh4LQsdTBfP4lfKFplGLnyzOMKHMRsREqwTnDtlxZiF/vSbZ48gXM+F9KECCVtNmcK/ub+wqw7xh7aTIexk6ay37KgSgtuVDLEP8lyy/bpA2AvENDH/sY+HufGpwJs2mJxTAwBJ5ToVW+RzLqoUYTiJwwqV3ml4q8QliLtAeLZc5GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/x6Z53vYtwzADwrqfdwqpRtrFNsOWyKn1F8ehpLf3w=;
 b=NVFcWIeF7TYaavCQOFTAXHPb7Ow0ep2hI/bIRfbeRj4rAA5qnGBVbJxqQPdRhwTbwgfoNY0t+RA0RX8JMjpniVhWbNY4eAgh6OtCLoNG0xlnkk67kyU+mlmDnEZ0EesGVVCcWYBCTaM4C1bQcVJhzEueei4+5/lSYl6ZhSuIlCRVwWnWDhpr/tljArorrrUpPdiApBC9rvzlz/lrXOzRQXKvddQdU4VHumqlQ+/7drgodeJ3PTxerYFho3TQb4DrGvnzunCpZsC7Rky+Hd9cG5jm1Rx4F0od380PmwkO9zvGyXC7nN1jl4NjfVi99H/8iiqYjIjdgAB07CETVMzupg==
Received: from CH5PR02CA0012.namprd02.prod.outlook.com (2603:10b6:610:1ed::11)
 by DM6PR12MB4203.namprd12.prod.outlook.com (2603:10b6:5:21f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 10:52:58 +0000
Received: from DM2PEPF00003FC5.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::3f) by CH5PR02CA0012.outlook.office365.com
 (2603:10b6:610:1ed::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Thu,
 26 Feb 2026 10:52:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM2PEPF00003FC5.mail.protection.outlook.com (10.167.23.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 10:52:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:52:40 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:52:37 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v3 19/32] hw/arm/tegra241-cmdqv: Allocate HW VCMDQs on base
 register programming
Date: Thu, 26 Feb 2026 10:50:43 +0000
Message-ID: <20260226105056.897-20-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226105056.897-1-skolothumtho@nvidia.com>
References: <20260226105056.897-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC5:EE_|DM6PR12MB4203:EE_
X-MS-Office365-Filtering-Correlation-Id: 85e311c8-bbe3-468b-97ed-08de752533ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|7416014|36860700013; 
X-Microsoft-Antispam-Message-Info: YcB67WePBj3kuRkmMZLRyRPxWd0P+YdEGCowZ92shJGdYGEoU+hVAueBPaNenRk+yW1of56O/ERznO+BWayqsqgsIZlgXbS12gIaYZqwlj6msbsBmODYB/DgeALoaU1E0uw5+6XcT7nXj6tAuL8K191OK1Di2rezyzsHgr7H5/Y6YrGrZ6d4yltcqN5DIzokySqI8nAjkcUd6QssvDDAJ5fKThDXIq7zKrmT8dYe296t+aajFHfyT/L1dC3dnyIY6UzuIDCLv5qPBPRTobk49+SlaUcdimY8PmJ/Gsw3LznssvVylTh0dV27HNKEby1bAX9TarUf0ZLnH+iZDffr2qPpgCKuNQCXk9oORzYXRCb7sjQrBreeww+dLdNBHzrPhEUfENUGj3O4/NjQzc75wVefU9T29DJyxaPkPHGbdCrZWfRgo1SXQAToYiv9OioqXCUEf30apI4vpRBWMHjApk1WokuxGan4OCwlObWDVOsmSsW5Z1gKZXbKFIT67GOBIRDHBZDqjUWZLL4cAl86Nu9ICAW/pnvWb09a/a8lBR/3yfUqeTquz5eZMUoh5qnRaLTcvaSqhuNz82wpEpKl7+lbOHeAuan6Mnqkp/kxnEmmEVmh8tvnmoJPOKi8zGaELWqwAbKa1NM+GmTbI/nxNk8OvyqzXXvRbLLqmA6V5/tDxqWSsbme085eUilU+m7Cn3AI28MPpwNz8wQU8UQphty91VSFxdS0fE2pV81Ra77V9mJ5DBkQCk7bu9TDarahsIKCvwYnC4eXn0nsFT4+YFRcvr0tsP4tly13ZLVj1Ir8y6ir7KuHtXyZuNj1KrSSS0jpNV3dNn6L3C5UZvYdvA==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: P5euJr504culk/E/Dme0AOg6ClkRvebcoItYSW3QTbh4n99J7YwKbmylg1WkqHTDf+HjHfVDlzOJYDbUtbt5inCmzBlCYhXQQXQp+t9B6LuQXDIBeaJ99AQY57hkJ2yavo38p2VbxfcEO014NEdlg4nLLr6T4FBLlA6rkZ3aUaXrnmEEUBLCHbigkkKQfZNXWWo8+5seL4912FJR4x8ldhL4CFMdrLnqlmTWd99Ob2X/OeO1pyD0vAael0TQwohrtMa/vDcSmA016wr3vR9UFAbI9Xivgcy+Uzr3WjveWNOmmgOvBwrDu1Ccwb3h/PsHAHynLCvA0M8Cic2R8wLZKGdX0dsTOMUfMZ45l8Z7NhSovx9swXAfJkuvzDwhD6kQBnJ46qRYBgtvEySSL31H0Sd245F/imOppKdl5yv3Yrox14zttAiUK6RFZ+1MWDz2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 10:52:57.6534 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e311c8-bbe3-468b-97ed-08de752533ec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4203
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

VCMDQ_EN is part of the VCMDQ_CONFIG register, which is accessed
through the VINTF Page0 region. This region is mapped directly into
the guest address space (introduced in a subsequent patch), so QEMU
does not trap writes to VCMDQ_CONFIG.

Since VCMDQ_EN writes are not trapped, QEMU cannot allocate the
hardware queue based on that bit. Instead, allocate the IOMMUFD
hardware queue when the guest writes a VCMDQ BASE register with a
valid RAM-backed address and when CMDQV and VINTF are enabled.

If a hardware queue was previously allocated for the same VCMDQ,
free it before reallocation.

Writes with invalid addresses are ignored.

All allocated VCMDQs are freed when CMDQV or VINTF is disabled.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.h | 11 +++++++
 hw/arm/tegra241-cmdqv.c | 71 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 79 insertions(+), 3 deletions(-)

diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index 3ce9f539ae..139e14b61b 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -36,6 +36,7 @@ typedef struct Tegra241CMDQV {
     SMMUv3AccelState *s_accel;
     MemoryRegion mmio_cmdqv;
     qemu_irq irq;
+    IOMMUFDHWqueue *vcmdq[TEGRA241_CMDQV_MAX_CMDQ];
     void *vintf_page0;
 
     /* Register Cache */
@@ -322,6 +323,16 @@ A_VI_VCMDQi_CONS_INDX_BASE_DRAM_L(1)
 A_VI_VCMDQi_CONS_INDX_BASE_DRAM_H(0)
 A_VI_VCMDQi_CONS_INDX_BASE_DRAM_H(1)
 
+static inline bool tegra241_cmdq_enabled(Tegra241CMDQV *cmdq)
+{
+    return cmdq->status & R_STATUS_CMDQV_ENABLED_MASK;
+}
+
+static inline bool tegra241_vintf_enabled(Tegra241CMDQV *cmdq)
+{
+    return cmdq->vintf_status & R_VINTF0_STATUS_ENABLE_OK_MASK;
+}
+
 const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void);
 
 #endif /* HW_ARM_TEGRA241_CMDQV_H */
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index a3767a85a3..002dde50fc 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -151,6 +151,67 @@ static uint64_t tegra241_cmdqv_read(void *opaque, hwaddr offset, unsigned size)
     }
 }
 
+static void tegra241_cmdqv_free_vcmdq(Tegra241CMDQV *cmdqv, int index)
+{
+    SMMUv3AccelState *accel = cmdqv->s_accel;
+    IOMMUFDViommu *viommu = accel->viommu;
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
+    /* Free in the reverse order to avoid "resource busy" error */
+    for (int i = (TEGRA241_CMDQV_MAX_CMDQ - 1); i >= 0; i--) {
+        tegra241_cmdqv_free_vcmdq(cmdqv, i);
+    }
+}
+
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
+    /* Ignore any invalid address. This may come as part of reset etc */
+    if (!address_space_is_ram(&address_space_memory, addr) ||
+        !address_space_is_ram(&address_space_memory, addr + size - 1)) {
+        return true;
+    }
+
+    if (!tegra241_cmdq_enabled(cmdqv) || !tegra241_vintf_enabled(cmdqv)) {
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
 static bool
 tegra241_cmdqv_munmap_vintf_page0(Tegra241CMDQV *cmdqv, Error **errp)
 {
@@ -192,7 +253,7 @@ static bool tegra241_cmdqv_mmap_vintf_page0(Tegra241CMDQV *cmdqv, Error **errp)
  */
 static void
 tegra241_cmdqv_write_vcmdq(Tegra241CMDQV *cmdqv, hwaddr offset0, int index,
-                           uint64_t value, unsigned size)
+                           uint64_t value, unsigned size, Error **errp)
 {
     switch (offset0) {
     case A_VCMDQ0_CONS_INDX:
@@ -220,11 +281,13 @@ tegra241_cmdqv_write_vcmdq(Tegra241CMDQV *cmdqv, hwaddr offset0, int index,
                 (cmdqv->vcmdq_base[index] & 0xffffffff00000000ULL) |
                 (value & 0xffffffffULL);
         }
+        tegra241_cmdqv_setup_vcmdq(cmdqv, index, errp);
         return;
     case A_VCMDQ0_BASE_H:
         cmdqv->vcmdq_base[index] =
             (cmdqv->vcmdq_base[index] & 0xffffffffULL) |
             ((uint64_t)value << 32);
+        tegra241_cmdqv_setup_vcmdq(cmdqv, index, errp);
         return;
     case A_VCMDQ0_CONS_INDX_BASE_DRAM_L:
         if (size == 8) {
@@ -263,6 +326,7 @@ static void tegra241_cmdqv_write_vintf(Tegra241CMDQV *cmdqv, hwaddr offset,
             tegra241_cmdqv_mmap_vintf_page0(cmdqv, errp);
             cmdqv->vintf_status |= R_VINTF0_STATUS_ENABLE_OK_MASK;
         } else {
+            tegra241_cmdqv_free_all_vcmdq(cmdqv);
             tegra241_cmdqv_munmap_vintf_page0(cmdqv, errp);
             cmdqv->vintf_status &= ~R_VINTF0_STATUS_ENABLE_OK_MASK;
         }
@@ -302,6 +366,7 @@ static void tegra241_cmdqv_write(void *opaque, hwaddr offset, uint64_t value,
         if (value & R_CONFIG_CMDQV_EN_MASK) {
             cmdqv->status |= R_STATUS_CMDQV_ENABLED_MASK;
         } else {
+            tegra241_cmdqv_free_all_vcmdq(cmdqv);
             cmdqv->status &= ~R_STATUS_CMDQV_ENABLED_MASK;
         }
         break;
@@ -321,7 +386,7 @@ static void tegra241_cmdqv_write(void *opaque, hwaddr offset, uint64_t value,
     case A_VCMDQ0_CONS_INDX ... A_VCMDQ1_GERRORN:
         index = (offset - 0x10000) / 0x80;
         tegra241_cmdqv_write_vcmdq(cmdqv, offset - 0x80 * index, index, value,
-                                   size);
+                                   size, &local_err);
         break;
     case A_VI_VCMDQ0_BASE_L ... A_VI_VCMDQ1_CONS_INDX_BASE_DRAM_H:
         /* Same decoding as read() case: See comments above */
@@ -330,7 +395,7 @@ static void tegra241_cmdqv_write(void *opaque, hwaddr offset, uint64_t value,
     case A_VCMDQ0_BASE_L ... A_VCMDQ1_CONS_INDX_BASE_DRAM_H:
         index = (offset - 0x20000) / 0x80;
         tegra241_cmdqv_write_vcmdq(cmdqv, offset - 0x80 * index, index, value,
-                                   size);
+                                   size, &local_err);
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s unhandled write access at 0x%" PRIx64 "\n",
-- 
2.43.0


