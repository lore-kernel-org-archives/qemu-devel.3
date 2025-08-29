Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE7B2CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 18:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNAR-00056z-Kh; Sat, 30 Aug 2025 11:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uruUY-0002xg-1X; Fri, 29 Aug 2025 04:29:50 -0400
Received: from mail-dm6nam10on20625.outbound.protection.outlook.com
 ([2a01:111:f403:2413::625]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uruUU-0006Re-C6; Fri, 29 Aug 2025 04:29:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SfVLgWfGji8dEotAIMawUbufll4W8TyomvQs2SK72TK4NjTY3+aqqe/qN3y1yhDQmQvyU+Op0A/YU2usrPGPS0z+bnG8WAukj6bs9a15bcdBSOnGXRpqeb0NLXg5n3pVIZ+f5T6BPSfcSYOWb6006YfCjB+AWD56rFa9/Qt8SDcU7WZ3XYUzV5V3htzLtfGskPuHTdOaB1wNQnfIRC0k85/Chng2j4RiRPqAmaDuE8QjhxYs+gNmO6EF2SOOUE8CQRI1juU+DhqXaKXtIXR04aFkBQ8rTnE6HOGcTd7QfBJgotj6C90yLbB0d2208d9V4fzKX6U1haGcaBHyWlSelQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGFFnbUrmViHMYy7rHd3afalbHlpWoHPlYlkx1HSFo0=;
 b=bkxgnaiBQncekrCbE2/I/rvTV7FteKxTwOR5noIl7tpPu3qphKFxrkKl8yS7qQ1GKgj5ePC1T95BtRL2+Y9C+SUAeRG2MrL+oHBdyQu1ritj3mbXOyKHSD3dzgElPzv+okXclSDfs3UYV/TC2Yia/Zzclj1qNWq7tAMFONF9x9CTil8B3VMRIA+b5qs2T/AlMVzZj9mnUiOPsMR6MVXlbHFMSW8eUg7kTAba9eb4FhC+a4RRQ0JYwead/0ZPHRqzaZrykwAlWPbAYiGlphVlY4FTn5exbMcVibqyEghN9e4OcTDq3q2BCynShs1ttHh2OWLeh5ESBG/z5PX+I4Bcng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGFFnbUrmViHMYy7rHd3afalbHlpWoHPlYlkx1HSFo0=;
 b=lT9DIZEBiY0JwiFhzx/hpCuYU7Y5bpykXVxqhO18WKzZslgIqAvg4J7BfAM0G7Xp+xB909KmFGUYJtnSn4iCQYf/7KOBkZ46tZWHgpcIB1JSDl0vHg1CZx0b1+aFS0CJMrT1nQiY82192cEWy/rdGwRqV5O0+JxRe0KMpvjjC118FemQ7Psk5CO842AQT9ntLgzG4avc6SO/warhM4BvXG9CkPovqCeAJi4f4N0UrPSvHU5QWuag6rIHX+zjdw6DSB1nK359gIfpHOhB7zrL+QVwqz1UD7BvvOflmcFgn4O/mMqmysVX+c0xz2MJZRSkolnUkr6fOFpsE8IX0mObIQ==
Received: from BYAPR01CA0037.prod.exchangelabs.com (2603:10b6:a03:94::14) by
 MN6PR12MB8568.namprd12.prod.outlook.com (2603:10b6:208:471::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Fri, 29 Aug
 2025 08:29:32 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::6f) by BYAPR01CA0037.outlook.office365.com
 (2603:10b6:a03:94::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.19 via Frontend Transport; Fri,
 29 Aug 2025 08:29:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 08:29:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 29 Aug
 2025 01:29:14 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 29 Aug
 2025 01:29:10 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <imammedo@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: [PATCH v9 07/11] hw/arm/virt: Allow user-creatable SMMUv3 dev
 instantiation
Date: Fri, 29 Aug 2025 09:25:29 +0100
Message-ID: <20250829082543.7680-8-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829082543.7680-1-skolothumtho@nvidia.com>
References: <20250829082543.7680-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|MN6PR12MB8568:EE_
X-MS-Office365-Filtering-Correlation-Id: ee60d9f2-f4e3-49d8-c5ef-08dde6d62d1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OHRGT2xVYmlWS0tQTCtWT21vSjRrNVh0VTVsVGd6WEZsdTRsa0lLaDdSMTZM?=
 =?utf-8?B?L2RwZnRaZDZoNTFGd3hKUkMzWldidFRRVTRCQ2JZUndIQ0hXdW9LSzVMR1dQ?=
 =?utf-8?B?STFNYTlpRjl2OHNWMTcrUTM0dUx1UUVIb0d4akloRlo5bU1jMnZHMjI3NjRj?=
 =?utf-8?B?T2t5MFNWeDloZVlrbklXUDBCV2hVM1pYUXJnM3UwR2RvTno4b0FrbEhUWlZi?=
 =?utf-8?B?UzNvZ0FKMFZVUnVJTEpQRUtKa29RQXpFNjVjbVROc0ZnZGxINUwzSXJjZkRQ?=
 =?utf-8?B?WldzUDIyWmluSzViOVZzWVVnZjFRQWhDQlAxY1g3VWhSWG1iYngrTGFkR2ww?=
 =?utf-8?B?TnFTS3R5WExsQmREa1FoNjdGYU1iSXZERWVCaTNvSmRvSVlZTzRmUkJLNFoy?=
 =?utf-8?B?SDlNaFp5VzhiVkRDNWJLSDFHL2NVTzNsQk5PZ05waWNlZ3pNK0RyVmdQK0xF?=
 =?utf-8?B?TGxDSEhkSzhINHc1QlgxMVJTWkZDODc4RkhrWndSSjNVdUJjTWMrZVh6TTFY?=
 =?utf-8?B?aUtnd2VKRTBlbm5GSGNjRm1xT0IwOFZnWjF1R2I4bXZZVE84UVBZT0d4T0ZV?=
 =?utf-8?B?NTc4anpUQkEwZDkzVGc4V1dTZjlGSkhFRXRlUWlFUWIrejN3NFZFUHlsZkxR?=
 =?utf-8?B?UWZ0TzZ1TXZybU9GY3FCOWFvLzBUTVBPZGpndnJiL1k2dHVqZzdCRVFlT3ND?=
 =?utf-8?B?d0NRUWdoWkV6S0puOE45YlUvNHdkT3l4MmlJS0g2RFE0YkZGUEdta1lCbFp3?=
 =?utf-8?B?WEFKUzdrQnQ1dUlOelJmekhaQUVESXpSUVNaUEEwdStSMDBpcWV6b0k3RXRG?=
 =?utf-8?B?bTE2dWpNK2QwMi9OUHhTN1ZXdDVOWklIMWFJYWNyVjNCNmxvaHIrajZCVllj?=
 =?utf-8?B?Vkk2NU1QemdMemhRQnFmbVY3ZC8rK0xmbk9kLzNnV0tmSHVWaDdNRmgvYnYv?=
 =?utf-8?B?RnVFTFgvRkx3ZkcrY0hXWlhrUVhZWCtweUR0M2ljd3VQQ0w5VzNQS0JxSGw5?=
 =?utf-8?B?MkFSWmVPeWNBT3MrclJyVEdEaTNlYXZZdmJER1d0dGkzL3lnckExV3V4T1d4?=
 =?utf-8?B?VGtoOHVBdVdvaEkvNWFvR1VzRC9BSTJvTmNTczNNMHY2MXFRcC9oNW9xK0oz?=
 =?utf-8?B?THlDazRJVm1wVzU4TkFFczh4NU4xRXhYWWljWnBFYW45VmdUdzFWS3RLa2Zx?=
 =?utf-8?B?K1BKakxDRzZYbHVrN3hkcDVaNW1tNEFnQlU4RjFkTWVXRWFkb3FaSkwwcGpN?=
 =?utf-8?B?WExaVEVSRXlkdnh6aXZiL1pzRGNFQWZiUzJtVFRCZkoraE9HeVJlczRJSXUx?=
 =?utf-8?B?cERlRy8rRGpFeldla0FnWVl6M3FlWThkWm5aamYrVWcra2kvdGdiUjBxV0dm?=
 =?utf-8?B?UzFCSUk5NTRXRDNoNVY2VCtpTVJvaG8zdEtkMGt5eGQyMERUOGhqanRrSUcw?=
 =?utf-8?B?Q0lHWGJuTW9aUlZRQWR1clVzUnJsWTkzc3J0dWVWVHdMMTBWc0pjNFh3ZUFW?=
 =?utf-8?B?UWhIU2krZzRFTnJKdGJwZldVclFsZUR4Y3VjMVJsdXJOSWZqd1NZZ2hhQ2VP?=
 =?utf-8?B?cCtmM0o2RGFTVnRLeUhFcGxDZWp6Z2pHckhrNmtoQXFjb0pXaTRaUjVEbDhH?=
 =?utf-8?B?Z29uT3FiWm04ZWk1OExoNGlXbXRzQ2tURVBsVTZFWkhJSGdHNFZYRmVFY1Jv?=
 =?utf-8?B?SDNmL2h2ZFF4dWpjQmtjTUprSWNIeHJCMnphQXZNY0htTHdnakIvOHl5cDBS?=
 =?utf-8?B?SmlERDhHMS9GY29iaTRxUUZ4WUpBSjlSVG11UHZNVm8yci9VRktZa3c5WkJO?=
 =?utf-8?B?UkRMKzUwcEtPdGNUN3ZZekx1NUZhOEJ1QWtQQmllVU9keW1qWjM1STY2aW5M?=
 =?utf-8?B?U3o3OXdjNUlKa2tEd0JkSS9EelcrRFJSd2VYQzI0blhYd3VGTS9hOHZJaHpj?=
 =?utf-8?B?by9uZjFDK1NpdDNhOTZSRFEzYkxHNUp3ZVd2MXhSNEdOSE5VTmptbm5pZWpD?=
 =?utf-8?B?c2JVU25vVHZqTVB4K3liUWdzRlVHeTFvU0VMTlZRWElieXpXd0pzTHlpbHh5?=
 =?utf-8?Q?sFIisO?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 08:29:30.9374 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee60d9f2-f4e3-49d8-c5ef-08dde6d62d1c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8568
Received-SPF: permerror client-ip=2a01:111:f403:2413::625;
 envelope-from=skolothumtho@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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

Allow cold-plugging of an SMMUv3 device on the virt machine when no
global (legacy) SMMUv3 is present or when a virtio-iommu is specified.

This user-created SMMUv3 device is tied to a specific PCI bus provided
by the user, so ensure the IOMMU ops are configured accordingly.

Due to current limitations in QEMU’s device tree support, specifically
its inability to properly present pxb-pcie based root complexes and
their devices, the device tree support for the new SMMUv3 device is
limited to cases where it is attached to the default pcie.0 root complex.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nathan Chen <nathanc@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmu-common.c         |  8 +++++-
 hw/arm/smmuv3.c              |  2 ++
 hw/arm/virt.c                | 51 ++++++++++++++++++++++++++++++++++++
 hw/core/sysbus-fdt.c         |  3 +++
 include/hw/arm/smmu-common.h |  1 +
 5 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 7f64ea48d0..62a7612184 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -961,7 +961,12 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
                 goto out_err;
             }
         }
