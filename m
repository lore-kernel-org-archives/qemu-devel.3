Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBA8CD8CAA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWudW-0000ac-Ca; Tue, 09 Jun 2026 07:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWud5-000776-NI; Tue, 09 Jun 2026 07:28:27 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWud3-00035F-FA; Tue, 09 Jun 2026 07:28:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPAmgbHTdUJd2tB/BG5Zsn/3aSv5xv6ye54C2r2lYr/3Or0ynY1ZnNf7mL1slFDbhjsLW2s3G3FT9SYldfbnBaZxw4HatqQf7e7GlDgq0fmze9KdpFAjTdQiduqnF5bkT22MwOBuBjs4Ob7KtixvldM5MntCSXCMxTLgQcQrqoN/adAZTuGDPelXhL0HGNrdshHCxTBUuOgdOZ3NZ3w8zSR1kAfJPpx8bAMcf4Hpte/gm5gUAiHq9z1i/qt/PwqoCSXfOyfX8cI+urhh/Ma/TEIdqxmjV8P4fqPRHip41nPxvE7mWMk039mq8OXg1qX1SoOr2UChkL3Vd/jvWFHG/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OeHsCrLD9kEpqjKF7Mcr0MtSWbagKqAXRVoq3VIAqNQ=;
 b=MGcrR1iYvgm2tRUED86qnDtpDyuWrOzweVBIj7fSdHB9m7R1W1EueaupHjKfOuq1H5ApdXcSCKMNNUROlrmgBu5Zcs5LPT9IHZBqk1vcqV04UUuRKJ4SB0rQ5ttF6SpjQdIYzIP9FoX/fuGEbEgZ5PNFOsJN2taDJP31hfBbA0VVlNAAk4s9ur/RAAEa+wLwgzO3WxIV/HndAghAWkJB/MeEJzK0yIShWT4jeg/0YvnCL/AViGK5SNHeRlnLYj1vfoi25PvFzLhAVwukhXJxNVEQ2pOdFuy0RMtpJienkBUu2AettA89ms+Uw6KJ2HHwa9lP6m35/U2MbS21nHEymA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeHsCrLD9kEpqjKF7Mcr0MtSWbagKqAXRVoq3VIAqNQ=;
 b=YRFwGCwcorKSVW9S5dWNvHH6EjJVBTzBfomkYQiJxcI4GkhoMq6pMfPrZMXoKNSQwfV73z6/FAYYZoJpsMq1ZJFIyqZzng46uBkL/paODy1wm7dn2gQ3TsD4za2/ANHsziB5QC0DNEgXYiX0340dz+oyhtcpc0q6KIyU3uLxBCZF7goe40C4w1VLV8co/hIphWHNONhjoadssKmwt498o0gvyo0RQqcK4vLy0PSgVpHlSjqYf2u15VczbRGa1QismgrwrDmR6e7uZ9e6g32XlR8mER22QPSBI2iMLcC/1RtiJcxDBG10SWbrhOBaOcR5n3JzQ2NEgQW9ujZFqEo1vw==
