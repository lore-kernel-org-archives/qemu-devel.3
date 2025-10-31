Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B870CCCF9FF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 10:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEmmE-0004nL-5C; Fri, 31 Oct 2025 06:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmlg-0004R6-VT; Fri, 31 Oct 2025 06:54:06 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmlS-0002xO-KY; Fri, 31 Oct 2025 06:53:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sYSwOJUQMtO2Sg14K6FtPBavRx6TGPtMo/8n55y3XdyjK+7XLVF7wvIfedT39IdjTrNkHQ4fEeKyvK5fasOMPq02bg1ciX1mVE2Ro2KCgWYfdNRFAs+PgHSiGHVTCsHiqSXkYJ0m5A1hZzaLU0hypEjcYirNGDt+KUDxeruXPRp1ywOWMZzhZL1BIwSEe6W7MvuxLs5HA9X7G9v4LH91Tto8C+gBA1gc88Z1F0AxbKiMTEg4TJ/pWM4juZPFk5daloDroFYGc5DGFdxYvOBk/jEo0U4o1elTOwSToAhwLFRIWmg0MELV3rxQnBV2SiZJnBFnpbV39cr2AOsOsS4HvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hiYKIH7EHrbC98rwIxCGqy8f2yC2y2tZh0ZHPWf+OZk=;
 b=bnsJ5FqemOrB3omlRt85ZrwRgBfz8tWYHLEq0ZcMxi13BIH6I8Of7LIYVKGV8pB76pjAakVOdsebMWatgXzBCiuheV5XPZ2kesrqXdOj4NIgXyH2HmBb0avrCM3YRJ+CBLYYUgHpxTCtN3L8KC2LhGy9Y4RaB1osp5hAw4lB2JopSSGGaKpc1jNzfgme2w6LLYjtixGqayqELttX0oQrfIS4+mUAGbX6lZLlOLl6pYlTof0d0kXxO3vNJLnm9e5/CuyJW54tVuIPaaxc8/ERC47REcLeKHU0vp0Q9NLNp2mf9gcv02QeJ3DfzOW17wFLMvYFrxXh6+J3Gv68kWNb9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hiYKIH7EHrbC98rwIxCGqy8f2yC2y2tZh0ZHPWf+OZk=;
 b=jfwfC3j5KJAPxcgMnmZca9scXtVEY+izm1NXyH3m5+AVGvHnkGgdyWyJV+CFysFsXQJv9LQgjZcefEViGuWvCwlE+WA3GbO3rR/kAPG2pQAaOUE4lYdUxzSvZkAZ+HQpIMz/uD88flQ8RFreC3nD5hbJP/WNOrxFLmVJ//bCYHktKTE9EiR4Qjiow+G8XWRvpR9aVB9+lz8Z1CJAY4FB0va+bxNRD3BThq28HWddgwp9joLdYZIJCHveKh9lChpBMkF6s4l7PyT+FtyvnTC2F9HidWossYd3qS1F8KatruaV3Oo3wz56Weg/bCiOfiNAU8RKm/n8jck7ZvRjiuFq1g==
Received: from PH7P221CA0043.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::31)
 by CH3PR12MB9729.namprd12.prod.outlook.com (2603:10b6:610:253::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 10:53:40 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:510:33c:cafe::9) by PH7P221CA0043.outlook.office365.com
 (2603:10b6:510:33c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 10:53:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 10:53:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:53:31 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:53:27 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v5 12/32] hw/arm/smmuv3-accel: Add set/unset_iommu_device
 callback
