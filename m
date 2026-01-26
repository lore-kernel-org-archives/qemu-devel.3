Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91258CF65D5
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 10:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkKBM-0003qr-FK; Mon, 26 Jan 2026 05:50:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkKBA-0002bI-Gz; Mon, 26 Jan 2026 05:50:46 -0500
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkKB6-0006As-Sy; Mon, 26 Jan 2026 05:50:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFbg86qfuO556JzhevQN97Edppj4b5LIr222oD56cnSNxU0lfJVmjZkTQKieAhyTkehFBJokNXNl7MzZfjQq7w47fbYcko43xlLGTnKft8k3EaNKJ7tXKfg2Dk4uPLR7iUI0kbCLa+m5o6+jayB4OyTZ4dTWHm8xqMLcRTfdbubwo2L0ISL+/OmJwrYRnRFqTgW2u92DXuKJyXzBGxQMDWqGXYz6vS+/SOPPHMu6kBLZYNBcP9Hhk5WiVnGJwEXd3elbzcb3ZX3zZk6vqh75zCWA9m0Zax2hapDVgmCb5LAg9elOmL1YYnRjy4NNjsyJ6r589Qk77Ikgy5tXtBWN7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPEGxV12DxrdTNPvl66io414JLC2IDqCvf6IA/LHqSA=;
 b=YsnF3Snqiq2qolt6gXMwIZY+R2RxKbFdE5GS1ZMw336Gksk3NQdnPpQThbgXN5nAHN0NoshPBFQa1tWszhysXeGyHoVvYF3PGZ51uupWPCLRVRFgw+9IhkfOdFJK/iUGWfMC1S7mNnlswWxfc/bj6+RxOkAnSZbtkQlOVKndRlpXY9KjaZDSrGPAfzO8V3gV6B7opXaXDrd+klF4KeYez34n+g22onliLB+6WYUj9iLbzhZjpuzkcy24TwWwl++hE0nAE2rgRDmseZlAxkp3bFw3HWuJnoYmmmGOIVebLbpXu2Iej716UFQ9cGwotrhmyM0pkN6nmtZPzpm51Jen+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPEGxV12DxrdTNPvl66io414JLC2IDqCvf6IA/LHqSA=;
 b=HHZZxUnat2WxrfFbAiOOagPkicrqwTinl5tixxp5F1qM6H3zBfuivMKAi3rVxOs6tnCQVe6dWUDXQBFjU1yGNUnap25qjIfGp4UaRBZRNCSgFEZmdKzJBfHuOOSHsT2q5UoBg/vBs0ZheO36zrOwZrH/f0cZ+MuvaV3dm2+y+otEqv2RhvIvmaUvKSaMRiy5Zst66tW/lz3Y/czz+i7rg2gcL4ySPI8GIy7Kt2dTtimvZYgig1IiuhsGoe7pVBoRGyYWG74IM2LCLgVXn42l0WhCMAYG9kQfx62/rYdGJPn0Xi7TVw2tfHkr/q3TIm60/3oSwfZ2sLVwDJhovxWLWg==
