Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02169CD8CBD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:00:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWrNW-00024L-9M; Tue, 09 Jun 2026 04:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wWrNU-00023w-C5
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 04:00:04 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wWrNR-0003iD-OI
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 04:00:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IhfZuCevmFFtejKbsy1n7WVSR50D3yedI3hXhYd8ZaF9LqrJ4Z0/eK4mgWiXytChKiIJfnwiOWF82sIVCuveXOWRkOSCOwdAjXhVgnZW7DA05JGk3PmTeVYqinbGJ6CMMW6oULbvp5tf8kn9HWRRZDsfbmotT9HdVXKu0jLFSOsNKKl/+Tg2FpnEoIfE21kczyi/G8bQT617KAOyBcEmO0ruuPJS9gRcLl4gT2x2bBYLHjFRIbf/mxV7gs0eG7mk8E9GFn7I9jsWAZIAXoQojdmr5fPHDTbbQqifTdyvkEZJ6Buui4tYUT2/mg/J4oeCRXAxurvsR7c7EQqqHEKw0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAwD98U32mbbZi3g+ttP0Biv1lW/8Yr+PypVnjpbCPI=;
 b=M2OY4E2gnTsF6E28Wq8S0vR1RT/tXPDozsmCKhvF41TzuHiPIJxGrmTBNd1RA/OuzsgfJn8+mU/1ZU9q/0oAtiD71pE3fVSfK1O/yeUSeK9tl1HaMCROcj4g9UBHkW6SlSY72ZHdZ6BHKMSJxbcY1ugpI7FMblrh1WAkMxzbpJRTHuT5UqtqPDjLcDGXj9GEA2j50Y2k/J36oCs/LyEbV2HeNynxqfoIzto7v2GrdS49s3qHhU2vQBePzsKO4+JxrH7wn9ZDPJ+/I8u5A2kjnIp5aPQpOO4xeOEHR+xviKDFDEpp5MZ7WEq1VPPQfoBE+QOXiGwrjvq0XKURY3+Ygw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAwD98U32mbbZi3g+ttP0Biv1lW/8Yr+PypVnjpbCPI=;
 b=M6J5fHdjyTZaKqIF1/zHs/FVbJx4zqmsiCzvGI8iHnB9jgIFrFoD4JTvzKv8UdfEa5iIl9lHfr21AP3lxrdRjwYrZbSpwYEKVvjcloGWvZeSIACRfstsX706BoYQhG4yXJuZ3PwuS4cqkaDZRwpRehQMuVtG2gWBILLsnO/XLYVqLOA6Iz0T69igsExJoIPQU5i7g3pTPM/kj1vWDyvKppJWq4ACqcPThnf2oFp+nOmLJ4+jf+OTz+BltSsdJOV08M637OMWIBCWXxPKldiVzM3jwAuLy7Of3s+vU8d7AnmXOwqN1/ojZKgvEjNTAjyKAm5u43kPa0XuhHWMZ6oHdA==
