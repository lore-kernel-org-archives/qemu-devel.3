Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D887CD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWudl-0002BT-FK; Tue, 09 Jun 2026 07:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWudV-0000aN-UK; Tue, 09 Jun 2026 07:28:50 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWudT-0003Xw-7M; Tue, 09 Jun 2026 07:28:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1EAz56XIinRWQV2xvTYwkmDoCQ9yF8VXnLU/uJd902LYmw84qEQfw4xe2SHDD0ywM+xzzK5NyxykZrDxgoSKGHq/7uElhBVVLI0qcOpdaBXD3yUnid+7N3MrFzyi2SVB2kJ0uzXEjwogoJ9RNQ0vHAfB0DEylCMtwn/UEGvAUnG+igJAtIzi3cP1DI62QrtO2oA7qGx7E+YyAPMasnpLhsjhYPBy4ek1Sc646ifIhEHLub0YzzdBFCD9tY+0pqe4yP3zi76VZsKvk9dT28UDTin/BiXpiEPMWnCV+++bJoCkjyZqpXt+1b0wAukg94eCdhBSDFbgqfj5tvdQ0UXjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WJEGobeJ1DftWs8ZjQ3EUmlJzop89CqE/JmRcdkg4c=;
 b=ID7DVcPv2LxptJU1fJeAmF0O8rRJQPBVdavmirw3dcuG1cnUVaNfu5H9q9eB53Q8Hl2JE3b2qagtVVBuAT7d+4Ni+q+E5uLLHW3p9SWBZ8KImNM8Kdh62LsvTfiHgyBrEP3eLtb/7kU7gh/V/SL7wuQ+jNmWi0RfgqbNDsmuF5KESOcwr55XQyKL/MUrti6UpZeJKkBznhnBHoaRjCJgT4yof4wNj9en8Kf4wtdnNOckuvcZ5pNI8hbjsq56B0zOW+QGsAwmwHjMDbga9ZiJazpMmwgzYAA/lw7VphtjboufR5HHG185J9CTuq3hNmd1FLfKzv2lcDjOT6+kciNl+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WJEGobeJ1DftWs8ZjQ3EUmlJzop89CqE/JmRcdkg4c=;
 b=EPlkik+B/3SVYGaBDDjmcrAcOp1qz2AgX0HdPXD/Mpw+IyVHB1Wa4fIBII943hOaxnJDpPWD0aZ1ihFN7k5IZAVDRuoGr66Gh08W9kY1gNLD+3p4LbP27BnInJ2aaQthKqGQILy+l2YQLMhV/k6Rz7YSd08ie/rtv5loE3HTrLT96rvOZBNpwJjx+OCKPsUFozl/GN8BlVtMmaYjLBGuaD6QD1JI6Ye0H/iskacYIEWBC267lr7ObjMLQM2vE5aKLI34NIVGT8oGbs+kNDRTHYw7vMOV6331bW/c6NLjspDas658hlEGS+/Ctkie/GkJNtDiPsyLNR3H1sZ6TY4Zzg==
Received: from SJ0PR03CA0294.namprd03.prod.outlook.com (2603:10b6:a03:39e::29)
 by MW4PR12MB5601.namprd12.prod.outlook.com (2603:10b6:303:168::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 11:28:35 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:39e:cafe::9c) by SJ0PR03CA0294.outlook.office365.com
 (2603:10b6:a03:39e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 11:28:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 11:28:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:28:20 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:28:16 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v7 24/31] hw/arm/tegra241-cmdqv: Initialize register state on
 reset
