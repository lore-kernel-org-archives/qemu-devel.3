Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F3FD2502E
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 20:01:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf1aj-0003t4-9k; Sun, 11 Jan 2026 14:59:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1aQ-0002w7-1U; Sun, 11 Jan 2026 14:58:56 -0500
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1aO-0004Dz-Cb; Sun, 11 Jan 2026 14:58:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGYphqXJNEHA7RzTnse9mPYcvSezVqNh44QARObPE091Ed7dtjaRo33ES8KmgqlX0zTMPV63tFi3W9PD2/SJaEBNCkO6vXDEsBFqaYsg3fg+z0rv9YrwunysmJO1dUILLl/Ab+MgtLT37s0QWAuaBFaDnctjJg07JBs8ZrFPJi+msFWnpL/ed14rpun+gtom1LfSfV0l7fjSi6I4WhBwc+CLUe/EOFY7t2H2qvG9Te+roVN3JnRPudW3sUrbdCoRbJgAC840e34PLbJRL1usAWW+Kr2kwykmUtnA1aObNCFrJN7LDU5fCqvV6r+GS6JXjGpVcs+T8geZA9IYE1y3+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WhuO7AjTxcMZrMfhhAnY9gQlmp8OZzF9eHpdUnTqnc=;
 b=DwvYmTnpnIAbEVfvmqKuDLQpIhdJyBvwUuv9/cA8B+/yRa7RAg5FBzsV84RwdUjJhXDx3DbfPYU63zhPat8XJCuKuuoplWsPojBdtHSzgGPNDMP6MFg6XRjbGTvEfuNT+WnYvuCLPLOo3fB/0fhHixJDV+cwXnKIxKiFZNnwZUTa9kpEfeUGuKK0h+yXEdUBs/e5e3vRRXchK4BSaDg3z3RykI6VeVnzV6qtFzoM80Kanhq/KUplyCxWaAbOoBG4cGngSofSDm26/i7zWs1yds2FjCAZ0uFVaxT1p2RyXbo9WfJcJFFCvqUJ++OLEQV8XOlyG7Cxknfz3X4T/xtfxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WhuO7AjTxcMZrMfhhAnY9gQlmp8OZzF9eHpdUnTqnc=;
 b=LrlU7mZ8U/ypLpgNB2oVEDGOr+tMI+65bfg2ILbHIwLNE3ZhSYHnY+KQEtXR2PVk+ptS0gbErL/LlK8AAoQPWoaLwm6PRAflAXrjA4o5kKIvykCvfaiZ2aaVYQFmupHwVZer52d7tvA4MDEdKO7kOCiB9RwIxVDRnXvSVNBYq72J+xFyQshL/QZUP2Euvk4VnOSzdz5zNv/kdjVVXUOjNhegRBKeWNhMadEAfWudg8TBTNyehBu04hnjfYkO4q1eUsAUa7OI30JnkrZngKCz1mys17XjvPGCum+SKYjLEU960CC58ocbEbLyRRSCOlYHSP8/D7kreSEuEMBwSxXxCw==
Received: from SA0PR11CA0007.namprd11.prod.outlook.com (2603:10b6:806:d3::12)
 by IA4PR12MB9811.namprd12.prod.outlook.com (2603:10b6:208:54e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Sun, 11 Jan
 2026 19:58:47 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:806:d3:cafe::7a) by SA0PR11CA0007.outlook.office365.com
 (2603:10b6:806:d3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Sun,
 11 Jan 2026 19:58:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 19:58:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:58:42 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:58:37 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH v7 33/36] hw/pci: Add helper to insert PCIe extended
 capability at a fixed offset
