Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCA6CD4F57
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHsD-00027P-QF; Tue, 19 May 2026 06:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHs5-0001Z0-JA; Tue, 19 May 2026 06:40:24 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHs3-0006py-Nx; Tue, 19 May 2026 06:40:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWR+dGEUAKrMgjHAgQB+n71vYEnqnKPk6xb4K4slvUEuJR/E7acRyKy+1ruCtNG5hOyJ6IJqmr5ko3jDbZd5xhVbUa97lK9DOpl/uRKvssvfDO0Gf29QesS7j0/SU4CkaUMK3dlaOkq30cYPbO3B6Id9KSnB5f7tg6rE3Ols1tG6C6N9kNFPLoK6cY1p4QQpBQgL3r9MIFDzBXDwhNCh1e4ZCeMHCGlKb1U3eVw9XPV+bpYpxnNCezPfOaarMTOXC/LOwil7XbvUdob5KSeezZT6m9u1kKZjt/6EEkcDdCH4JZB8EdHEcje7ajAGzOazAEUYa4xJqgYUlo7E4bVD6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/8Cs8dQH28IaPOUtRU0YY97g0cieILZpAHtOk5Kwzs=;
 b=LANHgP0FbklhtLTPfpHxl4O9hKZvzdCkyGwc2bsIkI0VJTBzQ8jHFa0YpRGs4UPip1CJybv9sXOC0dd9H32AWHhhU/vdBGfvTClXWYJHZ71gNRIbh4WzTCs5nPOUC9NrtRzg2+6ZjuH73CzOQKo7OAUOoeKpX3qLwN9RTGwI06VLfS+FY2ewwSWmbogpnB9nSlzFsECSCqqwOrAqjyZzQh8Oy0ULcnzP4DcSo2klmhGLNubtkq2O6Hj+rQPU1xSwbR3dsxGdkAZiJbzzi/v32x+FV3WBIvabK170ZunsTYssaOXmJMESib0lyaYHe0A784TXA6wwXSw3GQkE44JMwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/8Cs8dQH28IaPOUtRU0YY97g0cieILZpAHtOk5Kwzs=;
 b=hi7r7vKlzd2xqWjHp5A7cqJmOe6JCEaP/mO1pyzKzklbA4Yp5Xl1ROpTvi8u7vzoALDGSAI1WgOJXd6RU0tccvDy3r+NMhnOR3iK2TvdowxpTQsGQj9VKbhRP2QI0uaF0dEtZk1kAzuskqJaOYrV9B84E/mM+78xw5+SzaY5thSwbzUs/V2OHB832/YF5gohgFtNYITQEunpE7WqWFWQCPA3FtKGePJkO1MYOw/bTs8ZbaWtwC/ST3SV0E01P54pIW2/E6P7+msdIXgTMdUT59NG+2DHZ4NaytoF4t3KoeKb8e69veSlmBKK4BfWNSslaPmY4JvueVkh4Uo6+D8zwQ==
Received: from PH8PR07CA0025.namprd07.prod.outlook.com (2603:10b6:510:2cf::13)
 by DS0PR12MB8573.namprd12.prod.outlook.com (2603:10b6:8:162::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 10:40:12 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::9b) by PH8PR07CA0025.outlook.office365.com
 (2603:10b6:510:2cf::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.25 via Frontend Transport; Tue, 19
 May 2026 10:40:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 10:40:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:39:58 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:39:55 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v5 25/32] hw/arm/tegra241-cmdqv: Add reset handler
