Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DEADC44506
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 18:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vicUQ-0002ZH-MZ; Wed, 21 Jan 2026 12:59:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicTs-0000ZR-H7; Wed, 21 Jan 2026 12:59:03 -0500
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicTe-0002Eo-Hv; Wed, 21 Jan 2026 12:58:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uajbbs8lkIG6RsjlZDa09etIIeIk8m0KNPZc9DG4jNcS3brxILu9jt7uJf4MA2NmR41WyE/Aj6TtnlMmSfysEf0LadTwKHDwslxerNDWttlzqiZjfgKFBbyrW+JpIoEFfspvDrBGepIIFiGGsuGmqLtgtMHHVlGIzwBhsziPHhZEFVr/mLxS0mpAVPljJdEkjjxQILMtUTRp6SAHhtXW/0mgMPl/XholI5qTRZVIwX7vhyR3MEBkLstY75uxvx+3KIJkiYobBcClGPgDkl3d/qOpqMI89sLI8IbJbju0uUyTqXnAcAeqbvKwlRPDpKrzqjaFH+OrlW1uZ0FFmBF2yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgKRp3DjqksvvHTw48SGxcL4co/PkzPcXD/TGY6+Hi0=;
 b=iQovIjGu0dOIY5xNyZFo/1ocScc3JQZlefwD46jlIFrC4oUJilmITekmXqJr+qWA9opMy8eDif7lj7yvMk/HH/K30PHQ8lOwVekpa8AwtQZsNnpb/idVFBwLdHCG+IltpQ4x9WPQejDfnspPTpbOUzq1B4sF+rT4IRaCio95cKg4Tzop61ttDRhpI5xe4zX55xMFUq8IvCbUmI8C2I9Vci3ovj5lC5axCwXwvwG8PWQ1sgDv4u9mKIljxiyVguqASY5VD6UYKbQ0a7lz0uZ6uRQ9xqzQf62rXPsCdi6LHJZBvhG9fJV9JVrdoHrhqTzn/qyMic/CeGE4LTC50mutsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgKRp3DjqksvvHTw48SGxcL4co/PkzPcXD/TGY6+Hi0=;
 b=mzgNkngH7tjeF4BrLxzttmVT+vK09TLqUhRNM8J5ILjIxgwH+4FZVDc/THR6AyX8O7b+FuJXiBKiFoG9uu7rn2+GjuITXvDKc4askQMRgXffZilfJLdiAQ0HPttWYY4SgTJbEpQX1S/1Va/SpYjCzMtFAuw7KMaNhQg+gp3QEwmnC9QQvYSWrShURfeyqHXY611jdwm9aiRpD3ui4aw+Ty2yqI3BxOUVnKf2RCdJCzUw25f18k91DoJZRRipdZYztvhQAygKVpz+gW4eUMkvq33Fb6O0rBb3tFk8xSYahhewdv3PwST0HjffrIWQkMpiPo62dYup+CINo58SAQ/Pkw==
Received: from BN0PR02CA0047.namprd02.prod.outlook.com (2603:10b6:408:e5::22)
 by LV2PR12MB999072.namprd12.prod.outlook.com (2603:10b6:408:354::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 17:58:40 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:408:e5:cafe::a1) by BN0PR02CA0047.outlook.office365.com
 (2603:10b6:408:e5::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 17:58:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.0 via Frontend Transport; Wed, 21 Jan 2026 17:58:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:58:17 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:58:13 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v8 36/37] hw/vfio/pci: Synthesize PASID capability for
 vfio-pci devices
