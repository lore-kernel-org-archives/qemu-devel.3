Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81251CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEmmX-0006KO-1D; Fri, 31 Oct 2025 06:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmlr-0004b5-Qq; Fri, 31 Oct 2025 06:54:17 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmli-0002yN-8c; Fri, 31 Oct 2025 06:54:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pcr70hpb9dGKC3TdiHM73NpDCP5asJwSP09KHjcL74F0CjJU8f/li0ipC7BwygTinau9v8IGJJRcEB5tzlbkfBfPNRsv+kqrEzzwSq72xx+2UwJyDmd7j4T/WjUXmU5T/ATUI9JdZc7Vaw5agyXY0ktXwAcRlWCfHQV3EsxGe6X25lwtOoIczgsUW8n+MW8Ds0l+3A2jypqaSWqVz0OAmwdUpXF5QxWoqQ21xqfrChGSQ8Em5H/LKfS4EvBxsF+J5WW8SUQZs4kE7bZAkuNL+vl3oLDTjR3tZop6CRGJrEIkhYTEYMbsD7LHtBfIC+lZSKlvxoeNtk5OZdPwk1JMFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HD/grpbbGtyJTNtddlw+D9zZYbJ6z0DvrZ2KRKuQRTw=;
 b=Yrptgb9evCt++RUMPzrNhFL5W2DftwJFC6EhodMgJXA3LgQ111seV5XvGh8Q+hlSGSjUq4l73aDHe/ryFBNKFRE0JguPqFTENplN42zqE2fUZ+SrWqye9WnDcEsswDFklj0pp8JCO2Qt7epFWsHNIMxm9MrUtGPuolUWecEOFG8LT1rI+c57tAXbR+mXEO5NeCMp7RbEp6SYwkuFprPQ5zxXVyxnvkA0n1F186rk/JnkJ+alkGT8LhfX0zKCA5M07YhJssMH1LYPg9fdOR3vWS7shmDEg05ZRZbVJS8bmy46Jo3S3jPcJcSK/WMsNe3rQr0qpdCraSCOzAQnSNU/oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HD/grpbbGtyJTNtddlw+D9zZYbJ6z0DvrZ2KRKuQRTw=;
 b=KVgn/OLQPbGyiU21YvtH5TC8jCGgQlVaMd7OymodF9AxC0gB276GGp9ip1VX4NJWIqErcRzFXnQXGub6x+76t94Svzizi4TWd//V1zW/pjuihELxfh7cWV/urKeN1+5ECKuVr/e6CTsTZjm5Anap1n7x598Lcy5y65QJfJDl2t3078Pf6r7Bip4KUNfJwYuLX/pSBsw0oj32Ccvpq9SjdFsWzezpkMDmqh2wmafpUIGwJaR4awPUQDJfFcB3sXeEAE5ddLR4vywnG7it2yXqgGns03XCpi0c4PWIz+S1yT5D7cv5N8KRzd5HvBg7z0JQli5cuSoe6lFiz+tdNNsxFg==
Received: from PH7P221CA0040.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::24)
 by MN6PR12MB8514.namprd12.prod.outlook.com (2603:10b6:208:474::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 10:53:44 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:510:33c:cafe::f) by PH7P221CA0040.outlook.office365.com
 (2603:10b6:510:33c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 10:53:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 10:53:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:53:36 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:53:32 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v5 13/32] hw/arm/smmuv3-accel: Add nested vSTE
 install/uninstall support
