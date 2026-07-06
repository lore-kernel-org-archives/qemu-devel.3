Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84991C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgf69-0001Oy-3y; Mon, 06 Jul 2026 04:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wgf65-0001CY-5G
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:54:38 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wgf61-00073j-Ib
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:54:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CaMKDJtYOsn3Np7nvHL5tIUMkOlrJGiEcHaTAv59f7itXZgJanuihrDQ0mcI7m6ImAwBxEg0W3xZVntHsn/jGWbB6tU6QB04iMQ4uXI9eT0W1NoH+2OaOgZhDbQjUz+ckbpWxJSHSay81JruYfJnG9RNm0lpxMZGcgvCmYJWwUORQCqt/hmysfXevUfMV22f1M/fangPbH/0kcVcwPBSThnkSp8HUwH69pvW5MuO+AK7SiCssOYQ+rAtO3d03SBWV8uA4ajdspd1fx7b9H9FDmhGqHbhnJvBaWYb873tXaQswooxwzlf7DJKlhdq3y1ZzVXFhrVNJlDdWu0XaBS2cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aBBIGt3h+uziVhLIRHcrhjNCVufOCyAEoG3/IzvQeoY=;
 b=lnO90kdpXeAULZWmb0kMFQsE0FD4YNqVYVx0645IfqRc/k6blnNgZpQXWbTyFUTkVGO6pfg/vFHRA18uSum1F4I6QrrphQF1nnpJcnJiwEJ2whoosYeQDuAyDFh+Q6Ez6EruW6tkoTiSDyqjsO2B4E11vYQNmLMi95Wnm6OWSQs5t/eQKhb3salpl03J8fuO2Np2HJWO6oTzoqgi1M/sbhObXSzFMPFczNhMG4VwvhEdRuVFZt/xgwCbbwTfLOeMkoJSSaLu+V3HvEqyKqjtfN4Nx3fKDpJV/zcmbNNbyqG+GLdaxpadxNTxYF6AjBysRuzO2IPXZXW400YIKlxEIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBBIGt3h+uziVhLIRHcrhjNCVufOCyAEoG3/IzvQeoY=;
 b=LWRJLbOxd9WCc5j6uzsJns/Qi/VLlkUUlG1aHn2m/Drmz0a5tCoVw4znK+6chUYQE8aXCzSZdNS94/Cbmvp4XdQhROcd1cDE4DNJoUsZFdIeEYewgXcRUJKUdh/pr8bdpWph55gIddpRMzP/vHdg7x12WzPQjYk0P6/x9tuQ5c6NZ07TCZallL1C2Jaq4LgBnmcgXLVRKop/00s+Z0JO2hKnCT7wjBXqCbf3OVDeGrDtMYZv+6ZOsh21WXIBrW71m8YVP/tE94ZoTXqvx0ikKK9ixifXNcwPAUkgW49VgRxH5Ge3eUOEmhMGmclZG4LNKN1NXghRpiRc1JRNtihHCA==
Received: from CH0PR03CA0265.namprd03.prod.outlook.com (2603:10b6:610:e5::30)
 by MW4PR12MB7431.namprd12.prod.outlook.com (2603:10b6:303:225::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 08:54:23 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::10) by CH0PR03CA0265.outlook.office365.com
 (2603:10b6:610:e5::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 08:54:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 08:54:22 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 01:54:10 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 01:54:09 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 6 Jul
 2026 01:54:03 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex@shazbot.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>, Zhao Liu
 <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, Jason Herne
 <jjherne@linux.ibm.com>, Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 "Cornelia Huck" <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Vladimir Sementsov-Ogievskiy" <vsementsov@yandex-team.ru>, John Snow
 <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Lukas Straub
 <lukasstraub2@web.de>, Maor Gottlieb <maorg@nvidia.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH v5 07/16] migration: Make switchover-ack re-usable
