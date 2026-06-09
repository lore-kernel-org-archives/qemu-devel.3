Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC72ACD8CAC
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWrNm-0002Bj-Ks; Tue, 09 Jun 2026 04:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wWrNl-0002AU-0i
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 04:00:21 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wWrNj-0004Cg-16
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 04:00:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uIfgUOAr2IJ9lMAazTzQ/oviFwCdeMkY4KnTkme6zFX4yMMzUE14s0CZ79CBjMVEnqjZ/6J1Z/2EtyC8IgkgHKyI0QJtfVe5+luNOMZFVtip9vmXLIaPWC2PgP2PEQeqk01xg0PpsbsqULZ0WjjzqagYt2RA2xC+RWjqrVpzVT7KprMJ6jOyNNtARbMvSQneMBjpiXdM75BwgEn7Vl8DGhIxFRGRdz7bLsAJas5zhg40CRTgQvow3gitZZwnqzLSNU45JJCkSMVWROTwYYUpczRE9T2kfszUPWpHDSO3NK5/M5ysp2Z6erDIh1+mcikVMqQ/mOQMjcANFpC9/Z8EoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqaE1SyekmHJc3gLjGyn6sEPd+um0NqBnn1hwMI6cps=;
 b=MZ21yEJUFwrZrLiL5+wlKofWzbGYJdMr4qQXbkQwfwE3k05jW9GNCuUT50XmLQgRc7XdMM1EyQYxtbdMMSlen8mBTb6e+KdFZvSrkVDHOhJkbwHf7nFNumnJmwD+aXuhFmsS7cERE0nIR/j+o+DFkR3tIyLIYfY2Cv8jnEZiZp2xWW0TMgz24B17li1ob18QOWTtTqY1krBy9SKixa+w0xtQwkw4Yix+YX8+FKXrijSunfFutThFLYhszOUZYbjstqIgftTqtTGhimK24xbkDQgvIHLCgjCd32m8R3Q0SwSjIhrE1kD9x0lqEfB3MHDY7usSAwyXQkC9WZvk5UfSpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqaE1SyekmHJc3gLjGyn6sEPd+um0NqBnn1hwMI6cps=;
 b=TFzQ2R4v7w2yzJ42QitgM7hVzMLoUJ3/CCWnuSFaDJKK/JoQHOX/6/BI8FZkc0LdBKtzhC/4JlqQdhS76aVUmFNYgfabro7HDjsVYX8rh4VkdWRPwdrqHxn5/5vTD0FeNSh70R+2rGXVbnT+j4GJ0/hIUCL7bNpo3GaMMYpNSsFzTpFnyqltLqtEOZ2Ck8AgKJKa2Eo/bqdPA8Pm6x5VBT/IiOBqFbbjxxDdMJp1zwmlYHOkoLCJlTdo8tTtuMcJiMCfsEvj0v1hmErAxVuXVaMRD9gYTZJWAE85xiVgl+okK0/I2k2VNxUjw+GFOLSxnujCdlsSqmwGhE/DPdwx5A==
Received: from DS1PR03CA0009.namprd03.prod.outlook.com (2603:10b6:8:450::15)
 by MW4PR12MB6897.namprd12.prod.outlook.com (2603:10b6:303:20a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 08:00:10 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:8:450:cafe::26) by DS1PR03CA0009.outlook.office365.com
 (2603:10b6:8:450::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 08:00:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 08:00:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 00:59:52 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 00:59:52 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 9 Jun
 2026 00:59:46 -0700
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
 <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH v3 05/14] migration: Replace switchover_ack_needed
 SaveVMHandler
Date: Tue, 9 Jun 2026 10:58:03 +0300
Message-ID: <20260609075812.32067-6-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260609075812.32067-1-avihaih@nvidia.com>
References: <20260609075812.32067-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|MW4PR12MB6897:EE_
X-MS-Office365-Filtering-Correlation-Id: 35ad7029-8575-4f0b-fd15-08dec5fd2070
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|7416014|376014|82310400026|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: dYjee91JquxzYwZdBIaoFbE6GLXI+j0rGoF6lnl/GKsk754JNx0EFYM0U1Ls+/NjukNrD6GJOovbGCGaFmoSouDzoR0T1ljS0OZu+xr6ihnwL0WOqam/vXq4oahoL49xUXi8eXy9JvLymWs++G2YraWj1Z/OPmorSl69Wktxua8ml7hCFyfjRHn8pYGwbTHTMIlvGk73Cl/3NprRTvXLGF5qekylq/6JeF5KTqqJ/ayIzln+lkxq3QZPPocAveJSBVkDs9XyGSbvvmhq9e4oZH3fPP8iuSQpD6gdFFaLsf4xUhmMFc1TE5D5L/GOmDcMZc1x5IdFM9tIUXYcsYxg+zqNNNQgcnWVgprmKTUz6muPRW8zxq1fVvUOVA8wJ9yWoniJdKCvg9tdE04tIrfojWIMeD/324IJrGYrDyuFvF3EdL7I7FELRc526ckwXAc8nR905PhXAKUREHvoWPEGVxo8JDPjVrynHLYsAR46CLaHJPIlIoblSh5bbMYHNUkMiYwlHUH/yZL3RpD6BFtMOllWIAk1oXkTBH1uj1SunBiHSWM2+AGcwBAg4Vgz0bZslCgmj6EHF971FSLTRlIv1cIw+BxL2vA54WZ+lkZMnAmEoUZun4XdbFdt/MSVrwTH2WRqHVNohR+WWzSMZYJedxlPCcpPxzCgpEY5q91VUz+DMy3VoAxqAO8yRNEfxOXV6TbuXGDtMScyF6sujNL7mkNeTKfpboX9fH/lC7F7qP4=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(82310400026)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /Fxaz3MSylN/eFvLyxtwIVs+jWmxYlgLRrbJPgwsEb69yYxmkCjNzCVaLyeob2bbC+Aa3XjqhyOaP2YurB4PqIbZ0/m1eJqYrqv5tuMJpowVgaSUVgLHLZ9ELVmtDllGzzyuWqUOzPEhfkGU0hd2qXWvXbfZLjKe+u9bE8FOOTSCPckfwa1ocMKsR3LKcqPXhjueLHzFNG0cMv+chf7UZQ6Ngu1mSdhK/pZMg3udFseXn5TFdbP2PoXUz8LIiKHkeUDSq0xv9QrmRIMDhO09t9l/cqxmz2al/nQGrhK00ZhJgpCctXVsjKG2U/P/imn/ovcwZ+J2OMq2I8sJtuxnHUUOHo9Ln+FhiB6T9eLfG6zVNiat2OW0pp8VuLfobcdXi+GuT8eWPcdanf9+jEs9ahbRmbrROBRK8AFHZbRe9khJ1Ap6AAjd9nhuxvujNmbL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 08:00:09.3549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ad7029-8575-4f0b-fd15-08dec5fd2070
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6897
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=avihaih@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
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
index 929a6c432c..d6383b23b9 100644
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
index 8ff6c0b17e..25afcfd71e 100644
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


