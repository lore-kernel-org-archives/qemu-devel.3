Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C82CD343C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 08:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKAw2-0001QV-4C; Tue, 05 May 2026 04:15:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wKAw1-0001QG-89
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:15:17 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wKAvz-0006Z7-4q
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:15:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CAwXWU1kJOpuB621tKKPIyZuv/aXklrabb416HXWKlHgNg1KOfLwOQb7JfAzFehfqszEiJplE6suUATCHuKZqfCHOW1LaRBl40OwMdpEjFudQ95Fx0jVrSIsq1v3CSaqZ/0em2lOxAb0unsX6EsdHDBJwhX9rFBeLj63MMCvgGo9S9/KVMs7wN1Ic7HgZoWF6ZNthFNviWL1CZXodufxqw2O44gC7JIAgGM3uvY+p9mRmT28j6hCj/uPxXj+Y8vqusKEUrmmVk17il5RxRoVtJCCRDlsZ7tvWVZppsXo3LuxRNDO7Vf2pq7zJNOcmy4EVRki642O7VZH7lbpm3PsTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSvrfr60qQtpE0FUIW0WnhvwEzur68xxk8hAw3OfTsA=;
 b=hyrZHlXDBC/3utadXNBbBTcyIseY2y02kgmDmUX7D+bn1wTL8HvEG/ruDLAba5swxHl72o+8+rEkDgDAaG7KYpqi69Xez/lEAXQC1M70Dsm++OYyI5AH2foxuhaCMjmTX26Kau3uUoAg39qHnQUREQP5np33dqAHcqhOnf2XB+5fBgadaZe9KBV3k/z0oAQ6NIsdGNjo5By6U/4QID4eGwKxcJOfz2DDRSd8cueVaABnjv9D6o3ejFP2DjKQPy3RKt7PXuErS9kEApEdRIoPfuEeZvcy/iqsMTGa6garxoG+qLfgusCtHHqwII4+myANq6HMG2xme+ye/kDz756qAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSvrfr60qQtpE0FUIW0WnhvwEzur68xxk8hAw3OfTsA=;
 b=KcnuCABQ4Tgn6xA/Jjzkhkcc+5F430CI2CYJt0adKosuJCAuAwKZsJ5VoolVOVtdAJLmB4xV4GgKiAGCtAmv3pGRk1ed+6pI7p9B2lQ9Jy9kxgweU8vJcoVK4WVNleZuInkIcHlDu7vMIseOpV9Xxbj00L4FgK1g1j74RazSk4amyFGT0yJfKC3pmFni4ZxdcuSZNWH/iFrRDAfky4hlK8SwzxQJsoB3Q2IBE4Tki6LYTv7NjVHG42dLGtx4ToNW+Cg5bvwbzIDkF7MLf50sod5eDilzbSPHSg0gnQ3bLhb8AHSXFF+6bxYSbxlAU97CEF5vum9gNQDknURsLqV3kg==
Received: from BYAPR06CA0031.namprd06.prod.outlook.com (2603:10b6:a03:d4::44)
 by DS2PR12MB9710.namprd12.prod.outlook.com (2603:10b6:8:276::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 08:15:08 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::35) by BYAPR06CA0031.outlook.office365.com
 (2603:10b6:a03:d4::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Tue,
 5 May 2026 08:15:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 08:15:07 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 01:14:52 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 01:14:52 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 5 May
 2026 01:14:48 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex@shazbot.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Zhao Liu
 <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH 06/14] migration: Rename switchover-ack code to legacy
