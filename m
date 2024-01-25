Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E73BC47422
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 16:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT2YS-0002Pk-8n; Thu, 25 Jan 2024 11:26:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rT2YR-0002Pa-4M
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:26:15 -0500
Received: from mail-bn8nam12on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2418::600]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rT2YP-0000Vn-8e
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:26:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzjBmzbga8TrRz2PrFngYMrJ5cJCRL6H2Rp+6BBmubWcDEOsn964FA8U+Z7Qx4wWXlEgcbK8bVLHYp9ABr8sIWAbmCSu8jFCTbbJFySLeEupt16TaJyRUbVFXhAww9OeN6UMg6/HkmEOLXDpH396MkoxekwIefRJgfG8GJ7VdYDpYfLCED+BWD49y9Tvf29WB8UB57Y7+l1havepX9DPejowHdX2ln7bkKhljuJnAJ4guVIus6uv5p5x7XEi2rbThM9raPnFsAZkk6cpiTEi+uz0h/C3nSdM3YkVOeo+MI3Q+483PIpU3n4FobKu3cBOAa13To+5z0TWw2lSSMhoVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zy4AaUsE8ycrSz5IejZl8Zo89GZWYWXE8niRefWRUw=;
 b=hhZdQu72SLvNFsvW43OMYqW4subGqQZH3UHfwttMtv7Df437gMpuu7z09o07+8+5jW40RHuWCohzOcCc8B2wkt3oL1uscIZJs8Xe1+pD/Nt4vKkLBYKueon9UkH25vYvjl2m1PlFQ128aO8QR+seJrkFwKfMdMcPzZp980PfZiblrlVlbXOGYWWaSQxl3KItawW7KxJEfDeedrbf4yCfp50QsX7qyUix0W9XkFWZUmg3liMkAxrnX1R9gQXW4b2/hcDWgpFOGTSTBhGkxu/m0sLGXE+muknW/igDNs1hQTb3F8rHFc5+BgvISqgrSl25zIrJKAXXli4eFTlmQynLEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zy4AaUsE8ycrSz5IejZl8Zo89GZWYWXE8niRefWRUw=;
 b=fuDfzo08wC0wMuxcCSgzZbOhoznUQGg4sn7mfStm/0Cfg4pfcqZFFemK3+Rurn6DdiX8kc79w9CMIIdnwMsb0dvP1pNB6zazg9ilyXQY2wTds3io89l1UN734yRCBY3Yj/QFw06Wx+W81EAFm8IqbxF+4/EZEdLfhpiiNxgz2mkY3KCtw02cOIxnD5K9MG5rkeEq/5TRVJN9BgupE1K0rBXGzahrECRcJV+u+jkWNOYjQs4gZsqTU5/4v2XifJ2DLlXcEveInWI9hafXkgcJ3Kn6wr6hmRil/C9mIugx+CTnOE5AdBHSljG+9dZ561+GyRY+BIvH8111DLEbkz3ZPQ==
