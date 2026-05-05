Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE77DCD342F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 08:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKAwD-0001Sh-1X; Tue, 05 May 2026 04:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wKAwA-0001SI-MT
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:15:26 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wKAw4-0006cW-2Y
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:15:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DCP8bt6J3gSLBxMiY3YIOTHMpCeF64ojp6q5ApvY5u9tuq/zdQJ/3HVAwbcKtH4x2mGeAxKhqcMGoIQOY9HHO3ycw9rOjgLdKjSv0b2jG5KysUMLzH54KafpFk+abVnd2iFIN97uYcdbyKJRd4jXY2VC2YtYS6e7Nol1pLcSKSzLLs9U6UeG5AuZlDgHiozyC/WpcsEF7YfwaU9LOHpk679L0t5vr75t00cXxAZLKh7xLwhkn5HyZZEYFRw/PWpALa6vBJIwV/21vV9joRYy8iI/Nu1MwB7izi6YZzIWsU14/CE57l7a8MoTEXqgm92+YXZKzh2apP87umEZkrMzIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEauttGw/TxZ1b5XEqkjUdJ6R53/bRmUoFJGYQDgfHk=;
 b=d7r5v1f+52m2uILEZKBEGXiEqUxLlVDPKsmWdJr8jNrq2RDIolLJQuHJws+1C7/O158wqbvPFLyTuxNdTwu8GvcTvjJztrZqI9ueZb4XBA+zdWoCWjNbahrU1QLdpOlX4SXZ9UfpdW9gtHghFsThxcEagRXyEzWqowCFzZLkrb9Th7TJIt8LnDgdv8kjeqH6nmAMhpw875xIWCueCyzvQCUnEFJMMWvHzKfAiZYxmftBRDDcsbiQbeX4t9T58ui71mOSPwAeTNKWPvSmrylZT9n92u5lQP3yJyFnyFhX6hsy3+DEhH/pQDHS9x9BPf2R9tvxLodEldtBDtsUG+gMlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEauttGw/TxZ1b5XEqkjUdJ6R53/bRmUoFJGYQDgfHk=;
 b=uHXJSQj0GCYVDbZ5yF3H6gw8UouSpRAt1VPffAAUV098xs01Q/ptHNJAtH2tLFyzwz1ZyyuXk+EhiA7JoDsGA+PlJONxFe9GQSwZ8S+ZQlNnlo4SNde/Cmr5TvrmL4u3T3Y4PwuIewSbHm1YO18wJKVgPHQayvnRCKkIOcUkilXz31Yww75Uf50PfwDnntlImaGsB4ZyppNkmwXXxZJbxtvsm73KLNIlJP28djzNlZxVzgmCaFOHZAKEQ0vJSs83XHs3eLvEjsxQPkx6OCCc9mAuLtXPzW/nPRkh/9IV3kuqrS+SP8RQxRLx1qUb3y/24J7DyHcOPtm+2pboRD5Fnw==
Received: from SJ0PR03CA0158.namprd03.prod.outlook.com (2603:10b6:a03:338::13)
 by SA3PR12MB9092.namprd12.prod.outlook.com (2603:10b6:806:37f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 08:15:09 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::bb) by SJ0PR03CA0158.outlook.office365.com
 (2603:10b6:a03:338::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.23 via Frontend Transport; Tue,
 5 May 2026 08:15:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 08:15:09 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 01:14:56 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 01:14:56 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 5 May
 2026 01:14:52 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex@shazbot.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Zhao Liu
 <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH 07/14] migration: Make switchover-ack re-usable
