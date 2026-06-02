Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E438CD6E4A
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 09:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wULPD-0005tU-Qi; Tue, 02 Jun 2026 05:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wULPC-0005tM-34
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 05:27:26 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wULP9-00047G-Ty
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 05:27:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjdLSTc9oHBQSS/as4Nx6M9YA5lLVZjn/Ckrke+uaD6C+1F00DNIJ7cv47giSnpCG6SJBHMOQ9XEDWnE79hz+KXURtXsgJiDCGF/QtNMedFNrF10rxGaZ1MBPTrzcGpKG9R7qz5UbTk9vHjboAgBW3eJYywwj00Idk2PRIofol9WdeiQ7/VtV/ZhPwhLtoUKPCe3RW6cC+gH9GOvSqYGeFL4WkPmwvE3JVlK9X1joRI1kj7PqW5aSLjVJgJuZ7+PbakD2GxV2GJJMp+U4TLKyv4d7Zm1dlgusxqbSkVKn2Y7Qz5sIVCNmCz9STqE19C075YD5yAAHF8mkGqFtTAxPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ull8TSdOFwKcT+HUNpTMGxzloo9jfN+iC2D5GrNwHyw=;
 b=OtrjnffcqVe2Y80sNM8zgUFKP8PEzC59eGexlfyxGcUNguTUWy2ugTIfLUAleUvz5kDB3l4tNt3AmfR3Nwrt8Ekj775QQeRUdjpD5f2qAy17V/k3SRYfEpl65IJOviCgIdq5w7Jg5NUyXK1AuRKpjF53KH5SH7pREig1Rd5XFJQihH9njm7eMU6Et1HKWDhtIrpq5T77XJISg/wFeoy80Lu+3XO2KJVLC1ho7FM5VzVjHQKcgKdGTLdWlhPevOPwUJNWOMHzJhIXQPLUZPW843Nl0KA4mBUPb2c8sWuuBsl43gwbXLqgf3i0NDAkpbbuC/p8i2fx3oVohzyn1iiB3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ull8TSdOFwKcT+HUNpTMGxzloo9jfN+iC2D5GrNwHyw=;
 b=HO4cLQJKbsM4O1ulh84FrLpVSFHRqDvr5+HautSIigabmw81Kmej42ZLIDE4g52tWGtAC6nH2dyDX+f1fsFPXYsIzsdeXsaJ1gnd71sd3hCjRB95XTkLxyOe45jLhjkV8USHW1oPLGjj9e1Bz469HWnCo/H74jIVGzGasPV7w06+NbVxVXLRKYHfe4d0KRiM54gtiyf8mSUCm7kRQQxXel3xlbMPHgcN39uoMSL0pVNpMGVv1bWuyk4cI/wr624a54ShV3jPXRUaE7iahvYE7+KYvlYY7sv1rn/57uSDBOFXxgbkHHJoA1xSiI/GyBNHG55zEMFRxxYxSHZG45m5WQ==
