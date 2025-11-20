Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF55CF8855
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 13:24:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM4eF-0006Vv-BV; Thu, 20 Nov 2025 08:24:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4eB-0006Qx-3K; Thu, 20 Nov 2025 08:24:27 -0500
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4e9-0002Ik-Jg; Thu, 20 Nov 2025 08:24:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7AY6dn8uJi0jVCJApxyZ4geq5GDXjRZ1IbYC3ilgxRiXmKgCxjymD/WDVbkIg2v7h0Nu/axfd5RRWskZj4C4tjE7slH+2a3S3WaMmXOv/sidyNrr27WjWgHd0BZ4HSz9BHJA36MRM4dWG1FgWpq5TAQnm88MIjaI4i9Tqqz+Vdj6P18zjc94xAQPIZtaQ1a8xr3dFXxlLTjXTfE75p9EnRmeg36PrRwftjrBy/UZprvmQW91Ovtf92Jm194DeVnwoVt9O4KTvdmOdAPDgTvVKUfjiP22xwr2qajvDba4kSFyo1IoL0ys8FPGmo2YssM5RhefyBiWQV2ho9PO5NC4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBRSYzZuQ1i1Z6SVq7FysI6o+gGRms2XBEQ6+vFMd6E=;
 b=EOd5kVJX76dI+fkO2o97spcbWp1CtdCTBlsT69+2TBp+IFS2nmqsCLWgEgQIK2UWKxLPkfKntOfgRv4hGxU6zpua3wAgID11FfGYV1fP8smx23s6/R7C+yyt9mRuIXk9Hj472X2zR96mECbfvwQ3p9lLmuhGmwJg+4VsUAUKTKrNSy+TDtb7tOln2eM0SWRWQ8DqzgeACXr3ShGRwUHPMlDgFyXE81aCVLzoTJDQNoD26OYM0G5tzBSkffxTu/U7wYQw5QOnTbrbce0R0EvyhBKMUPZNhmKwbcAwfzewTTpB+IWIRTCSIW6NtJu7Qm5IZqySHZmBb6ysZS4PzfSv4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBRSYzZuQ1i1Z6SVq7FysI6o+gGRms2XBEQ6+vFMd6E=;
 b=nIaXdvf9FgJPnOIQOGm2LpiimXNu+Nff7jdPrljXIXkhX6E0H8fw7lP7l0vvb9e0+Fh5FFHwn8B944u1ORnnZfF51ojC4sFHJqqKA5/e8LiNmdevrPA6dvpY/OEioq/TQ0LyW3z07siYQhz4wARYF5KkRsqmLsgKts/Gg+6/QjDOHq6Mro00g15sSsFbH8v+Ac7/p0vI6utOBVUqC93qaaJ8JzV7oKOUKQ+MlPfjmWne+18K07hUOWU5N0UcrrnK0DYzIUU7SCzPC93bZLSIjE6xqm0rj6NSUA9PRh65Glo9uGWwymUR7KiExRFouGhW6ufVt70L7caO9toNu6ssZw==
Received: from BYAPR08CA0061.namprd08.prod.outlook.com (2603:10b6:a03:117::38)
 by BY5PR12MB4146.namprd12.prod.outlook.com (2603:10b6:a03:20d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 13:24:19 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a03:117:cafe::e0) by BYAPR08CA0061.outlook.office365.com
 (2603:10b6:a03:117::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 13:24:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:24:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:24:03 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:23:59 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v6 11/33] hw/arm/smmuv3: Implement get_viommu_cap() callback
