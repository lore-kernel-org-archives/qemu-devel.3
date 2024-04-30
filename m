Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8966C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 05:17:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1frO-0000jH-2C; Tue, 30 Apr 2024 01:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s1frJ-0000iv-Nt
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 01:16:53 -0400
Received: from mail-bn7nam10on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2009::601]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s1frG-0006Zo-Cz
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 01:16:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkEOumpr85qT6dMuTO4PsYiRbNKDrh8U0lyETBhHSpCekpIQMCWlvwqF0x/CD1HR3FxIeMeDAeyFM9p4Wlk/jfWkXSDCFLJAREyoue+5UlUJwtgS8tSoZLCKPVlusE3ECUtg0KR/JFC3PdWpVEiwgA99+d4dgHSccPzBPOmHnJZiqHOiiLCU/BGwy9QNlCHMRNDW9hIl8thalnq6wp3+u6oF6hbQKdMx/XUFdpzofbeS/pfBuwtoYFfswo6Th6a7YmMe5qw0QoMpFShXIvG8XWnF5gqgeebWTwMin7LVhTxwkjGeAzYesi0QqO+5fHyRRmB/czTMs2SMvqNor/h6HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSglfxLsM4KMhQ6WV6via/0uDKuW4tyx8UYxK35Oux4=;
 b=mD80QyditjtIAIHB1bxVV3fMS5eWEhpmSEkLs+lBNO9T4CrEtfdA4JcmcL+yxh8RwJxbJDN2aepeD6k6iN0+i5UxHQewh+K5vxMER+lPrvPsjq9JV073Y2pCeesAurY5NM80GVVmIOmawh92fTYuEex2+6grCtK0CMMtWUd0T5A5bvAJHmu1iNfITjoUEWI7iMBmEvBNv3Pny4SKiXHG2lOTMXOlqxGmBxK7ALIdHCqUpdIkMdVvVnc0+EKwr3QQ9ZXToHjfjkISQW3uowAWI9IrOxohoeIRsAqcMiobeu6FuP4kFowJQ7CVIfWynCTs4AGFNwGsDV8qsDcf4b+N7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSglfxLsM4KMhQ6WV6via/0uDKuW4tyx8UYxK35Oux4=;
 b=Wbe7UvjAYWsmMeklOrGCUNhIDNaBn3bSn4rE+lyUJR5a+T80i2Y9BcFZtEbnHCJ9SDcJb6FqbF49+0G96BgyUZ/AzV6L6Qx1WHN22/AiGIOBSJ7e+N0L7r1dbso4mycqqbI9jlbnrCb8iXVMCqlo73F3gFbZcSIsOIwCkL34A2XBkJ+RbNmQDjhLgIjLNj2/Glohc0YyPvTjr3qdoxgafS1lVNfMt4hIpObe7G2UKC5VpSIhcZiNlz10GVyJZwFDCWQ7FplhcWLdW8FLKx522tCOSnX8Ggz4byWZZ50/KfyVEHleXOgey+sQlktTVx8deXB3sDIYiVmAugTs8udHVA==
Received: from BN9PR03CA0194.namprd03.prod.outlook.com (2603:10b6:408:f9::19)
 by PH7PR12MB9068.namprd12.prod.outlook.com (2603:10b6:510:1f4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 05:16:45 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:f9:cafe::64) by BN9PR03CA0194.outlook.office365.com
 (2603:10b6:408:f9::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32 via Frontend
 Transport; Tue, 30 Apr 2024 05:16:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 05:16:44 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Apr
 2024 22:16:28 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Apr
 2024 22:16:28 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 29 Apr
 2024 22:16:25 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>, Eric Blake
 <eblake@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH 1/3] qapi/vfio: Add VFIO device migration state change QAPI
 event
