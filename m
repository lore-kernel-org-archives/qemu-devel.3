Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6573C44536
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 17:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vicRu-0001rC-D4; Wed, 21 Jan 2026 12:56:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicRn-00018m-HD; Wed, 21 Jan 2026 12:56:52 -0500
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicRl-0001Tl-Je; Wed, 21 Jan 2026 12:56:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hkgMd4eMbCeEpCMlNyg/8riePsw2tpznUNdF/3xzq5KUPJZ5QGunOj7A4eZBesjOLo4X74l9PBGuvBcBlARHwPlRkzlfUMz8srlNZmbx4k2SwwUfAK8d09sYCBjERQIhcdOsM9ioMxdY+LqFEWwn41Nkgg0F84K8hv/vmlHulG+nCVnqvmxpaab6MW4FyEkHXGXOrtSy9H3afLk2n2XFrCA7yACMZwzmh16hxoiktvBGjtGW/Y7YhwM/F2vDat9mng2HMnGjSJxrXfKRA1sHKu8BmS//EsIZuTgSYvInc4HF66pTRSQO7k74TvKhGg9gj64ZZYJxVhsuJc2cwfzlrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4btmVur8Y2aYLkd6goYFSWAIKh3Y/eHwPAGAmZrNj0=;
 b=r+aMU6NNsmgmJ+6mcVheFRqS7dCaHm8IELXfpYSEvkL0aYK1lpNUf20EbfhUIfcjJIqFnGKWzVLP+8c+JHQwliAvzTU+P/xWQGw30zYvkKl0SbawsLyH6TyMFWTTmHopmqwY6cl9s0jgteepp/0PJTpV6UrUgD+poVA8sCO2DJapS857CcISJ9i7WbC9rW7eHYHa7+0xM8G6dO1ZBFMni/5deU9f1f0SnZeY6Ec8ENUYOJJPlAyDJCg0pj0y+EXjGzTx4XA6B6V0RcF01M70nqgChvx4kxnyE/r7WX/9lF42QBPJvuVzm/3J0pPxLl5kp3hWbfp1hkibFtrqpEbFdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4btmVur8Y2aYLkd6goYFSWAIKh3Y/eHwPAGAmZrNj0=;
 b=eA7nDR32qYMldLzixNaNINtc8l36UJapPDfzCuAHW870T5DBRAvuRI3L6/tIvCzXNmUU6aRGGapD9h/OeSWZ49f9gV8jWEgGWNaWQ6lG97Y+MzG3glfzA8lGhMAAIdj1Xe9m+0GB3+48PWcF4/+meWee5ggLAAdG5s72Biqb0FW3kmG1WexCgt2J81rclyyaU43UXJquRZFmMVdCudr+Hjr+3GlCc7RGIpl5y3OXCIuuXTumROjjnAZGutlDe9RvwV86Wh2idhS+I9fZ+WLhBRFdDX9iYIe0J2jG1eXfWSiY/ZsAk+LcDUSQHTzioiEw85Pn48dPUeEVPV0Sqg8b4w==
