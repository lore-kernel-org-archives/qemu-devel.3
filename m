Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0909F4198B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 10:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCxwT-00018l-78; Wed, 15 Apr 2026 06:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxwO-0000vw-A0; Wed, 15 Apr 2026 06:57:52 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxwM-00044k-2H; Wed, 15 Apr 2026 06:57:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WCaVwB9tdYInuih3sNx4lnqtjkPM8fvL+qcUzZcDFbV8FjYE0Gxlh1kWJ2gxKo5zbw6iJkDimuQB3kD/PtPwm251DHycpsKg4qI0FwTID+L+MyNIWuLwOX0UubOSi8RnC3k3r7JdSK4O8MSHYDyp6dQNk3RQ6Um14dRjsd3WxE1kkSzSQCGXFhK69+OibjDL0OXs8ifRyN1EeJ+kBSVxVgwYNi5scDsM4QU66PQSfEAgWZwlISXYje2z96fhQKW11WFVGDU+dneGFY60yeBodx18UdVAqBOdBwnfRrIuGi75+LkDyTe49WIJpk5o300O5ERVzscU6QhRl5yMkqDRlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ei4Dtp2hLGne23Dt/xEp92hCwBw/IdjRCOBESiJ9+0k=;
 b=EeMksL94VPtTupGSc9vwUoR83H7BT3IvU4HoWghVoVHKLXJ29Tq7Kp7j8kIG+pb4IC1j8C9UVHAZ9pwyX+JP/OXxLDnr1Ygd3876HKvwDyQmk+DBab9xdZc/a43PmC8nF5NET8QuFEgHfviTC5tUlpyu1JZ0+Ngn+KUp8yre1m5bFUTsKrJhNpu8TNo4PLmEWJBVScsBSecOu2gm8yJD8n4KPNSDMi7ulJUs7altjUkJV5kWhTEH5dOFDwLqYgv2iqYt9GYb7Xn2LfV/nbq3jq6xaFktNyf6yEJAzLAq2JRWrBD5f4gdTNuw+nvN2fVyb3jbA4fUVHWcWab3JDOswA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ei4Dtp2hLGne23Dt/xEp92hCwBw/IdjRCOBESiJ9+0k=;
 b=Fj8EnWrV6hEb/E7TvMiEY/T7bzTz8Ljcsd5Lg6ZGyUA0jzgL1KpJZTFo4IuNNWNFXTfggn13U/JDoYfeEQd+f6roVZJUKE0EBczVOrJqwKwOQcu6rPltRbZzxlnrI7mF0QbYPk5ku3qRUUioBeRtRgzg/DEGGlFdJKNNmnVsdzsTqzRytLwv6R3tKG90RRX5q8x2Cmtiob3PnePDOZk2BDF8ipWaY4gFXqM8ZduP+kN1yKzsTLH8FW8/JvQv4hUeD/xouN8W21gL5Q31+jXkFkGMQvpNIrFaVVIg5Mn4ZWtRV4P5XY/DF3FkC4RSLON6r7fFt04dRtRrcPuEev7eBw==
Received: from DM6PR04CA0010.namprd04.prod.outlook.com (2603:10b6:5:334::15)
 by IA1PR12MB7493.namprd12.prod.outlook.com (2603:10b6:208:41b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 10:57:39 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:5:334:cafe::fd) by DM6PR04CA0010.outlook.office365.com
 (2603:10b6:5:334::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Wed,
 15 Apr 2026 10:57:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 10:57:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:57:25 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:57:21 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v4 14/31] hw/arm/tegra241-cmdqv: Emulate CMDQ-V Config region
