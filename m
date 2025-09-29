Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A43DCAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 13:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3E7x-0002q4-66; Mon, 29 Sep 2025 09:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E7J-0002lD-A4; Mon, 29 Sep 2025 09:40:40 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E72-0003bf-8o; Mon, 29 Sep 2025 09:40:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSV1ehS2n3nZx3nfAoz/+wzB7i2UOizhk4F8LLjkEpmCIkcUvAuqDHJenqvr28GTNyH+3BZp74hMr7iWuQIr1QrDq7rSyN3EjCG9/sXcA1FjbFhDRua9/H87WbjepWX0Q1M2qBFXH8AQcI+3+i72gZ3DnkjlwvtiO9ZOoCwvGbOYsg2oEO9nua7QGTzp7CqD1F6HvOxkoOaLXv+YTp7L8YRTyJE5hbDCKNdrEmLOBsyfsGRtDF3VAxKnuFgQtpFtBx/TeKhdqZdvcUhEUCqqNhhNh6o7TouTAWgymwY9pcZ45mFGayJsZes7xECRwlLDYWPHK8/VskwNmfn0h1tFJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htI0W+PFTv483BHSN5RVPayEWVV1CXMijTLTerFO/uU=;
 b=VgQk8lZINurGTePkO+JTWJxAvnMsjGUKZz42Z12cytPxLz6lCRQu9v8FTvmQtvzTbylHCn8k6wAHG83SpleqRGWGZpZYG/INEUM7I+/vJA3lFiZppEu4U9CwIHr0ez7qNxd7355RJxBer//tgfgFwZZ2bvDvU6u5v4BnrG67uOd+JSoKxDouCmx3on0SBuJ0NTrZp82IBmX342S9k0Fb8D1fse25Kh3/rzlWGJ9e20n7b7X4oMISzKN2ZYNIT9Hs4u0XF4Gl9gBbTHRkUYaMwTBRcnO1PZwI589ud2U7FwvrJ7CnPlRlcgRgI5SczHhd6bf5Ie3mDhjIG2bIhDF7CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htI0W+PFTv483BHSN5RVPayEWVV1CXMijTLTerFO/uU=;
 b=o1eTIyuz98VQF1CtrVZ8mknY7ckPqhvEG4eAu4OQXgbWLwMejdykCl6AsnNYaSiE9aMpNzymKs/c8K/a9AjvtSioapc4ABPAZG/zefpGfrkCjDG37af7yv5Zj8bDZ482L95UNqbGTGurF/kXt7P4sMZ1FbF80D+E69jWCyOTBTMrJrVQ7JNcD0oCsounBofnqF1odt/sLwmDol0y3kxEZZ6FKaYBP0953qKdOoByN9s8VBetmgfOTHnJg2yD6QR1QgvmDY+5eB1DNhALbd22WOw2/EjJsn7znK8D1m7nz3aCMUQ107xlyAzhp4ymG74GdljwKS43hOZCL6jYOwwXPw==
