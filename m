Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E14C2CDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 10:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbbfr-0004xq-Rq; Mon, 22 Jun 2026 06:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wbbfm-0004pt-7z
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 06:14:35 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wbbfi-0006G5-8l
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 06:14:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y1OXorGtTG7cmNQ/9vbhYrNdpxER8+BJemhxGTfvqEENTyYmVpDhzYJ7u3MgZ/XiwLEogORUlpTUuUgRLnqG5tfBaRx4rw2OHTAC5qKMZGfH0aKI0HYhLIooD8cOw8XiffRnxZxnprIY8ZNdIQHQq8tPyUikxVpyXCWKvZI61WZ+bvNGZQhtVScRj5gxZLPkDpFYgMCrSxryq/z0s2bp6DpMCLuAw1NwKAZAFk1s4zxQwzWfpcnq78TWBNxj0GjeZUMMq8N1j7qkPPirUF/B4YYhGfTtHRriRZci0636Tsm/yWfkQro1pHp5XMgqgFoqdGnoeDTiSMpMms2uN02Zxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HuAjeF9UOGAH55S8g7CXsr44T4w00et7YZl8H6wcfR8=;
 b=WTgBNkeNkiylrjEl2tzNro7cOZ1KM7nYgXNg6bd5Ht0GT5ZwVTeRhmN/6smA3aiM4DgvVWMzuoStm+SyTPwz+3kJ+3tRSBeOM70uFGKOeWQiHFxIZvPkMRONEkpJ4KXZxbRR3NaqsdtsPvCy3ZEqdpwHS9aUi8R0I2kWadciCO6o0hRF8jET3c4s475kGAZC0IG+tywWTx893oyvIqVvAHazucIg3IO17rhymyWyXmkMiKGxJnm+hMbwypFkS8IkR7J94c7dFIO5CQ1Xwbq+5h7XPDbYHdJQhQxJTWfjOI9wjNTDQ8wm8/ewg4p7sz2zKInsLysq0+oCdLydfd+sGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuAjeF9UOGAH55S8g7CXsr44T4w00et7YZl8H6wcfR8=;
 b=EE7rGICkym96seCctdrAh+sjyxHqzPLLYM7ZXImVhPftvvJHIRIVGlI/wRVwDfA/St6eN0EfGeN1XzjNRSfzxO4rlTI911Rki9QHNGtJIp0N7YGKqMMshejQlAbhY9Z6/K17HfMWRiracebVSBiZB0mjqDqVYQZqshzbt41lfLO19yHs9ypqhB2e4xvwUj+z58BVsE/Gs9pxwZ5+BZQUZmO+rFX4ONG4kRg7qwmUMuH1WwaRseP8dfOpgXhq9rj6S6TgLSXWHtHlU0CdEDrrvdzEu2yqF53mWaIYnWCjbxlFJRQL3sVPOs3mJ2e1f8L8GU6DuBOUKorMD/AZ/ycq+A==
