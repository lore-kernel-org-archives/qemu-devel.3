Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0B4D46962
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 18:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vicRK-0000N5-84; Wed, 21 Jan 2026 12:56:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicR1-0008MJ-N9; Wed, 21 Jan 2026 12:56:07 -0500
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicR0-000158-8R; Wed, 21 Jan 2026 12:56:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2nQWiNd2T2jP7ryldd8wBDLkDEVLOR4his0v+3feX/zD60DsWahGdgKQYQJrHQwSfaaPmtPCWlJzzCtNput+M3DzXIsAShxytb0uj1i7mfQS6xMkbEnxsHqgqukRSV8kmS6F5UWBCzcMjsQvaDyn6oxHEGcqpP8UzTQhOXmQjviFJys34iiiX58y7M1zj/GHwgaQzyc+L0bUbbSuBYJcJ6rpYqgBJPjOsU1EdNmGIgF4yvlDoLW4l6Fp9nm6rNbLkA0JfNy0kXb9lLsrzmIu5OztCl6WuRAI46w35Ss1IEGvG/0acSjngkgs1OpSpDGYZCC6DmLYdboSP4r9tQSTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zdsbSiBZWdnVa6W/nOPXnMkvGsScBnWnKlk/LxrCt4=;
 b=LLV+DyJQO8JKU0Po7pLUbBg005cC4ydtv+aan0DvAGmLMmLMRACT2CK2xoNVF4YDEfOne5Ud0EWqtyz/UIQs90mF+TAwW76bPT/esAlYBxwamhc80DZSeeSxSWYlb6kfrd15BtVeiVTnfGkwBgsNglF3QQQjPu/onobpTv+kpPmVSvK0bLs23Q+U8Wt5wsSG/UfNxVW43DMFURKUZQ6ON07QCzmQW/QQqTvKG0TopTrVeZM/AdgayFbF1cmXpiGKHxm/hnQ7Ad8xrF2q+W9pUe0AaF1do2Bctrfc9CKO6NOS7/avHY1KDNasm4tKXPNa4fZjDA5t/BaQzUCOVobgWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zdsbSiBZWdnVa6W/nOPXnMkvGsScBnWnKlk/LxrCt4=;
 b=pbBvXDqLlb4OqkZqptHZW0p8YRkI4+F6r0KhW1W3LzFNm1oapkkcdON2QFB/KnAjJrIgCK0lJmGrS+BOH9d8oQ0GbzKgU0QVX77DP69bEEZ9Sun26/YhuG3t6aJHvfKAmNJbw/SsUAIEmPCuIldGtWhLhUUSeMr/9sJJBL7CJsyYI/q748V2JzZEbsIMWdEWEK++ecVM+PEgAkxRu7LdNdsSx+QdgaHCBB45c9ttkL09K/9MiIIgdNTLNfuzAS9il+nBOWpHdSs8Zdtdky3HEZzjURLtXx11vzqIL5O/rPnf/fWJovX93LviIhugFDiJLjUWORZWrfwP0GXICp420w==
