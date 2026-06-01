Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C3DCD6E56
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:50:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU19F-0005wH-Tc; Mon, 01 Jun 2026 07:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU19D-0005sA-OC; Mon, 01 Jun 2026 07:49:36 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU19B-00056m-JS; Mon, 01 Jun 2026 07:49:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGO5GyDE4mtNHtQ7k/cQqmHdgcKeLdjOoe3GeTGBxbTWE/QnoH/1hgdmmTEUnHOoqec3308a6odmjLjPpf80JVa0GDRkvLpBCIBALLh3miqtv8DtVvy6Vh59v8LoKYtRFsr8DmFsWArCub9IbRcmD0oXKSOvqzHpNS2yWme03yPt7yWYXcb9i9fd3YfVxAMf6BoFr4+Nd3JA2FFqYP6fIyfVVCL3lRZ3nsM/vAeBdBnHeHMPNivp7vvUWYJsyIOLrPy1dV2wH1LWe+5yRb7uVT09/NHBCq+2BnHqqej+od7l9AYGw59x91Z6PdRSDCq1B6hb+o8OkFvY4xLpUepbQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSi9YBBZ+qSAvbsetix5Ze2zxDKMwFqVEF5xHSMWdVo=;
 b=SxZfBCQIOtBnF9Mx9pnT/yOtHYV3VNbbGQJpxvuVcZRPVexGAS5CJ+Ah6cy+1YL8+qxSIZ/y1PZML6K7BgQ1Ecri0Q8UfOpdSiAM9hLeTRibQXccSUYOzBRbbaoQJVWKBBAE8paD6kuspiCjm0j/ylH0lDX19qoeSMFBBW4SpvbF7T7xY+XLmnjTzvnoXukxGLwPhYw5ZsEMM6oKBH40YRfwD7dXIIDDCF99TTSsgwlQmS4Sm3RyfO141pAxJB8d+RZz5wuD8S4Cn8TdeEjqd9fFJPaAlZ5I1+74ruUQ/8RYddJdJ5iLxk6Yv18UmYoJRTFr/GThzsyatBaQK7cxWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSi9YBBZ+qSAvbsetix5Ze2zxDKMwFqVEF5xHSMWdVo=;
 b=cDwXWdXY6Cx5F7ceNhPHJAlPY94X4atwio14m5aJBFXlaoGOTGS/hytPFjRtClQqH2VcHKTolKPphZNV6mzBu/6lWH6wKgd883q6DqWsj+4eomTT+BgBpXNPbJ5r4wjnH3Nz3ugXdvZ9B+f7Gq+uB8Mm+yjLftIJcOx2oTl1d998CidFYCl4YtcIcmwYzDDnnhvl4pXscEqEHb66mQrSMSQQQ1vO5W2xfNuxopZ7Ydxj4Z1IWlLRYnJjUi3imBh0wsM9agoMCQqDvjqPY4BtrDM7qe91uBluhpY9NnMCqsQgMtqdZMF0v177JLi4Z50UW1bNhESu6BIhVeLd3rniWA==
Received: from BN0PR02CA0036.namprd02.prod.outlook.com (2603:10b6:408:e5::11)
 by MN0PR12MB6128.namprd12.prod.outlook.com (2603:10b6:208:3c4::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 11:49:25 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:e5:cafe::1a) by BN0PR02CA0036.outlook.office365.com
 (2603:10b6:408:e5::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Mon, 1
 Jun 2026 11:49:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Mon, 1 Jun 2026 11:49:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:49:07 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:49:04 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v6 16/31] hw/arm/tegra241-cmdqv: Emulate VCMDQ register writes
