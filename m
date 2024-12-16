Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EFD4E77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 09:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN7h8-0000XM-Qw; Mon, 16 Dec 2024 04:47:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tN7h6-0000X4-Ka
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 04:47:17 -0500
Received: from mail-co1nam11on2062a.outbound.protection.outlook.com
 ([2a01:111:f403:2416::62a]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tN7h4-0004MQ-P5
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 04:47:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WzQlo9uqNT8I7HELFuIX5w556muQrtDTdz9WROWAkibNUPnsUCZKx9xoLnv2Mu2pf3PBKreRfPvBLU2h6IdxtCEK+b6gpp7DiBgVHbATxL3tubLWGkwL43N4XTIodZ3d2+Zv4fTspv3W36ffMr1HEvkd4+aaTgb30pxGaQh8A4GlW10ZIY2R3RSLWM5innXizXBlf8bQiuCR/HtRyR4johmAG+3NHCIAr36AFmxburqaugx1bfztxwt9dzo4qrf7AVoeMd3yjiAP6P383ju2eCZB1r+Ju4t716pt5SNel3Yk0efCfN6Lm++XsYcojXHsC2yJNYePJYytGEbQnoNmiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLHrEJluMTpfJiGRKKnzy/R6+v/rtPavVRfMOXmStSw=;
 b=UANZa13XTzHU6TeTNXcsLC05DN8CeAmcdHRqFwASuddNvl5YHBAUapW0R9sJSKDrugkFAU+VdYPCni5xE4uyBM31NYHePiW+q9+CU/hshRKzRmftspYqWpucF8a+EVcqwfNj57gYFBhUSEpHwzuvnQeuaxWBoIZsbuUnF/q04FNlWQbslk7QU5HxwBYZrUynXO3iXMvMzaWjgmAiz4nvjwQR7EXAyDWklbqmNODZkdIf6EOtBqwyugVevc53lSO37cjMXGDr9+EToKjx5SA9LfeVb5X0kIzx0fQfjAKi21qsEyGYXbG3Xif6R2Y4inCUyABp/zs8/2I7Tf6SrLqcAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLHrEJluMTpfJiGRKKnzy/R6+v/rtPavVRfMOXmStSw=;
 b=m4+bLaE10CHkVb2fL1sGRH6CQK+FdT5hwbUsPU/ecM8SVZHk29hQE6+slpLg8/WHbBtpBtyWKxXs9JfqP2tLGi8FNQeBqOFojTDSoCVpSzBNj1BZoF0mCL91jOK/JFd3xwo6tLlZfuBozw9R9C2cxmxmK37FL5G2+k0cgGHzS4AiexhpYKrx8pNdYoCtP97kuRPp8BqtsFuR9ZgeyUp//v85GEnJeaa+pBd/2jZBVpkLiUHPYkTyHu9OpKGtm3mplq3C8OPVJouyqtfKN3M5vJ510VZbfXCq0LdVyQLtZk+gZV0+y88oxg5ty9ARdORL62BAiXpaMi/SrjLU7wg4/w==
Received: from MW4PR04CA0350.namprd04.prod.outlook.com (2603:10b6:303:8a::25)
 by SA3PR12MB9225.namprd12.prod.outlook.com (2603:10b6:806:39e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 09:47:09 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::9) by MW4PR04CA0350.outlook.office365.com
 (2603:10b6:303:8a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Mon,
 16 Dec 2024 09:47:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 09:47:08 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 01:46:49 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 01:46:49 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 16 Dec
 2024 01:46:47 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, Hyman Huang
 <yong.huang@smartx.com>, Maor Gottlieb <maorg@nvidia.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH 3/9] vfio/migration: Refactor
 vfio_devices_all_running_and_mig_active() logic
Date: Mon, 16 Dec 2024 11:46:32 +0200
Message-ID: <20241216094638.26406-4-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20241216094638.26406-1-avihaih@nvidia.com>
References: <20241216094638.26406-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|SA3PR12MB9225:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e3498ba-6b66-48b7-08bc-08dd1db69b51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bTbFtHQsANSoL7QSFyoOAxY7BJG3DQ4s+QVqu/pEIc3gpFokruBj+kpNg4Fk?=
 =?us-ascii?Q?SJ5/dBSmwadbi6kGPl/kwEOoHU957+U2xiVROcRo7fJG+gRxPOCpbD6zxVjy?=
 =?us-ascii?Q?oxmxfuMtOPt3eYfxF0QVC1dkcsmKKLuBr28NOR0ZCX81XSpkie2Rss7gnIyU?=
 =?us-ascii?Q?fxIA0qwAvIbRjB73eHGD2Sz51sloVdBpHt93Usnv/tOa+ZF6V6cdJ+3Uo0qx?=
 =?us-ascii?Q?P68j0lRGk7snLDjL5yrPqkOS8g6/JfsM7bitweA60Os6f9Qi5Q7h/rxq3dQL?=
 =?us-ascii?Q?ayfyPmdHHG0RzMJyPIN+ZpPX8JorWG50y4250hHjPdshcTgQYiPrlHqRh0km?=
 =?us-ascii?Q?QcDtFmDF2rOevhBWNjFnz14prsd5Cw3/9f1SX8rM/YKpxFw6jnIn27ctFQN0?=
 =?us-ascii?Q?4FdDhnJZFtyU2PGPe6I/ByQproRqpT8sGln2aslIeFWEKo29DJ3N/tQMeEGt?=
 =?us-ascii?Q?pN5CkC0gzDFJ8zGnBbRgTViOThpLmuMs4Fo3TtG0G6RecSBsnMTaEF6CSJrE?=
 =?us-ascii?Q?DtttD2F7W297AswNoNtSrR+gdfRV1mNAqvAF8MHfwjFjC9/zypQRAkCBEMhZ?=
 =?us-ascii?Q?OuTpJuFSL7ixvYSZO3ZC0+1EYuc/ltQz4EjAUouGLDcNKJub0nOR4NutrjAk?=
 =?us-ascii?Q?kvXrIH1HCE9L6/fkHVoxJD2pSacA0mqSclveW0PBBJqpDEKO/iWLBBGofxE3?=
 =?us-ascii?Q?3+ptyzZi4yMceq60a8niZbjdK4PZvzc/2JZBdDMCpqvCUVlPnQv+pjEj+MgI?=
 =?us-ascii?Q?u896U83K4+0SXZ313xOEf1+jsMpOI2KPUnVhSX+gNhgKD0uKK9ikPslsUmVU?=
 =?us-ascii?Q?vqzafrU1w7V2unZd3Xl3007JA0OKNGvy8ob4TsSkWp80I5vZ2U6fH+FaqWfO?=
 =?us-ascii?Q?iVckcqRGA5hfGhIvfx/7BKsaoFlPONNbWtCSxPfXCebLh2XqL+2pKNS6GkhY?=
 =?us-ascii?Q?8lP3AyagI9ywhyrhOExMmXfheQiae4X/6Cfloss7DDL/aRQ/ibkIH9Ykau/b?=
 =?us-ascii?Q?8AtfQ+x1MFiFCLqwzmUE4RK1ZM+hqpz4ucGKYusB1eO9/iYVeS9c2K4P9zbs?=
 =?us-ascii?Q?U+mjJyEUMFKvlXAU4/C0HcLeb4/hgD2OrihiIE80DFKUjbo3T9HVyp5rLZZN?=
 =?us-ascii?Q?CuiMOYqsiIoOhgJeJ3LGZLJqU+Zd0Sqzgiry98uPk7HL8zcfdjsFpYQxBXSG?=
 =?us-ascii?Q?B3/avu1tPN3SMaNRWdV5o5t8QfF90XKLYDbSmUt5GVazWKoeZWaCgQEeBOn0?=
 =?us-ascii?Q?1lmra6ApmYi5032rcGLrxkiJi+CJth6/La4KTuQ9GYmRzfKilNEt3sFCXBW7?=
 =?us-ascii?Q?/iZ1/Sgj67aSavaPDtiRM31FbbdZCrLdabbGHWQ4N8lmBx9qQfhezj/1Jy/R?=
 =?us-ascii?Q?YwTfN0kWwZ9JkyAcfaL2PG57uVUezzkWh/0QF7b73L2kiPs/hWa42j3PZmB+?=
 =?us-ascii?Q?Y0CWS35a2i2+IjZn9gYRZ4emK6Y+erAcWmYZwMbn7Xw/0CkkJ+nFTmcdazeb?=
 =?us-ascii?Q?4toEJOQ9on1SSZc=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 09:47:08.2573 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e3498ba-6b66-48b7-08bc-08dd1db69b51
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9225
Received-SPF: softfail client-ip=2a01:111:f403:2416::62a;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

During DMA unmap with vIOMMU, vfio_devices_all_running_and_mig_active()
is used to check whether a dirty page log sync of the unmapped pages is
required. Such log sync is needed during migration pre-copy phase, and
the current logic detects it by checking if migration is active and if
the VFIO devices are running.

However, recently there has been an effort to simplify the migration
status API and reduce it to a single migration_is_running() function.

To accommodate this, refactor vfio_devices_all_running_and_mig_active()
logic so it won't use migration_is_active().

Do it by modifying the logic to check if migration is running and dirty
tracking has been started. This should be equivalent to the previous
logic because when the guest is stopped there shouldn't be DMA unmaps
coming from it. Also rename the function properly.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 include/hw/vfio/vfio-common.h |  3 +--
 hw/vfio/common.c              | 28 ++++------------------------
 hw/vfio/container.c           |  2 +-
 3 files changed, 6 insertions(+), 27 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index e0ce6ec3a9..c23ca34871 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -296,8 +296,7 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
 void vfio_migration_exit(VFIODevice *vbasedev);
 
 int vfio_bitmap_alloc(VFIOBitmap *vbmap, hwaddr size);
-bool
-vfio_devices_all_running_and_mig_active(const VFIOContainerBase *bcontainer);
+bool vfio_dma_unmap_dirty_sync_needed(const VFIOContainerBase *bcontainer);
 bool
 vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
 int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index a99796403e..81fba81a6f 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -229,34 +229,14 @@ bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer)
     return true;
 }
 
