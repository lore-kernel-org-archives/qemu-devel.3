Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEAA3CF885A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 13:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM4fi-000333-9f; Thu, 20 Nov 2025 08:26:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4fc-0002eD-Bu; Thu, 20 Nov 2025 08:25:56 -0500
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4fZ-0002gE-Vq; Thu, 20 Nov 2025 08:25:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=auibkVuhLLUKTAEV5Oni1RhCBiywN4tSqjJ4b3/tvJu1wOfPoSrHR5pH2RFMI0jO/PK4sfKRJbGDgh92wa3ucCNT0AI9TeHDvjEQHIxpfJPyen7muvsYfT2FSY79VDhE4hzou+GXGhxW0l1wHzGSO7xLVXgoFRTj7IOiJNtk/g7bVdtPYiok7GZeUmwimUX3OofcqfcqO6/trTmgCB2oUUepR1oEQGNNKnbWPl1IoGjQ+sobTM6fmCfO4oaCmtcZ/pbG6ZTuEkfgoGflUI6QU4SK20HWgQ1A9oczEOQknnnQdxtRLeBRwUBF8aM9OI3GMTSjzUSTcIc0T9a9SMHeMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aClLKcKJOVJUt37ETCieMfkPsAJSDlqv9CIn/ZWTdx8=;
 b=KeGrmSrKr69Gw4W6SBsjy6UK4LfPkwsHsCuIAiunDfbiLoyuB/6Zz85wMdbNVctSEwQQpcK9bNI+e82+4LWWdTV3n5fv4UmI0rW3mjeTd7GPHiHcTQQqQ9OCko/LQCfqofm2+8ojNP567DDGtGPvOnut/4RKztpERQHaehQLv1I21+tk2wx/6I1eZpwVpIz9tG4yNc/nGc1eogt5JvX5TRpon/dode+3HhV5OFxwrWrPOinVOkbsLLTaz+UzI1R87QomQaT3AmirRaenfrAUUaDd32yx1n40X8wuIArUWWMkjZ14KmIiCfu6gsoH1KwDJgxNqaWLnXkER1QO48rJ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aClLKcKJOVJUt37ETCieMfkPsAJSDlqv9CIn/ZWTdx8=;
 b=ZrLpYvtVPh53VrFqTBx0uFOUwbf5xbhI2dJwO5KcuVJWCpsJycAT6NAzZLDttB1AQBi4EpQ7fQDQWdqp2VvIXwmUbOx9UdJPYcMAS4LbdZEz2la3eJnhjl/6nDa08hXO7QxaRNVcTUwnnKyrsaIxYppxB3wpfvFt+dhLIAsLy28BYPdmzB+eGBu7mw4RwXFlnVDU/1M4Jyn3BfKrjUIc/N8fTBzb0lBQSYUV/d97RIwOyAT+P/uv4FiWOODcaVjPAjuM/8K4jr66wwhVFxy5J2um31JyKwrCR24GD4dpe6OLuqfS6pRptcF1q4MGrQeA6No2lyXgPDCUI+QDN1AFmQ==
Received: from BY3PR10CA0021.namprd10.prod.outlook.com (2603:10b6:a03:255::26)
 by DS2PR12MB9709.namprd12.prod.outlook.com (2603:10b6:8:276::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 13:25:46 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::65) by BY3PR10CA0021.outlook.office365.com
 (2603:10b6:a03:255::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 13:25:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:25:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:25:27 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:25:23 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v6 30/33] backends/iommufd: Retrieve PASID width from
 iommufd_backend_get_device_info()
