Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1087BE77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 09:48:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN7hA-0000Xm-Ol; Mon, 16 Dec 2024 04:47:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tN7h6-0000Wt-ER
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 04:47:16 -0500
Received: from mail-bn8nam04on20611.outbound.protection.outlook.com
 ([2a01:111:f403:2408::611]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tN7h4-0004MT-KC
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 04:47:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dohC4UcC9U9IG5q5BbKZyGl2XvspqQHJvh/fhkVqaa5nT7gRY12WDwT+iIzzCTyZ7OyjqcDTVxEUnASzU4Dwt0H8iQMBtxrQi+qAnbnjympQyqU1VHywb4A8O3MTmrzSvVw6LHDmHLxwgQdvTfXcr91OdY/F6iN3/m+REJFqi0qG2qxsuyuGGNIMvQx68O7A700ohq/qvmd9bzO5ZaN97YZrqadokUNsJPBgZ2z66uy6MYDBsGEPJcwJLz9ZPo3I+6vbTJrbJuA+qNDrvvSKwOdS3N07hRj8WXue9Rfo/cOmCTUdHGWRWnC6zToV59sx6Ymh3y5/7Ss/KbnBIXOGKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fb4/3P7mjpTmCiwwS3JIXOxIVE8h13YyunD8pbbeAp4=;
 b=eUGonhODcS5KONFJqviXfAhGZAk0Sk5D5HqjJq4JhPFIQJqzCMLrmnJKT7BnZFKvI4HioPcGRfFnpJtxy6OihxU73OlaaLe9bMcSlEGcl2pPV7Y7fKgA12kTQuFORrYV3t5ShQQ0afliY/JoDZQQInHinhxwNT0u5KIINFMNRVWhp0rQsWb7cCXLBFAnZVVKQuk5NH09YcUKDZBMkdNQgEm2pjqDE41aNINFPlC/FWbY39b14XLrzHiRc3n9up58aMBtsCxe8BicvxdmxQX8K+TEF+zBn1lE/NL61uJYw3T4yYhh8KUcBtQMpY8XfD+i2cpMNUqgbiuwPDCEv9B/+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fb4/3P7mjpTmCiwwS3JIXOxIVE8h13YyunD8pbbeAp4=;
 b=NrE5hXVq6uQUzcafWTkmLU4nKfbc0fKuIUvLRiAXeFgcCEMEyVxiudjDU5M1Vn2lDG6jNDdiuK6JtRRdo6G/LGpnQ5SUTsIGtm9L+Rs/vnpa0q2G2h0ZALeqsLKwxv3B9ba7n9pgFf6fIC13bx/K29nwwA5hFilqDIEIc6S/U4BWQ9DFE9RsTkL7FhW1aDQqoja3a7oAtK5dPwFMb9MOCB7O54dNyyRuhnapyxYUfE4FIfw0Cv5/wFPL2zQoVRJDrlS2PJQ33BuluvNov9nIgK1iplKP+CsqN6cvU/NMxV+/R9TMO1UelTwNyHngyMboyJ5XP+EXT4M5G2vDTbBC5g==
Received: from BY3PR03CA0022.namprd03.prod.outlook.com (2603:10b6:a03:39a::27)
 by MN2PR12MB4456.namprd12.prod.outlook.com (2603:10b6:208:266::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 16 Dec
 2024 09:47:10 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::3b) by BY3PR03CA0022.outlook.office365.com
 (2603:10b6:a03:39a::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.20 via Frontend Transport; Mon,
 16 Dec 2024 09:47:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 09:47:09 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 01:46:52 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 01:46:52 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 16 Dec
 2024 01:46:49 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, Hyman Huang
 <yong.huang@smartx.com>, Maor Gottlieb <maorg@nvidia.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH 4/9] vfio/migration: Add
 vfio_devices_all_dirty_tracking_started() helper
Date: Mon, 16 Dec 2024 11:46:33 +0200
Message-ID: <20241216094638.26406-5-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20241216094638.26406-1-avihaih@nvidia.com>
References: <20241216094638.26406-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|MN2PR12MB4456:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c98c874-72c1-406b-5b8a-08dd1db69c46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xQGGwWscxdUeDDfhvdQG2JUNDNA0lmoBGQm6LbgHnra9/NUzK/2AsnUjJeok?=
 =?us-ascii?Q?+skC87ODFk5bLr2thWdSfnjxegSCbrnMM9eGM1XeUnvTGXkuYe1E8xVyWXTq?=
 =?us-ascii?Q?7SE6jFt1aXvGYkJt45th0v1GKTiXFtJPt3t7YMYsqKTVdCr8dLJJLPgXLZ7X?=
 =?us-ascii?Q?QU/cMUpzLRz/+z+aVNz7vQd5QdI0qSVPmNalunH7nrMjFBLasXqZmSPX8CeW?=
 =?us-ascii?Q?Ujtkt5xXb7BdhCyfe6vgeP5x7cPyn28+D+vBH+hNejiiEZ636whfjt/CvaZ7?=
 =?us-ascii?Q?OlMiPWL3HtjdmB67+xb4LMM6xZomAnjMWfx4MqpO4MEyM2N0eUDY8ZvlgpWF?=
 =?us-ascii?Q?q8ZJseDLZ3TJhKucNXMB6l3BE2cG2v2OvxEyJs15I9X/RASd3/xr+LQVAq5G?=
 =?us-ascii?Q?IgftJAh3QguVW8Zqx24te+fBrdI5tKp4eozIueV91LSf7wtTBQG+rUBBIyzu?=
 =?us-ascii?Q?F3zGt9wn1WjU9mkcJi6+SI4gawrjV/byL9gHw0mizt9nUTajDM3wIPF3fDZQ?=
 =?us-ascii?Q?Wus+CcG8IhM0NqU++WV4VPCC45e6vbogVxCR8kzlHnfmLIeX6PrkmX86ySCc?=
 =?us-ascii?Q?sIC8S9TPjLDt/RK2OkXBo/ixOTItnZT57snppeVRvLC93lunIu64wlBy8IcH?=
 =?us-ascii?Q?oPyWsg9W32Y3eV0JByEWWDERSCwJC+axHIquQo6UO5T9nzC04usCyynWH3OB?=
 =?us-ascii?Q?dyoHF6cpxfY1Z4fqScCDiDgt0ZmYrFiuTnnbmx0DDGaU2a66Em2kf0722eFE?=
 =?us-ascii?Q?eWc2Rb9oap7nRsi1FlikmYzishbWyFI8dBp9zlYOLLPp80hgFnZFCcHTLNjZ?=
 =?us-ascii?Q?Z3dDWnUfybPyTvDx13kyK3o3Lbw14oetZ02PDDDZgjsw927U4ryWps6cYVCI?=
 =?us-ascii?Q?Xt+GrCWQQhX+QINeh8zyHxq9OrLD4huWuBsAMcQL432imx6rrOBFOxPzd9ax?=
 =?us-ascii?Q?tkH0TL7wxEfN9Viq8Ww4tfc0JKepttPVTHRKBryFGhKbvjr1ixdZ28TTSZOc?=
 =?us-ascii?Q?23+htaFZk7BxDnuNpq6q39BbCtwnbzzNJTr89/oWDEvI75Vf+voLtz1hgCVI?=
 =?us-ascii?Q?FPJYuGHH04rOPE6NuVYwbgNC/+drqbeDszkrVcksy4nIA/H/V/j8jdGB2/IL?=
 =?us-ascii?Q?IWgL9OHxm6zWL8URdTx5rLo1NpL/0dgvC0wzWviFmT132CPsBPfr/o66vsfi?=
 =?us-ascii?Q?VCbzS5Un6Pn3Kq6q1ERqaJJUxZ3ofQ66Lr1eeBmalO+zvVsBmIOP5mcJ7hZ1?=
 =?us-ascii?Q?lhHKCkuzofEu27HR3du7xWKh+h2Om2iOY77zpxjHcduA651Soesoa2CUdDDG?=
 =?us-ascii?Q?l0s0ZBu5XBzikmJfTyYaZkzVhNQPIDI8kM4dN9DMcpuvkOR/Harz1NWXwJPX?=
 =?us-ascii?Q?/3CuiTJyInL5+x87biGbALJ2ruTijbu2lPE3hhvGuIm7oKJUxlgBgHFaSPF2?=
 =?us-ascii?Q?N132AplG8/4sUmae5qy7zlENL7vYCQH+eMfS/T8ia+ir8nwO1kodHzCjOBNB?=
 =?us-ascii?Q?+vH/mxeExxT16MI=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 09:47:09.8494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c98c874-72c1-406b-5b8a-08dd1db69c46
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4456
Received-SPF: softfail client-ip=2a01:111:f403:2408::611;
 envelope-from=avihaih@nvidia.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
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

vfio_devices_all_dirty_tracking() and vfio_dma_unmap_dirty_sync_needed()
share the same code that checks if dirty page tracking has been started.

Extract it to a common helper vfio_devices_all_dirty_tracking_started().

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 hw/vfio/common.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 81fba81a6f..45783982c9 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -184,16 +184,22 @@ static bool vfio_devices_all_device_dirty_tracking_started(
     return true;
 }
 
+static bool
+vfio_devices_all_dirty_tracking_started(const VFIOContainerBase *bcontainer)
+{
+    if (!migration_is_running()) {
+        return false;
+    }
+
+    return vfio_devices_all_device_dirty_tracking_started(bcontainer) ||
+           bcontainer->dirty_pages_started;
+}
+
 static bool vfio_devices_all_dirty_tracking(VFIOContainerBase *bcontainer)
 {
     VFIODevice *vbasedev;
 
-    if (!migration_is_running()) {
-        return false;
-    }
-
-    if (!(vfio_devices_all_device_dirty_tracking_started(bcontainer) ||
-          bcontainer->dirty_pages_started)) {
+    if (!vfio_devices_all_dirty_tracking_started(bcontainer)) {
         return false;
     }
 
@@ -231,12 +237,7 @@ bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer)
 
 bool vfio_dma_unmap_dirty_sync_needed(const VFIOContainerBase *bcontainer)
 {
-    if (!migration_is_running()) {
-        return false;
-    }
-
-    return vfio_devices_all_device_dirty_tracking_started(bcontainer) ||
-           bcontainer->dirty_pages_started;
+    return vfio_devices_all_dirty_tracking_started(bcontainer);
 }
 
 static bool vfio_listener_skipped_section(MemoryRegionSection *section)
-- 
2.40.1


