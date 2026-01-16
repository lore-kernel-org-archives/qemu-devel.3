Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C4BD4A61E
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 09:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vggB0-0002oP-NH; Fri, 16 Jan 2026 04:31:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vggAy-0002ic-9n; Fri, 16 Jan 2026 04:31:28 -0500
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vggAw-0005Sd-KU; Fri, 16 Jan 2026 04:31:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g67zqSoDM+oW8D4Jk0kb53Z12eY/vj2jBm6JEcE6Xjm13Jb6YaVn0uHqP6cjoQZCNTF77fv+tHR9FXkmxWpa5z3CjAqhscOzpjYYkxVnqDziM12XomG9bdpU6qefSs7hX7QvsXD1mFusmu8/Br0BofR6Gck5gMveuFMfSn69CxQBFLeO7c7f/q5c/0OqHDt0cUmFBMj33mY0Hw7ItxyjIcY1kFbbx2//mlDoKtB7v6AeVObBLlMtXLAe/KMnusIIvYYuQ2QUBJJGEc4ylUiRp5kcjDAOSK1QqDxyY4Fl1EVnlwnl0DGhQqXOsml7wGYtcl6tGPgb9JYlfom2GpoJRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxbB4gZPK1wEdYioADPBR6ZU0eRGSMiTpJZw7HpRG3c=;
 b=cImnLdZZGMFL7Xeb6H4YYkP6H2PfYA9BUBUOgJRlWzli2574GEPRV2v+/BLSHQ3VNRSv5xDvFEiHeT9als/SU9/LrK4n2UhiGVqwpphwQaz4XJCPlKWDkfxIojuxA3STzGIKegRLnthA+bM8l/yUTew85YTGSpe5w8xH44gwzIPmVo+aE972IYao7A06AqWiE7a8THaLxZNEghpuIC+dXCtdKR6c6P8AJ5iVlpsl80FYBzd5i2xoIfm5lx0MsYPVi3+VECJRw39OLPFgKvku/3HQJLa4qCqlER/DRPhuiosKTA7upkTONISGMgSIjmPgAJrqA1LGEog3mfC5Mo3vPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxbB4gZPK1wEdYioADPBR6ZU0eRGSMiTpJZw7HpRG3c=;
 b=DCi3rSYth0M+ZsLDlWIzzWR8hUX9/83eh+kSmKJSEpsIkkZaAdqI1Wq3pQSxK1Y3DTMk43QPx9glYBsOPfffH8mhlYwJo0oTuLPwItEElT5hSjZgAJuq4SYTVZ0AjrIlwlgADrjucu2v2d3F6XTqIH07moJf9Y1BPEqI+i1SbTAjD77WAmlxuYE12nyXWLtwNAiGfGW4tmrVN5x3lmwbu6s4Hyxp4KRjEtoa6vRowvXB9qrIge3ngqakoOwmoSRN5JBIhYCtEO/8tHJwUgFLWY4gXPLOWG2wxdkAuK6QX+4lyWNuXx/BFYyLtGod6NcMibS/ytVx1iP3FE23qaeYAQ==
Received: from BY1P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::12)
 by DS7PR12MB5864.namprd12.prod.outlook.com (2603:10b6:8:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 09:31:18 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:59d:cafe::1b) by BY1P220CA0010.outlook.office365.com
 (2603:10b6:a03:59d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.9 via Frontend Transport; Fri,
 16 Jan 2026 09:31:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 09:31:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 01:31:05 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 01:31:02 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <alex@shazbot.org>, <clg@redhat.com>,
 <cohuck@redhat.com>, <mst@redhat.com>, <nicolinc@nvidia.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <vivek.kasireddy@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v3 3/4] hw/vfio: Add helper to retrieve device feature
