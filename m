Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B13CCD6E4A
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 09:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wULOt-0005qk-47; Tue, 02 Jun 2026 05:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wULOq-0005qZ-6T
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 05:27:04 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wULOo-0003yq-Kf
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 05:27:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cswFY0AsTWo/s0EWQpVFdXlNl1j0g7t+KJOS40GG1FMyHdtWrzP+q2nOhaiqi5J/cNaZHyZLEoJzS4dfsvAQDCMrFiil7/FfPECfCN50cft7uucsTdRn1/dLEcWFXqI1DBDR5pL1rR+azWEUrH21zCcWLjUNDpGwneZxQ0BuZo3q1AZ5oysh8Je/J++ZSEC0rSaQRNminyBEG+A1H2WzqKPPvFbUBbU92B4CD68tsyadBzCyWIrpfdN3ekh4lT8ZN6Yq34PRbI32547coxXfcWeF+bst7B7liYut+mQz1kMGpFDVEyR7LXar17TBU1/Vmwpmx80+56V3g0lpR/xEhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxOLli5hATDfFw0edNBnF9MskuVfcm1vtBR85JdTAYM=;
 b=IMUjqRFv2LU+9rcK7xjFUnEaYmDY/GoUkWjGceJZixDscDDEvt4lqjOza95hz/Ykvw1EM7PobolS48HedHsLPFxz7Jx1MFVBrL7pn/575FB9khBJhaeTqJEGvqj6eCnNRQWPEhC+/5fPrrZHxGWFn0gilmoMyyRTlwUjkP4PjhKz92AoyXPS4sDxoW0M+FnNbhTlY3OAExqZc4eOCzBN9eJDLP1skPigDRvw+i3XLrCgPTh82nubtGiJ590rgmVG7GbIRIj7NRCG7aQWTXFIsO1YN0pgczNOZ+n8FtkMyGP1WayoBNX/uGUWeVzl8uza/d84zjNzZ8CWt59iyugiBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxOLli5hATDfFw0edNBnF9MskuVfcm1vtBR85JdTAYM=;
 b=quKCS1SBfJH8vXsjaVTfkVXK8FgxgeZrkx6D9yEyS/qpR288graNPYIXn//sltO1xOU2PCaL+YRX5hWb4fqDBA0Lx3D6xb9PFkDwM6Khyy7v/7apPxx53F4FISkk1zM1i7xIaATGZCaPBD06eOP/1UlPGr2YDDF8R/aYfzf+8oB2avTsWPcKyDcm7cu4gprawI+4keFIHDrb1eAxykzbq+xnT3ffL8qgtM3lJ/1wtlCfIVqiOK7OesNBbiTVu6j1VSrBGR4Bvuv/NQW2adMyL102ZdbN70zBU5E41Z3a46GdFtbN1/Awom5fOWa9FGjjK2A29LGNXNkhpxqs32FaOg==
Received: from CH2PR18CA0012.namprd18.prod.outlook.com (2603:10b6:610:4f::22)
 by CH3PR12MB9078.namprd12.prod.outlook.com (2603:10b6:610:196::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 09:26:53 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::72) by CH2PR18CA0012.outlook.office365.com
 (2603:10b6:610:4f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Tue, 2
 Jun 2026 09:26:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 09:26:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Jun
 2026 02:26:35 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Jun
 2026 02:26:34 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 2 Jun
 2026 02:26:29 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex@shazbot.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Zhao Liu
 <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, Jason Herne
 <jjherne@linux.ibm.com>, Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 "Cornelia Huck" <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Vladimir Sementsov-Ogievskiy" <vsementsov@yandex-team.ru>, John Snow
 <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH v2 01/13] migration: Propagate errors in
 migration_completion_precopy()