-/*
- * Check if all VFIO devices are running and migration is active, which is
- * essentially equivalent to the migration being in pre-copy phase.
- */
-bool
-vfio_devices_all_running_and_mig_active(const VFIOContainerBase *bcontainer)
+bool vfio_dma_unmap_dirty_sync_needed(const VFIOContainerBase *bcontainer)
 {
-    VFIODevice *vbasedev;
-
-    if (!migration_is_active()) {
+    if (!migration_is_running()) {
         return false;
     }
 
-    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
-        VFIOMigration *migration = vbasedev->migration;
-
-        if (!migration) {
-            return false;
-        }
-
-        if (vfio_device_state_is_running(vbasedev) ||
-            vfio_device_state_is_precopy(vbasedev)) {
-            continue;
-        } else {
-            return false;
-        }
-    }
-    return true;
+    return vfio_devices_all_device_dirty_tracking_started(bcontainer) ||
+           bcontainer->dirty_pages_started;
 }
 
 static bool vfio_listener_skipped_section(MemoryRegionSection *section)
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 9ccdb639ac..8107873534 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -131,7 +131,7 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
     int ret;
     Error *local_err = NULL;
 
-    if (iotlb && vfio_devices_all_running_and_mig_active(bcontainer)) {
+    if (iotlb && vfio_dma_unmap_dirty_sync_needed(bcontainer)) {
         if (!vfio_devices_all_device_dirty_tracking(bcontainer) &&
             bcontainer->dirty_pages_supported) {
             return vfio_dma_unmap_bitmap(container, iova, size, iotlb);
-- 
2.40.1


