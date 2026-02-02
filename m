Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7863CE7DF13
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 17:35:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmxp1-0004mE-LD; Mon, 02 Feb 2026 12:34:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1vmxoy-0004jk-96
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 12:34:45 -0500
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1vmxow-0003wD-7g
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 12:34:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s7Ec0x3yUfqmjX3Ew2aOmM/qD2ep0SfW6ocAmeoHfqSH+23kBE2c5NS13QI365uHKxWHc2nMxRNGJ0v8eM6ypVt3XNyXKcR0gMO1OeCvk9dlTTnTvTQkLTwrmDwWhjr4cqT85pBYl8oqNEIPmYBpF8XyRDhZN60JwUG2JOgo3sIslZ+xSpBnRcgfusg0n62QrqWjg7v5pToiVIDlvHqtzSKnha5dG/BwWSOxYV9IIuAemZulenWMTBKzbsxdvAB3TuLF7op6IaEaRbxSlu3giFYyrY6MwJ91RLYkB+oVGA1DOeOS3pB01fgDvE+/FOLP0vkwy+RexM3wCe0S2JdT4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmrPYfpfGCWokvSR50GU0tCRjPxDXhOC3MhLqa5crA4=;
 b=l7v/pFHwg+9fMbwAQr2q+gmygiCQitzIDu2UVqZEo3k3vTcr7OAg6VxYIfqv+a6jzzIH1O9Y5ZtfXveLR3G8FMRUKC3m5Sw50BbwmIN0Mu6PEx1nEOfO6RYlFveBq02tG4MYrwGwvPAaZS/vesQ8dwLRTt6u2U4uGAs0me2+9+lxANCGiWY6/G43+x+jx9MlnX3V1wjsH365TxXm0+1NmteHuSoNpoPxhMqdw01oJWOHN6JfgX09jBItfPIGDy8iU/DGOtfKlPC2exH0xjZ66tEy44dBHJUi+14Xx+01+8FOy8iGHJy4F3907CVx3b89FIO+en3hi4b5wAD+iVOzXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmrPYfpfGCWokvSR50GU0tCRjPxDXhOC3MhLqa5crA4=;
 b=epg35JC8GuyeKJMXxaKLnnnO4ZX/LDfw/kTlB8Tx4oXSrTEyvtq63PsHCxQ2M4DEdk4062e4dTrWIJa48pvRuuuJ63rZB7qCTAqv2N3459IpYpxc18luzPW8M6T+e7itgRFJT8lA0W69CJ8OBRyNk0nJH0m39aVskm2fqKbPiC/P45iYSlQa4Fq55ouKESzti2Ue2fZwth5c5Hn88PzYBk6zMKpmHBGUPe67y9PqMbIib9jtiLdqLYsXiMRKuNs7nnE5RLhpV1DoH0vFbFKWfacS87Vj+c1LyKjnrAcOeF4Nm7RBKyxa5ka9mwHefuqUYLbaIRWjJLPONF+ZtPgVMw==
Received: from BL1PR13CA0411.namprd13.prod.outlook.com (2603:10b6:208:2c2::26)
 by SA1PR12MB6703.namprd12.prod.outlook.com (2603:10b6:806:253::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 17:34:34 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:208:2c2:cafe::28) by BL1PR13CA0411.outlook.office365.com
 (2603:10b6:208:2c2::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Mon,
 2 Feb 2026 17:34:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 17:34:34 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 09:34:10 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 09:34:10 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 2 Feb
 2026 09:34:07 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex@shazbot.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Maor Gottlieb <maorg@nvidia.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH v3] vfio/migration: Send VFIO_MIGRATION event before
 PRE_COPY_P2P transition
