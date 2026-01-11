Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1064ED2502E
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 20:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf1Ye-0007LN-0P; Sun, 11 Jan 2026 14:57:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1YP-0006vc-6g; Sun, 11 Jan 2026 14:56:49 -0500
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1YN-0003tP-Pe; Sun, 11 Jan 2026 14:56:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jcQr9IrPHtR16706RA3AwdkS+kcFpeA/s1hCW5wdEpGR04K3d3w+MUFwDxf5bOWU3RQMDT/UA4MKd9B9cRf3JZB171aKnGBAg9u+4p8HZQmL8ih7NZiwC+FpPSZ1JdHKBdM5G83Z3yeAVGA5u5u92DiiihW5zTetgBsmNy18u1s/ZKtYmZwNrMiZ8/Wt5RwbrV/BSvdGHIa6o2uUXM1YXTpXsRSirczSWZvkkqbUvU2nLMBCat1CZ2zb/DyWms5juToSDQ3y7+FAiMHmLezKFUEZC4PwoySLe2GW2L7cD2c8+C33KDv/+PQIR8dAB75NRdG6QK5r1PHZf0n9gjp7cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWACz1lNtfF9rvBxvuwfjQ8FUjSX1kx3a33iX1xb7RM=;
 b=etRNQSSTt43Q3x6hdWarkrpYjJxK9Nf9D1uy1FhM89fKdwq379Jsq5xnKWOnRTFICWSlLcwhLq5hl3SCbFO5re5ngjEtqGlFDC1R0hwjiRRXvZHMhQFqq7un8cadVCO9Lj0+UrNbMIVWpE52aRH19Rz0yMI+aOcMktozWcPLd1e6fO16AOzLYwPVClerfX43pO935Zd+VJgJ340gi/ZA22c9vfRs2iyYOzgIOPhLDXBjSHNrmXs3lrxUUCl9/hhZkiHtNnTIivCZpiW0oJdfyXL2ncWCZRG+jKU4dsZEo4Uy69QFmVwS1IT4pkrfSCzln147SJMAA4TnJ48YbQpXnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWACz1lNtfF9rvBxvuwfjQ8FUjSX1kx3a33iX1xb7RM=;
 b=HnqBm34JFtxUtdYQqSY59NyuDLPWFgUKPb+XxBg0LXjJlpkk/p4uSUK7xKmMcA23j1cXycpKpNVCAD4vnYW5kORQy41AiaXT0PkiW5Opu0bMWJKKs0KLlLew0qYr8/ptALi5q56qaNyCWVT0+6fjlTDs4eC+ldAUYB3ItwMZ4Vlx38Zn76pNAVGUqBfVLDKOBzao33u7IjgjDc3mGjwZN3ag3MQCIt4aI2XtbfBqmxHF6u+KVjK8opmXxedoTUavrURFjCPbVfdegMoZrW7M/SOzXKSSWmlyADqNMYlBfoF3FzsYji8j/aBkFt1p+SaqMeR7m6Q22RqxHR2oCCcSow==
