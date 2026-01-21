Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A19C44508
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 17:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vicRt-0001Xg-1b; Wed, 21 Jan 2026 12:56:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicRS-0000cm-8d; Wed, 21 Jan 2026 12:56:30 -0500
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicRQ-00018n-7f; Wed, 21 Jan 2026 12:56:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZO920UAd4xtj/JxZhVDgxwKQs2FqF7nONnw94mGhJX1t7prkXrLvPUMIpW7mBRN4DoR50rZ5BLNqYfErRduiT4UwguEAcbFal3gdQTqgR9vlh7l5yTZoe4rTm0/6669+lLoYsemOmRdyWNbfzn/do4joiaM7Bj/8mXw0xRoDPlxmbL2HWw6BNIuf6/yrSdfAk+wMqvh9dlAuCFpGusXfUiwUUGwhwuY/UPsGwBanpUmndxNnZVKlWEx3+beVZVLjpx9nZhVwQCcfMO1iBVsQXZwXoXj8zxZgoNcd9fjAVR/kxrQsdXxli9MvDyxInQqFcVmGWYxD+t1CGOytPYy7qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKCfcHUMLySaKP0i4PoaBiQ/Ox+j/JOGjVfgCM+heNM=;
 b=PNjoUKcuFOshHjyE3XrQ75G3sWP/tBdI4woxisSZCfDxxlqoTbgXJHZF2NcuPBclRY7C0ryw5cBQ6HaUjE/R74MeUpzk3GXHujQW2uauQLazNeGb+xXQKpXpKjz1d9t/CMjAXF1vWStkMBeDg3fiq/Q3+BIPiGsS2U8KVmV9fg6IksmClcZQQv4pYXaPymrEaUiNX4Xnckqn4uW68g/3Us0Nq2p1c0hBxK0pS4yJzrhaDF/CHXHsJ7SVavb4Kti/br/Kl1np+Fl6P/l2O/EADkhUjrvK68M9U9//R00gYrBa0p8OXl07ubU/7ZE5L4ULlXri0bA3YNPjnKkrlluWvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKCfcHUMLySaKP0i4PoaBiQ/Ox+j/JOGjVfgCM+heNM=;
 b=huqhf566x1qi7mi0G4l58dL5roWOrAKtxwf3XBt3JTMULAaZbwApOPNDnRuAQrNB0tNt91Ghe9JL8TwWPDAun5YqccEykNYsjhC7efFCQ13T6o2bloabU3AjTF1EB3QTw+ySU7sqJcAXyXZsLk7hbXw8QOLZ9owfMC+vKawVOR1jF0uuSLni03ZUIt/RrkLmeBkd6SIhD9Y0WhYMVHjHpuPT1fvru8gPTaGCXjclHcH9tdnxMLuQ7Evao6hZOBotIs9Attebppd98EF1d67BT+pWpnJc+KSBbz+Vac63Xp5COcA3x9/5aBGWyIhwc68JzwTu/Bw+jmjQhHyT9dSemQ==
Received: from SJ0PR13CA0030.namprd13.prod.outlook.com (2603:10b6:a03:2c0::35)
 by DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Wed, 21 Jan
 2026 17:56:21 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::2c) by SJ0PR13CA0030.outlook.office365.com
 (2603:10b6:a03:2c0::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 17:56:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 17:56:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:56:00 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:55:55 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v8 12/37] hw/arm/smmuv3-accel: Add set/unset_iommu_device
 callback
