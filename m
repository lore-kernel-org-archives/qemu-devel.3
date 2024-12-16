Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBBD8E77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 09:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN7hZ-0000b5-RX; Mon, 16 Dec 2024 04:47:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tN7hK-0000Zi-9v
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 04:47:32 -0500
Received: from mail-dm6nam10on2062a.outbound.protection.outlook.com
 ([2a01:111:f403:2413::62a]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tN7hI-0004Ne-Lo
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 04:47:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sgF4KyiF69wc5bNn173/WPgG0YF+QIkN4oGBEh9Hr+gOti88/g2iqvT0IQyxccAYBiRJaDQjYD+cQoLyIVRexIrpOC1zCTIifWfE3XoGTx9YJ/RaUwflek/PBkHjR4FtewITI6CJTdZZr3c3yifkV2WDjcOOGOyKKuFCRrOc6IJuWCrqc9S+g0vX3ZgQ1XOMaMPw6+oZZPMBKrP+dGVW64SIdCh1UhS6XO/u3YtQfLimzMz5Fgyd472D1w1XapVywEvhZdNgbH8kZlBwMM7nsKYJ6mMdT3m8IeB+YCW0Py21RBPDTvyPKOhQ29sBJN15ApJnBuhtZjjOCvKPd8/G9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnIjopGlH0fjDwtHzVL9gDoP6tGKjDrcWAK8kQQHzxs=;
 b=wlzqRlMHMLXd56cG0MY7JwDkcxr8G75Ap6v487VgPhU2fCeKyCMH+1KUqpbCvj2pdhau9AjhRJWnj1x7rb8/6fPggDDm9+Q4FieN63Evfpbtuh89jVHQsKOczW1B6my3AlM60F7+sZhwbsfZ30aYGZIa6Y/1JST0D8uoqW5UjCT9zddF+TIWy6ybI7iXAiy2e8zH8LJFzrvWq6PwCnI/Qlg79GomByyeWCdb4+2BKFcbLoOIgXgrqBKo5IwyE7bFy6IRRdgdOhf7uW0mdT/U3vIOvmuMZMJwXWx21xL+4jPMjzvIpNq26DOage156clbXG1U4ptiDZZ8AMtqqQdPVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnIjopGlH0fjDwtHzVL9gDoP6tGKjDrcWAK8kQQHzxs=;
 b=lYQKGz3i+d2QLTJtoFDelWhoncGu2a3jyfdY70AGwOVnaQO0CwBr9wheK6Py9BE1vAlw1/1S3Pbb7eOWocazV8aN8CGkIyzXgxNbghbAeOA2zBiVGI6QoO1nsi5a19DaF6fjvEQOqwcHJlxH3Ov6CKiGQaNW2aaazOyWAmjBLD9baUc+h1xgXv6p2SDL2WshLGQybLhY4Dn3uiHKcJANmwUeNKUGA09rcHHihX0tx+WmTO/Zd2Swy2JLRHwEv8X4enJR1lVg4pyFGAiP/7E2uIrVXEwJ9gxuYOPu+UEqEY9OgS7a8V+F33RVnnWR4Ljis+p/xN6KQBmDHF/QNrHUFg==
Received: from MW4PR04CA0130.namprd04.prod.outlook.com (2603:10b6:303:84::15)
 by IA1PR12MB6092.namprd12.prod.outlook.com (2603:10b6:208:3ec::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 09:47:23 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:303:84:cafe::4e) by MW4PR04CA0130.outlook.office365.com
 (2603:10b6:303:84::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.17 via Frontend Transport; Mon,
 16 Dec 2024 09:47:22 +0000
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
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 09:47:22 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 01:47:05 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 01:47:05 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 16 Dec
 2024 01:47:03 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, Hyman Huang
 <yong.huang@smartx.com>, Maor Gottlieb <maorg@nvidia.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH 9/9] migration: Unexport migration_is_active()
Date: Mon, 16 Dec 2024 11:46:38 +0200
Message-ID: <20241216094638.26406-10-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20241216094638.26406-1-avihaih@nvidia.com>
References: <20241216094638.26406-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|IA1PR12MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: 58d22442-db2b-4288-ee19-08dd1db6a3b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9KOcT3KddHPctdHSk6kpcaoxMnVAqA7DYEcV7w8t9fgaZQzG3PUYpyYQKbHU?=
 =?us-ascii?Q?nEqcfEjjTYUwbExyoKLHUW7Rhf1/9OZjQdrJcAMmtCJUWXjNgwAl5AvrWPoq?=
 =?us-ascii?Q?ywStGlRF3h1nZ0bERSGK+gdDY0OcXLcvJ1Uapn3H8t7vkVh2sObhH4x6+OSY?=
 =?us-ascii?Q?P2byHjf+7Zxc1XkLkBTyK8uCR4YKZrJo7xlbOoJjoPbzmjhGoeEtV4i7Y8oB?=
 =?us-ascii?Q?FppiSmY50JzpBX9Gto1EqiI+7hP2zbhICRXvYsc1ATLFn6Ofp3WMDznJv1F2?=
 =?us-ascii?Q?1HlaFKa3Jtn2D8UNO8u9+DsztcI558L3VfuUP5e0wc0TybQ2uukKHQ8/rSHs?=
 =?us-ascii?Q?a7Te8zBWo1RkGnKVGhITQI1wkT93w0O2uTAENX2zSdTpqfWVrl8wd0RP8iun?=
 =?us-ascii?Q?GA6fQEWu44/2FlkwOnRCr+L9N0WoB7TpKJgVRwR6OM3X5brokYyJMWm4CitN?=
 =?us-ascii?Q?HoOUg3WxEON90vk3kFwM5eu11z5PxFYFAQkdU8/WpDpQWG63OdKCDcKAaF4/?=
 =?us-ascii?Q?+3fPXmdU2/3olNqRBbO3pVF8/52Zmz8dJSW5yXKBtbaHpV2q3zQWZ/8UB2lN?=
 =?us-ascii?Q?M6kK5HcGkpywps9moT3hq7xT5cWUOjhjAxwT+OD4dI9A0FlUcAfu21N6VZ39?=
 =?us-ascii?Q?nDkmUGGdh5C2GMfTdHRO23UTxvgFS+agtNEgSX52s6WooJBHsAHRRp8UnCgs?=
 =?us-ascii?Q?SNeOYOAUOSuquB/jI325xX6dNjA3HhBvGmcfNjZW1stDE2NbHMOGFa14zK4S?=
 =?us-ascii?Q?WAgWNHYCoI4E2Pki8ztba1E18i9y20p7/atLxgiqdzW7NEDDL4vnxsJomfrw?=
 =?us-ascii?Q?ME4qA3366NywTtgTWDASl0EiafjbIGSuVdKCRSP3hRipFLtkkJJMZs62QPa6?=
 =?us-ascii?Q?Uz9KJgIkMIrnl9RR3vM7d0R44uiZZA2anDPR5H5sLvXOpAvAiJ3QfhraqUeM?=
 =?us-ascii?Q?JOS51VCWnPH31GQUFyiyEGSDD18WQc+LkAawJwmHUsfebOg8Iz+L6/SpM1+2?=
 =?us-ascii?Q?xnfPRDgwY72e/wVi7XX70/rCbhOQhvXRl/QDSlsnjYWYIyZQAWQ2ouFcThfv?=
 =?us-ascii?Q?xghvCUtc0NxoGBUal5vFnf2rYX74RERTBH6Ae+QmmDs/ytHpWZurEuy8kDB6?=
 =?us-ascii?Q?GHAJrB0qOlBe/MqyscQ8xnGPxefXaoctXovgHeaGR33NwPbpPHN04c/t5cNx?=
 =?us-ascii?Q?RJQppP55SO4Qr+uK4DgGZROEW3ZkP3KqVDyaN77BIuxQO7DDnrVmSonYMxDS?=
 =?us-ascii?Q?NIGN8fiJls7KuigE+z0bPpIjLGBro6ZdUb5/N72a+uDuMJ4EpyOVv1SbmO3D?=
 =?us-ascii?Q?W68eMEzw9idsNQLAjRZjdx74DjG7p5r3B0Md7uUsQPuIPMmqz2ND3jv/Sfqo?=
 =?us-ascii?Q?7SPZ8OR8UVgvsI88pI3QlseVopaVdVWpa8k3Fgvc3NZ/nh9mZWlT/Kin8Hq/?=
 =?us-ascii?Q?vebjtE4VXbrscYfu9fSceqeB+wFvejuOzRL3w365yq1rLrrXbs+BJAxBkbdW?=
 =?us-ascii?Q?6bR84TGYyKs9PHc=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 09:47:22.3534 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d22442-db2b-4288-ee19-08dd1db6a3b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6092
Received-SPF: softfail client-ip=2a01:111:f403:2413::62a;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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

After being removed from VFIO and dirty limit, migration_is_active() no
longer has any users outside the migration subsystem, and in fact, it's
only used in migration.c.

Unexport it and also relocate it so it can be made static.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 include/migration/misc.h |  1 -
 migration/migration.c    | 16 ++++++++--------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index ad1e25826a..c0e23fdac9 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -53,7 +53,6 @@ void dump_vmstate_json_to_file(FILE *out_fp);
 void migration_object_init(void);
 void migration_shutdown(void);
 
-bool migration_is_active(void);
 bool migration_is_running(void);
 bool migration_thread_is_self(void);
 
diff --git a/migration/migration.c b/migration/migration.c
index 18ca60af4f..5bb0633e37 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1139,6 +1139,14 @@ bool migration_is_running(void)
     }
 }
 
+static bool migration_is_active(void)
+{
+    MigrationState *s = current_migration;
+
+    return (s->state == MIGRATION_STATUS_ACTIVE ||
+            s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
+}
+
 static bool migrate_show_downtime(MigrationState *s)
 {
     return (s->state == MIGRATION_STATUS_COMPLETED) || migration_in_postcopy();
@@ -1637,14 +1645,6 @@ bool migration_in_bg_snapshot(void)
     return migrate_background_snapshot() && migration_is_running();
 }
 
-bool migration_is_active(void)
-{
-    MigrationState *s = current_migration;
-
-    return (s->state == MIGRATION_STATUS_ACTIVE ||
-            s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
-}
-
 bool migration_thread_is_self(void)
 {
     MigrationState *s = current_migration;
-- 
2.40.1


