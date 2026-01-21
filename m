Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98290C44506
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 17:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vicRw-00023P-3k; Wed, 21 Jan 2026 12:57:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicRf-0000vS-7c; Wed, 21 Jan 2026 12:56:46 -0500
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicRd-0001JI-6n; Wed, 21 Jan 2026 12:56:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fueQ/su6c4Ax55gLUfKGyboyWKnik7M/ULVkicXl5t8QwXLNYMLE2EauMAIJkeiX1miJ7YsHUrgWaHJxTPGwXRpaI5gl5/xOqOYo5s8YHNs+PrCX+R+gH1XUncf2O8Vxk1prG6vkmkc5lYSeuqCzkWqOFKHwHIrToaBjo+7p2QA3kXeA6e8wr+hkRZqedAGw0p3WRQ4PsxnvUWamg3GHI4wQmj0L7OnSXwUN+VquCnGHTvFEUvfzMXGZcDd5N8/02YIvphQKN5fWzG4wZ+FKRzJ2XDTn3Xe+KJg/zK6Odxn5MdaBgZ+5ef6Nno37kzZfYpKN6PFfMA/QHx8RT30Tew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDFc8uzLRXufkwG4oDPrLmDNAYGA81e0ggQg7SyGoIg=;
 b=VFQ+Kd+NvGdtElQfHN2JK5hPJ8e77sCviBxHpqSBrVTzjX4vkmvtg4Iy74DW9T58MX37Vd60ykmHA8MqxTweK0yZ/aw2sk2u1xioaDJwmg9RVoutc12rg7CI0mBKLAwFLwOhLTPtvjjvly7BGReJJYbFV6sfS5x83plI+ct+dWXk+DBgOG9lIUcV9g42LDyPB5ZqHSQ1kFr9uUOjZoKxLZ2aHHLarDXU/sg+tQk18hO7jxxmxJu4Fz2R3+/ZZBDZDgHtv+y2P8R3uMKs+WyKxoeIq5+2VUxLZ7GdThMftFZUO4eUKQqoGb4qGJnMamJpyHeqcK5H22z5bQFxsVbFPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDFc8uzLRXufkwG4oDPrLmDNAYGA81e0ggQg7SyGoIg=;
 b=Y3PAHd42yC8iHAOUPnispJg7CkDvjQW4k76wi8jNuGw/qL8TbsfQRnGB3gI4FlbnPMHCFyrFW47fvdObBbk453oXfLIAXBCtFF4f61u1tNAWsTktdmUAV3yfiKuQk5Uo6RMEha7lSe74d+NQcKY0bM8vH5Effc/OqxpMN+pE6HBmJzB4wpweayVtaDELhxRpx/wyRZyibyAP4OaYSeXbvpTVNF4fbc8MsjdG5yXrPzCwpElvIgHZ3Xs7hDPTxA17bgwgUTmPLeA+tUhXXaKtVRLFih7AI04bgLzHjsfC2/kwMVDymNoBB4Bx7kkO6JJ3W8UzmdxX1Z4Rf2zmx7iHhg==
Received: from BN9PR03CA0474.namprd03.prod.outlook.com (2603:10b6:408:139::29)
 by CH2PR12MB9541.namprd12.prod.outlook.com (2603:10b6:610:27e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 17:56:32 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:139:cafe::78) by BN9PR03CA0474.outlook.office365.com
 (2603:10b6:408:139::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 17:56:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 17:56:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:56:06 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:56:01 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v8 13/37] hw/arm/smmuv3: propagate smmuv3_cmdq_consume()
 errors to caller
