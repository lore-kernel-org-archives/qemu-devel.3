Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C85C4451F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 11:48:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viWbb-0004YB-6l; Wed, 21 Jan 2026 06:42:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1viWbZ-0004Ve-6t; Wed, 21 Jan 2026 06:42:33 -0500
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1viWbX-00039D-Kt; Wed, 21 Jan 2026 06:42:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vEsUdKHBYDQqulRV+6eBNjxd+4HKrbu4T1xv6UD4x+QHgR2UM55LL8aRCRprxovj1YjzBmzCU+oihtwJkn/9IxmGzHIJc6RATdz33JAu4TMo+NcH3R/Mb4NJuZH3zlFEcPYnhCQyaG1gl+hM+A0RGBrUt0+VDO+ZwD7C9lzfifrPfAeMI+8uBoyVC7/w0U+U5LumUqa2MUpPdfa57XBvuW6m5Skt1RklFp6b6aiLIm88D1n0xCU28WITM2PM75K/qEkIGg3Iqjwebshx09sk38BHbJy3J8nz6mNSk5WeXV9guLAfWBJqij09EisTzB9O9F2Bw7l5+LtriG0HjiaD+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxbB4gZPK1wEdYioADPBR6ZU0eRGSMiTpJZw7HpRG3c=;
 b=mSooWRpiG5l5luVGtFqQreWawwf+ayT9fzmVZq3ZCeafTUTUiISImaLnCyCpKMdIqcnbtg+jujOZcf405zqrTsiKJw+1YftBS3ZJ0HkeTJ7CVaoLErL5KY/IxG9PGNKRenF2YLIf0NPpVNMocyitSclT9pXEDy2LH/XIUfQaYw6jCZKojp2QQGXIa0LF5g+c5amP6AGmiHQiwRk4WZA/mFbGtv+MC+IC4JbY2jv7u8KgTUc3+0O/tHnumWidBNYiy5N1kFV4LcL/ejhviGgAW9gWSsrSg/YOBdIHWh5qfB7ItpV5Tzxg++UHLmUjr4GRkdK5huFy0Jk3jODLtIIJwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxbB4gZPK1wEdYioADPBR6ZU0eRGSMiTpJZw7HpRG3c=;
 b=KIBy4hI8FCY6XkS6oxRTm7ztuk8krf0kttS5rddP8VkG6T/eRmhQJlTCCBzeElnzi6m9vZ1626UuFWwsJP2VYjP3qmrRQPHJXgX6YoxggrV/ATARL1Cvq1Z+GNbTm9arenm1mdQKDKhJoa3J8sSmO8wQXokI380xXtzzNKj2AL4/cBtlHKk93XvP1/L6K4jklmaE6Aiigvj0Vibp6C/ymPzIezzXhvTxmqAhc1nxjd43PFJdUkTj38FUN6uHPpM2dAZqp5KKR7jF8gOUb0UFRRZ7qMribxxC75u7OC6Vi9lQInwkXOFAZ0EqJOSTB56fj06xB8dOmYvBeDi9bFgZgQ==
Received: from MN0P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::6)
 by DM4PR12MB6639.namprd12.prod.outlook.com (2603:10b6:8:be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.7; Wed, 21 Jan
 2026 11:42:22 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:52b:cafe::2e) by MN0P223CA0006.outlook.office365.com
 (2603:10b6:208:52b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 11:42:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 11:42:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 03:42:07 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 03:42:03 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <alex@shazbot.org>, <clg@redhat.com>,
 <cohuck@redhat.com>, <mst@redhat.com>, <nicolinc@nvidia.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <vivek.kasireddy@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v4 2/3] hw/vfio: Add helper to retrieve device feature