Date: Thu, 20 Nov 2025 13:22:10 +0000
Message-ID: <20251120132213.56581-31-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120132213.56581-1-skolothumtho@nvidia.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|DS2PR12MB9709:EE_
X-MS-Office365-Filtering-Correlation-Id: beeefe29-5057-47c7-208b-08de2838504e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lpWrUn82jp8IfwMQvQRYFjt8mrSajrm9XmDxPTeXIIzcbwWamQa3NB35bUX9?=
 =?us-ascii?Q?h1df2+euUFHq+o59qPwI+cDWNm+lpHz1pmZMozF+YKptul+eb2vL8YCP5B7l?=
 =?us-ascii?Q?XSmk6f7dWWL34zMm5OmmUWbmFb7i8fBhIMGS5Vs0G+uaLHBIum6CNg9NB+g5?=
 =?us-ascii?Q?tzSiU29qfpsUm5Td8GXvOBukc7t6Rwnwnh6LIXypJ2JH7wd2lEtecYWH4m0Y?=
 =?us-ascii?Q?hdJ52EZYMgPJ/NpZka6ln/ZV4VbaPYu/kBXNDVV2ZtJFVobI69InT6VvU0s+?=
 =?us-ascii?Q?he8jwJJ95jmGFz4Xo7p284U4x6N0yPa87Lzizo/YbpJHk5XGzZHVQtKNlsse?=
 =?us-ascii?Q?ZvL7WbFVZeirYDMZxbi8UhB+Nj2nTqPNwcIx8+olg+R0YiEcnQ4gnqzDwFIV?=
 =?us-ascii?Q?aIfyrbN0rZkCXQOnjTlCCSA5e1hyjoqZlgGi7K6ctREa4/sarjX81h47n7cR?=
 =?us-ascii?Q?xjjpbxsMEkhT4venSxl0cwSQQPsyZ7VGlyq9mHL139TzSYmNaeJuHFlvXb7S?=
 =?us-ascii?Q?KAN+9Yb8Afr83UQqglycBPIMFImCxPxDDkJPGigPeHw2UkNUBS9g01dAhCAG?=
 =?us-ascii?Q?5kTRQF25f8WJay8q/SgopmEMXcGNT7YP575YLLOfbeSLkjBKNeOgbNW5qXxx?=
 =?us-ascii?Q?DQis1r0iIcn0idMTxh69pR/08bRsTAvAVB4cC0ejIG1v3HpotLYnxspuYBF+?=
 =?us-ascii?Q?Y3uY5HbrA9Vr9lDpcIetzgGVn1oqoKStAWyGHYWk1ARirCrm5MUu3xnAH95N?=
 =?us-ascii?Q?HEEPSNY6Eo3QU37e1FVkXdnJXIQdBOEWa56sAM3bNZQf9OdIxtZ0Vaq7Evi1?=
 =?us-ascii?Q?C8hqbqqcFeP0DkpBxa/fREgVT4CaCnTpAbzq3rObF1msXpxprZKj+Fi/RbZZ?=
 =?us-ascii?Q?ApKSnJ8n7SJhkK30x2Td2V/PzoV8DRjS0wRAeJ97Psd1CmabxrMona53QlgF?=
 =?us-ascii?Q?o+x2FNC37jFx/Qah1e8Kx5AkNPk6gLStHK/2H8oSebX3z2CjkCLIfQ99IjiL?=
 =?us-ascii?Q?VRZr5Z74fsfZRpZH7yQnvUHNgahxahkkObyUyCxl9q7oUpaoeYb9LcCuBPro?=
 =?us-ascii?Q?wEVQ1FMIxhpUOkwP2usEmFUvbcRhKnU2SNhXG4lb8eWN7v3uI5f7o+DABYYy?=
 =?us-ascii?Q?miYwkL7/Nf3NQaDfPLoOYora4bjSDGH/UiEaKotCDUXoos7IoiXfYZRlKppr?=
 =?us-ascii?Q?SMi+yR+vI74Ig3VjXaDzGkdM3Fku2QvWm8D3ioFtsoLjsMqW3WsyYbo82GaE?=
 =?us-ascii?Q?pLPxsoZZv2DW7FMsPtw2RH9kI7jiLGJeR0eprRol6a4Ss8ifZO2n3n3H1/4J?=
 =?us-ascii?Q?jX5Zy+tayxyCTaaOicFN240uTaQcQePz34cJ0NcLzmPZ1T4D6M05Mfvl3Wcr?=
 =?us-ascii?Q?sTrMe0vnOjp5UhWu0rQafOFT1fgGRBeWk/MBraNxrRwBKbI//ST0fNkJW+/h?=
 =?us-ascii?Q?AGpBNyE+gPFTlNzNQHLI1vkdC0flTjyzFT8FkDcyFM7t7HKnghpI3regkeN0?=
 =?us-ascii?Q?SHrk1Q9ucJLMTx2wyVJ0ncwGJOHw2HIHg0Qyw229KOgUH3HhnFv/Hih0ayFG?=
 =?us-ascii?Q?f6MORJAzoXXpnXJyWI8=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:25:46.3307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: beeefe29-5057-47c7-208b-08de2838504e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9709
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
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

