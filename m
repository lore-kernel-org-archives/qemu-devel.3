Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02783CD6E4A
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 09:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wULPE-0005tx-Sf; Tue, 02 Jun 2026 05:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wULPD-0005tV-RX
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 05:27:27 -0400
Received: from mail-westusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c001::5] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wULPA-00047T-3e
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 05:27:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qoEsxxYsgPlx7DKxZ7wcUtHxJ2A9/KwVNFBAQIz86fV1K+Iu6pRk0wHR/2H8PsF0+g74obxeD/8Bcnf7vmZSPzJdSp7HMKhkDLQso6q97N6ow+tm5EHFac33lwrktC+YBlbCvt70wtewVDrFjgDGiG2IhRLAXoodqRMB5lD57ONMoiQk5g/YbWVQ1/Z4P1zctJOfPOHLUJS8Y+KH7zvT97tGTPWLMKKM9aAnDRwB4aLEXw3qvo5u+xuI4Pk1nNPmoJNxRtF8tcpyUIIe2sqmC0UKBbuHl4/4Pnw/ZSuOJWbjTWh7UCybaTeUacuaqD9hk5zhvipNlGvRCaBw10oq+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qdsxysvd/vL/pVguOeDs/agi60N/8Kn2Ho1M7ePij/o=;
 b=vjnyqj8+6ZYHHJgVW727gwngw2394GeIR9B+WM2pZz3XZhZlHdcG8slX7ArJ42GuP4FCFfzk4nomxyvkpE+laUdn5FZG1au7Gb6Ce2wAyYWHVU6idXLQ8LqY0Nk3b/BQg5125QhFv3IFQ9ZZREfgZVuYSDttFvuG4Fqn4AI7fElY6YXjmSMAO3wnhxOEkHPYf3ShZMzXanf4g6JbC1IhbEEcyP/E/ddf0mY0UJ/41m1netWdelelDI0f3al1nuXFqjymF7b1vjueUK7a6fqxI7RLJALadAl2xgA4ZmZ1hgYZ93IagblLQbhRUXe/J26nQwbQcTba/ZA803U+rhfQPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qdsxysvd/vL/pVguOeDs/agi60N/8Kn2Ho1M7ePij/o=;
 b=mlKcRzY0WCIK/UC9vORMFvYhApaJo+fvFsvX8QHHlyvSXifvSO6hfg+mDasX/BZJPinmDWfEYJARAeQwy85JXrvDo4PSSegTai9zZ12s4jwardYVuRo8ifgz9Z21iWKNPLsAlZonr6bY3OzpjMkJnNhdgyj4CEVHk3J4ut9L7QGotd44CwM+oVeIim1WVStto8vp0fvocABNuYOERx42vxeyLJEosDcXQuFK2Cdg2ltahCJ+yzE9bh2yvM4d/5HbUC5S7kDNhtvjqWD3aaRTk5MG3cViwyT1vZfygIDnpmHvRXxRAwg/fM5O7ufv8YDi5G9B/9TRldWIqN8UZh0/QA==
Received: from CH5PR05CA0013.namprd05.prod.outlook.com (2603:10b6:610:1f0::26)
 by IA1PR12MB6259.namprd12.prod.outlook.com (2603:10b6:208:3e5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 09:27:11 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::66) by CH5PR05CA0013.outlook.office365.com
 (2603:10b6:610:1f0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Tue, 2
 Jun 2026 09:27:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 09:27:10 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Jun
 2026 02:26:54 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Jun
 2026 02:26:54 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 2 Jun
 2026 02:26:48 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex@shazbot.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Zhao Liu
 <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, Jason Herne
 <jjherne@linux.ibm.com>, Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 "Cornelia Huck" <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Vladimir Sementsov-Ogievskiy" <vsementsov@yandex-team.ru>, John Snow
 <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH v2 04/13] migration: Replace switchover_ack_needed
 SaveVMHandler
