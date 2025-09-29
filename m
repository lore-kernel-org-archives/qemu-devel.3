Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E51A0CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 13:49:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3E9K-0004GQ-AS; Mon, 29 Sep 2025 09:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E8a-0003fq-Ei; Mon, 29 Sep 2025 09:41:58 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E8M-0003yC-Pn; Mon, 29 Sep 2025 09:41:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ikd7U0k77SiQsT7V02V3UXNMXlGeq41bz417w6b+/YnwOWoQEmfyNb7u911+bEo4gP7RM7zdmggtt5Og3xAZcsTV5xW+v60arHcQOx/VLVs7hDBtdLxbOSYqhWW2n3PmnRdhCiibha/CNiJQx8Jq1D+C2PtPPu3wN6EyHVuDad7VqfBr8j/ItD934I/f856x3Qe1Ad9VQZqJ7sW6vLuaNP59m8/noQGyGeov7gmh5IFBhebZL7BWfCyXxtkxSDce7APrswjmw1CBu7i99ug+X/tz38hCI4lEfcc7rQVzZnAZnIquMaE0mYw7IdeD9ekxF7I/EZIE1OI7tTcIcrQVMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=juapDaj/DmKYrnC8ZMY9utd7Bfx/YmqqtOYXNUZisyM=;
 b=ImsN4DkybVmi+lALeioB0/dLiX907AFllVF6tWpZpN/8sgTb2xz6V6DS2zy4/8OBLoKbI/j99BBv1Wws05fQijIl+WGZqLF+CB5Gl1wHQJXSGRbR8sJj4iAft3YP9OcoB8u4VrMp8W1PpJ0Hdo65MpOY9C3DCgrU4bDr5rkzo5rNnY00Y79PPRisnYJMBYek083RIKJc/TSEgkJz4zmMA+DR+/GmiNoqARXiIrNVbXNPTyt3x+kCvIetyTMUA7Tv5xd5s4VkJi8PPEBJiVESMiEWh7tI7fMklCAuozYdVhNGsjrQ4afYePmBtrosYBZQS+6OxF1+MVY9dE3rlKoH9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=juapDaj/DmKYrnC8ZMY9utd7Bfx/YmqqtOYXNUZisyM=;
 b=CyTYd6jjDZW+eUmpki9RvCZvVcNG1US/rwfuWyPnCdiDs8s7ccqG9jwC5AYBboR9XYYzWkV6dEG8zpkMnKXOkzePmYRxGJgH5PiKEdnXXa9UUuA0nJby1BcpdW4zTeuHN8OxVN0NVdJXY0njrLCj732SZNYbA26r8PCgSfW1I5pwLzaW/1RsfvUpaK2e/kKBMQdTjjWjTA+I8KnApGp6/NQSMIQWnw86Gku/dAJhD2d+Dncl5dHuBIEVjRxIS1am6QUdVrEYxcJ8DQwdb6zywZ0ZUX1bcVwgs+zsxyKBYESeT3nrGzt87re/iPFpkGfZ5W9Mf3w0p8hQc6Y3PE8mcA==
