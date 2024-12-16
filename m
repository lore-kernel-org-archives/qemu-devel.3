Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4869FE77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 09:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN7lu-0006bW-7z; Mon, 16 Dec 2024 04:52:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tN7ls-0006bJ-Pw
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 04:52:12 -0500
Received: from mail-sn1nam02on2084.outbound.protection.outlook.com
 ([40.107.96.84] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tN7lr-0004t9-0f
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 04:52:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IjrMs42in3gO25UkVjAyIPqXGriLPVoe0okBA1gwXyF5n6RCwdIQ7PDv904/4ApGHJMK10O0MrZWnGIYjcWol2ZRLvsmx4gYIkH0k65uedXB5fL8S7NoQYAGlgK87i4C/+dyK+xPqmkUWC0h8xMc5pvIW1vAmxaw6OJq2hzFHq3zdEMW1IwcMvvVH05i2kYZ+Eql6A2Y5TxMwyE7RfzLglyFLnHU4M3mrtzE3sLwM8XvOZCZ3qSwhI5bgeBUwNJD0v0yM9JZuvB4RLAYK+/636APHlUVicNQT5NyORliUXuYwV776MQ2AxTj1tpGlKCdc6wtujC8XBkpIlOK78OpCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2F/vA4U5vm+OvnHBse+FyTyoWwUteRMZnak7fl4ig8U=;
 b=G+5yIVZItO3u6UZCUy3OF9rBaYYz8YrT7rtvIyQsPogn77d2ZLWSKzs2gx+6zljeM47D3oysmTL03FqoGaVACoNRwd9jxTks9JAbOwZ5B90zv/CTPRkQ2x60oahMw6dl6uX82dRcdiCB+qgDgrE/5o4aaCDG5I3PZu5i0mChKhK+iQwsabGbTpeKFJeT5nfNxPrKmQoKt3kdEOGdY8QMG77wcuq3SNJNfRe3tDyDnIFwLp2y8ncTUxzGpw/G+FEamAE+fRxptP68Po2UUNRicEOkvrBb/P9MqF4HzhSuMKPDf5zB5poqjkJW+HUBqMFYFeayYGfDaoQJdxjZzwbTPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2F/vA4U5vm+OvnHBse+FyTyoWwUteRMZnak7fl4ig8U=;
 b=L6j4ynJ1NnSCJutJ3uZRGcUESK0brjege8KrWlLawosGRx06v48lbYmTJ0Lcx586qabHKbzHuXr9t3vwKxuJMz0S77CdIMHCUwv3BW4Sjk72qgrkyM7XvSZPwO+Grq7lGB+qXzF8qJo4zV8YNEJdKOPLlTkXq/wIjTYCgv4/9Poe5xzMLaee86b4Lco4jSU0aKqsLJkKIgz00QPoi7zEcUFR0xLb77rn8CblvCftu6JpVc/2OJnDNBDsWVxjQvnJlZCgF3PLJzYra3ZeULhvu6UgZfijtmgItlYpONyD5Rk9InzWaUirT0LFgQQ3zbca7amNeIapjdQeRa6SDAqohA==
Received: from SJ0PR13CA0123.namprd13.prod.outlook.com (2603:10b6:a03:2c6::8)
 by SJ1PR12MB6196.namprd12.prod.outlook.com (2603:10b6:a03:456::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 09:47:03 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::19) by SJ0PR13CA0123.outlook.office365.com
 (2603:10b6:a03:2c6::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.20 via Frontend Transport; Mon,
 16 Dec 2024 09:47:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.0 via Frontend Transport; Mon, 16 Dec 2024 09:47:03 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 01:46:44 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 01:46:43 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 16 Dec
 2024 01:46:41 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, Hyman Huang
 <yong.huang@smartx.com>, Maor Gottlieb <maorg@nvidia.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH 1/9] vfio/container: Add dirty tracking started flag
Date: Mon, 16 Dec 2024 11:46:30 +0200
Message-ID: <20241216094638.26406-2-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20241216094638.26406-1-avihaih@nvidia.com>
References: <20241216094638.26406-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|SJ1PR12MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: b9343ac2-9b5a-4743-6c70-08dd1db6988d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UuFyjwtHqtr0zGRvrOeKOKnqSeVZ1zsiWeoeepOBlLAGPYUygsTJddr37Xfl?=
 =?us-ascii?Q?MNiGk8dcVYFMrEiJEDyd4o9WYXZ4aFays7MWaF6O2h8iXx3M8vjOuYs9i5qi?=
 =?us-ascii?Q?HgEljO1saPl1/ovVG1cdsxluc33lWYI7+WztLBWO5opqCEK1EClm7XnJXuXP?=
 =?us-ascii?Q?qOJ0NMas+b4NO2GcZl2zJ0Edzc5D5xev63NQEMj64FWIkg15+Pl8kU9/Uco2?=
 =?us-ascii?Q?P/R0AEQob6W4q5OOgO0oav1MMixaHj8tr4j+G9K+EuF5DTqGLNocHM8R6AVH?=
 =?us-ascii?Q?ak6PkAp4yCG133miup157b/n7WndLo4Uj1oSfvbhOvvDYYlNldnmfR0QhU9A?=
 =?us-ascii?Q?HPc+LTWaUs4d0UQVFFc8ivNS1IMaEr51dYb6C2G7dxurVakJN3UdRf0+xS4e?=
 =?us-ascii?Q?AkuQO/dzQywvHJzPAC6O+cNvp0igCH0xXa0z6lbZ8k6VHQFbL1od9IE834O7?=
 =?us-ascii?Q?qBeeYZHBk9ff/TcREYkZt7ErHJ2ypIXVbhR3mmmqx+PPXm9IEP0ChuI0ZMUo?=
 =?us-ascii?Q?RREdC13UFB1w5MTm3d23xvMOyiSTp+UoliVz3DgiIzaYbA7dbW/xTmdvpgB3?=
 =?us-ascii?Q?bZo1lbwRSrCTATb18JgTu/ZHplSkymxQDPHr3s3bVjMLYUls3EFCTSEKC+tf?=
 =?us-ascii?Q?XGbMg7qb8aPvcnc2p1K2syOPS5cw+tY+W0Rzgoc2EKRPz4OWD+P6NIZdjzjZ?=
 =?us-ascii?Q?J8NGBBCPYN3lZNtk8UDYbKw36HKeeBkkMIiJqgfrTtB/+LzI4mob9VVDcFHz?=
 =?us-ascii?Q?ZT+FJCMehWKhfEoi4qfJeDm6CSY36oF0xQNCcDJy+8oZj/kmX4YB9gLppfd0?=
 =?us-ascii?Q?AGyFWwj8IIdhic+7PqDWAliUgA5INFyOkoAzGBvVd287p5kTZwFBWkHcHBfI?=
 =?us-ascii?Q?qJpcvt7lvVmoldMMuZ+AC6A7MDOIIZt9Wplo7U7Sh0qYoTYq2AJ8L6uXQd3Z?=
 =?us-ascii?Q?cocW4/weYZIEEz9emrLWbgnXejifG3jIAg1O1HG+zSTLSm0CBI97VgBqmKkz?=
 =?us-ascii?Q?rqaTvxFapRMgxqVTM7U4xCQwTXn295vbCNsW0pZSXEFcH3OucllqI/O1TiGk?=
 =?us-ascii?Q?RCKd+wqXHa4Rz7sy58P7RPfEVPnYi5b84FkrpFWzmoQZ5Vim9Op2o0cOWViD?=
 =?us-ascii?Q?KBUkwAGdDF/ExoJGbi/+vn6zK3FZ6h5mVcW8oOl6+Nt/diyvMst8SKRIx3V9?=
 =?us-ascii?Q?kII0NB8VE/PncGQ3UIxqOMJ0yryhglAikjQTRBTUW2zRZV5M2aDjost4txXB?=
 =?us-ascii?Q?uknbgQ57tC4dwMUxmJpdDAm6kEC7VBPWMJXdsCQQgBqQV41QuDPLTCgsBpio?=
 =?us-ascii?Q?n1K+jE5evBppJfE0thnZqwOYv3PtIuzAamS9q+sllf4MEI07u8LGQfIy1f6/?=
 =?us-ascii?Q?CQzD2kEQ+/nEf7U6Ny24w3xpYIjmHy1A9L1KGbMMY7i5oX5MHaQ6An05yxV3?=
 =?us-ascii?Q?UY/SfMOtpBlcMrj5onHkxWw6HzesCM8+qzIJkpRqjGSkUTejdv3IjGTZ84OC?=
 =?us-ascii?Q?x8iK2BAddlcW3PY=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 09:47:03.5886 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9343ac2-9b5a-4743-6c70-08dd1db6988d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6196
Received-SPF: softfail client-ip=40.107.96.84; envelope-from=avihaih@nvidia.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.168,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
---
 include/hw/vfio/vfio-container-base.h | 1 +
 hw/vfio/container-base.c              | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

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
index 6f86c37d97..48fc75cd62 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -64,13 +64,19 @@ int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
                                            bool start, Error **errp)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+    int ret;
 
     if (!bcontainer->dirty_pages_supported) {
         return 0;
     }
 
     g_assert(vioc->set_dirty_page_tracking);
-    return vioc->set_dirty_page_tracking(bcontainer, start, errp);
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


