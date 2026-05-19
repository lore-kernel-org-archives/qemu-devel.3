Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C8DCD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHrh-0000xx-7J; Tue, 19 May 2026 06:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHrZ-0000sE-5R; Tue, 19 May 2026 06:39:49 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHrW-0006VV-QJ; Tue, 19 May 2026 06:39:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DoZCwZew2GanEj32NmmtXAoUlYwzXrI6I7PqHXc783d0+hIUdpybQCzmfoTBQDn6Q87KcoGID87LW/IeUyAGofvQXfJ8EFEItX35KS6WiX563jAKkcxwVJeHMNVT1n/RSD9dMecDT9sIs4MKzChQtst5iJqreW9NxU21NOrsiV5duU6xMQxRL/ehkJ8rmFd2f/1SQdyme8cJSCp4gGBNkowb4ASgPFiQXk+eg33BCaAr11aoHT+m4wmGqtECHR7kipVK4HTNAaSdBUZQ9IbrDjipypn+XqU64Hq2ATQkavIOp5fMzXDeCkduLRrUjTxCgtxTTWwPVsEcIVDrxRp5fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwdcdo9aVAUVCjZ9NEdw2HC9u+IoRqsxLjcTMtWkl74=;
 b=Lin9Gmk1hnLnY2dWxdnkXsa06oiMGmucTDYv3bN3fUdaXfAZyicyh5ATTfSOg10IWn0MZ5dpeS5Hvvw1ekxDkwvxRsZdOEg60Xq7Up0EWz8hpkpXx0tCxFOAFvVVFDyybJt6KaOSAh9399Jz5m472OVwaMgCvmhuP3UTxOz6KEZg2xnJmXobGFQTtCEKqAeau3KEOIvodx56ALlD6rwEnIiy4G8WDzTbNtStzn75BkI7Y/widZExAHCDIDvxcXUi3TNd+OuMRue+/afvjCKDyYxWuaB002xcdsZPiRv+id9vCQdIeSf7Qam6EsEuyvhZkTZS36rh90I+k3cgspLOCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwdcdo9aVAUVCjZ9NEdw2HC9u+IoRqsxLjcTMtWkl74=;
 b=KI+hMEk+1Pdco3octvipYRHE90yoZXTznXzX9QR98Pfsv86+cx17vJsR8gdZAeZpVf660isvo39EygrmEqFasIReTW9EQ3Dr/sqNzRjZqk8rLKhjACa/mRySCeU5DgL9Nbe0c0dClkc8bqcB/O7XqcIeHteWoqbIBKq+LmfG40gSdWcfJKaXzcadrZb10EX1jlmpywVDyVK/DMYGPtVDTVNvf99r++xNsk/u57QdWuEuLYU45LRBuoyD48ux46g+I4d8GfftqoOl4sfjwVv8tS9PQQEhnmQLerqlWQKRvsq2Z8t23xU1pE4vSGxYjzP+YwZo+smAh07yg/y2HDTouQ==
Received: from BL1PR13CA0170.namprd13.prod.outlook.com (2603:10b6:208:2bd::25)
 by PH7PR12MB7017.namprd12.prod.outlook.com (2603:10b6:510:1b7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 10:39:36 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:2bd:cafe::45) by BL1PR13CA0170.outlook.office365.com
 (2603:10b6:208:2bd::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.15 via Frontend Transport; Tue, 19
 May 2026 10:39:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 10:39:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:39:19 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:39:15 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v5 16/32] hw/arm/tegra241-cmdqv: Emulate VCMDQ register writes
