Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0DF6CCF9FE
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 10:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEmmQ-0005T3-1y; Fri, 31 Oct 2025 06:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmlk-0004TJ-Sx; Fri, 31 Oct 2025 06:54:11 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmlX-0002xD-Ac; Fri, 31 Oct 2025 06:54:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=teqD9dtYalTM4Q8ElkP+StapqCCGqCREaohAawfePJbBCdBf77fBPWze1W7KSrYnK3nDj6j4e/oeZV+i5+eRzi52i/bHaqYiM3CuIASF1RpJppUVvEDJ31VJ0tTnYS9zqXn8uSSVricy+LJDMnaTEhNrDeGcljB3fWdg4z6seiJS02ZWzGmiFfdZY0EwZMWlQFlys9t45gSWTsOSWV5pX04Fa7WpAR8ThgYvHKrjcs2nOF9DQgSU2WsHRdM/fZW22gmgMlgpd0xk0DOIy3/I7fTXQUc8zGyw0RW+pt1YPKseIII0eTNoZl/1rEM2XIGgOitoOA0sQXUtKXFBPC+83g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXVWr9vcNxrjKqLKUQwunzU/I3cl2yYcnk4qyNHlQIc=;
 b=ESpt3KC38SNkGMeMEuopjxRencgwEcVgucSlr+XOKzwaXZ1CrK9Tl+rhuThCXpJaeyeTmH+BSzAgSyc5gnxfUUvNE64w9464wBwhBs/Aq79iHh8rUg5n3QOvhBWYgZBs70KLnmXLMJbKEZAVY/s9k8n1l1Dm9T8U1X5T7MmSJG3GYgwZghwVbsWhSk9EF6A4G4WQ/UON12UJEfUl5CHf60+s9+u7Als4a8nGgecFiVPaWC5QnVethFN5luWK2u2taSuubXgo91AxJoY9HNZ/NhjvvTbaLjhJsPj6nSPM/ss6wwTpbBNNqZp45BN6HVJCnw9AcrMU3/t17N/pa9mF9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXVWr9vcNxrjKqLKUQwunzU/I3cl2yYcnk4qyNHlQIc=;
 b=YH9vV5fL0avZ1WqFKxz7YPTHmAAhnR2WT3wQSxGzDSBYis8mygAtKvZ6LSZ5BdpZt1Dsof87Ml7hG0Mj9TziY31833cJpbFDgwtBpLc8U+OEPlImMAkudU23cTqtjCdQtD8VMDLH/w0MDtppNBgbkHGKOisBVC4rlEDui6+x/Plyfk7SIfJoJGBQlrelck23l/U9kpNXjb//DVthRv3Y6kmSywr+vYE28JNYuHgPSG5VQrXJIz3dpz+BC+7IybKx2EgOiTkrmxtnQn4HLleHOCfqvTzhdOB83GssVa7YoPMtpe3ZthpTqV8ikPtFen1VHNV7lc5huagqdEdVUyirFA==
Received: from BY3PR10CA0013.namprd10.prod.outlook.com (2603:10b6:a03:255::18)
 by MN2PR12MB4392.namprd12.prod.outlook.com (2603:10b6:208:264::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 10:53:39 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::16) by BY3PR10CA0013.outlook.office365.com
 (2603:10b6:a03:255::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 10:53:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 10:53:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 31 Oct
 2025 03:53:26 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:53:23 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v5 11/32] hw/arm/smmuv3: Implement get_viommu_cap() callback
