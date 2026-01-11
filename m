Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF31DD25031
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 19:57:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf1Yf-0007Vx-KZ; Sun, 11 Jan 2026 14:57:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1Yc-0007Cw-Rp; Sun, 11 Jan 2026 14:57:02 -0500
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1Ya-0003tl-Kd; Sun, 11 Jan 2026 14:57:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zFpp/aPE9mj4FbM78hKRsETUwYF05IM+Ah42kEn2wAPUXzefw70RFA+D+MsrnhOo+mAVNrMuPrFCh+FRfB+dSS0V+ydKE9dLfs06k4IMIKpmiuuBviVmYGrDMdOHbDppEfvxrM0ME2XopgHGSxFKzCi+0UMSK7/w/BdvZ/OFzjmHtnD4GAQIPfxN2a0PcihEDGVjfWH6ld9bVc+1riFVq8QXx/kNmL9QsIby13fD+apBFTSLpcuxsXTG3j7kfvS+z1x+8V3dYyRYPp2Rvbrn3KcDYXPs2uH2iq819lr1uPld0T2OwKjXIiFXCvVE4jerPhvZAh9XvNdJUFiB097lQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gw7jfsneijsiqjWLEGlqx5c2MWdZueF0noBGAl5ZwaA=;
 b=CFhf23/lxHj+AEDW16b2xUZ9SOY9kURFECc7bc2JQGc1G9tlmiSKYEPtCPx6vOmyjs16QtMDwGCGMUtXTt6TOPoffR+ix5YmXPcajR62ytPHq1IwMAWo+KR/52bhreWn64nt9WWHudix9XHKCGlkG7qUNuZxXus4hqxjahsD5d6ckQhzZjCW20+tEs1KdtTJ7N8mdRDiegwND0Otk86tYx6A+HVU0nMEN44ZzaTNJhB3IWKyR7HrDrcN4G+crNBxIFdaPPzUoYnyY/MQvzCfqxuYLkzXlOvyO5j9VtSlck1mqTGGC7x9cQJHT0elcUBKwqsouvjsIpvvhKcHLzGKpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gw7jfsneijsiqjWLEGlqx5c2MWdZueF0noBGAl5ZwaA=;
 b=PssO3LYi7pEyZfdvjnF8jBoZKjLxM+5OsDoPmcz9tvDDv4BNdjuZlstM+LXBE1wtTMNJLwTxsihjjiyoxW7YQlXo9G2r+x/LTtAFMdG06dfx5HpASxPLPuJrEOYOX+jD/4n1QaJ0brM1hbj+Rrac4P7vNs/Xn/tAYyeIU6cGMvVDIJVf//iy2fm50KWRzvWR67177Llo1OkkCmSUVMJYhcl1o9cjR7GFM3f7tcPSsW8LLMLwuyc+rNxEzGtZzBanVw1XZHuNPholcR/4EA5wgac50UXVoXStbrf23NMlmc3x+qdePPnn9J55B/XTWQcsW7nPwndx9myAMd/GYynzWg==
