Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15DE6CD6E56
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU19F-0005vw-LF; Mon, 01 Jun 2026 07:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU19B-0005ql-St; Mon, 01 Jun 2026 07:49:33 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU199-00056E-BK; Mon, 01 Jun 2026 07:49:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=saaQLUjaab3TIaOQpBMqk+4GixWCkg6V0lf9mnX8iwhHdeuNqK4VUKonM07vep7ZxnGYiUOUFeovS8AqsROU9Ru2TEQgwyoNxYuk3xgJM77KXdPk16Gm1Yz32wBA4OsziTyhs27Ie9KwYTbTas8rd7ZVWFpaMT028/IAQhtL2ED7qQmpcPTLgvez0r+IMBi4XII6tOBwuUhQ8ekb6e3BjjZcmx3LSR35QjN6VpjCu7KlcSM4+G6yc0jleCLQrsm9sYy5DuWbxEHpb548Wo7nic0KJFGhYi+BvwltrY8doO/qRrzz2sy5t/8ZUAlccAP4F4k89K/62QqNSAyaQeim/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXuhJyTkGMIsuPpkmYVa4fAFuhjhBYiKdYkKByqXVuI=;
 b=M0V3euv8woYib064sftoyOlBaLEjVaSIh/bmxbWq66CNIWXxdJNv30yNvuJwsnw9OfcuOLPIcbQwZQ+I1nicd7rjDT53INb+q1e58+dUeqeAPx7u18ZGTaAhkigk2ESIyQJ2tUQkBi3CSN8i9W+qIGqL0OYY85Gmt5MMekfEvIgbaLzipO4kSOSYQ+idkiCxyE8SMAxrbxQlkj3aKgrkYIMRrMjNAQjwj7gEKb+Xja6c/uWfa2Hr4rLC8Gm0h2mSCbkX+6T3h8FmW4wyzSLEEDBUBWvjThR13bn0TX2PUjIN4f/hYDZuc3Dd4Ec8W2DVHs7dsv/mKnzF10M/xxV0bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXuhJyTkGMIsuPpkmYVa4fAFuhjhBYiKdYkKByqXVuI=;
 b=c646ulpcSCfyClZdpvHvIN035cpFhqv2YqBDkJXrPT8gJDZKzP8WkXrMnZemmM6J9hJrcRcl9bybrnio13E7NnWR8iXEmSpAZhUQ6hvS0m1MMBMvE8NE5YlOkiGhKmVmlI7fc6eyxQ340J8R6aTH8Qqak5aRuH0j82d7oaChJe/R1UosdlPMLHFv4QgPK3WIWs2GMnxhmZ4HF47DhL6DIz3M48lrORcB/TQeK3dqaXtv9dtrlo9IQsbk7PVnBoidpQWfdM1HDYr6m7BZwNgYsES3qTjVTb34hQcBmudMZBfWjfiq+Sweca8buJ5L+80f+MqgH/0toklID4tHETckuA==
Received: from MN0P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::15)
 by PH7PR12MB7209.namprd12.prod.outlook.com (2603:10b6:510:204::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Mon, 1 Jun 2026
 11:49:20 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:52e:cafe::2a) by MN0P220CA0004.outlook.office365.com
 (2603:10b6:208:52e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 11:49:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Mon, 1 Jun 2026 11:49:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:49:03 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:48:59 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v6 15/31] hw/arm/tegra241-cmdqv: Emulate VCMDQ register reads
