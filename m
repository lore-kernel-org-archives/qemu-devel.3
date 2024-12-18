Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01AEEE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuIi-0006lH-VZ; Wed, 18 Dec 2024 08:41:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tNuIY-0006go-7X
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:41:17 -0500
Received: from mail-bn8nam04on2061d.outbound.protection.outlook.com
 ([2a01:111:f403:2408::61d]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tNuIP-0004hm-Ca
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:41:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tA5RiB+TNw7zk0iK3Vgw3+XKWh4OCrrwnV2FkKHffUI1EOTdixZagcRy1QVQ9e2uj20DNQ5gCZlrgWQj0M+Qp4JGOt/NWYssouOmlkGlcVfaxLMOKHdy3MzSB0ZPPk61RytL3XP4W/5dj2juyudiTZarXPZ9MiXF8ppdNA9tvcOmxgIaFN/hQ+LlJA5d3cXMn6ZxFjgyeOm3bMOIXKsZAy6rk0A8f55nt3UQJ5seK9/xnRHYGyUymCe+IRr6hAxCNXhgXfzOKRqXAbjTxwV7jzvT4VhaMArJhLxReCaYqlocsu8xUeX/+zl5zBHY9HtpKANE13S5RsNsntJwsqSNjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqleAvJ9PRXc6uJCv6Tr1N9BPEJC167mxaoejccZf30=;
 b=XvAiEILUCoCknWEkLOQkW5qONr6iEWi5iTsYP3l2kU/wJymfdiT4M5kJZ9mku4kKaOszF82fkKovAnd22C07urVDMP2WRERRMf8SevCWGOB+dakWKco0owTthxL/LGx8p4fwUjzSs/nHVoAfYwo9cisUmOc5NqGNlr22zX7J8Co+qcv3gXoOaZ5SWvyW/e55VuuuH3/iLRftvQnpOZ3K1wkQIMElFt5yaQo8FpfQ9TRygAOoJbHDxQqRQeYwJPe8hQ8RpgifyTsT6DAOpNbHZGwqGf9+4sgU4c0kEq0nIu3mmR3mCFjecUBWzm7gIvKbFdooagOc2on5qegfTx1/7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqleAvJ9PRXc6uJCv6Tr1N9BPEJC167mxaoejccZf30=;
 b=Xox8DWsaE9jixeESjOMIvZ7LsQLbgMCxOLI1JUGMzqtYc7rVAaKNO8TNKvsUJSUPVPDF6sXoisD7X//LD/TS4XbJ+/p+lJ7VgBRreRMEZzMyK22dO3PlSBhlPkRMhXo6zgRNJqwL+lr+sF+BiUysEBTZJKAJaZCK/X9TWv/hCnff1uEajblbyLfR3R/Q/iNQ3DooaiMjqRiLUhqFOgbzfoB41ijxNvjnNc76OlMtgUpw9hPSLUY68388aykkFQtYq1ysVogWp2G7C/bny/hyebxNio2BsVIXT8HODOldQPgJ9RB2KMB5zmNhxbJT2K9XVOKqnO6xq0l7nshQI+hicA==
Received: from MW4PR03CA0235.namprd03.prod.outlook.com (2603:10b6:303:b9::30)
 by LV8PR12MB9110.namprd12.prod.outlook.com (2603:10b6:408:18b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 13:40:54 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:303:b9:cafe::2d) by MW4PR03CA0235.outlook.office365.com
 (2603:10b6:303:b9::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Wed,
 18 Dec 2024 13:40:54 +0000
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
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 13:40:54 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Dec
 2024 05:40:41 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 18 Dec 2024 05:40:41 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport;
 Wed, 18 Dec 2024 05:40:39 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, Hyman Huang
 <yong.huang@smartx.com>, Joao Martins <joao.m.martins@oracle.com>, "Maor
 Gottlieb" <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH v2 6/7] migration: Drop migration_is_device()
Date: Wed, 18 Dec 2024 15:40:21 +0200
Message-ID: <20241218134022.21264-7-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20241218134022.21264-1-avihaih@nvidia.com>
References: <20241218134022.21264-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|LV8PR12MB9110:EE_
X-MS-Office365-Filtering-Correlation-Id: 116cc3a5-aeb7-4ca3-fac5-08dd1f69984c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1hrM2lyYzd1T0ErZmNpUDF0WHlCZWJqYWxsS2dVOVprbDZoa2V6Mm5FMHlY?=
 =?utf-8?B?N1RsakxtREJpd2VOY3JaQm4waEViK2luRk9mTG91WHQwYUlGVERmQVlBcWhF?=
 =?utf-8?B?a0w2Q1p1akVtNjRlaVJaZHN4eHBxSXVhcnM1RjVwNG1SVmFFaXNUTmY3ZGFE?=
 =?utf-8?B?M01LRk0xRmY2MU5vMGs2QkZabmtCb3JNVWRlSkZndExvaXJBem5lNTBieGN0?=
 =?utf-8?B?VmVvVHdHU1F3eG9CN2FEeUgwRE1rM3N0d2daNTgreXBlOW50cDlod2QzWE9q?=
 =?utf-8?B?WlVoUFVxczRiakZ0cFdkTGl0M0VkZSttSXc0RDJoMCtpbFA0aE1GaVdORkx6?=
 =?utf-8?B?bXBXREhSRkU5cmlwTnZSdFZuemV3WjliaCtmeFdxN2QrYVVBcW5tcFN1UGdW?=
 =?utf-8?B?RndrSm5qTU1laUNhZ1YrNXFrUEtYL1BvTHR4VC9KdnhESFVIdTNuaXRUNzRS?=
 =?utf-8?B?RVNyakpYeDczUGxBUmlGQjlDSmVUMDlYTjhBZXRlQWJuTG9OUUw2R0c0MzVv?=
 =?utf-8?B?RHU2Tnl6OWtJZHB3aTZVaElrcW5udEpaTmZGVlVLY21FTFVXcURhUHowOTV3?=
 =?utf-8?B?Z3hJTVFtS3R0T0xTSWdUV1U5WEFOWnF4dkhwNDkzbVI5ZEdRT2ZSc2hsWjFz?=
 =?utf-8?B?ZjI5N290R2l3MVJuc29LWXJEM280VHByNVRkRUdZNHhkMi9nWmVZMmp1VTJ3?=
 =?utf-8?B?UDBPdkRLclJKcGZxbkNLK3o5M0V0Mi9JbSsvWVZ1b1dQYjBqcDZWVmEwaTlF?=
 =?utf-8?B?VzhMYXh3czFabENGTDlaeXdmRHJQaDFURjVXcWpBQTlub21aSGg5dCtJalV2?=
 =?utf-8?B?dXAzc3RDS3R0TU1XNVJYU2FPWGk5bEN4TlpDZEZWNm5CU0d5anhueXE1cTFa?=
 =?utf-8?B?SWUxbnd2N1FhZzlPQjBpWGZlUXI2YjBrUENhRU9EZjhhVFBRc08yTndkNjYz?=
 =?utf-8?B?eVM3V1JWTDRqbGdUbWl5cTZ6MXV6dDVmQkxPVjAySHB0RjBKWFRTaEJaSkRy?=
 =?utf-8?B?dXJyYVExRis1cEpkWmxhQjM1NTZGV1BMMjJZZDlGbnBXaHhkY2JpSERsMDZo?=
 =?utf-8?B?eHRkNFBodEdNdXd4bmR6VG9lNXJDbjNvQWFmbGExZ0ZzZjAyNUQvYVBqSGlx?=
 =?utf-8?B?MXdqTjJzYUhPL1VJOUZtNXdHNUJRRldOLzhudy8rT3ROZGZtWlpxWjIvUTNI?=
 =?utf-8?B?TVlXN28yUURycm9JZjZTSnEyV1BlelVJZ3BZbWVKaXZFZTVpYWtTY2FaRk11?=
 =?utf-8?B?TzdGM20yM2pHVktEQ2pldWFKTkV2MzVIQkV5R1R0V25rOU1VTTIwb0RIdUZr?=
 =?utf-8?B?ZmwyZlV2TU9lSmkwQUIzaVorbk9HRUdPZEVoZUtjcGxRR3l6NU45ZVhUbHpi?=
 =?utf-8?B?WVhQK0VxbFZ5ekRmaVpSS0x4OE5zNW5talBzSG4xc0hMQThHRUNMa3ZHWVNk?=
 =?utf-8?B?a2dwWlNpNHBtd25VNTkxSUtxTHNNTk9vd0YyZ2J1T293NnlwVjQ2MmpYeG9j?=
 =?utf-8?B?UlVVSVZVSHRmdzJ4K3YyNDBESFplS3lDQ1g1RzVXRmxGUG55OFlOTHk4dHl0?=
 =?utf-8?B?cEZxMWdEWVNwR1UzenhsL2E3N2VRTEtwS3lyZDhYVVR6Ym5Ya2t5d0JNb3dx?=
 =?utf-8?B?OWh6MVZVVU1JNk4ybWZrMk51Z05pU0ZMRDQyR0VhcHRwSjRmVVdOUTNHY0pU?=
 =?utf-8?B?QWt6cXZ6c25JSmZyZzdlRHM4NGhCcVA3MVh4MUxVd1ZVMzVEMjRFcjFsOGJj?=
 =?utf-8?B?R3BnR1d6bEVna1FmZ3pSVUpsREZQblg3cmlsRnlLQ3cyc0JkU3ROcjhWbUdL?=
 =?utf-8?B?dHhDOGdYYmJpNFJJajF0ajgxT3BXK2pacmZMdDUyZzZKeHJCbEMxcWxlTlBP?=
 =?utf-8?B?Zkg1WTVnblU2ZVpJSEpVVi9zUFFtWFBNZkdoVHM5Z1psbW92djh0Z0tKV3RZ?=
 =?utf-8?B?KzRhZWhkNENiWkVhZUI4REdvZStpSDZIczJWckh3OHkzOFl2NWxSeFl4aWFo?=
 =?utf-8?Q?4BMHVueX29GSVLVxbBnrFyJGi+FyoM=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 13:40:54.3376 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 116cc3a5-aeb7-4ca3-fac5-08dd1f69984c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9110
Received-SPF: softfail client-ip=2a01:111:f403:2408::61d;
 envelope-from=avihaih@nvidia.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
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
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Acked-by: Peter Xu <peterx@redhat.com>
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


