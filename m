Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A275C47422
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 16:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT2YJ-0002Ka-Ky; Thu, 25 Jan 2024 11:26:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rT2YF-0002J0-QT
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:26:03 -0500
Received: from mail-mw2nam10on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2412::601]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rT2YC-0000SW-Mp
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:26:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGDNYCvPKxzZm+xqPBVU4D8JPN4rNRTJMQqCokNW+MdVqCUtRKMrvFIfgIZYVKO86TRz+tWkqfWOEUqpiLk5CdPAX3dR+8k0IzSzywgpXio9oMnu19Ni5NB6aCwCzUAlKRpmJqjC0VqOa/Gc5pVleBPQN8xM8r2MOOvIrgP9yP90OGYarwHwfJupIsXARGbu5hdH+pAIbB4S6ju12Eq373esaPC1CDbl7OjRmftE1Zcj7XC6E/VFv9oj03/4t7sCR8UPqjN6Ig7peM7W8j0OAfkI0pjvBqibZXnnuS+jUpssPXhPim5f/12r2xQ6AQfxKs64ekBm7wNgjINSNDCPgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12XVcAfF7uB2cuFsxerhEBHJIXsw/3ZrNlDzkpyOtb8=;
 b=BSH+mz7u8D4o2lDdNOgQtEwvAmnshwuWcpo1dtlWKujWmjjbSLmMHFKKfHS4bNitZwHCtyzp1ABRC/0DrLPT/SAnwEcU8gs3jW4/QDKtp/FgWlE1UJ3UJyadzGdgUWMimIp+WxT0oWTaOxOLNr+dcoaI+oooGmtT2EJ1j5LsO+xnrHAEkeC6eXIdMFxAH1N7SYiWRTn68zd7XkbloLbPePnuf/LLaIDiRD0T+/2eqEd3kIczUPbWVW0F6glLlH2U2Ihv5fhhimiTBuGeVT+7GfuHBk0WQ1OJ9Mk5CdwzAEjhdwTqLeCloAL+1m2NfJigVimljaPfLvzsTLOplbLcNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12XVcAfF7uB2cuFsxerhEBHJIXsw/3ZrNlDzkpyOtb8=;
 b=jFgxkzeJt5GNb6CRnIG/wFAY3xbr1oVtJEQccSr+NqmHSE8QYgsY2neyp0McxwjE2hzRQGfYw0vAg9RxHcDSpnYUS/yUipleUFr4UBYy33Sp3TdDwjl5rBBhScSeNembbLAQfAjLtSamWqQJe7cGlLmjub1BRCVngtbI3HS8agLIyk8Xnog84GaEkKu3IARJy3DHEo6LfuSen/IDK9wohB5FPC/aQPKMOB8pdObqh8FCn9GJ2Gn9R8dhiclXnDUPZkhxYFXUM7yqKpXeCrjlM1jG0HkvCy+cMnCB41CvBsnBmCBUgaIlcGQ/vmJe4OYFbL4XGIfQeZqbOOxpxuAb0A==
Received: from DM6PR17CA0027.namprd17.prod.outlook.com (2603:10b6:5:1b3::40)
 by CY5PR12MB6083.namprd12.prod.outlook.com (2603:10b6:930:29::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Thu, 25 Jan
 2024 16:25:55 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:5:1b3:cafe::a1) by DM6PR17CA0027.outlook.office365.com
 (2603:10b6:5:1b3::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Thu, 25 Jan 2024 16:25:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.81) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.16 via Frontend Transport; Thu, 25 Jan 2024 16:25:55 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 25 Jan
 2024 08:25:46 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 25 Jan 2024 08:25:45 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport;
 Thu, 25 Jan 2024 08:25:44 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, "Avihai
 Horon" <avihaih@nvidia.com>
Subject: [PATCH 09/17] migration/multifd: Use the new TLS upgrade API for
 multifd channels
