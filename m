Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F07BC44508
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 17:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vicRN-0000Vp-Fo; Wed, 21 Jan 2026 12:56:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicRJ-0000LH-84; Wed, 21 Jan 2026 12:56:21 -0500
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicRH-00017P-GU; Wed, 21 Jan 2026 12:56:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYRpiziYilyPNGp/zfaZ5F9TS+1pjKLffbqf+l5DXJreqXqI+N9hje+7yqri13HSeygDDTNs45QYQlJnpigjsImQw0LO6bZkbV9mnywMls770Nt6wgQhG56yQb8P+nMTe9f6DSj546alVEmL2Lmk76ZJHbNO8W9EU8l4/gxOh6yMdZuF36XpCESeixzKlDBd0W2roWXJo4BhfQOO/4AOoAUCL//YNRwVlMZ37zv2f85gVQM8edmp81X1C3c1APh3om1Osj+fFActwJZj9jF3a4zELLEG4DVdjjGIQFf+Qvde+QlKUgoxgSUPWrmZIxZbGaYyhZTVs8je8RrL8qFxeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcUeHppzCyKZe1Ws3ggNg1sFEVuDRyqBUlnhaoF/oVg=;
 b=Td9muEmE6d5AFMAU5iRIvYpen8nhh9qXG2gAdhaYLB3icfoT+6YZgS60zJCHOjOIJVKegJpdGEQqiAMjI6wp0vgaWKUoXoKvFVg39Cf253bacYC1/N7eIZtVdldztcgXzxfQES8CQFJh9x5FKcfIP/BVQbdl54hfTYv3uefgqOcFUNAZtVrh2zE1mCprIMygjaWXCd2ux4I1+1YHxoQqamLHQEK+i5gxctb5OpmvvkRYptwfpTC+4WQEral0vQGrXY7kFek/gtc6ztiJ4hBGJMu+1LeAGmTup1J0h+OXAACnMhv0uIHRngWI+i+JGIRz+u0hOr4yFx6mco/yoZCG8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcUeHppzCyKZe1Ws3ggNg1sFEVuDRyqBUlnhaoF/oVg=;
 b=AhElob34ctqIdzuFz9g/VtCetrSf4WBCYf3KwHmw5U9Mgkpr0G5i84TniPz2H8izAdAAwTIwMSj/rdqM+jPQapp4p1FfrMBwhd9AnDZzjkyWOO/qr/dutPW/KAw3aNTteBrgQUnTxQm52MQj91qFO45kwxLfmCVk7ENihqIA5GrdM4uHV/r+yPmXWHQkM5OAj1ayOJQuhHaE0zwBwFL/sZ+AieVxsiww9WWZvfOoMczO1XXcM3uH8C2MtiImXQNjboqyPRN9akGhi2LCGfa5XAzSlfCJVv6K6HKntb74YXVCyjGMyALIJ4uZUhgheeQs3mOQuYEhZjavRmTmU7bAGQ==
Received: from SJ0PR13CA0210.namprd13.prod.outlook.com (2603:10b6:a03:2c3::35)
 by BL1PR12MB5852.namprd12.prod.outlook.com (2603:10b6:208:397::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 17:56:13 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::a7) by SJ0PR13CA0210.outlook.office365.com
 (2603:10b6:a03:2c3::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 17:56:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 17:56:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:55:54 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:55:49 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v8 11/37] hw/arm/smmuv3: Implement get_viommu_cap() callback
