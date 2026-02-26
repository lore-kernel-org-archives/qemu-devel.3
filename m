Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68119FC592B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvYzF-0004uh-UM; Thu, 26 Feb 2026 05:52:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYzA-0004l2-Ft; Thu, 26 Feb 2026 05:52:49 -0500
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYz8-0000ox-JX; Thu, 26 Feb 2026 05:52:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mot8ob2jXidJuiEmN4d0itZ57EDxePkUmZBOZXcGXrI/MYLit/SpV+iYs4R+tWZKLYWgmWIm+459vdX+/E5otPxpsFOMTExT96Ehi/fNZ9qxpGOXDSQqfRW4U35MZcZi/EgUfdIUS+6CFYNl5so/GA8ZiqCLLduTca9/QzTKvYqznuy4YE1nj63xhEeY6CyS/tKLX1jaoSSHArwMWwD1WAgJy+tY1PYXlmLmjXjsBHcqbRcHAOLJZkNjWulennXgCJsNpxwZmdvB2MkEMaS1X2+x6+izzJm6RpNavSyimaeBpPSGjLuVkgsuvLJurOlVG664+VbksRc+M9zCJebKvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7MJr8hE+NiZ1YM2RJVGGjq93xk7eb2xNmJkBASVDMg=;
 b=aUPnHadPCdaj3gGZS0kGLYjVZrKoj12UsO5xEEku6Z/ZjHIk6IsKQ00WODJ9NHaLopHjXejq9cwZ3QgW+D9euch9gzcKL/RBXChj6v3MxKsCxTeO6gwkT+yMPKYM/Q+Ca6Wp4mnWu4nMij/HoUQC+Ed41YGPxsRTLYOT0/+upSXss8BJxcOIP3hpibK6f29oZKrKIOS9NcjqH4hYF3UW9ezFZLpFq3WYfSDpdqUj8mFCpKkdr++/g7CXiZ6HwUbs9aeO1m+D003agYumRij7hRo8JJHN42ASz+Bq+CKpJlZ01LdfgFrPN62pkVQf3MEMegEhuQPOrOWV0DEBYvZJFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7MJr8hE+NiZ1YM2RJVGGjq93xk7eb2xNmJkBASVDMg=;
 b=hUsDXi+EL8lvPCJYrI6YWozHDK++3OncfmrQRXxkgqBzIBf5nE/UHfpnsum99Xg639EqyWYWlt62n3RPdi3y7yfjdKLOr9fYmYNp2ecw0sMek6Ikp86OMX9IV6U4UhkJ+Am4YQRDnOyxpwhQuH0H6rJ/EdgFdEKum7KF9yTzb8KWaUXv0T2j48c2v+VlzTbVzlPbncXZyxp4Zim86ed7CeG9RZm8eNrf8YDN6B3NLvLtxCo8AH2Qrw7snVKrjkOnEuCX9nS1nEYaQoJIsCAWSw9d0/Sl4TyCD5zHPhcDK0lTfXG1ewoY920cY00O2gOFquhTZvA6f8InNmWE4jKdrg==
