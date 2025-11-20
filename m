Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5A6CF8859
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 13:24:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM4dq-0005ht-V5; Thu, 20 Nov 2025 08:24:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4dp-0005hV-CY; Thu, 20 Nov 2025 08:24:05 -0500
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4dn-00028J-Hr; Thu, 20 Nov 2025 08:24:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dwPAsNuaWGqOBW/IiqYNCC9C5W1WD8keun11Niu95UWe+LFzNcG5JjKas7ZVAScTDsDTE3Bu4MuLTSfKvu2z+kj5zKOzpYltEwiyhgaJ0jHx3M+ZT3HsnJIIs0jMvEMx1q+HnlOYAhKVYXVyz2alM2JPybRMmvGN1SqFxZI6jRjGie/caFuvkQV74mE/YwttOds/j0MAB31g8hJ2FFhhWGkV6IBbV1LlJU33usVMgkjJmq6br1EzC8t4H43E1kHs+IMtFDfJzojn6wjrPnwJ8vWgkuo3FMm/BADMef1fDeSYLmduj1Ff/IartmfJhzXFeJ5p4c7HwOvdPqvPUGG1eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXvt0rsru2ONeY+KpFokUmRD+d6oFT6Mo+y5q+5ZMMQ=;
 b=iU4aHRcXr98pAkqOIpt28ClWjfpb3IxOT9tFgaFteRSaMSw00GFhM9/mGYmVV0Vs2LpEvofBLaZOjUbzqcDpNtlKseYcYvDqvR30OO3aKOrm0ZKn98rd19yLwYXwzfMGywCehidbpMxdoQSq4YKaUrfprV+Xv7BlNAddSoBVulCSuoK+4TZT8u8dBwV9rxTy8nK96BrPYW67bSKtdHdxfQnqPc26tsMMvyfO70FfWu04yyHa/yds7r6NzdUJVFjxZcZrpbP8QQWEE4Xr8oEQ5nxOc2mP0BGp1MU/uQYHlJP2XvlpZnRlpU98/LSQASfpjQ8ZNsRrFIFCF2GpHas3dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXvt0rsru2ONeY+KpFokUmRD+d6oFT6Mo+y5q+5ZMMQ=;
 b=QzGFbATb2cdwKroW9yXYWhaD5BmRUtf+SnFrpPLGUswwagQPBo88dmNMgvuGj6oeBpLXKjfYAAIjALIr/V+upmz7kXHs4lGJCt7Mslm9wCh5zX23z1D1PGriycMUQJv6gGfVH3Kf48gSAe/MEZMKGmjvSq5skGqLVWfuIXYFqS5NfiN8j0oiyT5rpqPY0maBt1rUvz6Vf3rzQT1jOJqZVAciP8HiyFufKQuZ1PDuEStTvpO8fpDW63ZDtJKECpON7l68DUcQTgs4M/HZ5ykWX/vvMELxB3HkVA/5ld3nV16xXPQufX81SxFH3rB90MYNwKirAUcOCTfgEwT8FBB2Og==
Received: from CH0P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::19)
 by LV8PR12MB9109.namprd12.prod.outlook.com (2603:10b6:408:18a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 13:23:56 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::63) by CH0P221CA0018.outlook.office365.com
 (2603:10b6:610:11c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 13:23:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:23:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:23:40 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:23:36 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH v6 07/33] hw/pci/pci: Move pci_init_bus_master() after adding
 device to bus
