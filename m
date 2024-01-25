Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A93AFC47422
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 16:28:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT2YH-0002Jj-9h; Thu, 25 Jan 2024 11:26:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rT2YB-0002IK-Cg
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:26:01 -0500
Received: from mail-dm6nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2417::601]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rT2Y9-0000S7-8z
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:25:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGVd+R4XhPacREgncJNYaPPNxwLSazmFqXUlJgh2Z3FZ3ft3jQWG4oa2NzGyWsuC/fYRriUzv1Zfzvu9hY6SQsgXIFsieJ8oqSpvMG4BpkYx2pRPEM3voTRugIjw9+QRYz12M9rP0jeebMFCGLTDmO7M+1yOIegWtdGCRGX6wv+W+MToNlAGBDXUeRETKy271S0DsAOHZl/GCGsiuP0J7eTW9AxKhjqYDPWUCA6jxifKulnHNWtiPu6abJtKyHFGDOqEymbn6naTYjd1xeOLUlZDfbvzkKu/rfaC1EDgSNiUqo0XKPJaQ/ngMmTjoFaBbBkA89uwvbu8QXPVmSmN4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOBoAuPIPr0iAOOSL33M1VQMH4Og0kQkA7oL4NQJ4D0=;
 b=dpo1bwltT3dmmBAoYCY657k96wDDjahSomB/uUAMB3iLjlcAa0JxektPRUe4SYoNO0wvD+6ZrLTex+JhMi3OszfCKYgcaejR/cFDFeUVi9zwPMPLwo9K7yNmSYppdN3PdD+mDHfzZm67Tc7MjNJWrmeuwE/FmgIo51Cpf9/qW3cKZCCRNIoIgp6Zl8Rmsc+kfs79NK0jYFW6GqhpzVIvjT5lQUvbggOnXTFdMPEJOybk1FyuenUHwJ+cNnMISamUi/A3mdm6/+LxPdLirH5xJXtoQNQzdyeUyWx46vjQKk9sLENiQS2+W9VoMAqhGaA2uYjqumK8zu00uoNIZeIdpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOBoAuPIPr0iAOOSL33M1VQMH4Og0kQkA7oL4NQJ4D0=;
 b=K3YUNTiDktx4lgKIMU9oNiMbdBXQsQfbrngOF5xmaJkKLnaG1sd1eoVSwJhe5iiflKb39a2ASXwKcuyLy1li2pVVRB8b2pntnK+2c3nYEp0vMJ3BD0sQ7DUMoTdYRREkNSNhiKFoQcwdtiVlr2XIeAIze7MN5o1ycjsLscxbpBj7XBGr/kVsdcj2NNJ2iTpmyv3P4cl5rVXeog5GaeKhvRBXZWVsbdizwSMWEe2duFy81Og5QIInT4rjBbewQsZbW3WyBvGkqZpTKY4zzccrQq2bAS4LQ+ayjHkpJjm6KpavPbhvTfM6eFutpq46g6R3LtgmEW1wDhwWQPd6U9verg==