Date: Thu, 20 Nov 2025 13:21:51 +0000
Message-ID: <20251120132213.56581-12-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|BY5PR12MB4146:EE_
X-MS-Office365-Filtering-Correlation-Id: f3c0f360-0472-4c41-6268-08de28381c1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Or67+k1KavY0C9M7+dcnWYLeLfXz9c2ohjkoHLtC+EPFG3GMnrzBdbG4bqpL?=
 =?us-ascii?Q?7We2Ri3WZzXQ+S4Zoof2wqTSAQKh9+JUeH+oxtzFiMP3i6ulJcQViLiGWkcu?=
 =?us-ascii?Q?WWxJ7ne8MAiUwGvCFNAiKHBazVKaKLKaKkKO4zHUvV5HfQmlxhe9y1+3TMb+?=
 =?us-ascii?Q?3Gp0eZEUn+cjEslHd/rW5ZRCiS1Nb74TUiVpQ0Trxbc+0ByM88DNOeGrJVwd?=
 =?us-ascii?Q?pwqbBReWaWM438fkltVkomiAzKQAqjUF3XigyinL0xAE0Mq2BorWtt0DDOZ6?=
 =?us-ascii?Q?Ba0Ho7O+gLGAj87KuJ6Zml0wFXwPwIF81XA6Rw3x4XFRp6LmEFatmLWhH3j6?=
 =?us-ascii?Q?JYb5NW3gUYBZI9wWtEuC2QifWQkJgrRR4YmDpr4cZCeET8aV1gnHJYogeJvS?=
 =?us-ascii?Q?aEJRc+4/up0tBK/R4eKbcTewrnU2XQKTQaocb7NXx5XkHrZI9lBhIGfWbSGD?=
 =?us-ascii?Q?YyurVfwQAonrzs6I2i9quVMxemdwMkvGzsed7uEnEbUU4GsXzq5/y2q8GFGE?=
 =?us-ascii?Q?4J6sE0ag6YaEuGHS4iZuzQmpzXEkdI70X0pNbcEQORFjgLoHsOiqjNnKo1g+?=
 =?us-ascii?Q?qYHdeUsOi4NAf/d/7ewn0EjrLvW5vbiN3bbRoEFaTyg2SCZaTn2wLyeKJXmG?=
 =?us-ascii?Q?Edc+MTatCDefHlj/fj6Agbkm75FL1zmW9GH+fIDkTqJTbl4Mf6a0Y5bQB9fb?=
 =?us-ascii?Q?eMidl7xVdmYgLpEE5C6REKcPgvPw55Sz0wA+aPu7PAn9UgfonN73JqO0nMCZ?=
 =?us-ascii?Q?QbOC/os8NBSW1PeBmZGqhb9kwYTOsdvheLKOL2rQ7THX3ICkqamsliK1WIrR?=
 =?us-ascii?Q?WI9YnpHedaedvdR8V+mID8oBWHohhkMWnOjaMA4yyuo2iPKmsTdJ3tO67rVe?=
 =?us-ascii?Q?RxrB6aKASlHZHVh7EVzzHK5Y/do0m9KLR0rWKOCZNEgNmDXf/Lykef9lo7uw?=
 =?us-ascii?Q?wLamHgZYVq8XssNFRrVSm+wp4hZCJwX+CYVb1PeoApa/2TTA7LIPQpDjZphZ?=
 =?us-ascii?Q?5zZc/I6KmxsYn2q8vHW3nabnA/n91tiZcvzqGXzgNDiyucA1DyG/rvyQ3Kcq?=
 =?us-ascii?Q?csWKdpwEFqjCQCq6yTqY6nLrsVdFaNEXJOlhNYICGaw0vhMnkByyyKd4UPOH?=
 =?us-ascii?Q?XPUck1U3VxtAo0xBWCi5X7MJd6nreQoRJbVdFjwpSjk4qOHyJsZn59PS/86z?=
 =?us-ascii?Q?4m3fhr02gUJSYgAXL2NlS/a0EEWuw6o5IC79IoGbdJ0GZaP9Km+FfPmaHsUe?=
 =?us-ascii?Q?ly+/VSaCNGF7YcXBnhacUiwPRmHyKG1etiy0GGalGeJLtnnrdZeNazZoVuDo?=
 =?us-ascii?Q?TNUV81cE1Y7ShR2d9p1TVt5guGWm7qBmX3G/miN9TKiOXa64OYEGrW0xjy4B?=
 =?us-ascii?Q?oHOZ1CvSzpAzZ9G8d+taQuc+RDa8gibvSm0XnxugFy5YEbIg7jKIlLyDIlKA?=
 =?us-ascii?Q?wS8QhCT6FLW2nn34MytMvrt4F6bNX2OLjWpHG8KD0MbK4jxBH69PK0BbY2f+?=
 =?us-ascii?Q?+cGM/jfKmoL/0oVFpp1yG5lFjNmN7/z1OyOJibTlHBiEGay4TJGjEFmjWqR8?=
 =?us-ascii?Q?rqKrldbaxRDuRIFvn88=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:24:18.7476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c0f360-0472-4c41-6268-08de28381c1a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4146
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
index 2fcd301322..bd4a7dbde1 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -10,6 +10,7 @@
 #include "qemu/error-report.h"
 
 #include "hw/arm/smmuv3.h"
+#include "hw/iommu.h"
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


