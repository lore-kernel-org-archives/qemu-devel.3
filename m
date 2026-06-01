Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A99CD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:52:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU197-0005bh-FA; Mon, 01 Jun 2026 07:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU193-0005RE-5w; Mon, 01 Jun 2026 07:49:25 -0400
Received: from mail-westusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c001::5] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU190-000534-Sz; Mon, 01 Jun 2026 07:49:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQkyRzErsNHyYcsL3Xm/MOZ8JQEM/X3NOZHYFwZMxbAqi8qq0PFDIlJn0n6iRyANSZUdkXaGCAhGhL39HKaZq5xC7rLmA2rwM8f1UXdGefUkx512udCyNfk5ki/7LkOvrNqbcC9z7UcuOpSmmj/OnlUgyODDQPA447J4xpoT+De4+SrembTVazqAGp+jpUNhS5/diIjXvNcVhp6mlSJ08XlzZb12upyoKJDfLpL3Z3cQisUVsw6OzGZAJT2QzlR0IEh4wRgV0rhZpdzR6yY4gjUBLK7z50BBl5FtFJKl6ffK+3STTAdnYgSV7fgxhE0tAs+rRQI1442xFp6RCXZEVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPOyfSJ269whMfFb/gUn/yWnW49zYQTG0yvwB0Jd8DQ=;
 b=UUVf3QvndQaHMl33ihY2aeieXZil7DByiXvKtWohZQ+eTddb16O0piiHjDpvKbsA2AJmxdZYVPbpMa5t4HLzBwHr1Ez6YtOGiPdcOaBuXRY6bFd1ft0kLEX4+C07cUqIYItzO30vqrPcrCZV+x5vVE5Zkw72Vp1Hp7S35N086qyTkh1bHZc6cla0A9ugWvPJP81Z93qLk7Yz9h7LGzP7q55WxxWNjESD6WS0+oBO/6STApoEq0tGhv6TFQuW6w/WhB5EESpaT55CHqxNaM/SLPUUnXP1YvLKbzx81i4jBn7bJIeyx2ghlndvlt1VSiX9n64meYWYMOJbgJ1haSr7uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPOyfSJ269whMfFb/gUn/yWnW49zYQTG0yvwB0Jd8DQ=;
 b=MHs0Fvqju249nAjgun5HCNh5nv4q3cLqKMd4BQNh5rZ5Pi+3wqo+/yTUhML7br/w22N6V4uunlQVGx8/g35VS6AIRXav7upRvhsI5+2Ne16BWJwDvtKOjllMaFzW00UdWmn50GSmvbJrX/F0kYYvXunp0EQzRjSM+d67kASXk0AWp88o9Fxa0F3ulxSXhxmpCgyYIgLn+EJjK+O5lHU6DRAT1D2u1xHIAxLyHTVJ6q49fS2xIaYdAu7wUydheVcBxgEcmqLAm4lryKj3LjAPBCu9m0TaJ0fwIUIU0NaFR71z7t8jg6V7IJsBnKFQWMENbQQ7kCBUx30haQtumiteYg==
Received: from MN2PR07CA0023.namprd07.prod.outlook.com (2603:10b6:208:1a0::33)
 by MW4PR12MB7143.namprd12.prod.outlook.com (2603:10b6:303:222::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 11:49:13 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:208:1a0:cafe::78) by MN2PR07CA0023.outlook.office365.com
 (2603:10b6:208:1a0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 11:49:12 +0000
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
 15.21.92.0 via Frontend Transport; Mon, 1 Jun 2026 11:49:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:48:59 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:48:55 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v6 14/31] hw/arm/tegra241-cmdqv: Emulate CMDQ-V Config region
