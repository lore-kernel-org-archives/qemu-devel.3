Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED37CD6E56
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU1AH-0008Bx-By; Mon, 01 Jun 2026 07:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU19d-00074A-Sk; Mon, 01 Jun 2026 07:50:04 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU19c-0005BF-3P; Mon, 01 Jun 2026 07:50:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mQAUjAfOTjJuyMtFlfrQQ4rQt/AHWlLAf/1FhhAXp0XJkMNbrzJp+UHvjeP7mmPQ/daewgJ+tVuL7Ofm/btg6I2+VxQ7fbC7udwKcW2cGe6u1VNeOuiDYagbTMIKf7DgLJ0pq7CAo5DqGr0gVxAcEAigNuMpCcRs4P/SylZ3EqYPnE3kMPE2xMCPfi4ddaHJCJDLCnXG05GuodwiXNgF3Ome5x+oexF85sgY9aLuS72em8YNk0Sfy+WOL+bo49XvNwqQIP+JavJXs933DdlfU0kzSo/DZCmNNciqDDWfh+NsaA09Vr0Xui5VzZijVzSQd40oneHfnltm3H9w2JLeXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gbmd3IGdyAHMHngTayIXhZvT6Q+abv3/FtEIUGegV/w=;
 b=e0iH7prPuwaDp0saEu0TOMmLD9P5Ssy9vxqog87OycV08RO4XZUtsHC8SK+B7y24e8DBaCpIi+vdH9uJz8zcNd3EPeQD+0QJxdNuYFE3T0CaZuvGaQ2H1Cfdgprfgok252TBxCwOzlum4m7PoscntkPFpyc8LFnntPqBKy8buN2L5nki/fKNQwO1tQGcIcKbjlakQhDkvdXUFCaM5nerRZSTRrT0YRyK63ZvX2TB26YNj28CGPHp+484zUWje2GCJAFPoWtF+pO8GhbmUriYI5FZVTReCUYXT9Lvj//zqprINeTxkQHKx6jsC6/7JP2VciArI4HMl8mWPaiS7Xddww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gbmd3IGdyAHMHngTayIXhZvT6Q+abv3/FtEIUGegV/w=;
 b=aQqJGCr2krQ4Hzc7EmZdr74nHX5wfs7RrUtn1SGJr6nroDwDCJ5sd7xAEF1BKi8Ubu45LAMTd3/O7gnmw4NQf/3mRIa20PpUW2UvF7lVQHwyujFpUCXHjmsUEeF0KjkOpV4VnZGBWh4KNU7EnLopgCGB1LK79tW5jlLw46dOxYBXduyMu4OzluCs+J+EbsGiM3LgDr5MGI7jMHwMMy+1YsPQZgv2QD0pcxYMCfA1B50xQlT6ubzYNG8np2Q24bF3byqOPgYk4I2uUfPq0m6g3wOnff17Niy0SLsV5EbLNVBJYT5ZzDtMa3qrVbPlaBQZI0MRyWaSG6netD6CQkZbsA==
Received: from MN2PR07CA0001.namprd07.prod.outlook.com (2603:10b6:208:1a0::11)
 by CH1PPF711010B62.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::614) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Mon, 1 Jun 2026
 11:49:51 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:208:1a0:cafe::6b) by MN2PR07CA0001.outlook.office365.com
 (2603:10b6:208:1a0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 11:49:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Mon, 1 Jun 2026 11:49:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:49:41 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:49:38 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v6 24/31] hw/arm/tegra241-cmdqv: Add reset handler
