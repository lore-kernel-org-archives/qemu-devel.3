Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A52CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN9d-0004cY-Mx; Sat, 30 Aug 2025 11:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uruTd-0002b7-4w; Fri, 29 Aug 2025 04:28:54 -0400
Received: from mail-mw2nam12on20626.outbound.protection.outlook.com
 ([2a01:111:f403:200a::626]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uruTa-0006Hh-6G; Fri, 29 Aug 2025 04:28:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/kGd6fEySEZ0L/I0OAXDtFVrs8OmAIuWbE6KKR2QFO1I8wlNVzjv8f+u/K/zCQ4bLF0+8xHRd7ic9wsZAsfVybcSgWKtKdyyDkUz6bWl50lm/VTp02PhHVKquxmPNUg6XehkBkaWjsUJnAf9ni2sWGpAloLlzTSkYrZO8jKY9KNPd/XXoX5jwc24lUwHY4ue+4aBqtYXPM7LhQdvAYXWO7VeKxmQg++e3IDdaTAUQQCPRnkCaKE08JdRhPUjLSYsS0GH4kk+TH5wiswpnwMUEAgGFmwPKBCN10Xq2PcoMVXJgjOfSC4iYo21g3DVYIfld0DlBWT5aKZsldwCooWcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msbzO19X3N9FfXv/Bd/ZMKiSP6mUfYJ07xHKxisnL1g=;
 b=Qo5xFdsgpNzNXkD/+J11JIwHxFWCc2mP/cv9Bmaa8HPt9FiuCF3jcTERlxba1b017FQYDMsacLfXj3pNkMuPftTjiKseVHVA9vazE6V7RRJZJg/ZEQQwki+CXnF+gh80AqI4zDqRIfM6oqDssK8bgOYPyxAiJT7Ui4iH0Gag0xWL0K++E7RsM8V91VOCADRpjoULUbbWWf4a9DPikgSls3t4D/y+slayeK9yhYIZZKkOds04BUOHmPSY0CCLRKFOif6dqoGwDqv/ymMBMubPvYNIKWhiq5ZRoQ/LhRveo67cN01jaABVc1LuRO9QH38GAemnawIeJHUKLyyNEKiInQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msbzO19X3N9FfXv/Bd/ZMKiSP6mUfYJ07xHKxisnL1g=;
 b=ZdHNnCotPwRaygEjxvnxAp4D4SLN/3WNiYieYkSDM2s/Y5p5Bh15CiAGPppvjR1acNQomPXXkjacooo75xWp959nQ4GRpQxiQAEwpO+u2c34+cysvAklYs27WlCi0EV67rIYfMm9XZL4qU8BabnK2EhVAMLiBsfb8eV7hBJHc1CPDlLvUqBRym7hy63wEacpUJTbUpOeetSmBK7em2TDKPRxgnmfPulBUxd0txbM29T44X2TUr3Ne9Fdw0LYU/61vfwm3CapqGUdDdBgz60UHLEF/rt1BI6xRCLOwbqdCy1pEbJOKsDAH9k+e3D206SHrZRtiqFUKvr+8XDiAdfsHA==
Received: from BY5PR03CA0005.namprd03.prod.outlook.com (2603:10b6:a03:1e0::15)
 by DS0PR12MB7727.namprd12.prod.outlook.com (2603:10b6:8:135::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Fri, 29 Aug
 2025 08:28:31 +0000
Received: from SJ1PEPF000026C4.namprd04.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::c3) by BY5PR03CA0005.outlook.office365.com
 (2603:10b6:a03:1e0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.16 via Frontend Transport; Fri,
 29 Aug 2025 08:28:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C4.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 08:28:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 29 Aug
 2025 01:28:17 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 29 Aug
 2025 01:28:13 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <imammedo@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: [PATCH v9 00/11] hw/arm/virt: Add support for user creatable SMMUv3
 device
Date: Fri, 29 Aug 2025 09:25:22 +0100
Message-ID: <20250829082543.7680-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C4:EE_|DS0PR12MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: 331d8b80-e037-4e38-850d-08dde6d6092e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|7416014|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WVhwbEc0eGYzaGpNSm9TaHdIWkJPSFE2YzNKVlhLSjVUUitpMnZlbHFRSEJy?=
 =?utf-8?B?czI3NzFBOGgwSkRnaTNsUk1UTSs3Uk16TE9lNWJWbXNFU1JMWlhnclR5TnV2?=
 =?utf-8?B?Z2RncmpseDdnUTV1TmRrc1QvdnoyOW1ublpxeEN6b1ZXSnRsOVpVd2JUeGkx?=
 =?utf-8?B?ak02YVE1YTloUFpEeEh2VU5zeW5JcHhGNGlaTHJ3UmxBTytyRmJRNDlIZC83?=
 =?utf-8?B?bUJheUFaQVBWTkJXMmlRTWtUM0ZNNGdXdkloR2ZtaTdkYlhZamNGYzlpZEhX?=
 =?utf-8?B?blM4anZqcUpkdUNDeDMxSHVUVXVkbDEzWWJ5aGpFeTA2b0o5ZFZLWlgvR0R5?=
 =?utf-8?B?V0pjNG5wMEtqbUw1dHN0NDlWNDRsL3A2R3JXQ1ZTRGt0UlI0czJDcWVnTEhI?=
 =?utf-8?B?SW43R2RaTTVzNGU3eWcyM1V1Z3lqVG5KK3pscXRHaVNaaERvNU84UEIySHpJ?=
 =?utf-8?B?d1BZMGQxNjdXSEVoZTdmNFYwdTFZb3pvRG9jRmxkVHBlcVBzY25zSnY3ckdW?=
 =?utf-8?B?NEMxNWFOTWwzTDVtdzd4N0g4SmtQbTdmYWFFeHNUS2hoUUpIU1B6b1dMUDhM?=
 =?utf-8?B?bXhHR0Q4azJYZHpHYWU2elhaWDRQR1VwL3RpbWNhWnYxL0pMUldoSm9WeHdV?=
 =?utf-8?B?MFRHVTMvSmRmbXRDYThqWkJwNDFwWmZ3QzNvWDllTlhDWWdrd0t2aUxmRDZs?=
 =?utf-8?B?ZkpTck4vNE4rTGdXb3Z6WnhvdWJET2ZlSnNzRmFVQWwwYUF1aDJoT09MYnY2?=
 =?utf-8?B?R1AvWnZ0R2pyR2d0UmQyVC9laWYySHVRUFJMVVc3Q0NwZm5QZmZqWEp3S3A4?=
 =?utf-8?B?aTBqamNFNExaMXVOY2NrV2djVmhTbzR0L05UVTFHRUp2cUtma05wUXNrdjlk?=
 =?utf-8?B?Nm41YUwvajMvSVRXelhRUHIvL1dSZ0N4UlRNZkVsZHhTc0g4WFZvakRjYWJW?=
 =?utf-8?B?eThpVlh3ZEgzd01SenRibzZpbDh6L0ltd25KenRYdzAvcGYzUUxGaHhpLzZ5?=
 =?utf-8?B?Yy9jeGVWWlVSc3JvV25CNFFlS3dDYXBZOXVNTnZaMjFkdWR2d1pDMUVHdVMr?=
 =?utf-8?B?QXBFSTg4Z3lYL2kyZ0IrTUxZMzlRakFoVUszdG1vcHIyWGVBTEE4MksyZ3hI?=
 =?utf-8?B?MWVqNEd3UTd5bm5Wb3hTKy8yOWxZbGd6QVdqb0ZTU0pROEJvaXpQVHpvWHhp?=
 =?utf-8?B?dGZCV2d5ckJtVFNmWE1BZWNmeUN1TTd4SWNIU3AyNFFDZ1BhUjZxTTJ2Lzc2?=
 =?utf-8?B?bmNJVmdDOVhtYnpuVmVXNjVPcXJWNWljZTlvUGptMHR2TElPTWlEcHRDYjda?=
 =?utf-8?B?ZXRBOWtadUZxeWt1NkZuS0xsZE1IZXNySmVaSlNQTmNEcmh5KzU2WmFweCtE?=
 =?utf-8?B?WFhiRVRvcXNaN3R4Y05UdDZ2S0JreXp4Q213b2hZd28wSHUyVHNjOU9PQ2NI?=
 =?utf-8?B?WE41QVFsb0w4cW9LbWdUWWdjeFV2Q0czdGdaeU5PeUJmQ3hScVV5YUxGZ3Rx?=
 =?utf-8?B?RDBHK2RmVk14dUo4a3J6bjhkNDJBZjJzTVJrTmFSdHdsVGxNc3ZCOVN0QzQx?=
 =?utf-8?B?eGdOYVdkclB3bzBZcXB4aExTRWZIUlNHeGpSaHNDSHVsa203TS90Zm5lM21V?=
 =?utf-8?B?NEpBN2lHVFk3YWQvcXNpeDBMSmtRMUU2N0ZQQVRYTUhuTXJTaFJJS3Zxc24r?=
 =?utf-8?B?V25PMWplUGtBbWdNcE1kb1VQTk1HWXYyUHNBZjNNa1JHY1dpL1lKOE90NFVY?=
 =?utf-8?B?RTZtM1VFLzdHQlAyMlpHd3hHcUU1aUFBR3Z6SDdGcXRURmEvUmZjRVF4ZHNY?=
 =?utf-8?B?TXR6YjhRVVFBTFJWNXd0NytCL2NYWGw0TDdkWmZyOGUxOEVva05qcTNIZHM2?=
 =?utf-8?B?WGlwWTVCUFhxenJCWk1HdnZuTTVDSHROdmpHZHNQb0N4LzYyVk5jRVI1MWc4?=
 =?utf-8?B?cm82OHlLYk5wOUkvb3l6ZzRuL3p6MnJFNFVaQ1VCSEhWdkR3MlRYVWQ4SjFS?=
 =?utf-8?B?b2xFYlBxZkZ5TGJEUm9zQk5CK3I2T1NCVUp2Vk95NVcrTXhtUHBJck5nK0VE?=
 =?utf-8?B?c2lOU2d0Mmo1Y0NPa01BWVhsR0ZCZWZCeC92Zz09?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 08:28:30.7231 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 331d8b80-e037-4e38-850d-08dde6d6092e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7727
Received-SPF: permerror client-ip=2a01:111:f403:200a::626;
 envelope-from=skolothumtho@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 29 Aug 2025 09:59:54 -0400
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

Changes from v8:
https://lore.kernel.org/qemu-devel/20250711084749.18300-1-shameerali.kolothum.thodi@huawei.com/

1.Dropped previous patch #1 as that one is now already in.
2.Rebased and updated DSDT in patch #11 to make bios table tests happy.
  The DSDT has changed since Eric's PCI hotplug series work.
3.Added T-by tags from Nicolin. Thanks!.

I think this is in a good shape now. Please take a look.

Thanks,
Shameer 

Changes from v7:
https://lore.kernel.org/qemu-devel/20250708154055.101012-1-shameerali.kolothum.thodi@huawei.com/

1. Rebased to latest target-arm.next(I have included patch#1
   as I can't find that after a git pull of latest)
2. Addressed comments from Nicolin and added R-by tags. Thanks!

Changes from v6:
https://lore.kernel.org/qemu-devel/20250703084643.85740-1-shameerali.kolothum.thodi@huawei.com/

1. Fixed the warning case for DT support, reported by Eric(patch #1).
2. Picked up R-by's and T-by's. Thanks!

Changes from v5:
https://lore.kernel.org/qemu-devel/20250623094230.76084-1-shameerali.kolothum.thodi@huawei.com/

1. Rebased to target-arm.next and resolved conflicts with the series 
   [PATCH-for-10.1 v6 0/9] hw/arm: GIC 'its=off'.
2. While at it, noticed an issue with RC id mappings creation
   and patch #1 is a fix for that.
3. Patches 3 and 4 have changes because of the conflict resolution with the
   above series. I have retained the R-by tags, but encourage all to take
   another look in case I missed anything.
4. Collected R-by and T-by tags. Thanks!.

Changes from v4:
https://lore.kernel.org/qemu-devel/20250613144449.60156-1-shameerali.kolothum.thodi@huawei.com/

Major changes from v4:

1. Added stricter validation for PCI buses associated with the SMMU.
   Only the default PCIe Root Complex (pcie.0) and additional root
   complexes created using pxb-pcie (see patch #1) are allowed.

2. While testing this series with a setup involving multiple PCIe root
   complexes using pxb-pcie, I encountered an issue related to IOMMU
   ops resolution. Consider the below configuration, where an
   arm-smmuv3 device is associated with the default root complex pcie.0,
   and an additional pxb-pcie-based root complex (pcie.1) is added
   without any associated SMMU:

   -device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.1 \
   ...
   -device pxb-pcie,id=pcie.1,bus_nr=8,bus=pcie.0 \
   -device pcie-root-port,id=pcie.port1,chassis=2,bus=pcie.1 \
   -device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.2 \
   ...
   -device virtio-net-pci,bus=pcie.0,netdev=net0,id=virtionet.0 \
   -device virtio-net-pci,bus=pcie.port1,netdev=net1,id=virtionet.1

   The guest boots fine, and virtionet.0(behind the SMMUV3) bring up
   is successful. However, attempting to bring up virtionet.1
   (behind pcie.1, which lacks a connected SMMU) results in a failure:

   root@ubuntu:/# dhclient enp9s0
   arm-smmu-v3 arm-smmu-v3.0.auto: event 0x02 received:
   arm-smmu-v3 arm-smmu-v3.0.auto: 0x0000090000000002
   arm-smmu-v3 arm-smmu-v3.0.auto: 0x0000000000000000
   arm-smmu-v3 arm-smmu-v3.0.auto: 0x0000000000000000
   arm-smmu-v3 arm-smmu-v3.0.auto: 0x0000000000000000
   arm-smmu-v3 arm-smmu-v3.0.auto: event: C_BAD_STREAMID client: (unassigned sid) sid: 0x900 ssid: 0x0
   virtio_net virtio1 enp9s0: NETDEV WATCHDOG: CPU: 2: transmit queue 0 timed out 5172 ms
   virtio_net virtio1 enp9s0: TX timeout on queue: 0, sq: output.0, vq: 0x1, name: output.0, 5172000 usecs ago
   ...

   Debug shows that QEMU currently registers IOMMU ops for bus using
   pci_setup_iommu(). However, when retrieving IOMMU ops for a device
   via pci_device_get_iommu_bus_devfn(), the function walks up to the 
   parent_dev and fetches the IOMMU ops from the parent, even if the
   current root bus has none configured.

   This works today because existing IOMMU models in QEMU are globally 
   scoped, and pxb-pcie based extra root complexes can use the
   bypass_iommu property to skip translation as needed.

   However, with this series introducing support for associating
   arm-smmuv3 devices with specific PCIe root complexes, this
   becomes problematic. In QEMU, pxb-pcie is implemented as a synthetic
   root complex whose parent_dev is pcie.0. As a result, even though
   pcie.1 has no SMMU attached, pci_device_get_iommu_bus_devfn()
   incorrectly returns the IOMMU ops associated with pcie.0 due to
   the fallback mechanism via parent_dev. This causes devices on
   pcie.1 to erroneously use the address space from pcie.0's SMMU,
   leading to failures like the one above.

   To address this, patch #6 in the series introduces a new helper 
   function pci_setup_iommu_per_bus(), which explicitly sets the 
   iommu_per_bus field in the PCIBus structure. This allows 
   pci_device_get_iommu_bus_devfn() to retrieve IOMMU ops based 
   on the specific bus.

   Not sure this is the correct approach or not. If there is a better
   way to handle this, please let me know .

3. Picked up few R-by tags where the patch content has not changed much.

4. Dropped T-by from Nathan for some patches as things have changed a bit.
   @Nathan, apprecaite if you have time to rerun the tests.

5. Added a bios table tests for both legacy SMMUv3 and new SMMMv3 devices.
   See last few patches.

Cover letter:

This patch series introduces support for a user-creatable SMMUv3 device
(-device arm-smmuv3) in QEMU.

The implementation is based on feedback received from the RFCv2[0]:
"hw/arm/virt: Add support for user-creatable accelerated SMMUv3"

Currently, QEMU's SMMUv3 emulation (iommu=smmuv3) is tied to the machine
and does not support instantiating multiple SMMUv3 devices—each associated
with a separate PCIe root complex. In contrast, real-world ARM systems
often include multiple SMMUv3 instances, each bound to a different PCIe
root complex.

This series allows to specify multiple SMMUv3 instances as below,

 -device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.0
  ...
 -device arm-smmuv3,primary-bus=pcie.1,,id=smmuv3.1

The multiple SMMUv3 instance support lays the groundwork for supporting
accelerated SMMUv3, as proposed in the aforementioned RFCv2[0]. The
proposed accelerated support will be an optional property like below,
-device arm-smmuv3,primary-bus=pcie.1,accel=on,..

Please note, the accelerated SMMUv3 support is not part of this series
and will be sent out as a separate series later on top of this one.

This series also,

-Supports either the legacy iommu=smmuv3 option or the new
  "-device arm-smmuv3" model.
  -Adds device tree bindings for the new SMMUv3 device on the arm/virt
   machine only, and only for the default pcie.0 root complex.
   (Note: pxb-pcie root complexes are currently not supported with the
    device tree due to known limitations[1].)

Example usage:
  -device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.0
  -device virtio-net-pci,bus=pcie.0
  -device pxb-pcie,id=pcie.1,bus_nr=2
  -device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.1
  -device pcie-root-port,id=pcie.port1,bus=pcie.1
  -device virtio-net-pci,bus=pcie.port1

Please take a look and let me know your feedback.

Thanks,
Shameer
[0]:https://lore.kernel.org/qemu-devel/20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com/
[1]:https://lore.kernel.org/qemu-devel/20230421165037.2506-1-Jonathan.Cameron@huawei.com/

Nicolin Chen (1):
  hw/arm/virt: Add an SMMU_IO_LEN macro

Shameer Kolothum (10):
  hw/arm/smmu-common: Check SMMU has PCIe Root Complex association
  hw/arm/virt-acpi-build: Re-arrange SMMUv3 IORT build
  hw/arm/virt-acpi-build: Update IORT for multiple smmuv3 devices
  hw/arm/virt: Factor out common SMMUV3 dt bindings code
  hw/pci: Introduce pci_setup_iommu_per_bus() for per-bus IOMMU ops
    retrieval
  hw/arm/virt: Allow user-creatable SMMUv3 dev instantiation
  qemu-options.hx: Document the arm-smmuv3 device
  bios-tables-test: Allow for smmuv3 test data.
  qtest/bios-tables-test: Add tests for legacy smmuv3 and smmuv3 device
  qtest/bios-tables-test: Update tables for smmuv3 tests

 hw/arm/smmu-common.c                          |  37 +++-
 hw/arm/smmuv3.c                               |   2 +
 hw/arm/virt-acpi-build.c                      | 201 ++++++++++++++----
 hw/arm/virt.c                                 | 111 +++++++---
 hw/core/sysbus-fdt.c                          |   3 +
 hw/pci-bridge/pci_expander_bridge.c           |   1 -
 hw/pci/pci.c                                  |  31 +++
 include/hw/arm/smmu-common.h                  |   1 +
 include/hw/arm/virt.h                         |   1 +
 include/hw/pci/pci.h                          |   2 +
 include/hw/pci/pci_bridge.h                   |   1 +
 include/hw/pci/pci_bus.h                      |   1 +
 qemu-options.hx                               |   7 +
 tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev  | Bin 0 -> 10230 bytes
 .../data/acpi/aarch64/virt/DSDT.smmuv3-legacy | Bin 0 -> 10230 bytes
 tests/data/acpi/aarch64/virt/IORT.smmuv3-dev  | Bin 0 -> 364 bytes
 .../data/acpi/aarch64/virt/IORT.smmuv3-legacy | Bin 0 -> 276 bytes
 tests/qtest/bios-tables-test.c                |  86 ++++++++
 18 files changed, 410 insertions(+), 75 deletions(-)
 create mode 100644 tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev
 create mode 100644 tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy
 create mode 100644 tests/data/acpi/aarch64/virt/IORT.smmuv3-dev
 create mode 100644 tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy

-- 
2.43.0


