Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E23CF8859
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 13:24:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM4e5-000675-4Y; Thu, 20 Nov 2025 08:24:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4e1-0005ym-32; Thu, 20 Nov 2025 08:24:17 -0500
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4dz-0002HN-4I; Thu, 20 Nov 2025 08:24:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GH56aDb6xMx/Z6tCLn2ks9kFJYCPkTFQ3MYPPFHvQ/KpOMtCXMtLJWKcoIsUPg5NuaRsDQCBYdGZP8EME9W6zgc4nm3r0MHLBee4L6fbQrdJoKeoTLV5cNE5e7P+K2yFcziw5V+/I83CU33xwFYd3ckEmTnxKx0qgbvJt0vVLToFYcoyAG9UqhgMmwnxh093PwS/R0jONevP5D0T1tXldK/PBJXv0gYzzDGgujgH6C2iDWgzIKbaphigYzWhlU4I7b4YzEuf+4bpUjtkozGTyn22t9oI4mpY/3ta+f7qoYMf8wXPH6ADssYUIlrX+YGdQ75GPuT2vMfzzUNonVj6Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CgWDqzAjcAT2MQSCn1+aWaHlAigvooUNSv+S3EHnCEI=;
 b=I4b6Af+VIuFJ7w6Guh5ojSBbfz95aT0ttrIG3NDcYnpr88bIlfT2GdMg+h/HeHzy7Csy/+L4ndiUbXGje+rEdEi9CWffM2mcfIRlF1iYryz6gTvdddTTycEiPfg6cDRnt0l1ok+WKuNEaRTeZivixiJtulPgYqGKY1G2qMiAxZdtkYjVqN6L8ORbbIYpBasVO+bAR8GuIg0xUUug1BKyC2nP+M+Zz8yW7FZwwZYw02MnXPdVvGfMIMHo5zIR2er/lmpf864oAQaiZHzx0bhiGgGoA+QqSdFlnebO+DWJgFnRCf2pfS/nUUB/z/EmhDjVlGrhzXeLl66aj5MYjulnGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgWDqzAjcAT2MQSCn1+aWaHlAigvooUNSv+S3EHnCEI=;
 b=VV+5Bh0x/xXLkJDsmKOVUEr9z9EtSsyb6nuMIDijdnDX5F3aOOkGn60WxIDybDoPV1rKwBjGeYZgEyAQRUpkV+4dkGeo9u5jP99z9uY1kbEc9Ob8oey63tF4Iv0bVxl2XWUD2+gDelCEUpg0dgw+4C6XTzY2qTYqzpWf2QWWryc6hbpczu/9NnUfrOYONJCaJS6BP6AuYfvx4Q2iZgceDqE92EYi2t+bTu/GQczU1hNVHIAc53karfD6nVmBPbFe4qs73HOLTzTCbNEbzWOZVOKbm7eBXiuvYcTyOkOW358nqZ7hemVtrIs3gdjVY0+zcIs6V2LJm+bENXhfBHK63g==
Received: from CH3P220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::6)
 by CH3PR12MB9729.namprd12.prod.outlook.com (2603:10b6:610:253::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 13:24:09 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::d0) by CH3P220CA0028.outlook.office365.com
 (2603:10b6:610:1e8::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 13:24:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:24:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:23:55 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:23:51 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v6 10/33] hw/arm/smmuv3-accel: Restrict accelerated SMMUv3 to
 vfio-pci endpoints with iommufd
