Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42F1C41513
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 09:11:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4znR-0004o6-Kk; Thu, 09 May 2024 05:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s4znQ-0004nd-3t
 for qemu-devel@nongnu.org; Thu, 09 May 2024 05:10:36 -0400
Received: from mail-mw2nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f403:200a::601]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s4znN-0003T5-GV
 for qemu-devel@nongnu.org; Thu, 09 May 2024 05:10:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CESMs1JkvJ15BtB/SGdEAbaX6MtTqdH9dhB+OwOhh+x2bI8IWs+49EO5IQ8xUOWIaXa91FQSIAyNx8pZ/SaBGulhOet2aBGOFvojJJyX8uZk60JtKLYFyyM9/DPfpd7hKOcvK7bPN234Ch3Kb59CekZWOxHb0MAbPqpxmRxes90xbXf2PRlsUBmYwnq+LyMJBQwyEo8IAyS+V612Fjbqa50Pf1Hy82hBGyMO8uVbSdyt9wAVy6Ush+NJkJdtdJtMP9qsRyWoISHyB5p9HdsCL0mMZLImUa4Kmm6xv651A5JNsUB3HI+nd3AewsBW9axUrzPIhtkKJfL57/0WwmtwKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDXPi1eKaN76rgzC+w4BLL1j0SEwquiNwP6LCfrF4Ss=;
 b=I7sR/oJIP2UeHtZDrhe1PAK4vc5g/1bCok6PjtGS7uZX2K6cByLvwiEiqaJtnaOfrnHQgNtkuMZrrQ0LIHNpWieMylTwmGPhyRP+cCiP9A8WjuJG/KQz/GqgYts71CXjFJbwpLwzq3grusmKaVaZawo/NythnquLWJQuqk5k01kW44c/Fa6D/YAEAIEdbAK5xtKmQXNgzin1YDwBoAEQtLEcvbdXHDPSUJK36hZjeKJYimn/qaWf3GRzmrtRcETSK4hq9M8Gsto5DoVDeFuMJhk1JUKs7Gb03RmNAAF1uBeM0D5qHQln/6cy9pWweZ/Rebb/BLF3glKloY8SRhJxoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDXPi1eKaN76rgzC+w4BLL1j0SEwquiNwP6LCfrF4Ss=;
 b=T8+EbUNEpOIzhTnz5NW4ObYyqshl2IPI61eC01kX08ujAtHuh+gTluCIGG4uem2h48BwrC8A+kgKK8p5gbzVP7dgUDG6FBHrF8YJggxyRjf77C1D+2kW6u2Wt4j2xtQfwNXORcg7UMQzKe8LmnAX8LxTwOJfXFevEntfUi6lXQjH3vwENDjL7ESEqO2nDUQVKe/c7jyJbImKZZlFtfQr1HD1HuM5WnevXPxWCHa17wF/Txcwu3XPzqoOMPQThfUgt9g6xSMN1YDOJwFNcUw6pVvQRt/AomXqpoMbSiU+wYqiHc612IYq5lKZR3xJcfAtHEK4caIen6iJtF5ZoBmm9w==
Received: from SJ0PR03CA0216.namprd03.prod.outlook.com (2603:10b6:a03:39f::11)
 by DM4PR12MB6325.namprd12.prod.outlook.com (2603:10b6:8:a4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Thu, 9 May
 2024 09:10:25 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::e8) by SJ0PR03CA0216.outlook.office365.com
 (2603:10b6:a03:39f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45 via Frontend
 Transport; Thu, 9 May 2024 09:10:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 09:10:24 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 May 2024
 02:10:05 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 May 2024
 02:10:05 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 9 May
 2024 02:10:02 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>, Eric Blake
 <eblake@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH v2 2/3] vfio/migration: Emit VFIO migration QAPI event