Date: Mon, 6 Jul 2026 11:52:02 +0300
Message-ID: <20260706085211.13905-8-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260706085211.13905-1-avihaih@nvidia.com>
References: <20260706085211.13905-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|MW4PR12MB7431:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a1ee5d2-0c8b-4bfd-6701-08dedb3c2cce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|23010399003|56012099006|5023799004|11063799006|6133799003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 7HHjpxI97PtWWad2ws4XAuqiEb0g9zRxseELmsTd7GUvtgnBaH0WFfw/ZdzPj6e6UJsvr0VovZjBI2s2saiFN8FgLNvby9jzrHkrmDTJSukLaixI4XMiVmcTY2pt0lQJCMVP0eAyXIJiP+u68oNJxasnbgpBUg/lijch3lNGFx+X15I+eREeJ4WBlj151HHlwK8hEqa5AVvBS/GOblk7TGpSojjk/e7+bbwnNpqeseiUtWf8gCdrq2TEdlsQzTwoubvwvjKtN7azaXi3DNUHSpKPlAigtVWZ8B/13UXdW1E94VEyplOiqHClp64kwcdFg1oeQZegXlI99RQcsVr65CgBzRKqaAoMfbu3J6Oz2gHkM8wtQ74lDC4quKFgTcsa8GX00+lIoPibZhl82XDqcG6ZDt3TSTK5f5yKMmz5UBySfLFrlUvrr2MeveXDJj4Wvji+Hr8KjnwFZRHj+ZQO0CCei6G8XmiWCxo/Eymaf/euB55SnDdaM8IVy/NMyv+b5SZHmNKIgapD/6yaW/OFJ+16lgqMh9zBTinci5cXRchTbHqacFvkaWcviKyFx87g6l/Rh06zfuzU7obg6xTgyp8+hHTMaIF7f9ucrynfmdRIf/6jg5fsr/D5+vwQMaWL7rXceS/hRKbWYY1zsKrXjlEU7Tl7kYGHRb9/UCCYetWorIHI825bVN829PwV9CK9yGtAMPeoUdojOpKHgt26wA==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(23010399003)(56012099006)(5023799004)(11063799006)(6133799003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ttZtceQ+FgeW9H/HOwAimZEA7HFjRU2sSKTFpCOcXp/O5s3Cg91j3B/yEDS8bg/O3kpocz14EuCXmpEFQsa1pkaMdvVviGxfL5fOi9GDOkDODAXhuPdRbJDw6HTrERztn9oGuCFGVxbdj3zoaQmwNPkNLXBhHvg72m0yTMnArMfItq2D19mNHfwt478csIzhNbzagnityR+p6C8ySUI4mJj5izRzTUsVldYFWIEBlVow0wSv14rQFzBWWMlYBJ3G+IrVyh5Pf2IFWc6ceMK4kJKKfH8cbRhXX76RhZlmwNJhfOY3uR9co6167/flQ7HORH54ZAryeWGJkfP47WR5rxF3PYBkxTdAworapJFOQ4JPuJMHyxpxu/ZGoGa02Nq8FUWQ4s7GYrAEBYy/jIBDB1Vl2J2ZBAHBnvnkg3dduyM+gekSB9QXopg8fuRfKCgj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 08:54:22.7852 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1ee5d2-0c8b-4bfd-6701-08dedb3c2cce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7431
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=avihaih@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Switchover-ack is a mechanism to synchronize between source and
destination QEMU during migration to prevent the source from switching
over prematurely.

VFIO uses switchover-ack to ensure switchover happens only after
destination side has loaded the precopy initial bytes. This is important
for VFIO, as otherwise downtime could be impacted and be higher.

In its current state, switchover-ack is a one-time mechanism, meaning
that switchover is acked only once and past that another ACK cannot be
requested again. This was sufficient until now, as VFIO precopy initial
bytes was defined to be monotonically decreasing. Thus, when precopy
initial bytes reached zero for all VFIO devices, a single ACK would be
sent and its validity would hold.

However, now the new VFIO_PRECOPY_INFO_REINIT feature allows precopy
initial bytes to be re-initialized during precopy. Specifically, it
means that initial bytes can grow after reaching zero, which would
invalidate a previously sent switchover ACK.

To solve this, make switchover-ack reusable and allow devices to request
switchover ACKs when needed via the save_query_pending SaveVMHandler.

Since now switchover ACK can be requested for a specific device and in
different times, make switchover ACK per-device (instead of a single ACK
for all devices) and let source side do the pending ACKs accounting.

Keep the legacy switchover-ack mechanism for backward compatibility and
turn it on by a compatibility property for older machines. Enable the
property until VFIO implements the new switchover-ack.

Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 qapi/migration.json                | 14 ++++----
 include/migration/client-options.h |  1 +
 include/migration/register.h       |  2 ++
 migration/migration.h              | 32 ++++++++++++++++--
 migration/savevm.h                 |  6 ++--
 migration/colo.c                   |  2 +-
 migration/migration.c              | 37 ++++++++++++++-------
 migration/options.c                | 10 ++++++
 migration/savevm.c                 | 53 +++++++++++++++++++++++-------
 migration/trace-events             |  5 +--
 10 files changed, 124 insertions(+), 38 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index e8756308cf..d2f42c4b0f 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -508,14 +508,12 @@
 #     (since 7.1)
 #
 # @switchover-ack: If enabled, migration will not stop the source VM
-#     and complete the migration until an ACK is received from the
-#     destination that it's OK to do so.  Exactly when this ACK is
-#     sent depends on the migrated devices that use this feature.  For
-#     example, a device can use it to make sure some of its data is
-#     sent and loaded in the destination before doing switchover.
-#     This can reduce downtime if devices that support this capability
-#     are present.  'return-path' capability must be enabled to use
-#     it.  (since 8.1)
+#     and complete the migration until the destination has
+#     acknowledged that it is OK to switchover.  The acknowledgement
+#     may depend, for example, on some device's data being loaded in
+#     the destination before doing switchover.  This can reduce
+#     downtime if devices that support this capability are present.
+#     Capability @return-path must be enabled to use it.  (since 8.1)
 #
 # @dirty-limit: If enabled, migration will throttle vCPUs as needed to
 #     keep their dirty page rate within @vcpu-dirty-limit.  This can
diff --git a/include/migration/client-options.h b/include/migration/client-options.h
index 289c9d7762..78b1daa1a6 100644
--- a/include/migration/client-options.h
+++ b/include/migration/client-options.h
@@ -13,6 +13,7 @@
 
 /* properties */
 bool migrate_send_switchover_start(void);
+bool migrate_switchover_ack_legacy(void);
 
 /* capabilities */
 
diff --git a/include/migration/register.h b/include/migration/register.h
index a61c4236d2..5825eb30cb 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -23,6 +23,8 @@ typedef struct MigPendingData {
     uint64_t postcopy_bytes;
     /* Amount of pending bytes can be transferred only in stopcopy */
     uint64_t stopcopy_bytes;
+    /* Number of new pending switchover ACKs */
+    uint32_t switchover_ack_pending;
     /*
      * Total pending data, modules do not need to update this field, it
      * will be automatically calculated by migration core API.
diff --git a/migration/migration.h b/migration/migration.h
index 570349d858..44bce199cd 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -487,6 +487,29 @@ struct MigrationState {
      */
     uint8_t clear_bitmap_shift;
 
+    /*
+     * This decides whether to use legacy switchover-ack or new switchover-ack.
+     * The main difference between them is that the former allows acknowledging
+     * switchover only once while the latter multiple times.
+     *
+     * In legacy, the destination keeps track of a pending ACKs counter. As
+     * migration progresses, the devices on the destination acknowledge
+     * switchover, decreasing the counter. When the counter reaches zero, a
+     * single ACK message is sent to the source via the return path, indicating
+     * that it's OK to switchover.
+     *
+     * In new switchover-ack, the source is the one that keeps track of a
+     * pending ACKs counter. As migration progresses, the destination sends ACK
+     * message per-device via the return path, which decrements the source
+     * counter. When the counter reaches zero, it's OK to switchover. During
+     * precopy, source-side devices may request additional ACKs, which increment
+     * the counter again.
+     *
+     * In both legacy and new schemes, we rely on per-device protocol to request
+     * switchover ACK from the destination-side counterpart.
+     */
+    bool switchover_ack_legacy;
+
     /*
      * This save hostname when out-going migration starts
      */
@@ -496,10 +519,13 @@ struct MigrationState {
     JSONWriter *vmdesc;
 
     /*
-     * Indicates whether an ACK from the destination that it's OK to do
-     * switchover has been received.
+     * Indicates the number of pending ACKs from the destination. The value may
+     * increase or decrease during precopy as new ACKs are requested or
+     * received. When zero is reached, it's OK to switchover. In legacy
+     * switchover-ack, it's initialized to 1 and decreased to zero upon ACK.
      */
-    bool switchover_acked;
+    uint32_t switchover_ack_pending_num;
+
     /* Is this a rdma migration */
     bool rdma_migration;
 
diff --git a/migration/savevm.h b/migration/savevm.h
index 44424be347..fb92d3bc85 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -45,8 +45,10 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
 void qemu_savevm_state_cleanup(void);
 void qemu_savevm_state_complete_postcopy(QEMUFile *f);
 int qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp);
-void qemu_savevm_query_pending_iter(MigPendingData *pending, bool exact);
-void qemu_savevm_query_pending_final(MigPendingData *pending);
+void qemu_savevm_query_pending_iter(MigrationState *s, MigPendingData *pending,
+                                    bool exact);
+void qemu_savevm_query_pending_final(MigrationState *s,
+                                     MigPendingData *pending);
 int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy);
 bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp);
 void qemu_savevm_state_end(QEMUFile *f);
