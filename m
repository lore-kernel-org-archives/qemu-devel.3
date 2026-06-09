Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D9CCD8CAD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:01:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWrOu-0005Zy-Oc; Tue, 09 Jun 2026 04:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wWrOo-0005X1-Ul
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 04:01:27 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wWrOn-0004pG-5E
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 04:01:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+t03MGqB6nbQZLxdZtx+6U11x1pEh2DFnuXwoQRFE+zLi5hQfNjJbQ9B2BNQ+a4TeYwjr5iHKWttFOm62Na6y6TAWEL3IA50hEa4DAmL8jTxTFqVmI7Om+39Xi5YMsa9NpMdgJb5WIYg69WAA20tk+WSBLUxdv/eecdsvVXBE2jhWh0x6HW6IMaSMsrRWRNP/TIjstiz+VybfuOZU4O+i+/LMlUKgkB00buyv8+C1UwuiFyd6aUKSx53eb+TIds6H4/HR5FbUeUbzUze5SXEjNzUXbXCrF7ZSri8vkGbIrDSVqP5xaDVNm+WjsJpNse8gliljZSwBBXgWHrI0LIXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uq1hplQ5pK+cE64OCMWgLlH90LFNTj2fkuw/Bad+wOI=;
 b=BIPwAlYIOVL1j2ABtH/dYqjmVZ8QVFfuQTcWTeqUo0z9g/lwfsFXGY15f3vjff1Oa+6SiIR5+Ey7CBN/b1WpPn92bJaaiI4kq1T9a3cdBtDeeSfTk3xx46bGh53yG1HQ4B1Ji25Mt0NLccoxJ7BrTz2rWUmrSzQC9ZRR7euTLberPYFdg5bklGf5fmF0iCBP2YNxMhAEF0NmWNKd3Kcx6ZF9OQP9NfiUxBVn+TCuLqwz/sO4DPscI6R+oSQIxez6em0AwPwwHRZHPxx8nuOmS2OHjd2B9PF2KfuW7vyTbl96xNRaAvYcLfqozwTe9pC26lCWXjVRLTvJgzySKz3uOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uq1hplQ5pK+cE64OCMWgLlH90LFNTj2fkuw/Bad+wOI=;
 b=XqHsw/YOsg7rbyIw0k7RC+J1sUuE1tCnpfx40s8FcBHvzpzisNyuUoBJ/0smOWfajp5AbkJqJsXBzrcVZ60VbKOI/ossJIA7Z2c8+JEO5X5uTMSdUbITWRG4mOT2gBJN2XwIE/7zbpL31U3Hw+72ZkIWcZyhIN8wnIrAGj18lQuwXVDuPPtZbx/cTpk1tqlfyOrA1/BECAVHrTVpL/Hx03K3Cl2Gt0yJlVRWdec21K8qlVkxXkgF22eljMe4QRIMVXk+qkZZC0AYOQKqa0JuvAX1d0sGKaPTDPFxmec1gQAyflE6lV9s4HF3ksVPMGYZhKoI3Qx9Rbv2IK1AsihHRA==
Received: from BY3PR03CA0010.namprd03.prod.outlook.com (2603:10b6:a03:39a::15)
 by BL4PR12MB9508.namprd12.prod.outlook.com (2603:10b6:208:58e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 08:01:19 +0000
Received: from CO1PEPF00012E66.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::ad) by BY3PR03CA0010.outlook.office365.com
 (2603:10b6:a03:39a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 08:01:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF00012E66.mail.protection.outlook.com (10.167.249.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 08:01:18 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 01:00:57 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 01:00:57 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 9 Jun
 2026 01:00:51 -0700
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
Subject: [PATCH v3 11/14] vfio/migration: Add new switchover-ack mechanism
Date: Tue, 9 Jun 2026 10:58:09 +0300
Message-ID: <20260609075812.32067-12-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20260609075812.32067-1-avihaih@nvidia.com>
References: <20260609075812.32067-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E66:EE_|BL4PR12MB9508:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ebf9f8a-45af-4193-c582-08dec5fd49bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|7416014|376014|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: pqElLuKGrHnONpyn1jZFscQaySFx0q61txrKjqFYycQ96tTClkuEu8j0jUPw6VqGXY+GPHb8x/ToYC0Tt/A/iJ7iPEgi9XACqCDdMgmAemiQrnE+3ca16FuDDRqW2dgt240RFIHRzaL5esz+66ppbTrGz2SL3i6u8XrtpiyY9rAXxoj8OXv6GV8kL5PJz1om+Y6vp6InCVbWBpeg/OdMQeBWNOX1uDVoEf0LA5HuIBvVvZJ0LXLHuBph7V2IG7yWrU02/dvJDCqquvfj8u6EcMcZnpgOyQ5jh5CmYNFd6l/CH4RBkQQX00QCiZ922WdrvuaSu803UyxmsTiiL2B306dAwD24FcZOLzX2Yv9Cvv640uZg5EBA+dnKBosAMtjApFzhI8itg5figXZroqqgiXGsXDhPgYc85ZyupomMkGRSMoPAGqeGpDUQFs4DHNljeXBEH9IdQWYTBemnBXh92EFZED4F2ImDp5DchB52ahJZ9Y7jpcZh8fKEexAFIU8XTkHFvxF2NaUDc1cLCtGWYk3qqhwHN4YTuNfXnj2Iarl7ySByGABRNANx4oNRid9n8Hinr8bdysqAMczWcQ5IIBAGOXeIULXCWVljuIDDH7+F/aNtx4dSg56wSaBrRp8BRKqwvqGzaNv7dr1w6Tpwaakx48WczPxQeeMKQgR0pPM9g9/uiAAevl9GFXnjScMbyXVMt/6ZOisPSVqoVX3u5LecpAHyNfJUeVCQ+7cW1gA=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EVzE3wVZ8Ap661CDKFPy7m2LilLYtAxHrCBve5v0S+fDS1EdfPYEigkW38EL4NwaI0txO1km9VFQo6GJzAHO1C6NaDzYFjNH/4zaRtpRyiCnK4EILc7EAQFYjsZ1zbyjjhzd3Xa4OabT7NJ1NM41QpChLYhJPgIfch3dG8Q+soJYjStUMXCC0Y+hrhS2ib2qKAcOKrIwtEkiVEAcy3d3X0clVZyUipG/A54KM7M20N0Nx6kcLDjH7RADwABEMBPFo0rkxBRZ/sR1ot8v/ZcofE988H49TFVLbvmgDRevxqRsAjwJrtsMwOx4wnJs6hCkx+yhBV0xohl5JkE0YnmpXvi1Z4IG5JbxWIb0cLQxhcR6Jk5YDEysWLleH+zOYjx+bonds2r9Za2G6pXsY32I7IV/LpDISaXTGN6sCkYIOnd9//V+8Swvr+bMFE0G5CYt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 08:01:18.6635 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ebf9f8a-45af-4193-c582-08dec5fd49bd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E66.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9508
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
index 411a306635..53f0ba357b 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -175,7 +175,7 @@ vfio_save_device_config_state(const char *name) " (%s)"
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


