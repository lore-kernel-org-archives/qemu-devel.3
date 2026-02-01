Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 907CFE7C718
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 12:30:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmWZs-0005sj-2f; Sun, 01 Feb 2026 07:29:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1vmWZo-0005sK-2M
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 07:29:16 -0500
Received: from mail-southcentralusazon11011029.outbound.protection.outlook.com
 ([40.93.194.29] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1vmWZk-0003Ep-5k
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 07:29:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U2csob8fv9eFIEmPFrKoBcAsKyPzH3ChqePW5xQdjW3McZcCF80f++aCimIhKCl6PtLJ9+k1sTJi27hj8ScV1ipB3drbJa0FUetKwGzxg+gfXOFZUYsoO/iXSvHGgqXQJsUgzbaYY4Ak586XSmMH4nvSUaJ06biaokrV7eC9h+Nm+dRXVHJwYebScyG4AHYXLbbFAVNvxy/zUpZzEMfEiOn5sJ/FJ1gnQNWWp6FKXGoPEs8b1n2DWbmlEPGlxA9OtMChNI6izPd+dG55DHuY/auFtf/5bpZGoadg2W6GvZ5qVKKi5kW+/DS6jRHBiq7WIC+rT2zgLkOnEwjznbz0rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+Fw0iaoXWevgDn2VlFSIAhSaRmbloXSbd2MQVIMbSg=;
 b=HeOTabbJa8QQHoGLWSvdqfstMavjqQMMibeC8LtEgE5Sj/usFy60yMuUbTVC+pSEL2lHAM8R1MpC5hC6w1e0J2v2Z8ekH5BX7M0rfKUVm7FBoMvJD6Kj4+Y3PwzOrJWIoqQStwXoIvD2coWDjRoUbuxp/alUiSg6r+c6KwOg3alk/GkAMIXAIZPTtU/LGbWIGa+vEcZaoynC4OG+/36T1Y5r/TbMBG29L1cNoJbE4d4QZkx80yxAgE4oS5iGrdyIWlfNCVQNN6d7wgbNcrvZAdPZMMUWuUA8357u8y/qWH3dSaro+UZeW4mCg75XpnG68NVlXMKPw3O3NO9QjzMyjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+Fw0iaoXWevgDn2VlFSIAhSaRmbloXSbd2MQVIMbSg=;
 b=n4JvRBxMRC5smbF9Xi2rr+aLC0aQCFgNGBQF8AKplSvCNFKyidL3stKgVf9UUxdub5TMqZDWwlQmcCj9nTwZgXC2+Zmkz5yW7Y6Hbxo6wTkGzhCU/FEC1ZsQyNrcO4r1UkfWJkjgfPV9qudj2+8rxMd83tn1HX+Lc61VZ4zaabJuPfWslHJKL8vjPIUMG75rrGgQMfZxKeL9y8hsqPbzEwYpgerx8HF3TGv+wf+T1KXTk/nGpeRtHCGNQ5eM6OvIHTj8wwnlj4Z43TLg10XkBOYs5jujPSUQUgUkly8fGDChjcP5kyEmzqcS47NieQt7gDrNmt/7+xyG9Wy3XY0Ngw==
Received: from SJ0PR05CA0133.namprd05.prod.outlook.com (2603:10b6:a03:33d::18)
 by DS4PR12MB9636.namprd12.prod.outlook.com (2603:10b6:8:27f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Sun, 1 Feb
 2026 12:24:04 +0000
Received: from BY1PEPF0001AE1B.namprd04.prod.outlook.com
 (2603:10b6:a03:33d:cafe::7e) by SJ0PR05CA0133.outlook.office365.com
 (2603:10b6:a03:33d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.4 via Frontend Transport; Sun, 1
 Feb 2026 12:23:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF0001AE1B.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 1 Feb 2026 12:24:04 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 1 Feb
 2026 04:23:52 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 1 Feb
 2026 04:23:52 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 1 Feb
 2026 04:23:49 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex@shazbot.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Maor Gottlieb <maorg@nvidia.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH v2] vfio/migration: Send VFIO_MIGRATION event before
 PRE_COPY_P2P transition
Date: Sun, 1 Feb 2026 14:23:48 +0200
Message-ID: <20260201122348.28478-1-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1B:EE_|DS4PR12MB9636:EE_
X-MS-Office365-Filtering-Correlation-Id: 06caf981-4c3e-42a8-d700-08de618cc9c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VC7D/Yrf+g51ic8/iyYQxVV9B5a8UnPJKWq+fdOiNgSDolxzyxZnIn2brDx9?=
 =?us-ascii?Q?5K3T62suYeIUYSsQL6zRAx+Q+CqhL1tERLxmBVPPRT8qe+kR6/cOpQ42vVlF?=
 =?us-ascii?Q?hyYWAlxNvSHFzTsqlDKYH22/ViP1eYTsyprDOiJoJJf/QpXtPmvkyh75YmN9?=
 =?us-ascii?Q?rj44yUuLU/fZqlwwGKSEZ7S30FTe9f43sZ7NUCfGRH2YZ6G3EyU75lWUUIDh?=
 =?us-ascii?Q?MC//FNmvQnXSnCkZ+Tsw123Npq9mPjGNJiScYoMuTh0orRjloN1fzzGh+skg?=
 =?us-ascii?Q?Yt1oqqFXzd7a2OgvD2WSC3oCTCEt1bl6060zQp21/QziGQEjhWbwfujz5vrE?=
 =?us-ascii?Q?NNIQhUehTWmnMkE3i8p637rSY0+bDjU1mzouryRWQVb7HoA6QogFYnBFdyoM?=
 =?us-ascii?Q?MGBnVamaMM+97jbuhEu9230dpz1iClWn01RgB1XoJ0lssyl8SjjoGFlL+IQ/?=
 =?us-ascii?Q?uVSy8Zdtc3FY7nxFxvI/mZ0V+E/nVbyOUfdIYhhtVXXH3i6H6nlsHm4LPLyG?=
 =?us-ascii?Q?BIziKIXNrHvBdQ98F76JsuSzvRT3RCal8QubmAw2W/06lh+BbtkmldnlJ/W5?=
 =?us-ascii?Q?qxax4NGLSSpOfrwACfLgAi4WYR5+n35YHRq9P04X5Mm2TtYNmbI0Q6IkwlVo?=
 =?us-ascii?Q?3o87xQEcs6jfQywHeueifqI/3G7wweKjOlQnnM569PJSglQ81Kidm45Y/zOX?=
 =?us-ascii?Q?q1Y2LqzqFZv+N5oBwikAhhhgqBYzA2c7UIdWi7W6CQYwG8yUdAQu9o+MG90F?=
 =?us-ascii?Q?0972SVdOCpDNtpDzx4elNUpxUO7XRbn4JN0G+WwlKagUKAtqpS2AlApbkINe?=
 =?us-ascii?Q?4RfxEBRcA0SYw3t/GFKopxo97HdgqQ+jby4vJIyA7g330z3l7WzqFewBa8Dk?=
 =?us-ascii?Q?VTeakB+ll/dzoduFCpFuGhXWZlkWRCyxOZw91QkB3Ckc0OeApyHzc32Fjdqg?=
 =?us-ascii?Q?57E7re5ji6V9HimzGKXT0D/gDLkD6Psg6edPAt3nWPKv7/dVdEJfyYyujYtj?=
 =?us-ascii?Q?PrvNWfPgLqccJwy7KzkaM3p6aS4fxXGBU3OGfuk5jsDq/K6fGXzXSCuWgkvV?=
 =?us-ascii?Q?z7AKO8WMkwj/w6QXdGV8L+iQMrD0Rfs+fhQZ2w8qE2Q/Ag65OO3VVrt3EcZi?=
 =?us-ascii?Q?o/ruptZLnru8Stu1t31eZ8mXbE2zYm78aTxDj7k9Cvh++Nix+cPwhNTNRAhS?=
 =?us-ascii?Q?Tq1lw1spGhz4vt+uRe13wWj1ZTzk2B+KHJekCYHvbCIP+zKJ34r8y8Putm15?=
 =?us-ascii?Q?NCzA1O5BP/tYTf8aZ1d/izYaYe2XS7ed9OWvOz+qaNYpcO+7FZwiew9z1tI5?=
 =?us-ascii?Q?znAKbxvfHuMaUbDrU7VMOME6dPG09c2ZXyE4sUAhWzmJr3jzHhiPSY7ge8dq?=
 =?us-ascii?Q?iM4T2CHFieDcxT7eWVZT4SKjM9nR/c4eEaezC4NZg/dWJ2NH8zJuywqtRUEK?=
 =?us-ascii?Q?OazrhVlVULyV/xvZSLCJeUILdKV4k6ccEbq0YtNf9PDH/M5ap1bEkIDXWuUP?=
 =?us-ascii?Q?q72x10jeFKOssL2Lh9Clmad2DJPK0Y5bQ+KLZgWDRDUcLFyaXSqMLTB15ZPF?=
 =?us-ascii?Q?JfZfCE7FWUeRONUiuLJZDuKfCA04H1PDMdu9nS+tHdGNJjhJ3AtfDwdM2iQC?=
 =?us-ascii?Q?7r1pEdeajKvJIxQpPWTWkGhbGbA9QdOM6+xM4qrvX5FrVTOKHJK6p+qrxWFK?=
 =?us-ascii?Q?GSQCDw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 31ZEkagSjClAuTvWmqMNdtYmwu4yBT0buLlk5VVaTLPgVNR6T/gnGTuB/fZoDoR4aFfQSunur7611b/OsM+Rtl5mHOAW7Ftl8X3jbdQT8J7tn7xyQnvsEgPnKw/Hl18MLL/L+wtxC+qT7vh4Yc7xh5z1jsTQm7u+DWJvtgSivcUpF07uLyPhYdPQQoI9q7++Ux0/r1LWvrj2JcYfXmMNr8qA5xslgkvy0QQkgoILIpf2Di7kLa5xH3SgdQUCHHdEzHcmo0iqXe6nw0gD9aPmhWRz2KqmF86aRjc+E0356u5k+EOYKJBUoXIGSBtcZvaLFuN8TeBX2IR4xKs7eoLIy2sNRvWaSYERWOSfXaDEpcQTCWQcas0wDiZjJR7iXKo8NdqD9fYu0CDKGSAW4xLErig4yHc56Pftd+FJFWkPByktJBcZDzWpCcvXv0yp2JDf
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2026 12:24:04.0078 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06caf981-4c3e-42a8-d700-08de618cc9c2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9636
Received-SPF: permerror client-ip=40.93.194.29;
 envelope-from=avihaih@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Changes from v1 (https://lore.kernel.org/qemu-devel/20260128105159.10282-1-avihaih@nvidia.com/):
* Removed VFIO_MIGRATION_PREPARE event and instead added a new
  PREPARE_PRE_COPY_P2P state which is sent before PRE_COPY_P2P
  transition
* Added details to commit message
---
 qapi/vfio.json      | 13 +++++++++++--
 hw/vfio/migration.c | 20 +++++++++++++-------
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/qapi/vfio.json b/qapi/vfio.json
index a1a9c5b673..2de87dc215 100644
--- a/qapi/vfio.json
+++ b/qapi/vfio.json
@@ -11,7 +11,13 @@
 ##
 # @QapiVfioMigrationState:
 #
-# An enumeration of the VFIO device migration states.
+# An enumeration of the VFIO device migration states.  In addition to
+# the regular states, there are prepare states (with 'prepare' prefix)
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
+# @prepare-pre-copy-p2p: The device is just about to move to
+#     pre-copy-p2p state.  (since 11.0)
+#
 # Since: 9.1
 ##
 { 'enum': 'QapiVfioMigrationState',
   'data': [ 'stop', 'running', 'stop-copy', 'resuming', 'running-p2p',
-            'pre-copy', 'pre-copy-p2p' ] }
+            'pre-copy', 'pre-copy-p2p', 'prepare-pre-copy-p2p' ] }
 
 ##
 # @VFIO_MIGRATION:
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index b4695030c7..3b215eb4ff 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -68,7 +68,7 @@ static const char *mig_state_to_str(enum vfio_device_mig_state state)
 }
 
 static QapiVfioMigrationState
