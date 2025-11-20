Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE81CF8858
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 13:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM4dD-0005Z8-SC; Thu, 20 Nov 2025 08:23:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4d5-0005Yg-UR; Thu, 20 Nov 2025 08:23:19 -0500
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4d3-0001xL-Ey; Thu, 20 Nov 2025 08:23:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9kK1666XgZFDE5NgfDCdivT2GfQ1XNYPJxII8ytulVkQVaaA0BLn1R7eY6qDY6FAbGED/RPXvpT2VqOztXJ/+0oV21p967EQaoZenIg3Uhc/hkwU7AH7TKUPL+MyEBEfIDFkE/CnYpLabHnTBQvj5hJIQV4UXFFKYZjlpjVURKJghDQk+NQ06QllMNxAJBX7OIUiQ/Ca6cZgpqcJV4EQaoaejCQbJiTzOoHiZO27azdGbyjDB1khPvN9cXa7dfduhtV8csV5YHtCvDdF6wkecovXrB0Vx7O2Vl2MBnZCQWZgN3bQc+9RCO41G0RXn7PxfG/pr6cLu3y2hRsH8oY9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVPXMbxcLVwPix93yuaieAYGg757LRJ8r7g1KiTV274=;
 b=EXtWvFl+fqHCgkk6mSUESNJxXLV7PBMtHwSYubclRwnpSkrPfhwXl+70VKAua6vLtxBegAe3jvE512vpDkg1AAsvCswbNBcDSX9iSPy8Ggp54/+9dtWJ70o20Ahrmr7bVxyLudFHLpJxvPtfayOPtCFh7RVWpmP2YrAowzVRbJmvuFsCcq/TiWcoMZKikIKkLveQhGyaAKzFk90vORt/j5YAhW5QUxu9TBoIZyFVRqT9IKpBpIJ9jvy2aETdyiGaET1onQ9+QTyi1R36M2pNdEk7PmvWDQtqVYsYk9OY1bW2qH9KbjW3tX7+plTC27ubqMxsbQ9mpSWh9U7hAoj0Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVPXMbxcLVwPix93yuaieAYGg757LRJ8r7g1KiTV274=;
 b=WxSsm/infvFASavU2QjNUb4/CBIlBsj3JgoVtzguqTSTtgu2bByWvJq/7fqlm3/Nm/WQbMwSfofMdqObU/SlYUx0oUANTItkXp5XsQT5lXyYnTxYQq/lSGFaei3won1aSpp6n7QArU68ze9e8K6EUKkweS41Dz0OGAcC9DLB7ZZkmft61qK0Hc1iYbgMQxXjymvRuwo0tR46ZbIt0r7lcHDVFvJwIz93LD5tL9yTfTTSMfpidIbmzYDVAozYj4tN6ajo5wLzpZmm4W5+equS4VBqXLQGIcPeksNVp1cw5+X+s0I2R3dMVLb2HmXKn9zQdFYVb4osFHYUDb2wtAPYJQ==
Received: from CH0PR03CA0005.namprd03.prod.outlook.com (2603:10b6:610:b0::10)
 by DS2PR12MB9752.namprd12.prod.outlook.com (2603:10b6:8:270::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 13:23:07 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::4e) by CH0PR03CA0005.outlook.office365.com
 (2603:10b6:610:b0::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 13:23:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:23:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:22:52 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:22:48 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v6 00/33] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
