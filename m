Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBD6F4198B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 10:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCxxB-00036v-8H; Wed, 15 Apr 2026 06:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxx9-00033Y-JU; Wed, 15 Apr 2026 06:58:39 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxx8-0004Eg-1d; Wed, 15 Apr 2026 06:58:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQ1/oZmVzrQft3qvyIPGYGmYJZ3931nw8gBw4YLPKy19BRN+EW3GSGRu5nTMrJjcmBrivSEdmLGRuXI015Xqbwo2p+sbbBXmGjHd4H2BO/PgTa3832Pd0CKnQAqg7uFpoXhczs7wsWawwxD835W+1zdJpTByJcC16whJXCPxb/bbWA3TYWLkfKd4P6hsjWsNxrP6DGkxy3+qzfzndCfyRU+9kPKsmT83KhoUEgTmKKHbFKKiRKzhuNLyfnhVrP+XtgRVuBGs6EiK16iEj/0/sJzo0WDOLFqLw6/CVDxzCSGE6ZjVEu1p7jK61mwINSy8bMbn7Btf0OMTvnM3K7jnXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSIxRRjmNzHMQogvi39tzapN4XZSo7OIlKksRc2MVrg=;
 b=llNpuIQ+JB3wnrB+j97zCE+e/8p++PruAAYwNT7x14ikXNE0F1mkm619Y7V78sNS9D9eWVPwIVHRBX/Oy7BSvWHeixR8AfVt/L4sjgshYuy1rTWhDXBcGwGcMxjNFD3C+pXzCHrTge3eKCYHbuwweTXgV281Tb2/TNbXKu4cQ4UPqwwtKr73Yvk60OFlgxPf52f0p2yes8tzL4E2c08pf++dWvo3G5E3tV7xvD14xyIN5tocZlNtOt5MPO7s3er5GSKjxRaX93nynLQlUqjTVqBvFOzarPNaV1cSfjbgSXoMT8twV3Ntfwf1u6cOueLPHc5QLgNRATlmSgqM27YRcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSIxRRjmNzHMQogvi39tzapN4XZSo7OIlKksRc2MVrg=;
 b=gupRT6dCGSl9dzuWlWXeQzdcIH0fI+zBARumubug6b0rabgj/c8Fm0KnA+lSqkmxT0f+boAt0gtP8Dr0eCtFzidq7Jv60ks5tkIKulMl+5nBkJk7sgKscsT28VdBw/87gX231OZwlDMiAgfl4R8gdQb41wNVEAdF3JOQcY9rRpYXgOFVKQBxwS09ScT0yciKlQHrbCkyPUtqgtVqhFgVhSkOVC7CAnTg920XWf4AZ3mjZpdSsWdyj0f/7TcLAcS4KdfCBndqBxNejjzsQwYyvrYoabl07zma0T0tbPJsAr82xV12bSyMeUimbzsFY/iurhQ8iDvbefKdEk10/QWWyg==
Received: from PH0P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::13)
 by SJ2PR12MB8783.namprd12.prod.outlook.com (2603:10b6:a03:4d0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 10:58:28 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::b6) by PH0P220CA0009.outlook.office365.com
 (2603:10b6:510:d3::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Wed,
 15 Apr 2026 10:58:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 10:58:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:58:08 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:58:05 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v4 25/31] hw/arm/tegra241-cmdqv: Add reset handler
