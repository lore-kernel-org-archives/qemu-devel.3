Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B313C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 16:26:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT2YU-0002QZ-Sc; Thu, 25 Jan 2024 11:26:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rT2YT-0002Q7-J9
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:26:17 -0500
Received: from mail-co1nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2416::600]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rT2YR-0000Vs-0P
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:26:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRn06frzlnuLYEb6kVJFItMjrCnWs3ApaL6fQ/aClxJ0U3gwzjLPj6pBCB0kDsbDtnfsq+HAp7AwjfaheuUFPUS1QsUpFYJk+SG4JncuCSUxbeRev6ysrvThHbQJbJBEpRuobDd0FO47sYnPhwqJzUWgIZNRTszC1o+7Pi8wV59DgVMLJLicwQLsT+p5BYgi/X50A7QEAdCbkW2r2VbmZ19A6bONSmmkq/9va4jAkbymLpzpskCxvbN7gY00JFAys50yGqR6baxjqFSEiN001kyFl20ZxXL/W4eLVoNoCA3mfniAUqRAvgdxWK4K7SHNoyz6wMWVJgMCgOJFZX+pdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBG0qsv98gUwGePqCU0WTNzg9t4JoCaKfnYWJBuqw2w=;
 b=OuTL05SQCj1/Y0LbNCKgOnMyn63c44ba702LFMgqogHPvnOnK6nLS1qejleeoCPQKSWc/d+VXys70qtDsbLA+1yyE4b7jnxt6oSkuBrhZ0x/4U7IJIxlc5K0S3t7c4gf9z2CKvQExayUAk1bx3YY6+gSvijjE9SmbbQl9CJudT8gtvpQl1kaI9EM0kROTfaSKjn76B8fcB/ocL7b+evgcJvJEU7wd9B2fsxjYz19z/0fKvjsbCyr2kIvvw5QxnKb/pRnIvXBDLuIReApdhdlhPaOYJD9GqHbMGl9T8b9fhJwYX8B7B3N1oRBHx0EY5n9br8HoQ+tpeVL0gvDHpIHBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBG0qsv98gUwGePqCU0WTNzg9t4JoCaKfnYWJBuqw2w=;
 b=tO/ppWui+Q9+ULGfGYvdopZf4ggEqiOP8ygY2WtQg2y+bHpHQly5rihb+7gA5vIhP4bar2CZGkJmb2tWZe5tlFTxoQCGj+iZT95/CXwYbaphpiuKWqK9nOWqWNi0Q71gy0bq9nbbQPCds2860XL9IiXPt/a6Kgws9I5/hSut0Y3/7cYL34ZZgnOp5sCuBRvug/51NuJKTfM7MhJ3C9PGisf2NCfgY4lvSgCUrX7mCI0Jd7t0H03528L92e9jvXhs48cbja3A5N6xg5h4OPQZkt73I4UC3h87n0vuAjS0nINIYIwCLHH2qwh7ODWwvS3knH2SDYPYKDqhPCpLVW4/Mw==
