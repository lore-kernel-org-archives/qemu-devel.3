Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44786CD8CA7
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 07:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWrN2-0001vi-3p; Tue, 09 Jun 2026 03:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wWrN0-0001vM-Gf
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 03:59:34 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wWrMy-0003Sf-Fe
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 03:59:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfsGM5HuRApxF3oOXYEdT4f/UOz2H5xa/yGNH2gB+Y8Y90cWbRQtLhvU6mHnVeWu+4kcfszmmG8ca7HlJaKpug6Bs/GJX0ogf9fUBzr6uJHoDLulDI+iHfogpV6cRqm7JFEact/8G5fdEdgzemXRxhv6NILsFlrWo4m8n4z41vnwJeXX/i8Kctq5fkr8rG+Md0i258yGk8gJY5fz18FgXITeizWbLyR23RVq2uJplvcNkXjKPYIhTv4uuGQPgpYs1M01V6HgbmttDWmyYCiRkDrPHtF9+Z7JArMyxSKcrN5Lam2ZlUY5e0ge7ZafPrsVnp18rtRiLSfQcRCAwLzCuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WhYoOMci1BNzaOqFhLBZwNsiAPyZoDLsa/M5JrnZ10E=;
 b=hYjInA7wndU+8eA1Eif0w/qMzzavL65cJWuFW4/xVWNvisKAUAxnRrB/J5bcIgvyZqU2hpHe2oBt5q77FkCov8X9WxHF47lfWcq5FRq9ZQ8LnsFljbVYx3VZt6IN9Cwr1BJhvc+2lFbIS+4vkfFaD6exKF2zR+EANY/apD4fIn7POSDOef0CERtV9VvnDJqm4P/EkMcmeVw70RGKDrAXavamefj5La4ExBb0DtqelXWyKtEvnu3tASRLM49XyKcVUlM1VBS+tLlHsRNTio+VgSxBGw54VdxeSq8NAdcRBZVUZmIzSTzk6li6eJtTVYBNRJxmYLl8siQkjv6YL9eoMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhYoOMci1BNzaOqFhLBZwNsiAPyZoDLsa/M5JrnZ10E=;
 b=ocWAt1mzJAbI+VkCEgNOKBoetOWTBUmFOl7mwG88y6z3oIhBhKGWa4MHUGZv4JkbHRE6p804JFGRMyo0gQEgzuG/yI9m5k8XAXkCRohlPMZHUKE4Ten2Zb+BUkYZeoRUfMZyjVMp8S8OE+Qfm+bsu4SBk82psvbkE5CjuyL0cs3u8BJ07erNDwRqsXISXICXi6KnLtokP6slwyIrQBxAd9KYsrhR96XronMClF6bzRqkCXyXyR+6t3HXmU8jIQGB+WWKMBe5YYXNXM/c+Z6b5o8nVxCaqDbc1IEJe16oKOQnWHaRc+UshGurDwMZtgiXnqxQmU1HEJF4KFtn+F2JZg==
Received: from CYXPR02CA0008.namprd02.prod.outlook.com (2603:10b6:930:cf::14)
 by PH0PR12MB7862.namprd12.prod.outlook.com (2603:10b6:510:26d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 07:59:25 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:930:cf:cafe::22) by CYXPR02CA0008.outlook.office365.com
 (2603:10b6:930:cf::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 07:59:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 07:59:25 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 00:59:06 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 00:59:06 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 9 Jun
 2026 00:59:00 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex@shazbot.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>, Zhao Liu
 <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, Jason Herne
 <jjherne@linux.ibm.com>, Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 "Cornelia Huck" <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Vladimir Sementsov-Ogievskiy" <vsementsov@yandex-team.ru>, John Snow
 <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH v3 01/14] migration: Propagate errors in
 migration_completion_precopy()
