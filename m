Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 338D4FC592C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvYzw-0006xG-MV; Thu, 26 Feb 2026 05:53:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYzu-0006vs-Dy; Thu, 26 Feb 2026 05:53:34 -0500
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYzs-00013m-Pl; Thu, 26 Feb 2026 05:53:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DcvrjCteGOO4nx4dhfEpmo2h/824uPWcYGcyMdUSwuJRYhffGkG6wjLrNg1lIZDz/Va3aEXxvYjbrXH9DxhYTx/BwobXfoGic7c0orjwLv98uLfCy/NF29btU5wQl8FHkFDS7bnXhSSc63lwHJ68OO8+wrhjwyZ0dmMhzSIkRPkSWdOZfzjFFgezc91uIsyn9zCVQdhTwLPRXTb5QyjvO2cLYYsGtkHAnQfDzYY1eDdebkb/zm4V4XUZFngDSUv4t9Ts911XJaGjbHuxFjQ4tNy7H6ok7/TZHtEtCCoGFzwei/vWxR6UTWvxq5QAHlQ5A5q0SC5ZfuoylcX03QIAmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/72YRWM+mVm23vb5IbHHiwmc/mHd/68sDgMPUM6iuo=;
 b=pCRZ09B8pbzJSY0IeHwTIIQnD1c7hMMmfhNlEytNmP+hPpQml5j9lAp0QspRZx4CnYxoEEBd7sZnq/v1l3O/VnZD4nehJts6e0C5eskPaXcHDByjehnhkQwh3+CvRP7VsMtmPwaSzCV89sRzXVA5G0KJTWQoOGcR5wkWO4llbKT/o7EI607a0juteoJXb91wSxC6iAU3FUghU5jlF4pJLuABbMY1JAmDk9nBUqCBeloH+OfS+7mKabNUC23l2f/7/FVJUpLQymk2F9kZ+/9fPBJg1QLcJLvYyhuf4umYq0pkU8FaS+abFVVdiIgx4fT7+y1SZkbhSK3atdQMOW7y6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/72YRWM+mVm23vb5IbHHiwmc/mHd/68sDgMPUM6iuo=;
 b=WYMS5B0wlRudD8S1zU2LplE/iKtk2/IVl8AerJGZPoDLiveXjB9bJEJFkAZdT5O9/zSBAWF9nAJ9nRIm980Y2WI/3+LAT7Ijl73KGCf3Vu5pWaH5ydoXDbozddc9QuY4/gvSMyw8CxH9kn/+Tb1gYe+yp1pbzi/faf6rOWxiCmW3PKWXjqFZjeduTecmz9/sWewhfRyrBbDeWXxBMM0HSjXfHHDDdfx6CnlFEIBhnG6VnMdjjt/dty4kxKwUHORRotwKZV0Pe8LBmcrf9qqn9HXdHL3F+6Gk97AcJvUQ9itzhuP028a1ZhJcy1JFxVt8FfhS0oxc3BJ2g9sR9Vewkg==
Received: from DS7PR03CA0035.namprd03.prod.outlook.com (2603:10b6:5:3b5::10)
 by DS5PPF7671D5CC0.namprd12.prod.outlook.com (2603:10b6:f:fc00::653) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 26 Feb
 2026 10:53:25 +0000
