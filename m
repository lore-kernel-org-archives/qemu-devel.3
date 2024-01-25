Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC3CC47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 16:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT2YH-0002Jx-JD; Thu, 25 Jan 2024 11:26:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rT2YB-0002IJ-CN
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:26:01 -0500
Received: from mail-dm6nam11on2061e.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::61e]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rT2Y9-0000Rw-6h
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:25:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eio2ZXITtbx8suhXsUoCR5GUcMbedodoXZ2vdJTxxWT4GLPn9oP0uH6JLakKCGq8y0tn9dLT/7EdcNyK/5Proj3OjNS6/Vd5vYeVVPnBstZxqYWPywXsCjp/3ke0BgUHEd0A31NKcP8yp9DBx1/1f/D/6Klw7p4k9LN6ZfF74h3vK3dg4kOT8Y5YrBpXJgg+ekzQeRm/4SCMo2pizQ3YnzBGTsDyF+fQ0KXvOn1p/qdiyqWdtt06+ts5JTCsXyZPuWUYSLI9VMbtFM20CLoCo+vrUqAo8Znudk6TUD7S9QdnXIWiynV65EoSG8ZzXYzPp6OUlkF5/L9ZZ+r8Ix0QjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5FbyVZXOlSh2wPsFIAvxzddoG5UlCNVdaCnEc9QjGcM=;
 b=FQqVPOcR8xO21E2ydDb5pdtlVehydxKDOtSP08BCSv0ORsluKtwrD2HSFCAY1UKJjQs/MkIB273k038OOTZCLqgAnIEQI+ulKmanJDWDmQdoIX40NxtNKTgt5sqwlQUwblWmnRBA2JHEi3lxuFJFdpPwLAa33U8EArQ9qQMKxC1xgNfjSQlCZb2YB20tC0mqAw0bSud/Bkp3pbh9OU7z+W1QfHPOuIYR/UAWHIlEFkUeVMQB7/USfFhHGdZYNwpps2ZZK2u09fi28Jgk0Rz4QTlS+PZa+cGibJa1rH6zSkcJZEODC5lKl2xPYWlKMUxuUlP9m0gW+Yfvj1YXQ53NBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5FbyVZXOlSh2wPsFIAvxzddoG5UlCNVdaCnEc9QjGcM=;
 b=pRsDqIwnKxm9M+ZG2snLcJrMZBzR9HH0Lk2EQOb63rfUcHQHwuTih60ClqGsBBu2GOoWiQl9iLaZ7/lOjT1IjB2lEoxNz7dje+4jO2Xd6Cgun5VlZVNn47GwWtvadObNIFVxut9eXyD0knpDV1EaD6EwfF1K3M/cikRlr1sOECDH6uEsGGnEe5fKXC2gsDy5ZIFdh6WJqYGNk4to+etyVHIIGxlDJcYKXJASC04j3vhYIaJwrKCAn/qzoFs3eNeq+qkxiY5BZZiIwhv9rocM/3LFzd43/XWaChau6uvVcRNtz3qY/+zpGyyLpSEZfgqOtv01KbAUUpldPEgRFG7YFA==
Received: from DM6PR07CA0090.namprd07.prod.outlook.com (2603:10b6:5:337::23)
 by MW4PR12MB7191.namprd12.prod.outlook.com (2603:10b6:303:22d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.30; Thu, 25 Jan
 2024 16:25:51 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:5:337:cafe::99) by DM6PR07CA0090.outlook.office365.com
 (2603:10b6:5:337::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24 via Frontend
 Transport; Thu, 25 Jan 2024 16:25:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.79) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.16 via Frontend Transport; Thu, 25 Jan 2024 16:25:51 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 25 Jan
 2024 08:25:39 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 25 Jan 2024 08:25:38 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport;
 Thu, 25 Jan 2024 08:25:37 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, "Avihai
 Horon" <avihaih@nvidia.com>
Subject: [PATCH 05/17] migration/multifd: Wait for multifd channels creation
 before proceeding
