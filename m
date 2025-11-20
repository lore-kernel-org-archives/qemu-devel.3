Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A46CF8859
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 13:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM4el-0007RN-VL; Thu, 20 Nov 2025 08:25:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4ei-0007La-Q0; Thu, 20 Nov 2025 08:25:00 -0500
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4eh-0002N4-3w; Thu, 20 Nov 2025 08:25:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNlo0bRoHUbUiOj4ZpeSodxaM5W8du7GHgT7ESux05Ab+gbNojunNlyE/yh9ovuqyAknBN7sYBpOXHGXwR0A2PJFoMwmKq309K5awVw9jpcJl2XfRv85E/Dc+XBLaQdYnt4602n/Sdfn5fSUyT5vX2+6R8lJmT4vbLXHrQTjtfngGOWiYVDyB2ZcNDGUYsisZ7g71L5WB6RcqUvV2Di3B1iZgaVoVEPL2jqVHYrqm30xhJWdfdK2eZOvGrjBnJLqOGcwXlml+xguyP1Xkq3qpr42RJBpgeQCzZzfzrlnhKrE6X0CRk70uqZJSmlkNn2iQ7Z8Gtt9pkwg+ksk72wIJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntAiUsqrBdIVm0E6PqRFJX9Tx5HlgupWokTWD/IO9kY=;
 b=eHD2b63L76CJO7CAbaz5WdX4XmJhN2j1xxSaf/lwIGzVBFRFMHCS6Ry8+RS5qUOfpW714peYnN4UF0h0fScHbu+JMn0R9w+FFFFHrjRvFgILFxAAe172T0ip9zBFWLjrgmgxPzsog1j73Jl/1DjCW/fCEAU3L6eXG2gvIa0IdhZgN67luMG+hnsf3qNtmehlWMYeLH4zYFKAdrs6CI4b75EFNTPRmQiaB9TDxxNR6XCHm2TUQ9a2WzpJ/3q7gj1L6Ry8EtKNiy5bwCSE/Laxv6qUX3tazkyVY7u7ezAQRq+CyGEI5OPXIdovOie4EjCjCNWcLlmKzQtEs19RpbyLTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntAiUsqrBdIVm0E6PqRFJX9Tx5HlgupWokTWD/IO9kY=;
 b=lKJpjQC+e+2aTBc7X6VMFNljqzs8RpN1bFsrvkYcRHMBqcFis8aEVl2Aob05ZEe9zIjBQMcUVUEWx9mn8GnViS/mQxqJFZHV2A4E6vIt0Qoy8jllK3f0MdJuQLOBX/TIwFiJx1CsQE/Ym3cHsJCSDuc5m4Fqh8qydIWeBvcGPcI6AKl+a8YV4MrIHuHEsayUFhKqGGfQy0UJSmcbrO61GsqfT3Mav8s6QeCR+foiHSpDtgWdqEMxa+kWDDUj8soQu7aBzEUrT1QuKjs/dtMiQnqRSlIGnMqF+xGfp0XbLvjbYwjkFNiwTTTMlnOLTOFS5SsRjxJjB25RoytAf2RLmA==
Received: from SJ0PR05CA0104.namprd05.prod.outlook.com (2603:10b6:a03:334::19)
 by CH1PPF2EB7CF87B.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::60b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 13:24:49 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:a03:334:cafe::82) by SJ0PR05CA0104.outlook.office365.com
 (2603:10b6:a03:334::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 13:24:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:24:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:24:30 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:24:27 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v6 17/33] hw/arm/smmuv3: Add support for providing a direct
 MSI doorbell GPA