Date: Mon, 2 Feb 2026 19:34:06 +0200
Message-ID: <20260202173406.13979-1-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|SA1PR12MB6703:EE_
X-MS-Office365-Filtering-Correlation-Id: f04894b3-3b4a-4d73-d2d2-08de628154b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b+XT0h2KaiQapwEDY6xaR2UzOGxsvVWQHXo+ZjTmfMalhXRz2hZNEP51cLX9?=
 =?us-ascii?Q?gW6UNG6XZqTw9YOtV+RvPND2nZMJKcPE+LdGKzD2F6MEDJcxA+9BBxUeF+lV?=
 =?us-ascii?Q?bmTcP9K5zqNeSIqzBXnIjZhX2GAoKDbTsbRP04+UXZrG3HiLpKUbucCcHaq9?=
 =?us-ascii?Q?GIMTgeu89zVfoeUeFv6j/iJMjloZ033lxitcCNIqoC/1x1wpABNR/Mb4stkI?=
 =?us-ascii?Q?PwAz6ATJVUSmMWE+8tE/Q2VvwAdXgpbl4QwLFImxp02g6PghC1N/4wNHcRk9?=
 =?us-ascii?Q?pbtj1bvZz/D0exrAZNbE+xTX2hXn9iGlYnuQUYz1Y9MkTO8X7J0crr1ROvjz?=
 =?us-ascii?Q?aJLC+plxba9BgpidU1qIdhWFrhbb17EjYnyhVbIVincaKcBrVCatDKQvq7KT?=
 =?us-ascii?Q?8pkOn4S2zrLLCwFN6h15n5KSiN32KpBX5YUXbAqg2Nj4NV2iPQuNgCzX1o21?=
 =?us-ascii?Q?nlaAZSkGdCY7FUHZ3NoM+Mok3FE6wjjSwmbq0WkrBletN6ge21C6/lAhQqVx?=
 =?us-ascii?Q?am4r2SPQauaV6ku/wpGd1cqgrIqP029QHUkZOmLeHCFdoaXMMwOieH/WNy4d?=
 =?us-ascii?Q?W/IiiEzoMM6WwR+WcHW+aLiannOFxoOMYNt9YLbpOiEbHlc+SQsIZAyDff2c?=
 =?us-ascii?Q?2zHi1VU8ZyieQA0jZ7RMIEDTux/Z3nDw+7Mk7cKnNotVXuXcmcaMHH3q9xmF?=
 =?us-ascii?Q?PsUaIj67srcj1d1APzJw/SlCZlYcUfujWaNEexvVn0xIrN6KB8kVmRpB0SdS?=
 =?us-ascii?Q?EkrcIpY00+1dhoGvFabc9lKNem3WBqa9hCYI477M5ndSqptAcO0/9DlPWsjN?=
 =?us-ascii?Q?Tnh7oW3W7LRcdQEPa8LjPSO5Gx/uE8Ib5uBzdvn2wnjjZGF2Oz1RB4QZCrc9?=
 =?us-ascii?Q?xgoPMBol/KYYrhskpEiFPTyHyYIdV3+xUyIwbYdOZodki+QJWKduMjWTIoBK?=
 =?us-ascii?Q?S7j+AoJvQvuBf/HDg+azQBGD41CLU7X7dfi+rsoHFANwXlAEeH/aHKj6KLkD?=
 =?us-ascii?Q?Yjux09QpBSzQ+mi6tQEAJ3K0BW20C/u06kTTmL4agBj4YL3OCJiWp9OIzH5A?=
 =?us-ascii?Q?w0yzO0+BD+4b8Mmhh8ps+4YpZ6GEZDIzPTqI7G1FQ35XIbPEGt1JSpcsopOC?=
 =?us-ascii?Q?y+5qOcrilxq6B8tUp+2sz+sRpkjA7n1xMZRyRCZrIxpMj0VgeH3pu+USKSSr?=
 =?us-ascii?Q?e9/JTas3+LFy/8XWCAWzGL50Q045f35ayqPmkN8tVa5DRF2CCSTk9laTHO69?=
 =?us-ascii?Q?gkUo/YVTK7hCwxuCjWK6SPrFevZM1iReUavVw0fU8FPx5Y2nbCDd9Gm9ay9i?=
 =?us-ascii?Q?T0MO1EYV0bILX+IcY4VaH5ksYyhqgIC+1fWUKxyASqxmzsmfODtUhgT+Af9l?=
 =?us-ascii?Q?8EtE/F2Q8fe1JIDYDRCmDBNLw71WB7G3WIZP2a8PZVBl3Si+4nsmvY4RivRN?=
 =?us-ascii?Q?Z9yHWisuALsCq7dWWLJwG481zM1zH/0mj4/83FQWUUG1/0fenGRfnstsdd7M?=
 =?us-ascii?Q?cDlbNh9jxJXe50lvinstBgqoj4iBXkTYZYrASflmCI+dWLKqFhHNE+aPm3VS?=
 =?us-ascii?Q?a/yu6G6Q/KdMyjhbqOmiTLgIZIebLSCi2hWqpDnmhseXkL95CWd+3SSjbJMn?=
 =?us-ascii?Q?X1T+o+p8h1Ylyc8Ku43uV4pTblMQ35cXx0kR78fEHmp2xrokWFcQiFbKvoqu?=
 =?us-ascii?Q?4g3GNw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DGxrqKzMFufJAKOZUYs71Ld3V5abqWPyxpZ8ozcRQIohRSjhWXdkkWWfBF7caWCQOQ5/gZc3V1NFkznWe9NdxYNUy8pz841fX2xVvBxeKTfmULvZDGG5U+YRDoS9FebCZ7cMHgfHwFM/aD3w45+D9i+XqExMv6xiGbStnEgx7B2O42ROrcSdV1aF0KbKXBA4oYnke3dWS5M2NF00PaRo/S3AwaJ9z8CM4u/q/TRkAHriFIyXwcwD1RGlGBCJCkA8nAeDG9mss7Wl8gYb5goAdClyi5hMFEja4UumA5Gv4WuaqDKL0oeu643Hmg9h+U/OqkcoI1kxaUxkSQNnXOGlzNZyeHiLkSz5+nfdG5i4LXlXt4qmusXAZafTph2kfwKD+feciKLz2LqjZJe0eTjiAr4lyHpCrKnK7VvGbxjPDejUoBRRd8sfmAbH2SzNUoZ+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 17:34:34.2579 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f04894b3-3b4a-4d73-d2d2-08de628154b1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6703
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=avihaih@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The VFIO_MIGRATION event notifies users when a VFIO device transitions
to a new state.