Date: Wed, 21 Jan 2026 11:41:10 +0000
Message-ID: <20260121114111.34045-3-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260121114111.34045-1-skolothumtho@nvidia.com>
References: <20260121114111.34045-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|DM4PR12MB6639:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f6f06f4-7beb-4ab1-92e8-08de58e223b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TnJRdWdTS2I4WWRNalpjNjdxQ3BORmp6aXFTSUozQ2c4ZDYxbmhQelA1R2tx?=
 =?utf-8?B?Y2lVYkVTeUphemdmZVdBQTFlWmtQbjA5bjU5ODBEcTFrUGdnK1Y5ZkM1ZXp6?=
 =?utf-8?B?cFMzNE1ySUhCQzUxanNzNGNZanFJeHRwckF3dTdLeUtwZk4wTFRHdlVxOEJp?=
 =?utf-8?B?eGZpMVIrcTg2U1RnSjVjMWtnalB5bmZOSXBuYVMyNUdPc29XdVVLRm8vVzJB?=
 =?utf-8?B?Q0FXQlhYQk8zWDBieU8yMk1uSUlvUyt1cjNWK3hCZU82NEZhQXZFZlRFVWxU?=
 =?utf-8?B?bVlaZThTNGtBS3JXYlJsVWRIV3Nya29HL0ZUZ1dwU1dtWUNISmJyT1ZsUUxI?=
 =?utf-8?B?ZjFESlpqelZXTW5HNWhmZ1BPY2M5azJwVmtmVGM0R25EbEg3b2xidWxsY2NO?=
 =?utf-8?B?R2NNQytBWFM1QnpjaEY0OE1kTTJqc2lRN0VLdjNhdjVUNlQyYnptTDd4ZDla?=
 =?utf-8?B?YU1yL3VUSnQ3QVdNV3NDK0NFMXNEN1RmdlhKOXVRRWZySnYwK3l2MTl5dGdG?=
 =?utf-8?B?eW9LTTZkMlh2KzdzTWF5Q0ZtYkxkYWVjeExDRGxSVHVJVytNdE1OREl0Skhk?=
 =?utf-8?B?N21uYjBodnhoTHVwNk9zZWxQczQvc0kyYkVMWURWT2ZzbkdwaUNRNGhrWG16?=
 =?utf-8?B?TjNBdUxWbks0SWdQL25DNkE5S3huNmR4ZTJFTVRGTzJ5Z0ZQdEo2cnhUOUwx?=
 =?utf-8?B?RzlpZ0ZydFBkdXJJMG9jNklVaVltZlIzaHR6WlZRaHZic0RQQjFzeWw0YmMx?=
 =?utf-8?B?Yk4waTk5bFdyWGJWTm5YazJTd3dVZkY1TzJuaWlidExWUkZtSTF0cDNKQ2hn?=
 =?utf-8?B?VVNTb1JweklHeG5MaDdyb0V5d005Q0dEcjlTWVhVOHNKZkdWTFlUdU40SnQx?=
 =?utf-8?B?SmdNYXR4REkyZi9UdWhuUDMzZ3JSK3hHenByRzNYcm90NnVSTGdkd0l0Ymg4?=
 =?utf-8?B?UlRtVE9nMjFRMkd4dWs5M0JNOGNWTFRHQTlXbVdyNTkrZWdtYzMvbGxlb2ZY?=
 =?utf-8?B?UHZ0YXdkRFlJakdtT2hQcTdOSDE3Z0M1ZENvYXArU1YzNE9Sc3RhRW9yUjRG?=
 =?utf-8?B?em1RNFlpbkpldFRmdFlNTjJKZEJFM0twTTdRUkV6VUJCSm5nY2tQS3RFK0dD?=
 =?utf-8?B?T2JUeXgwWTI0QUptcEMxT0tiVGpTVVk1amRlc0NTb0JXeWVxUng3c1NEaTdU?=
 =?utf-8?B?bDN4VXBpOE1TQ2U2YWQybFNjdTVKOWdsMFNLbEJBQVZiYnlyOG1YOXhIVjJF?=
 =?utf-8?B?VSt3VFlCaVNKby9qbm5wWW9xMkhoWmhPNmQrdmF0dnRnbkE3Y0hRZ2lwckEv?=
 =?utf-8?B?R3NVVG9PbGtvZDZwR1E2REhoS3RycWJZeFlodnVuVWxrNUZraGxZN2F6a0g3?=
 =?utf-8?B?TEJVNUtxTC9CYk5vNUlEa3RiS1pmeHlNREZCbG0xOStPU2JWTkNPaWZxNDB3?=
 =?utf-8?B?WGZ4dmNsc2pVTE5BSXFaZVYwWUh2UTVFeGJOdWhETHMyaEVlb0UraGpFcG81?=
 =?utf-8?B?cERWYUprb1BkZmk3VTJhTzJJRncrSVBkOCtjQlF3WXVxRXZGbW4rb0xRSW1l?=
 =?utf-8?B?bnp4MW4yVGhKUGJNeGV6OStJczNuT00wWXFhcGVSNlhRcWNBUSt5SVNNSnZW?=
 =?utf-8?B?eVRXNFh6RTlPdmwzQ01nSjI1NmNjQkRvbnhOL1pGaHA5Y25OR0Q2S0Zyb1RL?=
 =?utf-8?B?L0o4WFRtOGZQSUduWWhFaW5oZHJyUXdOYmRBR2VpRjFQMnM0d2xSejBnQTNP?=
 =?utf-8?B?b0hPYWxaY3RmZXN5eC9YSDdRVHBXci9QdnFxSlg0MGRVTUxyb3FNVW1jTTRZ?=
 =?utf-8?B?aVY1cFg1Rk42eS9DYUVIVGIxZ1dJZU5nQjBjeFdOcDdKUWlxOVJBRFV5OGc0?=
 =?utf-8?B?ZFArSTI3Y3FHM2EyT1RXREVZYWdIcHNVcVRQc2J5ckRDRXlFT0x6dk55Wkk1?=
 =?utf-8?B?T3JZd3NFeWlMY0VUcUhCQnFFNXI4b2hQaitybmZzWDZWTnpUOFlsWVVQM1lP?=
 =?utf-8?B?aVNzZGRPVmNwamw5RFM4aFU1VkxHOTlCNmhWbzBud0J5empNZjhiNXo3cEhT?=
 =?utf-8?B?UjVxVEFHYTVyUy9JRlpyMnU3N0N1SHJOc1V4R2ZuaG1hbWJrSktKV2hTMmFJ?=
 =?utf-8?B?ajRvZXFvejZCL3B5SVU5MjMvY3FEUjZKYmNZSzdpakdidDFiWjBlOGlhVU5h?=
 =?utf-8?B?SXpkSk5WL2lDZVQ2REJSRTIxNlFlbEtUSDQzcVZrdGticVAra2pGR0tadUN5?=
 =?utf-8?B?aVo2RmRWdjU5ZCtvckMvQW5GOFJ3PT0=?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 11:42:21.5770 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6f06f4-7beb-4ab1-92e8-08de58e223b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6639
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/vfio/container.c           | 2 +-
 hw/vfio/device.c              | 9 +++++++++
 hw/vfio/listener.c            | 4 ++--
 include/hw/vfio/vfio-device.h | 3 +++
 4 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index af16cd14db..4c2816b574 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -205,7 +205,7 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
     feature->flags = VFIO_DEVICE_FEATURE_GET |
                      VFIO_DEVICE_FEATURE_DMA_LOGGING_REPORT;
 
