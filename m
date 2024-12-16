Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70706E77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 09:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN7hH-0000Yw-LL; Mon, 16 Dec 2024 04:47:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tN7hE-0000YU-T6
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 04:47:24 -0500
Received: from mail-co1nam11on20629.outbound.protection.outlook.com
 ([2a01:111:f403:2416::629]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tN7hC-0004NF-V3
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 04:47:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ivfd2fAFwc4dfSxbL5f3PwL2aNvsjQOqWk1keBRDGzkzB5ag3rBM79xTQOygfQrM+y0/Pt3ahiQsY+AI1H4emy1REJvj0NxwqZHKa3q2yRFiQSYdJ2lnkr6iKxVBDDxYHFfZ0jX7ouO908GcFB5o14BD2WyImQ21DTeTHBI8K3JI7aPIm+zYq6ZhNP4gL2r8/VJggRrruGgiyytVIufWjwg38hVmyY3PORMOESD0soL+F0BzSWSTXNpDT6+DwcaCwwdsTubuc+cIzdn+Z2ppAYpmWwOuFT76XcCO//KkrQrOqqcJJVnXKHszIsApdvd+ZYlFPw5c5QSigJqPQBJOXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Udz9oOp9ZgWZpNWRItnobgAby/BEQqsyHVBKxOJL+SU=;
 b=YrODSGRsbUmhNSEswxedo/EcJdhAUnLmIKW0Rz9Keaqt/SA0Rn4xP5wtlXWzLhNFXpxQTshXEK9z+Kv/eLYhGk9M/UY6FxPQQ9HDFcwtmT1vXgXoR6zrnR71Sa/Erh3L/IXMaNxEkskjYUqIGHtH+FFYK8kD1ANBZjmy9PpA9homfBtOyBGWnfFXXXjsKP0AJO7Po7rVLSKIGQI5/VvpxqKZa6PnUbvxx++hZEXWGwATYBuD/pkSzDKqdVclXRCxqLxYIGzVOnSPVScB6n9iUshMClCyr/L72JKtI9BIY2j9yFXxcJCfpv+je6XScjnxQMVuWzs1mN/GEXHdSu+yGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Udz9oOp9ZgWZpNWRItnobgAby/BEQqsyHVBKxOJL+SU=;
 b=jbgoxzOILB2GT8n3kw9091zbD8b2Q1sNS30+sm/g1jj580MmIwITkbCM76gqAN1ONPt52E1k6J+YVq5pChsAYxY47THjSMZZB5q5Lnum+/goALRQsU/vIcHoVbam0Ue9/iJhyaO7j41wbV2rxJHrBg0Y5VpzHR56/KgBTIj7ezVy4sLPJ09iwV6OcsGuAmYxMBsgy/ju1MDSzJwSusi3pSRUN6kNDevC9IvRCOKrz73C6U3K8FPt+SfO0cpWqCfxWSjc2NwABjKrFuYQ6A741RZn5O79LjqMn8akGRW0gTWa5qiScwL+vEm6URi3z1RvOlXaMJ0lJ3yI+3DN62vj2A==
Received: from MW4PR04CA0145.namprd04.prod.outlook.com (2603:10b6:303:84::30)
 by DS0PR12MB6391.namprd12.prod.outlook.com (2603:10b6:8:cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 09:47:18 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:303:84:cafe::8d) by MW4PR04CA0145.outlook.office365.com
 (2603:10b6:303:84::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.18 via Frontend Transport; Mon,
 16 Dec 2024 09:47:18 +0000
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
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 09:47:18 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 01:47:03 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 01:47:02 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 16 Dec
 2024 01:47:00 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, Hyman Huang
 <yong.huang@smartx.com>, Maor Gottlieb <maorg@nvidia.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH 8/9] migration: Drop migration_is_device()
Date: Mon, 16 Dec 2024 11:46:37 +0200
Message-ID: <20241216094638.26406-9-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20241216094638.26406-1-avihaih@nvidia.com>
References: <20241216094638.26406-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|DS0PR12MB6391:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f0d02bc-ba1d-4a42-1e8b-08dd1db6a140
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tgaNjVuCOfBQ3Npqn3H7sjgPtGusjZ/uP+nkvIfn9ZuDuPR49dTqscmhyYBZ?=
 =?us-ascii?Q?Q9Fn5zbDeDbSVwQdnSQC5AUWfPpu0y/1w2D1PqV2KuBsNto9OnI++M3Z27jU?=
 =?us-ascii?Q?V5et5a8HVHLiM+xV1pIFeTidwlsg/qdd/I+L1rNmaoGF+vReN7XN9wKRhxNw?=
 =?us-ascii?Q?hZbI2TGixi/V8waXKUFr9ofmm02e3vPYZEVY34rZdjLnCu2ZXQmLAHoPnH2O?=
 =?us-ascii?Q?qHv1YJuQrhUVbg7R1ENsmtpw8Hc1Vb4pPj9WBcLYXZg42yAjxNyb0PNJWO+u?=
 =?us-ascii?Q?4wcwik64gfIWWcjW1PpfP80ovnNq/DBL1KxfOSXZKP+y+/hqFMZ329SzmvdJ?=
 =?us-ascii?Q?bHl83kaHs7TohavWqGp3RJCZuL/x4VKUcXtdSkB3JX3u8FqSxRImwFentHqf?=
 =?us-ascii?Q?6EfCq7NrI71AV29HN4tCLm6ee8T6mPPpACcfY6DSjpbuOie6PV5Oz1cEdtIH?=
 =?us-ascii?Q?9UkfJlFJ1I6YDeXqKUmD9Lrkwv1JLBBoYTmnWzx4ix9WaKNFb6YTw9a5ABvP?=
 =?us-ascii?Q?XKsLEqJCtLj8HwqEY3ui/TdrkUE8P4V5AUpegguuESPkjUf8EWfWgLS/gIq4?=
 =?us-ascii?Q?qNJoONYJ+c4Ilr8FNKHjmc5xlYSNmh/36sQYRBe0Z3apj1U2ter7wlFz2Tkp?=
 =?us-ascii?Q?Pk8mYiRjJF5Dl9Y1nmTmCxcM7hhS3JFO3RxL8PgXJw//PO2NItIvRKjuqYde?=
 =?us-ascii?Q?Jblj+Mb1lfhkXzONqMaPSxqvQ1GkgJYrhUtqjFbRFcyRf4IHYFBo4I6rNujK?=
 =?us-ascii?Q?UNwoUcIyoTJefv1A5Sf/Mn+0ZO/tQ9oWYt57PeMroFmDywHxUxAiPrqEzRrB?=
 =?us-ascii?Q?Afn1IHcydr+MeVR+rXcbFv6Q8A3kV+167PHKz2fZOFVoD6hNxb8nbH2zGOgE?=
 =?us-ascii?Q?M77QLakh1jEiDbqUWg3VmSDZDTmCqCh7bSOGZudEV/egrpHP04s+KOHEBrh8?=
 =?us-ascii?Q?1x+V9oKRfYtK4WwoCcDwFJv4OqzSt8982bvMiJq+2ifUUzqny6oQXgHKKAtC?=
 =?us-ascii?Q?FyuGzWed5ezFTqyDekCjJcGzLsccLHZakOGgpb48qcwPQpiDhA873m/7fqPX?=
 =?us-ascii?Q?xEmGNBKIysClnpmSfxUv5uYrosgVEQ5/ohSJw57945QKrt4eqbmByvnO/8Aq?=
 =?us-ascii?Q?1c7l6UW3AX3Pe40YDkoVkWVdtLe808MRCuaDC53mWk6CnRr38sK67Y2w8/vU?=
 =?us-ascii?Q?3egFesqtAUnJazWfZ2BTx5L7WPouDhLyqGhNbknw6GJt7ltfpEwhp+x0sI/t?=
 =?us-ascii?Q?lE8fLJkeF7PEObMNC3gjQ9x213OlYpah0LoLRnikVDzfyiM6Lx2TLAZlgyOq?=
 =?us-ascii?Q?JtPb/lAK/9o8IML2Ol6EayJHcyHPRuwyyC+i2v1+QY9JU9OU59cJYnAiNMBN?=
 =?us-ascii?Q?pV88kUfjYqFFyZ4/b4LCwFvaNa/3EoFm8Y0Qux4sRgheKb9Hb0zXLHQJJLl1?=
 =?us-ascii?Q?uaiGRjG+L5ypsqBgvwH/ZIJSpv0Y4SWYV4lB+gmR/oGmi5d7w55ujWN9JEHn?=
 =?us-ascii?Q?6qteArYEnv5GIjk=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 09:47:18.2128 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f0d02bc-ba1d-4a42-1e8b-08dd1db6a140
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6391
Received-SPF: softfail client-ip=2a01:111:f403:2416::629;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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

After being removed from VFIO, migration_is_device() no longer has any
users. Drop it.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 include/migration/misc.h | 1 -
 migration/migration.c    | 7 -------
 2 files changed, 8 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 804eb23c06..ad1e25826a 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -54,7 +54,6 @@ void migration_object_init(void);
 void migration_shutdown(void);
 
 bool migration_is_active(void);
-bool migration_is_device(void);
 bool migration_is_running(void);
 bool migration_thread_is_self(void);
 
diff --git a/migration/migration.c b/migration/migration.c
index 8c5bd0a75c..18ca60af4f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1645,13 +1645,6 @@ bool migration_is_active(void)
             s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
 }
 
-bool migration_is_device(void)
-{
-    MigrationState *s = current_migration;
-
-    return s->state == MIGRATION_STATUS_DEVICE;
-}
-
 bool migration_thread_is_self(void)
 {
     MigrationState *s = current_migration;
-- 
2.40.1