Date: Thu, 20 Nov 2025 13:21:40 +0000
Message-ID: <20251120132213.56581-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|DS2PR12MB9752:EE_
X-MS-Office365-Filtering-Correlation-Id: fb1d0a8d-5922-4281-041d-08de2837f14b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1VkQzRNN1htL0NKTmNGemp6bkQ3cHRXK1hmUUgrTFI0SGlEYW4yalkrdkxv?=
 =?utf-8?B?RlFJRUp0QlI5NWFMRGJjU0NhbGNYT1hhV1pGbi9LOXZUQVR3MW91TFR1a20y?=
 =?utf-8?B?OGk1RmdFWk9IbDVKSlROWWsxb215UWc1ZDdLYzlNellNYzFkeUt6MEpwNm4v?=
 =?utf-8?B?YnN5NEdvRnNOeWplcWdiaXQ5U2pOQUY4WFg0Z0VwazB6SjlKTXVCb3lNS2x4?=
 =?utf-8?B?OEk3czlpRy9XdnRWZTJLVXhHc25QVU9SYlNEYUVYQjNxRUJONDd0SEpzUTJ6?=
 =?utf-8?B?ZEpVMGMwMVBlVU9EYTNWZ2kwUmVCSkk2K2ZGckFhSThQRm5nVWd3dTRlYUo5?=
 =?utf-8?B?WGUxOUdHbEdJdmphalVqOG1QUERaajZOd21Xd1JZSWplNHBGQXRqMC96ZEZO?=
 =?utf-8?B?amJxSi9TWjZLYmJwMjZCdFUwMnpMYUhxa0xmOWNyRUgvc3BGVFV2VTI4MlBP?=
 =?utf-8?B?REI0VE9YYWVNTGwwa1A4ak01cjdjc0Y2dEZWTENQSVY0VVg5cjJsTjNqejB3?=
 =?utf-8?B?V2FaYS9RTlMzR013N2x0R1FRUnlqQVhINFZGaUgzY3Z5aHFKWSt6YWZ3Z2pz?=
 =?utf-8?B?aGtWcE9yaHdOWXhPL2U1MWgxWmNjOHU2SHo2Zlk3bUhDWEJOSTdUR2NDSUFh?=
 =?utf-8?B?cWpQWXBpNFJSSHBUazJIUG5Najh4T05HbzJvU3dXT2NQTDBMaE13aElwQW80?=
 =?utf-8?B?dVJ5Si9OOHdZN1drMGN2ZHR2SEc3V3pGdzRPNnR6MGVvR084Mm1BYXNDSmlN?=
 =?utf-8?B?UVZicmtnWTJWMkphdFVEb1o3NGk1aHB5VXpXSEhwNFZSQzFERkt6TmhFVTZk?=
 =?utf-8?B?dU95TWZKSkRBOHBFcUNjdHdLaEtWL3hmMWM5M2d2Y2pvSmRpaFlqeEFLS2pw?=
 =?utf-8?B?cHZyMk44VlZKL0kwa2xRbnc1RnZaZ3FtVHdjVWgrcHVNVEdXUmR2czBCYXFr?=
 =?utf-8?B?SUhpSm5lYm1vS3p1WHdMMnFnTmxwZmFjbE5KaTBOb3lqZFg4U3YzY3U1akRv?=
 =?utf-8?B?S2lXVTRjR2hVSXArY2hzQW1IYk9Ya0tOQjFBUFFCY3ZFQktqaUdRUTBqU1NK?=
 =?utf-8?B?MVRhcGJ2bjdJZmlvSU1oaXJmY0NFUlVxeFBCOWZYSVFmR3ZIWVJlWUwxWEJu?=
 =?utf-8?B?aStzeURUYXdoMG1nQjJEWFR1Y1g5bHVUVDR3Nk84OVF6K3crWVJGaDdoa0la?=
 =?utf-8?B?K1h2R0Fqa3cyczBVRUNaUnhaRkM1MzY0L295ZVhqTENCM0IvdnA1Y2VRa1NV?=
 =?utf-8?B?V21ZQWRzbkZnbnVNaUx2QjI0ZHNoUXpRT3dYZEloK1pIdEpzZHl5cTJEcGtj?=
 =?utf-8?B?ZnFLaWlNSDdJOVh3a2prZnZ5TUxWR2tKRTBqOFM0TFp3dk14RW02amZUNTc2?=
 =?utf-8?B?aGttQzRpSlhQZ3NHekFUNUhudXF2L0ZYdWtSK21sM3VRaHlMVU5EOUx3OFFJ?=
 =?utf-8?B?TzhMNitXem4zV0lJblVUQ1E2VVlXcTZSZVRVUExrTUJmTnZJa0hrdjJRblRK?=
 =?utf-8?B?OEpQV05RbWpGUVNkZUxSS2phaXRhWHJLRjNQcyswSG5UbXJ4OHIrd2JGYm1S?=
 =?utf-8?B?bERySWtXKzZuS245NStuTjZtWXFlNWpYOGttSTc3Z0oxU1IyalFvNVgvaFlF?=
 =?utf-8?B?UFdHci9sTG5OWlhkL0piK3MvbkpDUDdQMU5uTThRbWNUbUhCR1NWT2lZU2Zz?=
 =?utf-8?B?ZWJpRmVLT0dtNHVhVzZQNE1DbDRpa0dPSE1hbEc0R3lwajNMRVl6YjlhdHJZ?=
 =?utf-8?B?TEFVa3A0SHE5czZCY2x6eHBZOUdPb3BNOVh5NFEzUFdaa0dkbjFHRlJnc2lM?=
 =?utf-8?B?a05uaTY2TGoyRXBmWG9FMm4xQXpHODg1WXJmODlIeWRuV1VBNlJWN1dRSFRI?=
 =?utf-8?B?YmMzZWF0OEZMSWQ5VDJhS3dWQjhCbUtGWWU0aFk4Tjg3Q2RTMTFmRjJrbGJi?=
 =?utf-8?B?eVQwNlJPT2NhUjZEa1I1WXB3cTNBUDNuZHhjT1U2bHZ6MGpvZWNHOEhkZDlH?=
 =?utf-8?B?K0tlYUUxTnNSQ2pCY083NFFSN0JDWlZGUGE4VGZJUkhQQjFoOGlOK3FTLzZB?=
 =?utf-8?B?OUw1dDBNK3JTeW9JRUZWTlN6VlVZeGdEN0ZQUURLUGpZamhsbldDYnhkem4v?=
 =?utf-8?Q?HUE3VJm+XgWtaj55KxFP2qQJM?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:23:06.8111 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1d0a8d-5922-4281-041d-08de2837f14b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9752
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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