Received: from SJ0PR13CA0019.namprd13.prod.outlook.com (2603:10b6:a03:2c0::24)
 by DS0PR12MB9448.namprd12.prod.outlook.com (2603:10b6:8:1bb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Wed, 21 Jan
 2026 17:56:41 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::45) by SJ0PR13CA0019.outlook.office365.com
 (2603:10b6:a03:2c0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 17:56:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 17:56:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:56:23 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:56:18 -0800
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
Subject: [PATCH v8 16/37] hw/pci/pci: Introduce a callback to retrieve the MSI
 doorbell GPA directly
Date: Wed, 21 Jan 2026 17:52:21 +0000
Message-ID: <20260121175248.87649-17-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|DS0PR12MB9448:EE_
X-MS-Office365-Filtering-Correlation-Id: 37df91fc-add7-47a9-0e7a-08de59166eb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dRXiW4sZJoIkFsuPXnyQQHgG3XS/a5aBz1/Ed9CoVPjvCQ+htKZv7ShjVCMf?=
 =?us-ascii?Q?0eI8vnpIAULKBmUPZybyDao2E0wDk3+/M7O7TsbBfgZfoad1BbCenRDQ9VUK?=
 =?us-ascii?Q?FwBfBYiQ11To4ExOqYr+ZlygW1VI6chqnQ0gqKnmHXWPxoUMygnTeA6WMjvN?=
 =?us-ascii?Q?OP2NkmIW2AFfU4/MbxETbZE7Jw1P8+OFO1ERUUuQUNiKhfkSqrSKSVsHvxqF?=
 =?us-ascii?Q?f4GECLX+ScqQ8GYzTWEGDAoKxyyGz0G1MDtBpaCIp8k5Wqset5erpB1vo9CL?=
 =?us-ascii?Q?stwnIc4R0/sbhDpq4DmrN25huHf1ktCkW6y0vpK2ZbyEIyQZJnTM/l03fPTQ?=
 =?us-ascii?Q?Yvj6cfmt+0zOmr06hguGT7xPc6Ohmf5RlTESVwKj3PmUOmJVoDxVKMCbnleU?=
 =?us-ascii?Q?P7CP1RJ7DceHEl2h3kIYbF6Do9LXptYcDkW4vfE9bKSXRfWH2gSMgjq4j5oS?=
 =?us-ascii?Q?L3TbEhnQAhFPN1EW+YvCsWHj2aRtC2XN5Zv2y1rNhSEdGifzOfVDQ+ToM1Zs?=
 =?us-ascii?Q?2WF69g1AuFwQFfQdPCbqCCqULc6hI/VoS78IfvInHADgOHAp/UGIEs60/REU?=
 =?us-ascii?Q?WQ/cio4qJG1ggiQ59SNHrPP9iIudf42A/v1E80kKIF473S7hkIb9ejc8N2vS?=
 =?us-ascii?Q?fUheOSHD5o3aOxunp/dVNBar9GFhXzeHmP38EGzpyUijwHsIUmdCtexIQJk1?=
 =?us-ascii?Q?oSInetADVe9i13JXQEABY8CSvhLzd0VWFoTZ122euvUmHmkO0JHz1DlPQSOw?=
 =?us-ascii?Q?tRQwc1oIMZU69me+Gnjhh/Tk/cFpFkhIRfVgo7UXI73xFQWtXq/OAIohblDA?=
 =?us-ascii?Q?N3BTXcMTzP88Aise0CoO2P2AZY0/dSi3tGejjtGRRETmItPnKoYcMjno50nY?=
 =?us-ascii?Q?TJCll5zTqJrH/lW5woWCzk1bWSCNrNkNOmBkCINQXNKk9xJnN5xPjMIL46uZ?=
 =?us-ascii?Q?QYeBq2y72dtpH09w5zJIb9gsf9P8ZCbGMhG/JY2pnP7L8uFNArWZBISz93oH?=
 =?us-ascii?Q?MRBz5YQZEcm8JqkynEkWZVh8BEVtmknGo8SyA6FTBD6btnfTGEpdKlAwJ5RS?=
 =?us-ascii?Q?7mTGoNQxPl5GBSzjVNOsi9TyGxiTTrAHNBDnej73ZlE9l2kcTqz56k2X9JAX?=
 =?us-ascii?Q?79wdUeMzZ2jQHa9EMtQBX828oexwvCeMFezn6pwLqkRTalRPrE/FTuJ7E+xA?=
 =?us-ascii?Q?fJ1Xc//tvsKwSXZRdv1e/8bsExTFpffE4ulzTR/OG5rXmDcfyPveOsO/US5H?=
 =?us-ascii?Q?hkPjd5pwpd1FaxSYi5wEVu6hWdYhKYUdDcMbGXMY4QgpuCgaVunFU6xOZ/d2?=
 =?us-ascii?Q?xLbSkmiD9VX2HhDVfi38elSZFdHp1bxvQfiS2PhOTa2faQGfbOBDlzalKixa?=
 =?us-ascii?Q?Trg05eGRJlKNY47S9mCLBSdFq4MtlQTEvc2bx7SZySjPCovsna8DtSmM94ws?=
 =?us-ascii?Q?do8i8c5AXYj2Q4Dnl1S/j74XeVJVRqTZO6hoMY3R7i2VroteszWwWbCAJSjI?=
 =?us-ascii?Q?tl79P7ojp9ziAuNAeuu8QnIl6ZoKWWKhL8lmaXOAAjY/WVNcDYMxFCggcmDd?=
 =?us-ascii?Q?ZS72diIif0rCq18XUwkGrMU/UcX9sJDowrHYLl36bjHwu/y6m8aYiqDMQvmc?=
 =?us-ascii?Q?S9v8frPAnXWxuUgiBhzcwfZTagIJF5mWq8km4RuqVF13uiT39RywcgOOCD4v?=
 =?us-ascii?Q?vJnu4g=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:56:41.4307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37df91fc-add7-47a9-0e7a-08de59166eb4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9448
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/pci/pci.c         | 17 +++++++++++++++++
 include/hw/pci/pci.h | 17 +++++++++++++++++
 target/arm/kvm.c     | 18 +++++++++++++++++-
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 101e745bd5..9035caca92 100644
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
index ddb0c98e9f..d9835dfd0d 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -683,6 +683,22 @@ typedef struct PCIIOMMUOps {
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
@@ -691,6 +707,7 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
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


