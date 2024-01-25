Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8DCDC47422
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 16:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT2YJ-0002KS-Aq; Thu, 25 Jan 2024 11:26:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rT2YH-0002K5-St
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:26:05 -0500
Received: from mail-co1nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2416::601]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rT2YF-0000Sp-LV
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:26:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idBi7CPGHGb+/3v6VAA6Nzew5CUJYX6Wo7zD9KyK+jrzcK4DwCLYMEfuq4wTMd1gvfVysBhR5MJ/fGNE5dSNrlfOEEwSUZz3/Rzky6EmC2/68AqqE9DwfJ/MBy5u/Bp2cyhOcMS/ry0m9ZBwv+V7kCKCxH35SpjySsLYh47ZoaV8d2LV06prP+qFPLztvGgh/2DFLac1/vB7t4aNVVYLalCZfM8JM4Kc/EFNThsQ20X1SbMlaYZRxeCBGs/sMq2XRFWWt9+odUfj9txinfw2rAy9/2zyzsXc0tSsMGexTVL4Iv4YUXBfaksgQT1bQo7tRNKUWjo394QVckodvpxhxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8n4unbQ1FG9WGWzdc44omo+MZXrLbpGq+Y1DO8/pKmk=;
 b=ZJTxPKQ2lkf3Bh4QzqXpELXHUzy77Ffo8GhqM3Mnnx9Qsf3sSYJaDY1oVLh2WDmsbpfT8un3gPQsw3qnvX0Pf/bRjexFyu2Z84su3hCD/XKR5apRBMzUKUgD5XC3zALEL9Ey0Br9mu3n2E3479rFM8xermQsjuYCV4JjtsP66vL6gSttRScJqmkSA1D8QOFRCqPWCCjfrgRDXh979l2/823H/KwzHd8zna5EQaAfvmmODSBXLiFOcXdADfV9dOAU2IfHk6YlgaN3vyTKTlRW53rwXmDMfaL9vka64V+h66+uZs12oqvnwdb8S/cw0nX3WtK3fQvkt23XQiVpekoFcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8n4unbQ1FG9WGWzdc44omo+MZXrLbpGq+Y1DO8/pKmk=;
 b=Bi1bNAviKO3+RPa44QKz0ThDqOPRmjFM0AO4nEoziHsDWgNoLnu74GWPaWkClptPa9l8S6N1g4xhD3tN+QRD2ggPchQbtLVinWdtXvBUYDx6dKXVD2uqUNWjGg7hsmZ6JbbN1LNZjzp2l1yFGBtuMgLVCwjQT/bK2+SBY6KgxGtFLv0vGIQexxBqQUXc8qYwQ0/2qkIwwkpxiga3DPYdN7kWFDktk7zKvZwQvlehgGbK5a51ffiLJQ8fNTqEt5G2iK90TY1pKEAF4D8tLjg62okF+jHhMcll0tFOKOEqzHVqzGPrNvQlpWOUaL/EBNMRJ33fubCHuCtnx6ZG+7JofA==
