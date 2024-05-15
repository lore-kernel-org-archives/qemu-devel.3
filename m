Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78661C25B79
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 13:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7EaS-0001KT-4w; Wed, 15 May 2024 09:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s7EaP-0001KA-2B
 for qemu-devel@nongnu.org; Wed, 15 May 2024 09:22:26 -0400
Received: from mail-bn8nam12on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2418::600]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s7EaJ-0007Gf-HB
 for qemu-devel@nongnu.org; Wed, 15 May 2024 09:22:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgvBCfs3Re7EbQ6ie+YlXs1oje4xofncRYNGfGSRv30cKzflEpeCiRzRYOXRrEI07RV9k2Nlsft8lO28Ra9FiPMZaybnlsadFVNzUWHEsiVXdPYTOvg6x9MGFg+bo5uAPkgsM5glNB0kv8vLxF5d379/ojL49RhlRkI/sHPJxA784/3Bs8pScsJHDTRlhQev4rLZlwtx+aUB8dzU1uE/MxmDEwpcRBAEspzZkU0Dx78XedrHEd3BqC7Q77MuUHvgJ0EbQWDDiEbpvWMrAwK5FKJi+O8HHCnyvnHO/F5Wm/Yn/zqWi2LL1sYDDjlVBNFHdTUZkmWMmgUShiuUIKtOmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmWO0AxSzPSaSe9bmaQhyDXGyhc+LqakSOpDXCeOnD8=;
 b=NpMPH3CttKPpE4zlsiQKLGRL5pLr8pXTq9dS8rxGW/Jwz9DVP7fuh+yXb+43lWF4ufICFGK/iSoRMESTGSmwnn6AWx+AZC5U5dlaL6Df/LumTfdM7YGK0bDcDysR0c0yzof2u2TgtrsoNEQ6ppXD/TxAmQtmWsG5v6Smw/fjxRYskQiIe0oGKXNqwERWpBIzBQLGlQLns/QoI2NfxVOgpH57TCR4PhSLM2rK1kxqvxh1p3+LYFY5/mRdFvDEmL0I+IIzk8hB3TAwEweAyWADq/E9Dxg2/Y0q++EJOTXHoqS8HM8bRnYvaoqdhVuunRNdMG7NEEcEtZuvKevagAGvXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmWO0AxSzPSaSe9bmaQhyDXGyhc+LqakSOpDXCeOnD8=;
 b=l17m4B6VnNs83rse4fwXp+ExAWt0SFNooZ6vbRcPSndMWIYmiGnOry55i35tSgQheqSDP2EmtN2i2WwzLIww0oUcRhiulxQLL2BJ349V/Svnm2PWjKyiSYZvrOCv04C3dSncO9cWgeyHAaTJ+IySn2ejy4f7c9hb3l+6j8YYYIG4h2M27pF9Ze3J7/cGfBRaIGvD8riG1++7UInEJ/UoQ6CzKDkBAPVA/9LcB1IhvceOQRiT1Ewf00TXv7YN1ZJDbcSsXyqNHyUZAPz4sgo59WSTtDc13XqWbLXXRQ77MO5X/0d7jydSZkbKvPqVzWDr2Bzd0GqrlhmokInW8PhwNw==
Received: from BL0PR02CA0074.namprd02.prod.outlook.com (2603:10b6:208:51::15)
 by SN7PR12MB7787.namprd12.prod.outlook.com (2603:10b6:806:347::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 13:22:14 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:51:cafe::95) by BL0PR02CA0074.outlook.office365.com
 (2603:10b6:208:51::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Wed, 15 May 2024 13:22:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Wed, 15 May 2024 13:22:14 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 15 May
 2024 06:21:45 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 15 May 2024 06:21:44 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport;
 Wed, 15 May 2024 06:21:42 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>, Eric Blake
 <eblake@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH v3 1/4] qapi/vfio: Add VFIO migration QAPI event
