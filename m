Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728A8C44501
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgf71-00032g-PW; Mon, 06 Jul 2026 04:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wgf6h-0002gX-Td
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:55:16 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wgf6g-0007Qn-3H
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:55:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWxC5w/WJqEM2VRSh/qSnYB75j0v/Nxi/aALirVs3Lwp50dKDgEGoGWIxfsTmvQsNxnMdpZvLagMGJxLf+P8Q2BM2UlDik7od1gIf7WvTMCFwjzWN0b13mDGBYfgplXOzr2D7Ehl0kfzqRYLBgkViSP2sdIVgdC7UjLB+7zSmaPqnm6BQW0hi/n252jfyyXMZqvsL29N8ZM2V3FmAVL+7UZsJ7grzN4lZT+LuUMIIFJg1wktXdHCO7PeMef2ZETR733EdoMYqUJT2BJpOxynCP29khpcWt+3aG5icZ9dPDfGGNJ9jfAwJn91eiOZuKDWLwUQGwvFau8mtAUwOBankQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4Qh/jSYwgOkTqMbPJ/GTzzliZARfxaZePri6cTULPc=;
 b=SidABnp/6i/M8mTfOqwRKq87njuhtPEwkKX2Il0uMPr1bYWIZi5LZreMQbVeMq+SHJO+ShkbuADMMWQ+cfbefi0hjBJR3IJLC8AJLQrHUJWSGsV2gKFprpTq2i3vP5vGuQ3CG3i1lhW1afP0+3SqFkQaGsR8Cgfkb9TUvbPspuVseb8q0Wwzlh99GH+s0vAdTg86q8NHFTG60sf2iWD3i/Dtel4Y8Qi0n6AMN6joAVJV8i3gEzSOi3yNkhE+gTHJKyVDQC3bh6jeretSpXOiA0x65en5V6YVNHcUNZLVCMTMGY0FJKJDwta9/AOkjqeKKNU1DPRZseo1qZoZ7drn8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4Qh/jSYwgOkTqMbPJ/GTzzliZARfxaZePri6cTULPc=;
 b=UeJ2UTiQH+ld1sGk6Tnx+n/Fwgf0/AJrE43YcbA0ZYvznXpaH6FEPINO6GWdQYIGUhavhHozwzfbjAIw2j9CqsyOTV738K+oRE+gzgd6VcyzshTaKP9pL/PeiCCideUmMyl3TMpaKAQgmg4nPgGTCCZjnKTe7NYfGYqV5Up9q1wKiNkUX0E7yoL3uwEdW3S1eBJNU/Vv3vG6IdDsM1wgR9oA3g/HrsQi3EPI4fpxvbpayt2kvmD0ivRfkLCmnNOyP1ezfnw6YSi64DFACL/ds9Qlxs4Gh82Yih9n6HymyIKi9+b/5qRCOc6D6jY5l3sME1HTpRAZuDJrnEQEpxwpow==
Received: from DS7PR03CA0188.namprd03.prod.outlook.com (2603:10b6:5:3b6::13)
 by CH3PR12MB8233.namprd12.prod.outlook.com (2603:10b6:610:129::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 08:55:02 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:3b6:cafe::64) by DS7PR03CA0188.outlook.office365.com
 (2603:10b6:5:3b6::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Mon, 6
 Jul 2026 08:55:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 08:55:02 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 01:54:46 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 01:54:45 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 6 Jul
 2026 01:54:40 -0700
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
Subject: [PATCH v5 11/16] vfio/migration: Add new switchover-ack mechanism
Date: Mon, 6 Jul 2026 11:52:06 +0300
Message-ID: <20260706085211.13905-12-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260706085211.13905-1-avihaih@nvidia.com>
References: <20260706085211.13905-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|CH3PR12MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dcd1c0d-ca4b-44d8-0719-08dedb3c4487
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|376014|7416014|82310400026|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: iXGMWxjUtOMB0ij200TSBl7eSzlzXeg8rh5EMb25u6jS4ohUhKOvMgpQjv/TgoizuYsr8Qs7BXsBtvNBbxLnm0I9+h9BXfQEN5wIoWp1rtaTZ+MyxsZfGpvZHEThx1jla/3bbLZHh8NWEr/o69fVsk7vNna4zIioleLsaH3BtFwencqjsFbM+dUuiH1q2PJNw57lwOKsdGqDAyZUbHwHx+XRALF68vj+QFvFsGaoJkx+xanwovf2paHx6FruXSsYIrtXeDc6Bh8ADoPn8zrpfWM3MG0gZJyJwhO+cxFL64E8ACtrtLthAHYCtrDUwe+jbk8XajKOW0cS6UAF0vzJGI3Qv0Gh10G2Mi0NPlf5tmXoBLhJQbgJUIfQbwkjWNAmn+kUJ7/zKBzmcHjzcW1+y/X9mbX3RvGOZGTjxOf4942s6CI11zc8P/ZjSYmNiqOgyBxbcfL67RVCiC44RAPcTt3+DhEeAllp1fLHPsanCNyneV24YI6/DQeYsRm+rnC17o+uYLvMEJOpxQz2s7TUORna5D4MWtsalTwc3NbxCgUnCIyqxL70w/JP0wn/Yxa7i5wsmsxTvB9hkCrvLaeS3DvkUqy3RkqvAb6rSVDSTaUkjhPuu7K3tDx2hQeOBiMVR2ke3FIfCu1WPuVRQYZflybjz0XhYCjUmU7VYYIWQyjyGEdFf0hoCRxmUJtzkQGqVB7+1KMnUlUE5b8cDoTM2Q==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(7416014)(82310400026)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VAZm77/qcHk6Tpgo1wcUOpOpjcXZIugcqv6sXKW9pxn6wBXyACXxO8QjE5CLBMzWOLHJJ3a7XvlFLgyF4Wzir+dSuJhYDOflGkX45/oL6LIhrzv8oaRMFpWxM4q+7CROwyS04ThOCGQtaX1hZ3N3Gv0B5tpmP+PCH6cav2inQHZ67+3Z93rcjpDBXdiLCLhLBIghW9sMeJD/1Uoi7rr0pSXx+Z1eiIvrTjUyXv2F/l05SkG8KHeWEVkf8GV2AjisvAx4QnAxGOWuY5agRo9M1DTLEPRsR/MTL/G3OfDla3/L1rNBFIUsrwHqEibuIVWm8EtW8TqxARgri5ezReul1FkZxdW7SiBOIVUsCOxiWQyo2MIA9mkuFQ/Cu99XvdKQkfn6Rdoc5/7wwM+1xaloWjOwwMinTVdvlYRn1KIls5YV5RiSzkwI8fjGSQSnQxLo
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 08:55:02.5970 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dcd1c0d-ca4b-44d8-0719-08dedb3c4487
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8233
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=avihaih@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
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


