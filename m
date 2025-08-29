Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F24B4CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN9g-0004iW-1U; Sat, 30 Aug 2025 11:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uruUF-0002qR-Ry; Fri, 29 Aug 2025 04:29:32 -0400
Received: from mail-bn7nam10on20620.outbound.protection.outlook.com
 ([2a01:111:f403:2009::620]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uruU6-0006Nw-PA; Fri, 29 Aug 2025 04:29:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ffyo4eW15zC4EGw/WUqGKtPOiGw6ezPIwRjpYtDd89N7VNDiw6J0b+9qh/3cJ4NzpiYqv0JTvXs7VeOxGdiZuEB3fjo/4JZmX7S1bk95xK8GjIl3x+Kdmcvuj7VauWrimkOqVoFH0NM33n+k4QPKmLoJiq2iQ3YuH/QJte8V790Q5nsViT5vuRCm9ToShWEWhFKql9evzUMVmN8ndfqRfqrRscbL100IOvkxF858CrgDxs/o3gPi9AaUlGqK4JhjJAtaOvrhnu+LQ8B3c9baNqzXALA4OAyGBO3Gsaj/YtoJP+ETKi2d4w+kZhqWiuVq+LtFPIZzVmYIOTydPnVxpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqUsHgMwSOtZZy1pvZPCmTRMLBj+9+ACk2xTR9ZmYt8=;
 b=KwAfX4pE0BD21LjLK2PB66SDrnk9smcllmn3LpPVOBEd6YetRaBhz6H48Nd+2cpkjw3q7BCU4bZUByJz2mEF6mf19a+oNYbK320Wn1z1ZCt0xho4FYBIR2JANf0ijuUNd2yBQ7EUb6rIWNC5hMlMRi3KmtaVntYahUEjc9Ze72tPp3CnUEGIq9GVk8Ce7dluwE6KPQs9i6XDhtExkmhMk/9gXIq3z/XufTl0RyiCP+ol6b0DjupRmgnNOmWyKB96fzSgB2QZqTDtMt2BGUjw/jpmyNGs+fNjHYM5cW6cmZyyRBYPKgxo37tkM3p3TG3ytSzRxWsJECn3ouc+Otgapw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqUsHgMwSOtZZy1pvZPCmTRMLBj+9+ACk2xTR9ZmYt8=;
 b=i1xJr1hts0/9u47d8UsFxr1YPxY1hX1Cxdxd8ilymnxttD8H8UJYGoyBg0bE4dC3Kq4CEQcV233JayeJ/4bCmFB1C1FgZO+gMi1tHoOrzNpb+sPBim2+EBILqYk5dCewZe5Mu1rNpdlRh+4v1ErPyFhYuuxFezNA5iCFtDURsI1NfkExzvz1evZMXjkC/ulYe/q7CA79085COvkek1Y12pS52SNI13OSJAgYwCsDeOEczLcez4MjtXoT9r70y7QnhTp5SBCTrriMYlOrGNk2C/IrOChtSgVYis2ZXJARKwOFzpWhfac2cKG84RzoRWdcKACAn6CaZIGYNpVLGL2ifg==
Received: from BYAPR08CA0048.namprd08.prod.outlook.com (2603:10b6:a03:117::25)
 by DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Fri, 29 Aug
 2025 08:29:11 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::b2) by BYAPR08CA0048.outlook.office365.com
 (2603:10b6:a03:117::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.20 via Frontend Transport; Fri,
 29 Aug 2025 08:29:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 08:29:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 29 Aug
 2025 01:28:56 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 29 Aug
 2025 01:28:51 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <imammedo@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: [PATCH v9 04/11] hw/arm/virt: Factor out common SMMUV3 dt bindings
 code
Date: Fri, 29 Aug 2025 09:25:26 +0100
Message-ID: <20250829082543.7680-5-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829082543.7680-1-skolothumtho@nvidia.com>
References: <20250829082543.7680-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|DM6PR12MB4356:EE_
X-MS-Office365-Filtering-Correlation-Id: b88ca651-d349-4f41-de6d-08dde6d620a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4hn5YuW9QqRq6C95jNFOjaH/CB1Knqhq/gSOZ9BeOdRy0dKT/DlVOEVqw9i8?=
 =?us-ascii?Q?fOIP6PycdgQHYszM1hUa8taZufHd/tN6zqZr+ZvS4C1+pZHdlR07MwhpQsEV?=
 =?us-ascii?Q?qrgOaDeGDvgFI4z4dTR7ccKy7J2OKzmpXQFwRYLEBVP7dKqGf3pIrsGzccay?=
 =?us-ascii?Q?wlrbsQvCICOE8XJ5SlkKuWYU592K++j2e0HbOoaB68E63zg+T3eIhbElDHyj?=
 =?us-ascii?Q?hpL42s7Ye3JrcD5xrlHNIEn1IYnyhRxBSMp/sywQJSqE3//mG0+N1Ic6NcO+?=
 =?us-ascii?Q?4ukBdt82/V5PlKZXsT7xEBkXSK8z8mGVPtPll2tJwtPab9v3/fIksAtx5sFA?=
 =?us-ascii?Q?5Sj94aGuExWkKbnBgZxdgQMR0BqSdQ+GJO7sCRpj/bS5zaKNegnhO0GVIRTZ?=
 =?us-ascii?Q?IDEg3Aa6p6vxvWxtX69HM657c/OLZOhHvjSEDmE+MsTeBWU8K/ya4AJ7B7D7?=
 =?us-ascii?Q?WBSpLG9o4Hy1//BRhjgXpUKAUMX2h8f9gCMQbdWQmqmD12HfflZ1UubAipYX?=
 =?us-ascii?Q?VBT40NLEwJNvuXEAjlBDnvdBU/ucWfpH1A/Ga/xUEVhqoMeDiKTtvR26qd5D?=
 =?us-ascii?Q?RkomTon1SBq98b2B4jDFGmqOAvKV3hK3UIKdy4yz9BcmFbr9OP6HUPaX6VPU?=
 =?us-ascii?Q?7d7RD/TdZ6dzKWZusGOVFiMidIHJqSJDsDRxM3WC07dyjjYibRYynhpHthqF?=
 =?us-ascii?Q?sI3NWzRnpa04tX7xMe6uuGNaOr8CaBMN5TyI4h9shKctcTSY+HjtkQTMXBeX?=
 =?us-ascii?Q?jmSoyhJLOsbBtNGWq5q2MM+Hf0Ctkm16lh0MMFdNikyILIOuF3UjQUhX8z3Q?=
 =?us-ascii?Q?ik6TCKN9CzfSGNXczZf+tBsuEGT8Fqfe6rEWk6FHaldIsRswdUc2ZLtpeBnB?=
 =?us-ascii?Q?/FNSe0sG7zOtXM0jwtm6r6op+uIXf6WJD1w90ZUATfTXVKSCwHa3Zq0/PGjt?=
 =?us-ascii?Q?78l2VBGPDswfDvYdpQOyxhqRmyWrLENODX1tnWxgIIzN04tapauHmC2xfTFO?=
 =?us-ascii?Q?vy8L5H6PINLZ8kf6lHF7unybHHTHl54lYTlEAVE9Sb/+wdDSkl0KNAHwmhTB?=
 =?us-ascii?Q?8APSyq8Oc95QkirZ6Uz6vdsREqCvOJa1HjQJIhD/XPFNLasmWocFE8LzdqJq?=
 =?us-ascii?Q?g7wx8wlCrs4AFYQZM7dSNijAhYQo04gAstQzaCaC/PC7Wm3m1NzHlbRxiaj+?=
 =?us-ascii?Q?f7Xh4Y6Dt8XJ0JbCdzLHt1RenTqlYZNHKAaS8Jz/JLNMbET0a2q+FW6G9k9e?=
 =?us-ascii?Q?DqT+PKX4Oh9bEHfBKLPM4OnuZFUu7TxeYxkw2JID3xOcFjv/eVXHEyUdOWYu?=
 =?us-ascii?Q?uZ/rzs/sIQ/CGFyYZm+ABDwLJQVyiweeK7slJNBIdYp3LbmXTSkZcYRbJl91?=
 =?us-ascii?Q?KIh4TWYFh4S6pX1PbvHsVGQDCvyuVx4F3CF3hbkatMOjUfcHPnjnyO667YIQ?=
 =?us-ascii?Q?tChHxev1zQqv+EtV2yvARs4GgXJJ2LLKZT/aapF7nV/qCTgxY34zfRJHrzZw?=
 =?us-ascii?Q?z+xFfvpLuORp2+WYpKNl7VfKAQaD7s32MRaz?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 08:29:09.9955 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b88ca651-d349-4f41-de6d-08dde6d620a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4356
Received-SPF: permerror client-ip=2a01:111:f403:2009::620;
 envelope-from=skolothumtho@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 29 Aug 2025 09:59:54 -0400
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

No functional changes intended. This will be useful when we
add support for user-creatable smmuv3 device.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nathan Chen <nathanc@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/virt.c | 54 +++++++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 4663184654..d0d93fc0b9 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1443,19 +1443,43 @@ static void create_pcie_irq_map(const MachineState *ms,
                            0x7           /* PCI irq */);
 }
 
