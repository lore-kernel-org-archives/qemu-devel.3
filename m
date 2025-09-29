Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1EB3CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 13:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3E8k-0003rC-0n; Mon, 29 Sep 2025 09:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E7U-0002mx-OT; Mon, 29 Sep 2025 09:40:49 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E77-0003cB-EE; Mon, 29 Sep 2025 09:40:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ucWRo8pYzGFkgfhy2nZpO4Z/B2YnzBnxMKZjEWNUQA7qjadTP0yWNwSArXnp0S693qT0EA8yzionwRDzsbjb7JGsusJmcDYnBZbpIAxPbLyRWJeiEpFlcp89ax9zkW/ovnOlra4QYHmhxl1p4s46+lm1lqjTmtz1op7RbfDW0NU44tn6eReZshz87PqaVVrOJOA9Q/IDDUVCWtbbFHYhePglHsA05zm3TFuyUjIHviunRJK06//K5ogDpdAFIhwxrLx0hzhw6AZbtpd0DmI+txZKcteAjLA0U7JlNTtNsR0/rgEqyzJ9toIIQfk4WWDF5iRG8Zv6tl9FOzXPOfS2pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvcpXkHkPDtyK4+yBSTvp6sv/OrNQA77Q1GX2pWBzLM=;
 b=m8yoymxxeGNOYw9LIwnchd1acfRZ3KkpBdDrW12kGDNJCYEw4WD27HKHLM7fESw8uBTUuIapzn9cfLe/FWyqOmUMm96IMtwdx9tbRIYVYCTGt69i1ZEMcKSn0JlwDAH8Z24HzHyTePMYW/ExgASSE8s1turw4B1UrtkfYEAp62weedtv5teVAfart0GGplh1nk/fZyYxXQN/qrtO5gZvzCd5G5JkaJtmiS2+5L7bAN2JzwpiD/1Zwu2CpbRghn45mbtmHUGVAGBg344Lfc/EjiQMZJO6mBZen72uSMOSy/guNCHZfEDJvuxWBeHOHrBq1Zm03O7AosDvnGOYE3E/TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvcpXkHkPDtyK4+yBSTvp6sv/OrNQA77Q1GX2pWBzLM=;
 b=oWHTsP/iE1fo+7VlvBp1wtaqwpxj0VsXbIeJtCI6Wd4A3wimrO+dY/1IOvmTgWUDNQmfJtdchZ0ioC70lALdmk5O79LZp05sMquuZoEPpPVV9/2RewpSLhaOQjmCLr2L8P/rFC9Df1648kf5Yl8aFzH79D+5+SRExnWchsqJKrWYFyjpF3HK+43DXFOyE/R/ZVauyPfm3v58TdfIJR88gaXYfyUsmBW1RKd7Y1lEfx5yQoEKchkc2/L7IDAsuVbHElTbXe7ze6GIBMMcCkF/Q1diuxDi1N6KlGcx5oEHCj+35mUVqIVQ8lF82HnYs8TiLo6np5Ctf50YuCRLsS53YA==