Date: Tue, 5 May 2026 11:14:15 +0300
Message-ID: <20260505081423.28326-7-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260505081423.28326-1-avihaih@nvidia.com>
References: <20260505081423.28326-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|DS2PR12MB9710:EE_
X-MS-Office365-Filtering-Correlation-Id: 17451840-725e-433a-934d-08deaa7e6b83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|7416014|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: avV5XM+Y0jlTk7f4FO9QhbJPCNgNx0QswPKrmFlAn03f5joGIWXgUyBhIT6S2Ugn+y/KlrE30yLReEZ+gY/9j4f/Yhzozj/DzgPqkWpgdMlwom63FuyC1u8PnSIeqecCvXUYybPS1mF7KGhCiSciOoKs3J1l9IBjGYpRlQsEBCR7BYrLcg8QRpK5um0Dygh26YiVOsWsxOKMqMjVp93mUBCjIsZpCofnwMs/MD8bLLlVO2oh1+y6r2byoDHEYDkaBCIARBjuWUQVNOU/2UdHzQAlBQHLhtQdh8OP9wjKxMiXHZN4ViwI4S7EJBD3ZRXVCNm2hx9gWr3q1Vw0c1KKbZZ+IahrL64LMXy7a+7P1FQixmM8NA1+G0N/7VStgYxgQJUDOEidbVHQYzqni5gj2F2N1L6fywwhJl9yUFGXHDUPz6sz0rlmbeXIvw8spHDE86YjuZc6UpYXDpMt/cSSHMHi9KmddnygL1hJUjyhDTtQvjBNU93elzhETwYagfRyAV+Yd8XMjZH5xmzAsypgA/IYXxofCVDtgAA8ACqrTMDHvris9IxzBvstLLZCfFkeZz3p7NJ31xM0w+JmnpK3ur+EcYKoo2lN42FffHkrBPTfO5+tnZhq7av1fB8+xzKOAr9JfXhUkr3UNUFJ/KH86QF0yza3C8+TalNH8R5cePK6LMceEctDK0qfThrDpnVkLhLq/2gkbTEuWIPqRB4fCO/dU1n6aP8BkLoF7KYXPFo=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(7416014)(82310400026)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tVLehf5yP/alkIxUGpgWih/C/HRtTsNowvsBr1RxOlH5+0MElc1mgMJ3df6qWVkPKvaTI7xRC1TI2jTwaRi8OZhfRck743NRmEY+Q0/j33Hgm8uSw2sfuiIkJXYjovw5nUsZQT0i1WByCWvasxwxDwXFm1ZUIvztgJhEq18RXbWWRw8dHz6l05TQwzzTAsCL5JJl5MBjNCpa4xw4BXu4Ado1D6upEvPbxQR2qmuwlxAWLL4fljKzG44oj3HwXn8wD4+1eC3IFr4A/iO/Y/OEBoiiV02o0Sj0TaVWONdrRiWAWvL4komYry9I35ync0fQBJvDwa7OEihepUFLuK7xH8BUJzi8+l1SNmUPD6+l247b2C19ypfGdjuDSn8Q+oWqlXBvDgAWlHjMXxCgHEVDcKuQo7PvFdugIj3uKsWhhItJ9Wb6yHHpQa18pDkqqOTt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 08:15:07.9188 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17451840-725e-433a-934d-08deaa7e6b83
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9710
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=avihaih@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
 migration/savevm.h       |  2 +-
 hw/vfio/migration.c      | 14 +++++------
 migration/migration.c    |  8 +++----
 migration/savevm.c       | 51 ++++++++++++++++++++++++++--------------
 migration/trace-events   |  4 ++--
 7 files changed, 50 insertions(+), 33 deletions(-)

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
index ba0f9e0f9c..6099bac512 100644
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
diff --git a/migration/savevm.h b/migration/savevm.h
index 1efbe1d79d..fd0c4d3329 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -70,7 +70,7 @@ void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
 int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
                            Error **errp);
 int qemu_load_device_state(QEMUFile *f, Error **errp);
-int qemu_loadvm_approve_switchover(const char *approver);
+int qemu_loadvm_approve_switchover_legacy(const char *approver);
 int qemu_savevm_state_non_iterable(QEMUFile *f, Error **errp);
 int qemu_savevm_state_non_iterable_early(QEMUFile *f,
                                          JSONWriter *vmdesc,
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 4dab569e62..314095235d 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -463,11 +463,11 @@ static bool vfio_precopy_supported(VFIODevice *vbasedev)
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
 
@@ -755,7 +755,7 @@ static int vfio_load_setup(QEMUFile *f, void *opaque, Error **errp)
         return ret;
     }
 
-    vfio_request_switchover_ack(vbasedev);
+    vfio_request_switchover_ack_legacy(vbasedev);
 
     return 0;
 }
@@ -828,11 +828,11 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
                 return -EINVAL;
             }
 
-            ret = qemu_loadvm_approve_switchover(vbasedev->name);
+            ret = qemu_loadvm_approve_switchover_legacy(vbasedev->name);
             if (ret) {
-                error_report(
-                    "%s: qemu_loadvm_approve_switchover failed, err=%d (%s)",
-                    vbasedev->name, ret, strerror(-ret));
+                error_report("%s: qemu_loadvm_approve_switchover_legacy "
+                             "failed, err=%d (%s)",
+                             vbasedev->name, ret, strerror(-ret));
             }
 
             return ret;
diff --git a/migration/migration.c b/migration/migration.c
index 1db2d296bc..3c4385b5f7 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2165,7 +2165,7 @@ void migration_rp_kick(MigrationState *s)
 }
 
 /* This is called only on destination side */
-void migration_request_switchover_ack(const char *requester)
+void migration_request_switchover_ack_legacy(const char *requester)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
 
@@ -2173,10 +2173,10 @@ void migration_request_switchover_ack(const char *requester)
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
index 2bc3414363..687d6761cc 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2462,6 +2462,31 @@ static int loadvm_postcopy_handle_switchover_start(Error **errp)
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
@@ -2511,18 +2536,9 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
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
 
@@ -3137,18 +3153,19 @@ int qemu_load_device_state(QEMUFile *f, Error **errp)
     return 0;
 }
 
-int qemu_loadvm_approve_switchover(const char *approver)
+int qemu_loadvm_approve_switchover_legacy(const char *approver)
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
index 9f5f6142d3..d6795c64c7 100644
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