-    return vbasedev->io_ops->device_feature(vbasedev, feature);
+    return vfio_device_get_feature(vbasedev, feature);
 }
 
 static int vfio_container_iommu_query_dirty_bitmap(
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 086f20f676..973fc35b59 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -547,6 +547,15 @@ bool vfio_device_get_host_iommu_quirk_bypass_ro(VFIODevice *vbasedev,
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
index 8ba1cd255d..1087fdc142 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -909,7 +909,7 @@ static void vfio_devices_dma_logging_stop(VFIOContainer *bcontainer)
             continue;
         }
 
-        ret = vbasedev->io_ops->device_feature(vbasedev, feature);
+        ret = vfio_device_get_feature(vbasedev, feature);
 
         if (ret != 0) {
             warn_report("%s: Failed to stop DMA logging, err %d (%s)",
@@ -1014,7 +1014,7 @@ static bool vfio_devices_dma_logging_start(VFIOContainer *bcontainer,
             continue;
         }
 
-        ret = vbasedev->io_ops->device_feature(vbasedev, feature);
+        ret = vfio_device_get_feature(vbasedev, feature);
         if (ret) {
             error_setg_errno(errp, -ret, "%s: Failed to start DMA logging",
                              vbasedev->name);
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index f6f3d0e378..35a5ec6d92 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -272,6 +272,9 @@ bool vfio_device_get_host_iommu_quirk_bypass_ro(VFIODevice *vbasedev,
                                                 uint32_t type, void *caps,
                                                 uint32_t size);
 
+int vfio_device_get_feature(VFIODevice *vbasedev,
+                            struct vfio_device_feature *feature);
+
 int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
                                 struct vfio_region_info **info);
 int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
-- 
2.43.0