Date: Tue, 2 Jun 2026 12:26:12 +0300
Message-ID: <20260602092621.382-5-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260602092621.382-1-avihaih@nvidia.com>
References: <20260602092621.382-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|IA1PR12MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: afc89234-fe83-4d46-15d8-08dec0891faf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|36860700016|82310400026|376014|18002099003|11063799006|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: zlvVaUl5UIZkSYf41Q99R0gh5aGreKorITlM8KC5Li7L6TjovyrdrqQ5ZcIhPZOqlETAtxthW1pbHwWJ0CdWXOLY/ZjeHOSVG2nioQ4eSeFCWVz05X5S2LqWP2DGKa78/wOtjvEa/S4fM5FveJR94jCk/tAM2PpS8U9SQiHmYJH26pEHPz9eQ9yurbUyFaT9quuRYLXFW4MJpyMQyDJEifyfc5qccYB1luhHirDWFwd2bfxegdA5vwOyj2DFLV3oL9MilgD8mSoTNIslxPCoBoA0A7P8+DrioI7hIQUZKmkxf2Q35wmFvFF9MdZ/UH5gIdIfaR7gmPDgP34cz3MTV73c45XHrMGiBndlZd5tZbhnVB06nclzYHFKpc/ZD15kSO8xiNtbPIWkXOloJvJZ2VDQa9viDvmuUo3pmW0f1g+J1eL5nlQTN4xtSwHyqkvWqYal+MLbMV4M/qbzHdLyoGIX7A3aYpgLS2ufvZXGLQQ5zaTvtbleKjW50jl/hxV3dHPA3jO9Og8+i6l7IweIC73oQDqxk8JYIOvoFESIzl5XYm9PSuAWHnQ+6Cnl9LNX74JojmVPrauhmDYC6IEAyY5fLF/H/9vJ4UseAtqGOwlURszxTNgHWyQWCBrPx/PM4QPnQS+dC8ibEomA9Av/jAbkguNaXmJhcZgimSB77TN07LS11Vf356L/lZIl2ypV/2qOgjMAh68DI/HjBc5Bd6TseY2ETxmAuePDeYW9hVE=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(36860700016)(82310400026)(376014)(18002099003)(11063799006)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hUiRm4ApPy+KmYOl1Zxdx3PHufgyGXAhLUz4k9ghlpR2PwbLPcBa258KeaxosmP5BBjMtWs/0SUAR7wWgz+U59X8aPQKRZiSubxA/I41pQvGmDO9DWUqP/kwtz+u57eL9rboG3dB6BLamo65YR7YXES+DjfbgIkB9jtlHtq090lSOKTVk1Bws0/C3+vdD1FZ1J4BwZ0jqLTOBUyLjvXFobEzEu0FTc85f3AN6RUMd53c8rmGxa0zZ34PkRzSKv0QWlOo4YgxeTS5OM7ecLEX1SZ1vnzEe8wdvwHR3Gv05J5uDunu7e8JRAw1OeNj/X3Lrt/aIRGnd5g/zjRL6B9emYeq78Lt+jTUoSgHtxHE/oPp/1s2ru/5Yt3emT/W2UtvO39XXt8YAuuaElUC3lhRyL62TpLGvQ7E87E3NAw737maphmza0TKVNSEpMkvUGQW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 09:27:10.6238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afc89234-fe83-4d46-15d8-08dec0891faf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6259
Received-SPF: permerror client-ip=2a01:111:f403:c001::5;
 envelope-from=avihaih@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

A new switchover-ack mechanism that will replace the existing one will
be added in the following patches. The new mechanism will not use
switchover_ack_needed SaveVMHandler, however, the old mechanism must
still be kept for backward compatibility.

To keep things clear and decrease API surface of old code, replace
switchover_ack_needed SaveVMHandler with a regular function
migration_request_switchover_ack().

No functional changes intended.

Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 docs/devel/migration/vfio.rst |  3 ---
 include/migration/misc.h      |  2 ++
 include/migration/register.h  | 13 -------------
 hw/vfio/migration.c           | 18 ++++++++++--------
 migration/migration.c         | 15 +++++++++++++++
 migration/savevm.c            | 21 ---------------------
 migration/trace-events        |  2 +-
 7 files changed, 28 insertions(+), 46 deletions(-)

diff --git a/docs/devel/migration/vfio.rst b/docs/devel/migration/vfio.rst
index 691061d182..854277b11c 100644
--- a/docs/devel/migration/vfio.rst
+++ b/docs/devel/migration/vfio.rst
@@ -59,9 +59,6 @@ VFIO implements the device hooks for the iterative approach as follows:
 * A ``save_live_iterate`` function that reads the VFIO device's data from the
   vendor driver during iterative pre-copy phase.
 
-* A ``switchover_ack_needed`` function that checks if the VFIO device uses
-  "switchover-ack" migration capability when this capability is enabled.
-
 * A ``switchover_start`` function that in the multifd mode starts a thread that
   reassembles the multifd received data and loads it in-order into the device.
   In the non-multifd mode this function is a NOP.
diff --git a/include/migration/misc.h b/include/migration/misc.h
index 3159a5e53c..a2219c981b 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -156,4 +156,6 @@ bool multifd_device_state_save_thread_should_exit(void);
 void multifd_abort_device_state_save_threads(void);
 bool multifd_join_device_state_save_threads(void);
 
+void migration_request_switchover_ack(const char *requester);
+
 #endif
diff --git a/include/migration/register.h b/include/migration/register.h
index 6f632123f1..a61c4236d2 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -302,19 +302,6 @@ typedef struct SaveVMHandlers {
      */
     int (*resume_prepare)(MigrationState *s, void *opaque);
 
-    /**
-     * @switchover_ack_needed
-     *
-     * Checks if switchover ack should be used. Called only on
-     * destination.
-     *
-     * @opaque: data pointer passed to register_savevm_live()
-     *
-     * Returns true if switchover ack should be used and false
-     * otherwise
-     */
-    bool (*switchover_ack_needed)(void *opaque);
-
     /**
      * @switchover_start
      *
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 49266cbd76..6303f006a2 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -487,6 +487,14 @@ static bool vfio_precopy_supported(VFIODevice *vbasedev)
     return migration->mig_flags & VFIO_MIGRATION_PRE_COPY;
 }
 
+static void vfio_request_switchover_ack(VFIODevice *vbasedev)
+{
+    if (vfio_precopy_supported(vbasedev)) {
+        /* Precopy support implies switchover-ack is needed */
+        migration_request_switchover_ack(vbasedev->name);
+    }
+}
+
 /* ---------------------------------------------------------------------- */
 
 static int vfio_save_prepare(void *opaque, Error **errp)
