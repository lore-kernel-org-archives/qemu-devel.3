Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0CACF8859
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 13:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM4gW-0004Vg-R2; Thu, 20 Nov 2025 08:26:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4fj-0003BR-K7; Thu, 20 Nov 2025 08:26:05 -0500
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4fh-0002hc-Ob; Thu, 20 Nov 2025 08:26:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i5/4Rfw0FXlHv7QePsAoktuXggOlm0/nvEfPU5IENhzepcTHpReMS+Dhc7OyFRJ8A2Mz3tpxTMB2qz5O/34AS/tn1L+JwVUO1pJZn0h3jAhJ32tu+kDiopXGahqwjtHHjUpsswJsODItxeCtXrZyZZJXEIm2JtqqOCD3lCPxTcfLN2xsNt4ZFcwlxNdfozqGAaZ9U6/1IwxuLpxR8av62ZRFdP6SycoletAjkVicc8P0hbjhHD2aXURPz3Am9M0NprhQvk5xQWFzD3Kiu55GdfMgYMwkQjeyTLflX9BsRbkRm7PT1jOLOZzNE1osFJxplPTZw5tJqVJ/dlbJL8qUZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0k8gm7z6zSPWEhRsFYPuM9F36FPJA/5Qb8oyILQ1Z0Y=;
 b=wZJs7ON/N8TCo3I815B2vD2mifnFb0VueX9y8K97W0FibQbQ5yUZX3S7maFgZOopO/ot4JsvACGm3ryRpfmHv7UqYy76hA7+D00RumsvOCgSiHH+rVoyCdxOg/i6I5udpKspOKgjSZKRM5eRVDB2sYAzB1inluXVgH8MSekN6g8/HjikwGW/ouByAEgIbMpz1SQr6E3mpx2LuzVMHRo62SNfe1L88oAu3Qy4bMlIdXFH+KkbdnEVoBsGwGnKnh3/r3gA3ysEvekkCc37EQeOKkQvdBNUzzusxNFiSCJQSmEc/CFY1bXXCp4tdTDfFGDLK8QGCpxVNgi8L5BgcySG5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0k8gm7z6zSPWEhRsFYPuM9F36FPJA/5Qb8oyILQ1Z0Y=;
 b=eNkeN1RXXcDkwxt/c9r0nvUa7wd5e56m/6IbnVf49WIvcpRpaxkZk/g0YXDdn3os89jkrNIkqStccGuwPp38jVL7EAMXqXBprhi4spAxdbRhmGCdnTE1zqyJONx/CPs0tm8ND+9ECGgB39GRHBZi+qVpx7Ypzxvg4SFJZquHDNi/Sn+oBKu1d1yh4QodcS7gipPsVEINI/+FR+QmlVZbu9LfIKRCgcmPoAD7TDJ9/skIrrrwZ0vcA0hyL/CV7FDsSaC3y21wM4RYUJfbm4dpdG/yQL3aebQZ2hgD0xeLQktnWTUaK59UWd27AWNVmzdoyLy4oTVOIkWFKjYIuEwmiQ==
Received: from SJ0PR03CA0360.namprd03.prod.outlook.com (2603:10b6:a03:39c::35)
 by SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 13:25:54 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:39c:cafe::ff) by SJ0PR03CA0360.outlook.office365.com
 (2603:10b6:a03:39c::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 13:25:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:25:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:25:36 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:25:32 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v6 32/33] vfio: Synthesize vPASID capability to VM