Date: Fri, 31 Oct 2025 10:49:45 +0000
Message-ID: <20251031105005.24618-13-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|CH3PR12MB9729:EE_
X-MS-Office365-Filtering-Correlation-Id: b5c6709d-7fa1-490d-048e-08de186bc029
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SFh3ZHQwUnNRakV3Ky9pZjIzMmRJM05FdWFZRHB4azUxdTlWd3ZDejlEQ3dH?=
 =?utf-8?B?TG9iU2N2VWhJSW9tOWo4eWV0QkxNV1pzQTd2bDEyVU5ZVk9HUmt4NVY1RXNu?=
 =?utf-8?B?akh5OFhPelVMYlhtN0NBNnFyZFdUZkNudnlXcFUzRmU1WTdKM0tNZDB3UUhm?=
 =?utf-8?B?ZnV4UVdCd3BNRk9LR3VxK3RPdUtmMW5oeG5iVFNHOXo3c0hGR2k0NlpSNWwv?=
 =?utf-8?B?T2JqWUZ5aUcyblYzYWMyNVJYVjhZZ0gzTEwyeFdMcmVna3dlbGlHNWF4UGtZ?=
 =?utf-8?B?VCt1Q3hSRXhnamV0U2NjOEtta3BncTN0S3FHakdaMm1hZjN6TWlCOFlpbkt3?=
 =?utf-8?B?bC83bWtXZU5EQVNJalJ2UngvdWI2MENWbGdPazVKeTdQOVhoMi9kYTFibThy?=
 =?utf-8?B?dzhzRDhRSUtybmNoRXBqazJORHhRV1crYmFCNTVrL1p1cmFTbHJzZ3BwUjY4?=
 =?utf-8?B?MVpPbEx1cndNd2p3RkRqMjhjQ3k1SCtEZ1Z1NkRGSTluT1NKVXhlQXZCYzA5?=
 =?utf-8?B?TVR5SVdPQS9pSHhuNXVwZUJDanJsZFZCakw3L2hVenlBWFN3T3Z5UkpkL1FN?=
 =?utf-8?B?MlRwaXNCZDhOQXhpUUVMWVFEdDdDQkx5OG5uQ3FJUkxJdWtkclJpditFaHF4?=
 =?utf-8?B?dDNBck05OGdNU1ZTeWdPVmpJc2pNZDZBUzRFOW9sL0k4TUxVZ3cvNnRQWW1K?=
 =?utf-8?B?eU9TOWFIYThaYjBXQ1k0MzJ5RjZEeDY3YnYyR0pGZWR0YmhVNklldFFHQnJ5?=
 =?utf-8?B?dUpUYUo1aTNvTGdQMDVOYXNvVDZDcTZSTnlUdDY1TXhXbEwrZ3oyUTE3Zkhk?=
 =?utf-8?B?eGNJdkg5UzFkVjExWFpsRndXWHZXQ1RJbGxVNzdsU2ZoVkZrNnoxMkhRSyt1?=
 =?utf-8?B?Y2V1Rld3QTlKT1FMeU1JcmUvSjRKMUlqdjhyQWtncGl1cjJ5N3NTNFZnZTFJ?=
 =?utf-8?B?ZUsxQWpXSkg5ek0yLzZqZDFBSzhPUktUcFlvM1hITi9tWStOUU1lRS95Y3BS?=
 =?utf-8?B?eGp0dXdXZklUMFdqM2RMbUs4cFVkYTg4NHJDKzc2TDdCZkVlR2pKRG1XNVVK?=
 =?utf-8?B?T25MQVVpd2tISzdEODI0cnlkTE5jZnRld3VnUWJ4VEJaWm94aGM1TXFIa1Qy?=
 =?utf-8?B?cEgrMDcvaGtuQXltamV2ckpiQWFDRThuaWVMMS9NdjE4NVcydlljclVmQUxV?=
 =?utf-8?B?aXU2ZGxEbFN5NUZXenpQNC9SeVU4U0VaYnRocDdraTNYT0dJWENwQi9qOTU4?=
 =?utf-8?B?MHJDdjJUeTNBTEpoUzUzSU5tS2tRUmZZaUdjYjExT0dVZjB6aG94MlM2bGNM?=
 =?utf-8?B?a1k3YmVSeDI3NWR4OGw1OTJIbG5mdjRxNythdFlsZWN2Z0JXSWNYSCtJYWtr?=
 =?utf-8?B?Yktxc1dVSWw0Vy9PZVFqYjRobWF1bWhYakU5ZVpzR3FTMnVzdUFlamJQeEtQ?=
 =?utf-8?B?YlZYUm11WWp4cEJzdTFYV2d5UWhDRzRka00vbWQ1d2xpcmVjclJ0TTN4d3Nj?=
 =?utf-8?B?bElZNlJ3TTA3dUdDN2N3TlpsaDBwcW43VDczUzh3UXQ5djRaN3BNYUJZVDlJ?=
 =?utf-8?B?UjRwNDViYVlNd0dJWGhDdGo0Rm9sd0l6WU9CY3lqaXQ2MEFoeWs3MUJ1VlJu?=
 =?utf-8?B?QkRkdGl4SUM4azhaTFpHaUEwSzVFMC9JY0xsVWY3NDkwOElHODl3M3ZGdDkr?=
 =?utf-8?B?STQyM0haMERaaWVpejJEblV0SVNBVXZocDdDb1JSN0xVMnBBUFVaRGhvYWU3?=
 =?utf-8?B?OFVGcGN3dkgxQ1dmbFBMOG9jb0taK2MwS1FvTzB3M3UxS1I0aGNiamcvZW9o?=
 =?utf-8?B?QkpKZ0YxQ0pZRnVLR2R2OFRtaWxKLzFRRTlabDlKN3B4TkNnYWg2ODkrY1pz?=
 =?utf-8?B?M1lCTW9IWkJ1QUdUc1pUaFRuU0kzVzlmak1oSjREZEx2ZHdYaytMZERISDFQ?=
 =?utf-8?B?UUVUbEE3b3N0Q0lBQlNPYllhL3RoNmZDeW43YVpObnJsODh5RlNReVlFR1ZO?=
 =?utf-8?B?dzdOMCt3OG5JanlyVit6cnZjNGNFeXpJcTZRY2MxSkhDTlY3OEpIdEt2K1V4?=
 =?utf-8?B?QWJrL0FYclRaSkxmUVNzN1lrYmxDZGo5NWlIZEVQSVVDQ24wZkNXc2U2VUFO?=
 =?utf-8?Q?yAeY=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:53:39.6625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c6709d-7fa1-490d-048e-08de186bc029
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9729
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
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
    -The vDEVICE allocation and actual attach operations for these proxy
     HWPTs are implemented in subsequent patches.

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
    vIOMMU.
  - Add the device to the vIOMMU’s device list.

