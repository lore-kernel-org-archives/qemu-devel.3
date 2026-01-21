Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F188C44508
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 17:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vicRM-0000U2-PP; Wed, 21 Jan 2026 12:56:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicRI-0000G4-9R; Wed, 21 Jan 2026 12:56:20 -0500
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicRG-00017H-Ae; Wed, 21 Jan 2026 12:56:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BSzdKZsgi7Q/vrCDk6MdJ7kfrOQ5U011daOFI9akaKFNlmp9DfBAJpIdM3FxYPynRcxirfGwQ6mmpwTq4D0cjOn8MuYDxQUPjY13HhICGxBM2kzlxEIBw0BFO+/J2PSuBG3QvXQWhZLoU/AQjC+TBO7ap3iKN6t9Gw4C3z/XVkRDhW0uWYyxWwlg2x+doPTufIsLkWdkVEhEzM9v6NZFAyhxkMFaTpAtkNyrImmVPKXTcBjRqZkF6mmGCcoaCD0oapX9Uzd1d545fd050K6hg3sCZeVzMR4+GXxe9KTJ8Zhxft1N2FJKt8OpxkpV+sDZefW/nQ7OtYSJYEqVqVyOFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Bhp2dmPHJ0YgWIRTcoQHpWneYWyVs7+X8bO0sf7bS0=;
 b=O1hVv/IxQExxC80CcBRuVUQLgA0Wg5eeMxvrFmekSV49VE3U84tmuUqyiD2WpiBgiNjUOlb6AvEYaK3nY2pHyVJVjig76WcNGp24++L1lz7ymTDMWdXZoRHMWOrqq5l5SMHJOIiViY6eRtS3NyVIdpLzSBcgWQmHPP6+sMox9xCRw6FGZx7OUGG09QIcUnXp5Mn+FoI7Ual6PumDZrigzxkCvWllHDEvoiTsEtw0emudaF9isAlCLyLRjt/RpQbJr0X+mB/lvk28eZ6hO7WbOG7YdGOJJhKl3CkOTOiwk54qt0ZuH4wy7oHP5RxPkD5/YUjAboS85Cm5X2yDa3R7oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Bhp2dmPHJ0YgWIRTcoQHpWneYWyVs7+X8bO0sf7bS0=;
 b=Ny+nw9Oyve2DQnzi01v7aVC182FEOQcKZe2IJShM5ZiY5dsjJjmLnWK15eIDBRI5VYRbtceGsc5+wmTx9aoe6aa+JRWytIarqpDHEQVUCC6vOm+EBxstSOwNBwQeTB/QE09Th3Z9CpRlnTcPLTXe1EY4Oa6/PsrKvR/C3w03hcc1q1QL1W4vQ7g3VCdxv0kU+1MztKxqPZ4zcbK8MKkCwj4VIP+oSxR9A16xJC4/lIBkfK5f4exCrUpQlceJohImQnJD2+Vm1Ieuc3ZO0Nk4OOAAg3PrG2m7Yh9mNTUd+v7Iee26O3naAO57V1J0RrOpl5GfWKH7t+vk2Pf3gmS9ug==
Received: from BN9PR03CA0471.namprd03.prod.outlook.com (2603:10b6:408:139::26)
 by PH7PR12MB8105.namprd12.prod.outlook.com (2603:10b6:510:2b7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 17:56:12 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:139:cafe::6a) by BN9PR03CA0471.outlook.office365.com
 (2603:10b6:408:139::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 17:56:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 17:56:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:55:48 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:55:43 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v8 10/37] hw/arm/smmuv3-accel: Restrict accelerated SMMUv3 to
 vfio-pci endpoints with iommufd
