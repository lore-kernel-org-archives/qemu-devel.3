Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 905FAC25B74
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 09:17:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4zsE-0007kS-68; Thu, 09 May 2024 05:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s4zs4-0007jZ-OY
 for qemu-devel@nongnu.org; Thu, 09 May 2024 05:15:24 -0400
Received: from mail-mw2nam10on2084.outbound.protection.outlook.com
 ([40.107.94.84] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s4zs0-0005mZ-BT
 for qemu-devel@nongnu.org; Thu, 09 May 2024 05:15:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9olfczyYCOP95g2hlYy/8wVwwgepR9t7C19Ymrik/9O6tmY+M3lcQf48n8MFBtbAcF7dLq8RWc7GBYhsbWW48lhMjOb96oo83C2s26GFhZknjZiTE/X2+RtX6deKTPj0L9iz1+zeA2LbCCesKxPB4T/AwMOEg6VNvcHnE/0wyrO351nz5r9xf4SJYFOuLsby9l4LKU0dVKetYJ4nAgi9aByKaZoajeX6JS04/wntFo5wA0K2gaZJ3Sib2sg/lPEeBMRnhL9+tv6MKXIHZuqH4Rh+3BvQnXYzvTnii7lYccLfhTLN6PJHnNn0WWaKIZC2Bxn1NHgcTsSo0skFZ6rTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0yPHHloLUKIK3bsg7eDBRSATaUMxTXGbX6fYXMt5fE=;
 b=QMRmnjbe9EP9Xz1VaUsC7+SPGZpH4er6g4NQk8aptSIgU97l9hrvPWV58hCtNpzTwiC3BYBxpFGm4FcDm/f89p40MzWxMCVHWDRhrwJBDz4Liwe0RYV2b8GRNCeBvpcvW3/YluhYsLWairGVvxLjcwvpZtEtvbDapwdftaikByqDAs3LlEoFhrC2LgaRQk2S9euAcFygsZh21pQ/87aepzNg95y2Bub/rKgBeNIVF8dlNNhOYC60Prsbw6iBCT3CWdbBtDyGgwmCxQkRbx7mRpfxZfsBooDq40WWfEMfs20de8/fri5aF5xXGqix7i/Oz4Guk9fgnbjeh+nPUmsIsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0yPHHloLUKIK3bsg7eDBRSATaUMxTXGbX6fYXMt5fE=;
 b=TlGiLYVPqWsE/ki5cgHJMm//2KIFY9FYBuodxZE5OfH7DwKIUEyr2gaotzLfCaIoy+oRchEqniBB8+vYClv2A6DO90/+8vlDVc6ZpnIm1UlJ50TArxhqRsr2e4gm68xxfF6qqpLjYdOkMNTQ9tyndEp4oRft59+779oGDhWMuGrCBkjAirTOLWw/LCje5CpPUnp41gM/DMJ0t7ezULIsKzqq4BeWQDvB+MDyFn73vOkXKEkAriUVZ49yiLYMe6vYUwGX14yVnK9gLrLZLqHgMJ9wCGEbY1eY7y0UAD3dIgEs1de5sOBvjGTVudLJzTEqY2U6fEDWJawt4plwpSTAtg==
Received: from MN2PR20CA0037.namprd20.prod.outlook.com (2603:10b6:208:235::6)
 by MW4PR12MB7237.namprd12.prod.outlook.com (2603:10b6:303:22a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Thu, 9 May
 2024 09:10:14 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:235:cafe::e9) by MN2PR20CA0037.outlook.office365.com
 (2603:10b6:208:235::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45 via Frontend
 Transport; Thu, 9 May 2024 09:10:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 09:10:13 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 May 2024
 02:10:02 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 May 2024
 02:10:01 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 9 May
 2024 02:09:58 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>, Eric Blake
 <eblake@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH v2 1/3] qapi/vfio: Add VFIO migration QAPI event
Date: Thu, 9 May 2024 12:09:52 +0300
Message-ID: <20240509090954.16447-2-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20240509090954.16447-1-avihaih@nvidia.com>
References: <20240509090954.16447-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|MW4PR12MB7237:EE_
X-MS-Office365-Filtering-Correlation-Id: 13609ea6-9b89-4bcc-154d-08dc7007d606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5Gc2poBx2x7CuwVVgONTk+VS+ySqSl5RwBFUcn/AQ2lytN46dAK+qDLwtqyD?=
 =?us-ascii?Q?BVAudAL2EIqL8KQ+KmF3HlfaPIPyfYokw1E6om+4294knijMYB6YEzQjGmE2?=
 =?us-ascii?Q?2Z3aWD0BomvqC6QTyLbbdzzsqnIc0/SptFVQu7C5ep+zfvBChE4kPqgB2k/C?=
 =?us-ascii?Q?6ShvjAK2T777kB20PXttEClexZZkpx8b3Kuo6Lz47wbuoAWCNqfKOwKmxfP1?=
 =?us-ascii?Q?g+oW0pnUunWLjD0cuXv+o4Mzhu8cRkzwk3nj1vtMbyVNiGdwCYwdGFtlJ36x?=
 =?us-ascii?Q?aRfPa6Owl9kw2F9K/QiUnQEL4Qk1KWk08aSDkNdsNxh9EdgN830ZxbSCLdpd?=
 =?us-ascii?Q?QFYw9C5DWdztfENe030livhqnkmWK9WYAHWuSqw9WBJmQsPVhudepQwRt6pa?=
 =?us-ascii?Q?EPr5PuPn0TsTYAk7uMTUosD+sLL5h+nEVbUXdxt3j4gqFV9Axin9l0Uq/6TM?=
 =?us-ascii?Q?I7q1tfF2oHy6idldc1hKSHCmNvUevv+IEN4nq6SxadaDYDYN+l/GIOTkc27y?=
 =?us-ascii?Q?8/WAlTf+189gb9HuckINPHDVHsJUa8cpkRvMFuO8RPzo0tHZD9+rDkycMZS5?=
 =?us-ascii?Q?wR2btsogm7sGA7kvfm5hT/frlFw8I90104TOlVFUM3GnA++l24r7kXeCKs19?=
 =?us-ascii?Q?MSYIrDf+6z+ttNvayTgrYOJHJ+uvbd1CWJEPu06AftTGmEqF/a0n3wqozgRe?=
 =?us-ascii?Q?vQh35mr31mR2s57CxzjyMrv+Nmymne0MG8C8KFR5cxdeIRK+xqKLQqt4ij+9?=
 =?us-ascii?Q?PR0eTyzy7zdddydhPlqd3xMRZDawCVcJapnM7r7B5T4LTHIz9RvTpHooPJ95?=
 =?us-ascii?Q?bVb4LpzmPqQzwhASdLnB1d52bXLK54NkMIbWvK80ubbLp58bAwQ8BHh4zULg?=
 =?us-ascii?Q?M9/oCDlpCkU1kN7VbXKejPI2Swfs2qUP4R1nlOr7c8IwUNSeBtQxJ5kicMna?=
 =?us-ascii?Q?mHrgSjwarBMy7k7jwBBtPJwOF0QH7FfVdtg6wjrcvsBhcXKd+yh8HIyE8S/j?=
 =?us-ascii?Q?pzN5JzKNOwjm05fpjDAXatP6aOj+nNGs+HpylaFm4I9ZqHo+sdAXJEk5uFmO?=
 =?us-ascii?Q?iAiBRnB89gH/xltBa486sW+7jZNuMWD/i+rPjTz1pKG0he34E0dIyLkAb5R/?=
 =?us-ascii?Q?iLnAHUG1U3JPMRpG1ojwtSL57HpVZ130slxs9WLsI2HpNIZe1uV+LHvtWMKw?=
 =?us-ascii?Q?c5hLQWE+MpCSDYVrBefQttB67bs/po5ay94l9xoDGuAmf/MCDww8ZkTpcpmS?=
 =?us-ascii?Q?HJBA6yDP9w6vHzVvlZBK2Dl4wERScKAxQMZ6Z42ntLu5jFKYxAP31UB0+JZQ?=
 =?us-ascii?Q?fkz0406xSoMR+ZKBflBEr7aeh1WQ/2/aLP2WhXksP210FDaA/99eVOYYZs+M?=
 =?us-ascii?Q?Yh415iOYe6ZKyJwRvnNAWlEqanNJ?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 09:10:13.5541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13609ea6-9b89-4bcc-154d-08dc7007d606
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7237
Received-SPF: softfail client-ip=40.107.94.84; envelope-from=avihaih@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.582,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a new QAPI event for VFIO migration. This event will be emitted when
a VFIO device changes its migration state, for example, during migration
or when stopping/starting the guest.

This event can be used by management applications to get updates on the
current state of the VFIO device for their own purposes.

Note that this new event is introduced since VFIO devices have a unique
set of migration states which cannot be described as accurately by other
existing events such as run state or migration status.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 MAINTAINERS           |  1 +
 qapi/qapi-schema.json |  1 +
 qapi/vfio.json        | 67 +++++++++++++++++++++++++++++++++++++++++++
 qapi/meson.build      |  1 +
 4 files changed, 70 insertions(+)
 create mode 100644 qapi/vfio.json

diff --git a/MAINTAINERS b/MAINTAINERS
index 84391777db..b5f1de459e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2160,6 +2160,7 @@ F: hw/vfio/*
 F: include/hw/vfio/
 F: docs/igd-assign.txt
 F: docs/devel/migration/vfio.rst
+F: qapi/vfio.json
 
 vfio-ccw
 M: Eric Farman <farman@linux.ibm.com>
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 5e33da7228..b1581988e4 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -78,5 +78,6 @@
 { 'include': 'pci.json' }
 { 'include': 'stats.json' }
 { 'include': 'virtio.json' }
+{ 'include': 'vfio.json' }
 { 'include': 'cryptodev.json' }
 { 'include': 'cxl.json' }
diff --git a/qapi/vfio.json b/qapi/vfio.json
new file mode 100644
index 0000000000..a0e5013188
--- /dev/null
+++ b/qapi/vfio.json
@@ -0,0 +1,67 @@
+# -*- Mode: Python -*-
+# vim: filetype=python
+#
+
+##
+# = VFIO devices
+##
+
+##
+# @VfioMigrationState:
+#
+# An enumeration of the VFIO device migration states.
+#
+# @stop: The device is stopped.
+#
+# @running: The device is running.
+#
+# @stop-copy: The device is stopped and its internal state is available
+#     for reading.
+#
+# @resuming: The device is stopped and its internal state is available
+#     for writing.
+#
+# @running-p2p: The device is running in the P2P quiescent state.
+#
+# @pre-copy: The device is running, tracking its internal state and its
+#     internal state is available for reading.
+#
+# @pre-copy-p2p: The device is running in the P2P quiescent state,
+#     tracking its internal state and its internal state is available
+#     for reading.
+#
+# Since: 9.1
+##
+{ 'enum': 'VfioMigrationState',
+  'data': [ 'stop', 'running', 'stop-copy', 'resuming', 'running-p2p',
+            'pre-copy', 'pre-copy-p2p' ],
+  'prefix': 'QAPI_VFIO_MIGRATION_STATE' }
+
+##
+# @VFIO_MIGRATION:
+#
+# This event is emitted when a VFIO device migration state is changed.
+#
+# @device-id: The device's id, if it has one.
+#
+# @qom-path: The device's QOM path.
+#
+# @device-state: The new changed device migration state.
+#
+# Since: 9.1
+#
+# Example:
+#
+#     <- { "timestamp": { "seconds": 1713771323, "microseconds": 212268 },
+#          "event": "VFIO_MIGRATION",
+#          "data": {
+#              "device-id": "vfio_dev1",
+#              "qom-path": "/machine/peripheral/vfio_dev1",
+#              "device-state": "stop" } }
+##
+{ 'event': 'VFIO_MIGRATION',
+  'data': {
+      'device-id': 'str',
+      'qom-path': 'str',
+      'device-state': 'VfioMigrationState'
+  } }
diff --git a/qapi/meson.build b/qapi/meson.build
index c92af6e063..e7bc54e5d0 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -52,6 +52,7 @@ qapi_all_modules = [
   'stats',
   'trace',
   'transaction',
+  'vfio',
   'virtio',
   'yank',
 ]
-- 
2.26.3


