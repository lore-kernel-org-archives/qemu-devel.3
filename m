Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB702C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgf7a-000403-Lx; Mon, 06 Jul 2026 04:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wgf7L-0003OV-KT
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:55:56 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wgf7J-0007Wr-LG
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:55:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sPkLEa/8Avj5lQ/os5alPMpxNwI6nuQmS1mVup+lhHGI20VK7IitWpyhtZv6Mw/oURYe658xFCJ9VO7Nodk+5Ls/ORsPpTGq9f7YvTTD1091/WVI/guLvDRU63fVT8hfZz47iJNQfj5n5ybeazsPh7YvJjh6eTI8dgNrrmLwr0aFdK2POrlLUW0mVCL0wHv5f2rnwxFl90bK3tAlREFVrC6/tjBn7As9NBdvbxo4lkavR72rUqedtueGB9vIQMHE4xo6heiGLWV/v3Yu2Qp2lH26edGIFgInC/08mr/BbvaPdZ2FnCsMB6DzAbmjIQZYGlYxdMyQAdu51DH4XEfIxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hx687yj/ea4DZU03ZoLLyuE/TnMkuePYsYeAG3r4sKM=;
 b=pw6rUT9c7JTMC3Qisz935tob5geLkM0D46wm3Fzc3gGhKODwNefmbXrROY07KmCwen+22BPtKGWEnZFDOV5OY50Mj4EuLVPoZIn2j91Ore0kHUvDzAyDuOzKXtrlOd66eHnzoeSCW6eHgHO4wj/FYoVzgAcimRlmVS2SEyby9M2S85lEUKYC26hG8xYizbALXmnPLs8d+Tlqk4aos40Y0st3S7RdiCcfShNnTAh8bDY7zEpD4GeHhrXreL5Sgg78WCPppipfUty/+cfrSG7Jeu8gxuisk+Pa0SQwIyp/6Mq9mPu3rKVsVSdzpZrKcv0X7+74GoxUSmPQDW0Fa3PR+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hx687yj/ea4DZU03ZoLLyuE/TnMkuePYsYeAG3r4sKM=;
 b=BCofJCVkCocGY+hcMCsNmdIvg6r6SC/3VLdJsI4h9XSS9SORrDCxQsinUdBuTWpHoUBAuHNoM3GSsBSKMRJjPOKN+pgmr4kSxeNrDQRh2ygXvZKy/bFqqpK+2T8F/ukCU9l0x7Tj9I3a3lf0nFRYsiwgIKNCWXCbkCbb9QQAvI9NjBLjgEj8hC98IzlhgJw4i9xawDyTWTmrCaZk/P3cHRq2ckNZXoJizd5zyvVGce3Hy7/8LRHKqbW/1y9nIepfJCetgTixcqAQT56imhHcslNd0Q2u4e8bB6tzoCpKwf/BTBJQOx0UyPcfIP6ujhvo6KWxnSfWuNYQdvGqgyqkUQ==
Received: from CH0PR03CA0062.namprd03.prod.outlook.com (2603:10b6:610:cc::7)
 by BN7PPF3C1137D8A.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6cd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 08:55:47 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::a4) by CH0PR03CA0062.outlook.office365.com
 (2603:10b6:610:cc::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 08:55:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 08:55:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 01:55:31 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 01:55:30 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 6 Jul
 2026 01:55:24 -0700
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
 <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Lukas Straub
 <lukasstraub2@web.de>, Maor Gottlieb <maorg@nvidia.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH v5 15/16] migration: Refactor migration_completion_precopy()
 to return bool