Date: Fri, 31 Oct 2025 10:49:46 +0000
Message-ID: <20251031105005.24618-14-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031105005.24618-1-skolothumtho@nvidia.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|MN6PR12MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f063ea2-3894-48d7-baad-08de186bc30a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|7416014|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eK4XfNFgcsSGA70jcQrqe23ie7wMF+/ySUxhufT6pefMmDnyLhucndI5wYoO?=
 =?us-ascii?Q?cvHFLsytTkVQUzuFnsz/XaucbAw8COlM7/jvXjAA/IXKxUat/p7/pCYKga2Z?=
 =?us-ascii?Q?PilfGD2goreu4sA9+mKVPGIv1pudVI36Kn4LHayG52sm8fRBr2YfukVVUUB7?=
 =?us-ascii?Q?jvc+01q1eTYBmZkXsaGXls1dt8UGkVLs80B/DP37DqED7JXTHr8OEBPP9/ky?=
 =?us-ascii?Q?nrpd8tWJ4DPLlqdBKy22nwtPvghDyj+4QfziF4eZ+2dC93DxynZllhPcwZTZ?=
 =?us-ascii?Q?v51c73ikrGVazdXQoLnJRzaLzxA7ClhJ1mPqk4zp/hq7Ewy8kcTyP82Urnbb?=
 =?us-ascii?Q?BnWJqfSsB9iZpgJ5WyyepkY9yZK0jBEVY8AVZ1Gak1uBvBXzzUPoeVBfSoTi?=
 =?us-ascii?Q?JL+AIeZ8tpnX5gjvdzy1rLnvuHbl7mZzw3TT9TZZuvdYFyESG9PoH1+gODOG?=
 =?us-ascii?Q?3CuUeCq8vpnrxYCJT3oc32+jeS3en5PiHs56kSDtLd6eOEVlVrIWV2m/bVmi?=
 =?us-ascii?Q?ApujXqaLmU2kz4l7KnDTYsBNkV3iPWYbG3qoVuLX+Pm8yN7cxbxjt6MJJ/kN?=
 =?us-ascii?Q?tJIffaEjk6Vph9ue1SeMrgVzhdPsFhoZBOS4rHduur9qtOeqfmQH5+nug5W2?=
 =?us-ascii?Q?EPLGUsrK+T4jSi6Nmuu6zFoJZkgUw3G33rdcXruiYVKYuvuCCYrdckh8jF7Z?=
 =?us-ascii?Q?PgsqQCMCsqxite3KJQpDHQX+UWM6w+oDP2JkgPuUw6MxV4pljzXstFNmigVd?=
 =?us-ascii?Q?WK0cFylyAmgr6IJ+Y6DHd9gKQ1govrFpGKFiSqWwHdqMpb5/morBVXLNvW7x?=
 =?us-ascii?Q?j1L3h+v55ZCBAuooyzHxTDWVjwJ/QYD2Oc8AJ2ELjqzHMyIej/OJOta9JWsy?=
 =?us-ascii?Q?JHJIg+yfkswzd14oEkidMb8eLG4f6Zo60E1luH+2/52qrL32kzrXZbSNtwUt?=
 =?us-ascii?Q?KMYcn/v3s11uV49WJ/moukbHwio3guTJULhYE5xRhJFjKi4TnLrhWdTr+TCi?=
 =?us-ascii?Q?Cq/7HaqfnF3Fb0gg6nGE71RXN6CWvyNcK9dkvQGcfTaoCSSPkjsndEv8kgRu?=
 =?us-ascii?Q?0f/L32BkarTxQl2pVlaqfbpqfjQwMqebW2/t3F5XlrTRO0LE9LozeWdUdPd1?=
 =?us-ascii?Q?a5qONqHgqMt47Vc50JAufaJ4PEOzj8kRkbh3FYJqSfmfH0ev+xCYJmvE1XWe?=
 =?us-ascii?Q?EzYLpghdAdP0qdMHQ92+v+KHAcaOYScsmP/x40nPl6q4YHZ0SWVf+hjsCuVN?=
 =?us-ascii?Q?PURPXeABCiBLyVT6M6oz/mDVW5UebTmWwwMs5U1sxJUKVv08/IAdXWe4iu9U?=
 =?us-ascii?Q?4L/S31p30psD8zI22YRqutkyovXpMdyGK894ocbA1105noyfMpscgipPsE/F?=
 =?us-ascii?Q?lH5G5rMGDFDBas5vKuWCGuWk28CGcb7XQYKd8FwRr+w3THz2wTr55icM8I0A?=
 =?us-ascii?Q?bDGm727rq++EdiAJjh01TT8pxHkvFjw5Wi/gc4txxBJgLy3NTPSPa5ghW8NX?=
 =?us-ascii?Q?FC3p6Xo7cE9RGAPukKsrMUXq6G+FCP55OK7Ox1N12bITG/n7epZxbwZLYcda?=
 =?us-ascii?Q?DccNDNZ4UgTe7sQbtkQ=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:53:44.4830 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f063ea2-3894-48d7-baad-08de186bc30a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8514
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
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

