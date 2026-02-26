Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA88FC592C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvYzI-0004ya-Jm; Thu, 26 Feb 2026 05:52:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYzH-0004w5-6m; Thu, 26 Feb 2026 05:52:55 -0500
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYzF-0000s8-7e; Thu, 26 Feb 2026 05:52:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o7sJlUZKCs1dOa71EgG7l+ylehZ9N9GJZDvfpz43MCYCyauJ4+35At/MoDkYS2eqQp+0KB1KrPHjRCdo1xtKOvwGPPh1Pmf/L+TaFgrw8+okGc8KZhWCyJclyCGs2MfYTQlKG+H6vwaQkQW4Q6vpzodYdDN+8KVLZoEwLnG+4R4rycOO8ZIB4sRLdo53XoM9SYlpcYIbG4AmxBnSMsqWbcgsvsd1TigLPy8TivZjkz+gYb1nJke6DzfKTUMjsfscLjS/CqF/b2zwX/rFbsWkmmjr+Ker6XjSPLG99R6lhQCsSs9hwaC9GuN0JYBOp2jJrTQ435hLMdmce6N4q6s/rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1gkGW25ViwhMHjCKlGTG7gy/2Tzm+MNKheML2midkk=;
 b=rSdWKsaoC7068jSHkZg2xRbQ6DG0N1CKRpwduQ3c+5gMd+UQT/kXwU7FcBeYWc/SuUofTgdxygx6cC5OshZp9JQUZ4OFNYvHeXJwR5qsJMaNEpq3kLt5O1oXSNxYgzvLhh+/dujjOVsRitGb1f3bHLqoe5KtBWD9h9zg8MTavbbi0+SKfJDf5Y1d/UofZStwkVk3P0MXLkW3hpplkOjydaQb+gYUMXZWzTgaf/JN/4mzSc4tJ4a0VHMs5CPxU1X4MG3mkld8cV5c5Fgg1rFngsVEyUhkKORnqh21YLRyhknL15b+e4fW1q1pnPs0Wt9CcuHNQxXOwelR8MguANMOiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1gkGW25ViwhMHjCKlGTG7gy/2Tzm+MNKheML2midkk=;
 b=jtIs/7WnHy6dk0uazULHbjUw5R1MHmCDXWOXusK3APbHZ8OYNHnfO+/b/parQ2zXHZwlIB4YmgrGSEsap4oyaO7k96FtbBpe/UWOhKnWCQ0jnDVe8wBa+uWCUqbdg+qO86fO2XZSyiAqeNX9+uCsTU7gBE2wdv82GtXf+dATckdv/+ALTRL0SBLr0pVlqT0P460gJ2rZXUYYmLu1rr0gc6UeZTmFmY8cxCHT643RTzKw9PqU3haDwX6JTQhfRiXZOv72g62zt3FXhS/TYMBxSC/V34FH0mFGyu7arGTBP3gwkojVfObWvZ3HTydpH76DNELRUrNd8+pP99W0pchY1g==
Received: from PH8P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::28)
 by DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Thu, 26 Feb
 2026 10:52:44 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:510:345:cafe::c6) by PH8P220CA0018.outlook.office365.com
 (2603:10b6:510:345::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.25 via Frontend Transport; Thu,
 26 Feb 2026 10:52:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 10:52:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:52:24 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:52:21 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v3 15/32] hw/arm/tegra241-cmdqv: Emulate global and VINTF
 VCMDQ register reads
