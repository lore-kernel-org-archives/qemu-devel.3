Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1550CCCF9FF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 10:55:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEmmG-0004uL-JI; Fri, 31 Oct 2025 06:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmlg-0004R7-VO; Fri, 31 Oct 2025 06:54:06 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmlV-0002xL-JT; Fri, 31 Oct 2025 06:53:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iiekEEAC9/9xAqivq8+ANitt44UoodknR/mJBFbfJ4vKAuk1N4uVAILLldoU93FeZEBVjkakgYUSAZVkyVkgYOKuXVr7LDcpBLD90PLQJwUqxi7J5DNw9E+ST7ITDXFYIwYjqA1h3zspI6cHKAja8nWI62xW6NTSciFCVj5C+SkHtrW/IaGujgCXKDs/YygtYK1a85rua67M5jSCCYLpXlYXnOVdjnna6JJYe0ttl27X7/qaxkUQxmYvoo1Ir7yEn9u0zMvbNmQBXzgc8hObL5pdyIXQf1/ti37OrC71sW5KeFE9NtqXI/LkBdhyWt7HBADj25LvZpMC87KrDh7KUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkZ3AYA/jgEMOsNSbJQFTXXinfmlKImMW7bteh4tKpw=;
 b=N+evgmPvKKrLD1h8SdpyqS/0b7DWWT21E4ajpaIuMfu6HwAqksi6SJA/QMgcQCb7rnaYPtaU+YiHJYkqSDdXJ/S9Zf90BHJ2n4Vg4at7ZEJB/QACpaOxADAT1kKXxqQMH+o9XrAW1jIWgq5NZozv+sxkIuhkoad5QN06oc3lx+yTs1Ez6LKxXve+pgO2sFua4g5pVcwn4OGuGpG9THsUymWL9nl0mv8XJvu1/TFOQcvY5KZa08mSWnIjSRwJRWYL244MN8KAL6wzMId7WZXWAgpSajTSlfpMtg0yF1OIhREHuF6f/Elte8Xz1SbMHFL/JpvtknDs5Rx+zwhGw7bhkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkZ3AYA/jgEMOsNSbJQFTXXinfmlKImMW7bteh4tKpw=;
 b=Hc7+IgoRtmb5KiVkCF/fwyLtoHkaU0kLjZUvAPe64wVfCla9MA/az0dlTd8ZamkV3hCQTOMsid67CmrDZGYUHpKjXb3PW2gFkiumtrlngpjObNrqHonJ5ws6543+OVMGG2t9weznww/+zOdDzJatRtU0+XATqD+Dmj55BME9I2aj9ouMv8u8NwKFE1MS99LjBQiMRO3p0KFJR4FjwUCt6sg8o/aec+I0HqMOGajk9fxOoCY9gG+KevCdAx2McyC91fyoPXh6QpE9UQwg3n5H51FRzPgwTIqbRmucrT7bvqVrQqNmR+PPNBYL1F4ZBHKv03VixuKbKr2ORMh4TMqlEQ==
Received: from BY3PR10CA0029.namprd10.prod.outlook.com (2603:10b6:a03:255::34)
 by MW6PR12MB8957.namprd12.prod.outlook.com (2603:10b6:303:23a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 10:53:37 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::3d) by BY3PR10CA0029.outlook.office365.com
 (2603:10b6:a03:255::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 10:53:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 10:53:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 31 Oct
 2025 03:53:22 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:53:18 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v5 10/32] hw/arm/smmuv3-accel: Restrict accelerated SMMUv3 to
 vfio-pci endpoints with iommufd