Received: from DM5PR07CA0061.namprd07.prod.outlook.com (2603:10b6:4:ad::26) by
 SJ0PR12MB5453.namprd12.prod.outlook.com (2603:10b6:a03:37f::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.24; Thu, 25 Jan 2024 16:26:09 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:4:ad:cafe::f1) by DM5PR07CA0061.outlook.office365.com
 (2603:10b6:4:ad::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Thu, 25 Jan 2024 16:26:09 +0000
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
 15.20.7228.16 via Frontend Transport; Thu, 25 Jan 2024 16:26:09 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 25 Jan
 2024 08:25:58 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 25 Jan 2024 08:25:57 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport;
 Thu, 25 Jan 2024 08:25:56 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, "Avihai
 Horon" <avihaih@nvidia.com>
Subject: [PATCH 16/17] migration/multifd: Use the new migration channel
 connect API for multifd
Date: Thu, 25 Jan 2024 18:25:27 +0200
Message-ID: <20240125162528.7552-17-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20240125162528.7552-1-avihaih@nvidia.com>
References: <20240125162528.7552-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|SJ0PR12MB5453:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e807c04-803e-4577-ea2a-08dc1dc2569e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rdRa8V4Os6bCUACc2DHs7FWmh/NLOzy32iYWEVp1UKLAU9W0tqkph1EfIbyy5AxiV9CdoDUrU7fGi5qkQbZ0XpBK05jgbgV3KKvkY7lnfanY4NoWHObA3IAgvj876dcSVkhMe1v7AIn+2RyUL6e28ZwV9vc19vLJZsRnmSjEXzDnFjmgX1W3NnBIm6cBxEi24A6M0ycDS+hC0NXPbmeIoIiqGHKEEqhFvrP4SoJHKYh8cbzjfY2mr+5iiaFQMXWZq5X/FMDIuk+XmT9RoNDnM02TQlQpPZS9I/CGx586NqcLUvJh2XF/MTxegRf1jTwLVzMaUc8p2qW+pk39ydxSpC74PkBH/QjUvFfCP+qTYsaVhWWKPXAJ8syj+CfuimUmzYPK4paSUW3QJ7kAtexgiflX6NUN7r+xx7JVKQizN0FukiVEgvFNtcK6vBf8tNYJ2YFZvTiq5JznZmEtTCf4bPgccEZHA4RyELWBckGZhVMYW+wVK4k4P1IV2GxDmTWKlq70Egs+EG69uhUKTy4M/won8Bk7sCCfGDSnm+FQsA0nufrZklJyJn6S+0jAw4hukkWY5JhNAjt56iswjRkN+3ReI39TZmb5np9E38HC9+tA3PHrSLHW6RUvP+B0Va+ihPWdd5sfEn6b5TwQbJqBqXMSL7TUPPVAJjofMMDLVy5huygEUG1Oq+QNtxz2/D3CSQ0ewlt4W3Pxa4YS+2tRvcHH3hPQ+xk/431fjkjOO2V+SRXm32DL5CTympS3rpYG
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(64100799003)(186009)(82310400011)(1800799012)(451199024)(40470700004)(46966006)(36840700001)(36860700001)(47076005)(2906002)(36756003)(41300700001)(86362001)(7636003)(82740400003)(356005)(54906003)(7696005)(6916009)(316002)(70586007)(70206006)(478600001)(2616005)(6666004)(336012)(426003)(83380400001)(5660300002)(8676002)(4326008)(1076003)(107886003)(8936002)(26005)(40480700001)(40460700003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 16:26:09.2477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e807c04-803e-4577-ea2a-08dc1dc2569e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5453
Received-SPF: softfail client-ip=2a01:111:f403:2418::600;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Use the new migration channel connect API for multifd and remove old
channel connect code.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/multifd.c    | 89 ++++++++++--------------------------------
 migration/trace-events |  3 --
 2 files changed, 21 insertions(+), 71 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index cc9a1182fa..c679b64721 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -18,10 +18,10 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "ram.h"
+#include "channel.h"
 #include "migration.h"
 #include "migration-stats.h"
 #include "socket.h"
-#include "tls.h"
 #include "qemu-file.h"
 #include "trace.h"
 #include "multifd.h"
@@ -790,61 +790,6 @@ int multifd_send_channels_created(void)
     return ret;
 }
 
-static bool multifd_channel_connect(MultiFDSendParams *p,
-                                    QIOChannel *ioc,
-                                    Error **errp);
-
-static void multifd_new_send_channel_cleanup(MultiFDSendParams *p,
-                                             QIOChannel *ioc, Error *err);
-
-static void multifd_tls_outgoing_handshake(QIOChannel *ioc, gpointer opaque,
-                                           Error *err)
-{
-    MultiFDSendParams *p = opaque;
-
-    if (!err) {
-        if (multifd_channel_connect(p, ioc, &err)) {
-            return;
-        }
-    }
-
-    multifd_new_send_channel_cleanup(p, ioc, err);
-}
-
-static bool multifd_channel_connect(MultiFDSendParams *p,
-                                    QIOChannel *ioc,
-                                    Error **errp)
-{
-    MigrationState *s = migrate_get_current();
-
-    trace_multifd_set_outgoing_channel(ioc, object_get_typename(OBJECT(ioc)),
-                                       s->hostname);
-
-    if (migrate_channel_requires_tls_upgrade(ioc)) {
-        /*
-         * multifd_tls_outgoing_handshake will call back to this function after
-         * the TLS handshake, so we mustn't call multifd_send_thread until then.
-         */
-        if (migration_tls_channel_connect(ioc, p->name, s->hostname,
-                                          multifd_tls_outgoing_handshake, p,
-                                          true, errp)) {
-            object_unref(OBJECT(ioc));
-            return true;
-        }
-        return false;
-    }
-
-    qio_channel_set_delay(ioc, false);
-    migration_ioc_register_yank(ioc);
-    p->registered_yank = true;
-    p->c = ioc;
-    qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
-                       QEMU_THREAD_JOINABLE);
-    p->running = true;
-    qemu_sem_post(&p->create_sem);
-    return true;
-}
-
 static void multifd_new_send_channel_cleanup(MultiFDSendParams *p,
                                              QIOChannel *ioc, Error *err)
 {
@@ -863,26 +808,34 @@ static void multifd_new_send_channel_cleanup(MultiFDSendParams *p,
      error_free(err);
 }
 
-static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
+static void multifd_new_send_channel_callback(QIOChannel *ioc, void *opaque,
+                                              Error *err)
 {
     MultiFDSendParams *p = opaque;
-    QIOChannel *ioc = QIO_CHANNEL(qio_task_get_source(task));
-    Error *local_err = NULL;
 
-    trace_multifd_new_send_channel_async(p->id);
-    if (!qio_task_propagate_error(task, &local_err)) {
-        if (multifd_channel_connect(p, ioc, &local_err)) {
-            return;
-        }
+    if (err) {
+        multifd_new_send_channel_cleanup(p, ioc, err);
+        return;
     }
 
-    trace_multifd_new_send_channel_async_error(p->id, local_err);
-    multifd_new_send_channel_cleanup(p, ioc, local_err);
+    qio_channel_set_delay(ioc, false);
+    migration_ioc_register_yank(ioc);
+    p->registered_yank = true;
+    p->c = ioc;
+    qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
+                       QEMU_THREAD_JOINABLE);
+    p->running = true;
+    qemu_sem_post(&p->create_sem);
 }
 
-static void multifd_new_send_channel_create(gpointer opaque)
+static void multifd_new_send_channel_create(MultiFDSendParams *p)
 {
-    socket_send_channel_create(multifd_new_send_channel_async, opaque);
+    Error *local_err = NULL;
+
+    if (!migration_channel_connect(multifd_new_send_channel_callback, p->name,
+                                   p, true, &local_err)) {
+        multifd_new_send_channel_cleanup(p, NULL, local_err);
+    }
 }
 
 int multifd_save_setup(Error **errp)
diff --git a/migration/trace-events b/migration/trace-events
index 6c915d8567..6ac73b0d85 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -126,8 +126,6 @@ postcopy_preempt_switch_channel(int channel) "%d"
 postcopy_preempt_reset_channel(void) ""
 
 # multifd.c
-multifd_new_send_channel_async(uint8_t id) "channel %u"
-multifd_new_send_channel_async_error(uint8_t id, void *err) "channel=%u err=%p"
 multifd_recv(uint8_t id, uint64_t packet_num, uint32_t used, uint32_t flags, uint32_t next_packet_size) "channel %u packet_num %" PRIu64 " pages %u flags 0x%x next packet size %u"
 multifd_recv_new_channel(uint8_t id) "channel %u"
 multifd_recv_sync_main(long packet_num) "packet num %ld"
@@ -144,7 +142,6 @@ multifd_send_sync_main_wait(uint8_t id) "channel %u"
 multifd_send_terminate_threads(bool error) "error %d"
 multifd_send_thread_end(uint8_t id, uint64_t packets, uint64_t normal_pages) "channel %u packets %" PRIu64 " normal pages %"  PRIu64
 multifd_send_thread_start(uint8_t id) "%u"
-multifd_set_outgoing_channel(void *ioc, const char *ioctype, const char *hostname)  "ioc=%p ioctype=%s hostname=%s"
 
 # migration.c
 migrate_set_state(const char *new_state) "new state %s"
-- 
2.26.3