Date: Thu, 25 Jan 2024 18:25:16 +0200
Message-ID: <20240125162528.7552-6-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20240125162528.7552-1-avihaih@nvidia.com>
References: <20240125162528.7552-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|MW4PR12MB7191:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fc7fb83-1169-467c-f189-08dc1dc24be0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ii3pTLuQYsXLOf9yH3SyDcbBDxXEdWDsmEbMURZgIl28mKtG5lIPun0heFX3yjNg856Nexl/vohhz7SQFkfogVxIZJdUzGrwf4eXI/hPAT8btNbXbWXQZNw3NoV1QYuN5nOG3T8ibCKcM9BdpvrrONBHj7DWApcKN86tDAK1vfGFw4dDWvFZFQvzATuweS+RrESxhMwRlFPvCfryDSH2bAmMNUaVhEG0hwNMt/hIaLOc9nzxlxY8VjqBTzA7p0AcCx0eaxE7g8zm14H0902CwB1C2f5WkDh3WhCSwgu8qLlEBqyTOSdyB8/gnkLfby3tUx18rwBBlOiFiL+WYqAjaP06LE30MmKte/XPikyHHzOVgkwwr/mfQ/8KD5Wk8eja6AAje6iW7GMyt6IdZqrCl0BVbRVdfvpD1CJtBKZRk2Jyv/eExeMt0bXBWd0zFYi0q8oouf++eE+k0Co1w6Ouc4jO2B05yyAIKrAREoRyim5cgAsuTbkkrly8mP1EOyovvPMIZYGQYGBcdEpCP+PmfLy/p71hi+IAWrdHiAml4xZyaFBHJ9qNxMC71qZiOmNrbCMToCrBEArqQBh/O6601qBOmO14USPCZYtD/yjtqgJOV9qBWfIBFIpFekNf8ezT1TAcUuZnPx69Ld1fc6pH3uOcGCp7K4lDc9MydvhYYrxSQZU7wWUjHQn4Q5O6kOC/i/x3vQsQ3PtpfJftbiJdP7Kfw2UfR654Ba5SxMP1kU+PFe3YhJmSkroh7qzuP/OH
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(64100799003)(82310400011)(451199024)(186009)(1800799012)(46966006)(40470700004)(36840700001)(2906002)(6916009)(70586007)(36756003)(36860700001)(41300700001)(47076005)(86362001)(7636003)(83380400001)(356005)(82740400003)(6666004)(4326008)(7696005)(316002)(8676002)(478600001)(5660300002)(54906003)(26005)(70206006)(426003)(336012)(1076003)(8936002)(2616005)(107886003)(40480700001)(40460700003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 16:25:51.2568 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc7fb83-1169-467c-f189-08dc1dc24be0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7191
Received-SPF: softfail client-ip=2a01:111:f400:7eaa::61e;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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

Currently, multifd channels are created asynchronously without waiting
for their creation -- migration simply proceeds and may wait in
multifd_send_sync_main(), which is called by ram_save_setup(). This
hides in it some race conditions which can cause an unexpected behavior
if some channels creation fail.

For example, the following scenario of multifd migration with two
channels, where the first channel creation fails, will end in a
segmentation fault (time advances from top to bottom):

Thread           | Code execution
------------------------------------------------------------------------
Multifd 1        |
                 | multifd_new_send_channel_async (errors and quits)
                 |   multifd_new_send_channel_cleanup
                 |
Migration thread |
                 | qemu_savevm_state_setup
                 |   ram_save_setup
                 |     multifd_send_sync_main
                 |     (detects Multifd 1 error and quits)
                 | [...]
                 | migration_iteration_finish
                 |   migrate_fd_cleanup_schedule
                 |
Main thread      |
                 | migrate_fd_cleanup
                 |   multifd_save_cleanup (destroys Multifd 2 resources)
                 |
Multifd 2        |
                 | multifd_new_send_channel_async
                 | (accesses destroyed resources, segfault)

In another scenario, migration can hang indefinitely:
1. Main migration thread reaches multifd_send_sync_main() and waits on
   the semaphores.
2. Then, all multifd channels creation fails, so they post the
   semaphores and quit.
3. Main migration channel will not identify the error, proceed to send
   pages and will hang.

Fix it by waiting for all multifd channels to be created before
proceeding with migration.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/multifd.h   |  3 +++
 migration/migration.c |  1 +
 migration/multifd.c   | 34 +++++++++++++++++++++++++++++++---
 migration/ram.c       |  7 +++++++
 4 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/migration/multifd.h b/migration/multifd.h
index 35d11f103c..87a64e0a87 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -23,6 +23,7 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
 void multifd_recv_sync_main(void);
 int multifd_send_sync_main(void);
 int multifd_queue_page(RAMBlock *block, ram_addr_t offset);
+int multifd_send_channels_created(void);
 
 /* Multifd Compression flags */
 #define MULTIFD_FLAG_SYNC (1 << 0)
@@ -86,6 +87,8 @@ typedef struct {
     /* multifd flags for sending ram */
     int write_flags;
 
+    /* Syncs channel creation and migration thread */
+    QemuSemaphore create_sem;
     /* sem where to wait for more work */
     QemuSemaphore sem;
     /* syncs main thread and channels */
diff --git a/migration/migration.c b/migration/migration.c
index 9c769a1ecd..d81d96eaa5 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3621,6 +3621,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
         error_report_err(local_err);
         migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                           MIGRATION_STATUS_FAILED);
+        multifd_send_channels_created();
         migrate_fd_cleanup(s);
         return;
     }