Date: Thu, 20 Nov 2025 13:21:50 +0000
Message-ID: <20251120132213.56581-11-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|CH3PR12MB9729:EE_
X-MS-Office365-Filtering-Correlation-Id: de0a117f-16df-4c9e-2316-08de283816c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|7416014|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y3VNaTYwdC8xZFViNzFlY25JbTZXZ3I3ZlFnN051MTFLYjAxY3pwd3FoVmZp?=
 =?utf-8?B?TTJmOU5jNEVSRHFiemo1UjRidDdpN1Z3WHdlOVI3d3JpV3VSb2NXRk44WE5Q?=
 =?utf-8?B?bjdvdFdLb3dSUXZ5VzRPQkxqYVc1QmhlTUZieXhNUVRvaThNT05Ma3RobjVx?=
 =?utf-8?B?eVNyZjZnQXBqQi9qbDJ3eVRpZFpoMFB4TTRYeVBmendRQnlWTEJNL2NXY3Ix?=
 =?utf-8?B?b1ZJWGVSa09xWE1WMlBEN2hrM21zMEFkN2JYQmVIbnNlTENzYnU1eEhHbFor?=
 =?utf-8?B?MkR2QkdqU0hHZ2dtMmI3T09PZ1RqRDJva21tcjF3MEIrRzhjTEM2UDRlMHpm?=
 =?utf-8?B?VkFoQit3RFZsS0xkbWZhZ2pXNUV5V0xhMW9Xa3UwY21LaWczMWJTeGRZMllX?=
 =?utf-8?B?cURWMXU0OE9EMXhLZk01Rld5RHNqeGpNWXRKOGp4aGtiVURhbFE2NHVHN1M4?=
 =?utf-8?B?V0hpL21ScU5FVkFHWHFUREEvbzk4UXpRVExoUWtYQU5pa1hMNWxYNlZiR0ZL?=
 =?utf-8?B?UmVwMDhFOCtyV1ZTbjlvU3VWT3phcDRsQ3pOSnFLUW8vRkJmWlRNejc4QU41?=
 =?utf-8?B?U2thL0pHYlZpSjg3WkVtQW9wUnVRVFN3ZWtTL0J0MVFiVFJIbGFnanJEcHZ5?=
 =?utf-8?B?NG4vSVhaMGlpR2xtSnRqd0pDbndscElvSnIzMk1JMGJQUXNWVmtWZERBWnpn?=
 =?utf-8?B?VnlZWVNDOCszWnFBVDloeC9CWFQyMEFrdHYrSzdXbEZOKzhiMmk1cEVYT2l3?=
 =?utf-8?B?Z2pUQitQWlB6UHZhR1BIcHZwNWxVTno2dzR2ZVRyUklvSWliZnVvY1ZnRGJG?=
 =?utf-8?B?N0xjdmRjcXRGUWNZUmZGMXdjUDZJR0UzaUc0OHgxTHgyckpLdUZEUDVUR2Ja?=
 =?utf-8?B?dDNKb1lzOTZCekF1bWRaaitWbUZDWFFzU0ZaZ1BPQ09YbWJBRVBKNk9mVlBn?=
 =?utf-8?B?QTcwQzRrWTArOFROOVRxb0xjYUdxdERZQSt2RzdtY3grY3Z0Uk1YK29SaWcy?=
 =?utf-8?B?ZlQ3NWh2NjNmTzlCaDNPKzNMQ0VyNk85NXpZYmgzNDVzTXdIM1BnY0dIQ3Jp?=
 =?utf-8?B?VmlaUHhMS0YvWDdhUEY5MGxzVlFvMG5xU1VTSU51bkZFWDlrbjRMNzNqc0dj?=
 =?utf-8?B?V1E4NW9TeEljYktSVVA4bksyOTBoc0VGOTZqSlNwVFMrTnNpVG1yR3loZjZ3?=
 =?utf-8?B?TjFXNFRrNlBCUVB4WVF5SnlPNzlJK1Blcmk0NDV1MmgvY3puVjR3d3RCczJU?=
 =?utf-8?B?K0VRaVNEbW5WK0RTd0RZU0tsYTE3RTlndkZMelFJUUErTjVkL1ZkeThNUVBN?=
 =?utf-8?B?NmgzNHlPd1A4bHQxSDB2RXFjYnl4Q3hUQ3BwcTZsSG5tdkVoaEVEbWd6SWxu?=
 =?utf-8?B?TENIYVE2ak9aT1pxa1BodXppWGtRZUFMNFNzMFBwdTIyZ0d4YTJFZzVBZG85?=
 =?utf-8?B?MWtOS1FrZGtYTldzYmV6R1N6aHE5Q1IvM3BnZzA5QTZRM0VnUkRCK0dZSEdE?=
 =?utf-8?B?dUJpbSsxT010OFRub1ViZkhxdjE1cFplUm85bkhabHRTNUJjby96L0tINUZp?=
 =?utf-8?B?TkJ2T3ZXT3VxVTBIUWwxUGRyWHBoemZzdWlxTjc1M25ZU1ZyanJudGNFcWpD?=
 =?utf-8?B?WUQxVmVYMTJ3S04ySHRJY0toUFp1RDdkT0VTZXg5cnpjVzJYM09mOVZlcmxw?=
 =?utf-8?B?SmozelpveW1FQk4zKzg2bVBlRVpIK2hMa2NWZ3N6OHZML2l4dWdhWXVoL2Qy?=
 =?utf-8?B?RDU2aHJZYVVyeXl2bEVqcWpDdktyS3V6b2grSVJUTGhRbHdsRGg3VHcrVlNH?=
 =?utf-8?B?ZEFsM1M3andCUkJGVXlkeDRjRTkrcDVKR2xzOWdLMkhyQi9zMzhxVzgyRGRZ?=
 =?utf-8?B?QW9YT3hLL3cxZnVrbm54ZDA2RnRDZnJTQXZGUnhOeEVpYlhOcFJFakppcEtp?=
 =?utf-8?B?Zi9IREhJVitXV201aGpOT1BVZ095RU80blc4OVNTVm9jVjJ3MklsWVVHd3RR?=
 =?utf-8?B?bGJNTW1uaEt2RnBGYnIrUW1wbXE2OHhSSTJpdUFhTERMR3pyTks3M0M2ODVj?=
 =?utf-8?B?ODZSN3hGN283ZDJ2RVVsWUxrYmVYYVJteFBjTGVZbkJwU1hFNjI5VGd5U1RQ?=
 =?utf-8?Q?rBkU=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:24:09.6565 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de0a117f-16df-4c9e-2316-08de283816c1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9729
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
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