Received: from CH0PR03CA0106.namprd03.prod.outlook.com (2603:10b6:610:cd::21)
 by IA1PR12MB8237.namprd12.prod.outlook.com (2603:10b6:208:3f3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Mon, 29 Sep
 2025 13:40:03 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::c1) by CH0PR03CA0106.outlook.office365.com
 (2603:10b6:610:cd::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Mon,
 29 Sep 2025 13:40:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 13:40:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Mon, 29 Sep
 2025 06:39:49 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Sep
 2025 06:39:46 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: [PATCH v4 11/27] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Date: Mon, 29 Sep 2025 14:36:27 +0100
Message-ID: <20250929133643.38961-12-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250929133643.38961-1-skolothumtho@nvidia.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|IA1PR12MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: c3d0e41c-574c-4a2d-54e1-08ddff5db19d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kiB66adVg+zQHKWG74mqD5kqRsSXYnlsXeOWTQ6PJOSWK5NIjaBxqXcA6HWk?=
 =?us-ascii?Q?VaNGj70qrQAjwRqjv67EMHlTJ1d5pVBvmSWVdZFVWSEOdM6YpClIDzG/R+bv?=
 =?us-ascii?Q?h8IW5Ii9Sa0gyAMyTIFfqkw3GOZEAyrc3cWY4HQ601Os83wWFI7TVaRuVcEm?=
 =?us-ascii?Q?5Adti/um0OQuB801WydgSKyr7ldQBD2leufPOZMUaioj/EHbBtCnaIW8AXAx?=
 =?us-ascii?Q?jgpAlZwpb6R4fuf3B9YuOstE2gvrx+Aj/XVG9CmBazZjGnbnyFT/QT/q2FGQ?=
 =?us-ascii?Q?m5w0wCAHUWtuJFzXe5tqPy9tWYd6UQ6ngPoIJK41+IhDSeglj3nhm1G6tyF1?=
 =?us-ascii?Q?6Cy6AxbQhwSmgbSeHASBnKmTD2/JG4hHXt+D7shbE1OQCRpSWbw2DGyWcq/K?=
 =?us-ascii?Q?tHxkUB2J+YB4eB8TkgXzpvOYfyfceqc6QYAt+7v03e/6fUFWsoAw2Ul2flwP?=
 =?us-ascii?Q?V0oBN0geo9d4JlvyxJOzktJWXeMOy1Hs6XrtlkqvT/ZIoXCNXWSH8rHQuO4t?=
 =?us-ascii?Q?84o7xxeHaICJ8tB6suBikRvA55caXBLbMgl3A7aoN7OgCjVTFhFNhKvIlPtR?=
 =?us-ascii?Q?liXLMOrWlr49yx7TRVgI+rut6s+hpPPEezpYJSyWvLrzvBzLUhL9R0cwpF5t?=
 =?us-ascii?Q?gkPGlzLh9RTn98T9EqlImy0WoAoCmGz46DXyxOjsRqockrXI4Q5smpSHmyYK?=
 =?us-ascii?Q?2V7otNDFFkRmwNJfKefEX3kQ7iv93Dr+ABxB7WdD2Ieh5zC5FKT1T92Oc3ki?=
 =?us-ascii?Q?z14dtTX2VajO6kJh0S+imelcFmtIZBypDUQpeuPL8D5l7zmNSQnQO6q15WZ9?=
 =?us-ascii?Q?uGwJoofHsloAQSiXQczw+Fz8A/x+5zSaVr1QN8vMRv+XmzMS4S0X37212lem?=
 =?us-ascii?Q?Gzhe3z4nHxZPGjlghzX0iB5K7mLrSZMF5G+M5d+ruqo+ug8l6t/N6bUty5M9?=
 =?us-ascii?Q?soejWiRivdHvL9dZGT1c5ZdsOkaFR9x818IaQaprUViZ3NjYxKMS2bjbyLCe?=
 =?us-ascii?Q?rqNTHrtjAIglzzyniDnPPQFJmXPwnSBVAnkohzG959232UEsbwjGSWXwHBq3?=
 =?us-ascii?Q?LezdW4y9K7v3ezNewhN0Su5kbrK4uX11Kzbuo9+6R5O7zCh8zu4nU+c42dWi?=
 =?us-ascii?Q?ETwJch1ds7HvaPYhCDv9fcgD0Ygs7JvwkXEVGUzgtYYu4vPdOrVFCKNV9BFy?=
 =?us-ascii?Q?Lok3fMgyBbzSr+iXD0u2BsCrndtehJ7veDdIeqR+uIlnit/zomn9TX6ZTkWy?=
 =?us-ascii?Q?Pa+4iZwBoRDnj4u867MgYVIMWrUtBc8grPPlD9cOpIwxUg+RzCG+4cANR4Cr?=
 =?us-ascii?Q?HbHthAGjGiCk/hPaB9InOo1vuLnKuzX+MtFMkpLlDiFeyBy2TQisYlgXHqrd?=
 =?us-ascii?Q?0cSAhRkrVgOFtmwEfAkH2fp9WUcG85ZNvelFKJIRDzExZkmnZCHUHkjY4WM1?=
 =?us-ascii?Q?j/OLES8+Mc13Zj1uFeyXQEna20e5oBpjTZuWoqbYRVuDp8P2SbFsz1dwkVNd?=
 =?us-ascii?Q?Tqp4SqHN6Cx6iGAgwt4TRs4b1+oeg9K9qMU7Dl/ItO5StuRLSkOy9LtvvRoE?=
 =?us-ascii?Q?n+YMuyrer66xzM+ulGs=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 13:40:03.1744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d0e41c-574c-4a2d-54e1-08ddff5db19d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8237
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On ARM, when a device is behind an IOMMU, its MSI doorbell address is
subject to translation by the IOMMU. This behavior affects vfio-pci
passthrough devices assigned to guests using an accelerated SMMUv3.

In this setup, we configure the host SMMUv3 in nested mode, where
VFIO sets up the Stage-2 (S2) mappings for guest RAM, while the guest
controls Stage-1 (S1). To allow VFIO to correctly configure S2 mappings,
we currently return the system address space via the get_address_space()
callback for vfio-pci devices.

However, QEMU/KVM also uses this same callback path when resolving the
address space for MSI doorbells:

kvm_irqchip_add_msi_route()
  kvm_arch_fixup_msi_route()
    pci_device_iommu_address_space()
     get_address_space()

This will cause the device to be configured with wrong MSI doorbell
address if it return the system address space.

Introduce an optional get_msi_address_space() callback and use that in
the above path if available. This will enable IOMMU implementations to
make use of this if  required.

Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/pci/pci.c         | 19 +++++++++++++++++++
 include/hw/pci/pci.h | 16 ++++++++++++++++
 target/arm/kvm.c     |  2 +-
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 1315ef13ea..6f9e1616dd 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2964,6 +2964,25 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
     return &address_space_memory;
 }
 