-        pci_setup_iommu(pci_bus, &smmu_ops, s);
+
+        if (s->smmu_per_bus) {
+            pci_setup_iommu_per_bus(pci_bus, &smmu_ops, s);
+        } else {
+            pci_setup_iommu(pci_bus, &smmu_ops, s);
+        }
         return;
     }
 out_err:
@@ -986,6 +991,7 @@ static void smmu_base_reset_exit(Object *obj, ResetType type)
 
 static const Property smmu_dev_properties[] = {
     DEFINE_PROP_UINT8("bus_num", SMMUState, bus_num, 0),
+    DEFINE_PROP_BOOL("smmu_per_bus", SMMUState, smmu_per_bus, false),
     DEFINE_PROP_LINK("primary-bus", SMMUState, primary_bus,
                      TYPE_PCI_BUS, PCIBus *),
 };
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index ab67972353..bcf8af8dc7 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1996,6 +1996,8 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
     device_class_set_parent_realize(dc, smmu_realize,
                                     &c->parent_realize);
     device_class_set_props(dc, smmuv3_properties);
+    dc->hotpluggable = false;
+    dc->user_creatable = true;
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 430bc8a174..0bb03d3b5d 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -56,6 +56,7 @@
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
+#include "hw/pci/pci_bus.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/pci-bridge/pci_expander_bridge.h"
 #include "hw/virtio/virtio-pci.h"
