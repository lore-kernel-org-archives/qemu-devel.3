Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F10AD0C85E
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 11:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfcjm-0002pg-J9; Tue, 13 Jan 2026 06:39:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vfcjd-0002hL-8Y; Tue, 13 Jan 2026 06:38:53 -0500
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vfcjb-0003na-OQ; Tue, 13 Jan 2026 06:38:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d7fCLcN+8DdDk5nhA51hQYdaYOjdckBIYNd7UdLt2UGgjGX7AVETkXSIRxT6p7f6bgCASzNCDUZJKFKNa9YSFxKJnki2SZIU3LuFwSAajSmfQWMXIe7fKG1eN8A+um1aRz0eddyOxrkwEpR74zUGKNY6vwwA7khEYNnDD5TezrPNsqjVuf9ZHn3v4hConY7hxBae0jnUGs1LToLbEbDia3rlJh2lZ7/0Ubl6btOZJSDtbPQr8jM1pH2GZqiQ8eZCxQkdObdsONjpRm+Mniquk5/R0dsAAlPw8OPhhaEjinugS3Bk0HX7gScbGle1Ng8aLF19h6SSjUVzwboCCOVIIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEA7tJ1YSyyXldZyMsnV4J3+ftw34QpZQzhveWopWOk=;
 b=ZBZm4JzSrY9W5Ej2Q5zoHmVP5xRuiaiw25FdTjgfVk09VlVEYRRZzEoDNzcXI1Kw6M133hWl6B/ZGhqkm4F2pqxKCMLHW9l88NUaYiQAYaM5cngmDxpTDTDUlJKJUuvuRYSSXo/BRW/6hLjRmXCZYT42NQPsIE5UWt2fX/yZBzHeO1TNtv378/+uwNsj+Oxk1UOVKlrsuLSjIu7sLsQZcAR1cssCo0jMhuVJuUVZntkTUI9sDMs+wLhJtnk2rtkbiTjZgEc3RNA6TIaNrAd3qt074FUJqoN6cnU1IWTNgiCssgsRctpuFuY1ZhElz64/+evLYaI9czVdIFglYPAm8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEA7tJ1YSyyXldZyMsnV4J3+ftw34QpZQzhveWopWOk=;
 b=R4t1H8YVBN30Bh0z+4uNJiYHRIGOQL5g+V9YlVkfQwpWyor+4DU7VEtJhO6N81L6rvAfqLHuZgcY1OjCMVHtv6OEgbmeFBz4wuROV+g4KVu+tecC/p7SIqm/IXLmGvn8H1NQzK1Fc/5eQQ1iVh/UsKEekn0UGbJ1phV2afShRmIuEoEqBR46WknuGmZ639nD/rjDwWCsyl+Vp65ca0lEQvkU4GG+yX55KctaXfofW1RVb8aWwiWe4S5GIwv7fE6YGtm9+bNkq21IEdZi4YSFahRsgpTRNjozLw51jiGivi+keGoq9ApTjDXYGEstbnYGeWVRqJB5QEcXZ0hlZp8HGA==
Received: from BL6PEPF0001641F.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:f) by PH7PR12MB7284.namprd12.prod.outlook.com
 (2603:10b6:510:20b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Tue, 13 Jan
 2026 11:38:43 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2a01:111:f403:f903::4) by BL6PEPF0001641F.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Tue,
 13 Jan 2026 11:38:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 11:38:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 03:38:28 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 03:38:25 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <alex@shazbot.org>, <clg@redhat.com>,
 <cohuck@redhat.com>, <mst@redhat.com>, <nicolinc@nvidia.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jgg@nvidia.com>,
 <kjaju@nvidia.com>