Date: Mon, 1 Jun 2026 12:42:06 +0100
Message-ID: <20260601114221.457995-17-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|MN0PR12MB6128:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ebdf70a-f7ed-4cf0-9574-08debfd3d48f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|56012099006|6133799003|11063799006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: y0Rdyy45M8jejN7rzM4BocueOspGZ6xWWL1izOvLTHd/sksFS7Wrg6FbAU4GbRyPOmLQCYFnhPIe0Mx3BfTaPyoap+b7a4MKrFp21Y9ZWVrxlYT/aPpW61B3CQBxiJJYFtaQsZleaWF7zXR2Eee9LR5mn5oT5qiFP3yNyjU3xIvCWVSZyvoKVxhru50Hrqo9mPA8+Q7JHT5rwNLgiQYHRYiIYPzL346+bOqMhcomZM0unGRXfD8LoMTQMl1Qk4Mv5QFLl4PoC/MTiV/qkl6HVPmoGAx4jfPkrzbDnG3qb96zqfrIEqQewTa3uO1u7IeNEwbcekl1kBXRFFxGf8fDIdO5RaeNnBJYoFccNXq2f24ZRHGUXTVKxtz6wPyx2U1c/QnLmMAmiQc//Rn/ap1ECwW+rGkbj8dCiqojYUiXnXB44iHdPShBX6yEXNwkjfJbv8Nqr/5VzO9jWKvYTy763KRaGSGefi/ezYUu+vg8qJQYREyqWrHEcddPzukjGip8AkrHSeGerPqkEE0+6eRlPX032991gUawthwvzmsxOaPWoN8jqS9DaCLDkBdQ9gpTWwVP/znouoOQRA7dV14AxXE4bMkXmbMz0gN84NGor9osYFWRIdjxjg6LmUYFtRxtUlte6MoHUskOg41gSkjdU+NSIJ4TqaTS1B/4rMNutpqk81Z9947my6XDJWdbtK7JbkLhEb8ekOyAXY2FRHrqvccpCz3gb8NRqq69nQkQ0e8=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(56012099006)(6133799003)(11063799006)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IabUy5ccDLVUy0Wgx6Qh9EfvSiWdLnJ8aexvcrhCgXwJtbmb1twdIskRKjkS5fIcDGyD2HOKkpdvfFV4nup+qCuKGugF86h6jTLKArY9RGff88ifQbY15b35FDvp91LaMLAIhwPSVKHpDXveUoabyE05QDbVfEqd3VwC2Bhu05lx2IczO0PIE5E5EUgqNt/dKmL+FlSKYJKKvlYxWu71Aq2dah5H+rmMbtvbnTikycuAtkAEnubnot8gs8CZY+aEFTmccETTWTHDqv8FAYlZsvQz+QhO1/h5isL7Ml+BLqNhqnT/2VvcICq7DT7gYc6MTBQJV8uwAhPyhbN1vDG82r4vjGOFHmVtU6MIWr5i+lFzwKIsHbhhhEZhI4YAXZcMy+aYn37ubwjEHV4CQi/oDsKFpGILDfiTULfFZx8r+gHnnKt59ga1psXi0ibDhp3L
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 11:49:25.6497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ebdf70a-f7ed-4cf0-9574-08debfd3d48f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6128
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
Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.c | 159 +++++++++++++++++++++++++++++++++++++++-
 hw/arm/trace-events     |   2 +
 2 files changed, 159 insertions(+), 2 deletions(-)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index ff150fe0f3..3cb1b45575 100644
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
index 4392135fa2..d76f408d8a 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -77,6 +77,8 @@ tegra241_cmdqv_read_mmio(uint64_t offset, uint64_t val, unsigned size) "offset:
 tegra241_cmdqv_write_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
 tegra241_cmdqv_read_vcmdq_page0(int index, const char *aperture, uint64_t offset0, uint64_t val) "vcmdq[%d] %s page0 offset0: 0x%"PRIx64" val: 0x%"PRIx64
 tegra241_cmdqv_read_vcmdq_page1(int index, const char *aperture, uint64_t offset0, uint64_t val) "vcmdq[%d] %s page1 offset0: 0x%"PRIx64" val: 0x%"PRIx64
+tegra241_cmdqv_write_vcmdq_page0(int index, const char *aperture, uint64_t offset0, uint64_t val) "vcmdq[%d] %s page0 offset0: 0x%"PRIx64" val: 0x%"PRIx64
+tegra241_cmdqv_write_vcmdq_page1(int index, const char *aperture, uint64_t offset0, uint64_t val) "vcmdq[%d] %s page1 offset0: 0x%"PRIx64" val: 0x%"PRIx64
 
 # strongarm.c
 strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
-- 
2.43.0