Received: from SA1PR03CA0005.namprd03.prod.outlook.com (2603:10b6:806:2d3::6)
 by IA1PR12MB7565.namprd12.prod.outlook.com (2603:10b6:208:42f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Sun, 11 Jan
 2026 19:56:41 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:806:2d3:cafe::5) by SA1PR03CA0005.outlook.office365.com
 (2603:10b6:806:2d3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Sun,
 11 Jan 2026 19:56:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 19:56:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:56:36 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:56:31 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>
Subject: [PATCH v7 10/36] hw/arm/smmuv3: Implement get_viommu_cap() callback
Date: Sun, 11 Jan 2026 19:52:56 +0000
Message-ID: <20260111195508.106943-11-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|IA1PR12MB7565:EE_
X-MS-Office365-Filtering-Correlation-Id: d8ccf519-7986-43b4-0371-08de514b8a20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Hn75bNW5adOUUzQ2g1AOmoAYlEhjDhGJ/sHbM2swjEk2VrCRKuXpXSXqOK7i?=
 =?us-ascii?Q?KALjMCP9vwV1DKml8EgnGgbanpm4ADII7vVrW2oTkhFZTeEOF5S+lX7baFao?=
 =?us-ascii?Q?H1DXBWVW6YDqhR6cDyIKHnw7/PYnaTUXMGHCBa6Su5m2GTheEHlFMKTIiSyr?=
 =?us-ascii?Q?7cNYD8tmbqWNYm4jKTN+Y7QpUBT78TN61h0AGLXPK8OkcZxIu1aKRI/51Ah3?=
 =?us-ascii?Q?n1YKPoRWyVjmnVr3zX565pNF4cJpIOUEmLFjTuLx+CspV6SPpAgvUPodYwCG?=
 =?us-ascii?Q?7IlTx2dc3XrYEWqGj077+v1tfH6lhEuZCWoNBP/4FdwMJQtT0WIssLMMtU7O?=
 =?us-ascii?Q?zes1LHHPaiHQKqtbN7KbesZi4eLnu13BelWwebW1/Clan7jDeTl6G8202Y+m?=
 =?us-ascii?Q?XZpv7vG36QmS8XQcRR885ucIrFGd2K8qVLq434Trm3aXbVV1stGtzUOEttKh?=
 =?us-ascii?Q?uN0IhzMO9QHl48YLT+UuNLgIItI0xE95SX7fDfXsF/RlYRa8hDw7l/SDWtyx?=
 =?us-ascii?Q?C1FKZJwHP/aHWvF3RKALahmvYRuX8g1ntQdPEemgNRRz/nDkihXPXqncYFeR?=
 =?us-ascii?Q?y/aapUK8CNBOvD8EGnAkvlgG95t7ghgiDhF/D3Ebqm2JdSY8A8tAO/M1Z5AL?=
 =?us-ascii?Q?MFe/eWp39lpP3i3phZR4dyxnhmXAD6T3k09BP/4PHpGQFEK03hNVAt/Qgzqs?=
 =?us-ascii?Q?bDaW0pD/yXdxWWsz3ylVOxKHQ4jXNMG6D+gwYcYBRUCrYSL5FEWy/silmbbq?=
 =?us-ascii?Q?Ucju3beCf5X1yNteXQuFi0LVk1OPx2Dcfy33flQyNh8RFJJL+10qZ7Db0Hia?=
 =?us-ascii?Q?RtPGuuxddU2HwWNqGsjB4Oon9L+IP0m8zHRBI3g/7p8jhmclukXGpLIpIM2X?=
 =?us-ascii?Q?9TMWkVHCRa4FRZdFu2px4ZAdF+a6e2OSmKcH587KfZ+0vxAZCYVgb5aO/mki?=
 =?us-ascii?Q?V7CrxQjzuGS1uAjCWxGfNSwYZpY1Gu8QdPR3wTJawyM2hR2rTvxUZzIv15MX?=
 =?us-ascii?Q?drBklwq/b1rGz4Qd3edVSmh8RPrTbBf/+1bWp0ZhNJZmjr3dSMzlHTnx7L1t?=
 =?us-ascii?Q?HxMxWHVHi/kZ87NAHQgEPugVUnCnwzG0RrD13uOT3WjnZ1BPGxtbVGyZXhxF?=
 =?us-ascii?Q?IF6h6opld8cryn/DVgJBT9LYKtgjQJ/Y7utaejDB8VZfxG2S+XRWHe114LDC?=
 =?us-ascii?Q?G1Xycb8dMN+BfBx4rMtgKvHc5ZtNmvkgmn+Q9rtHRgMtLFhw2wUjX3cOnzWQ?=
 =?us-ascii?Q?Rxgbc0geziiIo/RjetjkJGqMkRYOk5HIMPMUPggVLYMOkHr6a1IN3bb9Aeog?=
 =?us-ascii?Q?MlNDRrCPTn+LvKBVp9ZoBpFIqJjtQvHSm7h9yaZWGXCAk7vOf5qdR0UDSENG?=
 =?us-ascii?Q?OHH0+vENykl4lMDCYVqINthMg2Y/7c338+uRUvGR0rfHs7uRa3rHVQC8/90C?=
 =?us-ascii?Q?j9Uvq26RjI8oRBakDQ5rQS9C77nC6YNnmmqUAe/R/6GKsgaj28/AM66b5eiF?=
 =?us-ascii?Q?fbLRYRq2d+ubpJIttX+t78mKp9TBFMRUXF4zqRa0hCDap+6LNjA5cfbbMli1?=
 =?us-ascii?Q?B2H2CxgbBuDMlYSTAaQ=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 19:56:41.3504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ccf519-7986-43b4-0371-08de514b8a20
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7565
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

For accelerated SMMUv3, we need nested parent domain creation. Add the
callback support so that VFIO can create a nested parent.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 2fcd301322..be09cf8b73 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -10,6 +10,7 @@
 #include "qemu/error-report.h"
 
 #include "hw/arm/smmuv3.h"
+#include "hw/core/iommu.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/vfio/pci.h"
@@ -129,9 +130,21 @@ static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void *opaque,
     }
 }
 
+static uint64_t smmuv3_accel_get_viommu_flags(void *opaque)
+{
+    /*
+     * We return VIOMMU_FLAG_WANT_NESTING_PARENT to inform VFIO core to create a
+     * nesting parent which is required for accelerated SMMUv3 support.
+     * The real HW nested support should be reported from host SMMUv3 and if
+     * it doesn't, the nesting parent allocation will fail anyway in VFIO core.
+     */
+    return VIOMMU_FLAG_WANT_NESTING_PARENT;
+}
+
 static const PCIIOMMUOps smmuv3_accel_ops = {
     .supports_address_space = smmuv3_accel_supports_as,
     .get_address_space = smmuv3_accel_find_add_as,
+    .get_viommu_flags = smmuv3_accel_get_viommu_flags,
 };
 
 static void smmuv3_accel_as_init(SMMUv3State *s)
-- 
2.43.0


