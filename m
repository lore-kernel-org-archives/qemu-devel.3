Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32604D25031
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 20:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf1Yx-00008u-6Z; Sun, 11 Jan 2026 14:57:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1Yw-00006v-AE; Sun, 11 Jan 2026 14:57:22 -0500
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1Yu-0003wT-JS; Sun, 11 Jan 2026 14:57:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EG6VYn8tCeAJVp8UYfhJp2aUexZi1y0ttuGazBcP8HeA+xMDuRhNrZh3v6xJqwsppK/KQQDYnI+uID59QM7kGAjVXLJCAEIuIekXQ4b6Ai4dnRSJWPl5NzRyiX6//Vo62vr0oAMt11P3M6DgwI3fr8VLCsr1tChG9tr733rUfG+KEyUtimc5g61TrLvHoSrig8Vorl6FrvsS0cGtMK2eC894B03furZSc9yucN2d5UQy8x6WpboSeQ06IK+GzkdzdDp0X2yxlbryavhMhZtBRM2iIVeF+9/IE4LcAHoU174zxtib1EtNO7efYmX8Ca2gSZYIS/eVuDrYgj29b7dsOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CJ7nVCET+o/Z77Xy/euxV9lhsSnCUyRb66ELLEB7DA=;
 b=AWIRkp1SEL5NRa5gynJtboyb4m+BNUBxGkwEDGBNF0wuXuqJqRd5XcY5Gxads8l7+M+s/RToOz/0IbNm1mr8RjURKenjWQeCsiPI5Oml5TIkPa+pvaajQVbfFSVJzijllcV+zD8RgMQlF94AIUtd6wZ2z9ERRRyBAx/UEADEtkrrWQ9k//rEclXl/BbfP/tcRPHYEiGNXOzNhoR+9hGk4+sHj4fSpK1+FT2RdyQNBwBXFRMJEn1BEhsVDmaQ71cIZVUlI4EtyeyxUruWUXdVmFBSLkevNZZcMREh5u7myxG9RLO6pPfpvAmJPmfrhtESubtyve/5bQKlGA5byYLUyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CJ7nVCET+o/Z77Xy/euxV9lhsSnCUyRb66ELLEB7DA=;
 b=k38vrMk7uUWfs6tK0XuisgAlsPSD+sSy1mWZRNUeZPUZrmW3KMFgzRrlUKTGM8neDktj/YIz2z+i9xQTPbAHMuratFGogrZHcWYgsBvnj3SKvut+GVXc3e3KDl8nzza+Xr++xJ26NWvQppMemcbVphP8qKP4+O8b0Qf13Ikxsrp8y4hT2nqwk2s/1fr4ftKTJ2O9G2OkPf37j0lMYnBosZU+euuucNTG2gBqsrl1cRSu7t7qU+LM+PWxzz/nbb+wqeaSeHV0uAG/ZcAFD08tF4yBUaB6ZEeqBd7QEL2h3Vpr7yzG5IBLVE9mbgcsuXBrYBBCzUWJ/paPeP92pfBrxg==
Received: from PH0PR07CA0071.namprd07.prod.outlook.com (2603:10b6:510:f::16)
 by MW3PR12MB4345.namprd12.prod.outlook.com (2603:10b6:303:59::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Sun, 11 Jan
 2026 19:57:13 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:510:f:cafe::40) by PH0PR07CA0071.outlook.office365.com
 (2603:10b6:510:f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Sun,
 11 Jan 2026 19:57:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 19:57:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:57:04 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:56:59 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH v7 15/36] hw/pci/pci: Introduce a callback to retrieve the MSI
 doorbell GPA directly
