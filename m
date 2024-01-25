Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C764C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 16:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT2YJ-0002KI-18; Thu, 25 Jan 2024 11:26:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rT2YC-0002IP-Ug
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:26:01 -0500
Received: from mail-dm6nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::601]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rT2Y9-0000SA-K5
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:26:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXBtKGLoifx/KlNSqm/UZlfvU125aO9fFXIMOJVc6kbNgfeTaDYFZJVw1GYeYWgm1uby6nLM+4XqyWjfMhKkl6X1oB8LLfCcESzx7JEWVY9C800e31gJCbWqJnsYG2MU7Vi7vTCa2GC1rqb9nlWLcTdZz9lx/aNksEFwuwbPgooBZq2BgDX7HbwQ27+/tIqE0seZ04w1f8rYdc9zS3rTBacpULRZTFX9TIYzfOQR6sbbveQ9RhnEAIdo4s+z+wxqIKyGgW//BnTa3QDBBObo8Z7bLovTsl3WOj/bifPLIcu8LAIP6xro+ZFCngdhSntdqt1VAbC6pEKet9vYH3reOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2luifolw7a6U9Ml2qGEzAIwBi2Yfqe7F7+I3RhSzko=;
 b=JCUyVlRSfmX7AQBNY5cAqJuYl6ruIFO3xi8SJ8ISj+y7oa0+YtMvC4zijqxLSM6aIyHlvHewbKEo5zpiLQALg40tbZePaENN6xCT7jPhVBc/ADmRvx2jODR9j8B1pXYSl250R1DPlgYHmVZRLRHT/AuNTqA4wwZ+QUzY8/+eHm++UIJb9S41OlkvDY1mJ4S9QZMSnDu/kH+gMxgZ5zTlgIDmuaV6OoNqCClbC7Tj4lX95WhPXqn5yBPBrCllLyTGzqUQij51FRKFo5IBLeHVId/ig6mqs57rLrMuXltMCYWYbklNVHIFojLlLjfKaRYr8sAqLJs6hHVVJ2wKdnWaPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2luifolw7a6U9Ml2qGEzAIwBi2Yfqe7F7+I3RhSzko=;
 b=kxDLBAJfd1fTw7R11Tlkh6pJ7RiYK58MUwSXHbWf0hAB3IKI0q3c68Ow1QcLEDceX/waNxlwWO9bcYds6NwNgHRxqEmXD/slCEX5kTfJbGgzvR017vVXGwBx9huRILqhckogvpEN0ND4rzJz6rHmPFmyeQOh0wXmJKB5tgws+QRrAQJmvHEoYovIgavRnaBlhKKp5NMKsMCE5ufGIGD8DAHHeG0shMLDPC8Ms5GIiROohPQCxUM2vxsxsHtRidetWYyFYNlhN1exl8Ocdr8i6ghhptLLzeSqCPmdEH6x0OTzxLs5N0qD3cGLP+n7Dzxp+8AQpAhuPLKKdNbnDh+kTw==