Date: Mon, 6 Jul 2026 11:52:10 +0300
Message-ID: <20260706085211.13905-16-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260706085211.13905-1-avihaih@nvidia.com>
References: <20260706085211.13905-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|BN7PPF3C1137D8A:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fdb1aad-10cf-49da-124f-08dedb3c5f4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|36860700016|1800799024|23010399003|82310400026|56012099006|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 9fNdd8xJpnHnkZhH6saQFlgKbHdKNtzKEQV+EpmcxbOESG2971ftIih2/tgHVoP8nk0VWFkf6LYJFDY6ugziTXiVNz5/zVjTvfTHKdmyI/YXyHT0a4vTc665yAAyzkrKTvm2C4WQUCIkPbkWBgNd18vn7g/dsf+KbWZ6mKfsAGQNZvi6Tqs/UbBBhxpopCsk5oQ90fUQS/sfyCg0okOouJ7xkQMreO9QlbBDG0JutWfyTmoDOG2lpE7+tgEsJ37qOm1kzmEK3N+iQmj5Q9jWDbFawTrrBM4Z6aGB8GOR1y2k0tii04UpZFGU/t0DYm5w/RHhiOZE8fAKX5Rz7q1mmI8aXp5LjXEy2Ozh7OfBHDKH9h0HyB9FPAZUXaoTXUDx9DX4Hl8ybDN54tu+BrsdaoOEYWEQK0XMyYxkaFeT08YWW+bicEPyIf/zkB/igtOJoeAtxT+63qkedcVzaum4BhXQxcwyhRC+IvuJfotConYpOaGnrdKjLIcE6psoCyMVB4vrkXjZ6qHIhSjgImgOQmmk8TUieC+G86WbZ2P+iYehucJeEhlkEQ3360UlEqttnRnIxefC50OnOFbVCsnRjWqGzMcuG+d5wBJ61oZVv/SU0Ba4BW+SOzv77NDn95ISCHcJEeCfwMtO5Vl00GLl29/vGZ8sIv20VXm4KOQsnJFyAX+F4P5EEgPMlepIK9ajWft/OjypRlLm85EFOa0Nug==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(56012099006)(22082099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FKaEWrB9tn6zFcLMX6M8CVvJzCTh/cPbnGtED79BDzT7Q4OXphxatDMcLUEpmVD82EXd+8aVtpwZM8PFeR4QAuswDoOSjYZ8hAl6ILnfvzFJV9eW7SYWnUjIXDrwJlDn+/Cx1qr2JNoKWBUn9wCu0xGadEzYn994Mj5x8HRoi+MvwGIZjFmq5pAmd0aLtzsl0F5KTDWlztQoQah22wNhcKy7VKlzV7LYZ++EhuUTDlCUQ3SuSEADMKvGJrQ7tIWB3y54r4u7hHFJuz074M6KFkWt+GsZiqX49Zw9v5HHGSVyLTD9tKt2EBFioaEB5uFu+K2pvtSRWjmjGh3hLAn6kIR7S/XZyr1tw5nGPVfU+oIEKDDZJLfE7TOk679yLOzVxvAE2xO8OoDRMzIBKqzZZITIu8pOjk24Vz3R85ChSZtmDYm1lZ5ZLvxPPB61y3tH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 08:55:47.4869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fdb1aad-10cf-49da-124f-08dedb3c5f4a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF3C1137D8A
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=avihaih@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
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

migration_completion_precopy() reports its error through the Error
**errp argument, so its int return value carries no information beyond
success/failure. Convert it to return a bool, matching the common
convention.

Convert its underlying helper qemu_savevm_state_complete_precopy()
likewise, and in turn qemu_savevm_state_non_iterable(), which it calls.
Adjust all callers accordingly.

Refactor and clean migration_completion() code too, which no longer
needs to track int return values.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/savevm.h    |  4 ++--
 migration/migration.c | 35 ++++++++++++++---------------------
 migration/savevm.c    | 32 +++++++++++++++-----------------
 3 files changed, 31 insertions(+), 40 deletions(-)

diff --git a/migration/savevm.h b/migration/savevm.h
index 415198423f..f7dcdd7d1b 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -44,7 +44,7 @@ void qemu_savevm_state_header(QEMUFile *f);
 int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
 void qemu_savevm_state_cleanup(void);
 void qemu_savevm_state_complete_postcopy(QEMUFile *f);
-int qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp);
+bool qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp);
 void qemu_savevm_query_pending_iter(MigrationState *s, MigPendingData *pending,
                                     bool exact);
 bool qemu_savevm_query_pending_final(MigrationState *s,
@@ -74,7 +74,7 @@ int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
                            Error **errp);
 int qemu_load_device_state(QEMUFile *f, Error **errp);
 int qemu_loadvm_approve_switchover(const char *approver);
-int qemu_savevm_state_non_iterable(QEMUFile *f, Error **errp);
+bool qemu_savevm_state_non_iterable(QEMUFile *f, Error **errp);
 int qemu_savevm_state_non_iterable_early(QEMUFile *f,
                                          JSONWriter *vmdesc,
                                          Error **errp);
diff --git a/migration/migration.c b/migration/migration.c
index 98603ee19c..7d5acd93c3 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2659,8 +2659,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
      */
     qemu_savevm_send_postcopy_listen(fb);
 
-    ret = qemu_savevm_state_non_iterable(fb, errp);
-    if (ret) {
+    if (!qemu_savevm_state_non_iterable(fb, errp)) {
         error_prepend(errp, "Postcopy save non-iterable states failed: ");
         goto fail_closefb;
     }
@@ -2858,22 +2857,22 @@ static bool migration_switchover_start(MigrationState *s, Error **errp)
     return true;
 }
 
