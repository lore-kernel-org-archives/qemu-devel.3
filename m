Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B36EB5956
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 03:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq0Z1-0003u7-3o; Tue, 10 Feb 2026 22:06:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1vq0Yz-0003tq-8W
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 22:06:49 -0500
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1vq0Yv-0004FG-Kd
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 22:06:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OzmUpwL8cEXa/j/t8KN1PhpWJEmL7SgUVhtvcPCRipGgzk+mOWhC15A9Yskb8wg7ZLybtSVS/9nqLbo6ecdPokro/KiSBaIOMEcKOPyIl/3sl2gTwFwvzSY1o0Yh+bTH7Mk0qu0Qz3t6Bfyq8R74U5whhv8iFL5Q3IZQUiYffNX+CfPn9Y1BcU+zPen8NkM8tMyX92aNCiGAa5tCxfcHmsv/gstVwGTj4t/g2NlHbUkISzCGNqjhpwVW+PN/2ZUh8b2KXJuE9qreYJpAsBSMu6WvYP2c2oerFPh3jgCtJSp3VAbO3Btk9WxZfII96wPk4++QL2HlbaCbl6WJty9fmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opOlXl9Jtzv/LIxeQsJ76iIHrq/JKxqomzYHxMl20Ro=;
 b=vTdvekvpBl60GgwDyfBSvqdyHK51QFT/awF7c3NRIfQzFg0NlHI5pttx3Q83CornJ3ztW8+07ZibXByHChRCL5eHhJc+aF4lUTOUBNS0yaT/kb3KJ9oepltDWOrl2PPYLFEo5Ro65BCegpoLsotfCE14esrgqZQpQbsY/Ju0a1bzZzA/azeUznBd+0NkodLHCiZ6/4/CPg4poVNxq7uwDH7c16JEVU1hl2sBFOmTY1nUGeCd8hVRKja2QvR6witXGSacw0Vz1HaQTZUWwbBd+urW45ALvO6t9ZJU80fpaFBnGr3Z7jz+tDsgt4f6ULBDFVshGGHm4iOi/wqfTSCmOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opOlXl9Jtzv/LIxeQsJ76iIHrq/JKxqomzYHxMl20Ro=;
 b=F6ERtt/v6+koiXJ5gtknBT1GjBVZmSSoQIxs6P1Kup7NGEL4sPVUv3YUZofLKVvdgodVb81aQ2Gc1HwhzJgXdfijuPLMJTBjUmhZX3uSTDDyJ8CEa431Od7xaFX16KHJFCxh6ghYMrZlf+Xxi84NByAS/pkoNQu/f2GXR/FI75c2jBmCaViHgxF172lZ388J203tpUitCISI/zqW3mKC6CLjtMJEpgtKvOgdA2nKzFHoO2Xvnpzo/BoYheIaD/vI2rZeAB5ZkC50CK1OeAm0wir0SZN3zh/9jra3pQU0R6CFQbQYwqszYD5l1kpO08zLY3D6Wouxq/PyeLgWIek6pQ==