Received: from SA1P222CA0122.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::17)
 by MW3PR12MB4427.namprd12.prod.outlook.com (2603:10b6:303:52::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 26 Feb
 2026 10:52:40 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:806:3c5:cafe::ab) by SA1P222CA0122.outlook.office365.com
 (2603:10b6:806:3c5::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Thu,
 26 Feb 2026 10:52:42 +0000
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
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 10:52:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:52:20 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:52:17 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v3 14/32] hw/arm/tegra241-cmdqv: Emulate global CMDQV registers
Date: Thu, 26 Feb 2026 10:50:38 +0000
Message-ID: <20260226105056.897-15-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|MW3PR12MB4427:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cb61219-192f-4a4b-2429-08de75252971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|7416014|376014; 
X-Microsoft-Antispam-Message-Info: CJct3TnnhU74eUlXd716CcZzGxSOW/Z82dasQGkL51u5Vs/p2x80eZxVfkroaUhQMjjEVfBVLqPaT6OP9c46ftU500NsukvWq1dr898sOyQkcbui2q5URhOIJQsKSKaU+w1GftKlgEInWNxaNhrP0WeGVcgMF22Eq0/toH3OUlMyQX1mg9odWV0pnIP0jQc8r9tsblKcIM0bBte6O9P9OYZkHQaDLdICxDfkwjreDPx8nCZCnG+GTCQZsr4PYoje9NGWPSuEmZxYNmpkOH8MW7UVEkVV1vl1KaV1F5izbNElCYWIp5aFmZECLTOYsiUwEOYmDN32SJDK4WyhAOfOMzs/2JoR+d0iC5p9+/PjEI5voXAQ0Mgjg1opPbo2PZ9q2+1uAQHpsFq7/65fQER8IjZnEXeGX0x7K4eJY3Z3U2Ax4GWdrFRBTcGZ7g2p8ET/dIcAsgUYHjU6kokx3kmKZGoLpMdtefkFJ85wvpX3sWqMjIqTmk5Q9NWcWamwyUTpA8S8Cju19zhYe9l/IImfsAkguFm73ILSM//npG/64NIw/sn0Shekc2KNigq20b78UI/lewUQwUqBHugRqeUxu40HylASDQuQB66TLo39GN6lGnnuz2p4tLYnwMIRPauW74oA/Hay11RL8QuHJEA1IgPu+JW1dcutnG96K/X31WoCojDpOd1PhS4XhV0ga2NEk9MTTn0ogu4IYfZFlBGcaT5wHCObrVvegFa6Kxt+DSSTB33TCNP4UcVU51oGVoOpXQXk/4raERpeowmDeOzzPP1xnfxdOIHIsrW/e2Lv4HuLEGhVM6y6ruEAgm4NpimwlRmRljKg1ApBdZjQVFHYbg==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6nxkOFbpjr/G9bqz/c2esctLI0Z5Ph+NOjW9LxHr5HHeO7lpo1CtnWciHxJKT786jeLj0lpSSRM6IRu5HdAAiLU8VULrXU39zEFR+vGUBim3VGMHkZF1TupzQFHNHVg5HE0znpXtoLGSZqkI9h4E5jeb27A/3G6BhqacT1Gt9Mado5Ai6VolHSVs4ZEr2jFKmM9TkWw7H2z7PlhCl/OD0akKvWD83a8RSjzyP78XzhU2r2NqAR4YaDFqO03/56qnflszI/yHF1XpyxL7/y1ZUdKOl8OVjf1sgykXyYsWZdzwHhKBvBWm0N4uiws9G1pJ8P/RRtqnwm0p8vAzn++5p2Q70JtDpJWhwR2YiGsqn7vKU1bQpvyJtvAjWu1dTAyeLp3UOUmBAiJbbsT00MFKIOgkFOfbshNk7G0V/j1AyAk6NBxpMvKpymZj32fk4M0b
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 10:52:40.0562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb61219-192f-4a4b-2429-08de75252971
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4427
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Tegra241 CMDQV defines a set of global control and status registers
used to configure virtual command queue allocation and interrupt
behavior.

Add read/write emulation for the global CMDQV register page
(offset 0x00000), backed by a simple register cache. This includes
CONFIG, PARAM, STATUS, VI error and interrupt maps, CMDQ allocation
map and the VINTF0 related registers defined in the global CMDQV
register space.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.h | 108 +++++++++++++++++++++++++++++++++++
 hw/arm/tegra241-cmdqv.c | 121 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 228 insertions(+), 1 deletion(-)

diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index 46aa9e8a9f..50bcecee9d 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -10,6 +10,9 @@
 #ifndef HW_ARM_TEGRA241_CMDQV_H
 #define HW_ARM_TEGRA241_CMDQV_H
 
+#include "hw/core/registerfields.h"
+#include "smmuv3-accel.h"
+
 #define TEGRA241_CMDQV_VERSION             1
 #define TEGRA241_CMDQV_NUM_CMDQ_LOG2       1
 #define TEGRA241_CMDQV_MAX_CMDQ            (1U << TEGRA241_CMDQV_NUM_CMDQ_LOG2)