Date: Tue, 9 Jun 2026 10:57:59 +0300
Message-ID: <20260609075812.32067-2-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260609075812.32067-1-avihaih@nvidia.com>
References: <20260609075812.32067-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|PH0PR12MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: e494a910-7200-478a-56bb-08dec5fd0633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|7416014|376014|82310400026|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: GwImsUO5/9Ee8OtH1wxvdEoDU7hKidnHQtGoA1rzpe9UNiyeBuwXhqwyNQghknxFcTr16J1l0UteHzRYLwbFIU+Y1IfPxGmvnw1Trl5ZFeYMSTW+FTS1udS694gLfR5Hq3+RVqosQDOIyXht+N9LUZnpLNPjzhK3L2OuMtF+0tsHM08BRbFKt644HxPFM7reVpA6BmuX7j7wNHuVnbHPRiDCqyr6+YNZQ7SNlqWbgHc7chRIstn9EeR6zofSZ4cR5vnsNuion4yGVzqi8CeL9TV5v8CCb0KBVSnbpx007ZK5TPtQiF25ADMDs3vs17f9PRSbzhHQe6YArjl3WtX+vQnPIKVAYxWpdCaWcnX0CA/k7igATEwojpgUefDUrTVXqE86zF+dXdxnMIrmLzMR3CtopzTJxEMxdDnuF/FP0Vrfd0Vi4yF4vvKaJJkYsV1Gl03gYDidrTBHeKQE68rQqxjl+5KYMEF6aSKkY8V5noxLz9kV3K06gYeln1WPawGpPzbxDTBDIssz6DD/u90gX2oT1pNW40ZO9tLyQk5OlJjUDCPUB1Z8LzF/cRXgi+kE8Ky0x3KBZlB7eehVN4rrfZUJd0XYpxiAc5YpJXEdby4VIHpNWinN2SPWOJT6RW9KQEGIAY3A6ZjHEkIuHP2kkSDnrguwz7wlBlGbkiEGdH9kJjGutN7iJJ0B/WeVkfVZujsjQRjAW5/Et3oxlXOi4Zfc3MxcrBUcOD2rIsAZB10=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(82310400026)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 72qZGJWHgTkwvdQ3o7FIFnq49UgUqMjU60MDvLEfvnjAL/mvDDCkE71mzbj65SWgxobl6KDH9r7tCLWo34KP8sE8lwApd130pwxc4pS7apG1XqjQygpm+TOKrvLBsYreJ4Sh376C4HnKBR+vNNaHK+t5Qe8NxEJeCsTzCv5PFId0vZHZ8JtaC030QHVDYXo9BY74AhKEj+zeYpAG5wK6aeZsCKg3QedWWdqPr7Y1+Z0DQaXytJm0qhz3ePBs3YXF0+iEiAwcjhY3ozZVwVzgGwrSnmqZPR+M30m4+IhSJirCUEvFnzPWzIldZ1PzEaMEehTrwkMCgS1tJkqPIX/vbzDP5F/eoMHtYNrDx0juZosOC03sNhSq3nuXgA5kiumCDwptVL+/5eU08OgV9HDh1G7di+a9XhSOsU3tgbYZKrFOxRK7Gt8dbG3UfbrovH9I
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:59:25.3765 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e494a910-7200-478a-56bb-08dec5fd0633
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7862
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=avihaih@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
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
fail on switchover-ack and still report a useful error.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/savevm.h    |  2 +-
 migration/migration.c | 13 ++++++++-----
 migration/savevm.c    | 29 +++++++++++++++++------------
 3 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/migration/savevm.h b/migration/savevm.h
index 96fdf96d4e..b6bb4fa977 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -44,7 +44,7 @@ void qemu_savevm_state_header(QEMUFile *f);
 int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
 void qemu_savevm_state_cleanup(void);
 void qemu_savevm_state_complete_postcopy(QEMUFile *f);
-int qemu_savevm_state_complete_precopy(MigrationState *s);
+int qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp);
 void qemu_savevm_query_pending(MigPendingData *pending, bool exact);
 int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy);
 bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp);
diff --git a/migration/migration.c b/migration/migration.c
index 074d3f2c69..aad23f3228 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2814,7 +2814,7 @@ static bool migration_switchover_start(MigrationState *s, Error **errp)
     return true;
 }
 
-static int migration_completion_precopy(MigrationState *s)
+static int migration_completion_precopy(MigrationState *s, Error **errp)
 {
     int ret;
 
@@ -2823,16 +2823,17 @@ static int migration_completion_precopy(MigrationState *s)
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
 
-    ret = qemu_savevm_state_complete_precopy(s);
+    ret = qemu_savevm_state_complete_precopy(s, errp);
 out_unlock:
     bql_unlock();
     return ret;
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
diff --git a/migration/savevm.c b/migration/savevm.c
index 23adaf9dd9..9d1d58c8f4 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1771,28 +1771,34 @@ int qemu_savevm_state_non_iterable(QEMUFile *f, Error **errp)
     return 0;
 }
 
-int qemu_savevm_state_complete_precopy(MigrationState *s)
+int qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp)
 {
+    ERRP_GUARD();
     QEMUFile *f = s->to_dst_file;
-    Error *local_err = NULL;
     int ret;
 
     ret = qemu_savevm_state_complete_precopy_iterable(f, false);
     if (ret) {
+        qemu_file_get_error_obj(f, errp);
+        error_prepend(errp, "Failed to save iterable device state: ");
         return ret;
     }
 
-    /* TODO: pass error upper */
-    ret = qemu_savevm_state_non_iterable(f, &local_err);
+    ret = qemu_savevm_state_non_iterable(f, errp);
     if (ret) {
-        migrate_error_propagate(s, error_copy(local_err));
-        error_report_err(local_err);
         return ret;
     }
 
     qemu_savevm_state_end_precopy(s, f);
 
-    return qemu_fflush(f);
+    ret = qemu_fflush(f);
+    if (ret) {
+        qemu_file_get_error_obj(f, errp);
+        error_prepend(errp, "%s: Failed to flush QEMUFile", __func__);
+        return ret;
+    }
+
+    return 0;
 }
 
 void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
@@ -1874,13 +1880,12 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
     }
 
     ret = qemu_file_get_error(f);
-    if (ret == 0) {
-        qemu_savevm_state_complete_precopy(ms);
-        ret = qemu_file_get_error(f);
-    }
-    if (ret != 0) {
+    if (ret) {
         error_setg_errno(errp, -ret, "Error while writing VM state");
+        goto cleanup;
     }
+
+    ret = qemu_savevm_state_complete_precopy(ms, errp);
 cleanup:
     qemu_savevm_state_cleanup();
 
-- 
2.40.1