Date: Thu, 20 Nov 2025 13:22:12 +0000
Message-ID: <20251120132213.56581-33-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|SJ0PR12MB7082:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cb97a58-d94c-44ae-01b2-08de283854fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|82310400026|1800799024|376014|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CFzWgNAZ2lZlDWmeUv0mfdfqRANrme0Etow9hH6qhmR45EMBW/1XUwRc43Jt?=
 =?us-ascii?Q?fjnPqJ83OG4XdOXn0BKmQG5lQHGXQvqrdkDaVMHo+VMpEarQQMSNri6IAx1c?=
 =?us-ascii?Q?9F1FSmyBM9ME6rqxyC8GKPqWMqT3QJ5jMATXvT4w19zzOi2W46NhAtTRHq/o?=
 =?us-ascii?Q?nv3Sqkw0O0/4xNIIZ5YY+iO07JjEX9cPx9wNJzsoJm6NzZzH3GtFRTLlmYqe?=
 =?us-ascii?Q?yBslHFeRMUQy9JVlEYxbWAOzazTVgIvZ7zqopMea75u4Bo5lDpIBd1QVzVDN?=
 =?us-ascii?Q?pMChTbHDqMLtQqgYi3Ph6xUQoPgGDjDGKoT9fGyhynJZml3wHKs7x354mtMD?=
 =?us-ascii?Q?KZ5MR8mBYO+LnEOIsOCytoSFyQyU2p/5bAOdP2FQ3vheJcu/ebIaGUfrTU8a?=
 =?us-ascii?Q?e/ByPUC6+DqRztRQxMtezKBH2O62PGoxxXaaw6jUw5dQcY+3Jm/N1XRZlqqs?=
 =?us-ascii?Q?LYsH8BAOwpKmHyvg0DqSDEIQ2boo35uQvR1D8rq4Hc1V2WtQt0SHvB1hvLeR?=
 =?us-ascii?Q?SMZ7qYmwR05R1nlY5BLpsxTFvyCvSDpypXBbNIah8Gfn6gvM3IVhk7hSuuRN?=
 =?us-ascii?Q?vokZiocjneXxdWGdyX8feTt7t61K/vSKdHhErIUrgyqPsK/XmsYPP0njqztX?=
 =?us-ascii?Q?e0YdZ25DhLpapNd3TXsZ66lww7/RGEP9ewV0niJ4ns8YbQ69URxZ7XaQ4a9L?=
 =?us-ascii?Q?xM/777le4FNBGH1PKvhpowhy1+0VPTDOVbS838I5a9LwEX/h12mY8DVo9IJB?=
 =?us-ascii?Q?Zem4Ytim6bdYmdqAKJbuynDi3aAkHG1+zVLp7+IKuYg3PUOT28amv0cyNKg7?=
 =?us-ascii?Q?8DR6hl0ocOAtvzoBR+4/IRuGGfhwa/MTzH3Qkvhg/TBTEnCzdiM0gUS1nwA7?=
 =?us-ascii?Q?GGgjKUIjswwjUeZayrj+0ms2LmgK/qKIrKPPPGMx1Bbf7b0m9oo6tXlg+675?=
 =?us-ascii?Q?BxWMBg2GRFMTITnfOmh33c50NcdpkWfU5cfpv4W5tLjrfrcS5sOTCgWl9Q61?=
 =?us-ascii?Q?wD5RTujOz5YdWx+8uXiPXtw0s7CpiGz8+JE+9kPMY/a5QMPTDbv9/LJl89ld?=
 =?us-ascii?Q?oowt5Xa6WZC9eN7ew1FON1KQUrDT9wKIfN5o6OfdHwOHT8ewa290S2sK4dqq?=
 =?us-ascii?Q?E6KGlttkS7Bi61cTtBVK1XfLsNnRTcKhmZPBQ8vSf5+V0wChVYEIMyvPT/w3?=
 =?us-ascii?Q?3k2NYhoBwUT6HIO+H96fQm/3SD21BtkPYuWcpAi4WOsVFrxurTrwNCsev7wj?=
 =?us-ascii?Q?pGp/9HpjnKqQje8m2/x8qRYU4dTDFz7UFo++HqKtKLJMe0a4k51G+Ap2RtQc?=
 =?us-ascii?Q?YdpdK70X4COzV0hr/i/9PmTxL1YYtgri2JeqZcGV0shsyEDj8pm8XFwbfhOe?=
 =?us-ascii?Q?Pp+3ZI3dInSa+VN0ADSYElGaa4knTQbP9vUr49pKTAerXL5PpizQegucjDV8?=
 =?us-ascii?Q?hXsI/rdFNSns1DFKfzeroA3GeazzfSD7ZOkkrX875hWCRFRg0eEcDKhKs7og?=
 =?us-ascii?Q?Y7lveEutOyabEetqd25sWJRhYbQHZQ83rBHXuNca/YTeJutuCooHMkGhRabC?=
 =?us-ascii?Q?TEd6YIrf1+b51YZarK4=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(82310400026)(1800799024)(376014)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:25:54.1285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb97a58-d94c-44ae-01b2-08de283854fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7082
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
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

From: Yi Liu <yi.l.liu@intel.com>

If user wants to expose PASID capability in vIOMMU, then VFIO would also
need to report the PASID cap for this device if the underlying hardware
supports it as well.

