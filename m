Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F17C44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgf5N-0008N4-Un; Mon, 06 Jul 2026 04:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wgf4z-0008Gm-BP
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:53:29 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wgf4x-0006Yp-Jg
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:53:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zx2W+pi02EzWdOl+zihL0ITGtZ7KYvLPx+3uDYS8IEHYdQFM6DtDVfQI6Lf41eCNWzu6qqt6fmaIPyhvvOKhMfuC7jshtNh0JLHXxeGClvou9P9bJFuImEIIOYdLXPAcXd8AzsP6UCibLsyQEHmxHqhb/iM1pPIsd0NrleuSFttSyn59VuRuwic/c/i2huk0yMwjK+L8Z53WEgcjNXBegX7aRMZGlHz1jXHnUsHhGg8mBrmRuk5fRqIVmScb8VD/beZK3MDvWGtD18u8e/SsZym+bdYgAJXYor5nrcOhi6ocZnec7XJD02KHMhY+2ykm74dkU3Ke6gdOF6cbUu/UYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NF3gMty1G1PyvVQQMVI44QkzCoGXyDH1wcmUrgvBb3k=;
 b=SFWSQ+/WOTkYwdNOahP+BXOrog04EVKG2OxnNX6TVGnx0WSNuxRbl3pJ1eiXw5inX1Vbwp6AAeMDM9qKbUqbXU/nxpJlD97rgTheBgck1TarGb1u8klRnLAi5a/Or/vJbbEPoO3uHRuBl8Pzc8gRP0p8Ow+li4encnl3/C/Y/631mFNalwRo7Bt6WFp7F37P4dGpouggBzaMl8D0HT+84Zu+4j8oKDBj57ciWLOEFuohH0yTahlErU8iYh5rr60cBhLfMlQWrldImk5pScbcXGDf7/KrvJj5N1zgm7souzWFNRDUIFwNRnn9Dn5EOL1gc2n3SMu2Fmrty+GlHoFxLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NF3gMty1G1PyvVQQMVI44QkzCoGXyDH1wcmUrgvBb3k=;
 b=myeg4n9M9CariMJz2cnJ5eGKxSkJEKSBCiHXXxlI06mKQ6HfvgbxsTMDYV0pgZh2RS8hKECKAxVWIOiltQ9+YSA8cGsalvLRWzyhiJWUpImAZuoOWE5Lovsq4DBpc64Qck9g1PU8XVTzBdHRwWkFDThdb+BfOLJ3NWlxT/fAEXAM6a8anlti4kehfo/kFtzfpJJVLI/2W6CKQd0GwhLgN3bpduUuIU3N5a4Or+ZWeodbu3WS39eoMPNFqspKgMDMSJPfok94G6rIIjNO/TWJKdgaHnGzt6/Pozdw4O/WWMN6AGBTagwQgGO9VgYrbQR5sf+0zenSaz52t5YMdFdIxw==