Received: from DM2PEPF00003FC7.namprd04.prod.outlook.com
 (2603:10b6:5:3b5:cafe::4a) by DS7PR03CA0035.outlook.office365.com
 (2603:10b6:5:3b5::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Thu,
 26 Feb 2026 10:53:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM2PEPF00003FC7.mail.protection.outlook.com (10.167.23.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 10:53:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:53:04 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:53:01 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v3 25/32] hw/arm/tegra241-cmdqv: Add reset handler
Date: Thu, 26 Feb 2026 10:50:49 +0000
Message-ID: <20260226105056.897-26-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC7:EE_|DS5PPF7671D5CC0:EE_
X-MS-Office365-Filtering-Correlation-Id: c92c1a8d-e88a-44b2-2184-08de7525442e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: iCw7Rru0MzKTmzUo4hucKf8godBSsJsuhfQBT1ryZGg4v8I/wNtyeQ4K3RQhZ/lS6Zo8en44ceaEFkBEexzw6EmM+UKy/3GKJfDzcIS7bgfwaRBKlc+QSuoQDkZLu3vlOqUOCdCQsoNj7DW4swfLvPtVvy9wnfROSyEZwF6IYwC26Z7DFNegN88oOixf3eLlFvIdoXsa5yt3JO2ZrKFRXhlyX01eHHLPC+kqsDLAqnmvk1G2YP16Sa7Wyjwj9MoCpHpc2EsMRZ9YcCxYzkWwdIjf1esaMAaLDyiUDIC8u0Tmc4wgOObsxY+3arpsG3QxIgqZCvKydWpYV389nXzuU9B1BhfoK5adUUdd0JOOdlXeDB03x5HolSXrXDX9qxIMaWH+eG5llMf/9FF2JAnxuOtKYEPkgCWsINGYw0lJqS94chBSeWoXDBc+yJENyWUtjiAUoYzMX1IwhvkEG1HnES2WtHR+EWlgj5IFXUikx3RVpPXaLwjEPG+yL5+zfHyyTwKdwKA4hN5ZClOXUjLUa7qlGt6wgzePnQn5RFOkqLt+P7btp/XlRbyGxHwT9rgWVc4UapB8i7z9WZkEbV3NfIpcmiEiBlA2qA0/D5YmEwBBbm3AZLSHLtsBt/Usn+oxBKzUK1TjxrhRyjrNpUuerqhYuNzm3eM/u5E+7QDtTACpGhHwVcX6hC3nJGCwzIif71i0h+E97jyxENiDUn+O1ztsj8hcK1dyeH+d8LjRjTfJi1PLUcUvdrJQhfb88fdAdqPbbCrhU39myeOGKtIaMjr6bC6G5XazlyZUnupfCku1UzYknXl8ulDqy2PI+5TDiqzJAtlOMX5Y4vv+7bWk6Q==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: i1plI1zwSP4FtnIa2TjxjZa9/Y7G8aqb6D/roeETxHdlk1ig7IbIiIoV7I5AaDpcdI6WAANqrYNrT06Zj4GHH3mksi1z9GxJNE7e8I9VSihkK72zv206AUPFQLoKiGCr3fU483uFyxbVw/TdZ+eIEd3aGKinc22nS5xh0jOk7S6tqQD1fK1w9hNUcg9UTdQ33t9Itw8k2t4rZ4Oaq6Bo2dcNEpV8BY8zIxncKVnbRUHOhLVAXdU84jaXEE5A6fkZkp2QW4wrVnj0XoDbpELywBa7EJ2x3GfsgfOzGokIkWsZOx5Pbh9LekxzobeUwq6+Xq+LV7e8ZTHVN3hcS6L1+/NQ3vb+oAQyPrG+OjjAqMRwNmsmVJswtSt2Dm9QFxuj6eRSlAdcA84e0E8hI5wmylu2qQ4IepXU3VWsS+lQTFL0Wq8fMO6XigusUGQDnEdl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 10:53:24.8499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c92c1a8d-e88a-44b2-2184-08de7525442e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF7671D5CC0
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
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

Introduce a reset handler for the Tegra241 CMDQV and initialize its
register state.

CMDQV gets initialized early during guest boot, hence the handler verifies
that at least one cold-plugged device is attached to the associated vIOMMU
before proceeding. This is required to retrieve host CMDQV info and
to validate it against the QEMU implementation support.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.h |  2 ++
 hw/arm/smmuv3-accel.c   | 12 +++++++++-
 hw/arm/tegra241-cmdqv.c | 50 +++++++++++++++++++++++++++++++++++++++++
 hw/arm/trace-events     |  1 +
 4 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index 01d446474a..96a737eb4e 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -72,6 +72,8 @@ FIELD(CONFIG, CMDQ_MAX_CLK_BATCH, 4, 8)
 FIELD(CONFIG, CMDQ_MAX_CMD_BATCH, 12, 8)
 FIELD(CONFIG, CONS_DRAM_EN, 20, 1)
 
+#define V_CONFIG_RESET 0x00020403
+
 REG32(PARAM, 0x4)
 FIELD(PARAM, CMDQV_VER, 0, 4)
 FIELD(PARAM, CMDQV_NUM_CMDQ_LOG2, 4, 4)
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 5f296ea763..9a570b8af9 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -774,7 +774,11 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
     QLIST_REMOVE(accel_dev, next);
     trace_smmuv3_accel_unset_iommu_device(devfn, idev->devid);
 
-    if (QLIST_EMPTY(&accel->device_list)) {
+   /*
+    * Keep the vIOMMU alive when CMDQV is present, as the vIOMMU to host
+    * SMMUv3 association cannot be changed via device hot-plug.
+    */
+    if (QLIST_EMPTY(&accel->device_list) && !accel->cmdqv) {
         smmuv3_accel_free_viommu(accel);
     }
 }
@@ -966,6 +970,12 @@ void smmuv3_accel_reset(SMMUv3State *s)
     /* Attach a HWPT based on GBPA reset value */
     smmuv3_accel_attach_gbpa_hwpt(s, NULL);
 
+    if (s->cmdqv == ON_OFF_AUTO_ON && QLIST_EMPTY(&accel->device_list)) {
+        error_report("cmdqv=on: requires at least one cold-plugged "
+                     "vfio-pci device");
+        exit(1);
+    }
+
     if (accel->cmdqv_ops && accel->cmdqv_ops->reset) {
         accel->cmdqv_ops->reset(s);
     }
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 99b85e698f..5afdc5c8a4 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -8,6 +8,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "trace.h"
 
@@ -617,8 +618,57 @@ tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
     return true;
 }
 
