Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F47ACD4F57
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:42:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHrQ-0000Nw-Cf; Tue, 19 May 2026 06:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHrO-0000Gc-6m; Tue, 19 May 2026 06:39:38 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHrL-0006UI-G9; Tue, 19 May 2026 06:39:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TI9hhkkNGR8DxW0dC/vnKncXgbOppAa4fOiyTfgvsGUeMRnOIT2gD46mQ93zxKttcDraQxthRRxbBq/m0ytZDX9ORcAa5imflRWy2YrC/oVE3flbtGWr7U4OFN+x8NR4XQvMWlQ8VzG5ZkzdvNE2+VugOtZwf9iWmPNsBcimSGSKa7Bbjskf0d7jJ9QLvwEIU/Sz1TNhrDvf9uwyZGsHqQ9s1JUboksqIhQA1dOf2LAQFS5PoNxK0WrjI9sqBE+aGr+oLQABW1724lV6FvSOTN99HaobbSVspkFwZPVnL63ikXeUKnfRuuCxGWeZJ07nIeCT64Nr0EcmlW3poOspsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+c1bRcNIojrQHkQqgm6dO9/tMFDCirHUjw24Cng/Ng=;
 b=EuPiMS/rt5jSabKtEDTBG4GnAnVLn9bVh7628NcZRBBrTyPuaQ7SaDK8KN/gUImqRHUnJGaFeEuoGFw1rFqYA1RnGxTookvo3uxNTVc1TMCW1VHhKJ7x1+u632YBCewfJ2uJRDvQE5ev16jvpEf1c6PXCtGHNCsjda/mgFct+nnS8VTdNEXMxcbgHFewbb3oxB+WoKDTCovKxhnNc+fRpnF3G6di1K+TgmXj3wxYGfwTkZzkVfTys9YaDCgjbkqUAaGVQAM4M+X6Gqif73yQp7xgg2rD0bbQcoFvdz7lABcitW5djUsFDMU1+opdgDDXh5L6dde/FLtwwWHbgY8QYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+c1bRcNIojrQHkQqgm6dO9/tMFDCirHUjw24Cng/Ng=;
 b=afVaR1Ur3g3r0d8QKBB7cnTUawLZHw48LUIEaoHFLJnjd9I0z2qB00jjxkfGzZnppSgYXDhgFT+dcNBQPU4eaeCyam5u6chhAiZv5rwECBV9yF1OaocRlJl/GbVFNw6qJakTQEps5kPu2V/CaE8+ecxXdMNZ2ezyGE76UwmeIFz+pXSlVYl5tBSHYxcpBOc5+zxk211kTYeaD6bjWkBEV3zch06eobMM27DtZZ3M/LRx/vB39tIOj5eU4ADKDmNwfoqnG+AXKqYT4Qrf6NXIKnf4SnInvD6G9C0yhDRroOCDrZd/viDcMwb3fLWOGWoY5aKjUlAygFwfExCpS9cluw==
Received: from BL1PR13CA0232.namprd13.prod.outlook.com (2603:10b6:208:2bf::27)
 by LV5PR12MB9778.namprd12.prod.outlook.com (2603:10b6:408:300::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 10:39:31 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:2bf:cafe::26) by BL1PR13CA0232.outlook.office365.com
 (2603:10b6:208:2bf::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 10:39:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 10:39:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:39:15 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:39:11 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v5 15/32] hw/arm/tegra241-cmdqv: Emulate VCMDQ register reads