Date: Thu, 20 Nov 2025 13:21:57 +0000
Message-ID: <20251120132213.56581-18-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120132213.56581-1-skolothumtho@nvidia.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|CH1PPF2EB7CF87B:EE_
X-MS-Office365-Filtering-Correlation-Id: fb39021b-9938-4668-097f-08de28382e10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|7416014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejlhOUhTeUI2Q3JrcXFnMHpMS2ZLdnZsOERFb3dOYjBCU0g2QjVSdmtQMjFR?=
 =?utf-8?B?TjQ5UEFNUVFVakxHbEV5R1MwRDM2dDBHZ0w3eERid0Q1YklVVE5jMm4wOHRU?=
 =?utf-8?B?U2hrc28rUG0wYW5mMWFFMnFhYWdUZHB0WUFsSVl3T3F3MXR6ODdoWkd1a1Js?=
 =?utf-8?B?ZU1PSDNpZEtEMDBGZ3V5UUVwZ3BzVjFIR2tqZ1d3VndEZktYVGdZbVB6WitM?=
 =?utf-8?B?ZUREM3pGc0xZaVdOazJYa21kdWNkVjhEdmRTREVBOUVoanVOVFVKeE5QMWp6?=
 =?utf-8?B?R3k3NEZ0c2JEd0pXMFErcEtYbzVEOXkzT292ZkFKakNpUjVUUjRtU3FrMnhU?=
 =?utf-8?B?UHZvdFd2dHV6bU9mT0lTTVJWK0pVd005YkhiU0tKK2NwaXlmSjJ2WVppajlT?=
 =?utf-8?B?dU1QcDdZMnovMjg4VG1vVWpLOXBzMmxTckJmNDAyR2gyRW1Ra0ZzeVk2VlB3?=
 =?utf-8?B?UzVwNUVRMlFnYjZFRFFvMFM0MnA2di9CUisya2dxdGpYU1FEdk42d1d2ajRP?=
 =?utf-8?B?Snpybm1Mem16TklmcVNqL1RjNTcrNndnOW84NmRnVmwwSXFNVzYrVDYyWXRu?=
 =?utf-8?B?RXc0NUFkT1Y1bW9GRjN0Y1kzSm1xZ2FaYXBKcDNOMytyMjJ2Q2RUMmFrLyti?=
 =?utf-8?B?NlUwK2dsYzVwelRRRjRXbGNFY1o1SjRNdGJWbGs4RDJKcDNIaDlNWDZTTDla?=
 =?utf-8?B?UGIwWTE2aUVGR0g4RDVQTUxtY2s0MCtaZzFnNUdIZzBYSWVYV1Bpb1REUS9O?=
 =?utf-8?B?ZUhKMElRaXc5NTN1YXdFVzl5aDZUME5SY0FJRTI2dVJvT0JnWFJ6OGVLYUZ2?=
 =?utf-8?B?VWxNSk16SlF0Tm5OeFpaMzlOdjV1SFVPVi9vVjZVSEVjQi9vb0V2TDYxSS9w?=
 =?utf-8?B?QUFqOWUwbmJpRllIWndUVm5yM1pydFpWZXJSVExvVXV0ajBGVUpRVTFDaStj?=
 =?utf-8?B?RWFPK1RUYnJaemc5UWs1MXU5cFhGRTB4bkdPVjdqRTlOTkhDOTV3cUprMHdR?=
 =?utf-8?B?N1BiNWVyWU45SldFanRkY2I3U0RHZWNwc0MyYU5jeHFkMjZZS3AyNVJhVDJV?=
 =?utf-8?B?SWFaZWJZa0dtbzNpeitDL2xIbnhTQXQwRWxGWm9aT1phaW9EOGZHaVFuV0Ri?=
 =?utf-8?B?N3o2dDUxcVRyWExkVkhhVmtqaEU1aStqYUNuQy9LOFlFcjNJaUtXZS9ZOEFO?=
 =?utf-8?B?dzlwV1JXbUc3bSt5cUdaVUx3aVFiSnhuSXpPZVBqem1NdkJxZGI5TmZNNFo2?=
 =?utf-8?B?NzlyUUdZN2ZseFQrampKOGIzbFp5a0dYbE1FNkhhREhOTVhkWmdvR1RiNW9F?=
 =?utf-8?B?V1piYkoxUDEvT2tDT1BCaVpFWEdqN1JRMnF4SFhVTC9MUWVEN3VhOXh0ZTg3?=
 =?utf-8?B?QjNaZTg0MTAwSTFRa3JEeVVFSWZPMWNtU3M4UThPYmV1bHV3MkZ0NmdQOVhD?=
 =?utf-8?B?OEc4RzNQT1M4aERDTzB2YlNPcmRTQ1g2eUhWckxFdlBMYmh0bU94Q2pYZHVR?=
 =?utf-8?B?UnJGMzlwWm1WSnZoQUpzS0J5bWlkYURUWVlCNVV4RTU1YTZzNDdjV2Nrak1R?=
 =?utf-8?B?SWVROUZzRDNzNVpKZlVHUm9vNXg1RVBzOXZCQjNLVXdrTWJhWHQrTTlTWWRq?=
 =?utf-8?B?TFFIRUYzbXQrWU9yU1Rxd1p4UUEzRXFSRUdua3FqczM5UnQrWm9vRmNSTUo1?=
 =?utf-8?B?VjFhS2p5K2N0ZzJ0aGpuQlBneDZwSFNpM0lCb1FTd2xZQ0FzK09BNkJVc0Zo?=
 =?utf-8?B?TmtGZ2huT0Vab2t2cEZIcVgyelFBNXlvYVpvMFlCVDREUSttYUJHVWJpek9o?=
 =?utf-8?B?cnh4dUFFUlEwWWd5eG5UUU1IZUpuc0JUaWxkaUFMM0ZSb3FEaEJ1WTZUd0RK?=
 =?utf-8?B?cVYvODFyMU0rQkxFQzdXVDJPM25pS0x6b1l1OVk0OThmWFZlZ0pXVnR1NDZR?=
 =?utf-8?B?djNNdUd1RHJKOGxWaWJ2WVlGVHp3a0FzZU1zQjRaVzFPMHhkTDZmK2d6RWh1?=
 =?utf-8?B?aitlY0Y4N1dwMzhvb05qZWRZRld6TllRWTBNMVhRb1I5c1FPRTliN2ZkaTdO?=
 =?utf-8?B?MHliNjU2dnVTWGdRdG5VOU1jclpYNHpqenprS2xRcUNkSGxNdVZQZ09HOUJH?=
 =?utf-8?Q?kBCk=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:24:48.8229 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb39021b-9938-4668-097f-08de28382e10
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF2EB7CF87B
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