Received: from CH0PR04CA0067.namprd04.prod.outlook.com (2603:10b6:610:74::12)
 by BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 10:50:35 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::3b) by CH0PR04CA0067.outlook.office365.com
 (2603:10b6:610:74::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Mon,
 26 Jan 2026 10:50:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 10:50:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:50:20 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:50:15 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>, "Michael S . Tsirkin"
 <mst@redhat.com>
Subject: [PATCH v9 35/37] hw/pci: Factor out common PASID capability
 initialization
Date: Mon, 26 Jan 2026 10:43:32 +0000
Message-ID: <20260126104342.253965-36-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126104342.253965-1-skolothumtho@nvidia.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|BL1PR12MB5995:EE_
X-MS-Office365-Filtering-Correlation-Id: e6938dbb-dff6-42cc-5e0c-08de5cc8bbf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Sg4IiqNafqAwWlrtuMlwHzmi6Cyv2MUB+NLN0kNsYyIX49JzR0QmcllojQYb?=
 =?us-ascii?Q?4yDU6khnzIJhH1fAbdKfIQz1TdRckXtNs+cjhvCvHko5vdf2zK6BiaS0OzXq?=
 =?us-ascii?Q?eUSQTlXVupzMPmZLtmt21bE0qpLAVHLH2vyh6W2KgKrIr0yxUPJ6M2gG6D4C?=
 =?us-ascii?Q?nl4tkoQQxeqBAYz3t/tQwOL8Fhk9LxRjBhap4+91Yt2r/+CP5nYm6BAHa2q4?=
 =?us-ascii?Q?CWeTSdn6WvyIRWKGHh7SSGkcD/k1QSFv9O0Xl8LIg24FYsrmUAZmuUB5g1+C?=
 =?us-ascii?Q?FHXCDkLdgFvEpbC+qL/oSCktu+zql7trxwOfkImi2pS2r8lbTmYAAuExU0rr?=
 =?us-ascii?Q?w87zbocP3B0ivjljlKffW25G7BtaI7qG7jFgigAJ1pqD5dTSeoKZa5aWME/R?=
 =?us-ascii?Q?cHcgwqezt8eTWcmANRk6S3J4HDq/trxQLnPMwJqeDYctyEscE1nUdNihUNNW?=
 =?us-ascii?Q?nvdMdWMVESY2YMQtPO58Of3juK/FnqO5fASL62yItV25i1ZMwVO2mUCqWesH?=
 =?us-ascii?Q?M0YXAZBUOPmC4qXfBgwTDyxoyhdJtBFRDdT06TnDlojiEvQESIzaoCD2u+hI?=
 =?us-ascii?Q?mJtsbXT5WwWkU/hWPpprU+P7fVYMBOlfSmueyeir7gsjEmqt3+p/4sPKAhpA?=
 =?us-ascii?Q?/Ru/v/1hnMmO5FHXh+HolEcUP5ukZJp8RAasMs2kbx7Sd6EPZuxG/UDVsgw7?=
 =?us-ascii?Q?QXlLjRF4Hj7YG9xidbd/93OtCYX62dPEAttPVJq99azcsKPX2Z4xzbZ6FLIr?=
 =?us-ascii?Q?yCluV68Zh3UH0IP8q6ZSfjE+Je9SOXEM1bMmUW3oZQlz5viWsKSIeyxuruuw?=
 =?us-ascii?Q?lpE0uPC/IRD4Iz1kzYfCmqutFChALyf42Cj7GMY+lQ1dyAO/omBxdSuQ1bAk?=
 =?us-ascii?Q?/n12FlhqM3aWNjDCPL2QoMAM8uYkZSiK5ZmBGNXs5AoRG4ygYxLoGZuVwLLQ?=
 =?us-ascii?Q?NQB1hREwqEQMS51XMWAIUljYsjq1eTs490u8xzGu1v+gumBy+TB0e1+hC0vq?=
 =?us-ascii?Q?F35DoZtmLnp3dwib82G0oEg3Si8Kt2EjFqaz7UwwTLNenJ40le3gTd8mP/gC?=
 =?us-ascii?Q?zm9uhxWnygynTx5DmswwCI5JwcN+ISwMxvT2ab2YxCzzJcRk9T7a7r8xy8wH?=
 =?us-ascii?Q?Z8X/AU7My+XbEZh/o0ePTmZ1pjV2Ymn6RaogZehw6Utcdnekmu72NpGHsb0g?=
 =?us-ascii?Q?Z77+eu9hUkDvzOkZsOUFr3azdvX/ycndsgHA4hfKN5yRF4H/1VqoVf7ghe2a?=
 =?us-ascii?Q?b80gKjTrFwTy6gN5C7ioE50ibWcjzneTkARSsNNRkhrAqczV4DbGTOBBJle0?=
 =?us-ascii?Q?kY7ck+XpimfFz+SC5vNyb2cTEC42CEfUvgNWPKp9L/lN3HdWn99laGpRtbEd?=
 =?us-ascii?Q?n7dfLqO7E5k35bDzX0Yu2fVsrAA1Mz+CDE9H1bE5l8bC/RbiXoedykk1RcuJ?=
 =?us-ascii?Q?mIZlVzBjXJ6GgyeCZkAHSjBC263Al0CGFZImLfsCRRFBQ1EQk2J26j+ljRS4?=
 =?us-ascii?Q?TkCotAdaWix3od8ZdGfvgxyc+uMSqV25lheMDPAN+qilclgxtYBP1GNXkFGU?=
 =?us-ascii?Q?MsAR6Ni7rvNglz4izMbHWnNE2gOMycDelLUUKDr0mNCxQ0RSiuVqyeJC0FVo?=
 =?us-ascii?Q?HkC+Y9TuvAHSmIK1VKUFl9rvsyD6csNTrxJ/c/QIbAaRGeOtNBGRzdyersJL?=
 =?us-ascii?Q?dBnktw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:50:34.8317 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6938dbb-dff6-42cc-5e0c-08de5cc8bbf6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5995
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.587, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Refactor PCIe PASID capability initialization by moving the common
register init into a new helper, pcie_pasid_common_init().

Subsequent patch to synthesize a vPASID will make use of this
helper.

No functional change intended.

Cc: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/pci/pcie.c         | 19 ++++++++++++-------
 include/hw/pci/pcie.h |  2 ++
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index aa9024e532..c481c16c0f 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1284,18 +1284,13 @@ void pcie_acs_reset(PCIDevice *dev)
     }
 }
 
