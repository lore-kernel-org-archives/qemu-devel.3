Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F49CF65D5
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 10:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkK5v-0007EG-S0; Mon, 26 Jan 2026 05:45:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK5t-0007C1-5N; Mon, 26 Jan 2026 05:45:17 -0500
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK5r-0005Wx-PC; Mon, 26 Jan 2026 05:45:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VoVLF1DQHlgR2cIjksoRLM0GBw8uwT09rtIZjG7wyISlLqPsBjNpfvBfIVxCefPIVLaSRtr8jXZWI3L7qjMjLZtXhTet6/gdFrp+FuMHgGlogxPWpUiYq2EjsZLYPkmy0G72+fbzkIRIuEdhR9Nqgck3fCKwNIlSDTGgtdnPZdMRQgnFfgIvFD6jqbZSQL4K3yjqff+CFMCRo93dA8yGnqFI3wK8YHpJltLh5s61an5Z8tyU0ExgjhC5AYkgs3csIWKsVquzLeos70b5IrXx3rgDz8VZn6zsCBZP8Ynam6pOTVK5LPAi33m1hMZ1VYSL3gCFRXaHIncQOvrj9btZOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zdsbSiBZWdnVa6W/nOPXnMkvGsScBnWnKlk/LxrCt4=;
 b=QdiAP2BURsI+apJ04EVfXYrSvzXLfzo9msa62y+Xdct0JZT/qaX3jNASojEPoO1HC1ZzVeAkgyCLi2zGaWL9mmpYNZoG0aDvxtMRfsTBxKuBuNOqewFbaiS3mXj0DW7nYNP9OjWHNAkYToH11nixaqbZW/j/8Ga2UiTmdGnCvtTSVylcSmytX3H4cg37xKSeMj9PNED3RiQ7kU1GO4ebSf4GcuXdt+JvxI+CirPub3QGZCtGGPiRlhcMxnI9NXBH9SDNNmgf5WLeaCQjMpBbJbLov8boiM7G4i87Dk3RaSZaMINlaYrmNHcIi4GphxviTEsoBMVkGQgfwI4O3RGuTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zdsbSiBZWdnVa6W/nOPXnMkvGsScBnWnKlk/LxrCt4=;
 b=gKCYefOeRI6MCAvDZZ2pdGZuwhK2fjPovKWKuYrNiauGlhmyXm6gVHJ/Zul9axMx8yHBHfLvNYZo6LmOUFX2O0HCoiVQEzB7dLlgSwckRa61hcdUhu1hMJN67dnph5nDnlgJGARprVdYgkrhodWxp96vz/L0Udgnjbb5xLoilRnlN9wbdwIMSE3y5eGiXz+VVIP911A+UseXSBTWQ4FBpj76ZHtDy7DTfxSekb+aVUD22eBdRC6eg+otHT6UNondysRf61JXKkw7n4akFnzUjTU3XR7kS7KzFcZAXPKncTxH9oCoTQkqp0AV5UxtffP9h8vkciRLGYghWvX6SrvLow==