Date: Thu, 9 May 2024 12:09:53 +0300
Message-ID: <20240509090954.16447-3-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20240509090954.16447-1-avihaih@nvidia.com>
References: <20240509090954.16447-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|DM4PR12MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d6251c3-fb0b-4f10-0c2a-08dc7007dc71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400017|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dzzOCja6BMwakU7hXPVpEBJRO8f+e5mbRs5pI5BIZ3E37Z8W3ifKk6O1odk/?=
 =?us-ascii?Q?29IUZ/d7+/MUeIAMUQZdnW2CTdLDAZs7i/gmz3aYcY4QDjzyrrNTjo++mgZP?=
 =?us-ascii?Q?l6KerkRy3OnUbkPWCGQ0s1lWsdW936hUR9/LE33qYsttCt+zAGb5g7uzaz7N?=
 =?us-ascii?Q?QyKtyyvq5N7QvtUk0y04tOTdZdfs800c4GuWy/3OcqfRpF8SEbNWx2i1jEju?=
 =?us-ascii?Q?OgyNc4dsvpx9PRQBbG503GuI9+KbHnYzYi3UEEvD/+aqTGkWrF/YZ+Qaowdh?=
 =?us-ascii?Q?4JAtzu4rdX6aBxbl1PZVCrf61HDPs7gIL2gkUigDQNI1u5e2EubEXhyzC++y?=
 =?us-ascii?Q?N8NwgExggnXONPTftqmCCW5AHEk5QdBebQSnl67vetPeOmLy03H4Pq3Obcog?=
 =?us-ascii?Q?ZBO/AZqpvYRy16qoAUsVrYMrk9F38DTGc3uYpQOlqZ1+IqBGmUVSIGR7MJJp?=
 =?us-ascii?Q?Epa2EnrcvGJyHxw/ZWi4jBYIS5UTGgr7uDBnwO0IAMzG9p2IMOxdJiyZrJcw?=
 =?us-ascii?Q?aYaNJALycK/o24MEE0Qa2IcfBklIT6KFfMafgR75Ecdj+Pjha/XfMu5pcm4v?=
 =?us-ascii?Q?zLSjxgeGiCEBDpV8cGwFpZ9hZR55Qx244Qsf+1Q7dygpYuejnsg1Vfl0ADfL?=
 =?us-ascii?Q?cSFgjHYN7UqMNhq5Q4bIDYzMoYj5k6kllEvR2+SKyoe2cxndcxbUpoapj8WV?=
 =?us-ascii?Q?z+UN0YsOFF+N5C9oEi3dzqeQkUMg5vHgHuUXtcQDSvIJwLyWP4M4/04gMSMc?=
 =?us-ascii?Q?659eAWrJv7vn2Ro4xv5ufVxyqLB+v6456puB9xMAwQXLr3lgCdU57RPvLHmf?=
 =?us-ascii?Q?SX9OcJ+IUWtGhJ93Gxn0IYsbrULcQVda8iOKH5qrA89hEMuATxPhyghXoF5s?=
 =?us-ascii?Q?H4x3EgXtghPLWftvE49rnQBsh51I5f5eJF2EBI3FpyQwt9GgI3zkBNcWI89G?=
 =?us-ascii?Q?9HX9HTfFE6on1ArImnGkbrs3oR6tKQ7RbEEsCLzrUzCNzyB/kBa6a3/dOQ/6?=
 =?us-ascii?Q?6sJpCGQ+dbYdg3SrA13TTTVBEW3lEDT+m22QsWdoRvH4KOXEAOKb0t1q6oZV?=
 =?us-ascii?Q?Zqy3J4qAR6RU0fDBY09KbKgzavP3zAsvOQPAgiizMsfSXeaJdY9+DlmxyYvK?=
 =?us-ascii?Q?AqNuf6R0dXMZXw9ouObjnLXkey2cIXr8EpWs4Wj2zisO7Sspnvj7WAbWmoUk?=
 =?us-ascii?Q?oWXe08Aq/H491fLS0slye1jYHggyNx2TYLDXUVkX/Au2Hp3sgjXKUvoDEo5z?=
 =?us-ascii?Q?16qxJhgRbRpy8CeVwSWkE8sv7GQ3Ls5mbpB3PUS42Z7ou+ukooVJXKsgAIo/?=
 =?us-ascii?Q?yx7S6tTRHYd3aolnTD4oPExeDjLdWNVn3fp2noOODKcRSgGaJdtfOBHPVabV?=
 =?us-ascii?Q?87/yZT+1G4D/9TM3rPh0zbncATXI?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(376005)(82310400017)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 09:10:24.3683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d6251c3-fb0b-4f10-0c2a-08dc7007dc71
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6325
Received-SPF: softfail client-ip=2a01:111:f403:200a::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.582,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Emit VFIO migration QAPI event when a VFIO device changes its migration
state. This can be used by management applications to get updates on the
current state of the VFIO device for their own purposes.

