Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576E0C44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:54:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgf5W-0008VS-Cp; Mon, 06 Jul 2026 04:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wgf5U-0008Ti-T9
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:54:00 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wgf5S-0006oA-CO
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:54:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uk6iM+XJRPyVF8aLjG7rrmaorkNFRXS67A+KJBTVymcKtIGasl5jdfgz63EqF4a399ds1pymLuGcGG0lKZSQG0LVn6/ghaHufeWe+bKnLj46G9ZAuyZ1kERrI2b0mZmtm+Oxugb39P8iScF+OLD0KmbldJRap+DrT+P4FCfekQzDEfRxOVtM0e//9zxUdwgXahln12/6C4BKMEOS9ikQ81GqP3ldAAi7k/4jPKuzcunFGHCeeMm2y/btT7MHkmhWVH5KHkbvQEyKA/Rz9Zqtns6KMOB3lSUohE6V2ZOHfwoDfSJIipberiIx97QI2yaFiJwaCDRO4UqkL0toUnrbKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqCQ/Jxi3xkd6aIwBpi6JyTRtpMrh1TeknGx8AzzqZo=;
 b=E2nyOoZ3EnHfCBzTX2hZTAyvEpLwO/gOLDfaeBCezOo4cVOBqTHIkX2jpnpMF8lKmZD1zwcZDnRuIsAKIltwd5MsGgzzg4k99IGN+y4qhI6wNpeYwqcwCbdfvb9DAsc5WW9+jw9Benww3Gjd5N6/m27ANuuhOyWNMZEch7OY1ELlNxv7kxRe2A3adgw8vB4APmDSFltSVXz6ZSwpTRvHFKskuVG55bhms/QbmB/No8DwZv6wobhsRIoTlYr28ltr3ly/tGRkJj28sga3jT2cziYpBlT4kQRheRUwbnB9sC3ncJ4h+mvML4W4VMYmBqaqNZs+JfghjMLofAcOd5GITA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqCQ/Jxi3xkd6aIwBpi6JyTRtpMrh1TeknGx8AzzqZo=;
 b=uKr5tv2Ah68RIDcN4jZbt/ahNXScbPjQQCoOqSMED1v1NI5HTBh5ZNWfimPP4L0Z5cdOJdXp/c6eUt26lwyd+mKQJPltGAN49HxpFk4f8rSA8sjwkIcIvn8FlxV1eKlO2Epj4Xrrg0dpzMgeumntcGBJHXt2YEXbIBLCydu8qpu93dWVC5kd9NsIve/zs6L/sB3p9d+hnAoR52/SaBa2iwMaoYSDAiTj7VT8Mj1E8D9uqoyV49awTbtjmyfS240S1lnusV8kCUI8LGJP669ld0SQPvfsDAugC1DDHwe3HlVNDEKk++mA4DmNBGpWQfGkwFAdK/G+iNYkpUXD5Hdtwg==
