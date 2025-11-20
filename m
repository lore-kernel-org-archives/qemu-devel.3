Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63577CF8859
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 13:25:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM4ec-0006zN-GK; Thu, 20 Nov 2025 08:24:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4eQ-0006jT-2d; Thu, 20 Nov 2025 08:24:46 -0500
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4eN-0002KY-Dt; Thu, 20 Nov 2025 08:24:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWzNVzUGFzMmyiUoNXxgvzLURfaUy1GRYtmMbzPhWU4nBS5DSQWcN/4WB1y6bZolRN+6tvnjFF/OXYR4bwC4t6bs4KWVgBt3PTqi9Yu9DmikioNWvWpOK1ZiViaIS8Us7x6vm3+WVC9zrLusqIRLxi1KPJk/JQmLdmokKh72Ac+5zjwbvWTkZgGFVBorFruduBTrssyipDaxQ/cz1ApQ0Ix1UGdx+Zg5e8KOIlA4VCU1Q8EOfY/qvY9B5nT/BlnGR+pZcrcyPPflSstKuQBgiNc5ibQatWbg2n0jwAzVdbe7IVhedzaA8R07Gn0pTWjLhceVp2KNYDE9y6rhzcZYFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nT2h1AF9uinuiH777NFWjRC5ErErzWSBcc+gq64aArM=;
 b=PcMLvZqoXYDIWfHMEDS4nRsGs5TBrqcc+W4KXlUWAUeFWnt/HIFRWHUR9piMqQYEk3JG/VbaQsKMC3vf14NyHHr21/BVNhFs8l4oocABEUlbA/WLGTGGi5Ng/uQ2dHlzfdBZ7BFLmCLfKbusOvtYKIoh2qSZELie5rpbVl4YaUrf4/FKoOLfemwDmjri7VEEhGwDChHK3yhGDfC1lyuBeE9l2rXpuKvl5lfHRQlHvxhXnliYqUZ1C977bmL/CJMNrQMKlwOW+ZMQXr1gu1GKI2TmlQ4+m6iaQ+AgTrFXyS8rDIpDhhkTDDSl+R1oR+Z6qvMuybRKGJPb39BRZsQmhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nT2h1AF9uinuiH777NFWjRC5ErErzWSBcc+gq64aArM=;
 b=PFUkW+g1Ad9piP97PIID99AkagfxtS/rOURAmrFKmhC8le4s0Y2K6ylSGfhvOUPmeaRUsM/wBssDJnjdvL47Ui+x2XyWtFbJm9jxLOPDLJVevsLzElCASmd0yc7EdswKWWaeyXpOQBSVSdhwLvf4TRlgAt5zfXkF4qwHuPiAUL5EpGeJImtYTXx0k0CpYnmNVdv3GqxL0JxxMoVykQlazp3umvp2aeXcfqE3XLEjqoc6buqzpIsHZpByRlcpFjOYuwKjBrGFtDDaovx2Q9IsmMQdbE/BaTy7Ue/Kj1J2m+PzkjecI7esiemm6VSsOpSs7Okm2HW4SA2psApBAEAK1g==
Received: from BY3PR10CA0012.namprd10.prod.outlook.com (2603:10b6:a03:255::17)
 by DS0PR12MB7747.namprd12.prod.outlook.com (2603:10b6:8:138::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 13:24:32 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::24) by BY3PR10CA0012.outlook.office365.com
 (2603:10b6:a03:255::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 13:24:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:24:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:24:13 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:24:09 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v6 13/33] hw/arm/smmuv3: propagate smmuv3_cmdq_consume()
 errors to caller
