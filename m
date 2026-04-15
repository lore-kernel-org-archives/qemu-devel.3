Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816BDF41986
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 10:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCxx3-0002FO-L4; Wed, 15 Apr 2026 06:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxwn-0001dU-Vo; Wed, 15 Apr 2026 06:58:19 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxwd-00048i-42; Wed, 15 Apr 2026 06:58:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YK1ZsxWJ2YunerBJwxFGHgevJJXoGFvgrnJLwdd1kcJ7ms8xImhicaRAL54FLlIVKU46l/wPV9gLJSFSGatcZwlN+kSxpKJu/bLZtoGMOUbYAmFm8xYQbxKywsr2sDEf8corWmOpfyT+7wu5b4ScbVU2tNUSryM4EwA2kEpyaOTQ/muf4bceFATIYbocoVLUrsz6gau6SQFFTGrqGIFuz0IlmJo5AfNTFS/RyESr7HPJXP5ddQJlZ48FtcPCufWW/PgrkdVKi2RYH1IBoVVu0TPMtynL4C6LFTT9E7UlfRFC2XAVzgp0DMOTAf/6BsnG0DFqH7X1b7M88Sam+LdqQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9DLOFcifzj837AUe7jnzWPo14/2YneH1gFZE/ch9RI=;
 b=vgTSKvoangbNEOnzXY3w+ECyqx0ljkOPO0kbAraZiC7GJVv0G2HTnlCE4AAnzRLohuIOgbaOk+Fb5zSVQHv53FFIEbaQXnHtPW6j7NkrRGlmeT+gO6dA7e7E7MRstxcS6CPSD7O7P34qvJPKSy80xc0J0Rst9W998nH/jcu9y4BxNRPuNhPyXIXwFbJ3lP1bacGEWgRUCt5/YaVWbUwTbtE079nHIH7cyu6KAehcDVTdabjhvHS0zcqdIRqr/bVn540sHeKji18aIuzgT0vS0aRFDHLp9X/CqePSbC16nd4Y0ypWgy941UAs3XG9NWYnkhTZq+kRrnanxMiWkaTaSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9DLOFcifzj837AUe7jnzWPo14/2YneH1gFZE/ch9RI=;
 b=EK2MWn2jllgYh8T7vQ+IAQOEXCyWYm2znhsgfOSvRGZs9Ex1vzt/mHF4xP8C4uS+gJVi+LBdF5gYXQjHX1BMYX+L+8zrqJNhPSYk7Y+Ftr1rz8bXc2N1eGy91ih1DVi17DV0fak/JVmCTWMLXC653KefkZwASoE/4esVrqoJacj9DSSUqhxIrpP4pzGDoCqJladSElYJJCX1IyS/yScwn8ZkWO6WmbyloCNpwXQurQT60kdl6RgcKiVXpu1Z4qXbi1K0l8R0RSjC9+fGYoX3rxjOnJqmifS+yRjIX5J7wCJzAeO/DHvMiuJeBPrCUkFDLb5aMKYZEuUE0pOJpwy/cg==
Received: from MN0PR03CA0020.namprd03.prod.outlook.com (2603:10b6:208:52f::27)
 by PH8PR12MB6843.namprd12.prod.outlook.com (2603:10b6:510:1ca::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 10:58:00 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:52f:cafe::1c) by MN0PR03CA0020.outlook.office365.com
 (2603:10b6:208:52f::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Wed,
 15 Apr 2026 10:57:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 10:57:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:57:45 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:57:41 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v4 19/31] hw/arm/tegra241-cmdqv: Allocate HW VCMDQs on base
 register programming
Date: Wed, 15 Apr 2026 11:55:40 +0100
Message-ID: <20260415105552.622421-20-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415105552.622421-1-skolothumtho@nvidia.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|PH8PR12MB6843:EE_
X-MS-Office365-Filtering-Correlation-Id: 95d5088c-89fe-48db-fbab-08de9adddba3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8Ya5MAupuq8aoGgAi8Lf8SGgyxkSEd+4L6uz4rBSEOpjOWsEmNoDg+aelwuxGSMv7exjB+dWVubQBizhrNuvBYbb7bFpVBAEM4m73yC8GaNqDu67WsQAvt1doNuX3rUvALYrzzBaYTGNGvmz+8eV1b2qMpu3Al1c5aW/HJ65Ynkht7KPJG6cEj+q5+JcT/kPxDFqb1uEEkNkGzviil7EqzIv7yyfU97H7ePSAhs7OEiuu31r7gpm186j600N0BasIANxHU6Pwpn1n6w+W3mLfwdjv1vcQTzebtFnAZ9ZmrV+cdigllgiGL1qpkv4654hWb+PWESxFEiNoitesqClgUwQJTpHkAhX9WtE67U3EAaJnyDDPyAGoHEKLRG23c6tkBQP1mTM62GmUbdC0tXWYgz2Rsa+DB4hNvav+aKlR+lkfXEsubtbG+ssiB9eEG/RrNcjPITX63y30btrrMqefEjuRHCgQrUKl0nd4Avp6vyN7bitCuaIVlKjFBxLt+w4JpcqEx2F6BImBqHDA4ZZ0DJ1thpINzgQ6AUA6gW8tRz7dntn1/uif8nYJe8tGVYV1bJuewGCT5lxV56tMu9bnBYMLHcSTodhqmbPx60UfS/4NYUND32OB/6zjGxN6AUI5IkzyPPkCrTJtvbPTFAm971kVM1d1K0LVNfJvK8E/xi/hi1vHVi8a4bzZSzMrW+gvbKO2XNW/IPiqkpJOcXd9QczdlHDO7lfCG6lz7RGnLtfOaSE4NpYUIiRIEFuUjqaTjkXOF9/PKcA7uBDOt3e7w==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ajwxM8QDwYU7x1bR/fn0H/CpGYTsGxBPiBWgpTlbcA4OuZbaaaCA0zmmPdXD8us1ewHkdeLhV0U5jV+jRi0yIJyp0To18+W4onWLI3Q8KW/kxM5BlRJHCeghQpv8yPf7e/4ZWwrZ+sZFuMgdmA3gvpeeAotDLB8ukqRp9yG2QUzqLIZL1ELeatau8t0QudZ6SnA3fH08NFCljxqjSkON1DaTzU2mpRmIxpN9XJ9Vm26ajI9hCriLfN7cTAgzl15SmrTfaApbc/PdXn0z6ri2zMpsgPVhZYSXGmEeLPw8hJKnloD87oDiTpeFTC+8GL+tGR9/Z/LU64dcVi8aWV6tkI0cewaXZkSeaDmirevM0hsK+hbVi9xYuOfdhv5wXBCJekMERKu4c5orHigwDlNTsk3BtEokyT8FxCnlOC8FcagBxsGCY0SVsYNGEaN2NXne
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 10:57:59.4674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d5088c-89fe-48db-fbab-08de9adddba3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6843
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
through the VINTF Page0 region. A subsequent patch maps this region
directly into the guest address space, so QEMU does not trap writes
to VCMDQ_CONFIG.

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
 hw/arm/tegra241-cmdqv.c | 70 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 78 insertions(+), 3 deletions(-)

diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index 88572ad939..039d86374f 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -44,6 +44,7 @@ typedef struct Tegra241CMDQV {
     MemoryRegion mmio_cmdqv;
     qemu_irq irq;
     IOMMUFDVeventq *veventq;
+    IOMMUFDHWqueue *vcmdq[TEGRA241_CMDQV_MAX_CMDQ];
     void *vintf_page0;
 
     /* Register Cache */
@@ -348,6 +349,16 @@ A_VI_VCMDQi_CONS_INDX_BASE_DRAM_L(1)
 A_VI_VCMDQi_CONS_INDX_BASE_DRAM_H(0)
 A_VI_VCMDQi_CONS_INDX_BASE_DRAM_H(1)
 
+static inline bool tegra241_cmdq_enabled(Tegra241CMDQV *cmdqv)
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
index cdd941cec9..b5f2f74cf2 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -15,6 +15,66 @@
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
+    /* Free in reverse order to avoid "resource busy" error */
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
+    /* Ignore any invalid address. This may come as part of reset etc. */
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
 /*
  * Read a VCMDQ register using VCMDQ0_* offsets.
  *
@@ -63,7 +123,7 @@ static uint64_t tegra241_cmdqv_read_vcmdq(Tegra241CMDQV *cmdqv, hwaddr offset0,
  */
 static void tegra241_cmdqv_write_vcmdq(Tegra241CMDQV *cmdqv, hwaddr offset0,
                                        int index, uint64_t value,
-                                       unsigned size)
+                                       unsigned size, Error **errp)
 {
     switch (offset0) {
     case A_VCMDQ0_CONS_INDX:
@@ -91,11 +151,13 @@ static void tegra241_cmdqv_write_vcmdq(Tegra241CMDQV *cmdqv, hwaddr offset0,
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
@@ -204,6 +266,7 @@ static void tegra241_cmdqv_config_vintf_write(Tegra241CMDQV *cmdqv,
                 cmdqv->vintf_status |= R_VINTF0_STATUS_ENABLE_OK_MASK;
             }
         } else {
+            tegra241_cmdqv_free_all_vcmdq(cmdqv);
             tegra241_cmdqv_munmap_vintf_page0(cmdqv, errp);
             cmdqv->vintf_status &= ~R_VINTF0_STATUS_ENABLE_OK_MASK;
         }
@@ -329,6 +392,7 @@ static void tegra241_cmdqv_write_mmio(void *opaque, hwaddr offset,
         if (value & R_CONFIG_CMDQV_EN_MASK) {
             cmdqv->status |= R_STATUS_CMDQV_ENABLED_MASK;
         } else {
+            tegra241_cmdqv_free_all_vcmdq(cmdqv);
             cmdqv->status &= ~R_STATUS_CMDQV_ENABLED_MASK;
         }
         break;
@@ -363,7 +427,7 @@ static void tegra241_cmdqv_write_mmio(void *opaque, hwaddr offset,
          */
         index = (offset - CMDQV_VCMDQ_PAGE0_BASE) / CMDQV_VCMDQ_STRIDE;
         tegra241_cmdqv_write_vcmdq(cmdqv, offset - index * CMDQV_VCMDQ_STRIDE,
-                                   index, value, size);
+                                   index, value, size, &local_err);
         break;
     case A_VI_VCMDQ0_BASE_L ... A_VI_VCMDQ1_CONS_INDX_BASE_DRAM_H:
         /* Same VINTF-to-VCMDQ translation as VINTF Page0 case above */
@@ -373,7 +437,7 @@ static void tegra241_cmdqv_write_mmio(void *opaque, hwaddr offset,
         /* Same decode logic as VCMDQ Page0 case above */
         index = (offset - CMDQV_VCMDQ_PAGE1_BASE) / CMDQV_VCMDQ_STRIDE;
         tegra241_cmdqv_write_vcmdq(cmdqv, offset - index * CMDQV_VCMDQ_STRIDE,
-                                   index, value, size);
+                                   index, value, size, &local_err);
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s unhandled write access at 0x%" PRIx64 "\n",
-- 
2.43.0


