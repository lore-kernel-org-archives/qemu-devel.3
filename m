Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B09CD6E57
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 09:28:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wULQC-0006dE-Ru; Tue, 02 Jun 2026 05:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wULPs-0006Qv-3e
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 05:28:13 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wULPo-0004Kj-MQ
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 05:28:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JELrmkWevqrCKUANEEQ8KEHqvznXNwaNMwGUR3VjWAISNA/oAtbLmwKTXv70aw4NaqEmcRunh4pKBOgBvh6y/IPYvDFGnMGelRySjZcIMJpAsD1/CvOEU+t5drBZrCWKeH172Msy8jwUxGBzrtnDA14Q8nbPe5VtMe6ot56tZ+Z54fxgKNCRk8fXUV1dEWWldZoNcaOmfS45wdGWnq83RljUUzpfQP1yC87OSmZTwSJpni9uuzJwgi6VF5+gtUPS3/P7IshyTgdGxkq/nMu81G/LjjeQ085JA0JUn9VH1mcF0/GxTj6YQbXF6boo2OaWb/tUYGj8KG6reTTxfuVY/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qu93yVOgC35sG2E8DqzOlMYk43cCrBS+gVFG0Fr2HIs=;
 b=xZLfVdyLT7cWWoluE0kSUya8nJRNX7fEgEb9u6c2UuSkXDuZQcFVLzPswnO7atdKhdTlTXr5EepjSkHmzfMIG9KRsHBNUd0QaV9yIcZM0s6kqNSM8msVbq/aPalWgtG0T9h1H25aRckAOMQxi6BJg7TvXUrbut9jpoScXMtzk0nNdQnm0UmmoCi9UNVr57iSejkT1FjE8XDY3HMkdZWlWmBqqsA7M0uPpB2eA1Gc5cqG6cPNVVkl/YzEdh/5P8BdXR9nRiJjohLNrMpfn5YedXps5WWkxT0zGpyLuLFD+gQQZK6bo3VXn/B4szKwSz6yQGZgc3+PuQAVSXjDUjvCSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qu93yVOgC35sG2E8DqzOlMYk43cCrBS+gVFG0Fr2HIs=;
 b=n7y1KRNIUEAv7ZalY8RuZzRgmaIJ10RVVea5wi7TWoPm72ikpsG+daCjujULPUueydv0ph6t9a/7NM/FHkeW7TIhVh05UD0Tf5DC7aI1Fh+3jVzwWMQ7+lGkfdGAoxrZbQH/U268KvGzmRzi/lxXRLkJlYwlDQGBe+ZUmC5pfeXmn+ecmKp9dpVjdtIzlO1QGUE1Qdtulm8QZHUjiuvpnqJQcO/LNgMvUCCnKQl8uaXk+nh9T441grT50pmuZsxK/BxYJ+iSuKg803OCh9nzAOrKT1v1Ms/73j8Set99st8LO8B+hIAshZRtPqiEQDaqNMc6EB+tOFmcba7yIWr7GQ==
