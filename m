Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416E4CDB46B
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 10:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbbhU-0006ju-Jx; Mon, 22 Jun 2026 06:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wbbga-0006GR-HD
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 06:15:25 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wbbgY-0006rl-2b
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 06:15:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/BmI58ElrPYsVLgg/C5Sk+/CKLqA+E+hlcSkHFkDfgOzc0Vg9wTlAXWK8x1r9d1NcV8+LSia910Y/ekoCh4rTY2rydNjhaVWGK24K1/t/cmFmSnbySgvYztY/euJetIvzMYzBC3eQWwteU5dcQH5Kko8xVV71Js1dcwkeT6OAF9L7exQKJ7YwLBjGKOPJAXWmk1VuHjpSK7LHL289d0MJB4R3/uOd4I0U1LYqm2EZVcXRIL3cd7IiA89nq28Zf6RM1gUUE7W3IPK32v8nxwrbcUOVjrgzKATB36dqCY9d/5Rx+CeNj0cxoAFjPcwC2gcK01gn2znue69TR32b7lqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4Qh/jSYwgOkTqMbPJ/GTzzliZARfxaZePri6cTULPc=;
 b=Dp7ZL8vyNnL4jB6onLqzBJjNycL2xp0tBaVEP8qPHP8axo5c+075lCKikEneYO6Nw8ngBF/mRgwKfrtu6Q9ya59qe8EUBV+D2DAox4DtZaPVfqQ1DdC33h9VnSR1J0yPiwP3Bc2RiFyY+zOpsYcmkTBhN3VfHVMfsqf5s/6+tbt8NbFG002bf83b3xU/GlqqjFXK1AXPTHC4lCewCo1ofVUM7oPPFz0b11oruZVghQvnM+PYx5o/Ht/z8dTiofm0Dpwzwwu3tvTEhkBZWxp+ILJiOzIY9JPgX5pMf/Qy9S05JHNrZDqV8/Y6bBNegX4msJflwt292j1E1irBugGupQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4Qh/jSYwgOkTqMbPJ/GTzzliZARfxaZePri6cTULPc=;
 b=YBoesXIWEQ/QVx24CvjTsoWC2lOB8izYai8Q5HA8CtEWQXraG2iFJ/d6Hvr50NW6Wj9/ohFHyfwuswNcDHGX/+Wcix+Q3qX3aIJaZRBgF1bbbGw4TAsz1JbldDH0RFXI9kVlNQsSc3tsVg5XwudZOgsVcEqsuQWfq+L7Rp2lqJd4Z2zLL2nxHY3STMHKgzwOhu96jUkaj53z9obzefpGWsmQNSCNo7lrzIdePHBokvk+/Y/X3Q2Tzq8ZfpDm+kN7UJ5FmxXh1JSFXzOeCLZyzYQ+4UJdkWECX28qzyJPGWKKyI5yZujUNDg9j7GxKkzLkNhHajHgo5Xsz171uKGptA==