+static void create_smmuv3_dt_bindings(const VirtMachineState *vms, hwaddr base,
+                                      hwaddr size, int irq)
+{
+    char *node;
+    const char compat[] = "arm,smmu-v3";
+    const char irq_names[] = "eventq\0priq\0cmdq-sync\0gerror";
+    MachineState *ms = MACHINE(vms);
+
+    node = g_strdup_printf("/smmuv3@%" PRIx64, base);
+    qemu_fdt_add_subnode(ms->fdt, node);
+    qemu_fdt_setprop(ms->fdt, node, "compatible", compat, sizeof(compat));
+    qemu_fdt_setprop_sized_cells(ms->fdt, node, "reg", 2, base, 2, size);
+
+    qemu_fdt_setprop_cells(ms->fdt, node, "interrupts",
+            GIC_FDT_IRQ_TYPE_SPI, irq    , GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
+            GIC_FDT_IRQ_TYPE_SPI, irq + 1, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
+            GIC_FDT_IRQ_TYPE_SPI, irq + 2, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
+            GIC_FDT_IRQ_TYPE_SPI, irq + 3, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI);
+
+    qemu_fdt_setprop(ms->fdt, node, "interrupt-names", irq_names,
+                     sizeof(irq_names));
+
+    qemu_fdt_setprop(ms->fdt, node, "dma-coherent", NULL, 0);
+    qemu_fdt_setprop_cell(ms->fdt, node, "#iommu-cells", 1);
+    qemu_fdt_setprop_cell(ms->fdt, node, "phandle", vms->iommu_phandle);
+    g_free(node);
+}
+
 static void create_smmu(const VirtMachineState *vms,
                         PCIBus *bus)
 {
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
-    char *node;
-    const char compat[] = "arm,smmu-v3";
     int irq =  vms->irqmap[VIRT_SMMU];
     int i;
     hwaddr base = vms->memmap[VIRT_SMMU].base;
     hwaddr size = vms->memmap[VIRT_SMMU].size;
-    const char irq_names[] = "eventq\0priq\0cmdq-sync\0gerror";
     DeviceState *dev;
-    MachineState *ms = MACHINE(vms);
 
     if (vms->iommu != VIRT_IOMMU_SMMUV3 || !vms->iommu_phandle) {
         return;
@@ -1474,27 +1498,7 @@ static void create_smmu(const VirtMachineState *vms,
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
                            qdev_get_gpio_in(vms->gic, irq + i));
     }
-
-    node = g_strdup_printf("/smmuv3@%" PRIx64, base);
-    qemu_fdt_add_subnode(ms->fdt, node);
-    qemu_fdt_setprop(ms->fdt, node, "compatible", compat, sizeof(compat));
-    qemu_fdt_setprop_sized_cells(ms->fdt, node, "reg", 2, base, 2, size);
-
-    qemu_fdt_setprop_cells(ms->fdt, node, "interrupts",
-            GIC_FDT_IRQ_TYPE_SPI, irq    , GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
-            GIC_FDT_IRQ_TYPE_SPI, irq + 1, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
-            GIC_FDT_IRQ_TYPE_SPI, irq + 2, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
-            GIC_FDT_IRQ_TYPE_SPI, irq + 3, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI);
-
-    qemu_fdt_setprop(ms->fdt, node, "interrupt-names", irq_names,
-                     sizeof(irq_names));
-
-    qemu_fdt_setprop(ms->fdt, node, "dma-coherent", NULL, 0);
-
-    qemu_fdt_setprop_cell(ms->fdt, node, "#iommu-cells", 1);
-
-    qemu_fdt_setprop_cell(ms->fdt, node, "phandle", vms->iommu_phandle);
-    g_free(node);
+    create_smmuv3_dt_bindings(vms, base, size, irq);
 }
 
 static void create_virtio_iommu_dt_bindings(VirtMachineState *vms)
-- 
2.43.0


