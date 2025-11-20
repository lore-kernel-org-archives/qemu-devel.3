Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B921CF8855
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 13:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM4ef-0007EF-VI; Thu, 20 Nov 2025 08:24:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4eY-0006oK-FL; Thu, 20 Nov 2025 08:24:51 -0500
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4eW-0002LI-RX; Thu, 20 Nov 2025 08:24:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N4PQNvDoffFfM8WoFIZCrynXwz7CR9GKto4S6jpXK4q3LQFAjdsBo9tcUHZLjT4ZvhwW1SJlTyb4TKXtKApb19vSgXIANyUvbQpd3ivMd+NGUUUylqZO7BHIDyEUc7pmhwXJBvCfRV1vsbUfwyrsTl8C9AG1+oCTKKY5Y0mwldxAUWHqlRz+g6+9rnBTGN9LR285/YFT+LUMxJTBBHIAPF8VJdo00QjTPZXYIVy/1cWxniK8LfFZABNpbjAlXBSmjDun9jpbTGNrCr7jg5RUnBn5V/GJpZcrm19Rf672Z5Zi4FnR6c4aDD4ZhAMS0t7QehnAf19G5m6mq1k9kbcqEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmPJzfQywtS55SHXgbCOZXs4+vV2rKaNOA89BzD7Jrs=;
 b=wDl7YeOme+F1R6ALi44ajq7et7Gpjs+NSyO6zJohgoQK9tqy0QqkyojvMUM4K6SdB88DY7+ng2BejKNb4E3vVDn6NRWbhvVWKXUQ1a4Sk2qPvEZP1a1NkBL4l1rT/4kUvE4l7kMQjR8ma++cej4LqJ0GRc4cDx+K4BafNjX8FYxVC5KsMvBpXW3ieofWUxDCMcls3ZDOZxGE16GG6glU2jrqf1VraJLelXz/Axc9pNeSKd/xo4BwpGoLz8IV2iDeT3Mk79ltFacnfHNlLvRIqHr6RZQwKZG07VlFsg6yH3DWW+p5NpFVqRrVc8EaswJ2tPJB37vhYzwy9fuIIipjeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmPJzfQywtS55SHXgbCOZXs4+vV2rKaNOA89BzD7Jrs=;
 b=acBEEgvGblu8EWQGZlAXmjYNHE3oVeDgoZ5c6YSxa7otR11qb30OjqI/eZGM2xWzb0nSGQ6OjKh/RB0hv8s4F6kJY9EDCgV1LCIa7z6zSalgttnwioyZ15Lg3ODvXDH/21KMtqtJNnHPs9VQjkVr4NLeOWpkM/KSMFVzu9dU7+dXg4N+mqnYPvc86ERUNABYptwqHRaN/e0qqDKCWbEuvFDaCkUPA1Zq2APg+IsX9b+Q2JtVmSf0Dow3s/JTweZO0XgePChCIjTy0fYMt0ltYwM+FR7jmG751B6BR+weod4w6pSBAZzRcKzafJBCAYO2HMsJCcTGMEaX3UjCeXPp6w==
Received: from CH0PR03CA0322.namprd03.prod.outlook.com (2603:10b6:610:118::27)
 by IA1PR12MB6139.namprd12.prod.outlook.com (2603:10b6:208:3e9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 13:24:41 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::38) by CH0PR03CA0322.outlook.office365.com
 (2603:10b6:610:118::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 13:24:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:24:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:24:26 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:24:22 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH v6 16/33] hw/pci/pci: Introduce a callback to retrieve the MSI
 doorbell GPA directly
