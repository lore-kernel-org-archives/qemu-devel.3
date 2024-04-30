Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341DBC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 05:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1frV-0000kF-3t; Tue, 30 Apr 2024 01:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s1frS-0000jj-SY
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 01:17:03 -0400
Received: from mail-mw2nam12on20600.outbound.protection.outlook.com
 ([2a01:111:f403:200a::600]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s1frN-0006af-Ok
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 01:17:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5T3DOYCZsDjIKdB1xpvNbj85ruUzwQQDJh7ACkQDU4FoedYO0BaK/7QfdGFNJhoONSCMZ7aQa8YCUbXZ74pugo+jr4kh4ZRTCkqxl9QYDqyv02IrXmvTiC+qzQOfVgPuxr8EfMdxdTnZ8/HDxMg8QZ0a1IBIzfEY6uYElNvknsj/FvfckyJ9jDCP1Cz1570sTzGlRwVMqEAUeLk5bDKVj27NjSZfiB8ozn5qDgEPVqqUtM3o8EOPfTn2z+YKSXzEX691QwtWohVj6IF7KCyk2YLUWhH5a24vOR5Fp+OdSVER0wGqjpwCw5JF7ZpIHokz2bZKmDx9G4UXYXTp++o5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZ6EB4ySYq+wDgPEQhcBbWuo6kce+vcwHrrkjaessfg=;
 b=LqUlaR1/B5ZmKUd6pqroeUSaCIGm9r/3hJF3rN0rI8Wr8v+hcR7GlIstA+Xk4E02LOfE7hRIO3714fUBPE9DyHTgbtDWFsmUDG8AgGsRQtFOvkUrGHOX5QwCfKJZTREC2Tj4R5zzwA+dfFDZsCrHJRmy/4O6HX/U//fbJtnQrpBg5adOJ4xl5+7bYd6wq8dg6P+O3XfyWK1yhSZ8dTGFzKioQQuKC7wuYifMyFK5n87TrrJYB4u9z2zF6jEIeB34OBSTGOTtqjl9BAwwJpNU1wM42dPePn/w+ktqApQeoCBwUoQrMBX033zL03jBdSZjZ4xthNxE9mQvnqm5dlP/WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZ6EB4ySYq+wDgPEQhcBbWuo6kce+vcwHrrkjaessfg=;
 b=Rpox3utOfQn3ma5Q5cHp0uaqmjo5NtM3R5Jjsu9WNWg71WGIqRC84qP0Kf+wxf0+oS/vesAFeDq0ADZubc38mNNKMdoDXfh/hXCX1syLz6kQS4u81YiIKDH0Q3SzhoQSJ8vpkyFj9ugU/M6TtBOWRBPUQhzEwZ097myVu5Cp96AFUYcBHj0Mq3X9TNAjr05jYTb3pOYRRZZ9fP8aeKmOIGcCQ25XcbmO3sCQYMkw7k1/boIHnW9NssiU5F6jrDbZuhjKAjOGXdXRM+GTsfK3XuDp1xp4gn/n6voyRYZK+jcoZ+wH1nNWd49O5x5jLPYriAEyqluvKaS8yD1nI3JBiw==
Received: from BN8PR15CA0043.namprd15.prod.outlook.com (2603:10b6:408:80::20)
 by PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 05:16:52 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:80:cafe::3d) by BN8PR15CA0043.outlook.office365.com
 (2603:10b6:408:80::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Tue, 30 Apr 2024 05:16:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 05:16:51 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Apr
 2024 22:16:35 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Apr
 2024 22:16:34 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 29 Apr
 2024 22:16:32 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>, Eric Blake
 <eblake@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH 3/3] vfio/migration: Don't emit STOP_COPY state change event
 twice
