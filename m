Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD42CDB471
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 10:14:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbben-00041o-3T; Mon, 22 Jun 2026 06:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wbbek-00041M-LT
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 06:13:30 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wbbei-00063l-Of
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 06:13:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hdXCsGwlmwToawyJHfAZAj54xA0YCUSDv1WVCd2n4vX5lM2Zon6d33aMV7/nC3J36psfT6ZqjycDsx6QKvh0aAsQ66roAwcIhe0PpN7ChjTFVvlu0TZecVh31b+G5VetH0l1AmhcaJ7bgtBhOg6JLWHo3+ya+knDcy7HFBZcMOOWthLc4w5PA2E+f6W7ca7Kf/c7WaOVCpakEpCIr5jarsc++0rsscLowywWmE0xo+Vhnl26GFBAk+MciUAp/Ty7pg6VE/KneZhzoJeZcKB43s8XlgbsqOIxo+f0GcrHbGhFVTTXcGOPzM3rF5rITPqVHYH6OtIwGuTye9RDdADXdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3U1Vhc3PPkRo8n6cEmY4x0hfK8tjcE4WHDibRY6KGk=;
 b=y1bDnUAl0ftQtLvJhfog+ZVol3IVJRe6Xx5fh/vKgghJfEtM84gUd/Q7ku6FUc/mkRDMxOdaFeed79Uvnm+s59H57Xri+QcJqG5h8mnv4dJmvGpQuCHTi6LSDuUfHO9zQl+29yK6AUcKQmGrCMWyOcOUEDPvW7ehsQ3hKKC9QRAAZmnxwElufQ3u/ZtxvSXv3YBVSA8bZYhwTIwzDm7M+vwHCYpBOeBc+9T/CMJlm482ylRh0HlGxpZmFMvUv4AJIUh8iVs0upC5vVNBZHdSTwkrnNwMbV8EHxn4TAxKLLUm+Xx0pomS6OTwKPr6KevCNu1PBU7DiydtuIiz15G73A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3U1Vhc3PPkRo8n6cEmY4x0hfK8tjcE4WHDibRY6KGk=;
 b=DLczEssHp7eB5TgIQLdN0A7bKsIqoSHF3qI6SZBHuuZJJFtWl9ivG9U/WxbEzfVX3FuFYIQ3SdfO3GgPITLuRhBYwwunoacJ9iHVhyFZE4zPd83d1PSyJqouwosbPShi03dXSa1PtiMZnUiMhi61Dgfa5uaj9Tyb0oUnrlioNP6TB8YFDITJXYcSbMCFgg7BmLHDNlZm4s0ARUvKQJvF1S6rvSQ2rBff0BvPFpVaebd4ZquyJP17Hl+ONlDuN8qsEdqWigLJSiiZs1h7k2byauuJ0dGmIeo+vMFU7rh6Ix76q6I5a9AWI719d/8MWFTWIfVq2Q2fa1AolDACbzZMww==
Received: from DS1P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:455::10) by
 CY5PR12MB6370.namprd12.prod.outlook.com (2603:10b6:930:20::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.11; Mon, 22 Jun 2026 10:13:16 +0000
Received: from DM2PEPF00003FC6.namprd04.prod.outlook.com
 (2603:10b6:8:455:cafe::39) by DS1P220CA0008.outlook.office365.com
 (2603:10b6:8:455::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 10:13:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM2PEPF00003FC6.mail.protection.outlook.com (10.167.23.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 10:13:16 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 03:13:03 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 03:13:02 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 22
 Jun 2026 03:12:56 -0700
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
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 01/14] migration: Propagate errors in
 migration_completion_precopy()
Date: Mon, 22 Jun 2026 13:12:01 +0300
Message-ID: <20260622101214.25770-2-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260622101214.25770-1-avihaih@nvidia.com>
References: <20260622101214.25770-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC6:EE_|CY5PR12MB6370:EE_
X-MS-Office365-Filtering-Correlation-Id: f02ba569-cebc-4c83-4261-08ded046e06b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|7416014|376014|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Q53zqNTXhfjkGemGT3j2wb3JZJjA58meDgNZrjNnDaOkczpzL/ZSGMBjjIebzK+JvWscr8yLrQkCmnSFh+es5N9iJ4+lFCBOXSktuMZzt1R/kHhCg5xIvXRe1tAq0ougT7jmQIZOt3J0AyIla8oD22Z/f5MOopSz11CNRAyRPCXl20jhItLgUAweuV0N+ynnokN0rv7T5zFBfq8NF1/Xu7C2CECCNgKzqw1OCFfNaUqS42pFgX/rORmA/fCwIMYewy6ul//VOzFJGmNY7fP2bEyA+9FH97uBlqp/icrIQE5wow7/is4cPKMuuYCt0Z5yjk4ukOTdRFqkJ+X65Y3lFZuKOlWeZ7ojh9IeClfdrXhhCJihC/TmPgJ6BZXSba5LJ8SiyQ/8zeJR4zSn/mQx/JNZp4yTYHJEzrG9wgu1MJ0tUtn0UjeU7e6Dgg6NXXwBKwZwQXz3qIXfOj2WIcp95WWQh0tceCSRgEHdD8IFc3w0W8MjA5fUo4lhVvI9XGkyvR34qYnHbJGrnYy2JoAn0Ufw7cpqzUzHUPaBw/JbCJ11hCc6U+ilhoCgTrCT9YyzV+hbNphyZjT5UvIRiwwzfSj+Gp6t/9+OfMdhkw0xXoiJoxrCaRZ9OSYDoQhjoGNNEtrINz2jmedc6lrVcb1ygLGLUW4EyPm2kaBS6cRCRu8gN1Tm8fUA3HuW3ZVRRonfhQKlUeHrHI6GELlpn1V4KA==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(7416014)(376014)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: djZealE3ARmsx29uvEmTsN5JCl9JuzK6YvPdkLnf1gPUQNtZenKHls0NL9g0Yfg4Zd1cV2FsvInWps14G198QsohLmS6LTesbXmwjK3XXwSLYvpNosTwuA+hD7fetNhmttEEGNvJ1Gv0/IrgP5Nmqj4w5qll4h6KOjpifeShhJHHsaHDYLxeHirQDvaQt7H7n78/EDRcqREDm6H/2GQrHxTw1zmzl1pZGQn38FoN21Vg3qtBPrNi3+wxwkpvzQlypLv3KEglBPR28l2OfDrKV0hfWhEtirS8HbVKQ6CX4Bc9ecmiq+LwfW9pk0g8uEq6UrfgHwV08m/s71gOOwhAHv0e/wDP+H36q7hImZ+tc1jK8tCbeBX0F0G4IBrH6vUVaV+tHB8NI4GCsljtyXDcldR6sgtUV9A5uPyE+B+NsvrDb7bqvRdBvBidXcpxTXXk
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 10:13:16.3033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f02ba569-cebc-4c83-4261-08ded046e06b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6370
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=avihaih@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
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