Date: Thu, 20 Nov 2025 13:21:56 +0000
Message-ID: <20251120132213.56581-17-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120132213.56581-1-skolothumtho@nvidia.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|IA1PR12MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: f7e12b30-ea96-4e59-7280-08de2838296f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|7416014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iqCnpwlHNYwuj0Kuo9oEaXFF4KGLNeqxTMgyBKiWlTcjd5LnyphRXY2i8TDj?=
 =?us-ascii?Q?kFJ+n2g0gYHUY5gKlsVj+OBDiRZ0mNdzqFLjLdiCccPfgKCMDxxPmVNcHplp?=
 =?us-ascii?Q?Fkr06HHvrwuB6LvheuiVYwiT4vsrVCLSnEVgkw70tjtY9PkDhmpmaweiCk1z?=
 =?us-ascii?Q?zAj3Z9lFrPcl+0ln1aNIywHsv0j+lpL+m3lXOLLHHa410VYFlqJvy9F/Cbun?=
 =?us-ascii?Q?K36Ua4QhEg2yJlEp3W8h69MPgWPHswU8fYkly9J8uyCUHqwECt5AHD+DamcP?=
 =?us-ascii?Q?1qD6Ttn3QXS5aOeoS5rZeP2DU4hEZnGoETkuNeTEnvL/NtDqE6juWTM/zEgt?=
 =?us-ascii?Q?5TZSXrzh7vVaYEhBAoyEJLspybASvuR/KGElfAQeNrhdWUlSpz+xZ0bsw7rs?=
 =?us-ascii?Q?QtoCpuuJkXWk+RiuLpzdRppKYzEDfY/Dnc0gn2kIel3S2COiiYQySCzCs0hL?=
 =?us-ascii?Q?PH2A1vbTnRsjg0VEOa+uC2DjCr6KMJYQFgqAqUocyV5lSImKFR5X9WVt1gRU?=
 =?us-ascii?Q?pNOEc4LOugtkDIUL/DSL4a2//USPDW6AeSMAuCLlgGPBALO0USUhVzgMA0US?=
 =?us-ascii?Q?gFv2ZoZODvnrZKMhSxH1lKot45aSHrKMtv/gpmHMd2AsQgpjgKZcSBmONvSe?=
 =?us-ascii?Q?J01raojMxcbvtcW//buoLaOB+fbAUmUM1LfvM6Ye3Jy4udQsu9wftDVb3spl?=
 =?us-ascii?Q?rSCPrTvyYOpHf2jSuf/URTVJUDmd5Y3BamkOlZPqRZbC/TkhQ+D7pXC1pUgU?=
 =?us-ascii?Q?5L7Nusibx678Da6II64I2q38/CmVL025SVqoEFTCYd8iBuvI3hrKVp+8pCaV?=
 =?us-ascii?Q?cyBUnJUJ4N3SS6EvZ6/cg0robDUjQksFHRxqnuofcl0jENSbZDdJ4GjOUV+3?=
 =?us-ascii?Q?OM0gQ/Cdli1S/Iz2qiB6u+ghOmpQE5NbpT5VwbI1ZE1DTPw2gR3ksWpGK2yz?=
 =?us-ascii?Q?IILU681Pc2J/EpcvF3u7DS78wGxstRPNym9RHwkitzk32s9xDpQW4/SkZMlv?=
 =?us-ascii?Q?S86lCrxxjBQ436jeH0dXBABqhz5KrPfE29mLqRN87VCQ9PhB4SmhtXn7wRXS?=
 =?us-ascii?Q?E9JNLLu7WphGgbGcUmQYWUAoGoRrmF9HyGZk3Djinv0dfx6QvZ/EnT7knnAq?=
 =?us-ascii?Q?PqoUfPV5D0Pu6TBCy9t2ZzGjN/1ltaF7PyC1/Fg5UEJ+FKCgytm1X6G23Xew?=
 =?us-ascii?Q?etxC9jxnG6eecfgL3WvdQwS57MFn+CLK994ylUeZYiACztAWcxdKtGk6A5DZ?=
 =?us-ascii?Q?97BVDwPYP4qQ78740gRs2A3kY87mCc3lnYpgLFVymomn/iUzDRrbwthAAuk3?=
 =?us-ascii?Q?Hu7470UWOBiPl+hfhJIYgBVyZDi8QKB7vmI4V1H5j4cMFVVDD7VwmMtbCUuh?=
 =?us-ascii?Q?6zjKGDHUBLcPRpHMy1Zs9E4AHnOFWMPTPytY8EKWTVngUwuJQ6yQ2PacFZm0?=
 =?us-ascii?Q?Ju0d6lduzKLfgj6QV2Oxj63PYnfmgypdV5WPae6mWVxZJd7sNBxarniVlnod?=
 =?us-ascii?Q?umEirOYfMgYlKZryuE6D1nRaKPXK66EALeJtoAjPfGRc95ShdC0bxpGO2izQ?=
 =?us-ascii?Q?2y/2PK/9qU+7wllQsPE=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:24:40.9930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e12b30-ea96-4e59-7280-08de2838296f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6139
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/pci/pci.c         | 17 +++++++++++++++++
 include/hw/pci/pci.h | 17 +++++++++++++++++
 target/arm/kvm.c     | 18 +++++++++++++++++-
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 55647a6928..201583603f 100644
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
index dd1c4483a2..0964049044 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -664,6 +664,22 @@ typedef struct PCIIOMMUOps {
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
@@ -672,6 +688,7 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
 bool pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
                                  Error **errp);
 void pci_device_unset_iommu_device(PCIDevice *dev);
+bool pci_device_iommu_msi_direct_gpa(PCIDevice *dev, hwaddr *out_doorbell);
 
 /**
  * pci_device_get_viommu_flags: get vIOMMU flags.
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 0d57081e69..2372de6a6e 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1620,26 +1620,42 @@ int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
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


