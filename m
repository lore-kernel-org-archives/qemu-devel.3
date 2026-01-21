Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1EDC44536
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 17:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vicRL-0000P9-3B; Wed, 21 Jan 2026 12:56:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicR0-0008LB-4n; Wed, 21 Jan 2026 12:56:03 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicQy-00014i-Og; Wed, 21 Jan 2026 12:56:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pyrMMANk0KYvkyg/+gil+xJUt8KnTVd1raju7eHQrImiRPKqHA9aplxxSCR92ElX8R9qrJ9GL8nBoiuYxZcEO6mK2NZVr3oZaseOfRzR+So3OfcZ1fnfTGwz6ATshvvX2vqC66sSGgG55Z1CVTq5Ld9U10/C+qSKVBi5D8WbKs26wHGYJ1jfMPkfzDn3+w5dEd/OadqRcaPdkjLmNu7JjC77FyGjO8qswAt3lqhomXJKBx4LU17DZTbwmiix7+NZWo3JTFIPdXL/HAUAU6VbhMXrrzuux60335zBYvT+En/PBJTAHl7Lmx0PzxhHCa5/6wrv1MHt88pvPfsBBxdp5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wuORsJgSJ1EOp2fzKSUJZ2s6IuItU3PMCcW8TNslek=;
 b=fCtou86hBLHsIfl0kZLgjLzs2+tNLSUl7NyOoJJtYmHZ3wsbWgg2naPTBiWxBN9Ur29qslg+Lxz72a8Q4YBG1cQ7Y68CWGkN+wTVNnDlKpPDNsXiJ3CtdoLz3lRPrpaQGoWd4CE7Ldcp+XmaZOB1oZOGgQw38aEjqMstDpFh893NNooiayVoDqJxYBo1BJ/dKFQnG7UAzGIQYgWJY4+8W43w5LroVcb40uRwddk27/H8yU77QWN9CJNkqEMMquRKwuSWNnzND83519QRjsIfKf+AE+owI/JN+z+XLgqmsIwHFtQeyZgAuI2DIoeUFrKg6QcRisk7Hpb5yzncH3F8Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wuORsJgSJ1EOp2fzKSUJZ2s6IuItU3PMCcW8TNslek=;
 b=oi0BzogNT2UpY85ULciLcdTiCKF+YT4Or8fmXI+I8fTm34TXa1eBmctmTytsmpgkvfjFZessCQI8o6ByJmVXGcWSfsu2C7vW7EXyuoFW2T84Dc01oowebkmrA77z7DeXbBxp95bVddA2WI3oer4xvp+YVpSWCNeIrPNreI7FgflwUc351Y48ZoFI0A4prjvna+03oVxFeqs5uZCLLa4w3d75l7Hl5Qfi8qpPTyQk6tzFgxiYLz42+X/jxKKcnrnJkOL9e5nUEjSh+TFYKBbzDfXrd5fZfvic193R7GhGkcI305NLBPJp//KU+DxE14vLAvqAZmITOTUf25zyatKLvg==
Received: from MN2PR10CA0014.namprd10.prod.outlook.com (2603:10b6:208:120::27)
 by CH3PR12MB8281.namprd12.prod.outlook.com (2603:10b6:610:128::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Wed, 21 Jan
 2026 17:55:52 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:208:120:cafe::9d) by MN2PR10CA0014.outlook.office365.com
 (2603:10b6:208:120::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 17:55:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 17:55:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:55:24 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:55:20 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v8 06/37] hw/arm/smmuv3-accel: Initialize shared system
 address space
