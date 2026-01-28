Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B98D25926
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 10:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl3Em-0001Zv-FJ; Wed, 28 Jan 2026 05:57:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1vl3Ei-0001ZC-Ks
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 05:57:24 -0500
Received: from mail-southcentralusazon11012024.outbound.protection.outlook.com
 ([40.93.195.24] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1vl3Eg-0001u7-VG
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 05:57:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L7gnETw+6CqIRC8JRo5RfhbyXLUcLNsM/ZEGaWoMQNPBM25WMaXO+is3m/lcFggWJ0HZ5h+oIzTfuWPKhH2xskvVrh5o6zbAQ6Bd9EBCAzk9fF3aeaIBCRBga+BlNMl+Sz5lThplqkMSxVl3/U6fH6H1O3kfw7kqOIoeXPWRQUqyBoS+IbgUFlOT8SATB46BbmPZ6sbmNTAMOfShGTtZj4qur6dp910oBwdnRXKAdwDg0/DV6GniAoh2WrRjg0Ke/0NBFGwTiMJ/sBLv3JhzHUGspHfLlCLlo5vKWeiShSkqczvEUlQhfFAnobLo4dUeJxPGSXGsDxcjgYk9KU/SUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxidKzi6cF+fJ8+alpOfs1CXliJlcZqjpLk5SyFRqNc=;
 b=zS7a88sna91tbbTLatdbjHch7SIab9Ur7UKjKEPVfwXR3wTY2DHolrAkBCnjv+abOwMlFuQdZhx8qtctWKu3wKw77XSBXQkiUlN8nbomW9zDJIPdlhwRmWZHkw+I1uEI+MpIsSpPj/6lL98Ma5+aHQ4YT6wIacqe8JAmpTfRBTVMgEEbpRUh4hf3uf5lkVnDTiYQxzdSQf7Yat+d3VKsxOdFc3IpPuKDVZj2XNt/TvbSMqoNdOwnytBQVPAFWtsd9p8uaff7BlIMKLuEIHrH3Pk+/fA48BUbuYUvQHyo/jsm/SYuANHY9U21YlLpwliXVNeoqNa7OI48HV8a1J9MXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxidKzi6cF+fJ8+alpOfs1CXliJlcZqjpLk5SyFRqNc=;
 b=bpIaroldRACf0cenYs4JjgoZ/ui6hxEtdsi6iZ0rtN7o6fL5ZznLcd39Ux0n4yMQ/eGDWUrciqzwnI8oPv3zXDXV8fKmTf/1K5ZlkQ2wOu2MK8wydxDRlsgw5dTGUEmf7wIWtTa19tbPS0oobXXaTANI6i69VPhHA/HfiKJaSEaLM3T4IyYvHi8BPDiJWGow0fbuYOxChy22Quhhk/fLBr5kHfw+XplABSzjL/iAaAhW4Oe73PikrRie537U05/e+g/rs8faVa3SHwUF9sMl7fxmAUAdC/VEWtaGim3SBU1ecUmwBk5vrWOZbFY67q9J88t/ane8wrcdOZHpauzX/g==
Received: from BY1P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::6)
 by SN7PR12MB6744.namprd12.prod.outlook.com (2603:10b6:806:26c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 10:52:15 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::26) by BY1P220CA0002.outlook.office365.com
 (2603:10b6:a03:59d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Wed,
 28 Jan 2026 10:52:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 10:52:14 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 02:52:02 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 28 Jan 2026 02:52:02 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport;
 Wed, 28 Jan 2026 02:52:00 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex@shazbot.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH] vfio/migration: Send migration event before device state
 transition