As a start, this chooses to put the vPASID cap in the last 8 bytes of the
vconfig space. This is a choice in the good hope of no conflict with any
existing cap or hidden registers. For the devices that has hidden registers,
user should figure out a proper offset for the vPASID cap. This may require
an option for user to config it. Here we leave it as a future extension.
There are more discussions on the mechanism of finding the proper offset.

https://lore.kernel.org/kvm/BN9PR11MB5276318969A212AD0649C7BE8CBE2@BN9PR11MB5276.namprd11.prod.outlook.com/

Since we add a check to ensure the vIOMMU supports PASID, only devices
under those vIOMMUs can synthesize the vPASID capability. This gives
users control over which devices expose vPASID.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/vfio/pci.c      | 38 ++++++++++++++++++++++++++++++++++++++
 include/hw/iommu.h |  1 +
 2 files changed, 39 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 8b8bc5a421..e11e39d667 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -24,6 +24,7 @@
 #include <sys/ioctl.h>
 
 #include "hw/hw.h"
+#include "hw/iommu.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pci_bridge.h"
@@ -2500,7 +2501,12 @@ static int vfio_setup_rebar_ecap(VFIOPCIDevice *vdev, uint16_t pos)
 
 static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
 {
+    HostIOMMUDevice *hiod = vdev->vbasedev.hiod;
+    HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
     PCIDevice *pdev = PCI_DEVICE(vdev);
+    uint64_t max_pasid_log2 = 0;
+    bool pasid_cap_added = false;
+    uint64_t hw_caps;
     uint32_t header;
     uint16_t cap_id, next, size;
     uint8_t cap_ver;
@@ -2578,12 +2584,44 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
                 pcie_add_capability(pdev, cap_id, cap_ver, next, size);
             }
             break;
+        /*
+         * VFIO kernel does not expose the PASID CAP today. We may synthesize
+         * one later through IOMMUFD APIs. If VFIO ever starts exposing it,
+         * record its presence here so we do not create a duplicate CAP.
+         */
+        case PCI_EXT_CAP_ID_PASID:
+             pasid_cap_added = true;
+             /* fallthrough */
         default:
             pcie_add_capability(pdev, cap_id, cap_ver, next, size);
         }
 
     }
 
+#ifdef CONFIG_IOMMUFD
+    /* Try to retrieve PASID CAP through IOMMUFD APIs */
+    if (!pasid_cap_added && hiodc && hiodc->get_cap) {
+        hiodc->get_cap(hiod, HOST_IOMMU_DEVICE_CAP_GENERIC_HW, &hw_caps, NULL);
+        hiodc->get_cap(hiod, HOST_IOMMU_DEVICE_CAP_MAX_PASID_LOG2,
+                       &max_pasid_log2, NULL);
+    }
+
+    /*
+     * If supported, adds the PASID capability in the end of the PCIe config
+     * space. TODO: Add option for enabling pasid at a safe offset.
+     */
+    if (max_pasid_log2 && (pci_device_get_viommu_flags(pdev) &
+                           VIOMMU_FLAG_PASID_SUPPORTED)) {
+        bool exec_perm = (hw_caps & IOMMU_HW_CAP_PCI_PASID_EXEC);
+        bool priv_mod = (hw_caps & IOMMU_HW_CAP_PCI_PASID_PRIV);
+
+        pcie_pasid_init(pdev, PCIE_CONFIG_SPACE_SIZE - PCI_EXT_CAP_PASID_SIZEOF,
+                        max_pasid_log2, exec_perm, priv_mod);
+        /* PASID capability is fully emulated by QEMU */
+        memset(vdev->emulated_config_bits + pdev->exp.pasid_cap, 0xff, 8);
+    }
+#endif
+
     /* Cleanup chain head ID if necessary */
     if (pci_get_word(pdev->config + PCI_CONFIG_SPACE_SIZE) == 0xFFFF) {
         pci_set_word(pdev->config + PCI_CONFIG_SPACE_SIZE, 0);
diff --git a/include/hw/iommu.h b/include/hw/iommu.h
index 9b8bb94fc2..9635770bee 100644
--- a/include/hw/iommu.h
+++ b/include/hw/iommu.h
@@ -20,6 +20,7 @@
 enum viommu_flags {
     /* vIOMMU needs nesting parent HWPT to create nested HWPT */
     VIOMMU_FLAG_WANT_NESTING_PARENT = BIT_ULL(0),
+    VIOMMU_FLAG_PASID_SUPPORTED = BIT_ULL(1),
 };
 
 #endif /* HW_IOMMU_H */
-- 
2.43.0