Date: Tue, 19 May 2026 11:37:03 +0100
Message-ID: <20260519103727.899332-26-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|DS0PR12MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: be661d41-e175-4d88-2805-08deb59301b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|22082099003|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 0QDzhWZ5FuigErRyQ0HUqcQTQl72RrzDM53Qa1PZTwoifLpqWZtW+qRTCzLtJYeSgQ0des/UwuDLqBCg7qCMHeL48NhBP67cwK+aWbkRsNlJYs6x+09sWIElgDB/6/a/1NRDr6SHPnO5fjIPBzCo7zQh1286edigPFnTI1Tr57yOSi1Uol21Bb4pAD50u0m4Fz9xp/pXE00uu8tt2mdxuPrPLdgoftOi+4GSz6scTedfw0jYG73BJTOOPw+HsSRu+2UqSolS3r4raTvenpbqYnmXb6mik92r5EjNmJdyYNAyXVhPbXaOweJHFG797zyxSv3+T/CRrsOfnLZ/2xADMO0T3lH9WvWnBLfNeifZCOkYwBNOVzj/nMziZrGrenvcKDbjad3g3aqxqimgxZgeAJayd4LbPXLV4pv7w6/VP3R1k/IqIAAblJMm65YCpus2tUXc5m5U8P1f0MdvEbwJ06vKb3QFCE35ZETLquCd1p4lrwfJn8J8Odta66PSD2zpedKuH+hugzQ07fa9bOtJ1N4wYSSRF6HD9nmzNYuV/gBlyVahcAmdscVYDG5vLWpncGsQ1NnDinp3SDqtDAqfIoZAxcHgDmDtxBtrY1uPHZ+w584+87KNNXnr9OBZobR3AxVYaf3njkP9Gw3hQkY9hCevHjRq/924M+FMVgntaPIGIOHQ508knKKSq0x4LTeV02g/MURoZ8Jjyvn608KhZABqO36f3RxE0NJKBpqRbA0=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(56012099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jzYGpGkjS35wJOBdQW16sR8lg3+cAhzxfJlKZ4c+Vbl/MRPPKqxaig9EEYqQgBk+j/VDE+7EJmKOZbKRrvt2V74d3Ye2q+dAdBrFAw9jhZStryx/L5hkf8lMtbeYTymtNT3dgn8Ezz6iyIVbfsX2TFPZOECKobqwLaGXMk3Rgag8jqBgbQxHGoexkj2OiSL94qW2F+qM+E6ESEgBieqEyolxoBeKdbRGe1peg4xxMUAkwolP7iKLOo7cVXVnoKtQF/GB5wTMtfXkIIAw+2KVW2W4I7p8Llcr/kdIlVfFeCBydd99aujIDl5HQKAu8bEZiUS9YhMOhuS6MfX9ONWGObbODmUgBKA9xl6tuWzlt4YAmY0iyfYfuRxoICm2oi6iT24G53xVkytgSZW3H240ziq5DIRzW00TrBbQv0WPKvyS75vE3NyAvLCo123dZT5L
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:40:12.5413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be661d41-e175-4d88-2805-08deb59301b6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8573
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
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
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.h |  3 +++
 hw/arm/tegra241-cmdqv.c | 48 +++++++++++++++++++++++++++++++++++++++++
 hw/arm/trace-events     |  1 +
 3 files changed, 52 insertions(+)

diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index e9e1933a19..34cb5efb84 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -87,6 +87,9 @@ FIELD(CONFIG, CMDQ_MAX_CLK_BATCH, 4, 8)
 FIELD(CONFIG, CMDQ_MAX_CMD_BATCH, 12, 8)
 FIELD(CONFIG, CONS_DRAM_EN, 20, 1)
 
+/* CMDQV_EN=1, PER_CMD_OFFSET=16B, CLK_BATCH=256, CMD_BATCH=32. */
+#define V_CONFIG_RESET 0x00020083
+
 REG32(PARAM, 0x4)
 FIELD(PARAM, CMDQV_VER, 0, 4)
 FIELD(PARAM, CMDQV_NUM_CMDQ_LOG2, 4, 4)
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 0bba2c1801..ad64f06260 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -853,8 +853,56 @@ free_viommu:
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
index 5afbceee83..5ebb3dc9ea 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -76,6 +76,7 @@ smmuv3_accel_install_ste(uint32_t vsid, const char * type, uint32_t hwpt_id) "vS
 tegra241_cmdqv_read_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
 tegra241_cmdqv_write_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
 tegra241_cmdqv_err_map(uint32_t map3, uint32_t map2, uint32_t map1, uint32_t map0) "hw irq received. error (hex) maps: %04X:%04X:%04X:%04X"
+tegra241_cmdqv_init_regs(uint32_t param) "hw info received. param: 0x%04X"
 tegra241_cmdqv_read_vcmdq_page0(int index, uint64_t offset0, uint64_t val) "vcmdq[%d] page0 offset0: 0x%"PRIx64" val: 0x%"PRIx64
 tegra241_cmdqv_read_vcmdq_page1(int index, uint64_t offset0, uint64_t val) "vcmdq[%d] page1 offset0: 0x%"PRIx64" val: 0x%"PRIx64
 tegra241_cmdqv_write_vcmdq_page0(int index, uint64_t offset0, uint64_t val) "vcmdq[%d] page0 offset0: 0x%"PRIx64" val: 0x%"PRIx64
-- 
2.43.0