Date: Tue, 19 May 2026 11:36:54 +0100
Message-ID: <20260519103727.899332-17-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519103727.899332-1-skolothumtho@nvidia.com>
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|PH7PR12MB7017:EE_
X-MS-Office365-Filtering-Correlation-Id: 69b5ad91-49cb-431b-3ce0-08deb592ebd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|22082099003|11063799006|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: 2pIimYyymbPXf6iTVJjUFRhk8CPoVM0KY7OM0q0rIxPibiYjARO2oXjok9NJBfHzbUu91WTu/7eUA4nYdIyZ+Qw5/ub5E0wsQlf9+lVcVBCkDU+ZpfZNyYMbT8J9fOoA7jJ9ngn/sfCPTaDwfHs9ROVyvk8jZlEX0nkSeO8EPKOM6KCM86/UIdeI5lXHgphkE8vORXzyJuCHDSXgp/Kof9OIn5PV33I19FjsKzm77G64qqzgr0XHviWHVaJ8gd/TMRxiueUWJ5cLdLD+lf88yCp4CpReRLQ9GmWBbhdXdpyehcNV0fvJ5JOSqgabJkAIt10nYbi0bzrCAiX8jREyEHDVu6a2iQU1uHwthW9Qb6xOP2osBhEk9+CGY+CRokZtHxFFoHRMaXlF9MVG+bP9Q2Wfr9dcvBABpzmdpGCp0xq9h8vsE9rxNM0xkdNvCe+gwXNmxKY5J+ol+pSu3/IEA00/z76zoUvYOxtPMWd8x39JltPz+PBLAn/TQQQAyPQHsK73e5rqqF1sdpyfNUlufSLqr7Rb9MYAzx/WiJ2D3fSmxZW0deZj26quJcB6RwqwuA6NfYLhhyLrzhwXMqEFUT0a7+dhXxXdESvP6KEMdNMKer1oVuhEVth7QTsNbWEeYZyKoKnNCRhrdMcZQTzAkx+9YoHXomYzUDn3oaRH7vabFVy8cpUP1epDLQTcFbBiIjIvp62e4jyvI61g7mAhGKf1MYRLhCfQmVIUwD7xwVo=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(22082099003)(11063799006)(18002099003)(56012099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XGwUbjl8DI+EOfhHNzzUxiwdXuF3X5SPg+8c6Zi0VOFws5NkoeQQxiI8hRqW4nxfIHIPBeT6BpgsFgsZlXweRvMO5YPIBhTqYBd1IpxLOaMWvyTwIyCS7MQS8cWXnRMnCfLjzaA4En2rGOtoq/6mnW2BYqVvbhFt/lpX49KgAJKPoTlrJMl5T8w4pyrBvnnDHO2A+X7gF/cc5Xg5WB/eAM5hJ2gNxOXQsVwpQEde6S0TQx7aPoBybl1Olkt6HscilaZZnqFYypY7hDlWIgXRBol/RuKkuYa+cGNE8/QZC7+s926wL1ebLOIgaJ7xagNUjbLadiIUro3BuSZLvGvDmVWIHT53f3z/P9+/eqVtXfuA46tndVmIwG/y4xMl3hoGuMLCh8nUWnRHUyWjMWI2pn2iVGsPm5jDJyXwYnHRzOhFmkHsE1kHbzIgFKrb/vse
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:39:35.7654 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b5ad91-49cb-431b-3ce0-08deb592ebd4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7017
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

This is the write side counterpart of the VCMDQ read emulation. Add
write handling for both the direct VCMDQ aperture and the VINTF
logical aperture using the same index decoding and VINTF-to-VCMDQ
translation logic as the read path.

VINTF aperture writes are translated to their direct-aperture
equivalent and update the same cached state. Page 1 registers
(BASE, CONS_INDX_BASE) always update the cache. Once
IOMMU_HW_QUEUE_ALLOC and viommu_mmap are wired up in a subsequent
patch, Page 0 register writes will be forwarded to the hardware-
backed mmap'd page.

Ignore VCMDQ BASE writes if the VCMDQ is already enabled.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.c | 164 +++++++++++++++++++++++++++++++++++++++-
 hw/arm/trace-events     |   2 +
 2 files changed, 164 insertions(+), 2 deletions(-)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index f859126ad6..5d2d9d2e26 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -16,6 +16,16 @@
 #include "tegra241-cmdqv.h"
 #include "trace.h"
 
+/*
+ * Returns true if the per-VCMDQ CMDQ_EN_OK bit is set.
+ */
+static bool tegra241_vcmdq_enabled(Tegra241CMDQV *cmdqv, int index)
+{
+    uint32_t status = cmdqv->vcmdq_status[index];
+
+    return status & R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
+}
+
 /*
  * Read a VCMDQ Page 0 register (control/status) using VCMDQ0_* offsets.
  *
@@ -116,6 +126,108 @@ static uint64_t tegra241_cmdqv_config_vintf_read(Tegra241CMDQV *cmdqv,
     }
 }
 
+/*
+ * Write a VCMDQ Page 0 register (control/status) using VCMDQ0_* offsets.
+ *
+ * The caller normalizes the MMIO offset such that @offset0 always refers
+ * to a VCMDQ0_* register, while @index selects the VCMDQ instance.
+ *
+ * Page 0 registers are all 32-bit; this helper is only called for 4-byte
+ * writes.
+ */
+static void tegra241_cmdqv_write_vcmdq_page0(Tegra241CMDQV *cmdqv,
+                                             hwaddr offset0, int index,
+                                             uint32_t value)
+{
+    switch (offset0) {
+    case A_VCMDQ0_CONS_INDX:
+        cmdqv->vcmdq_cons_indx[index] = value;
+        break;
+    case A_VCMDQ0_PROD_INDX:
+        cmdqv->vcmdq_prod_indx[index] = value;
+        break;
+    case A_VCMDQ0_CONFIG:
+        if (value & R_VCMDQ0_CONFIG_CMDQ_EN_MASK) {
+            cmdqv->vcmdq_status[index] |= R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
+        } else {
+            cmdqv->vcmdq_status[index] &= ~R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
+        }
+        cmdqv->vcmdq_config[index] = value;
+        break;
+    case A_VCMDQ0_GERRORN:
+        cmdqv->vcmdq_gerrorn[index] = value;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s unhandled write access at 0x%" PRIx64 "\n",
+                      __func__, offset0);
+    }
+    trace_tegra241_cmdqv_write_vcmdq_page0(index, offset0, value);
+}
+
+/*
+ * Write a VCMDQ Page 1 register (base / DRAM address) - 4-byte access.
+ */
+static void tegra241_cmdqv_write_vcmdq_page1(Tegra241CMDQV *cmdqv,
+                                             hwaddr offset0, int index,
+                                             uint32_t value)
+{
+    switch (offset0) {
+    case A_VCMDQ0_BASE_L:
+        if (tegra241_vcmdq_enabled(cmdqv, index)) {
+            return;
+        }
+        cmdqv->vcmdq_base[index] =
+            deposit64(cmdqv->vcmdq_base[index], 0, 32, value);
+        break;
+    case A_VCMDQ0_BASE_H:
+        if (tegra241_vcmdq_enabled(cmdqv, index)) {
+            return;
+        }
+        cmdqv->vcmdq_base[index] =
+            deposit64(cmdqv->vcmdq_base[index], 32, 32, value);
+        break;
+    case A_VCMDQ0_CONS_INDX_BASE_DRAM_L:
+        cmdqv->vcmdq_cons_indx_base[index] =
+            deposit64(cmdqv->vcmdq_cons_indx_base[index], 0, 32, value);
+        break;
+    case A_VCMDQ0_CONS_INDX_BASE_DRAM_H:
+        cmdqv->vcmdq_cons_indx_base[index] =
+            deposit64(cmdqv->vcmdq_cons_indx_base[index], 32, 32, value);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s unhandled write access at 0x%" PRIx64 "\n",
+                      __func__, offset0);
+    }
+    trace_tegra241_cmdqv_write_vcmdq_page1(index, offset0, value);
+}
+
+/*
+ * Write a VCMDQ Page 1 register - 8-byte access at BASE_L or DRAM_L.
+ */
+static void tegra241_cmdqv_write_vcmdq_page1_64(Tegra241CMDQV *cmdqv,
+                                                hwaddr offset0, int index,
+                                                uint64_t value)
+{
+    switch (offset0) {
+    case A_VCMDQ0_BASE_L:
+        if (tegra241_vcmdq_enabled(cmdqv, index)) {
+            return;
+        }
+        cmdqv->vcmdq_base[index] = value;
+        break;
+    case A_VCMDQ0_CONS_INDX_BASE_DRAM_L:
+        cmdqv->vcmdq_cons_indx_base[index] = value;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s unhandled 64-bit write at 0x%" PRIx64 "\n",
+                      __func__, offset0);
+    }
+    trace_tegra241_cmdqv_write_vcmdq_page1(index, offset0, value);
+}
+
 static void tegra241_cmdqv_config_vintf_write(Tegra241CMDQV *cmdqv,
                                               hwaddr offset, uint64_t value)
 {
@@ -235,6 +347,8 @@ out:
 static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
                                        uint32_t value)
 {
+    int index;
+
     switch (offset) {
     case A_CONFIG:
         cmdqv->config = value;
@@ -253,6 +367,33 @@ static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
     case A_VINTF0_CONFIG ... A_VINTF0_LVCMDQ_ERR_MAP_3:
         tegra241_cmdqv_config_vintf_write(cmdqv, offset, value);
         break;
+    case A_VI_VCMDQ0_CONS_INDX ... A_VI_VCMDQ1_GERRORN:
+        /*
+         * VINTF Page0 registers are hardware aliases of VCMDQ Page0 registers.
+         * Translate the VINTF aperture offset to its VCMDQ Page0 equivalent
+         * and fall through to the Page0 dispatch below.
+         */
+        offset -= CMDQV_VINTF_PAGE0_BASE - CMDQV_VCMDQ_PAGE0_BASE;
+        QEMU_FALLTHROUGH;
+    case A_VCMDQ0_CONS_INDX ... A_VCMDQ1_GERRORN:
+        /*
+         * Decode a per-VCMDQ Page 0 access. Each VCMDQ occupies a
+         * CMDQV_VCMDQ_STRIDE-byte window; extract the index and normalize
+         * to the VCMDQ0_* offset before calling the Page 0 helper.
+         */
+        index = (offset - CMDQV_VCMDQ_PAGE0_BASE) / CMDQV_VCMDQ_STRIDE;
+        tegra241_cmdqv_write_vcmdq_page0(cmdqv,
+                offset - index * CMDQV_VCMDQ_STRIDE, index, value);
+        break;
+    case A_VI_VCMDQ0_BASE_L ... A_VI_VCMDQ1_CONS_INDX_BASE_DRAM_H:
+        /* Same VINTF-to-VCMDQ translation as VINTF Page0 case above. */
+        offset -= CMDQV_VINTF_PAGE1_BASE - CMDQV_VCMDQ_PAGE1_BASE;
+        QEMU_FALLTHROUGH;
+    case A_VCMDQ0_BASE_L ... A_VCMDQ1_CONS_INDX_BASE_DRAM_H:
+        index = (offset - CMDQV_VCMDQ_PAGE1_BASE) / CMDQV_VCMDQ_STRIDE;
+        tegra241_cmdqv_write_vcmdq_page1(cmdqv,
+                offset - index * CMDQV_VCMDQ_STRIDE, index, value);
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s unhandled write access at 0x%" PRIx64 "\n",
                       __func__, offset);
@@ -260,14 +401,33 @@ static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
 }
 
 /*
- * 8-byte MMIO write handler.
+ * 8-byte MMIO write handler. Only Page 1 BASE / CONS_INDX_BASE_DRAM accept
+ * full 64-bit writes; other offsets are write-ignored.
  */
 static void tegra241_cmdqv_writell_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
                                         uint64_t value)
 {
-    qemu_log_mask(LOG_UNIMP,
+    int index;
+
+    switch (offset) {
+    case A_VI_VCMDQ0_BASE_L ... A_VI_VCMDQ1_CONS_INDX_BASE_DRAM_H:
+        /*
+         * VINTF Page1 registers are hardware aliases of VCMDQ Page1 registers.
+         * Translate the VINTF aperture offset to its VCMDQ Page1 equivalent
+         * and fall through to the Page1 dispatch below.
+         */
+        offset -= CMDQV_VINTF_PAGE1_BASE - CMDQV_VCMDQ_PAGE1_BASE;
+        QEMU_FALLTHROUGH;
+    case A_VCMDQ0_BASE_L ... A_VCMDQ1_CONS_INDX_BASE_DRAM_H:
+        index = (offset - CMDQV_VCMDQ_PAGE1_BASE) / CMDQV_VCMDQ_STRIDE;
+        tegra241_cmdqv_write_vcmdq_page1_64(cmdqv,
+                offset - index * CMDQV_VCMDQ_STRIDE, index, value);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP,
                       "%s unhandled 64-bit write at 0x%" PRIx64 " (WI)\n",
                       __func__, offset);
+    }
 }
 
 static void tegra241_cmdqv_write_mmio(void *opaque, hwaddr offset,
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 8c34a04b24..c4262bb2be 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -77,6 +77,8 @@ tegra241_cmdqv_read_mmio(uint64_t offset, uint64_t val, unsigned size) "offset:
 tegra241_cmdqv_write_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
 tegra241_cmdqv_read_vcmdq_page0(int index, uint64_t offset0, uint64_t val) "vcmdq[%d] page0 offset0: 0x%"PRIx64" val: 0x%"PRIx64
 tegra241_cmdqv_read_vcmdq_page1(int index, uint64_t offset0, uint64_t val) "vcmdq[%d] page1 offset0: 0x%"PRIx64" val: 0x%"PRIx64
+tegra241_cmdqv_write_vcmdq_page0(int index, uint64_t offset0, uint64_t val) "vcmdq[%d] page0 offset0: 0x%"PRIx64" val: 0x%"PRIx64
+tegra241_cmdqv_write_vcmdq_page1(int index, uint64_t offset0, uint64_t val) "vcmdq[%d] page1 offset0: 0x%"PRIx64" val: 0x%"PRIx64
 
 # strongarm.c
 strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
-- 
2.43.0


