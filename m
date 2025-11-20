Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E0BACF8859
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 13:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM4en-0007TR-Ea; Thu, 20 Nov 2025 08:25:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4ek-0007N0-Dm; Thu, 20 Nov 2025 08:25:02 -0500
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4ei-0002NN-Sr; Thu, 20 Nov 2025 08:25:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XlqaTevlh3knepBbKgoUiCbaWa3tj9l/a75tZ/x7frU+F0S/R0hcudHALT1cOsuyu3Qo1ZrG9tI00oJEAg35uIXQsjZdBhIQddijdaKhFYJbC3GMPA0TGhmtiPhxpKL3sdGhtrOGsyOnzDvfsarHgSs87wexwFOF0ydcgsrnrlcFgNRSlpCMUEDZIPMgK8ys1evBkCApZuZDAHttG8zS7r/ytS6BBo68xK5GN1Dvi2RX1zuIHl5OkRh9akCEo7A1niPsCWsULLbtj/qmGt5FTAotwJePIWwHj8yOX54J+3KKlrM1uVsXhuKNOqSrk7BnHUaRvp78yiFQBxXxBmRQJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4R84anKneIvg4GJsB3I0hhRoO4dEMc0+mAYtJX5EH4=;
 b=j7fak4ESret3WBjwVNlwAAfegEi5TmqeImnfCAHbexhS4PygF4x1jLxrk4DLkb5SMQkSHysRdz83D/hVHg3rIEezC7TFrTDTrUauhI4U6fPvJPpHGdk/7TxvPyTIx6dXEYPFhM+K3qUwXQdMiUvhJP3WlPdJaDrKZqu98NF/j6XGxRAztD+TbxzVBCrtjUDjYdoha4s16C9CAiBcPAbWAJvZYLXBoj491S9Or5qieZ6je6xh6+v5xdkdR3sKUjazR53DBQmtle3yS6xwc0GeFYBd0ZHuJk2Cf5jZnKEs1zV/nz0EwhHH/u21dvaFR0s44AaVie2U0TxlgCPLPuUofw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4R84anKneIvg4GJsB3I0hhRoO4dEMc0+mAYtJX5EH4=;
 b=DNn9iJAWxGk2RscUBX8fTeHWdRGqhTAwhZ32zw7vYwTERyxeB89pXyDUt+BVF4VJwoux1M+7nAsBIGBIMtsR9nCUg4EwQGU1o5MgdE7yTCfin6ft3X4Y9pdgEhKIiw+Drxfp0YHpjNNKPFIafX0yh9rrVPO/pWM9+Emi+cVoOIAUMU9CMeO2uCcArd7QbgtELPY/VCw1EvgxkBQurd1Sk58hCa+RJYk8XT5TYrUH/YGOGGyHJsjnZ6BLSapaz9nnAvTV4XTa/Xg9n6KcVSE8uGeqEakfr/rrbioNZgxD5rESf1ULqmMcPap4CIcRIBXxWx5YyUYTZ/IkTHs+Q6QHzA==
Received: from CH3P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::19)
 by IA0PR12MB7626.namprd12.prod.outlook.com (2603:10b6:208:438::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 13:24:52 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::38) by CH3P220CA0008.outlook.office365.com
 (2603:10b6:610:1e8::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 13:24:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:24:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:24:40 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:24:37 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v6 19/33] hw/arm/smmuv3: Initialize ID registers early during
 realize()