Received: from CY5PR22CA0062.namprd22.prod.outlook.com (2603:10b6:930:80::7)
 by CY3PR12MB9631.namprd12.prod.outlook.com (2603:10b6:930:ff::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Tue, 2 Jun 2026
 09:27:15 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:930:80:cafe::40) by CY5PR22CA0062.outlook.office365.com
 (2603:10b6:930:80::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Tue, 2
 Jun 2026 09:27:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 09:27:15 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Jun
 2026 02:27:01 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Jun
 2026 02:27:00 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 2 Jun
 2026 02:26:54 -0700
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
Subject: [PATCH v2 05/13] migration: Rename switchover-ack code to legacy
Date: Tue, 2 Jun 2026 12:26:13 +0300
Message-ID: <20260602092621.382-6-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260602092621.382-1-avihaih@nvidia.com>
References: <20260602092621.382-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|CY3PR12MB9631:EE_
X-MS-Office365-Filtering-Correlation-Id: f81c1fdf-f28a-49d9-7a70-08dec0892269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|36860700016|1800799024|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: IZvE9+sGmi0vI5+aRkyQ5FmTGVNbp2Mpr3syMOcxK1LyqUM/alJLbnASXDRJPks35lBZTFQacEFA+mmjiV9PaZdS6zxSw+6+NPqhhN3AgMsBJAm1WIKAMomZvsv7+ePI4mG8cua34DgmZGRs+jzfN+yOuDMwPTBJd40+vr91UYqfRGgKTym7bXteGd5JbaTuuv6pTwSogzKJRj6kYjPpJdGQW1jQkic9/8jYQhX9NedTmTW7EOML16+7RUOXO2DdMqJYX/65QleVdN8fm9+mvnu4qOzxRhYBjdUfaFLIjY3YsqOyVTb0tatyxIlGqAGPe3IRTAjRg7kM/uzFyObYtOJvNlCmxc0HGpkMe4tuzccboGrSOKkOWtBEHJeEHcfqk1vymGVY5OqfjraiddZew0IyRulf0Wv56s36vQc9INkb+AgOmUUGVyQ2ce41UOT6jaYx8fTCpJUfPePxpaPCPustu/X0+0fyuHCdCnNGWp5TUTFtkgFqpiJKJehJLmvq2LM4T4SO3hzpaGr9g/OqwR2tiUHJI78bEEYLKW/ULaRO7ao4Fo8oyOBrCbxyzHlIwYUuUfotysNI+XTO5/PkqGBIFl4cqEITRoxvoOYl7KQ5HBPtDnUCKXfvGeomm2T6yo8p0BNqb4KM8G44odmX43zLB122mvLaZQRvSPxpuYSJzruXi3k1XPEVwC9zWVs9byARGMcajegZkzzjm08ndUbzJSRnfjMK0dnlE3c4iv8=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(36860700016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uFQMFW49Z9SjKzUUxdvTCagE2JX1xYO43Ab+v6JwkfkXmoy897t5bRF2N5MYw45/GOfFQ3b7lV+GJX/5uXcB6duGpSCunC0NMtre/52GWeGpEsolIFaFsLRqwggf8ZqliZYK2q6DPq08MILSQBvIRvgQekPVAU92hYQYOZt2FArcqFZZFMfP9j2qam8uzs9/JE/V4+/IZuazhHi/AJXBJPsOxWqPh0PYcxLuYNFrllhfsMwMsHi/jZtbDVWOrts2qB8AO7gXLAF92enCg9MT8XHklO/WAwtca2AYBf22NgFLrvNNL1i7eSX4rFqozz+Y+5ZW0bcDmtk0cNclXeoB+aad5xOyHxZibnaX05DvvafBrFksy6ceGd9HUN8n/qCnUrdQBhnEplycER2tA/32ozY05UJCiIIFjzsUunBxToY1ZQVMTwsB0tfkKYD4SFEB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 09:27:15.1927 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f81c1fdf-f28a-49d9-7a70-08dec0892269
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9631
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=avihaih@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
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
index 6303f006a2..d5be135584 100644
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
 
@@ -783,7 +783,7 @@ static int vfio_load_setup(QEMUFile *f, void *opaque, Error **errp)
         return ret;
     }
 
-    vfio_request_switchover_ack(vbasedev);
+    vfio_request_switchover_ack_legacy(vbasedev);
 
     return 0;
 }
diff --git a/migration/migration.c b/migration/migration.c
index 957b794e91..59aff50d68 100644
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
index 1a60a178af..fa188dd34f 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2476,6 +2476,31 @@ static int loadvm_postcopy_handle_switchover_start(Error **errp)
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
@@ -2525,18 +2550,9 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
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
 
@@ -3155,14 +3171,15 @@ int qemu_loadvm_approve_switchover(const char *approver)
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