+AddressSpace *pci_device_iommu_msi_address_space(PCIDevice *dev)
+{
+    PCIBus *bus;
+    PCIBus *iommu_bus;
+    int devfn;
+
+    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, &bus, &devfn);
+    if (iommu_bus) {
+        if (iommu_bus->iommu_ops->get_msi_address_space) {
+            return iommu_bus->iommu_ops->get_msi_address_space(bus,
+                                 iommu_bus->iommu_opaque, devfn);
+        } else {
+            return iommu_bus->iommu_ops->get_address_space(bus,
+                                 iommu_bus->iommu_opaque, devfn);
+        }
+    }
+    return &address_space_memory;
+}
+
 int pci_iommu_init_iotlb_notifier(PCIDevice *dev, IOMMUNotifier *n,
                                   IOMMUNotify fn, void *opaque)
 {
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index c54f2b53ae..0d3b351903 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -652,6 +652,21 @@ typedef struct PCIIOMMUOps {
                             uint32_t pasid, bool priv_req, bool exec_req,
                             hwaddr addr, bool lpig, uint16_t prgi, bool is_read,
                             bool is_write);
+    /**
+     * @get_msi_address_space: get the address space for MSI doorbell address
+     * for devices
+     *
+     * Optional callback which returns a pointer to an #AddressSpace. This
+     * is required if MSI doorbell also gets translated through IOMMU(eg: ARM)
+     *
+     * @bus: the #PCIBus being accessed.
+     *
+     * @opaque: the data passed to pci_setup_iommu().
+     *
+     * @devfn: device and function number
+     */
+    AddressSpace * (*get_msi_address_space)(PCIBus *bus, void *opaque,
+                                            int devfn);
 } PCIIOMMUOps;
 
 bool pci_device_get_iommu_bus_devfn(PCIDevice *dev, PCIBus **piommu_bus,
@@ -660,6 +675,7 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
 bool pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
                                  Error **errp);
 void pci_device_unset_iommu_device(PCIDevice *dev);
+AddressSpace *pci_device_iommu_msi_address_space(PCIDevice *dev);
 
 /**
  * pci_device_get_viommu_flags: get vIOMMU flags.
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index b8a1c071f5..10eb8655c6 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1611,7 +1611,7 @@ int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level)
 int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
                              uint64_t address, uint32_t data, PCIDevice *dev)
 {
-    AddressSpace *as = pci_device_iommu_address_space(dev);
+    AddressSpace *as = pci_device_iommu_msi_address_space(dev);
     hwaddr xlat, len, doorbell_gpa;
     MemoryRegionSection mrs;
     MemoryRegion *mr;
-- 
2.43.0