Received: from DM5PR07CA0067.namprd07.prod.outlook.com (2603:10b6:4:ad::32) by
 SA1PR12MB5670.namprd12.prod.outlook.com (2603:10b6:806:239::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.24; Thu, 25 Jan 2024 16:25:54 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:4:ad:cafe::6) by DM5PR07CA0067.outlook.office365.com
 (2603:10b6:4:ad::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27 via Frontend
 Transport; Thu, 25 Jan 2024 16:25:54 +0000
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
 15.20.7228.16 via Frontend Transport; Thu, 25 Jan 2024 16:25:54 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 25 Jan
 2024 08:25:44 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 25 Jan 2024 08:25:44 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport;
 Thu, 25 Jan 2024 08:25:42 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, "Avihai
 Horon" <avihaih@nvidia.com>
Subject: [PATCH 08/17] migration: Use the new TLS upgrade API for main channel
Date: Thu, 25 Jan 2024 18:25:19 +0200
Message-ID: <20240125162528.7552-9-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20240125162528.7552-1-avihaih@nvidia.com>
References: <20240125162528.7552-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|SA1PR12MB5670:EE_
X-MS-Office365-Filtering-Correlation-Id: f7f97bc0-16dc-4930-a636-08dc1dc24db7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PKL2yhijD+/GWoZvzCwCmDPI6Ij0lJx95rBriHbK+OfDnOfh6jy4W4CUwxQFyQhid5l/o1f3hHym2TFT4INhxuKUmDhVC9wBsgM4tpGz0REaIi2GFeqxAkSh/YYsdAXy7uCxfWyFEFxy6dgJARE9GRNRo3moY+mgQWYUXX7qroN9SfSmIfYtTrALjlIBFzhu9HepYd0J0PHH1Xmx3i68QPlhXSdp+J2bxj2u/fAFgFyffKdTG92/dL4304xzqanXKP7RVRfcT0x+2fvLgGcNE1lLmbDfNATmcStMlChEPFEx4gAWMsja+NXlZsCDltStZKrGgSsbue3OR59gAQ5J3Z6DXqDzVK9tfuYWs0jpb7I+SrWqJPUs8VQ6We8t4HkSNoRdkqU13x70U2MJwKkStGfFGJIK/TDsNRo3epW1nrL6VVwauGpRFNj3qVWoVwI1n7tQuaH21llZkVa92kUVKZdG/M+ofEbZ3boRaoALXyou/FAgE/fr8fZUfyRDZgC85r6DHB0TiKFvcLMb5hKDGKUsbOhUOL0qkhitj1CpMEVn2Py7rGEZwQQUElj9UZW/Rn7C/AUdZ6tkk1688j9plQ5Gc+HAMUcga1lvMQZXnsvwXXbDgE7qg/RSLbxH+N8981hWSuolpKvaVh1/bd0jh4QL570SRDAiu0aoLKeyD/JUkGv8Z9k0I2SHR7ype8EqufjHLS4nz3tZdgQvLjYCS4YYSJ+tPPI/PJAQceVnk0S1QTkUI+1p5oUGQiGydPjD
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(186009)(82310400011)(1800799012)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(2906002)(5660300002)(8936002)(8676002)(4326008)(40460700003)(40480700001)(70586007)(70206006)(316002)(54906003)(6916009)(6666004)(1076003)(107886003)(478600001)(7696005)(2616005)(82740400003)(26005)(336012)(426003)(36860700001)(7636003)(36756003)(86362001)(356005)(83380400001)(41300700001)(47076005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 16:25:54.3103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f97bc0-16dc-4930-a636-08dc1dc24db7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5670
Received-SPF: softfail client-ip=2a01:111:f403:2416::601;
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

Use the new TLS upgrade API for main migration channel and remove the
old TLS code.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/tls.h        |  3 ---
 migration/channel.c    | 24 +++++++++++++++++-------
 migration/tls.c        | 36 ------------------------------------
 migration/trace-events |  3 ---
 4 files changed, 17 insertions(+), 49 deletions(-)

diff --git a/migration/tls.h b/migration/tls.h
index 514529ff38..a6babbfa14 100644
--- a/migration/tls.h
+++ b/migration/tls.h
@@ -32,9 +32,6 @@ QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
                                            const char *hostname,
                                            Error **errp);
 
-void migration_tls_channel_connect_main(MigrationState *s, QIOChannel *ioc,
-                                        const char *hostname, Error **errp);
-
 typedef void (*MigTLSConCallback)(QIOChannel *ioc, void *opaque, Error *err);
 
 /**
diff --git a/migration/channel.c b/migration/channel.c
index 041a63eb21..4022b2c9b8 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -50,6 +50,14 @@ void migration_channel_process_incoming(QIOChannel *ioc)
     }
 }
 
+static void migration_channel_tls_handshake_main(QIOChannel *ioc, void *opaque,
+                                                 Error *err)
+{
+    MigrationState *s = opaque;
+
+    migration_channel_connect(s, ioc, NULL, err);
+    object_unref(OBJECT(ioc));
+}
 
 /**
  * @migration_channel_connect - Create new outgoing migration channel
@@ -69,14 +77,16 @@ void migration_channel_connect(MigrationState *s,
 
     if (!error) {
         if (migrate_channel_requires_tls_upgrade(ioc)) {
-            migration_tls_channel_connect_main(s, ioc, hostname, &error);
-
-            if (!error) {
-                /* tls_channel_connect will call back to this
-                 * function after the TLS handshake,
-                 * so we mustn't call migrate_fd_connect until then
+            /* Save hostname into MigrationState for handshake */
+            s->hostname = g_strdup(hostname);
+            if (migration_tls_channel_connect(
+                    ioc, "main", hostname, migration_channel_tls_handshake_main,
+                    s, false, &error)) {
+                /*
+                 * migration_channel_tls_handshake_main will call back to this
+                 * function after the TLS handshake, so we mustn't call
+                 * migrate_fd_connect until then.
                  */
-
                 return;
             }
         } else {
diff --git a/migration/tls.c b/migration/tls.c
index e6a0349bd1..99c71e4fb6 100644
--- a/migration/tls.c
+++ b/migration/tls.c
@@ -97,24 +97,6 @@ void migration_tls_channel_process_incoming(MigrationState *s,
                               NULL);
 }
 
