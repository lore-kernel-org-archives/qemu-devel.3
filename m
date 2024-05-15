Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB2FC25B7A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 13:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7EaI-0001It-KC; Wed, 15 May 2024 09:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s7EaH-0001Ib-3b
 for qemu-devel@nongnu.org; Wed, 15 May 2024 09:22:17 -0400
Received: from mail-bn8nam12on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2418::600]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s7EaB-0007Fu-B9
 for qemu-devel@nongnu.org; Wed, 15 May 2024 09:22:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8IY5wFAeA4xV6Dyzx7NwV5bY1ze7oBjIWiF21nfpBzBLi5ag2R81Vx0DaF+rROcvnLwUtBZjQLH5QCin0z83XCFu4gvIS2/VMsp42jqsmd6BecxYBllMYyPQub/p3Ucb9dQZznqFrc2hOhOaU6Po+98KOS/Ozryn6iktfCT4hubT5c6SskEeic/gL9hbDCAz/Ys37KJFODq48QZgLd+g+7SmaKi4YMJHcNh5AlP7zIKfq5qr9C+NNAo/UOqhwj4EW5XV+hfJbG6M3nyzuYx8cjRhn9OUHbxubg1e1g7h3yPptoFHCo3Es04YjemQPM5RN/jODnq6EMPHByD7hRelg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysncH/GXbkCkfqKlt0YJah71gRqhJesgEfziDyTDuLI=;
 b=iJ1irTOKOJiWzsiT4ADdtSiu12SKg3WW/BA6JGdlQ8tbZddawGJ9s5nmGvNQGPlSHsRxZbinRw/Df6x6Z7Tv5HCv5llxINdzxofXr5rhCrtQFkmAvEl/uf1kziv1zETyDXJWJv5IcSmlqa4pGjUN86sMrlYcdFJ26kE66V2h3lh42mH/3fqd4H8poyCmK+ubNvsTdHLFZkhg91k3SkbQupZC0OTDzm+xp961/9S5Cd5TisZpf/XmrUf9/bclPtKpOQ9+xrtutd2lQaCgPyhL+c7tBcySRZHc08lAu9E80sriAe/i7aU3YZKJd346Tzm27YswvaSS4dWEJRTlZO/9lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysncH/GXbkCkfqKlt0YJah71gRqhJesgEfziDyTDuLI=;
 b=nSeaI6UsSJzbrV4jv42mhDUBt/gtRufiB8zDElDhKEHrZRTgpX2WGScYz2PlY8XD1nF/V2ojIyCNs8Wvcs8u4fh9L25Catus7w8Nf5C2+NzZ9jmA8riINs522GN6sTu56EyQEsMTp/8lzGrX9riTciahvBbtyI52oe0Gt+2PnmaZrwPSWE/lWqgWCGmORdZhzHUSw5HpAHbA/EdsXVzjE2ROHZdzWAcpMiiOKHJQK1yruzjW7nYm+jBnl+H8UpIdriGD10L+dfe9Xb38V/nNJCtD9iK0j5T6kYLl4/O0waPVI2jWKYimC0SNEfAvIs2jITz0v2BqsYQT8Tp4ScTXEw==
Received: from CH2PR07CA0066.namprd07.prod.outlook.com (2603:10b6:610:5b::40)
 by SA0PR12MB7479.namprd12.prod.outlook.com (2603:10b6:806:24b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Wed, 15 May
 2024 13:22:04 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::5b) by CH2PR07CA0066.outlook.office365.com
 (2603:10b6:610:5b::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Wed, 15 May 2024 13:22:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Wed, 15 May 2024 13:22:04 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 15 May
 2024 06:21:54 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 15 May 2024 06:21:54 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport;
 Wed, 15 May 2024 06:21:51 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>, Eric Blake
 <eblake@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH v3 4/4] vfio/migration: Enhance VFIO migration state tracing