Received: from CH2PR18CA0040.namprd18.prod.outlook.com (2603:10b6:610:55::20)
 by LV8PR12MB9408.namprd12.prod.outlook.com (2603:10b6:408:208::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 08:53:46 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::37) by CH2PR18CA0040.outlook.office365.com
 (2603:10b6:610:55::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 08:53:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 08:53:46 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 01:53:27 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 01:53:27 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 6 Jul
 2026 01:53:21 -0700
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
Subject: [PATCH v5 03/16] migration: Run final save_query_pending at switchover
Date: Mon, 6 Jul 2026 11:51:58 +0300
Message-ID: <20260706085211.13905-4-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260706085211.13905-1-avihaih@nvidia.com>
References: <20260706085211.13905-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|LV8PR12MB9408:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f8f5f60-7512-45dc-54ae-08dedb3c16e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|36860700016|1800799024|82310400026|23010399003|5023799004|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: fuoZmpgLTrNTnEgOJsjjDQm8MDiq1fPK9ogm9OKywH8VRp8Xaoug7YxFLJY9srnxHqCZ9AcZhHagXwVkQXE563NKOdDi6VVBmU26R/66kqzA9/ieQXsCjIn3M8i4+OgmmZjV81bcRBvbhTFQ0YMtuZuWqk6EIH5coOf3pVhXacRElzUE8hDGwVkdp1Q+tWbqNb8gOBdNMExw6lTrrm3Q3iiPHg1B/MD0lHAbPcmYkFZYZ9jYSWfyZvJCi4sa9+xhFyHs8vfcp1GKcOgRUaPGsn5VqiGho3w+CeWQQfBTMrZu4+ipiAUhkXysPsWr3ZxlbqrQrj0yFAA5s/9UsqBhsoNXZy8aUnLdNqqaKyU0+3wRPlRgaUQW3fblw9NA1YNFLngJVbMhJ8iQZJcheoKLTST0B98FeDC8ontolQjjXWkuIlCUTEkizpZ941indvl1Ctn5YDu2sgQiYf9jtQKmk1+ZwqPPvtA/vhn7TV1gEJgF1yzyoOF1ZvTOgOf6673C4BfPbJjgx+FH9D+OC5u3/FNBruQxg6KzzhZNpMLr1jhT8hpmVFWpCvexZ+bp5tGH2+7j4FJJfpZ9DnWqGELTwuqMabqlf0l2efl/7DuIjJy9PvYSe501skAZMRInjEtv/gUlXF/j3AwXqmhRf0bEvlgiq3o6oxmRkjiSUUcUGQ/isB6XD2w2I8bZQBA5jYoL7DZRVw0wkuIuZvKsxhC2uw==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(82310400026)(23010399003)(5023799004)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kbDAYnnO5PpDq5B8u2z/iENfTMaL6OsfoqUpS8o2WCNTaHV1CCTuILy+27kxGLH/vpbxuGY4VPROQWSzbexai7WBTaiJRhcvSQ8HiHBDSODMhzX5e3bsaB5fT27b8/QIndcdYTZKd85ZPyslYU30rQZsGGY0wNSNxo7zIGJivVjomPnSP2al2pG1TkeQ+tspVQqe1MlRTO9Sj0wskiDj0AjFqC03OKTrBzwJOJYvQyk7hNYBNDLWvugkbynPsd4hGf7XiJlXxTQR6CSk0oTc4YVlSCBFr06PPwzeYKbS01pI0LXEaibhMmZzaj0xx/7VEK6+DfGQGcSJNRoXwSa9QCGm5a+qu50vi87gLjbu93IQTZqGEPqecqUukf3hejCl+fs8ziQdxNQ8dkgg/EjXSl3LIiqEqVhPih4F9Lh8xU/r2PYg3uO0Z3jSck1Un4yu
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 08:53:46.0404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8f5f60-7512-45dc-54ae-08dedb3c16e7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9408
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=avihaih@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
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

Call final pending query also in COLO checkpoint, which needs to flush
dirty state before the checkpoint's live state is saved. Unlike a
regular switchover, COLO reaches completion repeatedly for every
checkpoint, so this must be done on each one.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 include/migration/register.h   | 41 ++++++++++++++++++----------------
 migration/savevm.h             |  3 ++-
 hw/s390x/s390-stattrib.c       |  2 +-
 hw/vfio/migration.c            | 11 ++++++---
 migration/block-dirty-bitmap.c | 11 ++++++---
 migration/colo.c               | 10 +++++++++
 migration/migration.c          | 14 ++++++++++--
 migration/ram.c                | 40 +++++++++++++++++++--------------
 migration/savevm.c             | 20 +++++++++++++----
 hw/vfio/trace-events           |  2 +-
 migration/trace-events         |  2 +-
 11 files changed, 104 insertions(+), 52 deletions(-)

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
 
diff --git a/migration/colo.c b/migration/colo.c
index 2d36f933cf..08632d5e4a 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -409,6 +409,7 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
                                           QEMUFile *fb)
 {
     Error *local_err = NULL;
+    MigPendingData pending = {};
     int ret = -1;
 
     colo_send_message(s->to_dst_file, COLO_MESSAGE_CHECKPOINT_REQUEST,
@@ -465,6 +466,15 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
     if (migrate_auto_converge()) {
         mig_throttle_counter_reset();
     }
+
+    /*
+     * Run the final pending query so migration modules can flush their dirty
+     * state (e.g., RAM syncs its dirty bitmap) before this checkpoint's live
+     * state is saved. Unlike a regular switchover, COLO reaches completion
+     * repeatedly for every checkpoint, so this must be done on each one.
+     */
+    qemu_savevm_query_pending_final(&pending);
+
     /*
      * Only save VM's live state, which not including device state.
      * TODO: We may need a timeout mechanism to prevent COLO process
diff --git a/migration/migration.c b/migration/migration.c
index 7e0a0bea7a..442f950c43 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2793,12 +2793,22 @@ static bool migration_switchover_prepare(MigrationState *s)
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
@@ -3291,7 +3301,7 @@ static void migration_iteration_go_next(MigPendingData *pending)
     /*
      * Do a slow sync first before boosting the iteration count.
      */
-    qemu_savevm_query_pending(pending, true);
+    qemu_savevm_query_pending_iter(pending, true);
 
     /*
      * Update the dirty information for the whole system for this
@@ -3342,7 +3352,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
     bool complete_ready;
 
     /* Fast path - get the estimated amount of pending data */
-    qemu_savevm_query_pending(&pending, false);
+    qemu_savevm_query_pending_iter(&pending, false);
 
     if (in_postcopy) {
         /*
diff --git a/migration/ram.c b/migration/ram.c
index 55aa9b47dc..8918b2f03b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2686,9 +2686,6 @@ void ram_postcopy_send_discard_bitmap(MigrationState *ms)
 
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
index 7e2a0c2b4a..74d622583e 100644
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
index 4c28b3291c..fa2204f002 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -176,7 +176,7 @@ vfio_save_device_config_state(const char *name) " (%s)"
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