-/* PASID */
-void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
-                     bool exec_perm, bool priv_mod)
+void pcie_pasid_common_init(PCIDevice *dev, uint16_t offset,
+                            uint8_t pasid_width, bool exec_perm, bool priv_mod)
 {
     static const uint16_t control_reg_rw_mask = 0x07;
     uint16_t capability_reg;
 
     assert(pasid_width <= PCI_EXT_CAP_PASID_MAX_WIDTH);
-
-    pcie_add_capability(dev, PCI_EXT_CAP_ID_PASID, PCI_PASID_VER, offset,
-                        PCI_EXT_CAP_PASID_SIZEOF);
-
     capability_reg = ((uint16_t)pasid_width) << PCI_PASID_CAP_WIDTH_SHIFT;
     capability_reg |= exec_perm ? PCI_PASID_CAP_EXEC : 0;
     capability_reg |= priv_mod  ? PCI_PASID_CAP_PRIV : 0;
@@ -1307,6 +1302,16 @@ void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
     pci_set_word(dev->wmask + offset + PCI_PASID_CTRL, control_reg_rw_mask);
 
     dev->exp.pasid_cap = offset;
+
+}
+
+/* PASID */
+void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
+                     bool exec_perm, bool priv_mod)
+{
+    pcie_add_capability(dev, PCI_EXT_CAP_ID_PASID, PCI_PASID_VER, offset,
+                        PCI_EXT_CAP_PASID_SIZEOF);
+    pcie_pasid_common_init(dev, offset, pasid_width, exec_perm, priv_mod);
 }
 
 /* PRI */
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index d68bfa6257..fc02aeb169 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -155,6 +155,8 @@ void pcie_cap_slot_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
 void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp);
 
+void pcie_pasid_common_init(PCIDevice *dev, uint16_t offset,
+                            uint8_t pasid_width, bool exec_perm, bool priv_mod);
 void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
                      bool exec_perm, bool priv_mod);
 void pcie_pri_init(PCIDevice *dev, uint16_t offset, uint32_t outstanding_pr_cap,
-- 
2.43.0