Received: from DS2PEPF00004551.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::517) by BY5PR12MB4132.namprd12.prod.outlook.com
 (2603:10b6:a03:209::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 10:14:23 +0000
Received: from DM2PEPF00003FC8.namprd04.prod.outlook.com
 (2603:10b6:f:fc00::22a) by DS2PEPF00004551.outlook.office365.com
 (2603:10b6:f:fc00::517) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.11 via Frontend Transport; Mon,
 22 Jun 2026 10:14:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM2PEPF00003FC8.mail.protection.outlook.com (10.167.23.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 10:14:22 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 03:14:07 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 03:14:06 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 22
 Jun 2026 03:14:01 -0700
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
Subject: [PATCH v4 06/14] migration: Rename switchover-ack code to legacy
Date: Mon, 22 Jun 2026 13:12:06 +0300
Message-ID: <20260622101214.25770-7-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260622101214.25770-1-avihaih@nvidia.com>
References: <20260622101214.25770-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC8:EE_|BY5PR12MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: e9ffb81a-8084-495d-0467-08ded04707bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|7416014|1800799024|82310400026|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: chOipxBMVQsQZF6K2BvWwnp3mfY/PPg90uyoaoUzYKgFkx0hznDp57HpGlPo0TmceaiogTAohH3EvznxbGrvcj4psOtvcKcgtfzMUWx2Q43mwrZsuElC0yBX7YX6qE+hq4P/QjRZjnN5aO4IAKTIIBaVESVLzhGjVyvdhU2vJuM0xJgghupTsaDTwiX80/gODl8jSBE6CvVji8+7JlF2M1LPwzrVBsFLlktEPyHpXniWyNSyMy4Uscb/pCUi9juy1Kow9vXzK3cbKRRUnp6ALuHrqr6Y9abvJLVuC3fJTCBQj6sJi4Q58DQD85fis7odk8GUMdfLoGbttkleUEKyaFdyrjJzDRPSebRPSgeHEXc2pnApRAcl/2fqa0irDci6I+bUjnNsguHPVRlvAHiyiTQLbcvsXLG/Wiuf3IGWTt8sIYmwDNWW4kG8K23fhmaUO6a4V23UbS/6Kpxlfuou3XxWB40IMdEMgvMYaRe4TdmL1rYmIAr4sBL/US2fRg6LY390QvwFYydsq2nmlKN9uGfmO8m1dMNgoyQkwe7c6vdppWjQMxoyKDael8Vz5Xk0AWfyl8ahkRudnGMveETskYZpgTq0bsYrbdcZQosCofzGW6DaxYQTmFvJDBDO+/PzNNxNbANjqMAsk7x6tdNRkPkBipsExB39vGphNeT/mL9nbkkFsQLL7UYR5wJqUFVr1ZonCwgBs/FX7P8SfJyqWg==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(7416014)(1800799024)(82310400026)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jdwPlC8451hOHEJCv4WQ0Tra8/6mSJpamVd8BcIdgXXgehEmoNSbWC2E8y4jqJG+gIb/JOx9r5ppe5V5V+VagVJV62g1Ach6t6GWjDknvGQlipe1GSkSbQeQ1qg4xNv+31BXCF7hv4qjYu12pghGSqut10pNO4JJKjOFcLlIH4y70o8Za/G0HKaMYHyRsKloNYn/CnW0JVzmw0x5Rx7oqVRGTxDCakrXlENCOBpJyK43QOK/pbjpn8unU6xj2ZKcbAEc7POP+/1L56JDLPu7uONGLL5WHDWYYnIbDDjEq5TNHlRo24FXeu4Erf7ZyX0a7Fn2Jx9oly4lw3zH+aKXUxtah6ZedIycP6L6ri3dGJtrW7rlxfs8oB08MozWIFVuT8AJy/zcSjvkwMy1LL1E4DGr94AD0JF6IXdenzeEPuvTPhK7hkg9AEdxkD2D3cKN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 10:14:22.2829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ffb81a-8084-495d-0467-08ded04707bd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=avihaih@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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

A new switchover-ack mechanism will be added in the following patches.
However, the old mechanism must still be kept for backward
compatibility.

Rename existing code that will be used only for old switchover-ack
mechanism as legacy. This will help to distinguish legacy code from new
code and make it more readable and easier for removal later when no
longer needed.

No functional change intended.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 include/migration/misc.h |  2 +-
 migration/migration.h    |  2 +-
 hw/vfio/migration.c      |  6 ++---
 migration/migration.c    |  8 +++----
 migration/savevm.c       | 49 +++++++++++++++++++++++++++-------------
 migration/trace-events   |  4 ++--
 6 files changed, 44 insertions(+), 27 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index a2219c981b..4b43413aee 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -156,6 +156,6 @@ bool multifd_device_state_save_thread_should_exit(void);
 void multifd_abort_device_state_save_threads(void);
 bool multifd_join_device_state_save_threads(void);
 
-void migration_request_switchover_ack(const char *requester);
+void migration_request_switchover_ack_legacy(const char *requester);
 
 #endif
diff --git a/migration/migration.h b/migration/migration.h
index 841f49b215..da45444f7b 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -246,7 +246,7 @@ struct MigrationIncomingState {
      * zero an ACK that it's OK to do switchover is sent to the source. No lock
      * is needed as this field is updated serially.
      */
-    unsigned int switchover_ack_pending_num;
+    unsigned int switchover_ack_pending_num_legacy;
 
     /* Do exit on incoming migration failure */
     bool exit_on_error;
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 7055cfbd3e..6b7acb2fa1 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -487,11 +487,11 @@ static bool vfio_precopy_supported(VFIODevice *vbasedev)
     return migration->mig_flags & VFIO_MIGRATION_PRE_COPY;
 }
 
-static void vfio_request_switchover_ack(VFIODevice *vbasedev)
+static void vfio_request_switchover_ack_legacy(VFIODevice *vbasedev)
 {
     if (vfio_precopy_supported(vbasedev)) {
         /* Precopy support implies switchover-ack is needed */
-        migration_request_switchover_ack(vbasedev->name);
+        migration_request_switchover_ack_legacy(vbasedev->name);
     }
 }
 
@@ -784,7 +784,7 @@ static int vfio_load_setup(QEMUFile *f, void *opaque, Error **errp)
         return ret;
     }
 
-    vfio_request_switchover_ack(vbasedev);
+    vfio_request_switchover_ack_legacy(vbasedev);
 
     return 0;
 }
diff --git a/migration/migration.c b/migration/migration.c
index d6383b23b9..8d189fec80 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2197,7 +2197,7 @@ void migration_rp_kick(MigrationState *s)
 }
 
 /* This is called only on destination side */