Received: from SN6PR08CA0033.namprd08.prod.outlook.com (2603:10b6:805:66::46)
 by SJ5PPFB332093D3.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::99f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sun, 11 Jan
 2026 19:56:52 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:805:66:cafe::ef) by SN6PR08CA0033.outlook.office365.com
 (2603:10b6:805:66::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.6 via Frontend Transport; Sun,
 11 Jan 2026 19:56:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 19:56:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:56:42 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:56:37 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>
Subject: [PATCH v7 11/36] hw/arm/smmuv3-accel: Add set/unset_iommu_device
 callback
Date: Sun, 11 Jan 2026 19:52:57 +0000
Message-ID: <20260111195508.106943-12-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111195508.106943-1-skolothumtho@nvidia.com>
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|SJ5PPFB332093D3:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a9ad856-f765-4c44-c31e-08de514b9080
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WEs0MmVxZTBZUlVHSldRRS9qdWpLa2lRS2t0a1FZTDc3WWxoaGR3VnE2dktz?=
 =?utf-8?B?UUFYeTVLRU0wa2hYcUpJT0VGUGpaSG9QTWVlWk5Cd2FhSEk1RmxRaVR1M0lK?=
 =?utf-8?B?Z3FVOGo5bFluSC9oSFJJVmNtclZKR3o5UC85L3ZyRlBzV0k4SDh1aE8rbmJN?=
 =?utf-8?B?NzFNeWdNY20rNHVnN2xQeE5TZWdVVHdNRjArVHhDcDVETjMvWDNVQmp5cXRp?=
 =?utf-8?B?ckxHa0szRW1WL2VDdzRIMnAyWVd6V2JMSy94eEJBKzRwUG1CQWUxMWZoWVlK?=
 =?utf-8?B?Vk5ORm5Pb3l5QzU0NXB2aWp3MVFtd1RFRWtvc0s0VEpDbm9UY2x2Vi84UXRt?=
 =?utf-8?B?Q1FIMGhJM0JVZEtKMDdhZ0R3WWVQdnlocTJwUHF5TCt6cUowZUhqUzJycytX?=
 =?utf-8?B?Uy9WQjR0emJZRFUveUxLcVduVnZFdE10QUdWenZ2WGRZUC9seE9LVHh4SXJR?=
 =?utf-8?B?TnE1ejhDMXdHbSt2c2F1KzVqaStTUkp3RTZMSUF4T2krV2hJVEIwN1NkQVpH?=
 =?utf-8?B?OHIrT0F2WHRTVTNpeXZWdGNzaG9waVZtclYrc0ErSXNSaW9yU0Q5MUpJRlAy?=
 =?utf-8?B?Q1JPdFJhR2V2VElWRFBZaVJyWXVKRFdZWVYrTEoyUVZjbVpweHJBQTRRWjdW?=
 =?utf-8?B?SGdkRUNzY1pmN256Y2JITThPVnpnUWtGTEdNRXBUTVJXL090R2JCcERyRHlU?=
 =?utf-8?B?Y3MxNW1SUEkzeG1HZEZRMFBoam05aWdoWkl5bVlvanRkN3ZIRCsrUzY5L3h3?=
 =?utf-8?B?NlAxRjFQOXJlK2NCaG1OY2RBZkE5VUsxOEZ6VTY5SzE2a3ZEWDJTUmo0dnEx?=
 =?utf-8?B?TDNJQW14VnBMTzlDVjlxTlowT29tNDhLdUVPeUw4TUU5T25FVEdGVVJNbmRs?=
 =?utf-8?B?Wm1qQkZEdEs2WmdqemIxK08zS0JYOTFwS0NDNFJGOGh1djRkcTIyUG9DOFRV?=
 =?utf-8?B?Tkg1cmdJc3ZDQzhFREF4SEdlSFhaYnJYN1NySGlYOEFyUWFyMCs4QWxMNVdT?=
 =?utf-8?B?ZmxtU0N1S25rTmtJekJ4VzVIbVFhZHh0Qm94T0VvcXdvYXlJdU5IUVRpM2Jp?=
 =?utf-8?B?dEFpT1lMN045bVhhaXF2bnNXalZKK2Z1a2hkVGJnWUxQOTEwemliS256TFlH?=
 =?utf-8?B?bGxXNCtoaVNzWHg1YnRtcndUWW43TU5RNURmS2QwMFljbnZwbUxKSko5K2xT?=
 =?utf-8?B?Z0k3NlpiYkdrdU1PakdGU2Q1TXpkWFdkNzNORnd3c1F2WFZKTkU4STFsNmxl?=
 =?utf-8?B?YkJuV01VdXREYWszb2t3Y1pzSmxnOGN3KzhkaXFqNFpzU0NKZ0lwTXJlZy9v?=
 =?utf-8?B?ZWJZWGpMRGRKeVJuV3FwZE14eGY5SE5Eay9IbmlId0lnc3k1TFFIWEV4bE4y?=
 =?utf-8?B?QTIrRUlZSkZoUjRNZWd4Mk5TUGMvOGZPcmYyNElzdTUwbFYyNGxHcXhyVno1?=
 =?utf-8?B?emNWZmNzakprOXFKV2p1ek95cytDZEZxVS9YZitOd2V0cGQ1YTFSTTlGV2pP?=
 =?utf-8?B?SmwxV2Z1RXNxYlhBRWNINEhlYWtCMUlYd0E4SlBVQnd6MWluWWZUcmlMUXBM?=
 =?utf-8?B?d2JlTkhtb1JCYTFZeVV6S3RMKy9HelIrWGwxYWlOWHRzVWh4UUdWOUlINnJn?=
 =?utf-8?B?MmtZcjdEbVdzTmxDNUxPWENSZjROZVg2Y1o0NTUySGtYUHR4aGFqbTlWVjhh?=
 =?utf-8?B?T05QQXRwN3Q1UndxQ1hJWHVRSmNWdStXV2xQRU9RMU9rOUdTSERHQUtmSEYx?=
 =?utf-8?B?WGJ4UVJyRUVjWHRpdG54dWhxN1UwNUxQY2tUeDh3eTRrVTBOd200WDJMS1gy?=
 =?utf-8?B?WEx3UE5nNCs2QzZVSkVnNW5OeS94aGZYbU5udjVnUFplS2FiTXFUS3kyQUEv?=
 =?utf-8?B?VkxSbzJZVnI1eExZQzlpM3Q3alB0emlRZ2pybTE2Uk14WlhoSm11cU9XVU5S?=
 =?utf-8?B?SlZmT2EreDhaTUR6dHMvUGJ1bHJlYjhUMHp1dnVCVFhlMHBqdVZVQ2N3UU9F?=
 =?utf-8?B?QUQ4bGtnTnJnT2VMOUw5SkpqMGFOZUNDVlg3Sk9XTUdRc1VLdUhJcHBtUkNS?=
 =?utf-8?B?MzBERVVtK3NsSDZ5Mk1idUxSL2d2Qzkzb2R4T0pkOTN1a3gvSzh5b1F0ZVl1?=
 =?utf-8?Q?0q1o=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 19:56:52.0452 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9ad856-f765-4c44-c31e-08de514b9080
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFB332093D3
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Nicolin Chen <nicolinc@nvidia.com>

Implement the VFIO/PCI callbacks to attach and detach a HostIOMMUDevice
to a vSMMUv3 when accel=on,

 - set_iommu_device(): attach a HostIOMMUDevice to a vIOMMU
 - unset_iommu_device(): detach and release associated resources

In SMMUv3 accel=on mode, the guest SMMUv3 is backed by the host SMMUv3 via
IOMMUFD. A vIOMMU object (created via IOMMU_VIOMMU_ALLOC) provides a per-VM,
security-isolated handle to the physical SMMUv3. Without a vIOMMU, the
vSMMUv3 cannot relay guest operations to the host hardware nor maintain
isolation across VMs or devices. Therefore, set_iommu_device() allocates
a vIOMMU object if one does not already exist.

There are two main points to consider in this implementation:

1) VFIO core allocates and attaches a S2 HWPT that acts as the nesting
   parent for nested HWPTs(IOMMU_DOMAIN_NESTED). This parent HWPT will
   be shared across multiple vSMMU instances within a VM.