Date: Tue, 19 May 2026 11:36:53 +0100
Message-ID: <20260519103727.899332-16-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|LV5PR12MB9778:EE_
X-MS-Office365-Filtering-Correlation-Id: fce1bfd0-c9e5-4240-93dc-08deb592e8fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|3023799003|18002099003|22082099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: LOJVvH8DgnLw7nTwuTNbYjBrCRklzPEs169wepCfxVnkneEIoXPmBx4ZpVTTB2+7oYUVV0bBDSsHmqmn1MmxT9h01UyXTYO2KGT6yooSpovfiri4id+91D4wu4uC2xZ1O7akdEyMYA3z1FvaLZmuJ/1Y8YJ5Y82mPYd03EHe2UZVYGmOAfpxL0Dy2jUI+/esjjVkS6VvkGxTEzj3jxJInd13PnDht5mmv2ZZLiOBmEZ+2WIXLdAplhfzEQf1jGQSYll3cGTHU8v8rb11kvwdK97421qgwKKSGD/RxBrjt9kFOnYR9ThrqEnqip91XcrShDpCK9iB5UaMhXiVSJ/O4YPq4cqHA/HH05RoPJgYkVWoAN7H54I70hwHIzChn2LwWehipPvt21ihxnXhzj0/tMxUWgQ5egxGV5r+UVRJhbw0/eRirLpKODMLR/MZoQngyGoDpzxaNQGA6Jp1AfC2PcUYUMwfDgD0UT+RTcwKCJe2qcWjEbYjXjimCA9eVgAPjrYaXnDx09k3IGFTPV9KeciE1n0CoH5Jf4Zqj+nUJDU/5mbMaV+iDUDmauT9CxUu7VL1xp7B7sxrO905OsO3mSKLu3EB9fbUU4dqOe2ply/n19vPWMeRBNnabP6KamcxI8CtqukUVzrxdhKz9evM1G9j+fGpQwrL790+7CglRZ4vpEDGhY48HZ3TeemUtFd3a+tNueDrFCSyfpx1asnWLBKY/4VmcIGhI/ZxT7eyHVA=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(3023799003)(18002099003)(22082099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eqDIieuisWUy7mGNMDwrYv/K57cK1jjEE1SWhW9NtEWMxDEOyaIOdkrOSFA1/fDYetp87BJA7X6rsTAqma1Afj2sUYvaX8rYhEMPipbL0U1XPao39IiBSuQn9JfCg8jdn3bbt2uisWHaB6yfLlYnK2rRQNP+kas/JMTg/8WGdzpI5m4dO8dVlNZtIAuEVY9e/nFEtF76X0zTG2HzfIqXKdE6k3oV3XRCQ5Xb4xg45Ft3BOMG+/NCPCnnTIs3E8x50d3cPWwkahn9+SxZ7qltRZhbZYVM+/mki6AidOKJUcsM9Aejt0MzVIMEIXoCNHvTsb/p1Wv04Gz+GdO+Q/0WIaeqjfEBupejL3zGu5pmmxvM55X0e44xmL6mBiGmcchIjEPD6qGvZn48Kpx3HPERUxO3aB7ZaXie4ClIQrQdoiazOfjjjKdMADX/bWIxo+Pr
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:39:30.9985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fce1bfd0-c9e5-4240-93dc-08deb592e8fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9778
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
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

Once IOMMU_HW_QUEUE_ALLOC and viommu_mmap are wired up in a
subsequent patch, Page 0 reads will be served directly from the
hardware-backed mmap'd page instead of the cache. Page 1 is also a
hardware alias, but the kernel only exposes mmap for Page 0, so
Page 1 reads always trap to QEMU and are served from cache.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.h | 215 ++++++++++++++++++++++++++++++++++++++++
 hw/arm/tegra241-cmdqv.c |  95 ++++++++++++++++++
 hw/arm/trace-events     |   2 +
 3 files changed, 312 insertions(+)

diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index ace327443a..6b21a407af 100644
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
 typedef struct Tegra241CMDQV {
     struct iommu_viommu_tegra241_cmdqv cmdqv_data;
     SMMUv3AccelState *s_accel;
@@ -52,6 +59,19 @@ typedef struct Tegra241CMDQV {
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
@@ -143,6 +163,201 @@ REG32(VINTF0_LVCMDQ_ERR_MAP_0, 0x10c0)
 FIELD(VINTF0_LVCMDQ_ERR_MAP_0, LVCMDQ_ERR_MAP, 0, 32)
 #define A_VINTF0_LVCMDQ_ERR_MAP_3 (A_VINTF0_LVCMDQ_ERR_MAP_0 + 3 * 4)
 
+/*
+ * VCMDQ Page 0 register window @ CMDQV_VCMDQ_PAGE0_BASE.
+ * Direct VCMDQ aperture; control and status registers.
+ */
+#define SMMU_CMDQV_VCMDQi_CONS_INDX_(i)                     \
+    REG32(VCMDQ##i##_CONS_INDX,                             \
+          CMDQV_VCMDQ_PAGE0_BASE + i * CMDQV_VCMDQ_STRIDE)  \
+    FIELD(VCMDQ##i##_CONS_INDX, RD, 0, 20)                  \
+    FIELD(VCMDQ##i##_CONS_INDX, ERR, 24, 7)
+
+SMMU_CMDQV_VCMDQi_CONS_INDX_(0)
+SMMU_CMDQV_VCMDQi_CONS_INDX_(1)
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
+SMMU_CMDQV_VCMDQi_PROD_INDX_(0)
+SMMU_CMDQV_VCMDQi_PROD_INDX_(1)
+
+#define SMMU_CMDQV_VCMDQi_CONFIG_(i)                             \
+    REG32(VCMDQ##i##_CONFIG,                                     \
+          CMDQV_VCMDQ_PAGE0_BASE + 0x8 + i * CMDQV_VCMDQ_STRIDE) \
+    FIELD(VCMDQ##i##_CONFIG, CMDQ_EN, 0, 1)
+
+SMMU_CMDQV_VCMDQi_CONFIG_(0)
+SMMU_CMDQV_VCMDQi_CONFIG_(1)
+
+#define SMMU_CMDQV_VCMDQi_STATUS_(i)                             \
+    REG32(VCMDQ##i##_STATUS,                                     \
+          CMDQV_VCMDQ_PAGE0_BASE + 0xc + i * CMDQV_VCMDQ_STRIDE) \
+    FIELD(VCMDQ##i##_STATUS, CMDQ_EN_OK, 0, 1)
+
+SMMU_CMDQV_VCMDQi_STATUS_(0)
+SMMU_CMDQV_VCMDQi_STATUS_(1)
+
+#define SMMU_CMDQV_VCMDQi_GERROR_(i)                              \
+    REG32(VCMDQ##i##_GERROR,                                      \
+          CMDQV_VCMDQ_PAGE0_BASE + 0x10 + i * CMDQV_VCMDQ_STRIDE) \
+    FIELD(VCMDQ##i##_GERROR, CMDQ_ERR, 0, 1)                      \
+    FIELD(VCMDQ##i##_GERROR, CONS_DRAM_WR_ABT_ERR, 1, 1)          \
+    FIELD(VCMDQ##i##_GERROR, CMDQ_INIT_ERR, 2, 1)
+
+SMMU_CMDQV_VCMDQi_GERROR_(0)
+SMMU_CMDQV_VCMDQi_GERROR_(1)
+
+#define SMMU_CMDQV_VCMDQi_GERRORN_(i)                             \
+    REG32(VCMDQ##i##_GERRORN,                                     \
+          CMDQV_VCMDQ_PAGE0_BASE + 0x14 + i * CMDQV_VCMDQ_STRIDE) \
+    FIELD(VCMDQ##i##_GERRORN, CMDQ_ERR, 0, 1)                     \
+    FIELD(VCMDQ##i##_GERRORN, CONS_DRAM_WR_ABT_ERR, 1, 1)         \
+    FIELD(VCMDQ##i##_GERRORN, CMDQ_INIT_ERR, 2, 1)
+
+SMMU_CMDQV_VCMDQi_GERRORN_(0)
+SMMU_CMDQV_VCMDQi_GERRORN_(1)
+
+/*
+ * VCMDQ Page 1 register window @ CMDQV_VCMDQ_PAGE1_BASE.
+ * Direct VCMDQ aperture; base and DRAM address registers.
+ */
+#define SMMU_CMDQV_VCMDQi_BASE_L_(i)                                          \
+    REG32(VCMDQ##i##_BASE_L, CMDQV_VCMDQ_PAGE1_BASE + i * CMDQV_VCMDQ_STRIDE) \
+    FIELD(VCMDQ##i##_BASE_L, LOG2SIZE, 0, 5)                                  \
+    FIELD(VCMDQ##i##_BASE_L, ADDR, 5, 27)
+
+SMMU_CMDQV_VCMDQi_BASE_L_(0)
+SMMU_CMDQV_VCMDQi_BASE_L_(1)
+
+#define SMMU_CMDQV_VCMDQi_BASE_H_(i)                             \
+    REG32(VCMDQ##i##_BASE_H,                                     \
+          CMDQV_VCMDQ_PAGE1_BASE + 0x4 + i * CMDQV_VCMDQ_STRIDE) \
+    FIELD(VCMDQ##i##_BASE_H, ADDR, 0, 16)
+
+SMMU_CMDQV_VCMDQi_BASE_H_(0)
+SMMU_CMDQV_VCMDQi_BASE_H_(1)
+
+#define SMMU_CMDQV_VCMDQi_CONS_INDX_BASE_DRAM_L_(i)              \
+    REG32(VCMDQ##i##_CONS_INDX_BASE_DRAM_L,                      \
+          CMDQV_VCMDQ_PAGE1_BASE + 0x8 + i * CMDQV_VCMDQ_STRIDE) \
+    FIELD(VCMDQ##i##_CONS_INDX_BASE_DRAM_L, ADDR, 0, 32)
+
+SMMU_CMDQV_VCMDQi_CONS_INDX_BASE_DRAM_L_(0)
+SMMU_CMDQV_VCMDQi_CONS_INDX_BASE_DRAM_L_(1)
+
+#define SMMU_CMDQV_VCMDQi_CONS_INDX_BASE_DRAM_H_(i)              \
+    REG32(VCMDQ##i##_CONS_INDX_BASE_DRAM_H,                      \
+          CMDQV_VCMDQ_PAGE1_BASE + 0xc + i * CMDQV_VCMDQ_STRIDE) \
+    FIELD(VCMDQ##i##_CONS_INDX_BASE_DRAM_H, ADDR, 0, 16)
+
+SMMU_CMDQV_VCMDQi_CONS_INDX_BASE_DRAM_H_(0)
+SMMU_CMDQV_VCMDQi_CONS_INDX_BASE_DRAM_H_(1)
+
+/*
+ * VINTF0 LVCMDQ Page 0 register window @ CMDQV_VINTF_PAGE0_BASE.
+ * Logical VCMDQ aperture (VCMDQs mapped via VINTF); control and
+ * status registers. Hardware alias of VCMDQ Page 0 above.
+ */
+#define SMMU_CMDQV_VI_VCMDQi_CONS_INDX_(i)                  \
+    REG32(VI_VCMDQ##i##_CONS_INDX,                          \
+          CMDQV_VINTF_PAGE0_BASE + i * CMDQV_VCMDQ_STRIDE)  \
+    FIELD(VI_VCMDQ##i##_CONS_INDX, RD, 0, 20)               \
+    FIELD(VI_VCMDQ##i##_CONS_INDX, ERR, 24, 7)
+
+SMMU_CMDQV_VI_VCMDQi_CONS_INDX_(0)
+SMMU_CMDQV_VI_VCMDQi_CONS_INDX_(1)
+
+#define SMMU_CMDQV_VI_VCMDQi_PROD_INDX_(i)                       \
+    REG32(VI_VCMDQ##i##_PROD_INDX,                               \
+          CMDQV_VINTF_PAGE0_BASE + 0x4 + i * CMDQV_VCMDQ_STRIDE) \
+    FIELD(VI_VCMDQ##i##_PROD_INDX, WR, 0, 20)
+
+SMMU_CMDQV_VI_VCMDQi_PROD_INDX_(0)
+SMMU_CMDQV_VI_VCMDQi_PROD_INDX_(1)
+
+#define SMMU_CMDQV_VI_VCMDQi_CONFIG_(i)                          \
+    REG32(VI_VCMDQ##i##_CONFIG,                                  \
+          CMDQV_VINTF_PAGE0_BASE + 0x8 + i * CMDQV_VCMDQ_STRIDE) \
+    FIELD(VI_VCMDQ##i##_CONFIG, CMDQ_EN, 0, 1)
+
+SMMU_CMDQV_VI_VCMDQi_CONFIG_(0)
+SMMU_CMDQV_VI_VCMDQi_CONFIG_(1)
+
+#define SMMU_CMDQV_VI_VCMDQi_STATUS_(i)                          \
+    REG32(VI_VCMDQ##i##_STATUS,                                  \
+          CMDQV_VINTF_PAGE0_BASE + 0xc + i * CMDQV_VCMDQ_STRIDE) \
+    FIELD(VI_VCMDQ##i##_STATUS, CMDQ_EN_OK, 0, 1)
+
+SMMU_CMDQV_VI_VCMDQi_STATUS_(0)
+SMMU_CMDQV_VI_VCMDQi_STATUS_(1)
+
+#define SMMU_CMDQV_VI_VCMDQi_GERROR_(i)                           \
+    REG32(VI_VCMDQ##i##_GERROR,                                   \
+          CMDQV_VINTF_PAGE0_BASE + 0x10 + i * CMDQV_VCMDQ_STRIDE) \
+    FIELD(VI_VCMDQ##i##_GERROR, CMDQ_ERR, 0, 1)                   \
+    FIELD(VI_VCMDQ##i##_GERROR, CONS_DRAM_WR_ABT_ERR, 1, 1)       \
+    FIELD(VI_VCMDQ##i##_GERROR, CMDQ_INIT_ERR, 2, 1)
+
+SMMU_CMDQV_VI_VCMDQi_GERROR_(0)
+SMMU_CMDQV_VI_VCMDQi_GERROR_(1)
+
+#define SMMU_CMDQV_VI_VCMDQi_GERRORN_(i)                          \
+    REG32(VI_VCMDQ##i##_GERRORN,                                  \
+          CMDQV_VINTF_PAGE0_BASE + 0x14 + i * CMDQV_VCMDQ_STRIDE) \
+    FIELD(VI_VCMDQ##i##_GERRORN, CMDQ_ERR, 0, 1)                  \
+    FIELD(VI_VCMDQ##i##_GERRORN, CONS_DRAM_WR_ABT_ERR, 1, 1)      \
+    FIELD(VI_VCMDQ##i##_GERRORN, CMDQ_INIT_ERR, 2, 1)
+
+SMMU_CMDQV_VI_VCMDQi_GERRORN_(0)
+SMMU_CMDQV_VI_VCMDQi_GERRORN_(1)
+
+/*
+ * VINTF0 LVCMDQ Page 1 register window @ CMDQV_VINTF_PAGE1_BASE.
+ * Logical VCMDQ aperture (VCMDQs mapped via VINTF); base and DRAM
+ * address registers. Hardware alias of VCMDQ Page 1 above.
+ */
+#define SMMU_CMDQV_VI_VCMDQi_BASE_L_(i)                     \
+    REG32(VI_VCMDQ##i##_BASE_L,                             \
+          CMDQV_VINTF_PAGE1_BASE + i * CMDQV_VCMDQ_STRIDE)  \
+    FIELD(VI_VCMDQ##i##_BASE_L, LOG2SIZE, 0, 5)             \
+    FIELD(VI_VCMDQ##i##_BASE_L, ADDR, 5, 27)
+
+SMMU_CMDQV_VI_VCMDQi_BASE_L_(0)
+SMMU_CMDQV_VI_VCMDQi_BASE_L_(1)
+
+#define SMMU_CMDQV_VI_VCMDQi_BASE_H_(i)                          \
+    REG32(VI_VCMDQ##i##_BASE_H,                                  \
+          CMDQV_VINTF_PAGE1_BASE + 0x4 + i * CMDQV_VCMDQ_STRIDE) \
+    FIELD(VI_VCMDQ##i##_BASE_H, ADDR, 0, 16)
+
+SMMU_CMDQV_VI_VCMDQi_BASE_H_(0)
+SMMU_CMDQV_VI_VCMDQi_BASE_H_(1)
+
+#define SMMU_CMDQV_VI_VCMDQi_CONS_INDX_BASE_DRAM_L_(i)           \
+    REG32(VI_VCMDQ##i##_CONS_INDX_BASE_DRAM_L,                   \
+          CMDQV_VINTF_PAGE1_BASE + 0x8 + i * CMDQV_VCMDQ_STRIDE) \
+    FIELD(VI_VCMDQ##i##_CONS_INDX_BASE_DRAM_L, ADDR, 0, 32)
+
+SMMU_CMDQV_VI_VCMDQi_CONS_INDX_BASE_DRAM_L_(0)
+SMMU_CMDQV_VI_VCMDQi_CONS_INDX_BASE_DRAM_L_(1)
+
+#define SMMU_CMDQV_VI_VCMDQi_CONS_INDX_BASE_DRAM_H_(i)           \
+    REG32(VI_VCMDQ##i##_CONS_INDX_BASE_DRAM_H,                   \
+          CMDQV_VINTF_PAGE1_BASE + 0xc + i * CMDQV_VCMDQ_STRIDE) \
+    FIELD(VI_VCMDQ##i##_CONS_INDX_BASE_DRAM_H, ADDR, 0, 16)
+
+SMMU_CMDQV_VI_VCMDQi_CONS_INDX_BASE_DRAM_H_(0)
+SMMU_CMDQV_VI_VCMDQi_CONS_INDX_BASE_DRAM_H_(1)
+
 const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void);
 
 #endif /* HW_ARM_TEGRA241_CMDQV_H */
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 813b9a61ce..f859126ad6 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -16,6 +16,75 @@
 #include "tegra241-cmdqv.h"
 #include "trace.h"
 
+/*
+ * Read a VCMDQ Page 0 register (control/status) using VCMDQ0_* offsets.
+ *
+ * The caller normalizes the MMIO offset such that @offset0 always refers
+ * to a VCMDQ0_* register, while @index selects the VCMDQ instance.
+ */
+static uint64_t tegra241_cmdqv_read_vcmdq_page0(Tegra241CMDQV *cmdqv,
+                                                hwaddr offset0, int index)
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
+    trace_tegra241_cmdqv_read_vcmdq_page0(index, offset0, val);
+    return val;
+}
+
+/*
+ * Read a VCMDQ Page 1 register (base / DRAM address) using VCMDQ0_* offsets.
+ */
+static uint64_t tegra241_cmdqv_read_vcmdq_page1(Tegra241CMDQV *cmdqv,
+                                                hwaddr offset0, int index)
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
+    trace_tegra241_cmdqv_read_vcmdq_page1(index, offset0, val);
+    return val;
+}
+
 static uint64_t tegra241_cmdqv_config_vintf_read(Tegra241CMDQV *cmdqv,
                                                  hwaddr offset)
 {
@@ -93,6 +162,7 @@ static uint64_t tegra241_cmdqv_read_mmio(void *opaque, hwaddr offset,
 {
     Tegra241CMDQV *cmdqv = (Tegra241CMDQV *)opaque;
     uint64_t val = 0;
+    int index;
 
     if (offset >= TEGRA241_CMDQV_IO_LEN) {
         qemu_log_mask(LOG_UNIMP,
@@ -126,6 +196,31 @@ static uint64_t tegra241_cmdqv_read_mmio(void *opaque, hwaddr offset,
     case A_VINTF0_CONFIG ... A_VINTF0_LVCMDQ_ERR_MAP_3:
         val = tegra241_cmdqv_config_vintf_read(cmdqv, offset);
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
+        return tegra241_cmdqv_read_vcmdq_page0(cmdqv,
+                offset - index * CMDQV_VCMDQ_STRIDE, index);
+    case A_VI_VCMDQ0_BASE_L ... A_VI_VCMDQ1_CONS_INDX_BASE_DRAM_H:
+        /* Same VINTF-to-VCMDQ translation as VINTF Page0 case above. */
+        offset -= CMDQV_VINTF_PAGE1_BASE - CMDQV_VCMDQ_PAGE1_BASE;
+        QEMU_FALLTHROUGH;
+    case A_VCMDQ0_BASE_L ... A_VCMDQ1_CONS_INDX_BASE_DRAM_H:
+        index = (offset - CMDQV_VCMDQ_PAGE1_BASE) / CMDQV_VCMDQ_STRIDE;
+        return tegra241_cmdqv_read_vcmdq_page1(cmdqv,
+                offset - index * CMDQV_VCMDQ_STRIDE, index);
     default:
         qemu_log_mask(LOG_UNIMP, "%s unhandled read access at 0x%" PRIx64 "\n",
                       __func__, offset);
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 8c61d66a26..8c34a04b24 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -75,6 +75,8 @@ smmuv3_accel_install_ste(uint32_t vsid, const char * type, uint32_t hwpt_id) "vS
 # tegra241-cmdqv
 tegra241_cmdqv_read_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
 tegra241_cmdqv_write_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
+tegra241_cmdqv_read_vcmdq_page0(int index, uint64_t offset0, uint64_t val) "vcmdq[%d] page0 offset0: 0x%"PRIx64" val: 0x%"PRIx64
+tegra241_cmdqv_read_vcmdq_page1(int index, uint64_t offset0, uint64_t val) "vcmdq[%d] page1 offset0: 0x%"PRIx64" val: 0x%"PRIx64
 
 # strongarm.c
 strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
-- 
2.43.0


