Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C46C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 13:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7EaK-0001JG-RS; Wed, 15 May 2024 09:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s7EaH-0001Ij-VL
 for qemu-devel@nongnu.org; Wed, 15 May 2024 09:22:18 -0400
Received: from mail-dm6nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2415::600]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s7Ea8-0007FI-Ay
 for qemu-devel@nongnu.org; Wed, 15 May 2024 09:22:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4Q3thHFGN9cPgMtJtky74RITzbdZte0Bo7IRdOCbWDGY//vRHK3NK72Im0R+hEo5Bu8NhEwOFG01TF/zbTrXhQ6CPgzqSZ2jSyAJqTM5qX1zqYewJu1XX8RFSrMXjSQGIjfW57DUX7yKjgRR5owy2U4bpUXdC9UhRzO+brbagHyF0zQ8ZevSEBwW3uYeUY1ppUwODc1lV1hIRzoDiVFnYiL/Pi4DmUha6ci2Sbfqdh4VzV88+Ph94ebdj9irz/e1IOZ19T33fo08BfXOJ4+aGUo/UmadEZ5ZuvzfuWOIZv+YDJtP+rjtjQKyCotShNkL6j5pXEPPHVxtNqKWNN8SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGSveI8gWjWqlXHzIK8RnyyI8vYTqlSU2h79zeFC/wo=;
 b=lpdeSwqNqRbvPmqYZRKbUmXyEZWTay2YPzfd8k6QKhmzIN3v53enh4QvLgsieuP2Sy5kRMXfDRMBEtsOmmhSZycWrCyK9OED8Ky6DH6n/d0FnZ/XY1OIrhp/csIbijBLPNAKocQdKIYuZSXWzr7hY0zG2n6hWkRpWvhmL5hzJHYaT1qE+53y0ukyEGhuq1lNteyEJatAW029Gn14numzA8maq066UGmnhbwqoBkKJgyTk0ONUMR8A9Bmz6nlyL4oAQRH2NL1HNIKjzZEGIP/GT6uJPeWJjlYMwqRFhduMerpugJvyJf/QkibK3thrrkAEwW70HIq0IOxk27V5qh5ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGSveI8gWjWqlXHzIK8RnyyI8vYTqlSU2h79zeFC/wo=;
 b=rTvGIsAKlY316XfB9uuubehI9gpVb3FtCw5CYFZRiWWbwaQDVYSbSwV8rSBdUV0bQors8wOG/ku8lC0fZOhXbnalbRGNXbMpX+tor+CRAzrHzn5UczgprBWk2QtPDnPHghEarPqbMKvH7DwqqRyA10SLTGjpItZsUdI0yADmdOCPQW41AMlYQ03nwoNc3MkxV4xvpiaTp+RkNxN4My5mhG1fXDKMrvSXPNuPpfw3g6rkTDjjgrJ4nz4bqkvinl436FQFEWam9bzsuZniGQfMnLfnlfLsJkUzajf/OiQZ+Djf3nXha2IH0TMzcGgBX0WW6Z8JtahQK8S8TqEhWqoFHQ==
Received: from CH5PR03CA0002.namprd03.prod.outlook.com (2603:10b6:610:1f1::14)
 by IA0PR12MB7626.namprd12.prod.outlook.com (2603:10b6:208:438::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 13:22:00 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::af) by CH5PR03CA0002.outlook.office365.com
 (2603:10b6:610:1f1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28 via Frontend
 Transport; Wed, 15 May 2024 13:22:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Wed, 15 May 2024 13:22:00 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 15 May
 2024 06:21:48 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 15 May 2024 06:21:48 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport;
 Wed, 15 May 2024 06:21:45 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>, Eric Blake
 <eblake@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH v3 2/4] vfio/migration: Emit VFIO migration QAPI event