Received: from CH0PR03CA0084.namprd03.prod.outlook.com (2603:10b6:610:cc::29)
 by LV2PR12MB5725.namprd12.prod.outlook.com (2603:10b6:408:14c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Wed, 11 Feb
 2026 03:06:37 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::fe) by CH0PR03CA0084.outlook.office365.com
 (2603:10b6:610:cc::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Wed,
 11 Feb 2026 03:06:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 03:06:36 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Feb
 2026 19:06:17 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Feb
 2026 19:06:17 -0800
Received: from localhost.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 10 Feb 2026 19:06:16 -0800
From: <ankita@nvidia.com>
To: <ankita@nvidia.com>, <vsethi@nvidia.com>, <jgg@nvidia.com>,
 <skolothumtho@nvidia.com>, <alex@shazbot.org>, <clg@redhat.com>
CC: <aniketa@nvidia.com>, <cjia@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <zhiw@nvidia.com>, <mochs@nvidia.com>,
 <kjaju@nvidia.com>, <qemu-devel@nongnu.org>
Subject: [PATCH v2 1/2] hw/vfio: sort and validate sparse mmap regions by
 offset
Date: Wed, 11 Feb 2026 03:06:14 +0000
Message-ID: <20260211030615.3202-2-ankita@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260211030615.3202-1-ankita@nvidia.com>
References: <20260211030615.3202-1-ankita@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|LV2PR12MB5725:EE_
X-MS-Office365-Filtering-Correlation-Id: 90f74dce-a66f-42bb-c9d4-08de691a91d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CE6rp+46wiZXauL9NIbXaPZu50lfMc1fENxctReB1h1bf8yQVepkvgzylX3L?=
 =?us-ascii?Q?rsbLGLSmY8zdvFzKRxO2z+HpXqP7wXDa7C2FRyJ14Q0rbJ1KxIR3ItYY83pV?=
 =?us-ascii?Q?rw8tMr9hLlr0nZhw5yui7w5coHlimpWnsNBt3ptdDsxfBvjnxxZd35RO/QVg?=
 =?us-ascii?Q?snKhiWh74D8DB1Pyy33jdhCyv5oWZtsb0slrlUXawl51EPrE2Wl33HNVlc8f?=
 =?us-ascii?Q?UL0EKclGrtpSCe7ZXGgWblOF70Hzyo3RRjiw4gPQcAu5mVLv/7aj22ncmJ06?=
 =?us-ascii?Q?m4E7liAOSQ+XOIW5L704l/Q1WoZmJeLnGNyC32mp+4cf2Q2dfkQ8Y7oYy3cv?=
 =?us-ascii?Q?o5Wn/9MNofS0TCNo6TujiquiFc/ouGKwr9A07Kjr8z+FVyYD0RbirG+gXOA2?=
 =?us-ascii?Q?hrXR6iUzG6iaIACW0H+D/iqRSluSQjXB5hC3gr6TaS/QJGdSgAllxqK0ytZ+?=
 =?us-ascii?Q?Skvmclf7Tx3h0FMJAQmaeJ7QrJl7lE36vQjGStyNjndF3Iqqzb/S/Kh6EJHB?=
 =?us-ascii?Q?y2igmF4o6RejpuxHOdE5QcPwHrXXGPL6bVRXVHWa2D8CXCIM3KPNUfVS6JeH?=
 =?us-ascii?Q?FrhQTdzpgWJTRonfQpJcE+nso9R/6NV7SPsHRvUDuWJZzfMvb1PKZKad8Es8?=
 =?us-ascii?Q?50VjfZroAW+iKR2lLF0UGNyISfbHDhn4sZEkDsLqYLwEOcXJGb5uarpv2J++?=
 =?us-ascii?Q?cSfk4LoTwZkDQpMJFAaqSL8zDvfPNwKQ52CU16PhDUvbgACCfCI8KfED4sz1?=
 =?us-ascii?Q?vEA5LnFdGJn29Lyasi3HogEZR/LmoVyRJsY/3PO/zkc6GZjk7h9/vloDs83l?=
 =?us-ascii?Q?raKPAywx/7IPJ459aU1+Bli0o4JUZrCVl8QtZaLDO4+7uLG+kG35hC0qntdh?=
 =?us-ascii?Q?JqPC1qpgBVqH5sGxmKYPCjLE6/zMKsfJJppEfU7kuytfa69z55aMmL+8TwO5?=
 =?us-ascii?Q?s49oBogOUFVb2kAJTQ2WCJGRz6v71P2ov/m/aXwxjgAQi/4Gy/k59WzV5+S7?=
 =?us-ascii?Q?7F5dq8mVewdy0dDHRsq0GDL520qzEbhatE1wcFhFyzih2KjYSvHr/TyFMRBL?=
 =?us-ascii?Q?SeCy63ItPElQVDH3XHRbEcpbOp+nmWEIfhcxjaO5UwbF/NhszKE51RVMoWZE?=
 =?us-ascii?Q?pmJ5j3PhGW2+095ae1FjMrgLTsURU1ay1B6+CaADY0mb8cQZhoVTXzV+TVCM?=
 =?us-ascii?Q?kuQFVfGsftHZLkPmVNxfsbp+94lpS7ZP8gHZcyzuyGo4h/Ji0YzFuRldN7/i?=
 =?us-ascii?Q?iY0QPgCw1qG9yF6gyZgM/xsHnJNDnSAdoV4NJXUE59hgoUJ2ZvJYtpzSVrox?=
 =?us-ascii?Q?5ngFnTtmHfVeHcYiiLTDCKsgM8gD1YI4VZ0LLay7GjmVY7XA5fJiJNutmafm?=
 =?us-ascii?Q?VKzQRqTpT8FrFe7nkUoIFwGzLIuH+7rIHedT2Oar4Ax91u4CibAGSumyw+hc?=
 =?us-ascii?Q?v9Ib20RNe61+239lj++a6z2P4y2GqfCSR1PSYuyk3K45bwkqhKG/CRoipNQk?=
 =?us-ascii?Q?uhUkhZMHrsW6z9z6JPSRl7ofkU5qQAR5sSiRGMPczBH8OiTzl8VcCzJ9LIn2?=
 =?us-ascii?Q?sCvG/YVDLR2NCjoWSzrhKJYHVgT+lDdJo1xDfQTQ4i28OirGHwVOQlTCWZJh?=
 =?us-ascii?Q?A5YoU2x3aJO1BmM20CrLg28at2hH4hQfH9RG9jBkX4mWkrtOtJOJamvZJS3H?=
 =?us-ascii?Q?+NgN+Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XFplIeyCfviqqSnDrxtjK9lQaYvc1n0WEm1v0LLAsJLCNCFmYol6n1q1SYsewVrgpguogYJrSpbkzgdz9cqMqFhw8u5se1UP9t4NVnnLE2Ih1mYYvqLstqQx5dBbzxO5pWRibrLkXLtoU2EsfKqMZInCXY/RqIZEXbdQZBJUD7vt1ZBlp2u6t/+M3ob0DceXkhGFGw9k33C4oVb6Ked4sZuUGm1+AIz+06ZJOZ1i3nHY4KPC14nKP6Yk6n2Xd7t/x+ou9oSTMGuW0cKvZFvuAUxhe0+uZKEWrSyAhpGGjJH7tWcwYGwI61wekblWEn9TjKJC8x4HJw3OidK4R8ZLovCnzkgaYII9Ws2RRBdEN4NUsEJwWCZP9IiB+u7w4hHwOb8ZoO/mjs8Yid3jgEly6MI/Pezm2nDK/x30lCQTY2oaIzETFW55zOvpiKcRpUEt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 03:06:36.8369 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f74dce-a66f-42bb-c9d4-08de691a91d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5725
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=ankita@nvidia.com;
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

From: Ankit Agrawal <ankita@nvidia.com>

Sort sparse mmap regions by offset during region setup to ensure
predictable mapping order, avoid overlaps and a proper handling
of the gaps between sub-regions.

Add validation to detect overlapping sparse regions early during
setup before any mapping operations begin.

The sorting is performed on the subregions ranges during
vfio_setup_region_sparse_mmaps(). This also ensures that subsequent
mapping code can rely on subregions being in ascending offset order.

This is preparatory work for alignment adjustments needed to support
hugepfnmap on systems where device memory (e.g., Grace-based systems)
may have non-power-of-2 sizes.

cc: Alex Williamson <alex@shazbot.org>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
---
 hw/vfio/region.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index ab39d77574..177494c379 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -149,6 +149,19 @@ static const MemoryRegionOps vfio_region_ops = {
     },
 };
 