Date: Thu, 20 Nov 2025 13:21:53 +0000
Message-ID: <20251120132213.56581-14-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120132213.56581-1-skolothumtho@nvidia.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|DS0PR12MB7747:EE_
X-MS-Office365-Filtering-Correlation-Id: d09df552-3444-4b25-8717-08de283823e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|7416014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W5jNCtEnznjPrUy9kD+7cyUSi1bQOYyK84RfEjauDLAwlcL5uz80JCYRqJs2?=
 =?us-ascii?Q?5+ZcRDphhEtAdBiV2PT583Ceu+f0fUq6To9MLedSD4FK9x3n6pwX/tCckkjI?=
 =?us-ascii?Q?jfLHDuUgW18K85w20sCuBp6Pn+HY1i1yyzwpuqw0CAZg9QKx0uRfR1x82QS5?=
 =?us-ascii?Q?oI51mtufMgiH0vp1Rcau4+6vOsyNs/QNbMXcROj4K2W+Zf4oTUr63DxEM/64?=
 =?us-ascii?Q?eAYPCeoMjLIQ+C3TRHapvwU+Gd344HC53nYoNyvqfHA3uM2RYRkbBO+TAuae?=
 =?us-ascii?Q?EjhziF7UT59Pve9ZNfhdrNhlptz7iabmjyjIXtFTQ3B3Q6ftT+O/iAFor5gC?=
 =?us-ascii?Q?VAzu1vzV3eG1BGHNgEBVRngOVqISxDhM7tvkIs+wmPRjyFgV3w6LjvH+UtRm?=
 =?us-ascii?Q?vx1v/OvZkfZzEgFJtSS2XRjhIGF0sDRP6GMRK5G1dodB6Jkyw+G/GEO90Ivc?=
 =?us-ascii?Q?b5ndPr+VrZC5x3q6Mreg+oCoweRYOLfXxAb5zOwspULPNqoc8gjbmga4tCVz?=
 =?us-ascii?Q?QAXHc//OS1YJsjP1GogGd/gBvvjdTpEmUf+RWUOMBtU+k0J/3e2U5/AYN7hn?=
 =?us-ascii?Q?gcCsti1HC7wZ7l3ipMZ7sYvW+3+zxMkZO71348eWmi0Teql/r94zH0aCS12F?=
 =?us-ascii?Q?6Cs8GI5ZnaugZvE1o0zh3Vhu88Ji2UhsJbOden115cpk25nwrmZ3orAw1c80?=
 =?us-ascii?Q?sX9qbTepkoAnLDzYqlXHAru9rub2zZ3D2H1X70hAr3ozkLI7R0uJDrs8sVHD?=
 =?us-ascii?Q?gjqM3+W+fQ/5mmouaNhJr0jOSLgnVEVbgHIvV78tCxArbDwkcqgXOMEAF7o1?=
 =?us-ascii?Q?9uJOZRx7oiL+WCgEnfwsftioYVbYkgxgVCVR5US/9fp/dtpCyOqeJAH/G9QU?=
 =?us-ascii?Q?cp2YRMRm3PPtsLM31K7fR8wUz/tv+PMecyRX08b8vRcUe4G83LQDNLPMmOPh?=
 =?us-ascii?Q?+/NhbLPI6oreu60fYuizbrPLA93RvfLT6+lEgRq2dfxgMUz+fQFPpn2zTLHG?=
 =?us-ascii?Q?afp0r/MgT+wSK1rHvmY18C3BEXJ6htPJx5eqbmKganpRvEX0wsXojvCXmAzW?=
 =?us-ascii?Q?jGUK3BnvNewrqH1iJd7xH+AaSTow51MVuYx1QZdbzdXYgMw1RMlH24gT8czi?=
 =?us-ascii?Q?rA7RQU9wpU1hd8uvc23oD70DqPhlNOL87QKSkxbO0M0lFLIP8OeAwoX4wclT?=
 =?us-ascii?Q?9H7JJIH90Ri05YV0EEhcRvorrXQXlhDJUulLSok2VJFrBsM0sn2mPjuohBIW?=
 =?us-ascii?Q?Wu2vmxgQIdrUI9Qv0Zw8gU1arWbdgbZKlsNesARLT10+d+L4ww9Ky5JITMUd?=
 =?us-ascii?Q?BE9pfMR1wkLmKA8LNUPgCA7NKj2wcY1Yshz6MYIDV45NqESxaAW+3h5Se3c7?=
 =?us-ascii?Q?SgJHlsc/KUET1bEoT2tS84M03u79Wani6HbxBmtL8XoUxynu1kue/+NumPaW?=
 =?us-ascii?Q?Rj1GwLZos3yQmAUyBpVvh42wE50RyYDaV5kf7M+FxMT8jRdzGUafTYLu45oL?=
 =?us-ascii?Q?g5i58cdxEGqWXD9x0d4vqC6JH5Sv2MOpcQ9MmAuorm245AvvQOyDLg3kyEwN?=
 =?us-ascii?Q?vv3NJqgzkAhEqxBRkcY=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:24:31.7768 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d09df552-3444-4b25-8717-08de283823e7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7747
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3.c | 67 +++++++++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 30 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index ef991cb7d8..374ae08baa 100644
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


