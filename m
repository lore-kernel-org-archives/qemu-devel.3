Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0CAFCF65D5
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 10:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkK77-00005g-CG; Mon, 26 Jan 2026 05:46:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK6R-0007Ok-AD; Mon, 26 Jan 2026 05:46:05 -0500
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK6P-0005Zd-VA; Mon, 26 Jan 2026 05:45:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=trFVDrOm0gvZ28u+RgktBi0i6E0Xevamf4I5pJq//b/umM7NhnlBNdC699hBH8bAdF+aI8ESWDcvq5yn26lhQu6vL3ucWCApCvvZ38vGeGR/ngwsnPDc25FonqG99O5XKyeu7fm+uXxdSuljV3aH7UFWvpwCF5rwJY6ApGuceX+PaH/7fyoVVNUCSe4NMMuxFQUxAcDHui8WRg2Ywt4PMnYd0sx6NxnTXbv+oGOb2DUzrh9hIsIGT4dPvfNRzuVU2z/HoTOhaOa+ozSb8pVO/ZWF+imk272V0qRIVfMM5NuVAMR/zC3L5iXGkFibp/rQ9JTR+UchKhPE88yWCXwS6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcUeHppzCyKZe1Ws3ggNg1sFEVuDRyqBUlnhaoF/oVg=;
 b=wu7JqZzoDf4QrZpaWFNMML51KRn3bKSN/iD+1gT2MnQ/ooayv2T34Ij35itrwoaRyZQ1I5u0QFTb51ou0XLUAjBZc7o2D8m1wtQ8+lxJUWH0YCNOX7ZuWctbZgCb4+SbZbGpJ0VNcFwQfiw6GKzAUtdE7PYgdXfZmuCi1+T4Nimm8RFTEyFELH6z6boavg7Ni4uP+GS7To01482T3E6mFSxIyuO+hjC48BE4b7WoPmK0tB+5uSGNUJwb9TAwAhR20PB8aSlH1aET/iAuLUMCBgR6A2UgCMHM51Xq5+9gVJwXsqQc6XM9mcN8zJZDJpDpRJQx5P+qTD1xLSH+9kA/dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcUeHppzCyKZe1Ws3ggNg1sFEVuDRyqBUlnhaoF/oVg=;
 b=PMvTjULBaT41HDdKO9OayjMvsvqK8kltOUpKbJRv6gCT9bQO++VuWBZL5EhHBJWSMOEGyp2ZnHMnzcwekSg6jW948jf9kgU/fIWj7io46AgW8UvqW/K9Hqcn3IUaJuHV0GhExm0IebwcYmc6k+N61DddBPdHv3/eL7lBWUPHo2n9EBoRagM9mIBBJizVTV83Q0fZZ7lOUIz0b8oxkCEq4a/Z0p1ynYtX7T31MVLZ+NOMvUaAOh1zmDV8HurtQLLWVunapsyij1FFkcrm4esft5Buznl3KN5S6pFaw7429F9J+GFphj7F0tK9pFcW+qQyNjlWHa0AaHU0cmehd0CbQA==
Received: from BLAPR03CA0152.namprd03.prod.outlook.com (2603:10b6:208:32f::16)
 by LV3PR12MB9142.namprd12.prod.outlook.com (2603:10b6:408:198::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Mon, 26 Jan
 2026 10:45:40 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::e2) by BLAPR03CA0152.outlook.office365.com
 (2603:10b6:208:32f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Mon,
 26 Jan 2026 10:45:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 10:45:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:45:22 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:45:18 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v9 11/37] hw/arm/smmuv3: Implement get_viommu_cap() callback