Changes from v5:
  https://lore.kernel.org/qemu-devel/20251031105005.24618-1-skolothumtho@nvidia.com/

 - Addressed feedback from v5 and picked up R-by tags. Thanks to all!
 - The previously split out _DSM fix mini-series is now accepted [0].
 - Improved documentation about the rationale behind the design choice of
   returning an address space aliased to the system address space for
   vfio-pci endpoint devices (patch #10).
 - Added error propagation support for smmuv3_cmdq_consume() (patch #13).
 - Updated vSTE based HWPT installation to check the SMMU enabled case
   (patch #14).
 - Introduced an optional callback to PCIIOMMUOps to retrieve the MSI
   doorbell GPA directly, allowing us to avoid unsafe page table walks for
   MSI translation in accelerated SMMUv3 cases (patch #16).
 - GBPA-based vSTE update depends on Nicolin's kernel patch [1].
 - VFIO/IOMMUFD has dependency on Zhenzhong's patches: 4/5/8 from the
   pass-through support series [2].

PATCH organization:
 1–26: Enables accelerated SMMUv3 with features based on default QEMU SMMUv3,
       including IORT RMR based MSI support.
 27–29: Adds options for specifying RIL, ATS, and OAS features.
 30–33: Adds PASID support, including VFIO changes.

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
https://github.com/shamiali2008/qemu-master master-smmuv3-accel-v6

Please take a look and let me know your feedback.

Thanks,
Shameer

[0] https://lore.kernel.org/qemu-devel/20251022080639.243965-1-skolothumtho@nvidia.com/
[1] https://lore.kernel.org/linux-iommu/20251103172755.2026145-1-nicolinc@nvidia.com/
[2] https://lore.kernel.org/qemu-devel/20251117093729.1121324-1-zhenzhong.duan@intel.com/

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

Shameer Kolothum (26):
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
  hw/arm/smmuv3: propagate smmuv3_cmdq_consume() errors to caller
  hw/arm/smmuv3-accel: Install SMMUv3 GBPA based hwpt
  hw/pci/pci: Introduce a callback to retrieve the MSI doorbell GPA
    directly
  hw/arm/smmuv3: Add support for providing a direct MSI doorbell GPA
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

 backends/iommufd.c                            |  82 +-
 backends/trace-events                         |   2 +
 hw/arm/Kconfig                                |   5 +
 hw/arm/meson.build                            |   3 +-
 hw/arm/smmu-common.c                          |  51 +-
 hw/arm/smmuv3-accel.c                         | 756 ++++++++++++++++++
 hw/arm/smmuv3-accel.h                         |  86 ++
 hw/arm/smmuv3-internal.h                      |  27 +-
 hw/arm/smmuv3.c                               | 206 ++++-
 hw/arm/trace-events                           |   6 +
 hw/arm/virt-acpi-build.c                      | 127 ++-
 hw/arm/virt.c                                 |  30 +
 hw/i386/intel_iommu.c                         |   8 +-
 hw/pci-bridge/pci_expander_bridge.c           |   1 -
 hw/pci-host/gpex-acpi.c                       |  29 +-
 hw/pci/pci.c                                  |  43 +-
 hw/vfio/container-legacy.c                    |   8 +-
 hw/vfio/iommufd.c                             |   7 +-
 hw/vfio/pci.c                                 |  38 +
 include/hw/arm/smmu-common.h                  |   7 +
 include/hw/arm/smmuv3.h                       |  10 +
 include/hw/arm/virt.h                         |   1 +
 include/hw/iommu.h                            |   1 +
 include/hw/pci-host/gpex.h                    |   1 +
 include/hw/pci/pci.h                          |  34 +
 include/hw/pci/pci_bridge.h                   |   1 +
 include/system/host_iommu_device.h            |  21 +-
 include/system/iommufd.h                      |  29 +-
 target/arm/kvm.c                              |  18 +-
 tests/data/acpi/aarch64/virt/IORT             | Bin 128 -> 128 bytes
 tests/data/acpi/aarch64/virt/IORT.its_off     | Bin 172 -> 172 bytes
 tests/data/acpi/aarch64/virt/IORT.smmuv3-dev  | Bin 364 -> 364 bytes
 .../data/acpi/aarch64/virt/IORT.smmuv3-legacy | Bin 276 -> 276 bytes
 33 files changed, 1536 insertions(+), 102 deletions(-)
 create mode 100644 hw/arm/smmuv3-accel.c
 create mode 100644 hw/arm/smmuv3-accel.h

-- 
2.43.0