Received: from DM5PR07CA0053.namprd07.prod.outlook.com (2603:10b6:4:ad::18) by
 DS0PR12MB7928.namprd12.prod.outlook.com (2603:10b6:8:14c::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.22; Thu, 25 Jan 2024 16:25:53 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:4:ad:cafe::4d) by DM5PR07CA0053.outlook.office365.com
 (2603:10b6:4:ad::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26 via Frontend
 Transport; Thu, 25 Jan 2024 16:25:53 +0000
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
 15.20.7228.16 via Frontend Transport; Thu, 25 Jan 2024 16:25:53 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 25 Jan
 2024 08:25:42 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 25 Jan 2024 08:25:42 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport;
 Thu, 25 Jan 2024 08:25:41 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, "Avihai
 Horon" <avihaih@nvidia.com>
Subject: [PATCH 07/17] migration/tls: Add new migration channel TLS upgrade API
Date: Thu, 25 Jan 2024 18:25:18 +0200
Message-ID: <20240125162528.7552-8-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20240125162528.7552-1-avihaih@nvidia.com>
References: <20240125162528.7552-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|DS0PR12MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: 111fdf6d-2e16-4e25-49d5-08dc1dc24d39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UJ52HQPm7K8H7YRIIvjKjQAeGabx0DCJVs5unBM+vPq2bPfbqkEbSrRjj00yh5qlzWECM9aWkpiqnMerVnGK1nOPI9iDkIc78T0a4YgBbksEve3FhHx8zalPKC3UxsoqC/X4VTHmZmywr87qj7PDv833Is1h1PjAdLKxxSq04xN1Cm5x5soKEVldWH7kwQ8jXLEqn+tmw8WrCdrFRytVQRsjvhjA5PRMpcvcWgUYSL0t5fJUSpcFZT9DaKv6X0C0n+jGTi3ot5YBP7uKoqhZ96hNiR4PV6wZIv9hXYRvtJ2t18GTO8gkgKrVEXBnIn72qyAF5qMJqEF8JIILju2A3owHyIWI2NURVv6eLGAxe9mzV/mPiUBrBygmdme5CWSPZyJz4R07J93VA3IIN8C07pD5U+ywg5bbe8W6yrFAGYkzupiTgor6CvIbFCUnZb4WG5PkTC4nWymMooiuCDrRd5VfuJf6RgdIZgH2vOc5/qu6TlyCYDUktKkqRgoCYWUkXcA2kKjv0vDD7uEWiStY1tWxqzJTjMmBTkLo8OczKWMauYW8m8I3+WuED1eqSbLJzqaACka4EkDjL7HXL5G2ww99pKVK7hjesw4kLVnwuLOXeAF4X39Z5PtL4LO4aCHUTOvYPWmvMIJYx+30QsWoCrjWyvyI5aQjoehQxX63I0gEoQ3bnUbKMPtSaJOftBLn7TR/DiXpxDfgecB5/seQ1NzeUb9mDdYuGG6FpMIirCU=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(82310400011)(64100799003)(1800799012)(451199024)(186009)(46966006)(36840700001)(40470700004)(336012)(83380400001)(47076005)(426003)(36860700001)(1076003)(26005)(2616005)(107886003)(8676002)(82740400003)(4326008)(5660300002)(8936002)(6916009)(70586007)(70206006)(7696005)(2906002)(478600001)(316002)(54906003)(7636003)(6666004)(41300700001)(356005)(36756003)(86362001)(40460700003)(40480700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 16:25:53.4666 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 111fdf6d-2e16-4e25-49d5-08dc1dc24d39
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7928
Received-SPF: softfail client-ip=2a01:111:f403:2417::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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

Main migration channel, multifd channels and postcopy preempt channel
use the QIOChannelTLS API to upgrade their channels to TLS when needed.

Each of them has its own code to create a QIOChannelTLS and to perform
the TLS handshake. Some of this code is duplicate and can be avoided.

Add a new API to TLS upgrade migration channels. This will make the code
clearer and avoid duplicate code such as TLS handshake, trace handling
and threading.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/tls.h        | 27 ++++++++++++++++
 migration/tls.c        | 72 ++++++++++++++++++++++++++++++++++++++++++
 migration/trace-events |  3 ++
 3 files changed, 102 insertions(+)

diff --git a/migration/tls.h b/migration/tls.h
index 5435dd4867..514529ff38 100644
--- a/migration/tls.h
+++ b/migration/tls.h
@@ -35,6 +35,33 @@ QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
 void migration_tls_channel_connect_main(MigrationState *s, QIOChannel *ioc,
                                         const char *hostname, Error **errp);
 
+typedef void (*MigTLSConCallback)(QIOChannel *ioc, void *opaque, Error *err);
+
+/**
+ * migration_tls_channel_connect:
+ * @ioc: The underlying channel object
+ * @name: The name of the channel
+ * @hostname: The user specified server hostname
+ * @callback: The callback to invoke when completed
+ * @opaque: Opaque data to pass to @callback
+ * @run_in_thread: Whether to run TLS handshake in new thread or not
+ * @errp: Pointer to a NULL-initialized error object pointer
+ *
+ * Establishes a TLS connection on top of the provided QIOChannel @ioc. If this
+ * function succeeds, @callback will be invoked upon completion and
+ * success/failure will be reported to it via the Error object argument.
+ * In case multiple channels are TLS upgraded in parallel, @run_in_thread
+ * should be set to true so the TLS handshake will be performed in a new
+ * thread, to avoid a potential risk of migration hang.
+ *
+ * Returns: True on successful initiation of TLS upgrade process, or false on
+ * failure.
+ */
+bool migration_tls_channel_connect(QIOChannel *ioc, const char *name,
+                                   const char *hostname,
+                                   MigTLSConCallback callback, void *opaque,
+                                   bool run_in_thread, Error **errp);
+
 /* Whether the QIO channel requires further TLS handshake? */
 bool migrate_channel_requires_tls_upgrade(QIOChannel *ioc);
 
diff --git a/migration/tls.c b/migration/tls.c
index 803cb54c8b..e6a0349bd1 100644
--- a/migration/tls.c
+++ b/migration/tls.c
@@ -152,6 +152,78 @@ void migration_tls_channel_connect_main(MigrationState *s, QIOChannel *ioc,
                               NULL, NULL);
 }
 
+typedef struct {
+    QIOChannelTLS *tioc;
+    MigTLSConCallback callback;
+    void *opaque;
+    char *name;
+    QemuThread thread;
+} MigTLSConData;
+
+static void migration_tls_outgoing_handshake(QIOTask *task, void *opaque)
+{
+    QIOChannel *ioc = QIO_CHANNEL(qio_task_get_source(task));
+    MigTLSConData *data = opaque;
+    Error *err = NULL;
+
+    if (qio_task_propagate_error(task, &err)) {
+        trace_migration_tls_outgoing_handshake_error(data->name,
+                                                     error_get_pretty(err));
+    } else {
+        trace_migration_tls_outgoing_handshake_complete(data->name);
+    }
+
+    data->callback(ioc, data->opaque, err);
+    g_free(data->name);
+    g_free(data);
+}
+
+static void *migration_tls_channel_connect_thread(void *opaque)
+{
+    MigTLSConData *data = opaque;
+
+    qio_channel_tls_handshake(data->tioc, migration_tls_outgoing_handshake,
+                              data, NULL, NULL);
+    return NULL;
+}
+
+bool migration_tls_channel_connect(QIOChannel *ioc, const char *name,
+                                   const char *hostname,
+                                   MigTLSConCallback callback, void *opaque,
+                                   bool run_in_thread, Error **errp)
+{
+    QIOChannelTLS *tioc;
+    MigTLSConData *data;
+    g_autofree char *channel_name = NULL;
+    g_autofree char *thread_name = NULL;
+
+    tioc = migration_tls_client_create(ioc, hostname, errp);
+    if (!tioc) {
+        return false;
+    }
+
+    data = g_new0(MigTLSConData, 1);
+    data->tioc = tioc;
+    data->callback = callback;
+    data->opaque = opaque;
+    data->name = g_strdup(name);
+
+    trace_migration_tls_outgoing_handshake_start(hostname, name);
+    channel_name = g_strdup_printf("migration-tls-outgoing-%s", name);
+    qio_channel_set_name(QIO_CHANNEL(tioc), channel_name);
+    if (!run_in_thread) {
+        qio_channel_tls_handshake(tioc, migration_tls_outgoing_handshake, data,
+                                  NULL, NULL);
+        return true;
+    }
+
+    thread_name = g_strdup_printf("migration-tls-outgoing-worker-%s", name);
+    qemu_thread_create(&data->thread, thread_name,
+                       migration_tls_channel_connect_thread, data,
+                       QEMU_THREAD_JOINABLE);
+    return true;
+}
+
 bool migrate_channel_requires_tls_upgrade(QIOChannel *ioc)
 {
     if (!migrate_tls()) {
diff --git a/migration/trace-events b/migration/trace-events
index 9448b5cedf..09dd342d37 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -328,6 +328,9 @@ migration_socket_outgoing_error(const char *err) "error=%s"
 migration_tls_outgoing_handshake_main_start(const char *hostname) "hostname=%s"
 migration_tls_outgoing_handshake_main_error(const char *err) "err=%s"
 migration_tls_outgoing_handshake_main_complete(void) ""
+migration_tls_outgoing_handshake_start(const char *hostname, const char *name) "hostname=%s, name=%s"
+migration_tls_outgoing_handshake_error(const char *name, const char *err) "name=%s, err=%s"
+migration_tls_outgoing_handshake_complete(const char *name) "name=%s"
 migration_tls_incoming_handshake_start(void) ""
 migration_tls_incoming_handshake_error(const char *err) "err=%s"
 migration_tls_incoming_handshake_complete(void) ""
-- 
2.26.3


