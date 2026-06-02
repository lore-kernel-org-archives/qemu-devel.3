Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25266CD6E4A
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 09:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wULPf-000639-B7; Tue, 02 Jun 2026 05:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wULPd-00062m-6c
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 05:27:53 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wULPb-0004Jf-Ib
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 05:27:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igxxitUq138Kd/mdMR+apLbmivKCLx5TT+9I6CD1gZO82lWCc74//U7UAa+GSXURcXZ7RaVI4pshMidU9ajg9yqBfLGdQuTtzWbm9VIPTO7SkosxVIO8jFPbW4+Lkn3X96C5Yrv5SG+Qq0vNCllK+G9FVgeV7R2NP2EJocx6ehl7s2oaIRA2WF0FifyjGjgIoKLpkuNWzCkPRXt5ruN+fxFGXXGnx6yegwwjuJoUvcN7ZxSsqbQ0Y0oWS1pNnoNJiyTL5wbQpIsgIyUhxIQTCtxAThBDCPbouEPW1M/asNdaMDvWqPewRur/bBojS+vdFKwVSTUQPrg15XlBi6YrRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JcaI2x2sVYxUmtliF5hyiKKznS+5+xzDS1hhrISoWM=;
 b=y6RyFJWcPwvAA1cPdSTpGdNjBdHXmCuSf93z3BjY7Gx4HhqM8xk2vBOPKEqZYQt9AsUDV2EMABP21RfYjYmLENhbJUH3lRskQUuQITnkHXrDhoXO00K+jTiuyX6xlNysY3irY/mmVFxJyCJSVQbUzkJAxSn/TkNzvJ220xrouRIrfzZzU2QVMuPxQwddVN4JKcwdlf8SW+J7jgPtG+BVXcDv93rqCJNP1ZIdCOm6dCMDWsNyXzsyOcDIeQiNB7rVrEWfJ/hSHmEirr3nxEK/Q+WzVRkP7gqcxbaunie3aDDgkFvnkqCwq+o5lL7C2g/MnJw7K8qsvpNPclj4HQxYog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JcaI2x2sVYxUmtliF5hyiKKznS+5+xzDS1hhrISoWM=;
 b=C8Qf8p/RLFZmEZozdbOi4n/3Nh8wda3zasRsz7+ZB5PDNK53jU9hF61bF71l6rJHqVkoOPqSj+GJIaZw099u4+a72EXAzC9BSMu3cHgkT5QR0aOaV+pbouu9UPYvSPzmP1CxYD8KUrpP2r0gsujRalhqWZ27QHygy+4L+9YWU7dedXfMcRn7Vmlxavq0jct20CpXYzugoKcguvX07jz41UMaaowG4ma8VAa42fDuRQDFst1wO4yfATxc3OyIjNhotkrFD1tO3mQJ9MKq0Mc45jx/jd94XPEO89wI0rTtzM4qMBZv24FzQBm0lzRu9f1quJPDbvkgtQUDEtJnCfIJfw==