Date: Tue, 5 May 2026 11:14:16 +0300
Message-ID: <20260505081423.28326-8-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260505081423.28326-1-avihaih@nvidia.com>
References: <20260505081423.28326-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|SA3PR12MB9092:EE_
X-MS-Office365-Filtering-Correlation-Id: 37886424-b66b-4c07-48fd-08deaa7e6c62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: B+Qd72EFhXUyrW4YSatLna3wxQjcatvti5KztFNlLgdgmgX+Xb0aKPaX9ZINB70qXfF58oXcovKkccdz297uFlHuSZPRPsV6ms1aRmQufa1jprVT7MXUOYewEDxAdx5a492mIuWHDkpAw5N0L692A6Y6zw/E8DJjhaWloClmuBXQyJ897xCHxMIDwZfPp+yJZTwZREtbwEOyD6ihgGIQB/ULBW68jFDNd84VUon6zFAejxUcRh956tbD6zlmMDGVFBxgidTJZbJjnxCvkwt/H97rrIW8L6dUfVKuccvfliDzZoL4ybrKNCqWIe0wBrw8okwiwuxeqT//jmjRT19r/j0ax70YIO9KIlEZjQyXm5Nvi2+3U9YMuUVnj/w286064Sse6DHaREGE5Be808J92tukxqUUKcN9mADDPngu3ik9yjimsQU8kIh6zgD7kmpTPqD5IdSsUyOXXOHrJH3kRcuvzviQs7j/Dffj4v+SigFW8cCrezBNXqJw4IXWR/rt5iNRz/dDDWGWFj1ail/3bhykgevoKltwXqgvKEDY8p17uZp+QI8jat5cRXxO/FYO3wV8rzxCFbJGfQ9OwUxbYKSb0YRjCDbKiAbqqrGmWJFM2V+twforOfjNcrdBSCZ0JsP9tszYi/9bt/6naAfB3paQmGEu6N3Flk9RzAnkvTePlst/m8cbkC1l42pYnqsXIIY98wPyCBE+eK6z+XfvbtzfXXCS7QDbGpL9xIVUsg0=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dOZ9afzvELF7Bqej9DP8KtCTv3PbR/Dm1qk9XX2T/fpa5XsgNthnfcBkjOB1uZDlEtgGNuvoCvGfP9FnMgn74NnYELGOTAgarA/qCQohUR7z7QjqY/TGDnX1x9dT4fW7GwGR9n9Cd4eaQuTq0IW5uOog3ytO8IetyAZ1lm3PHWDiJ6DjJmVB1MYw+C2/TMwwDs78Pk3KunDTnH+xpB9iNpn7wOlMTgxo4ag1MCRwA//vLxFnL5YUFpBLD7Iw+4SX39hgA5GzXzR3m6zEj36K1miWje9W129aChoEYb29Qcqo2iNQVdlrpCbr6NEasgTM7CG/Honenv37fX9bEPAu6gSSFGaLQgQSHj/l8SNj8ltEuBxcFmTtRFDZc1UBQfc/B0ZhoyjVnkx+gAMC+u793mflbdVS5bGCJDQdfo9OwqPKCCdBBWqmFG0+gWHJT9fO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 08:15:09.3889 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37886424-b66b-4c07-48fd-08deaa7e6c62
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9092
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=avihaih@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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
another switchover ACK when needed.

To avoid scattering them all over, switchover ACKs are requested through
a new request_switchover_ack handler which is called in specific places.

Since now switchover ACK can be requested for a specific device and in
different times, make switchover ACK per-device (instead of a single ACK
for all devices) and let source side do the pending ACKs accounting.

Keep the legacy switchover-ack mechanism for backward compatibility and
turn it on by a compatibility property for older machines. Enable the
property until VFIO implements the new switchover-ack.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 include/migration/client-options.h |  1 +
 include/migration/register.h       | 21 +++++++++
 migration/migration.h              | 15 +++++--
 migration/savevm.h                 |  4 +-
 hw/core/machine.c                  |  4 +-
 hw/vfio/migration.c                |  8 ++--
 migration/migration.c              | 38 +++++++++++++---
 migration/options.c                | 10 +++++
 migration/savevm.c                 | 69 +++++++++++++++++++++++++++++-
 migration/trace-events             |  4 +-
 10 files changed, 156 insertions(+), 18 deletions(-)

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
index eae4c4ffca..f43f47a679 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -30,6 +30,11 @@ typedef struct MigPendingData {
     uint64_t total_bytes;
 } MigPendingData;
 
