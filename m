Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC40FCAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 13:42:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3E6U-0002Ql-UA; Mon, 29 Sep 2025 09:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E6Q-0002P9-NY; Mon, 29 Sep 2025 09:39:43 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E6F-00035r-KA; Mon, 29 Sep 2025 09:39:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wwxxt56rd5bN/YC2FFLls9RHCHqSyjS6U8EZcFDMiD1wwNI/X9v6akFS7BJjjW3FGTuw2thELgpX+MeTGwj4L0bclFf6fH75QZ1P2pSoB+MoulqsCSmJDTm/CRERa3CFyS5g7iHJ6T2l9ASALm9Ctv0WAUDeyBMtbCAJY9UjQ17ZwBJ7EPC5y1PucWil6fXRNcrOaFbE5O9me/b4/vlMVuCqG8M0+1SvDqcxHm1aFZ2EAG84fawT5YzpGEWiyQiY922OzzSgQdboGlqQdDTIbvKYxBIsSoU2j15YLVH3zum+wmm1LY/sbhA3Wz/MHvO2VHcVKWMRnRoISMrqBFD3cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kenlFJcnHQ9gn3TqnAFboQvHrFFHi62aaLC+dbjbyys=;
 b=l/MgF9DrYCHp6XNMcZLJ3wNuFrbL4KU+xose7Hjhz95y0wJQtzqJt1TPJK9fNRJt5UVZ5O9gFHLqt6BPs5EPZp2GNQ4A0O1bvAw4Oh11iNdOU4k/xqtlMzTiij/zzOuZzRGgb3RdmSy5l88/s1Wd6TFEm0bp4qMVJLRApxivACVlXGPUCRZRrfd/SHBMdlxY+JNyrOYnZXWnZimulh0B299wzUacE49Vh400JlBnkixpYl8X0qxbHCgx4RvY9Lvw5febrOSG8CDYH2u++rOYeDhNQTH0IUtoHKj/3bggB0BiJV2fO5uXvx8F0fHcqySkNt6QjU4w1s/Dd9HqnZMu3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kenlFJcnHQ9gn3TqnAFboQvHrFFHi62aaLC+dbjbyys=;
 b=PgHNrMD0JDfFXqcUMJF/AFQ6/WWNVZ7UO6ITamq+a55w5q7YEGJTt7Ksl3pWB6dSLBKXo0lcygI8f4CK3SeNLhT//CpyKBXhL4SspV340naWvnhNySOPqZj32OHO7WiIN5Wc4k0K3q7/+iVZs6qveAji4h//ah1YZalr77tztXhZ8P+l/LMwEei/qn5GIY0tbibWah/h5DzUpTzbGwIaxKb3sKoh7p7ETPfQxOBHdMvdK+77g9erTyrNVzh0XJiOtYVRVAxeFfFWUXI1kSOrWquubc/+YzAbw0lZo6WgACp3HudX1Sq44JCoiVDzAAGSbMelamE6yGVS7Q/OBAsoSg==
