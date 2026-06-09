Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E7ECD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:29:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWuda-0000v6-Fz; Tue, 09 Jun 2026 07:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWudB-0007E7-At; Tue, 09 Jun 2026 07:28:29 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWud9-00036I-6W; Tue, 09 Jun 2026 07:28:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPEgHUzS5w5AaELVTJiinwFVm7GNGQ9V+kk/3d5hpGnarkHKlrpys3FdrDe65hXUCiB4P6OHNLiP8jOT3srp36OEDAV1WaZVVhupFMNYpRBo2WqEEY0VJd1slVkYz5GZdQJzs76ZPWOaD9nbIt0HWMca7UWYiXcNx7udR0G2yI3gaCBGvnOeRuKwyavM+8PKLOYsa1TeeCvi4wo9BQ03aXsIpNnjWSWRIYvWlZDflcfXkauWwhaAvSI7MmtVpgwzO5fGNfz4+t1Vjq9lQwUx/8WugMGmvqdauQeQSHyOTPy7TfEX+qdYTBpH5kdAC5YpYry4Jg+eXcP1dTVLHf2exQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MsxMyb9VyIvpgdwMWuYM8ziGy838HJaE6BWEjdXwPb0=;
 b=h20iInvmnfOCiPLJ9JhQxj7zLxT1/ezxuHUx+eui/kY33lJE9xuWuc0X1dfin3TXng+Y0+RQ8eA/6afPqPzS/QwXbFNzCePMW/rvk/cMegi3QEueI09fon2WlP60ZNRxGo/ajLs+dAFchlvWQ59NKshrhgDWV85eb+j+gX/JuQ2kQJ1wuuqMOXgpr6q3DvyJccRwC7XwchQre4zCY9kzlWcsctJ9DlJne4CB5rCfG58A8oy/ynjAxRgwlIWeq1sfvtxuidCFj4vUj1nkL7Anqj5h6pHa5KHO0vqMChaVDexdU8jOk4I4ZM29qhfklmGAgQX9b0CilIZRqnVTZLKsxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsxMyb9VyIvpgdwMWuYM8ziGy838HJaE6BWEjdXwPb0=;
 b=dLxPE2VluOjgydMfsJYuahNgLVYXGDEnD9qwLkaQ7xAdmc9UsMoU6vTR5O6cceS6FfFSyb8bC+XVvcOh3YQ/hNBT1HudEGROqK97H726rT5HBxJqs5YfOHEZsVDHX1zd80S31AT9CRqr7y6qMYNlMdIBCzHG6QxNABVAY+Hp9U0jsP4XQ8ojSQZmZRwE/pSLfpZn5Lb2UUfQyMHqa65Sm023yIKZteAyjc25axVR/04jMzpGoJjAbOm5cCj7zyMQ1T4abM+ctsOwDplBNgAwKi3Q807uNa+KUGgAhoD2jBXoXacvVsooK1XM8gLsnBDzb625ZgfFRPdwncQY5BgsVA==
Received: from MW4PR03CA0134.namprd03.prod.outlook.com (2603:10b6:303:8c::19)
 by DM4PR12MB6472.namprd12.prod.outlook.com (2603:10b6:8:bc::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.14; Tue, 9 Jun 2026 11:28:19 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:303:8c:cafe::2b) by MW4PR03CA0134.outlook.office365.com
 (2603:10b6:303:8c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 11:28:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 11:28:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:28:00 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:27:56 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v7 19/31] hw/arm/tegra241-cmdqv: Route allocated VCMDQ Page0
 accesses to the mmap'd host VINTF page0