Date: Wed, 21 Jan 2026 17:52:11 +0000
Message-ID: <20260121175248.87649-7-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|CH3PR12MB8281:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fe5f3d7-5ab2-40ea-ccf0-08de5916510f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eiM4gehxIHy3aU7UxLJlytRY7H8d8I8kHxVDU8GF38C9fQ4PiwXhAK/mrYcm?=
 =?us-ascii?Q?JrsmBtVAtaSR7X55hLQI6SEtwcIjSBsMlA7jN67tm3+bx7yflafh4AfBmnLV?=
 =?us-ascii?Q?bY4uE44pxtxPsIq3QnonUdtuGKJK1FcvqLDsjglC3ngOPwGBoSBk3iteKXmy?=
 =?us-ascii?Q?9joBPPHueI5rWY5UmhlihD2Wve1dkqeqrK3XrZEe0nnkEbPzkeit89gZd2qw?=
 =?us-ascii?Q?2mneszgow78eX+gUb1qP+JNTzEiDA3W1KMr1pH4eloIBbFPF+Fx3/ysKKdom?=
 =?us-ascii?Q?U/JBaXn4iRNNUp5xNxXp6/9F8G5gBtvXxtSNiJZEljjLBMuwJaGi91X1ILFN?=
 =?us-ascii?Q?AQv35wdSkmOnySMf2q1WSsT5pU/tabEokjTZnkeojxPDEpZ/kawqZ4lavLEj?=
 =?us-ascii?Q?jzasC3NM3D1ni3ccCw0WH9gpYcEI2u31kE04I48lKCUhSMhhe/GhIyTTcO+j?=
 =?us-ascii?Q?5iN0PdarhIGTvfOwvVAM8mZSuXA8GQ8RpiKRrhpz3A73Cw8JCalPue8JHAF4?=
 =?us-ascii?Q?PD95Vu9f7ZpvkB5RGppp+Prw15VyePt7vA45yt1kyMRSKOsuqTbcJinPmwe7?=
 =?us-ascii?Q?WbhJoHO6S3jwdvrvAAOd/97W0liVjU2NpynsKnAF0mVABfg4HtdbrKuvDb2X?=
 =?us-ascii?Q?UBjQKll3C+os0918DC/Jkk9t6WMOJdbFGUkZtEb3I/6u5U1/RPsFzHX7MObT?=
 =?us-ascii?Q?kuYZKbFWtrjFJlsIz8p8Jztz7Iev2kWg65e3D5VOttY345Dxnfw9eE4tfwnt?=
 =?us-ascii?Q?ikczJRzlPVmvCBiX5pT1L5PCsBJZ5tJeBAfQsT+9bvW8TPnJf/+ruJIRhNeL?=
 =?us-ascii?Q?MyeC7ze4UmcxOJ9XQwvRuijsoE6f8z69YZluBunTtLCB41xNAlzgvhNqry24?=
 =?us-ascii?Q?Gva2gveB/UPqGQsesP5tz3SydLLgBfHGAGo8tX4yPJv8vnMmYRBdMe34HnkG?=
 =?us-ascii?Q?4Yk3IvOF6zllgmYFMba71mqTmtiEca58CjirruM41LPKe1TBUstbcL0lyOh7?=
 =?us-ascii?Q?+Ir1bmcUyH0BvKXteG/wzxhMId0Yx4iikMaBovcTu0kUu5JCMzjQsYLKj0hY?=
 =?us-ascii?Q?2UuCmpSYNfdGlTqTLLVEgOJMc6lvt7lHvm29c+jMqv/55XBBlT7oXe58fou1?=
 =?us-ascii?Q?Z6NkQHjJltYg0DvrLY5M007p9hFjfuDBfNfOC0Iq0BIl/6yEPxTIRGOFRpTa?=
 =?us-ascii?Q?/ZagKVsVuapphKahVnqUDVat8yJIVuDXJY4qd+E1jfQ84Dc6DCvtKVyw04GP?=
 =?us-ascii?Q?P8DNdvC2u+VZXWhSJrt+ISyPWiXR8SXk2dIAUlOC2taLQa8fDK0qprhK0ZLR?=
 =?us-ascii?Q?oEcYCJQsdp3G6Kexf5tZIG6sX9+PX1BwERPeB6wYPYRFYcBqk2/aYX5Kx82j?=
 =?us-ascii?Q?VppwxaYXpxhdqGh88jlwQ1L4W+Hs3/vEPuPzObDZN07oLgJ40CFZ0iim9U6n?=
 =?us-ascii?Q?ManomkPxufMtBDBhxWp1/iMoJDqEoUFxfiHAtHsDo+wCA51Xvut9sL5p6SmL?=
 =?us-ascii?Q?/iyiPw9RpYP/zAw51KnUbQwb2qxWED5v/B+5PHj63QRayyESUYrOXI3THCDr?=
 =?us-ascii?Q?53aaZH/h9zbSSMQJRJRdQ0ahesRpGIAmUubF5fSyNOfu5WiKHFShrpBzA8a/?=
 =?us-ascii?Q?FwJzwPpdGUd6QjtEVinJqJL2ltE4u3N6QpLtDKaVqzeD4dheqG88UEZJeGbb?=
 =?us-ascii?Q?ADd+Dw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:55:51.5284 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe5f3d7-5ab2-40ea-ccf0-08de5916510f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8281
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
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

To support accelerated SMMUv3 instances, introduce a shared system-wide
AddressSpace (shared_as_sysmem) that aliases the global system memory.
This shared AddressSpace will be used in a subsequent patch for all
vfio-pci devices behind all accelerated SMMUv3 instances within a VM.

Sharing a single system AddressSpace ensures that all devices behind
accelerated SMMUv3s use the same system address space pointer. This
allows VFIO/iommufd to reuse a single IOAS ID in iommufd_cdev_attach(),
enabling the Stage-2 page tables to be shared within the VM rather than
duplicated for each SMMUv3 instance.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 99ef0db8c4..b2eded743e 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -11,6 +11,14 @@
 #include "hw/arm/smmuv3.h"
 #include "smmuv3-accel.h"
 
+/*
+ * The root region aliases the global system memory, and shared_as_sysmem
+ * provides a shared Address Space referencing it. This Address Space is used
+ * by all vfio-pci devices behind all accelerated SMMUv3 instances within a VM.
+ */
+static MemoryRegion root, sysmem;
+static AddressSpace *shared_as_sysmem;
+
 static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
                                                PCIBus *bus, int devfn)
 {
@@ -51,9 +59,27 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
     .get_address_space = smmuv3_accel_find_add_as,
 };
 
+static void smmuv3_accel_as_init(SMMUv3State *s)
+{
+
+    if (shared_as_sysmem) {
+        return;
+    }
+
+    memory_region_init(&root, OBJECT(s), "root", UINT64_MAX);
+    memory_region_init_alias(&sysmem, OBJECT(s), "smmuv3-accel-sysmem",
+                             get_system_memory(), 0,
+                             memory_region_size(get_system_memory()));
+    memory_region_add_subregion(&root, 0, &sysmem);
+
+    shared_as_sysmem = g_new0(AddressSpace, 1);
+    address_space_init(shared_as_sysmem, &root, "smmuv3-accel-as-sysmem");
+}
+
 void smmuv3_accel_init(SMMUv3State *s)
 {
     SMMUState *bs = ARM_SMMU(s);
 
     bs->iommu_ops = &smmuv3_accel_ops;
+    smmuv3_accel_as_init(s);
 }
-- 
2.43.0