Date: Wed, 21 Jan 2026 17:52:41 +0000
Message-ID: <20260121175248.87649-37-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260121175248.87649-1-skolothumtho@nvidia.com>
References: <20260121175248.87649-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|LV2PR12MB999072:EE_
X-MS-Office365-Filtering-Correlation-Id: ab4999e2-1e87-4546-ca4b-08de5916b5dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/v7nDkJkCg4WHH4f5/RiXG6S8CMUIVqB7ndtG+tlBhd8G5Ppfjl9/28i4nGS?=
 =?us-ascii?Q?JjDDCxaGkrcumL1vH/j3P0QbWzZejiw2rZ1ps53rHEb4XSTlHh7Pd+PknRM7?=
 =?us-ascii?Q?c4Sy9uZmJ4K7rtsbcZ2FGdUZnio3fKt5h8UM7qdIHFY6XlYd/AHG+G+Y7ZIW?=
 =?us-ascii?Q?7riwH0rJqrTy3yJaDlhAv6Y1vtVSOuOml1OWQAQDBGzFm0T+W57Tn16uaXkJ?=
 =?us-ascii?Q?4kNtbLsyjSQFqrJyxaDmxiDYusQkzeBnfSJRWl/3S+8S3E427v60jjLqUiOQ?=
 =?us-ascii?Q?YUFluynEPsUJOu5RzKnniyiHrDP5A5Nynh+WrS2x4jUSSJvQqIdCO5aZ+rAI?=
 =?us-ascii?Q?FOwIAMyy1S40KIZ/ND9akKVkYiIKcW3J6BoFxmE+ZK2zo6M80z7Z7hUhgGHQ?=
 =?us-ascii?Q?l5kneSc0SZtFiCGd+30aDVn7z0RKFN1O6FCMbDH4pmPTgz3KvQVo/pa8+yIy?=
 =?us-ascii?Q?B4Hsz/uuY0ZG88Hqzv3XYFBMs6+TR1IQT3y1yW0Q+Fpz91eLA71tMwQ2RELX?=
 =?us-ascii?Q?mF9DDGk7NxeAiV2WJ9baI1tlftqXR39K/iy97j5lDcWP9NScnEef02u29jHe?=
 =?us-ascii?Q?vfEoj/OhrgPGMFO0zlfmJVuo0qKtveN+fNglwsS5MgJm8hciGi7iKpa1X0Sf?=
 =?us-ascii?Q?tFkAdiKfdz7Vp4y6nhg8jR3hLa4OFw704VOhyfmaAEYssQvPHoWEPhcHgk5T?=
 =?us-ascii?Q?M/VK+CPWemLEc7IL4gba7EbxlHWxaMj0pjlMTX2CsYkTgujia38Joci+GniA?=
 =?us-ascii?Q?+cZNGlzgKq0UsR6PzvtAfJj9/gVMeOfIp2sb9BHtWPfHPZ/kQYriSLf3R+Io?=
 =?us-ascii?Q?bPbRkjmVqmspM1MfCugkwpg6NWlOj4vHovFiYvwktq7wt8Tsqdltf27ZVxI5?=
 =?us-ascii?Q?uh+FCgl8yZ7OZTz5hMvGrP5Q7MXg3KUoU+ozca6Pj4iiNtvoIQeFJG3/VMpY?=
 =?us-ascii?Q?Q3++x315TCZOiBEBm3OLzfJexlc6U4W4hFUjTUafr+0K+W5UVz3FNytNHozE?=
 =?us-ascii?Q?2EWoQvED33bpOYUK8mu01xkcC8OjQ21UV0/LKOPwPt8/dSiUTwk3x/+04evA?=
 =?us-ascii?Q?IFSdR9BJaPLHveEt/es0B0Mo9yMVxNAJnRL4zOhF+KqGG2953kvy96F1csuq?=
 =?us-ascii?Q?OwxnFD42MkpackKsh8i1IoISjX+LCpZ5uiTg9yaRFoFkSx4JMh75AsrUWq8t?=
 =?us-ascii?Q?KK+E5Y7B9SKelSVWtDxmVfIO0D3mBHABFbGM1WSZ/Z+4r7m1XVIAgjuJR+J3?=
 =?us-ascii?Q?josBoPzk0cVgCFZCs++Kn7NSF558Glrvf2pTRm+/UocnemeDwhjqI4WTnKur?=
 =?us-ascii?Q?K25rW5t5sexAzv0tKlOxJb4286Nnx5xu3KEMCfhAfat0qzC4T2IW8+01oGv2?=
 =?us-ascii?Q?+c76fJZHuoCZI3yufwXyBQY50WBElaygEbVmV1h6Q0F2IsKKZz203gXhxCHd?=
 =?us-ascii?Q?lfER9ZNh8hHfasHjJh9Qbc5Kdx3Mpf9Z+T5oArDf3dABA/jl3NPbGwKzlkIm?=
 =?us-ascii?Q?vag8qkRRCtSrXIHc/nLNPcz562SGzyx7ork6p+gfC+5ENft//whHtrrzDGcE?=
 =?us-ascii?Q?GufgD5gfZA3GbBN8WWhELNYw4s7bPcqnpiN1Kglqast20zGteNRvCG0zajVd?=
 =?us-ascii?Q?Vb7v7ABS0S9W1F5msqsV34aVqKaX3zshbad6BcvA8NDWCxG267YO4KwanhN4?=
 =?us-ascii?Q?SDWRLA=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:58:40.6725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab4999e2-1e87-4546-ca4b-08de5916b5dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999072
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
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

