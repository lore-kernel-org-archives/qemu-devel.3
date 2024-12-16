Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C5AE77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 09:49:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN7hE-0000YE-R3; Mon, 16 Dec 2024 04:47:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tN7hA-0000Xo-Bj
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 04:47:20 -0500
Received: from mail-dm6nam04on20630.outbound.protection.outlook.com
 ([2a01:111:f403:2409::630]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tN7h8-0004Mt-JX
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 04:47:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+0xmMEtpknwhR/RweUc8EEmFGeQiJuT6ARg5jXHpjayykuFVe/3wiZFZH1zMYQMyFiSqf4eh6k6jl3F6h8uCLqwVaQFvWreG0jxNMAfDD/I8LZ5N1KZUjMAwG/vOSDALNG5BXzKYdf2gPYTld8FbejMfmC4oKs+MZup83o1td9tVTD3+4RJ8PvobIcdkq6G4OR7a5YBg1wRZOA9Z4IrdPqIxmreBrfx55QYQgEqNnfOM7AOUkOQSBM51n6C6OnzpzuNP6Wd8464LIOqTddJvKjEp1GZsGnMJmtq04Psi6RRUw5JhSr0fuLBmD2oxqTBXoFKO+JUEK+D/Cb4vUCJLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6gkGDnKDmRM2MU+wMZK0oDong1qMUIksKsF56IspXZc=;
 b=YfzPm6bF7rHLO8P0Ua6rA9m0Keil3rXCbJoVVWjl7ZgJtU5xJKGa5HvpdYgDJAqXgq9zkCGAqyxzCvAZ3CuSfHS26iumzFqFwgqEgq30Kt4vJo1I9Qi2SSgGJkfhveL4UOGqMl6mMwjULT4vIIlVipYTc2mQOrXoNZRw/F+8jHPd4ewmAyaVcrz30Tr7X1M/aa7kSQQsDczPn3rihEO2vJKXQVvysSHmnitkqZFPbCq7/lOxijU9CBjhT7gj2MQwwaXRjr5NzLBxJh+Ax+Ma3AdCY9l7tFhcd8YlVEIUm0QQ/Q7wZelxVvLiIc58DMlzKsd0ZzG/3ZRZ4bXvhXWMgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gkGDnKDmRM2MU+wMZK0oDong1qMUIksKsF56IspXZc=;
 b=TdgTOkMiYRHslYAA4DGtujVodPk/npLj4wrr9pcyK5xyT7Ao3dDpv4DsdxBRs7xBklsJxtIZBfNWA+9+AVqcz1t+c6GvY4wNr3S/00wmZN5WzkrL9ar5KLZ/lbKv408i22SEVPSh5tZFjX//c9AItGaPSEFRpkiFZ/fIuIL0dhvSBlkk5YwsJ1wBnz7lntbe7Zcyayn7MkzxBFO2VOy4ogk9VvfCeO9n5m9Fwk79B2AWAd9w1pnlx0BXdLDLWf+Qi+9R/QWFA4PmnzbkUyd4eBJTrGgXI4AzX0WnKb1UKvMwvqIFjiQJUrba8r4M+lXYR8B5ouI0SQ1sy8VrY+ct6A==
Received: from SJ0PR13CA0105.namprd13.prod.outlook.com (2603:10b6:a03:2c5::20)
 by CH3PR12MB7690.namprd12.prod.outlook.com (2603:10b6:610:14e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 09:47:14 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::a7) by SJ0PR13CA0105.outlook.office365.com
 (2603:10b6:a03:2c5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.20 via Frontend Transport; Mon,
 16 Dec 2024 09:47:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.0 via Frontend Transport; Mon, 16 Dec 2024 09:47:13 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 01:46:55 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 01:46:54 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 16 Dec
 2024 01:46:52 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, Hyman Huang
 <yong.huang@smartx.com>, Maor Gottlieb <maorg@nvidia.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH 5/9] vfio/migration: Drop vfio_dma_unmap_dirty_sync_needed()
Date: Mon, 16 Dec 2024 11:46:34 +0200
Message-ID: <20241216094638.26406-6-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20241216094638.26406-1-avihaih@nvidia.com>
References: <20241216094638.26406-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|CH3PR12MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 2485c62d-962f-47ea-0dac-08dd1db69e4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GJNo0J3186EZtT47kU1u1kXqsvwER1LuL9Sqv2fTgQKJLdKc3Y5Gzmqye1KA?=
 =?us-ascii?Q?3WCy6iL85lEzoir46NdSJzlfK9wwQV2nq8mgYc3AxyMeF6noOgWrNfaKItAe?=
 =?us-ascii?Q?A4jH5Qd+Pr82mrZoz2UOeGm9lCSx5FUqXKTrxK+0k+pN1+7K2E8I4NAJV3RA?=
 =?us-ascii?Q?pnc0qLD4PH/A1lWYSX0QVlu6m+FoGTN945fNNmOfOOoBEPymJZnOcS0AF7CY?=
 =?us-ascii?Q?DhEK4SEuXbJKQI0+vWKlK58edA1WO0aNIV/XsQahKX1v3U2uWB2PbM2IoJi2?=
 =?us-ascii?Q?XioPu/hHW08Co3+ySbGEK8oqq0W8BG07Hmo85cODJDFaxYebPN6c1HCieOdi?=
 =?us-ascii?Q?eE6zRZuQJ1YM0E/AOKRDtWJI0SRFOh8p7B1y2lZW8k/0GxUfkcctIqIz+EWV?=
 =?us-ascii?Q?pX4a6ef/hSmy1EEDHUxDD3nMxxMxF0d24kWstTuhoMDyHcIyn+6dOot8T6Dz?=
 =?us-ascii?Q?FqhDxnYPZdea2jxrBg99vYAanfsXzQPNl3mquq9ocg484W16j5KbCoyI4L9Q?=
 =?us-ascii?Q?7MIRw8q59qmcaGMmvZQ7TG9bvq4xsjTC17f8P8Lysuo16QCzdmRjZKHBNo4r?=
 =?us-ascii?Q?3Cwmzw1ATPBYt30LIRcK/LudR2/BUxeVzCsDxs3JcTT+ysV3ma8Do5M9heKf?=
 =?us-ascii?Q?Yjb+aEuYpn65gGBZDNewev2XYlKRTPUpkm8RPL6RQBeR0fPHM/XuOGxTEqnE?=
 =?us-ascii?Q?VO5LLVRypmbunDF6YE6H66p77T3tKPjP83LadsfNTOE5tn3ZzGCIMBjexw96?=
 =?us-ascii?Q?5kM4rf1NTll4ee2kTl9+uTblriGiAxJh4ETBGHyyqNRqyAb1J8jts9R2FeCU?=
 =?us-ascii?Q?WdaYVuIAAWTcCCodanWo1OfzrmVaRQlDQd855cvyjrLO4Ec26rJIwEQ8HqVF?=
 =?us-ascii?Q?pA12GQAuuzDk7dgdPGtC1U2VyLsEedaY6R9vLYirxjEDaZwwimmUwKqmV+R/?=
 =?us-ascii?Q?Smlk5s196A5v39wToa/iPT5S/8komm8O7dwGK519cw0zKdxC6NEY1JnI72x2?=
 =?us-ascii?Q?igo+T5862uraCE3euUwDLQTU8nz06EHUo3algK8BBsIgM0vrpcDwm8/AC1Bc?=
 =?us-ascii?Q?rAp4p3TnAIqFitMRNnmXgjX/fg1IeT/NMAhc+Pvyv4CiDWY0xyUi8F52rxbj?=
 =?us-ascii?Q?5zRaPyMdx8YzE+ovRY4x0gOTcKgCSqOWI54S6sj7cDNSgPoKgyCV0K3qRCzC?=
 =?us-ascii?Q?Fj29PGUf24FwVWFwdlpe/Rc/YeGDWMQ+jzJ8IWELOEuKAZvUEuD7oiqSN0B+?=
 =?us-ascii?Q?4CdZ078dWCCI4U/RISTvqTC8ykXPiZqM054SO0PBVG1hgwwCWhoPZ518TxCP?=
 =?us-ascii?Q?HkpgfIb0WXZF9GxVhK9yzYg0ClIl4QKjLAR03zDtABjlmxVmFYUNh8ffC/DJ?=
 =?us-ascii?Q?EngEFGsZHaZ7XVafdJHW7s3Qpr8V3brY9FkQUZ3iS7E+E3Kqi9Px9JbUjOr/?=
 =?us-ascii?Q?li+RrLRY76rOiuY50Sdf4L/BfLrvNBe0CXucRevzRv9aKhOiEex+bDIjKyQe?=
 =?us-ascii?Q?gN1Loy3i+4dh6wY=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 09:47:13.3022 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2485c62d-962f-47ea-0dac-08dd1db69e4e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7690
Received-SPF: softfail client-ip=2a01:111:f403:2409::630;
 envelope-from=avihaih@nvidia.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
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

There is no need for vfio_dma_unmap_dirty_sync_needed(), as it simply
calls vfio_devices_all_dirty_tracking_started().

Drop vfio_dma_unmap_dirty_sync_needed(), export
vfio_devices_all_dirty_tracking_started() and use it instead.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 include/hw/vfio/vfio-common.h | 3 ++-
 hw/vfio/common.c              | 9 ++-------
 hw/vfio/container.c           | 2 +-
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index c23ca34871..c5aa606890 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -296,7 +296,8 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
 void vfio_migration_exit(VFIODevice *vbasedev);
 
 int vfio_bitmap_alloc(VFIOBitmap *vbmap, hwaddr size);
-bool vfio_dma_unmap_dirty_sync_needed(const VFIOContainerBase *bcontainer);
+bool vfio_devices_all_dirty_tracking_started(
+    const VFIOContainerBase *bcontainer);
 bool
 vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
 int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 45783982c9..6e4654218a 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -184,8 +184,8 @@ static bool vfio_devices_all_device_dirty_tracking_started(
     return true;
 }
 
-static bool
-vfio_devices_all_dirty_tracking_started(const VFIOContainerBase *bcontainer)
+bool vfio_devices_all_dirty_tracking_started(
+    const VFIOContainerBase *bcontainer)
 {
     if (!migration_is_running()) {
         return false;
@@ -235,11 +235,6 @@ bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer)
     return true;
 }
 
-bool vfio_dma_unmap_dirty_sync_needed(const VFIOContainerBase *bcontainer)
-{
-    return vfio_devices_all_dirty_tracking_started(bcontainer);
-}
-
 static bool vfio_listener_skipped_section(MemoryRegionSection *section)
 {
     return (!memory_region_is_ram(section->mr) &&
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 8107873534..15deffe3e4 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -131,7 +131,7 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
     int ret;
     Error *local_err = NULL;
 
-    if (iotlb && vfio_dma_unmap_dirty_sync_needed(bcontainer)) {
+    if (iotlb && vfio_devices_all_dirty_tracking_started(bcontainer)) {
         if (!vfio_devices_all_device_dirty_tracking(bcontainer) &&
             bcontainer->dirty_pages_supported) {
             return vfio_dma_unmap_bitmap(container, iova, size, iotlb);
-- 
2.40.1