From: Nicolin Chen <nicolinc@nvidia.com>

A device placed behind a vSMMU instance must have corresponding vSTEs
(bypass, abort, or translate) installed. The bypass and abort proxy nested
HWPTs are pre-allocated.

For translat HWPT, a vDEVICE object is allocated and associated with the
vIOMMU for each guest device. This allows the host kernel to establish a
virtual SID to physical SID mapping, which is required for handling
invalidations and event reporting.

An translate HWPT is allocated based on the guest STE configuration and
attached to the device when the guest issues SMMU_CMD_CFGI_STE or
SMMU_CMD_CFGI_STE_RANGE, provided the STE enables S1 translation.

If the guest STE is invalid or S1 translation is disabled, the device is
attached to one of the pre-allocated ABORT or BYPASS HWPTs instead.

While at it, export both smmu_find_ste() and smmuv3_flush_config() for
use here.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c    | 193 +++++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h    |  23 +++++
 hw/arm/smmuv3-internal.h |  20 ++++
 hw/arm/smmuv3.c          |  18 +++-
 hw/arm/trace-events      |   2 +
 5 files changed, 253 insertions(+), 3 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index d4d65299a8..c74e95a0ea 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -28,6 +28,191 @@ MemoryRegion root;
 MemoryRegion sysmem;
 static AddressSpace *shared_as_sysmem;
 