-mig_state_to_qapi_state(enum vfio_device_mig_state state)
+mig_state_to_qapi_state(enum vfio_device_mig_state state, bool prep)
 {
     switch (state) {
     case VFIO_DEVICE_STATE_STOP:
@@ -84,15 +84,17 @@ mig_state_to_qapi_state(enum vfio_device_mig_state state)
     case VFIO_DEVICE_STATE_PRE_COPY:
         return QAPI_VFIO_MIGRATION_STATE_PRE_COPY;
     case VFIO_DEVICE_STATE_PRE_COPY_P2P:
-        return QAPI_VFIO_MIGRATION_STATE_PRE_COPY_P2P;
+        return prep ? QAPI_VFIO_MIGRATION_STATE_PREPARE_PRE_COPY_P2P :
+                      QAPI_VFIO_MIGRATION_STATE_PRE_COPY_P2P;
     default:
         g_assert_not_reached();
     }
 }
 
-static void vfio_migration_send_event(VFIODevice *vbasedev)
+static void vfio_migration_send_event(VFIODevice *vbasedev,
+                                      enum vfio_device_mig_state state,
+                                      bool prep)
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
+                                   mig_state_to_qapi_state(state, prep));
 }
 
 static void vfio_migration_set_device_state(VFIODevice *vbasedev,
@@ -119,7 +121,7 @@ static void vfio_migration_set_device_state(VFIODevice *vbasedev,
                                           mig_state_to_str(state));
 
     migration->device_state = state;
-    vfio_migration_send_event(vbasedev);
+    vfio_migration_send_event(vbasedev, state, false);
 }
 
 int vfio_migration_set_state(VFIODevice *vbasedev,
@@ -146,6 +148,10 @@ int vfio_migration_set_state(VFIODevice *vbasedev,
         return 0;
     }
 
+    if (new_state == VFIO_DEVICE_STATE_PRE_COPY_P2P) {
+        vfio_migration_send_event(vbasedev, new_state, true);
+    }
+
     feature->argsz = sizeof(buf);
     feature->flags =
         VFIO_DEVICE_FEATURE_SET | VFIO_DEVICE_FEATURE_MIG_DEVICE_STATE;
-- 
2.40.1