Date: Tue, 30 Apr 2024 08:16:19 +0300
Message-ID: <20240430051621.19597-2-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20240430051621.19597-1-avihaih@nvidia.com>
References: <20240430051621.19597-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|PH7PR12MB9068:EE_
X-MS-Office365-Filtering-Correlation-Id: 13c9ef40-dbfa-4d32-1a5d-08dc68d4ba4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400014|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4ZiPFJCiezK9FUYbNYysToliB/eNsBeUzi+k7Axr7gF2vRo/UWyOtlCQyexN?=
 =?us-ascii?Q?iowAjZdhgJopqFZGkgaon+OqEH4OV4Sx/xnCUMdOxzLhwGar5DHlRn9Or4Uw?=
 =?us-ascii?Q?MvD4A3F7uXJrY22Nne1XqVQGaPF9olgphWzWLDZVOkcxAy1aN0kMoH9z3XpE?=
 =?us-ascii?Q?haK637q6XpgGXEtF6wQPjOTXaEMyz7AQM65g85PDs4OsLBVI+1gARm/q/j3Z?=
 =?us-ascii?Q?7L+K1nEpf5qQQ05ICtJ7Tv3+CR1p/EmEbv1hL3top/kVDSzr2xsbQaksmZfo?=
 =?us-ascii?Q?G5zYFom2epuykQ7lYmGa6znFz3z/wdWhAuVPW9E1LsnPhPaJp2sHylBdezfZ?=
 =?us-ascii?Q?2Sq924vOZUwpy/luiqvoSR0m+jvQo4kMmKDf7JI+nIHLNG+JPSmW8DaeP8Cj?=
 =?us-ascii?Q?7YRWgaeHJlT3Ti/RCEUKbRKSaUn9zl5eHbj49OnX5/w7yhm8uhBppOeSkXZ9?=
 =?us-ascii?Q?VHm9IMtlFCa5Un6cvlEhtCfNokU4Aj+kdF6RCb2+dNfg1ZpkSl2STT0bLL0u?=
 =?us-ascii?Q?Sz7XzygU+k0c4pndAsCZqqeWkHKsnFPHG6E0sJgyYsnUv0rR4f/yxns+LEik?=
 =?us-ascii?Q?UJ2O8KtJGv/MS3HGWB87u2fhWJQdY+TRzUdLSdlObdkgWDPyzZuxeeN+B0nM?=
 =?us-ascii?Q?lymx5jov2WakioqYGnqVLE+D6XgIp4/8xcx6S8/6cvHRcN9hczxprbLk/pws?=
 =?us-ascii?Q?echLeVRAKWVRRf+HV36Y00/wbkF+OrrPCxQxx8e4uiE2/xHASSQLpLT0fYpr?=
 =?us-ascii?Q?CsNeu/eUz18L6qv6j5D5skncv98etoSybPgN3S4kKklF2+l7yHCdDy+nnkjo?=
 =?us-ascii?Q?jRKO834UWYhmkamHe52hbTteHOwzJfsFb7v+g+pT/38ayAZy31lwLhAji0DQ?=
 =?us-ascii?Q?lOrT/8Llqktc9Mj+r9kiEXJ1/mRFMUDOORmlhetDUbGdD5WT+98C4WJ7hsGk?=
 =?us-ascii?Q?34pehb2bEMhP/wpnidqKTxxSaHWWKQ/qYDIeboLHW1+L2s6gl05ajK8l4HMk?=
 =?us-ascii?Q?9naE1UL3R8AGS9Eynh9V74K0RIR3t6FNZ5dwCK+BC3waImLVrdbT1ElR7Kmh?=
 =?us-ascii?Q?Bv9mI6sVpz41CM454kbuQGpgXnqhU4NkLsvud1I1cu6Co802QKkLJoQd/Otr?=
 =?us-ascii?Q?zcbq6AyZMw3zHQkzPadeF73d8GEC80IwTbhU6Odu+a3DfMTD9sMZdKg5Xhem?=
 =?us-ascii?Q?dA+TeGqp0h7TovDh6jFYhU1riNhtkZ8i1hS39Awno2tTus8vMeIn4oHkEGuW?=
 =?us-ascii?Q?yEdToQ6oBPQFvZVcRDxvkcSzajjlwpc7wkPRMbh9XZ/+9tdppjQCtBlwcoQm?=
 =?us-ascii?Q?dvHzshu+KigkXAOOe9U3yDIqpO8BQ6Igwepyb5eheT/SgSChxY+mO1zuNMoF?=
 =?us-ascii?Q?KPKd02RufIxQhvkNf43BPuXSbnkW?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 05:16:44.5641 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c9ef40-dbfa-4d32-1a5d-08dc68d4ba4c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9068
Received-SPF: softfail client-ip=2a01:111:f403:2009::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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

Add a new QAPI event for VFIO device migration state change. This event
will be emitted when a VFIO device changes its migration state, for
example, during migration or when stopping/starting the guest.

This event can be used by management applications to get updates on the
current state of the VFIO device for their own purposes.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 MAINTAINERS           |  1 +
 qapi/qapi-schema.json |  1 +
 qapi/vfio.json        | 61 +++++++++++++++++++++++++++++++++++++++++++
 qapi/meson.build      |  1 +
 4 files changed, 64 insertions(+)
 create mode 100644 qapi/vfio.json

diff --git a/MAINTAINERS b/MAINTAINERS
index 302b6fd00c..ef58a39d36 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2159,6 +2159,7 @@ F: hw/vfio/*
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
index 0000000000..a38f26bccd
--- /dev/null
+++ b/qapi/vfio.json
@@ -0,0 +1,61 @@
+# -*- Mode: Python -*-
+# vim: filetype=python
+#
+
+##
+# = VFIO devices
+##
+
+##
+# @VFIODeviceMigState:
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
+{ 'enum': 'VFIODeviceMigState',
+  'data': [ 'stop', 'running', 'stop-copy', 'resuming', 'running-p2p',
+            'pre-copy', 'pre-copy-p2p' ],
+  'prefix': 'QAPI_VFIO_DEVICE_MIG_STATE' }
+
+##
+# @VFIO_DEVICE_MIG_STATE_CHANGED:
+#
+# This event is emitted when a VFIO device migration state is changed.
+#
+# @device-id: The id of the VFIO device (final component of QOM path).
+#
+# @device-state: The new changed device migration state.
+#
+# Since: 9.1
+#
+# Example:
+#
+#     <- {"timestamp": {"seconds": 1713771323, "microseconds": 212268},
+#         "event": "VFIO_DEVICE_MIG_STATE_CHANGED",
+#         "data": {"device-id": "vfio_dev1", "device-state": "stop"} }
+##
+{ 'event': 'VFIO_DEVICE_MIG_STATE_CHANGED',
+  'data': {
+      'device-id': 'str',
+      'device-state': 'VFIODeviceMigState'
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