Retrieve PASID width from iommufd_backend_get_device_info() and store it
in HostIOMMUDeviceCaps for later use.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 backends/iommufd.c                 | 6 +++++-
 hw/arm/smmuv3-accel.c              | 3 ++-
 hw/vfio/iommufd.c                  | 7 +++++--
 include/system/host_iommu_device.h | 3 +++
 include/system/iommufd.h           | 3 ++-
 5 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index e68a2c934f..6381f9664b 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -388,7 +388,8 @@ bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
 
 bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
                                      uint32_t *type, void *data, uint32_t len,
-                                     uint64_t *caps, Error **errp)
+                                     uint64_t *caps, uint8_t *max_pasid_log2,
+                                     Error **errp)
 {
     struct iommu_hw_info info = {
         .size = sizeof(info),
@@ -407,6 +408,9 @@ bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
     g_assert(caps);
     *caps = info.out_capabilities;
 
+    if (max_pasid_log2) {
+        *max_pasid_log2 = info.out_max_pasid_log2;
+    }
     return true;
 }
 
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 35a94c720a..254d29ee2d 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -113,7 +113,8 @@ smmuv3_accel_hw_compatible(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
     uint64_t caps;
 
     if (!iommufd_backend_get_device_info(idev->iommufd, idev->devid, &data_type,
-                                         &info, sizeof(info), &caps, errp)) {
+                                         &info, sizeof(info), &caps, NULL,
+                                         errp)) {
         return false;
     }
 
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index ca8a6b7029..bbe944d7cc 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -353,7 +353,8 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
      * instead.
      */
     if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev->devid,
-                                         &type, NULL, 0, &hw_caps, errp)) {
+                                         &type, NULL, 0, &hw_caps, NULL,
+                                         errp)) {
         return false;
     }
 
@@ -889,19 +890,21 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
     HostIOMMUDeviceCaps *caps = &hiod->caps;
     VendorCaps *vendor_caps = &caps->vendor_caps;
     enum iommu_hw_info_type type;
+    uint8_t max_pasid_log2;
     uint64_t hw_caps;
 
     hiod->agent = opaque;
 
     if (!iommufd_backend_get_device_info(vdev->iommufd, vdev->devid, &type,
                                          vendor_caps, sizeof(*vendor_caps),
-                                         &hw_caps, errp)) {
+                                         &hw_caps, &max_pasid_log2, errp)) {
         return false;
     }
 
     hiod->name = g_strdup(vdev->name);
     caps->type = type;
     caps->hw_caps = hw_caps;
+    caps->max_pasid_log2 = max_pasid_log2;
 
     idev = HOST_IOMMU_DEVICE_IOMMUFD(hiod);
     idev->iommufd = vdev->iommufd;
diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
index ab849a4a82..bfb2b60478 100644
--- a/include/system/host_iommu_device.h
+++ b/include/system/host_iommu_device.h
@@ -30,6 +30,8 @@ typedef union VendorCaps {
  * @hw_caps: host platform IOMMU capabilities (e.g. on IOMMUFD this represents
  *           the @out_capabilities value returned from IOMMU_GET_HW_INFO ioctl)
  *
+ * @max_pasid_log2: width of PASIDs supported by host IOMMU device
+ *
  * @vendor_caps: host platform IOMMU vendor specific capabilities (e.g. on
  *               IOMMUFD this represents a user-space buffer filled by kernel
  *               with host IOMMU @type specific hardware information data)
@@ -37,6 +39,7 @@ typedef union VendorCaps {
 typedef struct HostIOMMUDeviceCaps {
     uint32_t type;
     uint64_t hw_caps;
+    uint8_t max_pasid_log2;
     VendorCaps vendor_caps;
 } HostIOMMUDeviceCaps;
 #endif
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index 41e216c677..aa78bf1e1d 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -71,7 +71,8 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
                               hwaddr iova, uint64_t size);
 bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
                                      uint32_t *type, void *data, uint32_t len,
-                                     uint64_t *caps, Error **errp);
+                                     uint64_t *caps, uint8_t *max_pasid_log2,
+                                     Error **errp);
 bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
                                 uint32_t pt_id, uint32_t flags,
                                 uint32_t data_type, uint32_t data_len,
-- 
2.43.0


