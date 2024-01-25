Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F425C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 16:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT2YW-0002Qj-Ob; Thu, 25 Jan 2024 11:26:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rT2YT-0002Q0-Bm
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:26:17 -0500
Received: from mail-mw2nam10on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2412::600]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rT2YR-0000Vu-AW
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:26:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+P9D87BJMVCV5VvmGHth2kacmnZKz4B5vkZKFJHFv+nj04LMKzlYbk3lUcp5RRxaLUN16CRAsVGljp68yIUQqpci+03GLqaYamQPv5y5lxGQEfJAXqZ5vazrTlTa26LCH1HVxDPk9fHBohntvtUiapqCWUdm7sZMeKZdkRwHsWXVsCi3UbsDS9EWXr5FqToaKIp8um87UmgRQSIahP85CBi7JDiUAhc1oz0SkPVK5dXd7/WqFT3LduKj01toJP9lmA+WSitns/0I/vCDQYT+ZzMPp5kbMZrXz777nOrSHowGd5q1j2samiE5dEVw2ePz+LpYBgVeXvVGjeQpWr22A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjNWe7F7zYwdGDQLM6D4PmBiqb0D5XI8XKeekITtisQ=;
 b=Qz8fQZRpjfri7P8L0GyKnKRHbUb6rVTQ/9agStYgBwFUx5kP3Ti1ZEPEF29x5sPH7Q3fQgzLNSdKXiA3Z/LzvMz96L0Ocvl/WQonNEzja7f/3cesosuL1eV7eeB1J0S/3NOTwRjg0vtGcebYxuxMsVrMJ0I/pu4s8FkeuY1E6f7a5FJLUYBy57kUljKXq3imWIY4TCY166AXmRcx+ZVrXknBXDPyoHgoR8HZmoHmkCYZyvlEazt/6UCozvBGgpnUXzqB87k9aCdtdS867HyQzjqD2U+wR8YtN20kwvceRZr20DlrqFKUrsFncNw80IF7OnY7rxfxil6uoRTtu+an/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjNWe7F7zYwdGDQLM6D4PmBiqb0D5XI8XKeekITtisQ=;
 b=sJ+jJzcN0ZXyLwLjd3OQcN0ThTNaQlSi1UllBoFd35JmB2XlhZmT297L+JklwPwdZE9psqW6bPVhzUY+bUhInazQ9+H4NdoFdBMo9tHnLeiGGyGRZHA+KmOl+n65WNFH4HjB95yxNqUHBDXq/QSVgON5kf30E6+E/AKsN/Z0NnASgmILK087AR6wAiwDf/w7bC/7b4TeE6YMrwQsN/wUGgZKQ3zGkYTRwaotOuS4rRtuTO2N2h/guH5Tn4hca9m98DC3k4j4wREJUR8aXWoeRYcexAqeysQkieTxv9rDkDEq8KhUS6/cSqJORLKMV7JkoTrFQ+Qs8NsFPN23nYh3ng==