Date: Thu, 26 Feb 2026 10:50:39 +0000
Message-ID: <20260226105056.897-16-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|DS7PR12MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f4de30b-96c7-481e-5814-08de75252bea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|7416014|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: C2iUmwckLcqCMVQSDFFLAXZcAj9R49nYAOdXSNzEjn06nadGp7qwMLhywywWIol/T/qoPE1a8MIQow9MQqztrDtPCboUkagXlB8MLTMpwwS8fsHo+zRF9RoHYZwOlNtYji4Hi7wFoRaRAvSkvFW0q4Tzcc3LO7Am5mWm2roZ89XWloCifKZ2syAP+x1zjghm2vdkKJUB/eZ6IRbI6UXxDTVQjTgg1eBTcr7Q/PUvYQa20Kx/99+qclZ6XqQJY9HOKxiIZ/UtR/lZ6jE9HdrNlHxQuGdtyO20+7NdBuiU4iMVSsH/Cfc4Dqy7o+cnhbZAtCREWSprEJv7ZSoiNVA7F1Z7CuDS1Jmus2qkZfZFqY+9+/aGGoanmKkmahrSBopvymWOdtkSaJVQ6Msy5VDDb6eVL22rR9ybS8Q6rx7bhhIYGUIx6tR9FTsmpMGGhmqb2FBVKT4I00iW78roakSI6TMFBzbGAetN84WJI2C3q1BoW3Kjbr7pMCG1aVv4t8daQuc0fq/j9qeUTEZhio20rVUIz09ST3txPy95o7Vw9gcQv2dkS+zCY7FpbtYOPcQIAClIOYeRxTfeuDUHnU25lI/XkJR4Fycdzb9g05axTbWVK/cB6InEQe16UzVVlAaBA51soNB3Z1vlE3DPgw+VnyOP7cTaAjlbKxFxn6tvKrdGTL7kFC2PRbQIhbOfKYlN+8eDvTd29smlfyom6KK/kYix7/ldjlJmt0cwqP1oNB9SA8fTZ2xnpSe3ikJfFtPDwXShMInC6LTXeEJWI63vnsbsPfZXsSTIwumLIGMkwvGnABhWzhi/WmpI1OnyaLj4uaj/b2vdBuPhMtuz4UtX/A==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: e02HHXIGRRbq7YfUW3p3IAUcvQpyM1oljEUXxLFWA1hD8ZBudahTqhTVeeLVI0+q0CtJSCG5KG8BSZmpW2FHOO3AenXTMtsHACIyfU5hMvchPw7/tGCpwLM7EkTS4YmLpUjRk81t/sjtXwKUYk5d4Pm9AdcFXQQtOsybpDXJ2ZHO3A0tily5ykXJJOtl2aMJJRot6FtnfRySap1JqEBpbBmiTQSWePhIK7DDWDxHj8t+ZReVTlF2DgtRk7K1zpqKqTzlYkGWXpHp8nfyoxH9zE9E71S6hKSfs24noE6hLeBq1ABq7pHRzCCoRyG8Kt2MOLREHrdFg9z88roW9XnRz5Ixzk5TRFGEnn1kV8ceRvT1PjW7/0vVGw1uDD2R6Bf+4oyZSA9ji/t/Jss7/hlJKpoD+NFkFM0AwYio68qC1mVd5R4OEy/BDYdWIWBh1q5m
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 10:52:44.1421 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f4de30b-96c7-481e-5814-08de75252bea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6214
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Tegra241 CMDQV exposes per-VCMDQ register windows through two MMIO views:

  -Global VCMDQ registers at 0x10000/0x20000
  -VINTF VCMDQ (VI_VCMDQ) registers at 0x30000/0x40000

The VI_VCMDQ register ranges are an alias of the global VCMDQ registers
and are only meaningful when a VCMDQ is mapped to a VINTF via ioctl
IOMMU_HW_QUEUE_ALLOC.

Add read side emulation for both global VCMDQ and VI_VCMDQ register
ranges. MMIO accesses are decoded to extract the VCMDQ instance index
and normalized to a VCMDQ0_* register offset, allowing a single helper
to service all VCMDQ instances.

VI_VCMDQ accesses are translated to their equivalent global VCMDQ
offsets and reuse the same decoding path. All VCMDQ reads are currently
served from cached register state.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.h | 178 ++++++++++++++++++++++++++++++++++++++++
 hw/arm/tegra241-cmdqv.c |  77 +++++++++++++++++
 2 files changed, 255 insertions(+)

diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index 50bcecee9d..d379b8860c 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -48,6 +48,14 @@ typedef struct Tegra241CMDQV {
     uint32_t vintf_sid_match[16];
     uint32_t vintf_sid_replace[16];
     uint32_t vintf_cmdq_err_map[4];
+    uint32_t vcmdq_cons_indx[TEGRA241_CMDQV_MAX_CMDQ];
+    uint32_t vcmdq_prod_indx[TEGRA241_CMDQV_MAX_CMDQ];
+    uint32_t vcmdq_config[TEGRA241_CMDQV_MAX_CMDQ];
+    uint32_t vcmdq_status[TEGRA241_CMDQV_MAX_CMDQ];
+    uint32_t vcmdq_gerror[TEGRA241_CMDQV_MAX_CMDQ];
+    uint32_t vcmdq_gerrorn[TEGRA241_CMDQV_MAX_CMDQ];
+    uint64_t vcmdq_base[TEGRA241_CMDQV_MAX_CMDQ];
+    uint64_t vcmdq_cons_indx_base[TEGRA241_CMDQV_MAX_CMDQ];
 } Tegra241CMDQV;
 
 /* Global CMDQV MMIO registers (offset 0x00000) */