+enum MigSwitchoverAckRequestStage {
+    MIG_SWITCHOVER_ACK_REQUEST_STAGE_SETUP,
+    MIG_SWITCHOVER_ACK_REQUEST_STAGE_PENDING_EXACT,
+};
+
 /**
  * struct SaveVMHandlers: handler structure to finely control
  * migration of complex subsystems and devices, such as RAM, block and
@@ -299,6 +304,22 @@ typedef struct SaveVMHandlers {
      */
     int (*resume_prepare)(MigrationState *s, void *opaque);
 
+    /**
+     * @request_switchover_ack
+     *
+     * Checks if a new switchover ACK is requested. Called only on source side
+     * in the stages specified in enum MigSwitchoverAckRequestStage.
+     *
+     * @stage: the stage in which the handler was called
+     * @opaque: data pointer passed to register_savevm_live()
+     * @requester: output pointer to be set to the name of the requester of the
+     * switchover ACK (for logging purposes). If not set, idstr will be used.
+     *
+     * Returns true to request switchover ACK and false otherwise
+     */
+    bool (*request_switchover_ack)(enum MigSwitchoverAckRequestStage stage,
+                                   void *opaque, const char **requester);
+
     /**
      * @switchover_start
      *
diff --git a/migration/migration.h b/migration/migration.h
index 6099bac512..d46ecd967f 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -494,6 +494,12 @@ struct MigrationState {
      */
     uint8_t clear_bitmap_shift;
 
+    /*
+     * This decides whether to use legacy switchover ack (send ACK once for all
+     * devices) or new switchover ack (send ACK for each device).
+     */
+    bool switchover_ack_legacy;
+
     /*
      * This save hostname when out-going migration starts
      */
@@ -503,10 +509,13 @@ struct MigrationState {
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
index fd0c4d3329..937acfa84c 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -37,6 +37,8 @@ bool qemu_savevm_state_blocked(Error **errp);
 void qemu_savevm_non_migratable_list(strList **reasons);
 int qemu_savevm_state_prepare(Error **errp);
 int qemu_savevm_state_do_setup(QEMUFile *f, Error **errp);
+int qemu_savevm_request_switchover_ack(enum MigSwitchoverAckRequestStage stage,
+                                       Error **errp);
 bool qemu_savevm_state_guest_unplug_pending(void);
 int qemu_savevm_state_resume_prepare(MigrationState *s);
 void qemu_savevm_send_header(QEMUFile *f);
@@ -70,7 +72,7 @@ void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
 int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
                            Error **errp);
 int qemu_load_device_state(QEMUFile *f, Error **errp);