Date: Tue, 2 Jun 2026 12:26:09 +0300
Message-ID: <20260602092621.382-2-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260602092621.382-1-avihaih@nvidia.com>
References: <20260602092621.382-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|CH3PR12MB9078:EE_
X-MS-Office365-Filtering-Correlation-Id: 7902df4b-f992-4ca8-aa44-08dec089156e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|1800799024|36860700016|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: E9eeSsK4gPETRgd4zRWZA1UyhDkNtcvyZvVEIpaKAP36+FudkEyb8LHYRP3vx+IKyvqOZVKuGwe8ciQ94LeYQl/mLIBlugZUqGyJK7K6+wU3reLegtgg6OJK4O7GLaV42jjrNSSywzXR3pUbtaPDINSJBZ+4X5gw8UsB3VSiBDBndQqnixs61e//7VbADKVdr97H6Sr0ex7vsR/i5XORzLwBpReBhUpGztJPSruyGks6F8q/vnT+pehtPzC7wkWW5p6N3izI2wYUt0PjTV+WyS5l6BgvGnXfNmeAvRwRkEzZkX5e2Kgd3AvQyYz5YFydPFKqNU4TqTiRYg+Wwsz8WHWSbt9rWm9rMk0WAFVVQlI6Uaq0XAwi3mPepLYpKjpnqJ3OWqP2ieqtBdxK1o7RoMiAycCMKJ4QcUDQddle2e1TcPEk3EN2isTD8YF/m9bd487SzrOIljP9KD6T4LuS4HcbMe6Kenqdq9IKoSQV2IYCkl9oUQAdmR7klMA46kvglyg63uHk34lPUuCTDm4X4JSDJg98hpUqlyba8N2CyiTAAmLJ4qI/KtDCYj28V3HYEvQnfrDppEpLSGDRq1tZ65VXxrxBXqGl1vhrvztfuJozv8KHmBvK+MdLhggQwzxXW+iffdvZt2HTwtiedJjfWkqezrlFDfihns0KOEKK9Ltv7Qpl9gvajso5GG9BS2yN+VfQHI5cZ51yKZYi1+BW6mRxceuORipKdyzYyWyA1U4=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: h6PCj5s1LPPlXGvEz/d/jMgEp6Tb0oaA1U2iM5AhhuduEuDleUTp5bJqLqc/qcrB7YO2h7zxodiHyso8u/XnMR7E6lpqnBDngonZIF1WpM5gf7G2lwKWVVkpw3oLtETLJkTTMSCtnpdEQONnTDcCsQ0eSCk2uwCybhithd29U/V0SOQn92EqCJmKxGv6IDJseSgt7J9LSxzk+S9ZjwXFWXTeP7NVf5+c/7kDnFJp9bmmbOcS27Vii1cIB6fi32gaw4L3DVBDutvrlLJWj8blnX+FczQo6lCu00gEcp69Scp+8yVYcRW0t65NRUXb18rcxsBmjqdQDX0mzhXgPf8nemZ9qD8dUm+x7rCVtxbZ++Xn/Ac3Tj7uoaOkXxhv59qaT5+YxzTDnMyNNZ2ORdWQeBdPv1ZEiyzTzN42dGbyA2j9GF1PnBFxzEag/9TbK8TF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 09:26:53.4285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7902df4b-f992-4ca8-aa44-08dec089156e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9078
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=avihaih@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

migration_completion_precopy() doesn't propagate errors to migration
core which leads to error information loss. Fix that.

This prepares for a follow-up where migration_switchover_start() can
fail on switchover-ack and still report a useful error. Errors from
qemu_savevm_state_complete_precopy() are not propagated yet as it
requires more plumbing.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/migration.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 074d3f2c69..7488a94206 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2814,7 +2814,7 @@ static bool migration_switchover_start(MigrationState *s, Error **errp)
     return true;
 }
 
-static int migration_completion_precopy(MigrationState *s)
+static int migration_completion_precopy(MigrationState *s, Error **errp)
 {
     int ret;
 
@@ -2823,11 +2823,12 @@ static int migration_completion_precopy(MigrationState *s)
     if (!migrate_mode_is_cpr()) {
         ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
         if (ret < 0) {
+            error_setg_errno(errp, -ret, "Failed to stop the VM");
             goto out_unlock;
         }
     }
 
-    if (!migration_switchover_start(s, NULL)) {
+    if (!migration_switchover_start(s, errp)) {
         ret = -EFAULT;
         goto out_unlock;
     }
@@ -2869,7 +2870,7 @@ static void migration_completion(MigrationState *s)
     Error *local_err = NULL;
 
     if (s->state == MIGRATION_STATUS_ACTIVE) {
-        ret = migration_completion_precopy(s);
+        ret = migration_completion_precopy(s, &local_err);
     } else if (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
         migration_completion_postcopy(s);
     } else {
@@ -2900,7 +2901,9 @@ static void migration_completion(MigrationState *s)
     return;
 
 fail:
-    if (qemu_file_get_error_obj(s->to_dst_file, &local_err)) {
+    if (local_err) {
+        migrate_error_propagate(s, local_err);
+    } else if (qemu_file_get_error_obj(s->to_dst_file, &local_err)) {
         migrate_error_propagate(s, local_err);
     } else if (ret) {
         error_setg_errno(&local_err, -ret, "Error in migration completion");
-- 
2.40.1