Date: Sun, 11 Jan 2026 19:53:19 +0000
Message-ID: <20260111195508.106943-34-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|IA4PR12MB9811:EE_
X-MS-Office365-Filtering-Correlation-Id: 21b637d5-f8e4-451f-59ba-08de514bd54f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U1Qifk8HPSPESBnexowIlcuRTisLrK0ws/IcK223Har0dm/3GtJ3OmnhdZvb?=
 =?us-ascii?Q?baXAQOcu+hTDlw9FVo2BNlmtBWNb2Pu0S04ohDmEaUunJzKWyaOwpfDRJvbu?=
 =?us-ascii?Q?R5EuMOXJBWzZRpfeL0e7umGfUHEKtgWrGyreFRohsk/efK5EPXcGU3WphonW?=
 =?us-ascii?Q?PZx/LU5WO3uBCOBm8ZyoFa/2fG4pCK8j5+sM4F3sAyABZCItdPqY5o9LKoee?=
 =?us-ascii?Q?oiF6X3i0HW55FpC1DnCOA4T4P1QlXcG+DNj9zZNcvE51q3I+TLlodmgVX0iv?=
 =?us-ascii?Q?yeiOYAsyPN1ISfEwk1ZbGTjko1HplbXzqYoO5Ey7qHBzYVOUcRt126pt7mVA?=
 =?us-ascii?Q?nT/npfzidI8fdZNW4jp866gmnYofJTRSeKf/wm4GM+VxniEoadgZH4reNhOA?=
 =?us-ascii?Q?hIEKuXXmEKyqaAS28qmf9qcFoADPAN/DJcE4tASnaWnAiFCFCEY8rtroNHTj?=
 =?us-ascii?Q?o1HPYbj9URjkGmbNoFGJ6irgUnOv6y0Hx3w5fCUY+9xbmr/RzuT+GKZO78m/?=
 =?us-ascii?Q?rCAaSSjr6sOGRVsVYFDJk9xvpJzKV9mjktOGDxXRJOmal0bT2pYX+RftHWNn?=
 =?us-ascii?Q?S7qMZBrbOVEXK6eHsM31F1LiEu1eEw7Ckv7VOsQIs7an6eoHRw+8bvag08Ja?=
 =?us-ascii?Q?qujqSlDwrv3Fbc62lErRIGJGep2/B4QNXzX4JZAH/9SZsoO9yUUbkK8zYtIe?=
 =?us-ascii?Q?tj6TBxuuFcsM/1S7fRCCWwdjg1Du0mlxmPZM+VCNeGK1sBmViCHCKJ7E2QNd?=
 =?us-ascii?Q?B/sXZV2WH4PQWvSgVybbsQh0Vc9NExA9LgA7NYJhYMqi4SlMXGRTa3S7gFyq?=
 =?us-ascii?Q?nWK6QT3P6XcOZWmQ87iOwk95MJk/8/00lm2rSy5MVVOqNBxFUQ3Cp0kaPGVf?=
 =?us-ascii?Q?iwWWcUx2L/9bz3oBAz+JONH7TAeXriCrO6bbcC60pKD9mbkIMiLd/ZEEws7L?=
 =?us-ascii?Q?Bs7MP0VptyzwiEJYRKv4qG+YNJHwMsLcQ3xpA4Add6wi5Sniqe+HkRILln9a?=
 =?us-ascii?Q?OSiYctpTnrYAD60tBq96se5R3gTZqDjaWoJ2oga+5eXJvywG+mqeSJxtvHyv?=
 =?us-ascii?Q?11n8Wp8/6vKRyV5rqxURr3sDp3CO6zuo1cLnOPxE1jk1OwXUFheHJO5UTeRy?=
 =?us-ascii?Q?+5/R7tMx03JtKCQJWIyHcVAhnyoMsMIR9r9NsOunQdg/CZEjFtZWsKo6GvAF?=
 =?us-ascii?Q?hnhKgrEE+kPUI43WrRvc4RSQz3WTdu6YclyoJyHGMJ+asevX2hRwmAS5IXQh?=
 =?us-ascii?Q?wCWo93iQUdQhOsFXl4tQmCpLjjlcOYhj1TYNo7dC7taGgNpx9ZSGF1mCxTg7?=
 =?us-ascii?Q?SfnUO+sb+fchxK/alVj/k/S7WW1c9yy11U1Gkwtve8/ReQTQBGaxrbMtZ1VY?=
 =?us-ascii?Q?I38oTCNmcoFMuZk/4qsYW+11isfwe+pcsl04Y4UqRd81IMs2koLBIAwt22G5?=
 =?us-ascii?Q?K0BtKFsD0x6G6Iw6XH65fdfvA3C0SRgac4yUEqIaZ6LJEnW5H1HJibjWCEzM?=
 =?us-ascii?Q?GDntwEBaRcHC+DyEwPzgQgsIzgU3io/uKGcfNR0JkLpqdiNBGmUZZQTaipWG?=
 =?us-ascii?Q?SoY/Ws1ife8fx/zpIcg=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 19:58:47.4701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b637d5-f8e4-451f-59ba-08de514bd54f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9811
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
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