Date: Wed, 15 Apr 2026 11:55:46 +0100
Message-ID: <20260415105552.622421-26-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|SJ2PR12MB8783:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ced8989-337b-442b-31b8-08de9addeb1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: nn0stwl9dm4L9rkysAWwsN0ny2/XDkRYHX3VxACv9uxZMINBqS4/Fnqr1N4b9w0u4KDRz/HJzljtfi08x+WYFXD73dR6mbO06jWtBzLHSGANkSASH2KY/XxVFKzmvMeoJGkNEe+2tAaNgUD1coeOtQHtZ5mDVcc+qcbjWt0sNcfjLeAsTONflHXF9JPmWHhcVUqJCu+auzMfqwKRy3ZmSrLaqXMmcmOQirDdXyIdTkSLMNpMrzZWC5SfsQzUBAxuc0bzhdnV9js9pQnBoZSnNGXHtH2Y1K2VewsjqDEf/bIiynI+qLykUPmPXHWoFZlkglQ/vzVze42sFHPP7hODkjnfVGtMjwPpcI5KOlP3kmCX7LkznN4rUqmHXYj+pwljpvN1pGAG1DaeoGNdVFgEghbKvKQbIb5U1VcyTF5WK9Uw+MIqnfsUCMB+Wi4RhuxqQoi9p+o8uar5Yad67Jq440VCIqj53/gTVJ7kY6VSXQN+ZywhvazI9COibU9ZhZH//BeWs1PiIoGMt9D/HXyMEGWDQny+cgsgb4/oLqe9xB2Mj40vcb4TSxZQVy2osMTcARZcTER0T+WwttpGQGRhTXN6L0y5FVvThPb5amIxPEHvjw8qn/Ppmn3kglU+CBVUqJPzn9F7ZlSAUp+8eWLevg6wNtdokPwsaCKvZ6QiHM/Yr3T/scoGf5iWCQxFmJ6I0FVtm0UhFQ/STcuUB4Kvb0F/f6dqvGJF0T4dIx1E5UbwfxXCXTcVD+QBYZLlxyDO8EYiN1IfP7GIcC2oZXy9rA==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2lPB6q0p5/3vh/uvYhYg1nXxq/uzRq9CwnZWn48LdTDynFgq4vgjCoOU8d6328dCHjgssjcw1lqRaZpwPNHmwRg0UrGJUAuaDJKA610usNpq4eYFnhwIAkX81aDPo8Zma+pWV5+ll87xLOG6ogymrrFvr/XTNM/brabvxXJ9NmmQHTrHoSXWYyWdQGup0ygJDc3xr232jofGpBkxBssl9jlNriNsQck75CSoqrPdm+XVJvfQnDol/a/QKamKCywjVxrQo5os1I0aUErLatShkPp0mOOyS3mFDhOOP5fGIOm5nP9z/1Br69fhU4sJenL+yXjgqeztSNh0fuurMPTn4wndyGCMD56UrKA76JWhimSDhqZB3dGjnYXfZV8+kh73BpT6f9+PYZCRvXwMZYpI2j6ifv80yu6eetM6v/TnMOMemLMBN3Jj4JV1UKEac2o4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 10:58:25.4825 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ced8989-337b-442b-31b8-08de9addeb1f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8783
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
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

Introduce a reset handler for the Tegra241 CMDQV and initialize its
register state.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.h |  2 ++
 hw/arm/tegra241-cmdqv.c | 50 +++++++++++++++++++++++++++++++++++++++++
 hw/arm/trace-events     |  1 +
 3 files changed, 53 insertions(+)

diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index 2befa6205e..b2a444daef 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -79,6 +79,8 @@ FIELD(CONFIG, CMDQ_MAX_CLK_BATCH, 4, 8)
 FIELD(CONFIG, CMDQ_MAX_CMD_BATCH, 12, 8)
 FIELD(CONFIG, CONS_DRAM_EN, 20, 1)
 
+#define V_CONFIG_RESET 0x00020403
+
 REG32(PARAM, 0x4)
 FIELD(PARAM, CMDQV_VER, 0, 4)
 FIELD(PARAM, CMDQV_NUM_CMDQ_LOG2, 4, 4)
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 9c2fc02b92..af68add2f0 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -8,6 +8,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu/log.h"
 
 #include "hw/arm/smmuv3.h"
@@ -645,8 +646,57 @@ free_viommu:
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
+    for (i = 0; i < 2; i++) {
+        cmdqv->vi_err_map[i] = 0;
+        cmdqv->vi_int_mask[i] = 0;
+        cmdqv->cmdq_err_map[i] = 0;
+    }
+    cmdqv->cmdq_err_map[2] = 0;
+    cmdqv->cmdq_err_map[3] = 0;
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
index fd6441bfa7..6f602b9eda 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -76,6 +76,7 @@ smmuv3_accel_install_ste(uint32_t vsid, const char * type, uint32_t hwpt_id) "vS
 tegra241_cmdqv_read_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
 tegra241_cmdqv_write_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
 tegra241_cmdqv_err_map(uint32_t map3, uint32_t map2, uint32_t map1, uint32_t map0) "hw irq received. error (hex) maps: %04X:%04X:%04X:%04X"
+tegra241_cmdqv_init_regs(uint32_t param) "hw info received. param: 0x%04X"
 
 # strongarm.c
 strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
-- 
2.43.0