Received: from MN2PR06CA0021.namprd06.prod.outlook.com (2603:10b6:208:23d::26)
 by SN7PR12MB7450.namprd12.prod.outlook.com (2603:10b6:806:29a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 10:15:14 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::24) by MN2PR06CA0021.outlook.office365.com
 (2603:10b6:208:23d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 10:15:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 10:15:14 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 03:15:00 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 03:14:58 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 22
 Jun 2026 03:14:52 -0700
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
Subject: [PATCH v4 11/14] vfio/migration: Add new switchover-ack mechanism
Date: Mon, 22 Jun 2026 13:12:11 +0300
Message-ID: <20260622101214.25770-12-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260622101214.25770-1-avihaih@nvidia.com>
References: <20260622101214.25770-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|SN7PR12MB7450:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c613c91-a09a-4c92-e1cf-08ded04726a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|36860700016|82310400026|23010399003|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: aC24yYeHXWveqD31F9XdYh30AKckhBQTEdIwDkACm/B3D1dacp2hVoL7DDYTF4A1Pvcfl/ueiUkJIaKtJ4vE/zTrt7TQ9cdyGhALEBamBI/r+Agg61FcMPWJhU4eIeGQwh8NATukPl9AD+pch6BNEtrS1T4goxvFrE6IYvdTGeFKcD3BebJxhC+d5WJ1Aca8FAIsIsi9Y+v3vmXfG6HLcYbcD0x8cdK4ySNVAbRkLges52rt26GmlPbaq4by9HZRqqYw69D+w6eK0WX8PU6in2vRz5FGawTW7IoQnsNFZ6lkzMKIOsdSdVnEGzO76Rqm5cRVQutFeHv5Tp3uOfozpIzsNyiO8aYTqmOPsWWIufYkVUVeEq2/w9QueyeagLrKisTc2SCBU9FRayQGpvjgCRWNEAHHWuEc4AbIbEQ85rgeGCUs5McATigHxqRi8UQGv7HvOg2Z00q5H8VGt0XHUzOeSnR5oVfVxuGX7AASRtPHet5WCTpCVnGtIehxigEv1svkoYcFywc2YGfJSsba2njIz7l5/iKzEsUXJ6R0/KjtkOZg/oR00Ja792YjCuWDrqWq3wf3LwG+FT8OVXWjt+DqECyRhx+wU/isFNpxlVgZ3fgRkocuOURKPCpiAsTdacdvcP3t4oZW3i8N+i8r+DIj6OV059IhHJjdY3AppmRQpHgu3nAE8iaX0elwadLxf48mvyjZacZeO5E3paiVbg==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ImJmI/LKRFcQZiUU/a6NvbIXCAfUeQKyAeV+bI+fYZ7IRcuEvNU29TBe8ChfnrGj+2K47r5KeixVyp4hRDHDmTCrSohVN6CLBGzlp72wrCFEXEzPZnqOgmsWjUI1h7ZQ+D6dgeekWJIi7xHpoH+CLgKDVJOi1B1YjWKS/7TYUO/bgPZQS7ucHICH05wWlKIWEGobUT8pNKMMNTcyCCcf2E2n5C71UFHYH9QhTyqFxlmYF5tggmTme6p3tZxcdLvOrXzCYuDrlZGtACsjEHvwIBIaWAP+8Tm7z8X5gyIAKttippTAxT3DudMn4Trf4FdthFdtI1JXgx9W3WmiDsEGyQY0ovfzAJdqWes52urOjwpEEmY6kuuQLHnHAfDmz9qssFcjjTm5VFpJjXqZTscLBCI2n3yboqpM+Cm5GzOWFYhImwwTKoHVTBEYMwHdRst5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 10:15:14.0829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c613c91-a09a-4c92-e1cf-08ded04726a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7450
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=avihaih@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
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

Add support for the new switchover-ack mechanism. This includes
requesting a switchover ACK on the first save_query_pending call (with
exact=false) if VFIO precopy is supported.

This achieves the same functionality of legacy switchover-ack but with
the new switchover-ack mechanism.

Keep legacy switchover-ack functionality for backward compatibility.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 hw/vfio/vfio-migration-internal.h |  1 +
 hw/vfio/migration.c               | 13 ++++++++++++-
 hw/vfio/trace-events              |  2 +-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/vfio-migration-internal.h b/hw/vfio/vfio-migration-internal.h
index a15fc74703..dc741e5142 100644
--- a/hw/vfio/vfio-migration-internal.h
+++ b/hw/vfio/vfio-migration-internal.h
@@ -58,6 +58,7 @@ typedef struct VFIOMigration {
     bool multifd_transfer;
     VFIOMultifd *multifd;
     bool initial_data_sent;
+    bool request_switchover_ack;
 
     bool event_save_iterate_started;
     bool event_precopy_empty_hit;
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 3ab6b7248f..ebe2eafded 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -582,6 +582,9 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
             }
 
             vfio_query_precopy_size(migration);
+            if (migrate_switchover_ack() && !migrate_switchover_ack_legacy()) {
+                migration->request_switchover_ack = true;
+            }
 
             break;
         case VFIO_DEVICE_STATE_STOP:
@@ -634,6 +637,7 @@ static void vfio_save_cleanup(void *opaque)
     migration->precopy_init_size = 0;
     migration->precopy_dirty_size = 0;
     migration->initial_data_sent = false;
+    migration->request_switchover_ack = false;
     vfio_migration_cleanup(vbasedev);
     trace_vfio_save_cleanup(vbasedev->name);
 }
@@ -655,6 +659,7 @@ static void vfio_state_pending(void *opaque, MigPendingData *pending,
     VFIODevice *vbasedev = opaque;
     VFIOMigration *migration = vbasedev->migration;
     uint64_t precopy_size, stopcopy_size;
+    bool request_switchover_ack = false;
 
     /*
      * The final pending query runs during switchover downtime. VFIO does not
@@ -676,10 +681,16 @@ static void vfio_state_pending(void *opaque, MigPendingData *pending,
 
     pending->precopy_bytes += precopy_size;
     pending->stopcopy_bytes += stopcopy_size;
+    if (migration->request_switchover_ack) {
+        pending->switchover_ack_pending++;
+        request_switchover_ack = true;
+        migration->request_switchover_ack = false;
+    }
 
     trace_vfio_state_pending(vbasedev->name, migration->stopcopy_size,
                              migration->precopy_init_size,
-                             migration->precopy_dirty_size, exact, final);
+                             migration->precopy_dirty_size,
+                             request_switchover_ack, exact, final);
 }
 
 static bool vfio_is_active_iterate(void *opaque)
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index fe0d2cc06f..c9d143826d 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -176,7 +176,7 @@ vfio_save_device_config_state(const char *name) " (%s)"
 vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy initial size %"PRIu64" precopy dirty size %"PRIu64
 vfio_save_iterate_start(const char *name) " (%s)"
 vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data buffer size %"PRIu64
-vfio_state_pending(const char *name, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size, bool exact, bool final) " (%s) stopcopy size %"PRIu64", precopy initial size %"PRIu64", precopy dirty size %"PRIu64", exact %d, final %d"
+vfio_state_pending(const char *name, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size, bool request_switchover_ack, bool exact, bool final) " (%s) stopcopy size %"PRIu64", precopy initial size %"PRIu64", precopy dirty size %"PRIu64", request switchover ack %d, exact %d, final %d"
 vfio_send_init_data_flag(const char *name) " (%s)"
 vfio_vmstate_change(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
 vfio_vmstate_change_prepare(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
-- 
2.40.1