Date: Thu, 20 Nov 2025 13:21:47 +0000
Message-ID: <20251120132213.56581-8-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|LV8PR12MB9109:EE_
X-MS-Office365-Filtering-Correlation-Id: bedd709e-f27d-405e-b30b-08de28380eda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZCYxBaBIe0617XLdcJIJOd9uZXnM1x2XIG7ccTQaKAQhLqpjTt1XWhWQ00VJ?=
 =?us-ascii?Q?Cek9CK4DdBSHwOoWDlscb+R6oytd2FuHeh8rGweL8LFDgOHySLJ5Az2cAbrs?=
 =?us-ascii?Q?zyagLwLfcLs9zhm8Unyyyunk1N3PbFpAW+FTGPX60pq7tR+uu7HqwUzTvbcc?=
 =?us-ascii?Q?5YHgcfwziYMdivkFd/ddeMWe4syhevZDja4Panz3PvZ5qlIJiq/ehcjTWd6B?=
 =?us-ascii?Q?oWIwdTlzX2d6bzZXuzC9+x7EJvchKwi+3F+IWvlwbOGLzuGM0lI+1i6+TZwK?=
 =?us-ascii?Q?RlrpdnAD+vskEK6uEV3h2/6RNCQYWHbArbVShP2q6DOAX5esKum5EtP2wYFz?=
 =?us-ascii?Q?/hEnbliCe0QNlD3EBxW+ysg4vQf90C9xDtHVDJ5AJLdyk1G/2Hp8Wf8IQBqS?=
 =?us-ascii?Q?K9X85LUCk+A31dyAz3Dcwv4tMbl6a1u69B8BHDIkuBA3hrqs7/1n5AZEVgiX?=
 =?us-ascii?Q?WDvOtdPC1o0pbF2Xft2cF75KvRCruWKX4ADKZfqNZ8sENctSxuC1EoGEG6n0?=
 =?us-ascii?Q?LaLwtiOjdlWBorgRSxqbGVVuRDF3N0DQZQZYU9EhwZJwAhtUI24fxF9uYdJ6?=
 =?us-ascii?Q?v36YY6rm8tZlHOXTsp+fxipB2Usm+BNqGmgeVYxHNDZDb+l2xUUo+ATOWdzD?=
 =?us-ascii?Q?6twe5X3du8GwUip7IQom0USnFufZdcIalbJsIpCoCLUnuhilHL1/c6VPNvrR?=
 =?us-ascii?Q?TIdZI7MicDBWUT1l4oVgwkRiwPgzrnFrs+kgmTruBScuE1wGjFi5QUbcXyLQ?=
 =?us-ascii?Q?W5FQI8RH6GQGC7xKpVFr6aXdRkcH6mvGMl4GXXnLqUJ7apg+vpxaU5WQ9Z9A?=
 =?us-ascii?Q?WURbtmoA0b3+da4+QPuVL/o8iVVlLiBhLBG/g/oevsB4Tbt42d/KRGuyDtF1?=
 =?us-ascii?Q?0q+gRpOmkqK6fIpPYe8iveLyIGCnIeNR1AFHKBSAUfdyrghLG/3/yVeobxYM?=
 =?us-ascii?Q?13oWNahDaEu5AZ8ouzAObDjAHRxKfAGLfy+inY5kfxMWW2D9Y9JDZH9PHToZ?=
 =?us-ascii?Q?9ReEbyf1bQSc9Uv/vu7ZViMNeTfcx1f8PAflStAx8UI5Tmo0CRJQDaqwF9qC?=
 =?us-ascii?Q?6b3s/6KTbBQlTGreMiPQUwOwWgvN1utqQFEdTev+leCpwZJsx0ATJOL4wfSY?=
 =?us-ascii?Q?EJcLaursYTg6QiyhUuaaN60HHbLH2Vfh9LFd6vEJ6OiiK8Nr2yb4A29K3QBT?=
 =?us-ascii?Q?lo/p5VXBL//BN2m75C2HkT5nlfkDZ5qhHmcnTiuFYO0dgYdhHQwoxvW1PBZA?=
 =?us-ascii?Q?qnhPExNWKTczJH6nFwU0YdX4g7RwZ8pOuxb/kUmewbM0SGF/mwpd2nVu3wam?=
 =?us-ascii?Q?FfjHQRs+DL9LuXgQ+KKGbOm9FKmTfgKmf4vi+jGWBo2PF64l0dI2JHQcAIfI?=
 =?us-ascii?Q?r81R7wwOS8ZF1EoBg1kQLyKm/ZfXCpe4+nZP5Ra23h1Zl7nyO/GS6nj/HEX3?=
 =?us-ascii?Q?QdUZOSK29FGkSNTz56lsX7uBCLQrC73iZ51dEHBO3HOJnP4svpSFRaTp4ZcA?=
 =?us-ascii?Q?9eCi0kahWqifxHTXnq1UwtmDpCY8JpxlYZz9oqoJut/N53GppA58G8bvuSHX?=
 =?us-ascii?Q?IeeTqcWUkSplc20iAV0=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:23:56.4094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bedd709e-f27d-405e-b30b-08de28380eda
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9109
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

During PCI hotplug, in do_pci_register_device(), pci_init_bus_master()
is called before storing the pci_dev pointer in bus->devices[devfn].

This causes a problem if pci_init_bus_master() (via its
get_address_space() callback) attempts to retrieve the device using
pci_find_device(), since the PCI device is not yet visible on the bus.

Fix this by moving the pci_init_bus_master() call to after the device
has been added to bus->devices[devfn].

This prepares for a subsequent patch where the accel SMMUv3
get_address_space() callback retrieves the pci_dev to identify the
attached device type.

No functional change intended.

Cc: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/pci/pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 8b62044a8e..af32ab4adb 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1381,9 +1381,6 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
     pci_dev->bus_master_as.max_bounce_buffer_size =
         pci_dev->max_bounce_buffer_size;
 
-    if (phase_check(PHASE_MACHINE_READY)) {
-        pci_init_bus_master(pci_dev);
-    }
     pci_dev->irq_state = 0;
     pci_config_alloc(pci_dev);
 
@@ -1427,6 +1424,9 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
     pci_dev->config_write = config_write;
     bus->devices[devfn] = pci_dev;
     pci_dev->version_id = 2; /* Current pci device vmstate version */
+    if (phase_check(PHASE_MACHINE_READY)) {
+        pci_init_bus_master(pci_dev);
+    }
     return pci_dev;
 }
 
-- 
2.43.0


