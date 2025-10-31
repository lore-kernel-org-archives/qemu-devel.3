Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D115CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEmoe-0001fY-7l; Fri, 31 Oct 2025 06:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmnC-0007rj-BO; Fri, 31 Oct 2025 06:55:39 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmmw-0003IN-Hc; Fri, 31 Oct 2025 06:55:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q7bM18t+RXwhUu7sLTz8N32/fOV3keVFN6WZKTfLBP27Qmb6kKjUNIciI7aNURghpwX29IBm6TzcuDsCDWi9Kz2i69RxqXQ4iRfSFkHxT2f89hFgkxAaDenPfqI/hdxJ9gIOCQiy8fLvD7cvtNnX27vc8vTFwMqJXkKxzAQ95raRmWrxPxCqASWHiLByBILMkymUFPOnhp+8QFbHdWY7F1tKZSJi75OPLk2KeTYUmKBAJb9WkTtQYsn8G0hx8ouiOZoP5G0aU49KC1Yoa5FgBWxEuHbVawRrbkeeLriEMy3D8lYgWsPyUch4LLw9JDVC3nN2eHtB923UgNqlWmj9Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaBk8K+ZbBqyjqaseyc5ZDYR8L1YEkBF5/x+YRxd97Q=;
 b=lYdzCidAU3YJSGgvyDBHJJWrbS74P198zXJ3G1oA5uBKD425nYpYY0fla78xuqnEN1JpkU+2IMvFWaxYHJKZtU/wllsE8qfhP7e9wMyNPgwVtb1NUohqkb7feh2G9BMHqS6lcQVpthyrzT+DVxvSQQzndB+zlq5UgespI3azvxV6y3LtTjQ3htOGUU2GrT75bo2ApIVze8zFEIGZsRqN2jJo5XaImJT+JIkRerKVSRs4pMnWbQMsxYP8cEKUYLQWA1545dJrWCJ19zHqFb6t6Q2a526TlU3bv1CW+97UaaVPuJ1ergxhy70SmszKZ6wJWn02aRkAh/ERwb3TphnjEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaBk8K+ZbBqyjqaseyc5ZDYR8L1YEkBF5/x+YRxd97Q=;
 b=A8QUKMMjSOfpr6NmVmEteiUFMkJuIyuFlgHp6wLZDbuDCrXLOLQBuytqQGq48AbXbZnpjplBqTdEjq3Y8xwIN3o193aaO/Pr4biQVS1nT9pPr2xMZf4DVrIrfy+QhK8BJkq854vB3BC+RPIDxwZsdXEPmKBPkj6qNmiYIIrJn6HlIg3NHHnILPXuNJ8D6CPNHXu99nUw2vjFO55EjcM+ZBfiSfehq+A/6Yr2S27Op7v4gq1X5XY3rv/Q6Os6pp+c4TklqRLpDWJ07zlYX9W6ZudmOOcyeRpJZ8BxtByPK/C5rBYvv6HaVZwfU4SR0n2RdDl3QFpYRKYsbp82Ex2h8g==
Received: from MN0PR03CA0030.namprd03.prod.outlook.com (2603:10b6:208:52f::19)
 by PH7PR12MB5806.namprd12.prod.outlook.com (2603:10b6:510:1d2::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 10:55:11 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:52f:cafe::8f) by MN0PR03CA0030.outlook.office365.com
 (2603:10b6:208:52f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 10:55:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 10:55:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 31 Oct
 2025 03:55:00 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:54:56 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v5 31/32] vfio: Synthesize vPASID capability to VM
