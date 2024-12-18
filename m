Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0AC9E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:46:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuN6-0002uO-6n; Wed, 18 Dec 2024 08:45:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tNuN4-0002iU-Ii
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:45:50 -0500
Received: from mail-dm6nam10on2065.outbound.protection.outlook.com
 ([40.107.93.65] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tNuN2-0006lj-8k
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:45:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pUg78tNw9qr2stUIJq6PubstnmGq9d1y4g7NYdiSgVWhWfCVuRpDew9EPOzBnSOfPMlAOxQ4XS3sNlh3Z1y9gjFRGVGG6RMnfweWii97sR8/kGdC6fCUKpeLRuK3Fg6q2/cbINB2qf1Whp+KgUWynKiFSIJ5kwZrifPoT/6dxqpE9N5pK0VEEB8Ie/wWJ2YtsVL9GcmiDbFy61I0M3ODsj1MVHzyMmGfSRnFdYukQCEdaAEi6paHvMwPJS3m0qn0SKmb+egCLAFqJLuHj852LpWbEv6yQUKljz9+DEPd/7+fMGpH9tahEEt9+3L/2hXOAGwd9K/OahExgc28eQb4QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Smv0sLtma52eJMuYfomE8BSkOIUNKfCuLJKL/tP8hJY=;
 b=E7LUlthsO3ZCfxlEv7bNQ8jb0WKBGvm78XU/X81PlZOdNbouK+4k9W5BDEsIK34Nf6ejS+XbF1EYhZ/vkFKuEMIBtEwHOnKoOU2Fp1dH+9u3lB6c68+leZsBxYqbSuUoVmsVkflhWcEjvTaHCDccXMNWkNFnri5KvIu5WCkftKOq+iv25nem994fLhGKfW/4ds5dZMuIxys+kMwkEFGAZY9GTqMwKalDiz3vSqPQs6BIDDdUu8bmDijKD44Y1JsiX3WgmTnBONAtfoFht7v+YCvpOM9iMjYChfaz69TYpSp/S18X7/sHgbnVN0OqzSPDVVbNxO16DqmhWKCgTDk4FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Smv0sLtma52eJMuYfomE8BSkOIUNKfCuLJKL/tP8hJY=;
 b=QNY0xi/oqDlk4VLPtAk4f/YFvNB8cvCxa3Rxqv1zRUmnn6rGb4em4aNr1JAXNCuqF/ic6c3Kxlka6ZFyeO1F87CI2o7P8Wu1AxWAj82yhv0+Ck7bfwzYJ1TyW6NXUIHVxNPYew7yl9ujG/4ihkxedBsjyCRfOQMWl/sWxmLXP+i9+KOpUVcZWfGq6tSl1G61GW8n7UYJBGMVQhSpKC8wfc49cUtjScK20rJLbLwR7wHTTKwdlNLi4+8Vorqb/eoD7T+36Ph5FogFSV+ePdh+eZi4P14VH3HgZvjwCdb1smVzg4pxbyvT+Q0weDbCbrXWheaifZ9jLgwcCrxUpD3Jzg==
Received: from MW4PR04CA0036.namprd04.prod.outlook.com (2603:10b6:303:6a::11)
 by PH8PR12MB6986.namprd12.prod.outlook.com (2603:10b6:510:1bd::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 13:40:40 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:303:6a:cafe::2e) by MW4PR04CA0036.outlook.office365.com
 (2603:10b6:303:6a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.23 via Frontend Transport; Wed,
 18 Dec 2024 13:40:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 13:40:39 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Dec
 2024 05:40:31 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 18 Dec 2024 05:40:30 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport;
 Wed, 18 Dec 2024 05:40:28 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, Hyman Huang
 <yong.huang@smartx.com>, Joao Martins <joao.m.martins@oracle.com>, "Maor
 Gottlieb" <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH v2 2/7] vfio/migration: Refactor
 vfio_devices_all_dirty_tracking() logic
Date: Wed, 18 Dec 2024 15:40:17 +0200
Message-ID: <20241218134022.21264-3-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20241218134022.21264-1-avihaih@nvidia.com>
References: <20241218134022.21264-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|PH8PR12MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a56682b-9df9-4119-b94f-08dd1f698f39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x6UtdJpcF1OJUKECuNGNSJ4EDWbmBhsBtzSzGaervQJCMmyZ9pXHR+k6WeFY?=
 =?us-ascii?Q?TtWbnvdQ9FnvlB4Acg+NJxqC0p3/rpOktTnshUdlL5oKjIKWG0jSqIHPwvSS?=
 =?us-ascii?Q?c51vaeWtXgAvX3JA+xdjZzdc8NPds1GqcvR98N7LRAOaJo2gHlT/asFRxQ5I?=
 =?us-ascii?Q?CtKBPAMbvtLhWCI7lE0FggOeVpIZ29lIpMScl0DUtAkH7S+t+NnXy2DaM8Lh?=
 =?us-ascii?Q?fQMcxocGpFHVS9lJVqDd4vh+SymEW5oqk35qcYInVRdQbVPF5wW/lhCHX4Kd?=
 =?us-ascii?Q?UaRXp6NeJBvVxIniw0GH2XQXS4O8YHQPGTEGkjQ61Us7/oKv+R1mTAdaiBmQ?=
 =?us-ascii?Q?Cq3wXDCEYEC4XK1GY/ONBwLlWjpXMPg2BucyDnF/0lEf5Hqj4xdb+XcERlK6?=
 =?us-ascii?Q?w8dFFcOc/5f+kyuh9hT1OHBdpaQPSL9NkD8FNF4Fs1e9o4BuD/kLjJ/O6DKT?=
 =?us-ascii?Q?7fqVp/zHDt17XTpV/dSzOIvfuuOCM4wZvGx4pVuWjvGayprfpaA+sMiRorgy?=
 =?us-ascii?Q?AWPkdK/iLEZB/N+f2rdyR+GHR+1sUFBxIHyLpeH9UGnEI/+GkO56l9BIq7pX?=
 =?us-ascii?Q?iJtxHbgC5VQS4pz9Mu+4ZAhxXvSUHzxUtSPGacyGT6rPgjfYy1YptwHIcbj7?=
 =?us-ascii?Q?tmPtHA9b6HSY2LV6cZNZRP3+HE8z/ySrqp4nXmPgwddPqvljCBiVMRaslfTP?=
 =?us-ascii?Q?y1tyjBmbwuyj/ic3D5jlnJd6Pt9SGrBjipqE3x7vh86Er/+9EvG7f3J6H825?=
 =?us-ascii?Q?kTMVHophtg+YfUQbF+zoiuP9ASP9Chxys4tQ64QGt/NeTnfwv6zuYnx8Fn4Z?=
 =?us-ascii?Q?KpofHRfg7pFAPWHXmUsfqV7PZaOiyHcsn3nESM19i00aGJmh/xtTDtcM6Dfm?=
 =?us-ascii?Q?FRjYjDFTrYHD4z4NwWDnh9OYJEdJCXmUGlHz6P/gykXWJ2OXPPCS2wPSFjEM?=
 =?us-ascii?Q?iCO6qVzNMpRxZTGSEqzpBu3tGbWBiaLga0vU8bx193M55d0xSmgzwDDGMzaM?=
 =?us-ascii?Q?AweOeSF3LXOlTJJuNaVb41rYCMj5sZNBmUu9cEEQTmHQ/zIoQfhgdUDLxo1a?=
 =?us-ascii?Q?ewj7sWzR8KDdvmuo/cWFHbmAqgYIYIq6k3HzMxac4KvLBPsCG2GT9H6qna3W?=
 =?us-ascii?Q?jb3SipwwsrKyMSwdYUxHaWCR7mf+2UK1LNRKL8IVLKIKC4LYRRZvUO7oHU+X?=
 =?us-ascii?Q?kBPlpDyr4QRts5uQa7JL/a2Czq0D2VbA4O4QajCoGvEjfhPNzEZjE8A0/vBL?=
 =?us-ascii?Q?x3NCes1op41EB1EWophlqce6fkPfgg0PTssqCyaTHA+93Sbv47M82H1YGgMg?=
 =?us-ascii?Q?B2jhbw6YdNxLuu+7Anx13uB+BbgUY27u1VPDyK8NaL2WbIaY1Nj7dvlh9WUD?=
 =?us-ascii?Q?2Jbz8gc6mC+AALYojPuwlNqku+H2E+FzV0ZWUM+YVB+MN5QpPjmNR3Sp4gAG?=
 =?us-ascii?Q?dT2w5qQBWMXly4vz0HbWDYh+kqZa09EgWI8l/pPSdwnVsdEZ0/hJaOlyuk7V?=
 =?us-ascii?Q?KSDkVyAr/7TLa8Y=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 13:40:39.0649 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a56682b-9df9-4119-b94f-08dd1f698f39
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6986
Received-SPF: softfail client-ip=40.107.93.65; envelope-from=avihaih@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

During dirty page log sync, vfio_devices_all_dirty_tracking() is used to
check if dirty tracking has been started in order to avoid errors. The
current logic checks if migration is in ACTIVE or DEVICE states to
ensure dirty tracking has been started.

However, recently there has been an effort to simplify the migration
status API and reduce it to a single migration_is_running() function.

To accommodate this, refactor vfio_devices_all_dirty_tracking() logic so
it won't use migration_is_active() and migration_is_device(). Instead,
use internal VFIO dirty tracking flags.

As a side effect, now that migration status is no longer used to detect
dirty tracking status, VFIO log syncs are untied from migration. This
will make calc-dirty-rate more accurate as now it will also include VFIO
dirty pages.

While at it, as VFIODevice->dirty_tracking is now used to detect dirty
tracking status, add a comment that states how it's protected.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 include/hw/vfio/vfio-common.h |  2 +-
 hw/vfio/common.c              | 17 ++++++++++++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index e0ce6ec3a9..6c999be398 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -143,7 +143,7 @@ typedef struct VFIODevice {
     OnOffAuto pre_copy_dirty_page_tracking;
     OnOffAuto device_dirty_page_tracking;
     bool dirty_pages_supported;
-    bool dirty_tracking;
+    bool dirty_tracking; /* Protected by BQL */
     bool iommu_dirty_tracking;
     HostIOMMUDevice *hiod;
     int devid;
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index dcef44fe55..e032ce1b6f 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -170,11 +170,26 @@ bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
            migration->device_state == VFIO_DEVICE_STATE_PRE_COPY_P2P;
 }
 
+static bool vfio_devices_all_device_dirty_tracking_started(
+    const VFIOContainerBase *bcontainer)
+{
+    VFIODevice *vbasedev;
+
+    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
+        if (!vbasedev->dirty_tracking) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
 static bool vfio_devices_all_dirty_tracking(VFIOContainerBase *bcontainer)
 {
     VFIODevice *vbasedev;
 
-    if (!migration_is_active() && !migration_is_device()) {
+    if (!(vfio_devices_all_device_dirty_tracking_started(bcontainer) ||
+          bcontainer->dirty_pages_started)) {
         return false;
     }
 
-- 
2.40.1


