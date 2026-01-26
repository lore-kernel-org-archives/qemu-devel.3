Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85DACF65D6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 10:47:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkK74-00083N-6T; Mon, 26 Jan 2026 05:46:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK6X-0007Ot-Ln; Mon, 26 Jan 2026 05:46:05 -0500
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK6V-0005a3-Uv; Mon, 26 Jan 2026 05:45:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BkfAtSkZWV+BQ0rQvD2c5Hj5xVe4dZ8WHu88a7pBty27WbnegxHuiD4Jcw9nYaUOiFSICRT5vA9vl/8bSyNcIYyiallCikPZlSdeOx9L4YneJJydrRjn8X3XeJBpBG6cHqw5Nd0Osf92PqeN/uiVyePa2H6OKizc1Ce6w5eJNSN7kw0lA5+hoVMmALQOYbDUpi6qOCwEqxt0oLZ3Ag5QIqlMkSK7Z9Yi7wAsoPaySHHB9yQiHSPZyqk3RctWXKCRkPZejPUX+j1Fv90Ny0YXqun7fcOaamiIvjwnqL61NV8dTr494dfb4peItDrL8uoO0W1H4tIjyKShhxNVoGCkZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0sY8m+iCrT5Mwo3cqZZRZlXcXlfqszZJU5WClJnu0g=;
 b=fYR8fecWMDzyvzVul/Tn0N4ARxT02cuRy6IJ9uGhy8jLZ9+gfvDA02F80iNFe/qCgolWeKT5GPwhEFX/JQMoZ+oPEecb16qBjj+2uegmTCLVHylheeKUrXpPf09aBwAZ/AygiltoBBKyxLvOMS/tUWUn9o7oilzx3A8KOgSenFFNwpHtzW+NsESxWSJlyB8zCh98IHrBB9qHgI+bDGBun2iShOkvVt08UsUjfIknyg6gdR6LoIOPG2I6lA8V1UocJiQLQokGvUV08cako0y5xVWKUi7dOf5SRljgjw4F7902i6kVNoszqGECl4vRbMsTdr4uZcLV//ix5uln22W1mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0sY8m+iCrT5Mwo3cqZZRZlXcXlfqszZJU5WClJnu0g=;
 b=GTmdDUGTofJ/H9uAIZ8zbbbx5YFeueSq9FyHjrHKuvQZQzWd4Y+Od7ljQLLuUEzztIxHQ/yULXcSLU94LGE7lXSPYffJLrq0zPTilNylFk0Q4gzvzKa9bp9TEl4M0yksQlLQjMpfnZKAlHI22rDgNkpnspdnQcqoiHG2LQBjUVcuy6aiMweIY8KelSogvsLDJByNdYGws3qzgO0VCOiqNUztqRObohj2+daMv9JF7OrQgUEsCGRLpvGRSx6+1Z7Hr+lTBLzqj/dJhtqD2nVIaMbi94+1T4UGWIVUTlORn/OYlAoEjB91eLuIQIzWVai5vMSkv2mhnblUi8N0XdP9mA==
Received: from BL1PR13CA0023.namprd13.prod.outlook.com (2603:10b6:208:256::28)
 by BN5PR12MB9488.namprd12.prod.outlook.com (2603:10b6:408:2a9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 10:45:49 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::9c) by BL1PR13CA0023.outlook.office365.com
 (2603:10b6:208:256::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Mon,
 26 Jan 2026 10:45:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 10:45:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:45:34 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:45:28 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v9 13/37] hw/arm/smmuv3: propagate smmuv3_cmdq_consume()
 errors to caller