Date: Mon, 26 Jan 2026 10:43:08 +0000
Message-ID: <20260126104342.253965-12-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|LV3PR12MB9142:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c100312-3e57-453c-8af9-08de5cc80c4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v92lFfoSYxPHlLh6YtPhDxVlQrT0IIXBdD2A6UtHQ+KK39s0zB72FpoK+LUe?=
 =?us-ascii?Q?YhF5g8qhtdPuG8c9OOlZXSdM1eG2dXvVdkabzUbgchDHEzGA2J/tv6Dd1nZT?=
 =?us-ascii?Q?PDqUbOTgk/d1Ve5hR7EA4vWKtRoLdtiE3KRW9+mkuRqdaAF9wrjY4G+4n2Si?=
 =?us-ascii?Q?eFpoITwxI/2RqDBsQ9/83mS6yKy8lNf7q+tw+Sq/MoEVCl7o63gKqUv8lkNw?=
 =?us-ascii?Q?QLpCSpZY37fe+bxo6w1r6oNoM3avFIRIfXZgLn04CL9rsSeQ47AefkPuVeJB?=
 =?us-ascii?Q?CWqTrjECAKMPSx9CcC8SIntA3c/5ypMyHFbcVgb5VpyluR4TQ6XUphUOz2t5?=
 =?us-ascii?Q?KoDW3X6IRWRjS6CwUAQLTHmpKk/BqhHh5CJqpn4L2XWrcc83pGlPpep/sG9T?=
 =?us-ascii?Q?Jw9Seu+ujDyaiPA8BAFVFWFm/7cJ2OlS8j3UZV9lsAIVBaEW7GPLbFqlhrv9?=
 =?us-ascii?Q?yiLwurFhcpEw+BG0tOIBQdapvFC5FNVmWmcWgKyfnvYsg1WtbaY/i6e/rLBP?=
 =?us-ascii?Q?qxUx4yVmXVtrkd0fqow1lNxQVQ5q27nI/Sit7TeCts912EwrYc0KnlSvMAyF?=
 =?us-ascii?Q?3zgOXTiUDkYzy3kconIzM6+0G/F7fChHKOa0K/COhEMSopKyXkcT6Do2zT0V?=
 =?us-ascii?Q?TA81dN+BkxO2q7cJl8/rpOCHKkJJCo4UjfoORUsVNX9nWb/+Iji0vZ76FrdC?=
 =?us-ascii?Q?oGFZYGVsbtwDzGEKP/Cu2ZW0Tn5kVfhAbSFr4pF6iyeT72bQzqiwTDPuQtZp?=
 =?us-ascii?Q?jwsFSx6o25KFckBDmrv5TcVI8oecc5ib2N2KmiogAiWf1YgyApWm8VuixAOQ?=
 =?us-ascii?Q?emkIsejKQi/K2Ks1mKU8rS2R0DnESX8bTm347ps54EFAid7c2MNSO/YUE1V8?=
 =?us-ascii?Q?ieQCLW+fX8UnTMiGLjyxGQHe1XlacW9ajeLUwqTVm1KOuRmKQsrhkHXaM1fF?=
 =?us-ascii?Q?vdoDyiNonaHgUHqeq/y8G/+R6Qj1VH8dq8YRg9GyqmVSPwIfoCkyRiiAOaob?=
 =?us-ascii?Q?f8UOpK/gJsvJyymYfjG7seu7WQ3wuGBcRUc2Q+pfGbAy0JuYD8WjuSh2hkCy?=
 =?us-ascii?Q?pK6m+OXQrjgL+GTsb23YVm1Ff4rq3Y1e3Uc20xjKQxVimzq1pq7mTIFW2Qjb?=
 =?us-ascii?Q?/tcibJoIGoofqmzUNkaxEilUWilkVdixBjFAjUOaYxmgsk8LtPu4RgkMWTwc?=
 =?us-ascii?Q?bbW3rMiZDERGrJuYe3FRZDB/BsST21KcVThMt6HmXy9LVZ0iaD5TZ5ymlLfD?=
 =?us-ascii?Q?ChqHw9BopBHNSIVyBpst3KJDb6S6iLZZbAvOlWQmg4fPAzl1kYz0sFUQBHbd?=
 =?us-ascii?Q?N/tqcxy0FgxyLgyDZNBwG89tvnsjWIX+X3KgfCUyaxuuWOkbuNHJhDOJshZX?=
 =?us-ascii?Q?wbiJkE7qL3yEAL54MqTDa6wHZDaIVdhN14f5xdBQaY/NuymGQfNycByh5zvJ?=
 =?us-ascii?Q?6CtUgbCMo9jFAUCX1vgvn3mgRc6DTSR3pWtynFHgYsdvfKzswnqOUVfYAgx/?=
 =?us-ascii?Q?Il96YNcaC0bpsiUS5dy8kG41X6QTQypjPyip1GoL8/VBjTZ+gCmxtNIHafBN?=
 =?us-ascii?Q?WYEbI8lrVWjRtlkGwO9c4GXcnQtIf4JDMudNG1iyIMsebhTpq/+t9PHu7WX1?=
 =?us-ascii?Q?Pd1xqctuxxujcVvjDyqNlnn0QtcHX1pSAH+9rGmNX8BRTgzF6GCgCLY/AoPh?=
 =?us-ascii?Q?MJwX3Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:45:40.0786 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c100312-3e57-453c-8af9-08de5cc80c4a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9142
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.587, SPF_HELO_PASS=-0.001,
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