Add pcie_insert_capability(), a helper to insert a PCIe extended
capability into an existing extended capability list at a
caller-specified offset.

Unlike pcie_add_capability(), which always appends a capability to the
end of the list, this helper preserves the existing list ordering while
allowing insertion at an arbitrary offset.

The helper only validates that the insertion does not overwrite an
existing PCIe extended capability header, since corrupting a header
would break the extended capability linked list. Validation of overlaps
with other configuration space registers or capability-specific
register blocks is left to the caller.

Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/pci/pcie.c         | 58 +++++++++++++++++++++++++++++++++++++++++++
 include/hw/pci/pcie.h |  2 ++
 2 files changed, 60 insertions(+)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index b302de6419..8568a062a5 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1050,6 +1050,64 @@ static void pcie_ext_cap_set_next(PCIDevice *dev, uint16_t pos, uint16_t next)
     pci_set_long(dev->config + pos, header);
 }
 
+/*
+ * Insert a PCIe extended capability at a given offset.
+ *
+ * This helper only validates that the insertion does not overwrite an
+ * existing PCIe extended capability header, as corrupting a header would
+ * break the extended capability linked list.
+ *
+ * The caller must ensure that (offset, size) does not overlap with other
+ * registers or capability-specific register blocks. Overlaps with
+ * capability-specific registers are not checked and are considered a
+ * user-controlled override.
+ */
+bool pcie_insert_capability(PCIDevice *dev, uint16_t cap_id, uint8_t cap_ver,
+                            uint16_t offset, uint16_t size)
+{
+    uint16_t prev = 0, next = 0;
+    uint16_t cur = pci_get_word(dev->config + PCI_CONFIG_SPACE_SIZE);
+
+    /* Walk the ext cap list to find insertion point */
+    while (cur) {
+        uint32_t hdr = pci_get_long(dev->config + cur);
+        next = PCI_EXT_CAP_NEXT(hdr);
+
+        /* Check we are not overwriting any existing CAP header area */
+        if (offset >= cur && offset < cur + PCI_EXT_CAP_ALIGN) {
+            return false;
+        }
+
+        prev = cur;
+        cur = next;
+        if (next == 0 || next > offset) {
+            break;
+        }
+    }
+
+   /* Make sure, next CAP header area is not over written either */
+    if (next && (offset + size) >= next) {
+        return false;
+    }
+
+    /* Insert new cap */
+    pci_set_long(dev->config + offset,
+                 PCI_EXT_CAP(cap_id, cap_ver, cur));
+    if (prev) {
+        pcie_ext_cap_set_next(dev, prev, offset);
+    } else {
+        /* Insert at head (0x100) */
+        pci_set_word(dev->config + PCI_CONFIG_SPACE_SIZE, offset);
+    }
+
+    /* Make capability read-only by default */
+    memset(dev->wmask + offset, 0, size);
+    memset(dev->w1cmask + offset, 0, size);
+    /* Check capability by default */
+    memset(dev->cmask + offset, 0xFF, size);
+    return true;
+}
+
 /*
  * Caller must supply valid (offset, size) such that the range wouldn't
  * overlap with other capability or other registers.
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index c880ae1e04..d68bfa6257 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -133,6 +133,8 @@ uint16_t pcie_find_capability(PCIDevice *dev, uint16_t cap_id);
 void pcie_add_capability(PCIDevice *dev,
                          uint16_t cap_id, uint8_t cap_ver,
                          uint16_t offset, uint16_t size);
+bool pcie_insert_capability(PCIDevice *dev, uint16_t cap_id, uint8_t cap_ver,
+                            uint16_t offset, uint16_t size);
 void pcie_sync_bridge_lnk(PCIDevice *dev);
 
 void pcie_acs_init(PCIDevice *dev, uint16_t offset);
-- 
2.43.0