One use case for this event is to prevent timeouts for RDMA connections
to the migrated device. In this case, an external management application
(not libvirt) consumes the events and disables the RDMA timeout
mechanism when receiving the event for PRE_COPY_P2P state, which
indicates that the device is non-responsive.

This is essential because RDMA connections typically have very low
timeouts (tens of milliseconds), which can be far below migration
downtime.

However, under heavy resource utilization, the device transition to
PRE_COPY_P2P can take hundreds of milliseconds to complete. Since the
VFIO_MIGRATION event is currently sent only after the transition
completes, it arrives too late, after RDMA connections have already
timed out.

To address this, send an additional "prepare" event immediately before
initiating the PRE_COPY_P2P transition. This guarantees timely event
delivery regardless of how long the actual state transition takes.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
Changes from v2 (https://lore.kernel.org/qemu-devel/20260201122348.28478-1-avihaih@nvidia.com/):
* Renamed prepare-pre-copy-p2p to pre-copy-p2p-prepare
* Renamed prep parameter to prepare in mig_state_to_qapi_state() and
  vfio_migration_send_event()
* Added short explanatory comment before sending the prepare event in
  vfio_migration_set_state()
* Explicitly used VFIO_DEVICE_STATE_PRE_COPY_P2P as parameter for
  vfio_migration_send_event()

Changes from v1 (https://lore.kernel.org/qemu-devel/20260128105159.10282-1-avihaih@nvidia.com/):
* Removed VFIO_MIGRATION_PREPARE event and instead added a new
  PREPARE_PRE_COPY_P2P state which is sent before PRE_COPY_P2P
  transition
* Added details to commit message
---
 qapi/vfio.json      | 13 +++++++++++--
 hw/vfio/migration.c | 26 +++++++++++++++++++-------
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/qapi/vfio.json b/qapi/vfio.json
index a1a9c5b673..17b6046871 100644
--- a/qapi/vfio.json
+++ b/qapi/vfio.json
@@ -11,7 +11,13 @@
 ##
 # @QapiVfioMigrationState:
 #
-# An enumeration of the VFIO device migration states.
+# An enumeration of the VFIO device migration states.  In addition to
+# the regular states, there are prepare states (with 'prepare' suffix)
+# which indicate that the device is just about to transition to the
+# corresponding state.  Note that seeing a prepare state for state X
+# doesn't guarantee that the next state will be X, as the state
+# transition can fail and the device may transition to a different
+# state instead.
 #
 # @stop: The device is stopped.
 #
@@ -32,11 +38,14 @@
 #     tracking its internal state and its internal state is available
 #     for reading.
 #
+# @pre-copy-p2p-prepare: The device is just about to move to
+#     pre-copy-p2p state.  (since 11.0)
+#
 # Since: 9.1
 ##
 { 'enum': 'QapiVfioMigrationState',
   'data': [ 'stop', 'running', 'stop-copy', 'resuming', 'running-p2p',
-            'pre-copy', 'pre-copy-p2p' ] }
+            'pre-copy', 'pre-copy-p2p', 'pre-copy-p2p-prepare' ] }
 
 ##
 # @VFIO_MIGRATION:
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index b4695030c7..4bd8e24699 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -68,7 +68,7 @@ static const char *mig_state_to_str(enum vfio_device_mig_state state)
 }
 
 static QapiVfioMigrationState