Date: Tue, 9 Jun 2026 12:25:40 +0100
Message-ID: <20260609112552.378999-20-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609112552.378999-1-skolothumtho@nvidia.com>
References: <20260609112552.378999-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|DM4PR12MB6472:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ace2da6-572a-4762-73da-08dec61a34fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|18002099003|22082099003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: vgeMOnzlgCAZ+7ZYCgds30b7FGF1AZt7aAo7MA/6RtA4KZgMbD9vcTCMpL88pX7zt0aFPTCObALL5Pw5pCwGNSVMskrWpqrZDTr+LlbRud6TAXDT+jST+0x6dXEG4mo3qitNOWJIDMLh+W18w967zRhcHd06BInAzsFJXfd25MSdPAMVoRUIWucDhivC399RRMp2H3nxiWXiFt0gRMSlY8IjjbJAQxz9BOr35rBzPyktOBqI/r/rGIVBF6ws3vD/N7EsdTcNKSQxAOGKCAZRaMkEJPILpkrl9ug0AWpEhIwYucxW7Mv7eJ5v+bJ5eRbfMz10Y7N1g5inxmc1kGliww1Dplol/jPw5RpZ2aMK4BllPlcJxgy8X4C5LYea9BRPs4dJRVFnL2x6c/Bk3Wixjhap+d9fvzhZDX/P/ndkDFSFsEQI0bZzJMBHq2IG53rnh8weZPSWoXdtPmcoYzX0BDKx6G8JSXJPYO34x5CO1JE28XRslNeQt2jsG7olR+TdfinnyTleOeId0D8cfoGZqS8cHrV90hsRnYXIkx43cGfp/BXX8sbsDFEvhWXrVB++XbjIucMFm7Wrb/0DVAOWc/SDCodJ26eYOcHs4Nat8Kk85cFvhoswIPpsKY/uz+mMPK62bK9YM5jv8rEFSNIc9qTxho6CIY6l6VIrFXYpvlvQlONINtxDE+IFpOMrnYPnudoCV/w+wMQtX3WjQkN36wZmejK9VmsZznJWOlBrHf0=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(22082099003)(56012099006)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /lMXAKOjnRz/ltPhz6dxSPBn4bdeX9kIyIl9eGKTrzlm1TYU0e4YFb0YxM1fXAMkf8hg7TAdeVUyY4SzkkiTh5X4lH4BsvxSisZ0HDKubAuWesyhhRBLTSocjEnHbuBQYz3jWza8m34MfJuOcWjcMY35o/RZpXFiUdXGRlWUuT8K7jyzOz8TxNya8r+x6f/8oR35jQKFYkb+2f6shO9VDyXal1Pk5UCc3PzEVqPnhtBvA7Mqux3X0maL1tko2t8SkOSE+FORD6DXuXRyTFWKP99ljVoQMbgwGyW/ydZ4PvoqlO//x/taj1mL3LJPxvRKl3LSCcMks10XV5+z4nbSOd7CA50kUqZf8Zjz8IOvEmUCCIPEyGyb0pK7qmtTv0E2nDqqt6tnn8ZwIOwpKpDw5dNA8FvkNGI3DKtr/GL4dHSEnhXm/0HaSPCjo3VJobLi
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 11:28:19.2017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ace2da6-572a-4762-73da-08dec61a34fa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6472
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
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

Introduce tegra241_cmdqv_vintf_lvcmdq_ptr() to route VCMDQ Page 0
register accesses through the mmap'd host VINTF Page 0 backing once a
hardware queue has been allocated for the VCMDQ.

The two QEMU-trapped Page 0 apertures (direct at 0x10000, VINTF at
0x30000) are hardware aliases of the same underlying registers. A
subsequent patch installs the VINTF aperture as a RAM-device into
guest MMIO; in this patch both remain QEMU-trapped.

The direct VCMDQ aperture stays QEMU-trapped (rather than aliased
to the VINTF mmap) so that writes to an unallocated VCMDQ remain
well-defined. The CMDQV architecture allows software to program a
VCMDQ through the direct aperture without first allocating it to a
VINTF; aliasing to the VINTF mmap would route those writes into
unallocated logical slots where the hardware silently drops them.

A VCMDQ Page 0 access is served from one of two sources:

  - Cache-backed: no hw_queue is allocated for the VCMDQ
    (HW_QUEUE_ALLOC has not yet succeeded). Both apertures use
    QEMU's register cache.

  - HW-backed: HW_QUEUE_ALLOC has succeeded. Both apertures access
    the registers directly through the mmap'd host VINTF Page 0.

tegra241_cmdqv_sync_vcmdq() copies any cached writes (CONS_INDX,
PROD_INDX, CONFIG, GERRORN) into the mmap'd page on the cache-to-HW
transition so the guest's earlier register state survives. Freeing a
VCMDQ clears the cached Page0 registers.

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.c | 89 +++++++++++++++++++++++++++++++++++++++++
 hw/arm/trace-events     |  4 +-
 2 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 8cb39e87c4..63fe0ac681 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -16,6 +16,16 @@
 #include "tegra241-cmdqv.h"
 #include "trace.h"
 
