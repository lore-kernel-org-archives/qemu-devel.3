Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977CDD2502D
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 20:01:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf1ai-0003pS-UP; Sun, 11 Jan 2026 14:59:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1aU-0002xw-Vm; Sun, 11 Jan 2026 14:59:00 -0500
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1aT-0004EY-FO; Sun, 11 Jan 2026 14:58:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tn+4ghHY08OXT5LiAm6Oxi6h6gMz862Qew9s4kGmx5mfqOKhBLj02qUpkCuJskizibQlBt2IF/Oy1ljTVZfj3pm3qioLAgso1TrjVnIcUQkhc8EuyrBweno4PKY199CbEsKUfwA65t9pL8hnKHQzsQMXDNPqlRIsjXRFHPSOif6pgw0i/KNrBqrIM6l+/IqNnhaf/NxcFtALvwveqHxT+H5LTFyo9LHv1U92phIZBCBtr1hoS/B1dnwjVQSUQhxMoLr6QOtTF+Ug9t4ZNgRX5EOa3w7foMJeo9RmRotw1620rQ2LIleEZjDacli2PYXkItrsreoPzt4TI0TZQ9V6MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2K1766m/PdCqnjNrGL5CHJBlxsD4UESJAJKmxIvDc0=;
 b=Q7zJKicG3yKgsHCqj/72GJ5PTD3N5UtJw3XvqreiJX4/W3p29uliMQETdOHYdpvosVWW/qWgbWmjdN5wHj8qQ51r9wxlXkA70zSCeNW31zhW4kvsE5ay1b/cvjoTXA0eeqH0xiLMEuPELK2V2rq9fjtQ8vTgoVVL9+yAVzyRl8hcMxnHGddY5848dSyJBwUG1r8NYDhCwHDhz+J+ljtmM6fkXkcxZVZQfS8nwrNgtWjhu5wzQb+a77eELfHg1GIrFmNS9g96QXq5s0QR9Zxfx267jhGFUD0C4Yuxf9E/IhRYDmOGUcD9U+FVVo569La6bed8RVlK1uI2u6QkllnWxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2K1766m/PdCqnjNrGL5CHJBlxsD4UESJAJKmxIvDc0=;
 b=qlqRpQSKW1bTTWt5SQNXg31emKxjNNahUg2gfPKJTUanWKFmAmi3mnKioi3/Rmv1CZpURGwglZdeh+DY27bCmB5P3I2z8DXfm31fPagpaNJyWdj5VLafcZBsQrybDsHMCyXIthqPN6UZMX24OipCTECBe+kP03gErzb1yMckpNkhfSn0LJVd5sILPJbWz5YY35NixR/9B0hsGSUFkF3ViLJe8U2SpNhvSrG79275Xk7zeH5Zi9yWrLl5A0ZxGEKRSzAiQV1R4qtojMCoOs/hs8eMdvZQbKE8iDyjgueq7TvZUl80GUgbnIe4Wx/rlgBmQUgiGnxZvd05ofEqkKvCCA==
Received: from SA0PR11CA0012.namprd11.prod.outlook.com (2603:10b6:806:d3::17)
 by DS5PPF5A66AFD1C.namprd12.prod.outlook.com (2603:10b6:f:fc00::64d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Sun, 11 Jan
 2026 19:58:50 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:806:d3:cafe::5d) by SA0PR11CA0012.outlook.office365.com
 (2603:10b6:806:d3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Sun,
 11 Jan 2026 19:58:45 +0000
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
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 19:58:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:58:47 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:58:43 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH v7 34/36] hw/pci: Factor out common PASID capability
 initialization
