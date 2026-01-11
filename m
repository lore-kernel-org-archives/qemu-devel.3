Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5230DD2502E
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 19:58:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf1Ym-0007vS-4h; Sun, 11 Jan 2026 14:57:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1Yf-0007U9-8n; Sun, 11 Jan 2026 14:57:05 -0500
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1Yd-0003uU-Gx; Sun, 11 Jan 2026 14:57:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BahqJUFTthTlH3KNq7bxS6AXhH6pxLUsqjYeTFKQSq7pHfl5OyIpyJRugDEKzaP5mxHbZc7/kvcYLNDsQEfTlnRyYqZUrC88PcYkU+xpgKS6Brw54EiPPaj6HCLuXowYPPrPKDBN10URTmioqsybrPW/kCxAPcxQM2e06n8NxK2GdibLq/58rqg7v/Ix5o9lCkpfaL4GrxqNtbUqofjJUL7yCc34vVy3TCPFeynBNpKfCbTd6DJtFNiDRi0kTMe+l4leBHu5/vEyYLe4n4mnNe0zAlpxCm48d3byX3XhK3s15R8ojILZCddFdla5CuAzuIOw3INXCHWQ9ROFL+4nsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OPuzuoKWTUQMBk2Ru4JbYkjA1XoNfXHvGYXKBptxA8=;
 b=k1d2DF/gQEpf29aHIXYH61o1CAXekDO9Pez7bB1DLKUd6Ww5LJ7LOsMxNuh/hqOKRmY+9sH+U84K1KcsT/QxCDa77kCa/0ei0RqSFBOxDTmkFPY90ZbmBAhXXMpmalJbkVbuw3a7TBVB8Zz8jKnzne4sE0TL4TKj4NxpPnUcwzy4hmtO1klgMmWBjh+M1JjhnCgnMD9A4l+ot6JFP++pCykMWbCW5EPud3uFsGSG/L9RraYt3Ab3rDGpYTx2EYu16SBlyze+AbrWASB4ak56o4uRhOWY4qSc0NDltyUFEWBQNIXbPdvduyWVZuBXymNgkbEkFXMP7Fk7LUR5LYMQYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OPuzuoKWTUQMBk2Ru4JbYkjA1XoNfXHvGYXKBptxA8=;
 b=lT9tQuGZVN0qt7JEwetphYLxqq8tVDu4jFr1R4JBWN6bkdMDJInYysyA6whoDFVgDOt7atjd6n1GIbYIUOCUxB+xGiQ0EbB11kDCnLdDZlEBhzfZFoqSZpZgZmet3JSxG5figznK5eJF6UdeUyRnT834vFkmSNRIwyfZ8X4RE4otBWIAiML7EWPTYzaHyfV/0UyJOZBk+Bx6LSjE2g7i2d6fF2E7p8GDPMK3CDIpk+m/Gws/8tloMOJW4SM/IyxK7Czcszpc0M0z+efp/UGrjVkmQOeJd1D4NFh+obc5JNodXgDqk36Z6kJ8RscZwIYOLZPjnfC7nCXXoB7ub7idxw==
