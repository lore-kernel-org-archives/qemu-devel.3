Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 609FDCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN9Z-0004Uh-Nn; Sat, 30 Aug 2025 11:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uruU4-0002ll-OI; Fri, 29 Aug 2025 04:29:20 -0400
Received: from mail-co1nam11on20614.outbound.protection.outlook.com
 ([2a01:111:f403:2416::614]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uruU2-0006NG-Kl; Fri, 29 Aug 2025 04:29:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b+CMCgF5MzYPQfP8hoXUnGpHO9l5t6uYD+EnBPHFnTi7rKpBUCuGouTKAHxJt0eHcG7Pw92j4d0gOD2xU/zzPrdV4fKkZA8wXO965rE1+dJh4xTudM6YG5aM9SMIUcUR/iayhhGh16K7CsqIX2N6j4NKnR31XkWxoglSdt9apBaUwc30//n7xiU42xaOoAq8fHQJc2BeTafNKO7kQcDVeWa6UUSHSIN7I+mksAzTlOMGIkmSXO7xT0R1zfe4oYMjdvuQMUdQekJHbR2uTaJzj95Ve8c1A1AXmMoRrq8nqWSwG1Knh2gKfbxY892yLuzsgOdLMCbWV3zZKfxdq5D/aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ape2vs0dhxwuNlSzLaDeyCGnJ9Ne3W26ftlZe+Mhzo4=;
 b=YcmfKoC9MXw4qhVn9OvCPrySw7udaeUkabhwS2hp9bHkk9FH0HovdlCCHn8JjcPClaDS24vllPPqimSRxskxOKcf3D3oeQ7veAxEbC7FM7DLCx8FlbG0d+KRkw0ytllhSy1DsSmYP5jzt9j9pypg3ycLGlWyk+1V3tPGfJFhy2C1Rso7tIcuMdKqJjb3waC7eyLRbBhFWT80fEHFXM3y0kmnMSS83WiS+rUJX7R1kXY4hyr2m9XBbr5+q6Ug55H21tKopQgtJeQ8G8P5QrxDQ95acmNAwez9L6/ZRv+tE4xZUZXIXU1yI4SeKK63bTH3y4fq1PzwDVi42lc6re/uwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ape2vs0dhxwuNlSzLaDeyCGnJ9Ne3W26ftlZe+Mhzo4=;
 b=C7D27c3yZFGEbEPJg3Mf+w66+kiPZu9f6sDE2qiXY4GilbtuSwqfjtSMRTp6Oj3fr90Llyw8vRS/yqVivC6oHDRN93/j7Pc167VHjVd4kxGwPkokIZ/VfDUhmy5+3jhuGQvZQG7AEntBEnYkdMBaadVddsJ9XacAof6EDf+2g0tLsj0vU+wrPqP8eWg8R4IP+99RG9HuQOmTY1FH7PY9nFM0cpIVl35IhbAUtdcY+3gj3OM7jivgHARAs/NoLsofY089MMKV/oJA61MlHjJgM0CfUXOko2pV9k7BJPOyZ2VpI4I7GnxEQroNMZzrZGeZKZaxOlMuqPKC8jPdC08xBw==
Received: from SJ0PR03CA0380.namprd03.prod.outlook.com (2603:10b6:a03:3a1::25)
 by LV3PR12MB9094.namprd12.prod.outlook.com (2603:10b6:408:19e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Fri, 29 Aug
 2025 08:29:07 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::9a) by SJ0PR03CA0380.outlook.office365.com
 (2603:10b6:a03:3a1::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Fri,
 29 Aug 2025 08:29:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 08:29:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 29 Aug
 2025 01:28:51 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 29 Aug
 2025 01:28:46 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <imammedo@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: [PATCH v9 03/11] hw/arm/virt-acpi-build: Update IORT for multiple
 smmuv3 devices
Date: Fri, 29 Aug 2025 09:25:25 +0100
Message-ID: <20250829082543.7680-4-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|LV3PR12MB9094:EE_
X-MS-Office365-Filtering-Correlation-Id: 7875bf20-6264-41c5-657f-08dde6d61eb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VTtHHwuS9aPvFvb8SynpHMOs1R+xA04gMadZEoRcj6GLOUf0CZzCnFCv0y+g?=
 =?us-ascii?Q?8Ibg7JCSKOvxY0k212mH9j9nflEPojF9DBxAuIhgJnLKnPhWlpKH3aXfiQuP?=
 =?us-ascii?Q?PaL8xp+sQv/FvBmi6E0/2iXYgt3JnsTWI1tZ/1AfUlQX2pFJka9SFX/KjHoU?=
 =?us-ascii?Q?6c1LWdmxbQ4p9rH3FzI+JEIpAEoAFIOl+sssb1JLY18ALQudjFjDGXn2PNjg?=
 =?us-ascii?Q?wmOHZRU9VU8Tcr7Q8r+nQHYb8UoK3Ccent84WzkhreI3vJ27xoohiDfbT/gL?=
 =?us-ascii?Q?V+1CH0JRyRHem7GbzITq01SXjtmWshVGWQtmJc3JaJWYuv06Ppqs7lHPbxj+?=
 =?us-ascii?Q?DUemD5VP24zksRYIPqeN3svzC0sEqqShXB8ydWNgqRPCEyfZoach348I/I+t?=
 =?us-ascii?Q?N2+vX8NVffjBSNgdkm7U9etJk04uot2hqtRK6TqD8JWfGoFoO3y6ccClglQW?=
 =?us-ascii?Q?NSYZQ4aAtcPQ5A/aOTZZuTLt0uksB7aE0hZJxkGPc4CxI/tS58e/aonKQDL6?=
 =?us-ascii?Q?jIu1izmSOfFfhkJu6qbqlD3RagXE2Y/3mPOlxIYSOf2lRNYIe7nyaXkWEBYz?=
 =?us-ascii?Q?H/LZu6ig7wrTo9Cwo+8QH7egy4BqvUNt8RQApnrRqKkVGaU2LzKlOM/5D3Ab?=
 =?us-ascii?Q?n+qVf/hVBh64TZ72y3ebxDfSr31DKUkWS4L8kk+g6HW2zZRzgvFxLtsmE4si?=
 =?us-ascii?Q?NIuwaFfE1et23d/PRnrAZuX2bzMTflSJaqOl4ossYaeZ0mVAI5MzYrlmB0W7?=
 =?us-ascii?Q?oAHMDT2P0HUrOieHB42zMzt9fPSD3AiaPOpe2u+ataOJqxIbkbMkF/FYY4rj?=
 =?us-ascii?Q?gG7spa78LDKdoptkBVpp18EMTUjWH7RjVMnboQ0iNz/BI+beMt7ITPvQ8JJd?=
 =?us-ascii?Q?g199mbHXUQk0zpu5crnMj/Z+j3YVe7/GoZy1t4RjqRnZGsQl2cXCkPMELHxI?=
 =?us-ascii?Q?j9fph1/qTgVl8C5PjmAi2QP1j1Qc/CXB4INHeHaYHi8EKmBMpRTTtEyBdIq1?=
 =?us-ascii?Q?OUlCkfSvFtyJOSEmBrCCY9Mv9wNHVLaNAcRsnc9FHZvtcewzpoR9T6UWTkvZ?=
 =?us-ascii?Q?Aj9P+T9zHtEl2Gp8xVfXPnHJdhQf6UZo2DgOXTKC3c+OT/eXQBW/ykZqvS9z?=
 =?us-ascii?Q?g2ieG41QR0t+7aPKdvwjeysfY2gIbmiFO3QG7oiap6Zcs5ftN479hyAYqAWu?=
 =?us-ascii?Q?qV7ieXlsc0uujoeqM1OaOKEkYFtCMmgSD8EKFO9Ja+VnEePORcnxZ/Q9uhUm?=
 =?us-ascii?Q?tIZLnXUdhj3bzMUtQI7hBAay8BCnTAHTC8gSBNyD6crFxN/3LbTJoMx8+T03?=
 =?us-ascii?Q?yM66biEWBUTBdaWwD01KkyuBKoLYCDtDdPiJwJ7gFBB81pivcyv1fIfgdxBG?=
 =?us-ascii?Q?IZhgfALBtou21y3OXNPp4eyOQ+6tnEXjAXh5Kc9X5eVmP5xgwbXf0vTBXEZN?=
 =?us-ascii?Q?+awVsWdAAWqfojk/AHOBgm3G8p12OMthhMa5MDM2hJnWM+tc4v6udB76im5a?=
 =?us-ascii?Q?dWT7Fqji8fF2KHNlWaUJ8KmgZnNnZZKb9m0n?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 08:29:06.7483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7875bf20-6264-41c5-657f-08dde6d61eb1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9094
Received-SPF: permerror client-ip=2a01:111:f403:2416::614;
 envelope-from=skolothumtho@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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

With the soon to be introduced user-creatable SMMUv3 devices for
virt, it is possible to have multiple SMMUv3 devices associated
with different PCIe root complexes.

Update IORT nodes accordingly.

An example IORT Id mappings for a Qemu virt machine with two
PCIe Root Complexes each assocaited with a SMMUv3 will
be something like below,

  -device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.0
  -device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.1
  ...

  +--------------------+           +--------------------+
  |   Root Complex 0   |           |   Root Complex 1   |
  |                    |           |                    |
  |  Requestor IDs     |           |  Requestor IDs     |
  |  0x0000 - 0x00FF   |           |  0x0100 - 0x01FF   |
  +---------+----------+           +---------+----------+
            |                               |
            |                               |
            |       Stream ID Mapping       |
            v                               v
  +--------------------+          +--------------------+
  |    SMMUv3 Node 0   |          |    SMMUv3 Node 1   |
  |                    |          |                    |
  | Stream IDs 0x0000- |          | Stream IDs 0x0100- |
  | 0x00FF mapped from |          | 0x01FF mapped from |
  | RC0 Requestor IDs  |          | RC1 Requestor IDs  |
  +--------------------+          +--------------------+
            |                                |
            |                                |
            +----------------+---------------+
                             |
                             |Device ID Mapping
                             v
              +----------------------------+
              |       ITS Node 0           |
              |                            |
              | Device IDs:                |
              | 0x0000 - 0x00FF (from RC0) |
              | 0x0100 - 0x01FF (from RC1) |
              | 0x0200 - 0xFFFF (No SMMU)  |
              +----------------------------+

Tested-by: Nathan Chen <nathanc@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/virt-acpi-build.c | 64 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index bef4fabe56..96830f7c4e 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -45,6 +45,7 @@
 #include "hw/acpi/generic_event_device.h"
 #include "hw/acpi/tpm.h"
 #include "hw/acpi/hmat.h"
+#include "hw/arm/smmuv3.h"
 #include "hw/cxl/cxl.h"
 #include "hw/pci/pcie_host.h"
 #include "hw/pci/pci.h"
@@ -338,6 +339,67 @@ static int populate_smmuv3_legacy_dev(GArray *sdev_blob)
     return sdev.rc_smmu_idmaps->len;
 }
 
+static int smmuv3_dev_idmap_compare(gconstpointer a, gconstpointer b)
+{
+    AcpiIortSMMUv3Dev *sdev_a = (AcpiIortSMMUv3Dev *)a;
+    AcpiIortSMMUv3Dev *sdev_b = (AcpiIortSMMUv3Dev *)b;
+    AcpiIortIdMapping *map_a = &g_array_index(sdev_a->rc_smmu_idmaps,
+                                              AcpiIortIdMapping, 0);
+    AcpiIortIdMapping *map_b = &g_array_index(sdev_b->rc_smmu_idmaps,
+                                              AcpiIortIdMapping, 0);
+    return map_a->input_base - map_b->input_base;
+}
+
+static int iort_smmuv3_devices(Object *obj, void *opaque)
+{
+    VirtMachineState *vms = VIRT_MACHINE(qdev_get_machine());
+    GArray *sdev_blob = opaque;
+    AcpiIortIdMapping idmap;
+    PlatformBusDevice *pbus;
+    AcpiIortSMMUv3Dev sdev;
+    int min_bus, max_bus;
+    SysBusDevice *sbdev;
+    PCIBus *bus;
+
+    if (!object_dynamic_cast(obj, TYPE_ARM_SMMUV3)) {
+        return 0;
+    }
+
+    bus = PCI_BUS(object_property_get_link(obj, "primary-bus", &error_abort));
+    pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
+    sbdev = SYS_BUS_DEVICE(obj);
+    sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
+    sdev.base += vms->memmap[VIRT_PLATFORM_BUS].base;
+    sdev.irq = platform_bus_get_irqn(pbus, sbdev, 0);
+    sdev.irq += vms->irqmap[VIRT_PLATFORM_BUS];
+    sdev.irq += ARM_SPI_BASE;
+
+    pci_bus_range(bus, &min_bus, &max_bus);
+    sdev.rc_smmu_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
+    idmap.input_base = min_bus << 8,
+    idmap.id_count = (max_bus - min_bus + 1) << 8,
+    g_array_append_val(sdev.rc_smmu_idmaps, idmap);
+    g_array_append_val(sdev_blob, sdev);
+    return 0;
+}
+
+/*
+ * Populate the struct AcpiIortSMMUv3Dev for all SMMUv3 devices and
+ * return the total number of idmaps.
+ */
+static int populate_smmuv3_dev(GArray *sdev_blob)
+{
+    object_child_foreach_recursive(object_get_root(),
+                                   iort_smmuv3_devices, sdev_blob);
+    /* Sort the smmuv3 devices(if any) by smmu idmap input_base */
+    g_array_sort(sdev_blob, smmuv3_dev_idmap_compare);
+    /*
+     * Since each SMMUv3 dev is assocaited with specific host bridge,
+     * total number of idmaps equals to total number of smmuv3 devices.
+     */
+    return sdev_blob->len;
+}
+
 /* Compute ID ranges (RIDs) from RC that are directed to the ITS Group node */
 static void create_rc_its_idmaps(GArray *its_idmaps, GArray *smmuv3_devs)
 {
@@ -401,6 +463,8 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 
     if (vms->legacy_smmuv3_present) {
         rc_smmu_idmaps_len = populate_smmuv3_legacy_dev(smmuv3_devs);
+    } else {
+        rc_smmu_idmaps_len = populate_smmuv3_dev(smmuv3_devs);
     }
 
     num_smmus = smmuv3_devs->len;
-- 
2.43.0