A new per VFIO device capability, "migration-events", is added so events
can be enabled only for the required devices. It is disabled by default.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 include/hw/vfio/vfio-common.h |  1 +
 hw/vfio/migration.c           | 56 +++++++++++++++++++++++++++++++++--
 hw/vfio/pci.c                 |  2 ++
 3 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index b9da6c08ef..3ec5f2425e 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -115,6 +115,7 @@ typedef struct VFIODevice {
     bool no_mmap;
     bool ram_block_discard_allowed;
     OnOffAuto enable_migration;
+    bool migration_events;
     VFIODeviceOps *ops;
     unsigned int num_irqs;
     unsigned int num_regions;
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 06ae40969b..5a359c4c78 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -24,6 +24,7 @@
 #include "migration/register.h"
 #include "migration/blocker.h"
 #include "qapi/error.h"
+#include "qapi/qapi-events-vfio.h"
 #include "exec/ramlist.h"
 #include "exec/ram_addr.h"
 #include "pci.h"
@@ -80,6 +81,55 @@ static const char *mig_state_to_str(enum vfio_device_mig_state state)
     }
 }
 
+static VfioMigrationState
+mig_state_to_qapi_state(enum vfio_device_mig_state state)
+{
+    switch (state) {
+    case VFIO_DEVICE_STATE_STOP:
+        return QAPI_VFIO_MIGRATION_STATE_STOP;
+    case VFIO_DEVICE_STATE_RUNNING:
+        return QAPI_VFIO_MIGRATION_STATE_RUNNING;
+    case VFIO_DEVICE_STATE_STOP_COPY:
+        return QAPI_VFIO_MIGRATION_STATE_STOP_COPY;
+    case VFIO_DEVICE_STATE_RESUMING:
+        return QAPI_VFIO_MIGRATION_STATE_RESUMING;
+    case VFIO_DEVICE_STATE_RUNNING_P2P:
+        return QAPI_VFIO_MIGRATION_STATE_RUNNING_P2P;
+    case VFIO_DEVICE_STATE_PRE_COPY:
+        return QAPI_VFIO_MIGRATION_STATE_PRE_COPY;
+    case VFIO_DEVICE_STATE_PRE_COPY_P2P:
+        return QAPI_VFIO_MIGRATION_STATE_PRE_COPY_P2P;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void vfio_migration_send_event(VFIODevice *vbasedev)
+{
+    VFIOMigration *migration = vbasedev->migration;
+    DeviceState *dev = vbasedev->dev;
+    g_autofree char *qom_path = NULL;
+    Object *obj;
+
+    if (!vbasedev->migration_events) {
+        return;
+    }
+
+    obj = vbasedev->ops->vfio_get_object(vbasedev);
+    qom_path = object_get_canonical_path(obj);
+
+    qapi_event_send_vfio_migration(
+        dev->id, qom_path, mig_state_to_qapi_state(migration->device_state));
+}
+
+static void set_state(VFIODevice *vbasedev, enum vfio_device_mig_state state)
+{
+    VFIOMigration *migration = vbasedev->migration;
+
+    migration->device_state = state;
+    vfio_migration_send_event(vbasedev);
+}
+
 static int vfio_migration_set_state(VFIODevice *vbasedev,
                                     enum vfio_device_mig_state new_state,
                                     enum vfio_device_mig_state recover_state)
@@ -125,12 +175,12 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
             goto reset_device;
         }
 
-        migration->device_state = recover_state;
+        set_state(vbasedev, recover_state);
 
         return ret;
     }
 
-    migration->device_state = new_state;
+    set_state(vbasedev, new_state);
     if (mig_state->data_fd != -1) {
         if (migration->data_fd != -1) {
             /*
@@ -156,7 +206,7 @@ reset_device:
                  strerror(errno));
     }
 
-    migration->device_state = VFIO_DEVICE_STATE_RUNNING;
+    set_state(vbasedev, VFIO_DEVICE_STATE_RUNNING);
 
     return ret;
 }
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 64780d1b79..8840602c50 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3362,6 +3362,8 @@ static Property vfio_pci_dev_properties[] = {
                     VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
     DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
                             vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
+                     vbasedev.migration_events, false),
     DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
     DEFINE_PROP_BOOL("x-balloon-allowed", VFIOPCIDevice,
                      vbasedev.ram_block_discard_allowed, false),
-- 
2.26.3


