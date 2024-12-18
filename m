Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96975E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:42:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuIi-0006kI-By; Wed, 18 Dec 2024 08:41:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tNuIP-0006ft-HB
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:41:06 -0500
Received: from mail-mw2nam10on20618.outbound.protection.outlook.com
 ([2a01:111:f403:2412::618]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tNuIM-0004hY-2H
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:41:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrO10TpxpuolDXjcwncjqCOfMNNKY79g4pTF49wccp0EjPPwFhb+Q3eAgsLrd/gN+lYWh2UPshSZq7ke2MNwf4ZwNPVkIif6beMsFbY2Xvql3fSRVL/ClRTFFQ406Whi+d6qD6YlHr+J7eBHcPGXOwyv6otvxVEUkIC2dD/M3XBzBjgW2JPEZmy5RS4F2fGdWSwUKzdo5uOSzn+klD7A+Iyaz6I6cXrnkIjDQOO3YH4oIhvjS9XHbqAp9s7lIjWtpcBzzwMn/AmjSLj4mpn7u6waVi5NGqsh3LcSWT65zWLrS0Vxzn4vbmxDRAe/yBctjkF0m02leeZYDKqyljsPGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAiYKusLrHRrTGVfSy7Cu/HoWxHxS4ZmbTJ9sDkoWtc=;
 b=ywIi9/3e/IoMYwrQNafquLyiVaDa4eqSDakGyyP004BwgOYv6lg8CqvZS36MmdK6wQfDMbwXUFFVaoTdbzDHee39pj/kRS/Y/qc0jAkic1j96ngPW3mH73LPQNB9G5oX8X1v/eSCvWKdiENZuMlO+8wLUzhsn2c6Xwz+uoB7nEStn9VYlK+9p/2H4orke/aT2zhLiqDYKSH5jzZdDaqD5AwAfwKZIi02Xqsc1CQbO+wwsO3H88rKUM4N6l3QRc6Czl5GjceXhwEQGumskhmBt03eOeQeigAoDY4l8UEvW7uUy6tZGMpcl0wozGG6lTZa6PD7GpByvYdBHu7eu3YbBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAiYKusLrHRrTGVfSy7Cu/HoWxHxS4ZmbTJ9sDkoWtc=;
 b=ex1NHX4ZDAuyNvb0VM731HcqT9OczsposHO2Ve9L1nzw2BYJ+BfuN0kEAn7uEt7gO/jKEnMLlP1xdh/bbSa+93xMZiov3bZSJpSh18AVPBZpMq86xKOisw4xZX2eY4DLPu6qtuyYPi0AZhYCkXtQ6qaN1XMOpmcbfEuwW7lQtsYZyfQg3Em8nBusUlyp4rMt/xt2/cnt/jjI6lV6GNtPy9Afca4sJioCb/8IBoyi0kB2Q3JVA2QTn2pq4CFdafBzhxNbA0ohy5D2C9D+s+n6hqjnSfEI1vuIibf8NjeshpoxSVQDW+oXyn9VjRCG4FVYRQPRWuioQLVvaedyvu4ckg==
Received: from MW4PR03CA0227.namprd03.prod.outlook.com (2603:10b6:303:b9::22)
 by SA1PR12MB8161.namprd12.prod.outlook.com (2603:10b6:806:330::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Wed, 18 Dec
 2024 13:40:51 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:303:b9:cafe::3c) by MW4PR03CA0227.outlook.office365.com
 (2603:10b6:303:b9::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Wed,
 18 Dec 2024 13:40:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 13:40:50 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Dec
 2024 05:40:38 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 18 Dec 2024 05:40:38 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport;
 Wed, 18 Dec 2024 05:40:36 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, Hyman Huang
 <yong.huang@smartx.com>, Joao Martins <joao.m.martins@oracle.com>, "Maor
 Gottlieb" <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH v2 5/7] system/dirtylimit: Don't use migration_is_active()
Date: Wed, 18 Dec 2024 15:40:20 +0200
Message-ID: <20241218134022.21264-6-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20241218134022.21264-1-avihaih@nvidia.com>
References: <20241218134022.21264-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|SA1PR12MB8161:EE_
X-MS-Office365-Filtering-Correlation-Id: 9242228a-b4be-4ecf-9e11-08dd1f699628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7o6Qqp+xm9sEHmb1Xm14QpKeRtiVkleY4jHHH3eJ/hr2difiOB1mfxo/ogFi?=
 =?us-ascii?Q?I24wL9ow9vxBUyrIr3+BZhfAbVKveBCr864i0p8b3DMgs0A8YsxM3GcQvRBf?=
 =?us-ascii?Q?9Cp9BrzmxVvSmcF3S5BPSSsoZ3r6WPEOoaeUQWirclkYagC+g7dHa+q+kqXV?=
 =?us-ascii?Q?MPuyy006+ukU7QA771hih7OrCGobgBU8hyv3laeBbIQQ1qSirk9HLksA96cj?=
 =?us-ascii?Q?gWqEo6Uliv3Ta9vA6lcTyulw0RzM3lSZFAXTLyA/yTejNRq9x/BQfLPMp9cu?=
 =?us-ascii?Q?bFclfE3WUQroCKrZIV/Gh57GVL6D9FU6kRFTklPVggBQdRvcKlADJDxdoqiA?=
 =?us-ascii?Q?ylVTD8aKKNUGP6qq8D4r9l5FJZbmOxxiiEVr5BSh9pg0D7Fgn6ixyqxlGywj?=
 =?us-ascii?Q?iTW6poXScDIXaWlnkV1uIBLC+q2QpjHXIm0X7GMWRS3WdtvUFZVt4rmEezG1?=
 =?us-ascii?Q?qIcn+O6ip751/onA9KGf+OV4DH9Ndsu0XSGTCg7SH540skPx981+zA8q+aWY?=
 =?us-ascii?Q?Wpd452ITZz6IRdXdbTmnrle7Wqg2kn/jWJ1QIudKdw8zw9ZyxunjduPlXRFU?=
 =?us-ascii?Q?3sEpva33TpRiKdymPpNhlAq8puw2wn/ze1KIEmkygZuKb3blsfm0i3+uOV70?=
 =?us-ascii?Q?9bINRBV6zpikpI/Zy9eGq1bbL7lyAu3bGQ3VstxqkzMFrKoAAjFPwXGQGb6c?=
 =?us-ascii?Q?EP8rudLT0pBCMqmevmnlvGxYKMgn2b3Rge2NnpTadrBE1fJGh6Oc6B6ZVI4/?=
 =?us-ascii?Q?n+MfNA2+FWK6LFiXoiDB/sUrdyEGoIaYbJtWB0d+T5pgRA17cxDCI+x22DUp?=
 =?us-ascii?Q?HhXvowL3WIH7rw4EIUV2LgDST0ioqbhM/MOpCBK304YkRWQex9H3bjP1Wy+z?=
 =?us-ascii?Q?Qu7tDUGaa+yMLRQFLT36wr6aCQuHwOuyrjixIbYiRDrB39tDXl9AM+RAQ8aG?=
 =?us-ascii?Q?UVZvpagfYgMLZ9QlSq2+tLj/UqHq3r8b5BetYftGKbxi92ZR4zJKd5uhB1+E?=
 =?us-ascii?Q?QXN/OryUyTf32VfMcI0hRnrjtpnUpldUHOKNQWOq6zCThU26pDYOVnJVR5eX?=
 =?us-ascii?Q?S4dg8pxioN2JmW35/lvO6l5Gex2XO/l6c1rlLKW5jd/6Ugwt6K6Ezi6Z8alj?=
 =?us-ascii?Q?F4Iu1Ayco2IZoc3Yl+Gq2DWVIE1bNjkTlJbfPIjehIi2/1q1SBEOZIslQ7yR?=
 =?us-ascii?Q?bvxmzM//GML01NxbZJDuzApAC8/2h0omPmJu1mk2VE34AoKxvbBd+FClkvGy?=
 =?us-ascii?Q?Zk95gL+itjb0rEV6RfsNSkgg59GqnIWT/xUzRQPYzQXF76Rvp98h4ubp5Mpe?=
 =?us-ascii?Q?tPznojgi0Y4VhRa3//0868jiCeampekfDvAGvn7HUgEu90UU5RM9qy6tFQbG?=
 =?us-ascii?Q?fV045MFrCim2F2oijFBsDk2vF2v478/HqLjQLNNN+fOp6MGx6+SDJUIKbEtR?=
 =?us-ascii?Q?mRFyI0qtEVbpt/dteSNd0wjxMMvDt3WENVr5MSbcRPdVA8TCgxF6sA=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 13:40:50.7593 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9242228a-b4be-4ecf-9e11-08dd1f699628
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8161
Received-SPF: softfail client-ip=2a01:111:f403:2412::618;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

vcpu_dirty_rate_stat_collect() uses migration_is_active() to detect
whether migration is running or not, in order to get the correct dirty
rate period value.

However, recently there has been an effort to simplify the migration
status API and reduce it to a single migration_is_running() function.

To accommodate this, and since the same functionality can be achieved
with migration_is_running(), use it instead of migration_is_active().

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Hyman Huang <yong.huang@smartx.com>
---
 system/dirtylimit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/system/dirtylimit.c b/system/dirtylimit.c
index ab20da34bb..d7a855c603 100644
--- a/system/dirtylimit.c
+++ b/system/dirtylimit.c
@@ -80,8 +80,7 @@ static void vcpu_dirty_rate_stat_collect(void)
     int i = 0;
     int64_t period = DIRTYLIMIT_CALC_TIME_MS;
 
-    if (migrate_dirty_limit() &&
-        migration_is_active()) {
+    if (migrate_dirty_limit() && migration_is_running()) {
         period = migrate_vcpu_dirty_limit_period();
     }
 
-- 
2.40.1