Received: from CH0PR03CA0449.namprd03.prod.outlook.com (2603:10b6:610:10e::25)
 by SA0PR12MB7004.namprd12.prod.outlook.com (2603:10b6:806:2c0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 09:27:58 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::a0) by CH0PR03CA0449.outlook.office365.com
 (2603:10b6:610:10e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Tue, 2
 Jun 2026 09:27:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 09:27:58 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Jun
 2026 02:27:46 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Jun
 2026 02:27:45 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 2 Jun
 2026 02:27:40 -0700
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
Subject: [PATCH v2 12/13] vfio/migration: Check VFIO_PRECOPY_INFO_REINIT
 during switchover
Date: Tue, 2 Jun 2026 12:26:20 +0300
Message-ID: <20260602092621.382-13-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260602092621.382-1-avihaih@nvidia.com>
References: <20260602092621.382-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|SA0PR12MB7004:EE_
X-MS-Office365-Filtering-Correlation-Id: 37b97361-a5ed-4a0a-7e1c-08dec0893c08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|7416014|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: CjhfiIl94IwPKcI/qnzGXHQqifKccRDiDS6fR1x5Mb8M7o1CVcCUA8wvmAarH4BPMoGrVoIvqAM+Fu0qymnP1tn48gSlYHfviG7jeXEU1jcCuTasPTurbke7JrF2aVHRryAEEkhHFgYZNzHmWI0hTSA8ZvDz990EaUnC4Lq+g9udDiRr8I9gDf/SQdApQqaEuD4ndC2VqKCUzwu9R4EsuGVeh6mi30uG1xJN1/otRdN8Ilnb41uwI9fJYufGrCUfjHDLYjetFw8PwZDh+duVX7brKucbYMXUe2GoYShv9F8+vH/+JeAlIRGHWaAb+qrgQWER5CmProoS2hxR/lR1WA/6ltvN4hUHtDTCqSw5/fvm9J7dgIVJeuhcdzy9B4wLtvJrTY0AtiTjGCJTAZUPtp6brb4cENbL5p38+1DJkZ3X4s6nMK0kkMaAY3rMyHhCwPP2lUXWkUWVuSuaeXS9eHUheTSX9UhGVLAuLdR3WuNkDOxz4C/Vasf50gAoBb0ZczC7OjqG0N1QxlOvB7gSqpmkDYgfodxzQJxs5qdcRZqHfN6rX4n/SIQNCCNu6s8MSiER7MZPeKRINR5/Slx/o/SDQABaVokSXpDUPxCjJx9NhngdxNDWwYj5RF3JOSbQlURH6bmuJzzdEOUbG0nR2I9134pmTYg1XdtyyuwWcLYbmWmCZEUXRU402WSIvwOSacs0yn1MS/VcQHlVNPkrOIVlcOBoqbPnn6FVaTob4/E=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RGqygJM/FWxyQsZFJ7EMznTiCf+z+aoWjv5GA8PVf0RjHUHi384LL1W5VempjTzZjpJBskNKnjkG4oIZ6nWJXGmBiiBwqj73veRSi2ZUiD/n2EjE0ghQ+KrLNxoF8+2VscRdJKzzI95/XVGCOoDEEFLAQa5upDmqlIvbSr0Jl1rtHhzs1BGZpSTeQOtrjstWZ745U0qMpp7HmkBwT9Z4VfyWquKxkLepWp4keEBA3soH3e7R9GqIM9Dd68v4ipj9TuikYdFU74ryf8sEgDTAePaY/Q6YsdvBHxl5MoAgGgMDncwuhDRi0rmXuq0Jp24Wr8T5Eiyla3FbPuAZa7TZnV/sLHseebU9jS0cmEAAswRACDL9SxNYFcBuJolqGeeEUvob667SPMmeI6a1LC28URYlgll1XHvbnMerwJGDtwyHiAXUITSGttHLshbsfsqJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 09:27:58.1917 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b97361-a5ed-4a0a-7e1c-08dec0893c08
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7004
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

VFIO_REPCOPY_INFO_REINIT is checked only during precopy, before the
switchover decision. However, the switchover decision and guest stop are
not atomic, so a VFIO device may want to set VFIO_PRECOPY_INFO_REINIT
and request another switchover ACK in the gap after switchover decision
has been made but before the guest is stopped. This would be missed and
may increase downtime.

Solve this by checking if VFIO_PRECOPY_INFO_REINIT was set during that
gap, and request a new switchover-ack in the final save_state_pending
call. Query precopy info after vCPUs are stopped but before
transitioning from PRE_COPY state, when its valid to call the ioctl.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 hw/vfio/migration.c  | 41 +++++++++++++++++++++++++++++++++++------
 hw/vfio/trace-events |  2 +-
 2 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index caf4d5e19f..f1480fc4cc 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -681,11 +681,11 @@ static void vfio_state_pending(void *opaque, MigPendingData *pending,
     uint64_t precopy_size, stopcopy_size;
     bool request_switchover_ack = false;
 
-    if (final) {
-        return;
-    }
-
-    if (exact) {
+    /*
+     * Skip sync in final query as sync for precopy (which is needed for
+     * switchover-ack) was already done during guest stop.
+     */
+    if (exact && !final) {
         vfio_state_pending_sync(vbasedev);
     }
 
@@ -709,7 +709,7 @@ static void vfio_state_pending(void *opaque, MigPendingData *pending,
     trace_vfio_state_pending(vbasedev->name, migration->stopcopy_size,
                              migration->precopy_init_size,
                              migration->precopy_dirty_size,
-                             request_switchover_ack, exact);
+                             request_switchover_ack, exact, final);
 }
 
 static bool vfio_is_active_iterate(void *opaque)
@@ -963,6 +963,26 @@ static const SaveVMHandlers savevm_vfio_handlers = {
 
 /* ---------------------------------------------------------------------- */
 
+static void vfio_final_precopy_reinit_check(VFIODevice *vbasedev)
+{
+    VFIOMigration *migration = vbasedev->migration;
+    int ret;
+
+    if (!migration->precopy_info_v2_used || !migrate_switchover_ack() ||
+        migrate_switchover_ack_legacy()) {
+        return;
+    }
+
+    ret = vfio_query_precopy_size(migration);
+    if (ret) {
+        error_report("%s: Final precopy reinit check failed (err: %d)",
+                     vbasedev->name, ret);
+        /* If query failed, assume reinit and request switchover-ack */
+        migration->request_switchover_ack = true;
+        migration->initial_data_sent = false;
+    }
+}
+
 static void vfio_vmstate_change_prepare(void *opaque, bool running,
                                         RunState state)
 {
@@ -976,6 +996,15 @@ static void vfio_vmstate_change_prepare(void *opaque, bool running,
                     VFIO_DEVICE_STATE_PRE_COPY_P2P :
                     VFIO_DEVICE_STATE_RUNNING_P2P;
 
+    if (migration->device_state == VFIO_DEVICE_STATE_PRE_COPY) {
+        /*
+         * Now that vCPUs are stopped, check if new init_bytes are available
+         * since switchover decision, to be reported in the final
+         * save_query_pending.
+         */
+        vfio_final_precopy_reinit_check(vbasedev);
+    }
+
     ret = vfio_migration_set_state_or_reset(vbasedev, new_state, &local_err);
     if (ret) {
         /*
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 464c28c860..3fbc32cb3a 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -178,7 +178,7 @@ vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy
 vfio_save_iterate_start(const char *name) " (%s)"
 vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data buffer size %"PRIu64
 vfio_send_init_data_flag(const char *name) " (%s)"
-vfio_state_pending(const char *name, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size, bool request_switchover_ack, bool exact) " (%s) stopcopy size %"PRIu64", precopy initial size %"PRIu64", precopy dirty size %"PRIu64 ", request switchover ack %d, exact %d"
+vfio_state_pending(const char *name, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size, bool request_switchover_ack, bool exact, bool final) " (%s) stopcopy size %"PRIu64", precopy initial size %"PRIu64", precopy dirty size %"PRIu64 ", request switchover ack %d, exact %d, final %d"
 vfio_vmstate_change(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
 vfio_vmstate_change_prepare(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
 
-- 
2.40.1