Received: from DS7PR03CA0200.namprd03.prod.outlook.com (2603:10b6:5:3b6::25)
 by IA0PPF64A94D5DF.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 08:53:17 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:3b6:cafe::85) by DS7PR03CA0200.outlook.office365.com
 (2603:10b6:5:3b6::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Mon, 6
 Jul 2026 08:53:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 08:53:16 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 01:53:01 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 01:53:01 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 6 Jul
 2026 01:52:55 -0700
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
 <avihaih@nvidia.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>
Subject: [PATCH v5 01/16] migration: Propagate errors in
 migration_completion_precopy()
Date: Mon, 6 Jul 2026 11:51:56 +0300
Message-ID: <20260706085211.13905-2-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260706085211.13905-1-avihaih@nvidia.com>
References: <20260706085211.13905-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|IA0PPF64A94D5DF:EE_
X-MS-Office365-Filtering-Correlation-Id: f502663f-59e6-4202-cc39-08dedb3c051e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|7416014|82310400026|376014|36860700016|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 6ilmclyjkD+v3VcrG6V0c7fEkuirKCRaB+l0KBjDfg/B3GgoHpM5Em1JONmcWHUUjP0r0bwmz3LROlKcPUL5ezA8ktcZBHHa+Z6XSW2BQYLR8p31cqAmWiKPlzLrr6S2beehjt2lPt5KejmRpkHvMyNsSwRKZE1AOxXUK5icA8mIbUZpKmVGNy1QDc5uAIYKt5Hsn6U4wCx7PxGoqDKlZWkF0oiVBEzg3jJLHrvVb9+Sgo9hYjep824ILBoF7e0GjDigJaCU73vfZHS6GrW0OdUJ+0WRfofdy/jLABp6VocdJYL9P49noU/8PD0TLTJE7zsGVwWill5Dr5Gl4D1SYoWI/GtqJQDs7QhaRh5g391zW40JXTtzGbuzyFV6MJccAGcLql9aeShg+MR83Uh3VxrYBjIunE7GGHMRoOtYMif2vAQ30GkTqr9WC43ERRs9C+/mAojmmR+GXzzhy+dF7095r+xcU26GhwhKIzZwycmpliw/1fTNU9Rc46U2QMFF0pV+fNX2bWiBJsR5ByD2xcPrEkr6UqC/BezLkiaxQvELw+Ct3LMayYuD5+uulSbheaFofrc5iIx7lS8yC4k+asUU2Giz7JsfTT99cSj67/7HMCdu18eyjlD5h+IxzLh3PoKHWU/yYVwMv3R15hQO3DycGBgdjjHpXsxDpeYQWAk9LyiuCLmkBVB71WCg4Vd0tex1TsiQ4WaEIE+CObLzOQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(7416014)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WLkmElSwo5YttnnmFmqZn8Usqyv9uYH3OqzonwPVWMgXQdaD/VGhW5q8zFTXw0JeLub0PXOIiiOJZRaAcMmr+ulYXreYRL+3EpDZCZy2QyWKWQzlBaErJQXUTSlhf1FOYRy29EqVnYNZoPXw6QpcC6a5PqfbVTYfqYIiV0BtNKASRO/OSobZGEadb49TIPmCxVenzl5Xw+JUwPArbzdLv0H0ovd0ou29V/m0/EY9FpysnEJi8O5RErwg2Aru2jKmXWVjE0PYbq1EbmCl+zrPTK0BuffM+nFbnp2oLKfLmjCMhzDlheb+r1FzD/RJjCQWTFFUkSytw3RmS5FzLmUpEJMayaUIV4JUs6BpIcZY0bfVuU3+6qcyXvD+DrNTkv7ZwhU+UdYicyX4s7Ac5bxhnNRNWJw0TpFn1BNICyxbQdewUPeHCsgJk/MvV0//JJV/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 08:53:16.2172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f502663f-59e6-4202-cc39-08dedb3c051e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF64A94D5DF
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
index 0f56432d90..7e0a0bea7a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2820,7 +2820,7 @@ static bool migration_switchover_start(MigrationState *s, Error **errp)
     return true;
 }
 
-static int migration_completion_precopy(MigrationState *s)
+static int migration_completion_precopy(MigrationState *s, Error **errp)
 {
     int ret;
 
@@ -2829,16 +2829,17 @@ static int migration_completion_precopy(MigrationState *s)
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
@@ -2875,7 +2876,7 @@ static void migration_completion(MigrationState *s)
     Error *local_err = NULL;
 
     if (s->state == MIGRATION_STATUS_ACTIVE) {
-        ret = migration_completion_precopy(s);
+        ret = migration_completion_precopy(s, &local_err);
     } else if (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
         migration_completion_postcopy(s);
     } else {
@@ -2906,7 +2907,9 @@ static void migration_completion(MigrationState *s)
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
index 23adaf9dd9..7e2a0c2b4a 100644
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
+        error_prepend(errp, "Failed to flush QEMUFile: ");
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