Date: Wed, 21 Jan 2026 17:52:15 +0000
Message-ID: <20260121175248.87649-11-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260121175248.87649-1-skolothumtho@nvidia.com>
References: <20260121175248.87649-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|PH7PR12MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c12db85-571d-41ef-502c-08de59165d1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UzJjTTdCcERaaFQ0ZnNNNHNFaUh1V2VBWFNUUlZyZkpRT1JKak5LTFcwSlZx?=
 =?utf-8?B?UmxqZ0FiWlRSSWo3RW9SRElSRUUyTythak9lVHRJUk1NaThlNkJHV2huQTZD?=
 =?utf-8?B?SlhkSmlBRVBJTmJmdXJobXI4UGVqamFnSlpMTkNMNVIzQjg4Sk9ZVU9Oc2Nh?=
 =?utf-8?B?emsvd25QUHBXMWxhczhyOFFRVXU3T3RuYndqOVIwblhvc3U5NUdjSlA4TjRH?=
 =?utf-8?B?ZWFYV3B0Mm8xV0JOL1NqTE5hUGhIVllGa0lSd0pQNjVOVzZveU1lQmd4L2Zt?=
 =?utf-8?B?ZVJjV3hyc21ycXJ5WHZrZHg2UFNQUzVWTEI5cmtMc0EwdUR0N2VSM0ZSYVJ5?=
 =?utf-8?B?UFdqVkFQOTJmYXZabktrRjlrMjNNVEkyQml3SHJycGhjU05BRTFJYTZpZkE2?=
 =?utf-8?B?YTJqampERnlHSFBwaXJVcmVxcUFqc3BLaWc2R3gwbXdJenR5VjBLTXNuMXBl?=
 =?utf-8?B?b3ZaQW03ZWM2SVQyTUpRTy9tRlgwOFlYZE9qS25wZERBOEhlVFU5bHpERGYx?=
 =?utf-8?B?dllSU3BwSVRBVWQ0VTRrQTlTazRQaktLWm12ZG1TcGprS1hjbGYrVTRDaHFw?=
 =?utf-8?B?VTltQVJ0YnIrRlJqZGwxUkVIcVBJWi9mNDdmZ3dWa3BNN25TTVFweCsvSTJJ?=
 =?utf-8?B?c2VGdmJMMjErczR5enB2eVdmZ1g2WEFIRmdMeTAwK2V2MXNpaTRxaHUwZk5V?=
 =?utf-8?B?YmRxRWlQNFk3UTlnV3NTakVRVnprbzQ0RFRLTThXRHZuRTczZ0JZb3V4WUUz?=
 =?utf-8?B?THRGd1gvUURtcHptNk9iVU1OdXpmRFhuVkY3a0tJdDVHN2RHdXpHWnIzci8z?=
 =?utf-8?B?VlNLT2U5TkF1bTFqZ2ZDbmtTUU5yZWVtOXJybk1Pem9YOUp3Mnc1UEgySTV0?=
 =?utf-8?B?VEZNNWVxektVcndRekwrbFVLS29xTHRjR3BHQjlEdjJ1ZUtYL2cxR3FmYTgz?=
 =?utf-8?B?S2R6UFVPNzB1RlBOTUJCYTBwZ0RDaytoYm94Nnl6U09oY3NGcEs2V0x3SnAz?=
 =?utf-8?B?RnkwbzZxSzNzZ04ySGJzR3B5djEwRUM5Q2NjR0JPRFV0QStPSHZRc1dyNjUv?=
 =?utf-8?B?dXg1TnhPOERuMlJaOElzRGV0NUlyd3pXUFFSWmR4Kzlxcm1ieFd2RWpMRmZi?=
 =?utf-8?B?Qm1GQWZXMmR4MHQ3QUN1bjJuaVNZZjdxMFVzNGdTRGlMYnJiSWRYUzhXVHIr?=
 =?utf-8?B?c1hyc2FlUEVEdjlEb1duYzc2UGFrZGp2M0RXTW9YTi80TTZWV3dlZHkvalNI?=
 =?utf-8?B?YkRhZUI3R1V4RTNQUjhlYjR3aHhFSGxNQTI3VGdOQ2Q5VTkza3cvRzE2MTl1?=
 =?utf-8?B?UzdFd1pvbzZiVXBhS25XRmZ4cnRrdVZHMVJteEkvOHByVmY4cExJZmZQM25V?=
 =?utf-8?B?c0s1YUFMRUlMUDIvM2k5Ri9sZHBOTktsMTBVdTlCdWtBUGhFdUF6TXFEYlJ5?=
 =?utf-8?B?dVY2bU1Dc2xlNm9ZbFhoZ3gzNG9NYnN3YkU2TTcwRDV3cFB6cGpGdTRTaTZ0?=
 =?utf-8?B?cFdnSTdIOEZvTWdhOGJDK0dUZTZ6azVMS1BqZm1PMm5mZThBZ05EYVlBeGRk?=
 =?utf-8?B?eDVMdHdHQnl1ZHQ1MTMzTnpDbisydXNiMGQ0TkxVa0NteHlGNDA1b3VYQ1pG?=
 =?utf-8?B?WjZPNHA2NnJWRHVsNVprMVpvOEdvc3RCem9NVzg3cDNDQ01CbTJsZEU0NHA5?=
 =?utf-8?B?UUxmOUxoK1QvWmoxK04zMTdua1RjWldhN1dMWjU0bEd0T2F2eUJhVEdNdlQr?=
 =?utf-8?B?YlA3WVNaRXRuNEFVWXEzalo4TU4yRXVWMUFMcXgyOEJ4ajBPTHhLcXIyNGRT?=
 =?utf-8?B?ZUo0emJ6N01wREE2c25CazF6czkzemlOUWdGTlNxRmlzdFRkdjNnVytQWWVV?=
 =?utf-8?B?VElML2UzQ1lpckRlSlF6dHdLM29DcVcrK21JalAwNGU4T0JDZUtZc2VKdjlp?=
 =?utf-8?B?d25YZXdZYktGd2U1ck5HdGlicFV1VW9PbmowbGZ4YkxwYU5SUk1SSEZuMjhD?=
 =?utf-8?B?UkR6Tk5SNko4ZWNkQVdnTkJFcVhGL042L3hQODQrV3F3UHM4Wnh6L0ljRW8w?=
 =?utf-8?B?MmhIL0krUmRlR2hKOXZNYTR5Wm0rTFBaelRnRUFUam1NclJuV0M3Wm9qc1o0?=
 =?utf-8?B?OHRvSUVzNzhEWksrTEdCZnViMWNTWGdZSjJ6SEFKanhEOGd0N2xmN0hHZjha?=
 =?utf-8?B?WmtBMDlUTlU0Vk0wanc2ZXJZdGNwOFQvamRhNVZydG1qQ0kxVVhkZEticUJr?=
 =?utf-8?B?WU4xQVBoY1EyVERZT0pYTW9wNW9nPT0=?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:56:11.7757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c12db85-571d-41ef-502c-08de59165d1d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8105
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
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
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
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