Date: Mon, 1 Jun 2026 12:42:14 +0100
Message-ID: <20260601114221.457995-25-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|CH1PPF711010B62:EE_
X-MS-Office365-Filtering-Correlation-Id: 868b11db-6109-4410-d52b-08debfd3e40b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: R71eGe6918IZ93NFnrqAFqyabMCyoNnwodNs3g7ZTpGP+J+1HfMSbvtyOxTYNEjhPIR8PhkbLw9nbGC3Nn5sMQoOgkkm8k+r0x/dqjOQwhfpmHGwh5lXsCmq4hcO/5npiIForMwt7DH1kRGZ1hsPEMytaSGxnvsCV5fMDMIJMhJ/ppwuDOQlh/W1rUf+netDwDSnUS4/r5ncEMe0N5uE0rXpk66BlNqxF3sJFUXolkaSVQhgOnx51Jv5NKnlAAek9NgrDt/3bVX9hHNzx681YsoLSWJdV4AKJim4btn1Sjbhsp+yjQ6aZUOzxPzrhexJzWu70VVETI86hNOcJct3qrDRJ1K/xQUS1FXRMOXfcSrfmNRwjsdcfWspumOdmbL7ahxqcXEdyKdUe19VIrAlwJS8P3+/Pyf7BZKbs9KVGibkEyKwTy26g5/prmk7ejPLBMpOomZuwfUxz9p9xukIag4MQ6VjedaS2tgqlkilnzWvG9zGaP9Umj/W83kAvfo9hsPbgRZe7CE6N5catAiLlfilo4P2X+VjjSRoNJ80UA3K+Y9lUFCUc6go+A4ZY6/MmA/bXQVj5H769LT680rPKLCvw6TRub6r1mkDcVWDWQk3BjVrLCFUcf3f6Jt/hLtrK4yH7YC49g/xLCBKvn6BxpA98F2hflXOX2pikEgIczl5Vs+nnMv054Ks1JcapkhvhmWkyeHSp54+DOxAxEknqrneECLwjSYyCF4kxwIfPuQ=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: swDvdL9C9xZGHYieRKCzVrSDYdfWopw4t0Audvg1qL3khRV71hgKt57y7qR7l/bnkfYvRc0z4LEAqYxyj/QtgjfPjh7sCL/ju6y00VV4c5wsuIA1zdHAHmPoOFSKLCsiLSrE3AW120WSqlozjzeUB26I7jbdmd9axSrMK/5VnmAtAR4sJ7JY390cQgL8LXw8WJbMcKFod9IFRShqda7NynaFk8JqbXk3+ThnGhuqGSNGLY7W9FOaBDPR1fJnStV8olsiXp/j/S7IiUpZzZ7/Q4pYlWiJbQbhDa/vcSa/wKWLBxtuffqk9FnHhwAUHGj+1EFo/kZ/HRAkXW87F8R8qngZ6fhf96iLVCiSADmVzK2WFGiVrFSYn34y/CiM2CjVLt67sweKMTuZM6wKuiXlGOIQNHIdX9IVynwGP4+STMGuQm5terSS90ziANyiEJ9w
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 11:49:51.6259 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 868b11db-6109-4410-d52b-08debfd3e40b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF711010B62
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

Introduce a reset handler for the Tegra241 CMDQV and initialize its
register state.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.h |  3 +++
 hw/arm/tegra241-cmdqv.c | 48 +++++++++++++++++++++++++++++++++++++++++
 hw/arm/trace-events     |  1 +
 3 files changed, 52 insertions(+)

diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index 01cd6af97d..de4c1e5335 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -89,6 +89,9 @@ FIELD(CONFIG, CMDQ_MAX_CLK_BATCH, 4, 8)
 FIELD(CONFIG, CMDQ_MAX_CMD_BATCH, 12, 8)
 FIELD(CONFIG, CONS_DRAM_EN, 20, 1)
 
+/* CMDQV_EN=1, PER_CMD_OFFSET=16B, CLK_BATCH=256, CMD_BATCH=32. */
+#define V_CONFIG_RESET 0x00020083
+
 REG32(PARAM, 0x4)
 FIELD(PARAM, CMDQV_VER, 0, 4)
 FIELD(PARAM, CMDQV_NUM_CMDQ_LOG2, 4, 4)
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index d8b36164a1..ac17b56c1c 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -871,8 +871,56 @@ free_viommu:
     return false;
 }
 