Date: Wed, 15 May 2024 16:21:36 +0300
Message-ID: <20240515132138.4560-3-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20240515132138.4560-1-avihaih@nvidia.com>
References: <20240515132138.4560-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|IA0PR12MB7626:EE_
X-MS-Office365-Filtering-Correlation-Id: a83355ab-396a-447c-6cc2-08dc74e200ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g2Cc0Jh7hDLxV3cg4yRnfdG6afj0wCq5UMf3dugfwyvvIDAiebVQTmVW8PK2?=
 =?us-ascii?Q?i6ak7lVB4jN6KC/+hVpphdbw7WYiVZHPX1rFd+V60sANXWxGWunuudA4nWv0?=
 =?us-ascii?Q?Kai/AsEMSdaUO8eAbPEmVbTTmDpHzg+6ZIN8MdfRzj9X2/W5npnhzg0KJUdI?=
 =?us-ascii?Q?jMYdgFLMoDDhP7djOuu26W16bWBIbjC13EslZ94p19WzpdKQodPyVQE4D/Ys?=
 =?us-ascii?Q?Ad5WMdycVpAoMpDqT8hslo5E6QnxLh2eLaUl1pFKIEyCG8cDWF535JuR4wRm?=
 =?us-ascii?Q?mkj+MmLVKNiJ4+5a5/CSmltLjRpri1+nDYK2kZHZipADtmONt+j0G5VxKGf0?=
 =?us-ascii?Q?mJOReNIdIdE88+UznsbANWpy97SG6Zy4Q8velz8MGeNADNEy9tfNijQCUhXy?=
 =?us-ascii?Q?z9m4JS6re6sL0uza7t0Wf/qdDPoRaN7G4LeXnAjvrtLnJ6VxYfhVRfUbAe8s?=
 =?us-ascii?Q?MEHJQwckOFORAnIjVucyZW3L5LmggCVgQQKC8DL/Fpwq61+1iW1U5rLRrnYx?=
 =?us-ascii?Q?LmFMq4RGaB6kpQGc41/THnCLgQLZbFX8hlXImTpYAFwvFiTglV0xKWYjLQlu?=
 =?us-ascii?Q?srgxQR1v2901NzUJz8mMF6pT8LG6yGA/SVUcuqHE1VhEUv8wWhQdaAv3EisT?=
 =?us-ascii?Q?oVbf4PptUSpH4rJR/HbAMgloEKD+Gtn/PoA9ULp3jqL76HelKU0HB+kKpNdq?=
 =?us-ascii?Q?zW3ntsK4rfsQolvtc2yZ6Z9FeMBLJZSF7T5jPuE1jOOzvWDtXBUgTlPHRNlQ?=
 =?us-ascii?Q?FVSOD26Y0lgWxXlLGIrtLA0HSo/lnrc5+OLwI3z2hsN/crelcOLN2wMd2Z4Q?=
 =?us-ascii?Q?kbOyrv5Mzjhpy0GVe/K0N2/7/DMkjYVxV+g63tigMMXBMBKgG+zCLsYV6tzy?=
 =?us-ascii?Q?suBitRqZhQMa7PKBI2mosZCrlJ9gc3Qv2tRqQSj2nXADYXtX3JJ/4otFo1OJ?=
 =?us-ascii?Q?tKlf4BQ//AJa1OHD3s5LJU3SkXjOR3W34L9VQqqTGiuyfRlMe3BSSyiqwZHU?=
 =?us-ascii?Q?1Lgj0yWbs15B3Tl6CZ8FxrUikEjsAimcbqEHYuU1QMxlbZ+mTzezLLf2lPzd?=
 =?us-ascii?Q?1ZkjomdAKyCDE7YpzuxxddUgGijXAgT7hcOc2/ZGeGRmtIIbVJv1xHCfy8UP?=
 =?us-ascii?Q?SExom7PUHREAfYCOSoaZJwvTGaWRdjkpLgZM4OEkM0bTAptieArRGI+j2zIG?=
 =?us-ascii?Q?Ix6RBFtuJP0amW92XsovDdeE5BWD0oPoC7UOsixdfdOCjjjzlhmUwvphQwWt?=
 =?us-ascii?Q?qHz/1p8WcSkvdYrSx9RvSxD3XTODIUMrJdpTM/+/UN9Vx3RmKRL2pxlN/RNp?=
 =?us-ascii?Q?+xOoqzqeuXeYD//yRyJIQyzQ8MZrmro+UOaasdJxmRB7g/xyQOMDjV0810w8?=
 =?us-ascii?Q?FSAJ/dzUSAP3ONtArwDLmbEeVb4B?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 13:22:00.5352 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a83355ab-396a-447c-6cc2-08dc74e200ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7626
Received-SPF: softfail client-ip=2a01:111:f403:2415::600;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
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
 hw/vfio/migration.c           | 59 +++++++++++++++++++++++++++++++++--
 hw/vfio/pci.c                 |  2 ++
 3 files changed, 59 insertions(+), 3 deletions(-)

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
index 06ae40969b..2e1a8f6031 100644
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
@@ -80,6 +81,58 @@ static const char *mig_state_to_str(enum vfio_device_mig_state state)
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
+    g_assert(vbasedev->ops->vfio_get_object);
+    obj = vbasedev->ops->vfio_get_object(vbasedev);
+    g_assert(obj);
+    qom_path = object_get_canonical_path(obj);
+
+    qapi_event_send_vfio_migration(
+        dev->id, qom_path, mig_state_to_qapi_state(migration->device_state));
+}
+
+static void vfio_migration_set_device_state(VFIODevice *vbasedev,
+                                            enum vfio_device_mig_state state)
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
@@ -125,12 +178,12 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
             goto reset_device;
         }
 
-        migration->device_state = recover_state;
+        vfio_migration_set_device_state(vbasedev, recover_state);
 
         return ret;
     }
 
-    migration->device_state = new_state;
+    vfio_migration_set_device_state(vbasedev, new_state);
     if (mig_state->data_fd != -1) {
         if (migration->data_fd != -1) {
             /*
@@ -156,7 +209,7 @@ reset_device:
                  strerror(errno));
     }
 
-    migration->device_state = VFIO_DEVICE_STATE_RUNNING;
+    vfio_migration_set_device_state(vbasedev, VFIO_DEVICE_STATE_RUNNING);
 
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