Date: Wed, 15 May 2024 16:21:38 +0300
Message-ID: <20240515132138.4560-5-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20240515132138.4560-1-avihaih@nvidia.com>
References: <20240515132138.4560-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|SA0PR12MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ad208f3-f970-45fe-92f4-08dc74e20328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MVFvamN6SnRXY2RkdmRidy9WcWdRZjkzbFl5QXcxaVFHbE5odHpYWXUyQ1RF?=
 =?utf-8?B?Rysyd24rL3NrS1NJTENoOEVzb1QyUGFpNWNBMlQ5aXc2b2ZORm9GRU5rb1RT?=
 =?utf-8?B?OEUxeFA0WmdoVmJtSDBUem04VVJ2YjV6dlBld0hycTQ3bERpajROVDJxdTNQ?=
 =?utf-8?B?SG5haEFKdjEvaTlzOGFWcU8xNnBCNWdiL0Fpai9KRStwYndxRkZtcW5ESVNz?=
 =?utf-8?B?TjNyY0JHdUdYZEpkeTVFNjFHb1RUSDZiN0wxQVZ6RzFrL0JTSUl1TU8yM3cy?=
 =?utf-8?B?d3dqYnkwd0dnekxib3hXMkVzUVRFR3NYS0JPQVpiMVl1Rk1IVUhRbUZjUkt2?=
 =?utf-8?B?VmpNVTd0ZlI1RWJWVjYrM2xiU3VWQnl1UENnbE14QkNlT2hMSGpjNXRzdkFM?=
 =?utf-8?B?bFJ5WUlmaVBOUzBDODZZcDB1c2xWR3k3amdGK05mUEcrd0NPRzhucDhuOHFz?=
 =?utf-8?B?MWFwMUdaMGtINzBMdlZIM1pVRFd6czAvVnJlNGc2M0Z5K2pRSTJvSVZNQWYw?=
 =?utf-8?B?WklidnR4MzQvM3dSYUlIOWxTNzNBejB2eU5rZyttWGNQOEtXNnd5RW9sb1Nw?=
 =?utf-8?B?UnBlblFadEdXZlU3bmNRSjZ3RmcyaHBNN1F1SFN1ZVhrV0RlZWhGSmJsZ1dU?=
 =?utf-8?B?NnNkWWxURWJwM2xQVzVmSzhWQ0pTdTdzVTVyT0F1cys4R2lqa203VllHMkVl?=
 =?utf-8?B?OXNFWjdSTkZiUXdReXF2M2NVVGhMd0RET21aU2RQM01hUG0rSE9aZzcrek5D?=
 =?utf-8?B?MW03czlIS2tZUU92L3NwNmREZmlQbmR0Y1ljSlFaRHRPTkk0SnRMNjNJMldZ?=
 =?utf-8?B?eWljd0tXTzMxN0laRjRxb2xKWUVzV1dacllkSkd2WGRDWlkxcGM0T1BkMlhN?=
 =?utf-8?B?azNFSEFmb3ZnV3F1RTR5N0orSXhNNk1GOHdGQUVpdjhvR3hxL2N5Qm4xbDdI?=
 =?utf-8?B?ZVBwRHVmYUJwSnYzUFJsQjFKT2FmeGlkTHVxbEFRajM0cWRDVHlnQW5VWXFp?=
 =?utf-8?B?Rk5iVEFuL0hQZnJBc3QwM0NyOEZLbXIzNGR6TEVrL3h4Wk80cjhUZmlnbFlL?=
 =?utf-8?B?YlhEWWR3emRrbGdCZFJpY0x6ZXRIbGZjVW1rKzYxNW5LZHVjK3hub3hHbjkx?=
 =?utf-8?B?SGZ6a0RwVlNNaitvTUlhUXcxWFNWYTBLTFZjVUVYdms1Nys3TDNzT2NwR3VL?=
 =?utf-8?B?OTZ2a09NVVpjeTRvR2NPQUR2VHdDYXM2V005SndHQ0NVa0l4Rkg0aXFkLzF6?=
 =?utf-8?B?ZmJBQXNYWDRKRkMvdjlZQ2dkWFpVU0Y2UVlFKzdReTA0ZGcxUkhxRjN0MUZ2?=
 =?utf-8?B?ZUtYSjFQWWZJaGF6QThjVGF0eW5GaTB0eFJQQXMwdzQvRVZmeTBTbG05U3No?=
 =?utf-8?B?eXBHVE5DbVl6ZVJWWlY3MGtwQWt6MEU3RGVhNWd1b0puQ3B0R05YVHE1Znc2?=
 =?utf-8?B?b1lpM2xCeWJiblU2VjNyVmt1V1RPVVlkQXdaWWVCSXQ3YTZod3c3ZG84NGJM?=
 =?utf-8?B?eXlkc0JIUnhBc0Nrem5Lb2ZtMzkyMmZ3N21VSDk5enViSTZVVFBOMmhJa3M0?=
 =?utf-8?B?ZDNxVEhFY09LL1RkcC8xQVpqWjAvRWI3S1c3K0hTZjhXSnE5WFNya09DbnFa?=
 =?utf-8?B?bXFIRE16LzlrMDU0MmJzcWN0UWZ6VE1SZTN2QjArNjBiajRxbmJETDVxZS9J?=
 =?utf-8?B?S1A4UnliaW1malNIbDFPbzBpM2Rwa0NlUllSS1pEM0FYdlJwZHZrOXlDejY2?=
 =?utf-8?B?Rm9mZElxcnpLZCtNWGJjSU81VVV0UDNhLy9WaTQvTzRVdjVuUE5LVHdwZFBh?=
 =?utf-8?B?QjVqUHZGR2lyZGdUODBCbjZwajNxU21RSnBqK2pNSk9RM1I1cnR1c2dkM20w?=
 =?utf-8?Q?IJu7NiCzh6Wjd?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 13:22:04.2470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad208f3-f970-45fe-92f4-08dc74e20328
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7479
Received-SPF: softfail client-ip=2a01:111:f403:2418::600;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
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