diff --git a/migration/colo.c b/migration/colo.c
index 08632d5e4a..0cef0f6b0e 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -473,7 +473,7 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
      * state is saved. Unlike a regular switchover, COLO reaches completion
      * repeatedly for every checkpoint, so this must be done on each one.
      */
-    qemu_savevm_query_pending_final(&pending);
+    qemu_savevm_query_pending_final(s, &pending);
 
     /*
      * Only save VM's live state, which not including device state.
diff --git a/migration/migration.c b/migration/migration.c
index 1d3387da0f..2b625da114 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1713,7 +1713,9 @@ int migrate_init(MigrationState *s, Error **errp)
     s->vm_old_state = -1;
     s->iteration_initial_bytes = 0;
     s->threshold_size = 0;
-    s->switchover_acked = false;
+    /* Legacy switchover-ack sends a single ACK for all devices */
+    qatomic_set(&s->switchover_ack_pending_num,
+                migrate_switchover_ack_legacy() ? 1 : 0);
     s->rdma_migration = false;
 
     /*
@@ -2207,7 +2209,7 @@ void migration_request_switchover_ack_legacy(const char *requester)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
 
-    if (!migrate_switchover_ack()) {
+    if (!migrate_switchover_ack() || !migrate_switchover_ack_legacy()) {
         return;
     }
 
@@ -2463,9 +2465,18 @@ static void *source_return_path_thread(void *opaque)
             break;
 
         case MIG_RP_MSG_SWITCHOVER_ACK:
-            ms->switchover_acked = true;
-            trace_source_return_path_thread_switchover_acked();
+        {
+            uint32_t pending_num;
+
+            pending_num = qatomic_dec_fetch(&ms->switchover_ack_pending_num);
+            trace_source_return_path_thread_switchover_acked(pending_num);
+            if (pending_num == UINT32_MAX) {
+                error_setg(&err, "Switchover ack pending num underflowed");
+                goto out;
+            }
+
             break;
+        }
 
         default:
             break;
@@ -2822,7 +2833,7 @@ static bool migration_switchover_start(MigrationState *s, Error **errp)
      * properly update all the dirty bitmaps to finally generate the
      * correct discard bitmaps; see ram_postcopy_send_discard_bitmap().
      */