Received: from BY3PR10CA0001.namprd10.prod.outlook.com (2603:10b6:a03:255::6)
 by IA0PR12MB7751.namprd12.prod.outlook.com (2603:10b6:208:430::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 11:28:11 +0000
Received: from MWH0EPF000C618A.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::83) by BY3PR10CA0001.outlook.office365.com
 (2603:10b6:a03:255::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 11:28:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C618A.mail.protection.outlook.com (10.167.249.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 11:28:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:27:50 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:27:47 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v7 17/31] hw/arm/tegra241-cmdqv: Emulate VCMDQ register writes
Date: Tue, 9 Jun 2026 12:25:38 +0100
Message-ID: <20260609112552.378999-18-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618A:EE_|IA0PR12MB7751:EE_
X-MS-Office365-Filtering-Correlation-Id: 5966a275-c688-49a6-626e-08dec61a302d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|11063799006|56012099006|3023799007|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lEJicAN/03ScomF+OHYTn4Cj7A76bjne4naQ+A7C9Hfq3SAzkm2dpFTDJei7EYvrOiKpJgt/KacOrpXJSkHj/AfXOJs2vL21ZUnFkx4B4musDH/yxqBZFCdjhL/uUyuDv5c54c/YpSa2QHMdASfE80zGfoxmv6kfo/JVaqbiqoxP5VeQ/KGuh3BFCO6W5uVMQEkYb87mELj0mpjcYHkn2WRYDfHfDFN7vSaKe3zo8jWEL4SAayNKU80BvfSF/Ohxf8JNyorS/eNXzF88GufovcylrJ2vUKWKYnZtpFMG/lpOxWWvpFQkAqQhvM6j5llFlD+OxxFVhRwgyzsyyEZRoxeKcU1B264/LfPc/Mv/qe9Lo4AVNcV4nCgaim46SDcg2zhNkmCPUJxyk9Q9fDsXvipQxQPPut066KVcLF+FQILDYtmNhdtFhAhJrVIihaWl99L4qKORySJjGHNqB7ObmrOed05qjXAi9ZOZ4c2CkwzQXIv9WcMDcGgySCjAGDUPWWMBxjEI880Hw6+i8dePDuiX4+eEv5rCFSfiNLdOCXAbXNoMgs36uEjnencimrJsYxyTyXGwW+x+4lwLYVYTqyZxtH9q+WWHbDaE9gRfpGdHiNOV8P1+lSVWZIaKWuM939q8eMSPMSEjeujX/xHpWEkko1B53qOyxYaEZ2gelPC5UtDaOs/L/6QaJpesoxi/FD+TYJvUu1mcGjuBfr4LJmJRL563JISoL8REaWzwOY4=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(11063799006)(56012099006)(3023799007)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pwTFEbdPltcXP+7hdGdXLKCq67hyEKZghkgkUr5ulqjdvqf6caHan+z34EGf6bcf8QRdTbSjtvpqtY8jj1S1Uu1pAZVMLDCyCAsdWs6c6qogNenuFy0McsWuCHjAUwm2jykyqaA8lazRWffC2zjMa8XwU4DO454outOKQ3TxCnrI4HhQpyjUGx8v8/DlxOq5/1IhKGDj9acSwMmOuqE+/Qpy+doH6CiVxA9lUdzH+atnKKfB2s+9SQUaxHJYVnpCP6cZqx6466V+Psr9l6lXZIbBTs8q2FAOwWoXPhlQN9oIblvGpVkblXLbIZO0fpTJosZfnSZC1Cu0hGls+HLDkEvSPlft7QypcV6Y6PggF/CQOUlFquCA7pG5IDGPTHn10PAS1mJUsmi958TbWxzubuoOUrkWGvucoVam+q7JZogQP6JzHn2ZV3qNIfc8voVa
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 11:28:11.1410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5966a275-c688-49a6-626e-08dec61a302d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C618A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7751
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
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

This is the write side counterpart of the VCMDQ read emulation. Add
write handling for both the direct VCMDQ aperture and the VINTF
logical aperture using the same index decoding and VINTF-to-VCMDQ
translation logic as the read path.

VINTF aperture writes are translated to their direct-aperture
equivalent and update the same cached state. Page 1 registers
(BASE, CONS_INDX_BASE) always update the cache.

Per the CMDQV architecture, a VCMDQ must be allocated to a Virtual
Interface before it is used to send commands to the SMMU. Until
that allocation happens, MMIO writes only update cached register
state - no command consumption, error handling, or interrupt
activity is driven from these writes. Subsequent patches wire up
IOMMU_HW_QUEUE_ALLOC, mmap the host VINTF Page 0, and install it
into guest MMIO; after that, Page 0 writes from either aperture
reach the hardware-backed mmap'd page instead of just the cache.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.c | 159 +++++++++++++++++++++++++++++++++++++++-
 hw/arm/trace-events     |   2 +
 2 files changed, 159 insertions(+), 2 deletions(-)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 2dfd377ee9..1f3d883cfe 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -120,6 +120,104 @@ static uint64_t tegra241_cmdqv_config_vintf_read(Tegra241CMDQV *cmdqv,
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
+                                             uint32_t value, bool direct)
+{
+    switch (offset0) {
+    case A_VCMDQ0_CONS_INDX:
+        cmdqv->vcmdq_cons_indx[index] = value;
+        break;
+    case A_VCMDQ0_PROD_INDX:
+        /* VCMDQ is functional only once allocated to a VINTF; cache only. */
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
+        /* VCMDQ is functional only once allocated to a VINTF; cache only. */
+        cmdqv->vcmdq_gerrorn[index] = value;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s unhandled write access at 0x%" PRIx64 "\n",
+                      __func__, offset0);
+    }
+    trace_tegra241_cmdqv_write_vcmdq_page0(index, direct ? "direct" : "vi",
+                                           offset0, value);
+}
+
+/*
+ * Write a VCMDQ Page 1 register (base / DRAM address) - 4-byte access.
+ */
+static void tegra241_cmdqv_write_vcmdq_page1(Tegra241CMDQV *cmdqv,
+                                             hwaddr offset0, int index,
+                                             uint32_t value, bool direct)
+{
+    switch (offset0) {
+    case A_VCMDQ0_BASE_L:
+        cmdqv->vcmdq_base[index] =
+            deposit64(cmdqv->vcmdq_base[index], 0, 32, value);
+        break;
+    case A_VCMDQ0_BASE_H:
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
+    trace_tegra241_cmdqv_write_vcmdq_page1(index, direct ? "direct" : "vi",
+                                           offset0, value);
+}
+
+/*
+ * Write a VCMDQ Page 1 register - 8-byte access at BASE_L or DRAM_L.
+ */
+static void tegra241_cmdqv_write_vcmdq_page1_64(Tegra241CMDQV *cmdqv,
+                                                hwaddr offset0, int index,
+                                                uint64_t value, bool direct)
+{
+    switch (offset0) {
+    case A_VCMDQ0_BASE_L:
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
+    trace_tegra241_cmdqv_write_vcmdq_page1(index, direct ? "direct" : "vi",
+                                           offset0, value);
+}
+
 static void tegra241_cmdqv_config_vintf_write(Tegra241CMDQV *cmdqv,
                                               hwaddr offset, uint64_t value)
 {
@@ -243,6 +341,8 @@ out:
 static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
                                        uint32_t value)
 {
+    int index;
+
     switch (offset) {
     case A_CONFIG:
         cmdqv->config = value;
@@ -261,6 +361,39 @@ static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
     case A_VINTF0_CONFIG ... A_VINTF0_LVCMDQ_ERR_MAP_3:
         tegra241_cmdqv_config_vintf_write(cmdqv, offset, value);
         break;
+    case A_VI_VCMDQ0_CONS_INDX ... A_VI_VCMDQ1_GERRORN:
+        /*
+         * VINTF Page0 registers are hardware aliases of VCMDQ Page0 registers.
+         * Translate the VINTF aperture offset to its VCMDQ Page0 equivalent
+         * before dispatching to the Page 0 helper.
+         */
+        offset -= CMDQV_VINTF_PAGE0_BASE - CMDQV_VCMDQ_PAGE0_BASE;
+        index = (offset - CMDQV_VCMDQ_PAGE0_BASE) / CMDQV_VCMDQ_STRIDE;
+        tegra241_cmdqv_write_vcmdq_page0(cmdqv,
+                offset - index * CMDQV_VCMDQ_STRIDE, index, value, false);
+        break;
+    case A_VCMDQ0_CONS_INDX ... A_VCMDQ1_GERRORN:
+        /*
+         * Decode a per-VCMDQ Page 0 access. Each VCMDQ occupies a
+         * CMDQV_VCMDQ_STRIDE-byte window; extract the index and normalize
+         * to the VCMDQ0_* offset before calling the Page 0 helper.
+         */
+        index = (offset - CMDQV_VCMDQ_PAGE0_BASE) / CMDQV_VCMDQ_STRIDE;
+        tegra241_cmdqv_write_vcmdq_page0(cmdqv,
+                offset - index * CMDQV_VCMDQ_STRIDE, index, value, true);
+        break;
+    case A_VI_VCMDQ0_BASE_L ... A_VI_VCMDQ1_CONS_INDX_BASE_DRAM_H:
+        /* Same VINTF-to-VCMDQ translation as VINTF Page0 case above. */
+        offset -= CMDQV_VINTF_PAGE1_BASE - CMDQV_VCMDQ_PAGE1_BASE;
+        index = (offset - CMDQV_VCMDQ_PAGE1_BASE) / CMDQV_VCMDQ_STRIDE;
+        tegra241_cmdqv_write_vcmdq_page1(cmdqv,
+                offset - index * CMDQV_VCMDQ_STRIDE, index, value, false);
+        break;
+    case A_VCMDQ0_BASE_L ... A_VCMDQ1_CONS_INDX_BASE_DRAM_H:
+        index = (offset - CMDQV_VCMDQ_PAGE1_BASE) / CMDQV_VCMDQ_STRIDE;
+        tegra241_cmdqv_write_vcmdq_page1(cmdqv,
+                offset - index * CMDQV_VCMDQ_STRIDE, index, value, true);
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s unhandled write access at 0x%" PRIx64 "\n",
                       __func__, offset);
@@ -268,14 +401,36 @@ static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
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
+         * before dispatching to the Page 1 helper.
+         */
+        offset -= CMDQV_VINTF_PAGE1_BASE - CMDQV_VCMDQ_PAGE1_BASE;
+        index = (offset - CMDQV_VCMDQ_PAGE1_BASE) / CMDQV_VCMDQ_STRIDE;
+        tegra241_cmdqv_write_vcmdq_page1_64(cmdqv,
+                offset - index * CMDQV_VCMDQ_STRIDE, index, value, false);
+        break;
+    case A_VCMDQ0_BASE_L ... A_VCMDQ1_CONS_INDX_BASE_DRAM_H:
+        index = (offset - CMDQV_VCMDQ_PAGE1_BASE) / CMDQV_VCMDQ_STRIDE;
+        tegra241_cmdqv_write_vcmdq_page1_64(cmdqv,
+                offset - index * CMDQV_VCMDQ_STRIDE, index, value, true);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP,
                       "%s unhandled 64-bit write at 0x%" PRIx64 " (WI)\n",
                       __func__, offset);
+    }
 }
 
 static void tegra241_cmdqv_write_mmio(void *opaque, hwaddr offset,
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 5156604228..666967dc5e 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -77,6 +77,8 @@ tegra241_cmdqv_read_mmio(uint64_t offset, uint64_t val, unsigned size) "offset:
 tegra241_cmdqv_write_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
 tegra241_cmdqv_read_vcmdq_page0(int index, const char *aperture, uint64_t offset0, uint64_t val) "vcmdq[%d] %s offset0: 0x%"PRIx64" val: 0x%"PRIx64
 tegra241_cmdqv_read_vcmdq_page1(int index, const char *aperture, uint64_t offset0, uint64_t val) "vcmdq[%d] %s offset0: 0x%"PRIx64" val: 0x%"PRIx64
+tegra241_cmdqv_write_vcmdq_page0(int index, const char *aperture, uint64_t offset0, uint64_t val) "vcmdq[%d] %s offset0: 0x%"PRIx64" val: 0x%"PRIx64
+tegra241_cmdqv_write_vcmdq_page1(int index, const char *aperture, uint64_t offset0, uint64_t val) "vcmdq[%d] %s offset0: 0x%"PRIx64" val: 0x%"PRIx64
 
 # strongarm.c
 strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
-- 
2.43.0


