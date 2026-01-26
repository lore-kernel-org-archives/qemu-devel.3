Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C33CF65D5
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 10:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkK7L-0000pL-6k; Mon, 26 Jan 2026 05:46:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK6R-0007Ol-Ui; Mon, 26 Jan 2026 05:46:05 -0500
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK6P-0005ZU-UB; Mon, 26 Jan 2026 05:45:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OolpbJnDBgraDhjebVa0IwQ32vriKuYofgdfzjMUPsSrhjbGqNVkynvZcM/FELC1IOKspQrGIX4vLwHLkMKLwx6SHxaudw+t0f95EaJtVmBZMbSzstfO8Jw/0zWSBJ3/RFZZLItOQqZzK0RCYEEmPJ455xhv6F7tvSSmMYCrIJS77DSqk/Jt4t0PBgMKgv7YnHZefUptNzpuIzHxlAitbwWFaNbCjAJCK4hkxjctMIVoSrmRsmrmckbwxOeUs+4Pc0OvAMxvdJqQtsGkch29w6nevKFvABuGm+WIGMmpl26rBzvNlfyz/wiAj6TuubBs14iLxhb4xzxKSxfLyTqGrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKCfcHUMLySaKP0i4PoaBiQ/Ox+j/JOGjVfgCM+heNM=;
 b=rEW4mRHg2157aL3vcdvIda8GjeVS2fyQGJ++gHbn243OukazCXv/eT3k/3khi7Q19Yb35AcB7aZOAREBiOzqlPHBOQ2xF6E4mQ4NufWdb1HTgcUq+Ej9Cs/kX7cM7VxtqWtqiXgFq3z2rz68QAd0KEZ9mTJAkAibJAidVt9INmA/9TRZi8PW32letUH85zxkVCzRFkKFznvYcRUQXHWGRejX8Wf+CmM8XVtrsYIrIKJBHsAavqmKA7f0J355IFzzsryw9IO1X6eENaMm/ayoG86DsQ67BmbXkt4hKoe1gvSMZspWmcAyOxI0t5/6K34PCJGypNJhwoPu1qbCkKqTww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKCfcHUMLySaKP0i4PoaBiQ/Ox+j/JOGjVfgCM+heNM=;
 b=de7Mz7vwioRO/B2+Sv/8rwFTc3ie1LbY3y3d0YQPfNe6UwjX/hJGul1PxF7jpvjXIMowoZ4Pv80ZVO0AOU5VI/PZ8U/vDsvKc3oQezxyaauPfXreaLnGosTVx6ngWDmXoV5OXkOPBAMvcMHtsjmOYVb1xGgBwo2aClMor+gYVSmI6rAR7cmTmaqhEZINEaO5WtL5DYpaIu2lOdtp36to/jmuxExL8Xp86uu4ijDA/dyaq17lEHhQBGCDttybNPHYoBcFaOZqNNMZ5KPF8TJKt1zGGF4rfC9pWsUStSZbneb88wa0DoOaPI0Ob820ge1IfVBPuYKqsVg1b4hfIJU5tg==
Received: from SJ2PR07CA0015.namprd07.prod.outlook.com (2603:10b6:a03:505::28)
 by DM6PR12MB4187.namprd12.prod.outlook.com (2603:10b6:5:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 10:45:40 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:a03:505:cafe::68) by SJ2PR07CA0015.outlook.office365.com
 (2603:10b6:a03:505::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Mon,
 26 Jan 2026 10:45:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Mon, 26 Jan 2026 10:45:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:45:27 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:45:23 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v9 12/37] hw/arm/smmuv3-accel: Add set/unset_iommu_device
 callback