unset_iommu_device():
  - Re-attach device to the nesting parent S2 HWPT.
  - Remove the device from the vIOMMU’s device list.
  - If the list is empty, free the proxy HWPTs (bypass and abort)
    and release the vIOMMU object.

Introduce SMMUv3AccelState, which holds a reference to an SMMUViommu
structure representing a virtual SMMU instance backed by an iommufd
vIOMMU object.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c    | 150 +++++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h    |  22 ++++++
 hw/arm/smmuv3-internal.h |   5 ++
 hw/arm/trace-events      |   4 ++
 include/hw/arm/smmuv3.h  |   1 +
 5 files changed, 182 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index a1d672208f..d4d65299a8 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "trace.h"
 
 #include "hw/arm/smmuv3.h"
 #include "hw/iommu.h"
@@ -15,6 +16,7 @@
 #include "hw/pci-host/gpex.h"
 #include "hw/vfio/pci.h"
 
+#include "smmuv3-internal.h"
 #include "smmuv3-accel.h"
 
 /*
@@ -44,6 +46,151 @@ static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
     return accel_dev;
 }
 
+static bool
+smmuv3_accel_dev_alloc_viommu(SMMUv3AccelDevice *accel_dev,
+                              HostIOMMUDeviceIOMMUFD *idev, Error **errp)
+{
+    struct iommu_hwpt_arm_smmuv3 bypass_data = {
+        .ste = { SMMU_STE_CFG_BYPASS | SMMU_STE_VALID, 0x0ULL },
+    };
+    struct iommu_hwpt_arm_smmuv3 abort_data = {
+        .ste = { SMMU_STE_VALID, 0x0ULL },
+    };
+    SMMUDevice *sdev = &accel_dev->sdev;
+    SMMUState *bs = sdev->smmu;
+    SMMUv3State *s = ARM_SMMUV3(bs);
+    SMMUv3AccelState *s_accel = s->s_accel;
+    uint32_t s2_hwpt_id = idev->hwpt_id;
+    SMMUViommu *vsmmu;
+    uint32_t viommu_id;
+
+    if (s_accel->vsmmu) {
+        accel_dev->vsmmu = s_accel->vsmmu;
+        return true;
+    }
+
+    if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
+                                      IOMMU_VIOMMU_TYPE_ARM_SMMUV3,
+                                      s2_hwpt_id, &viommu_id, errp)) {
+        return false;
+    }
+
+    vsmmu = g_new0(SMMUViommu, 1);
+    vsmmu->viommu.viommu_id = viommu_id;
+    vsmmu->viommu.s2_hwpt_id = s2_hwpt_id;
+    vsmmu->viommu.iommufd = idev->iommufd;
+
+    /*
+     * Pre-allocate HWPTs for S1 bypass and abort cases. These will be attached
+     * later for guest STEs or GBPAs that require bypass or abort configuration.
+     */
+    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid, viommu_id,
+                                    0, IOMMU_HWPT_DATA_ARM_SMMUV3,
+                                    sizeof(abort_data), &abort_data,
+                                    &vsmmu->abort_hwpt_id, errp)) {
+        goto free_viommu;
+    }
+
+    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid, viommu_id,
+                                    0, IOMMU_HWPT_DATA_ARM_SMMUV3,
+                                    sizeof(bypass_data), &bypass_data,
+                                    &vsmmu->bypass_hwpt_id, errp)) {
+        goto free_abort_hwpt;
+    }
+
+    vsmmu->iommufd = idev->iommufd;
+    s_accel->vsmmu = vsmmu;
+    accel_dev->vsmmu = vsmmu;
+    return true;
+
+free_abort_hwpt:
+    iommufd_backend_free_id(idev->iommufd, vsmmu->abort_hwpt_id);
+free_viommu:
+    iommufd_backend_free_id(idev->iommufd, vsmmu->viommu.viommu_id);
+    g_free(vsmmu);
+    return false;
+}
+
+static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
+                                          HostIOMMUDevice *hiod, Error **errp)
+{
+    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(hiod);
+    SMMUState *bs = opaque;
+    SMMUv3State *s = ARM_SMMUV3(bs);
+    SMMUv3AccelState *s_accel = s->s_accel;
+    SMMUPciBus *sbus = smmu_get_sbus(bs, bus);
+    SMMUv3AccelDevice *accel_dev = smmuv3_accel_get_dev(bs, sbus, bus, devfn);
+    SMMUDevice *sdev = &accel_dev->sdev;
+    uint16_t sid = smmu_get_sid(sdev);
+
+    if (!idev) {
+        return true;
+    }
+
+    if (accel_dev->idev) {
+        if (accel_dev->idev != idev) {
+            error_setg(errp, "Device 0x%x already has an associated IOMMU dev",
+                       sid);
+            return false;
+        }
+        return true;
+    }
+
+    if (!smmuv3_accel_dev_alloc_viommu(accel_dev, idev, errp)) {
+        error_append_hint(errp, "Device 0x%x: Unable to alloc viommu", sid);
+        return false;
+    }
+
+    accel_dev->idev = idev;
+    QLIST_INSERT_HEAD(&s_accel->vsmmu->device_list, accel_dev, next);
+    trace_smmuv3_accel_set_iommu_device(devfn, idev->devid);
+    return true;
+}
+
+static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
+                                            int devfn)
+{
+    SMMUState *bs = opaque;
+    SMMUv3State *s = ARM_SMMUV3(bs);
+    SMMUPciBus *sbus = g_hash_table_lookup(bs->smmu_pcibus_by_busptr, bus);
+    SMMUv3AccelDevice *accel_dev;
+    SMMUViommu *vsmmu;
+    SMMUDevice *sdev;
+    uint16_t sid;
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
+    sid = smmu_get_sid(sdev);
+    accel_dev = container_of(sdev, SMMUv3AccelDevice, sdev);
+    /* Re-attach the default s2 hwpt id */
+    if (!host_iommu_device_iommufd_attach_hwpt(accel_dev->idev,
+                                               accel_dev->idev->hwpt_id,
+                                               NULL)) {
+        error_report("Unable to attach dev 0x%x to the default HW pagetable",
+                     sid);
+    }
+
+    accel_dev->idev = NULL;
+    QLIST_REMOVE(accel_dev, next);
+    trace_smmuv3_accel_unset_iommu_device(devfn, sid);
+
+    vsmmu = s->s_accel->vsmmu;
+    if (QLIST_EMPTY(&vsmmu->device_list)) {
+        iommufd_backend_free_id(vsmmu->iommufd, vsmmu->bypass_hwpt_id);
+        iommufd_backend_free_id(vsmmu->iommufd, vsmmu->abort_hwpt_id);
+        iommufd_backend_free_id(vsmmu->iommufd, vsmmu->viommu.viommu_id);
+        g_free(vsmmu);
+        s->s_accel->vsmmu = NULL;
+    }
+}
+
 static bool smmuv3_accel_pdev_allowed(PCIDevice *pdev, bool *vfio_pci)
 {
 
@@ -135,6 +282,8 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
     .supports_address_space = smmuv3_accel_supports_as,
     .get_address_space = smmuv3_accel_find_add_as,
     .get_viommu_flags = smmuv3_accel_get_viommu_flags,
+    .set_iommu_device = smmuv3_accel_set_iommu_device,
+    .unset_iommu_device = smmuv3_accel_unset_iommu_device,
 };
 
 static void smmuv3_accel_as_init(SMMUv3State *s)
