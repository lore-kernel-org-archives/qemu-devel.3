Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D472CCD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWudP-0008UF-Ui; Tue, 09 Jun 2026 07:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWud5-000775-Mi; Tue, 09 Jun 2026 07:28:27 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWud2-000357-EL; Tue, 09 Jun 2026 07:28:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pTqjj6Svj2n1MRnlW0P8gl4uspe+KagP9Q5E7ExSvIVz7iMjvRJy7ny8zqZpq1sWkC6T8oC3l3I2S+35ErDlGVCqyEUu4Ue7dChfIye+ThUf6cdV6johe87qzM/J0U/YXSaIEMpOOjgRtE/ZFETIpem3N9X2xVI3YokwyF4zpTS1bqkJbMSlFPyUlteGBdKen1wQRlp9tUGAXox3LknafaKHQe6prJ+a1kHYKET9dAff45GAEB0Hx9VWjzXJJ5OZnaEBBRoaDEbXNFm55b312lI6WZN6HQ7U6MiJ+sCv8YlTVh/oDLVr8hVGPqW4XJlYsFhQAqN49/Y5ywWbNjXxqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72W5O7/JutUIYOfnZ5dCnRm5+8p+nPcow6dOgutpwJ0=;
 b=WOkEAe4joV7A1VhcuAVz+JCq0F46181p03mRdahGGPFqTwxOF/jNeTFhNRUeO5pn//fqYYjw/X0XZgVdb/iJBeENMLkNK1Ya8kSIw5iI+vfdYIdD4xrMG+SFvN/OFFYaHPKVimadXafLzV0U7milA9+nUnHLixRhAjsLulkg2ML07doGUGmXOpUqooccTizMptJp5SgQzIth4FPYZQeeVmrwH0kyeVr3rtr5+TOAUb9BLD7zA1s07SQcuI2H/gBPZmWozhJVFLglLN1tXjKsR4bttvFpA6n4rBl0idlGqZzf/ji0O67tb4UMaaJhiE2iw+xg++UuTt3QYUXaxqnt0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72W5O7/JutUIYOfnZ5dCnRm5+8p+nPcow6dOgutpwJ0=;
 b=sUWgvVUAYVnLJfTL4gHQDTq9P0IiufcJxn7T9QKxKyLZYjr3wLmq2/OSGP4ZprlxMn4TjvhehwxSAtH2rp/EK/lIebq1pAymAm9mI5wSSCcmsfd4fcie/uXWRwxuITEXyAZuBGFIrlKHccuDf9j+4y2MiN5/I0AfJsMNT2ZHa/aM0G8USIt4Y4chKSxDLq/QrVdrTT1/KT9F01gCeXYMeke9zWEh/IqcEC3aoa2CXjzkCF86aCGALeySrOFUnBhIwDz+5rAoyis9ASmRpAtQK60UNklLk9PceDjC9aA2m7yDzBaMIDIgctDlgywLRfw4GQIpNKgJ9d0nMEqFH7WcTg==
Received: from BY3PR10CA0025.namprd10.prod.outlook.com (2603:10b6:a03:255::30)
 by DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 11:28:08 +0000