Date: Sun, 11 Jan 2026 19:53:20 +0000
Message-ID: <20260111195508.106943-35-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|DS5PPF5A66AFD1C:EE_
X-MS-Office365-Filtering-Correlation-Id: d9db3d02-beee-466c-1937-08de514bd6ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|7416014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VNrwEqHVRtJgXK4XwQdPOFs8gHI9C6cCN6rie0hqn2ND+WrLJtdz9VyB0bNl?=
 =?us-ascii?Q?Xd+N83Cu3pfBWMsSxBvTx4Ca6Ea/vCmB7X6bc1DZjza0UinxBCXaWDR1RRcQ?=
 =?us-ascii?Q?EeAFg42EyFlRcc0dMI4GtGn0CIh6OyT3hOJ234pDIVeCLzAcoaOTZHexDwIQ?=
 =?us-ascii?Q?lmVHPsu+LpUq4otvcP9UoZ4SoU3fB6Q1cm39tFQZ91SPgW4Gir0F9XChmOuk?=
 =?us-ascii?Q?2Ojw/iDhRJDExth1p/d92FCUaYbl2pbC74Lv5nfohaf4++JMX9gfFWlfyozQ?=
 =?us-ascii?Q?wt1BqL1GDPLcVTgXXLp+ItnjUfAT6CTmHkjdd6KU+MH8/Yy12YniYFH5aqS+?=
 =?us-ascii?Q?/H0ShhCqcFTsw/q47z8/SG7rzRl4OqEzcYJiwnTNc6OR5/kaG9n+v6oNzdUk?=
 =?us-ascii?Q?MdfyH2gQstrJkK3J4TQCHZW9+ShxeSIqEmGmLkfKTFnBE6aCaXQDaocca8gP?=
 =?us-ascii?Q?UsgKs6Ae7EgDc2bpwlvrgvvlN80lLvNT4ThJEFrSovLlUI8cQ5ub9Ka7Bgfh?=
 =?us-ascii?Q?v4j6Q6ePLe6IiHBQUB4EzX84YLzFaNCWDKwFM7/j7pLggauXHp4kijuWqgoc?=
 =?us-ascii?Q?98H27K84UYnO9wT6r8qpHBIzFiiSjTb332gtLHnWR9ERtHZD1fUnSBiPXEA9?=
 =?us-ascii?Q?pRNKxTBjiVp48rvGovlKB3AMnX8kN5WvhTE0D5Mg09EC8QhHn56qEblUZ1pv?=
 =?us-ascii?Q?PkS8xQOLiKMZ4Al+KeYSP4zI57gg0Y3ySwCiOApYb+h3RorOqjCzW7HEGqK1?=
 =?us-ascii?Q?t/MPYQ0vnHroZUhXid2n/ic7oFRqczrt8Mt1Okcua1CtWTYzZtxRC8jDTtze?=
 =?us-ascii?Q?ZB4nxoIoGYfF8S1nvl6vnluUT/8jdXdu/gAD9bauslupIkTSPjzjAppDZh8j?=
 =?us-ascii?Q?4SoPG9QyTARV0bka5CMQOsS9apvYVA7GTeiWdyX+71wwblYa9Or3hNBZk+gp?=
 =?us-ascii?Q?Bhj4oGzY5tffCOi4/6E/xToIQGPxUOBgvhZvmEXPAjQ/DILgkRx9wZnP2Tq7?=
 =?us-ascii?Q?1tygSlYchLcKzcd9DkWH+MXW8zAoKS9R5juLdqrVoEw4HzHc8iDVVN50dgAK?=
 =?us-ascii?Q?g/a9AYvFh2kmU1KjIYqEQP6O/4NxNFcTlGJaGdYvRsWHD1Cw8BJMZJSBt95I?=
 =?us-ascii?Q?r/AN8Vo4BlkxECnxNBJLS/CdtFsvS0OxWRRr2aRSIXaBlDpzHY1yKaDC4mX9?=
 =?us-ascii?Q?byGOfxDJdT++w1Eb6y4Y+7QQhpJIge2HR+xztz4BjTHqbad8cMexnVxd/i4H?=
 =?us-ascii?Q?eTQUd5YUnKZrtdO+qdu5UtSUaa45Ix4tocj9xYFcdsQoXDR3vjT36cGKX/Eb?=
 =?us-ascii?Q?zPGcubZmpTUFagwXGyQ1qgpoBqCl9KaaYAaDJp6OoXx3Uma+3GWpF/Wlz4XS?=
 =?us-ascii?Q?OUSi9EFlo7eX05J4gQtGy7UG6vpioSectjz2Ia87wr1+vy3xpEn6zJhBw4Sv?=
 =?us-ascii?Q?erJ6UVRUPXudjOuUlW0mFb69Vfcf5pzqyOEsN2sOK6NhR8WRWT7ie1FmBZs3?=
 =?us-ascii?Q?109yWM2Aty62Ma8pAbZsDpYb1jqvgCvHm9Rm/Ip64rcZcAUy+5XtmeMk15TV?=
 =?us-ascii?Q?ihL4ODEz+u41BDxiSsE=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 19:58:49.7603 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9db3d02-beee-466c-1937-08de514bd6ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5A66AFD1C
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
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

Refactor PCIe PASID capability initialization by moving the common
register init into a new helper, pcie_pasid_common_init().

Subsequent patch to synthesize a vPASID will make use of this
helper.

No functional change intended.

Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/pci/pcie.c         | 19 ++++++++++++-------
 include/hw/pci/pcie.h |  2 ++
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 8568a062a5..efd5588e96 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1273,18 +1273,13 @@ void pcie_acs_reset(PCIDevice *dev)
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
@@ -1296,6 +1291,16 @@ void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
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