Received: from DM5PR07CA0066.namprd07.prod.outlook.com (2603:10b6:4:ad::31) by
 SJ2PR12MB8782.namprd12.prod.outlook.com (2603:10b6:a03:4d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Thu, 25 Jan
 2024 16:25:52 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:4:ad:cafe::71) by DM5PR07CA0066.outlook.office365.com
 (2603:10b6:4:ad::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Thu, 25 Jan 2024 16:25:51 +0000
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
 15.20.7228.16 via Frontend Transport; Thu, 25 Jan 2024 16:25:51 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 25 Jan
 2024 08:25:41 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 25 Jan 2024 08:25:40 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport;
 Thu, 25 Jan 2024 08:25:39 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, "Avihai
 Horon" <avihaih@nvidia.com>
Subject: [PATCH 06/17] migration/tls: Rename main migration channel TLS
 functions
Date: Thu, 25 Jan 2024 18:25:17 +0200
Message-ID: <20240125162528.7552-7-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20240125162528.7552-1-avihaih@nvidia.com>
References: <20240125162528.7552-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|SJ2PR12MB8782:EE_
X-MS-Office365-Filtering-Correlation-Id: a2908811-10df-48c2-45e4-08dc1dc24bf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dzjuDFLZX3AGyyz1A0Oa8g2TDEgNXIGteClSBTDlb10BvJ3+b+o7ld3ED9Kv4uBeown9XtKUvO7uc2jiyWJPwFCkHVL/DDDc8X7WYc/8Moynp+iL9zxcdqfv5oic9e0KzRDXa/AAUoeMWLSybWasO0av7gvxYacondIhFURYBihRwSnSY+4VPoa2sqGMlS8JrmOKyhQL/mTvtRF3MF/4i1fs0WaOm2oE4Z1uvChANUcXsufxnHNUoKiZ4tByCfNK20E2evJSKTNzOIEJ0p5QsxKE2XmKF15+6SQBGp+75O7hP0MX4+Lb5OO/Yns+OV5rl69MTo/hC1lSEH4cUH/3bADSPjzm5NPFuMeWsxN2lr33GrTXII9x2b0pC6zJZk00PhNIxnfSSCCWS6NEfO/xp0okueDWPHIT4i2OfJ5iNb087yihojmhfQxonLH+aGeG5dzyCuolUNKwI3+ueqb/lc/O6LS4AxZab42iypGBKCg8FLiKzLndVitK8oUTAYQIxQHMPXH37ecpDAHA3Fy6n7aqBzdvtoe4eHwTTs2QG+PbbPxkuU0tWKUbY8LO3lB6PXHgA5XZhGzFDlz6XEoJN+ibeBR65XTKXhskX6o/GJjP6AULBrsRubxBz6cGAo7fWR4L1byecPU3MlRQeiZ64SCItLmzML+x5GPFIDQIhfKawWljwyHopiTFAcB51co26SexxPJ7gy/Xh+TGTddLmkdI0s6CcRKBt5NmtQKwLuHwpNfAoAzI6AS5BL1P8W8I
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(186009)(451199024)(82310400011)(64100799003)(1800799012)(46966006)(40470700004)(36840700001)(41300700001)(36756003)(478600001)(6666004)(47076005)(4326008)(316002)(7696005)(70206006)(70586007)(107886003)(2616005)(6916009)(1076003)(54906003)(26005)(8676002)(5660300002)(83380400001)(336012)(40480700001)(40460700003)(426003)(8936002)(82740400003)(36860700001)(2906002)(356005)(7636003)(86362001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 16:25:51.3416 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2908811-10df-48c2-45e4-08dc1dc24bf0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8782
Received-SPF: softfail client-ip=2a01:111:f400:7eaa::601;
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

Rename functions related to main migration channel TLS upgrade. This is
done in preparation for the next patch which will add a new TLS upgrade
API for migration channels with the same name.
No functional changes intended.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/tls.h        |  6 ++----
 migration/channel.c    |  2 +-
 migration/tls.c        | 24 ++++++++++--------------
 migration/trace-events |  6 +++---
 4 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/migration/tls.h b/migration/tls.h
index 5797d153cb..5435dd4867 100644
--- a/migration/tls.h
+++ b/migration/tls.h
@@ -32,10 +32,8 @@ QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
                                            const char *hostname,
                                            Error **errp);
 
-void migration_tls_channel_connect(MigrationState *s,
-                                   QIOChannel *ioc,
-                                   const char *hostname,
-                                   Error **errp);
+void migration_tls_channel_connect_main(MigrationState *s, QIOChannel *ioc,
+                                        const char *hostname, Error **errp);
 
 /* Whether the QIO channel requires further TLS handshake? */
 bool migrate_channel_requires_tls_upgrade(QIOChannel *ioc);
diff --git a/migration/channel.c b/migration/channel.c
index f9de064f3b..041a63eb21 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -69,7 +69,7 @@ void migration_channel_connect(MigrationState *s,
 
     if (!error) {
         if (migrate_channel_requires_tls_upgrade(ioc)) {
-            migration_tls_channel_connect(s, ioc, hostname, &error);
+            migration_tls_channel_connect_main(s, ioc, hostname, &error);
 
             if (!error) {
                 /* tls_channel_connect will call back to this
diff --git a/migration/tls.c b/migration/tls.c
index fa03d9136c..803cb54c8b 100644
--- a/migration/tls.c
+++ b/migration/tls.c
@@ -98,17 +98,18 @@ void migration_tls_channel_process_incoming(MigrationState *s,
 }
 
 
-static void migration_tls_outgoing_handshake(QIOTask *task,
-                                             gpointer opaque)
+static void migration_tls_outgoing_handshake_main(QIOTask *task,
+                                                  gpointer opaque)
 {
     MigrationState *s = opaque;
     QIOChannel *ioc = QIO_CHANNEL(qio_task_get_source(task));
     Error *err = NULL;
 
     if (qio_task_propagate_error(task, &err)) {
-        trace_migration_tls_outgoing_handshake_error(error_get_pretty(err));
+        trace_migration_tls_outgoing_handshake_main_error(
+            error_get_pretty(err));
     } else {
-        trace_migration_tls_outgoing_handshake_complete();
+        trace_migration_tls_outgoing_handshake_main_complete();
     }
     migration_channel_connect(s, ioc, NULL, err);
     object_unref(OBJECT(ioc));
@@ -133,10 +134,8 @@ QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
     return qio_channel_tls_new_client(ioc, creds, hostname, errp);
 }
 
-void migration_tls_channel_connect(MigrationState *s,
-                                   QIOChannel *ioc,
-                                   const char *hostname,
-                                   Error **errp)
+void migration_tls_channel_connect_main(MigrationState *s, QIOChannel *ioc,
+                                        const char *hostname, Error **errp)
 {
     QIOChannelTLS *tioc;
 
@@ -147,13 +146,10 @@ void migration_tls_channel_connect(MigrationState *s,
 
     /* Save hostname into MigrationState for handshake */
     s->hostname = g_strdup(hostname);
-    trace_migration_tls_outgoing_handshake_start(hostname);
+    trace_migration_tls_outgoing_handshake_main_start(hostname);
     qio_channel_set_name(QIO_CHANNEL(tioc), "migration-tls-outgoing");
-    qio_channel_tls_handshake(tioc,
-                              migration_tls_outgoing_handshake,
-                              s,
-                              NULL,
-                              NULL);
+    qio_channel_tls_handshake(tioc, migration_tls_outgoing_handshake_main, s,
+                              NULL, NULL);
 }
 
 bool migrate_channel_requires_tls_upgrade(QIOChannel *ioc)
diff --git a/migration/trace-events b/migration/trace-events
index de4a743c8a..9448b5cedf 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -325,9 +325,9 @@ migration_socket_outgoing_connected(const char *hostname) "hostname=%s"
 migration_socket_outgoing_error(const char *err) "error=%s"
 
 # tls.c
-migration_tls_outgoing_handshake_start(const char *hostname) "hostname=%s"
-migration_tls_outgoing_handshake_error(const char *err) "err=%s"
-migration_tls_outgoing_handshake_complete(void) ""
+migration_tls_outgoing_handshake_main_start(const char *hostname) "hostname=%s"
+migration_tls_outgoing_handshake_main_error(const char *err) "err=%s"
+migration_tls_outgoing_handshake_main_complete(void) ""
 migration_tls_incoming_handshake_start(void) ""
 migration_tls_incoming_handshake_error(const char *err) "err=%s"
 migration_tls_incoming_handshake_complete(void) ""
-- 
2.26.3