-int qemu_loadvm_approve_switchover_legacy(const char *approver);
+int qemu_loadvm_approve_switchover(const char *approver);
 int qemu_savevm_state_non_iterable(QEMUFile *f, Error **errp);
 int qemu_savevm_state_non_iterable_early(QEMUFile *f,
                                          JSONWriter *vmdesc,
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 1b661fd36a..4f82813e8b 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -39,7 +39,9 @@
 #include "hw/acpi/generic_event_device.h"
 #include "qemu/audio.h"
 
-GlobalProperty hw_compat_11_0[] = {};
+GlobalProperty hw_compat_11_0[] = {
+    { "migration", "switchover-ack-legacy", "on" },
+};
 const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
 
 GlobalProperty hw_compat_10_2[] = {
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 314095235d..2911583ee1 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -828,11 +828,11 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
                 return -EINVAL;
             }
 
-            ret = qemu_loadvm_approve_switchover_legacy(vbasedev->name);
+            ret = qemu_loadvm_approve_switchover(vbasedev->name);
             if (ret) {
-                error_report("%s: qemu_loadvm_approve_switchover_legacy "
-                             "failed, err=%d (%s)",
-                             vbasedev->name, ret, strerror(-ret));
+                error_report(
+                    "%s: qemu_loadvm_approve_switchover failed, err=%d (%s)",
+                    vbasedev->name, ret, strerror(-ret));
             }
 
             return ret;
diff --git a/migration/migration.c b/migration/migration.c
index 3c4385b5f7..b86ceea6ff 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1684,7 +1684,9 @@ int migrate_init(MigrationState *s, Error **errp)
     s->vm_old_state = -1;
     s->iteration_initial_bytes = 0;
     s->threshold_size = 0;
-    s->switchover_acked = false;
+    /* Legacy switchover-ack sends a single ACK for all devices */
+    qatomic_set(&s->switchover_ack_pending_num,
+                migrate_switchover_ack_legacy() ? 1 : 0);
     s->rdma_migration = false;
 
     /*
@@ -2169,7 +2171,7 @@ void migration_request_switchover_ack_legacy(const char *requester)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
 
-    if (!migrate_switchover_ack()) {
+    if (!migrate_switchover_ack() || !migrate_switchover_ack_legacy()) {
         return;
     }
 
@@ -2425,9 +2427,18 @@ static void *source_return_path_thread(void *opaque)
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
@@ -3221,7 +3232,7 @@ static bool migration_can_switchover(MigrationState *s)
         return true;
     }
 
-    return s->switchover_acked;
+    return qatomic_read(&s->switchover_ack_pending_num) == 0;
 }
 
 /* Migration thread iteration status */
@@ -3311,9 +3322,10 @@ static MigIterateState migration_iteration_run(MigrationState *s)
     Error *local_err = NULL;
     bool in_postcopy = (s->state == MIGRATION_STATUS_POSTCOPY_DEVICE ||
                         s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
-    bool can_switchover = migration_can_switchover(s);
+    bool can_switchover;
     MigPendingData pending = { };
     bool complete_ready;
+    int ret;
 
     /* Fast path - get the estimated amount of pending data */
     qemu_savevm_query_pending(&pending, false);
@@ -3346,8 +3358,18 @@ static MigIterateState migration_iteration_run(MigrationState *s)
          */
         if (migration_iteration_next_ready(s, &pending)) {
             migration_iteration_go_next(&pending);
+            ret = qemu_savevm_request_switchover_ack(
+                MIG_SWITCHOVER_ACK_REQUEST_STAGE_PENDING_EXACT, &local_err);
+            if (ret < 0) {
+                migrate_error_propagate(s, local_err);
+                qemu_file_set_error(s->to_dst_file, ret);
+                return MIG_ITERATE_RESUME;
+            }
         }
 
+        /* Check can switchover after qemu_savevm_request_switchover_ack() */
+        can_switchover = migration_can_switchover(s);
+
         /* Should we switch to postcopy now? */
         if (can_switchover && postcopy_should_start(s, &pending)) {
             if (postcopy_start(s, &local_err)) {
@@ -3638,6 +3660,10 @@ static void *migration_thread(void *opaque)
     bql_lock();
     ret = qemu_savevm_state_do_setup(s->to_dst_file, &local_err);
     bql_unlock();
+    if (!ret) {
+        ret = qemu_savevm_request_switchover_ack(
+            MIG_SWITCHOVER_ACK_REQUEST_STAGE_SETUP, &local_err);
+    }
 
     qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
                                MIGRATION_STATUS_ACTIVE);
diff --git a/migration/options.c b/migration/options.c
index 7556fbc06b..44327c588f 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -108,6 +108,9 @@ const Property migration_properties[] = {
                      preempt_pre_7_2, false),
     DEFINE_PROP_BOOL("multifd-clean-tls-termination", MigrationState,
                      multifd_clean_tls_termination, true),
+    /* Use legacy until VFIO implements new switchover-ack */
+    DEFINE_PROP_BOOL("switchover-ack-legacy", MigrationState,
+                     switchover_ack_legacy, true),
 
     /* Migration parameters */
     DEFINE_PROP_UINT8("x-throttle-trigger-threshold", MigrationState,
@@ -462,6 +465,13 @@ bool migrate_rdma(void)
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
index 687d6761cc..b6076579de 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1472,6 +1472,54 @@ int qemu_savevm_state_do_setup(QEMUFile *f, Error **errp)
     return precopy_notify(PRECOPY_NOTIFY_SETUP, errp);
 }
 
+static const char *
+switchover_ack_stage_to_str(enum MigSwitchoverAckRequestStage stage)
+{
+    switch (stage) {
+    case MIG_SWITCHOVER_ACK_REQUEST_STAGE_SETUP:
+        return "SETUP";
+    case MIG_SWITCHOVER_ACK_REQUEST_STAGE_PENDING_EXACT:
+        return "PENDING_EXACT";
+    default:
+        return "UNKNOWN";
+    }
+}
+
+int qemu_savevm_request_switchover_ack(enum MigSwitchoverAckRequestStage stage,
+                                       Error **errp)
+{
+    MigrationState *s = migrate_get_current();
+    uint32_t pending_num;
+    SaveStateEntry *se;
+    const char *requester;
+
+    if (!migrate_switchover_ack() || migrate_switchover_ack_legacy()) {
+        return 0;
+    }
+
+    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+        if (!se->ops || !se->ops->request_switchover_ack) {
+            continue;
+        }
+
+        requester = NULL;
+        if (se->ops->request_switchover_ack(stage, se->opaque, &requester)) {
+            requester = requester ?: se->idstr;
+            pending_num = qatomic_inc_fetch(&s->switchover_ack_pending_num);
+            if (pending_num == 0) {
+                error_setg(errp, "Switchover ack pending num overflowed by %s",
+                           requester);
+                return -EOVERFLOW;
+            }
+
+            trace_savevm_request_switchover_ack(
+                switchover_ack_stage_to_str(stage), requester, pending_num);
+        }
+    }
+
+    return 0;
+}
+
 int qemu_savevm_state_resume_prepare(MigrationState *s)
 {
     SaveStateEntry *se;
@@ -2471,7 +2519,7 @@ static int loadvm_switchover_ack_no_users_legacy(MigrationIncomingState *mis,
 {
     int ret;
 
-    if (!migrate_switchover_ack()) {
+    if (!migrate_switchover_ack() || !migrate_switchover_ack_legacy()) {
         return 0;
     }
 
@@ -3153,7 +3201,7 @@ int qemu_load_device_state(QEMUFile *f, Error **errp)
     return 0;
 }
 
-int qemu_loadvm_approve_switchover_legacy(const char *approver)
+static int qemu_loadvm_approve_switchover_legacy(const char *approver)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
 
@@ -3172,6 +3220,23 @@ int qemu_loadvm_approve_switchover_legacy(const char *approver)
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
index d6795c64c7..be3e688c71 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -24,6 +24,7 @@ loadvm_postcopy_ram_handle_discard_header(const char *ramid, uint16_t len) "%s:
 loadvm_process_command(const char *s, uint16_t len) "com=%s len=%d"
 loadvm_process_command_ping(uint32_t val) "0x%x"
 loadvm_approve_switchover_legacy(const char *approver, unsigned int switchover_ack_pending_num_legacy) "Approver %s, switchover_ack_pending_num_legacy %u"
+loadvm_approve_switchover(const char *approver) "Approver %s"
 postcopy_ram_listen_thread_exit(void) ""
 postcopy_ram_listen_thread_start(void) ""
 qemu_savevm_send_postcopy_advise(void) ""
@@ -40,6 +41,7 @@ savevm_send_postcopy_resume(void) ""
 savevm_send_recv_bitmap(char *name) "%s"
 savevm_send_switchover_start(void) ""
 savevm_state_setup(void) ""
+savevm_request_switchover_ack(const char *stage, const char *requester, uint32_t pending_num) "Stage %s, requester %s, switchover_ack_pending_num %" PRIu32
 savevm_state_resume_prepare(void) ""
 savevm_state_header(void) ""
 savevm_state_iterate(void) ""
@@ -189,7 +191,7 @@ source_return_path_thread_loop_top(void) ""
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


