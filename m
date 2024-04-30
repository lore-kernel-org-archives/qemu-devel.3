Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFCECC25B10
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 05:17:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1frU-0000jx-AJ; Tue, 30 Apr 2024 01:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s1frJ-0000iw-UT
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 01:16:54 -0400
Received: from mail-dm6nam04on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2409::600]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s1frG-0006Zr-I2
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 01:16:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brGOo5CViVz3hLu+qAaUgcr3Sr0IPrx1KP3wQz/Nx+yhpPTsHqwUqe3T8JegPQrjnnEboXTJyYLu679IPYQUzeTIxK43iWi5CoykI1+mw1DuBontWgr7cYslhA69bgwXnSEg8o2WphtWgx7ZGwzxgCrp265oMIl82kjUXvipZ6FACVpy2CxCLPNjnGIt/eHe35n8OGAMPhIT8eHjceH/M8qXCAaIxkvD8GM+RRQT4HDeiVdwYbUIG3FkI6wBwCBNs0a9Jiw8LmipMkmUnvtpSn0oGktjFkwAZvmSWCYd53zcUWfFcqad+HnhluDDXJe2rekHGKT/QApz+6hWqSyq4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trL3uBjO5cicwCkNsL9K2hS9t77/0ZNOOJldkgzrGNU=;
 b=YJxUF7Lly2dZ8pno1Xf/N2hrichUZut6NNP1jTfwEbb/ExqgxZSgTBobJZCjIJ+GV+nvlESb/lRdmm+gFO643ytb6EBV/qE2L7FgQLh9v63HrmwHio/uHriF34PQP72IdqDrTqPqMaHdZ5YjfZ/9R7aNbDa2NL3bci0RCJ2Xqk3kjVLjsvF2RJtlVr+g19Lre7Zmgnx3FNtgF0JS+9017motYpL9iT2M1mTCaT5nDIieCklkX7qZHZrPW+i2oNqE4kO9KEZHxvFxAEPTqlXtpsHfIW2iQfibLhN9q9chKHw9pAMgIvJUN93z7mwTl+BZZokjRHpvDUSj1x1L+Pz8Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trL3uBjO5cicwCkNsL9K2hS9t77/0ZNOOJldkgzrGNU=;
 b=EICAoWGqhu+iUCis2bGv8IPUBI6kh8ashzrH0GoCWBtURgnx1so1WbKOV+7uZoxagCqomK2vrl+puA0uTMJ2CbebzdOgwL5vwMuelSbSLlzLp3itz6YFflxQaMjxlpg0MvhnkZ9Axz8RQT/3pAv1G/7btLun06oyuecNRrMi6hkmWliVW8t8/tLe+lDh9rfRlGP1tErA4fi1i+Bm7dyuwqDOYBw5mrdj8qK6tOznBlwzrLvgrAgWzO2HiXNPdttc6VhOmwDoaDfyU/BPqjEKWXcb0+9m2AxUtY+lPyPjaU31bEHbJqK6qO9fHNZIQj0ONrA8bjaGJyHCjs1DHfWMmg==
Received: from SJ0PR13CA0016.namprd13.prod.outlook.com (2603:10b6:a03:2c0::21)
 by IA1PR12MB8310.namprd12.prod.outlook.com (2603:10b6:208:3ff::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 05:16:45 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::4e) by SJ0PR13CA0016.outlook.office365.com
 (2603:10b6:a03:2c0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.21 via Frontend
 Transport; Tue, 30 Apr 2024 05:16:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 05:16:44 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Apr
 2024 22:16:32 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Apr
 2024 22:16:31 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 29 Apr
 2024 22:16:28 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>, Eric Blake
 <eblake@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH 2/3] vfio/migration: Emit VFIO device migration state change
 QAPI event