Date: Fri, 31 Oct 2025 10:50:04 +0000
Message-ID: <20251031105005.24618-32-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|PH7PR12MB5806:EE_
X-MS-Office365-Filtering-Correlation-Id: 15dd7500-2a5b-4f82-11b1-08de186bf67a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|82310400026|376014|36860700013|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?58xLwGrrpTE9EZOznh0qEGwx8ZGcbb6K03OG4UQSmH1TdjMVpYe4FLBKuhir?=
 =?us-ascii?Q?Zl57wWruBzWsuOAmLdDBupBoQxY7gy0zJfOmNAK1Fw0BzljmAmwJwqxzOdQE?=
 =?us-ascii?Q?hMq5DcfvXHsfZOtLFHbTTEdWc/a5Z41KRpgmjhepIeiU3IEdF6l1XalYKd3v?=
 =?us-ascii?Q?NSSa3nKrzAkcUlmqRYRAlqOaGTjeVLGrBXgOvhoeiGqzaWSxN+egIM5/6aiB?=
 =?us-ascii?Q?470VgVcKVNoh64HO1ePg/muMCaAF+XQlaPL1QSwqSNeHaf1wMzkJsS5xrFjH?=
 =?us-ascii?Q?5ezhmoNNaTHsXWOkOSQFuuP0UGhWs71Pxhe5F1W5pdvAJPeeVqBpCPgvR6aW?=
 =?us-ascii?Q?641bpqcOaNIlLyyHk5Cw21+1Jyh8fYCppWslX7xzbXhGdgiL9PoqzB9HzBrv?=
 =?us-ascii?Q?1f023YLIv8GF91fK6QWabUZNRytiR9Ygp36TvcB4+FwWHspBlNjq8Ecbgd63?=
 =?us-ascii?Q?Np/owbrx30aSwTCD2b7CkaZ29aIJoAWMtXo5Xgmbd/Ywq9DeNYnPfCU+pCWV?=
 =?us-ascii?Q?ccgZYdvAlZoE6haUcCExrMr+oCwuWWRcVI046kJOk0wF3sxZxq88JVJrRIp6?=
 =?us-ascii?Q?b3l8OkQM+yx/PQxbDApnRwusRj7GHrDHsdGyDzZPoARRBlrfffVvEKGKLho8?=
 =?us-ascii?Q?ZHJoBDituuplE9z0yB/bDmdqvI1ckhiX1bFjRCndNlT/9YKpbAVjFEP0DeLw?=
 =?us-ascii?Q?uPto2WuwK7LwQUwwDakB3eoPMU8mBzbSgV4Iv8KX8lFgGMGOmwIH9+JQAdql?=
 =?us-ascii?Q?3AB35doddZAUzp07ZL1aqDOgOqNRbtrvaBNQOzqo+mRCoEoewDVfgsI9KFXO?=
 =?us-ascii?Q?F1M6Qt2d4vBWFRTmubyEfY3FsoQScDlU8qNMYnZnMsplnVjiv7hlxtpJNrSj?=
 =?us-ascii?Q?e6Wdn1oy2u+J2vM7zqT21gBwo7KULxHkkhTDQcE7zsUWwtTnOPLjzym2wRkG?=
 =?us-ascii?Q?EdVjfs6T+Y9M0LnMP683l0kzthEgYv04W1iUQHUAcnlScOhd5r4Wedp7K9zZ?=
 =?us-ascii?Q?P0dH9otxT6bu1MZeyGY0nGcoI7miSJ6M8Lfx7HhzDcrk0mN/4dS0NlKvrE43?=
 =?us-ascii?Q?7OgFe51SlE8ibkdXJAE0DKDuagWiVioLrlDUJkm5DH0OHik//1z80+K+uzYR?=
 =?us-ascii?Q?Umtdz2lCd7Xj8h6YYrKlW9/gYf0tiuBHtatwXlJieYmVAwJWA0uEaufwoku3?=
 =?us-ascii?Q?/d9G2GQnj1Liy+++OxK7KpoReknX+BsuW590ilnev4CodyesE1XF+Y80Qnhe?=
 =?us-ascii?Q?oIaX1DzNIsa5TpBoTLtmofgDaZe5zaE3Nr08UFS0j4sz1qGOuCfoXpvGJ/Vk?=
 =?us-ascii?Q?9Cwhk3KpW4ukVqogFsc/0NzcDD73L3QZJag6fF0Inu1B7PrOD7Zp9ch1sCB9?=
 =?us-ascii?Q?cLONtaoUSejmM01Ms6TpTKomDtV8Iz63jPrktnahywxUw8J5TwXq0dL4HhLD?=
 =?us-ascii?Q?2b2jX3M5afaALnL3i1NOolGqfiHn0zGdAKIJraK+V64E3AhuhPuLxJY+JSci?=
 =?us-ascii?Q?sO8koGA2/okr/Pwd1Fkk1gm0Uos2ItzJVUSh0Yf0BpFdRyOcRGGJl0o8zmxx?=
 =?us-ascii?Q?tAS+P950Ba/lnW27yZ4=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:55:10.7183 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15dd7500-2a5b-4f82-11b1-08de186bf67a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5806
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Since we add a check to ensure the vIOMMU supports PASID, only devices
under those vIOMMUs can synthesize the vPASID capability. This gives
users control over which devices expose vPASID.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/vfio/pci.c      | 37 +++++++++++++++++++++++++++++++++++++
 include/hw/iommu.h |  1 +
 2 files changed, 38 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 06b06afc2b..2054eac897 100644
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
@@ -2578,12 +2584,43 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
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
 
+#ifdef CONFIG_IOMMUFD
+    /*
+     * Although we check for PCI_EXT_CAP_ID_PASID above, the Linux VFIO
+     * framework currently hides this capability. Try to retrieve it
+     * through alternative kernel interfaces (e.g. IOMMUFD APIs).
+     */
+    if (!pasid_cap_added && hiodc->get_cap) {
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
+        bool exec_perm = (hw_caps & IOMMU_HW_CAP_PCI_PASID_EXEC) ? true : false;
+        bool priv_mod = (hw_caps & IOMMU_HW_CAP_PCI_PASID_PRIV) ? true : false;
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