Date: Wed, 28 Jan 2026 12:51:59 +0200
Message-ID: <20260128105159.10282-1-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|SN7PR12MB6744:EE_
X-MS-Office365-Filtering-Correlation-Id: 472ebaf5-0f97-42cc-7321-08de5e5b4c43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?69AWZ2HJ01bRDs0Ofj2+jw25HDUUzhRFqg6rMNVFlSL4S010hzCg3M70DHVL?=
 =?us-ascii?Q?3qIbHF3m4gf7o//RnWDAdbZYLVfbf4Yi7hjPiFfkUJhtiZ9dw1ujjwWxxgla?=
 =?us-ascii?Q?17MwTwuQGPDJWK7uveWkS+Dty5k6ZUHs9xREIRGJBZF2she4KCCG2lQeWLyp?=
 =?us-ascii?Q?PFlPz8Oahz7vcSmmEQnsDMrWv0wWesmvqeBwTalgfkpLvsnVZ1KDz7ZktRoX?=
 =?us-ascii?Q?/ewMagahSPEhjvy+XUSiSrWVi57WL9n6qjOlR36dKNPdcDonasmXzkfkHmZJ?=
 =?us-ascii?Q?xpDWdqbyI+rDITwJZG7pnthTwXPFg6TZC+mAGAElWTwICqhJgoQbbtsOTwZd?=
 =?us-ascii?Q?eJeWgacGU33FSaDrBXZAgITXRdBWAalvyWXakbygAw3YiRf1gzh9t6yQVKJU?=
 =?us-ascii?Q?bzIDPjrC0yumn4HNSqEsS+TNA7I0FpSqeNgy5St4qUe6YMpR6SDng5tRzWRB?=
 =?us-ascii?Q?9agB3V4es+iAjhUvg+3YlXPCl+YV/fBgTPXkXMdM91iI2xb/g0iX9qexpQXi?=
 =?us-ascii?Q?e5vXcQKRQNl7YNnZ6kx076bUxU6XqTZ+GkV33RSDe8YfzEoWTNZnx8U49vwj?=
 =?us-ascii?Q?+fqNkNa5MJsu0jiPGZ4Ygzs7oNkKJbZ6l1Okn1Pr7inFIPGpCDPYDWl3DGJ+?=
 =?us-ascii?Q?EjWYgO0kxW68RRn0S2LlAM0+5DIaIAsEK+boD2p7rCE6uREqa/dGClzPnXn+?=
 =?us-ascii?Q?tNZomZEWa42YJKW/u6ogbr08h9s08ThhxJXYX6K5hfOOxD1Q69SR4CYJim1P?=
 =?us-ascii?Q?/ZzR/Wm500KnEMMyMWtbbR3eQxLI2aNUSOxtegd5Zp45is2CZ+C3ZhHuM9BV?=
 =?us-ascii?Q?F8yXhBJfW/CCLGjjniwx2NqOdkS/T7P0M1XlBjEEbRR5K80rSkH5JoJHOFl1?=
 =?us-ascii?Q?3mcSl2vYsN2YiP148GjDw9GtKC2caP0BlPRcX21v/1rrHBSQx5garIqEeN1I?=
 =?us-ascii?Q?8niooCm4PJAbWx9uzrsoLkX0zQWNXuLeTy4YkJcI+5ViretsOmMcOizSQqlK?=
 =?us-ascii?Q?lKtuEy9kpwktNjq8x77cPxxQJvGzCeUKkGir9AS96YolikrRt8o+ei5V61W2?=
 =?us-ascii?Q?qqQmQPNdxIux6KxBrD/37imLtbyaVRdacq7ShfTNOLHq6XyblA/QiAtsoKUf?=
 =?us-ascii?Q?Alr0No8itdx6GoQ+p/onjXxA6PDt87KcrE/oRspJAHOXBXlZmcrF+scxuESn?=
 =?us-ascii?Q?PsM+LDpuOvgRUQcLzrrVN2dvV1xi/Yfr5Olx6G/abAhdGFWTjaYwk2LUluUf?=
 =?us-ascii?Q?BWCmQK0HjeB3UcV36QjICHZKdPQCskspxHyvsHb5xL86fwRm49nJZkGVIU/F?=
 =?us-ascii?Q?yWXMlG5VWWqekEAt1UU0rRL0GijaTcmVMQBrzY0SfAnOXDIQhy3NSGZgrh//?=
 =?us-ascii?Q?R8a+cRasbivl3dQKPiJTnrVNaHwRFeWCMgJP4B4L/6ATipJHza9LMqYp5Owp?=
 =?us-ascii?Q?9bmdf7P+fA8Ts330kHf27qSpRE6vlPmUqoxOmdmM333Y5mtqC7pD/iNX68Xi?=
 =?us-ascii?Q?ujD6P5Wg+aAYbyWwnUc1Dg3lCeFi+qulfg539zVz2XIzp/iJe6FaZCmG1Uec?=
 =?us-ascii?Q?kDfEE+fNeqV6WAgz/3OtGUpQ/410IQMqKcFrRvLuEFcmYbKMQg1bf77J1GLV?=
 =?us-ascii?Q?84GZCranbEoA18N3cJaYA1xoLvnOs2g7xEbiWP/ec90+mzYdMXDU1NQgYBiQ?=
 =?us-ascii?Q?qeFP3A=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 10:52:14.6180 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 472ebaf5-0f97-42cc-7321-08de5e5b4c43
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6744
Received-SPF: permerror client-ip=40.93.195.24;
 envelope-from=avihaih@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Currently, VFIO device migration event is sent after the device state
