Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F855CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 13:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3E6s-0002eN-UD; Mon, 29 Sep 2025 09:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E6o-0002c9-JA; Mon, 29 Sep 2025 09:40:07 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E6c-0003Ib-Vy; Mon, 29 Sep 2025 09:40:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDZvPavvY5Xs9FA92wJzKzgM3nBZ/FpOWD7JMPuVricsUxdVVTD10WCPEnry9yCTW+qHyTx68dxffXtORKi5UVWSxYP5LqIvj+Usn9HjeMAQBTiru+GJfqAJ4/TvJxB5L+5WK3nj5ro+GzZAnUGn1UTH2Sp02+xKv9nBVVYMGAeNapA0sm7oueSsyzVv+hm6iW4nyND/ig19oRFwwucHkUfihkmj3o8K5xbsu6dgSA06HEbhoNiVcS1VP1nqnwYJR6gaArzqBDbUx2wwXVRqm48HX7ApHKwsz/wr2RiA+i/Y7IUvOcpzmuvBJm3zHXNDJkWpNMLrFyzuzgpS5ehW+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zg3lHXYV/8iQ914+dLwFvf3+LK8DgYE+Gs1Vm2A9UGI=;
 b=OA2Ap5U/O89mNgP6seIcMXl/JGkMaSfebBQCHIiUAo5pD06PAzWj/hVTLqfJDeWc/kdYdFlLey+yKBHsW1pAuYXIBzTQw04RYrks1NEkW8p8+Zgwapn/WsmDuAWWZBI732FW1849EIbcfLY2lRzPdJEQs6/Bf1fXj45s8PhKIlbYCY/iozwy86zs/W6uhTwwIBKvDRnoqhjc1rW6aofoF/yV5ye3oZtMWcQS+d+qp6FETb9YN+zz6OS+RAlzuWQX4qUuhQ/d7cTMkni6YJDTfhfdy+M4+eHTkfJO07oOjestDYuLwoelZhrNS4P4a0Cnm/tCZX3CvDWUSkKyXS3mJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zg3lHXYV/8iQ914+dLwFvf3+LK8DgYE+Gs1Vm2A9UGI=;
 b=sWEwFR4RfC1vu5MoemxcJd2cVz/pmuZIvwowMo3DHJShQFZiYL4Lh0HvBthBKK4YeBE0BPnsYHPa3D4Xznz1c1k/W7SgyJAzqkddPa9WHaFDN69oz8RRlXsKRCPfZwtHoJeM0kF81OL6570KS3KRga+x0OBExO7lBODOCZhEhfAAVjS2GUQ7jyz3zbonOOeRrvB/dMLCguRCG6lFHWowUbL4PbfiyH5XtYddO4C93OZMzPUvC38/ylJoazv+V+wgz5OVcJXvzbK43dk6lBYdETyIgFKkPNEyFYdU8fo5lOukVkuwcubaeIa2aLTYHDY1Wj5Ub0KNseFNIrsDPerhVQ==