Accelerated SMMUv3 is only meaningful when a device can leverage the host
SMMUv3 in nested mode (S1+S2 translation). To keep the model consistent
and correct, this mode is restricted to vfio-pci endpoint devices using
the iommufd backend.

Non-endpoint emulated devices such as PCIe root ports and bridges are also
permitted so that vfio-pci devices can be attached downstream. All other
device types are unsupported in accelerated mode.

Implement supports_address_space() callback to reject all such unsupported
devices.

This restriction also avoids complications with IOTLB invalidations. Some
TLBI commands (e.g. CMD_TLBI_NH_ASID) lack an associated SID, making it
difficult to trace the originating device. Allowing emulated endpoints
would require invalidating both QEMU’s software IOTLB and the host’s
hardware IOTLB, which can significantly degrade performance.

A key design choice is the address space returned for accelerated vfio-pci
endpoints. VFIO core has a container that manages an HWPT. By default, it
allocates a stage-1 normal HWPT, unless vIOMMU requests for a nesting
parent HWPT for accelerated cases.

VFIO core adds a listener for that HWPT and sets up a handler
vfio_container_region_add() where it checks the memory region.

 -If the region is a non-IOMMU translated one (system address space), VFIO
  treats it as RAM and handles all stage-2 mappings for the core allocated
  nesting parent HWPT.

 -If the region is an IOMMU address space, VFIO instead enables IOTLB
  notifier handling and translation replay, skipping the RAM listener and
  therefore not installing stage-2 mappings.

For accelerated SMMUv3, correct operation requires the S1+S2 nesting
model, and therefore VFIO must take the "system address space" path so
that stage-2 mappings are properly built. Returning an alias of the
system address space ensures this happens. Returning the IOMMU address
space would omit stage-2 mapping and break nested translation.

Another option considered was forcing a pre-registration path using
vfio_prereg_listener() to set up stage-2 mappings, but this requires
changes in VFIO core and was not adopted. Returning an alias of the
system address space keeps the design aligned with existing VFIO/iommufd
nesting flows and avoids the need for cross-subsystem changes.

In summary:
 - vfio-pci devices(with iommufd as backend) return an address space
   aliased to system address space.
 - bridges and root ports return the IOMMU address space.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 77 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index b2eded743e..2fcd301322 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -7,8 +7,13 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 
 #include "hw/arm/smmuv3.h"
