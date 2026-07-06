Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB69FC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:56:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgf5y-0000fb-Tb; Mon, 06 Jul 2026 04:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wgf5n-0000V6-IQ
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:54:21 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wgf5k-0006uI-1N
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:54:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aY8d3dzWZPTH2H+pNpZyWzQxGkRr/4yuiZkTc0dB/e7osZqV8o4un0w385nhlbOyE3lL7gK6cqEE06h7iKqDTk6z2ckxe75JftasIqt/67YgU04mvwOvl68Ha5aqxI4XFlP6O+UcKDecWLW5A41nWMqN3QuFKyj8KnEgtqormnHEzItLR4wqrhHaAXr7tXwl9+Cg6r2VewcooV5HSyG0+mZomomH3fDOIyCn2caSnQOJFPGwT63SfuAJKwZqm3E+3rC/fK5KDkSDCSrr+ynDskfKKYFO4lGpx9kq233KsqfevJ9kGf7VYT2Bd5YthLQNWtXDbDof+sUdVzD/Gb9g3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7lGDES412FhQmVNcyPKGjvb4LqjvT0NJgbaxwwXuijQ=;
 b=QUgHdJrp4jFs+RkHIEDjnx+oBv9sqmZWtp8A34ss0Pkh1yhtA1rgpbEG6fTKJZHKy4WeEz+4/tMMt75bIVs9Ymkx1lTss58WvTV/oMl2/CjHQp8FzpsoDtePhttHM+jrcgtR+pVB9VbmZo15ESXycuIiXX9DMhkYMG223DxW3TRCPMGaLVIjB9/fgVufXRuU37I4oCB+PQ4mQSE5i5X1/s3UA0wksLqQVulquMQEWgbZIFzf7aoMQFEkJQybUNSAuHRUTscTRbAaVrf2TPYntb68rU43jfJnmtTnhRrtadhl3K3QrWWUS1pUNIwlPe8B2qPJHU4mAoUax1uEHrX9zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lGDES412FhQmVNcyPKGjvb4LqjvT0NJgbaxwwXuijQ=;
 b=I6e8UYz9sdv/HFW+6IcGuIjDkSy7/k6jbJGqIZA/kJGYw3Xw7jHHVbbW/ZjaA/nBjY63k+3SzX5PvqJu5nS9immf2vCGgojh/OWZ3nnh4lj73179rd6pOY1tqJ6KAbJPiiCIsfFF2HsKS1REM2QlEmy4zFpo1fNJOkAtZdB/Pc1FSJJynrxQVfuH5ofIJ0kfj5a5TgRl6M6aKqDgiC4tSICnmG4kB3EvYfff+KxTqIpkGTn1ME2h/63M6t/fAUiEPPRS+cXxDzWmZx1brQJv7DaRjQ8I9GuoptUjmKBPaOKzoUOkRpqD7sHXK5xx4m/GjTqF7W/JXKv+saNkcfQwhQ==