Date: Wed, 15 Apr 2026 11:55:35 +0100
Message-ID: <20260415105552.622421-15-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|IA1PR12MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: 71cb1a45-543a-472e-1a31-08de9addcf5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: w+on5BLn0gXC+J2tfxKW3jvJ87rHskEIs1DQeJVj0PhmCUMybpsoa1mcW7mtqagqEa5Wlvsv4itmrBNGOo4YxUol3jY11ItWRLxds4zNNydokSG82GKvq/+oDWwnurajaIzVmvcsUGizq1tk+IHQUTH8T/uvsS1YTrmRKsJJbcb4JMuT/sfrF1Pt5H8mxWq1ShzAcSGzohj/LE+rbyhP79BWBGI6ZgAwHz6f26zRSRUa/99tKF0kxWkjeQHcSsT42HCuPd+emsQjlualXa4edk3sYI1ZJJ87E3Bg6YRG45VA+T27JFOkLYCGZR7Eg4qnT2qARDgHr5yUZZQNRgDjBj5inPYB4S0AFUiD1Vs5hAHu9gu8QLPTRJ3jqgaiNeD4MTkIk2Jf5kLIluARaMcf12dZsBiuojfjKHCNrX9RhjjSERkH2M62UbP3Jhj26VZxVI2bvwVWH7xXuutp8dy1jshbphZT+8f5acMYU9loxV7xClD0HUOHmY1fM7nnkYROs4miaEMjixPt4pZDZNlVkIjHhZq8IGlrVgDKgG8D3TuIPgrq7VGlpcPKTV9oXccmZBUykKBZomXogrujTthP59t5poCQ+zKoUZ9KJljoTo42uTCNOgYvte1yh7HyAH87EbkM+q2XKPYCzW/xaFbvBU7fIdeQSjvCktyI7g2IgWSxa5soEjJINDE3G9rqM63ssrnz1SGgG/jBVpydemjkxrolIIG+bLMgdhl9oMXQOLg1KjblKwT2DvOoWULG9SZn2k0d5uZ+UK4eLr2mEJmq0Q==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SRrVXHtuL3JrdKoVgF4dbyqYECV9hwko0TLqthoTcK6BAP2boulHXSyQhQBnTEGzxnQSXvORMT5rcbZYakIPs8O4KGzHZOavgrfANcG1usGkepLutO9baP6sOTovTbc2Y+v2oMAeodA5w7rGMI6wNfgvslGZMBPJUis/4H/izNgq+MSbPm5DIWrKH3nUDW8NqJlKiudjPIetARaINlzaaanpfYEwOg0Ncc+cVJHZ3WVHJhru5NM6yERLXs16ZejiHDdiAOJOC1989tzrDb4ldYACm1apJx2MYw7Y7mDtrwKcSa5VOS9JtvXg/AzMMhDUAHNoKLmRTgjatrrYkWEcPVcO5U7lnJLP7LoYo5Bg31t8q9ymVwLPESoMcSt2itVc7G71AgiFFTrbnxlTw2UHufpiqnaVX169AvpSA0WNi7QFRfQ2nSwCv+RzD5+dvEbl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 10:57:38.9866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71cb1a45-543a-472e-1a31-08de9addcf5e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7493
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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

Tegra241 CMDQV exposes control and status registers in the CMDQ-V
Config page (offset [0x0, 0x10000)) used to configure virtual command
queue allocation and interrupt behavior.

Add read/write emulation for the CMDQ-V Config region
([CMDQV_BASE, CMDQV_CMDQ_BASE]), backed by a simple register cache.
This includes CONFIG, PARAM, STATUS, VI error and interrupt maps, CMDQ
allocation map and the VINTF0 related registers defined in the CMDQ-V
Config space. Only VINTF0 is supported; VINTF1-63 are not.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.h | 127 +++++++++++++++++++++++++++++++
 hw/arm/tegra241-cmdqv.c | 163 ++++++++++++++++++++++++++++++++++++++--
 hw/arm/trace-events     |   4 +
 3 files changed, 288 insertions(+), 6 deletions(-)

diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index fa0aa3ab04..965670066d 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -10,10 +10,14 @@
 #ifndef HW_ARM_TEGRA241_CMDQV_H
 #define HW_ARM_TEGRA241_CMDQV_H
 
+#include "hw/core/registerfields.h"
+
 #define CMDQV_VER                 1
 #define CMDQV_NUM_CMDQ_LOG2       1
 #define CMDQV_NUM_SID_PER_VI_LOG2 4
 