Date: Fri, 16 Jan 2026 09:29:48 +0000
Message-ID: <20260116092950.15796-4-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116092950.15796-1-skolothumtho@nvidia.com>
References: <20260116092950.15796-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|DS7PR12MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: eaaad066-5a92-421c-9c72-08de54e2009a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVNTTFI2Tk5mVTMvdDZCcVlTNzgwOExqOWlEVFdybXhvNDBLQ1ZnaXluVXRS?=
 =?utf-8?B?ckh5QUZJNElVZk5yTHpDNERkamFmbWY3anhXU2xJek5wZVZKNkgwa1BRclkz?=
 =?utf-8?B?Yzc4RDUwbzNEU1h6Q1hhZVVpcnh6NXJaQ1crektZWGttY2ZkNHA2V2I5eFVq?=
 =?utf-8?B?VjhvSTUrWmpXdWhwRFhmS0U1S1l5VXdZVk01V24yZUhUM3FpbEdmQjcxeEpu?=
 =?utf-8?B?cXNyM2pYSlZxVVJoRDBDaDRGZkJlakI3KzZ3Q0RvNjA5QU1tc3hpaTlsQk9q?=
 =?utf-8?B?OG5PbEVUVjBLelBVaTJnbWczUnZrR3BDb0I2b3o4KzlzTG5JalVuVWVHcjV2?=
 =?utf-8?B?MlRwRE5kV01LK2FEUVJMRnZwUk5KQU40aW9tNEhWRkI5UFlFblRXaktBc3Zm?=
 =?utf-8?B?TllzcWRiQ3Q4b2Q5dHJkc2MyZFRvWWtZa0lDVVFybXB5SldidjNWMWlVblV3?=
 =?utf-8?B?K1lScXFIZjBjZVRUL1FkVW9CaDJFeHc5ZmU5WUsyVGhnMW1aS3kreGM3NTJX?=
 =?utf-8?B?TjdJbGYrNjI1b0dJcnZrdFNWNXJmWHVlNHdzMTJZQlZrSVVva1d0OHJaa3J6?=
 =?utf-8?B?bDUzTWpSTTByM0ZoYjZUS2VvQnZURXMwVFVrcGg3L3hDTDFROVdqam95cXlx?=
 =?utf-8?B?Yy8zenluTkZpNCt2dXFST3hBU2x0ZXhtUmFaWjVFdDBYZHdncm9XTURveHkv?=
 =?utf-8?B?NHFtNlNoenY0bFg5b1lEb1hDM3ZQS3hPR1RHUzdIYjQ3bEJMdTQrOXJiTS9F?=
 =?utf-8?B?d1lVOEVjK1NwQTZOZ2EvR1R2cWRrazRNdTBnbTlXRWFKelJyblJPbzJneFJY?=
 =?utf-8?B?MDMzT2t4RUNaUXVta2IrRURlMWczWC9EUUQ5Q3h2S0VJQXIvR0h2TXljcktH?=
 =?utf-8?B?UnRnTFc0TDMrSDYzMVpKeXNIRm5TeExBZ2hIV1Bnd1UxOHYrNmg2aTk1NVFw?=
 =?utf-8?B?UFhpajd3bGhwRGxWc3BEbDBSS3NVWHhFaVpUTzZzR0VPV211ZWd6Szd1RGg5?=
 =?utf-8?B?cWNNSzdNZVh1dENkeXNSVVo2R0NSQjZCUVh5TnBtTWRxN0tIWW5DRGhoaDFW?=
 =?utf-8?B?SjVBYVRjeXJpN0wwSVczdTZXcVNMYiszMklvczAyUDN6NnpiSWIyemt4ZDlD?=
 =?utf-8?B?S25zaFdTdmJzQkZnWlN0WWp5TE9adnJ0NEYyNmVndXg3dk1WeUxFb1Jpb3FK?=
 =?utf-8?B?N0NqUm1nUjlIOVVKQUQwM1dMeDkvRGtxSktTMjd0blR0amxtekdvSGtGQml3?=
 =?utf-8?B?VEZXaVRuRTBRbkhVaEdvWUpVMXRBUlBhT3NHZGdua2NmR3QrNkUrQk1ZZ21t?=
 =?utf-8?B?bTJqYUJPbFpBUVpGcjB2Z0UybFJuODcyRnU2SktBZDBua0FPUk4xVndYSU94?=
 =?utf-8?B?QldNNFRKOUNpV1FpbUI2RjFSN3FTM1cyME5DQnVINXJyK01NYXBDbTVVSDV0?=
 =?utf-8?B?QWtVR0VsUEdqQlBxOGNpNzdFc2NyYWlYbHZvM2xTQ2F4T24zWXlzZUUxRzlo?=
 =?utf-8?B?SFQ0d3pHd3R5eUZwdUxFS2NLam5JVE5hUHFlYWkvVzFCeG9xOWEvL0Y2WUpW?=
 =?utf-8?B?MThtazNLdURRcGR1L2pOWVpuQStreXkwekNWRnJPZWJaZDgwMGk5SUV4bFJ4?=
 =?utf-8?B?UmZWUzE4aHJKUkhXK3FBQzZZaVRybzBIWDZNd3NvN09pMXltbjVtbGVHNTlp?=
 =?utf-8?B?Y0JQc2N6cEc0a05nZElkZFJKd1hKbUx5K3IzYzg2K0VuWDRlK1gyeUZMVHVW?=
 =?utf-8?B?NldFUDhTc095OG9SeHNGZGlXT2drbkhCOVNDQWY0elFBYkJ5UEhpTTlZRDdX?=
 =?utf-8?B?bTQ5d3Q2TUF3N080M1MraExTNWJUaS9DY05DSFNCMk9KV2JKWC9TQ2JpaXRG?=
 =?utf-8?B?L0l4eXlhUWhpVHFMaXA2N0dZbCt6WmRjQ1VPb285MmY5MTM3YVVyK0Eyb0c3?=
 =?utf-8?B?UnkwaXpLZ3hwVSs3V1VaL2RwemdyQVBENUt2MzBHN2svVzIwbDlYSEpkK1Nk?=
 =?utf-8?B?UkNXVUxpWnZoLzRKTlN2NVF1ODRLaEJRWE1zQzQ1ek1kSDRqUTRVZC9nM0xH?=
 =?utf-8?B?YWhFaHZoTjg5YUJIQmFqWUlrd0RnaXJWb21qejUyaGkzaU1rcFQ2dXpxMlpj?=
 =?utf-8?B?Vk9Ed240NUdJUkJkdVNGYWMyUmw3aFZvQmUzL2N5SmJXVmdpc1BmYlJmalVq?=
 =?utf-8?B?YjZiaVFtRkpTNlJCenh6VUlqc3RjY3NFKzZWQ1A1YmFmTVlleXBUS3FvZEVI?=
 =?utf-8?B?L3NHcUlIQmRQZFp2ZFFYU2hZbXF3PT0=?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 09:31:18.2186 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eaaad066-5a92-421c-9c72-08de54e2009a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5864
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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