-void migration_request_switchover_ack(const char *requester)
+void migration_request_switchover_ack_legacy(const char *requester)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
 
@@ -2205,10 +2205,10 @@ void migration_request_switchover_ack(const char *requester)
         return;
     }
 
-    mis->switchover_ack_pending_num++;
+    mis->switchover_ack_pending_num_legacy++;
 
-    trace_migration_request_switchover_ack(requester,
-                                           mis->switchover_ack_pending_num);
+    trace_migration_request_switchover_ack_legacy(
+        requester, mis->switchover_ack_pending_num_legacy);
 }
 
 static struct rp_cmd_args {
diff --git a/migration/savevm.c b/migration/savevm.c
index 25afcfd71e..8e6c5b7c87 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2478,6 +2478,31 @@ static int loadvm_postcopy_handle_switchover_start(Error **errp)
     return 0;
 }
 
+/*
+ * If legacy switchover-ack is enabled but no device uses it, need to send an
+ * ACK to source that it's OK to switchover.
+ */
+static int loadvm_switchover_ack_no_users_legacy(MigrationIncomingState *mis,
+                                                 Error **errp)
+{
+    int ret;
+
+    if (!migrate_switchover_ack()) {
+        return 0;
+    }
+
+    if (!mis->switchover_ack_pending_num_legacy) {
+        ret = migrate_send_rp_switchover_ack(mis);
+        if (ret) {
+            error_setg_errno(errp, -ret,
+                             "Could not send switchover ack RP MSG");
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
 /*
  * Process an incoming 'QEMU_VM_COMMAND'
  * 0           just a normal return
@@ -2527,18 +2552,9 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         }
         mis->to_src_file = qemu_file_get_return_path(f);
 
-        /*
-         * Switchover ack is enabled but no device uses it, so send an ACK to
-         * source that it's OK to switchover. Do it here, after return path has
-         * been created.
-         */
-        if (migrate_switchover_ack() && !mis->switchover_ack_pending_num) {
-            ret = migrate_send_rp_switchover_ack(mis);
-            if (ret) {
-                error_setg_errno(errp, -ret,
-                                 "Could not send switchover ack RP MSG");
-                return ret;
-            }
+        ret = loadvm_switchover_ack_no_users_legacy(mis, errp);
+        if (ret) {
+            return ret;
         }
         return 0;
 
@@ -3157,14 +3173,15 @@ int qemu_loadvm_approve_switchover(const char *approver)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
 
-    if (!mis->switchover_ack_pending_num) {
+    if (!mis->switchover_ack_pending_num_legacy) {
         return -EINVAL;
     }
 
-    mis->switchover_ack_pending_num--;
-    trace_loadvm_approve_switchover(approver, mis->switchover_ack_pending_num);
+    mis->switchover_ack_pending_num_legacy--;
+    trace_loadvm_approve_switchover_legacy(
+        approver, mis->switchover_ack_pending_num_legacy);
 
-    if (mis->switchover_ack_pending_num) {
+    if (mis->switchover_ack_pending_num_legacy) {
         return 0;
     }
 
diff --git a/migration/trace-events b/migration/trace-events
index 5955befcc6..a6b8c31ee1 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -23,7 +23,7 @@ loadvm_postcopy_ram_handle_discard_end(void) ""
 loadvm_postcopy_ram_handle_discard_header(const char *ramid, uint16_t len) "%s: %ud"
 loadvm_process_command(const char *s, uint16_t len) "com=%s len=%d"
 loadvm_process_command_ping(uint32_t val) "0x%x"
-loadvm_approve_switchover(const char *approver, unsigned int switchover_ack_pending_num) "Approver %s, switchover_ack_pending_num %u"
+loadvm_approve_switchover_legacy(const char *approver, unsigned int switchover_ack_pending_num_legacy) "Approver %s, switchover_ack_pending_num_legacy %u"
 postcopy_ram_listen_thread_exit(void) ""
 postcopy_ram_listen_thread_start(void) ""
 qemu_savevm_send_postcopy_advise(void) ""
@@ -198,7 +198,7 @@ process_incoming_migration_co_postcopy_end_main(void) ""
 postcopy_preempt_enabled(bool value) "%d"
 migration_precopy_complete(void) ""
 migration_call_notifiers(int type) "type=%d"
-migration_request_switchover_ack(const char *requester, unsigned int switchover_ack_pending_num) "Requester %s, switchover_ack_pending_num %u"
+migration_request_switchover_ack_legacy(const char *requester, unsigned int switchover_ack_pending_num_legacy) "Requester %s, switchover_ack_pending_num_legacy %u"
 
 # migration-stats
 migration_transferred_bytes(uint64_t qemu_file, uint64_t multifd, uint64_t rdma) "qemu_file %" PRIu64 " multifd %" PRIu64 " RDMA %" PRIu64
-- 
2.40.1