-
-static void migration_tls_outgoing_handshake_main(QIOTask *task,
-                                                  gpointer opaque)
-{
-    MigrationState *s = opaque;
-    QIOChannel *ioc = QIO_CHANNEL(qio_task_get_source(task));
-    Error *err = NULL;
-
-    if (qio_task_propagate_error(task, &err)) {
-        trace_migration_tls_outgoing_handshake_main_error(
-            error_get_pretty(err));
-    } else {
-        trace_migration_tls_outgoing_handshake_main_complete();
-    }
-    migration_channel_connect(s, ioc, NULL, err);
-    object_unref(OBJECT(ioc));
-}
-
 QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
                                            const char *hostname,
                                            Error **errp)
@@ -134,24 +116,6 @@ QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
     return qio_channel_tls_new_client(ioc, creds, hostname, errp);
 }
 
-void migration_tls_channel_connect_main(MigrationState *s, QIOChannel *ioc,
-                                        const char *hostname, Error **errp)
-{
-    QIOChannelTLS *tioc;
-
-    tioc = migration_tls_client_create(ioc, hostname, errp);
-    if (!tioc) {
-        return;
-    }
-
-    /* Save hostname into MigrationState for handshake */
-    s->hostname = g_strdup(hostname);
-    trace_migration_tls_outgoing_handshake_main_start(hostname);
-    qio_channel_set_name(QIO_CHANNEL(tioc), "migration-tls-outgoing");
-    qio_channel_tls_handshake(tioc, migration_tls_outgoing_handshake_main, s,
-                              NULL, NULL);
-}
-
 typedef struct {
     QIOChannelTLS *tioc;
     MigTLSConCallback callback;
diff --git a/migration/trace-events b/migration/trace-events
index 09dd342d37..80c3c20faa 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -325,9 +325,6 @@ migration_socket_outgoing_connected(const char *hostname) "hostname=%s"
 migration_socket_outgoing_error(const char *err) "error=%s"
 
 # tls.c
-migration_tls_outgoing_handshake_main_start(const char *hostname) "hostname=%s"
-migration_tls_outgoing_handshake_main_error(const char *err) "err=%s"
-migration_tls_outgoing_handshake_main_complete(void) ""
 migration_tls_outgoing_handshake_start(const char *hostname, const char *name) "hostname=%s, name=%s"
 migration_tls_outgoing_handshake_error(const char *name, const char *err) "name=%s, err=%s"
 migration_tls_outgoing_handshake_complete(const char *name) "name=%s"
-- 
2.26.3


