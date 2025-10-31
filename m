Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0031ECCF9FE
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 10:53:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEmkG-0002gr-Fl; Fri, 31 Oct 2025 06:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmkD-0002gD-Rz; Fri, 31 Oct 2025 06:52:33 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmk8-0002sl-3I; Fri, 31 Oct 2025 06:52:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMU0obeCso7RqsyM3dfJ7lkyDhCoFxE9rCDidu7JEHATcKInhufkzrksTB7tiOkmuNFqSRO6k1ZQWBBJNsXSqXQnFCmALAfXd4I+dR8aKYh8iDW4caoNEWnJhHdF05TNzlilOT34jH8ey+s6A8pFDo4+bb9jgWyPKFUKRFgZrBu/z6jf3QbDeBibxrmMGaVlu2gpZ964yH1KnfpyTqSUExhP/nW5diiHxJN037NwOat3SE4V94CV0Ntzt1hYK3tfzs5e6KQkzBJHNuq1EF6GUAfXR6zvCn0ytCu86Q4006Dgr3IVxfrrY2aiyIf8XbRZJp7mxE2qcoTLhxJp16vBjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDAUD71vCbGpTxf56C5+XG1rvj25h8GtBem7HGhLNCQ=;
 b=WE5lV/UrKRFZEYCIS8+8c7SGLECYmdvSHsmcFESONQFuf14i/kX0+fPm0rMqU5uLy1NjeeTYkM/KVSbjHiqRJaFvJhA7GEbPTxa7ToD6JgMESYJDJsnmROm6dMHgmGkF/OS9d149XqtHowQsgYqjWaZsAWzx6EdM8R+pU+yVKWBkWyTAfKxK7Gv2qtDFYL4a1b4YZoZ3ArFS/9zK9Hx665jv6Eesq+Mx5mvI3pz/VQu1Dc94P83+/qVGcHWptZLZZIT8co0Bum5MW99mI7XXUeztp1ODLkGUnoqNmv7QpAIe5aR0rLH5dOHdp1l57E+1WM1XP53r50ut7/0EC9TCOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDAUD71vCbGpTxf56C5+XG1rvj25h8GtBem7HGhLNCQ=;
 b=aByO0L6lODwozs5XVFsPASE5fUw2naELdkrBJw1ko3LaRE2IeV3qE0CWsJ9R3klzOgcPtN5bKbpZfmt4UPfOWoFzfDBDVwXhsHkkL8VOwYyx2z3wYFoxE21j11jIphMjzZAK1+SjZTSWLZlhGRDUjcKC+RX9vG8pGFn9irevYNm627DE8O35ok8lSW6ysQXNloVxN8O2vZixPB4OAGcW0ikfPbZiM8YBD3jHL6z71IfRFE6Gv0j2OEeffMz1w96UL94k0tR7r9tGTdjyTjUPsOIU3WhkRqCQEE9AmU5TTQJyuGhOrGfmtyFlLyv8OgnGfFGes885ySCmy+pvt9WgSw==
Received: from SJ0PR03CA0223.namprd03.prod.outlook.com (2603:10b6:a03:39f::18)
 by CH3PR12MB9396.namprd12.prod.outlook.com (2603:10b6:610:1d0::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 10:52:15 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a03:39f:cafe::f8) by SJ0PR03CA0223.outlook.office365.com
 (2603:10b6:a03:39f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 10:52:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 10:52:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 31 Oct
 2025 03:52:07 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:52:04 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v5 00/32] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