+static void tegra241_cmdqv_init_regs(SMMUv3State *s, Tegra241CMDQV *cmdqv)
+{
+    int i;
+
+    cmdqv->config = V_CONFIG_RESET;
+    cmdqv->param = FIELD_DP32(0, PARAM, CMDQV_VER, CMDQV_VER);
+    cmdqv->param = FIELD_DP32(cmdqv->param, PARAM, CMDQV_NUM_CMDQ_LOG2,
+                              CMDQV_NUM_CMDQ_LOG2);
+    cmdqv->param = FIELD_DP32(cmdqv->param, PARAM, CMDQV_NUM_SID_PER_VI_LOG2,
+                              CMDQV_NUM_SID_PER_VI_LOG2);
+    trace_tegra241_cmdqv_init_regs(cmdqv->param);
+    cmdqv->status = R_STATUS_CMDQV_ENABLED_MASK;
+
+    for (i = 0; i < 2; i++) {
+        cmdqv->vi_err_map[i] = 0;
+        cmdqv->vi_int_mask[i] = 0;
+    }
+    for (i = 0; i < 4; i++) {
+        cmdqv->cmdq_err_map[i] = 0;
+        cmdqv->vintf_cmdq_err_map[i] = 0;
+    }
+    cmdqv->vintf_config = 0;
+    cmdqv->vintf_status = 0;
+    for (i = 0; i < TEGRA241_CMDQV_MAX_CMDQ; i++) {
+        cmdqv->cmdq_alloc_map[i] = 0;
+        cmdqv->vcmdq_cons_indx[i] = 0;
+        cmdqv->vcmdq_prod_indx[i] = 0;
+        cmdqv->vcmdq_config[i] = 0;
+        cmdqv->vcmdq_status[i] = 0;
+        cmdqv->vcmdq_gerror[i] = 0;
+        cmdqv->vcmdq_gerrorn[i] = 0;
+        cmdqv->vcmdq_base[i] = 0;
+        cmdqv->vcmdq_cons_indx_base[i] = 0;
+    }
+}
+
 static void tegra241_cmdqv_reset(SMMUv3State *s)
 {
+    SMMUv3AccelState *accel = s->s_accel;
+    Tegra241CMDQV *cmdqv = accel->cmdqv;
+
+    if (!cmdqv) {
+        return;
+    }
+
+    tegra241_cmdqv_guest_unmap_vintf_page0(cmdqv);
+    tegra241_cmdqv_munmap_vintf_page0(cmdqv, NULL);
+    tegra241_cmdqv_free_all_vcmdq(cmdqv);
+
+    tegra241_cmdqv_init_regs(s, cmdqv);
 }
 
 static const MemoryRegionOps mmio_cmdqv_ops = {
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 115f1add9d..e655b2e26e 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -76,6 +76,7 @@ smmuv3_accel_install_ste(uint32_t vsid, const char * type, uint32_t hwpt_id) "vS
 tegra241_cmdqv_read_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
 tegra241_cmdqv_write_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
 tegra241_cmdqv_err_map(uint32_t map3, uint32_t map2, uint32_t map1, uint32_t map0) "hw irq received. error (hex) maps: %04X:%04X:%04X:%04X"
+tegra241_cmdqv_init_regs(uint32_t param) "register init, param=0x%08X"
 tegra241_cmdqv_read_vcmdq_page0(int index, const char *aperture, uint64_t offset0, uint64_t val) "vcmdq[%d] %s page0 offset0: 0x%"PRIx64" val: 0x%"PRIx64
 tegra241_cmdqv_read_vcmdq_page1(int index, const char *aperture, uint64_t offset0, uint64_t val) "vcmdq[%d] %s page1 offset0: 0x%"PRIx64" val: 0x%"PRIx64
 tegra241_cmdqv_write_vcmdq_page0(int index, const char *aperture, uint64_t offset0, uint64_t val) "vcmdq[%d] %s page0 offset0: 0x%"PRIx64" val: 0x%"PRIx64
-- 
2.43.0