Received: from DM6PR05CA0045.namprd05.prod.outlook.com (2603:10b6:5:335::14)
 by PH8PR12MB6771.namprd12.prod.outlook.com (2603:10b6:510:1c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 16:26:07 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:335:cafe::4b) by DM6PR05CA0045.outlook.office365.com
 (2603:10b6:5:335::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.10 via Frontend
 Transport; Thu, 25 Jan 2024 16:26:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Thu, 25 Jan 2024 16:26:07 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 25 Jan
 2024 08:25:56 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 25 Jan 2024 08:25:56 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport;
 Thu, 25 Jan 2024 08:25:54 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, "Avihai
 Horon" <avihaih@nvidia.com>
Subject: [PATCH 15/17] migration: Add new migration channel connect API
Date: Thu, 25 Jan 2024 18:25:26 +0200
Message-ID: <20240125162528.7552-16-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20240125162528.7552-1-avihaih@nvidia.com>
References: <20240125162528.7552-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|PH8PR12MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: 1112b9a6-65c2-47a8-d35e-08dc1dc25557
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V4fKYh6thyY7XM6jYVg9mBISKYRFbHvMn/6T9WGHMXFCFFuln9hBu15CsOfByFo5O977dGp7Nvo6qiwFM4mV4lxdeIQrwhH8ghE6PknhO0mgqwZyPcfPySsFrouCdwAB9ynN2IB90nv/gNu9AFZWBUltVoSNt6g7gMg5Rz5mjlib8l1AhznVFNeCrTlfpIOnmqJVkRcp2XkMFkqDjoz0KWFhX3lIxQ+psgEu40i28UydE76Z/RmP4uXPfHoJhbaNQWIE8rKjy2sZgLz+u/TS1UI8CXL/KucCvAXvLSymQKEHbIMrsz5jVJMzL4Z5dRcY70/0MVZiUbMUwOVQilu5LtkaoQ+Vqd5xNIAlUQO/Vec+DuQ+wbipgvivEveOSwbyE8Vz8TOXEy/eligAdHUpZcipWff2K+JbpxJ0ydoCGofmycCYL11Gyr37byC9gaq6hpYfjYAx7/o4baqYyffYiRN5IXn0OQwTmsrbf69u8txG+lmHY9Y03x3n9Xx61iSh65KiMGZ/FtJMjePsuLAajwPKBNHtxkTJ9M+XIkBF24bQk+YMUUyYDyTWGQohtul+Rq73VJ/UvHYv56uSGmm0nbBNZUl1FPO8eou51ql4P6SGXmZJPnzeD/wN3344ng40dGxgOgX7SPVy/OBayRjdlLmesVRF0cfM1HfQfQeXuAqXONP6j42GpINvimx4xvK719notp4Te6JEXGdcfGqitpeq06teYWXsvdllP8jBrDghirlKD70an/KP0OKDKjpB
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(82310400011)(36840700001)(46966006)(40470700004)(41300700001)(336012)(426003)(107886003)(1076003)(26005)(40480700001)(40460700003)(36756003)(478600001)(47076005)(36860700001)(82740400003)(6666004)(7696005)(2616005)(83380400001)(7636003)(356005)(70206006)(70586007)(5660300002)(6916009)(86362001)(2906002)(54906003)(316002)(66899024)(4326008)(8676002)(8936002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 16:26:07.1041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1112b9a6-65c2-47a8-d35e-08dc1dc25557
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6771
Received-SPF: softfail client-ip=2a01:111:f403:2412::600;
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

Add a new API to connect additional migration channels other than the
main migration channel. This API removes the burden of handling the
transport type and TLS upgrade logic, and thus simplifies migration
channel connection.

It will be used in the next patches to connect multifd and postcopy
preempt channels.

Export migration_channels_and_transport_compatible() as now it is also
used outside of migration.c.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/channel.h    | 24 ++++++++++++++
 migration/migration.h  |  2 ++
 migration/channel.c    | 74 ++++++++++++++++++++++++++++++++++++++++++
 migration/migration.c  |  5 ++-
 migration/trace-events |  3 ++
 5 files changed, 105 insertions(+), 3 deletions(-)

diff --git a/migration/channel.h b/migration/channel.h
index 1e36bdd866..f0fa94ad9e 100644
--- a/migration/channel.h
+++ b/migration/channel.h
@@ -27,4 +27,28 @@ int migration_channel_read_peek(QIOChannel *ioc,
                                 const char *buf,
                                 const size_t buflen,
                                 Error **errp);
+
+typedef void (*MigChannelCallback)(QIOChannel *ioc, void *opaque, Error *err);
+
+/**
+ * migration_channel_connect:
+ * @callback: The callback to invoke when completed
+ * @name: The name of the channel
+ * @opaque: Opaque data to pass to @callback
+ * @tls_in_thread: Whether to run TLS handshake in new thread or not (if TLS is
+ *                 needed).
+ * @errp: Pointer to a NULL-initialized error object pointer
+ *
+ * Establishes a new migration channel and TLS upgrades it if needed. If this
+ * function succeeds, @callback will be invoked upon completion and
+ * success/failure will be reported to it via the Error object.
+ * In case multiple channels are established in parallel, @tls_in_thread should
+ * be set to true so the TLS handshake will be performed in a new thread, to
+ * avoid a potential risk of migration hang.
+ *
+ * Returns: True on successful initiation of channel establishment process, or
+ * false on failure.
+ */
+bool migration_channel_connect(MigChannelCallback callback, const char *name,
+                               void *opaque, bool tls_in_thread, Error **errp);
 #endif
diff --git a/migration/migration.h b/migration/migration.h
index dc370ab3e8..52b340e00b 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -523,6 +523,8 @@ bool check_dirty_bitmap_mig_alias_map(const BitmapMigrationNodeAliasList *bbm,
 void migrate_add_address(SocketAddress *address);
 bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
                        Error **errp);
+bool migration_channels_and_transport_compatible(MigrationAddress *addr,
+                                                 Error **errp);
 int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque);
 
 #define qemu_ram_foreach_block \
diff --git a/migration/channel.c b/migration/channel.c
index c1f7c6d556..741974279f 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -21,6 +21,7 @@
 #include "io/channel-socket.h"
 #include "qemu/yank.h"
 #include "yank_functions.h"
+#include "socket.h"
 
 /**
  * @migration_channel_process_incoming - Create new incoming migration channel
@@ -101,6 +102,79 @@ void migration_channel_connect_main(MigrationState *s, QIOChannel *ioc,
     error_free(error);
 }
 
+typedef struct {
+    MigChannelCallback callback;
+    void *opaque;
+    char *name;
+    bool tls_in_thread;
+} MigChannelData;
+
+static void migration_channel_connect_tls_handshake(QIOChannel *ioc,
+                                                    void *opaque, Error *err)
+{
+    MigChannelData *data = opaque;
+
+    data->callback(ioc, data->opaque, err);
+    g_free(data->name);
+    g_free(data);
+}
+
+static void migration_channel_connect_callback(QIOTask *task, void *opaque)
+{
+    QIOChannel *ioc = QIO_CHANNEL(qio_task_get_source(task));
+    MigChannelData *data = opaque;
+    MigrationState *s = migrate_get_current();
+    Error *err = NULL;
+
+    if (qio_task_propagate_error(task, &err)) {
+        trace_migration_channel_connect_error(data->name,
+                                              error_get_pretty(err));
+        goto out;
+    }
+
+    trace_migration_channel_connect_complete(data->name);
+    if (!migrate_channel_requires_tls_upgrade(ioc)) {
+        goto out;
+    }
+
+    if (migration_tls_channel_connect(ioc, data->name, s->hostname,
+                                      migration_channel_connect_tls_handshake,
+                                      data, data->tls_in_thread, &err)) {
+        object_unref(OBJECT(ioc));
+        /* data->callback will be invoked after handshake */
+        return;
+    }
+
+out:
+    data->callback(ioc, data->opaque, err);
+    g_free(data->name);
+    g_free(data);
+}
+
+bool migration_channel_connect(MigChannelCallback callback, const char *name,
+                               void *opaque, bool tls_in_thread, Error **errp)
+{
+    MigrationState *s = migrate_get_current();
+    MigChannelData *data;
+
+    g_assert(s->address);
+    g_assert(migration_channels_and_transport_compatible(s->address, NULL));
+
+    data = g_new0(MigChannelData, 1);
+    data->callback = callback;
+    data->opaque = opaque;
+    data->name = g_strdup(name);
+    data->tls_in_thread = tls_in_thread;
+
+    trace_migration_channel_connect_start(s->hostname, name);
+    /*
+     * Currently, creating migration channels other than main channel is
+     * supported only with socket transport.
+     */
+    socket_send_channel_create(migration_channel_connect_callback, data);
+
+    return true;
+}
 
 /**
  * @migration_channel_read_peek - Peek at migration channel, without
diff --git a/migration/migration.c b/migration/migration.c
index deaa79ff14..6f985e7f74 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -141,9 +141,8 @@ static bool transport_supports_multi_channels(MigrationAddress *addr)
     return false;
 }
 
-static bool
-migration_channels_and_transport_compatible(MigrationAddress *addr,
-                                            Error **errp)
+bool migration_channels_and_transport_compatible(MigrationAddress *addr,
+                                                 Error **errp)
 {
     if (migration_needs_multiple_sockets() &&
         !transport_supports_multi_channels(addr)) {
diff --git a/migration/trace-events b/migration/trace-events
index 9a8ec67115..6c915d8567 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -195,6 +195,9 @@ migration_transferred_bytes(uint64_t qemu_file, uint64_t multifd, uint64_t rdma)
 # channel.c
 migration_set_incoming_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
 migration_set_outgoing_channel(void *ioc, const char *ioctype, const char *hostname, void *err)  "ioc=%p ioctype=%s hostname=%s err=%p"
+migration_channel_connect_start(const char *hostname, const char *name) "hostname=%s, name=%s"
+migration_channel_connect_error(const char *name, const char *err) "name=%s, err=%s"
+migration_channel_connect_complete(const char *name) "name=%s"
 
 # global_state.c
 migrate_state_too_big(void) ""
-- 
2.26.3