Subject: [PATCH v2 3/4] hw/vfio: Add helper to retrieve device feature
Date: Tue, 13 Jan 2026 11:37:53 +0000
Message-ID: <20260113113754.1189-4-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113113754.1189-1-skolothumtho@nvidia.com>
References: <20260113113754.1189-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|PH7PR12MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: 66cedd20-d2c0-4c0b-f2d2-08de52984e26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EOomNfSPzXtfIY9DRXTSqTddzaRGH6lqkk/G75D2QQs3qwEpKxWZ2aOH2ksu?=
 =?us-ascii?Q?yTjflxMAiyi3hNXDCY+bIf0BMSxzLPga5mn67GFCwhDxRfZ3vroVNNZ3Ieq9?=
 =?us-ascii?Q?t7yQAuOkppekUWW0DzlzYWeAU0i8ZYx9CulgusQUvtO76Jsac9f+sg0/7Hbi?=
 =?us-ascii?Q?p8MbqZCV1eWp904Mj09Ak2oqJBLGGxNX0RNzgqiaHo4waMa0gRh/Z5+qBHBr?=
 =?us-ascii?Q?IaSg8798QkZcKw6FtFojKqjxegmhgC3zB+wiIRh77Og1L8u0a51eZPbkOwdh?=
 =?us-ascii?Q?QEAU2iIAx7T9bgeE0JTpyhagXozo6N3iVCLld8DiimxlHQ5O5/28YdsD6EpQ?=
 =?us-ascii?Q?xid4SBRz/CFadVdFSar4HreyrtVzm/23xhH5HTPlSbdIDs1RvfOuQ0BfbVuk?=
 =?us-ascii?Q?e/Iv0rmY3B30uFr0ASxdxJiT0bsHHOEZ3aw6mA/JqVQUPGYsFVH/Yb17bhFt?=
 =?us-ascii?Q?R1b/WMrbcXxG3HUuFWaPgZdFAL9PYGmZ9B9V7eFUYJg40G4PQVnASIxIY/Iy?=
 =?us-ascii?Q?cedZA8vrdXaDPy/U5vIRqYzm6V6IspKkMJThjtB7GITCaPeQmfn4eZszAWjp?=
 =?us-ascii?Q?rou5qRJ2ExDlq1h76j9yiKDwRsEnwzQOcXEy19i19maXkoexZS6tydKdwh+h?=
 =?us-ascii?Q?aSSUbTjRmXMT3nIJEpt22eSnFQstLrGvbUTdzzNzTrwCi1rxmTwxNVNpQEgw?=
 =?us-ascii?Q?oWzrgjoil8BVuZOXt2S8CMdR+atuzm8XNmuN/jxSFRnYIg3USzLe1u8tLZbX?=
 =?us-ascii?Q?LYjGBt0F+WehX7cT8rLco4ceyLng05Fmt4dMbbqX+D9K5dL6EjIbM9nlP+Ne?=
 =?us-ascii?Q?g0qMppVPIFgC7mteYwKbwsdhpshbpfTIg1sQ4wrivqKnfOCGCBGI/RuOGClx?=
 =?us-ascii?Q?kMZgoxIShwpbB8ov4fj4MEwsx9E3LpC205M4sny1E7TfQ2sfUc1g3lT1Hxjx?=
 =?us-ascii?Q?aslU0pSR+UPu1Ne1K6mkKSQN0wgFu7FnwPlRAD6P/mP9vr++/Z43N3+j5Nkx?=
 =?us-ascii?Q?eOjoR8jWaIRjOxj7+/jBfWgGubjZusbxA3DqUrkkdBpVNR6jbf4Z0CAHE6G+?=
 =?us-ascii?Q?1HwHdzPOZbXygSoyiDcOstoZlwj8SaPwHKMLVjF4IJfalz9I95cRXBBF1oaZ?=
 =?us-ascii?Q?GO1BKvcbLTMa7xyU65gywf+ci2cupIgcgUyx8bC7FUo55Lrw/ba03qEJVx8n?=
 =?us-ascii?Q?mt3/KQ20DEhgHKO0/q8HUGea9AU02KDDI6V0J+wmyO6fsHE3tCRjmVUggjix?=
 =?us-ascii?Q?XBK3JGYHJgyxlj0tYqWblSZvu44IUh+Do3H40xwlx8e3ULSNZWqox4ZFc/E7?=
 =?us-ascii?Q?tDVVOisufRuWpN/CFvvd6GWlR1w+fHQuamTCoL1om80z3/1WgGfO+e449SCz?=
 =?us-ascii?Q?wpOb+Aijy0orYt1pi4LUSFfqxROgWfcKaqpBctkqPWk+McSKyuiKfVWRj97e?=
 =?us-ascii?Q?9fGlPMVRmHwoykbmxozGUOYnW7n/PyfQoeRfPaaCAHmhxkXZfnDctFUtRnHq?=
 =?us-ascii?Q?xcDmLIpsOI75hllvp6Lms78G6ppyAZXegNM5f4c+Ofi13QYLA+PWiV2a60Pi?=
 =?us-ascii?Q?Dsd5ff/SluXyuc7nJVk=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 11:38:43.0878 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66cedd20-d2c0-4c0b-f2d2-08de52984e26
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7284
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Add vfio_device_get_feature() as a common helper to retrieve
VFIO device features.