Date: Tue, 30 Apr 2024 08:16:20 +0300
Message-ID: <20240430051621.19597-3-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20240430051621.19597-1-avihaih@nvidia.com>
References: <20240430051621.19597-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|IA1PR12MB8310:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d1da453-4018-47ab-8810-08dc68d4ba5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|1800799015|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8BAfbuCoq4M/wbboqbgfOt4uVA7Hs84zNxvV9xuvSGqskZqaLpinIHlN5g3I?=
 =?us-ascii?Q?bXvcdpQb3F7YPJhJYO+ignqjlGcb74z4WEONc83MYw2tKvbGjNgo+I5JIrFO?=
 =?us-ascii?Q?sqZmycoPluhRlEnZjggQ788rZy28xiylD2kkFg5fnLBwrdYY7muqJg1L6u+T?=
 =?us-ascii?Q?XM40sKTx4qc812K3YuK2m17UEYIsjQGti5kxNCMoeAddrjp7x26FAkE+VeED?=
 =?us-ascii?Q?ctEv7CAsXW6nqvU3ubOgybPba2Ek5K4sbs1NkgRzxyC9nNnTR+7v/i/ww+dz?=
 =?us-ascii?Q?gnJu7SvDFuVjIgNkhDpOpcZVaIU2jH5Qdj0CkEDQ+qFcijhCecuC+izoE/g0?=
 =?us-ascii?Q?MucJSbnBHdDJk/56zE6SBTPnv8PT3BqbTQDK/3WgdxkHui+GKpIjQnJu/3bf?=
 =?us-ascii?Q?KGf1vDGWhOdk8ergzfhSrqbnG9VKeHq30al1iBtm1I+j3MxFsJqELjRRK61x?=
 =?us-ascii?Q?Fp1NyKaRQC9xbPoXPcTiMLaVtsrlkZED5kslt0kncGIOU9cMxPNb8us31gLK?=
 =?us-ascii?Q?Fo2jcXk12MlZyaTn7B+gimm3BYSzyTSviY2B5a6WMFBYkQa4H+AJtua/KwSO?=
 =?us-ascii?Q?APzEakx9K9lgbfpwncCz+cuSnPD5wvNbEHyLtaS0S55cnq7rkl26so3JN8ui?=
 =?us-ascii?Q?DFsCEBp05LTvl1UZ8u8Fu7js1TB1/mVpHVpmOAvvKw+bkGbvaGKrsfOJCVyA?=
 =?us-ascii?Q?10LKm4xa3m8t0++w9MS8T1cuVvqF3JWShJLOMBdFXTq/Z97d63go0JS5j4EH?=
 =?us-ascii?Q?xJQHzqvFMdb59e3HLjPR/pxZ/Dbwmc/F/XW7YJlSZjMuPXsifAuqtOlkvB5B?=
 =?us-ascii?Q?vEM+83/supz372yKzXP4DhZSkR2dG2i7/ItO5KX3rUzj8PtivvOcgISu6OA7?=
 =?us-ascii?Q?KO2yNsFwfNZ98Si4p2AR5/jT7c4cWcJS1Dw2co4p6gCFg5zB8csOWSXVvPU0?=
 =?us-ascii?Q?GE1T2gh8bOAslQAgiOD+6L/bDwBXgH7/PMfdcbBQ3yIjkiALvxjnn60xYw0d?=
 =?us-ascii?Q?tkSbjsUQtExpOqVHUwvrU0BxOVU+Lqu6IwattIRRR6BXFYsI3v5qBuVix3KD?=
 =?us-ascii?Q?YO0hXT2kM8LRb9B3a2Aevk0q9A3Pv8IssAdb4ICe4tuhexSgmuL2VUqEzmto?=
 =?us-ascii?Q?6xqobFPyAd4JfmcILyhkCOb7a3TpmkYY4ZpI/0YYbxWpSAFA9Zs26PY9247+?=
 =?us-ascii?Q?GKtyd36PKEw2404mYAoUGQ0BVap2YUMKRQ6Qqo0kSr17xnS1eiMX8ajTATqN?=
 =?us-ascii?Q?RfBfG0EcG1jwaimoNvRb4G6AsDsd1wj0snVYGuoMV5A0jEEOd/GSn+SeMdif?=
 =?us-ascii?Q?bCh54vA18YtCQdv+/wCDoSd0+0jRlZ5KrDEhaGD/ol1PUTBmDepNFBX44Nu8?=
 =?us-ascii?Q?/rRiBu7PwC1w9rTkrtkEiiekGksh?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 05:16:44.7877 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d1da453-4018-47ab-8810-08dc68d4ba5d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8310