@@ -160,4 +309,5 @@ void smmuv3_accel_init(SMMUv3State *s)
 
     bs->iommu_ops = &smmuv3_accel_ops;
     smmuv3_accel_as_init(s);
+    s->s_accel = g_new0(SMMUv3AccelState, 1);
 }
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 0dc6b00d35..d81f90c32c 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -10,12 +10,34 @@
 #define HW_ARM_SMMUV3_ACCEL_H
 
 #include "hw/arm/smmu-common.h"
+#include "system/iommufd.h"
+#include <linux/iommufd.h>
 #include CONFIG_DEVICES
 
+/*
+ * Represents a virtual SMMU instance backed by an iommufd vIOMMU object.
+ * Holds references to the core iommufd vIOMMU object and to proxy HWPTs
+ * (bypass and abort) used for device attachment.
+ */
+typedef struct SMMUViommu {
+    IOMMUFDBackend *iommufd;
+    IOMMUFDViommu viommu;
+    uint32_t bypass_hwpt_id;
+    uint32_t abort_hwpt_id;
+    QLIST_HEAD(, SMMUv3AccelDevice) device_list;
+} SMMUViommu;
+
 typedef struct SMMUv3AccelDevice {
     SMMUDevice sdev;
+    HostIOMMUDeviceIOMMUFD *idev;
+    SMMUViommu *vsmmu;
+    QLIST_ENTRY(SMMUv3AccelDevice) next;
 } SMMUv3AccelDevice;
 