Received: from SA9PR13CA0125.namprd13.prod.outlook.com (2603:10b6:806:27::10)
 by MN2PR12MB4437.namprd12.prod.outlook.com (2603:10b6:208:26f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sun, 11 Jan
 2026 19:56:57 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com (2603:10b6:806:27::4)
 by SA9PR13CA0125.outlook.office365.com (2603:10b6:806:27::10) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4
 via Frontend Transport; Sun, 11 Jan 2026 19:56:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 19:56:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:56:47 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:56:43 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>
Subject: [PATCH v7 12/36] hw/arm/smmuv3: propagate smmuv3_cmdq_consume()
 errors to caller
Date: Sun, 11 Jan 2026 19:52:58 +0000
Message-ID: <20260111195508.106943-13-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111195508.106943-1-skolothumtho@nvidia.com>
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|MN2PR12MB4437:EE_
X-MS-Office365-Filtering-Correlation-Id: 80c6114d-ee7d-4146-9172-08de514b9370
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|7416014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RzAbVX7ovyG1Qhepp+f5w21b1uH03RmauEHGZYLisGmDNHrhNVhITru/rkiU?=
 =?us-ascii?Q?bR6+VokBCWQNF+xUDRM/MoFqkjNE0GJgwfvGwQbH7CyYP1q+9ncaXy0Xm8FT?=
 =?us-ascii?Q?X2MLI/bKqpPeG2RPxBlaAG+4n7y/fiXL8HsCs28s0+d591NOOliXW4JBzZ4K?=
 =?us-ascii?Q?G11CIMM6xxMNnG+0vZOcwkV1PIC0pk/0/tvKOwePYV25IfoGEmg4s9hEnsLC?=
 =?us-ascii?Q?2yjhqbueXzpDkAvWO8T+GiqsIrqCzLvhk2Y6PZR2HCwEVkcMq/STa8HeYt5a?=
 =?us-ascii?Q?BjXY1/qDTCqBf+kwI3LkFx1nh9OMrMKKAM+8FGXlnEBx6Xet9j1dx6oYTFOw?=
 =?us-ascii?Q?juh9NBCU+8d8lW4zqW045GQ55gn8JEK24AuM1iMdmhoUxFMf/7uYe1uAHAbz?=
 =?us-ascii?Q?4oxl9CsuoFah6RLHIyD38g+s3aa32nEnwTTWXEs0zluMiOCYxogxo9tAUW9n?=
 =?us-ascii?Q?UAfFTbhl/aAJHCy/LUxlePAs+1agCkdjdHWwOIeW2rRqQhdvTMb5wRdAAIBO?=
 =?us-ascii?Q?B7Ak9bxZKkdRBmVeSIzMMTo47XUBPXp4RuI8NjAeGTc96JjiirNtvi278xpQ?=
 =?us-ascii?Q?uIKvJYe7gttqbt/c/1bnDBCUbopp48N0+zuu3NwWEc0tBIxT9encWtZOShmQ?=
 =?us-ascii?Q?iPVV4fWvCOyjSZwPQDQtC4gBtgs3TtBf14HVf+cmELic4do1wDmMuwOgIy2i?=
 =?us-ascii?Q?Ad/Mv6xr8fW15GH39310hp2T4TSyoLo05yPSv/s+LWT8Kcdq/BSq+8VKE75F?=
 =?us-ascii?Q?RLSAhfZfZ4v0aPElTZGXyhJjpbrIfcoOF+HQyxJavg4/m+0kqKpsN1Q/o8kS?=
 =?us-ascii?Q?1LDfur/7EjvTvtHxx2GBxr5GrtrPuN4PKPbqUWaEuQ/+WNUEtNkewzf/d0tN?=
 =?us-ascii?Q?XwGZQXUiXiWq/0cJxuCoHATYwXF4O/RDmZ1Y7oX3Z54nxToRV27+Vr+u7d+p?=
 =?us-ascii?Q?pxUxnoMeUhZy9wy6bboKWadbva+6jWrVRHgiRg/+5f7mIGeo0KK5YJVbCBQL?=
 =?us-ascii?Q?Vpc7DoTuntZ/9nA+tzW6b+kD8MfN84wQT1cIVTFQ18Bk/GFicua78Bm/GFEk?=
 =?us-ascii?Q?3ixoIno1T9N+zs8PBu/AUESzqmcRFECPv3aFJ8lG/jdiCk3OtK9mUSf9fWxd?=
 =?us-ascii?Q?QT6kKZsunzxhsgrpM8SanCQFyyAeemCu/wcK0qCUD+VcfhuZhYRhOO6X1ceX?=
 =?us-ascii?Q?PKsuwUz4iOMnNogJPCKbENviN13MpKUeTJ+VlUwtmByuEEa+uFRtYoiBMs0U?=
 =?us-ascii?Q?ZaSr8RJy4w+bsQ7EB6jeM+As8XOBR/OGUBczn5swrCPKerVekB2rL3wCNBEm?=
 =?us-ascii?Q?3sOpvIRPDB67WAU7RGwyvG/oE7frAHYzAAVzwYz2FEHICZysfDqxdQD/iA0M?=
 =?us-ascii?Q?wq07N75l6T6kJgr7i3RbRqzlRZJ6DPYsjVqJyUyTRrljWcveXCRUiM8+34yv?=
 =?us-ascii?Q?ixTAyIE5V+4jhYq2eeczYTS1PeWvwx6KFFPBq7d5a1OE1R4SG0drb76N6lI0?=
 =?us-ascii?Q?hNp6VkveNnv9EyBHMvKBW0n9Ax3pm1VP9klEZvcw65MMz6gAf5mqpi7bmuKF?=
 =?us-ascii?Q?hziLPhqb4lUqyQDNqn4=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 19:56:56.9751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c6114d-ee7d-4146-9172-08de514b9370
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4437
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
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


