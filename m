Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E33D25031
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 20:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf1b1-0004oE-V2; Sun, 11 Jan 2026 14:59:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1ad-0003Qf-6K; Sun, 11 Jan 2026 14:59:08 -0500
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1ab-0004FM-Cy; Sun, 11 Jan 2026 14:59:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oKp9IUfL2LMJLgn36GtkZ9J7u7tEfySppG1EkL3VMMCOnd4sniatAir21s9yNbhSs980MCDJhsoutgUZi96nL7oPgw9FPOztzLhGHHUS8ASRDVbQxAOAvcQLuMPWO+C5Z9MhTzNfaG+eUqNqlMLIWQLSHS857SgRk2yg3GTnen7tkhUzCP+ADuYQ1RoT24eGN8a/FiFkKybBs+Fk7LEo/fiKOnmxtCHNzLgW7QOA6C8yCFtMcwDZHWIgSn8k9qEwVANVu0bDrgwDBBU0/1llugySrmtii64DWaQaS9kh1lYF9miDFhnepzH3QLsElvw5eBfLPaicnId/RtuReEkz7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvaxIvZ+vgjrIkUKsm+UhDhGQlso4n7i3HJ1max+gOk=;
 b=WXVfcSyhLYsdNmob+LMhaGP+n8SVHgXYWsiT7JtyV3GsBuzwHMB8tmS5c7Pqo72AzFyBu0V8m88wZ5bMOThk0iFwuzIxv9xa74/loq3KUSQlvA2yu3NmNa34FFvomFWBHgBo+7RlovzbcUrGLABVLup+++hIWPiulUktlaNSEa6v6vnxqvpKXPATwylw+lQIhfimxWj5C9pSyoxToR2YgpAxBti3EAXcSJPQFjMAdM0Kc5B02lgtYdt0oi3bBTL3+zQ+rseLoDZ8a6YbKIQ+7/m/48Tq3gpGMD5vzwbhGjieYiR+8Y90hEu4O6WdcUqyr+AiQPaBOLbwZ3dM44jDuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvaxIvZ+vgjrIkUKsm+UhDhGQlso4n7i3HJ1max+gOk=;
 b=NIHuiUby5TA11yyDp0+8erw0BMd0q3Go5ZVgyGqNSNzvJR1/84IpnRg6rOpUCqKFqvq7BYxIXaraKcZjr39MiiMiS/UwzM6zSIY2Lue3ui9zd3xIfpBMqpmIPm2BVPeMMrnDQ50GhVk8XhOdbEjDJYTvcLfaxa+rK+/bSobmKf2c4Hqiovjdh3RfJ0+Lw6gPr26iWT15XtLCkOA5Zh8dcmHIQLBx2aCEGeVj7hT2tIWCOmVUgI4yryVVYLAqkl5vomisW55wtoofaM2VGQgV6V65NTCLzskeYu9NrLrqIpb5JN+ek+bGMBhKZw9Uo56njU/PO48vGLZtC4NPsaYuFQ==