+typedef struct SMMUv3AccelState {
+    SMMUViommu *vsmmu;
+} SMMUv3AccelState;
+
 #ifdef CONFIG_ARM_SMMUV3_ACCEL
 void smmuv3_accel_init(SMMUv3State *s);
 #else
diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index b6b7399347..03d86cfc5c 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -583,6 +583,11 @@ typedef struct CD {
     ((extract64((x)->word[7], 0, 16) << 32) |           \
      ((x)->word[6] & 0xfffffff0))
 
+#define SMMU_STE_VALID      (1ULL << 0)
+#define SMMU_STE_CFG_BYPASS (1ULL << 3)
+
+#define SMMU_GBPA_ABORT (1UL << 20)
+
 static inline int oas2bits(int oas_field)
 {
     switch (oas_field) {
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index f3386bd7ae..49c0460f30 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -66,6 +66,10 @@ smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s
 smmuv3_inv_notifiers_iova(const char *name, int asid, int vmid, uint64_t iova, uint8_t tg, uint64_t num_pages, int stage) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" stage=%d"
 smmu_reset_exit(void) ""
 
+#smmuv3-accel.c
+smmuv3_accel_set_iommu_device(int devfn, uint32_t sid) "devfn=0x%x (idev devid=0x%x)"
+smmuv3_accel_unset_iommu_device(int devfn, uint32_t sid) "devfn=0x%x (idev devid=0x%x)"
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


