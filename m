Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28523E77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 09:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN7hH-0000Ys-Kt; Mon, 16 Dec 2024 04:47:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tN7hD-0000YD-78
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 04:47:24 -0500
Received: from mail-sn1nam02on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2406::601]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tN7hB-0004N0-Ef
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 04:47:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIrNqutdH+TV/K42SBX1kQ50u3QBJy8qgqybAYRca1qj+L91hHrQP4nHQIo3m6jA/z1kl0NMk3MjzYmc3OMJn+EfYowXryuWRgOgfx/H10UAODVX0GeZCuqEnrbwZZKNseVJB7mUL34vGGm69TKmGmGgjtvNrpeQ4vjba6dlG9NmLZVbNP46qMCNZ4vm3EA+4MTHl0J+o+d2X0VZZFdZLv54retFGU0TGEyTkHclZflnkFxv3nhNBd1pO+k4mWj+M+ERMvT3Lu11TwIdnG2KxliHTl+fegNQFw66QoJGB5uX4vARcnsvwEnwDlkST1Wqzr9Ga+LbYG32H9Mp7WNLyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWdGjvrkmvfvPRcfztRz61P7WEzbPU3q68+0ZLxjMTo=;
 b=Pmn70lIyN+2k9Knr3zTIcjF/ovN7Df449cfa+h6C8Lqsyr5jeFjKjIw6CsEvGGYptrPUPFLaQWfmrzHOFtWRbTLdQ+MWikS0kkJfxebaywNBvij7tyD4WKqtWYBu8f/q4SpkoLB/rNzyE/O/SF/vT+RbQsFjnYqruioRAmHjqQ8xQBxVa95f/heFZBwoPaHokXr8p5RZcz76c4DWJJDQuK5fe/XI8jzdljGu8KeRtgyVr2XSBylOerSBFYKJKiwZlo+pN1St/7oQgkn7T6uQNZOzJgiNJiBUE4WyFYUWDXZbtB2OLEQYtSJ1AVdfRYxN66QBOZijdo4at+9gPXLHRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWdGjvrkmvfvPRcfztRz61P7WEzbPU3q68+0ZLxjMTo=;
 b=ONm0kA4dlesKvdgp1guvg63OxUQ59s6CYbBHHJG7Nv0OeVaVAcYjrseNt/nHi6+5bQ04omn51bkVXiuUHUdULFqDANFjMraumWHfaJRB5FSBFt9dvS7OuiYiOfJobbZdMUM60Jgnka+ECxtG/mK4D4/CbmvWe+zTF32GiJDwfoWGefowLNW23sgtaHBrO5W69JKSekSThvfiPuf/FeSTh3BZ3FzZkxJJirmFB+kRnVlXRFZZOXwhgNBepDgO2Ua/MlOXxiFRqvBd09kBhKNL7vR7JqStsnjYWpJctljMBREgMx12/UdRddZLIv3zaFP2cOdf4UgO0Z6TkK0QFjdbCA==
Received: from MW4PR04CA0136.namprd04.prod.outlook.com (2603:10b6:303:84::21)
 by DS7PR12MB8083.namprd12.prod.outlook.com (2603:10b6:8:e4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.27; Mon, 16 Dec
 2024 09:47:16 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:303:84:cafe::99) by MW4PR04CA0136.outlook.office365.com
 (2603:10b6:303:84::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.20 via Frontend Transport; Mon,
 16 Dec 2024 09:47:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 09:47:15 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 01:47:00 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 01:47:00 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 16 Dec
 2024 01:46:57 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, Hyman Huang
 <yong.huang@smartx.com>, Maor Gottlieb <maorg@nvidia.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH 7/9] system/dirtylimit: Don't use migration_is_active()