-mig_state_to_qapi_state(enum vfio_device_mig_state state)
+mig_state_to_qapi_state(enum vfio_device_mig_state state, bool prepare)
 {
     switch (state) {
     case VFIO_DEVICE_STATE_STOP:
@@ -84,15 +84,17 @@ mig_state_to_qapi_state(enum vfio_device_mig_state state)
     case VFIO_DEVICE_STATE_PRE_COPY:
         return QAPI_VFIO_MIGRATION_STATE_PRE_COPY;
     case VFIO_DEVICE_STATE_PRE_COPY_P2P:
-        return QAPI_VFIO_MIGRATION_STATE_PRE_COPY_P2P;
+        return prepare ? QAPI_VFIO_MIGRATION_STATE_PRE_COPY_P2P_PREPARE :
+                         QAPI_VFIO_MIGRATION_STATE_PRE_COPY_P2P;
     default:
         g_assert_not_reached();
     }
 }
 
-static void vfio_migration_send_event(VFIODevice *vbasedev)
+static void vfio_migration_send_event(VFIODevice *vbasedev,
+                                      enum vfio_device_mig_state state,
+                                      bool prepare)
 {
-    VFIOMigration *migration = vbasedev->migration;
     DeviceState *dev = vbasedev->dev;
     g_autofree char *qom_path = NULL;
     Object *obj;
@@ -106,8 +108,8 @@ static void vfio_migration_send_event(VFIODevice *vbasedev)
     g_assert(obj);
     qom_path = object_get_canonical_path(obj);
 
-    qapi_event_send_vfio_migration(
-        dev->id, qom_path, mig_state_to_qapi_state(migration->device_state));
+    qapi_event_send_vfio_migration(dev->id, qom_path,
+                                   mig_state_to_qapi_state(state, prepare));
 }
 
 static void vfio_migration_set_device_state(VFIODevice *vbasedev,
@@ -119,7 +121,7 @@ static void vfio_migration_set_device_state(VFIODevice *vbasedev,
                                           mig_state_to_str(state));
 
     migration->device_state = state;
-    vfio_migration_send_event(vbasedev);
+    vfio_migration_send_event(vbasedev, state, false);
 }
 
 int vfio_migration_set_state(VFIODevice *vbasedev,
@@ -146,6 +148,16 @@ int vfio_migration_set_state(VFIODevice *vbasedev,
         return 0;
     }
 
+    /*
+     * Send a prepare event before initiating the PRE_COPY_P2P transition to
+     * ensure timely event delivery regardless of how long the state transition
+     * takes.
+     */
+    if (new_state == VFIO_DEVICE_STATE_PRE_COPY_P2P) {
+        vfio_migration_send_event(vbasedev, VFIO_DEVICE_STATE_PRE_COPY_P2P,
+                                  true);
+    }
+
     feature->argsz = sizeof(buf);
     feature->flags =
         VFIO_DEVICE_FEATURE_SET | VFIO_DEVICE_FEATURE_MIG_DEVICE_STATE;
-- 
2.40.1