Date: Mon, 26 Jan 2026 10:43:09 +0000
Message-ID: <20260126104342.253965-13-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126104342.253965-1-skolothumtho@nvidia.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|DM6PR12MB4187:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e076fa9-4566-465e-5916-08de5cc80bf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWJPQmhvV3NJQnd4cjg3K1diaUxyZkJXT0Fzb1V4bmQ2WFJvMmMrbnIzQnVx?=
 =?utf-8?B?WnRVbHNsamhRK25EWUZ3R0FoUUNsd3lJbHNCUVlGOGlUUGg0WUdSSC91U042?=
 =?utf-8?B?cWhtUVBEYjlUajdZWnNZcjhQRSt0WjFCTzU5c0RZVGorQXlyQm14ckIzUDJ6?=
 =?utf-8?B?S3dVRjBQajRkcStnTW5zZk05clp3ZklSZFFlZmdxWVBXYlFuVTB6QTdhNm9Z?=
 =?utf-8?B?eTdDTVQyZXU3QjN2NlQreUM0Tm54NjZlZStYZjcyazhnRG1pNkFJa2xqWENO?=
 =?utf-8?B?OXdmb2pwM2krOXBxWTdmRGJPdk9tTkN1Q3BEeWhnRDNmYWd1NWsrOTVYTjRi?=
 =?utf-8?B?QzlydGU0Vm5BbUg1UjhDRnUyNjZiVjBCYjllakUxN2dSaElTbFdaQkxpazBm?=
 =?utf-8?B?TUpsbmJGbE1NVFhyVWZGUWMrY3hJTXU0MmlsU1Q5UDNRbkc4WXhucnVvQ0hN?=
 =?utf-8?B?V0V5cEJNTER4dSt3Mkd0YkFCRC80dFNyYXF3b0E4WU05bWtKVUY3TWxVSEMy?=
 =?utf-8?B?NHNpZy9wRmx3TEFNRCtlMGtvVW53SHZhclRYS3ZhSXZuN1lmOWlWbEVzRStC?=
 =?utf-8?B?M0VHQ1drMWxwaXVwelJkK2VveXNDNWxuRXUxRDNFUkdTR09pTzNhRFpLYzRQ?=
 =?utf-8?B?SGVEVlZ3d0tyeXFxREcvbmxUd0lEdVZhcjgrUnVTK2FtMEtOWFhDTlBNSXAy?=
 =?utf-8?B?VDlodUd2aTFpUHFOQ2QydHk4OFdWUitwWVd2RHVYQjNNR0RUMnVvdjJmK01k?=
 =?utf-8?B?b3o3UnNaV1p6YkoxZ1lzOEpKUGxIcmYrTXZDOVhROVFNZU40QWQ2UitRdUdz?=
 =?utf-8?B?U1BFT0NOZDJYdTZ3TVBTRFp2VlRaNzg1bHQ4NDhuUGUxZFZtanhLYWRjY2ds?=
 =?utf-8?B?Yklvb2o2aGxtMHR6VXR4aWY0d05sRXI2WWhFMzZwK1JUUVNPa0lYdjRNUnM0?=
 =?utf-8?B?TlJyQzRTK3A5QWVHcFZjUDBXYWx1MXFoM0hFVmswZ3pFU0dEVjlhdy9ZN0RY?=
 =?utf-8?B?ZXJTSjlqaUNUTzUzRXJnQk1UVEM0dW9TaVZSV2M1bUFKRmt2WjA5Ym55OFNL?=
 =?utf-8?B?YkZhLzJPSjRjUHVhellENks3ZHNZN1dzRjNBY0FhUkxFZ21iT2FLNW5kSUJG?=
 =?utf-8?B?cWx3dkptc0UxK21xbThMUnhKT3d5MmUybHhENWZIU01NTlNOcnBoMGZDem9k?=
 =?utf-8?B?ZkFGZEprZUZHMEUvcXVhZ2lpUFZpcmMrdUFJWUw3Rk9IY0hrSm05Z0NBQ2ha?=
 =?utf-8?B?ZFN2UWJ4a0N1dlpzUWtPR3RrOHBYd0l5NEJYQzdVMDJDOHprbFRQOFFZMVFn?=
 =?utf-8?B?OXVaWkp0Z1dnZDBJQ2lMUDIrWlgwTUpZemFTb0czaWRRK01uU0Rrd3IyQWZu?=
 =?utf-8?B?d0hkQkNQZFhqSDhua0Zyc2RaY0hRM2kwWFJDYjJYaVNsdzMwMmVGZm8waFFn?=
 =?utf-8?B?YmdlYU4yakdTcnRQaWVPSStxWDcreDZuSjlDVllqeTBuWjBoUWowWGtXRnlB?=
 =?utf-8?B?Znc0eXcwN2I0blh1Uk9RbjRTUnVpdDlUSFNzTlVGOWlkRUUrK2VxaVdEVVM4?=
 =?utf-8?B?Q3FZNDNOZlpQeWVuZ21DK1AzcTkvWi9WY0w5WmdBbDEwVENtcE9Ua1BoeFUv?=
 =?utf-8?B?UHFCWHlWV1NLdmVzb3d6Qzdoa2RFdG9XaG1mMFVWcVJWblNZK0doL1NFQndk?=
 =?utf-8?B?SXVSQ29EL1hUWkV3Q1J5QUl6YVh2by9uMEhPaUpEWGhwNUtoY1NDT1VDVVJE?=
 =?utf-8?B?aFFOL3UyN2lkTjNkbHlLbWNEajVmUGZFekxiUG5VVUZSYWZTVDNtaG1xT2Nw?=
 =?utf-8?B?MDdCK2tnQ0c5VU8wTlhYS053dTh1cHllMTRvR3VjaEg2d2tic050NUdYZEly?=
 =?utf-8?B?UVgwbGsxcDdlSzAwRjcyTm8xU2doZmErbkxwcW1ndEcxRzRweit1OHFxdjdl?=
 =?utf-8?B?SW11RUIzdFltSzFkTjZnQ09RaE1CaHJwdDlSZFNoQjRqSWUzdmRDNG1VeGlN?=
 =?utf-8?B?OEhJeklraks1Z1FubW1SRmlUR20wODRmcjJZR2tJN090amdqeDE5R0FhWTNY?=
 =?utf-8?B?bVRMZ1NJL0N0RDdIbzA0d0FqdEJQMHhFanlvZnRlZjZJZTZLODNnK1ZkdzJq?=
 =?utf-8?B?S1JNK0NTZTh5TGpIelgxNThHOGpTSlIwbWRNSlNxb0pROTdwQ1IxeStqeldS?=
 =?utf-8?B?TzQvM0wvTzkzQVZvZ05rdDFmbURYa3puZExLT29xazRPQnZGQjZvaDkwSytk?=
 =?utf-8?B?YmFnOGsxL1pEVkl6ejdtc1JJdkpBPT0=?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:45:39.6216 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e076fa9-4566-465e-5916-08de5cc80bf1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4187
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.587, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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


