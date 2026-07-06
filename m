Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E5CC44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgf6b-0001rn-Vu; Mon, 06 Jul 2026 04:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wgf68-0001Pg-VX
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:54:41 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wgf66-00076v-T8
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:54:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MtwieprUYOrgQsSQBVMuDgmxPp79NEMrHsu6VzAdEiqCoP/AajRojcMmlDIsEnnl6dbZaLSqlpbIBjofPiUtGcgWqCtjm+CvqXb+c0VS1eNfim6EmTuIb1Pn/5b6HX06ztlj63iM/7E4SFpstUyTrj9pffxy+Mafsl7f68KcFZq6Hx2shbnoqJvWEiDUleQic6UgehVomFC+5yzunJcCToABuQS+Z93QV6QL4iPtNs6VwJnQ3bLN902e7IVx5MYzkN6ljHdf13GbF2yqZnGA4zR5mCvSd4q1isth8cCX1lck1wH0Q4GR2vQ1bURyhHPfyAcSMw8YVXxXrMnrPc3SFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+MhHTTX6ybIFzCnfrYjbm2Av8ZbvkLSvyurTpMj5D0=;
 b=j7oF26j/PeLJU/rSvFLanDLGWdTsD8va+HynxQnPcQyB6oSZAqpSURp6W9Tft6BiLnm16Q0POjEWhR1W6pIQQV40t73NTiGwQROYg9hc/uxbjDuf1G0IiEEZrRBoNu9gbqw60OyCVqCeGPah+jUh04b5+sFh0ni78Fz0zHIFGzWCdvLct1a4he2Lss34QdyR502e9FrCqeNDZGvXX5Q3EIbQaKEsBmb6/cZ1cPe4thXYNgRnemVs6PqNeDuuZF40b9S0LWLUCfF2tX+O6/bc6KY6avDKnN5rXXJ9oKWP83Vzn1bt6uEE2quluHkvs7VEHU7fon+TdP+WfggGu0Pbyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+MhHTTX6ybIFzCnfrYjbm2Av8ZbvkLSvyurTpMj5D0=;
 b=mt8PewdAJ+KXwJCYtaA1tjZhZ6jfbZKktC+Zx9slGM4KWB7/6z8zJEwlFa0jaJQeIYQjPsss7R7DNngFZkeJ4q/tNb//mUVEnQvd0ile5mn1bL8LR3NSCpwRW0fIjhUEpfFd5jFbrT6zyE1um2HBseFkVrQAvV9eNmv3ILSCNhgqDtTOpQATsfwgaSD3GVuA0NzhpvnRGutFhauA+Zkps4nD9YtlfmbsCrAzLQla21wwtD+ZL5BnK3Tw6MtEWGebOVqUkTttYsLfswwjxB+toZdwshETiko7aAdpbFI1IKW1Hdn++plnPO7iRtNTRutGsArhsEPkTNlezhnhIQ2MLg==