Received: from BN1PR13CA0018.namprd13.prod.outlook.com (2603:10b6:408:e2::23)
 by CH2PR12MB4086.namprd12.prod.outlook.com (2603:10b6:610:7c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Wed, 21 Jan
 2026 17:55:56 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:e2:cafe::76) by BN1PR13CA0018.outlook.office365.com
 (2603:10b6:408:e2::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 17:55:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 17:55:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:55:31 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:55:25 -0800
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
Subject: [PATCH v8 07/37] hw/pci/pci: Move pci_init_bus_master() after adding
 device to bus
Date: Wed, 21 Jan 2026 17:52:12 +0000
Message-ID: <20260121175248.87649-8-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|CH2PR12MB4086:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f2cc9f4-0323-4aad-c68f-08de591653e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Qgjh8ACI/+MIsKwAf4DM5YObNpmmNy2Q3Ad4n4LtQPQp+KocB/x46GsUemV3?=
 =?us-ascii?Q?UBBYyiadEuiSYss+2FTc6yeDoLap1HA5fULQD8EwvMIm4108GqUNp+q5xOpd?=
 =?us-ascii?Q?2biffUn6EJyyXiA/f8DJnum65XXfEOhlu4FrQaw6AGapfJIINa0gWYTru1YA?=
 =?us-ascii?Q?ZVgmf+4jdihgKsVShymDZOIyvdFqqL1nFL3vKao20pKVwzhxWcLyaOOjMgVV?=
 =?us-ascii?Q?dlE0/drJ5juFyuLit8ySNRFWooBhRfHZu/ig16pbSt95RL5YO8orSPbV7qDj?=
 =?us-ascii?Q?3me1Rwkg/6MTXsVJ6oYPkxN9OMlwWV7I0ycab0KcF88IN3qIHPFiyXClwI8c?=
 =?us-ascii?Q?X5ggmwxEoDkWdeCAFHYOOl9R9Z0zzdfqDL/25jLijYppey7/BKnXMHOsW3qb?=
 =?us-ascii?Q?kuifKsWrbrOi2QnH6LurI1loGA9niePaqowOps3YHEEtWEBHEAWpuGC72zsB?=
 =?us-ascii?Q?tibx5HfSozocNiS1pyoWVsw6sYYT8w5g2CmuoLS11pk+KW7NUKcq1vQSnjNR?=
 =?us-ascii?Q?2vcbfmqVwbxBZG6oZIp/pjBBP6QqyhXm6kU8pKEx0ieWhmdo0zN3W0tDiCcn?=
 =?us-ascii?Q?rGhsKfgofCswlqbG9rGthIfdsiQj1XuhbO8lkNEORdUwa20DjkCvVk8U0Bg+?=
 =?us-ascii?Q?mEExRhGQetDp5jWwyEpK30EzDGmRnbr8V+sH5TOYIkQmTlBf9mM6IwXzauTZ?=
 =?us-ascii?Q?qAZ0Yra4tRaIPvGoLTQjxb7L0b9UnG6WjHJXUbQYlCjxajTfsTSzYRiF/CB0?=
 =?us-ascii?Q?G8ZWY9LIQQYDM149FgPG2fCiD7MuZuYqDO0YgZqc3R6TgrJHo/AbtKGXEjdA?=
 =?us-ascii?Q?yCAPjY/K0XPGJ6mBjfC0BafT/wYa8ZSFvIVLCHSxws3IT+rhbg9v6Ek26hGI?=
 =?us-ascii?Q?Q9f9xm14rYiULJu8FGerdb/9I4DHvoiVdmlZm1FSwyw726CXRAHEk17mmTb0?=
 =?us-ascii?Q?ICtqA8JQihP1VLNv9yMxwdmFXsw56RlNQGkqM+YT10tB58qJ7eRTQMKqstYi?=
 =?us-ascii?Q?z1sx/cJgNu/Ztm/9VCmmLvPuCM2+o8wSiIxBS6vE8vyO7T94be3GFxlN5mxF?=
 =?us-ascii?Q?QUnLzDPIN9XIYZPzI8eB0l/OG87pQpnr8kAWEYvHWltJNQiHze18VGgtVbaw?=
 =?us-ascii?Q?QGFU3t9D7rm7BmWQYY7jlG2oOirQLgan+bZKrI/lXMwIY5zlyUwrBza07PeJ?=
 =?us-ascii?Q?RQmIDrSRJfgA76karOMAjyAQtbcTleVegI7J4YyFfySZCdfHRl5Kc+xbnacB?=
 =?us-ascii?Q?trpeI0iq3D4FRsU4Nu9cTZCb23hi9Wy+X27u5XhG4IKdEMhXdRLyEXtq6RWB?=
 =?us-ascii?Q?5Eu/QS1hsBoma226M9LQmORmyl6Eymr3Q8LrQHRzr94tav9ncqhI+xSFGv2p?=
 =?us-ascii?Q?N11I+tPba23O981sxV5JP4/WkfhJoQ5NrdrBVvE6hItJAUYDFLcsjNSJ3nTh?=
 =?us-ascii?Q?i25WrXjvIOZRg+sFHO6MkmMwcuoet59s+7uRyz7Wkpdi4bCpqolmKoYhqo6D?=
 =?us-ascii?Q?yWmpfr9wF8pBEe+9eOZVLLMKy69Yv1TyICIuZlx/h0VZBHNr9F2sM9KqZYTW?=
 =?us-ascii?Q?LCRB0i5V/v07JHLG0CpECro53js2YY8fn+phJ1Mih7VsHofrjsDNopV6EiQK?=
 =?us-ascii?Q?77Wsc5TPNVz37ce1bi6p5zGEBIWUwUOpzHSlSpuq7GCvaFgFmLYfueCTkgEI?=
 =?us-ascii?Q?dtZZ5g=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:55:56.3263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2cc9f4-0323-4aad-c68f-08de591653e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4086
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
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