Date: Mon, 26 Jan 2026 10:43:10 +0000
Message-ID: <20260126104342.253965-14-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126104342.253965-1-skolothumtho@nvidia.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|BN5PR12MB9488:EE_
X-MS-Office365-Filtering-Correlation-Id: eb1d3972-a98b-45af-f870-08de5cc811a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|7416014|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9kWYSxzLwgOJuCU0gMpbr/P8iOyFr7KNz3iHfzeUjptbfIKM1ce39tloHB8B?=
 =?us-ascii?Q?bxWjeLmvQXXAda00h/tpkaF4fsd4vk+1EPtnIA9ahFx71uhDnmNQImTc+HRG?=
 =?us-ascii?Q?mntM/mmAwZ0JkUwU4WRutkyaY1ZeYAFhsqiCbJnefU66WpB0EteTN+4rrRd/?=
 =?us-ascii?Q?zuabrv/Up6Ac/U6s5YfAHe71H0Nq+OH+yXEhlbFjcH6u7PJ17aax/efaYCzp?=
 =?us-ascii?Q?aRCnYl9A2/VtDSTkHWMNVKz6bHia41ZKcto73qPqDMnuyzysfM4ad0Y3L55I?=
 =?us-ascii?Q?AtN4WnlN8wt0gKp5tzbGwm6CmNqvj35wwvVNIna6z9MqxON28T+iIIzTt9+J?=
 =?us-ascii?Q?0q7Ij2WYzCFj6P4ZsGPZNjvVRP7qNaBJfEMQKXAjHvYQyQBp8278yqM834BW?=
 =?us-ascii?Q?67CY+zVn0pD28oAaRsUjD4kA0BCxoDakaluJiIg7ZuVzmvbQj7ZlnTmbC1UY?=
 =?us-ascii?Q?ry+DfPTm49sElgNwlRohdqMUF+LgdQ00NCTKKXvR3x+vKw+TMHlHh3kjhTjM?=
 =?us-ascii?Q?QCszYByE0ukRaRRb3Zz/d8fp1QOzwq+g9RqZL2gXL2Eu2pbTrKnMTRP8+tLt?=
 =?us-ascii?Q?2IDJfAEZQFjLNUa7ozrCgwKkbAycZmnCoMa6TCEmvS5ytpYU/PrR2Nr5OkcK?=
 =?us-ascii?Q?zaaFfucs3DBqwq89wixGuClf4RHtQHC5bSwA/qANt3PchF92FRfITfCi5s0j?=
 =?us-ascii?Q?kQ9eSeKfIeb4Tv9j8giXPhgn3n8NX1AMBFDOUZzgpOGZApLP30Xhbi8s7z91?=
 =?us-ascii?Q?HYYwRW5Gi1YW1mj+89b6gOt5TRyYEcpxEQCNFVKMP1ebV1b0LJFNWO9PC88C?=
 =?us-ascii?Q?7eNtktHNjB3AG42iCcgtRMpMNzTggJfToWPjDw6KqksexWZ2t11eQ9lm7tm2?=
 =?us-ascii?Q?aE8BZywuTg8Z7LBR0RtE38Oznp0WH/LT8cWf35T1nl3OYRTrSmpjo8DnlMA1?=
 =?us-ascii?Q?C4RtwT+fYU0JfWK4w76uBNfFbUs8b90jWtPrGJtgv4WHNv3P2kq0hT7mxHmY?=
 =?us-ascii?Q?PnQUdvGynznSbEMWz9xch59jAMpPD0YGacXCXTn+lqcE7VF7vaXVjfdwhWKA?=
 =?us-ascii?Q?wEq/rikxKkqduGLA610cKAE8zxm8k0tA/fNIUJJRJpu6hLSmZ5JTmLByH/a8?=
 =?us-ascii?Q?iV7iXrhuNSTxJhc0q+qm0n7CRPdvAGallFseyH4RE/AdtLJ9Yz/ThK7ywYru?=
 =?us-ascii?Q?TAbq3BLumusTVImFo/LY1M8XlFjhT+2lErieMrotNuyJr5AroNwE5QOfNaK1?=
 =?us-ascii?Q?F+TyTO2dgvk6kjpx+SvaPhYJkwvfpa+XOTcvb+rsizKXiyHZrEjLgprK0B/z?=
 =?us-ascii?Q?eTqHYu6MnmUEUJYkpEvo880x/XyU7MlfNcTPqP+6IV/nzFz1kTO9OwL1nZv5?=
 =?us-ascii?Q?eBO+kcd7IpWL7f0uuobi52boGnpKOiVCBywAm0Nh9ujsMZLRycJubTcKI1is?=
 =?us-ascii?Q?K+sCLKL8/LcxNb+TZi0Cb2zXjtCQIlXeBb9jBDuBwha9bSULe5NDg65RNFz7?=
 =?us-ascii?Q?AGlqEAROdTwqNgtTZQZtEC39YBRDiNoAEDn39HZ6fSBeZYd9SsCyUQ3WS3ZE?=
 =?us-ascii?Q?45cGsYK1IkkxX/EqUmoYt6YcsCAvO1q2kS1RfV4AU0tkRLBOLyObOWcgUExI?=
 =?us-ascii?Q?lUyTOx/ol1LUAYkyfIp+roY9VCPzZNso7EJ/OrDlK5a8KJUXcZglhndr7bhO?=
 =?us-ascii?Q?giv8PA=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:45:49.0418 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb1d3972-a98b-45af-f870-08de5cc811a2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9488
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.587, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
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