Add support for synthesizing a PCIe PASID extended capability for
vfio-pci devices when PASID is enabled via a vIOMMU and supported by
the host IOMMU backend.

PASID capability parameters are retrieved via IOMMUFD APIs and the
capability is inserted into the PCIe extended capability list using
the insertion helper. A new x-vpasid-cap-offset property allows
explicit control over the placement; by default the capability is
placed at the end of the PCIe extended configuration space.

If the kernel does not expose PASID information or insertion fails,
the device continues without PASID support.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/vfio/pci.c           | 75 +++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.h           |  1 +
 hw/vfio/trace-events    |  1 +
 include/hw/core/iommu.h |  1 +
 4 files changed, 78 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c734472721..36d8fbe872 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -24,6 +24,7 @@
 #include <sys/ioctl.h>
 
 #include "hw/core/hw-error.h"
+#include "hw/core/iommu.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pci_bridge.h"
@@ -2498,9 +2499,62 @@ static int vfio_setup_rebar_ecap(VFIOPCIDevice *vdev, uint16_t pos)
     return 0;
 }
 
+/*
+ * Try to retrieve PASID capability information via IOMMUFD APIs and,
+ * if supported, synthesize a PASID PCIe extended capability for the
+ * VFIO device.
+ *
+ * Use user-specified PASID capability offset if provided, otherwise
+ * place it at the end of the PCIe extended configuration space.
+ */
+static bool vfio_pci_synthesize_pasid_cap(VFIOPCIDevice *vdev, Error **errp)
+{
+    HostIOMMUDevice *hiod = vdev->vbasedev.hiod;
+    HostIOMMUDeviceClass *hiodc;
+    PasidInfo pasid_info;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
+    uint16_t pasid_offset;
+
+    if (!hiod) {
+        return true;
+    }
+
+    hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
+    if (!hiodc || !hiodc->get_pasid_info ||
+        !hiodc->get_pasid_info(hiod, &pasid_info) ||
+        !(pci_device_get_viommu_flags(pdev) & VIOMMU_FLAG_PASID_SUPPORTED)) {
+        return true;
+    }
+
+    /* Use user-specified offset if set, otherwise place PASID at the end. */
+    if (vdev->vpasid_cap_offset) {
+        pasid_offset = vdev->vpasid_cap_offset;
+    } else {
+        pasid_offset = PCIE_CONFIG_SPACE_SIZE - PCI_EXT_CAP_PASID_SIZEOF;
+    }
+
+    if (!pcie_insert_capability(pdev, PCI_EXT_CAP_ID_PASID, PCI_PASID_VER,
+                                pasid_offset, PCI_EXT_CAP_PASID_SIZEOF)) {
+        error_setg(errp, "vfio: Placing PASID capability at offset 0x%x failed",
+                   pasid_offset);
+        return false;
+    }
+    trace_vfio_pci_synthesize_pasid_cap(vdev->vbasedev.name, pasid_offset);
+
+    pcie_pasid_common_init(pdev, pasid_offset, pasid_info.max_pasid_log2,
+                           pasid_info.exec_perm, pasid_info.priv_mod);
+
+    /* PASID capability is fully emulated by QEMU */
+    memset(vdev->emulated_config_bits + pdev->exp.pasid_cap, 0xff,
+           PCI_EXT_CAP_PASID_SIZEOF);
+    return true;
+}
+
 static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
 {
     PCIDevice *pdev = PCI_DEVICE(vdev);
+    bool pasid_cap_added = false;
+    Error *err = NULL;
     uint32_t header;
     uint16_t cap_id, next, size;
     uint8_t cap_ver;
@@ -2578,12 +2632,24 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
                 pcie_add_capability(pdev, cap_id, cap_ver, next, size);
             }
             break;
