Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 908C8F41991
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 11:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCxwW-0001H0-Aj; Wed, 15 Apr 2026 06:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxwR-00013K-68; Wed, 15 Apr 2026 06:57:56 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxwO-000465-V2; Wed, 15 Apr 2026 06:57:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b3aNggBJAwyyqJBb1vnnEC/CuZ3u2untuEXv4hCb9Eqk6FwcaHmuRuUaicAAPo8E8rmKTdMuNSQfrtNd4OMdIf1p7qlYtkWRLcc4bnFP/IKB8GbIunbRS/I+q58UPtXX+7an35nTq9LIbaXWZKnOqJAqKTZk+AWXdTKyp0IiIULBFVm4XrTV5CFRzwiMsFgWq5ykaQfw+qJMjm59TupNtX0Hi+DcrSCT1w6DJsU0IGx/IXd/ZeM/xVsChJv7k1RJjLvzNCuaKnGyvKAkNXdBDnCGl1RANbr6B7AeE5K0t/aXDz8Uz/rMavvaeqR0fa2AuDv/dgSpRgORF77QeeCuIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=niuRGh63KDsdAfqJ0562BDjZM+g4wfhRA0S9dqbJYZs=;
 b=X1e7zts96XSrQGe1YCH7nDkafm7wjzZu6smDpQA2G/94HHBfF9w/93iA4aJkLKkBsbQreANn8B3FlGqkjkgyKxBGppvBz5x1LngrojNxJ3TSOOyxzjo54cfVVN+6BmgmwNz5zqXYMVnZYoun5UwfkY6zYnS6OJIsWXTcJxuSAaFDBLly8StRoWH0aDxFXT+Hi+ePcMuXQi6d9QMaCD1avkciv6NQfeqbwJ0XV4zPWdXXRkcAfWtdEpMkH3B6OvC7KKSB2oUZs1hNsUFrfKFBNYOsNYfKtFd7+bN+xVEMnp+zjAS8ljzuKGyeki3/VrRkAiOLkiqC5TtjC/TcLxKGpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niuRGh63KDsdAfqJ0562BDjZM+g4wfhRA0S9dqbJYZs=;
 b=Pr6pNuFheSMFatUb16Ukbz/VV2m1VUBfTRwkCht/TYQ1xT2nevte91n6rJY68UTOMvIjZwnh8Wcv1huUMqDj4mT135/6+ho758RJ0OqxBfVDeA26CMCi0W+dJfhOzSPX1KnndNvIdWdg1E/tCbQ1yr6b/y+1at13SN5RF2ONKbtHmB7Go2JgVYFbDZU9um7KX+MhWgkS4Yt/n2aMkDfu7qa3nhZJqcxbd8mRorN1x/p3iwx68BtiNNAY053wkp0c5eSsvGXz6yIY8l5zN8WcJwhSPISsUcCIEfoePHS2rmz3v4KELhDid0EHulOUoBa9TugLYU3cAMJ5s//WmAV/gg==
Received: from DM6PR01CA0030.prod.exchangelabs.com (2603:10b6:5:296::35) by
 LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.20; Wed, 15 Apr 2026 10:57:42 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:5:296:cafe::f9) by DM6PR01CA0030.outlook.office365.com
 (2603:10b6:5:296::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Wed,
 15 Apr 2026 10:57:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 10:57:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:57:29 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:57:25 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v4 15/31] hw/arm/tegra241-cmdqv: Emulate VCMDQ register reads