Received: from CH2PR20CA0001.namprd20.prod.outlook.com (2603:10b6:610:58::11)
 by DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 13:40:04 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::e2) by CH2PR20CA0001.outlook.office365.com
 (2603:10b6:610:58::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Mon,
 29 Sep 2025 13:40:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 13:40:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 29 Sep
 2025 06:39:45 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Sep
 2025 06:39:41 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: [PATCH v4 10/27] hw/arm/smmuv3-accel: Allocate a vDEVICE object for
 device
Date: Mon, 29 Sep 2025 14:36:26 +0100
Message-ID: <20250929133643.38961-11-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250929133643.38961-1-skolothumtho@nvidia.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|DM6PR12MB4313:EE_
X-MS-Office365-Filtering-Correlation-Id: 096b7cef-1d1e-45d4-d0f4-08ddff5db20b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T2R98mxcqnJZek8EbeCkDhEWbGRswguiIb1I4bFYN9iyxb/NeJWhd1e+KaHJ?=
 =?us-ascii?Q?D2utNcBK79Fe2YMGM51F0TqiFbpI1VeR2Op3C5O7XMFPrNqnIi+roY/ugydK?=
 =?us-ascii?Q?lUGaUnWo+fRsbzU4gjWMOgHrf0xVq5ZU6/HjdXI9ToLfs2GT+MhEerqiAK1N?=
 =?us-ascii?Q?n1sqOcoeHzHpe9M4GiJxPDRqkjeZ3x16umiOJJIKxcBGa85ZOwJXve5sN1s4?=
 =?us-ascii?Q?N1l8pDE4QsjKPaXkK1T3L0lIYhDqoBikWT26gZGix2ImHCKxpADBaiWMA5gF?=
 =?us-ascii?Q?YUilX9V5LdkbAPZSz3+xcO69JvnCMnlmQU9QOOeO/+ivL3js66dCOzBmqBAc?=
 =?us-ascii?Q?YNjsYLxqasEs2eOOJ7duSEzjrV++C72aD9k+ZfCZDwFw471NXpapC/c2+5Eq?=
 =?us-ascii?Q?m4LGEwA3px0dQ1g/ytD8fJdFoy6HPdSHnaxVhOiTdyU2V7G1aa6t3sp18g4t?=
 =?us-ascii?Q?xUEvot4cSLsn7TeJ6oPXHQbddUUCdc/6DK1WNpNjxCgdY32/UuhSLApPZ4SD?=
 =?us-ascii?Q?vs1EDeJWKC9m3EiBP3dV8cejVcH2HWh2szQFkTD+NvDMY2y4E/fO/5NrrF+K?=
 =?us-ascii?Q?yN37IVFHfoTKXfhxoHautAbll1SvJMErmphLPiNUlLNgPt02nAR48CTNURuA?=
 =?us-ascii?Q?zYlqGLDTtG64i1MQbWRYmTQeUrn77EN2njIO+s2Atr0GyQvGDA8Sr4kgaDSi?=
 =?us-ascii?Q?wprQJC/PZ4cjXTYcQu5Xc2ogkxnvgmMKz7+qIhoVoibn+JH01UqoFKJ4PsnU?=
 =?us-ascii?Q?S/9fdO+VZISNVDe94GVa/YM0JinqSQoIiUpUcvQPtOoifKUnmXHRe5mO47aH?=
 =?us-ascii?Q?IJO202CWKEatkq2z1dSWjfbwZxlDYwbjEsu6c+ZuGDEDNpHSXMVZl/7NZifx?=
 =?us-ascii?Q?J/ne0fw2+shP/LvuZhPxH0lLJ1QwTdPFmqySmisr9/up5g5SGzcFhQcnXnks?=
 =?us-ascii?Q?9EgkhD9d1t/TNiqjynerRHRNWNJm8mm9r6KjrsR0rVK+ekbJH983Yj/DfFGX?=
 =?us-ascii?Q?zx4HRpT8zCpZUlxT5T8tSwhJVf0o74AzhiWXVylTjn0uR53VXTUHoWF1ti5L?=
 =?us-ascii?Q?/VPJaUWG1xfL0/qsINluI4b5aXpbrNC129pysjXyZB5k9RAKu51SM2R4ox++?=
 =?us-ascii?Q?pyPtjrLMbJqgj0JKJaV8ce0mqbmApfAQ1GkO2ENnKwqokOzRY7mdbo56melF?=
 =?us-ascii?Q?804eNmgizCBzh8C/qPYGYj+FIazjwGu6rZ2jk5ag5GulLxqYp9InEqQu/7Sj?=
 =?us-ascii?Q?ULqlfaP1oTAaryIcCk+hHXeVeoAMQXPpqBhlgndakGlXLxE/XhqWMej+VLwT?=
 =?us-ascii?Q?E3V765k+jSZ/1Bk49IwJHRgJ3ZhWeqqIwA/snkYXm/+CwismE60CmT2VONew?=
 =?us-ascii?Q?zHtXkOqCjxsW1olihMo0QL+xL0MSmdncULlaWOpMmipCk39xUi711K3Afwj2?=
 =?us-ascii?Q?wDVDu2cg0vKL9fzZc6SxLZwl10loZZ4FPcPuCPKocAnd5OXW4OBSWeN7JvC1?=
 =?us-ascii?Q?BnJkM/rOqaigFT3X3mvdYbpaIguOzM+jT4WTzccgo5yERQMoKoUZP1WVdSNv?=
 =?us-ascii?Q?QKRUq6ev8tjrL1oZ8uU=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 13:40:03.8932 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 096b7cef-1d1e-45d4-d0f4-08ddff5db20b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4313
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_NONE=0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Allocate and associate a vDEVICE object for the Guest device with the
vIOMMU. This will help the host kernel to make a virtual SID --> physical
SID mapping. Since we pass the raw invalidation commands(eg: CMD_CFGI_CD)
from Guest directly to host kernel, this provides a way to retrieve the
correct physical SID.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 41 +++++++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h |  1 +
 2 files changed, 42 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 5c3825cecd..790887ac31 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -39,6 +39,35 @@
 #define STE1_MASK     (STE1_ETS | STE1_S1STALLD | STE1_S1CSH | STE1_S1COR | \
                        STE1_S1CIR | STE1_S1DSS)
 
