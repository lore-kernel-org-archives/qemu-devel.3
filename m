Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B93F8CCF9FE
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 10:55:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEmml-00070i-6f; Fri, 31 Oct 2025 06:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmlt-0004bP-1l; Fri, 31 Oct 2025 06:54:19 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmlo-0002zi-T6; Fri, 31 Oct 2025 06:54:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KdDsSrG/Mztal2lKG9f0O9l2KhqoyweXOGBkNoz0US4NSUaI5UnH5K7bfRnfnYdG30qVFkdmvIHB3dY7pUkzgkf9vJYRBh8NaUEompdmZ8WVLfpuCT2qKCX+4zM3uh4suzywozRxz26cOnUfit1nTZ1hspN4xo6bfR44NySH3BK8twF5hk/qkuFkVqB+NvDN85Gq81NQnKXTJ5kCeXBgF7D5sEpe+aAxlXou3pdyCeKXrWpL7EqhAKq6QgzLhKBCh+GQ1rUy/LwPZp8TlSb/Lxwyx5VzFLsokbZzRvygsudj5XqjL9HThUWOm8fUlgkRMo/XunX/KIqs9hKJytjAQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1564gZWsiX8wsj62jsFc/NIGNl9IxdjAXWZ7sqBwtA=;
 b=nhh+QMjvFMN+xQF0EF2I3ZplpA3m6fmHQdFHRVPoS5R2SEV0pnIUDp3Zd6PAVNSHQPedYxvGhE7ViW5TAtph4EyVRzE7klYEKMdS9m1Q0RLmfin7veXVuq3Wki++0wWQu+Ha0gX/Mo32OU+OomagIU5eq8xL7/6OJnQLj+cos8ZWh5Jnx5WXvpp5LJGX1SB9DuMrwh7nnj5dQYFf2FCr1lmS+v7SMTwEQmf4I/zr6ZW3vejy13BJU+EsI+tOhdYKE5cuNzgdP1+EASwxPF+4r22mn5AgCgsgitRjq1OKMTNymUcJa1tvBSLMmb6S+UquENHQNF3gvzsepQPqJfliVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1564gZWsiX8wsj62jsFc/NIGNl9IxdjAXWZ7sqBwtA=;
 b=XaolbOgP3VIjlFU6xW9VkdsPE+IvQ8TkPGHzzi7/XCNlvHVTN+m64CJBdgVGMf80wIgnRuV+EgL+US3AOwGVg92R7utuV/OiLyL1aQacxcErlu35HYc6bfJOWEI7QhvDM8VGIR8rSIixZE4V+c8WFOhbv0jtwRA6MbfNwsixXpnJm8v7R1OIKOH+pYMZtl1gHWVwTvFEZynJK3VD7kCj8QljSbGaUhUXQ2s9L31tZy9y4hMr7yZphx6uGZ76sXSyDPRvZ0ofAiqZRDZESMS50VMwvUfQNz2Sf8K/uqD9ih6UILnrdTEUKCUR5pT1Q1MiVk16FEErsOapR7yYJ8tyQA==
Received: from BLAPR03CA0178.namprd03.prod.outlook.com (2603:10b6:208:32f::32)
 by SN7PR12MB6790.namprd12.prod.outlook.com (2603:10b6:806:269::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Fri, 31 Oct
 2025 10:54:06 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:32f:cafe::b) by BLAPR03CA0178.outlook.office365.com
 (2603:10b6:208:32f::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 10:53:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 10:54:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:53:57 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:53:54 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v5 18/32] hw/arm/smmuv3: Initialize ID registers early during
 realize()