Received: from CH5PR02CA0020.namprd02.prod.outlook.com (2603:10b6:610:1ed::25)
 by MN2PR12MB4288.namprd12.prod.outlook.com (2603:10b6:208:1d2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 08:54:33 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::83) by CH5PR02CA0020.outlook.office365.com
 (2603:10b6:610:1ed::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 08:54:33 +0000
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
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 08:54:33 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 01:54:19 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 01:54:19 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 6 Jul
 2026 01:54:13 -0700
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
Subject: [PATCH v5 08/16] migration: Fail migration if switchover-ack is
 requested after switchover decision
Date: Mon, 6 Jul 2026 11:52:03 +0300
Message-ID: <20260706085211.13905-9-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260706085211.13905-1-avihaih@nvidia.com>
References: <20260706085211.13905-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|MN2PR12MB4288:EE_
X-MS-Office365-Filtering-Correlation-Id: 717e6c86-dd0a-42a8-55be-08dedb3c3303
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|7416014|376014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: rqlbU/7XbZALYE6VvOFaM3YgCmuUrT9s1zwJcJnD61Wpx6qIFZnMZAKQXboEh7tiPuNurFVooE+f5UBgKlXngUFQQQEk2j/7RVKKljFNR95FxKNG6gWTYENVwDOIzeniuDMO/67O4h9piaYEQJ7xq+Ldt4tHVlkAtX9+eqd7o/v/1vXExcYRSjJ+AlYJ24OhtaUihP16z6Fq9mhF/FxBJ9QbQ+dk5jv235puRx1GmaaJMlY2nUVlyVMNiae+eyY2cYO6T4SwULD1ENt4L8prBOy/MTpgmATbr3g6j3orz5PBTpJrGbECKmMCBnBpM9L30Ahw3FKTDU4QeJl+PdbzRW5RXj1q/yJupdZp+X1ccuRRKwtYdQFT3KY8m7d1fKQw8tNk/lSg5GP42GGdWeYFa1OfZL7MuCORrK4lVqxyj4rfhYb0e2o0D+YfGx4poWW0bXwP9ENQCpDkVgNOCMDLDFHGSsBWFoVdyBs/NwjNk/zygxrC8rZCxtTcw+8sRFfSAJueeQHvFdG7tJGTkhQuozOaSwe21gd90/mcsPab2VdWkVgXEsusHICiqhf2UBPHVmbBqMF8LFD0XCEaw8tK1kw5BybPqHpmeBHBEQ00zuOOE/sqzdAvGhUFnw34ijKajef/+53KSn9R8l0P+s2xV960yEGEq2J8u2UCpikl4WkGvm5JXx55rzUlw/XkbNYN00XFPLQYgqEfNB88+1gBHA==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(7416014)(376014)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hhUifZyxEVbDBkIN/V4KgZXe+VkEKYYPtAjIYoosQyGxExAUYHe5VyOot+2/xl+NOSfJlDhppIiRMW3rSDH+FqvkceAFhZ1V/kYUtv3MAtNhyxyFaYAb2cxNVb9C3xdftgNc523IYnPhDvWBnVNR3cSOZ/AnJJTYiJ1HIlN/MY6LoJywaGj1pU5YNHPTLX5IHAYpUqo5UIYWAu1qYmZCicaaZURKpDxrL0c1etSnYvrBwy/yu4N8+sWzntZ4oxxXUyMgSZZwNUmF5Tzgrwe9LER2Nul1towIkkl3nMRuj/gR13YYzOuLoLT76GRoCAsokjkn1l4dObSZbBfBfQSGXOHEwZWSXz79+NNflEedbKc6N5SFcko99VtvTbB9OhFnn/kTJKrp5W4knBnuCLqToxhR+oGwXHpUcPwA2osGjnrPPvNbJMG6C7VTLPCyQyVF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 08:54:33.1883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 717e6c86-dd0a-42a8-55be-08dedb3c3303
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4288
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=avihaih@nvidia.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
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

Switchover ACK is checked only during precopy while the guest is still
running. The last migration_can_switchover() decision and guest stop are
not atomic, so a device may want to request another switchover ACK in
the gap after switchover decision has been made but before the guest is
stopped. Migration would then miss that request, which can increase
downtime.

Cover this case by failing the migration if a switchover-ack was
requested during that time.

Ideally, precopy iterations should be resumed in this case, however,
VFIO doesn't support going back to precopy after being stopped, so
implementing such logic would require non-trivial changes to the guest
start/stop flow. Given the above and that this case should be rare,
failing the migration seems reasonable.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/savevm.h    |  4 ++--
 migration/colo.c      |  6 +++++-
 migration/migration.c |  4 +++-
 migration/savevm.c    | 19 ++++++++++++++++++-
 4 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/migration/savevm.h b/migration/savevm.h
index fb92d3bc85..415198423f 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -47,8 +47,8 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f);
 int qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp);
 void qemu_savevm_query_pending_iter(MigrationState *s, MigPendingData *pending,
                                     bool exact);
-void qemu_savevm_query_pending_final(MigrationState *s,
-                                     MigPendingData *pending);
+bool qemu_savevm_query_pending_final(MigrationState *s,
+                                     MigPendingData *pending, Error **errp);
 int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy);
 bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp);
 void qemu_savevm_state_end(QEMUFile *f);
diff --git a/migration/colo.c b/migration/colo.c
index 0cef0f6b0e..0f30a5926f 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -473,7 +473,11 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
      * state is saved. Unlike a regular switchover, COLO reaches completion
      * repeatedly for every checkpoint, so this must be done on each one.
      */
-    qemu_savevm_query_pending_final(s, &pending);
+    if (!qemu_savevm_query_pending_final(s, &pending, &local_err)) {
+        ret = -1;
+        bql_unlock();
+        goto out;
+    }
 
     /*
      * Only save VM's live state, which not including device state.
diff --git a/migration/migration.c b/migration/migration.c
index 2b625da114..98603ee19c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2833,7 +2833,9 @@ static bool migration_switchover_start(MigrationState *s, Error **errp)
      * properly update all the dirty bitmaps to finally generate the
      * correct discard bitmaps; see ram_postcopy_send_discard_bitmap().
      */
-    qemu_savevm_query_pending_final(s, &pending);
+    if (!qemu_savevm_query_pending_final(s, &pending, errp)) {
+        return false;
+    }
 
     /* Inactivate disks except in COLO */
     if (!migrate_colo()) {
diff --git a/migration/savevm.c b/migration/savevm.c
index 1f6e696c50..f654a1c563 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1852,11 +1852,28 @@ void qemu_savevm_query_pending_iter(MigrationState *s, MigPendingData *pending,
     qemu_savevm_query_pending(s, pending, exact, false);
 }
 
-void qemu_savevm_query_pending_final(MigrationState *s, MigPendingData *pending)
+bool qemu_savevm_query_pending_final(MigrationState *s, MigPendingData *pending,
+                                     Error **errp)
 {
     g_assert(bql_locked());
 
     qemu_savevm_query_pending(s, pending, true, true);
+
+    /*
+     * Switchover-ack requests done after switchover decision are not allowed.
+     * Fail the migration in this case since we currently don't support going
+     * back to precopy.
+     */
+    if (migrate_switchover_ack() && !migrate_switchover_ack_legacy() &&
+        pending->switchover_ack_pending > 0) {
+        error_setg(errp,
+                   "Switchover ACK was requested by %" PRIu32
+                   " devices during switchover",
+                   pending->switchover_ack_pending);
+        return false;
+    }
+
+    return true;
 }
 
 void qemu_savevm_state_cleanup(void)
-- 
2.40.1


