Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7D1E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:41:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuIf-0006gS-NO; Wed, 18 Dec 2024 08:41:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tNuIK-0006f4-Ql
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:40:56 -0500
Received: from mail-mw2nam10on20620.outbound.protection.outlook.com
 ([2a01:111:f403:2412::620]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tNuII-0004hL-Jm
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:40:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=llewC75EW5R+nLAckMZEQUZdDzb4aQcsZEWjWyUz0Fp6qGry+Xp+hSKOz4ooeTHaZDBilt0CDHOXjTNBmACJgqGT9mZdgyxQOxx7Aodi4lR3ZTvyEIVX7ain1aIG1dcgu0UBJOfXxUzj/Q4SjV8Pk/jbEHZDQCs06Cn0VCl+OKjqUcdOlEqf+/YbFaduo2iz/BxKaaFJkqOOafnRa5nHCQoumd7kOFXTGBCHOVq6bFVX+ShHpDbN4Rz+XtRMkDgXwKFiQuyxKfYqdn5mM0i/8ZlCPw5NK+S3QuGwp3OYYgS0zKnfu/pV56u2z31eloq6YmhjDuhTPEsgjv74mPKXCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DM4jKH5VoSupnigqCKHmVNpJHCChrXTI3MHzfuesa5U=;
 b=qZnMc7MmawnhfGXZA/u9+BDYoi75wcAabUinxnC0yqtzKYZc68/cBJkK45JvKAZ/urCPHrqYUSJOPgk8DQSzUGbZJST2KL+5THh8m8slcHyRWJhELJSJAlo7unD/h7jCV8KuR31IInHmK1xL3O5UoL+aZPfuSs/gXQqHm9fNYYaExAumTmXEZMuClZy7WxGj2dkhCwbzu9CUaQ239EBsLUKDgtcksjXHr2E/fUkiiynodrJdwtyMDuKI3VDjZwijfSFJwsYRTCpE6Wf0+1yCyfwEXhTLPMEyfBfGQd71RDHZlbXnNfEW7IvtQtPUrf8Ht5qqncYe0sARLU0WhpQ45Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DM4jKH5VoSupnigqCKHmVNpJHCChrXTI3MHzfuesa5U=;
 b=Lv/GQBwz2VHSB/Wnud877uFepyXMTrtGbnJlQBncad8r9HFeCafIhkxWEmfInVncTfZ3UVkMmQmExdJbyPIWsGPOd7bD7dJRAZ9xHs1yuFsEnJfssh+REurwTguseesYya+0hDwLG7CejvuZIb4GyYLSiPNCRwopjRrckuTnZb1gp+Shl4NFNG3fWG0POoaUNUPBxnE+Ylfjaz8hFBWNsnDC52TWxJRAQ5wsTKxgcqcapJ7hEgs4gXSqwfl8ZOYGBHnPbG1Sx2m/Mvx4w7snhq8sFxdDUBgkxSKcbgblDfXNBXcWpiO+p3iQkpmSHcXocQDq0UJuAYBS3l286AqlDA==
Received: from MW2PR16CA0049.namprd16.prod.outlook.com (2603:10b6:907:1::26)
 by DM4PR12MB6133.namprd12.prod.outlook.com (2603:10b6:8:ae::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.20; Wed, 18 Dec 2024 13:40:46 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:907:1:cafe::3b) by MW2PR16CA0049.outlook.office365.com
 (2603:10b6:907:1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8137.26 via Frontend Transport; Wed,
 18 Dec 2024 13:40:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 13:40:46 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Dec
 2024 05:40:33 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 18 Dec 2024 05:40:33 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport;
 Wed, 18 Dec 2024 05:40:31 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, Hyman Huang
 <yong.huang@smartx.com>, Joao Martins <joao.m.martins@oracle.com>, "Maor
 Gottlieb" <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH v2 3/7] vfio/migration: Refactor
 vfio_devices_all_running_and_mig_active() logic
Date: Wed, 18 Dec 2024 15:40:18 +0200
Message-ID: <20241218134022.21264-4-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20241218134022.21264-1-avihaih@nvidia.com>
References: <20241218134022.21264-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|DM4PR12MB6133:EE_
X-MS-Office365-Filtering-Correlation-Id: 19b22a8c-8306-4d1c-6764-08dd1f69936c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JsASmH90Ve2PAzPNNkzghpgDveruM59Txtbhc5GhvBMLR50C6foH7iZgyBKf?=
 =?us-ascii?Q?hpu4VyHlStMjy59lxaJcOO2kVJhoOZfjYTFkb7yDqlUyIIly6nvmj+c+yO9w?=
 =?us-ascii?Q?81CURcK2MoV1SjAKDF4+C93KpccBS+y1x8MmCNv/YaQX17pkam2UYTbPDq+P?=
 =?us-ascii?Q?5xPOhGnj4622+/hZY4PYj4l1CphZ0oOlx3QGl+KdN//llsun1Fb2qak+rHuh?=
 =?us-ascii?Q?Ou5HtHgHMvocnSo+hjYziMI2EL5TYFWW7TEuokNCdneRV4WUxWjn7+4WV0zb?=
 =?us-ascii?Q?gFQQYh3fXmBszBlCVCpY93Zd0efKarGkoqfA+FksJYz0MNb1XMJ/zgepaUbf?=
 =?us-ascii?Q?DaUH2Z6vmNYP9EKP64oKBV6+JXN5/wdGvcUVqkFwkYV5oFSvD2aLOS1E6zC9?=
 =?us-ascii?Q?Abm/3VGx8HDIiYBo8M8nID3+YzzMW5ciJu9+oa6t2LCtRqQRzPR0LPoeDkmQ?=
 =?us-ascii?Q?C0L9knXOl9NCHT/SXuT52N+zkSsyn+OYlKf/lAxJXP9WLuzQf7sAZr/lORZQ?=
 =?us-ascii?Q?qPeRD0yfeOxqh9J9MMkW+7f1FXOa6tsRHMyaXS0IyMxiAx3dE0BB4d6E0Ttk?=
 =?us-ascii?Q?EOQYRFXvmU0dbQr/WK51qkgP8Y5AtSiYTv8Yr/KLpakO8sB1HCDq+0je9qNO?=
 =?us-ascii?Q?4BXZjqYZAMx2MTWuymoNMosUx9Bt9DxZH9BFAnT5XpDOvwFuEeMnoPM2UQEr?=
 =?us-ascii?Q?bm4qdCoABjLBaaYZ5aG4oEO+GxbXf18shZDA1CEMV7RD5rIveu13o6gGZo71?=
 =?us-ascii?Q?2MPEq78Wf68M0CfSfFBqce2r1w8Iv6SJ1b8wzaycBdvPix6ZVDGOvIwfXIBC?=
 =?us-ascii?Q?Cg5A+XvcNBjttFoKWpt6ihlvGNRuZnaW14MJMrNdV4xngjddECBWhOY1JoFV?=
 =?us-ascii?Q?q70t7QuVUEfwRybB0E7rSRol5zPbbl6kUzz5ERwviWvZOv6Mw/KzW7vA85Mf?=
 =?us-ascii?Q?4YZX2EXtGW9/7WHIPfv/AT5IvUb4cPFvgtXm4BnZ/+op8fzVyl2x6mJ9siaC?=
 =?us-ascii?Q?PCi5BbW0cHE7siNez+VxtkhWJNeoQlNSNYZALrfoIYyYzmNvomu5gD8W6jx+?=
 =?us-ascii?Q?lTOZ9uN4axR4J7d4TaPMup+eh51Qoua3n5wHwCCiuCsO48CpH0Ro/M1IZJF3?=
 =?us-ascii?Q?CbF/q44cZ3LCuhTSnEyVtPHD/WTQ4beGeFavpoGgeUoaAcmSi7LPjbmhdRjM?=
 =?us-ascii?Q?j/AELs2voQr8cLh9pv6Luxylt50ym+fAkmvOG8fpBWRyxdufOXvekiTEVBch?=
 =?us-ascii?Q?cLDNl3AiuUso7e7/chYTWnxGKA1PtazIrIpEJuP0V0G5lF2ea9iuwa0Z9diY?=
 =?us-ascii?Q?hsitjzRALbUXiiOH38XPvyJT1H5lW8bZa8qT0mjB6uupUGuks5spHwrjl99a?=
 =?us-ascii?Q?QOtZNdgVx74iuhsl9r7N6TKWt1UE/Qgetp0gekirjnSgoeahmzTCzJ3LLwRM?=
 =?us-ascii?Q?KWkY04zlLMETcH8cDAeD4Yfj3H+acl6R44/yGPDOFIU7MwFeDGIdp7NMIzNy?=
 =?us-ascii?Q?krb6RnFtWG6QwAE=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 13:40:46.1548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b22a8c-8306-4d1c-6764-08dd1f69936c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6133
Received-SPF: softfail client-ip=2a01:111:f403:2412::620;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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
logic so it won't use migration_is_active(). Do it by simply checking if
dirty tracking has been started using internal VFIO flags.

This should be equivalent to the previous logic as during migration
dirty tracking is active and when the guest is stopped there shouldn't
be DMA unmaps coming from it.

As a side effect, now that migration status is no longer used, DMA unmap
log syncs are untied from migration. This will make calc-dirty-rate more
accurate as now it will also include VFIO dirty pages that were DMA
unmapped.

Also rename the function to properly reflect its new logic and extract
common code from vfio_devices_all_dirty_tracking().

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 include/hw/vfio/vfio-common.h |  4 ++--
 hw/vfio/common.c              | 40 +++++++----------------------------
 hw/vfio/container.c           |  2 +-
 3 files changed, 11 insertions(+), 35 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 6c999be398..d5f542beab 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -296,8 +296,8 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
 void vfio_migration_exit(VFIODevice *vbasedev);
 
 int vfio_bitmap_alloc(VFIOBitmap *vbmap, hwaddr size);
-bool
-vfio_devices_all_running_and_mig_active(const VFIOContainerBase *bcontainer);
+bool vfio_devices_all_dirty_tracking_started(
+    const VFIOContainerBase *bcontainer);
 bool
 vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
 int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index e032ce1b6f..2831f674ff 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -184,12 +184,18 @@ static bool vfio_devices_all_device_dirty_tracking_started(
     return true;
 }
 
+bool vfio_devices_all_dirty_tracking_started(
+    const VFIOContainerBase *bcontainer)
+{
+    return vfio_devices_all_device_dirty_tracking_started(bcontainer) ||
+           bcontainer->dirty_pages_started;
+}
+
 static bool vfio_devices_all_dirty_tracking(VFIOContainerBase *bcontainer)
 {
     VFIODevice *vbasedev;
 
-    if (!(vfio_devices_all_device_dirty_tracking_started(bcontainer) ||
-          bcontainer->dirty_pages_started)) {
+    if (!vfio_devices_all_dirty_tracking_started(bcontainer)) {
         return false;
     }
 
@@ -225,36 +231,6 @@ bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer)
     return true;
 }
 
-/*
- * Check if all VFIO devices are running and migration is active, which is
- * essentially equivalent to the migration being in pre-copy phase.
- */
-bool
-vfio_devices_all_running_and_mig_active(const VFIOContainerBase *bcontainer)
-{
-    VFIODevice *vbasedev;
-
-    if (!migration_is_active()) {
-        return false;
-    }
-
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
-}
-
 static bool vfio_listener_skipped_section(MemoryRegionSection *section)
 {
     return (!memory_region_is_ram(section->mr) &&
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 9ccdb639ac..15deffe3e4 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -131,7 +131,7 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
     int ret;
     Error *local_err = NULL;
 
-    if (iotlb && vfio_devices_all_running_and_mig_active(bcontainer)) {
+    if (iotlb && vfio_devices_all_dirty_tracking_started(bcontainer)) {
         if (!vfio_devices_all_device_dirty_tracking(bcontainer) &&
             bcontainer->dirty_pages_supported) {
             return vfio_dma_unmap_bitmap(container, iova, size, iotlb);
-- 
2.40.1