Date: Wed, 15 Apr 2026 11:55:36 +0100
Message-ID: <20260415105552.622421-16-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|LV2PR12MB5968:EE_
X-MS-Office365-Filtering-Correlation-Id: f94d0f72-fabf-4076-ad62-08de9addd113
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: fs36zJ2ElvK/rHvvTl3E2sFRX00uGjdZqdR4uQyqhFNfFfsp5JjZ2JRPA1RV0u9UmlEJ5QsBBt1PzusaG2A6bzxenGmwP1xBWUo+KCNu38GTAk+eodhhj1Twv8M4gMYzNV506u6muIL3sv4vuT0DYMhhYFkfgA4fcTfkizLpLPeYyIFKhH9WW1bth024jFyLGcdaZga2ZeywwugxayKaXTCyuv3e/Er+FukKewYWK5WdOz3rllNVCqaA7KXPTJR5niq6F9cGahU7Z0ROTnAfU3OzLEKLve85dxtHdHPzgqnBG6iXcczi2h/FFjDsr1MQmz742SAtijkHIxFjqs5FEyZqF4PDNzXb71UevrE0qneT2EOsuiWWU0UxAFeIPHa0df9/+oxXqpPoo+QGKJ7b3S6Ipxng6G6TnLdYRqpo0WaVyHRcWaTRjxKwgE3qKVB39Nk1k2GiUv6+uUW0iLLxU095tO21AyZEcGY5SsCZ918PjBMUEOrKNGMd11xUyR/B63TgLU9ffo4Ey9hjBrFJGVqlPXUnkwXgrPUv8VqxJc/nz1WepaiYCbH87YVbZ1Jl8kBSFhUkfdGmikE/24M5J2YI8T5JlADRX1KlG2xT7kbsWrp+Hm8yoGTDs5axy3O5yU/FTJiTk54Fa1Qn/8Iq8lF9dYcGCRl5v0D1Fda5azBA3r731mnpPZUzkm/oD1qSgj17WDX0IjuYO+wEJIaAfswqBMknDrMlKuCo/OaxWyjkboTJKpH+plLmJsS9ks5GLvWQ8GdNg5eiBuN5Ha/18w==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kw7K0+Sb/oE5OUIPSPdVUsL8aMWlxPeGtO7fMgw9lK7LpOt94/avF2RbVaCz7VhwFY69Fk4pRxTmMJL6/2JetywlC9ih/PCFzIpOTk8tRCZw6N350Ara4ITT08ifTuv1yhr/mLxSYcNVje+sL0zb1qyWc0zj2N4JMpypAZatjDMNDj0BNJPVqlCN20Fh2+huEbZo3MMoDa5vwGoxSF6Ke566FUAE6JEVOatzPTs2WvUqbPAvL9HWbL2/xX8OccszFva2UD76eBnCHuPuUad9niQyDbCVC4i0AwAxXRCDxkBzN0m+d7enKFlrgMQrZPz4kLcWYe6Wu0aVFWSk8u3mm7Ga7VSJ7MPYWuKTt3FSJk68I9Hdr8JdhdFtdA+nh72FAOPtD7nLDIfd0w8ct7EF8VPDCurLGkEHxF5usveVgXV3ygQEtpUdCOU0itolSDQu
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 10:57:41.7998 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f94d0f72-fabf-4076-ad62-08de9addd113
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5968
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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

  CMDQV_CMDQ_BASE (0x10000/0x20000): VCMDQ Page0/Page1
  CMDQV_VI_CMDQ_BASE (0x30000/0x40000): VINTF VCMDQ Page0/Page1

VINTF Page0 (0x30000) and VCMDQ Page0 (0x10000) are hardware aliases
addressing the same underlying registers. Add read emulation for both
apertures, backed by a register cache. VINTF Page0 reads are translated
to their VCMDQ Page0 equivalent and served from the same cached state.

Once IOMMU_HW_QUEUE_ALLOC and viommu_mmap are wired up in a subsequent
patch, Page0 register reads will be served directly from the hardware
backed mmap'd page instead of the cache. Page1 registers are always
served from cache.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.h | 185 ++++++++++++++++++++++++++++++++++++++++
 hw/arm/tegra241-cmdqv.c |  73 ++++++++++++++++
 2 files changed, 258 insertions(+)

diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index 965670066d..b8bd8cd8ff 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -29,6 +29,13 @@
  */
 #define TEGRA241_CMDQV_IO_LEN 0x50000
 
