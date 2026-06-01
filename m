Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F127CD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:50:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU19F-0005us-31; Mon, 01 Jun 2026 07:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU19B-0005nq-6P; Mon, 01 Jun 2026 07:49:33 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU199-00056F-FC; Mon, 01 Jun 2026 07:49:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVRjj/QVNwZYbQu4LjYB1RhnE/ITcWetpvjeVa2/ih7ftFpXHKihNcvPjWR3F21B2SHBL2LKLVERv1y0IbsScP9c/Qg2A3dOkk6WXQHypOZjlsNiE6foQHwHCeUoZc9UXEaNytHZ95S/1GO99YevpOpUX43yZMkzmZiwr6NJlPGhIz9i9wsnp9dKOUIiBalx6WVkhp6Vj4GlYixQ6+dchdwQvPypv3pIWgbJhPaWsN9n3KkUvecMfJpzfD0Ni5cfhAyJTRZmKd43NjxRA1nAwqls/WdYh9mOGOYQI3Qy/53WSQSKTKCXtmucBXA7aT5lkG3aS/XEQ+JTuRysrrOGjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYyvKF7ZYFtRtpy3TBfk3XlErEMdCoJa4R67FAafZsM=;
 b=HeonJnYfo6lpJrlfdiwo0ELczMbbuKdp/SAN4m8hzyIj0cqTHtDxjGdYVdgV5eHY6p+ck5z3dq5u5sHL1A1cwYCtEv2uGHB/43PrPQPDxptthe7y3hUo2HG83W+9I60L/iThgwkuS9SWtUYOcbIrHPNhEvUjy0TQnAwSOoR9gTbinBpoDRM1NYdTM6RoRxlaowe0g1RD87903fs/B2T886232ZmJGpzqGMCZhYvzYhKJA5n8lVJoVV3/CHp6+iQLp3mAXVbvDSnJDo/3bLIHttpwkyTuZu6/rFVVo0WXn3BQibJzH5v25DQo3iXcLjfRCxxXWdmo+8SYZr6ppGDEZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYyvKF7ZYFtRtpy3TBfk3XlErEMdCoJa4R67FAafZsM=;
 b=jskAPTYFnMaNcbazTjCNSXcqe0jZgMh0K9MAo5+shslRdrfuegwIkqKCTne3w1f0uCJmN0jKdg9Ako8npbQfCUUVdYMySR7LyJCUgt2+pR0UjEhRtALvjEwPcjY4SbCNQQoHErG1cKRil1z8HGFgo6ZgTTWR6yWjZ0E+nuHJV7C59sia4aY6x9kfkLsdV5MD+AwxjwVrBJ2xOPTnod7OSgM1ox96Ge8OfbXhu8Pt/M8/JQ2nnAiVr6TANFkqBjJ4BHHjkirxRDSad9czNP7dJifziF2Icom4JD6AHaygoTcI3gO2v1++Kvxa/Ya/pW01AFyM/QHkcQwOpWiS/4is2Q==
Received: from BLAPR03CA0115.namprd03.prod.outlook.com (2603:10b6:208:32a::30)
 by LV3PR12MB9120.namprd12.prod.outlook.com (2603:10b6:408:1a3::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 11:49:24 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::63) by BLAPR03CA0115.outlook.office365.com
 (2603:10b6:208:32a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 11:49:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 11:49:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:49:11 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:49:08 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v6 17/31] hw/arm/tegra241-cmdqv: mmap VINTF Page0 for CMDQV