Move trace_vfio_migration_set_state() to the top of the function, add
recover_state to it, and add a new trace event to
vfio_migration_set_device_state().

This improves tracing of device state changes as state changes are now
also logged when vfio_migration_set_state() fails (covering recover
state and device reset transitions) and in no-op state transitions to
the same state.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 hw/vfio/migration.c  | 8 ++++++--
 hw/vfio/trace-events | 3 ++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index f2b7a3067b..7f0d76ab50 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -129,6 +129,9 @@ static void vfio_migration_set_device_state(VFIODevice *vbasedev,
 {
     VFIOMigration *migration = vbasedev->migration;
 
+    trace_vfio_migration_set_device_state(vbasedev->name,
+                                          mig_state_to_str(state));
+
     migration->device_state = state;
     vfio_migration_send_event(vbasedev);
 }
@@ -146,6 +149,9 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
         (struct vfio_device_feature_mig_state *)feature->data;
     int ret;
 
+    trace_vfio_migration_set_state(vbasedev->name, mig_state_to_str(new_state),
+                                   mig_state_to_str(recover_state));
+
     if (new_state == migration->device_state) {
         return 0;
     }
@@ -203,8 +209,6 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
         migration->data_fd = mig_state->data_fd;
     }
 
-    trace_vfio_migration_set_state(vbasedev->name, mig_state_to_str(new_state));
-
     return 0;
 
 reset_device:
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index f0474b244b..64161bf6f4 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -152,7 +152,8 @@ vfio_load_device_config_state(const char *name) " (%s)"
 vfio_load_state(const char *name, uint64_t data) " (%s) data 0x%"PRIx64
 vfio_load_state_device_data(const char *name, uint64_t data_size, int ret) " (%s) size 0x%"PRIx64" ret %d"
 vfio_migration_realize(const char *name) " (%s)"
-vfio_migration_set_state(const char *name, const char *state) " (%s) state %s"
+vfio_migration_set_device_state(const char *name, const char *state) " (%s) state %s"
+vfio_migration_set_state(const char *name, const char *new_state, const char *recover_state) " (%s) new state %s, recover state %s"
 vfio_migration_state_notifier(const char *name, int state) " (%s) state %d"
 vfio_save_block(const char *name, int data_size) " (%s) data_size %d"
 vfio_save_cleanup(const char *name) " (%s)"
-- 
2.26.3


