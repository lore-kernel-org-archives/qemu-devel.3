Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD72AC44506
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 18:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vicXK-0005Se-Kd; Wed, 21 Jan 2026 13:02:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicTs-0000ZS-HF; Wed, 21 Jan 2026 12:59:03 -0500
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicTe-0002Ez-Hn; Wed, 21 Jan 2026 12:58:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lOiCQXDfSDso7IIhzDzuo2PyO0wkq4G9wzIHjWrcf7PYUbYDM0vbsU62v/I1XBN0GtKNiacbbT2GgRJFl5LwyHSfCVeuaE/IYoeQiniP0c94sbdIPFQGLwGssZJQ9Rj6zTjUqf0nyBLKx2AxN++YTnYkd54KpoiTn5CaG3WgTQltosviR93x89h2Lbu/81YRuGH7Ivewp/hPeA/XeyO6SPFa0PVdFiJpDbyDEs/iwkfd5aqS0ZTVuTNoWfUvdc1MyP4GKwh2biqEj1aQCz17+IIxIVsmh1IEDZHaqNG+ngJbb8EF/HXBk20lrbuATbXaJwX1wo0tEbAYarjn8UTukA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPEGxV12DxrdTNPvl66io414JLC2IDqCvf6IA/LHqSA=;
 b=ts9t0h1VUpYMjHtCDwgXv6VRsFFv8CSmMltnBAAnYfuhu1MbjZ/B71+2/HloTj3B1p8zsgxZ1V7B2vPUQ6OSxsOtuqjr9OI2A/JI+EgVq2fDWmAPctpdY7Tgl3azISWhk5oVx/XKxGcgSs04ET707DqOMKp0nxNG19PyDfS+fFNaEJS6LpJ0347JZilpkJbNMG2nQ4YOuk3gtF8N0PxHUvKAXnrfvRf9zUIJ+lDOLTRXZG3bT8O2/n1ZJ8yBbjqYtfwWY/rA2FmhAE80SwUAWahgkWvjytyjsAlTTM0cvw1bD2oPJzEl0fBjkZzcle8J7Vu4xWYIlPOZeYW1kiirlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPEGxV12DxrdTNPvl66io414JLC2IDqCvf6IA/LHqSA=;
 b=cQcYnX3boKY9yakouezibmUYGekhKxcY5kERMqD3meo1G2+3iGd2IuwD9TZSyMTAntEDItSE4cUOpbj719y9HxSJiJvolIWWS8vcmKowTxSR5afCDl9LMflbHFgBVARdZeoUqTo01sKLZVxPdK6mX0fS2mECyMo0QH3JBCsZenIjhUOWO3b47U1mSGXne57+eWhIiXf2qj3ltREPA6W8recqzFndk5e7ELGYPwwFTpOrkDxDJ7Q9QN5y3HJSzT/wdmUdk8gksGHQqXSlDyQrUzsvEvjnTfJkOhPK1E+ws/HyZGrDSAcB3dtJ26Z4pmjgBUcH+071aFMn/YNOA75FjA==