Date: Sun, 11 Jan 2026 19:53:01 +0000
Message-ID: <20260111195508.106943-16-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|MW3PR12MB4345:EE_
X-MS-Office365-Filtering-Correlation-Id: 811483db-cd1c-444a-ced3-08de514b9d48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hUKisQl97Mj7i8ysIoRxqnhRHhMHNlMGV8J4sRWQnyGoGXjJMaUcD2UqAapL?=
 =?us-ascii?Q?Q54gPdz4BRsDFMNNTv2ctccktV35B+mrqp7MbhlRSZ6TAsH8TQxr+oGYC6Aj?=
 =?us-ascii?Q?9ZwyQ4A2LnpDnbvMxXx9yzmWGuM7E/edkGS2hT05TxynnmrmNP44mC2/9Ypt?=
 =?us-ascii?Q?yAgCU88TDxO6WS6dFVVuno0+hQsUw/uYlxp8O222m407huGfYvk9LS8xBFRY?=
 =?us-ascii?Q?tqpHfhbVQsvn6wyjVo4XQG9RGRgyFBWx9u+wYJu96bMd01eu2NfN7+BmPNUi?=
 =?us-ascii?Q?hTvlPJSV40OUynolEIBD8CJyAfqOAMTS25qCU1KShmno4Nxitayi/MAS4c0M?=
 =?us-ascii?Q?cXH4orKby+qXoFiCvLvQGlQVz6ncm3s4e5p4dx3g1ZjjLooAemcxLR2C0Ehk?=
 =?us-ascii?Q?Nn4Gt9Bx12UZf6tn3l+O7NF3I5Pz186n4Nz0uyDvH09eX3JnvIxQYFha5f/o?=
 =?us-ascii?Q?zTkAIr2k0kL0OhdXH6NOynSq7bdQWt/B+7ZfNyvYvQRyC4koDxU4XEPct4uy?=
 =?us-ascii?Q?bkc2+EXBo1xTNH1y2YnfKBmQfHCYjHIFQrdyM5pWmNixc3q+YJiibdv3FMYW?=
 =?us-ascii?Q?7nOeuGWGHtFsOo9agK9A6LuT90ZKZQH0WsYS/imUx09y8rgPacMFtJ9i6eTf?=
 =?us-ascii?Q?sw22ASIxoWB3OR1Vk+4F04HWHr+0G3+pDAwYDPhf2o9pKT2/IymCnmoCsVk5?=
 =?us-ascii?Q?1tI6dhKnDJCq4t4HRwqCOdWg6FnIXxJju6wspBrLsXCeB/phIuyvMy9FFtHX?=
 =?us-ascii?Q?9p/PKh1keXapYypc7e7WbRV7Gv95l0Ez6seP74KyCN7ERIj5jEFPbVLDp1Rq?=
 =?us-ascii?Q?0DhOM74oOFZlL6MLH4WjsZOskfOZlq/qN/5lmQUhxQp3XcFBSu9wVnB9g1LD?=
 =?us-ascii?Q?tNyWrl27N49q3b4i9U/8ktrMgAfXTlU+cPXO9VZJy46pWyMNMndm2lnmswi1?=
 =?us-ascii?Q?fUyZ8CDSdvhnD+AS0TAZskSP/p96TEG8Zk7zvKni6239w50CqFPd8+8Pf/XC?=
 =?us-ascii?Q?d/1j442e8s+yeuPPlCCAdatC467rNoEAui4iiWCSu+FEu4kA0BVUlIAhUpUn?=
 =?us-ascii?Q?5PbjoHHIuohZlRGLeX++y0+MOuU90vi1TUbmuVIhbrGnnWOvckcDhen//mI6?=
 =?us-ascii?Q?tT/7wL+/HeFurKIraooHs93bnr3Jo3k+ZB5l+ARx0GWSOakQRYpdB6HoFoTO?=
 =?us-ascii?Q?gwg64c50yJj1fd1Y3KxX3xOKjF5U+Ms7LIQR02LNu3+Ri2aUj4sRuDJnWG4j?=
 =?us-ascii?Q?S+r7gEJQ3aGyNHtk68T2cijESjhCA28RAcO+HkoqGqi6MWYPz6ABix8/T3b4?=
 =?us-ascii?Q?BZupqOHiEZS6CP80euXSdNO6DuPcT8CSxRrqbzaTq4yrHNdCMRYnSH0FI9U2?=
 =?us-ascii?Q?dY0vSbsMGnGGIqA/W2Ti0TW0eoPXR+gPZgI6M1rkODFFSd7KTcN/yoHCZzQI?=
 =?us-ascii?Q?txIl5gJuX631aRWTrtnATil0+t9LXNOwXq7QoAZtJ5kRhLuKOuQRHlpkM61f?=
 =?us-ascii?Q?exwPbsYIs4MsH4rAEX4te6Sfhxkmvwxb1vvbbHq+GsgDsbi+Khx6JJbvwjgJ?=
 =?us-ascii?Q?ogK9xU8UpC2b13ZCVg0=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 19:57:13.5132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 811483db-cd1c-444a-ced3-08de514b9d48
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4345
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

For certain vIOMMU implementations, such as SMMUv3 in accelerated mode,
the translation tables are programmed directly into the physical SMMUv3
in a nested configuration. While QEMU knows where the guest tables live,
safely walking them in software would require trapping and ordering all
guest invalidations on every command queue. Without this, QEMU could race
with guest updates and walk stale or freed page tables.

This constraint is fundamental to the design of HW-accelerated vSMMU when
used with downstream vfio-pci endpoint devices, where QEMU must never walk
guest translation tables and must rely on the physical SMMU for
translation. Future accelerated vSMMU features, such as virtual CMDQ, will
also prevent trapping invalidations, reinforcing this restriction.