+/* CMDQV MMIO aperture bases and VCMDQ stride */
+#define CMDQV_VCMDQ_PAGE0_BASE  0x10000  /* CMDQV_CMDQ_BASE */
+#define CMDQV_VCMDQ_PAGE1_BASE  0x20000
+#define CMDQV_VINTF_PAGE0_BASE  0x30000  /* CMDQV_VI_CMDQ_BASE */
+#define CMDQV_VINTF_PAGE1_BASE  0x40000
+#define CMDQV_VCMDQ_STRIDE      0x80
+
 typedef struct Tegra241CMDQV {
     struct iommu_viommu_tegra241_cmdqv cmdqv_data;
     SMMUv3AccelState *s_accel;
@@ -49,6 +56,14 @@ typedef struct Tegra241CMDQV {
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
 
 /* CMDQ-V Config page registers (offset 0x00000) */
@@ -160,6 +175,176 @@ SMMU_CMDQV_VINTFi_LVCMDQ_ERR_MAP_(0, 0)
 /* MAP_1 and MAP_2 omitted; not referenced directly */
 SMMU_CMDQV_VINTFi_LVCMDQ_ERR_MAP_(0, 3)
 
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
index 3b08ed0ff3..35e6f0bbd6 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -15,6 +15,46 @@
 #include "tegra241-cmdqv.h"
 #include "trace.h"
 
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
 static uint64_t tegra241_cmdqv_config_vintf_read(Tegra241CMDQV *cmdqv,
                                                  hwaddr offset)
 {
@@ -92,6 +132,7 @@ static uint64_t tegra241_cmdqv_read_mmio(void *opaque, hwaddr offset,
 {
     Tegra241CMDQV *cmdqv = (Tegra241CMDQV *)opaque;
     uint64_t val = 0;
+    int index;
 
     if (offset >= TEGRA241_CMDQV_IO_LEN) {
         qemu_log_mask(LOG_UNIMP,
@@ -125,6 +166,38 @@ static uint64_t tegra241_cmdqv_read_mmio(void *opaque, hwaddr offset,
     case A_VINTF0_CONFIG ... A_VINTF0_LVCMDQ_ERR_MAP_3:
         val = tegra241_cmdqv_config_vintf_read(cmdqv, offset);
         break;
+    case A_VI_VCMDQ0_CONS_INDX ... A_VI_VCMDQ1_GERRORN:
+        /*
+         * VINTF Page0 registers have the same per-VCMDQ layout as the
+         * VCMDQ Page0 registers. Translate the VINTF aperture offset to the
+         * equivalent VCMDQ aperture offset, then fall through to reuse the
+         * common VCMDQ decoding logic below.
+         */
+        offset -= CMDQV_VINTF_PAGE0_BASE - CMDQV_VCMDQ_PAGE0_BASE;
+        QEMU_FALLTHROUGH;
+    case A_VCMDQ0_CONS_INDX ... A_VCMDQ1_GERRORN:
+        /*
+         * Decode a per-VCMDQ register access.
+         *
+         * The hardware supports up to 128 identical VCMDQ instances; we
+         * currently expose TEGRA241_CMDQV_MAX_CMDQ (= 2). Each VCMDQ
+         * occupies a CMDQV_VCMDQ_STRIDE-byte window within the page.
+         *
+         * Extract the VCMDQ index and normalize to the VCMDQ0_* register
+         * offset. A single helper services all instances via @index.
+         */
+        index = (offset - CMDQV_VCMDQ_PAGE0_BASE) / CMDQV_VCMDQ_STRIDE;
+        return tegra241_cmdqv_read_vcmdq(cmdqv,
+                offset - index * CMDQV_VCMDQ_STRIDE, index);
+    case A_VI_VCMDQ0_BASE_L ... A_VI_VCMDQ1_CONS_INDX_BASE_DRAM_H:
+        /* Same VINTF-to-VCMDQ translation as VINTF Page0 case above */
+        offset -= CMDQV_VINTF_PAGE1_BASE - CMDQV_VCMDQ_PAGE1_BASE;
+        QEMU_FALLTHROUGH;
+    case A_VCMDQ0_BASE_L ... A_VCMDQ1_CONS_INDX_BASE_DRAM_H:
+        /* Same decode logic as VCMDQ Page0 case above */
+        index = (offset - CMDQV_VCMDQ_PAGE1_BASE) / CMDQV_VCMDQ_STRIDE;
+        return tegra241_cmdqv_read_vcmdq(cmdqv,
+                offset - index * CMDQV_VCMDQ_STRIDE, index);
     default:
         qemu_log_mask(LOG_UNIMP, "%s unhandled read access at 0x%" PRIx64 "\n",
                       __func__, offset);
-- 
2.43.0