Accelerated SMMUv3 instances rely on the physical SMMUv3 for nested
translation (Guest Stage-1, Host Stage-2). In this mode the guest’s
Stage-1 tables are programmed directly into hardware, and QEMU should
not attempt to walk them for translation since doing so is not reliably
safe. For vfio-pci endpoints behind such a vSMMU, the only translation
QEMU is responsible for is the MSI doorbell used during KVM MSI setup.

Add a device property to carry the MSI doorbell GPA from the virt
machine, and expose it through a new get_msi_direct_gpa PCIIOMMUOp.
kvm_arch_fixup_msi_route() can then use this GPA directly instead of
attempting a software walk of guest translation tables.

This enables correct MSI routing with accelerated SMMUv3 while avoiding
unsafe accesses to page tables.

For meaningful use of vfio-pci devices with accelerated SMMUv3, both KVM
and a kernel irqchip are required. Enforce this requirement when accel=on
is selected.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c   | 10 ++++++++++
 hw/arm/smmuv3.c         |  2 ++
 hw/arm/virt.c           | 22 ++++++++++++++++++++++
 include/hw/arm/smmuv3.h |  1 +
 4 files changed, 35 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 65b577f49a..8f7c0cda05 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -392,6 +392,15 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
     }
 }
 
+static uint64_t smmuv3_accel_get_msi_gpa(PCIBus *bus, void *opaque, int devfn)
+{
+    SMMUState *bs = opaque;
+    SMMUv3State *s = ARM_SMMUV3(bs);
+
+    g_assert(s->msi_gpa);
+    return s->msi_gpa;
+}
+
 /*
  * Only allow PCIe bridges, pxb-pcie roots, and GPEX roots so vfio-pci
  * endpoints can sit downstream. Accelerated SMMUv3 requires a vfio-pci
@@ -496,6 +505,7 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
     .get_viommu_flags = smmuv3_accel_get_viommu_flags,
     .set_iommu_device = smmuv3_accel_set_iommu_device,
     .unset_iommu_device = smmuv3_accel_unset_iommu_device,
+    .get_msi_direct_gpa = smmuv3_accel_get_msi_gpa,
 };
 
 /* Based on SMUUv3 GPBA.ABORT configuration, attach a corresponding HWPT */
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 42c60b1ec8..f02e3ee46c 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1998,6 +1998,8 @@ static const Property smmuv3_properties[] = {
      * Defaults to stage 1
      */
     DEFINE_PROP_STRING("stage", SMMUv3State, stage),
+    /* GPA of MSI doorbell, for SMMUv3 accel use. */
+    DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
 };
 
 static void smmuv3_instance_init(Object *obj)
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 25fb2bab56..ea3231543a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3052,6 +3052,14 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
             /* The new SMMUv3 device is specific to the PCI bus */
             object_property_set_bool(OBJECT(dev), "smmu_per_bus", true, NULL);
         }
+        if (object_property_find(OBJECT(dev), "accel") &&
+            object_property_get_bool(OBJECT(dev), "accel", &error_abort)) {
+            if (!kvm_enabled() || !kvm_irqchip_in_kernel()) {
+                error_setg(errp, "SMMUv3 accel=on requires KVM with "
+                           "kernel-irqchip=on support");
+                    return;
+            }
+        }
     }
 }
 
@@ -3088,6 +3096,20 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
             }
 
             create_smmuv3_dev_dtb(vms, dev, bus);
+            if (object_property_find(OBJECT(dev), "accel") &&
+                object_property_get_bool(OBJECT(dev), "accel", &error_abort)) {
+                hwaddr db_start;
+
+                if (vms->msi_controller == VIRT_MSI_CTRL_ITS) {
+                    /* GITS_TRANSLATER page + offset */
+                    db_start = base_memmap[VIRT_GIC_ITS].base + 0x10000 + 0x40;
+                } else {
+                    /* MSI_SETSPI_NS page + offset */
+                    db_start = base_memmap[VIRT_GIC_V2M].base + 0x40;
+                }
+                object_property_set_uint(OBJECT(dev), "msi-gpa", db_start,
+                                         &error_abort);
+            }
         }
     }
 
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index e54ece2d38..5616a8a2be 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -67,6 +67,7 @@ struct SMMUv3State {
     /* SMMU has HW accelerator support for nested S1 + s2 */
     bool accel;
     struct SMMUv3AccelState *s_accel;
+    uint64_t msi_gpa;
 };
 
 typedef enum {
-- 
2.43.0