Date: Fri, 31 Oct 2025 10:49:33 +0000
Message-ID: <20251031105005.24618-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|CH3PR12MB9396:EE_
X-MS-Office365-Filtering-Correlation-Id: 55d18652-cb0b-4466-e935-08de186b8d70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|7416014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkRuZWZJTTdLUFVhc3NFc2FnUGZQYnJlR3FOTWtIeTYyRTFML2NFVWlzSEc2?=
 =?utf-8?B?SE12d01td1YvMzFUSEFJWHJxSXA3ZUl2SUdtVldNRG1XSGh5aFZldnRRcCtq?=
 =?utf-8?B?a1B6WjdhUEwxOVc4bElaanhGWTVQZWpaR1FWUG1OeldtaW14MnpFTUViY0gz?=
 =?utf-8?B?SkRIa1R1UWtodDNBTm0yd1NtellkR3RqNEF4K3JOUlY0T2FVZzBybldDRnNl?=
 =?utf-8?B?SHQ0b1NjNnFQTHBibllleHBBVGhYdkZzNzdpZzB1ZDN4bllMeWFhZy9ab2JL?=
 =?utf-8?B?elMwUHh1VXRMcERmdlN5RVhXdFVMb1M1V0N6b2ZsVmgwWGd4VkYxOFRROHZU?=
 =?utf-8?B?aHduN3hlOHJOYlZMNWJ4a3phVnQvNGNocWgxaTJVZUtydTY4bzZRNHJjbzR3?=
 =?utf-8?B?dS92eitTM00wdGE5VVVsVldCSkxqWm5HVFVyZ0RUTjYwSUVNZVQ3c1k0dHlu?=
 =?utf-8?B?Y1VtK29Bb2VHRi91TTVuMVpoVWJFNEZhQkVCZUZ2aXJjR2Q3K1liRVQraEhX?=
 =?utf-8?B?N01GMituZXV4TEVEMTNxUCtFSHordXp2R0R5NFB3WDNCblZIajJXSGViZkRX?=
 =?utf-8?B?Q0xhdXBsNDhWaFV5YnM4eFFHL0RUOXNLYi81SjhZTzdkS3U2WmxqZDJjczhh?=
 =?utf-8?B?VXFkWUxXeE1mQ0Fock1jQ3ZEWlJxKzJQV2c3TzFqOCs0UXV3VnRSV0wzS2R1?=
 =?utf-8?B?b09zd1RJNDJhVW54TjVzSXBWeGhUL1pucXN5UFZKWks2YVZHcGpSMFBlV0FI?=
 =?utf-8?B?RTdYZStDbFhjRHowaHBEVnlXb3MzYzFKYVRNdm5icXpLNjQ5alNoUm0yNzdw?=
 =?utf-8?B?SUdmdXZNdzh1dEl6VVZKcnA1OXgvb21VWEdLZWdWWDZlQkU5UVUxQS96eEVV?=
 =?utf-8?B?S3pZZHd3bGx3ZUx2L3JDbUJtRTRpQWVZdmN1eUdWTkU2d0p1WFVIQUdjaXh6?=
 =?utf-8?B?NjlzRXkrTFRHUTVaYXZBMjVwQkJPeHJiMEIvdXljS2dJOWFhVThua2ljVmFN?=
 =?utf-8?B?VHgrK3g4NEhCUzIxdVZXb1BQYkt5ZHQzYmUzTkpnRlpxRTE0bWkwemJQc25o?=
 =?utf-8?B?K3VBVlU2bzJUazA5SmNoWjFKc2FHaXo5UkQ1TVhnSm1JUTg3MVNUWlF5MGlL?=
 =?utf-8?B?bkQ4dkZiY2lud04wVnk2bnpFSU1xSDFNZ1ViZ2gwekNFNnVkOU9ycUMrYWdp?=
 =?utf-8?B?UzJQb0YzM2R5TWhhSEpMS0FzR2N5MEhkaVY4MU16NWEzQ1VCekdWS2U3ZGNj?=
 =?utf-8?B?TEpvWW82a3IrU043UUdwZEF4TUxvYWhyd0RZVUNnYWJpZThmbUR5bnd3WDZk?=
 =?utf-8?B?N2xUMFJWTGZXS0VwNjkzODBNRExKUDMzZVg3dTVIMGx4bEJhWVRJeXdyR0hT?=
 =?utf-8?B?aDRLMlh6WXJPYmFwRU8yL2VuSnB3REszaWRJMmU3Sm5EU2UyRHE2aGY2cm4v?=
 =?utf-8?B?YVBEdUEwSFNwMEY5K29VbDBWSUFZdFBoQi9CS0RnRU9MQmFRRzl4bW9jNWVD?=
 =?utf-8?B?alU1bktnenhnNC9YTmoxNnpOa2gxTGJlUHR3N3labTRzYXE5OG9Qak9qTUZV?=
 =?utf-8?B?RWVRc2RJY3Yzd3B1VytqaFMvR00xK21OMVgxSnBQbjBaNy9HTk5FUU1PVHFR?=
 =?utf-8?B?bG5JZTYxZzZKWWhHbnk5VUtCWll6cTQ2MkZRdS9rVkMwMS85SnQxcWIwNHJU?=
 =?utf-8?B?ZFhaUklFQTVHOXk2UGUxNE1WUXN5NTVaVDFPYlN5WHBidCtCbitYMjkveE44?=
 =?utf-8?B?YitJZnh2K3lSVkh4UHgvNCtLT0QwbGhaVlg2SktibEFMUTZzNTVWYmNCMEpQ?=
 =?utf-8?B?V2c3cTkzQlRFdzdZZnR6cnFWRjVFajltOUxjc1ArRFBRSGhpL0hXRXBSVTl2?=
 =?utf-8?B?d2tqdTh6ajRKMVQ0WW1LT0hnVmhRRWtMTExHTVNEN3VjZTRDOThqS1hxZTEw?=
 =?utf-8?B?VG9jUk1ZeW1uWFcrZElYNk8xNnNCZkJ2b0wwYTFETXF2U1F1V003MTdtaUxy?=
 =?utf-8?B?YTY1UnlmT3hZYjNMUU5xOTlPcVNkd0N6dHF6cGhkbFBjQ1pQbURQTnhYQ0lo?=
 =?utf-8?B?dDY2YTQrbmRTaXM2NUFGY05DTVFsTEUwS0lDUUs5SkNHWVpLVnFkOVpRTkt1?=
 =?utf-8?Q?Nf+eqZiPpFzX7JAcrIWqXHz/f?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:52:14.5604 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d18652-cb0b-4466-e935-08de186b8d70
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9396
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
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