Received: from CH0PR03CA0119.namprd03.prod.outlook.com (2603:10b6:610:cd::34)
 by DS2PR12MB9773.namprd12.prod.outlook.com (2603:10b6:8:2b1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Mon, 29 Sep
 2025 13:39:42 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::5d) by CH0PR03CA0119.outlook.office365.com
 (2603:10b6:610:cd::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Mon,
 29 Sep 2025 13:39:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 13:39:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Mon, 29 Sep
 2025 06:39:26 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Sep
 2025 06:39:23 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: [PATCH v4 06/27] hw/arm/smmuv3-accel: Restrict accelerated SMMUv3 to
 vfio-pci endpoints with iommufd
Date: Mon, 29 Sep 2025 14:36:22 +0100
Message-ID: <20250929133643.38961-7-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|DS2PR12MB9773:EE_
X-MS-Office365-Filtering-Correlation-Id: f75834fa-0f25-479c-203b-08ddff5da525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KrWdD5VRHGyzsCcYiuzZdlTU5Lym054aRJiPHunqiFmlygyOhw5eVbCwElzp?=
 =?us-ascii?Q?/0KMCqxa9doKgb6xQClaBA/i1BJfygTYS24ifgr8uabP8xLGHiSpGi+jPnBy?=
 =?us-ascii?Q?CZYTwn6ly1hzj9zKJfjjFfqRj63OWyUFrgOyKZEVu9NFkXweUHzEiSUfsK7x?=
 =?us-ascii?Q?oN4dTrGJsOJ6w56NrY5LvdgAzwKjgvlXWdmqY9I6OcDYyp+gjQbK2DbMcP+F?=
 =?us-ascii?Q?+zeIp9Mnzl2ZmJRwvp8iBr3YEaNJxkGXBpevp9HhRSEEkLFKeS7GXI7CmLia?=
 =?us-ascii?Q?ZOPs+33zv01Pon2HShK0uSldrDf14FuQBe+Kub6fGdPUNfYwwV3VJrTjzhpP?=
 =?us-ascii?Q?ZvSl7mJeecWan3EtDVCxeNfn/A2vOgtZLoeBJTK8wbv1MAk7IvIjWZo4cxlp?=
 =?us-ascii?Q?k8FRnRngE9Lg83/j/Ua0MMaBFMBVPIlwWjlGvWCGV7Q56UYpt+0tukBBjeQ3?=
 =?us-ascii?Q?p42jnm3dHTDuoU/JjaC4GUgy0XsuKtC5BNuycVO/KE8lklx5CuEeHjd1dh3J?=
 =?us-ascii?Q?L4oIwHtvdy72U2GdLI3fzbtZ5T7ieT2ybx2WjC5CT1Rw/J1axlBzdUnaxOOy?=
 =?us-ascii?Q?/AURumgiNBYw58PBLHAXWyZPK79S4W799mQ9jRIgVk53trS0Jg1l7OkCteq8?=
 =?us-ascii?Q?4OwKZpdMfNOg2dDOBSx7efT4qN3h9NZlpbHzeSBbXch8Q4UioQtj2bPGaYSQ?=
 =?us-ascii?Q?08TZZjt2WNVi6PA3Q0b/lqy6opiG/VQMI3La1EDsGRQIRcOrxKTYcjlvUsY1?=
 =?us-ascii?Q?0ay6IH9a5n3n4xQhYPfyfarIRxlcPUKwXyiBQkcfrq+UvVPOPgCAOk/RrkZb?=
 =?us-ascii?Q?F21PyVbHVq5TwGfVvSs+q05cFGEaN868qv1em4V/Zt1ufjYdcDoOnKvDbqPU?=
 =?us-ascii?Q?g29UXHs9MeGGrSfWdjG21/M9y6eIxElwbr4mRGuoEfF2oUSTrBNcbRSo2J/L?=
 =?us-ascii?Q?IZswk8IZbowhsygFZw3VO6WX5/zJIN+jNpzxvmcimRl7b4sZe4bKbn6lVzE4?=
 =?us-ascii?Q?2NIGOzjn8ZLfNVmVQ8qbmtjJVavR3bf1+dCGO2ydZ/F0WERyNrwDxqHEnoJf?=
 =?us-ascii?Q?IHsWWcBi0UXGQFmEZXHimdMp9Y6gCAp19pB6T5BE33Ao40NtR0SvxGveVKPO?=
 =?us-ascii?Q?u8iLKdlNnAnj/Jhvvytuedkke1EFMbzUTA0daxFzJoPjOOGNdCVKEWnp/iEf?=
 =?us-ascii?Q?zAslnqYC990kvJGsOCX9woSw4l0uq5x8HJRoyRAb+LnHQoiq/XpoyhrMsIMK?=
 =?us-ascii?Q?32cghFEXGFBgz9KJp1AebZXcHtFaS+pZd362CSdUnqmzlVEITASMJrB47yt2?=
 =?us-ascii?Q?RSiHVVQ05jM6FHNT26QJ9hZjz1b+NVVy675/W8seVh3RqH0fCPRC7zPpp0mo?=
 =?us-ascii?Q?CM/n1yxYAJNc42Z7g02UI5njBfU5Mz/frodgZoAB97FjyrCI6dEaIJQiKhYT?=
 =?us-ascii?Q?0Q09SMXSOc9Mu6UOKpRAKPPq7vrjYWZi5tbH2w0aLk3qusBxMnyVBbnmeudd?=
 =?us-ascii?Q?i45qzlmTCm6ngokIJ5zGmc1SRDd/GUKrLqNPXq0bnoV0rLUNshA+ShymD7kU?=
 =?us-ascii?Q?TtGo8kuOqrUepErrOwc=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 13:39:42.2737 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f75834fa-0f25-479c-203b-08ddff5da525
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9773
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Accelerated SMMUv3 is only useful when the device can take advantage of
the host's SMMUv3 in nested mode. To keep things simple and correct, we
only allow this feature for vfio-pci endpoint devices that use the iommufd
backend. We also allow non-endpoint emulated devices like PCI bridges and
root ports, so that users can plug in these vfio-pci devices. We can only
enforce this if devices are cold plugged. For hotplug cases, give appropriate
warnings.

Another reason for this limit is to avoid problems with IOTLB
invalidations. Some commands (e.g., CMD_TLBI_NH_ASID) lack an associated
SID, making it difficult to trace the originating device. If we allowed
emulated endpoint devices, QEMU would have to invalidate both its own
software IOTLB and the host's hardware IOTLB, which could slow things
down.

Since vfio-pci devices in nested mode rely on the host SMMUv3's nested
translation (S1+S2), their get_address_space() callback must return the
system address space so that VFIO core can setup correct S2 mappings
for guest RAM.

So in short:
 - vfio-pci devices(with iommufd as backend) return the system address
   space.
 - bridges and root ports return the IOMMU address space.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c               | 68 ++++++++++++++++++++++++++++-
 hw/pci-bridge/pci_expander_bridge.c |  1 -
 include/hw/pci/pci_bridge.h         |  1 +
 3 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 79f1713be6..44410cfb2a 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -7,8 +7,13 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 
 #include "hw/arm/smmuv3.h"
+#include "hw/pci/pci_bridge.h"
+#include "hw/pci-host/gpex.h"
+#include "hw/vfio/pci.h"
+
 #include "smmuv3-accel.h"
 
 static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
@@ -29,15 +34,76 @@ static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
     return accel_dev;
 }
 
