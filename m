Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95B8E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuIk-0006ly-Gv; Wed, 18 Dec 2024 08:41:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tNuIY-0006gp-7W
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:41:17 -0500
Received: from mail-bn7nam10on20624.outbound.protection.outlook.com
 ([2a01:111:f403:2009::624]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tNuIP-0004hu-BP
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:41:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6vLya7UBJ2MuU61Dqvkc47pd1o5ZqQloLrCZQ0h6WQpENxJpIFnDu4DSbEgcVVrEqHrbJVRmLRvlf2Aa6F/nN58BHGm+t2v1A2ejF3zCdDhaVKcaP3uU1PaNEN76RNpKylWFMQbateGqiUJOQGjNkegyklcl02plNcnuG8Iq/LKys+/cnsantMzFomT/j8xP59aj+YFRiY1vLAUAq8X3VRKznU0SlMMXdqtf4WAbRRJWAOSVBxo4kc8gnRQmQweLM81+OpSdHTxrBJbzw0R1E0cm7lIsdWi8UsDYiGUFCPhAjdaoUFQs5MYx4vUygOSF611hXYEn8AvsGTlH38PAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmdvqL8OCXMc7eJg3MzqQn6K8IKkUcFUi8NZhsh36Sk=;
 b=h2grFGuDWaizSim/v80xiQpA7EiaCvKttY+2AgykrT0z6wYYe7Ug8b48uusSdXjayiHAZ2EY7Dvf/qvvF9jp/HC5yZqm6VJzJvW0mvmRFHukW4A35MkxGAqhoKlYA4KJu2h/VKzUW/TRbCugTMdavnSh3tABr6+VbUou9u7ZOycRyiLD+WEJyOyOqlGr7mGWHD7PT+b9T6l0i85gp6XVJunJxhfJW72KkXs/1OOmDpPOh9jJgs3mDxbrOd2sxq1NIw6T5QhOZqoKiH4RY7NFg/aP09lu/IPfe+nk+H791PrzAr27nHO8upuYDWc4Azdw5x2qJEedlu75I9wUVi3TfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmdvqL8OCXMc7eJg3MzqQn6K8IKkUcFUi8NZhsh36Sk=;
 b=pZLyEAQrnPgC0d0/QaUrEhXvceMb/5HOtAiMXqVhgl/XJ3X05/neh+39UnsUUMM9u6ArZnygh47wPxCz9BvrexDQ1PbwvsgOw7CN0n2zpOWwcEuXKve/L1fJEEmBLLfcQGu7EH+GA2Ly8OBhyiJ42nzVw9+uU+QYNQ48q4QARQNQwrY2q/B9xb3yTpVqJyk707jwpGOcELZn6Jdt9psrVGfgsVHIg1u9ubXhGztzUPv3uRbajQBNlBhCox2YmXxUJjtc6snxLhGBJxuCyFsKNPDktko0Hj4YdNmOBUVicWkrVRhQ5vV2avENsaqNXGiF+nKU9wGmlzqTLi6D5zUFHA==
Received: from MW4PR04CA0040.namprd04.prod.outlook.com (2603:10b6:303:6a::15)
 by CH3PR12MB8726.namprd12.prod.outlook.com (2603:10b6:610:17b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Wed, 18 Dec
 2024 13:40:55 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:303:6a:cafe::ef) by MW4PR04CA0040.outlook.office365.com
 (2603:10b6:303:6a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Wed,
 18 Dec 2024 13:40:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 13:40:55 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Dec
 2024 05:40:44 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 18 Dec 2024 05:40:43 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport;
 Wed, 18 Dec 2024 05:40:41 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, Hyman Huang
 <yong.huang@smartx.com>, Joao Martins <joao.m.martins@oracle.com>, "Maor
 Gottlieb" <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH v2 7/7] migration: Unexport migration_is_active()
Date: Wed, 18 Dec 2024 15:40:22 +0200
Message-ID: <20241218134022.21264-8-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20241218134022.21264-1-avihaih@nvidia.com>
References: <20241218134022.21264-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|CH3PR12MB8726:EE_
X-MS-Office365-Filtering-Correlation-Id: f94c94ba-1e2e-42f7-f298-08dd1f699918
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGxsU0t2VmVkMW45STh3andyd3pCeGtja3FVYklDV2dRUlI5dWlaelFRd2c1?=
 =?utf-8?B?c1NOc3ZacEordnM1R29abG9McVJoUjk1L0NQS0Vtb0FUOTVZSmQ1b1VmL05m?=
 =?utf-8?B?ajBGVDdwencxV3E4dlhUL0wvNnE4c0NKdDdYMDJYQ3BGQUtCSmVnVG5QUWNJ?=
 =?utf-8?B?bVl6aGJtZkxMV215OWI3N3NoWFIyNkJ1NlNrTjlOd2ZzbmYycDcySldsd3BW?=
 =?utf-8?B?Vkx0bk4ybFd4aGlkZlJONEZMN0hmZEpMYytJUWE2Q3VyZW1uNUR6YVVnZ0pU?=
 =?utf-8?B?OWprTzlCSlNoNGFvNktGVXZYclJaemRRQUtsWVo3U2VKT1ArSEJPZENEcFZp?=
 =?utf-8?B?TjUxcmorZDZNTUNSMkljd2tKdjJmbVVjajhEMThTNUVwbGZVU2tMWFFOQlUx?=
 =?utf-8?B?WEJjblFYRHN2eFFwUUVWS1ZDUHpDMjVhZjIzRVZJRnFoSjNmZGp2SlBMaXN2?=
 =?utf-8?B?NzhyemV1R0M4aFdFdGlnNWZtNXVMK0NGS01GZXhrRTYvZkw5YU9EdUtKZTRz?=
 =?utf-8?B?eHpwR3VkOGFZMWlLOHM4SHdvRXlkbU5QejA1ZmM1R2hYb05hYUJPMmsrSWlq?=
 =?utf-8?B?UUlObHNmQ1pxalkyS2dzL21zMzBzT1dnN054aU9ucU5Mc0xmWjZpTjFhS3lL?=
 =?utf-8?B?SUFpckpGTG1LRE14aEVzdERhaEN1OTdqQUFOK01OL1pTQ3BmODRxbjBVbkVx?=
 =?utf-8?B?eUdVMUVOd2tBWmZvbjY4N3ZEOFlRQ245STdlNWl4cDZsOGlSSlBjM1VEZjl5?=
 =?utf-8?B?NVkra0lqZ3pNVFBQb0dKeDMwUEVyL3RPbXRlb0JqYzZDQmxFbFJoZU9pSFZa?=
 =?utf-8?B?UjhiOHkvTWc1Zjk2N1QyMHg2NUZKN1lBTExUV1h1M0p3Y3ZpNFZDblNxdWxr?=
 =?utf-8?B?YTNUQXllVmo3NHYvbktjZHlzRUE1KzZDdld2YUNVMXdKNUwwRXArbXNjbnNL?=
 =?utf-8?B?eGVnckttK1g2RHZUd0kzZmdsZlp5KzJ3U0EyK1QrZlREZU1TRFl0NW45RDJ6?=
 =?utf-8?B?OXFIRVYzRjFmR1pRdzBsdGlnL0p1QlZGTldQMnY4a0xWK29mRFpmWlBTQ0hR?=
 =?utf-8?B?N3JiazNTWjZCcmIrZVIzWS9aNXhuOU9EbDVqcXNPa1lSZVlGaTN0Y1U2UXRD?=
 =?utf-8?B?bklsZHlrK1JwQ1Y0eDl2a1ZBZUFmTHZjbzZEeFhQOTVPeWwwNGR0bUV5VUEw?=
 =?utf-8?B?NTZlT29rclQrYVliRkxrd29YUHpsTGhEZnV2elhMcFZwSHEvL2IrbkpDQ1Q0?=
 =?utf-8?B?OUczN0JNOTBXNHkrTWVFbU5NcE83VGhVcGZ4M1JIREhBKzhLU0NVQ2gxdkVW?=
 =?utf-8?B?YmlsaTlTWUlUeE1IbitqUzgwbUZSV2U5Z2F5bzQxSEhvYmlZMjl1U1dFeXYr?=
 =?utf-8?B?UUcxb3d0Wk1ZUG1BdlBnVGwveTZqdkZiekJ3K1lQN0xjc3c4OURzQ2VHV1ZQ?=
 =?utf-8?B?VGJuTkRFK3hybjY0S3ZMaE5zRm50RzFOTGlQTUJhdEM1dWYvenhVTmg4YWNB?=
 =?utf-8?B?OW5BaUJHcmMwRWdUNlR4YWtra3NtTWhtb0RaREJBNEd2dnVkOVBSemhZSWxJ?=
 =?utf-8?B?YWY4YXJnOTBnZUp4WFJIczRwVUN2aUVZNjhFbWx5dE1wMmNwcFlwSEZ1bmFX?=
 =?utf-8?B?aE16MU9NaGh4MFhYWHJtWlMrd1o4Z3ZaY0Q1eWhEcVV4RkcvSm5WOTJlaTZR?=
 =?utf-8?B?YmJQdkFOcjlDa0tKek0zbWI5V21WTnhDYkVPbUdhVVh0aXpNTG9uQVBiQjVB?=
 =?utf-8?B?Tkw3VUQ4UXJmT1haZVNhTWZxaStPN2VlK1dsc3B2ZmprZ1hrY1hWY1YrOTRp?=
 =?utf-8?B?RW0reXN5eGRUOFJVTy9STk40VGlpRWh4a0tCeWkvTWJrQTZLVjBJbThRVkVu?=
 =?utf-8?B?L1BaK2t0NHdnTGFaMUpBOE55UlB4OVBzUnBkbHZEL3VxZndrZVBvSGhHV0xv?=
 =?utf-8?B?cXIyUTEyZU1aQlkxWHRDeVFzSngrK1g4TC95VHpVUEhxS0dLMUZycDYwbTZL?=
 =?utf-8?Q?1zQrwNHvogYvcXc+fFKXnylH4LSTXw=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 13:40:55.6273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f94c94ba-1e2e-42f7-f298-08dd1f699918
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8726
Received-SPF: softfail client-ip=2a01:111:f403:2009::624;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Acked-by: Peter Xu <peterx@redhat.com>
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