Date: Mon, 1 Jun 2026 12:42:07 +0100
Message-ID: <20260601114221.457995-18-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601114221.457995-1-skolothumtho@nvidia.com>
References: <20260601114221.457995-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|LV3PR12MB9120:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f8f6971-2728-4228-baf3-08debfd3d356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|3023799007|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: FVO6BeIfLn5qGEDqeDKgMIXaqmghcZ/uaTK2HFxsxci5Qal7+HW1RPo9G1gSnI/JPJo8MgPCOgZAJvhM239zkFEuEp0ygVJ5AHnOojwcOLuhUso8k3xQh+fYdMZTy/HHi/e+/YSiUs4IFprqF0IKDx061+NqMu8bk+igkhWl7UkDmOKjWXzS6kS++LtIK565ILKsL/gKEKQX/LcSGDPOXQ2qXVJVr6BNuSBm9CqSYFZMfcLovc3/Ek6Iss7jNUNuVbD+/qmpjl+zUMP/hq8I0c9lVkvKKJDPd+/am9uiZZQ9u2d2TPFoF5Ek8ZjFkGUI7Vu0dd75ByATdk+oypDFrOjMxBCBEEgv1P0eHAoeBM1fIxLfaPNlL8456VXORhXv3uMZqAtuMgRYyDM0ZzJzXHl/Irw/MlAcx5fE9RDsnHa+TOYfpbEwgqJpxBp82G36Qf0OVQPaSEbaVaqK1+ZxSxB1lS1A2PzjuBhl3zfcl4xIvDbQpfjYtlPpbkT71Nap3FNhsrsjSW/Bn70s60NnCne9PuVCdExHMAqr0/XLxd9GkhpunsZVcK/gHUqwIproxy6Lf5RauLlLW0uaCDkON0nyKIRHwqy5t5eQ42xJ4lI7qt7mNXReUPB6CQ3U5Tl1AzRsafRbZgSKk9oM+s/ht0W2O06600oZ4dNByFyGtRORDH518ZVUfVbjlrxoSZfQKRiY/HW4daGvb9TaVvFrLXWWyEAqky3g2sxE2wiwyr8=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(3023799007)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PVCalIvoCcsQ9mlzFNbx2cs78E0nbk3FCUqqUKGd1OTu/vTyMftfW/331p6VIp/g4eLrqCocfdKF+EAB+dpCMrABCuArILtS7Q+QJ2AMqez0n+5C0PvlwTszkfqLpiipr5ystFVEWyMw7h6qlSbhXfllzJCnnr5h4K5xNdt3ozqSHfMWCmA0QQO7mVxh42iKFhGJKvvLv7v+O+P/5Hu/yYoTEhhCoKTtmIG0FZx6WO3sxIqbUZnZAPUvaNhQpa343DG1MuR9fmnXuTuW1g1CcrEd93s3EN7yC1vJ+D80Ao77EiKTHrWS8qJdN6aJ7QFTIOCksX9SWb8WxkJkfwPY7V3tQrc2nDG2gJ9oReFRnGGYgjVbgmpZa/s03cY1P0rlUgTxZZgp2A0eQQXj7MDNvrclje4katx5BKk5vqKUpyxGWD9EGYeeIxLICK9T5t6V
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 11:49:23.5921 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8f6971-2728-4228-baf3-08debfd3d356
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9120
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

The kernel currently exposes a single VINTF per emulated SMMUv3
instance. IOMMU_VIOMMU_ALLOC returns an mmap offset for the host
VINTF Page0 allocated for this SMMU. However, VCMDQs only become
bound to that VINTF after IOMMU_HW_QUEUE_ALLOC, so until then the
mapped Page0 does not back any real VCMDQ state.

When VINTF is enabled, mmap the kernel-provided Page0 region and set
STATUS.ENABLE_OK only if the mmap succeeds; unmap it when VINTF is
disabled. This prepares the VINTF mapping in advance of subsequent
patches that add VCMDQ allocation and the guest MMIO install.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.h |  3 +++
 hw/arm/tegra241-cmdqv.c | 50 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index ad7fb8725f..c4d327a9a5 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -37,6 +37,8 @@
 #define CMDQV_VINTF_PAGE1_BASE  0x40000
 #define CMDQV_VCMDQ_STRIDE      0x80
 
