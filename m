Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 462D5C2BBCA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 02:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMIAz-0005WS-UC; Tue, 25 Jun 2024 22:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sMIAK-0005TC-5h
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 22:13:50 -0400
Received: from mail-sn1nam02on20604.outbound.protection.outlook.com
 ([2a01:111:f400:7ea9::604]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sMI9a-0004Pm-4B
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 22:13:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UA/VWhyhc7/tTdmctfMHxQgPo2oyDO0x7XGzJXOPpFLlFWXRwLMlWJgCARxeVda+0aU5YWwGtgeuw/kIhxcVV76mERPyG8Ll9Txuj878AOmrhlLvXpBl3g0spMP7A4UQCmoE9+3uaDeojGE8l9jjrETt2iapakofiOP0zFg+G63E5SpuB5yXcyUZwC6rbPrLk7vob4XfuBREJi+vRpav1zMvDp8xDAv6KuBsVN4Cnb50Ib5a06P4m6zk2xhYH1+b7/P2P8RLrTWtX2okjKg0fxyVNsUrc7Fu1qwkpidbDQ3tDaU2GDpamVgGJwhoGEy+nG0KNzo8A6zY/Bgrnbln0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VT9dhE5C30C/kMiM4NyBOMn7CmmxC/qeuX97X8XzTHA=;
 b=KF5vI8vgRDVDfD/T1aXfSfJUyu0yN030p7DbW/FIU7VumIzobwTgmrZwgtCezE6fRYDz8psIkHAQvfVM4h+sSZ0Ho9zu0DmNM8GtfcCt10bzhIxnCHSgMuAlblfI0aNg0Vo0wZ58Rf/0s0uNruoHFGxNFoPa46FZdzu86RUlU41VdqeVEnnwqLVROHpe9hRc1IZkltnn+Jlzmlj+J/Z1A+BeLlMr6awmaYlFb8OMOj90DNpwDkrlufDs1mXOc+C5HQl3VNVrxyBSMOmixpQ7GMM56B+u8CcD1+nN2fBzzQiSNQqrfrwyJSAvzD6t+Q9g2OULqBUcINKF9k8ZnEEKCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VT9dhE5C30C/kMiM4NyBOMn7CmmxC/qeuX97X8XzTHA=;
 b=b9YsiDsXFQG6zcFs0+Ipkj4wEmJvyzGUJkv076VeV2gNHpIzdKvSbAjX6DzudWfRDlVD7XOkj50Iql6dcz8BdJEeEQ+pgpK/g/FA/EP2InXgS12Jxlm5IfjSVkEzU2L6T2idL/Ik0NMB/28cjsns8IqB2etKZAX44hEWokc4id7Bn43jNLEYQ3wVI66Z508ebhyx0mpm46d3fGzpy4Z9cgZzd6E4KnacD34UEHX0eivxArvKF3XMHRCfbiHgmpjVZ1vIJVXKfjKAT50u9w0S/XS47WZHYhv6Vg2JJyE63txYy+nhBlRjDoWAjg0QUScn81RX29n3c5OntT8DWJYMEw==
Received: from BN0PR07CA0029.namprd07.prod.outlook.com (2603:10b6:408:141::11)
 by MN6PR12MB8513.namprd12.prod.outlook.com (2603:10b6:208:472::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Wed, 26 Jun
 2024 00:29:37 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::40) by BN0PR07CA0029.outlook.office365.com
 (2603:10b6:408:141::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 00:29:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 00:29:37 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Jun
 2024 17:29:28 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 25 Jun 2024 17:29:28 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 25 Jun 2024 17:29:27 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <peter.maydell@linaro.org>, <shannon.zhaosl@gmail.com>, <mst@redhat.com>, 
 <imammedo@redhat.com>, <anisinha@redhat.com>, <eric.auger@redhat.com>,
 <peterx@redhat.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <jgg@nvidia.com>,
 <shameerali.kolothum.thodi@huawei.com>, <jasowang@redhat.com>
Subject: [PATCH RFCv1 05/10] hw/arm/virt: Add VIRT_NESTED_SMMU
Date: Tue, 25 Jun 2024 17:28:32 -0700
Message-ID: <bc7a57311ac4976699789ceca329edfdfe823c2d.1719361174.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719361174.git.nicolinc@nvidia.com>
References: <cover.1719361174.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|MN6PR12MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: a7eb4f23-0abe-415f-adfa-08dc95770f95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230038|36860700011|376012|7416012|1800799022|82310400024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8tzZCxKKHnT5xI4q+9gDUgpLbQI5kYRrya2sVdHmmCMK8FKMKyMuAMgK608K?=
 =?us-ascii?Q?vL1NUpB99zRhd6O8wJafrhM19YcWScjeJvPXEq2+AMzxHMHgcEdW+iWIcs+z?=
 =?us-ascii?Q?bqBZFkWvev2tA7mihAUkR0UvU+OOaAUmjsJUg7EtgkmrAvTyV4XADpo+ulmp?=
 =?us-ascii?Q?YKpbNmwSU7Iapq8IgZsn6OsbOq5YGsOlBHj0I2ODu/oiTiXqhiMS4IFT/4k7?=
 =?us-ascii?Q?k0FkKfNISgK/KmD0a+bKoeUNstRb35MEEj2heKgMp8McYROW+VSUD7zW3Cxa?=
 =?us-ascii?Q?rLv3UIM5nJezjVpt/vZWhPcI6sCkoCdZs14DgkKGyeRIrWmeRqqxWEimveQ/?=
 =?us-ascii?Q?IdcRPZ0b4Yq+By8UC59ZWBZbCs0fmIup5ROqH76KKwD1v3qP/XQ7YvmippIw?=
 =?us-ascii?Q?DbgLU2DQ0hl16+AZf/+r3kQ3D4lxTkpoKHAD66EIKAPLwcGPKtrrNy2Edb8E?=
 =?us-ascii?Q?FDI6lNIxfrDnaDvGQ/q0oMAdjYY1L4PDeLPAxaa10rFUy96LeXVDiQ6abFf3?=
 =?us-ascii?Q?1SntjSrHlJ5+jsa+D7QZejWlYx/i4TPTUPppk905cDuvWU42RF4UfTpWr1gU?=
 =?us-ascii?Q?m+nEar5Q4f9HcKZOvT2g+KDzDj7oyMJf/I0ZCtn7roiXfI+nx1ylXiioEnMW?=
 =?us-ascii?Q?rFdah1GuVQQDsxpLxlZgJ8DUEJ75sdNpJEZQy20ICrXd1ANTIhw34Iymg0Y1?=
 =?us-ascii?Q?xGuoZ9A+m2U/bx1zWGgmyxZCrtXFSlCq6JLTDjZ9JwhtgM6XlRQIK4HONItY?=
 =?us-ascii?Q?LQm6w2DqMzb67DLAb7/UhdDOS8Q+EM4QqWk9NwwoeSM2R3mYdEPS6FJaQF2I?=
 =?us-ascii?Q?MYU9VALtdDEkX1NfbAwbUkbA6EoUHHWubBEWJxQWoczSb55Bs+TIvSsnCOWr?=
 =?us-ascii?Q?vuhNt0AUcPl4O9i+Idcw/VfmJ1+0066n947SA7Godbl/Ny7khhzEQsqM/Lic?=
 =?us-ascii?Q?c9Xyn1fLQUmNyfgVRKdI03yFuXexS1vs5OPNati1axh3D7PALOY4HMtrbszX?=
 =?us-ascii?Q?LoIh/CAkCAzxjcYUe+hS9EroXZAO8DWtuVOl0kyQxoVdaZDXXgHLkAf5X1jN?=
 =?us-ascii?Q?brprSAmw7Kk9y0uUvorL4ZbgXM7ebHzwviFe0t3aWBau989vThpZPx1bTqLD?=
 =?us-ascii?Q?kWa7jOJXgQI2tysfVGL2A1i8edpQbIvZSmTLX6NHB7NYKhhtxe1DWh2L62Re?=
 =?us-ascii?Q?1wWF0Rhn/m9DOCLg0ZUDxcj9MrGGhofjYti8imSEii9HdQ3j8eFr4ca4v7Ft?=
 =?us-ascii?Q?MZRr/fJ5mheuBkRtD+p/N8KaXTAhoXdqw7jFckzd6MHY6Fy/lyFtN16sbhMS?=
 =?us-ascii?Q?wTnDwHlrW6P4fSkmqYvsoEUCMiaAO5jZuiyZjgVa0O3cRHaqy3jm8lVxaqpg?=
 =?us-ascii?Q?s/OlAadjE2y3KGmVtq4c5DBVw9mLQbQLjliY6C1Xom8/uyEfrSjXX1RaB974?=
 =?us-ascii?Q?q3Qa1KKrOc96KHSW249eV7l3kOecjDWC?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230038)(36860700011)(376012)(7416012)(1800799022)(82310400024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 00:29:37.2851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7eb4f23-0abe-415f-adfa-08dc95770f95
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8513
Received-SPF: softfail client-ip=2a01:111:f400:7ea9::604;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, KHOP_HELO_FCRDNS=0.4, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

VIRT_SMMU can be used as an emulated SMMU, i.e. iommu=smmuv3. However, the
MMIO space for VIRT_SMMU isn't large enough to accommodate multiple nested
SMMUv3 instances. Add a new VIRT_NESTED_SMMU to separate MMIO space.

Meanwhile, a nested SMMUv3 could only work with a vfio-pci device that is
physically associated to a host-level SMMUv3 instance, meaning that such a
passthrough deivce must be linked to a nesteed SMMU corresponding to the
underlying host-level SMMUv3 instance:
      HW SMMU0 <-----------------> vSMMU0 (nested)
          ^                             ^
	  |                             |
	  ----> PCI dev0 & PCI dev1 <----
      HW SMMU1 <-----------------> vSMMU1 (nested)
          ^                             ^
	  |                             |
	  ----> PCI dev2 & PCI dev3 <----

Note that, on the other hand, an emulated deivce should not be associated
to a nested SMMU.

To prepare for that, create a PCIe Expander Bridge per nested SMMU as a
docker for pci-vfio devices. It eases the QEMU code to build ID mappings
in the IORT.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 hw/arm/virt.c         | 110 +++++++++++++++++++++++++++++++++++++-----
 include/hw/arm/virt.h |  17 +++++++
 2 files changed, 116 insertions(+), 11 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ef59c79ca3..a54332fca8 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -55,6 +55,7 @@
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
+#include "hw/pci/pci_bus.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/virtio/virtio-pci.h"
 #include "hw/core/sysbus-fdt.h"
@@ -83,6 +84,7 @@
 #include "hw/virtio/virtio-md-pci.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/char/pl011.h"
+#include "qemu/config-file.h"
 #include "qemu/guest-random.h"
 
 static GlobalProperty arm_virt_compat[] = {
@@ -177,6 +179,7 @@ static const MemMapEntry base_memmap[] = {
     [VIRT_PVTIME] =             { 0x090a0000, 0x00010000 },
     [VIRT_SECURE_GPIO] =        { 0x090b0000, 0x00001000 },
     [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
+    [VIRT_NESTED_SMMU] =        { 0x0b000000, 0x01000000 },
     /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
     [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
     [VIRT_SECURE_MEM] =         { 0x0e000000, 0x01000000 },
@@ -221,7 +224,8 @@ static const int a15irqmap[] = {
     [VIRT_MMIO] = 16, /* ...to 16 + NUM_VIRTIO_TRANSPORTS - 1 */
     [VIRT_GIC_V2M] = 48, /* ...to 48 + NUM_GICV2M_SPIS - 1 */
     [VIRT_SMMU] = 74,    /* ...to 74 + NUM_SMMU_IRQS - 1 */
-    [VIRT_PLATFORM_BUS] = 112, /* ...to 112 + PLATFORM_BUS_NUM_IRQS -1 */
+    [VIRT_PLATFORM_BUS] = 112, /* ...to 112 + PLATFORM_BUS_NUM_IRQS -1 (179) */
+    [VIRT_NESTED_SMMU] = 200, /* Keep it at the end of list */
 };
 
 static void create_randomness(MachineState *ms, const char *node)
@@ -1383,21 +1387,19 @@ static void create_pcie_irq_map(const MachineState *ms,
                            0x7           /* PCI irq */);
 }
 
-static void create_smmu(const VirtMachineState *vms,
-                        PCIBus *bus)
+static DeviceState *_create_smmu(const VirtMachineState *vms, PCIBus *bus,
+                                 hwaddr base, hwaddr size, int irq,
+                                 uint32_t smmu_phandle)
 {
     char *node;
     const char compat[] = "arm,smmu-v3";
-    int irq =  vms->irqmap[VIRT_SMMU];
     int i;
-    hwaddr base = vms->memmap[VIRT_SMMU].base;
-    hwaddr size = vms->memmap[VIRT_SMMU].size;
     const char irq_names[] = "eventq\0priq\0cmdq-sync\0gerror";
     DeviceState *dev;
     MachineState *ms = MACHINE(vms);
 
-    if (!virt_has_smmuv3(vms) || !vms->iommu_phandle) {
-        return;
+    if (!virt_has_smmuv3(vms) || !smmu_phandle) {
+        return NULL;
     }
 
     dev = qdev_new(TYPE_ARM_SMMUV3);
@@ -1436,8 +1438,31 @@ static void create_smmu(const VirtMachineState *vms,
 
     qemu_fdt_setprop_cell(ms->fdt, node, "#iommu-cells", 1);
 
-    qemu_fdt_setprop_cell(ms->fdt, node, "phandle", vms->iommu_phandle);
+    qemu_fdt_setprop_cell(ms->fdt, node, "phandle", smmu_phandle);
     g_free(node);
+
+    return dev;
+}
+
+static DeviceState *create_smmu(const VirtMachineState *vms, PCIBus *bus)
+{
+    hwaddr base = vms->memmap[VIRT_SMMU].base;
+    hwaddr size = vms->memmap[VIRT_SMMU].size;
+    int irq = vms->irqmap[VIRT_SMMU];
+
+    return _create_smmu(vms, bus, base, size, irq, vms->iommu_phandle);
+}
+
+static DeviceState *create_nested_smmu(const VirtMachineState *vms, PCIBus *bus,
+                                       int i)
+{
+    hwaddr base = vms->memmap[VIRT_NESTED_SMMU].base + i * SMMU_IO_LEN;
+    int irq = vms->irqmap[VIRT_SMMU] + i * NUM_SMMU_IRQS;
+    hwaddr size = SMMU_IO_LEN;
+    DeviceState *dev;
+
+    dev = _create_smmu(vms, bus, base, size, irq, vms->nested_smmu_phandle[i]);
+    return dev;
 }
 
 static void create_virtio_iommu_dt_bindings(VirtMachineState *vms)
@@ -1466,6 +1491,48 @@ static void create_virtio_iommu_dt_bindings(VirtMachineState *vms)
                            bdf + 1, vms->iommu_phandle, bdf + 1, 0xffff - bdf);
 }
 
+/*
+ * FIXME this is used to reverse for hotplug devices, yet it could result in a
+ * big waste of PCI bus numbners.
+ */
+#define MAX_DEV_PER_NESTED_SMMU (4)
+
+static PCIBus *create_pcie_expander_bridge(VirtMachineState *vms, uint8_t idx)
+{
+    /* Total = PXB + MAX_DEV_PER_NESTED_SMMU x (Rootport + device) */
+    const uint8_t total_bus_nums = 1 + MAX_DEV_PER_NESTED_SMMU * 2;
+    uint8_t bus_nr = PCI_BUS_MAX -
+                     (vms->num_nested_smmus - idx) * total_bus_nums;
+
+    VirtNestedSmmu *nested_smmu = find_nested_smmu_by_index(vms, idx);
+    char *name_pxb = g_strdup_printf("pxb_for_smmu.%d", idx);
+    PCIBus *bus = vms->bus;
+    DeviceState *dev;
+
+    /* Create an expander bridge */
+    dev = qdev_new("pxb-pcie");
+    if (!qdev_set_id(dev, name_pxb, &error_fatal)) {
+        return NULL;
+    }
+
+    qdev_prop_set_uint8(dev, "bus_nr", bus_nr);
+    qdev_prop_set_uint16(dev, "numa_node", idx);
+    qdev_realize_and_unref(dev, BUS(bus), &error_fatal);
+
+    /* Get the pxb bus */
+    QLIST_FOREACH(bus, &bus->child, sibling) {
+        if (pci_bus_num(bus) == bus_nr) {
+            break;
+        }
+    }
+    g_assert(bus && pci_bus_num(bus) == bus_nr);
+    nested_smmu->pci_bus = bus;
+    nested_smmu->reserved_bus_nums = total_bus_nums;
+
+    /* Return the pxb bus */
+    return bus;
+}
+
 static void create_pcie(VirtMachineState *vms)
 {
     hwaddr base_mmio = vms->memmap[VIRT_PCIE_MMIO].base;
@@ -1580,12 +1647,33 @@ static void create_pcie(VirtMachineState *vms)
     qemu_fdt_setprop_cell(ms->fdt, nodename, "#interrupt-cells", 1);
     create_pcie_irq_map(ms, vms->gic_phandle, irq, nodename);
 
-    if (vms->iommu) {
+    /* Build PCI Expander Bridge + Root Port from the top of PCI_BUS_MAX */
+    if (vms->num_nested_smmus) {
+        /* VIRT_NESTED_SMMU must hold all vSMMUs */
+        g_assert(vms->num_nested_smmus <=
+                 vms->memmap[VIRT_NESTED_SMMU].size / SMMU_IO_LEN);
+
+        vms->nested_smmu_phandle = g_new0(uint32_t, vms->num_nested_smmus);
+
+        for (i = 0; i < vms->num_nested_smmus; i++) {
+            DeviceState *smmu_dev;
+            PCIBus *pxb_bus;
+
+            pxb_bus = create_pcie_expander_bridge(vms, i);
+            g_assert(pxb_bus);
+
+            vms->nested_smmu_phandle[i] = qemu_fdt_alloc_phandle(ms->fdt);
+            smmu_dev = create_nested_smmu(vms, pxb_bus, i);
+            g_assert(smmu_dev);
+
+            qemu_fdt_setprop_cells(ms->fdt, nodename, "iommu-map", 0x0,
+                                   vms->nested_smmu_phandle[i], 0x0, 0x10000);
+        }
+    } else if (vms->iommu) {
         vms->iommu_phandle = qemu_fdt_alloc_phandle(ms->fdt);
 
         switch (vms->iommu) {
         case VIRT_IOMMU_SMMUV3:
-        case VIRT_IOMMU_NESTED_SMMUV3:
             create_smmu(vms, vms->bus);
             qemu_fdt_setprop_cells(ms->fdt, nodename, "iommu-map",
                                    0x0, vms->iommu_phandle, 0x0, 0x10000);
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index b35c4f62d7..0a3f1ab8b5 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -63,6 +63,7 @@ enum {
     VIRT_GIC_ITS,
     VIRT_GIC_REDIST,
     VIRT_SMMU,
+    VIRT_NESTED_SMMU,
     VIRT_UART,
     VIRT_MMIO,
     VIRT_RTC,
@@ -141,6 +142,8 @@ struct VirtMachineClass {
 typedef struct VirtNestedSmmu {
     int index;
     char *smmu_node;
+    PCIBus *pci_bus;
+    int reserved_bus_nums;
     QLIST_ENTRY(VirtNestedSmmu) next;
 } VirtNestedSmmu;
 
@@ -179,6 +182,7 @@ struct VirtMachineState {
     uint32_t gic_phandle;
     uint32_t msi_phandle;
     uint32_t iommu_phandle;
+    uint32_t *nested_smmu_phandle;
     int psci_conduit;
     hwaddr highest_gpa;
     DeviceState *gic;
@@ -229,4 +233,17 @@ static inline bool virt_has_smmuv3(const VirtMachineState *vms)
            vms->iommu == VIRT_IOMMU_NESTED_SMMUV3;
 }
 
+static inline VirtNestedSmmu *
+find_nested_smmu_by_index(VirtMachineState *vms, int index)
+{
+    VirtNestedSmmu *nested_smmu;
+
+    QLIST_FOREACH(nested_smmu, &vms->nested_smmu_list, next) {
+        if (nested_smmu->index == index) {
+            return nested_smmu;
+        }
+    }
+    return NULL;
+}
+
 #endif /* QEMU_ARM_VIRT_H */
-- 
2.43.0


