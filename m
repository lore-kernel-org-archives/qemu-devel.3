Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 895E9CDB46B
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 10:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbbgC-0005hD-QC; Mon, 22 Jun 2026 06:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wbbg8-0005dz-7b
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 06:14:56 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wbbg6-0006Ta-JZ
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 06:14:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ARRe2mjODmyfescEiK6Vnx7UjHX0ahXqOafUoM/DQH0IRmJaU7HkhKQsD3SH6p57n6IaqDZaYsdGBj+u6r3aYg78AXMFAg1ckXXYFeVsNiNGQWis7AEudkrYhm2XaYEFpZvH7KPw1mSu1PZeNb/V0uWdqF7AJEExpmgkRyK6Qen67+L3NFyLNcqZY6R0CIe54CgpJ8I1wf+TrulAg2c/zvOsVsTgFW9PUKak/Ks6rQKW/ccVGOkhUnHdV+QAA1gfkorjGrVNC4LyyyhtTSUCMcbBApaNUPfYEnt4bYnYrLQWSAgHxpEumQrCvmSPB/bwblXRU08QpHLCohBIGicYCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0m3pvzpc1c5Wd2i3+SqLVcW995KEG9bZECsPOgrtJA=;
 b=E97KLB2/Cdu7ZUa00g4U3pl6Mdf3F9xLt7DMGTKwhxBuDnlyN3A6Qk4FKmwCEli9cJuB8uiR7vx2fvUiOlHjZyrWPt9ORFkGO7MMkhe3zk/c5HKFSdZcQdpUBUg60rlpYxrK9//1EpQpRCCx2j7rsj7j0BPRTRchEIlqBCsVrD0M3ye8PWwzSR9QV9Klu0yE/7I6BOIKqZwlfck1s+4LPWQrxwZP27DckqLWSOpR1WWQr8r3DQVTLRvyGL213BeR8kGCBCi8cklFL0MXtZYXvYk1glVIu0u2Uoe2gwzOfOj6nLFLHhOun9CtUAHM2qSOqMs4IDLUzOlhSAXw56etmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0m3pvzpc1c5Wd2i3+SqLVcW995KEG9bZECsPOgrtJA=;
 b=qw6cTOKzqSRPOzjIXiuROgIvtEwwXtntxpeW/jL/3mIqvJnPooGaSHSFmLZRWSATXUC3sz9tRG9+j64i71COtZcO1tAN1b5O+5CqQ5JssxZfhtE7VmECfNbRAN3P1FyEyAVWWzb95wogBkSvQgCbeCcSHcPUnD+ybA/uyHaDZAe7vSBKodICAHUbtx5QaGGv9NG9zPyqDA0A+Wrg5J1uW95IzvEfpPkdb4kzwG/So63Mxo9jxHTK617jR+dWwL+9KzuKxVj4tkiq9OVuCpHuX8Q/zed6n8yCkGQNlmmV0Nv8TnllALYhYYm0SVNZe0pINx9V3jBOPiT/GEDMjAnN8A==
Received: from DS7P220CA0109.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25d::6) by
 SA3PR12MB7805.namprd12.prod.outlook.com (2603:10b6:806:319::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 10:14:47 +0000
Received: from DM2PEPF00003FC9.namprd04.prod.outlook.com
 (2603:10b6:8:25d:cafe::8f) by DS7P220CA0109.outlook.office365.com
 (2603:10b6:8:25d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 10:14:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM2PEPF00003FC9.mail.protection.outlook.com (10.167.23.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 10:14:47 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 03:14:31 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 03:14:29 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 22
 Jun 2026 03:14:23 -0700
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
Subject: [PATCH v4 08/14] migration: Fail migration if switchover-ack is
 requested after switchover decision
Date: Mon, 22 Jun 2026 13:12:08 +0300
Message-ID: <20260622101214.25770-9-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260622101214.25770-1-avihaih@nvidia.com>
References: <20260622101214.25770-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC9:EE_|SA3PR12MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: bbab8e8b-58f0-49a2-1c08-08ded0471698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|82310400026|36860700016|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7AY4uV9yRY0QTkGs4wrJxeJgNYcAinDoPWGusx0uUwcAyVvnMDeGpLxD5yRXkYOGB72XyiXrAa/e+SGOw4LdsV/2zaCqBfOAcf1NvptvVXw4lFtiFc9g2wDh4mDBsPcp2aoCc4h+egI/7E/fPqTidjy9P2N7BQMElq8aZZ3oyLdk3tRbs4iPq1s5jazEpkI7lX6IvpDXDfqleHVR0jqDgGUBAY5qw9KE0sC+8/o+xJtg1kc9h8XBcu7qbyjsMRyiwmu2YocExlCMpaX5Ety23vcl9M/crvBmFGlqrIbTDctF6EWIT3oGNPAdj1/oHkCRogir5v3niScyTxDtGATML01xWZgD+xNtYeml2C87ln0+RYsO7BlSqDWen3pw0S+3L6sfUHJkup5KDyv4/jfU4hAaqxT7NyVCeFafPxXVC2sQD95pUIcedCE0qUQNq2ToLiRRukBLzufSQIqde9JkXVeYP2De6C3GDPP1AZ3UR9xA1tM9CA/Z8AVqe7y8KrgG5UFPIB3VOM33w5Vcr1smJ/PrOfmj5w/C0g5puEdT5Yn/Rp5axkk/LiX5zQCZgVT0SiW/faEPXB8NatPdR/AiSK8YqAegNZHa59MdXoZ4/FFK8nDPZxZ6IQ3NLqsrLYpN8xf9m9kmXtJ3N96ndTXRsQXv70LTwm6poI0ZXzJBJCwx0rPKWWSs7fc0QZHKU0+5Z4HOZTL+QndidwEGeaZ4iA==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(82310400026)(36860700016)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: U06ZHS2myVD2vVyoTpcOJ7wMJFZOUVw9lY49mTKMunJNoAXoCi6ywSaeUudj3VPa5lSI0FwsDXpEM0yhX/+XlnFkYV5Ks26gbYiBFqrGvjdyM3NXGsdMPiLFLAOi+YLJ7pRdTSgDrgdF3WgdFmKWggfLBmLpVhduednddZ4b4d9uwEP6aX1dqmWMt/lk9RzuGj2ettYtgz4EorNTLs/Uth0nyzuT9rW0J779p3Q++ECEHxaExDDqAAE3mydfTsS9Wtw1gm7INPcMkc2y2/UM0VaIBStznLTZV/uZRj7tYQXUd7I57axC4AHvyS45F0lZTWXynN0xvB4g5DD3NeKjquVml+5zr7ml1ftqnnmEf45F7Hecc+6Uowyy8Eq20gKtiozmJov9ffbTf9OFQWK+4jkrbjsoPKgYBCRFWNv5gZXwXPFVD0cniPq4HDtXcemZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 10:14:47.2172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbab8e8b-58f0-49a2-1c08-08ded0471698
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7805
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=avihaih@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
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

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/savevm.h    |  4 ++--
 migration/migration.c |  4 +++-
 migration/savevm.c    | 19 ++++++++++++++++++-
 3 files changed, 23 insertions(+), 4 deletions(-)

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
diff --git a/migration/migration.c b/migration/migration.c
index 60493e2c10..4c20378ed2 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2827,7 +2827,9 @@ static bool migration_switchover_start(MigrationState *s, Error **errp)
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
index b8c93d86d7..6737058021 100644
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