-    qemu_savevm_query_pending_final(&pending);
+    qemu_savevm_query_pending_final(s, &pending);
 
     /* Inactivate disks except in COLO */
     if (!migrate_colo()) {
@@ -3272,7 +3283,7 @@ static bool migration_can_switchover(MigrationState *s)
         return true;
     }
 
-    return s->switchover_acked;
+    return qatomic_read(&s->switchover_ack_pending_num) == 0;
 }
 
 /* Migration thread iteration status */
@@ -3311,12 +3322,13 @@ static bool migration_iteration_next_ready(MigrationState *s,
     return false;
 }
 
-static void migration_iteration_go_next(MigPendingData *pending)
+static void migration_iteration_go_next(MigrationState *s,
+                                        MigPendingData *pending)
 {
     /*
      * Do a slow sync first before boosting the iteration count.
      */
-    qemu_savevm_query_pending_iter(pending, true);
+    qemu_savevm_query_pending_iter(s, pending, true);
 
     /*
      * Update the dirty information for the whole system for this
@@ -3362,12 +3374,12 @@ static MigIterateState migration_iteration_run(MigrationState *s)
     Error *local_err = NULL;
     bool in_postcopy = (s->state == MIGRATION_STATUS_POSTCOPY_DEVICE ||
                         s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
-    bool can_switchover = migration_can_switchover(s);
+    bool can_switchover;
     MigPendingData pending = { };
     bool complete_ready;
 
     /* Fast path - get the estimated amount of pending data */
-    qemu_savevm_query_pending_iter(&pending, false);
+    qemu_savevm_query_pending_iter(s, &pending, false);
 
     if (in_postcopy) {
         /*
@@ -3408,9 +3420,12 @@ static MigIterateState migration_iteration_run(MigrationState *s)
          * during postcopy phase.
          */
         if (migration_iteration_next_ready(s, &pending)) {
-            migration_iteration_go_next(&pending);
+            migration_iteration_go_next(s, &pending);
         }
 
+        /* Check can switchover after qemu_savevm_query_pending() */
+        can_switchover = migration_can_switchover(s);
+
         /* Should we switch to postcopy now? */
         if (can_switchover && postcopy_should_start(s, &pending)) {
             if (postcopy_start(s, &local_err)) {
diff --git a/migration/options.c b/migration/options.c
index 5cbfd29099..4c9b25372e 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -110,6 +110,9 @@ const Property migration_properties[] = {
                      preempt_pre_7_2, false),
     DEFINE_PROP_BOOL("multifd-clean-tls-termination", MigrationState,
                      multifd_clean_tls_termination, true),
+    /* Use legacy until VFIO implements new switchover-ack */
+    DEFINE_PROP_BOOL("switchover-ack-legacy", MigrationState,
+                     switchover_ack_legacy, true),
 
     /* Migration parameters */
     DEFINE_PROP_UINT8("x-throttle-trigger-threshold", MigrationState,
@@ -467,6 +470,13 @@ bool migrate_rdma(void)
     return s->rdma_migration;
 }
 
+bool migrate_switchover_ack_legacy(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->switchover_ack_legacy;
+}
+
 typedef enum WriteTrackingSupport {
     WT_SUPPORT_UNKNOWN = 0,
     WT_SUPPORT_ABSENT,
diff --git a/migration/savevm.c b/migration/savevm.c
index 804c76e3bd..1f6e696c50 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1801,7 +1801,8 @@ int qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp)
     return 0;
 }
 
-static void qemu_savevm_query_pending(MigPendingData *pending, bool exact,
+static void qemu_savevm_query_pending(MigrationState *s,
+                                      MigPendingData *pending, bool exact,
                                       bool final)
 {
     SaveStateEntry *se;
@@ -1827,22 +1828,35 @@ static void qemu_savevm_query_pending(MigPendingData *pending, bool exact,
      * close to reality when this got invoked frequently while iterating.
      */
     mig_stats.dirty_bytes_total = pending->total_bytes;
-    trace_qemu_savevm_query_pending(exact, final, pending->precopy_bytes,
-                                    pending->stopcopy_bytes,
-                                    pending->postcopy_bytes,
-                                    pending->total_bytes);
+
+    if (migrate_switchover_ack() && !migrate_switchover_ack_legacy() &&
+        pending->switchover_ack_pending) {
+        /*
+         * NOTE: Currently we rely on per-device protocol to request switchover
+         * ACK from the device on the destination side.
+         */
+        qatomic_add(&s->switchover_ack_pending_num,
+                    pending->switchover_ack_pending);
+    }
+
+    trace_qemu_savevm_query_pending(
+        exact, final, pending->precopy_bytes, pending->stopcopy_bytes,
+        pending->postcopy_bytes, pending->total_bytes,
+        pending->switchover_ack_pending,
+        qatomic_read(&s->switchover_ack_pending_num));
 }
 
-void qemu_savevm_query_pending_iter(MigPendingData *pending, bool exact)
+void qemu_savevm_query_pending_iter(MigrationState *s, MigPendingData *pending,
+                                    bool exact)
 {
-    qemu_savevm_query_pending(pending, exact, false);
+    qemu_savevm_query_pending(s, pending, exact, false);
 }
 
-void qemu_savevm_query_pending_final(MigPendingData *pending)
+void qemu_savevm_query_pending_final(MigrationState *s, MigPendingData *pending)
 {
     g_assert(bql_locked());
 
-    qemu_savevm_query_pending(pending, true, true);
+    qemu_savevm_query_pending(s, pending, true, true);
 }
 
 void qemu_savevm_state_cleanup(void)
@@ -2487,7 +2501,7 @@ static int loadvm_switchover_ack_no_users_legacy(MigrationIncomingState *mis,
 {
     int ret;
 
-    if (!migrate_switchover_ack()) {
+    if (!migrate_switchover_ack() || !migrate_switchover_ack_legacy()) {
         return 0;
     }
 
@@ -3169,7 +3183,7 @@ int qemu_load_device_state(QEMUFile *f, Error **errp)
     return 0;
 }
 
-int qemu_loadvm_approve_switchover(const char *approver)
+static int qemu_loadvm_approve_switchover_legacy(const char *approver)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
 
@@ -3188,6 +3202,23 @@ int qemu_loadvm_approve_switchover(const char *approver)
     return migrate_send_rp_switchover_ack(mis);
 }
 
+int qemu_loadvm_approve_switchover(const char *approver)
+{
+    MigrationIncomingState *mis = migration_incoming_get_current();
+
+    if (!migrate_switchover_ack()) {
+        return 0;
+    }
+
+    if (migrate_switchover_ack_legacy()) {
+        return qemu_loadvm_approve_switchover_legacy(approver);
+    }
+
+    trace_loadvm_approve_switchover(approver);
+
+    return migrate_send_rp_switchover_ack(mis);
+}
+
 bool qemu_loadvm_load_state_buffer(const char *idstr, uint32_t instance_id,
                                    char *buf, size_t len, Error **errp)
 {
diff --git a/migration/trace-events b/migration/trace-events
index a6b8c31ee1..f5339f4193 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -7,7 +7,7 @@ qemu_loadvm_state_section_partend(uint32_t section_id) "%u"
 qemu_loadvm_state_post_main(int ret) "%d"
 qemu_loadvm_state_section_startfull(uint32_t section_id, const char *idstr, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
 qemu_savevm_send_packaged(void) ""
-qemu_savevm_query_pending(bool exact, bool final, uint64_t precopy, uint64_t stopcopy, uint64_t postcopy, uint64_t total) "exact=%d, final=%d, precopy=%"PRIu64", stopcopy=%"PRIu64", postcopy=%"PRIu64", total=%"PRIu64
+qemu_savevm_query_pending(bool exact, bool final, uint64_t precopy, uint64_t stopcopy, uint64_t postcopy, uint64_t total, uint32_t switchover_ack_pending, uint32_t total_switchover_ack_pending) "exact=%d, final=%d, precopy=%"PRIu64", stopcopy=%"PRIu64", postcopy=%"PRIu64", total=%"PRIu64", collected switchover ack pending=%"PRIu32", total switchover ack pending=%"PRIu32
 loadvm_state_setup(void) ""
 loadvm_state_cleanup(void) ""
 loadvm_handle_cmd_packaged(unsigned int length) "%u"
@@ -24,6 +24,7 @@ loadvm_postcopy_ram_handle_discard_header(const char *ramid, uint16_t len) "%s:
 loadvm_process_command(const char *s, uint16_t len) "com=%s len=%d"
 loadvm_process_command_ping(uint32_t val) "0x%x"
 loadvm_approve_switchover_legacy(const char *approver, unsigned int switchover_ack_pending_num_legacy) "Approver %s, switchover_ack_pending_num_legacy %u"
+loadvm_approve_switchover(const char *approver) "Approver %s"
 postcopy_ram_listen_thread_exit(void) ""
 postcopy_ram_listen_thread_start(void) ""
 qemu_savevm_send_postcopy_advise(void) ""
@@ -189,7 +190,7 @@ source_return_path_thread_loop_top(void) ""
 source_return_path_thread_pong(uint32_t val) "0x%x"
 source_return_path_thread_shut(uint32_t val) "0x%x"
 source_return_path_thread_resume_ack(uint32_t v) "%"PRIu32
-source_return_path_thread_switchover_acked(void) ""
+source_return_path_thread_switchover_acked(uint32_t pending_num) "switchover_ack_pending_num %" PRIu32
 source_return_path_thread_postcopy_package_loaded(void) ""
 migration_thread_low_pending(uint64_t pending) "%" PRIu64
 migrate_transferred(uint64_t transferred, uint64_t time_spent, uint64_t bandwidth, uint64_t avail_bw, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " switchover_bw %" PRIu64 " max_size %" PRId64
-- 
2.40.1