+        /*
+         * VFIO kernel does not expose the PASID CAP today. We may synthesize
+         * one later through IOMMUFD APIs. If VFIO ever starts exposing it,
+         * record its presence here so we do not create a duplicate CAP.
+         */
+        case PCI_EXT_CAP_ID_PASID:
+            pasid_cap_added = true;
+            /* fallthrough */
         default:
             pcie_add_capability(pdev, cap_id, cap_ver, next, size);
         }
 
     }
 
+    if (!pasid_cap_added && !vfio_pci_synthesize_pasid_cap(vdev, &err)) {
+        error_report_err(err);
+    }
+
     /* Cleanup chain head ID if necessary */
     if (pci_get_word(pdev->config + PCI_CONFIG_SPACE_SIZE) == 0xFFFF) {
         pci_set_word(pdev->config + PCI_CONFIG_SPACE_SIZE, 0);
@@ -3756,6 +3822,8 @@ static const Property vfio_pci_properties[] = {
                      TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
 #endif
     DEFINE_PROP_BOOL("skip-vsc-check", VFIOPCIDevice, skip_vsc_check, true),
+    DEFINE_PROP_UINT16("x-vpasid-cap-offset", VFIOPCIDevice,
+                       vpasid_cap_offset, 0),
 };
 
 #ifdef CONFIG_IOMMUFD
@@ -3913,6 +3981,13 @@ static void vfio_pci_class_init(ObjectClass *klass, const void *data)
                                           "destination when doing live "
                                           "migration of device state via "
                                           "multifd channels");
+   object_class_property_set_description(klass, /* 11.0 */
+                                          "x-vpasid-cap-offset",
+                                          "PCIe extended configuration space offset at which to place a "
+                                          "synthetic PASID extended capability when PASID is enabled via "
+                                          "a vIOMMU. A value of 0 (default) places the capability at the "
+                                          "end of the extended configuration space. The offset must be "
+                                          "4-byte aligned and within the PCIe extended configuration space");
 }
 
 static const TypeInfo vfio_pci_info = {
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 0f78cf9cdb..d6495d7f29 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -187,6 +187,7 @@ struct VFIOPCIDevice {
     bool defer_kvm_irq_routing;
     bool clear_parent_atomics_on_exit;
     bool skip_vsc_check;
+    uint16_t vpasid_cap_offset;
     VFIODisplay *dpy;
     Notifier irqchip_change_notifier;
     VFIOPCICPR cpr;
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 180e3d526b..b48c4abe7a 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -40,6 +40,7 @@ vfio_pci_hot_reset_result(const char *name, const char *result) "%s hot reset: %
 vfio_pci_populate_device_config(const char *name, unsigned long size, unsigned long offset, unsigned long flags) "Device '%s' config: size: 0x%lx, offset: 0x%lx, flags: 0x%lx"
 vfio_pci_populate_device_get_irq_info_failure(const char *errstr) "VFIO_DEVICE_GET_IRQ_INFO failure: %s"
 vfio_mdev(const char *name, bool is_mdev) " (%s) is_mdev %d"
+vfio_pci_synthesize_pasid_cap(const char *name,  uint16_t offset)  "%s offset: 0x%x"
 vfio_add_ext_cap_dropped(const char *name, uint16_t cap, uint16_t offset) "%s 0x%x@0x%x"
 vfio_pci_reset(const char *name) " (%s)"
 vfio_pci_reset_flr(const char *name) "%s FLR/VFIO_DEVICE_RESET"
diff --git a/include/hw/core/iommu.h b/include/hw/core/iommu.h
index d5401a397b..86af315c15 100644
--- a/include/hw/core/iommu.h
+++ b/include/hw/core/iommu.h
@@ -20,6 +20,7 @@
 enum viommu_flags {
     /* vIOMMU needs nesting parent HWPT to create nested HWPT */
     VIOMMU_FLAG_WANT_NESTING_PARENT = BIT_ULL(0),
+    VIOMMU_FLAG_PASID_SUPPORTED = BIT_ULL(1),
 };
 
 /* Host IOMMU quirks. Extracted from host IOMMU capabilities */
-- 
2.43.0