Date: Tue, 30 Apr 2024 08:16:21 +0300
Message-ID: <20240430051621.19597-4-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20240430051621.19597-1-avihaih@nvidia.com>
References: <20240430051621.19597-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|PH7PR12MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: 38644ec4-279c-4b83-ef9d-08dc68d4be65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|82310400014|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2XsrvNY/p+IBqqOMu9BuBqIyBQVz6e4gdhMo/OGgm5n2LWkfuCUTlJnrP51r?=
 =?us-ascii?Q?CsdyUQrAf6FdoZ4dbdX+GjVZhjsgdGutAch3EO60OTYvgXeRznyOgHZN39Ly?=
 =?us-ascii?Q?ztbFOjw6fyoAbyyD2Jm+YwOItbcCrUwpZgQ1VwWJCS4DeupCd6qXXf+Ykdji?=
 =?us-ascii?Q?BAJfrtVYouawehlbYs/a8c5loSRqOS+gav+lZiSoSwHgiY55F8OcGoVILEK1?=
 =?us-ascii?Q?1lYOtsJavPYrYKpzH0r8BFEjoYyElQbgtjGcoObjxLVZzsB7QHcNebAMiJ+G?=
 =?us-ascii?Q?2dqvs0TilUlDC0HY2IUIyATSBuSiSTvcO0OGkme6WHy0wtBD2i8vnIQZiF+g?=
 =?us-ascii?Q?oEC7O4nMvsAg8Ijf7/gOT2GTvbjsScXFy3HSqUSBx294sa2x226TCraNtwZM?=
 =?us-ascii?Q?vvkrA7jQ+khgLYECOPFxcYOJ4Cyos36J0LVXZVhn1wE24ARE8lexvjyYFLmf?=
 =?us-ascii?Q?X8OH0oqfnw6TTihQ6poOXAIPj0hjcOpgr9ZtvJ9epsnImLgUyloghrfCiX0p?=
 =?us-ascii?Q?n+KaI9vUiCcVwvzpVrVWNlI2QDuCU140C/1WkSZFQiEsMNJllqa5nhOlYSBj?=
 =?us-ascii?Q?aCfvfOhw3B2qx+o72K4yTroyViXAREO0M/BcGegh9qvF2ftf5wDSM/PejRnL?=
 =?us-ascii?Q?i3vc4ETEVB7usUCOmjqm4gpTTLqvzv9LWQZwP+oBJnHzLHAPcPauRVknL/4Z?=
 =?us-ascii?Q?k3fvRag3Al3n+qzUYxueRIF0Hre2DX2YGL7I7i1g1Rn/qAGqxivjQPjPPYcr?=
 =?us-ascii?Q?COczCrznUqgv6Ap4iWxikHrBnPeXCNoqR89EjFpYXJpuG1+3nWV34E2k+6EO?=
 =?us-ascii?Q?QmJwOrjazhVoNFjYzkhFqB0nIOr32wTw7r+EBP9efh7qU8F1PakE05VqdcTR?=
 =?us-ascii?Q?tu7nS+DhSEKTH86qNazhfC4RRi4CKlnIcqfHFQa4XHJpKGFbbqw/3H696TiD?=
 =?us-ascii?Q?zJk/ouVbMNLMQezMZDf7qKt9MpPoZQH455jshcLgiMOOOUS1AkWrrG2BLDHe?=
 =?us-ascii?Q?VX4YfKq5agSUmHjVZlg1TkQYSSfITqi7AM0smlh8EYocwfQYt89BpeMJSb+W?=
 =?us-ascii?Q?zOyRYRJ4HbRrQ1C6CyXZ5js9+OXRfjp/38fUTX2qE5HCTaDlMWC/8om5g5vC?=
 =?us-ascii?Q?tmNo10l3gnyHoIcUmVjcU6AWzC9YNaZpAILhjr5ivp6avV621SQRQF2nFsCu?=
 =?us-ascii?Q?L3cXGqcpx0Dox7r6SLLgUViqklyTFo2DG9/4fOjmLl1cIsYNxkNU+ahQ4shs?=
 =?us-ascii?Q?YZI5fpGb+UFEw+n8dS52ADtRhR+SlveMjmrwMH65zNtNq6e6j+poExIWOEfv?=
 =?us-ascii?Q?rJKk0DVf4fWox792S+QwteRj7hZA05poK1V7bHwfEhQj+OX/6hI3BSzYl9yb?=
 =?us-ascii?Q?FdeIZ5y/u3Q0WTMjOtUq4Cztwfhy?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 05:16:51.4287 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38644ec4-279c-4b83-ef9d-08dc68d4be65
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6395
Received-SPF: softfail client-ip=2a01:111:f403:200a::600;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

When migrating a VFIO device that supports pre-copy, it is transitioned
to STOP_COPY twice: once in vfio_vmstate_change() and second time in
vfio_save_complete_precopy().

The second transition is harmless, as it's a STOP_COPY->STOP_COPY no-op
transition. However, with the newly added migration state change QAPI
event, the STOP_COPY state change event is undesirably emitted twice.

Prevent this by conditionally transitioning to STOP_COPY state in
vfio_save_complete_precopy().

Note that the STOP_COPY transition in vfio_save_complete_precopy() is
essential for VFIO devices that don't support pre-copy, for migrating an
already stopped guest and for snapshots.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 hw/vfio/migration.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 6bbccf6545..30a2b2ea74 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -591,14 +591,17 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
 static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
 {
     VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
     ssize_t data_size;
     int ret;
 
     /* We reach here with device state STOP or STOP_COPY only */
-    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
-                                   VFIO_DEVICE_STATE_STOP);
-    if (ret) {
-        return ret;
+    if (migration->device_state == VFIO_DEVICE_STATE_STOP) {
+        ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
+                                       VFIO_DEVICE_STATE_STOP);
+        if (ret) {
+            return ret;
+        }
     }
 
     do {
-- 
2.26.3