Date: Fri, 31 Oct 2025 10:49:51 +0000
Message-ID: <20251031105005.24618-19-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031105005.24618-1-skolothumtho@nvidia.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|SN7PR12MB6790:EE_
X-MS-Office365-Filtering-Correlation-Id: a696c65b-18b6-46e6-0716-08de186bcfa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s7oL04oeZNQP1tG3PIJ482WGciAW3wNmUVr6Z8OEjphFLXVyY+LBm9zrJIYq?=
 =?us-ascii?Q?gLaeCS5hXZCSJcExwrfoSmsmxhDJOCxOpcHUuSYWq3ctEA1S+4RpI7rZk3PB?=
 =?us-ascii?Q?9J6Wheghq8Mpxra5fjcwv69tPCHZsxUwl5g18V7JHy0WbAY6YT7GHMKvbH5w?=
 =?us-ascii?Q?isPePRsVDFcoCah5EFpJ41wKk+g5Bx37sBXJqB0DUatu2rtQ3SOxbVKC3iyg?=
 =?us-ascii?Q?g65rei7itu9umqLgLLc+qjjjWB49I92/e/27lXIPF/FuiSddzUAF4meY+tf2?=
 =?us-ascii?Q?UQ2Cx7Tl2BnbcmWa1sGETtaLwi3pAL2n+96mRazLvjb/KvuE6n5pZIJ74Amq?=
 =?us-ascii?Q?30Rd3a//BuWtlFtDacu2c5lDRiIO+kXnKAhr3zOyC/PvEvWhcKvmV49S4JDI?=
 =?us-ascii?Q?8I6SzmooW0y17XnsPYKkVm4ARmB9Z3DzF7405H/JX6blv9H4uRLGbH5C5mnA?=
 =?us-ascii?Q?PmJiEY7WgRzlwegJT0ARDvOtZ/csF5gUpFEc4HY/1a7fXnsknEr3iGZ16D8f?=
 =?us-ascii?Q?FWzOx+BU+HKIExwb4ObuXK77RlFoB2SzmmqXckCZXblGLhI/UKuJaOqvT+kN?=
 =?us-ascii?Q?B5JF1hI4DarCm9rkpg9+RdQBbAXSlReoaXbf9ey6ua+5c+ruVlDYGjw2e0sC?=
 =?us-ascii?Q?FWUTk+ackMIVqtfNEJNW6bZ1ejlxa8FrfCQoyIXb7e6IY8lHCAP/sUnyO56t?=
 =?us-ascii?Q?nxsZivB52T/2WVQc2XuaRlC1uFAxQroJVvCkFX06pqdFbX+TnJx8tbkPW7Dg?=
 =?us-ascii?Q?tpZzTPnXL1k97t3c3m+GS+h3u2go5uQhrM6sj/hn898PykgFEibmHr3UIkvH?=
 =?us-ascii?Q?wVy5KkCEQny6/EWJrG7E2qHjTPANleHs+6O9/qJ10DdwB1BGNPeU3TMX8CQj?=
 =?us-ascii?Q?8wXlLwcdzKI97WRqJo0Ff9ds3BgUh2Az6WOQaZrJS/RPddTv7WaqAS9s35bq?=
 =?us-ascii?Q?l2HtY/Cuug3/bEzKFvw8hlfJ97P6xrwqO4RFNwJ2x4vfrgaYkcSt3oJvnlKC?=
 =?us-ascii?Q?dJkGDbjsq0A5S9/uCTOURoZQaA+h1RuwXVFi68UXSpwoqp/OD04fgDyODh3F?=
 =?us-ascii?Q?60yn+EkVkmTAhqYzzZBiW9wnc/zWkzOM68ES+9XDz+MVkP4aXk2dDuJ2v5Ck?=
 =?us-ascii?Q?W/27n39/d/vhaU6ep4wWxqVJLS0H3APzFWOoP4NmDdaKiX/nUOIErJM9RQok?=
 =?us-ascii?Q?MSx/s9Uq+JYWE3Erva/Pi2zywUR6gxUQ736SFRgRTLy1fbYeXNmMpFINiaB0?=
 =?us-ascii?Q?EYmNKcH8fuj3aoMUGOsjd/a6mEahHeOtQNzdKnUz3RP/FelggkLI2MH4CN+e?=
 =?us-ascii?Q?CcIyE7D8sRyZD/k+qyCHPzEniYGZBiPbGCl4SXUMXavQ0ELFLVS1wtKq0TLu?=
 =?us-ascii?Q?R9/6UrK5RjnulJU/+fd5j2K9/08YIVHLg1KqzhEmPD1g5XXhDahhEacEizSO?=
 =?us-ascii?Q?5+09/eqJS0dugmoUyIkA1fUck6O07m//f6z+1JVYhMgKlbT9yhNJ8iMUPyqa?=
 =?us-ascii?Q?H5XIgHoYaDF2dleCOqFxZ6fzsiSh6jPijx3ZlEjgxO9rdkIV7fiwV4d0YkIp?=
 =?us-ascii?Q?qLzt0yzq5Z3RIMJZpzI=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:54:05.5415 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a696c65b-18b6-46e6-0716-08de186bcfa0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6790
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

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 15173ddc9c..fae545f35c 100644
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
@@ -1915,7 +1923,7 @@ static void smmu_reset_exit(Object *obj, ResetType type)
         c->parent_phases.exit(obj, type);
     }
 
-    smmuv3_init_regs(s);
+    smmuv3_reset(s);
     smmuv3_accel_reset(s);
 }
 
@@ -1947,6 +1955,7 @@ static void smmu_realize(DeviceState *d, Error **errp)
     sysbus_init_mmio(dev, &sys->iomem);
 
     smmu_init_irq(s, dev);
+    smmuv3_init_id_regs(s);
 }
 
 static const VMStateDescription vmstate_smmuv3_queue = {
-- 
2.43.0


