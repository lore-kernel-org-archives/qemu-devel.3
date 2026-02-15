Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C340FEF586D
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 08:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrXue-00024e-86; Sun, 15 Feb 2026 03:55:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1vrXuM-0001yN-D7
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 03:55:19 -0500
Received: from mail-southcentralusazon11013007.outbound.protection.outlook.com
 ([40.93.196.7] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1vrXuI-0003L1-Cf
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 03:55:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rg77g5uEC5gNjTa4jfY88iT9GHsjFUF/4wC5VIQKjQ3puEjZhCX/3HnAaolgKRYrckf3QOC/KEnu9tDB3aV/iOikaeRMu0v91uv+IIRgtS1+Px5lAVKZjvgY/NnyLxf3/QReccyr013QEtFv1kSuBc1sdY7Fc9XoVWO2ZqvN2MLASUfIHGO8znrmtQ1OVlZa9Rv54/wtrXdIaOHImE0b/0xWVlLvgJLE14cfXwWlwCQzhinWdN/huZMRDyoMXU3JvTji0l3Hu6FlRVrMRvxXCMIHT3yijzYJ4vFR6tbHmD2p2tP+svpfqJL+1L2E4X0qGzfDujnCIq/MBZ8y5WoNqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlJi4GalqPmHNwIpq8wYzWqCs7zDASkjSD5PuT0qwPY=;
 b=tZRHUU76b+sgmzafd9W8ly1b0zQ+QujQb5vEGrSsAOBzIfQINk6xjwIXhEhLMsWvL3cMx8Xi6dHWUWgf+4lGk6jU0M0IyHSsb9OiB5HNYLAKiARX+VtG2kzToZ+I1dI0PezJCLwekWj2dA93YovphAq+95fgiV6vyjKYk1JnXgpXwqEMK3HrKFyRdppHKfhqiJ/bq+sLkCDS8uqKz+v4jw1FcwHJJrTnFlAU2o/u0ifSDEtsjXnZArodCCLsFNuBEESeG3GsWl8pxtVTMNQEwZeeJybxSiM9Mq4KxWZYWm3ZThRMs2rZljkRhAtzHUC6qeMu3qZat+77WrvsM2p1bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlJi4GalqPmHNwIpq8wYzWqCs7zDASkjSD5PuT0qwPY=;
 b=DOne18eOHEoqafv0BG75xfi9OQ0BwC53iK6Pn7B2J2MMLgogocz4L5wdV8rjqD17WjDecc+B5F4EJ+2kP287RIYm1lnJY7t5sjG8ZJpJO0TlMvWZ8v0UhGgT/Tc5+cxNGWTFNiYPEbSM10FBmGg5LdLEElvsuDD8w0jrHf2i1xGJVCkpY9L+7WPmoe8Rjn/G7wphL6EB8tQw5VmQ2SEVW4s86sCz4+TYhGcGIFIDmKS4fq5SyauFAjEE+j9JhqQcJQC+92ju57XRcNfoaEGJ6Q+wN56JDydW0DWza1Td2XWsZIb/qL9NSv/muE3NEuSqyBPzLPYv38RRVjX9ySGwUw==
Received: from SJ0PR05CA0050.namprd05.prod.outlook.com (2603:10b6:a03:33f::25)
 by CH3PR12MB8995.namprd12.prod.outlook.com (2603:10b6:610:17e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Sun, 15 Feb
 2026 08:50:03 +0000
Received: from MWH0EPF000C6186.namprd02.prod.outlook.com
 (2603:10b6:a03:33f:cafe::59) by SJ0PR05CA0050.outlook.office365.com
 (2603:10b6:a03:33f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12 via Frontend Transport; Sun,
 15 Feb 2026 08:50:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C6186.mail.protection.outlook.com (10.167.249.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Sun, 15 Feb 2026 08:50:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 15 Feb
 2026 00:49:52 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 15 Feb
 2026 00:49:51 -0800
Received: from localhost.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 15 Feb 2026 00:49:51 -0800
From: <ankita@nvidia.com>
To: <ankita@nvidia.com>, <vsethi@nvidia.com>, <jgg@nvidia.com>,
 <skolothumtho@nvidia.com>, <alex@shazbot.org>, <clg@redhat.com>
CC: <aniketa@nvidia.com>, <cjia@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <zhiw@nvidia.com>, <mochs@nvidia.com>,
 <kjaju@nvidia.com>, <qemu-devel@nongnu.org>
Subject: [PATCH v3 2/3] vfio: Add Error ** parameter to vfio_region_setup()
Date: Sun, 15 Feb 2026 08:49:49 +0000
Message-ID: <20260215084950.4657-3-ankita@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260215084950.4657-1-ankita@nvidia.com>
References: <20260215084950.4657-1-ankita@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6186:EE_|CH3PR12MB8995:EE_
X-MS-Office365-Filtering-Correlation-Id: ff313f6f-831a-4385-d8b0-08de6c6f35cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IeH9S7Bcisx9kv16TgwBu+qx7GRvIVFSLFDvfQFUl3T1KlXdxVmXXar/1ILq?=
 =?us-ascii?Q?VRlohCtta5a4Jo2Honm7CHgI4vE1VFPcsSoja1CQSvK/X2PhWGNPmJhbVjkK?=
 =?us-ascii?Q?SW21uZ4gBmJpc5R3PjDmy4vENDwPESUuScuZxflDe1MQnPdi88G6m0y5Pu+r?=
 =?us-ascii?Q?TNmxUhoD7OV+khQggEFNbyr5XylN8Rgm+XCqDy9sIXALORyJda2FqWC77ryG?=
 =?us-ascii?Q?RHW6qGVtx+JTZTcBn5J9MQZRFsyx/x2qaWKsXxEZk+FkLY/+x6QRVowo+L4M?=
 =?us-ascii?Q?EUl8ZHwYHZ7jJf5+9XZQfxVnGc6/eoCa5whRZpguQRCaXlL7X+WXjj0SlruJ?=
 =?us-ascii?Q?ST2aeo8cKp0u4rJ9eJtQ4R1JTymWjU5gRGy9cnv5+RPKhsPUYVEGRYJm+zNQ?=
 =?us-ascii?Q?t7GBHMWVKYGTA9tWHfpCfZEhZC/s29JGxPTYmD+vwVtds56re1pMaZfHwS1y?=
 =?us-ascii?Q?JnCmIUDgjUEIHdDEbh44Q+TixVqWYL4K1DSmYRJHTr10HSDCJU1jLI86dbga?=
 =?us-ascii?Q?OujpzZacwHtz3UdYpVcTGESdCFXpbjbe67rRaFaYcG6QgXo4MFdRU/PVubQe?=
 =?us-ascii?Q?gP29iYI48MdlaQ4FhNJdIhf+i5gSHXeqP8mH5QqGTDONNWP7GaC4vA4cg1Qc?=
 =?us-ascii?Q?lrpRNGc0JDcKEMo3oetZE2U71FjmVMMc8o7+vnJAFZ7VckSoMb6yZI6qM5GT?=
 =?us-ascii?Q?Ir0ZtG6yUEuxmvg51QUcPnnzycTpkh+dBfe40VfwZ9dpRqU3BsYPAG6QqwDI?=
 =?us-ascii?Q?M9qss9CY4mzUKzgrWci+Le9mvowyATUcGx6Ez1PSFgS3j2vSePmZ5fWq7NHl?=
 =?us-ascii?Q?YjJwXjh1xcj9gZESP9Krpwe4baJbKclWPgq/jioeNcNkfN6h8sSvxIrN3+o9?=
 =?us-ascii?Q?HxiBqj5BrfFFrIw2Vlo+BS2O1QoLu/oKvoQUgcefYlhVMfcHyIDQ3xAzj4Ym?=
 =?us-ascii?Q?4IWjWluTsJz6j004p4Jcob4XbZeiXNTzQA/WNF4aoD8bAhu3WWeL2vLqncCL?=
 =?us-ascii?Q?NjtcaXiK+yZt8WuZVbGiSiV4/MGLNnEW7EkT+54PITkm5ZUrGuHpnLDOV3/y?=
 =?us-ascii?Q?1eDMgOqky6krlvuZBhtSqbuo8F9fbmlyMq7/nJ3she5WrZ/TxGwmbf2avCxU?=
 =?us-ascii?Q?2Rl5WXUNmEY19ISswn968KnoQeFXNj+3+dkOswWE6Sd+AXuls4KOv8qTrp/1?=
 =?us-ascii?Q?MxUjwAXFytZAzxZV2pe3lpbS76lVBznPlq+AlkQvmbT8dYnqJC2OI6eMHVmL?=
 =?us-ascii?Q?aKaMHdyWpygSC31wLbcciuyjIFLJE/pk2IREfjRwJczUae5Us/LyEojG6q3F?=
 =?us-ascii?Q?jdhwYxHnQfbIVXZqyPI0sC+CGVN+SS2+y//KXaQfcaPthDsIv1Zn1Bvid7/2?=
 =?us-ascii?Q?Xt7wNvRIuzp94QUhIT6t4CGfg2sTCQBxHQVWjF9WthQ3kmoC1TZhj/ciNqGS?=
 =?us-ascii?Q?KgZp8XdhnrkqxfYIC+toY04LmmzN12e8MMHym41PA9GdZy7NA0wrWwtChTTc?=
 =?us-ascii?Q?R9PHNXiaxRC+8z+dW4s+UunL6B4c8Yq60Qxv9d1Fw1VBOXZ5bBjwohqApOvO?=
 =?us-ascii?Q?8u+XJFb8DOC0BqKx9LaJol0DOzdOfUESHyiMOROW1afSLV0OPe2BgVSC/n+2?=
 =?us-ascii?Q?f5IRUz5b670IQjJ1QI32pwe8JJNoql6ZVQ3CKrB5vylJbGVejnEwWe4JhCOi?=
 =?us-ascii?Q?hJzsvA=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dLRvJyx6O2VRbZEbGNsHAw+0P5D8PPyr9pzm28lJjR4ZlgxLvXLTq2ZqdVEEluWMck4gEWEbXaY/xKJNJ2OOVY7EelQApBClO8jY4DR3cX1iy79qy9XzNf94JEnI9mvgn8p8X7x8XOcV4HgOrfB+3aImBGii7asdg3rCSKmbTeuVaL63+wyftpBfySiSnfkxn7BnlynIqRjV0YOQptJzTOYftLff4KbMQ6ZOEoIA8pVhswiO1eUtKXzyAFkbMKqx0MsEZx82sFLqfmI6vWQVra0oER9YyJu//xKfu+eQKVyRPfnrsNxE8ZIWlC81iumx3hlTB2SebS5e7pEgYPBS5DkPWjK6ceP/NKQ+xcURcJpMaETm1GBw7AYXBqfEo7jH4XQXDIL7+5AP9IYXhNZgESQ1v9Xj6Fs8iSJ3c/VAEL10Rxr0WpuWP+BRDTFVqUy6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 08:50:03.1735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff313f6f-831a-4385-d8b0-08de6c6f35cf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6186.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8995
Received-SPF: permerror client-ip=40.93.196.7; envelope-from=ankita@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Add an Error **errp parameter to vfio_region_setup() to allow
proper error handling instead of just returning error codes.

The function sets errors via error_setg_errno() when failures
occur.

Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
---
 hw/vfio/display.c     | 2 +-
 hw/vfio/pci.c         | 3 +--
 hw/vfio/region.c      | 5 ++++-
 hw/vfio/vfio-region.h | 2 +-
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index faacd9019a..bb9015804c 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -449,7 +449,7 @@ static void vfio_display_region_update(void *opaque)
         ret = vfio_region_setup(OBJECT(vdev), &vdev->vbasedev,
                                 &dpy->region.buffer,
                                 plane.region_index,
-                                "display");
+                                "display", NULL);
         if (ret != 0) {
             error_report("%s: vfio_region_setup(%d): %s",
                          __func__, plane.region_index, strerror(-ret));
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 36d8fbe872..c89f3fbea3 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3056,11 +3056,10 @@ bool vfio_pci_populate_device(VFIOPCIDevice *vdev, Error **errp)
         char *name = g_strdup_printf("%s BAR %d", vbasedev->name, i);
 
         ret = vfio_region_setup(OBJECT(vdev), vbasedev,
-                                &vdev->bars[i].region, i, name);
+                                &vdev->bars[i].region, i, name, errp);
         g_free(name);
 
         if (ret) {
-            error_setg_errno(errp, -ret, "failed to get region %d info", i);
             return false;
         }
 
diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index 177494c379..b83b09fa2f 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -227,13 +227,14 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
 }
 
 int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
-                      int index, const char *name)
+                      int index, const char *name, Error **errp)
 {
     struct vfio_region_info *info = NULL;
     int ret;
 
     ret = vfio_device_get_region_info(vbasedev, index, &info);
     if (ret) {
+        error_setg_errno(errp, -ret, "failed to get region %d info", index);
         return ret;
     }
 
@@ -260,6 +261,8 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
                 region->mmaps[0].offset = 0;
                 region->mmaps[0].size = region->size;
             } else if (ret) {
+                error_setg_errno(errp, -ret, "failed to setup region %d",
+                                 index);
                 return ret;
             }
         }
diff --git a/hw/vfio/vfio-region.h b/hw/vfio/vfio-region.h
index ede6e0c8f9..9b21d4ee5b 100644
--- a/hw/vfio/vfio-region.h
+++ b/hw/vfio/vfio-region.h
@@ -38,7 +38,7 @@ void vfio_region_write(void *opaque, hwaddr addr,
 uint64_t vfio_region_read(void *opaque,
                           hwaddr addr, unsigned size);
 int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
-                      int index, const char *name);
+                      int index, const char *name, Error **errp);
 int vfio_region_mmap(VFIORegion *region);
 void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled);
 void vfio_region_unmap(VFIORegion *region);
-- 
2.34.1