@@ -31,8 +34,113 @@ typedef struct Tegra241CMDQV {
     SMMUv3AccelState *s_accel;
     MemoryRegion mmio_cmdqv;
     qemu_irq irq;
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
 
+/* Global CMDQV MMIO registers (offset 0x00000) */
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
+FIELD(PARAM, CMDQV_NUM_VM_LOG2, 8, 4)
+FIELD(PARAM, CMDQV_NUM_SID_PER_VM_LOG2, 12, 4)
+
+REG32(STATUS, 0x8)
+FIELD(STATUS, CMDQV_ENABLED, 0, 1)
+
+#define A_VI_ERR_MAP 0x14
+#define A_VI_ERR_MAP_1 0x18
+#define V_VI_ERR_MAP_NO_ERROR (0)
+#define V_VI_ERR_MAP_ERROR (1)
+
+#define A_VI_INT_MASK 0x1c
+#define A_VI_INT_MASK_1 0x20
+#define V_VI_INT_MASK_NOT_MASKED (0)
+#define V_VI_INT_MASK_MASKED (1)
+
+#define A_CMDQ_ERR_MAP 0x24
+#define A_CMDQ_ERR_MAP_1 0x28
+#define A_CMDQ_ERR_MAP_2 0x2c
+#define A_CMDQ_ERR_MAP_3 0x30
+
+/* i = [0, 1] */
+#define A_CMDQ_ALLOC_MAP_(i)                 \
+    REG32(CMDQ_ALLOC_MAP_##i, 0x200 + i * 4) \
+    FIELD(CMDQ_ALLOC_MAP_##i, ALLOC, 0, 1)   \
+    FIELD(CMDQ_ALLOC_MAP_##i, LVCMDQ, 1, 7)  \
+    FIELD(CMDQ_ALLOC_MAP_##i, VIRT_INTF_INDX, 15, 6)
+
+A_CMDQ_ALLOC_MAP_(0)
+A_CMDQ_ALLOC_MAP_(1)
+
+
+/* i = [0, 0] */
+#define A_VINTFi_CONFIG(i)                       \
+    REG32(VINTF##i##_CONFIG, 0x1000 + i * 0x100) \
+    FIELD(VINTF##i##_CONFIG, ENABLE, 0, 1)       \
+    FIELD(VINTF##i##_CONFIG, VMID, 1, 16)        \
+    FIELD(VINTF##i##_CONFIG, HYP_OWN, 17, 1)
+
+A_VINTFi_CONFIG(0)
+
+#define A_VINTFi_STATUS(i)                       \
+    REG32(VINTF##i##_STATUS, 0x1004 + i * 0x100) \
+    FIELD(VINTF##i##_STATUS, ENABLE_OK, 0, 1)    \
+    FIELD(VINTF##i##_STATUS, STATUS, 1, 3)       \
+    FIELD(VINTF##i##_STATUS, VI_NUM_LVCMDQ, 16, 8)
+
+A_VINTFi_STATUS(0)
+
+#define V_VINTF_STATUS_NO_ERROR (0 << 1)
+#define V_VINTF_STATUS_VCMDQ_EROR (1 << 1)
+
+/* i = [0, 0], j = [0, 15] */
+#define A_VINTFi_SID_MATCH_(i, j)                               \
+    REG32(VINTF##i##_SID_MATCH_##j, 0x1040 + j * 4 + i * 0x100) \
+    FIELD(VINTF##i##_SID_MATCH_##j, ENABLE, 0, 1)               \
+    FIELD(VINTF##i##_SID_MATCH_##j, VIRT_SID, 1, 20)
+
+A_VINTFi_SID_MATCH_(0, 0)
+/* Omitting [0][1~14] as not being directly called */
+A_VINTFi_SID_MATCH_(0, 15)
+
+/* i = [0, 0], j = [0, 15] */
+#define A_VINTFi_SID_REPLACE_(i, j)                               \
+    REG32(VINTF##i##_SID_REPLACE_##j, 0x1080 + j * 4 + i * 0x100) \
+    FIELD(VINTF##i##_SID_REPLACE_##j, PHYS_SID, 0, 19)
+
+A_VINTFi_SID_REPLACE_(0, 0)
+/* Omitting [0][1~14] as not being directly called */
+A_VINTFi_SID_REPLACE_(0, 15)
+
+/* i = [0, 0], j = [0, 3] */
+#define A_VINTFi_LVCMDQ_ERR_MAP_(i, j)                               \
+    REG32(VINTF##i##_LVCMDQ_ERR_MAP_##j, 0x10c0 + j * 4 + i * 0x100) \
+    FIELD(VINTF##i##_LVCMDQ_ERR_MAP_##j, LVCMDQ_ERR_MAP, 0, 32)
+
+A_VINTFi_LVCMDQ_ERR_MAP_(0, 0)
+/* Omitting [0][1~2] as not being directly called */
+A_VINTFi_LVCMDQ_ERR_MAP_(0, 3)
+
 const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void);
 
 #endif /* HW_ARM_TEGRA241_CMDQV_H */
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index d487612ba2..a3830a02d6 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -8,19 +8,138 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 
 #include "hw/arm/smmuv3.h"
 #include "smmuv3-accel.h"
 #include "tegra241-cmdqv.h"
 
+static uint64_t tegra241_cmdqv_read_vintf(Tegra241CMDQV *cmdqv, hwaddr offset)
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
+        qemu_log_mask(LOG_UNIMP, "%s unhandled read access at 0x%" PRIx64 "\n",
+                      __func__, offset);
+        return 0;
+    }
+}
+
 static uint64_t tegra241_cmdqv_read(void *opaque, hwaddr offset, unsigned size)
 {
-    return 0;
+    Tegra241CMDQV *cmdqv = (Tegra241CMDQV *)opaque;
+
+    if (offset >= TEGRA241_CMDQV_IO_LEN) {
+        qemu_log_mask(LOG_UNIMP,
+                      "%s offset 0x%" PRIx64 " off limit (0x50000)\n", __func__,
+                      offset);
+        return 0;
+    }
+
+    switch (offset) {
+    case A_CONFIG:
+        return cmdqv->config;
+    case A_PARAM:
+        return cmdqv->param;
+    case A_STATUS:
+        return cmdqv->status;
+    case A_VI_ERR_MAP ... A_VI_ERR_MAP_1:
+        return cmdqv->vi_err_map[(offset - A_VI_ERR_MAP) / 4];
+    case A_VI_INT_MASK ... A_VI_INT_MASK_1:
+        return cmdqv->vi_int_mask[(offset - A_VI_INT_MASK) / 4];
+    case A_CMDQ_ERR_MAP ... A_CMDQ_ERR_MAP_3:
+        return cmdqv->cmdq_err_map[(offset - A_CMDQ_ERR_MAP) / 4];
+    case A_CMDQ_ALLOC_MAP_0 ... A_CMDQ_ALLOC_MAP_1:
+        return cmdqv->cmdq_alloc_map[(offset - A_CMDQ_ALLOC_MAP_0) / 4];
+    case A_VINTF0_CONFIG ... A_VINTF0_LVCMDQ_ERR_MAP_3:
+        return tegra241_cmdqv_read_vintf(cmdqv, offset);
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s unhandled read access at 0x%" PRIx64 "\n",
+                      __func__, offset);
+        return 0;
+    }
+}
+
+static void tegra241_cmdqv_write_vintf(Tegra241CMDQV *cmdqv, hwaddr offset,
+                                       uint64_t value)
+{
+    int i;
+
+    switch (offset) {
+    case A_VINTF0_CONFIG:
+        /* Strip off HYP_OWN setting from guest kernel */
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
+        qemu_log_mask(LOG_UNIMP, "%s unhandled write access at 0x%" PRIx64 "\n",
+                      __func__, offset);
+        return;
+    }
 }
 
 static void tegra241_cmdqv_write(void *opaque, hwaddr offset, uint64_t value,
                                  unsigned size)
 {
+    Tegra241CMDQV *cmdqv = (Tegra241CMDQV *)opaque;
+
+    if (offset >= TEGRA241_CMDQV_IO_LEN) {
+        qemu_log_mask(LOG_UNIMP,
+                      "%s offset 0x%" PRIx64 " off limit (0x50000)\n", __func__,
+                      offset);
+        return;
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
+        tegra241_cmdqv_write_vintf(cmdqv, offset, value);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s unhandled write access at 0x%" PRIx64 "\n",
+                      __func__, offset);
+    }
 }
 
 static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
-- 
2.43.0