Date: Wed, 15 May 2024 16:21:35 +0300
Message-ID: <20240515132138.4560-2-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20240515132138.4560-1-avihaih@nvidia.com>
References: <20240515132138.4560-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|SN7PR12MB7787:EE_
X-MS-Office365-Filtering-Correlation-Id: 47a930e1-ec12-4ce1-e717-08dc74e2090e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZjREczI0cUlyWEloLzFRd2w2MFRrSmxuZkxzS0FJeTh2d3NUNG9tQUFUSzQz?=
 =?utf-8?B?UjRkMUl6VkwwVTJYRDdWQlNTbUZDV1hGZi9QVHdXcG95NUxHbjAwcFFrWDJq?=
 =?utf-8?B?ZWRwTVN1Tktnb1QwdTR3NitySkFLWGNiMmJXL1BkRzJKVi8zMmh1STd5S083?=
 =?utf-8?B?ek5UMFRLeXJWZG4xc3phdTYyNk14OVBDWWJEKzNYSHZNeFZta25GRENIZ1hn?=
 =?utf-8?B?RW5Jc1p0d0NRYThZekxUVzNKRWxCK1BaWVB6M2t6Qy9RTkNYV2NZQVVBVjg5?=
 =?utf-8?B?VGc5KzNjbldEcVZvbkJUbTdYdXlXRzd4b2xnRHJBc3g1NFRlZFJXQTBOei9G?=
 =?utf-8?B?Wi9rTEYwSkR6UHpCc0QvU05rdEtHZVFzakNCZTNOMWJnSTR4VjZQSXZ1a2hh?=
 =?utf-8?B?dytraklZOWNxLzExTTlFRnBZWVhickNYblk2Y2hCWmI3SEY1Wkpic28wOVln?=
 =?utf-8?B?ZzBHZUZSUjU5ZVE1cU1KdE5jWXU3Wm9xeFYwRzI2R1RTSlovZjJNZTJ6MzRQ?=
 =?utf-8?B?ZFFIcE5UclI3RkVMdjM3UWNrZnJtTzliUlJVREJ0TU1mVXJmSU0zZWJpaGhm?=
 =?utf-8?B?RFdha1hPWFJsUEFRMEt4MHBkbnBsZDV0NHRidW9rVzFVT1hmSGxMb3hxeXUw?=
 =?utf-8?B?Ylg0aHVxeTQxQzZoYXYzeTNQYmFKTCtpU2VySEtRTWRHMnF6dUNqK2NDYU95?=
 =?utf-8?B?QWk4alNHVFhER2V0Mm9SSkRPVDFQMVdnQURrTURNZ3h5SGUvbUJ1TXhyb0Nj?=
 =?utf-8?B?UUN2SHVWaW0ySzlTSkVPVHBHZHpnTjdCVG84aXIyaFY0aVNBSlRaOHdib2xy?=
 =?utf-8?B?SnhsWnZiSWgwaWZtY0taNENqWVNWOXdoK1pTdUN3TkczS0V6c0QvTGI1OGpl?=
 =?utf-8?B?UHBWVHhmSmtiQmVCVENBTU9pMWFYK1UzNVZqaHF2N0lVRHdSRzJZRzZTQnM2?=
 =?utf-8?B?NFM2LzZVSzdxc1JxWldZVlp6Nlh6QXRENENMODRualRhSWdIODB1VTBwMTAw?=
 =?utf-8?B?VlZJSTZnR3pOTmpOKzFaNkFiMm9hb2xsVG1XYmt3c24zQVJ0T2NYN3cwUVVi?=
 =?utf-8?B?RzVadlFnTTEvSThHbWtCQmQ2ZElRZC9ybTFYRWZVS0RzTkZ3dTlXVHhuQ0F6?=
 =?utf-8?B?bVhzWFordTVwakFtUmdsU2hQRWpqMnRlNG83ZGtHNU9RcFArd3M0UWpjRHBK?=
 =?utf-8?B?OEdtbEhHd09RKzVjbnpnelJxeTZrYWI3cGJObitBYUNZK1JxbGtmQWhzN3E0?=
 =?utf-8?B?UjFQL1FqdXpGQUQ0bHFiWFhURFNoM0JhYzQ3VzdBYUt3T09wZjRQYmQremFW?=
 =?utf-8?B?M0ZKb3RHaGZtM2piRFBRMkpTTFRVaWtEMTBEbERBdzk1dlp6N2FVUXRGdDdZ?=
 =?utf-8?B?V0tOMFkwRnJCNWR6WURGTVpxR3kyUFJkalhXbzkyR0JBUDFhQ1YxcWJ4eVlH?=
 =?utf-8?B?ZDNNckhtWTdxQlZZMXVoK1Z1QklGamRvT04yb2dGVkdSRUZCeEdqUG1sOVNV?=
 =?utf-8?B?d2lNempxU2hPUis1T1pveUgrRDVIdW5aR2lGMC8rbUJVa2ZDVGlUbzZjM2pO?=
 =?utf-8?B?dDZEaEplVjI2Z21IelBkQ3JkMWJmSE5YcXh6MlExSm5WWGF4dU56WS9mNGhJ?=
 =?utf-8?B?bHU3OTR4TGYrTjFQbHNZZzNKSUgzQUZXL240K3Q1MVkwZXlBekRjR2JqdHFt?=
 =?utf-8?B?eFJMTUVCa3ZBaENkRVU2anR1ejUwemdRK3FPNmFJQzZCVHRVM2F3RHVhWEM4?=
 =?utf-8?B?OHQzb25MeVozSWhWbEhpRU5wa2pka0dtY3MxNFliZ3NieTEzTktsbUpSWVB0?=
 =?utf-8?B?aVZ4dXd6WWNOYkgwSFpZWDBkSERFS0hkUnkvcmowayt4VDdnTCtFVElJdllY?=
 =?utf-8?Q?IXoLBh4wPf1bW?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 13:22:14.1295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a930e1-ec12-4ce1-e717-08dc74e2090e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7787
Received-SPF: softfail client-ip=2a01:111:f403:2418::600;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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

Add a new QAPI event for VFIO migration. This event will be emitted when
a VFIO device changes its migration state, for example, during migration
or when stopping/starting the guest.

This event can be used by management applications to get updates on the
current state of the VFIO device for their own purposes.

Note that this new event is introduced since VFIO devices have a unique
set of migration states which cannot be described as accurately by other
existing events such as run state or migration status.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 MAINTAINERS           |  1 +
 qapi/qapi-schema.json |  1 +
 qapi/vfio.json        | 67 +++++++++++++++++++++++++++++++++++++++++++
 qapi/meson.build      |  1 +
 4 files changed, 70 insertions(+)
 create mode 100644 qapi/vfio.json

diff --git a/MAINTAINERS b/MAINTAINERS
index 1b79767d61..448dc951c5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2164,6 +2164,7 @@ F: hw/vfio/*
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