Date: Wed, 21 Jan 2026 17:52:17 +0000
Message-ID: <20260121175248.87649-13-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|DM6PR12MB4140:EE_
X-MS-Office365-Filtering-Correlation-Id: d13a238d-1fb2-4ccd-aff7-08de59166201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEs5RS9xOGUrazdtcWdRN0VEUXp6S3BKWjhIa05teGZJSUIzcDZwUXkxRzVp?=
 =?utf-8?B?cFlvbTE3M2NzWnhjMjl3K3VFb1NHd1dhZjZlV25nSmlpa050Tk13anZCKzR2?=
 =?utf-8?B?cTRGRWw1ZXc1ZEtlTjlrM0UxQlJ6ZHhLRGFrSEtPeDZWWTQyc0hZOVhqRjFE?=
 =?utf-8?B?bk9MUmVJeUpWTGRRbFZhRi8zV25JLzE4c21UT2RLM2VPS1c2cEJaQXVhY2Fp?=
 =?utf-8?B?T1QwK04wbGFIcnYrSDlTZzhST3Z5blFEa1JvcG8ycGRyR202cm5Ca3R6VlhK?=
 =?utf-8?B?NGNxenNsQjhTY0FITzdEVDNYSHBaY29ib3R1SnB5UlpvZDNZdGtvWjFhTm9y?=
 =?utf-8?B?SU12aGNYSHZEZ0p1elYvcWZ2WkVmaC9ieFhNcVFNZXdxWGhvM1c1NXJMUmF2?=
 =?utf-8?B?MkpEOXM3VjFwS2pVM2FPUSt1MGowc3hmQ0MzMmdqVDRYTnVVQlloVTQxei9K?=
 =?utf-8?B?MFMyUkVXU3M5TFRBSTZMeFRaTDV4c2h6Um1RRHNjWFQrK1FlYVpOOUZZRGVx?=
 =?utf-8?B?NzVnZVVOWER2K3l2WjZCV1BXWStacXhBeE5Vbzh6NE14MFI1akpSOTNqMmpH?=
 =?utf-8?B?M2xUWVNrU1dWZ21GVkdieURBVHg2Nm45UmttYldJdStSQlhoZktQNDBkQUtS?=
 =?utf-8?B?RzRCR2ZtUXRFaVFhbU1YWEIvODdqRU9VQXB3Q1RldXJoekMySDdvQTZQdFgr?=
 =?utf-8?B?MnJFWkl0eUdROFlSQmtXZDJrMkhtc0JMaGtkWEk0eXFJR1lVckE2MU9JWDg5?=
 =?utf-8?B?ZkNINFVmR2Iyd2RzdVc2WHFWbldRSUhyWHJkS3lWZXpVRmlBUlZaMXRyNG5R?=
 =?utf-8?B?MXFRbWJQbDFic2lDMXZmdHNzNVVXa0l1S0pQUFU4RFJKZHNydXJIVXVmRGJF?=
 =?utf-8?B?NFBETVlHSlZaSHdac1lJZjZCY20xRUhoTTFBbmovVjdBZWZoMHBIOVh6TnZS?=
 =?utf-8?B?LzFlWFV4Zm9UVTRMalFLVFZIWGI0RFYwNWJzVU9BV2kyaXFwdzN5TTR4VXlq?=
 =?utf-8?B?KzcxZWQ0dnl5dENVWFRnSzJSVmxvR2RKTXU5a3kzbC9CdDJucHlycERmaVF2?=
 =?utf-8?B?dGFJc2cxcTlxUVJPbWVqSHo1QWhmaFI3L2QrLzRzK2d1SU0rZjVyYk1rRFJB?=
 =?utf-8?B?ZStmajRpSU9vSlJoTlJHenlmZzVueVBGcWRkbkVzSUFsVGpDK2IrZTR4eVV4?=
 =?utf-8?B?a2FIUjFCTTh2dDhmZ2ZXR3BuVzRVaDNDTW1BUVVoZmw1WUQvbnE5QkVnVVNu?=
 =?utf-8?B?OXlUaE0xWUF6YWp2TkE1VUl0UldCczJRRW85SzZ4VG4zREZDUnQ1b1JjMElt?=
 =?utf-8?B?dzNweFR0eGl1anFBaU81eXBRa3ZhNGw5OWdGRk91SERHczFyOXRNRmRqdXJL?=
 =?utf-8?B?Y1EvRGZYbU5sd0krWXA1UlJiOFUwU2JRWVBDTGtDN0RXdjlLWVRQSWFLb3Uy?=
 =?utf-8?B?SjYydTcvQlNMbWJpSWxmVUpLNytMT245N0s3YjFOZVVtZ0RzMmY1aVJya215?=
 =?utf-8?B?NVhiT0E5c2FHdTh6RlBXS1QxU2dhZmcvK0FMSzVGb1VmbS9NckYyRi9HOGl3?=
 =?utf-8?B?VU8xY05yeitEdkxWQkhaOHp4Q3J5NE82aDZ2RTk1TFFWYmVwRVRVeEhEL0dP?=
 =?utf-8?B?RDdNK0VHUTlOQUk4ODdVSDdMZjhwcU0xT3I3Qm0vTSsrblk2MFpNMnpxTnF1?=
 =?utf-8?B?bUU0UUtUemZ2MEIrSDU0VnhkQTJoSlQrZ3ZzcFZ0RS9xeDE3RUIweStoK3BW?=
 =?utf-8?B?ODY1Uks4Q0ZEUGI0NHBQN0w5YUdsNDVkYWFlZCtyOElVNHluaWRlNStGUVM3?=
 =?utf-8?B?OGY3cFIrZW5uN0FDeTFXa2FtaGFBVnlKai9uOFZmVjI4UEMzc3pIL0dwaVl1?=
 =?utf-8?B?bXhob3p3TFhMNk4vN1FRclR3RlQwSWcxWGdmN1JyeFIzVmY5ekYvWnY1eE5P?=
 =?utf-8?B?akNrVzFDWDhrZWhRSEZGbmpHS0xMTG5HODJXNHgyd3EyamIxZld5ZUVLUWZN?=
 =?utf-8?B?V205Y3V2T0FIL0dzTTZmclBsaGFqOElUYWh3WTFZTDl0dkpUMEhoUDNCRW9E?=
 =?utf-8?B?SkxiakdkRUJxVmRqQmd4d3NBUVZ1YWc1SG1SbDRHdGNiWmtUc0xqcGV0ZUVE?=
 =?utf-8?B?a213eXlmMTVrUi9rMTV1UzR6MkIzYXlyV09qbGNncVY4ajBvc3BUTVFnOG5w?=
 =?utf-8?B?KzlMZjdMaXVsMCs4SHh1TW9jUUVoN2NUY1pmbUJ2MHZGVWdCNDArNmJKZXc2?=
 =?utf-8?B?ckx6ZU8vSG1VbTN5Mi9GeWFVTjd3PT0=?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:56:20.1182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d13a238d-1fb2-4ccd-aff7-08de59166201
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4140
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c          | 156 +++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h          |  18 ++++
 hw/arm/trace-events            |   4 +
 include/hw/arm/smmuv3-common.h |   3 +
 include/hw/arm/smmuv3.h        |   1 +
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
diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3-common.h
index f644618f38..153310248d 100644
--- a/include/hw/arm/smmuv3-common.h
+++ b/include/hw/arm/smmuv3-common.h
@@ -100,6 +100,9 @@ REG32(STE_7, 28)
 #define STE_CFG_ABORT(config)      (!(config & 0x4))
 #define STE_CFG_BYPASS(config)     (config == 0x4)
 
+#define SMMU_STE_VALID      (1ULL << 0)
+#define SMMU_STE_CFG_BYPASS (1ULL << 3)
+
 /* Update STE fields */
 #define STE_SET_VALID(ste, v)                                                 \
     ((ste)->word[0] = FIELD_DP32((ste)->word[0], STE_0, VALID, (v)))
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