Date: Thu, 20 Nov 2025 13:21:59 +0000
Message-ID: <20251120132213.56581-20-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|IA0PR12MB7626:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d5f4c18-e934-4344-2213-08de2838304a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?knNwwZX3MiI75sE9EY/SO3o7kPbu/isZJfTs2nhl9zgXhaPv+TulYOsxy7Sq?=
 =?us-ascii?Q?8NKuLEAmzRVZaL2iEvn2K8b/i6VMGtzXbBGU5kZaOZ33mAUR2JM/GtP7/1Z/?=
 =?us-ascii?Q?hdY0X5jsqDRrdV9+l1jYx/NFu4c7Bge/K+CdybfhwCocmECfrO8SrWZYXrlH?=
 =?us-ascii?Q?TbyKPCN6y+mARB9QEfG2MM8TPYZ57Jd+xqx3DEyyRSFbweGeom5vvW9agCPt?=
 =?us-ascii?Q?/eQRvEMoLJEOccJJ6zpLp8gMzWKLQ2kD4lcVubrasX+NLhIWKTmDDyNf8J7w?=
 =?us-ascii?Q?btYS8drEeReCypG5iuXtyzoIQvFEz5gdr/x0Kt4HdNbH0abpIu6KGGq17hM8?=
 =?us-ascii?Q?8B8VlemYfpT/vId0zjM10Hdi8JncimIQx4YRdFsaQ7CyF33z1ve8V5YPCkSK?=
 =?us-ascii?Q?sAHBNvt133UGdYSIemFKZWlGMlCiV73ggEjbzq+42Pv/H2gkGRxQB+Gf3b/x?=
 =?us-ascii?Q?FiMAMRLBwKmxqw1ySbTAdJ9qFKWdB05vDasR9/ks1D2AAEyDVJtUJ+Vz3IFU?=
 =?us-ascii?Q?7omN2uYOtOsVkOm0+WosNDsjgTgbzcEkSC68qUjvDLH/G7uLSTokGuCAqomx?=
 =?us-ascii?Q?AWfSjcq2gxzVNx3W+AE7AaFPNMcxtLZ+T+pYoeJu2NuxYJrcV3MFRfPHhYBT?=
 =?us-ascii?Q?Z+PnCbl9io6qziAryZbNeLvZQwyVhxgIM3mTSrCLuYQ5/7+Lmzr0ZaIU0rOM?=
 =?us-ascii?Q?4Wkc8Zpq6ouu5RXcOqXYch9YWPvTgeLE2WAJEQgww6ZbRh3CDZREffa4H0Z4?=
 =?us-ascii?Q?4l+KaYuMbQxBEufKjp7J+reBgvOY8fQxfueI5k3s3rsKWNjFnDwflCLyLEpA?=
 =?us-ascii?Q?V+ZkpSW6dFAmg6GmSCJWee9fxT4tufRGgxAtpmRdMjII1Ru2Pp9ISR7D+cuW?=
 =?us-ascii?Q?BQGrRufjpwRdrd5lmv+RIdsLT7v5//Ry2hPD+yzBXqqc1YSTUnRXG26vFF9I?=
 =?us-ascii?Q?QEmqksLhHc1LqguBfcxd70EluUl8oNW/7tzSbSKoV5HsV+hlW6HG1UvpQFy8?=
 =?us-ascii?Q?Z59DoSyiqq/UBtDiHxDHpmr8wQ+XD4ie08qFVtsDUTaGFAd2IqKwNA5E/a3a?=
 =?us-ascii?Q?cw7eUGSIk8CdgclHEJX6z6/6xgnky2Re5MM5Ee8MCT2DeeZ+t9A/rm1/jbH0?=
 =?us-ascii?Q?Gy2CQ7kqdYLWD8ThvZcTKw9h56J9G6n7CPxUBTm87+SOQxLTGFzKN1DxJ3R1?=
 =?us-ascii?Q?RsFG0eCZ41Lw2rjqcJjvNRvaRvaFPAK3FNWrzhpccFnMj9VlWwOUlQS5MrKZ?=
 =?us-ascii?Q?amQ8+0/j+y4UNFoRlZqaZ6kdyZsoZiA2uelzfFHldpSiDn/o0F09+Jdd+1u2?=
 =?us-ascii?Q?PG3dM3CtlNc8D4JPBNiwKXBJroBJqZocaqB4XRogE+7hHIPodf8qeiDKH4jB?=
 =?us-ascii?Q?GOSSDvotp6DQD9LtxwxfJphGA2OdFO45sYZ/1skNl7aA75ZCR0tImzFuqm6t?=
 =?us-ascii?Q?FXPPhrpgGpkLEzVLEtjsp6e3GAnO3jDFvSVrwR8Qn5X2dj4huCRcjSP4VZTD?=
 =?us-ascii?Q?8aeuzN7VVpcfeoUlzAYzDPCH3nRtbuWK6WIsnmY0ymg4wmW5rQdOOxfpXl5n?=
 =?us-ascii?Q?OQVIZrR4QUQ+WXqaRgg=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:24:52.5032 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d5f4c18-e934-4344-2213-08de2838304a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7626
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
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

Factor out ID register init into smmuv3_init_id_regs() and call it from
realize(). This ensures ID registers are initialized early for use in the
accelerated SMMUv3 path and will be utilized in subsequent patch.

Other registers remain initialized in smmuv3_reset().

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 513da966a4..dba5abc8d3 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -258,7 +258,12 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
     info->recorded = true;
 }
 
-static void smmuv3_init_regs(SMMUv3State *s)
+/*
+ * Called during realize(), as the ID registers will be accessed early in the
+ * SMMUv3 accel path for feature compatibility checks. The remaining registers
+ * are initialized later in smmuv3_reset().
+ */
+static void smmuv3_init_id_regs(SMMUv3State *s)
 {
     /* Based on sys property, the stages supported in smmu will be advertised.*/
     if (s->stage && !strcmp("2", s->stage)) {
@@ -298,7 +303,11 @@ static void smmuv3_init_regs(SMMUv3State *s)
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN4K, 1);
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN16K, 1);
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN64K, 1);
+    s->aidr = 0x1;
+}
 
+static void smmuv3_reset(SMMUv3State *s)
+{
     s->cmdq.base = deposit64(s->cmdq.base, 0, 5, SMMU_CMDQS);
     s->cmdq.prod = 0;
     s->cmdq.cons = 0;
@@ -310,7 +319,6 @@ static void smmuv3_init_regs(SMMUv3State *s)
 
     s->features = 0;
     s->sid_split = 0;
-    s->aidr = 0x1;
     s->cr[0] = 0;
     s->cr0ack = 0;
     s->irq_ctrl = 0;
@@ -1903,7 +1911,7 @@ static void smmu_reset_exit(Object *obj, ResetType type)
         c->parent_phases.exit(obj, type);
     }
 
-    smmuv3_init_regs(s);
+    smmuv3_reset(s);
     smmuv3_accel_reset(s);
 }
 
@@ -1935,6 +1943,7 @@ static void smmu_realize(DeviceState *d, Error **errp)
     sysbus_init_mmio(dev, &sys->iomem);
 
     smmu_init_irq(s, dev);
+    smmuv3_init_id_regs(s);
 }
 
 static const VMStateDescription vmstate_smmuv3_queue = {
-- 
2.43.0