@@ -141,6 +149,176 @@ A_VINTFi_LVCMDQ_ERR_MAP_(0, 0)
 /* Omitting [0][1~2] as not being directly called */
 A_VINTFi_LVCMDQ_ERR_MAP_(0, 3)
 
+/*
+ * VCMDQ register windows.
+ *
+ * Page 0 @ 0x10000: VCMDQ control and status registers
+ * Page 1 @ 0x20000: VCMDQ base and DRAM address registers
+ */
+#define A_VCMDQi_CONS_INDX(i)                       \
+    REG32(VCMDQ##i##_CONS_INDX, 0x10000 + i * 0x80) \
+    FIELD(VCMDQ##i##_CONS_INDX, RD, 0, 20)          \
+    FIELD(VCMDQ##i##_CONS_INDX, ERR, 24, 7)
+
+A_VCMDQi_CONS_INDX(0)
+A_VCMDQi_CONS_INDX(1)
+
+#define V_VCMDQ_CONS_INDX_ERR_CERROR_NONE 0
+#define V_VCMDQ_CONS_INDX_ERR_CERROR_ILL_OPCODE 1
+#define V_VCMDQ_CONS_INDX_ERR_CERROR_ABT 2
+#define V_VCMDQ_CONS_INDX_ERR_CERROR_ATC_INV_SYNC 3
+#define V_VCMDQ_CONS_INDX_ERR_CERROR_ILL_ACCESS 4
+
+#define A_VCMDQi_PROD_INDX(i)                             \
+    REG32(VCMDQ##i##_PROD_INDX, 0x10000 + 0x4 + i * 0x80) \
+    FIELD(VCMDQ##i##_PROD_INDX, WR, 0, 20)
+
+A_VCMDQi_PROD_INDX(0)
+A_VCMDQi_PROD_INDX(1)
+
+#define A_VCMDQi_CONFIG(i)                             \
+    REG32(VCMDQ##i##_CONFIG, 0x10000 + 0x8 + i * 0x80) \
+    FIELD(VCMDQ##i##_CONFIG, CMDQ_EN, 0, 1)
+
+A_VCMDQi_CONFIG(0)
+A_VCMDQi_CONFIG(1)
+
+#define A_VCMDQi_STATUS(i)                             \
+    REG32(VCMDQ##i##_STATUS, 0x10000 + 0xc + i * 0x80) \
+    FIELD(VCMDQ##i##_STATUS, CMDQ_EN_OK, 0, 1)
+
+A_VCMDQi_STATUS(0)
+A_VCMDQi_STATUS(1)
+
+#define A_VCMDQi_GERROR(i)                               \
+    REG32(VCMDQ##i##_GERROR, 0x10000 + 0x10 + i * 0x80)  \
+    FIELD(VCMDQ##i##_GERROR, CMDQ_ERR, 0, 1)             \
+    FIELD(VCMDQ##i##_GERROR, CONS_DRAM_WR_ABT_ERR, 1, 1) \
+    FIELD(VCMDQ##i##_GERROR, CMDQ_INIT_ERR, 2, 1)
+
+A_VCMDQi_GERROR(0)
+A_VCMDQi_GERROR(1)
+
+#define A_VCMDQi_GERRORN(i)                               \
+    REG32(VCMDQ##i##_GERRORN, 0x10000 + 0x14 + i * 0x80)  \
+    FIELD(VCMDQ##i##_GERRORN, CMDQ_ERR, 0, 1)             \
+    FIELD(VCMDQ##i##_GERRORN, CONS_DRAM_WR_ABT_ERR, 1, 1) \
+    FIELD(VCMDQ##i##_GERRORN, CMDQ_INIT_ERR, 2, 1)
+
+A_VCMDQi_GERRORN(0)
+A_VCMDQi_GERRORN(1)
+
+#define A_VCMDQi_BASE_L(i)                       \
+    REG32(VCMDQ##i##_BASE_L, 0x20000 + i * 0x80) \
+    FIELD(VCMDQ##i##_BASE_L, LOG2SIZE, 0, 5)     \
+    FIELD(VCMDQ##i##_BASE_L, ADDR, 5, 27)
+
+A_VCMDQi_BASE_L(0)
+A_VCMDQi_BASE_L(1)
+
+#define A_VCMDQi_BASE_H(i)                             \
+    REG32(VCMDQ##i##_BASE_H, 0x20000 + 0x4 + i * 0x80) \
+    FIELD(VCMDQ##i##_BASE_H, ADDR, 0, 16)
+
+A_VCMDQi_BASE_H(0)
+A_VCMDQi_BASE_H(1)
+
+#define A_VCMDQi_CONS_INDX_BASE_DRAM_L(i)                             \
+    REG32(VCMDQ##i##_CONS_INDX_BASE_DRAM_L, 0x20000 + 0x8 + i * 0x80) \
+    FIELD(VCMDQ##i##_CONS_INDX_BASE_DRAM_L, ADDR, 0, 32)
+
+A_VCMDQi_CONS_INDX_BASE_DRAM_L(0)
+A_VCMDQi_CONS_INDX_BASE_DRAM_L(1)
+
+#define A_VCMDQi_CONS_INDX_BASE_DRAM_H(i)                             \
+    REG32(VCMDQ##i##_CONS_INDX_BASE_DRAM_H, 0x20000 + 0xc + i * 0x80) \
+    FIELD(VCMDQ##i##_CONS_INDX_BASE_DRAM_H, ADDR, 0, 16)
+
+A_VCMDQi_CONS_INDX_BASE_DRAM_H(0)
+A_VCMDQi_CONS_INDX_BASE_DRAM_H(1)
+
+/*
+ * VI_VCMDQ register windows (VCMDQs mapped via VINTF).
+ *
+ * Page 0 @ 0x30000: VI_VCMDQ control and status registers
+ * Page 1 @ 0x40000: VI_VCMDQ base and DRAM address registers
+ */
+#define A_VI_VCMDQi_CONS_INDX(i)                       \
+    REG32(VI_VCMDQ##i##_CONS_INDX, 0x30000 + i * 0x80) \
+    FIELD(VI_VCMDQ##i##_CONS_INDX, RD, 0, 20)          \
+    FIELD(VI_VCMDQ##i##_CONS_INDX, ERR, 24, 7)
+
+A_VI_VCMDQi_CONS_INDX(0)
+A_VI_VCMDQi_CONS_INDX(1)
+
+#define A_VI_VCMDQi_PROD_INDX(i)                             \
+    REG32(VI_VCMDQ##i##_PROD_INDX, 0x30000 + 0x4 + i * 0x80) \
+    FIELD(VI_VCMDQ##i##_PROD_INDX, WR, 0, 20)
+
+A_VI_VCMDQi_PROD_INDX(0)
+A_VI_VCMDQi_PROD_INDX(1)
+
+#define A_VI_VCMDQi_CONFIG(i)                             \
+    REG32(VI_VCMDQ##i##_CONFIG, 0x30000 + 0x8 + i * 0x80) \
+    FIELD(VI_VCMDQ##i##_CONFIG, CMDQ_EN, 0, 1)
+
+A_VI_VCMDQi_CONFIG(0)
+A_VI_VCMDQi_CONFIG(1)
+
+#define A_VI_VCMDQi_STATUS(i)                             \
+    REG32(VI_VCMDQ##i##_STATUS, 0x30000 + 0xc + i * 0x80) \
+    FIELD(VI_VCMDQ##i##_STATUS, CMDQ_EN_OK, 0, 1)
+
+A_VI_VCMDQi_STATUS(0)
+A_VI_VCMDQi_STATUS(1)
+
+#define A_VI_VCMDQi_GERROR(i)                               \
+    REG32(VI_VCMDQ##i##_GERROR, 0x30000 + 0x10 + i * 0x80)  \
+    FIELD(VI_VCMDQ##i##_GERROR, CMDQ_ERR, 0, 1)             \
+    FIELD(VI_VCMDQ##i##_GERROR, CONS_DRAM_WR_ABT_ERR, 1, 1) \
+    FIELD(VI_VCMDQ##i##_GERROR, CMDQ_INIT_ERR, 2, 1)
+
+A_VI_VCMDQi_GERROR(0)
+A_VI_VCMDQi_GERROR(1)
+
+#define A_VI_VCMDQi_GERRORN(i)                               \
+    REG32(VI_VCMDQ##i##_GERRORN, 0x30000 + 0x14 + i * 0x80)  \
+    FIELD(VI_VCMDQ##i##_GERRORN, CMDQ_ERR, 0, 1)             \
+    FIELD(VI_VCMDQ##i##_GERRORN, CONS_DRAM_WR_ABT_ERR, 1, 1) \
+    FIELD(VI_VCMDQ##i##_GERRORN, CMDQ_INIT_ERR, 2, 1)
+
+A_VI_VCMDQi_GERRORN(0)
+A_VI_VCMDQi_GERRORN(1)
+
+#define A_VI_VCMDQi_BASE_L(i)                       \
+    REG32(VI_VCMDQ##i##_BASE_L, 0x40000 + i * 0x80) \
+    FIELD(VI_VCMDQ##i##_BASE_L, LOG2SIZE, 0, 5)     \
+    FIELD(VI_VCMDQ##i##_BASE_L, ADDR, 5, 27)
+
+A_VI_VCMDQi_BASE_L(0)
+A_VI_VCMDQi_BASE_L(1)
+
+#define A_VI_VCMDQi_BASE_H(i)                             \
+    REG32(VI_VCMDQ##i##_BASE_H, 0x40000 + 0x4 + i * 0x80) \
+    FIELD(VI_VCMDQ##i##_BASE_H, ADDR, 0, 16)
+
+A_VI_VCMDQi_BASE_H(0)
+A_VI_VCMDQi_BASE_H(1)
+
+#define A_VI_VCMDQi_CONS_INDX_BASE_DRAM_L(i)                             \
+    REG32(VI_VCMDQ##i##_CONS_INDX_BASE_DRAM_L, 0x40000 + 0x8 + i * 0x80) \
+    FIELD(VI_VCMDQ##i##_CONS_INDX_BASE_DRAM_L, ADDR, 0, 32)
+
+A_VI_VCMDQi_CONS_INDX_BASE_DRAM_L(0)
+A_VI_VCMDQi_CONS_INDX_BASE_DRAM_L(1)
+
+#define A_VI_VCMDQi_CONS_INDX_BASE_DRAM_H(i)                             \
+    REG32(VI_VCMDQ##i##_CONS_INDX_BASE_DRAM_H, 0x40000 + 0xc + i * 0x80) \
+    FIELD(VI_VCMDQ##i##_CONS_INDX_BASE_DRAM_H, ADDR, 0, 16)
+
+A_VI_VCMDQi_CONS_INDX_BASE_DRAM_H(0)
+A_VI_VCMDQi_CONS_INDX_BASE_DRAM_H(1)
+
 const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void);
 
 #endif /* HW_ARM_TEGRA241_CMDQV_H */
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index a3830a02d6..d2e6938e44 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -14,6 +14,46 @@
 #include "smmuv3-accel.h"
 #include "tegra241-cmdqv.h"
 
+/*
+ * Read a VCMDQ register using VCMDQ0_* offsets.
+ *
+ * The caller normalizes the MMIO offset such that @offset0 always refers
+ * to a VCMDQ0_* register, while @index selects the VCMDQ instance.
+ *
+ * All VCMDQ accesses return cached registers.
+ */
+static uint64_t tegra241_cmdqv_read_vcmdq(Tegra241CMDQV *cmdqv, hwaddr offset0,
+                                          int index)
+{
+    switch (offset0) {
+    case A_VCMDQ0_CONS_INDX:
+        return cmdqv->vcmdq_cons_indx[index];
+    case A_VCMDQ0_PROD_INDX:
+        return cmdqv->vcmdq_prod_indx[index];
+    case A_VCMDQ0_CONFIG:
+        return cmdqv->vcmdq_config[index];
+    case A_VCMDQ0_STATUS:
+        return cmdqv->vcmdq_status[index];
+    case A_VCMDQ0_GERROR:
+        return cmdqv->vcmdq_gerror[index];
+    case A_VCMDQ0_GERRORN:
+        return cmdqv->vcmdq_gerrorn[index];
+    case A_VCMDQ0_BASE_L:
+        return cmdqv->vcmdq_base[index];
+    case A_VCMDQ0_BASE_H:
+        return cmdqv->vcmdq_base[index] >> 32;
+    case A_VCMDQ0_CONS_INDX_BASE_DRAM_L:
+        return cmdqv->vcmdq_cons_indx_base[index];
+    case A_VCMDQ0_CONS_INDX_BASE_DRAM_H:
+        return cmdqv->vcmdq_cons_indx_base[index] >> 32;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s unhandled read access at 0x%" PRIx64 "\n",
+                      __func__, offset0);
+        return 0;
+    }
+}
+
 static uint64_t tegra241_cmdqv_read_vintf(Tegra241CMDQV *cmdqv, hwaddr offset)
 {
     int i;
@@ -42,6 +82,7 @@ static uint64_t tegra241_cmdqv_read_vintf(Tegra241CMDQV *cmdqv, hwaddr offset)
 static uint64_t tegra241_cmdqv_read(void *opaque, hwaddr offset, unsigned size)
 {
     Tegra241CMDQV *cmdqv = (Tegra241CMDQV *)opaque;
+    int index;
 
     if (offset >= TEGRA241_CMDQV_IO_LEN) {
         qemu_log_mask(LOG_UNIMP,
@@ -67,6 +108,42 @@ static uint64_t tegra241_cmdqv_read(void *opaque, hwaddr offset, unsigned size)
         return cmdqv->cmdq_alloc_map[(offset - A_CMDQ_ALLOC_MAP_0) / 4];
     case A_VINTF0_CONFIG ... A_VINTF0_LVCMDQ_ERR_MAP_3:
         return tegra241_cmdqv_read_vintf(cmdqv, offset);
+    case A_VI_VCMDQ0_CONS_INDX ... A_VI_VCMDQ1_GERRORN:
+        /*
+         * VI_VCMDQ registers (VINTF logical view) have the same per-VCMDQ
+         * layout as the global VCMDQ registers, but are based at 0x30000
+         * instead of 0x10000.
+         *
+         * Subtract 0x20000 to translate a VI_VCMDQ offset into the equivalent
+         * global VCMDQ offset, then fall through to reuse the common VCMDQ
+         * decoding logic below.
+         */
+        offset -= 0x20000;
+        QEMU_FALLTHROUGH;
+    case A_VCMDQ0_CONS_INDX ... A_VCMDQ1_GERRORN:
+        /*
+         * Decode a per-VCMDQ register access.
+         *
+         * The hardware supports up to 128 identical VCMDQ instances; we
+         * currently expose TEGRA241_CMDQV_MAX_CMDQ (= 2). Each VCMDQ
+         * occupies a 0x80-byte window starting at 0x10000.
+         *
+         * The MMIO offset is decoded to extract the VCMDQ index and normalized
+         * to the corresponding VCMDQ0_* register by subtracting index * 0x80.
+         *
+         * A single helper then services all VCMDQs, with @index selecting the
+         * instance.
+         */
+        index = (offset - 0x10000) / 0x80;
+        return tegra241_cmdqv_read_vcmdq(cmdqv, offset - index * 0x80, index);
+    case A_VI_VCMDQ0_BASE_L ... A_VI_VCMDQ1_CONS_INDX_BASE_DRAM_H:
+        /* Same decode logic as A_VI_VCMDQx_CONS_INDX case above */
+        offset -= 0x20000;
+        QEMU_FALLTHROUGH;
+    case A_VCMDQ0_BASE_L ... A_VCMDQ1_CONS_INDX_BASE_DRAM_H:
+        /* Same decode logic as A_VCMDQx_CONS_INDX case above */
+        index = (offset - 0x20000) / 0x80;
+        return tegra241_cmdqv_read_vcmdq(cmdqv, offset - index * 0x80, index);
     default:
         qemu_log_mask(LOG_UNIMP, "%s unhandled read access at 0x%" PRIx64 "\n",
                       __func__, offset);
-- 
2.43.0