transition has been completed. However, it may be useful to additionally
send a "prepare" event before the state transition, to notify users that
it's about to happen.

For example, in some cases with heavy resource utilization, stopping the
VFIO device may take a long time. In time-sensitive scenarios, the
management application that consumes the event may be notified about the
state transition too late.

To overcome this issue, send an additional "prepare" migration event
before the device state transition.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 qapi/vfio.json      | 33 +++++++++++++++++++++++++++++++++
 hw/vfio/migration.c | 18 +++++++++++++-----
 2 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/qapi/vfio.json b/qapi/vfio.json
index a1a9c5b673..de41211f1d 100644
--- a/qapi/vfio.json
+++ b/qapi/vfio.json
@@ -66,3 +66,36 @@
       'qom-path': 'str',
       'device-state': 'QapiVfioMigrationState'
   } }
+
+##
+# @VFIO_MIGRATION_PREPARE:
+#
+# This event is emitted when a VFIO device migration state is about to
+# be changed.  Note that even if this event is received for state X,
+# the VFIO device may transition to a different state if the original
+# state transition to X failed.
+#
+# @device-id: The device's id, if it has one.
+#
+# @qom-path: The device's QOM path.
+#
+# @device-state: The new device migration state that is about to be
+#     changed.
+#
+# Since: 11.0
+#
+# .. qmp-example::
+#
+#     <- { "timestamp": { "seconds": 1713771323, "microseconds": 212268 },
+#          "event": "VFIO_MIGRATION_PREPARE",
+#          "data": {
+#              "device-id": "vfio_dev1",
+#              "qom-path": "/machine/peripheral/vfio_dev1",
+#              "device-state": "stop" } }
+##
+{ 'event': 'VFIO_MIGRATION_PREPARE',
+  'data': {
+      'device-id': 'str',
+      'qom-path': 'str',
+      'device-state': 'QapiVfioMigrationState'
+  } }
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index b4695030c7..9f887c148f 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -90,9 +90,11 @@ mig_state_to_qapi_state(enum vfio_device_mig_state state)
     }
 }
 
-static void vfio_migration_send_event(VFIODevice *vbasedev)
+static void vfio_migration_send_event(VFIODevice *vbasedev,
+                                      enum vfio_device_mig_state state,
+                                      bool prep)
 {
-    VFIOMigration *migration = vbasedev->migration;
+    QapiVfioMigrationState qapi_state;
     DeviceState *dev = vbasedev->dev;
     g_autofree char *qom_path = NULL;
     Object *obj;
@@ -105,9 +107,13 @@ static void vfio_migration_send_event(VFIODevice *vbasedev)
     obj = vbasedev->ops->vfio_get_object(vbasedev);
     g_assert(obj);
     qom_path = object_get_canonical_path(obj);
+    qapi_state = mig_state_to_qapi_state(state);
 
-    qapi_event_send_vfio_migration(
-        dev->id, qom_path, mig_state_to_qapi_state(migration->device_state));
+    if (prep) {
+        qapi_event_send_vfio_migration_prepare(dev->id, qom_path, qapi_state);
+    } else {
+        qapi_event_send_vfio_migration(dev->id, qom_path, qapi_state);
+    }
 }
 
 static void vfio_migration_set_device_state(VFIODevice *vbasedev,
@@ -119,7 +125,7 @@ static void vfio_migration_set_device_state(VFIODevice *vbasedev,
                                           mig_state_to_str(state));
 
     migration->device_state = state;
-    vfio_migration_send_event(vbasedev);
+    vfio_migration_send_event(vbasedev, state, false);
 }
 
 int vfio_migration_set_state(VFIODevice *vbasedev,
@@ -146,6 +152,8 @@ int vfio_migration_set_state(VFIODevice *vbasedev,
         return 0;
     }
 
+    vfio_migration_send_event(vbasedev, new_state, true);
+
     feature->argsz = sizeof(buf);
     feature->flags =
         VFIO_DEVICE_FEATURE_SET | VFIO_DEVICE_FEATURE_MIG_DEVICE_STATE;
-- 
2.40.1