Date: Tue, 9 Jun 2026 12:25:45 +0100
Message-ID: <20260609112552.378999-25-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609112552.378999-1-skolothumtho@nvidia.com>
References: <20260609112552.378999-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|MW4PR12MB5601:EE_
X-MS-Office365-Filtering-Correlation-Id: f58f4710-eef9-4aa5-d492-08dec61a3e7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: v2Q/N6xd1Jw8VYYakeDgkZA4LDE83pfRcVR7mcNDPg1Snn52WMzPuRL+yjUhOH1HdsJYigkD06BeNP+8/tBDIbEwspEJasskePwmsMpRvBvoZsM4ac75uM3Scx9AEEd3YB13WQ92opEWi40PfRyKiiwG7pAmB8EInzFr+woLv9Yr0g1OFsxrTor7swoZqG1eAi3c+ho0HrA3e1qJmMbb5LP4K2N4Z0KyoxRsFdu3MffmwDq5OVK3TuRV+OARBsaIHp4j4y1se8KBI+n5UYXyotHxYy1DzTUCNaon3J9gFon0W5GSXqIIEtbOKQ5AXVvHpxwTatvzVxBqZhfmnJE6exmPi0/wBgxRY0pOBv4A7Zn//9wbpNXXRAjLK6TkWVVLKJqPCQoly7ZGZXCOOBLv2WdeIDI419n3obb5RCm6kVrAWtFsq4SeJ9gnfJQc3g23gx173LElkYmYO+iSYESW7Z4XkuVs2mdQn3j2pG/m0F8SrObVX5ryyY5MyTAyqXQjVDqa272pJaIGfdCOphWIXxwMT16IRKHIq0zOPGxNGxCqsLh+cAY3MqDfhh47dwZXM1KWzE/KaKb7SNlIc7/bHiVIHbrrOmXkGnt5871QgjFotUBi6IJOjkGzwM1mCadKNfCns06oGVuXtI53UHILWzcjYH4J3wEhtvaTrEWsZOBbsDjs9e7vCWczHgeorZJx5tc7Dq36cKsl60qFRi3cruWuc+bSmK6qrImbG0y0NRo=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NxNXebs5amJx11Zuw6s8oAY7BzRbM/z1RFu5WTirjaduxlnZZ7DeuNWdvfES8rE/toUalah4s40amlENpdhBtwqNd4ceoOB/mq+8Gd2e38r2E27aKdlRTfjFb94h92GHcuJ6YjX0s5YGbrfZKhnF8w5Fr/kv4hYgEV41Ph1clGeYmuabClD5iPT+GrIYMy7qHzG2wtvXCrgFI3JOpr2ESi1iAaDU1kQjdWouD4PXuHv8lJ+gSJhkGsR+7QdMkNLGhplq2VRvGBBvTlWMYsfqxAQutQd9keQ+y41SmVTeNNn6eTtN9MJB9ZaWYcg74NVmpb9PwB1SYeP7yWtp/euswHjv1ZtE9kFx8ifGQUy0/7BiqHMP1SsIci2r9fZkbasrR96gvRXaPA5fLo6JODxEz0DHVE9K/MDSuhaZqU2ElZj13s5fGcKMdcc0c1Od611b
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 11:28:35.1398 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f58f4710-eef9-4aa5-d492-08dec61a3e7d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5601
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
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

Initialize the Tegra241 CMDQV register state in the reset handler.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.h |  3 +++
 hw/arm/tegra241-cmdqv.c | 38 ++++++++++++++++++++++++++++++++++++++
 hw/arm/trace-events     |  1 +
 3 files changed, 42 insertions(+)

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
index ff0fcd1e66..0ed2a03612 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -863,6 +863,42 @@ free_viommu:
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
     Tegra241CMDQV *cmdqv = s->s_accel->cmdqv;
@@ -873,6 +909,8 @@ static void tegra241_cmdqv_reset(SMMUv3State *s)
 
     tegra241_cmdqv_guest_unmap_vintf_page0(cmdqv);
     tegra241_cmdqv_free_all_vcmdq(cmdqv);
+
+    tegra241_cmdqv_init_regs(s, cmdqv);
 }
 
 static const MemoryRegionOps mmio_cmdqv_ops = {
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index dbed00afbb..0bd718b1ab 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -76,6 +76,7 @@ smmuv3_accel_install_ste(uint32_t vsid, const char * type, uint32_t hwpt_id) "vS
 tegra241_cmdqv_read_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
 tegra241_cmdqv_write_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
 tegra241_cmdqv_err_map(uint32_t map3, uint32_t map2, uint32_t map1, uint32_t map0) "hw irq received. error (hex) maps: %04X:%04X:%04X:%04X"
+tegra241_cmdqv_init_regs(uint32_t param) "register init, param=0x%08X"
 tegra241_cmdqv_read_vcmdq_page0(int index, const char *aperture, const char *backing, uint64_t offset0, uint64_t val) "vcmdq[%d] %s (%s) offset0: 0x%"PRIx64" val: 0x%"PRIx64
 tegra241_cmdqv_read_vcmdq_page1(int index, const char *aperture, uint64_t offset0, uint64_t val) "vcmdq[%d] %s offset0: 0x%"PRIx64" val: 0x%"PRIx64
 tegra241_cmdqv_write_vcmdq_page0(int index, const char *aperture, const char *backing, uint64_t offset0, uint64_t val) "vcmdq[%d] %s (%s) offset0: 0x%"PRIx64" val: 0x%"PRIx64
-- 
2.43.0


