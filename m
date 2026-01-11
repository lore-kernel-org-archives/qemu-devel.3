Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344ACD2502D
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 20:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf1Y8-0006f0-6b; Sun, 11 Jan 2026 14:56:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1Y6-0006dv-Cp; Sun, 11 Jan 2026 14:56:30 -0500
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1Y4-0003s6-VM; Sun, 11 Jan 2026 14:56:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rT1/FLjsdizrbSZvC3Lisex1/GYWLow9MQ4JiEOJNgZP7La0oJZaTFzQ0jsdMOdJHucpgvEpaE5sdgxtvlcRqokTjU6cibKYDNysuu31c0EpgQTRp+ge+W4dQTspnMrBFy1yxL6LBBf1QSIhn5UaG+UOtpxAqa/rxoBNqsxxOR/VX5HNEJj3jRuEZn4oXWlZ4F66/XhEj8P2cbtQYhSrVVnEYYKUVJI4pm2m2h4A4OG3jJv91PSWrUaJ75hDUg5+BjYblkM1UVHq5bT9OqUpLPbCFGIf5ljwIC0geWRzukzAauD4KvXUOrI7eBzzpQ7BMlGYPewuvvTyiepvQzQW5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlLt15/mAHiDoXl6RWBxvgXTYW0tMNmaTYq32DllFZo=;
 b=Tp/U2R6rpAVkMtqyv0xS1r7Pp3PoJmVuzS/uK8WbzwPSFw224SFFoq+xZaYRBtv9sOFq0veU+2Ugj42kQEsvCnz+6EirprjEU+ZVTdp0tF64ADJnNfOTOpXjZ89brQ9MbZDo3suZ6LHShmKbtrHDZmW2t0VXLWmuTxh3zy/qiyjxRX0KLiqKTv++K7aq6SX38pyg+tEO8kHn5gjHT+fKzldQks7PA9JZucNGnqoE22uz8swZRc/bzM7lPGwoug2Ni6TTBWgwSMonHV28QRo04F4YK0C7LDSWVyTyFiR9fEw2qFl++ea5CBaXVKE8qXXCBjquSagX3cnW/E9+8rwJRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlLt15/mAHiDoXl6RWBxvgXTYW0tMNmaTYq32DllFZo=;
 b=cBjdDTpC6K60m1Eq1XfrYjPGgQhVfKNve6tz+8msn42PAAUDZBJ22mgX+dQL3jOAWbBlVqgMaOeYSB3dgeHl/Fh8m8QBMrnvR4bpo+5aLuMS2XFKePGa3gzlxNoDSyeejpfWpG6W7fls7mCtLusqP5jK0Od1uL8gIPe4VF9AicX7lg7S4Z2o92ieq1TCUu8Wz7zEDJSC5vW95Nf68pEroPEIjep/yFJIaqVyXIROzyJZv4vaOFWOrIFG449/Bvww7Q5pg2+ZP694KokAJQayVTmYTvvGhX83msKsUlra0JuncO5XykcGc19c+DUBZbucEAC5xxSga/pHSNzTC+xONQ==
Received: from SN6PR05CA0024.namprd05.prod.outlook.com (2603:10b6:805:de::37)
 by CY5PR12MB6408.namprd12.prod.outlook.com (2603:10b6:930:3b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sun, 11 Jan
 2026 19:56:23 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:805:de:cafe::8e) by SN6PR05CA0024.outlook.office365.com
 (2603:10b6:805:de::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Sun,
 11 Jan 2026 19:56:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 19:56:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:56:14 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:56:09 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH v7 06/36] hw/pci/pci: Move pci_init_bus_master() after adding
 device to bus