+static bool
+smmuv3_accel_alloc_vdev(SMMUv3AccelDevice *accel_dev, int sid, Error **errp)
+{
+    SMMUViommu *vsmmu = accel_dev->vsmmu;
+    IOMMUFDVdev *vdev;
+    uint32_t vdevice_id;
+
+    if (!accel_dev->idev || accel_dev->vdev) {
+        return true;
+    }
+
+    if (!iommufd_backend_alloc_vdev(vsmmu->iommufd, accel_dev->idev->devid,
+                                    vsmmu->viommu.viommu_id, sid,
+                                    &vdevice_id, errp)) {
+            return false;
+    }
+    if (!host_iommu_device_iommufd_attach_hwpt(accel_dev->idev,
+                                               vsmmu->bypass_hwpt_id, errp)) {
+        iommufd_backend_free_id(vsmmu->iommufd, vdevice_id);
+        return false;
+    }
+
+    vdev = g_new(IOMMUFDVdev, 1);
+    vdev->vdevice_id = vdevice_id;
+    vdev->virt_id = sid;
+    accel_dev->vdev = vdev;
+    return true;
+}
+
+static bool
+smmuv3_accel_dev_uninstall_nested_ste(SMMUv3AccelDevice *accel_dev, bool abort,
+                                      Error **errp)
+{
+    HostIOMMUDeviceIOMMUFD *idev = accel_dev->idev;
+    SMMUS1Hwpt *s1_hwpt = accel_dev->s1_hwpt;
+    uint32_t hwpt_id;
+
+    if (!s1_hwpt || !accel_dev->vsmmu) {
+        return true;
+    }
+
+    if (abort) {
+        hwpt_id = accel_dev->vsmmu->abort_hwpt_id;
+    } else {
+        hwpt_id = accel_dev->vsmmu->bypass_hwpt_id;
+    }
+
+    if (!host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp)) {
+        return false;
+    }
+    trace_smmuv3_accel_uninstall_nested_ste(smmu_get_sid(&accel_dev->sdev),
+                                            abort ? "abort" : "bypass",
+                                            hwpt_id);
+
+    iommufd_backend_free_id(s1_hwpt->iommufd, s1_hwpt->hwpt_id);
+    accel_dev->s1_hwpt = NULL;
+    g_free(s1_hwpt);
+    return true;
+}
+
+static bool
+smmuv3_accel_dev_install_nested_ste(SMMUv3AccelDevice *accel_dev,
+                                    uint32_t data_type, uint32_t data_len,
+                                    void *data, Error **errp)
+{
+    SMMUViommu *vsmmu = accel_dev->vsmmu;
+    SMMUS1Hwpt *s1_hwpt = accel_dev->s1_hwpt;
+    HostIOMMUDeviceIOMMUFD *idev = accel_dev->idev;
+    uint32_t flags = 0;
+
+    if (!idev || !vsmmu) {
+        error_setg(errp, "Device 0x%x has no associated IOMMU dev or vIOMMU",
+                   smmu_get_sid(&accel_dev->sdev));
+        return false;
+    }
+
+    if (s1_hwpt) {
+        if (!smmuv3_accel_dev_uninstall_nested_ste(accel_dev, true, errp)) {
+            return false;
+        }
+    }
+
+    s1_hwpt = g_new0(SMMUS1Hwpt, 1);
+    s1_hwpt->iommufd = idev->iommufd;
+    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
+                                    vsmmu->viommu.viommu_id, flags,
+                                    data_type, data_len, data,
+                                    &s1_hwpt->hwpt_id, errp)) {
+        return false;
+    }
+
+    if (!host_iommu_device_iommufd_attach_hwpt(idev, s1_hwpt->hwpt_id, errp)) {
+        iommufd_backend_free_id(idev->iommufd, s1_hwpt->hwpt_id);
+        return false;
+    }
+    accel_dev->s1_hwpt = s1_hwpt;
+    return true;
+}
+
+bool
+smmuv3_accel_install_nested_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
+                                Error **errp)
+{
+    SMMUv3AccelDevice *accel_dev;
+    SMMUEventInfo event = {.type = SMMU_EVT_NONE, .sid = sid,
+                           .inval_ste_allowed = true};
+    struct iommu_hwpt_arm_smmuv3 nested_data = {};
+    uint64_t ste_0, ste_1;
+    uint32_t config;
+    STE ste;
+    int ret;
+
+    if (!s->accel) {
+        return true;
+    }
+
+    accel_dev = container_of(sdev, SMMUv3AccelDevice, sdev);
+    if (!accel_dev->vsmmu) {
+        return true;
+    }
+
+    if (!smmuv3_accel_alloc_vdev(accel_dev, sid, errp)) {
+        return false;
+    }
+
+    ret = smmu_find_ste(sdev->smmu, sid, &ste, &event);
+    if (ret) {
+        error_setg(errp, "Failed to find STE for Device 0x%x", sid);
+        return true;
+    }
+
+    config = STE_CONFIG(&ste);
+    if (!STE_VALID(&ste) || !STE_CFG_S1_ENABLED(config)) {
+        if (!smmuv3_accel_dev_uninstall_nested_ste(accel_dev,
+                                                   STE_CFG_ABORT(config),
+                                                   errp)) {
+            return false;
+        }
+        smmuv3_flush_config(sdev);
+        return true;
+    }
+
+    ste_0 = (uint64_t)ste.word[0] | (uint64_t)ste.word[1] << 32;
+    ste_1 = (uint64_t)ste.word[2] | (uint64_t)ste.word[3] << 32;
+    nested_data.ste[0] = cpu_to_le64(ste_0 & STE0_MASK);
+    nested_data.ste[1] = cpu_to_le64(ste_1 & STE1_MASK);
+
+    if (!smmuv3_accel_dev_install_nested_ste(accel_dev,
+                                             IOMMU_HWPT_DATA_ARM_SMMUV3,
+                                             sizeof(nested_data),
+                                             &nested_data, errp)) {
+        error_append_hint(errp, "Unable to install sid=0x%x nested STE="
+                          "0x%"PRIx64":=0x%"PRIx64"", sid,
+                          (uint64_t)le64_to_cpu(nested_data.ste[1]),
+                          (uint64_t)le64_to_cpu(nested_data.ste[0]));
+        return false;
+    }
+    trace_smmuv3_accel_install_nested_ste(sid, nested_data.ste[1],
+                                          nested_data.ste[0]);
+    return true;
+}
+
+bool smmuv3_accel_install_nested_ste_range(SMMUv3State *s, SMMUSIDRange *range,
+                                           Error **errp)
+{
+    SMMUv3AccelState *s_accel = s->s_accel;
+    SMMUv3AccelDevice *accel_dev;
+
+    if (!s_accel || !s_accel->vsmmu) {
+        return true;
+    }
+
+    QLIST_FOREACH(accel_dev, &s_accel->vsmmu->device_list, next) {
+        uint32_t sid = smmu_get_sid(&accel_dev->sdev);
+
+        if (sid >= range->start && sid <= range->end) {
+            if (!smmuv3_accel_install_nested_ste(s, &accel_dev->sdev,
+                                                 sid, errp)) {
+                return false;
+            }
+        }
+    }
+    return true;
+}
+
 static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
                                                PCIBus *bus, int devfn)
 {
@@ -154,6 +339,7 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
     SMMUv3State *s = ARM_SMMUV3(bs);
     SMMUPciBus *sbus = g_hash_table_lookup(bs->smmu_pcibus_by_busptr, bus);
     SMMUv3AccelDevice *accel_dev;
+    IOMMUFDVdev *vdev;
     SMMUViommu *vsmmu;
     SMMUDevice *sdev;
     uint16_t sid;
@@ -182,6 +368,13 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
     trace_smmuv3_accel_unset_iommu_device(devfn, sid);
 
     vsmmu = s->s_accel->vsmmu;
+    vdev = accel_dev->vdev;
+    if (vdev) {
+        iommufd_backend_free_id(vsmmu->iommufd, vdev->vdevice_id);
+        g_free(vdev);
+        accel_dev->vdev = NULL;
+    }
+
     if (QLIST_EMPTY(&vsmmu->device_list)) {
         iommufd_backend_free_id(vsmmu->iommufd, vsmmu->bypass_hwpt_id);
         iommufd_backend_free_id(vsmmu->iommufd, vsmmu->abort_hwpt_id);
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index d81f90c32c..73b44cd7be 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -27,9 +27,16 @@ typedef struct SMMUViommu {
     QLIST_HEAD(, SMMUv3AccelDevice) device_list;
 } SMMUViommu;
 
+typedef struct SMMUS1Hwpt {
+    IOMMUFDBackend *iommufd;
+    uint32_t hwpt_id;
+} SMMUS1Hwpt;
+
 typedef struct SMMUv3AccelDevice {
     SMMUDevice sdev;
     HostIOMMUDeviceIOMMUFD *idev;
+    SMMUS1Hwpt *s1_hwpt;
+    IOMMUFDVdev *vdev;
     SMMUViommu *vsmmu;
     QLIST_ENTRY(SMMUv3AccelDevice) next;
 } SMMUv3AccelDevice;
@@ -40,10 +47,26 @@ typedef struct SMMUv3AccelState {
 
 #ifdef CONFIG_ARM_SMMUV3_ACCEL
 void smmuv3_accel_init(SMMUv3State *s);
+bool smmuv3_accel_install_nested_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
+                                     Error **errp);
+bool smmuv3_accel_install_nested_ste_range(SMMUv3State *s, SMMUSIDRange *range,
+                                           Error **errp);
 #else
 static inline void smmuv3_accel_init(SMMUv3State *s)
 {
 }
+static inline bool
+smmuv3_accel_install_nested_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
+                                Error **errp)
+{
+    return true;
+}
+static inline bool
+smmuv3_accel_install_nested_ste_range(SMMUv3State *s, SMMUSIDRange *range,
+                                      Error **errp)
+{
+    return true;
+}
 #endif
 
 #endif /* HW_ARM_SMMUV3_ACCEL_H */
diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 03d86cfc5c..5fd88b4257 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -547,6 +547,9 @@ typedef struct CD {
     uint32_t word[16];
 } CD;
 
+int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event);
+void smmuv3_flush_config(SMMUDevice *sdev);
+
 /* STE fields */
 
 #define STE_VALID(x)   extract32((x)->word[0], 0, 1)
