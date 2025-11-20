Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612A0CF8856
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 13:32:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM4ed-00074X-SK; Thu, 20 Nov 2025 08:24:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4eO-0006jP-Vq; Thu, 20 Nov 2025 08:24:46 -0500
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4eM-0002KR-26; Thu, 20 Nov 2025 08:24:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XkjSeHEDleNy8eDc7xbr2XhWRDesTqgF3vysL4HvR39UbNLcIYHgAuz57MAlFnWv4n0gflMr1Yha+iN+bsmQ+G3ClXqd8jA46HnB1aIwRqjEh0NLu4cZZLl+2nNMDDv46RqUHp/vZrfzCTSJp00/wnfmLfDcMvIyo/7+3wmP8WlMg5wQkjAm9nQRXsdiDzz1CF9lIMPllNgaYQSpediXWaMvda8AfoPqNwE94JQd0gVWtumsYy1WP11gIPNgIg13ZOX120b0QIhdAerXkFxxXpw0wFIK5wnQ7TP6MG7lrUE2vUmbnezcundNazRglFWtY+2//A1f0ioWxe0wkQUprQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bH1L84xJUgoD4LTcj7+Osfl0+2SNo+lDALfS25AtnUg=;
 b=C38qnKqd8+CFpkINAA6gPJrOwm3bEAzvT2/qMknPSn1Pg5+OXno6JNiuVFg/izOiO9P0K0pJhK//CDkhw6RF7UDFzZKm4gkaXW5KToJkJQ5kU9/qDXM12DUlz/BxJ6Zd6AHcFDqjqH4/p5VM2phwNcr6SmVuK44yqQCnOCdk232i7zwlFuq9hPU5QAYiWYrkTTuFcvDNKlzi3l4LwV5hzDWk8ITjYjc84JRQnqUc5iz1OXXBC6La8lC0wHECauDDiM/OkXmvKEea1Ek3RjZ8CozHljQbzO7E4pKIagWvV9ECTJTy2J4mZQo4pCOaYYSokaY0BYSQgtMzR0vDxahofQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bH1L84xJUgoD4LTcj7+Osfl0+2SNo+lDALfS25AtnUg=;
 b=avnRyfCJSn4a6AbH9I4nwHJWstUbFcqleAdBALJhIyyW7UuzBSPpfemjE903duy8uhXnvZf3VBQVT8BFK45XdAFmbUsD1XBnCb6vV3OVli3kQsukvzPqoWF/4wX2l2wlM8u+aJ40K8ePsfpG0ruPgtcn4uChfqdQvqHvXxXqK6fFJWHXXJejPjkEwr3olOXYePc/IgX4RBOChqVtxn3uhEioL2LZBbOJbF4MAzjQou7lCQ2+DXatzDjYLJPTNyNiNlSm+u4zdvH77tZWIQRcuMAo3FDK8pYLK6pE3RaL+tzI4mdX5l/mDsb75/qj6KjN0JU9o2C1NxDvuvGiIiuKgQ==
Received: from BYAPR08CA0059.namprd08.prod.outlook.com (2603:10b6:a03:117::36)
 by DS0PR12MB8070.namprd12.prod.outlook.com (2603:10b6:8:dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 13:24:29 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a03:117:cafe::92) by BYAPR08CA0059.outlook.office365.com
 (2603:10b6:a03:117::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 13:24:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:24:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:24:08 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:24:04 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v6 12/33] hw/arm/smmuv3-accel: Add set/unset_iommu_device
 callback