Received: from BN1PR10CA0016.namprd10.prod.outlook.com (2603:10b6:408:e0::21)
 by DS7PR12MB6238.namprd12.prod.outlook.com (2603:10b6:8:96::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 17:58:37 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:408:e0:cafe::11) by BN1PR10CA0016.outlook.office365.com
 (2603:10b6:408:e0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 17:58:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 17:58:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:58:12 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:58:06 -0800
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
Subject: [PATCH v8 35/37] hw/pci: Factor out common PASID capability
 initialization
Date: Wed, 21 Jan 2026 17:52:40 +0000
Message-ID: <20260121175248.87649-36-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|DS7PR12MB6238:EE_
X-MS-Office365-Filtering-Correlation-Id: c2077649-5e09-4754-b9ab-08de5916b3b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/fKRuNzDefp9Sin0AdYctHsXWNFFbSNA8w5zrgd1gZcY1Qt2zQQDJud9o0mf?=
 =?us-ascii?Q?lVxZ4E2GdISlpcHbL4bxj2H4c2ryYD7FPpArqGczuFTSf13DD7w/q0PGg2/l?=
 =?us-ascii?Q?Hhp3TRRcpk7hi3qkpGWxI4Efrt0EDmSNTDOhSgdao4Lj3tyywD9J6AwrYwfq?=
 =?us-ascii?Q?dMMt0Zj22Dn2V7Fkf+l4DfqQeukE7PcGBUDgf+PQTKb9TFTV5FHObFXlu9ls?=
 =?us-ascii?Q?Bp3mQYtJW5SdarjtrHBsXj3/zx1x5eSWQaqP7rj10lAIiR6h+UePIFp8Kpa+?=
 =?us-ascii?Q?Qg0dqXikSwsx8IYzd9A8tPBhPG4V+Cc8qUm8QdfVN/Rwl/8uXGmdVHlv8d27?=
 =?us-ascii?Q?1N9kFV2ySuZow1ECJSYzUgarKU5pdHTQLgrcMm9WkvKbByiN0BPqRjWM3JSZ?=
 =?us-ascii?Q?ZtMbwPBkow71lHsZWcsEqnm07653ZGavgc9lnbVV59nuSWXDPH3srfswKnyb?=
 =?us-ascii?Q?TL8LD7zIbZduTYeIspvorLtRiOOdo6WQVTgoKDKSfyOioz0mNcMGmK3MOLlq?=
 =?us-ascii?Q?cmVCR4LGm+plw2xr3qgGwGCqvg0HBlvj3+epDPdrf1IeTk3yNQf8mfINPmWR?=
 =?us-ascii?Q?hS20RyAbP604268nGEi+ICaPfnNoY0vVb06a2pB1dtKkz+Vylcsh6L3tAXG+?=
 =?us-ascii?Q?YufZGVh7oBgAx8HXfv3rMBsIZtilP0Q9MyYt0VYzXrnuvd0vsISloRUdqBfC?=
 =?us-ascii?Q?EwXKxfjFm4ySe93Fbgl//HP6shfaFjKkegONmkbhwGuk3sxxecX0DXXU35G6?=
 =?us-ascii?Q?YazMvOzRQdTwcp3M+nWwaGmIK5sHX8SHs0M1GSnhFIklYGFaGkBUbvbOFZ6Q?=
 =?us-ascii?Q?wQFbZS6s/2VeLepGssK5VeEt85I50G++/ZW3OxK3UDjL8xrEGDP4ZscmIDKH?=
 =?us-ascii?Q?GJvk8sSmZSq9Y0dT7cZQXd3WoSJe60iOvu9Xb3DKSoJmxOFdZei3XmsLgeTz?=
 =?us-ascii?Q?o2T11siQwVAQjcUmMsNDcr87gYWPUR3+33IBUb4Nh2PrVaTO89aJ+clm2IIG?=
 =?us-ascii?Q?ktPVOxCFMl90lKROSoOEXLAr4yshTpv2oz8aZPQhaXSehGgVNdIvKZ1V93bx?=
 =?us-ascii?Q?a8O3zmQkEk18lbrGaOzZsHqXWQ9fXdat89467wMt8NYTzssNhxtgS34atDyT?=
 =?us-ascii?Q?Z42HGKD1FU55BusC5JgpWdxaCEBlWm3Hb70+juAUWp7oWewrIQhBkMQsVY9w?=
 =?us-ascii?Q?KVBKUgxPSL1uJxiw5sbWEGcBs9xyCBiuBJKH2LTg0njNo3MxtqXfRJunD57N?=
 =?us-ascii?Q?rc65dxBlyPcBatIWnhq49qDbrENhvSWryF08vv8bSuJB0k++J6qBqgK5GWkd?=
 =?us-ascii?Q?pTvERAh2EIQBi5xXhv9sCGXtoBwCJTCPjnQT2AalZ2b7T4Ji2a/zHXn72OYa?=
 =?us-ascii?Q?dVlMiMhl6tTX94KrEZ+RX8BEYXGW8eDj6k0QRkYJK6vpaoddBCGdu9uzKK0T?=
 =?us-ascii?Q?pv0+WwRnO21c5CJtMSO2VcfEAiTpMK+gvlohC7lBwt8Tu20iLOfrCORhA13D?=
 =?us-ascii?Q?Qf5nOuFiguLWWoK8Zd1FEeTghRDX0VAeqc0KJ7Fy0wftXCLtPxov2FrKSP/s?=
 =?us-ascii?Q?T4mOgZ9/mnuIWHsswjGWpvUIU3gxPOjscAHXGImwQsg09sKmsoFVG66rrUSD?=
 =?us-ascii?Q?n9Lbo5Q+vdjoQg+Pi9KzxbTr8NcABwYYT+UAYIgkCanX/2qlGKuUyHmr7Qux?=
 =?us-ascii?Q?dALZgA=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:58:37.0821 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2077649-5e09-4754-b9ab-08de5916b3b9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6238
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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


