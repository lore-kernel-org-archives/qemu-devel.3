Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E89CD8CAD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:01:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWrOM-0004qL-A1; Tue, 09 Jun 2026 04:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wWrOK-0004kN-Lu
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 04:00:56 -0400
Received: from mail-westusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c001::5] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wWrOJ-0004mt-0I
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 04:00:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qsa9f5ySrXE5Jb3E8M2ISeKAKFU50FKHP/8ikhIvnLSQ9WJ0tRzV0zuCkNftArf0FteMKu+IQTvxk9ymU3caa1loWmU7fgnHzK8GtHBqM8Gl/8otLPj5ZfC9KQ442duNY4Qh+HBL4Vcoe9PEtWVC5e4qOc15aNTpoGyt/O8mUEHL4BIWenhg0lqkRxoTZrR3N+VZpeX6ZDS5SjIkQQX3IMxzfmERaDmmryjmmKkyAOdtImCIgB6epVvJlsPFd+AG/3/9N/b53Z31bqzs8iwmawfizzKALfKWSxH6Z4FEKZJpqhxsHozXc0uiisrB2wl1G05XYn1D/Kf6Tq+bpEApYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6G36LfBqPWIVOHutzdV8Y5d6qlQPN9Su8FzrZVLpxM=;
 b=R68KW+w7wdejYQ3FFt7WliHiWIVnhpNOATiHwY025uQqsTRXYpYZdFKgepk4D/u47FRggJGQFj4G7ZHoPrRix+Wr12VkYh/mKYrZryENthYa++TyvpChhyxMvwa7KLh2e3aTQdbQbw90vZ5gWwyHLFj39q/KdeW0Z+ommWiEN264D4CzsdLHAaqWs0oQJJ9PzQwUT/HHeYrePmB+/7iUs+ltV9ycsAKcQXny09Dg7a5egnN6H7r0WCoyL2QRVxpi9uJi4xQEybDIZUYTRxYf6vSM6gBSFL+C9D4IoAULFselIqAevMUdUTQCzqQ1T+GTnL+4O52tCzYJIOFXTmOUvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6G36LfBqPWIVOHutzdV8Y5d6qlQPN9Su8FzrZVLpxM=;
 b=h10lsapMzEjZ2/FQJrE4sQJirYVCp9abS91nC8ThXN3+MjnNgbs+HavZ1M7L1M6cx6oISdJ5I8ywn21VL5T1a4F5LsF73vO9w+DF7HEs1UDeKXogIBnldpewhZQGAU+41+iEzNZauo9fuFCmvWDsLk8Vabd6IcrzX+6iAot4UHGxLiNJN/Xa7DNn+RjQkOnjJPZwyDG2OYyFGXjLji4uGtMcF06lsMzAC2IgANA3qMDoZlFny8lBpABdWJuQdko/b9KBVVdIU2WnoP/YcENILsS1/5KphUVXGaysYKMjqGlUahNtgj5w8yCAz9BBsXMfuyaT12yH/GaIkKZCCjllVg==
Received: from MN2PR18CA0012.namprd18.prod.outlook.com (2603:10b6:208:23c::17)
 by IA0PR12MB8350.namprd12.prod.outlook.com (2603:10b6:208:40d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 08:00:48 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:208:23c:cafe::77) by MN2PR18CA0012.outlook.office365.com
 (2603:10b6:208:23c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 08:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 08:00:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 01:00:25 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 01:00:24 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 9 Jun
 2026 01:00:19 -0700
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
Subject: [PATCH v3 08/14] migration: Fail migration if switchover-ack is
 requested after switchover decision
Date: Tue, 9 Jun 2026 10:58:06 +0300
Message-ID: <20260609075812.32067-9-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260609075812.32067-1-avihaih@nvidia.com>
References: <20260609075812.32067-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|IA0PR12MB8350:EE_
X-MS-Office365-Filtering-Correlation-Id: aff56531-8289-47ce-4454-08dec5fd3695
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|7416014|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: keIw2kRL4H8xPgFdJimCUHIA4GRRtm5Pg9MCZyqUYLEQldV+dErPD5ZdH8YrTAHkKKE30Nu8k53GDKdyCCW3i7b+fKFuj5NWadCTBplVA9rChOx5ih6Y3ncTtXHGbeJnSEL/9BvCHJbGAXf/seaq99YSRoN5MjgVN+wb2bXcpA7z5as+EOB8Qzfe0qM06MTSki0192vzfCfHKxbZTWEzEnctZd/QkPw3LqSn2A8S0TViaPKBK5X8lFNRMmXOLP1WdwV/KZlM7MdfjR18FAF05Ks1kbV0RCK3KNzLjBi3Y9ns2+jTg/k9QTA0QZNXWvsr7/lhsWd/QSFk3x1ZgMGnXpbB4nAoKIldwh0LRpep0CqOGnZ6GOLPi762XIylhhGzeVMqolFaI58hI+T17hW1RbfoI61UC4ZOiTGF3uupXWWfruPGQUmlxKeaM75Vs9gajDdOr3DtVXN+0GdZarKf5SJEVxdII//8eqsOqHhglu+nzmYKnrwA8AwYiizS4R5sPiHkyb3zkAf0Jwx9cC55VryqNH5lg5sY0oqK9dCrvAJWhBeAYxAWmPlGYssiBgDg+Dv+aWr8eZvselPDE4sF/1zoB7Ngnmm/+x7vHFgQmEEI7YlZu3uRKStaRWt1GG+UG9h+zoeL/rDWdR3h6MQ/zLWppoWERb5CETOSOexkBh1qZqabTYoKbVc+llRkVvPH3/7/oz8DL/+hsxZykujmb51A0vJezVYXS0RKaRtyvBA=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: neHshY+jkCx/EVYYKFta4gwMTHHfrgtnWh/5u2epIw7XDQuf/PFkRRWqfa9vPgxdNoM1L/HB7d7vv+At+dy3o4Gym0wOA6WyhVxZ7FWbaNqcUNFLIETxANwvqPdmFelmeAFp29Usr7V7Kxcawbau4L7AMMAv5mGiqBdYm4Pl8u4rUOB2ynfeBYNjZKIIsIaMboT3X5N7F7vW7oxpkGAPYMeMqfNOOzUviQh2lXAMneeGDJPDyuw+fk5ZdnnJq45/L497TxweyCjNAvtGXIbWyMUq1trks/RFNcVtld9hFnw5pWw8/qkmhhKhLxrdZVbpafQ7XJyOKTrTDSL7GGVzVr51MwlTewL42yrU2QHghvCW1G8b2iXTuos7QfwzTvhfVaLAHGSQX60HyOCLikUcjW2BEGju8ptL8aHqCxIwQ2oe0XTlQe6BgIDZUEk+CWwC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 08:00:46.4282 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aff56531-8289-47ce-4454-08dec5fd3695
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8350
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