Date: Sun, 11 Jan 2026 19:52:52 +0000
Message-ID: <20260111195508.106943-7-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|CY5PR12MB6408:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bb3c39f-699a-4a3c-af5c-08de514b7f25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QdV7pfSIvANKnR70G2zysLVIonMb0Q8znU2uTMlC/UUWkuYLy5OO09wdJa5n?=
 =?us-ascii?Q?7M7yvjASU+Im59jWjOI/NJ/2ei+vSNqWExiJST0stFwH43cur/X3O4TxkI+p?=
 =?us-ascii?Q?MYei1a/9xxicZboA+1PtCb9gVus/OdE8P5vAD2+LVQ+E0DallKCyt3ur90a2?=
 =?us-ascii?Q?HgEkw5ixdkee8dJzID9san5DLk44VFNWJgOBjovsUJyIt3A1BSKnoDi33cmh?=
 =?us-ascii?Q?eHegXsMcnOnkcwghDz4JWpvbjDyCwclyWw3jk8Nukyks1fHeCQY8GzzEv7jC?=
 =?us-ascii?Q?G2tqn0gNCBeleb9g9usk37nI9CthZApuq/ONZDycaw/PoYspREpkQHWzQSos?=
 =?us-ascii?Q?kU1bwz9p4twcplELT6q325SmzMX6cQX31MzQXCAYe8vgyTa8+De1iyB6b1nm?=
 =?us-ascii?Q?I6k++bCofF5pi2JRyhYf7ePeakrQT7E7POz4v/Pz8rfAB6/GjttMNPfbNpKP?=
 =?us-ascii?Q?SUSbffXp3ajXGn/2nxsjFISIcBhaoqwVHEMCGH8DM1srdgRHp0g+hEXh66V8?=
 =?us-ascii?Q?0iEFeEXQRZSS/J72r22Xdu9Zzu+6fZOXBvDIj7s2F6Ze/Y321FkLyjVIQNnA?=
 =?us-ascii?Q?4xSbDK4AnMhtvrV4mG31zLi+dcNHPxqa3OgbGQff9ONPNtcRch3piZgOQAda?=
 =?us-ascii?Q?n5zKELoCxyNuBgmYuPiHdjQoSiaDU1YL0wTOV7eJQpLAXYz3iodqFggJwuW1?=
 =?us-ascii?Q?+wyKCaxIOI9bvBHbYjykTtHAxwbFSmZ8lvyOJLN0Bl9BGFDpHiHIiQqzhnst?=
 =?us-ascii?Q?EJEm/jjhDdQz6690C9mu9L9rqoFNBk+Qd7/tijOdt5rMydEu6cva6lGoBH/i?=
 =?us-ascii?Q?p1VWiHYBx6v/OFOI3mvYt0L7UtoCCmBi6S/VWXHJU0KAK1JNTBaylqSh2Llo?=
 =?us-ascii?Q?DofG5dWOnCM/zwJKDhf2GG5aQw+buROCOh2GLqQR9+56ORgC+iH6WDCgrjpb?=
 =?us-ascii?Q?Vqi5Ow/Rgm+SqG0+Pg4vuHf0LvMg4Dmoa8Yn/UFhT3tL7b/7tISEPsgtSLI8?=
 =?us-ascii?Q?/C8ImgqhkB4DPrjqdnIDBxqYN+AmRRHqGBFQgrn10/BhstuZ5hzT2ijLXvDQ?=
 =?us-ascii?Q?mE9fIWxVOsWRBsSlQX7TjqLggJc9xkZWAxDhxmvR5Qh6Pwv0boo3frBaToZJ?=
 =?us-ascii?Q?Eb9OmkryY75L/hCj0PC8MlYRZbPLmO8cdkxl2UrEWlZUymakMC9ro22FZ19d?=
 =?us-ascii?Q?w5A5nUrveH0rYwaOP9esZBmVksbKcganpId1yJ2wn33G/nggorUCYNKEYatj?=
 =?us-ascii?Q?IgN+sty/mobJhJGTQEvhenHY0YQmNm8IAzt4ks2WzP4TBR23fmhzgysDJFJg?=
 =?us-ascii?Q?T1GZPKGuzveJB2g/OKTCM+o57ekfnEIQj+wwg3By9EmdXvhDUVzZYHhpE1Kp?=
 =?us-ascii?Q?UQRtPPv9Q5D9CkRB2O+5PHQGAnbhjNK4VhQle2zxWlPwv4vH69Fv18Pkqf9F?=
 =?us-ascii?Q?hqnmDA10d6sCvFR9Ya0r6GeX48CsdfJ8B1X05Qy9FLWK+4LvPtakzXLgKgGk?=
 =?us-ascii?Q?lb0BWGUEl8QRSBMCyItaoY+GGUy8aRXEDbnNjA7By9DU2bJp4gcj56e8p9wb?=
 =?us-ascii?Q?+EsE/FRNm8x6+SL38qs=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 19:56:22.9232 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb3c39f-699a-4a3c-af5c-08de514b7f25
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6408
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/pci/pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index a136e772a3..a852694cc9 100644
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