Date: Mon, 16 Dec 2024 11:46:36 +0200
Message-ID: <20241216094638.26406-8-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20241216094638.26406-1-avihaih@nvidia.com>
References: <20241216094638.26406-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|DS7PR12MB8083:EE_
X-MS-Office365-Filtering-Correlation-Id: 39a2fe56-fcb8-49a9-f428-08dd1db69fd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HtE6EZnGqovQpBtAUcZ5H6cFdl964k39CB4a4KgFvE2d0+TP9BBUHr8j1BRt?=
 =?us-ascii?Q?3e7I8pTz7rHErW5OTjw4aQoiqtxtbGdQgX/Nxq0pWxDaiD6+mQZu1zMjJlmk?=
 =?us-ascii?Q?kAAt0sTkmN6wesQWQrAm+01Oiw8RM+cgtS9G9X2F2fjZQPOKOE/l/lLtQ7b/?=
 =?us-ascii?Q?m6jrdpsRqnMPDM37UmcqSmYISv9rpLHD15Y4xMiiS31bH90tnS4/RqTWf3V3?=
 =?us-ascii?Q?JCinqB8QfC428b08HhnTvPBCPeUpyX1SoLRKdaczKaAXV+OqrVMWxY+9x5BT?=
 =?us-ascii?Q?PKFhFVrHbOTX5JjJcl6Tj6mC3BygLFzTQ5qTn2T24hi5aKgREuTGRmSn19ls?=
 =?us-ascii?Q?5KsE88d1FrVvx24/972X/orb8LIz3OG5dOBhUC6bTjROBR99EN6b8qtsMBXN?=
 =?us-ascii?Q?FxguIGGKxbSs0JTo8OBkAg+cAXr0oqhHnEoEaZpIxlmro29y2KfiMU2cD0OM?=
 =?us-ascii?Q?Np5h18XVwGvFMjZarJ2eQJY63U/GeA1yEWTTN/Mb5UkcrSr7u/z9nuRtJhWD?=
 =?us-ascii?Q?KLsOF8mfA0Sk+G9+qC3WcWfPswARjfantQ1d1VL3p9UXay3+/aE48rkPYljw?=
 =?us-ascii?Q?/QTgo097MhgIaEwdzJ1aYrW48O2fuGkT3+ImKDIjmBCoRa3GZKFevlPzxcjL?=
 =?us-ascii?Q?clqp09E9VePItQL0g5h1f6E7VcE4Meh8G35hMN09K1ILFzovD3ZgSZy806nn?=
 =?us-ascii?Q?U2GjkqPTHdQmSaWD+PJp/F5yS/4yrO9E7mNjmgTRQrz6s+mxXgPCZJzv5fGB?=
 =?us-ascii?Q?GLuAhaQtZsMoHbr1dqcZudn6bVaJtdIepdcojej7ADAI/hR5lxLHTveCyDNv?=
 =?us-ascii?Q?vH2Dj1mGarU0dvpQQJgqoxCw0VbnJlg/IKI0ViBK5p6JyvRt8aOnZEbL1r03?=
 =?us-ascii?Q?UgVnETMJhCNG883GFlC/YBNkbcesJd/uXF41825ihcdT2BmCcz3U9F8mD+/j?=
 =?us-ascii?Q?U5V+GJ5mcWI5h6TqCcmTwqKBbUGcTH4+5SHLK3wu/AhTPkaJEG6VTVB2wNDS?=
 =?us-ascii?Q?nxT6LyceHRjEtjcuW+IljI5jzDI7pvDtneu3xylUahYIKYubZsSBN9PBosdW?=
 =?us-ascii?Q?y0QpCvEBCUu/OI+LOAO36FI9NODg4OtXpQ1v8TKP9EmevkzCB9PPc68ct2AI?=
 =?us-ascii?Q?Eez7r0YotxgZUItrWOQ/V7UWnMlFQ+Nl34iS8Y3KALDelGfzKC6MQDlfw/CL?=
 =?us-ascii?Q?eeol55NU/8N8SosiELiMsRfXC/L8rm87pVjfVX8EYUVmNkJxtpoleruO2ZBp?=
 =?us-ascii?Q?3iEOLPEDByvtseuU4sOHq2nuUztN2i6XyFBmtu48glZPoyEQba8uYl3i4eXp?=
 =?us-ascii?Q?fOFA9N054VVlkSVnOWwgU+WSiG+4ihd9fcYzVKkSSlRuJysLofL6YrBNdgsC?=
 =?us-ascii?Q?8xxTD79K2+QauVunbIf7qjSgvyIG/w92tB2YYdJ3Ovs5oVRoWfRSYIzBkn/N?=
 =?us-ascii?Q?Jo5iVyPMDkzs4b1tKQvXAvIvnSGlVMYHEB35P2Nht3ihbI+NqHfHmA=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 09:47:15.8065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a2fe56-fcb8-49a9-f428-08dd1db69fd0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8083
Received-SPF: softfail client-ip=2a01:111:f403:2406::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
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