Date: Wed, 21 Jan 2026 17:52:18 +0000
Message-ID: <20260121175248.87649-14-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260121175248.87649-1-skolothumtho@nvidia.com>
References: <20260121175248.87649-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|CH2PR12MB9541:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d7ba658-71db-4fee-8d79-08de5916690e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|7416014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bSRhZRanZu8gcjc8tUV06kbsgnTv+OS/2t4Um3GZirnFvjFHValMwiuUFTBm?=
 =?us-ascii?Q?s/RYqWuKsmRQU5jSS9szA5XiUU43ifooIz9EzvRxvAY7cQxCQM+NyKqg88V5?=
 =?us-ascii?Q?3iMZfaaarhK4H4u2uUVGzx9x7IgYR8+wyu8T3Vk+UMlYcYET9jBnIq+JWP9p?=
 =?us-ascii?Q?eUPHy08KnZj4PHGa480lbOp6sQzPZgW853weyfzkpbEkOw7/LYfupH/zFfTf?=
 =?us-ascii?Q?aF9hVrhlsNVTIcvplAXHzu0tA2i+l0byZpWR7YT0D1PBDJzszpbZHvj6IUUL?=
 =?us-ascii?Q?BaNbXVi1vuEoOLITpUDRO66jg/ipvMGQpHAQHKTRIGHP4DLN+2+JUm8cg+z6?=
 =?us-ascii?Q?JqnhdzMn4j9CNsbGGoDvfBlNoDWySBQiSzUf4TopeDVAGrSxWstdwpjatMYh?=
 =?us-ascii?Q?xREWplQqOj2QqOeAisC4P9aEnyM+PN/3VVx/9N4K3NBDGF8re9THygP9T9YJ?=
 =?us-ascii?Q?THpfS1N0q/GMlfBQ/bA4rxO0rOLvev/AdFx6sPsZacgFOk3V8BHq3ZkO7y3f?=
 =?us-ascii?Q?Z55WdMG69+Vk3E+ScMmigyLPlY53Hw3RMGlqgWDQsSgj84pUxvvvIOVEsgpJ?=
 =?us-ascii?Q?hzzTdJ2c2Rkuguz5KaNhzhLU5aCGWNy8KHQLdD5eA/UnPnhadwdjrEIel6ua?=
 =?us-ascii?Q?tcz0KfhGdu2LnBQly36zqEsY43G7VE3DYiAxOdqujFGi/rKJaQYy2smr9Ps6?=
 =?us-ascii?Q?Z1hTv4AiS8MDpn3RVp7CLqGkcLHTqZcbzIK8hg0XshWWNqIzuczym+7sgxKh?=
 =?us-ascii?Q?fAYNSkcXmj69p6FP/0CObqxSrEj5faFW5YBv9A7TZzoZqx3Tq492AxkJCmN7?=
 =?us-ascii?Q?snlOCa+Gpfovx6tAwa9N9WSowjvVApc1AH5S61xQLwt/R3r9VRP/E2/HbPU2?=
 =?us-ascii?Q?T8ksuiuYGpZZVyPyZYzqY0ZXLRMNES6ucvetUg3RBEuaqjItmTi3QaYcNrOj?=
 =?us-ascii?Q?p+CnwFd+SEY8X7x8xAtVrqTyT/PM+2QDnX4UT0MHej4yfZl1EU5tWo1z3dox?=
 =?us-ascii?Q?gL2j32o0/Bz/HcBAMNgWdmXcop3f+vo/JKjJBdNCiJwHkeJAOcHxp+iCKfit?=
 =?us-ascii?Q?s4dn91jGthoestqBH06LaQkva/69d1ZfapkWevkdxqGAmCa5LmDo6rcXKrA7?=
 =?us-ascii?Q?3+rg/J/i2nL5163kkeXtTBKDU0hHDyEhWsF5r2sSHnF8TlDxcfdhv7yKThJs?=
 =?us-ascii?Q?+p6/sUXnBP4pt3/j1nGaQcP3On8cio9SgtkmEZKykvuIcZTelbg17O4T3eKX?=
 =?us-ascii?Q?uhVFoq4G9Rmi5Qkv2i3fdEMDkp2jw3YZO2zfMYgdAskM2gQGwDGs5lpam1DU?=
 =?us-ascii?Q?hfZsKdaru50RkhEzkfYeEaQcn3JtvyWXZmyQPTU5R0/QOB1Rg85qgVy2VyXj?=
 =?us-ascii?Q?G3sHJDbr2y1jV2HCPb4TKvTFBACxg2ICCaCQGSqpAK5yHoGtb+W0UJDCjvMN?=
 =?us-ascii?Q?wQ0bYZ/5/xsZ4z/MkGfSzlwEFPasyGC/Vc9IDjp2mBLEOJEqm3J357gbkJDW?=
 =?us-ascii?Q?lPHY+o3X91EEKr3/F2kdDbDS5qi3UfiAQlFEdiG+atiH31QIyBWG24LAK9CZ?=
 =?us-ascii?Q?41GgqkhkdHhd1FhxU2rYHt3l0EwhPBHz8dHa0iE9gdGb/C/3rNprsvyPZfop?=
 =?us-ascii?Q?BEZmy4fRs4XHbh2sr/2go8pX+co38hVWKJHBqGWWkewvaIZeSdGz7swt8Af/?=
 =?us-ascii?Q?SnvP2g=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:56:31.8055 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7ba658-71db-4fee-8d79-08de5916690e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9541
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
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