+static bool smmuv3_accel_pdev_allowed(PCIDevice *pdev, bool *vfio_pci)
+{
+
+    if (object_dynamic_cast(OBJECT(pdev), TYPE_PCI_BRIDGE) ||
+        object_dynamic_cast(OBJECT(pdev), TYPE_PXB_PCIE_DEV) ||
+        object_dynamic_cast(OBJECT(pdev), TYPE_GPEX_ROOT_DEVICE)) {
+        return true;
+    } else if ((object_dynamic_cast(OBJECT(pdev), TYPE_VFIO_PCI))) {
+        *vfio_pci = true;
+        if (object_property_get_link(OBJECT(pdev), "iommufd", NULL)) {
+            return true;
+        }
+    }
+    return false;
+}
+
 static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void *opaque,
                                               int devfn)
 {
+    PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), devfn);
     SMMUState *bs = opaque;
     SMMUPciBus *sbus = smmu_get_sbus(bs, bus);
     SMMUv3AccelDevice *accel_dev = smmuv3_accel_get_dev(bs, sbus, bus, devfn);
     SMMUDevice *sdev = &accel_dev->sdev;
+    bool vfio_pci = false;
+
+    if (pdev && !smmuv3_accel_pdev_allowed(pdev, &vfio_pci)) {
+        if (DEVICE(pdev)->hotplugged) {
+            if (vfio_pci) {
+                warn_report("Hot plugging a vfio-pci device (%s) without "
+                            "iommufd as backend is not supported", pdev->name);
+            } else {
+                warn_report("Hot plugging an emulated device %s with "
+                            "accelerated SMMUv3. This will bring down "
+                            "performace", pdev->name);
+            }
+            /*
+             * Both cases, we will return IOMMU address space. For hotplugged
+             * vfio-pci dev without iommufd as backend, it will fail later in
+             * smmuv3_notify_flag_changed() with "requires iommu MAP notifier"
+             * error message.
+             */
+             return &sdev->as;
+        } else {
+            error_report("Device(%s) not allowed. Only PCIe root complex "
+                         "devices or PCI bridge devices or vfio-pci endpoint "
+                         "devices with iommufd as backend is allowed with "
+                         "arm-smmuv3,accel=on", pdev->name);
+            exit(1);
+        }
+    }
 
-    return &sdev->as;
+    /*
+     * We return the system address for vfio-pci devices(with iommufd as
+     * backend) so that the VFIO core can set up Stage-2 (S2) mappings for
+     * guest RAM. This is needed because, in the accelerated SMMUv3 case,
+     * the host SMMUv3 runs in nested (S1 + S2)  mode where the guest
+     * manages its own S1 page tables while the host manages S2.
+     *
+     * We are using the global &address_space_memory here, as this will ensure
+     * same system address space pointer for all devices behind the accelerated
+     * SMMUv3s in a VM. That way VFIO/iommufd can reuse a single IOAS ID in
+     * iommufd_cdev_attach(), allowing the Stage-2 page tables to be shared
+     * within the VM instead of duplicating them for every SMMUv3 instance.
+     */
+    if (vfio_pci) {
+        return &address_space_memory;
+    } else {
+        return &sdev->as;
+    }
 }
 
 static const PCIIOMMUOps smmuv3_accel_ops = {
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 1bcceddbc4..a8eb2d2426 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -48,7 +48,6 @@ struct PXBBus {
     char bus_path[8];
 };
 
-#define TYPE_PXB_PCIE_DEV "pxb-pcie"
 OBJECT_DECLARE_SIMPLE_TYPE(PXBPCIEDev, PXB_PCIE_DEV)
 
 static GList *pxb_dev_list;
diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
index a055fd8d32..b61360b900 100644
--- a/include/hw/pci/pci_bridge.h
+++ b/include/hw/pci/pci_bridge.h
@@ -106,6 +106,7 @@ typedef struct PXBPCIEDev {
 
 #define TYPE_PXB_PCIE_BUS "pxb-pcie-bus"
 #define TYPE_PXB_CXL_BUS "pxb-cxl-bus"
+#define TYPE_PXB_PCIE_DEV "pxb-pcie"
 #define TYPE_PXB_DEV "pxb"
 OBJECT_DECLARE_SIMPLE_TYPE(PXBDev, PXB_DEV)
 
-- 
2.43.0