+static bool
+smmuv3_accel_alloc_vdev(SMMUv3AccelDevice *accel_dev, int sid, Error **errp)
+{
+    SMMUViommu *viommu = accel_dev->viommu;
+    IOMMUFDVdev *vdev;
+    uint32_t vdev_id;
+
+    if (!accel_dev->idev || accel_dev->vdev) {
+        return true;
+    }
+
+    if (!iommufd_backend_alloc_vdev(viommu->iommufd, accel_dev->idev->devid,
+                                   viommu->core.viommu_id, sid,
+                                   &vdev_id, errp)) {
+            return false;
+    }
+    if (!host_iommu_device_iommufd_attach_hwpt(accel_dev->idev,
+                                               viommu->bypass_hwpt_id, errp)) {
+        iommufd_backend_free_id(viommu->iommufd, vdev_id);
+        return false;
+    }
+
+    vdev = g_new(IOMMUFDVdev, 1);
+    vdev->vdev_id = vdev_id;
+    vdev->dev_id = sid;
+    accel_dev->vdev = vdev;
+    return true;
+}
+
 static bool
 smmuv3_accel_dev_uninstall_nested_ste(SMMUv3AccelDevice *accel_dev, bool abort,
                                       Error **errp)
@@ -127,6 +156,10 @@ smmuv3_accel_install_nested_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
         return true;
     }
 
+    if (!smmuv3_accel_alloc_vdev(accel_dev, sid, errp)) {
+        return false;
+    }
+
     ret = smmu_find_ste(sdev->smmu, sid, &ste, &event);
     if (ret) {
         error_setg(errp, "Failed to find STE for Device 0x%x", sid);
@@ -311,6 +344,7 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
     SMMUPciBus *sbus = g_hash_table_lookup(bs->smmu_pcibus_by_busptr, bus);
     SMMUv3AccelDevice *accel_dev;
     SMMUViommu *viommu;
+    IOMMUFDVdev *vdev;
     SMMUDevice *sdev;
     uint16_t sid;
 
@@ -337,6 +371,13 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
     trace_smmuv3_accel_unset_iommu_device(devfn, sid);
 
     viommu = s->s_accel->viommu;
+    vdev = accel_dev->vdev;
+    if (vdev) {
+        iommufd_backend_free_id(viommu->iommufd, vdev->vdev_id);
+        g_free(vdev);
+        accel_dev->vdev = NULL;
+    }
+
     if (QLIST_EMPTY(&viommu->device_list)) {
         iommufd_backend_free_id(viommu->iommufd, viommu->bypass_hwpt_id);
         iommufd_backend_free_id(viommu->iommufd, viommu->abort_hwpt_id);
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index f631443b09..6242614c00 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -31,6 +31,7 @@ typedef struct SMMUv3AccelDevice {
     SMMUDevice  sdev;
     HostIOMMUDeviceIOMMUFD *idev;
     SMMUS1Hwpt *s1_hwpt;
+    IOMMUFDVdev *vdev;
     SMMUViommu *viommu;
     QLIST_ENTRY(SMMUv3AccelDevice) next;
 } SMMUv3AccelDevice;
-- 
2.43.0