smmuv3_cmdq_consume() is updated to return detailed errors via errp.

Although this is currently a no-op, it prepares the ground for accel
SMMUv3 specific command handling where proper error reporting will be
useful.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3.c | 67 +++++++++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 30 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 95d44f81ed..ade2b43ab8 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1279,7 +1279,7 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
     }
 }
 
-static int smmuv3_cmdq_consume(SMMUv3State *s)
+static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
 {
     SMMUState *bs = ARM_SMMU(s);
     SMMUCmdError cmd_error = SMMU_CERROR_NONE;
@@ -1547,42 +1547,44 @@ static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
 static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
                                uint64_t data, MemTxAttrs attrs)
 {
+    Error *local_err = NULL;
+
     switch (offset) {
     case A_CR0:
         s->cr[0] = data;
         s->cr0ack = data & ~SMMU_CR0_RESERVED;
         /* in case the command queue has been enabled */
-        smmuv3_cmdq_consume(s);
-        return MEMTX_OK;
+        smmuv3_cmdq_consume(s, &local_err);
+        break;
     case A_CR1:
         s->cr[1] = data;
-        return MEMTX_OK;
+        break;
     case A_CR2:
         s->cr[2] = data;
-        return MEMTX_OK;
+        break;
     case A_IRQ_CTRL:
         s->irq_ctrl = data;
-        return MEMTX_OK;
+        break;
     case A_GERRORN:
         smmuv3_write_gerrorn(s, data);
         /*
          * By acknowledging the CMDQ_ERR, SW may notify cmds can
          * be processed again
          */
-        smmuv3_cmdq_consume(s);
-        return MEMTX_OK;
+        smmuv3_cmdq_consume(s, &local_err);
+        break;
     case A_GERROR_IRQ_CFG0: /* 64b */
         s->gerror_irq_cfg0 = deposit64(s->gerror_irq_cfg0, 0, 32, data);
-        return MEMTX_OK;
+        break;
     case A_GERROR_IRQ_CFG0 + 4:
         s->gerror_irq_cfg0 = deposit64(s->gerror_irq_cfg0, 32, 32, data);
-        return MEMTX_OK;
+        break;
     case A_GERROR_IRQ_CFG1:
         s->gerror_irq_cfg1 = data;
-        return MEMTX_OK;
+        break;
     case A_GERROR_IRQ_CFG2:
         s->gerror_irq_cfg2 = data;
-        return MEMTX_OK;
+        break;
     case A_GBPA:
         /*
          * If UPDATE is not set, the write is ignored. This is the only
@@ -1592,71 +1594,76 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
             /* Ignore update bit as write is synchronous. */
             s->gbpa = data & ~R_GBPA_UPDATE_MASK;
         }
-        return MEMTX_OK;
+        break;
     case A_STRTAB_BASE: /* 64b */
         s->strtab_base = deposit64(s->strtab_base, 0, 32, data);
-        return MEMTX_OK;
+        break;
     case A_STRTAB_BASE + 4:
         s->strtab_base = deposit64(s->strtab_base, 32, 32, data);
-        return MEMTX_OK;
+        break;
     case A_STRTAB_BASE_CFG:
         s->strtab_base_cfg = data;
         if (FIELD_EX32(data, STRTAB_BASE_CFG, FMT) == 1) {
             s->sid_split = FIELD_EX32(data, STRTAB_BASE_CFG, SPLIT);
             s->features |= SMMU_FEATURE_2LVL_STE;
         }
-        return MEMTX_OK;
+        break;
     case A_CMDQ_BASE: /* 64b */
         s->cmdq.base = deposit64(s->cmdq.base, 0, 32, data);
         s->cmdq.log2size = extract64(s->cmdq.base, 0, 5);
         if (s->cmdq.log2size > SMMU_CMDQS) {
             s->cmdq.log2size = SMMU_CMDQS;
         }
-        return MEMTX_OK;
+        break;
     case A_CMDQ_BASE + 4: /* 64b */
         s->cmdq.base = deposit64(s->cmdq.base, 32, 32, data);
-        return MEMTX_OK;
+        break;
     case A_CMDQ_PROD:
         s->cmdq.prod = data;
-        smmuv3_cmdq_consume(s);
-        return MEMTX_OK;
+        smmuv3_cmdq_consume(s, &local_err);
+        break;
     case A_CMDQ_CONS:
         s->cmdq.cons = data;
-        return MEMTX_OK;
+        break;
     case A_EVENTQ_BASE: /* 64b */
         s->eventq.base = deposit64(s->eventq.base, 0, 32, data);
         s->eventq.log2size = extract64(s->eventq.base, 0, 5);
         if (s->eventq.log2size > SMMU_EVENTQS) {
             s->eventq.log2size = SMMU_EVENTQS;
         }
-        return MEMTX_OK;
+        break;
     case A_EVENTQ_BASE + 4:
         s->eventq.base = deposit64(s->eventq.base, 32, 32, data);
-        return MEMTX_OK;
+        break;
     case A_EVENTQ_PROD:
         s->eventq.prod = data;
-        return MEMTX_OK;
+        break;
     case A_EVENTQ_CONS:
         s->eventq.cons = data;
-        return MEMTX_OK;
+        break;
     case A_EVENTQ_IRQ_CFG0: /* 64b */
         s->eventq_irq_cfg0 = deposit64(s->eventq_irq_cfg0, 0, 32, data);
-        return MEMTX_OK;
+        break;
     case A_EVENTQ_IRQ_CFG0 + 4:
         s->eventq_irq_cfg0 = deposit64(s->eventq_irq_cfg0, 32, 32, data);
-        return MEMTX_OK;
+        break;
     case A_EVENTQ_IRQ_CFG1:
         s->eventq_irq_cfg1 = data;
-        return MEMTX_OK;
+        break;
     case A_EVENTQ_IRQ_CFG2:
         s->eventq_irq_cfg2 = data;
-        return MEMTX_OK;
+        break;
     default:
         qemu_log_mask(LOG_UNIMP,
                       "%s Unexpected 32-bit access to 0x%"PRIx64" (WI)\n",
                       __func__, offset);
-        return MEMTX_OK;
+        break;
     }
+
+    if (local_err) {
+        error_report_err(local_err);
+    }
+    return MEMTX_OK;
 }
 
 static MemTxResult smmu_write_mmio(void *opaque, hwaddr offset, uint64_t data,
-- 
2.43.0