2) A device cannot attach directly to a vIOMMU. Instead, it attaches
   through a proxy nested HWPT (IOMMU_DOMAIN_NESTED). Based on the STE
   configuration,there are three types of nested HWPTs: bypass, abort,
   and translate.
    -The bypass and abort proxy HWPTs are pre-allocated. When SMMUv3
     operates in global abort or bypass modes, as controlled by the GBPA
     register, or issues a vSTE for bypass or abort we attach these
     pre-allocated nested HWPTs.
    -The translate HWPT requires a vDEVICE to be allocated first, since
     invalidations and events depend on a valid vSID.
    -The vDEVICE allocation and attach operations for vSTE based HWPTs
     are implemented in subsequent patches.

In summary, a device placed behind a vSMMU instance must have a vSID for
translate vSTE. The bypass and abort vSTEs are pre-allocated as proxy
nested HWPTs and is attached based on GBPA register. The core-managed
nesting parent S2 HWPT is used as parent S2 HWPT for all the nested
HWPTs and is intended to be shared across vSMMU instances within the
same VM.

set_iommu_device():
  - Reuse an existing vIOMMU for the same physical SMMU if available.
    If not, allocate a new one using the nesting parent S2 HWPT.
  - Pre-allocate two proxy nested HWPTs (bypass and abort) under the
    vIOMMU and install one based on GBPA.ABORT value.
  - Add the device to the vIOMMU’s device list.