@@ -775,6 +783,8 @@ static int vfio_load_setup(QEMUFile *f, void *opaque, Error **errp)
         return ret;
     }
 
+    vfio_request_switchover_ack(vbasedev);
+
     return 0;
 }
 
@@ -873,13 +883,6 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
     return ret;
 }
 
-static bool vfio_switchover_ack_needed(void *opaque)
-{
-    VFIODevice *vbasedev = opaque;
-
-    return vfio_precopy_supported(vbasedev);
-}
-
 static int vfio_switchover_start(void *opaque)
 {
     VFIODevice *vbasedev = opaque;
@@ -903,7 +906,6 @@ static const SaveVMHandlers savevm_vfio_handlers = {
     .load_setup = vfio_load_setup,
     .load_cleanup = vfio_load_cleanup,
     .load_state = vfio_load_state,
-    .switchover_ack_needed = vfio_switchover_ack_needed,
     /*
      * Multifd support
      */
diff --git a/migration/migration.c b/migration/migration.c
index df8ed3a9fd..957b794e91 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2196,6 +2196,21 @@ void migration_rp_kick(MigrationState *s)
     qemu_sem_post(&s->rp_state.rp_sem);
 }
 
+/* This is called only on destination side */
+void migration_request_switchover_ack(const char *requester)
+{
+    MigrationIncomingState *mis = migration_incoming_get_current();
+
+    if (!migrate_switchover_ack()) {
+        return;
+    }
+
+    mis->switchover_ack_pending_num++;
+
+    trace_migration_request_switchover_ack(requester,
+                                           mis->switchover_ack_pending_num);
+}
+
 static struct rp_cmd_args {
     ssize_t     len; /* -1 = variable */
     const char *name;
diff --git a/migration/savevm.c b/migration/savevm.c
index fd870345b4..1a60a178af 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2798,23 +2798,6 @@ static int qemu_loadvm_state_header(QEMUFile *f, Error **errp)
     return 0;
 }
 
-static void qemu_loadvm_state_switchover_ack_needed(MigrationIncomingState *mis)
-{
-    SaveStateEntry *se;
-
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
-        if (!se->ops || !se->ops->switchover_ack_needed) {
-            continue;
-        }
-
-        if (se->ops->switchover_ack_needed(se->opaque)) {
-            mis->switchover_ack_pending_num++;
-        }
-    }
-
-    trace_loadvm_state_switchover_ack_needed(mis->switchover_ack_pending_num);
-}
-
 static int qemu_loadvm_state_setup(QEMUFile *f, Error **errp)
 {
     ERRP_GUARD();
@@ -3076,10 +3059,6 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp)
         return -EINVAL;
     }
 
-    if (migrate_switchover_ack()) {
-        qemu_loadvm_state_switchover_ack_needed(mis);
-    }
-
     cpu_synchronize_all_pre_loadvm();
 
     ret = qemu_loadvm_state_main(f, mis, errp);
diff --git a/migration/trace-events b/migration/trace-events
index c0c433744c..5955befcc6 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -8,7 +8,6 @@ qemu_loadvm_state_post_main(int ret) "%d"
 qemu_loadvm_state_section_startfull(uint32_t section_id, const char *idstr, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
 qemu_savevm_send_packaged(void) ""
 qemu_savevm_query_pending(bool exact, bool final, uint64_t precopy, uint64_t stopcopy, uint64_t postcopy, uint64_t total) "exact=%d, final=%d, precopy=%"PRIu64", stopcopy=%"PRIu64", postcopy=%"PRIu64", total=%"PRIu64
-loadvm_state_switchover_ack_needed(unsigned int switchover_ack_pending_num) "Switchover ack pending num=%u"
 loadvm_state_setup(void) ""
 loadvm_state_cleanup(void) ""
 loadvm_handle_cmd_packaged(unsigned int length) "%u"
@@ -199,6 +198,7 @@ process_incoming_migration_co_postcopy_end_main(void) ""
 postcopy_preempt_enabled(bool value) "%d"
 migration_precopy_complete(void) ""
 migration_call_notifiers(int type) "type=%d"
+migration_request_switchover_ack(const char *requester, unsigned int switchover_ack_pending_num) "Requester %s, switchover_ack_pending_num %u"
 
 # migration-stats
 migration_transferred_bytes(uint64_t qemu_file, uint64_t multifd, uint64_t rdma) "qemu_file %" PRIu64 " multifd %" PRIu64 " RDMA %" PRIu64
-- 
2.40.1