+static void tegra241_cmdqv_reset_vcmdq_cache(Tegra241CMDQV *cmdqv, int index)
+{
+    cmdqv->vcmdq_cons_indx[index] = 0;
+    cmdqv->vcmdq_prod_indx[index] = 0;
+    cmdqv->vcmdq_config[index] = 0;
+    cmdqv->vcmdq_status[index] = 0;
+    cmdqv->vcmdq_gerror[index] = 0;
+    cmdqv->vcmdq_gerrorn[index] = 0;
+}
+
 static void tegra241_cmdqv_free_vcmdq(Tegra241CMDQV *cmdqv, int index)
 {
     IOMMUFDViommu *viommu = cmdqv->s_accel->viommu;
@@ -27,6 +37,7 @@ static void tegra241_cmdqv_free_vcmdq(Tegra241CMDQV *cmdqv, int index)
     iommufd_backend_free_id(viommu->iommufd, vcmdq->hw_queue_id);
     g_free(vcmdq);
     cmdqv->vcmdq[index] = NULL;
+    tegra241_cmdqv_reset_vcmdq_cache(cmdqv, index);
 }
 
 /*
@@ -45,6 +56,47 @@ static bool tegra241_cmdqv_vcmdq_ready_to_alloc(Tegra241CMDQV *cmdqv, int index)
            tegra241_cmdqv_enabled(cmdqv) && tegra241_vintf_enabled(cmdqv);
 }
 
+/*
+ * Return a pointer into the mmap'd VINTF page0 for the VCMDQ Page 0
+ * register at @offset0 in VCMDQ slot @index, or NULL when the VCMDQ
+ * has no hw_queue allocated or the host VINTF page0 is not mmap'd.
+ */
+static inline uint32_t *tegra241_cmdqv_vintf_lvcmdq_ptr(Tegra241CMDQV *cmdqv,
+                                                 int index, hwaddr offset0)
+{
+    if (!cmdqv->vcmdq[index] || !cmdqv->vintf_page0) {
+        return NULL;
+    }
+    return (uint32_t *)(cmdqv->vintf_page0 +
+                        (index * CMDQV_VCMDQ_STRIDE) +
+                        (offset0 - CMDQV_VCMDQ_PAGE0_BASE));
+}
+
+/*
+ * Flush cached register writes into the mmap'd host VINTF page0 after a
+ * successful HW_QUEUE_ALLOC, so the guest's earlier writes survive
+ * the cache-to-hardware transition.
+ */
+static void tegra241_cmdqv_sync_vcmdq(Tegra241CMDQV *cmdqv, int index)
+{
+    uint32_t *ptr;
+
+    ptr = tegra241_cmdqv_vintf_lvcmdq_ptr(cmdqv, index, A_VCMDQ0_CONS_INDX);
+    if (!ptr) {
+        return;
+    }
+    *ptr = cmdqv->vcmdq_cons_indx[index];
+
+    ptr = tegra241_cmdqv_vintf_lvcmdq_ptr(cmdqv, index, A_VCMDQ0_PROD_INDX);
+    *ptr = cmdqv->vcmdq_prod_indx[index];
+
+    ptr = tegra241_cmdqv_vintf_lvcmdq_ptr(cmdqv, index, A_VCMDQ0_CONFIG);
+    *ptr = cmdqv->vcmdq_config[index];
+
+    ptr = tegra241_cmdqv_vintf_lvcmdq_ptr(cmdqv, index, A_VCMDQ0_GERRORN);
+    *ptr = cmdqv->vcmdq_gerrorn[index];
+}
+
 /*
  * Allocate a host HW VCMDQ from the current cached BASE / size for @index.
  * No-op (returns true) until the VCMDQ is ready to be allocated.
@@ -85,6 +137,9 @@ static bool tegra241_cmdqv_setup_vcmdq(Tegra241CMDQV *cmdqv, int index,
     cmdqv->vcmdq_gerror[index] &= ~R_VCMDQ0_GERROR_CMDQ_INIT_ERR_MASK;
     cmdqv->vcmdq_status[index] |= R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
 
+    /* Push cached writes to HW; freeing resets the cache. */
+    tegra241_cmdqv_sync_vcmdq(cmdqv, index);
+
     return true;
 }
 