+static void tegra241_cmdqv_init_regs(SMMUv3State *s, Tegra241CMDQV *cmdqv)
+{
+    int i;
+
+    cmdqv->config = V_CONFIG_RESET;
+    cmdqv->param =
+        FIELD_DP32(cmdqv->param, PARAM, CMDQV_VER, TEGRA241_CMDQV_VERSION);
+    cmdqv->param = FIELD_DP32(cmdqv->param, PARAM, CMDQV_NUM_CMDQ_LOG2,
+                          TEGRA241_CMDQV_NUM_CMDQ_LOG2);
+    cmdqv->param = FIELD_DP32(cmdqv->param, PARAM, CMDQV_NUM_SID_PER_VM_LOG2,
+                          TEGRA241_CMDQV_NUM_SID_PER_VM_LOG2);
+    trace_tegra241_cmdqv_init_regs(cmdqv->param);
+    cmdqv->status = R_STATUS_CMDQV_ENABLED_MASK;
+    for (i = 0; i < 2; i++) {
+        cmdqv->vi_err_map[i] = 0;
+        cmdqv->vi_int_mask[i] = 0;
+        cmdqv->cmdq_err_map[i] = 0;
+    }
+    cmdqv->vintf_config = 0;
+    cmdqv->vintf_status = 0;
+    for (i = 0; i < 4; i++) {
+        cmdqv->vintf_cmdq_err_map[i] = 0;
+    }
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
+    return;
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
index 76bda0efef..ef495c040c 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -74,6 +74,7 @@ smmuv3_accel_install_ste(uint32_t vsid, const char * type, uint32_t hwpt_id) "vS
 
 # tegra241-cmdqv
 tegra241_cmdqv_err_map(uint32_t map3, uint32_t map2, uint32_t map1, uint32_t map0) "hw irq received. error (hex) maps: %04X:%04X:%04X:%04X"
+tegra241_cmdqv_init_regs(uint32_t param) "hw info received. param: 0x%04X"
 
 # strongarm.c
 strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
-- 
2.43.0