Date: Mon, 1 Jun 2026 12:42:05 +0100
Message-ID: <20260601114221.457995-16-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|PH7PR12MB7209:EE_
X-MS-Office365-Filtering-Correlation-Id: 4665e4bc-9e1b-4b26-edf2-08debfd3d11e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|3023799007|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: i30hDddmMZtSNv52mvuoylIkQ6l8QT8AwbKqp1pUvHwVRocU8IUD12Gx09cPBL1fzWNBuPPc5cwzpI7W0S74g8SJFcTxz9kDxhd1zlwqKHcGxlHzHLHdq54jN0l71tZjJxZMkDgDkIKCYMJs5zLRGm2gLBg3gHEKJMX4cy2rP51J/fmVnA0+wzamweuqgosQ1tl0taMdnZn0SCPFp0PCOu/m3/D5wLi2QwEFnPeOFGlSC0GacpgWdtO+UlfsZT0o3Sz84IYbTvN0B1y0khz95t8w2gv2677RvuqQwEc0lHiml1luHG1DwUdKfsHdoApRUtqR9UMWjxPbIiKdNJecx73MfvS1Dsozh8YABP/iVycWFrzx2ja4J2U80QQnpUpbxs3fNdlaTlqLy7fuiXrMIfhz5fa8BtCYGexmaTPHbyodBjiKv9I84ZfvEHw3hGRn7MCYyY/d3mz/R14qTclBz2XNG0NG7Vr/kTJinHnNpUeb4VSc5UAmCF0n19tgT9R4qsRY1ad2Tm96QcM6D03bPwAfNToakNOst68fC/M6rAadIKIpgBcXsabjeGtN3pl7JPorq+ojU7Uito432ScBJ9xqo+4Ci5D60Pdchgpx2rNeXrxn1kqUPaKUAd83r7Vd6cgCXxa/YtPXiAXZtYAswGW+c75y2iAuf6tEhkePpnyhjGc0J0o2kCBI4ySTVp9jFgWBtGcKydKpcyyKTgNswAy6NLXUrBerygHGgsEZdK8=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(3023799007)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 92xy0Y4+Whe99SxSDakLVrrxcvMxdSa5wJy7EXThRkNE9C86MwbO9pnUdgGapfrDDtG0zqWOj/hWvPebiqSa+IfjFhH92bK63B+IGgUfxfNaphzM4+LcndrLhwz3efnlucuL1ZargjVmekbbinR145jX5voKztr4tNnOcrbS5GtEEcVDxJ+dMBtapdDPWIh74Y0DT3RTACI/6tw16rtO2bo4THnHsirII4yOwPRnFsk4seE4qUDKD8TSBp9I8+sytuJQ/p+Wq5b0Ce0zLC7wRFluKydggMdK0f/CbBFOVLXSMTgmLqStdwuD3ZLQP+KnEw+u9oANk2aB65ZFVAQBmIhQyGVrrPN6L/1hPLc/Ne8m+qD5YN0g9mbWh5kepwHr10b+rSv8jMo6HafmICKtIk71Nghb+07JuSpl2Du85ALhX4HAamIWN0GLNfIsk3MF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 11:49:19.8840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4665e4bc-9e1b-4b26-edf2-08debfd3d11e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7209
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
Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.h | 216 ++++++++++++++++++++++++++++++++++++++++
 hw/arm/tegra241-cmdqv.c | 103 +++++++++++++++++++
 hw/arm/trace-events     |   2 +
 3 files changed, 321 insertions(+)

diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index 8034b3b752..ad7fb8725f 100644
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
 struct iommu_viommu_tegra241_cmdqv;
 
 typedef struct Tegra241CMDQV {
@@ -54,6 +61,19 @@ typedef struct Tegra241CMDQV {
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
@@ -145,6 +165,202 @@ REG32(VINTF0_LVCMDQ_ERR_MAP_0, 0x10c0)
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
index 4e671bea9a..ff150fe0f3 100644
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
index 8c61d66a26..4392135fa2 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -75,6 +75,8 @@ smmuv3_accel_install_ste(uint32_t vsid, const char * type, uint32_t hwpt_id) "vS
 # tegra241-cmdqv
 tegra241_cmdqv_read_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
 tegra241_cmdqv_write_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
+tegra241_cmdqv_read_vcmdq_page0(int index, const char *aperture, uint64_t offset0, uint64_t val) "vcmdq[%d] %s page0 offset0: 0x%"PRIx64" val: 0x%"PRIx64
+tegra241_cmdqv_read_vcmdq_page1(int index, const char *aperture, uint64_t offset0, uint64_t val) "vcmdq[%d] %s page1 offset0: 0x%"PRIx64" val: 0x%"PRIx64
 
 # strongarm.c
 strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
-- 
2.43.0