Received: from SA0PR11CA0046.namprd11.prod.outlook.com (2603:10b6:806:d0::21)
 by DM4PR12MB5889.namprd12.prod.outlook.com (2603:10b6:8:65::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Sun, 11 Jan
 2026 19:58:59 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:806:d0:cafe::66) by SA0PR11CA0046.outlook.office365.com
 (2603:10b6:806:d0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.6 via Frontend Transport; Sun,
 11 Jan 2026 19:59:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 19:58:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:58:53 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:58:48 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>
Subject: [PATCH v7 35/36] hw/vfio/pci: Synthesize PASID capability for
 vfio-pci devices
Date: Sun, 11 Jan 2026 19:53:21 +0000
Message-ID: <20260111195508.106943-36-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111195508.106943-1-skolothumtho@nvidia.com>
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|DM4PR12MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: 05c00e13-d753-44a5-3a35-08de514bdc6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Iuk/0ZpQrHWgNYnoiAWUbqsFD9+6jy+ce0twj+iVLSkNXXsW5ogA3bUEnaRp?=
 =?us-ascii?Q?y6haSlbLrEqtPa4i8UeE+HgtxD6kUgOfdzISZiz3/0yXbG0fmCefyBKW4RfS?=
 =?us-ascii?Q?1fcDzN+GmmYnegV2LYNpFFsu9hGR1zecEH7P3wy8XJul3cAdTz3wfAVbvI2C?=
 =?us-ascii?Q?5aarMI2wzW2SlkwG1ehGdGt6yPO0ENCpA0Eyty2jobM9Xm+L5kr7An/y+7Td?=
 =?us-ascii?Q?JZ5JrxmvuJlLVIZaVYXAbJgV6YQu2XjGu35V3BtgbACAtz3zpRCpW/Pwo1UP?=
 =?us-ascii?Q?Bt6+wTxRWnIJVvpoihL7kwRTTbDbesGXxn1cD1mWW9q9PSprBbJxKRILuEwD?=
 =?us-ascii?Q?WgARLr7AvvkR5PlqVzqaOB/0Uv/3bXSECG3XDi8hTB8waRznS7hZzI0POq2l?=
 =?us-ascii?Q?lsodD5seX52nxg+FfPDxPo66XCUQlLmTzHIHXjo69wZs9hekk0pBzcb+xY42?=
 =?us-ascii?Q?4Lv37+ztbKel6Nam19W/gg2P15+IWZYHcapqKl4JNP/pt9M9lFKTQJao/jj+?=
 =?us-ascii?Q?4ugg40YLAgT99WPkcC56IIhnYod/9wtGny6Qs7blE829jJUjLx2O7KTYlbnn?=
 =?us-ascii?Q?T6n26aSxgwrEGOPSa73VSo4Y1AR9kMbqPLc+IZ+HUHGjALXZZodGpbC5eedn?=
 =?us-ascii?Q?oe+Xo6mIFRT271exQLoEOXGJfxZSznm9ngbXJrnbmWxRkDt6vRIeLTIAzBZP?=
 =?us-ascii?Q?E3uebA08ohfHBvu0c/EPwS/jJk7y4Bz1VCADQwwEimI3hqWfbfgjjBGLn8AP?=
 =?us-ascii?Q?U7oFOjPffKjdN4c6M4c/PbbGxkN7GnOARIN+Rf6Rl7LbRs5+pEk0U1blSkGl?=
 =?us-ascii?Q?XfL4n/GgA3EF47vUtCj5Up39Sz7oBNmdGP/oQzgMRt/y9orpfDGetfcYR/hB?=
 =?us-ascii?Q?Slg5pWqCmkRrVejdWYa/BlaDdVyV5DKaQyT3bMIxNWByRHSjs54SV0zdfDvS?=
 =?us-ascii?Q?f8N77s9pyJfW9BoiUA+4pq6TNyhUXWJrVZ4acoN5pHCKauicNCxy4H8YzkqN?=
 =?us-ascii?Q?4ZG08J+QQCxZ4UV8MMkhZSgnY+O27iuPnvdoTJ9NJ4SWm5056R1+0hQkrTge?=
 =?us-ascii?Q?swma7lDbdxR1+luv1nEPYQqHXc6h2L9JwbHKfhtxnSeagduQeej8uV+YuyEW?=
 =?us-ascii?Q?7Zqhvfxl/JRi2eZyN0/qmV171TpquvirwNEXS9geet41EwqK3lJvQpSjDSfD?=
 =?us-ascii?Q?rQzHoD30Y4dwdV0RvG7+7qQOzQDA5nXgAQAcY+MDP4L62Dpr0sSBK8UFuUsK?=
 =?us-ascii?Q?t/LIOqvR2Exfo//ZQY8u8bDp0wPP5tVMA6uaGPsKhlk52WjusVCL0s5aybRb?=
 =?us-ascii?Q?hNBib00qZhI75FKWOl5X25dSKZY4to2QCsfmgOZlEeCUxLkYIaqvKEIih78T?=
 =?us-ascii?Q?QI92ULJKV+rFw/oJK1XR/2ROGLPO9ZjZujt9gLrEjvUhtYyeJzHrldrCTH3K?=
 =?us-ascii?Q?jBVYP9LtNlbtL0zsYwuKqV1+F3NYZP56S6q0iE1ymNC/5OozJZMsF0t0BNMv?=
 =?us-ascii?Q?V1HIxLRYwnvoJ8SYOCPyac3iYRKEPhgXAYT6tA3Bjj9NfwSdqQwdlD/uCP4O?=
 =?us-ascii?Q?9JH3dCOPRIkxsi5Iv24=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 19:58:59.4312 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c00e13-d753-44a5-3a35-08de514bdc6e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5889
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/vfio/pci.c           | 84 +++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.h           |  1 +
 include/hw/core/iommu.h |  1 +
 3 files changed, 86 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c734472721..96990576ac 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -24,6 +24,7 @@
 #include <sys/ioctl.h>
 
 #include "hw/core/hw-error.h"
+#include "hw/core/iommu.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pci_bridge.h"
@@ -2498,9 +2499,71 @@ static int vfio_setup_rebar_ecap(VFIOPCIDevice *vdev, uint16_t pos)
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
+static void vfio_pci_synthesize_pasid_cap(VFIOPCIDevice *vdev)
+{
+    HostIOMMUDevice *hiod = vdev->vbasedev.hiod;
+    HostIOMMUDeviceClass *hiodc;
+    PasidInfo pasid_info;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
+    uint16_t pasid_offset;
+
+    if (vdev->vbasedev.mdev) {
+        return;
+    }
+
+    hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
+    if (!hiodc || !hiodc->get_pasid_info ||
+        !hiodc->get_pasid_info(hiod, &pasid_info) ||
+        !(pci_device_get_viommu_flags(pdev) & VIOMMU_FLAG_PASID_SUPPORTED)) {
+        return;
+    }
+
+    /*
+     * Check if user has specified an offset to place PASID CAP,
+     * else select the last offset as default
+     */
+    if (vdev->vpasid_cap_offset) {
+        if (!QEMU_IS_ALIGNED(vdev->vpasid_cap_offset, PCI_EXT_CAP_ALIGN) ||
+            vdev->vpasid_cap_offset < PCI_CONFIG_SPACE_SIZE ||
+            vdev->vpasid_cap_offset + PCI_EXT_CAP_PASID_SIZEOF >
+                PCIE_CONFIG_SPACE_SIZE) {
+            error_report("vfio: invalid x-vpasid-cap-offset 0x%x, skipping PASID",
+                        vdev->vpasid_cap_offset);
+            return;
+        }
+        pasid_offset = vdev->vpasid_cap_offset;
+    } else {
+        pasid_offset = PCIE_CONFIG_SPACE_SIZE - PCI_EXT_CAP_PASID_SIZEOF;
+        warn_report("vfio: PASID capability offset(x-vpasid-cap-offset) not specified, "
+                    "placing at the default offset 0x%x",
+                    pasid_offset);
+    }
+
+    if (!pcie_insert_capability(pdev, PCI_EXT_CAP_ID_PASID, PCI_PASID_VER,
+                                pasid_offset, PCI_EXT_CAP_PASID_SIZEOF)) {
+        error_report("vfio: Placing PASID capability at offset 0x%x failed",
+                     pasid_offset);
+    }
+    pcie_pasid_common_init(pdev, pasid_offset, pasid_info.max_pasid_log2,
+                           pasid_info.exec_perm, pasid_info.priv_mod);
+
+    /* PASID capability is fully emulated by QEMU */
+    memset(vdev->emulated_config_bits + pdev->exp.pasid_cap, 0xff,
+           PCI_EXT_CAP_PASID_SIZEOF);
+}
+
 static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
 {
     PCIDevice *pdev = PCI_DEVICE(vdev);
+    bool pasid_cap_added = false;
     uint32_t header;
     uint16_t cap_id, next, size;
     uint8_t cap_ver;
@@ -2578,12 +2641,24 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
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
 
+    if (!pasid_cap_added) {
+        vfio_pci_synthesize_pasid_cap(vdev);
+    }
+
     /* Cleanup chain head ID if necessary */
     if (pci_get_word(pdev->config + PCI_CONFIG_SPACE_SIZE) == 0xFFFF) {
         pci_set_word(pdev->config + PCI_CONFIG_SPACE_SIZE, 0);
@@ -3756,6 +3831,8 @@ static const Property vfio_pci_properties[] = {
                      TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
 #endif
     DEFINE_PROP_BOOL("skip-vsc-check", VFIOPCIDevice, skip_vsc_check, true),
+    DEFINE_PROP_UINT16("x-vpasid-cap-offset", VFIOPCIDevice,
+                       vpasid_cap_offset, 0),
 };
 
 #ifdef CONFIG_IOMMUFD
@@ -3913,6 +3990,13 @@ static void vfio_pci_class_init(ObjectClass *klass, const void *data)
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
diff --git a/include/hw/core/iommu.h b/include/hw/core/iommu.h
index 9b8bb94fc2..9635770bee 100644
--- a/include/hw/core/iommu.h
+++ b/include/hw/core/iommu.h
@@ -20,6 +20,7 @@
 enum viommu_flags {
     /* vIOMMU needs nesting parent HWPT to create nested HWPT */
     VIOMMU_FLAG_WANT_NESTING_PARENT = BIT_ULL(0),
+    VIOMMU_FLAG_PASID_SUPPORTED = BIT_ULL(1),
 };
 
 #endif /* HW_IOMMU_H */
-- 
2.43.0