Received: from MWH0EPF000C6188.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::7e) by BY3PR10CA0025.outlook.office365.com
 (2603:10b6:a03:255::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 11:28:07 +0000
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
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 11:28:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:27:46 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:27:42 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v7 16/31] hw/arm/tegra241-cmdqv: Emulate VCMDQ register reads
Date: Tue, 9 Jun 2026 12:25:37 +0100
Message-ID: <20260609112552.378999-17-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6188:EE_|DS0PR12MB7804:EE_
X-MS-Office365-Filtering-Correlation-Id: 44e70e95-7ebf-46ff-6480-08dec61a2dbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|11063799006|3023799007|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: KC8S/UMolJkeRcqWtUuyeqcJTzE7NJ5Su+opPzkP+sacA0ux+Ns7VZpdkBB6ji8naGRyVoj0RGO1HSSdlJbXMvbPOJM92afLxWgEkbUXZq59MpzeyfzkzhIWfOqwtt5FZVp9YwRyg+rTfT6s16mKlfHbv2gKE54y3PpUdp8MWfHQey3uvH/Z58xALWI5QH3uIwq7XNIM72/hSRIPbMDAr5xijVnK4HFib9haOotpKafCByK8v9CZzlgtgkVv556rUd4b/a0+b6Pe8BxyelCwmwUN4nqVv0cJOOFL30Ya0CmajNKcVTDHa8dT1cZByV1Ng1UhMBG/lX0fB8GXG78R0Jn3bipNJA95fDtophcMDl7JyTvVIzxqLyT7uFgJGKWa8nhGYC2K+JKn0BDCQk7I/JhJFL7i8WElWIgNM9nktpN+NQbuOVSKgcbvgZx52xGrfxhg89zYP2w9suJbAjEylDBkLBRtxkthbbOxmmE9DSumw2JrYdfjvIWjBVk2CKp337zQhXkYXr+sg9xz6VaCw5PuRE9k8cT4yFODhBhwia3gdX2ziqe5Y4nFjSWAsPOvG5dYeOzqQB3aJ2D0nHzF8LwFLoR/rmSY+ctxic3hV+3aOQXnpycsZgM+rvVBm7HQ2r0+ccm2aTUWl3+BuvQtU0WJc4IdH4P7fWnzjnFx/PbfU/VoAwEsfN8w9ge9+f339D2WtOAuFhkqvoS3hvF6t67jC9PVaml1pFkpdW83tlo=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(11063799006)(3023799007)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HoEsFlDE45uyQAVhdeWh3eTdOZh7F4ReWVrTC1/jBoNQlBtHeaHQhjtMcHsGbTi/9RAfDKYrHro16m40y6KWP/Tacgg61saHqP2GwNJikkKrIKeCNtAl1j3uGLVnLS0TxviBCHoJzUJ07G5RkFIfaan/xh1z2d1WXhMcDwacq6W24+LxGoaRhDBKOAboJ4lcmNrt0koI24LMHZy+VcNaQo8Ftq3crV0+ScepdMmrAgmb7zHCsrnmnBWdgIDqJSrEda3khy+1WSocvbTNo+o0fH+5NAXdVyOlWOhpbFknhqI/m41Vm7iI3I93CVgoE13a22d9Kf2gdAmIY8iv2S/XpFPiMPlWj/DdxeXjWIeto1Tvs3/JUbB6a28MQnf17glGdP4tETHJdZ+kukf8dJQCKQD0pQBp2gU2SYum62nhXdXyE2SuzbjE10oDnp7BvS3e
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 11:28:07.0430 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e70e95-7ebf-46ff-6480-08dec61a2dbb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6188.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7804
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
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

Tegra241 CMDQV exposes per-VCMDQ register windows through two MMIO
apertures:

  Direct VCMDQ aperture (0x10000/0x20000): VCMDQ Page0/Page1
  VINTF logical aperture (0x30000/0x40000): VINTF0 LVCMDQ Page0/Page1

Both apertures are hardware aliases of the same underlying registers:

  Page 0 (control/status): CONS_INDX, PROD_INDX, CONFIG, STATUS,
                           GERROR, GERRORN
  Page 1 (base/DRAM):      BASE_L/H, CONS_INDX_BASE_DRAM_L/H

The direct aperture Page 0 is programmable at any time so long as
CMDQV_EN is enabled. The VINTF (logical) aperture Page 0 is
programmable only once SW has mapped a VCMDQ to a VINTF; the
"logical" view is local to that VINTF.

Add read emulation for both apertures, backed by a single per-VCMDQ
register cache. VINTF aperture reads are translated to their
equivalent direct-aperture offset and served from the same cached
state.

Per the CMDQV architecture, a VCMDQ must be allocated to a Virtual
Interface before it is used to send commands to the SMMU. Until that
allocation happens, reads return cached register state with no HW
interaction. Subsequent patches wire up IOMMU_HW_QUEUE_ALLOC, mmap
the host VINTF Page 0, and install it into guest MMIO; after that,
Page 0 reads from either aperture are served from the hardware-backed
mmap'd page instead of the cache. Page 1 is also a hardware alias,
but the kernel only exposes mmap for Page 0, so Page 1 reads always
trap to QEMU and are served from cache.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.h | 216 ++++++++++++++++++++++++++++++++++++++++
 hw/arm/tegra241-cmdqv.c | 103 +++++++++++++++++++
 hw/arm/trace-events     |   2 +
 3 files changed, 321 insertions(+)

diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index d49fa42cd5..c4d327a9a5 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -30,6 +30,13 @@
  */
 #define TEGRA241_CMDQV_IO_LEN 0x50000
 
+/* CMDQV MMIO aperture bases and VCMDQ stride */
+#define CMDQV_VCMDQ_PAGE0_BASE  0x10000  /* CMDQV_CMDQ_BASE */
+#define CMDQV_VCMDQ_PAGE1_BASE  0x20000
+#define CMDQV_VINTF_PAGE0_BASE  0x30000  /* CMDQV_VI_CMDQ_BASE */
+#define CMDQV_VINTF_PAGE1_BASE  0x40000
+#define CMDQV_VCMDQ_STRIDE      0x80
+
 #define VINTF_PAGE_SIZE 0x10000
 
 struct iommu_viommu_tegra241_cmdqv;
@@ -57,6 +64,19 @@ typedef struct Tegra241CMDQV {
     uint32_t vintf_sid_match[TEGRA241_CMDQV_MAX_NUM_SID];
     uint32_t vintf_sid_replace[TEGRA241_CMDQV_MAX_NUM_SID];
     uint32_t vintf_cmdq_err_map[4];
+    /*
+     * VCMDQ register cache. The direct (VCMDQ aperture) and logical
+     * (VINTF aperture) views are hardware aliases; both are served from
+     * this single cached copy.
+     */
+    uint32_t vcmdq_cons_indx[TEGRA241_CMDQV_MAX_CMDQ];
+    uint32_t vcmdq_prod_indx[TEGRA241_CMDQV_MAX_CMDQ];
+    uint32_t vcmdq_config[TEGRA241_CMDQV_MAX_CMDQ];
+    uint32_t vcmdq_status[TEGRA241_CMDQV_MAX_CMDQ];
+    uint32_t vcmdq_gerror[TEGRA241_CMDQV_MAX_CMDQ];
+    uint32_t vcmdq_gerrorn[TEGRA241_CMDQV_MAX_CMDQ];
+    uint64_t vcmdq_base[TEGRA241_CMDQV_MAX_CMDQ];
+    uint64_t vcmdq_cons_indx_base[TEGRA241_CMDQV_MAX_CMDQ];
 } Tegra241CMDQV;
 
 /* CMDQ-V Config page registers (offset 0x00000) */
@@ -148,6 +168,202 @@ REG32(VINTF0_LVCMDQ_ERR_MAP_0, 0x10c0)
 FIELD(VINTF0_LVCMDQ_ERR_MAP_0, LVCMDQ_ERR_MAP, 0, 32)
 #define A_VINTF0_LVCMDQ_ERR_MAP_3 (A_VINTF0_LVCMDQ_ERR_MAP_0 + 3 * 4)
 