-static int migration_completion_precopy(MigrationState *s, Error **errp)
+static bool migration_completion_precopy(MigrationState *s, Error **errp)
 {
-    int ret;
+    bool ret = false;
 
     bql_lock();
 
     if (!migrate_mode_is_cpr()) {
-        ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
-        if (ret < 0) {
-            error_setg_errno(errp, -ret, "Failed to stop the VM");
+        int r = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
+
+        if (r < 0) {
+            error_setg_errno(errp, -r, "Failed to stop the VM");
             goto out_unlock;
         }
     }
 
     if (!migration_switchover_start(s, errp)) {
-        ret = -EFAULT;
         goto out_unlock;
     }
 
@@ -2910,18 +2909,17 @@ static void migration_completion_postcopy(MigrationState *s)
  */
 static void migration_completion(MigrationState *s)
 {
-    int ret = 0;
     Error *local_err = NULL;
 
     if (s->state == MIGRATION_STATUS_ACTIVE) {
-        ret = migration_completion_precopy(s, &local_err);
+        if (!migration_completion_precopy(s, &local_err)) {
+            goto fail;
+        }
     } else if (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
         migration_completion_postcopy(s);
     } else {
-        ret = -1;
-    }
-
-    if (ret < 0) {
+        error_setg(&local_err, "Unexpected migration completion status %s",
+                   MigrationStatus_str(s->state));
         goto fail;
     }
 
@@ -2945,12 +2943,7 @@ static void migration_completion(MigrationState *s)
     return;
 
 fail:
-    if (local_err) {
-        migrate_error_propagate(s, local_err);
-    } else if (qemu_file_get_error_obj(s->to_dst_file, &local_err)) {
-        migrate_error_propagate(s, local_err);
-    } else if (ret) {
-        error_setg_errno(&local_err, -ret, "Error in migration completion");
+    if (local_err || qemu_file_get_error_obj(s->to_dst_file, &local_err)) {
         migrate_error_propagate(s, local_err);
     }
 
@@ -3863,7 +3856,7 @@ static void *bg_migration_thread(void *opaque)
         goto fail_with_bql;
     }
 
-    if (qemu_savevm_state_non_iterable(fb, &local_err)) {
+    if (!qemu_savevm_state_non_iterable(fb, &local_err)) {
         error_prepend(&local_err, "Failed to save non-iterable devices ");
         goto fail_with_bql;
     }
diff --git a/migration/savevm.c b/migration/savevm.c
index f654a1c563..bbb8d2b47c 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1737,13 +1737,12 @@ void qemu_savevm_state_end_precopy(MigrationState *s, QEMUFile *f)
     qemu_savevm_state_vm_desc(s, f);
 }
 
-int qemu_savevm_state_non_iterable(QEMUFile *f, Error **errp)
+bool qemu_savevm_state_non_iterable(QEMUFile *f, Error **errp)
 {
     MigrationState *ms = migrate_get_current();
     int64_t start_ts_each, end_ts_each;
     JSONWriter *vmdesc = ms->vmdesc;
     SaveStateEntry *se;
-    int ret;
 
     /* Making sure cpu states are synchronized before saving non-iterable */
     cpu_synchronize_all_states();
@@ -1756,9 +1755,8 @@ int qemu_savevm_state_non_iterable(QEMUFile *f, Error **errp)
 
         start_ts_each = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
 
-        ret = vmstate_save(f, se, vmdesc, errp);
-        if (ret) {
-            return ret;
+        if (vmstate_save(f, se, vmdesc, errp) < 0) {
+            return false;
         }
 
         end_ts_each = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
@@ -1768,10 +1766,10 @@ int qemu_savevm_state_non_iterable(QEMUFile *f, Error **errp)
 
     trace_vmstate_downtime_checkpoint("src-non-iterable-saved");
 
-    return 0;
+    return true;
 }
 
-int qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp)
+bool qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp)
 {
     ERRP_GUARD();
     QEMUFile *f = s->to_dst_file;
@@ -1781,12 +1779,11 @@ int qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp)
     if (ret) {
         qemu_file_get_error_obj(f, errp);
         error_prepend(errp, "Failed to save iterable device state: ");
-        return ret;
+        return false;
     }
 
-    ret = qemu_savevm_state_non_iterable(f, errp);
-    if (ret) {
-        return ret;
+    if (!qemu_savevm_state_non_iterable(f, errp)) {
+        return false;
     }
 
     qemu_savevm_state_end_precopy(s, f);
@@ -1795,10 +1792,10 @@ int qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp)
     if (ret) {
         qemu_file_get_error_obj(f, errp);
         error_prepend(errp, "Failed to flush QEMUFile: ");
-        return ret;
+        return false;
     }
 
-    return 0;
+    return true;
 }
 
 static void qemu_savevm_query_pending(MigrationState *s,
@@ -1928,7 +1925,9 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
         goto cleanup;
     }
 
-    ret = qemu_savevm_state_complete_precopy(ms, errp);
+    if (!qemu_savevm_state_complete_precopy(ms, errp)) {
+        ret = -1;
+    }
 cleanup:
     qemu_savevm_state_cleanup();
 
@@ -1962,9 +1961,8 @@ int qemu_save_device_state(QEMUFile *f, Error **errp)
         return ret;
     }
 
-    ret = qemu_savevm_state_non_iterable(f, errp);
-    if (ret) {
-        return ret;
+    if (!qemu_savevm_state_non_iterable(f, errp)) {
+        return -1;
     }
 
     qemu_savevm_state_end(f);
-- 
2.40.1