Received: from BN1PR13CA0009.namprd13.prod.outlook.com (2603:10b6:408:e2::14)
 by CH3PR12MB8755.namprd12.prod.outlook.com (2603:10b6:610:17e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 07:59:49 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:e2:cafe::75) by BN1PR13CA0009.outlook.office365.com
 (2603:10b6:408:e2::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 07:59:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 07:59:49 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 00:59:32 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 00:59:32 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 9 Jun
 2026 00:59:26 -0700
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
Subject: [PATCH v3 03/14] migration: Run final save_query_pending at switchover
Date: Tue, 9 Jun 2026 10:58:01 +0300
Message-ID: <20260609075812.32067-4-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260609075812.32067-1-avihaih@nvidia.com>
References: <20260609075812.32067-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|CH3PR12MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a7304b7-a8bc-4b67-e008-08dec5fd1491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|7416014|376014|82310400026|22082099003|18002099003|6133799003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: uimKNfDzRIZqjaho3L7SS59Xjee/DW+FGz7CyIHOOH8N2AlCiDMWV1SfFbmYOyXje6kFNSaPh5csGrnUzR5qENCyWkLD931Bq5WEzrW82j0b52SqQSMCsBDRDWWYozYqqakerFkBeX4eU+K7rLWSV0fxorZ+MjTqFbsfSkFaMSxi0qln0Y8Ks6u5siTd5F94DZfRRKH5zPFg+Jyi7Rjlrr2yy/iSoS1RyUymzpDw2CDdiXnxd+Nn4lWfOVc54BrqseIJAiFoj9bvYaX+cYr9AejIwrYx6oSFE/47BkO2/8QluNY/Zlc0CbsjGC+iRS9YSfd7YkTDuOkXCZayi63cxnQq21BEEil/t00oJU9W0hDMlz2ZvQSWYQGnXUHaH0xOpFivNJ4LjjLbc3q0C6FkywwP86ENMbv2kdrS/EjplTE/VjS4iWUQ0vzqCZJCeop1ZBS93WgaIeuxc57Q3cSc+hTXR7Y5Qng0IV6e3pyRHm+jFTSPpzGXp+S6lSqNLJvTw9RLpfQ1MZk20J5y2KBvsd41IhqgtvBl9wdtsOyb3KXjqig2H/OcT/vdBtPo5Wdl4jR/DzVTdFy6AMNMX1Qw0+LJA2PmeVNZ1qe5CCFpis1F/bJCLD1SbN6FOgv+G8UhdBuGwItRAFBt9ibAo7PN6W9j1t8BXKN5ZPF43LK5b9fWSjpkbPrIhMSryJ1JqY6S0evJ83r9V7/uzo98+kuVTAATQIrGC6yG41OTJDA3hVA=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(82310400026)(22082099003)(18002099003)(6133799003)(5023799004)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fPN1kiR+REvW3ITK+7mZnTOC8DO3Bo40oXK2YnsEknT4vxYMhmHkRdPWo7HK64Xn3EQ6K271OnwN130tMeRNbSFE74DVIb5JlHwHD36PvE64/jsKpK0LET8CKa/Ab4NSP+tvDun5bA1RR9t33WcTUiz69pwdjtZbwpNKe1eFu95yEFEMtZIZkEMSQc+TbdBTXuKoyKn67+t+EhgeyaykicHiD+x7j0Up7siYql9S62zSFbHzP77VGFcyxAEj+NAr2ope7rVtcTYkmko3j9cy/Gz8TxcJ7oLX/J7kw9Kk9CY5kAf0XoYFo6cwVj6s8f+/iK0Aj8tXmHLI7+raJt6u1iq53vE/n54BX8lsXWHSEHaeytMBFv5CBaM6wafgbOlTUDyZphybOop8gtJDBF8G03G4wgxQNwJH3nYd3LtvVPv85ilGLf86h9HPM05x6QH1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:59:49.3896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a7304b7-a8bc-4b67-e008-08dec5fd1491
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8755
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=avihaih@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Before switchover, the source needs one last exact pending query so
modules can flush dirty state. This is currently done ad hoc in modules
handlers. For example, RAM syncs its dirty bitmap in its save_complete
handler.

This should be a general concept relevant for any module, so extract it
to migration core instead by running a final save_query_pending before
switchover.

The final query requires special handling by modules (e.g., it's called
with BQL locked, during VM stop), so extend save_query_pending
SaveVMHandlers callback and qemu_savevm_query_pending() with a "final"
flag so migration modules can tell the last pending query during
switchover from periodic iteration queries.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 include/migration/register.h   | 41 ++++++++++++++++++----------------
 migration/savevm.h             |  3 ++-
 hw/s390x/s390-stattrib.c       |  2 +-
 hw/vfio/migration.c            | 11 ++++++---
 migration/block-dirty-bitmap.c | 11 ++++++---
 migration/migration.c          | 14 ++++++++++--
 migration/ram.c                | 40 +++++++++++++++++++--------------
 migration/savevm.c             | 20 +++++++++++++----
 hw/vfio/trace-events           |  2 +-
 migration/trace-events         |  2 +-
 10 files changed, 94 insertions(+), 52 deletions(-)

diff --git a/include/migration/register.h b/include/migration/register.h
index 5e5e0ee432..6f632123f1 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -171,6 +171,28 @@ typedef struct SaveVMHandlers {
      */
     bool (*is_active_iterate)(void *opaque);
 
+    /**
+     * @save_query_pending
+     *
+     * This estimates the remaining data to transfer on the source side.
+     *
+     * When @exact is true, a module must report accurate results.  When
+     * @exact is false, a module may report estimates.
+     *
+     * It's highly recommended that modules implement a faster version of
+     * the query path (for example, by proper caching on the counters) if
+     * an accurate query will be time-consuming.
+     *
+     * @opaque: data pointer passed to register_savevm_live()
+     * @pending: pointer to a MigPendingData struct
+     * @exact: set to true for an accurate (slow) query
+     * @final: set to true for the final query during switchover. When final is
+     * true, the query is called with BQL locked. Otherwise, it's called with
+     * BQL unlocked.
+     */
+    void (*save_query_pending)(void *opaque, MigPendingData *pending,
+                               bool exact, bool final);
+
     /* This runs outside the BQL in the migration case, and
      * within the lock in the savevm case.  The callback had better only
      * use data that is local to the migration thread or protected
@@ -210,25 +232,6 @@ typedef struct SaveVMHandlers {
      */
     bool (*save_postcopy_prepare)(QEMUFile *f, void *opaque, Error **errp);
 
-    /**
-     * @save_query_pending
-     *
-     * This estimates the remaining data to transfer on the source side.
-     *
-     * When @exact is true, a module must report accurate results.  When
-     * @exact is false, a module may report estimates.
-     *
-     * It's highly recommended that modules implement a faster version of
-     * the query path (for example, by proper caching on the counters) if
-     * an accurate query will be time-consuming.
-     *
-     * @opaque: data pointer passed to register_savevm_live()
-     * @pending: pointer to a MigPendingData struct
-     * @exact: set to true for an accurate (slow) query
-     */
-    void (*save_query_pending)(void *opaque, MigPendingData *pending,
-                               bool exact);
-
     /**
      * @load_state
      *
diff --git a/migration/savevm.h b/migration/savevm.h
index b6bb4fa977..81abd96dda 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -45,7 +45,8 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
 void qemu_savevm_state_cleanup(void);
 void qemu_savevm_state_complete_postcopy(QEMUFile *f);
 int qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp);
-void qemu_savevm_query_pending(MigPendingData *pending, bool exact);
+void qemu_savevm_query_pending_iter(MigPendingData *pending, bool exact);
+void qemu_savevm_query_pending_final(MigPendingData *pending);
 int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy);
 bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp);
 void qemu_savevm_state_end(QEMUFile *f);
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index c334714b31..b0f04eb30c 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -190,7 +190,7 @@ static int cmma_save_setup(QEMUFile *f, void *opaque, Error **errp)
 }
 
 static void cmma_state_pending(void *opaque, MigPendingData *pending,
-                               bool exact)
+                               bool exact, bool final)
 {
     S390StAttribState *sas = S390_STATTRIB(opaque);
     S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index fb12b9717f..195498845e 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -622,13 +622,18 @@ static void vfio_state_pending_sync(VFIODevice *vbasedev)
 }
 
 static void vfio_state_pending(void *opaque, MigPendingData *pending,
-                               bool exact)
+                               bool exact, bool final)
 {
     VFIODevice *vbasedev = opaque;
     VFIOMigration *migration = vbasedev->migration;
     uint64_t precopy_size, stopcopy_size;
 
-    if (exact) {
+    /*
+     * The final pending query runs during switchover downtime. VFIO does not
+     * need a fresh device pending-data query then to get the latest dirty
+     * data, so avoid the extra work and report the cached counters below.
+     */
+    if (exact && !final) {
         vfio_state_pending_sync(vbasedev);
     }
 
@@ -646,7 +651,7 @@ static void vfio_state_pending(void *opaque, MigPendingData *pending,
 
     trace_vfio_state_pending(vbasedev->name, migration->stopcopy_size,
                              migration->precopy_init_size,
-                             migration->precopy_dirty_size, exact);
+                             migration->precopy_dirty_size, exact, final);
 }
 
 static bool vfio_is_active_iterate(void *opaque)
diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 7ef3759e53..cba54e25cd 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -767,13 +767,16 @@ static int dirty_bitmap_save_complete(QEMUFile *f, void *opaque)
 }
 
 static void dirty_bitmap_state_pending(void *opaque, MigPendingData *data,
-                                       bool exact)
+                                       bool exact, bool final)
 {
     DBMSaveState *s = &((DBMState *)opaque)->save;
     SaveBitmapState *dbms;
     uint64_t pending = 0;
 
-    bql_lock();
+    /* Final pending query is called with BQL locked */
+    if (!final) {
+        bql_lock();
+    }
 
     QSIMPLEQ_FOREACH(dbms, &s->dbms_list, entry) {
         uint64_t gran = bdrv_dirty_bitmap_granularity(dbms->bitmap);
@@ -783,7 +786,9 @@ static void dirty_bitmap_state_pending(void *opaque, MigPendingData *data,
         pending += DIV_ROUND_UP(sectors * BDRV_SECTOR_SIZE, gran);
     }
 
-    bql_unlock();
+    if (!final) {
+        bql_unlock();
+    }
 
     trace_dirty_bitmap_state_pending(pending);
 
diff --git a/migration/migration.c b/migration/migration.c
index aad23f3228..929a6c432c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2787,12 +2787,22 @@ static bool migration_switchover_prepare(MigrationState *s)
 static bool migration_switchover_start(MigrationState *s, Error **errp)
 {
     ERRP_GUARD();
+    MigPendingData pending = {};
 
     if (!migration_switchover_prepare(s)) {
         error_setg(errp, "Switchover is interrupted");
         return false;
     }
 
+    /*
+     * The final query to the whole system on dirty data to make sure we
+     * collect the latest status of the VM.  For precopy, source QEMU will
+     * dump all the dirty data during switchover.  For postcopy, this will
+     * properly update all the dirty bitmaps to finally generate the
+     * correct discard bitmaps; see ram_postcopy_send_discard_bitmap().
+     */
+    qemu_savevm_query_pending_final(&pending);
+
     /* Inactivate disks except in COLO */
     if (!migrate_colo()) {
         /*
@@ -3285,7 +3295,7 @@ static void migration_iteration_go_next(MigPendingData *pending)
     /*
      * Do a slow sync first before boosting the iteration count.
      */
-    qemu_savevm_query_pending(pending, true);
+    qemu_savevm_query_pending_iter(pending, true);
 
     /*
      * Update the dirty information for the whole system for this
@@ -3336,7 +3346,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
     bool complete_ready;
 
     /* Fast path - get the estimated amount of pending data */
-    qemu_savevm_query_pending(&pending, false);
+    qemu_savevm_query_pending_iter(&pending, false);
 
     if (in_postcopy) {
         /*
diff --git a/migration/ram.c b/migration/ram.c
index d7b8cc61ea..079a9b9275 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2683,9 +2683,6 @@ void ram_postcopy_send_discard_bitmap(MigrationState *ms)
 
     RCU_READ_LOCK_GUARD();
 
-    /* This should be our last sync, the src is now paused */
-    migration_bitmap_sync_precopy(true);
-
     /* Easiest way to make sure we don't resume in the middle of a host-page */
     rs->pss[RAM_CHANNEL_PRECOPY].last_sent_block = NULL;
     rs->last_seen_block = NULL;
@@ -3376,10 +3373,6 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
     rs->last_stage = !migration_in_colo_state();
 
     WITH_RCU_READ_LOCK_GUARD() {
-        if (!migration_in_postcopy()) {
-            migration_bitmap_sync_precopy(true);
-        }
-
         ret = rdma_registration_start(f, RAM_CONTROL_FINISH);
         if (ret < 0) {
             qemu_file_set_error(f, ret);
@@ -3442,25 +3435,38 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
     return qemu_fflush(f);
 }
 
-static void ram_state_pending(void *opaque, MigPendingData *pending,
-                              bool exact)
+static void ram_state_pending_sync(bool exact, bool final)
 {
-    RAMState **temp = opaque;
-    RAMState *rs = *temp;
-    uint64_t remaining_size;
-
     /*
      * Sync is not needed either with: (1) a fast query, or (2) after
      * postcopy has started (no new dirty will generate anymore).
      */
-    if (exact && !migration_in_postcopy()) {
+    if (!exact || migration_in_postcopy()) {
+        return;
+    }
+
+    /* Final pending query is called with BQL locked */
+    if (!final) {
         bql_lock();
-        WITH_RCU_READ_LOCK_GUARD() {
-            migration_bitmap_sync_precopy(false);
-        }
+    }
+
+    WITH_RCU_READ_LOCK_GUARD() {
+        migration_bitmap_sync_precopy(final);
+    }
+
+    if (!final) {
         bql_unlock();
     }
+}
+
+static void ram_state_pending(void *opaque, MigPendingData *pending,
+                              bool exact, bool final)
+{
+    RAMState **temp = opaque;
+    RAMState *rs = *temp;
+    uint64_t remaining_size;
 
+    ram_state_pending_sync(exact, final);
     remaining_size = rs->migration_dirty_pages * TARGET_PAGE_SIZE;
 
     if (migrate_postcopy_ram()) {
diff --git a/migration/savevm.c b/migration/savevm.c
index 9d1d58c8f4..ed62defadc 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1801,7 +1801,8 @@ int qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp)
     return 0;
 }
 
-void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
+static void qemu_savevm_query_pending(MigPendingData *pending, bool exact,
+                                      bool final)
 {
     SaveStateEntry *se;
 
@@ -1814,7 +1815,7 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
         if (!qemu_savevm_state_active(se)) {
             continue;
         }
-        se->ops->save_query_pending(se->opaque, pending, exact);
+        se->ops->save_query_pending(se->opaque, pending, exact, final);
     }
 
     pending->total_bytes = pending->precopy_bytes +
@@ -1826,13 +1827,24 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
      * close to reality when this got invoked frequently while iterating.
      */
     mig_stats.dirty_bytes_total = pending->total_bytes;
-
-    trace_qemu_savevm_query_pending(exact, pending->precopy_bytes,
+    trace_qemu_savevm_query_pending(exact, final, pending->precopy_bytes,
                                     pending->stopcopy_bytes,
                                     pending->postcopy_bytes,
                                     pending->total_bytes);
 }
 
+void qemu_savevm_query_pending_iter(MigPendingData *pending, bool exact)
+{
+    qemu_savevm_query_pending(pending, exact, false);
+}
+
+void qemu_savevm_query_pending_final(MigPendingData *pending)
+{
+    g_assert(bql_locked());
+
+    qemu_savevm_query_pending(pending, true, true);
+}
+
 void qemu_savevm_state_cleanup(void)
 {
     SaveStateEntry *se;
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 2049159015..8f57d0b7d8 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -175,7 +175,7 @@ vfio_save_device_config_state(const char *name) " (%s)"
 vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy initial size %"PRIu64" precopy dirty size %"PRIu64
 vfio_save_iterate_start(const char *name) " (%s)"
 vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data buffer size %"PRIu64
-vfio_state_pending(const char *name, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size, bool exact) " (%s) stopcopy size %"PRIu64" precopy initial size %"PRIu64" precopy dirty size %"PRIu64 " exact %d"
+vfio_state_pending(const char *name, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size, bool exact, bool final) " (%s) stopcopy size %"PRIu64", precopy initial size %"PRIu64", precopy dirty size %"PRIu64", exact %d, final %d"
 vfio_vmstate_change(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
 vfio_vmstate_change_prepare(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
 
diff --git a/migration/trace-events b/migration/trace-events
index de99d976ab..1c9212d3e2 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -7,7 +7,7 @@ qemu_loadvm_state_section_partend(uint32_t section_id) "%u"
 qemu_loadvm_state_post_main(int ret) "%d"
 qemu_loadvm_state_section_startfull(uint32_t section_id, const char *idstr, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
 qemu_savevm_send_packaged(void) ""
-qemu_savevm_query_pending(bool exact, uint64_t precopy, uint64_t stopcopy, uint64_t postcopy, uint64_t total) "exact=%d, precopy=%"PRIu64", stopcopy=%"PRIu64", postcopy=%"PRIu64", total=%"PRIu64
+qemu_savevm_query_pending(bool exact, bool final, uint64_t precopy, uint64_t stopcopy, uint64_t postcopy, uint64_t total) "exact=%d, final=%d, precopy=%"PRIu64", stopcopy=%"PRIu64", postcopy=%"PRIu64", total=%"PRIu64
 loadvm_state_switchover_ack_needed(unsigned int switchover_ack_pending_num) "Switchover ack pending num=%u"
 loadvm_state_setup(void) ""
 loadvm_state_cleanup(void) ""
-- 
2.40.1