@@ -111,13 +166,23 @@ static void tegra241_cmdqv_setup_all_vcmdq(Tegra241CMDQV *cmdqv,
  *
  * The caller normalizes the MMIO offset such that @offset0 always refers
  * to a VCMDQ0_* register, while @index selects the VCMDQ instance.
+ *
+ * If the VCMDQ is allocated and the host VINTF page0 is mmap'd, read
+ * directly from the host VINTF page0 backing. Otherwise, fall back to
+ * the cache.
  */
 static uint64_t tegra241_cmdqv_read_vcmdq_page0(Tegra241CMDQV *cmdqv,
                                                 hwaddr offset0, int index,
                                                 bool direct)
 {
+    uint32_t *ptr = tegra241_cmdqv_vintf_lvcmdq_ptr(cmdqv, index, offset0);
     uint64_t val = 0;
 
+    if (ptr) {
+        val = *ptr;
+        goto out;
+    }
+
     switch (offset0) {
     case A_VCMDQ0_CONS_INDX:
         val = cmdqv->vcmdq_cons_indx[index];
@@ -142,7 +207,9 @@ static uint64_t tegra241_cmdqv_read_vcmdq_page0(Tegra241CMDQV *cmdqv,
                       "%s unhandled read access at 0x%" PRIx64 "\n",
                       __func__, offset0);
     }
+out:
     trace_tegra241_cmdqv_read_vcmdq_page0(index, direct ? "direct" : "vi",
+                                          ptr ? "hw" : "cache",
                                           offset0, val);
     return val;
 }
@@ -218,11 +285,31 @@ static uint64_t tegra241_cmdqv_config_vintf_read(Tegra241CMDQV *cmdqv,
  *
  * Page 0 registers are all 32-bit; this helper is only called for 4-byte
  * writes.
+ *
+ * If the VCMDQ is allocated and the host VINTF page0 is mmap'd, write
+ * directly to the VINTF page0 backing. Otherwise, update the cache.
  */
 static void tegra241_cmdqv_write_vcmdq_page0(Tegra241CMDQV *cmdqv,
                                              hwaddr offset0, int index,
                                              uint32_t value, bool direct)
 {
+    uint32_t *ptr = tegra241_cmdqv_vintf_lvcmdq_ptr(cmdqv, index, offset0);
+    bool hw = false;
+
+    if (ptr) {
+        switch (offset0) {
+        case A_VCMDQ0_CONS_INDX:
+        case A_VCMDQ0_PROD_INDX:
+        case A_VCMDQ0_CONFIG:
+        case A_VCMDQ0_GERRORN:
+            *ptr = value;
+            hw = true;
+            goto out;
+        default:
+            break;
+        }
+    }
+
     switch (offset0) {
     case A_VCMDQ0_CONS_INDX:
         cmdqv->vcmdq_cons_indx[index] = value;
@@ -253,7 +340,9 @@ static void tegra241_cmdqv_write_vcmdq_page0(Tegra241CMDQV *cmdqv,
                       "%s unhandled write access at 0x%" PRIx64 "\n",
                       __func__, offset0);
     }
+out:
     trace_tegra241_cmdqv_write_vcmdq_page0(index, direct ? "direct" : "vi",
+                                           hw ? "hw" : "cache",
                                            offset0, value);
 }
 
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 666967dc5e..a8dcbc82db 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -75,9 +75,9 @@ smmuv3_accel_install_ste(uint32_t vsid, const char * type, uint32_t hwpt_id) "vS
 # tegra241-cmdqv
 tegra241_cmdqv_read_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
 tegra241_cmdqv_write_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
-tegra241_cmdqv_read_vcmdq_page0(int index, const char *aperture, uint64_t offset0, uint64_t val) "vcmdq[%d] %s offset0: 0x%"PRIx64" val: 0x%"PRIx64
+tegra241_cmdqv_read_vcmdq_page0(int index, const char *aperture, const char *backing, uint64_t offset0, uint64_t val) "vcmdq[%d] %s (%s) offset0: 0x%"PRIx64" val: 0x%"PRIx64
 tegra241_cmdqv_read_vcmdq_page1(int index, const char *aperture, uint64_t offset0, uint64_t val) "vcmdq[%d] %s offset0: 0x%"PRIx64" val: 0x%"PRIx64
-tegra241_cmdqv_write_vcmdq_page0(int index, const char *aperture, uint64_t offset0, uint64_t val) "vcmdq[%d] %s offset0: 0x%"PRIx64" val: 0x%"PRIx64
+tegra241_cmdqv_write_vcmdq_page0(int index, const char *aperture, const char *backing, uint64_t offset0, uint64_t val) "vcmdq[%d] %s (%s) offset0: 0x%"PRIx64" val: 0x%"PRIx64
 tegra241_cmdqv_write_vcmdq_page1(int index, const char *aperture, uint64_t offset0, uint64_t val) "vcmdq[%d] %s offset0: 0x%"PRIx64" val: 0x%"PRIx64
 
 # strongarm.c
-- 
2.43.0