Received: from SJ0PR05CA0172.namprd05.prod.outlook.com (2603:10b6:a03:339::27)
 by PH7PR12MB8156.namprd12.prod.outlook.com (2603:10b6:510:2b5::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 10:45:10 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:a03:339:cafe::73) by SJ0PR05CA0172.outlook.office365.com
 (2603:10b6:a03:339::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.6 via Frontend Transport; Mon,
 26 Jan 2026 10:44:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Mon, 26 Jan 2026 10:45:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:45:00 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:44:56 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>, "Michael S . Tsirkin"
 <mst@redhat.com>
Subject: [PATCH v9 07/37] hw/pci/pci: Move pci_init_bus_master() after adding
 device to bus
Date: Mon, 26 Jan 2026 10:43:04 +0000
Message-ID: <20260126104342.253965-8-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|PH7PR12MB8156:EE_
X-MS-Office365-Filtering-Correlation-Id: 609204ed-1704-4dcd-a661-08de5cc7fa47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Gs5WJTRY/mi9stKeFRPV8evmyjLDQhqGi1rQBDJJxhdZWNAlEeLaAjkGy0WK?=
 =?us-ascii?Q?1Pa416GqnGD6fjcUblf036JGJYiAq3sORkUzalMuZuvJ452uMWNy445PDJau?=
 =?us-ascii?Q?TqdCRjCHAiFN9sSj5NBdLhaIKE4w/ZrrJbKTq41emilNdbR9QtXp8cylcWp4?=
 =?us-ascii?Q?yHsUCy/0X1pKyhBqkyUgphm+/lECnLERf5pkWnQFdeKwA8C7J3dBln5g52qE?=
 =?us-ascii?Q?W0pLYkt7GKVD4KZ6NCUCUh2nFrSrBKNwC/7bkPd062qkVdiaS5KLaz7XqXvu?=
 =?us-ascii?Q?EhEBD6WLNkX1u13TJhvH2qj0t0Ilx14oXWr2Ve1uWAkRfrj2vmmLDOIKyoLi?=
 =?us-ascii?Q?XpipR6cOjfl9H6ieig/JFHicJ0q+lypdRwhqsyX0WABP5cVqM+VYZoaudHJT?=
 =?us-ascii?Q?Q5VPt7JeGINX4m9yPjZlCDB+NeYx0mnivDHkstUMg1q/CpR0vRz/vbqJKSIK?=
 =?us-ascii?Q?1Y1C3jFLP6tBLA/E/YELuc8s1WT9fALvF6GmiCDLDtM27CI5ioKQpVfqRRVT?=
 =?us-ascii?Q?N6v8ikOL5lAQu3F/xGEWqmAhR3OKBr/oqejaIFjiuMGKP+Izh2hvn/yrk345?=
 =?us-ascii?Q?oxmK82YmC5W1zJBW5VfUdDw3PpY6x4UPcALm5A6XLt6ZZz6bvaqSsANNuntY?=
 =?us-ascii?Q?WqD1OEYdIZFKfBuJ7FeyPdve5eI060+6aiQdnWH5aaj/j7L9o2WZbp4mNBcN?=
 =?us-ascii?Q?kTN/hTp0kuiAW/jpamC4+3UXpn2uiWkTSeOpTf+qSIYlnclCTtcxoBMfrGTE?=
 =?us-ascii?Q?cvGSQo4NK0TSPQ/cXuHwjc0HztfLueFg7NhFy+FSDm4uDSz3ZBhPXvxDCokF?=
 =?us-ascii?Q?fmX6c64ptEy58pCPl0EPqqPn2XLBcEPnhAKCOPNFpOWXjKH1nQQbbXxcnya3?=
 =?us-ascii?Q?eKTwk5iPugOA+D8k+L86kIi8ismiYoLeYxyba2gOksXU44M+IYcDjqx1eR+t?=
 =?us-ascii?Q?xR9C1QfkvvHx0wT+hPjlj4VfTE5IyByH+NS30sGef1+RX47xzQ5Yu+fAULr3?=
 =?us-ascii?Q?ngPDdvg8HCic7jW2SsS5W+g7dzExSfR7/0aOspSZzRE3OpJ67VOvenFEYF4Y?=
 =?us-ascii?Q?BiAdIYVyMBVWUjLFiVG0gxv9wGi22e2yRh9VlxVAveOmBFpXpiP+zpLxcCXy?=
 =?us-ascii?Q?7IxmEDFQ6rppMA6Hr0jmTqqVCOXh9lfHQDOEF78uwyEs3OiYmYeYQolFyHw6?=
 =?us-ascii?Q?VufywpQ2quaupl42ZcK0jAgYfGNfSQOQLxMFPqAwllN1FKuRUbNLmcPtEUjQ?=
 =?us-ascii?Q?aPZzEwhH8fO7Q06f2v6b0FsJd3NeSh0SmXJPVzSfWmA3b7C2IictF9LzjSCt?=
 =?us-ascii?Q?ePzxFwqjyKs8j3Wdq2R/N/WR3D7NQwEbXMs4usHhIga1x30luMFSre0JpBif?=
 =?us-ascii?Q?GyTdieM0MvT3BvIE7MZrksEZclGgibOCG0TdtnU6klQZhKw0fLeKNuzUlOF9?=
 =?us-ascii?Q?B0GK3MJJ2oZ9DY2oIdgMO2bEu9sZ7M1OVspKhPvudr+pNK8rmM0rzDj+KLny?=
 =?us-ascii?Q?BUr3SVgVYLXsssu1jcYHeFjXZN8YGQIH/R1B9BdnsMw/PaA0RudL7jXjbzyf?=
 =?us-ascii?Q?kLlIGxizAzMF1LID4qVttcUSYbS+4Go7OFkfjYiXwzjUAbeNkekql34ARiZE?=
 =?us-ascii?Q?RYR0gU9Icd6zy/N0kG7wGjY1UJlbtX8BzcX2yp3h9UeR52WrlQolxF+v7sF3?=
 =?us-ascii?Q?fgIffQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:45:10.0113 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 609204ed-1704-4dcd-a661-08de5cc7fa47
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8156
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
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
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/pci/pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 8cbf5f5d70..229ea7cfb1 100644
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