Received: from CH2PR18CA0021.namprd18.prod.outlook.com (2603:10b6:610:4f::31)
 by SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Tue, 2 Jun 2026
 09:27:45 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::36) by CH2PR18CA0021.outlook.office365.com
 (2603:10b6:610:4f::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Tue, 2
 Jun 2026 09:27:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 09:27:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Jun
 2026 02:27:33 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Jun
 2026 02:27:33 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 2 Jun
 2026 02:27:27 -0700
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
Subject: [PATCH v2 10/13] vfio/migration: Add new switchover-ack mechanism
Date: Tue, 2 Jun 2026 12:26:18 +0300
Message-ID: <20260602092621.382-11-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260602092621.382-1-avihaih@nvidia.com>
References: <20260602092621.382-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|SJ2PR12MB8691:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eaf5279-a41d-4527-d217-08dec089346b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Vv6cWI8DzYvDpzd/+lb6ftYz4JtMQJSdgQHESF766AIJRXBSbRYGHG6h+r2+4qWs5XQbkFrT2wuFWbgjEMGdAFlPCArPkutBXP4wTY5qLsACKrey4hUPbxpj5fcka/92lLgtzxuWx/JLGj7JfSdRAPH6NP+GHnXxcd1TxPrYo9c/8KRt/XAaCV4UmJOc33xaoP/JuFclg/IrtY/BHhSkQj+3IGqKrzmhQ5PiqjNvP6UupCpahNfR6i7rrbQXws0E4VFoAhrubS7y51z4C1P0F59jAAhe6NuRFNNdaaCM8ny/HXQ4PsjbEW1wBUC8S5RjtZnbs6JYRkhyCR3KJMp2Ik383Gve8+Y04zKIQUcQHWg3X9oH8An4BLredVuLnQcmm3QBrNXbwElxJ7Kx54BgJUsWUMap0B3wlGw9ICb9i1ra5t8Y7MIwl0cGEyihv59moDPwC1jActEsFnhOXOc0wCwtGQq5X664jTy6NGnYWpKw1uOKgeMfGyGQYSLsKKswZZoHKWE4dym3ysucY3u8GW31vzT6sgM8D8W4vxXapyvFV2/MF2HDV5ArnygHGZXlJr2Xrv9p6hanf+l2FzvYVOKdYt5qPFv34MsGCRjqWqOfpmaqfKso92EoSYEaahCiwYIH3nrdjxeX8Z4mKJoDb77HUHRh6m+VKQxKdp3Hb7oLu/vdHpQ3kqy7SPwgAVrkSyuK8z56cNwXtntQo9oeS/3PlKz7/XVW3HbFF8LXdDw=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 60aUeOTjufmb0sEY31y9z7t4zt4KlRZcZgMcoXzVuPiuMR5tnb1b18G3p+jAMs4wfbJBo/ISxlKtnQGJ2IEDtgWPA+uyWlbiNvuHRsObWXiOmsDiA97+JZYKk94a7M1UzZMTS1vDJZ44+Ot5yy72NjzCybaQHt4Oz1FdK0vDHgmRMeFiZhqIGTxcnP1V0dxBcPC4DJKax2T1bogskdc4vbtbbqBYgNDROWlRsKKQZEWE6jw7qgefKXt3qBuaKbItVnumqmaeRzgZseNY2OvZk92dZYGdu6GH2QHYwjKoFsoz57AGQ5M4bfc/M79e2yOuzHxzPQXYP34lJX5ZzoNs+WxNmzFAyBbMTu067qN+kJYWHvBQG7fw9zFZhNf5MDYsG7D6YvqYr1RJS5DAd/YwhEGW27D4th8bmAnp6dtXaVT7s+9kpWrnH5fIIJaaB4sP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 09:27:45.4049 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eaf5279-a41d-4527-d217-08dec089346b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8691
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=avihaih@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
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
index 02ef216712..2296d0d44b 100644
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
 
     if (final) {
         return;
@@ -675,10 +680,16 @@ static void vfio_state_pending(void *opaque, MigPendingData *pending,
 
     pending->precopy_bytes += precopy_size;
     pending->stopcopy_bytes += stopcopy_size;
+    if (migration->request_switchover_ack) {
+        pending->switchover_ack_pending++;
+        request_switchover_ack = true;
+        migration->request_switchover_ack = false;
+    }
 
     trace_vfio_state_pending(vbasedev->name, migration->stopcopy_size,
                              migration->precopy_init_size,
-                             migration->precopy_dirty_size, exact);
+                             migration->precopy_dirty_size,
+                             request_switchover_ack, exact);
 }
 
 static bool vfio_is_active_iterate(void *opaque)
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index e99ee2ee8a..50722eb717 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -176,7 +176,7 @@ vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy
 vfio_save_iterate_start(const char *name) " (%s)"
 vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data buffer size %"PRIu64
 vfio_send_init_data_flag(const char *name) " (%s)"
-vfio_state_pending(const char *name, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size, bool exact) " (%s) stopcopy size %"PRIu64" precopy initial size %"PRIu64" precopy dirty size %"PRIu64 " exact %d"
+vfio_state_pending(const char *name, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size, bool request_switchover_ack, bool exact) " (%s) stopcopy size %"PRIu64", precopy initial size %"PRIu64", precopy dirty size %"PRIu64 ", request switchover ack %d, exact %d"
 vfio_vmstate_change(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
 vfio_vmstate_change_prepare(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
 
-- 
2.40.1