+static int vfio_mmap_compare_offset(const void *a, const void *b)
+{
+    const VFIOMmap *mmap_a = a;
+    const VFIOMmap *mmap_b = b;
+
+    if (mmap_a->offset < mmap_b->offset) {
+        return -1;
+    } else if (mmap_a->offset > mmap_b->offset) {
+        return 1;
+    }
+    return 0;
+}
+
 static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
                                           struct vfio_region_info *info)
 {
@@ -182,6 +195,34 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
     region->nr_mmaps = j;
     region->mmaps = g_realloc(region->mmaps, j * sizeof(VFIOMmap));
 
+    /*
+     * Sort sparse mmaps by offset to ensure proper handling of gaps
+     * and predictable mapping order in vfio_region_mmap().
+     */
+    if (region->nr_mmaps > 1) {
+        qsort(region->mmaps, region->nr_mmaps, sizeof(VFIOMmap),
+              vfio_mmap_compare_offset);
+
+        /*
+         * Validate that sparse regions dont overlap after sorting.
+         */
+        for (i = 1; i < region->nr_mmaps; i++) {
+            off_t prev_end = region->mmaps[i - 1].offset +
+                             region->mmaps[i - 1].size;
+            if (prev_end > region->mmaps[i].offset) {
+                error_report("%s: overlapping sparse mmap regions detected "
+                             "in region %d: [0x%lx-0x%lx] overlaps with [0x%lx-0x%lx]",
+                             __func__, region->nr, region->mmaps[i - 1].offset,
+                             prev_end - 1, region->mmaps[i].offset,
+                             region->mmaps[i].offset + region->mmaps[i].size - 1);
+                g_free(region->mmaps);
+                region->mmaps = NULL;
+                region->nr_mmaps = 0;
+                return -EINVAL;
+            }
+        }
+    }
+
     return 0;
 }
 
@@ -213,11 +254,13 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
 
             ret = vfio_setup_region_sparse_mmaps(region, info);
 
-            if (ret) {
+            if (ret == -ENODEV) {
                 region->nr_mmaps = 1;
                 region->mmaps = g_new0(VFIOMmap, region->nr_mmaps);
                 region->mmaps[0].offset = 0;
                 region->mmaps[0].size = region->size;
+            } else if (ret) {
+                return ret;
             }
         }
     }
-- 
2.34.1