Date: Thu, 25 Jan 2024 18:25:20 +0200
Message-ID: <20240125162528.7552-10-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20240125162528.7552-1-avihaih@nvidia.com>
References: <20240125162528.7552-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|CY5PR12MB6083:EE_
X-MS-Office365-Filtering-Correlation-Id: 025efc11-0127-4605-bc28-08dc1dc24e4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bg1f2xpffwmjthPoczxtQXHBC9bYulYJ8C83SWiFdQcddSuYwdCmbhmxB7KQ51uES6zLKi8uJtlI3NfPyAMAiomoeFCDFTDUpKe1aNDZ+VNsW/QE5o9plW50jw2W8rhr0YbHh1JuLsLImbWhHAq6CqfpYpi65kasnzQ+SevW/UDje9Y7xddbeP0v+YFpgzwvp89mwhgdEyId07A4DPgrNCu0AzE4h9eS513WAZL2QGa0AhN+t3YjFaTkYY1f1ym3geKgkXe2PBSxN/AiCCE0WHwgIxm13RWVbYyqtTfAaRKIAHKQq7BHzdmB9dgrZ9JN+ZwK8O22WG2V1IKXNR3sM77NULU/tJAvnQ+RqewlwkpcNJzJ1pyuFXDeFE1u8ozSrWT03VkEqB/ymtawYl/HyO9F3Vz+QjglRmV1Caf75mngq1SCPYMxd/EQ7BW+bDCMStz/pt0lez5fg6WXGaGiKVC1geSL6oBWt9/7i9aNTDAmZkoMnPakKug0XKpDrpZmKBFHxsbtczILjf8FR7Nnmbe+ABCnjAAjss1zrBNHfq08B1aIoFyaUvZRgCO8bGzNtH7QCH5XvpWwGUBOgNjTOcQW1Z14Q8yszwwwV6OcomIn70aCWUdhyTBekKO4LHcYFq99BBWK70VlnYF+csdWnY3lCjAzC4XYiPf5IJH/PlikvOnS55ASIKNs+0kUn36/e3suaehq7bzLYovOoGCIBU8bBbnHic1PhbGCdiAR7OJx02SFQJXMCApXxVZOOqJ9
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(82310400011)(186009)(64100799003)(451199024)(1800799012)(36840700001)(46966006)(40470700004)(4326008)(8676002)(8936002)(2906002)(82740400003)(2616005)(7696005)(36860700001)(6666004)(47076005)(70586007)(70206006)(316002)(5660300002)(83380400001)(6916009)(54906003)(36756003)(41300700001)(7636003)(86362001)(40460700003)(40480700001)(356005)(426003)(336012)(1076003)(107886003)(478600001)(26005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 16:25:55.3186 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 025efc11-0127-4605-bc28-08dc1dc24e4c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6083
Received-SPF: softfail client-ip=2a01:111:f403:2412::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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

Use the new TLS upgrade API for multifd channels and remove the old TLS
code.

Note that p->c is now set only after a successful TLS connection, so
need to call object_unref() on QIOChannelTLS in case of error in
multifd_tls_outgoing_handshake() (previously it was done in
multifd_save_cleanup()).

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/multifd.c    | 66 ++++++++++--------------------------------
 migration/trace-events |  3 --
 2 files changed, 16 insertions(+), 53 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index f0c216f4f9..f4d8cd0023 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -794,22 +794,17 @@ static bool multifd_channel_connect(MultiFDSendParams *p,
                                     QIOChannel *ioc,
                                     Error **errp);
 
-static void multifd_tls_outgoing_handshake(QIOTask *task,
-                                           gpointer opaque)
+static void multifd_tls_outgoing_handshake(QIOChannel *ioc, gpointer opaque,
+                                           Error *err)
 {
     MultiFDSendParams *p = opaque;
-    QIOChannel *ioc = QIO_CHANNEL(qio_task_get_source(task));
-    Error *err = NULL;
 
-    if (!qio_task_propagate_error(task, &err)) {
-        trace_multifd_tls_outgoing_handshake_complete(ioc);
+    if (!err) {
         if (multifd_channel_connect(p, ioc, &err)) {
             return;
         }
     }
 
-    trace_multifd_tls_outgoing_handshake_error(ioc, error_get_pretty(err));
-
     migrate_set_error(migrate_get_current(), err);
     /*
      * Error happen, mark multifd_send_thread status as 'quit' although it
@@ -820,59 +815,30 @@ static void multifd_tls_outgoing_handshake(QIOTask *task,
     qemu_sem_post(&p->sem_sync);
     qemu_sem_post(&p->create_sem);
     error_free(err);
-}
-
-static void *multifd_tls_handshake_thread(void *opaque)
-{
-    MultiFDSendParams *p = opaque;
-    QIOChannelTLS *tioc = QIO_CHANNEL_TLS(p->c);
-
-    qio_channel_tls_handshake(tioc,
-                              multifd_tls_outgoing_handshake,
-                              p,
-                              NULL,
-                              NULL);
-    return NULL;
-}
-
-static bool multifd_tls_channel_connect(MultiFDSendParams *p,
-                                        QIOChannel *ioc,
-                                        Error **errp)
-{
-    MigrationState *s = migrate_get_current();
-    const char *hostname = s->hostname;
-    QIOChannelTLS *tioc;
-
-    tioc = migration_tls_client_create(ioc, hostname, errp);
-    if (!tioc) {
-        return false;
-    }
-
     object_unref(OBJECT(ioc));
-    trace_multifd_tls_outgoing_handshake_start(ioc, tioc, hostname);
-    qio_channel_set_name(QIO_CHANNEL(tioc), "multifd-tls-outgoing");
-    p->c = QIO_CHANNEL(tioc);
-    qemu_thread_create(&p->thread, "multifd-tls-handshake-worker",
-                       multifd_tls_handshake_thread, p,
-                       QEMU_THREAD_JOINABLE);
-    return true;
 }
 
 static bool multifd_channel_connect(MultiFDSendParams *p,
                                     QIOChannel *ioc,
                                     Error **errp)
 {
-    trace_multifd_set_outgoing_channel(
-        ioc, object_get_typename(OBJECT(ioc)),
-        migrate_get_current()->hostname);
+    MigrationState *s = migrate_get_current();
+
+    trace_multifd_set_outgoing_channel(ioc, object_get_typename(OBJECT(ioc)),
+                                       s->hostname);
 
     if (migrate_channel_requires_tls_upgrade(ioc)) {
         /*
-         * tls_channel_connect will call back to this
-         * function after the TLS handshake,
-         * so we mustn't call multifd_send_thread until then
+         * multifd_tls_outgoing_handshake will call back to this function after
+         * the TLS handshake, so we mustn't call multifd_send_thread until then.
          */
-        return multifd_tls_channel_connect(p, ioc, errp);
+        if (migration_tls_channel_connect(ioc, p->name, s->hostname,
+                                          multifd_tls_outgoing_handshake, p,
+                                          true, errp)) {
+            object_unref(OBJECT(ioc));
+            return true;
+        }
+        return false;
     }
 
     qio_channel_set_delay(ioc, false);
diff --git a/migration/trace-events b/migration/trace-events
index 80c3c20faa..2c328326e8 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -144,9 +144,6 @@ multifd_send_sync_main_wait(uint8_t id) "channel %u"
 multifd_send_terminate_threads(bool error) "error %d"
 multifd_send_thread_end(uint8_t id, uint64_t packets, uint64_t normal_pages) "channel %u packets %" PRIu64 " normal pages %"  PRIu64
 multifd_send_thread_start(uint8_t id) "%u"
-multifd_tls_outgoing_handshake_start(void *ioc, void *tioc, const char *hostname) "ioc=%p tioc=%p hostname=%s"
-multifd_tls_outgoing_handshake_error(void *ioc, const char *err) "ioc=%p err=%s"
-multifd_tls_outgoing_handshake_complete(void *ioc) "ioc=%p"
 multifd_set_outgoing_channel(void *ioc, const char *ioctype, const char *hostname)  "ioc=%p ioctype=%s hostname=%s"
 
 # migration.c
-- 
2.26.3