@@ -586,6 +589,23 @@ typedef struct CD {
 #define SMMU_STE_VALID      (1ULL << 0)
 #define SMMU_STE_CFG_BYPASS (1ULL << 3)
 
+#define STE0_V       MAKE_64BIT_MASK(0, 1)
+#define STE0_CONFIG  MAKE_64BIT_MASK(1, 3)
+#define STE0_S1FMT   MAKE_64BIT_MASK(4, 2)
+#define STE0_CTXPTR  MAKE_64BIT_MASK(6, 50)
+#define STE0_S1CDMAX MAKE_64BIT_MASK(59, 5)
+#define STE0_MASK    (STE0_S1CDMAX | STE0_CTXPTR | STE0_S1FMT | STE0_CONFIG | \
+                      STE0_V)
+
+#define STE1_S1DSS    MAKE_64BIT_MASK(0, 2)
+#define STE1_S1CIR    MAKE_64BIT_MASK(2, 2)
+#define STE1_S1COR    MAKE_64BIT_MASK(4, 2)
+#define STE1_S1CSH    MAKE_64BIT_MASK(6, 2)
+#define STE1_S1STALLD MAKE_64BIT_MASK(27, 1)
+#define STE1_EATS     MAKE_64BIT_MASK(28, 2)
+#define STE1_MASK     (STE1_EATS | STE1_S1STALLD | STE1_S1CSH | STE1_S1COR | \
+                       STE1_S1CIR | STE1_S1DSS)
+
 #define SMMU_GBPA_ABORT (1UL << 20)
 
 static inline int oas2bits(int oas_field)
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index ef991cb7d8..1fd8aaa0c7 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -630,8 +630,7 @@ bad_ste:
  * Supports linear and 2-level stream table
  * Return 0 on success, -EINVAL otherwise
  */