+#include "hw/pci/pci_bridge.h"
+#include "hw/pci-host/gpex.h"
+#include "hw/vfio/pci.h"
+
 #include "smmuv3-accel.h"
 
 /*
@@ -37,6 +42,48 @@ static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
     return accel_dev;
 }
 
+/*
+ * Only allow PCIe bridges, pxb-pcie roots, and GPEX roots so vfio-pci
+ * endpoints can sit downstream. Accelerated SMMUv3 requires a vfio-pci
+ * endpoint using the iommufd backend; all other device types are rejected.
+ * This avoids supporting emulated endpoints, which would complicate IOTLB
+ * invalidation and hurt performance.
+ */
+static bool smmuv3_accel_pdev_allowed(PCIDevice *pdev, bool *vfio_pci)
+{
+
+    if (object_dynamic_cast(OBJECT(pdev), TYPE_PCI_BRIDGE) ||
+        object_dynamic_cast(OBJECT(pdev), TYPE_PXB_PCIE_DEV) ||
+        object_dynamic_cast(OBJECT(pdev), TYPE_GPEX_ROOT_DEVICE)) {
+        return true;
+    } else if ((object_dynamic_cast(OBJECT(pdev), TYPE_VFIO_PCI))) {
+        *vfio_pci = true;
+        if (object_property_get_link(OBJECT(pdev), "iommufd", NULL)) {
+            return true;
+        }
+    }
+    return false;
+}
+
+static bool smmuv3_accel_supports_as(PCIBus *bus, void *opaque, int devfn,
+                                     Error **errp)
+{
+    PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), devfn);
+    bool vfio_pci = false;
+
+    if (pdev && !smmuv3_accel_pdev_allowed(pdev, &vfio_pci)) {
+        if (vfio_pci) {
+            error_setg(errp, "vfio-pci endpoint devices without an iommufd "
+                       "backend not allowed when using arm-smmuv3,accel=on");
+
+        } else {
+            error_setg(errp, "Emulated endpoint devices are not allowed when "
+                       "using arm-smmuv3,accel=on");
+        }
+        return false;
+    }
+    return true;
+}
 /*
  * Find or add an address space for the given PCI device.
  *
@@ -47,15 +94,43 @@ static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
 static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void *opaque,
                                               int devfn)
 {
+    PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), devfn);
     SMMUState *bs = opaque;
     SMMUPciBus *sbus = smmu_get_sbus(bs, bus);
     SMMUv3AccelDevice *accel_dev = smmuv3_accel_get_dev(bs, sbus, bus, devfn);
     SMMUDevice *sdev = &accel_dev->sdev;
+    bool vfio_pci = false;
 
-    return &sdev->as;
+    if (pdev && !smmuv3_accel_pdev_allowed(pdev, &vfio_pci)) {
+        /* Should never be here: supports_address_space() filters these out */
+        g_assert_not_reached();
+    }
+
+    /*
+     * In the accelerated mode, a vfio-pci device attached via the iommufd
+     * backend must remain in the system address space. Such a device is
+     * always translated by its physical SMMU (using either a stage-2-only
+     * STE or a nested STE), where the parent stage-2 page table is allocated
+     * by the VFIO core to back the system address space.
+     *
+     * Return the shared_as_sysmem aliased to the global system memory in this
+     * case. Sharing address_space_memory also allows devices under different
+     * vSMMU instances in the same VM to reuse a single nesting parent HWPT in
+     * the VFIO core.
+     *
+     * For non-endpoint emulated devices such as PCIe root ports and bridges,
+     * which may use the normal emulated translation path and software IOTLBs,
+     * return the SMMU's IOMMU address space.
+     */
+    if (vfio_pci) {
+        return shared_as_sysmem;
+    } else {
+        return &sdev->as;
+    }
 }
 
 static const PCIIOMMUOps smmuv3_accel_ops = {
+    .supports_address_space = smmuv3_accel_supports_as,
     .get_address_space = smmuv3_accel_find_add_as,
 };
 
-- 
2.43.0