Date: Fri, 31 Oct 2025 10:49:44 +0000
Message-ID: <20251031105005.24618-12-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|MN2PR12MB4392:EE_
X-MS-Office365-Filtering-Correlation-Id: c0e1994f-a82b-443a-ecab-08de186bc00a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|7416014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2b4M5LakeZAm7NhbkdlurgF88ghbwZ36Ftvnbrx3peReDNjpZKw5f49RTZKH?=
 =?us-ascii?Q?7P8bVPD2FH4Yf7E4BNjIIuCBO73154GPPUl7zoF0F+5I03rYXK6v4UJR0ANc?=
 =?us-ascii?Q?i9KLaC8LH4p55lLkT3x7BeOdrqNyhz1EwTZCFVBuJmnriwfyGAXlcZWmm0HA?=
 =?us-ascii?Q?5rsant368ZWGw20lMAevKcmqxffGJV2H1R1/B9gTgYwIkvebaGwSPAUgwwf8?=
 =?us-ascii?Q?HkHsk8TWMy08zqupwwY+6fybsNgS6eSECSzqpdh/WT3xwvQn15D/NylkTcrZ?=
 =?us-ascii?Q?taczAa6fbiXNk70IayRm/lvFbZVAG2TfVvdqXW1thwMhshkQyW70MAtjUjiy?=
 =?us-ascii?Q?V1uFFXBWNJWeEzyoEPRy73LquCx5WzPSX/rR2Zs5ucLOVgqzXVVDE4UocmuO?=
 =?us-ascii?Q?jY4Znh5Frn2xwXQcWn09NxcWjHprFBqiTuJ06HOuXw5YRER+LTnW3QsbLZuP?=
 =?us-ascii?Q?gPbRG7Elw52nVmqfqiiTHA87MCZ2zqnDwl1krnorvzGVBOY6dFLv0JET9sDZ?=
 =?us-ascii?Q?V6q48m+dZbOliC2becmU0ctk1EL23M0Leoiww9+h2LJW02Bm2nohsdekTGoa?=
 =?us-ascii?Q?l8CF+8X/gi20IVWjaMkES8kHVSrI7MGg4E9Wbj0zSiBUBkl6eZbnTle3WJy5?=
 =?us-ascii?Q?/IV6M7zGk/bUUNV8mayA+KAMsmmOi6Blo8MgGXtXDW8EWC6ZYF+rYsdNAv0t?=
 =?us-ascii?Q?4w8xsf6Pc0T2V2mXFn9IMbL4shiniBai0uzNceIqwIJYo7OJHn3IPIX2EPDE?=
 =?us-ascii?Q?MTkpnKra1c+79LXdqwiQlWYJvY8Kh/7Xdgj8zjzjZqn8UDJMyNoFhVoobPZj?=
 =?us-ascii?Q?JJL0o68u1NsOwxk58v6ET6kfTmYJp7mLuGdupkbhT8v162tFKM/ebjUe/Mg/?=
 =?us-ascii?Q?mAz6n5F4NRyU7eBmcldXnsHOGF8QX9qak9ZFx0a41alDZTfbOIYo9mM0s18k?=
 =?us-ascii?Q?Ysxn273+cbz2Yp8c4tVuF1iZzPhTynjx1FQjRnCX5CPR/Zp69aapDlUXv7CK?=
 =?us-ascii?Q?4dQr/IfURkRVbnCmlC46b0opbY54bNE1mPvKZXA/h9jqf8ySvqIZaA3Nv3n+?=
 =?us-ascii?Q?nyDmLhyrBOeyBSXDpzWrTOQCrNuCfQ53gOaUg8BaeG5MqZYpsv2B+0soClb5?=
 =?us-ascii?Q?VRILOMCgk0CvNHUTJw7LBSpdvUNT3pI+kGOoMA+i/sn5MYwsZNQBc3d39ext?=
 =?us-ascii?Q?VID7OCyfGPDq4Q1i/WDr96icI/W9JmaXJkippnM+Tize6Mwg4tQn7ihLStBx?=
 =?us-ascii?Q?TYtrGsAwcQoBSWngj/9XTjYx1mRJn9A9CR7P7gQ4oeeESXYEmW8vEOXz/aEU?=
 =?us-ascii?Q?ldMRyDC2EFNaxP/u47Bxgjq1I1sPdH3ZreTERq63kMVNUKoFng66dQsNEFrP?=
 =?us-ascii?Q?nA/6LRyczNbeHFXGVujpIxXeKjo6UuI33y41xxE59kQsxJaw+U4o3KicCsPK?=
 =?us-ascii?Q?VcXqc/QdnJz0v/Zov8q6WDT9oiEiTJyyM5FbB4BI3dPIrxn+qXlUskZvlOa4?=
 =?us-ascii?Q?pnbes1FF8y+NvEK7UBMFln5U8j1La1t74P9+Am/R82bzangsWDGasOoKl57u?=
 =?us-ascii?Q?sXS5eOsknc1wS8SxuGU=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(7416014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:53:39.4811 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e1994f-a82b-443a-ecab-08de186bc00a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4392
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

For accelerated SMMUv3, we need nested parent domain creation. Add the
callback support so that VFIO can create a nested parent.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 550a0496fe..a1d672208f 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -10,6 +10,7 @@
 #include "qemu/error-report.h"
 
 #include "hw/arm/smmuv3.h"
+#include "hw/iommu.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/vfio/pci.h"
@@ -119,9 +120,21 @@ static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void *opaque,
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