@@ -1474,6 +1475,29 @@ static void create_smmuv3_dt_bindings(const VirtMachineState *vms, hwaddr base,
     g_free(node);
 }
 
+static void create_smmuv3_dev_dtb(VirtMachineState *vms,
+                                  DeviceState *dev, PCIBus *bus)
+{
+    PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
+    SysBusDevice *sbdev = SYS_BUS_DEVICE(dev);
+    int irq = platform_bus_get_irqn(pbus, sbdev, 0);
+    hwaddr base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
+    MachineState *ms = MACHINE(vms);
+
+    if (!(vms->bootinfo.firmware_loaded && virt_is_acpi_enabled(vms)) &&
+        strcmp("pcie.0", bus->qbus.name)) {
+        warn_report("SMMUv3 device only supported with pcie.0 for DT");
+        return;
+    }
+    base += vms->memmap[VIRT_PLATFORM_BUS].base;
+    irq += vms->irqmap[VIRT_PLATFORM_BUS];
+
+    vms->iommu_phandle = qemu_fdt_alloc_phandle(ms->fdt);
+    create_smmuv3_dt_bindings(vms, base, SMMU_IO_LEN, irq);
+    qemu_fdt_setprop_cells(ms->fdt, vms->pciehb_nodename, "iommu-map",
+                           0x0, vms->iommu_phandle, 0x0, 0x10000);
+}
+
 static void create_smmu(const VirtMachineState *vms,
                         PCIBus *bus)
 {
@@ -3003,6 +3027,16 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
         qlist_append_str(reserved_regions, resv_prop_str);
         qdev_prop_set_array(dev, "reserved-regions", reserved_regions);
         g_free(resv_prop_str);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_ARM_SMMUV3)) {
+        if (vms->legacy_smmuv3_present || vms->iommu == VIRT_IOMMU_VIRTIO) {
+            error_setg(errp, "virt machine already has %s set. "
+                       "Doesn't support incompatible iommus",
+                       (vms->legacy_smmuv3_present) ?
+                       "iommu=smmuv3" : "virtio-iommu");
+        } else if (vms->iommu == VIRT_IOMMU_NONE) {
+            /* The new SMMUv3 device is specific to the PCI bus */
+            object_property_set_bool(OBJECT(dev), "smmu_per_bus", true, NULL);
+        }
     }
 }
 