Date: Fri, 31 Oct 2025 10:49:43 +0000
Message-ID: <20251031105005.24618-11-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031105005.24618-1-skolothumtho@nvidia.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|MW6PR12MB8957:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b28b95c-ef29-4496-ea3b-08de186bbe48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|7416014|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVVGSVA1Qi9MTTEzLzRFS21pamdPeFJTSHpjK0NWeHgwdFJ3TUpjNzZuYkVF?=
 =?utf-8?B?S2NWUUxmVzBycTJXU3pHOEZZM2tJNXcwM05ZdVM5TjB4T25jdzg4QjVVZ1pV?=
 =?utf-8?B?REljdlV6R1ZseitIaVJPMTVVeFBoajZOb1RpK05icXlFUG5MRmlGVnpadHhF?=
 =?utf-8?B?ZVpMQ1ZsMXplY01Oa2JFbzdUT0tSblFIbm8xaW9FMElmdFpESVFydXRjMkQ1?=
 =?utf-8?B?eEZGWXJIV2JhN2ViN1RRcFJaa3FIUmhleGVvL0YwOWFGUU1UK0R1R2I3Nlcy?=
 =?utf-8?B?SE84Y1F4Y3JLRDdadVNDZTNBL0dwb3NZUk9EYVpXRG96U3VnanRHQTJUMUl5?=
 =?utf-8?B?UVlrVWExRm5EeDhZd0RGODdJL0JyTzcwWktFa3hKbWRGMStzQkpGQklkVjhF?=
 =?utf-8?B?RWlWVnpsM1dPK2FsVGM1bXpSUWxIVnNaUlpSUUxJelU1M1BCeXdOOUM1aVBv?=
 =?utf-8?B?UXl6OVlCb0NjcG0xWnRXeUhWak1SSFJOdFhiY2loT1U2V3UyTHFoRkVMbi92?=
 =?utf-8?B?c0JzNFAwRnFEWm9WcGE1b3Vvekt0YXdJT3h0WmJlclZGWjFncnRNb2EzQnB5?=
 =?utf-8?B?VHMxa0hHVHF1ampxOS9HNjcwKzBkcjB4V0tsbFYzZVoreS82UmVZZHUrMzlm?=
 =?utf-8?B?VHRheEhHZTJMMVdWL05oejZzZWIyVkRIRC9IY2VSSnU0WnhSUUQ2R0xYQ0hG?=
 =?utf-8?B?WFF3T1Joa3hoSkNwZEJ4RmttNnlhcnRJRnBpeXdLRDJOV2lURkdWRmR6QXJ0?=
 =?utf-8?B?eVRuMTlPTzdVRFBSNERTSVRIekRHSDBmWVN3b21PU2FaaTBYcUlZQ01PQkgy?=
 =?utf-8?B?WU1aWFFRaGl1RVlMYU9QZkFOUmMyN0RrYVRvRWtZSlBHSUoyVkN1b01ESS9x?=
 =?utf-8?B?WFN5UU8rU1l4K0ZFanJnZWhaV1ZzSm9acmdoTE5xRXJLUEtnQ3BDOUlnNEtz?=
 =?utf-8?B?TjlNTnk3TzQvQSttejlwTWtvaXlPN2I1QWlWOUU5U2N1SEUyMDNDRlNDUlhl?=
 =?utf-8?B?d2h0aG04enhvUjFkRXhkSjFRS0ZjNzVDVTQ5Mzg4RGo4dnhnWGVHVktTdGVu?=
 =?utf-8?B?NEs3cEp2dmhxZmZMRU55SkI3dEFxVFJPMXpZQjVla3k2Nk0vWmRrQTlEV3g4?=
 =?utf-8?B?RjZsR1kzS0R1WHRYSHFJVVlGcHI2VVBPbkYvZURhdldTRHFVTFE3SXlLL0Yy?=
 =?utf-8?B?dnBVNHU0NEVWZ0FMbU16Yk1vTndZNTh5RnFhb2FpdGZZZzhYZ0RKdGRESmZ6?=
 =?utf-8?B?S3dLbHFzbFJiNjhwMkM0b01oblduTjdScGRIT3RpK1R2dXlFeG80YTZscHVt?=
 =?utf-8?B?eWZXTWdwbFBHbk1YSXh5N2JUZW9ydG90bnJXSjVveE9GdEx3c3Z0QnlvcEhJ?=
 =?utf-8?B?QnhrNE9KVWtLaUp2VWs1K0hvOGZOdXN5akZMTGwxM2hWUnhRRjQrcFZlZU1Q?=
 =?utf-8?B?YmdBS2dFL0NlNm5SZlo4dnRRNjZzVVc1R09UanYwZmh3eEFFNWNadDY0Vkcy?=
 =?utf-8?B?T1RDNG9mejZYZVFLamY5c2s3TTZvbHFnNG16d0FJYjZkbXVUaVBGRFluTFlr?=
 =?utf-8?B?QmliN2ZScGs5c0ZkaVZSdGR4dzFFUnArdFpRQk9UL08zelRTOFNVdElTWVZU?=
 =?utf-8?B?dC9icnNDanl4Yy9Ham5yOGZVdDZNdEx3OGlPbmZweFhWM1dyV25SMWkyd2RG?=
 =?utf-8?B?S3JTZkNtWFZ3THZ1bkdaN0lPZjUyejFkbEZsZjN3SlJHUGFFQmJ4VFp2bjdp?=
 =?utf-8?B?VEExM0piS2Z6L1R2NjhvNk12eFdaTytyRTA1YmQyT21ZTjI1ZkNxeUw0TDFF?=
 =?utf-8?B?bGJtSWhtQ2VwbGRlUlcxQ1BCdHd4M2cyRDFZV1ZxQVlpbWd1NmpxSnN3ajJh?=
 =?utf-8?B?RkQxYTRkRE1wRTZDREZ2ZEJTclQvaDRVcTY5ZSticUlSa1NGbXluUGFIYitJ?=
 =?utf-8?B?L1BaU0d2RXBZdVZwOXhqOGllNEJuaFYyUEZLNUFCdWZ2ZUpRSVViUXVDODhM?=
 =?utf-8?B?ZWtzQnd0ek9MbXhlMS9IcUNJRDZybGVaYzZPL3NCMlFTL3FMYlFmbUc5akF0?=
 =?utf-8?B?d25ZUU9BQ0oyVWJpZlROeHJITVBrQjFLOWRKSSt2SmRMYmpOeCtDVmxzbnU1?=
 =?utf-8?Q?bnlE=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:53:36.4810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b28b95c-ef29-4496-ea3b-08de186bbe48
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8957
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_NONE=0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Accelerated SMMUv3 is only meaningful when a device can leverage the
host SMMUv3 in nested mode (S1+S2 translation). To keep the model
consistent and correct, this mode is restricted to vfio-pci endpoint
devices using the iommufd backend.

Non-endpoint emulated devices such as PCIe root ports and bridges are
also permitted so that vfio-pci devices can be attached beneath them.
All other device types are unsupported in accelerated mode.

Implement supports_address_space() callaback to reject all such
unsupported devices.

This restriction also avoids complications with IOTLB invalidations.
Some TLBI commands (e.g. CMD_TLBI_NH_ASID) lack an associated SID,
making it difficult to trace the originating device. Allowing emulated
endpoints would require invalidating both QEMU’s software IOTLB and the
host’s hardware IOTLB, which can significantly degrade performance.

For vfio-pci devices in nested mode, get_address_space() returns an
address space aliased to system address space so that the VFIO core
can set up the correct stage-2 mappings for guest RAM.

In summary:
 - vfio-pci devices(with iommufd as backend) return an address space
   aliased to system address space.
 - bridges and root ports return the IOMMU address space.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 66 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index f62b6cf2c9..550a0496fe 100644
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
@@ -38,6 +43,41 @@ static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
     return accel_dev;
 }
 
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
@@ -48,15 +88,39 @@ static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
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