Received: from CH5P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::20)
 by CH3PR12MB7715.namprd12.prod.outlook.com (2603:10b6:610:151::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 13:41:13 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:1f3:cafe::fa) by CH5P223CA0011.outlook.office365.com
 (2603:10b6:610:1f3::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Mon,
 29 Sep 2025 13:41:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 13:41:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Mon, 29 Sep
 2025 06:40:57 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Sep
 2025 06:40:50 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: [PATCH v4 26/27] vfio: Synthesize vPASID capability to VM
Date: Mon, 29 Sep 2025 14:36:42 +0100
Message-ID: <20250929133643.38961-27-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|CH3PR12MB7715:EE_
X-MS-Office365-Filtering-Correlation-Id: 95d07e7e-1dd4-4d8b-4ee7-08ddff5ddb8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IjdONETw89apgbyVVqH4cMWOfEAPmrGgyvEX1Tp7BtyFDCSUGcs4vJlKCKOY?=
 =?us-ascii?Q?s+D89GqDM+uhK2mMFT8Juil/LqTHaEvyAFo0lT/Tx3J2of0gW08hWc8zfeDz?=
 =?us-ascii?Q?CbHH7essVX2s4h7lXkvV4VFAG9y9nHbJNkVQdHeQDnWan1NcbpajDEsBwCih?=
 =?us-ascii?Q?c3776x1vHTo7eLjHTt0fyL7FYDbsMtQxcgg5MqoUyWuuryte/E3LGcNAxufQ?=
 =?us-ascii?Q?z7uTFHUpvqiZWSUk681L6B1Uwyd+Q4p+esrexfvixTAGtZ0X+e9kOBLG1eu0?=
 =?us-ascii?Q?H+PaU28ZKfuduFZXBawcFWxFcH0lq9yMt4raxpTKbvFR0xpul54LsVGkp1cZ?=
 =?us-ascii?Q?W983rKqVJDNbtvKzvUGyaaEAVYOBnwOyY79bhQs7yt7q0DHmAOtIp8SErDvc?=
 =?us-ascii?Q?nLH4ueinVffr3v4xyXgD6ETq7/UsVO0i7akdlAn/aL2L4cgPsJ7rzNevqUVp?=
 =?us-ascii?Q?geESsTY2KuArkv7qiNi31cUlFGeGZf71T2igN7gvQbxGK0DR7P0x+D/KBoJP?=
 =?us-ascii?Q?S/H9aBGxzmF2EmVYPy1acXnNM0z/mMuyi6TlFd1lv8IumejqVFHv8yt2SNHz?=
 =?us-ascii?Q?dYTqdgsnkGpJCHflnSPZllPlFk51j1JdCgejubNGmJ7DG/24gTGV0JxV0CoS?=
 =?us-ascii?Q?2AF62+6oqhGijP9Vix85afohtkQX0LMb84GEZrhky4dCpfHidDkBBAXeFUuD?=
 =?us-ascii?Q?CYersCMhydAea3+xB5KLK4cUC7fzebMZlfpF821DpLWOOXC/cXJKrptkATY9?=
 =?us-ascii?Q?tbhwIdL0c2UDhiuvsEeF/+LI4j/PvnSTy22SArzr+PxO0AHRut2DLgAjho6b?=
 =?us-ascii?Q?aR2a6USbCR48XnrGdk4TjPHOP1WGDCbI83CF7+TE4Co7+wTXHHuBfTaaDALB?=
 =?us-ascii?Q?wDa5S9gBw7R51uug5Nl9bQGvk7nh3fjoZTF0oXQKdmmsxqObHWO0wBvVz14Z?=
 =?us-ascii?Q?KvHidANqGWRmqChV+7j+4MNLqOaz5Jke9ZqRxG3xH3hTVlcKgCPtcZSpajiO?=
 =?us-ascii?Q?6MTNT5Uo6C6s/CY+ik+aIk7A0sYZXS0azK5MDnMwI0GtVyM7rJy2O6asPuuR?=
 =?us-ascii?Q?6L+tlEvxd9Jn7oYjIKHImZ8m4FheCPYjaTRdV2dfYikL/GHIQuyCvayrrPck?=
 =?us-ascii?Q?5i+aH36Vo+gt089nfpIcEmh/VBcB4incEI6sP78K9UlPMuTyaMvFuAcVb5o7?=
 =?us-ascii?Q?1HBIzQC94XcspTRxXcn1pyk7FTgh1UMqglqiqKtFLj2jhNwShCSm4pNFHgUh?=
 =?us-ascii?Q?AWr5adb/JVqurSIAD33mN+GsCOiKBYXe6R5Txs0htJk4y6jtKEyaW126Tss9?=
 =?us-ascii?Q?ygZYkMjCnyMKujHLqf40lGoPO7jDEd1wlMpmD0oTa/3iViF5hJv+qnhtfeIp?=
 =?us-ascii?Q?3pxHYMoOWvIRFZlV7ouOZVWTHpPszpg6HV1v4gUkWyU5a+Sfamq25vTKl8EM?=
 =?us-ascii?Q?vZnSt6vxzlo/eVE/kKFxWZ6n2yhoKa/+U7IecQWWM0er7ETptLgk4Kb/a4Sc?=
 =?us-ascii?Q?7ZtIx32n4kUkJ9oEWsALuxW08p8PCmOytgeJBIcS2zD76k7Bu7bzAThQzwJn?=
 =?us-ascii?Q?KZkRDuY/Rw7TkwXcnBo=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 13:41:13.5442 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d07e7e-1dd4-4d8b-4ee7-08ddff5ddb8f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7715
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
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

From: Yi Liu <yi.l.liu@intel.com>

If user wants to expose PASID capability in vIOMMU, then VFIO would also
report the PASID cap for this device if the underlying hardware supports
it as well.

As a start, this chooses to put the vPASID cap in the last 8 bytes of the
vconfig space. This is a choice in the good hope of no conflict with any
existing cap or hidden registers. For the devices that has hidden registers,
user should figure out a proper offset for the vPASID cap. This may require
an option for user to config it. Here we leave it as a future extension.
There are more discussions on the mechanism of finding the proper offset.

https://lore.kernel.org/kvm/BN9PR11MB5276318969A212AD0649C7BE8CBE2@BN9PR11MB5276.namprd11.prod.outlook.com/

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/vfio/pci.c      | 31 +++++++++++++++++++++++++++++++
 include/hw/iommu.h |  1 +
 2 files changed, 32 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 5b022da19e..f54ebd0111 100644
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
+    uint8_t max_pasid_log2 = 0;
+    bool pasid_cap_added = false;
+    uint64_t hw_caps;
     uint32_t header;
     uint16_t cap_id, next, size;
     uint8_t cap_ver;
@@ -2578,12 +2584,37 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
                 pcie_add_capability(pdev, cap_id, cap_ver, next, size);
             }
             break;