+/*
+ * Direct VCMDQ aperture register windows.
+ *
+ * Page 0 @ CMDQV_VCMDQ_PAGE0_BASE: VCMDQ control and status registers.
+ * Page 1 @ CMDQV_VCMDQ_PAGE1_BASE: VCMDQ base and DRAM address registers.
+ *
+ * Each VCMDQ occupies a CMDQV_VCMDQ_STRIDE-byte slot within its page.
+ */
+
+/* --- Page 0 register macros --- */
+#define SMMU_CMDQV_VCMDQi_CONS_INDX_(i)                     \
+    REG32(VCMDQ##i##_CONS_INDX,                             \
+          CMDQV_VCMDQ_PAGE0_BASE + i * CMDQV_VCMDQ_STRIDE)  \
+    FIELD(VCMDQ##i##_CONS_INDX, RD, 0, 20)                  \
+    FIELD(VCMDQ##i##_CONS_INDX, ERR, 24, 7)
+
+#define V_VCMDQ_CONS_INDX_ERR_CERROR_NONE         0
+#define V_VCMDQ_CONS_INDX_ERR_CERROR_ILL_OPCODE   1
+#define V_VCMDQ_CONS_INDX_ERR_CERROR_ABT          2
+#define V_VCMDQ_CONS_INDX_ERR_CERROR_ATC_INV_SYNC 3
+#define V_VCMDQ_CONS_INDX_ERR_CERROR_ILL_ACCESS   4
+
+#define SMMU_CMDQV_VCMDQi_PROD_INDX_(i)                          \
+    REG32(VCMDQ##i##_PROD_INDX,                                  \
+          CMDQV_VCMDQ_PAGE0_BASE + 0x4 + i * CMDQV_VCMDQ_STRIDE) \
+    FIELD(VCMDQ##i##_PROD_INDX, WR, 0, 20)
+
+#define SMMU_CMDQV_VCMDQi_CONFIG_(i)                             \
+    REG32(VCMDQ##i##_CONFIG,                                     \
+          CMDQV_VCMDQ_PAGE0_BASE + 0x8 + i * CMDQV_VCMDQ_STRIDE) \
+    FIELD(VCMDQ##i##_CONFIG, CMDQ_EN, 0, 1)
+
+#define SMMU_CMDQV_VCMDQi_STATUS_(i)                             \
+    REG32(VCMDQ##i##_STATUS,                                     \
+          CMDQV_VCMDQ_PAGE0_BASE + 0xc + i * CMDQV_VCMDQ_STRIDE) \
+    FIELD(VCMDQ##i##_STATUS, CMDQ_EN_OK, 0, 1)
+
+#define SMMU_CMDQV_VCMDQi_GERROR_(i)                              \
+    REG32(VCMDQ##i##_GERROR,                                      \
+          CMDQV_VCMDQ_PAGE0_BASE + 0x10 + i * CMDQV_VCMDQ_STRIDE) \
+    FIELD(VCMDQ##i##_GERROR, CMDQ_ERR, 0, 1)                      \
+    FIELD(VCMDQ##i##_GERROR, CONS_DRAM_WR_ABT_ERR, 1, 1)          \
+    FIELD(VCMDQ##i##_GERROR, CMDQ_INIT_ERR, 2, 1)
+
+#define SMMU_CMDQV_VCMDQi_GERRORN_(i)                             \
+    REG32(VCMDQ##i##_GERRORN,                                     \
+          CMDQV_VCMDQ_PAGE0_BASE + 0x14 + i * CMDQV_VCMDQ_STRIDE) \
+    FIELD(VCMDQ##i##_GERRORN, CMDQ_ERR, 0, 1)                     \
+    FIELD(VCMDQ##i##_GERRORN, CONS_DRAM_WR_ABT_ERR, 1, 1)         \
+    FIELD(VCMDQ##i##_GERRORN, CMDQ_INIT_ERR, 2, 1)
+
+/* Page 0 layout: VCMDQ0 */
+SMMU_CMDQV_VCMDQi_CONS_INDX_(0)
+SMMU_CMDQV_VCMDQi_PROD_INDX_(0)
+SMMU_CMDQV_VCMDQi_CONFIG_(0)
+SMMU_CMDQV_VCMDQi_STATUS_(0)
+SMMU_CMDQV_VCMDQi_GERROR_(0)
+SMMU_CMDQV_VCMDQi_GERRORN_(0)
+
+/* Page 0 layout: VCMDQ1 */
+SMMU_CMDQV_VCMDQi_CONS_INDX_(1)
+SMMU_CMDQV_VCMDQi_PROD_INDX_(1)
+SMMU_CMDQV_VCMDQi_CONFIG_(1)
+SMMU_CMDQV_VCMDQi_STATUS_(1)
+SMMU_CMDQV_VCMDQi_GERROR_(1)
+SMMU_CMDQV_VCMDQi_GERRORN_(1)
+
+/* --- Page 1 register macros --- */
+#define SMMU_CMDQV_VCMDQi_BASE_L_(i)                                          \
+    REG32(VCMDQ##i##_BASE_L, CMDQV_VCMDQ_PAGE1_BASE + i * CMDQV_VCMDQ_STRIDE) \
+    FIELD(VCMDQ##i##_BASE_L, LOG2SIZE, 0, 5)                                  \
+    FIELD(VCMDQ##i##_BASE_L, ADDR, 5, 27)
+
+#define SMMU_CMDQV_VCMDQi_BASE_H_(i)                             \
+    REG32(VCMDQ##i##_BASE_H,                                     \
+          CMDQV_VCMDQ_PAGE1_BASE + 0x4 + i * CMDQV_VCMDQ_STRIDE) \
+    FIELD(VCMDQ##i##_BASE_H, ADDR, 0, 16)
+
+#define SMMU_CMDQV_VCMDQi_CONS_INDX_BASE_DRAM_L_(i)              \
+    REG32(VCMDQ##i##_CONS_INDX_BASE_DRAM_L,                      \
+          CMDQV_VCMDQ_PAGE1_BASE + 0x8 + i * CMDQV_VCMDQ_STRIDE) \
+    FIELD(VCMDQ##i##_CONS_INDX_BASE_DRAM_L, ADDR, 0, 32)
+
+#define SMMU_CMDQV_VCMDQi_CONS_INDX_BASE_DRAM_H_(i)              \
+    REG32(VCMDQ##i##_CONS_INDX_BASE_DRAM_H,                      \
+          CMDQV_VCMDQ_PAGE1_BASE + 0xc + i * CMDQV_VCMDQ_STRIDE) \
+    FIELD(VCMDQ##i##_CONS_INDX_BASE_DRAM_H, ADDR, 0, 16)
+
+/* Page 1 layout: VCMDQ0 */
+SMMU_CMDQV_VCMDQi_BASE_L_(0)
+SMMU_CMDQV_VCMDQi_BASE_H_(0)
+SMMU_CMDQV_VCMDQi_CONS_INDX_BASE_DRAM_L_(0)
+SMMU_CMDQV_VCMDQi_CONS_INDX_BASE_DRAM_H_(0)
+
+/* Page 1 layout: VCMDQ1 */
+SMMU_CMDQV_VCMDQi_BASE_L_(1)
+SMMU_CMDQV_VCMDQi_BASE_H_(1)
+SMMU_CMDQV_VCMDQi_CONS_INDX_BASE_DRAM_L_(1)
+SMMU_CMDQV_VCMDQi_CONS_INDX_BASE_DRAM_H_(1)
+
+/*
+ * VINTF0 logical VCMDQ aperture register windows.
+ *
+ * Page 0 @ CMDQV_VINTF_PAGE0_BASE: VCMDQ control and status registers.
+ * Page 1 @ CMDQV_VINTF_PAGE1_BASE: VCMDQ base and DRAM address registers.
+ *
+ * VCMDQs mapped via VINTF are accessed through this aperture as
+ * hardware aliases of the direct VCMDQ aperture above.
+ */
+
+/* --- Page 0 register macros --- */
+#define SMMU_CMDQV_VI_VCMDQi_CONS_INDX_(i)                  \
+    REG32(VI_VCMDQ##i##_CONS_INDX,                          \
+          CMDQV_VINTF_PAGE0_BASE + i * CMDQV_VCMDQ_STRIDE)  \
+    FIELD(VI_VCMDQ##i##_CONS_INDX, RD, 0, 20)               \
+    FIELD(VI_VCMDQ##i##_CONS_INDX, ERR, 24, 7)
+
+#define SMMU_CMDQV_VI_VCMDQi_PROD_INDX_(i)                       \
+    REG32(VI_VCMDQ##i##_PROD_INDX,                               \
+          CMDQV_VINTF_PAGE0_BASE + 0x4 + i * CMDQV_VCMDQ_STRIDE) \
+    FIELD(VI_VCMDQ##i##_PROD_INDX, WR, 0, 20)
+
+#define SMMU_CMDQV_VI_VCMDQi_CONFIG_(i)                          \
+    REG32(VI_VCMDQ##i##_CONFIG,                                  \
+          CMDQV_VINTF_PAGE0_BASE + 0x8 + i * CMDQV_VCMDQ_STRIDE) \
+    FIELD(VI_VCMDQ##i##_CONFIG, CMDQ_EN, 0, 1)
+
+#define SMMU_CMDQV_VI_VCMDQi_STATUS_(i)                          \
+    REG32(VI_VCMDQ##i##_STATUS,                                  \
+          CMDQV_VINTF_PAGE0_BASE + 0xc + i * CMDQV_VCMDQ_STRIDE) \
+    FIELD(VI_VCMDQ##i##_STATUS, CMDQ_EN_OK, 0, 1)
+
+#define SMMU_CMDQV_VI_VCMDQi_GERROR_(i)                           \
+    REG32(VI_VCMDQ##i##_GERROR,                                   \
+          CMDQV_VINTF_PAGE0_BASE + 0x10 + i * CMDQV_VCMDQ_STRIDE) \
+    FIELD(VI_VCMDQ##i##_GERROR, CMDQ_ERR, 0, 1)                   \
+    FIELD(VI_VCMDQ##i##_GERROR, CONS_DRAM_WR_ABT_ERR, 1, 1)       \
+    FIELD(VI_VCMDQ##i##_GERROR, CMDQ_INIT_ERR, 2, 1)
+
+#define SMMU_CMDQV_VI_VCMDQi_GERRORN_(i)                          \
+    REG32(VI_VCMDQ##i##_GERRORN,                                  \
+          CMDQV_VINTF_PAGE0_BASE + 0x14 + i * CMDQV_VCMDQ_STRIDE) \
+    FIELD(VI_VCMDQ##i##_GERRORN, CMDQ_ERR, 0, 1)                  \
+    FIELD(VI_VCMDQ##i##_GERRORN, CONS_DRAM_WR_ABT_ERR, 1, 1)      \
+    FIELD(VI_VCMDQ##i##_GERRORN, CMDQ_INIT_ERR, 2, 1)
+
+/* Page 0 layout: VCMDQ0 */
+SMMU_CMDQV_VI_VCMDQi_CONS_INDX_(0)
+SMMU_CMDQV_VI_VCMDQi_PROD_INDX_(0)
+SMMU_CMDQV_VI_VCMDQi_CONFIG_(0)
+SMMU_CMDQV_VI_VCMDQi_STATUS_(0)
+SMMU_CMDQV_VI_VCMDQi_GERROR_(0)
+SMMU_CMDQV_VI_VCMDQi_GERRORN_(0)
+
+/* Page 0 layout: VCMDQ1 */
+SMMU_CMDQV_VI_VCMDQi_CONS_INDX_(1)
+SMMU_CMDQV_VI_VCMDQi_PROD_INDX_(1)
+SMMU_CMDQV_VI_VCMDQi_CONFIG_(1)
+SMMU_CMDQV_VI_VCMDQi_STATUS_(1)
+SMMU_CMDQV_VI_VCMDQi_GERROR_(1)
+SMMU_CMDQV_VI_VCMDQi_GERRORN_(1)
+
+/* --- Page 1 register macros --- */
+#define SMMU_CMDQV_VI_VCMDQi_BASE_L_(i)                     \
+    REG32(VI_VCMDQ##i##_BASE_L,                             \
+          CMDQV_VINTF_PAGE1_BASE + i * CMDQV_VCMDQ_STRIDE)  \
+    FIELD(VI_VCMDQ##i##_BASE_L, LOG2SIZE, 0, 5)             \
+    FIELD(VI_VCMDQ##i##_BASE_L, ADDR, 5, 27)
+
+#define SMMU_CMDQV_VI_VCMDQi_BASE_H_(i)                          \
+    REG32(VI_VCMDQ##i##_BASE_H,                                  \
+          CMDQV_VINTF_PAGE1_BASE + 0x4 + i * CMDQV_VCMDQ_STRIDE) \
+    FIELD(VI_VCMDQ##i##_BASE_H, ADDR, 0, 16)
+
+#define SMMU_CMDQV_VI_VCMDQi_CONS_INDX_BASE_DRAM_L_(i)           \
+    REG32(VI_VCMDQ##i##_CONS_INDX_BASE_DRAM_L,                   \
+          CMDQV_VINTF_PAGE1_BASE + 0x8 + i * CMDQV_VCMDQ_STRIDE) \
+    FIELD(VI_VCMDQ##i##_CONS_INDX_BASE_DRAM_L, ADDR, 0, 32)
+
+#define SMMU_CMDQV_VI_VCMDQi_CONS_INDX_BASE_DRAM_H_(i)           \
+    REG32(VI_VCMDQ##i##_CONS_INDX_BASE_DRAM_H,                   \
+          CMDQV_VINTF_PAGE1_BASE + 0xc + i * CMDQV_VCMDQ_STRIDE) \
+    FIELD(VI_VCMDQ##i##_CONS_INDX_BASE_DRAM_H, ADDR, 0, 16)
+
+/* Page 1 layout: VCMDQ0 */
+SMMU_CMDQV_VI_VCMDQi_BASE_L_(0)
+SMMU_CMDQV_VI_VCMDQi_BASE_H_(0)
+SMMU_CMDQV_VI_VCMDQi_CONS_INDX_BASE_DRAM_L_(0)
+SMMU_CMDQV_VI_VCMDQi_CONS_INDX_BASE_DRAM_H_(0)
+
+/* Page 1 layout: VCMDQ1 */
+SMMU_CMDQV_VI_VCMDQi_BASE_L_(1)
+SMMU_CMDQV_VI_VCMDQi_BASE_H_(1)
+SMMU_CMDQV_VI_VCMDQi_CONS_INDX_BASE_DRAM_L_(1)
+SMMU_CMDQV_VI_VCMDQi_CONS_INDX_BASE_DRAM_H_(1)
+
 const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void);
 
 #endif /* HW_ARM_TEGRA241_CMDQV_H */
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 8950d5153b..2dfd377ee9 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -16,6 +16,79 @@
 #include "tegra241-cmdqv.h"
 #include "trace.h"
 
+/*
+ * Read a VCMDQ Page 0 register (control/status) using VCMDQ0_* offsets.
+ *
+ * The caller normalizes the MMIO offset such that @offset0 always refers
+ * to a VCMDQ0_* register, while @index selects the VCMDQ instance.
+ */
+static uint64_t tegra241_cmdqv_read_vcmdq_page0(Tegra241CMDQV *cmdqv,
+                                                hwaddr offset0, int index,
+                                                bool direct)
+{
+    uint64_t val = 0;
+
+    switch (offset0) {
+    case A_VCMDQ0_CONS_INDX:
+        val = cmdqv->vcmdq_cons_indx[index];
+        break;
+    case A_VCMDQ0_PROD_INDX:
+        val = cmdqv->vcmdq_prod_indx[index];
+        break;
+    case A_VCMDQ0_CONFIG:
+        val = cmdqv->vcmdq_config[index];
+        break;
+    case A_VCMDQ0_STATUS:
+        val = cmdqv->vcmdq_status[index];
+        break;
+    case A_VCMDQ0_GERROR:
+        val = cmdqv->vcmdq_gerror[index];
+        break;
+    case A_VCMDQ0_GERRORN:
+        val = cmdqv->vcmdq_gerrorn[index];
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s unhandled read access at 0x%" PRIx64 "\n",
+                      __func__, offset0);
+    }
+    trace_tegra241_cmdqv_read_vcmdq_page0(index, direct ? "direct" : "vi",
+                                          offset0, val);
+    return val;
+}
+
+/*
+ * Read a VCMDQ Page 1 register (base / DRAM address) using VCMDQ0_* offsets.
+ */
+static uint64_t tegra241_cmdqv_read_vcmdq_page1(Tegra241CMDQV *cmdqv,
+                                                hwaddr offset0, int index,
+                                                bool direct)
+{
+    uint64_t val = 0;
+
+    switch (offset0) {
+    case A_VCMDQ0_BASE_L:
+        val = cmdqv->vcmdq_base[index];
+        break;
+    case A_VCMDQ0_BASE_H:
+        val = cmdqv->vcmdq_base[index] >> 32;
+        break;
+    case A_VCMDQ0_CONS_INDX_BASE_DRAM_L:
+        val = cmdqv->vcmdq_cons_indx_base[index];
+        break;
+    case A_VCMDQ0_CONS_INDX_BASE_DRAM_H:
+        val = cmdqv->vcmdq_cons_indx_base[index] >> 32;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s unhandled read access at 0x%" PRIx64 "\n",
+                      __func__, offset0);
+    }
+    trace_tegra241_cmdqv_read_vcmdq_page1(index, direct ? "direct" : "vi",
+                                          offset0, val);
+    return val;
+}
+
 static uint64_t tegra241_cmdqv_config_vintf_read(Tegra241CMDQV *cmdqv,
                                                  hwaddr offset)
 {
@@ -93,6 +166,7 @@ static uint64_t tegra241_cmdqv_read_mmio(void *opaque, hwaddr offset,
 {
     Tegra241CMDQV *cmdqv = (Tegra241CMDQV *)opaque;
     uint64_t val = 0;
+    int index;
 
     if (offset >= TEGRA241_CMDQV_IO_LEN) {
         qemu_log_mask(LOG_UNIMP,
@@ -126,6 +200,35 @@ static uint64_t tegra241_cmdqv_read_mmio(void *opaque, hwaddr offset,
     case A_VINTF0_CONFIG ... A_VINTF0_LVCMDQ_ERR_MAP_3:
         val = tegra241_cmdqv_config_vintf_read(cmdqv, offset);
         break;
+    case A_VI_VCMDQ0_CONS_INDX ... A_VI_VCMDQ1_GERRORN:
+        /*
+         * VINTF Page0 registers are hardware aliases of VCMDQ Page0 registers.
+         * Translate the VINTF aperture offset to its VCMDQ Page0 equivalent
+         * before dispatching to the Page 0 helper.
+         */
+        offset -= CMDQV_VINTF_PAGE0_BASE - CMDQV_VCMDQ_PAGE0_BASE;
+        index = (offset - CMDQV_VCMDQ_PAGE0_BASE) / CMDQV_VCMDQ_STRIDE;
+        return tegra241_cmdqv_read_vcmdq_page0(cmdqv,
+                offset - index * CMDQV_VCMDQ_STRIDE, index, false);
+    case A_VCMDQ0_CONS_INDX ... A_VCMDQ1_GERRORN:
+        /*
+         * Decode a per-VCMDQ Page 0 access. Each VCMDQ occupies a
+         * CMDQV_VCMDQ_STRIDE-byte window; extract the index and normalize
+         * to the VCMDQ0_* offset before calling the Page 0 helper.
+         */
+        index = (offset - CMDQV_VCMDQ_PAGE0_BASE) / CMDQV_VCMDQ_STRIDE;
+        return tegra241_cmdqv_read_vcmdq_page0(cmdqv,
+                offset - index * CMDQV_VCMDQ_STRIDE, index, true);
+    case A_VI_VCMDQ0_BASE_L ... A_VI_VCMDQ1_CONS_INDX_BASE_DRAM_H:
+        /* Same VINTF-to-VCMDQ translation as VINTF Page0 case above. */
+        offset -= CMDQV_VINTF_PAGE1_BASE - CMDQV_VCMDQ_PAGE1_BASE;
+        index = (offset - CMDQV_VCMDQ_PAGE1_BASE) / CMDQV_VCMDQ_STRIDE;
+        return tegra241_cmdqv_read_vcmdq_page1(cmdqv,
+                offset - index * CMDQV_VCMDQ_STRIDE, index, false);
+    case A_VCMDQ0_BASE_L ... A_VCMDQ1_CONS_INDX_BASE_DRAM_H:
+        index = (offset - CMDQV_VCMDQ_PAGE1_BASE) / CMDQV_VCMDQ_STRIDE;
+        return tegra241_cmdqv_read_vcmdq_page1(cmdqv,
+                offset - index * CMDQV_VCMDQ_STRIDE, index, true);
     default:
         qemu_log_mask(LOG_UNIMP, "%s unhandled read access at 0x%" PRIx64 "\n",
                       __func__, offset);
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 8c61d66a26..5156604228 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -75,6 +75,8 @@ smmuv3_accel_install_ste(uint32_t vsid, const char * type, uint32_t hwpt_id) "vS
 # tegra241-cmdqv
 tegra241_cmdqv_read_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
 tegra241_cmdqv_write_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
+tegra241_cmdqv_read_vcmdq_page0(int index, const char *aperture, uint64_t offset0, uint64_t val) "vcmdq[%d] %s offset0: 0x%"PRIx64" val: 0x%"PRIx64
+tegra241_cmdqv_read_vcmdq_page1(int index, const char *aperture, uint64_t offset0, uint64_t val) "vcmdq[%d] %s offset0: 0x%"PRIx64" val: 0x%"PRIx64
 
 # strongarm.c
 strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
-- 
2.43.0