Received: from BL1P223CA0038.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::7)
 by DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 13:39:10 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:208:5b6:cafe::ad) by BL1P223CA0038.outlook.office365.com
 (2603:10b6:208:5b6::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Mon,
 29 Sep 2025 13:39:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.1 via Frontend Transport; Mon, 29 Sep 2025 13:39:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 29 Sep
 2025 06:38:48 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Sep
 2025 06:38:44 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: [PATCH v4 00/27] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
Date: Mon, 29 Sep 2025 14:36:16 +0100
Message-ID: <20250929133643.38961-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|DM6PR12MB4156:EE_
X-MS-Office365-Filtering-Correlation-Id: 8670b4d5-7eea-426c-a0b7-08ddff5d9146
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3BIUFB1bHVOM3RKenhrMU9tQUcrc1pNeUV2RXllZHpKYnNvUWlxSElnL1ND?=
 =?utf-8?B?RmcvNThTdG1qaGY2UHVic3c5c3VOU1pQczVLUldJMXdycHhQa3E1Ly9oNUZL?=
 =?utf-8?B?VEhXOGVnR0V2SDBaZ3BMMDBYMXVWVEVKanB3YldYV29vWmRuU1ZKWGE0ajBy?=
 =?utf-8?B?MnovTmszcXNZWmk3SHpMVG83VWNHZjVjM3lGZVcxdEV0RnhOaEJjVUV2bVFU?=
 =?utf-8?B?L3V1THdhZHBScW9ZWmt1ckNRZVZaKzlaMy9NamF4eSt6VXFUOElJOXNxNWJh?=
 =?utf-8?B?WWRQV1I3UTRXNnFsbEVYS0xzZ2JLaFZLcXJVRHI3ekg1VGVxYStVYWFZbmk5?=
 =?utf-8?B?MnpFY2ZvaXZublZCNGxIRGExcVpYNnVDbjlhbC9adS9pbHNJbyt0NjRjRjdi?=
 =?utf-8?B?N2FyYmRoRXZTbWE1SnV6UjdEc0JGZitMR256NDM5TzY0ODNvNWxoUnRzS3l0?=
 =?utf-8?B?eDRUMGhWOW5ubGptYWNsZ0J3emRuek5RbFIzaldPdkFXUXV5eFZ2T1hYakNa?=
 =?utf-8?B?WkkzWFp5dVBxRUgySVRrQnFFZjN6bi9mRkMrcXA1Wnl0ejAvZzg1bXhweEUy?=
 =?utf-8?B?ZVZ4NTkrZDB3aENxWTIxeWtxWUxZaSsrRzUwb1ZGZUlRR1k4T2htazQ3bjA1?=
 =?utf-8?B?VUhUdkhtb3U5dTFkMW03NTVZS084VmNjd1hRRVRFaWw3WUVyT1ZCdDRkc2hE?=
 =?utf-8?B?UDdsRS9lbU9lbTRuOUxUcFltcGEvNmFFT0s2YTV6c2NST2p2Q0VsL1B1ajVz?=
 =?utf-8?B?UXhxQXFqdnpCaXpNeGRCczhYQnJ1THVWVGlLUUNCR2xscnA4UE41OGZyNitJ?=
 =?utf-8?B?WkdiRlJlOEhYek14c3hoOHlBNEJENUlXMG5XaWZVeHZ3a2RaSlBZdWJpM2dk?=
 =?utf-8?B?U2tnVHE1SmtvWTBBRGE5SDNOc1dhc253Tkh3OVY0ZjFBL3c2Vk10dmVJeTRL?=
 =?utf-8?B?aTU5RU0vQUJjYVRoendKNm5nK1B0WHRZRXRVTzhDVUpjMk9uVXZpT3FRTU1t?=
 =?utf-8?B?NUFSSTJOSXFaOUtIS0JOeE5JTFBuMGk5OG5qS29PbERNQmhsZkVZbzRJTEky?=
 =?utf-8?B?V1JnQXYwVFQrN2xDbUJpZGVWTlZPcEYwSzczUzNGaU1QazZuVzQ0dVAwSEV0?=
 =?utf-8?B?RnVTRzRvbDNwamJvcnNwVFlGcGFadThMc0JnUnZiQS80enZ6SWcxTVBDb3Fl?=
 =?utf-8?B?TDZyUUp2T0k4QVZ5eFZPM2xJT2F1M1RGaUQ1RGVTa25DSFpxL2cxV0lYUXBq?=
 =?utf-8?B?K2NaR1lob3hSK09XQ3k4YUVldE5GRVZoSWNlMi8zNHBtdWljNDB5Zm53c2xE?=
 =?utf-8?B?ZHFxZUxMeFVHbVdhRWN6eGlZWktaZ3l6NUwvQklpY3FmU2lXYnRJdGg2SENP?=
 =?utf-8?B?am1mYXBudDg0cUdLUk5WSkw4STdoci92emFtU1dRRThLY0hDcHVSNXVsaE5m?=
 =?utf-8?B?U0lueE5SS3N0OUQzMS9nNHIvTk15VElldCs3anlZVThiYTYwQmtUV1ZHM3M1?=
 =?utf-8?B?Rm81cGxiN0pEZU8xanc2YkxzUnV5N2YzSys1SnNwdWNhS0QwTUk1WWY2T0c2?=
 =?utf-8?B?WnY2NmhyUmhzc2ozdTBNSkJKU295ZnExbWxXZUhvZDkvcFdKejQ4K0tkckRC?=
 =?utf-8?B?NEFoRTZHRVlSZW1DM0gwNG14Mld5NGZyRzNmQzhpOE50alBORWVDLzZuRDAz?=
 =?utf-8?B?VjIwYjFoeDVuSFFQN09QQ1VMa2JSVVpDenN6UTRqSXFwTFlHSjJQMDJwMkUr?=
 =?utf-8?B?WjVva01TMzFJcjdacVZjdlB6YlUzWTJGTXlVdDNhOUZ2R0Q5b05ETk1LS0Nm?=
 =?utf-8?B?RERoRW9ud1NBeVp1bmNLSWlTRGQxUXZOUGJOM3Ewb0JjRU9Wd1JPbGhWT2JK?=
 =?utf-8?B?aXFlbFFZMnZzVlp5TmtMRngwNTEyN0RVZVRMdC90UHltZUxPTVlLV2JtelhB?=
 =?utf-8?B?VTRJbTF2R0dyUmFGL2l2SmpDZ0lTNUhZemsxcWliampRZktFNys0b1dOZHZX?=
 =?utf-8?B?NVFCSWV5dHJNcEFMZFVJT2RsQjAwZFRDbnNtS21iL1gwOWxoK3JMOUEwdytX?=
 =?utf-8?B?alJqdnRneGoxdzRIc2hpNG91d0M2bm12aEZZWW1uaGxVVnhKSDlRN3BDK1JF?=
 =?utf-8?Q?suv27mir5P1qgAj0mHZr9sfK9?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 13:39:08.9028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8670b4d5-7eea-426c-a0b7-08ddff5d9146
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4156
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
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

Hi,

Changes from RFCv3:

 -Removed RFC tag as we have the user-creatable SMMUv3 sereis now applied[0]
 -Addressed feedback from RFCv3. Thanks to all!(I believe I have addressed
  all comments, apologies if I missed any)
 -Removed dependency on “at least one cold-plugged vfio-pci device.” The
  accelerated SMMUv3 features are now initialized based on QEMU SMMUv3
  defaults, and each time a device is attached, the host SMMUv3 info is
  retrieved and features are cross-checked.
 -Includes IORT RMR support to enable MSI doorbell address translation.
  Thanks to Eric, this is based on his earlier attempt on DSM #5 and
  IORT RMR support.
 -Added optional properties (like ATS, RIL, etc.) for the user to override
  the default QEMU SMMUv3 features.
 -Deferred batched invalidation of commands for now. This series supports
  basic single in-order command issuing to the host. Batched support will
  be added as a follow up series.
 -Includes synthesizing PASID capability for the assigned vfio-pci device.
  Thanks to Yi’s effort, this is based on his out-of-tree patches.
 -Added a migration blocker for now. Plan is to enable migration support
  later.
 -Has dependency(patches: 4/5/8)on Zhenzhong's pass-through support series[1]

PATCH organization:
 1–20: Enables accelerated SMMUv3 with features based on default QEMU SMMUv3,
       including IORT RMR based MSI support.
 21–23: Adds options for specifying RIL, ATS, and OAS features.
 24–27: Adds PASID support, including VFIO changes.

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
https://github.com/shamiali2008/qemu-master smmuv3-accel-v4

Please take a look and let me know your feedback.

Thanks,
Shameer

[0] https://lore.kernel.org/qemu-devel/20250829082543.7680-1-skolothumtho@nvidia.com/
[1] https://lore.kernel.org/qemu-devel/20250918085803.796942-1-zhenzhong.duan@intel.com/

Deatils from RFCv3 Cover letter:
-------------------------------
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

Eric Auger (3):
  acpi/gpex: Fix PCI Express Slot Information function 0 returned value
  hw/pci-host/gpex: Allow to generate preserve boot config DSM #5
  hw/arm/virt-acpi-build: Add IORT RMR regions to handle MSI nested
    binding

Nicolin Chen (5):
  backends/iommufd: Introduce iommufd_backend_alloc_viommu
  backends/iommufd: Introduce iommufd_vdev_alloc
  hw/arm/smmuv3-accel: Add set/unset_iommu_device callback
  hw/arm/smmuv3-accel: Support nested STE install/uninstall support
  hw/arm/smmuv3-accel: Allocate a vDEVICE object for device

Shameer Kolothum (18):
  hw/arm/smmu-common: Factor out common helper functions and export
  hw/arm/smmu-common:Make iommu ops part of SMMUState
  hw/arm/smmuv3-accel: Introduce smmuv3 accel device
  hw/arm/smmuv3-accel: Restrict accelerated SMMUv3 to vfio-pci endpoints
    with iommufd
  hw/arm/smmuv3: Implement get_viommu_cap() callback
  hw/pci/pci: Introduce optional get_msi_address_space() callback
  hw/arm/smmuv3-accel: Make use of get_msi_address_space() callback
  hw/arm/smmuv3-accel: Add support to issue invalidation cmd to host
  hw/arm/smmuv3-accel: Get host SMMUv3 hw info and validate
  hw/arm/virt: Set PCI preserve_config for accel SMMUv3
  hw/arm/smmuv3-accel: Install S1 bypass hwpt on reset
  hw/arm/smmuv3: Add accel property for SMMUv3 device
  hw/arm/smmuv3-accel: Add a property to specify RIL support
  hw/arm/smmuv3-accel: Add support for ATS
  hw/arm/smmuv3-accel: Add property to specify OAS bits
  backends/iommufd: Retrieve PASID width from
    iommufd_backend_get_device_info()
  backends/iommufd: Add a callback helper to retrieve PASID support
  hw.arm/smmuv3: Add support for PASID enable

Yi Liu (1):
  vfio: Synthesize vPASID capability to VM

 backends/iommufd.c                  |  68 ++-
 backends/trace-events               |   2 +
 hw/arm/Kconfig                      |   5 +
 hw/arm/meson.build                  |   3 +-
 hw/arm/smmu-common.c                |  51 +-
 hw/arm/smmuv3-accel.c               | 726 ++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h               |  83 ++++
 hw/arm/smmuv3-internal.h            |   7 +-
 hw/arm/smmuv3.c                     | 145 +++++-
 hw/arm/trace-events                 |   5 +
 hw/arm/virt-acpi-build.c            |  93 +++-
 hw/arm/virt.c                       |  36 +-
 hw/pci-bridge/pci_expander_bridge.c |   1 -
 hw/pci-host/gpex-acpi.c             |  29 +-
 hw/pci/pci.c                        |  19 +
 hw/vfio/iommufd.c                   |   7 +-
 hw/vfio/pci.c                       |  31 ++
 include/hw/arm/smmu-common.h        |   7 +
 include/hw/arm/smmuv3.h             |   9 +
 include/hw/arm/virt.h               |   1 +
 include/hw/iommu.h                  |   1 +
 include/hw/pci-host/gpex.h          |   1 +
 include/hw/pci/pci.h                |  16 +
 include/hw/pci/pci_bridge.h         |   1 +
 include/system/host_iommu_device.h  |  14 +
 include/system/iommufd.h            |  29 +-
 target/arm/kvm.c                    |   2 +-
 27 files changed, 1335 insertions(+), 57 deletions(-)
 create mode 100644 hw/arm/smmuv3-accel.c
 create mode 100644 hw/arm/smmuv3-accel.h

-- 
2.43.0