diff --git a/migration/multifd.c b/migration/multifd.c
index 564e911b6c..f0c216f4f9 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -538,6 +538,7 @@ void multifd_save_cleanup(void)
         multifd_send_channel_destroy(p->c);
         p->c = NULL;
         qemu_mutex_destroy(&p->mutex);
+        qemu_sem_destroy(&p->create_sem);
         qemu_sem_destroy(&p->sem);
         qemu_sem_destroy(&p->sem_sync);
         g_free(p->name);
@@ -766,6 +767,29 @@ out:
     return NULL;
 }
 
+int multifd_send_channels_created(void)
+{
+    int ret = 0;
+
+    if (!migrate_multifd()) {
+        return 0;
+    }
+
+    for (int i = 0; i < migrate_multifd_channels(); i++) {
+        MultiFDSendParams *p = &multifd_send_state->params[i];
+
+        qemu_sem_wait(&p->create_sem);
+        WITH_QEMU_LOCK_GUARD(&p->mutex) {
+            if (p->quit) {
+                error_report("%s: channel %d has already quit", __func__, i);
+                ret = -1;
+            }
+        }
+    }
+
+    return ret;
+}
+
 static bool multifd_channel_connect(MultiFDSendParams *p,
                                     QIOChannel *ioc,
                                     Error **errp);
@@ -794,6 +818,7 @@ static void multifd_tls_outgoing_handshake(QIOTask *task,
     p->quit = true;
     qemu_sem_post(&multifd_send_state->channels_ready);
     qemu_sem_post(&p->sem_sync);
+    qemu_sem_post(&p->create_sem);
     error_free(err);
 }
 
@@ -857,6 +882,7 @@ static bool multifd_channel_connect(MultiFDSendParams *p,
     qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
                        QEMU_THREAD_JOINABLE);
     p->running = true;
+    qemu_sem_post(&p->create_sem);
     return true;
 }
 
@@ -864,15 +890,16 @@ static void multifd_new_send_channel_cleanup(MultiFDSendParams *p,
                                              QIOChannel *ioc, Error *err)
 {
      migrate_set_error(migrate_get_current(), err);
-     /* Error happen, we need to tell who pay attention to me */
-     qemu_sem_post(&multifd_send_state->channels_ready);
-     qemu_sem_post(&p->sem_sync);
      /*
+      * Error happen, we need to tell who pay attention to me.
       * Although multifd_send_thread is not created, but main migration
       * thread need to judge whether it is running, so we need to mark
       * its status.
       */
      p->quit = true;
+     qemu_sem_post(&multifd_send_state->channels_ready);
+     qemu_sem_post(&p->sem_sync);
+     qemu_sem_post(&p->create_sem);
      object_unref(OBJECT(ioc));
      error_free(err);
 }
@@ -921,6 +948,7 @@ int multifd_save_setup(Error **errp)
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
         qemu_mutex_init(&p->mutex);
+        qemu_sem_init(&p->create_sem, 0);
         qemu_sem_init(&p->sem, 0);
         qemu_sem_init(&p->sem_sync, 0);
         p->quit = false;
diff --git a/migration/ram.c b/migration/ram.c
index c0cdcccb75..b3e864a22b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2937,6 +2937,13 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     RAMBlock *block;
     int ret;
 
+    bql_unlock();
+    ret = multifd_send_channels_created();
+    bql_lock();
+    if (ret < 0) {
+        return ret;
+    }
+
     if (compress_threads_save_setup()) {
         return -1;
     }
-- 
2.26.3


