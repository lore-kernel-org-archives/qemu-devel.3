Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C342E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:46:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuND-0003TN-3a; Wed, 18 Dec 2024 08:45:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tNuN7-00030G-0v
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:45:53 -0500
Received: from mail-mw2nam12on2050.outbound.protection.outlook.com
 ([40.107.244.50] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tNuN4-0006lo-1a
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:45:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+BeNDCOoJXtPW19+V0VVGWVJGjC+KG6ODQWSI2KSWjMa+JNZBD0StsRxrsaOOCb2PqZv7lSU6nO7OJ8bVaSgx7ox/pCTXs1UO1SPe6E8I/u+k/eTUPzNXYGadsnUZdtbQI7/aZpI7CX5c3Ji8qkYa4Q4NaTppqYh9IJFP6LfvI1N53+389Wmb0EEcawJpFRj+EuFNnPT2RC1S60OXU8t4SwBS5FAK1t8E5ElURaPZbGJzka8F4sEt0bDvCt5Fn7E8VNODJhggBl4Ax68ne6dy1YuwqUOeu050kNxsoDFRVtDpXbJdik3tyaX84ackylkaR8e64jG2ImUvfJiAKwXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXp4FRqE/o+QZ90l5bTNvD51XwHJsdB1erBnGPspoAk=;
 b=LiQ1DLqnhk/6NFZEhW62Y2MA2xDzAqBEJrBWWMiVYu23II2j5cT7+LXMnMhk4CfkSGK9woBfcnF+2kb/J0E0+3v8XtW+RcPdUdVIpIvWvu4uDLx9IqXfEyZIy6JyTkUHk/OQDzcVX4nEqt0yMWXZBFEZH9W03QXIoP/ALjh0qOxzkdBgLw4IKvJ97fwT72RSG13A5oFVCyqMr+HVwLtdImy9GMzs7jDgyQ0z08lAy6XCb3PQHgoEE5Nxy4PWmPruch1MRYXoXu6D5jAfLhVmiaw9Up/tyYHAJv+QFuZ+0HSlUyybKxGhp2hK4r4kugJxcMi0RO2D1iIEbGyCX77UxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXp4FRqE/o+QZ90l5bTNvD51XwHJsdB1erBnGPspoAk=;
 b=Ch7XAcrWU8Xpeu2rpup+hJ8lY9Zzn0NNcblk0gP7i4d0gTTtolFyokT5zk4CC/opwqcHcCicRL0lxj3WvZF7F9gh8hoBZmCTGUzx7E65zR/16f63+PrkTYm9RZd+5xS/fHmwlf4BF+s8BtwaHoCa8JlQJ0CimA/9it+qd9OShN1WCYmLQpnMN8xrUn03IaTMo39AUEe6gnWlkCda7fuFFxPstQ1LPaSh6Rde7oQkzotidYxz62Xt71/VHgCieqGxUyJlrCEjvBJZKniqKnm/MIajGo8mceYneVybsuy6kk3mBqWBv7tvz1YF6UxnIXgg3o+Tnl24qmaIHwpXT/S7VQ==
Received: from BYAPR04CA0008.namprd04.prod.outlook.com (2603:10b6:a03:40::21)
 by DS0PR12MB8561.namprd12.prod.outlook.com (2603:10b6:8:166::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Wed, 18 Dec
 2024 13:40:43 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:40:cafe::d0) by BYAPR04CA0008.outlook.office365.com
 (2603:10b6:a03:40::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.23 via Frontend Transport; Wed,
 18 Dec 2024 13:40:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 13:40:43 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Dec
 2024 05:40:28 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 18 Dec 2024 05:40:27 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport;
 Wed, 18 Dec 2024 05:40:25 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, Hyman Huang
 <yong.huang@smartx.com>, Joao Martins <joao.m.martins@oracle.com>, "Maor
 Gottlieb" <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH v2 1/7] vfio/container: Add dirty tracking started flag
Date: Wed, 18 Dec 2024 15:40:16 +0200
Message-ID: <20241218134022.21264-2-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20241218134022.21264-1-avihaih@nvidia.com>
References: <20241218134022.21264-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|DS0PR12MB8561:EE_
X-MS-Office365-Filtering-Correlation-Id: f1cab929-18e6-43c3-3585-08dd1f6991eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2hHdTI2vGYSTCBe7YkizsAPvgSME81eVA+qVUtXFstKf2/bYFfP7UBK6faez?=
 =?us-ascii?Q?I31y+lVXueH8pqtHKdKYBYnQjONvTJoPQlIl9C7XtHIOLtYv+9loch4udM6V?=
 =?us-ascii?Q?2mIbbOWtqDvImEt+HgyfKrqtwqNwhDkVRKxw4+rBE7UELQbmdq1Y5jcni9l6?=
 =?us-ascii?Q?61bARdSYgroAY87ezeC1Iqe0+p6M9Kae5qntUh2DhdWixCVCGYv4zwNDfVAd?=
 =?us-ascii?Q?Kyw68O6NGyXAqmDrAM29GV2CzHsC5jS6OKby2D4Fwsw96KDgBhwtbRWJOPYG?=
 =?us-ascii?Q?MgLgEkBOqExSsfRenPwe0z0WQwg/dbg1df8NykL/2rnFfGK4XHyL1IbwShp0?=
 =?us-ascii?Q?loQ1TLQ4NbhXJs4PFlfW8nxv20Hl+WyA4cnGP0G9XTd0p88Pmxm1fIaTAbbK?=
 =?us-ascii?Q?yqj+IBAMpUpZMqao/ny2aZn1E/vr0RNDofk1R20IZv/QYnkkYNvrVsxOlirD?=
 =?us-ascii?Q?YvLHlZNXu2Zbfh3Jk95n/WDR9QZtweWhpM6c+r1cG4Bunb5Y0rl00Rz5Uwwt?=
 =?us-ascii?Q?PfDJ/XeQB6ofHo9O94Hs+7EAmoNVZmq/VPeQaF3xUES9aN4n3WkhfMCuxjmn?=
 =?us-ascii?Q?ZxkOJt/SXyySDHuAkwT9ABBZrZ7WF7tWZm9npuPZzmV86VoSp8N3aEBipsjN?=
 =?us-ascii?Q?3yZQpx1eVo5T1YyhgK7pkcygVJbU/OS19GGjRHayR88zc52RrgiGig4Sbe4t?=
 =?us-ascii?Q?8RWZyXicHA2Y1FrezTVy6rfsOx8p17dHl0PMLoFW2gyQRt/A7hjoEyKuzw12?=
 =?us-ascii?Q?JQ1nSksVr4OFSKYz+LM0iO71s87a8/IAXiPy3Q1GBwkjrFg8ZA9Ud6ig+lmZ?=
 =?us-ascii?Q?yv2IJgaJiOt4pF3vU95KL677m1OieSfao07cNs8PP5Oz8Wk+ATOGqfZD3/5v?=
 =?us-ascii?Q?ihpx3Xem2swCv3O9QLpDwQucxYp8i/xPChoop/EBHqpnUByUDaNwYs6LMZWz?=
 =?us-ascii?Q?Mw6aPMckpKVB2tqhq7qe4OJzAeh3wrk1q/s0HS5jaC9txDq6Vqf941YAu7XU?=
 =?us-ascii?Q?6mifW9IN5zv9S/YcvFyt5495Txx+XH04cZrLcX9le9HPLaQ/l9bfTVLbTpXc?=
 =?us-ascii?Q?H11CuOyD3hM7V2OFRfMBNhrXVZdGJ8bKu1tqG5AJfyGD+1XxJD2Zd6uaRvAa?=
 =?us-ascii?Q?JQpXmJv1NJzW+AvIFD4AEYKpKOmLVT25Uef3hto3Pn7F6O0Z65+IYw6/cu11?=
 =?us-ascii?Q?4WBGvF/u/4QhRbwqy+gYt05NA9lWejlt0Xn6LzbWMKabqdVkFtawc2qddtvG?=
 =?us-ascii?Q?g0hURqDGOrDiAKCK6Fiou4M1IL6KaHNaw9fL/IwHx95xBSYnG1UvzVP7KXwN?=
 =?us-ascii?Q?rqrrFDQjzwMY6rgFPxwPRRXZNqgAZkJOHm0ljUreCzFxQSxHWa9nt+wYMg/1?=
 =?us-ascii?Q?ZrWAmxCDitEtUYTYjVe2kR17SS9cicu9f1hp7Sql35r+MUL5Ze2whFnRJlTF?=
 =?us-ascii?Q?azmbdoOjN/ke9KIpNZ+dgUyQ4u4gLIeI3QtC3ltmg0ombIaj7UHgAbGyqfVw?=
 =?us-ascii?Q?KdamgxBR6rjx0HM=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 13:40:43.6460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1cab929-18e6-43c3-3585-08dd1f6991eb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8561
Received-SPF: softfail client-ip=40.107.244.50;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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

Add a flag to VFIOContainerBase that indicates whether dirty tracking
has been started for the container or not.

This will be used in the following patches to allow dirty page syncs
only if dirty tracking has been started.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
---
 include/hw/vfio/vfio-container-base.h |  1 +
 hw/vfio/container-base.c              | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 62a8b60d87..4cff9943ab 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -44,6 +44,7 @@ typedef struct VFIOContainerBase {
     unsigned long pgsizes;
     unsigned int dma_max_mappings;
     bool dirty_pages_supported;
+    bool dirty_pages_started; /* Protected by BQL */
     QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
     QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
     QLIST_ENTRY(VFIOContainerBase) next;
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 6f86c37d97..749a3fd29d 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -64,13 +64,23 @@ int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
                                            bool start, Error **errp)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+    int ret;
 
     if (!bcontainer->dirty_pages_supported) {
         return 0;
     }
 
     g_assert(vioc->set_dirty_page_tracking);
-    return vioc->set_dirty_page_tracking(bcontainer, start, errp);
+    if (bcontainer->dirty_pages_started == start) {
+        return 0;
+    }
+
+    ret = vioc->set_dirty_page_tracking(bcontainer, start, errp);
+    if (!ret) {
+        bcontainer->dirty_pages_started = start;
+    }
+
+    return ret;
 }
 
 int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
-- 
2.40.1