+#define VINTF_PAGE_SIZE 0x10000
+
 struct iommu_viommu_tegra241_cmdqv;
 
 typedef struct Tegra241CMDQV {
@@ -45,6 +47,7 @@ typedef struct Tegra241CMDQV {
     MemoryRegion mmio_cmdqv;
     qemu_irq irq;
     IOMMUFDVeventq *veventq;
+    void *vintf_page0;
 
     /* CMDQ-V Config page register cache */
     uint32_t config;
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 3cb1b45575..a52e153501 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -9,6 +9,8 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
 
 #include "hw/arm/smmuv3.h"
 #include "hw/arm/smmuv3-common.h"
@@ -218,8 +220,42 @@ static void tegra241_cmdqv_write_vcmdq_page1_64(Tegra241CMDQV *cmdqv,
                                            offset0, value);
 }
 
+static bool
+tegra241_cmdqv_munmap_vintf_page0(Tegra241CMDQV *cmdqv, Error **errp)
+{
+    if (!cmdqv->vintf_page0) {
+        return true;
+    }
+
+    if (munmap(cmdqv->vintf_page0, VINTF_PAGE_SIZE) < 0) {
+        error_setg_errno(errp, errno, "Failed to unmap VINTF page0");
+        return false;
+    }
+    cmdqv->vintf_page0 = NULL;
+    return true;
+}
+
+static bool tegra241_cmdqv_mmap_vintf_page0(Tegra241CMDQV *cmdqv, Error **errp)
+{
+    IOMMUFDViommu *viommu = cmdqv->s_accel->viommu;
+
+    if (cmdqv->vintf_page0) {
+        return true;
+    }
+
+    if (!iommufd_backend_viommu_mmap(viommu->iommufd, viommu->viommu_id,
+                                     VINTF_PAGE_SIZE,
+                                     cmdqv->cmdqv_data->out_vintf_mmap_offset,
+                                     &cmdqv->vintf_page0, errp)) {
+        return false;
+    }
+
+    return true;
+}
+
 static void tegra241_cmdqv_config_vintf_write(Tegra241CMDQV *cmdqv,
-                                              hwaddr offset, uint64_t value)
+                                              hwaddr offset, uint64_t value,
+                                              Error **errp)
 {
     int i;
 
@@ -234,8 +270,11 @@ static void tegra241_cmdqv_config_vintf_write(Tegra241CMDQV *cmdqv,
 
         cmdqv->vintf_config = value;
         if (value & R_VINTF0_CONFIG_ENABLE_MASK) {
-            cmdqv->vintf_status |= R_VINTF0_STATUS_ENABLE_OK_MASK;
+            if (tegra241_cmdqv_mmap_vintf_page0(cmdqv, errp)) {
+                cmdqv->vintf_status |= R_VINTF0_STATUS_ENABLE_OK_MASK;
+            }
         } else {
+            tegra241_cmdqv_munmap_vintf_page0(cmdqv, errp);
             cmdqv->vintf_status &= ~R_VINTF0_STATUS_ENABLE_OK_MASK;
         }
         break;
@@ -341,6 +380,7 @@ out:
 static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
                                        uint32_t value)
 {
+    Error *local_err = NULL;
     int index;
 
     switch (offset) {
@@ -359,7 +399,7 @@ static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
         cmdqv->cmdq_alloc_map[(offset - A_CMDQ_ALLOC_MAP_0) / 4] = value;
         break;
     case A_VINTF0_CONFIG ... A_VINTF0_LVCMDQ_ERR_MAP_3:
-        tegra241_cmdqv_config_vintf_write(cmdqv, offset, value);
+        tegra241_cmdqv_config_vintf_write(cmdqv, offset, value, &local_err);
         break;
     case A_VI_VCMDQ0_CONS_INDX ... A_VI_VCMDQ1_GERRORN:
         /*
@@ -398,6 +438,10 @@ static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
         qemu_log_mask(LOG_UNIMP, "%s unhandled write access at 0x%" PRIx64 "\n",
                       __func__, offset);
     }
+
+    if (local_err) {
+        error_report_err(local_err);
+    }
 }
 
 /*
-- 
2.43.0