No functional change intended.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/vfio/container.c           |  2 +-
 hw/vfio/device.c              | 10 ++++++++++
 hw/vfio/listener.c            |  4 ++--
 include/hw/vfio/vfio-device.h |  3 +++
 4 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 5993d90545..b0cbcf0f4a 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -208,7 +208,7 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
     feature->flags = VFIO_DEVICE_FEATURE_GET |
                      VFIO_DEVICE_FEATURE_DMA_LOGGING_REPORT;
 
-    return vbasedev->io_ops->device_feature(vbasedev, feature);
+    return vfio_device_get_feature(vbasedev, feature);
 }
 
 static int vfio_container_iommu_query_dirty_bitmap(
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 100532f35d..0d9f42a1f0 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -516,6 +516,7 @@ void vfio_device_unprepare(VFIODevice *vbasedev)
     vbasedev->bcontainer = NULL;
 }
 
+
 bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev)
 {
     VFIOPCIDevice *vdev = vfio_pci_from_vfio_device(vbasedev);
@@ -527,6 +528,15 @@ bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev)
     return false;
 }
 
+int vfio_device_get_feature(VFIODevice *vbasedev,
+                            struct vfio_device_feature *feature)
+{
+    if (!vbasedev->io_ops || !vbasedev->io_ops->device_feature) {
+        return -EINVAL;
+    }
+    return vbasedev->io_ops->device_feature(vbasedev, feature);
+}
+
 /*
  * Traditional ioctl() based io
  */
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 7af0107535..d00fc87f3b 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -879,7 +879,7 @@ static void vfio_devices_dma_logging_stop(VFIOContainer *bcontainer)
             continue;
         }
 
-        ret = vbasedev->io_ops->device_feature(vbasedev, feature);
+        ret = vfio_device_get_feature(vbasedev, feature);
 
         if (ret != 0) {
             warn_report("%s: Failed to stop DMA logging, err %d (%s)",
@@ -984,7 +984,7 @@ static bool vfio_devices_dma_logging_start(VFIOContainer *bcontainer,
             continue;
         }
 
-        ret = vbasedev->io_ops->device_feature(vbasedev, feature);
+        ret = vfio_device_get_feature(vbasedev, feature);
         if (ret) {
             error_setg_errno(errp, -ret, "%s: Failed to start DMA logging",
                              vbasedev->name);
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 0bc877ff62..315dbb742a 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -259,6 +259,9 @@ void vfio_device_unprepare(VFIODevice *vbasedev);
 
 bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev);
 
+int vfio_device_get_feature(VFIODevice *vbasedev,
+                            struct vfio_device_feature *feature);
+
 int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
                                 struct vfio_region_info **info);
 int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
-- 
2.43.0