+#define TEGRA241_CMDQV_MAX_CMDQ   (1U << CMDQV_NUM_CMDQ_LOG2)
+
 /*
  * Tegra241 CMDQV MMIO layout (64KB pages)
  *
@@ -31,8 +35,131 @@ typedef struct Tegra241CMDQV {
     MemoryRegion mmio_cmdqv;
     qemu_irq irq;
     IOMMUFDVeventq *veventq;
+
+    /* Register Cache */
+    uint32_t config;
+    uint32_t param;
+    uint32_t status;
+    uint32_t vi_err_map[2];
+    uint32_t vi_int_mask[2];
+    uint32_t cmdq_err_map[4];
+    uint32_t cmdq_alloc_map[TEGRA241_CMDQV_MAX_CMDQ];
+    uint32_t vintf_config;
+    uint32_t vintf_status;
+    uint32_t vintf_sid_match[16];
+    uint32_t vintf_sid_replace[16];
+    uint32_t vintf_cmdq_err_map[4];
 } Tegra241CMDQV;
 
+/* CMDQ-V Config page registers (offset 0x00000) */
+REG32(CONFIG, 0x0)
+FIELD(CONFIG, CMDQV_EN, 0, 1)
+FIELD(CONFIG, CMDQV_PER_CMD_OFFSET, 1, 3)
+FIELD(CONFIG, CMDQ_MAX_CLK_BATCH, 4, 8)
+FIELD(CONFIG, CMDQ_MAX_CMD_BATCH, 12, 8)
+FIELD(CONFIG, CONS_DRAM_EN, 20, 1)
+
+REG32(PARAM, 0x4)
+FIELD(PARAM, CMDQV_VER, 0, 4)
+FIELD(PARAM, CMDQV_NUM_CMDQ_LOG2, 4, 4)
+FIELD(PARAM, CMDQV_NUM_VI_LOG2, 8, 4)
+FIELD(PARAM, CMDQV_NUM_SID_PER_VI_LOG2, 12, 4)
+
+REG32(STATUS, 0x8)
+FIELD(STATUS, CMDQV_ENABLED, 0, 1)
+
+/* SMMU_CMDQV_VI_ERR_MAP_0/1 definitions */
+#define A_VI_ERR_MAP_0 0x14
+#define A_VI_ERR_MAP_1 0x18
+#define V_VI_ERR_MAP_NO_ERROR (0)
+#define V_VI_ERR_MAP_ERROR (1)
+
+/* SMMU_CMDQV_VI_INT_MASK_0/1 definitions */
+#define A_VI_INT_MASK 0x1c
+#define A_VI_INT_MASK_1 0x20
+#define V_VI_INT_MASK_NOT_MASKED (0)
+#define V_VI_INT_MASK_MASKED (1)
+
+/* SMMU_CMDQV_CMDQ_ERR_MAP_0-3 definitions */
+#define A_CMDQ_ERR_MAP_0 0x24
+#define A_CMDQ_ERR_MAP_1 0x28
+#define A_CMDQ_ERR_MAP_2 0x2c
+#define A_CMDQ_ERR_MAP_3 0x30
+
+/*
+ * CMDQ_ALLOC_MAP: one entry per physical VCMDQ. Hardware supports up to 128
+ * entries (CMDQV_NUM_CMDQ_LOG2=7), but QEMU only exposes
+ * TEGRA241_CMDQV_MAX_CMDQ (=2) VCMDQs per VM so only entries 0 and 1 are
+ * defined here.
+ */
+/* 2 identical register entries */
+#define SMMU_CMDQV_CMDQ_ALLOC_MAP_(i)        \
+    REG32(CMDQ_ALLOC_MAP_##i, 0x200 + i * 4) \
+    FIELD(CMDQ_ALLOC_MAP_##i, ALLOC, 0, 1)   \
+    FIELD(CMDQ_ALLOC_MAP_##i, LVCMDQ, 1, 7)  \
+    FIELD(CMDQ_ALLOC_MAP_##i, VIRT_INTF_INDX, 15, 6)
+
+SMMU_CMDQV_CMDQ_ALLOC_MAP_(0)
+SMMU_CMDQV_CMDQ_ALLOC_MAP_(1)
+
+
+/* Only VINTF0 is exposed to the guest; vintf = 0 */
+#define SMMU_CMDQV_VINTFi_CONFIG_(vi)                 \
+    REG32(VINTF##vi##_CONFIG, 0x1000 + vi * 0x100) \
+    FIELD(VINTF##vi##_CONFIG, ENABLE, 0, 1)       \
+    FIELD(VINTF##vi##_CONFIG, VMID, 1, 16)        \
+    FIELD(VINTF##vi##_CONFIG, HYP_OWN, 17, 1)
+
+SMMU_CMDQV_VINTFi_CONFIG_(0)
+
+#define SMMU_CMDQV_VINTFi_STATUS_(vi)                 \
+    REG32(VINTF##vi##_STATUS, 0x1004 + vi * 0x100) \
+    FIELD(VINTF##vi##_STATUS, ENABLE_OK, 0, 1)    \
+    FIELD(VINTF##vi##_STATUS, STATUS, 1, 3)       \
+    FIELD(VINTF##vi##_STATUS, VI_NUM_LVCMDQ, 16, 8)
+
+SMMU_CMDQV_VINTFi_STATUS_(0)
+
+#define V_VINTF_STATUS_NO_ERROR (0 << 1)
+#define V_VINTF_STATUS_VCMDQ_ERROR (1 << 1)
+
+/*
+ * SID_MATCH/SID_REPLACE: 16 entries per VINTF (CMDQV_NUM_SID_PER_VI_LOG2=4).
+ * vintf = 0, 16 identical register entries
+ */
+#define SMMU_CMDQV_VINTFi_SID_MATCH_(vi, j)                          \
+    REG32(VINTF##vi##_SID_MATCH_##j, 0x1040 + j * 4 + vi * 0x100) \
+    FIELD(VINTF##vi##_SID_MATCH_##j, ENABLE, 0, 1)               \
+    FIELD(VINTF##vi##_SID_MATCH_##j, VIRT_SID, 1, 20)
+
+SMMU_CMDQV_VINTFi_SID_MATCH_(0, 0)
+/* Omitting [0][1~14] as not being directly called */
+SMMU_CMDQV_VINTFi_SID_MATCH_(0, 15)
+
+/* vintf = 0, 16 identical register entries */
+#define SMMU_CMDQV_VINTFi_SID_REPLACE_(vi, j)                          \
+    REG32(VINTF##vi##_SID_REPLACE_##j, 0x1080 + j * 4 + vi * 0x100) \
+    FIELD(VINTF##vi##_SID_REPLACE_##j, PHYS_SID, 0, 20)
+
+SMMU_CMDQV_VINTFi_SID_REPLACE_(0, 0)
+/* Omitting [0][1~14] as not being directly called */
+SMMU_CMDQV_VINTFi_SID_REPLACE_(0, 15)
+
+/*
+ * LVCMDQ_ERR_MAP: hardware defines 4 registers per VINTF (offset
+ * 0x10c0..0x10cc), each covering 32 logical VCMDQs. All 4 are accessible
+ * by the guest. With TEGRA241_CMDQV_MAX_CMDQ=2 only MAP_0 bits [1:0]
+ * carry meaningful error state; MAP_1..MAP_3 always read as 0.
+ * vintf = 0, 4 identical register entries
+ */
+#define SMMU_CMDQV_VINTFi_LVCMDQ_ERR_MAP_(vi, j)                          \
+    REG32(VINTF##vi##_LVCMDQ_ERR_MAP_##j, 0x10c0 + j * 4 + vi * 0x100) \
+    FIELD(VINTF##vi##_LVCMDQ_ERR_MAP_##j, LVCMDQ_ERR_MAP, 0, 32)
+
+SMMU_CMDQV_VINTFi_LVCMDQ_ERR_MAP_(0, 0)
+/* MAP_1 and MAP_2 omitted; not referenced directly */
+SMMU_CMDQV_VINTFi_LVCMDQ_ERR_MAP_(0, 3)
+
 const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void);
 
 #endif /* HW_ARM_TEGRA241_CMDQV_H */
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 2f1084b55f..3b08ed0ff3 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -8,19 +8,170 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 
 #include "hw/arm/smmuv3.h"
 #include "smmuv3-accel.h"
 #include "tegra241-cmdqv.h"
+#include "trace.h"
 
-static uint64_t tegra241_cmdqv_read(void *opaque, hwaddr offset, unsigned size)
+static uint64_t tegra241_cmdqv_config_vintf_read(Tegra241CMDQV *cmdqv,
+                                                 hwaddr offset)
 {
-    return 0;
+    int i;
+
+    switch (offset) {
+    case A_VINTF0_CONFIG:
+        return cmdqv->vintf_config;
+    case A_VINTF0_STATUS:
+        return cmdqv->vintf_status;
+    case A_VINTF0_SID_MATCH_0 ... A_VINTF0_SID_MATCH_15:
+        i = (offset - A_VINTF0_SID_MATCH_0) / 4;
+        return cmdqv->vintf_sid_match[i];
+    case A_VINTF0_SID_REPLACE_0 ... A_VINTF0_SID_REPLACE_15:
+        i = (offset - A_VINTF0_SID_REPLACE_0) / 4;
+        return cmdqv->vintf_sid_replace[i];
+    case A_VINTF0_LVCMDQ_ERR_MAP_0 ... A_VINTF0_LVCMDQ_ERR_MAP_3:
+        i = (offset - A_VINTF0_LVCMDQ_ERR_MAP_0) / 4;
+        return cmdqv->vintf_cmdq_err_map[i];
+    default:
+        /*
+         * GLB_FILT_CFG_0 (offset 0xC) and GLB_FILT_DATA_0 (offset 0x10) are
+         * filter config and filter data registers. They are not required for
+         * normal VINTF operation and are not emulated.
+         */
+        qemu_log_mask(LOG_UNIMP, "%s unhandled read access at 0x%" PRIx64 "\n",
+                      __func__, offset);
+        return 0;
+    }
+}
+
+static void tegra241_cmdqv_config_vintf_write(Tegra241CMDQV *cmdqv,
+                                              hwaddr offset, uint64_t value)
+{
+    int i;
+
+    switch (offset) {
+    case A_VINTF0_CONFIG:
+        /*
+         * Mask out HYP_OWN on guest writes. This bit selects Hypervisor (1) vs
+         * Guest (0) ownership of the CMDQ. Force it to 0 so the VINTF always
+         * remains guest-owned.
+         */
+        value &= ~R_VINTF0_CONFIG_HYP_OWN_MASK;
+
+        cmdqv->vintf_config = value;
+        if (value & R_VINTF0_CONFIG_ENABLE_MASK) {
+            cmdqv->vintf_status |= R_VINTF0_STATUS_ENABLE_OK_MASK;
+        } else {
+            cmdqv->vintf_status &= ~R_VINTF0_STATUS_ENABLE_OK_MASK;
+        }
+        break;
+    case A_VINTF0_SID_MATCH_0 ... A_VINTF0_SID_MATCH_15:
+        i = (offset - A_VINTF0_SID_MATCH_0) / 4;
+        cmdqv->vintf_sid_match[i] = value;
+        break;
+    case A_VINTF0_SID_REPLACE_0 ... A_VINTF0_SID_REPLACE_15:
+        i = (offset - A_VINTF0_SID_REPLACE_0) / 4;
+        cmdqv->vintf_sid_replace[i] = value;
+        break;
+    default:
+        /*
+         * GLB_FILT_CFG_0 (offset 0xC) and GLB_FILT_DATA_0 (offset 0x10) are
+         * filter config and filter data registers. They are not required for
+         * normal VINTF operation and are not emulated.
+         */
+        qemu_log_mask(LOG_UNIMP, "%s unhandled write access at 0x%" PRIx64 "\n",
+                      __func__, offset);
+        return;
+    }
+}
+
+static uint64_t tegra241_cmdqv_read_mmio(void *opaque, hwaddr offset,
+                                         unsigned size)
+{
+    Tegra241CMDQV *cmdqv = (Tegra241CMDQV *)opaque;
+    uint64_t val = 0;
+
+    if (offset >= TEGRA241_CMDQV_IO_LEN) {
+        qemu_log_mask(LOG_UNIMP,
+                      "%s offset 0x%" PRIx64 " off limit (0x%x)\n", __func__,
+                      offset, TEGRA241_CMDQV_IO_LEN);
+        goto out;
+    }
+
+    switch (offset) {
+    case A_CONFIG:
+        val = cmdqv->config;
+        break;
+    case A_PARAM:
+        val = cmdqv->param;
+        break;
+    case A_STATUS:
+        val = cmdqv->status;
+        break;
+    case A_VI_ERR_MAP_0 ... A_VI_ERR_MAP_1:
+        val = cmdqv->vi_err_map[(offset - A_VI_ERR_MAP_0) / 4];
+        break;
+    case A_VI_INT_MASK ... A_VI_INT_MASK_1:
+        val = cmdqv->vi_int_mask[(offset - A_VI_INT_MASK) / 4];
+        break;
+    case A_CMDQ_ERR_MAP_0 ... A_CMDQ_ERR_MAP_3:
+        val = cmdqv->cmdq_err_map[(offset - A_CMDQ_ERR_MAP_0) / 4];
+        break;
+    case A_CMDQ_ALLOC_MAP_0 ... A_CMDQ_ALLOC_MAP_1:
+        val = cmdqv->cmdq_alloc_map[(offset - A_CMDQ_ALLOC_MAP_0) / 4];
+        break;
+    case A_VINTF0_CONFIG ... A_VINTF0_LVCMDQ_ERR_MAP_3:
+        val = tegra241_cmdqv_config_vintf_read(cmdqv, offset);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s unhandled read access at 0x%" PRIx64 "\n",
+                      __func__, offset);
+    }
+
+out:
+    trace_tegra241_cmdqv_read_mmio(offset, val, size);
+    return val;
 }
 
-static void tegra241_cmdqv_write(void *opaque, hwaddr offset, uint64_t value,
-                                 unsigned size)
+static void tegra241_cmdqv_write_mmio(void *opaque, hwaddr offset,
+                                      uint64_t value, unsigned size)
 {
+    Tegra241CMDQV *cmdqv = (Tegra241CMDQV *)opaque;
+
+    if (offset >= TEGRA241_CMDQV_IO_LEN) {
+        qemu_log_mask(LOG_UNIMP,
+                      "%s offset 0x%" PRIx64 " off limit (0x%x)\n", __func__,
+                      offset, TEGRA241_CMDQV_IO_LEN);
+        goto out;
+    }
+
+    switch (offset) {
+    case A_CONFIG:
+        cmdqv->config = value;
+        if (value & R_CONFIG_CMDQV_EN_MASK) {
+            cmdqv->status |= R_STATUS_CMDQV_ENABLED_MASK;
+        } else {
+            cmdqv->status &= ~R_STATUS_CMDQV_ENABLED_MASK;
+        }
+        break;
+    case A_VI_INT_MASK ... A_VI_INT_MASK_1:
+        cmdqv->vi_int_mask[(offset - A_VI_INT_MASK) / 4] = value;
+        break;
+    case A_CMDQ_ALLOC_MAP_0 ... A_CMDQ_ALLOC_MAP_1:
+        cmdqv->cmdq_alloc_map[(offset - A_CMDQ_ALLOC_MAP_0) / 4] = value;
+        break;
+    case A_VINTF0_CONFIG ... A_VINTF0_LVCMDQ_ERR_MAP_3:
+        tegra241_cmdqv_config_vintf_write(cmdqv, offset, value);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s unhandled write access at 0x%" PRIx64 "\n",
+                      __func__, offset);
+    }
+
+out:
+    trace_tegra241_cmdqv_write_mmio(offset, value, size);
 }
 
 static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
@@ -84,8 +235,8 @@ static void tegra241_cmdqv_reset(SMMUv3State *s)
 }
 
 static const MemoryRegionOps mmio_cmdqv_ops = {
-    .read = tegra241_cmdqv_read,
-    .write = tegra241_cmdqv_write,
+    .read = tegra241_cmdqv_read_mmio,
+    .write = tegra241_cmdqv_write_mmio,
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 3457536fb0..8c61d66a26 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -72,6 +72,10 @@ smmuv3_accel_unset_iommu_device(int devfn, uint32_t devid) "devfn=0x%x (idev dev
 smmuv3_accel_translate_ste(uint32_t vsid, uint32_t hwpt_id, uint64_t ste_1, uint64_t ste_0) "vSID=0x%x hwpt_id=0x%x ste=%"PRIx64":%"PRIx64
 smmuv3_accel_install_ste(uint32_t vsid, const char * type, uint32_t hwpt_id) "vSID=0x%x ste type=%s hwpt_id=0x%x"
 
+# tegra241-cmdqv
+tegra241_cmdqv_read_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
+tegra241_cmdqv_write_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
+
 # strongarm.c
 strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
 strongarm_ssp_read_underrun(void) "SSP rx underrun"
-- 
2.43.0