+        case PCI_EXT_CAP_ID_PASID:
+             pasid_cap_added = true;
+             /* fallthrough */
         default:
             pcie_add_capability(pdev, cap_id, cap_ver, next, size);
         }
 
     }
 
+    /*
+     * If PCI_EXT_CAP_ID_PASID not present, try to get information from the host
+     */
+    if (!pasid_cap_added && hiodc->get_pasid) {
+        max_pasid_log2 = hiodc->get_pasid(hiod, &hw_caps);
+    }
+
+    /*
+     * If supported, adds the PASID capability in the end of the PCIE config
+     * space. TODO: Add option for enabling pasid at a safe offset.
+     */
+    if (max_pasid_log2 && (pci_device_get_viommu_flags(pdev) &
+                           VIOMMU_FLAG_PASID_SUPPORTED)) {
+        bool exec_perm = (hw_caps & IOMMU_HW_CAP_PCI_PASID_EXEC) ? true : false;
+        bool priv_mod = (hw_caps & IOMMU_HW_CAP_PCI_PASID_PRIV) ? true : false;
+
+        pcie_pasid_init(pdev, PCIE_CONFIG_SPACE_SIZE - PCI_EXT_CAP_PASID_SIZEOF,
+                        max_pasid_log2, exec_perm, priv_mod);
+        /* PASID capability is fully emulated by QEMU */
+        memset(vdev->emulated_config_bits + pdev->exp.pasid_cap, 0xff, 8);
+    }
+
     /* Cleanup chain head ID if necessary */
     if (pci_get_word(pdev->config + PCI_CONFIG_SPACE_SIZE) == 0xFFFF) {
         pci_set_word(pdev->config + PCI_CONFIG_SPACE_SIZE, 0);
diff --git a/include/hw/iommu.h b/include/hw/iommu.h
index 65d652950a..52e7f0cd96 100644
--- a/include/hw/iommu.h
+++ b/include/hw/iommu.h
@@ -14,6 +14,7 @@
 enum {
     /* Nesting parent HWPT will be reused by vIOMMU to create nested HWPT */
      VIOMMU_FLAG_WANT_NESTING_PARENT = BIT_ULL(0),
+     VIOMMU_FLAG_PASID_SUPPORTED = BIT_ULL(1),
 };
 
 #endif /* HW_IOMMU_H */
-- 
2.43.0