@@ -3026,6 +3060,22 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
         virtio_md_pci_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
     }
 
+    if (object_dynamic_cast(OBJECT(dev), TYPE_ARM_SMMUV3)) {
+        if (!vms->legacy_smmuv3_present && vms->platform_bus_dev) {
+            PCIBus *bus;
+
+            bus = PCI_BUS(object_property_get_link(OBJECT(dev), "primary-bus",
+                                                   &error_abort));
+            if (pci_bus_bypass_iommu(bus)) {
+                error_setg(errp, "Bypass option cannot be set for SMMUv3 "
+                           "associated PCIe RC");
+                return;
+            }
+
+            create_smmuv3_dev_dtb(vms, dev, bus);
+        }
+    }
+
     if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
         PCIDevice *pdev = PCI_DEVICE(dev);
 
@@ -3228,6 +3278,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_PLATFORM);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_UEFI_VARS_SYSBUS);
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_ARM_SMMUV3);
 #ifdef CONFIG_TPM
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
 #endif
diff --git a/hw/core/sysbus-fdt.c b/hw/core/sysbus-fdt.c
index c339a27875..e80776080b 100644
--- a/hw/core/sysbus-fdt.c
+++ b/hw/core/sysbus-fdt.c
@@ -31,6 +31,7 @@
 #include "qemu/error-report.h"
 #include "system/device_tree.h"
 #include "system/tpm.h"
+#include "hw/arm/smmuv3.h"
 #include "hw/platform-bus.h"
 #include "hw/vfio/vfio-platform.h"
 #include "hw/vfio/vfio-calxeda-xgmac.h"
@@ -518,6 +519,8 @@ static const BindingEntry bindings[] = {
 #ifdef CONFIG_TPM
     TYPE_BINDING(TYPE_TPM_TIS_SYSBUS, add_tpm_tis_fdt_node),
 #endif
+    /* No generic DT support for smmuv3 dev. Support added for arm virt only */
+    TYPE_BINDING(TYPE_ARM_SMMUV3, no_fdt_node),
     TYPE_BINDING(TYPE_RAMFB_DEVICE, no_fdt_node),
     TYPE_BINDING(TYPE_UEFI_VARS_SYSBUS, add_uefi_vars_node),
     TYPE_BINDING("", NULL), /* last element */
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index e5e2d09294..80d0fecfde 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -161,6 +161,7 @@ struct SMMUState {
     QLIST_HEAD(, SMMUDevice) devices_with_notifiers;
     uint8_t bus_num;
     PCIBus *primary_bus;
+    bool smmu_per_bus; /* SMMU is specific to the primary_bus */
 };
 
 struct SMMUBaseClass {
-- 
2.43.0