unset_iommu_device():
  - Re-attach device to the nesting parent S2 HWPT.
  - Remove the device from the vIOMMU’s device list.
  - If the list is empty, free the proxy HWPTs (bypass and abort)
    and release the vIOMMU object.

Introduce struct SMMUv3AccelState, representing an accelerated SMMUv3
instance backed by an iommufd vIOMMU object, and storing the bypass and
abort proxy HWPT IDs.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c    | 156 +++++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h    |  18 +++++
 hw/arm/smmuv3-internal.h |   3 +
 hw/arm/trace-events      |   4 +
 include/hw/arm/smmuv3.h  |   1 +
 5 files changed, 182 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index be09cf8b73..9c2b917a11 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "trace.h"
 
 #include "hw/arm/smmuv3.h"
 #include "hw/core/iommu.h"
@@ -15,6 +16,7 @@
 #include "hw/pci-host/gpex.h"
 #include "hw/vfio/pci.h"
 
+#include "smmuv3-internal.h"
 #include "smmuv3-accel.h"
 
 /*
@@ -43,6 +45,157 @@ static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
     return accel_dev;
 }
 
+static uint32_t smmuv3_accel_gbpa_hwpt(SMMUv3State *s, SMMUv3AccelState *accel)
+{
+    return FIELD_EX32(s->gbpa, GBPA, ABORT) ?
+           accel->abort_hwpt_id : accel->bypass_hwpt_id;
+}
+
+static bool
+smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
+                          Error **errp)
+{
+    SMMUv3AccelState *accel = s->s_accel;
+    struct iommu_hwpt_arm_smmuv3 bypass_data = {
+        .ste = { SMMU_STE_CFG_BYPASS | SMMU_STE_VALID, 0x0ULL },
+    };
+    struct iommu_hwpt_arm_smmuv3 abort_data = {
+        .ste = { SMMU_STE_VALID, 0x0ULL },
+    };
+    uint32_t s2_hwpt_id = idev->hwpt_id;
+    uint32_t viommu_id, hwpt_id;
+    IOMMUFDViommu *viommu;
+
+    if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
+                                      IOMMU_VIOMMU_TYPE_ARM_SMMUV3,
+                                      s2_hwpt_id, &viommu_id, errp)) {
+        return false;
+    }
+
+    viommu = g_new0(IOMMUFDViommu, 1);
+    viommu->viommu_id = viommu_id;
+    viommu->s2_hwpt_id = s2_hwpt_id;
+    viommu->iommufd = idev->iommufd;
+
+    /*
+     * Pre-allocate HWPTs for S1 bypass and abort cases. These will be attached
+     * later for guest STEs or GBPAs that require bypass or abort configuration.
+     */
+    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid, viommu_id,
+                                    0, IOMMU_HWPT_DATA_ARM_SMMUV3,
+                                    sizeof(abort_data), &abort_data,
+                                    &accel->abort_hwpt_id, errp)) {
+        goto free_viommu;
+    }
+
+    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid, viommu_id,
+                                    0, IOMMU_HWPT_DATA_ARM_SMMUV3,
+                                    sizeof(bypass_data), &bypass_data,
+                                    &accel->bypass_hwpt_id, errp)) {
+        goto free_abort_hwpt;
+    }
+
+    /* Attach a HWPT based on SMMUv3 GBPA.ABORT value */
+    hwpt_id = smmuv3_accel_gbpa_hwpt(s, accel);
+    if (!host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp)) {
+        goto free_bypass_hwpt;
+    }
+    accel->viommu = viommu;
+    return true;
+
+free_bypass_hwpt:
+    iommufd_backend_free_id(idev->iommufd, accel->bypass_hwpt_id);
+free_abort_hwpt:
+    iommufd_backend_free_id(idev->iommufd, accel->abort_hwpt_id);
+free_viommu:
+    iommufd_backend_free_id(idev->iommufd, viommu->viommu_id);
+    g_free(viommu);
+    return false;
+}
+
+static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
+                                          HostIOMMUDevice *hiod, Error **errp)
+{
+    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(hiod);
+    SMMUState *bs = opaque;
+    SMMUv3State *s = ARM_SMMUV3(bs);
+    SMMUPciBus *sbus = smmu_get_sbus(bs, bus);
+    SMMUv3AccelDevice *accel_dev = smmuv3_accel_get_dev(bs, sbus, bus, devfn);
+
+    if (!idev) {
+        return true;
+    }
+
+    if (accel_dev->idev) {
+        if (accel_dev->idev != idev) {
+            error_setg(errp, "Device already has an associated idev 0x%x",
+                       idev->devid);
+            return false;
+        }
+        return true;
+    }
+
+    if (s->s_accel->viommu) {
+        goto done;
+    }
+
+    if (!smmuv3_accel_alloc_viommu(s, idev, errp)) {
+        error_append_hint(errp, "Unable to alloc vIOMMU: idev devid 0x%x: ",
+                          idev->devid);
+        return false;
+    }
+
+done:
+    accel_dev->idev = idev;
+    accel_dev->s_accel = s->s_accel;
+    QLIST_INSERT_HEAD(&s->s_accel->device_list, accel_dev, next);
+    trace_smmuv3_accel_set_iommu_device(devfn, idev->devid);
+    return true;
+}
+
+static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
+                                            int devfn)
+{
+    SMMUState *bs = opaque;
+    SMMUPciBus *sbus = g_hash_table_lookup(bs->smmu_pcibus_by_busptr, bus);
+    HostIOMMUDeviceIOMMUFD *idev;
+    SMMUv3AccelDevice *accel_dev;
+    SMMUv3AccelState *accel;
+    SMMUDevice *sdev;
+
+    if (!sbus) {
+        return;
+    }
+
+    sdev = sbus->pbdev[devfn];
+    if (!sdev) {
+        return;
+    }
+
+    accel_dev = container_of(sdev, SMMUv3AccelDevice, sdev);
+    idev = accel_dev->idev;
+    accel = accel_dev->s_accel;
+    /* Re-attach the default s2 hwpt id */
+    if (!host_iommu_device_iommufd_attach_hwpt(idev, idev->hwpt_id, NULL)) {
+        error_report("Unable to attach the default HW pagetable: idev devid "
+                     "0x%x", idev->devid);
+    }
+
+    accel_dev->idev = NULL;
+    accel_dev->s_accel = NULL;
+    QLIST_REMOVE(accel_dev, next);
+    trace_smmuv3_accel_unset_iommu_device(devfn, idev->devid);
+
+    if (QLIST_EMPTY(&accel->device_list)) {
+        iommufd_backend_free_id(accel->viommu->iommufd, accel->bypass_hwpt_id);
+        iommufd_backend_free_id(accel->viommu->iommufd, accel->abort_hwpt_id);
+        iommufd_backend_free_id(accel->viommu->iommufd,
+                                accel->viommu->viommu_id);
+        g_free(accel->viommu);
+        accel->viommu = NULL;
+    }
+}
+
 /*
  * Only allow PCIe bridges, pxb-pcie roots, and GPEX roots so vfio-pci
  * endpoints can sit downstream. Accelerated SMMUv3 requires a vfio-pci
@@ -145,6 +298,8 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
     .supports_address_space = smmuv3_accel_supports_as,
     .get_address_space = smmuv3_accel_find_add_as,
     .get_viommu_flags = smmuv3_accel_get_viommu_flags,
+    .set_iommu_device = smmuv3_accel_set_iommu_device,
+    .unset_iommu_device = smmuv3_accel_unset_iommu_device,
 };
 
 static void smmuv3_accel_as_init(SMMUv3State *s)
@@ -168,6 +323,7 @@ void smmuv3_accel_init(SMMUv3State *s)
 {
     SMMUState *bs = ARM_SMMU(s);
 
+    s->s_accel = g_new0(SMMUv3AccelState, 1);
     bs->iommu_ops = &smmuv3_accel_ops;
     smmuv3_accel_as_init(s);
 }
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 0dc6b00d35..efb631db4f 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -10,10 +10,28 @@
 #define HW_ARM_SMMUV3_ACCEL_H
 
 #include "hw/arm/smmu-common.h"
+#include "system/iommufd.h"
+#ifdef CONFIG_LINUX
+#include <linux/iommufd.h>
+#endif
 #include CONFIG_DEVICES
 
+/*
+ * Represents an accelerated SMMU instance backed by an iommufd vIOMMU object.
+ * Holds bypass and abort proxy HWPT IDs used for device attachment.
+ */
+typedef struct SMMUv3AccelState {
+    IOMMUFDViommu *viommu;
+    uint32_t bypass_hwpt_id;
+    uint32_t abort_hwpt_id;
+    QLIST_HEAD(, SMMUv3AccelDevice) device_list;
+} SMMUv3AccelState;
+
 typedef struct SMMUv3AccelDevice {
     SMMUDevice sdev;
+    HostIOMMUDeviceIOMMUFD *idev;
+    QLIST_ENTRY(SMMUv3AccelDevice) next;
+    SMMUv3AccelState *s_accel;
 } SMMUv3AccelDevice;
 
 #ifdef CONFIG_ARM_SMMUV3_ACCEL
diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index d15031f265..108a358b8f 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -583,6 +583,9 @@ typedef struct CD {
     ((extract64((x)->word[7], 0, 16) << 32) |           \
      ((x)->word[6] & 0xfffffff0))
 
+#define SMMU_STE_VALID      (1ULL << 0)
+#define SMMU_STE_CFG_BYPASS (1ULL << 3)
+
 static inline int oas2bits(int oas_field)
 {
     switch (oas_field) {
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index f3386bd7ae..2aaa0c40c7 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -66,6 +66,10 @@ smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s
 smmuv3_inv_notifiers_iova(const char *name, int asid, int vmid, uint64_t iova, uint8_t tg, uint64_t num_pages, int stage) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" stage=%d"
 smmu_reset_exit(void) ""
 
+#smmuv3-accel.c
+smmuv3_accel_set_iommu_device(int devfn, uint32_t devid) "devfn=0x%x (idev devid=0x%x)"
+smmuv3_accel_unset_iommu_device(int devfn, uint32_t devid) "devfn=0x%x (idev devid=0x%x)"
+
 # strongarm.c
 strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
 strongarm_ssp_read_underrun(void) "SSP rx underrun"
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index bb7076286b..e54ece2d38 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -66,6 +66,7 @@ struct SMMUv3State {
 
     /* SMMU has HW accelerator support for nested S1 + s2 */
     bool accel;
+    struct SMMUv3AccelState *s_accel;
 };
 
 typedef enum {
-- 
2.43.0