Received-SPF: softfail client-ip=2a01:111:f403:2409::600;
 envelope-from=avihaih@nvidia.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

Emit VFIO device migration state change QAPI event when a VFIO device
changes its migration state. This can be used by management applications
to get updates on the current state of the VFIO device for their own
purposes.

A new per VFIO device capability, "migration-events", is added so events
can be enabled only for the required devices. It is disabled by default.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 include/hw/vfio/vfio-common.h |  1 +
 hw/vfio/migration.c           | 44 +++++++++++++++++++++++++++++++++++
 hw/vfio/pci.c                 |  2 ++
 3 files changed, 47 insertions(+)

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
index 06ae40969b..6bbccf6545 100644
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
@@ -80,6 +81,46 @@ static const char *mig_state_to_str(enum vfio_device_mig_state state)
     }
 }
 
+static VFIODeviceMigState
+mig_state_to_qapi_state(enum vfio_device_mig_state state)
+{
+    switch (state) {
+    case VFIO_DEVICE_STATE_STOP:
+        return QAPI_VFIO_DEVICE_MIG_STATE_STOP;
+    case VFIO_DEVICE_STATE_RUNNING:
+        return QAPI_VFIO_DEVICE_MIG_STATE_RUNNING;
+    case VFIO_DEVICE_STATE_STOP_COPY:
+        return QAPI_VFIO_DEVICE_MIG_STATE_STOP_COPY;
+    case VFIO_DEVICE_STATE_RESUMING:
+        return QAPI_VFIO_DEVICE_MIG_STATE_RESUMING;
+    case VFIO_DEVICE_STATE_RUNNING_P2P:
+        return QAPI_VFIO_DEVICE_MIG_STATE_RUNNING_P2P;
+    case VFIO_DEVICE_STATE_PRE_COPY:
+        return QAPI_VFIO_DEVICE_MIG_STATE_PRE_COPY;
+    case VFIO_DEVICE_STATE_PRE_COPY_P2P:
+        return QAPI_VFIO_DEVICE_MIG_STATE_PRE_COPY_P2P;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void vfio_migration_send_state_change_event(VFIODevice *vbasedev)
+{
+    VFIOMigration *migration = vbasedev->migration;
+    const char *id;
+    Object *obj;
+
+    if (!vbasedev->migration_events) {
+        return;
+    }
+
+    obj = vbasedev->ops->vfio_get_object(vbasedev);
+    id = object_get_canonical_path_component(obj);
+
+    qapi_event_send_vfio_device_mig_state_changed(
+        id, mig_state_to_qapi_state(migration->device_state));
+}
+
 static int vfio_migration_set_state(VFIODevice *vbasedev,
                                     enum vfio_device_mig_state new_state,
                                     enum vfio_device_mig_state recover_state)
@@ -126,11 +167,13 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
         }
 
         migration->device_state = recover_state;
+        vfio_migration_send_state_change_event(vbasedev);
 
         return ret;
     }
 
     migration->device_state = new_state;
+    vfio_migration_send_state_change_event(vbasedev);
     if (mig_state->data_fd != -1) {
         if (migration->data_fd != -1) {
             /*
@@ -157,6 +200,7 @@ reset_device:
     }
 
     migration->device_state = VFIO_DEVICE_STATE_RUNNING;
+    vfio_migration_send_state_change_event(vbasedev);
 
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