For vfio-pci endpoints behind such a vSMMU, the only translation QEMU
needs is for the MSI doorbell used when setting up KVM MSI route tables.
Instead of attempting a software walk, introduce an optional vIOMMU
callback that returns the MSI doorbell GPA directly.

kvm_arch_fixup_msi_route() uses this callback when available and ignores
the guest provided IOVA in that case.

If the vIOMMU does not implement the callback, we fall back to the
existing IOMMU based address space translation path.

This ensures correct MSI routing for accelerated SMMUv3 + VFIO passthrough
while avoiding unsafe software walks of guest translation tables.

As a related change, replace RCU_READ_LOCK_GUARD() with explicit
rcu_read_lock()/rcu_read_unlock(). The introduction of an early goto
(set_doorbell) path means the RCU read side critical section can no longer
be safely scoped using RCU_READ_LOCK_GUARD().

Cc: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/pci/pci.c         | 17 +++++++++++++++++
 include/hw/pci/pci.h | 17 +++++++++++++++++
 target/arm/kvm.c     | 18 +++++++++++++++++-
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 95b29a690e..2e636b7c40 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2979,6 +2979,23 @@ bool pci_device_get_iommu_bus_devfn(PCIDevice *dev, PCIBus **piommu_bus,
     return aliased;
 }
 
+bool pci_device_iommu_msi_direct_gpa(PCIDevice *dev, hwaddr *out_doorbell)
+{
+    PCIBus *bus;
+    PCIBus *iommu_bus;
+    int devfn;
+
+    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, &bus, &devfn);
+    if (iommu_bus) {
+        if (iommu_bus->iommu_ops->get_msi_direct_gpa) {
+            *out_doorbell = iommu_bus->iommu_ops->get_msi_direct_gpa(bus,
+                                iommu_bus->iommu_opaque, devfn);
+            return true;
+        }
+    }
+    return false;
+}
+
 AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
 {
     PCIBus *bus;
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index efe9547185..af22757a37 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -666,6 +666,22 @@ typedef struct PCIIOMMUOps {
                             uint32_t pasid, bool priv_req, bool exec_req,
                             hwaddr addr, bool lpig, uint16_t prgi, bool is_read,
                             bool is_write);
+    /**
+     * @get_msi_direct_gpa: get the guest physical address of MSI doorbell
+     * for the device on a PCI bus.
+     *
+     * Optional callback. If implemented, it must return a valid guest
+     * physical address for the MSI doorbell
+     *
+     * @bus: the #PCIBus being accessed.
+     *
+     * @opaque: the data passed to pci_setup_iommu().
+     *
+     * @devfn: device and function number
+     *
+     * Returns: the guest physical address of the MSI doorbell.
+     */
+    uint64_t (*get_msi_direct_gpa)(PCIBus *bus, void *opaque, int devfn);
 } PCIIOMMUOps;
 
 bool pci_device_get_iommu_bus_devfn(PCIDevice *dev, PCIBus **piommu_bus,
@@ -674,6 +690,7 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
 bool pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
                                  Error **errp);
 void pci_device_unset_iommu_device(PCIDevice *dev);
+bool pci_device_iommu_msi_direct_gpa(PCIDevice *dev, hwaddr *out_doorbell);
 
 /**
  * pci_device_get_viommu_flags: get vIOMMU flags.
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 48f853fff8..0828e8b87b 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1621,26 +1621,42 @@ int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
         return 0;
     }
 
+    /*
+     * We do have an IOMMU address space, but for some vIOMMU implementations
+     * (e.g. accelerated SMMUv3) the translation tables are programmed into
+     * the physical SMMUv3 in the host (nested S1=guest, S2=host). QEMU cannot
+     * walk these tables in a safe way, so in that case we obtain the MSI
+     * doorbell GPA directly from the vIOMMU backend and ignore the gIOVA
+     * @address.
+     */
+    if (pci_device_iommu_msi_direct_gpa(dev, &doorbell_gpa)) {
+        goto set_doorbell;
+    }
+
     /* MSI doorbell address is translated by an IOMMU */
 
-    RCU_READ_LOCK_GUARD();
+    rcu_read_lock();
 
     mr = address_space_translate(as, address, &xlat, &len, true,
                                  MEMTXATTRS_UNSPECIFIED);
 
     if (!mr) {
+        rcu_read_unlock();
         return 1;
     }
 
     mrs = memory_region_find(mr, xlat, 1);
 
     if (!mrs.mr) {
+        rcu_read_unlock();
         return 1;
     }
 
     doorbell_gpa = mrs.offset_within_address_space;
     memory_region_unref(mrs.mr);
+    rcu_read_unlock();
 
+set_doorbell:
     route->u.msi.address_lo = doorbell_gpa;
     route->u.msi.address_hi = doorbell_gpa >> 32;
 
-- 
2.43.0