Received: from DM5PR07CA0063.namprd07.prod.outlook.com (2603:10b6:4:ad::28) by
 CH3PR12MB8971.namprd12.prod.outlook.com (2603:10b6:610:177::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 16:26:10 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:4:ad:cafe::ce) by DM5PR07CA0063.outlook.office365.com
 (2603:10b6:4:ad::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26 via Frontend
 Transport; Thu, 25 Jan 2024 16:26:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.16 via Frontend Transport; Thu, 25 Jan 2024 16:26:10 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 25 Jan
 2024 08:25:59 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 25 Jan 2024 08:25:59 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport;
 Thu, 25 Jan 2024 08:25:58 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, "Avihai
 Horon" <avihaih@nvidia.com>
Subject: [PATCH 17/17] migration/postcopy: Use the new migration channel
 connect API for postcopy preempt
Date: Thu, 25 Jan 2024 18:25:28 +0200
Message-ID: <20240125162528.7552-18-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20240125162528.7552-1-avihaih@nvidia.com>
References: <20240125162528.7552-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|CH3PR12MB8971:EE_
X-MS-Office365-Filtering-Correlation-Id: e2313c2e-b42e-4651-7f01-08dc1dc25756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AHcoS9ZSmnlzweQGbSZ9b53lLlZM3V6oB2Vx51HYl7+i8atalc5tFkXZTRs36PXYy2VG7x0TWQhgmcgV/8i5aB6zVz0+0rMCaZObPFDKJkQmyLu0Waf7SsbOleMJDgyKIpVLNpXRecuxsC7VWtC9JSY3wn2tm5IhI120WPZX6GsfJgcuMQqTWcK0tslm1R689nfugB8e4AWgpQros3W3YrCZG/GnxEtvZuBDa4ZL9zQBXPg1VVKDC/N3jU7LrRWekAWx+t3sHzE++KkENdbSzgVMGX55FhAQmb9ZNFCM6vwBKwwXoAOZ8sjq1ObuCPN9jTqVrg+Oni0Lh00Cx2tl8eZFvJqhdSy/Yp4GNDZem4bIxuNw2AkH9JED6Qsr/96qo8HxVuSns4v1QT3Q7heJMM99uTvIZPLUeBNXPDIIE068TiXrQ6p2oVbU9ixDkbMN3SOdtCuSZieojMgMMj5vB3b1sFDfT8PiEQa7XystQeaiwq3GdccxZmIbu21IEFbNYtZx9NRi3QmOBTNWImDysilzTm0Rvtyo63dyQ01leVDxw7zRUxuKhtVMxFn8ibgbsvhPqNZqlOBmS5SE0bRS2j5HxIWqe9sEKlmHM5tRTocq09hRh26TngtN8cYcLJ+2ZfT5svjX9F+IET5/q4MYSRS1oVL7FP5Zk327kVgOYk29sXi8+6c7AOvnSL0Vf++8aERA2mwDwUN4uXeecbx18E0iD2e9Kj+9E1/YLIFJxnJ7tMG1ZRYvWJcS2BJa1+1Q
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(1800799012)(64100799003)(82310400011)(186009)(451199024)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(83380400001)(41300700001)(86362001)(36756003)(356005)(36860700001)(2616005)(107886003)(47076005)(1076003)(82740400003)(26005)(426003)(336012)(7696005)(7636003)(478600001)(2906002)(70586007)(6916009)(70206006)(316002)(54906003)(6666004)(8936002)(4326008)(5660300002)(8676002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 16:26:10.4508 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2313c2e-b42e-4651-7f01-08dc1dc25756
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8971
Received-SPF: softfail client-ip=2a01:111:f403:2416::600;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Use the new migration channel connect API for postcopy preempt and
remove old channel connect code.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/postcopy-ram.h |   2 +-
 migration/postcopy-ram.c | 105 +++++++++++++++------------------------
 2 files changed, 42 insertions(+), 65 deletions(-)

diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index 442ab89752..c1b7d9be6d 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -192,7 +192,7 @@ enum PostcopyChannels {
 };
 
 void postcopy_preempt_new_channel(MigrationIncomingState *mis, QEMUFile *file);
-void postcopy_preempt_setup(MigrationState *s);
+int postcopy_preempt_setup(MigrationState *s);
 int postcopy_preempt_establish_channel(MigrationState *s);
 
 #endif
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 3df937e7da..1d80acc7b4 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -34,9 +34,9 @@
 #include "exec/ramblock.h"
 #include "socket.h"
 #include "yank_functions.h"
-#include "tls.h"
 #include "qemu/userfaultfd.h"
 #include "qemu/mmap-alloc.h"
+#include "channel.h"
 #include "options.h"
 
 /* Arbitrary limit on size of each discard command,
@@ -1620,65 +1620,6 @@ void postcopy_preempt_new_channel(MigrationIncomingState *mis, QEMUFile *file)
     trace_postcopy_preempt_new_channel();
 }
 
-/*
- * Setup the postcopy preempt channel with the IOC.  If ERROR is specified,
- * setup the error instead.  This helper will free the ERROR if specified.
- */
-static void
-postcopy_preempt_send_channel_done(MigrationState *s,
-                                   QIOChannel *ioc, Error *local_err)
-{
-    if (local_err) {
-        migrate_set_error(s, local_err);
-        error_free(local_err);
-    } else {
-        migration_ioc_register_yank(ioc);
-        s->postcopy_qemufile_src = qemu_file_new_output(ioc);
-        trace_postcopy_preempt_new_channel();
-    }
-
-    /*
-     * Kick the waiter in all cases.  The waiter should check upon
-     * postcopy_qemufile_src to know whether it failed or not.
-     */
-    qemu_sem_post(&s->postcopy_qemufile_src_sem);
-}
-
-static void postcopy_preempt_tls_handshake(QIOChannel *ioc, gpointer opaque,
-                                           Error *err)
-{
-    MigrationState *s = opaque;
-
-    postcopy_preempt_send_channel_done(s, ioc, err);
-    object_unref(ioc);
-}
-
-static void
-postcopy_preempt_send_channel_new(QIOTask *task, gpointer opaque)
-{
-    g_autoptr(QIOChannel) ioc = QIO_CHANNEL(qio_task_get_source(task));
-    MigrationState *s = opaque;
-    Error *local_err = NULL;
-
-    if (qio_task_propagate_error(task, &local_err)) {
-        goto out;
-    }
-
-    if (migrate_channel_requires_tls_upgrade(ioc)) {
-        if (!migration_tls_channel_connect(ioc, "preempt", s->hostname,
-                                           postcopy_preempt_tls_handshake, s,
-                                           false, &local_err)) {
-            goto out;
-        }
-        /* Setup the channel until TLS handshake finished */
-        return;
-    }
-
-out:
-    /* This handles both good and error cases */
-    postcopy_preempt_send_channel_done(s, ioc, local_err);
-}
-
 /*
  * This function will kick off an async task to establish the preempt
  * channel, and wait until the connection setup completed.  Returns 0 if
@@ -1697,7 +1638,9 @@ int postcopy_preempt_establish_channel(MigrationState *s)
      * setup phase of migration (even if racy in an unreliable network).
      */
     if (!s->preempt_pre_7_2) {
-        postcopy_preempt_setup(s);
+        if (postcopy_preempt_setup(s)) {
+            return -1;
+        }
     }
 
     /*
@@ -1709,10 +1652,44 @@ int postcopy_preempt_establish_channel(MigrationState *s)
     return s->postcopy_qemufile_src ? 0 : -1;
 }
 
-void postcopy_preempt_setup(MigrationState *s)
+/*
+ * Setup the postcopy preempt channel with the IOC.  If ERROR is specified,
+ * setup the error instead.  This helper will free the ERROR if specified.
+ */
+static void postcopy_preempt_send_channel_new_callback(QIOChannel *ioc,
+                                                       void *opaque, Error *err)
+{
+    MigrationState *s = opaque;
+
+    if (err) {
+        migrate_set_error(s, err);
+        error_free(err);
+    } else {
+        migration_ioc_register_yank(ioc);
+        s->postcopy_qemufile_src = qemu_file_new_output(ioc);
+        trace_postcopy_preempt_new_channel();
+    }
+
+    /*
+     * Kick the waiter in all cases.  The waiter should check upon
+     * postcopy_qemufile_src to know whether it failed or not.
+     */
+    qemu_sem_post(&s->postcopy_qemufile_src_sem);
+    object_unref(OBJECT(ioc));
+}
+
+int postcopy_preempt_setup(MigrationState *s)
 {
-    /* Kick an async task to connect */
-    socket_send_channel_create(postcopy_preempt_send_channel_new, s);
+    Error *local_err = NULL;
+
+    if (!migration_channel_connect(postcopy_preempt_send_channel_new_callback,
+                                   "preempt", s, false, &local_err)) {
+        migrate_set_error(s, local_err);
+        error_report_err(local_err);
+        return -1;
+    }
+
+    return 0;
 }
 
 static void postcopy_pause_ram_fast_load(MigrationIncomingState *mis)
-- 
2.26.3


