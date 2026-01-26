Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9DD3CF65D6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 10:48:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkK80-0002Y8-9L; Mon, 26 Jan 2026 05:47:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK6j-0007WG-Pq; Mon, 26 Jan 2026 05:46:15 -0500
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK6i-0005ay-6W; Mon, 26 Jan 2026 05:46:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BqfLrQJ87yXJfrY6xtghseiD3DtfCJlfHmptoh37eHKAEebIF5rLEF2QGChSBmb3IK5hb2h9l85Pk6sAgwgpIJK6FJllS7+HXm4kds9+EtaU8uh3Td2VH+qXvxQ4dPWC7sGSdykbXlgQI3gOtuDG17Y8niLCDHrumL7GF3wiAjhhZqS//THtsa6bIz94WnvKiVPJRn+e6F0WErQGBonMlCtxpFPUNtmz/79kuSj2C0z4IE1IX9/ifIZQnaZj1z0lSrys/1jKJowGvPS5De4vYw7STca7yK269uu7OL4b9dOir0wrfuZYgp/iN92WGFh37j30DKdXcslO7JXT99vPlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzoI0/TBEhY/XObDFiLgCWE6MjZgwsUY7XlD0V1vKPs=;
 b=XuURcp05gOS+tQuors+k3cGvFZVKBhaNKBcZ3BkxsGUHJ9ijL3j606n348dqXv08RUkIh8J0tmsPry85GUM4jvaXgOQCyAISbRbkbWp3kCnmSGA/2LtrKplvhsCOCECe0R63GbhtEvasKcHn/E0uT8/J81YV5NeTzxUdt+0/z9nVIhHU3qehFQAsfsgWQkNoHqqaAy2z23FbFIFftK18l+bC5Q+1iixE2XWFxVEpBM8LjXzfxNpht778N2d8GwYBBsjpvfJG6NaeXm19G/vbx58kw9RWoXBk6bTMjGXx5Tv4KlCKZB6nxNZdMSwD7yG5iLZyLYNfXb3HTTkBxLLM0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzoI0/TBEhY/XObDFiLgCWE6MjZgwsUY7XlD0V1vKPs=;
 b=EtEXa/xqiawBuzIrJYJc5bibx9IxRlIWgFAiAAdTa43VSyiJ6ekW3wctuFtXwHopzNzxWxLQSdytH7Xa35FQG9jMqDNGuRxWMGIknVjKvnS1+546MdepE8O3P6+nYc/r4r7Dh5Enb7pRvmQfqAyfLOM3zIZ48D8sOsvUOok1t9IRGPFFKKXpi3U7l48xkyXtUs40+ugi9cCB0O7aAcVW6+RLSnYQ+5XK5kCpYJPUUeqQwDjYRwiIIjc3IsMXVu+HqCzdWUGeYJUA3Eg/8KjMOkQeKnSiLCzsZAzID8B7Drord8l08mLlDgocfVgvxEXQpf3TcAEpuqBdIcw3c9DYQA==