-static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
-                         SMMUEventInfo *event)
+int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event)
 {
     dma_addr_t addr, strtab_base;
     uint32_t log2size;
@@ -900,7 +899,7 @@ static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event)
     return cfg;
 }
 
-static void smmuv3_flush_config(SMMUDevice *sdev)
+void smmuv3_flush_config(SMMUDevice *sdev)
 {
     SMMUv3State *s = sdev->smmu;
     SMMUState *bc = &s->smmu_state;
@@ -1330,6 +1329,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
         {
             uint32_t sid = CMD_SID(&cmd);
             SMMUDevice *sdev = smmu_find_sdev(bs, sid);
+            Error *local_err = NULL;
 
             if (CMD_SSEC(&cmd)) {
                 cmd_error = SMMU_CERROR_ILL;
@@ -1341,6 +1341,11 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
             }
 
             trace_smmuv3_cmdq_cfgi_ste(sid);
+            if (!smmuv3_accel_install_nested_ste(s, sdev, sid, &local_err)) {
+                error_report_err(local_err);
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
             smmuv3_flush_config(sdev);
 
             break;
@@ -1350,6 +1355,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
             uint32_t sid = CMD_SID(&cmd), mask;
             uint8_t range = CMD_STE_RANGE(&cmd);
             SMMUSIDRange sid_range;
+            Error *local_err = NULL;
 
             if (CMD_SSEC(&cmd)) {
                 cmd_error = SMMU_CERROR_ILL;
@@ -1361,6 +1367,12 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
             sid_range.end = sid_range.start + mask;
 
             trace_smmuv3_cmdq_cfgi_ste_range(sid_range.start, sid_range.end);
+            if (!smmuv3_accel_install_nested_ste_range(s, &sid_range,
+                                                       &local_err)) {
+                error_report_err(local_err);
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
             smmu_configs_inv_sid_range(bs, sid_range);
             break;
         }
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 49c0460f30..2e0b1f8f6f 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -69,6 +69,8 @@ smmu_reset_exit(void) ""
 #smmuv3-accel.c
 smmuv3_accel_set_iommu_device(int devfn, uint32_t sid) "devfn=0x%x (idev devid=0x%x)"
 smmuv3_accel_unset_iommu_device(int devfn, uint32_t sid) "devfn=0x%x (idev devid=0x%x)"
+smmuv3_accel_install_nested_ste(uint32_t sid, uint64_t ste_1, uint64_t ste_0) "sid=%d ste=%"PRIx64":%"PRIx64
+smmuv3_accel_uninstall_nested_ste(uint32_t sid, const char *ste_cfg, uint32_t hwpt_id) "sid=%d attached %s hwpt_id=%u"
 
 # strongarm.c
 strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
-- 
2.43.0