Received: from CH0PR03CA0328.namprd03.prod.outlook.com (2603:10b6:610:118::14)
 by CH0PR12MB8549.namprd12.prod.outlook.com (2603:10b6:610:182::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 08:54:04 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::6e) by CH0PR03CA0328.outlook.office365.com
 (2603:10b6:610:118::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 08:54:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 08:54:03 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 01:53:47 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 01:53:47 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 6 Jul
 2026 01:53:41 -0700
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
Subject: [PATCH v5 05/16] migration: Replace switchover_ack_needed
 SaveVMHandler
Date: Mon, 6 Jul 2026 11:52:00 +0300
Message-ID: <20260706085211.13905-6-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260706085211.13905-1-avihaih@nvidia.com>
References: <20260706085211.13905-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|CH0PR12MB8549:EE_
X-MS-Office365-Filtering-Correlation-Id: 1904340c-cef5-4305-fd13-08dedb3c214c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|7416014|376014|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: bgZh3X3iQsSJwuXeVSAgeAxza98MIrfWmzMc/ZsEV8Mqhnciz3Wi90Y+JGIw5EM+J//TJzPijM8+06mk4dBztd0yzdN2/EFEFtQf0GalihsikJKzWqhPFS9IqLa2AD/hD/Qb2OZyaUlEVsb2Agk9eW9S3SQZSnY0USMO3/gxpOLRGAXCufgOi8k6tjIZHSEaZKGBgNnTId6+11MUn5kqPuAZsZniLXX9rUXd1mvNvPRzOmAI5gZWncz5NzhZ0D2j6vPRwsVQzcW2bzZ/AKJ5MXMU2FI2YqCahLeo6h0BEgw3srUS/0mSOHsyuM11y/A+3C2mhI8REAbpjFfhwGw3U001EzVT8lV1xRyQW9WeIL8feIAtOWoqtfCkMe8+Opx94nHJ/0pGPlTsf7FWqbUxOJJ5mCQXxD1iNiEr+E2EsJT990EDLwxEm/HiplFtVr4li16Ys3UGKunoN1JbvzWc0h9K5zqnoba+NAc42ZlzZh6Ggkcf+wj+UNO6SaXKRhjmr1ylFG1I3nlhkue1nHl1Vf5dW4eo47EdeR6YO2jGMQyVj6h2Wdri3GIwUN2UHAZgT4dc30CVpWxauHf7fUed2c2TfbGcp8m7tPeNC/A4r6R1bqQtIwHpOcmNTogXu9a/MYnNy8TF3vxK50vUTP9huJ9rcYaJnHyMFtWb9DFNy3dU0wgaa3Mraj6/neUb1bnC/m19luirQoFNZOxU1o7O5Q==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(7416014)(376014)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2Jadk960i84vfjsXzjm/icfhdVSnYRPzEypGHxzeHg0ub2jTzTDoNAEyT8ECVgicgGPgcK4+0u/m8lVSqvQOAy+c0RvLVGaXXpjKSuVb2DE6wNKAoAjw5UOryYtlQk0lpfMqIQtVD7uKhmqwjwXy/Ba2foZma1IlJHGFY0BDyAOFIQFxjVdoaprN7gsXnOyv08fU03r5jIMcLjLBWEjnt08w43oTXpFmSOjtONlPA1pTFt9szZAvOj4fn/6jB+JGCS7KuIzzFncPZoasY/i2ovSQXKAslhUMDIn22yQ4ld1JnOQpPcVwQGcJPEVi+JIpmNobSBUW6EqBSHMsqMoqi/SWVT8NF1OkprrQuBzgpbR0FE98PkxlVSFgM7Z3uU7GcUhb5+QrRkqA5AtPXbKDklvxcVVLeIEMDgA2s57SnZoW3i8UpnMe632Jle2D9VjL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 08:54:03.4832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1904340c-cef5-4305-fd13-08dedb3c214c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8549
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=avihaih@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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
index d3d6e1f50d..17b42949d4 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -159,4 +159,6 @@ bool multifd_device_state_save_thread_should_exit(void);
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
index 180b316bae..7055cfbd3e 100644
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
@@ -776,6 +784,8 @@ static int vfio_load_setup(QEMUFile *f, void *opaque, Error **errp)
         return ret;
     }
 
+    vfio_request_switchover_ack(vbasedev);
+
     return 0;
 }
 
@@ -874,13 +884,6 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
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
@@ -904,7 +907,6 @@ static const SaveVMHandlers savevm_vfio_handlers = {
     .load_setup = vfio_load_setup,
     .load_cleanup = vfio_load_cleanup,
     .load_state = vfio_load_state,
-    .switchover_ack_needed = vfio_switchover_ack_needed,
     /*
      * Multifd support
      */
diff --git a/migration/migration.c b/migration/migration.c
index 442f950c43..9a8d47ba96 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2202,6 +2202,21 @@ void migration_rp_kick(MigrationState *s)
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
index be81de2616..9863963027 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2800,23 +2800,6 @@ static int qemu_loadvm_state_header(QEMUFile *f, Error **errp)
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
@@ -3078,10 +3061,6 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp)
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