Hi,

Changes from v4:
  https://lore.kernel.org/qemu-devel/20250929133643.38961-1-skolothumtho@nvidia.com/

 - Addressed feedback from v4 and picked up R-by and T-by tags.
   Thanks to all!
 - Split out the _DSM fix into a separate mini series which has
   already been sent out [0].
 - Introduced a global shared address space aliasing to the system
   address space instead of directly using "address_space_memory" in the
   get_address_space() callback(patch #6).
 - Fixed pci_find_device() returning NULL in the get_address_space()
   path (Patch #7).
 - Introduced an optional supports_address_space() callback for
   rejecting devices attached to a vIOMMU (Patch #8). This allows us
   to reject emulated endpoints when using SMMUv3 with accel=on.
 - Added BIOS table tests for the IORT revision change.
 - Added support to install vSTE based on SMMUv3 GBPA (Patch #14).
 - Factored out ID register initialization from the reset path so
   that it can be used early in the SMMUv3 accel path for HW
   compatibility checks (Patch #18).
 - GBPA-based vSTE update depends on Nicolin's kernel patch [1].
 - VFIO/IOMMUFD has dependency on Zhenzhong's patches: 4/5/8 from the
   pass-through support series [3].

PATCH organization:
 1–25: Enables accelerated SMMUv3 with features based on default QEMU SMMUv3,
       including IORT RMR based MSI support.
 26–28: Adds options for specifying RIL, ATS, and OAS features.
 29–32: Adds PASID support, including VFIO changes.

Tests:
Performed basic sanity tests on an NVIDIA GRACE platform with GPU device
assignments. A CUDA test application was used to verify the SVA use case.
Further tests are always welcome.

Eg: Qemu Cmd line:

qemu-system-aarch64 -machine virt,gic-version=3,highmem-mmio-size=2T \
-cpu host -smp cpus=4 -m size=16G,slots=2,maxmem=66G -nographic \
-bios QEMU_EFI.fd -object iommufd,id=iommufd0 -enable-kvm \
-object memory-backend-ram,size=8G,id=m0 \
-object memory-backend-ram,size=8G,id=m1 \
-numa node,memdev=m0,cpus=0-3,nodeid=0 -numa node,memdev=m1,nodeid=1 \
-numa node,nodeid=2 -numa node,nodeid=3 -numa node,nodeid=4 -numa node,nodeid=5 \
-numa node,nodeid=6 -numa node,nodeid=7 -numa node,nodeid=8 -numa node,nodeid=9 \
-device pxb-pcie,id=pcie.1,bus_nr=1,bus=pcie.0 \
-device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.0,accel=on,ats=on,ril=off,pasid=on,oas=48 \
-device pcie-root-port,id=pcie.port1,bus=pcie.1,chassis=1,pref64-reserve=512G,id=dev0 \
-device vfio-pci,host=0019:06:00.0,rombar=0,id=dev0,iommufd=iommufd0,bus=pcie.port1 \
-object acpi-generic-initiator,id=gi0,pci-dev=dev0,node=2 \
...
-object acpi-generic-initiator,id=gi7,pci-dev=dev0,node=9 \
-device pxb-pcie,id=pcie.2,bus_nr=8,bus=pcie.0 \
-device arm-smmuv3,primary-bus=pcie.2,id=smmuv3.1,accel=on,ats=on,ril=off,pasid=on \
-device pcie-root-port,id=pcie.port2,bus=pcie.2,chassis=2,pref64-reserve=512G \
-device vfio-pci,host=0018:06:00.0,rombar=0,id=dev1,iommufd=iommufd0,bus=pcie.port2 \
-device virtio-blk-device,drive=fs \
-drive file=image.qcow2,index=0,media=disk,format=qcow2,if=none,id=fs \
-net none \
-nographic

A complete branch can be found here,
https://github.com/shamiali2008/qemu-master master-smmuv3-accel-v5

Please take a look and let me know your feedback.

Thanks,
Shameer

[0] https://lore.kernel.org/qemu-devel/20251022080639.243965-1-skolothumtho@nvidia.com/
[1] https://lore.kernel.org/linux-iommu/20251024040551.1711281-1-nicolinc@nvidia.com/
[2] https://lore.kernel.org/qemu-devel/20251024084349.102322-1-zhenzhong.duan@intel.com/

Details from RFCv3 Cover letter:
-------------------------------
https://lore.kernel.org/qemu-devel/20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com/

This patch series introduces initial support for a user-creatable,
accelerated SMMUv3 device (-device arm-smmuv3,accel=on) in QEMU.

This is based on the user-creatable SMMUv3 device series [0].

Why this is needed:

On ARM, to enable vfio-pci pass-through devices in a VM, the host SMMUv3
must be set up in nested translation mode (Stage 1 + Stage 2), with
Stage 1 (S1) controlled by the guest and Stage 2 (S2) managed by the host.

This series introduces an optional accel property for the SMMUv3 device,
indicating that the guest will try to leverage host SMMUv3 features for
acceleration. By default, enabling accel configures the host SMMUv3 in
nested mode to support vfio-pci pass-through.

This new accelerated, user-creatable SMMUv3 device lets you:

 -Set up a VM with multiple SMMUv3s, each tied to a different physical SMMUv3
  on the host. Typically, you’d have multiple PCIe PXB root complexes in the
  VM (one per virtual NUMA node), and each of them can have its own SMMUv3.
  This setup mirrors the host's layout, where each NUMA node has its own
  SMMUv3, and helps build VMs that are more aligned with the host's NUMA
  topology.

 -The host–guest SMMUv3 association results in reduced invalidation broadcasts
  and lookups for devices behind different physical SMMUv3s.

 -Simplifies handling of host SMMUv3s with differing feature sets.

 -Lays the groundwork for additional capabilities like vCMDQ support.
-------------------------------

Eric Auger (2):
  hw/pci-host/gpex: Allow to generate preserve boot config DSM #5
  hw/arm/virt-acpi-build: Add IORT RMR regions to handle MSI nested
    binding

Nicolin Chen (4):
  backends/iommufd: Introduce iommufd_backend_alloc_viommu
  backends/iommufd: Introduce iommufd_backend_alloc_vdev
  hw/arm/smmuv3-accel: Add set/unset_iommu_device callback
  hw/arm/smmuv3-accel: Add nested vSTE install/uninstall support

Shameer Kolothum (25):
  hw/arm/smmu-common: Factor out common helper functions and export
  hw/arm/smmu-common: Make iommu ops part of SMMUState
  hw/arm/smmuv3-accel: Introduce smmuv3 accel device
  hw/arm/smmuv3-accel: Initialize shared system address space
  hw/pci/pci: Move pci_init_bus_master() after adding device to bus
  hw/pci/pci: Add optional supports_address_space() callback
  hw/pci-bridge/pci_expander_bridge: Move TYPE_PXB_PCIE_DEV to header
  hw/arm/smmuv3-accel: Restrict accelerated SMMUv3 to vfio-pci endpoints
    with iommufd
  hw/arm/smmuv3: Implement get_viommu_cap() callback
  hw/arm/smmuv3-accel: Install SMMUv3 GBPA based hwpt
  hw/pci/pci: Introduce optional get_msi_address_space() callback
  hw/arm/smmuv3-accel: Make use of get_msi_address_space() callback
  hw/arm/smmuv3-accel: Add support to issue invalidation cmd to host
  hw/arm/smmuv3: Initialize ID registers early during realize()
  hw/arm/smmuv3-accel: Get host SMMUv3 hw info and validate
  hw/arm/virt: Set PCI preserve_config for accel SMMUv3
  tests/qtest/bios-tables-test: Prepare for IORT revison upgrade
  tests/qtest/bios-tables-test: Update IORT blobs after revision upgrade
  hw/arm/smmuv3: Add accel property for SMMUv3 device
  hw/arm/smmuv3-accel: Add a property to specify RIL support
  hw/arm/smmuv3-accel: Add support for ATS
  hw/arm/smmuv3-accel: Add property to specify OAS bits
  backends/iommufd: Retrieve PASID width from
    iommufd_backend_get_device_info()
  Extend get_cap() callback to support PASID
  hw/arm/smmuv3-accel: Add support for PASID enable

Yi Liu (1):
  vfio: Synthesize vPASID capability to VM

 backends/iommufd.c                            |  77 +-
 backends/trace-events                         |   2 +
 hw/arm/Kconfig                                |   5 +
 hw/arm/meson.build                            |   3 +-
 hw/arm/smmu-common.c                          |  51 +-
 hw/arm/smmuv3-accel.c                         | 763 ++++++++++++++++++
 hw/arm/smmuv3-accel.h                         |  92 +++
 hw/arm/smmuv3-internal.h                      |  29 +-
 hw/arm/smmuv3.c                               | 161 +++-
 hw/arm/trace-events                           |   6 +
 hw/arm/virt-acpi-build.c                      | 128 ++-
 hw/arm/virt.c                                 |  31 +-
 hw/i386/intel_iommu.c                         |   5 +-
 hw/pci-bridge/pci_expander_bridge.c           |   1 -
 hw/pci-host/gpex-acpi.c                       |  29 +-
 hw/pci/pci.c                                  |  44 +-
 hw/vfio/container-legacy.c                    |   8 +-
 hw/vfio/iommufd.c                             |   7 +-
 hw/vfio/pci.c                                 |  37 +
 include/hw/arm/smmu-common.h                  |   7 +
 include/hw/arm/smmuv3.h                       |   9 +
 include/hw/arm/virt.h                         |   1 +
 include/hw/iommu.h                            |   1 +
 include/hw/pci-host/gpex.h                    |   1 +
 include/hw/pci/pci.h                          |  33 +
 include/hw/pci/pci_bridge.h                   |   1 +
 include/system/host_iommu_device.h            |  17 +-
 include/system/iommufd.h                      |  29 +-
 target/arm/kvm.c                              |   2 +-
 tests/data/acpi/aarch64/virt/IORT             | Bin 128 -> 128 bytes
 tests/data/acpi/aarch64/virt/IORT.its_off     | Bin 172 -> 172 bytes
 tests/data/acpi/aarch64/virt/IORT.smmuv3-dev  | Bin 364 -> 364 bytes
 .../data/acpi/aarch64/virt/IORT.smmuv3-legacy | Bin 276 -> 276 bytes
 33 files changed, 1506 insertions(+), 74 deletions(-)
 create mode 100644 hw/arm/smmuv3-accel.c
 create mode 100644 hw/arm/smmuv3-accel.h

-- 
2.43.0