Date: Mon, 1 Jun 2026 12:42:04 +0100
Message-ID: <20260601114221.457995-15-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|MW4PR12MB7143:EE_
X-MS-Office365-Filtering-Correlation-Id: b4898a3f-20f7-4e8d-9fa9-08debfd3cc66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|3023799007|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: QO4FBVF1bKoZcH7dyrxX18cGRcWGkuqi3Qp2cdSV07dFXguxQwfQO5EuF+UVcWajA3tG9+n1mDkyyGnnluKngr2q3EN7NJX8+v/r/vK7aCE03g/57o9qcIIj+ei58A7zq4BIR5E8/8odRxNgIBn3jtvas3KzjGortUHlDRtktcWjB+gCeMs8Cr9aUO8xWjIAJPguttmrULW42+ATgpQzR7xup6w4T+lVRrlU5x1Q0Sn9QOBxCUgIeDERJPxhBV8ii6jNkL6Wsy6iJoUiiLXNT9iLt2BCnhpOlKP2vi9M3p0V/L3LQeQG6WDM4ltDdsR8/gogQOb1rN8M6CeeVFPIZq8EFWl/wiAe/n6YvlzoWifAlHAXMjiiPbUykegyj9lzFXjB2ca7p2Thz8anGoNyn3TwUBU4zKP/m4bgMdPh3BulWmrcVydYS7EATjOyTmil/n5OmuiMalUrKVV0pf7YKro7KUMlQjTcwOD5h+TWvQoHJqxbJlSvhvxqnt0V2pwCljXLeQswJjNicPc63a0MHkzDAC6GB7OhONKH/QJH3j0ZilTIXyMG8CVdB2zaantnYA75ZYmYhzjrrAr0/MUdgZ8qnVEi3vgE6loYFd9iK9loXV+0KChHl+WE4u1NO91lheCX1MSMcaOM+iNyrTIOhqz8Chn3jOfP0mAj9Suxd6JTD8nzKXy3J+lCCWa/rdwXlM7QvZ2RKrdu5CjVxjUK4VvI++nI4XcupU55TrfecUg=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(3023799007)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wT0SxJRnjHtDr1AbIcsScl5pw/cfFyYz538kYXU3uOM6JQ9bogavMEXyNfTqrQrJHxpZvxadKajHHa1KwSi5TOpjc5IxDvPqSWOxbdqjLUq1uh4K1QYbwBGbzMeKMB4qqk8pbYilvVQjP+nXLGJqEOtZXOXJIRiqYyvj39YGR0JE7qhme5RUr3b5keFxkNRKgotLurIsBbqXVuxUX/grnw73lfZJ+hjA085ZJqhaVRyeJJcyO8A1SVlGcoQwvmrJbNWcWYOqeBeQNNUl3wTRQuGdZ0qkFPDXlNsUf84oA7+FZj/UdvpE/4mt0uImyGOdEdLfCGrfZ7xrnLrVlBHvD2+2uuuwNCou6nN9XGuk3M8MdP7gekd81ZjH7Hu7E7a0lO89IPHucxj0MLJx9Wzl9reXI+Z5M8fETlOch2S1r9Nnpcf84CM4cS5v5XVJg0Xn
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 11:49:11.9678 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4898a3f-20f7-4e8d-9fa9-08debfd3cc66
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7143
Received-SPF: permerror client-ip=2a01:111:f403:c001::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
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

Tegra241 CMDQV exposes control and status registers in the CMDQ-V
Config page (offset [0x0, 0x10000)) used to configure virtual command
queue allocation and interrupt behavior.

Add read/write emulation for the CMDQ-V Config region
([CMDQV_BASE, CMDQV_CMDQ_BASE]), backed by a simple register cache.
This includes CONFIG, PARAM, STATUS, VI error and interrupt maps, CMDQ
allocation map and the VINTF0 related registers defined in the CMDQ-V
Config space. Only VINTF0 is supported; VINTF1-63 are not.

Dispatch writes on access size: Introduced writel_mmio for 4-byte and
writell_mmio for 8-byte. Reads need no split as the MMIO framework masks
the returned value to the access size.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.h | 110 ++++++++++++++++++++++++
 hw/arm/tegra241-cmdqv.c | 181 +++++++++++++++++++++++++++++++++++++++-
 hw/arm/trace-events     |   4 +
 3 files changed, 294 insertions(+), 1 deletion(-)

diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index 9fc720e96c..8034b3b752 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -10,10 +10,15 @@
 #ifndef HW_ARM_TEGRA241_CMDQV_H
 #define HW_ARM_TEGRA241_CMDQV_H
 
+#include "hw/core/registerfields.h"
+
 #define CMDQV_VER                 1
 #define CMDQV_NUM_CMDQ_LOG2       1
 #define CMDQV_NUM_SID_PER_VI_LOG2 4
 
+#define TEGRA241_CMDQV_MAX_CMDQ      (1U << CMDQV_NUM_CMDQ_LOG2)
+#define TEGRA241_CMDQV_MAX_NUM_SID   (1U << CMDQV_NUM_SID_PER_VI_LOG2)
+
 /*
  * Tegra241 CMDQV MMIO layout (64KB pages)
  *
@@ -33,8 +38,113 @@ typedef struct Tegra241CMDQV {
     MemoryRegion mmio_cmdqv;
     qemu_irq irq;
     IOMMUFDVeventq *veventq;
+
+    /* CMDQ-V Config page register cache */
+    uint32_t config;
+    uint32_t param;
+    uint32_t status;
+    uint32_t vi_err_map[2];
+    uint32_t vi_int_mask[2];
+    uint32_t cmdq_err_map[4];
+    uint32_t cmdq_alloc_map[TEGRA241_CMDQV_MAX_CMDQ];
+
+    /* VINTF0 register cache (within CMDQ-V Config page) */
+    uint32_t vintf_config;
+    uint32_t vintf_status;
+    uint32_t vintf_sid_match[TEGRA241_CMDQV_MAX_NUM_SID];
+    uint32_t vintf_sid_replace[TEGRA241_CMDQV_MAX_NUM_SID];
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
+#define A_VI_INT_MASK_0 0x1c
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
+#define SMMU_CMDQV_CMDQ_ALLOC_MAP_(i)                       \
+    REG32(CMDQ_ALLOC_MAP_##i, 0x200 + i * 4)                \
+    FIELD(CMDQ_ALLOC_MAP_##i, ALLOC, 0, 1)                  \
+    FIELD(CMDQ_ALLOC_MAP_##i, LVCMDQ, 1, 7)                 \
+    FIELD(CMDQ_ALLOC_MAP_##i, VIRT_INTF_INDX, 15, 6)
+
+SMMU_CMDQV_CMDQ_ALLOC_MAP_(0)
+SMMU_CMDQV_CMDQ_ALLOC_MAP_(1)
+
+/* SMMU_CMDQV_VINTF0 registers (only VINTF0 is exposed to the guest) */
+REG32(VINTF0_CONFIG, 0x1000)
+FIELD(VINTF0_CONFIG, ENABLE, 0, 1)
+FIELD(VINTF0_CONFIG, VMID, 1, 16)
+FIELD(VINTF0_CONFIG, HYP_OWN, 17, 1)
+
+REG32(VINTF0_STATUS, 0x1004)
+FIELD(VINTF0_STATUS, ENABLE_OK, 0, 1)
+FIELD(VINTF0_STATUS, STATUS, 1, 3)
+FIELD(VINTF0_STATUS, VI_NUM_LVCMDQ, 16, 8)
+
+#define V_VINTF_STATUS_NO_ERROR    (0 << 1)
+#define V_VINTF_STATUS_VCMDQ_ERROR (1 << 1)
+
+/*
+ * SMMU_CMDQV_VINTF0_SID_MATCH/_REPLACE: 16 entries per VINTF
+ * (CMDQV_NUM_SID_PER_VI_LOG2=4). Only _0 and _15 are defined,
+ * used as switch case range bounds.
+ */
+REG32(VINTF0_SID_MATCH_0, 0x1040)
+FIELD(VINTF0_SID_MATCH_0, ENABLE, 0, 1)
+FIELD(VINTF0_SID_MATCH_0, VIRT_SID, 1, 20)
+#define A_VINTF0_SID_MATCH_15  (A_VINTF0_SID_MATCH_0 + 15 * 4)
+
+REG32(VINTF0_SID_REPLACE_0, 0x1080)
+FIELD(VINTF0_SID_REPLACE_0, PHYS_SID, 0, 20)
+#define A_VINTF0_SID_REPLACE_15 (A_VINTF0_SID_REPLACE_0 + 15 * 4)
+
+/*
+ * SMMU_CMDQV_VINTF0_LVCMDQ_ERR_MAP: 4 registers per VINTF covering 32 logical
+ * VCMDQs each. With TEGRA241_CMDQV_MAX_CMDQ=2, only MAP_0 bits [1:0] carry
+ * error state. MAP_1..MAP_3 always read as 0. Only _0 and _3 are defined,
+ * used as switch case range bounds.
+ */
+REG32(VINTF0_LVCMDQ_ERR_MAP_0, 0x10c0)
+FIELD(VINTF0_LVCMDQ_ERR_MAP_0, LVCMDQ_ERR_MAP, 0, 32)
+#define A_VINTF0_LVCMDQ_ERR_MAP_3 (A_VINTF0_LVCMDQ_ERR_MAP_0 + 3 * 4)
+
 const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void);
 
 #endif /* HW_ARM_TEGRA241_CMDQV_H */
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index c1351c8519..4e671bea9a 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -8,21 +8,200 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 
 #include "hw/arm/smmuv3.h"
 #include "hw/arm/smmuv3-common.h"
 #include "smmuv3-accel.h"
 #include "tegra241-cmdqv.h"
+#include "trace.h"
+
+static uint64_t tegra241_cmdqv_config_vintf_read(Tegra241CMDQV *cmdqv,
+                                                 hwaddr offset)
+{
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
 
 static uint64_t tegra241_cmdqv_read_mmio(void *opaque, hwaddr offset,
                                          unsigned size)
 {
-    return 0;
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
+    case A_VI_INT_MASK_0 ... A_VI_INT_MASK_1:
+        val = cmdqv->vi_int_mask[(offset - A_VI_INT_MASK_0) / 4];
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
+}
+
+/* 4-byte MMIO write handler. */
+static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
+                                       uint32_t value)
+{
+    switch (offset) {
+    case A_CONFIG:
+        cmdqv->config = value;
+        if (value & R_CONFIG_CMDQV_EN_MASK) {
+            cmdqv->status |= R_STATUS_CMDQV_ENABLED_MASK;
+        } else {
+            cmdqv->status &= ~R_STATUS_CMDQV_ENABLED_MASK;
+        }
+        break;
+    case A_VI_INT_MASK_0 ... A_VI_INT_MASK_1:
+        cmdqv->vi_int_mask[(offset - A_VI_INT_MASK_0) / 4] = value;
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
+}
+
+/*
+ * 8-byte MMIO write handler.
+ */
+static void tegra241_cmdqv_writell_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
+                                        uint64_t value)
+{
+    qemu_log_mask(LOG_UNIMP,
+                      "%s unhandled 64-bit write at 0x%" PRIx64 " (WI)\n",
+                      __func__, offset);
 }
 
 static void tegra241_cmdqv_write_mmio(void *opaque, hwaddr offset,
                                       uint64_t value, unsigned size)
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
+    switch (size) {
+    case 4:
+        tegra241_cmdqv_writel_mmio(cmdqv, offset, value);
+        break;
+    case 8:
+        tegra241_cmdqv_writell_mmio(cmdqv, offset, value);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s bad write size %u at 0x%" PRIx64 "\n",
+                      __func__, size, offset);
+    }
+
+out:
+    trace_tegra241_cmdqv_write_mmio(offset, value, size);
 }
 
 static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
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