Date: Wed, 21 Jan 2026 17:52:16 +0000
Message-ID: <20260121175248.87649-12-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|BL1PR12MB5852:EE_
X-MS-Office365-Filtering-Correlation-Id: 552b66f8-9ef4-4b03-ca19-08de59165e04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vEkKrKAcpquyEsJohFwh3+pFfyOBKOmuVAMjNC2J90FfecKCwjyCmZ+bmp6u?=
 =?us-ascii?Q?FQaa0YDI0CArtp1lQ6lq6GmLHjzrmC0XHr9HruYejrsPp/ebIesb+uUovS8e?=
 =?us-ascii?Q?E2k+i454pAHgLLIghlysKuM3a9CPFlHiZq+TbSCj7Ox8iqqQpQ8ZxYMpIUxf?=
 =?us-ascii?Q?/hx6SeehCfBtvJaAv5Ch+xc91hCE+kYi+UAMHjsRMUzdb+LEIF/p0Fp4XwSH?=
 =?us-ascii?Q?UOHdev/Rrqh2JsdiFpjcfWNct8DUII17IGLfvrqMZfcabDcwa3Q+7qfJLDGe?=
 =?us-ascii?Q?aZTbkPiqc7rluJNEXt211xZVHMzC0U5QbRsHx1IzNsT2RFBwgrPzi23A6Mu0?=
 =?us-ascii?Q?sH1kQrcdzoH1aCrJdNw1CWlH7yNVjOxFE01Y3Zudsx5Aqi8P+NDiUuCZvARt?=
 =?us-ascii?Q?fc5TUJwqvwEO12lwOOPkv/BuFaYgyAjzU7i8j4DWVGp2A16v7q8fPawRyTWO?=
 =?us-ascii?Q?6Ms2oRGGTY6LO2Yqh6RpeKPioNxcgFf5UlIXGb15AjR7Ih/FYmFB9jFd1VSv?=
 =?us-ascii?Q?MXCQQDdrG6gCgsxzTYDGQ22toEDjk6HbQkaI4o7w+fEY6qkBrz06nMKyzJUs?=
 =?us-ascii?Q?S5Z2UdF7C8Va6qmb5j5iiUyVI4M+oQNYTHq22HiHR7WUeRXXHYopL1OI5NUD?=
 =?us-ascii?Q?biDsB/PNekFK/OfQE7Bf6WG/9Ps9P4bwJveQF5rPftB3iPp+1BlCuhDvAfq7?=
 =?us-ascii?Q?bXnny7W1vPpLu7VTf/sty5sJBXdhiiXpybS+iP5iVFU0GC01gTrr0p4A/NhR?=
 =?us-ascii?Q?zZGd9KhHS3kzZBFGRcgO8ApW8Bsh/7hQQb73Ul8DEws465gm57BYmwSuQLCX?=
 =?us-ascii?Q?XndtGX+SlYF7BnYKw5qdbaxuzYYzmwHOU27Aao1XVJbLxoiv0c/39lmXaXfn?=
 =?us-ascii?Q?V4asIkgiq6l/dOzCDnx1ylEFKSm0DFn31GrZZxzjd/FsXC0rSuvym6kX4nnO?=
 =?us-ascii?Q?Fa/awMWCEopyr9W9HYFtcRMucGXRyBU4Vn0rOdJ//NmnS9ml9lJnx24DcgJ9?=
 =?us-ascii?Q?ajiv9QmWo8nwFbbEP2tSDPw+QjOb5dEz5G8eCv8PapAWxQ0lh14ivuM9JdPX?=
 =?us-ascii?Q?/7jFcMa4cylM0EFaHUYkW3NeFlu1TsPk7FGJZST0UdqJW5B4ePbqQWV1XlOJ?=
 =?us-ascii?Q?VWgv8gHisruNM4C1uCMZAvhG8uPKd97daH1quQXFJ9WzvdPEcDbgGpR5IDr5?=
 =?us-ascii?Q?Evc1h1/8nG1nXrIhNN6FuK23saplo6ukXbzDJwgvGrzKHktCLaTBv8pJeaqz?=
 =?us-ascii?Q?86fdFIjeG4tjFYSna7BpVmO6Wz9/Rc4mDbKZBvf+QPb2N4A330qNg9TGN/KJ?=
 =?us-ascii?Q?Amabkx4nAI2yAbqrYZVrdjvaeo38N4ybsWF6XoO1cj1bXk5h24Q1m+N8Sznu?=
 =?us-ascii?Q?BMUfJsDr1GTf2K1LjPL4wIxI6iLsGS9ky8vz7v8FLJuaiIO2pWztT1I/Y/co?=
 =?us-ascii?Q?oX4izYdajylAeI7nL5Fax3knGFuqXCOW9SmpxlOrjHvu437yM75ONI2Hdjvm?=
 =?us-ascii?Q?3kBJMzclxHsOYm0DjoZi1Ehafrol2hq5QZXp7LjX9ZcJ8vyMcUW7Yx+pBxI6?=
 =?us-ascii?Q?cFcx29QCRNNJi+l68ovs/4G5NrbInHLtn/acNHjnVTKhqXZP0/fPAOEiLcIq?=
 =?us-ascii?Q?diCJ5ezIIqkBLDtiW8/pWrlaqFq3UjAMs/fdWwMiYgDHpqAVwFvXNAA8nKMX?=
 =?us-ascii?Q?DRITGA=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:56:13.4319 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 552b66f8-9ef4-4b03-ca19-08de59165e04
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5852
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
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

For accelerated SMMUv3, we need nested parent domain creation. Add the
callback support so that VFIO can create a nested parent.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
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