Received: from PH7P220CA0058.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::9)
 by LV2PR12MB999098.namprd12.prod.outlook.com (2603:10b6:408:353::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 10:46:01 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:510:32b:cafe::ea) by PH7P220CA0058.outlook.office365.com
 (2603:10b6:510:32b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Mon,
 26 Jan 2026 10:45:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Mon, 26 Jan 2026 10:46:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:45:48 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:45:43 -0800
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
Subject: [PATCH v9 16/37] hw/pci/pci: Introduce a callback to retrieve the MSI
 doorbell GPA directly
Date: Mon, 26 Jan 2026 10:43:13 +0000
Message-ID: <20260126104342.253965-17-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|LV2PR12MB999098:EE_
X-MS-Office365-Filtering-Correlation-Id: d44c9739-f8fa-4ed0-90d5-08de5cc818b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|7416014|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cyabImElIXZj6i+sed77JKQHvOVv5txUZQ93wEYXKqFjDaHqpgDjcIiStjq0?=
 =?us-ascii?Q?Et8HG/ukMyaiKD2VBMZymuJnGreYLFLrOo00NWxu2uOHWQKcQY6x8e/7L7mx?=
 =?us-ascii?Q?RbKC8j7eX4Wp1+fDc6Y+HGHp+UVsCL9FWaj0zOybZjdXwhP3zrhv2kCnyGUu?=
 =?us-ascii?Q?mP/42iiEoK7qoOiWu8P5bmH5S7G/C9HTneUtRDRee9DkrEyekNSgi+7Fq8Q5?=
 =?us-ascii?Q?Dc8U0kWj6ro0RozhDFDUzrDGj6BtoILQppBh3pQs0hJ8PoHjaYPPm3lOh0Qd?=
 =?us-ascii?Q?G+wK3O4QDRbPu18hEQFOFhdk5CgoTMxXo6y5PPLW/MkHZLDINDIVSCor6pVq?=
 =?us-ascii?Q?k4O5miTXFdjatvySL6fnQNXlCz+QWxAPcfdELg2pYXJzCFLwZgoGT2To2rYS?=
 =?us-ascii?Q?1IOyTFV4FQ/N3yT21AUOMd8wR9ssx98Aeow4ctm8sghgfPI0OTp+h5uSnUlE?=
 =?us-ascii?Q?PsAX9T51lptwT4EyLvJ41W1UK+3UT59+IhQDWxNJn9YoAKBKP0sKtsTLowCy?=
 =?us-ascii?Q?TtkUUe5EPLX85nMKEJroBZGyWj9Xi3kv+KPGi/ULalw+1GnJJH22sHqYUzLp?=
 =?us-ascii?Q?uL+KhxP8YKGtp5LrgZIKqOFousTER7TLCpxxAN0J4clY/Utkd91b7r7HCq6V?=
 =?us-ascii?Q?CLP14xkljK29LW9Wowm/hwVwb+fQrxuHSfIsb1DUKrTKMrs9VHYumkbJTvuN?=
 =?us-ascii?Q?INbxY6DKjj+HhLfARyzAyozjlQHkg7AiQWr/FeMBvSAzY2PJ+IBtPRndFk9l?=
 =?us-ascii?Q?TS1E+IlPw8WafxSpQ2Qrv+jfbg7E2GYuUV2fvFH7alcJcQ1rKOBt0kZGjiRc?=
 =?us-ascii?Q?BtPX/1OoGAnNyIQWkLbFmGRLGigpClFGmxWv+Ugu0UGSFc5Z4MaU/Drki9Ka?=
 =?us-ascii?Q?qslIUYv/RpC0HpWRjL8LB7A5y/7fzoVmlxCfSeAqRrXcPhVv3gK/8P1ByPXt?=
 =?us-ascii?Q?0d4kpBFZ3a9+6esoM5O9a0sSr28ReqTfus0orJ+t1WSXNVk+n86IraUFQYKT?=
 =?us-ascii?Q?tJKh27qd0qXg/VdRVRMYz3xWlg4LSsDoBTTBGb8s6a9s2OjwqNSIx7goOEtd?=
 =?us-ascii?Q?k+fLunaVh0TDr77Bs3NngoXmZtvokkb1MyBGryIQC+w+gukX7IQUU4ctArXr?=
 =?us-ascii?Q?zgPhXQQiBCCZgxUxKQAgH96QM29KOZZg3iQzAB2mO1iknFClqm3TwNCs1u2j?=
 =?us-ascii?Q?C5+MN9pzcgKNxYpSRpZcB3DfRfXMNyvSFWb+FPE+8mncv0psVvC2qXErwdCW?=
 =?us-ascii?Q?d+QVvdLjuRvokvN+812NS56/c5PZkKdl/4i0prCCpuslr/nprLOjvau1uzSo?=
 =?us-ascii?Q?LS6UV4+wrEnjTI9WyopWgGtKJos4pPrTJ7dXsK/WXIwDRfatLQhsUHbiSk24?=
 =?us-ascii?Q?TBBANZ584BU7sqnIVkZK2bE0TMH7Osa39c1v7gfH7uW2KyPyJoRCfMmQ0ywb?=
 =?us-ascii?Q?ip04GVd6RqQsMeg6OXnKmh26NDfzPr+MgptXEHKxVOCgUyelDXiieStljnvV?=
 =?us-ascii?Q?YNDFN+XfJuk9vDyAZ558tVCCOuUgAUdGfxgqoTIOncLQiaXcshBTBpxUwBfz?=
 =?us-ascii?Q?YRhJdJPE8Ut2NQqqpfceVFDjUHGQknQXoXtekrsfa5WAVS58WQo8iz8oKE38?=
 =?us-ascii?Q?1AFX4GqXUBEdUMmJnh71RZs8mKR7srzXFIrSVaqwSV1PDc9fsi699lGbT6cZ?=
 =?us-ascii?Q?DXcJSQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:46:01.0589 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d44c9739-f8fa-4ed0-90d5-08de5cc818b9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999098
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
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
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
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