Date: Thu, 20 Nov 2025 13:21:52 +0000
Message-ID: <20251120132213.56581-13-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|DS0PR12MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: b78cab47-ca15-40a6-e638-08de283821ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cXJEZEpzUnpaMk5FN2N2NXRtVm5vMHJ2V3RKRW14TTRWWjlHM2Q0WURPZ21B?=
 =?utf-8?B?eFZRQVVRckVwVmdTYkRNY0FtZllKMkpSeHlYdUFYRzFWQUhYQW9vWUM5MUl5?=
 =?utf-8?B?L1hhclR6cFRxUVdjTGZadFczK0xDZVZHOGwybkx3bUxmOExIK0pPdVJtVStE?=
 =?utf-8?B?cTBlam9ESktYVmtCWDNJTSt2TzN3d3VHS3hKSk5NaFdUSmJCclJ5dGtZeG1q?=
 =?utf-8?B?UzE1NW5Kcy9IZkFtTTdUUDMwL3VkVkR1bS9nYUdSYXk2VmxuajlvbUhlTkRr?=
 =?utf-8?B?aEh5Y2tMamtwaTNHREhtSkNVRExsQ2hETEx4Zi91dU80R01rcUZyQ3M5MTFK?=
 =?utf-8?B?R0pYRTB4L1ZOWlFsbGJ6djRsY2hNV0hjbnhhbDRucGNyaXpFaFUrL3RHVXVH?=
 =?utf-8?B?RTZ0Z2tERFVYYlY2bmFCdVphSm8wbjNRUjlrQzlYZTRrSHBCTk16a0YzWWJR?=
 =?utf-8?B?L3N4Z3NqSG50d3pYTmIxZi8yMGJzMDFmRmNzOS9aSVQ1Q2hqNFArdnZMaGJW?=
 =?utf-8?B?TjZNcTR5bHRZbGJQcGZ3VGJHQ3kxSmgzQzJQU2FyN0J6dW04ZmlXdEtYUGd1?=
 =?utf-8?B?b1pqbmc2NEk3TEg1eHIzRTBXSk9teU1OV1orTjJ3QVA5MXgyUFNLZitWU3Np?=
 =?utf-8?B?Zi9TQWxYblhRSW5CREppSVlUTXFUT2FkYldRbzRqTnAydkt3amY0aFV5R09E?=
 =?utf-8?B?aG8vUVh5TGhkZWZoWEhNeDBJNzVDYWZOM1hHaWRoMEZuOFU2UUI4aXFnVWFY?=
 =?utf-8?B?UVRJYTlzSVIxUURsUktHMkZsaEVPaXEwSnFIUFQ1TTB6Z2dWUm5hd2ljTFd4?=
 =?utf-8?B?cEV0TjlSSVBia1hSQ3FoVWJBcVhnYXJEbE5vOFNaZXYrU3JOWEhoQTEzUE16?=
 =?utf-8?B?d2NrZExGYWQ1SzI5aTdkLzJLTkNVbXJ1ZWJveUtIR0x5L2lzUFpkMFdaTzBt?=
 =?utf-8?B?azhpMkcwT0crSWtWRzY5RHdBajEvVVYxalVwM2UwdDV6OWZzOXlZREJMZi9C?=
 =?utf-8?B?NEtwaUpuSml3L2NndXBlWHVLbjFxZVlYMWxZVG9UMFhnVzhHUzFrL2VMTnBG?=
 =?utf-8?B?SEg2TWF2U0dmZ3pHakxqUFVrTXdjTnViRkRCYzduU0FEYmVEejdXYjJGR0NN?=
 =?utf-8?B?RWVRd2dPUm1XMDBrcERrTHhvR3pHNXVNbDFxOE9zb2VmL040TzRmZHhxa2pQ?=
 =?utf-8?B?OWJWYnVCL1FYLzFUQ2pZUDZ6UXhBaWhyZzlIaElZT2hvbU1Scyt0Rlo4cTRM?=
 =?utf-8?B?dGlxaWs2L0wwNjZpS3JsN1Rwd0Y2bEtWQTMxNjVUYURYS2pYZXpObXJMcTBX?=
 =?utf-8?B?alpWV1NaM1NSSFlSSUpaTVUrS1VLQ2dEQVVDeXo4dDRseU9tWjZBWHNDNHQ5?=
 =?utf-8?B?bmJZU2FyT1ZGTjRVdXlzalI4aDZNVGpmZDRzVnVtczNKMDRuLzRIQWQyeHdH?=
 =?utf-8?B?YzZ5MEVhRHpZQzZuSUo4UldUZStoSCtMSGFqUGxENUIvZllHRkhOVGdKMEww?=
 =?utf-8?B?WC9yRW53L3ZHRGNvR1kyR0ZTY0RncHh2dUhqd292ZFNSR2NVcENNM1NZK0J4?=
 =?utf-8?B?K216bFRCMFplbExpdjBKN211c3I5bjM2UENaMHNReklWUHdORzhHRjNCT0Qy?=
 =?utf-8?B?MVZhcHZsUFZEcmtEd1padUc4Z3V1cjI1a2RrRVg4YUxReVJhREhMZS9FM2dv?=
 =?utf-8?B?YW5DdFlYRjZNN2lEdWlNOWh6WXp1dW1aNmJHTTdkUVUrcmpaYngxWkwyY3g2?=
 =?utf-8?B?TFhYM3k3a1VyeVNYR3pkcWZ2aUE3L291ZzRxQ09DODQ3NkxlNXNDZHI4UU1Q?=
 =?utf-8?B?Zm1VSm1SMEdBdXQ2UjFRT04zdnpwbityWlU3c0NEMStPTkNhV1pXdWNGVTVF?=
 =?utf-8?B?ZWxsY091WVVZNWMzbmtpK0xUNWU1azh0Rzcyc3RlM2FVeHU1c01HQjJFZXVD?=
 =?utf-8?B?ZElHVnJ3QXh5VnhvR05rVHhWYUtPamFOT1dFMUZFa0dMeVovTXNjK3U2cHFY?=
 =?utf-8?B?a1ZucXAzTGNDci9ERk4yeWNteGJ2SHhVN2RvRDdHaTNiZkY0cnVzbkNmcHhJ?=
 =?utf-8?B?bnZnNDU4dTU2Qlg2MXR5dnk3b0NCNDBSZE5JMUFkOVIzNzBRWGRucFBYaTVo?=
 =?utf-8?Q?12Fs=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:24:28.3979 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b78cab47-ca15-40a6-e638-08de283821ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8070
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
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c    | 154 +++++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h    |  16 ++++
 hw/arm/smmuv3-internal.h |   3 +
 hw/arm/trace-events      |   4 +
 include/hw/arm/smmuv3.h  |   1 +
 5 files changed, 178 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index bd4a7dbde1..4dd56a8e65 100644
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
@@ -43,6 +45,156 @@ static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
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
+    struct iommu_hwpt_arm_smmuv3 bypass_data = {
+        .ste = { SMMU_STE_CFG_BYPASS | SMMU_STE_VALID, 0x0ULL },
+    };
+    struct iommu_hwpt_arm_smmuv3 abort_data = {
+        .ste = { SMMU_STE_VALID, 0x0ULL },
+    };
+    uint32_t s2_hwpt_id = idev->hwpt_id;
+    uint32_t viommu_id, hwpt_id;
+    SMMUv3AccelState *accel;
+
+    if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
+                                      IOMMU_VIOMMU_TYPE_ARM_SMMUV3,
+                                      s2_hwpt_id, &viommu_id, errp)) {
+        return false;
+    }
+
+    accel = g_new0(SMMUv3AccelState, 1);
+    accel->viommu.viommu_id = viommu_id;
+    accel->viommu.s2_hwpt_id = s2_hwpt_id;
+    accel->viommu.iommufd = idev->iommufd;
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
+    s->s_accel = accel;
+    return true;
+
+free_bypass_hwpt:
+    iommufd_backend_free_id(idev->iommufd, accel->bypass_hwpt_id);
+free_abort_hwpt:
+    iommufd_backend_free_id(idev->iommufd, accel->abort_hwpt_id);
+free_viommu:
+    iommufd_backend_free_id(idev->iommufd, accel->viommu.viommu_id);
+    g_free(accel);
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
+    if (s->s_accel) {
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
+    SMMUv3State *s = ARM_SMMUV3(bs);
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
+        iommufd_backend_free_id(accel->viommu.iommufd, accel->bypass_hwpt_id);
+        iommufd_backend_free_id(accel->viommu.iommufd, accel->abort_hwpt_id);
+        iommufd_backend_free_id(accel->viommu.iommufd, accel->viommu.viommu_id);
+        g_free(accel);
+        s->s_accel = NULL;
+    }
+}
+
 /*
  * Only allow PCIe bridges, pxb-pcie roots, and GPEX roots so vfio-pci
  * endpoints can sit downstream. Accelerated SMMUv3 requires a vfio-pci
@@ -145,6 +297,8 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
     .supports_address_space = smmuv3_accel_supports_as,
     .get_address_space = smmuv3_accel_find_add_as,
     .get_viommu_flags = smmuv3_accel_get_viommu_flags,
+    .set_iommu_device = smmuv3_accel_set_iommu_device,
+    .unset_iommu_device = smmuv3_accel_unset_iommu_device,
 };
 
 static void smmuv3_accel_as_init(SMMUv3State *s)
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 0dc6b00d35..c72605caab 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -10,10 +10,26 @@
 #define HW_ARM_SMMUV3_ACCEL_H
 
 #include "hw/arm/smmu-common.h"
+#include "system/iommufd.h"
+#include <linux/iommufd.h>
 #include CONFIG_DEVICES
 
+/*
+ * Represents an accelerated SMMU instance backed by an iommufd vIOMMU object.
+ * Holds bypass and abort proxy HWPT IDs used for device attachment.
+ */
+typedef struct SMMUv3AccelState {
+    IOMMUFDViommu viommu;
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
index b6b7399347..81212a58f1 100644
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


