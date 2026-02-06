Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38866EE20A6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 14:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voNAK-0000sK-QD; Fri, 06 Feb 2026 09:50:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voN9V-0000Pd-9E; Fri, 06 Feb 2026 09:49:45 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voN9S-0006we-Af; Fri, 06 Feb 2026 09:49:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AHEya/4WgbyU+HcPTyRBAOw/xs2bNg5yrPAjEOgj8OA420eblhIR8K8wmTOVeJdsmSSbeB+ictV180/xZozT2X3T0mH33GZWzECXplpw42kkBpLdOUPeQGkvF4ulpKom5nInkors88kKcRnW2Lhc/KeJTsAuocMRf3F+ZFTKQaIZGF2PkyymHCHynuHntUl6p4tFYcirXiIYZhCnfIch0z2PZDVuW433MfWBNR2rP4KU924aj5qjG5cqCAMG69V5xOwWt+nHXEDg3iidpnDkYJIz7FaKZhfz9DwhjRaJ60YmXLWT22KoMgWhFWZSp+NQRaQg8gSWQpmY29CIs19H6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8x8WjkdpV8J5DJEJn3eZfmPKdFW1qY1HzmDiaXrSOUU=;
 b=OSlEwiSRfR/atLvqcQS3ndOCaiFe8qiWE9CEXGIfDT+xXQBrD80/NTZNIQ5ecyrNTbkdRcnT1Hq47s/bz2o5xReWsnn++EU30m7magljEeTAQt6+HI3Go+F62fXpc4IFK4ryl5mQfAoyDW9hbMCk8myoNYehh1hfoWnwizrHMAX/CPsag+yIX5VM91vzn6uGSpRC8r/hhyLvKYFD4aDr61kULCOBsqILfSe/k/atsusK7Ht3Yb5vXka8heuEmK4TwK2qWOj6wTgCztRGkPDcMAES0v4I7mU7FsH8oipkiVKQ8yAVaRuaPhnz/z0yMwkG/FUbiYiTGTqZkG+tZOwzEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8x8WjkdpV8J5DJEJn3eZfmPKdFW1qY1HzmDiaXrSOUU=;
 b=plqurVRQrcKJl855yjiNQbcc4rhTknuVllAPrFawgUwX5vZ4Cr4lrkkwv+Dq/YX2+yjtjKOmazHlg9OP8a2yVZqBQcm7cYlMU5gv116Liqi9Z8+ViG9ePARqYVLEi9SGQZtBB3u96c2gLIRdtGbhourUi0UZJ0X1kosEwjDQtfB/vfxNTNwHyAgYyGRdrGas1bsoSC9xry7CxFNNFM2HCmyK4OgO1pdSp8qFxn0fCkNPMCLoI5KSUlzwbEWOWsgKadr/ivxJeV4N2NyPph+XANJSnm9d/hfh4JgIycbQ87fXng/GgTr7ClOVlU2/apo5zpclw/qwd2hctdmTew4BNA==
Received: from BYAPR11CA0079.namprd11.prod.outlook.com (2603:10b6:a03:f4::20)
 by LV8PR12MB9665.namprd12.prod.outlook.com (2603:10b6:408:297::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 14:49:20 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::50) by BYAPR11CA0079.outlook.office365.com
 (2603:10b6:a03:f4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Fri,
 6 Feb 2026 14:49:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:49:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:49:01 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:48:57 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v2 00/24] hw/arm/virt: Introduce Tegra241 CMDQV support for
 accelerated SMMUv3
Date: Fri, 6 Feb 2026 14:47:59 +0000
Message-ID: <20260206144823.80655-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|LV8PR12MB9665:EE_
X-MS-Office365-Filtering-Correlation-Id: ab255321-0f1f-42b7-bf99-08de658ee896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3ZuQUxOU2tJQ25YMWpEQW85cGY5bkEySzczYVhpN1ZDNTFUK3AvamVLTTA3?=
 =?utf-8?B?TTBUY2dzWjVNVFM4TkN4YTBabUg2ZG93S2lIWmE5WlRWRnFXQjlsYmNMR1lN?=
 =?utf-8?B?STVCZzFYQmNoL1RNalVuRzJqRlU2Q3IvUG1ZcTFvRHlSTTk4R3cyckRZeC84?=
 =?utf-8?B?V01obGxXNE1GODZsOHltYmprSlhQZnoxYkVkN0U3ZDZoWUNUV29kS2hpWFAx?=
 =?utf-8?B?bnQ1ZXgxenF0UmNWbUxqdXFvQlRoOW81SXJGSDVFZktJajVmWVk5M0VORFNW?=
 =?utf-8?B?SmpkOG5WTFpOOFJzei9tbjg1eE1wWWliWTlPTC9JSTk2Y0ZZc2FPNUhydW1l?=
 =?utf-8?B?MldZRHR0NXFsN1FHZmF2dGVFS01WNTZQVEdOdzdFVStDbC82cnRvRVhQY0E0?=
 =?utf-8?B?L2RKSlY0V1BPWDUrcE83c0VuYUIxemJIeHBEcGRZRmZBZ1NMeTMzWCtZeml4?=
 =?utf-8?B?bWJUbXI2OERLaGZZaVM5ZkJCY2FYQWtic1lmbnJyVmxTUkFsZm1tVW9TQUlS?=
 =?utf-8?B?TjlmR2dhNVg1RURhMmlXUmlBU0VSV2l0cjYwank4VzFmMW5IZG5RdGdrOXlU?=
 =?utf-8?B?cWN2Y3N0anRCOHcyYWhyeW1yV3BxdW54VjFjc2VWMWZFVThJZ1FHdnlJT09t?=
 =?utf-8?B?MXdVR2dUNkFLVTFjQklnbjB3ekNUdjE2aVVtYWdPWDZFUzNDTjFrYlFJbjhO?=
 =?utf-8?B?bnRNQ2FpZTEvQldGdW04NE1sdUk2NllJeU8ydnl3dE45dlpRMEUrb0pZRCtO?=
 =?utf-8?B?bFVqVGhxZ29WYk84VWFxN2dlVXl6aU1hMW5ZUU9MbjM0T3RtQ2RvUnB3azFC?=
 =?utf-8?B?RzY0ZU5JMXMwT2hYaFRCakw0YWM2R3E1MW01djZETmt4R2hwbEw3RUk1bkVz?=
 =?utf-8?B?Z2ZrUGxsNTNBWTZ3S3BxWGd5M0FOTUxuY01LZFUzVUVoV2o1V3h1TnA0TDhF?=
 =?utf-8?B?b0NYdHpwVzQ5NVQ0MmV3R0NmL1VtTEFsYzc0dmpDUk5ObVl1V0hHdzd5YlRr?=
 =?utf-8?B?ZjVWZ29Zb21yRVJIY0tUSEJ3MWdTK0RSdS9OZ1h0VFNidVdTY1RBc1Q3Q1Zl?=
 =?utf-8?B?cmVMd212K0VhM3NVNTY2SURrY1AvL3dKK2MzZnF3ZjZEbkw0WWc2MXEzbjlm?=
 =?utf-8?B?c0VGcVhWc2FiZzg4ZlZjZTBtL1A5RDBHUGhpdU5sQ01BYmhiOUlaOEdMZnJG?=
 =?utf-8?B?ZXFtQ3JxNUN0SUt5KzBMNmswaTlDdkk1R09hSmV3K2RkNVp4SjhtNFRBNWxH?=
 =?utf-8?B?NTZuWDVEOTVPZ3dQSUZSSEJOQllsbmQ4UnI4UEdxRFFHUGtTaVdSaXZOemND?=
 =?utf-8?B?V21PMC9zMUNwTklOaTc1RjdOUlNKZkRQTWgzT1V3MkNvR0QrVHlBRXBoWVAz?=
 =?utf-8?B?eWNKd0FsaXBYN01MM3I1ZmNzRm5ZeW4xbGM5bXBVVW1CazRjejNkZHd3Mjlu?=
 =?utf-8?B?US9vdmcwcUs1UE5Ubm9EZVdtVWNOejI0di9VNjlReDdpYmFVNEo1M2thSG53?=
 =?utf-8?B?MjJLcEFKSXgycWR3eFkrME9Nd1l6UWJIMnBwNCtGelpNRkl1NEFnaXZDQS9Y?=
 =?utf-8?B?SXkrVmRoaWtLb3ZDQmJXcW5Tc0pPR3JtVjYyWGxFNk5OeURvYVhQYmorSkVu?=
 =?utf-8?B?bjY5N3ZFNy8vcUN6RjgrQzgzT3ZKWDhUOS9NZHZMTkdHYXcrZDdWcWpDZXRH?=
 =?utf-8?B?dG11MkdVcTlsak95NFBIWHh3NC9NSzgrUTg0K2VRWk1UVEJWOW5Sdm1Ud2lR?=
 =?utf-8?B?U2l3VWdxeUtUQkJ3Rm5MKzFOUFc2cEZndi9aRWt0aEgycEJYSWlJMVhwa3Uv?=
 =?utf-8?B?b0Q4dEpNM1pxL05TOGNYMFBlcEt3TllacWM5ZEZ2bi9HQ0hqUFh6L0Y1Q3pB?=
 =?utf-8?B?Q0JZYVJuaTNaLzd4aUVsSDNTT1FjRTlxbkEyUkJCODVoTExiZjd6U1RiY2tj?=
 =?utf-8?B?UlJRTWNFZWMxYUdRMXludTJLNDBqUzZoalgvVFR0Wll5b0xjcGpoakJNU084?=
 =?utf-8?B?b2dvbEVKREZvTmsxR2JNMEk3MW5mK0ZGYUJVYlN2MWFKWjVqRTlXV3k2UUVt?=
 =?utf-8?B?VFZCZFhtWDJpQTMwZ1ZBUUZTSFk3TXhTYVo4NUxqdTcrcDNsb0wzZ2gxY3Fp?=
 =?utf-8?B?T2RBYS9iOWx2a0QwZ21tK296THFqck1ZRk9LNGN6NGQ5d2dXZkU5YjV0aTRz?=
 =?utf-8?B?N1lxSWc2L3RzcXZwZ3dVTkdQWTV5WjNoanlvbEJoalVLRzhYVkZzK2U2YkJP?=
 =?utf-8?B?WUhTa2l2VjVVR3d1TWpiaUVJU2hBPT0=?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tSya4OZNG1pHSEJLRKGMWO3EE8jnV61PKXdM0WSkxukdPMenKhcBKYhKqxT3GOiLaTyVnqO+OIhE1N2bdfFUDtCDHj5O5Tww+x4bBgIzr65GJe1oxaHGKxW1Z7aAcjpWGE1vzCCzVOrlswo7ZqzaP6aOqrP+0EMn4/7mR02MG1/4GglJB/jgpy3z47GVNqq8TN8fWIeELYzhOKAhDwl4hU+XGB4zwylmMy00UzVbINlziIYRsih6hvPbJw6BKtWJ0hHDsObAOtSH34HUuznsH1vk6moku5HPxA+KEwCH4Y3eAZiuaRw8bBnP3/fxftpN/BBOP+tneC4bCyznWsBdbyxlbNS/4cvI68MJiGWVo7po+QCdV54QVd+nISsL3X1V1Ufv8+Jjrnt7evsATsbc+YP3oBkNQoo8jX5+tgNylDaVbfDk+/qe7WIdKyN71S8Z
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:49:19.3716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab255321-0f1f-42b7-bf99-08de658ee896
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9665
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

Hi,

Changes from RFCv1:
https://lore.kernel.org/qemu-devel/20251210133737.78257-1-skolothumtho@nvidia.com/

 - Rebased on top of latest master with SMMUv3 accel support.
 - RFC tag dropped as the SMMUv3 accel series is now applied.
 - Addressed feedback on RFC and collected tags. Thanks!
 - Introduces an ops interface to factor CMDQV specific
   behavior out of the base implementation(patch #5)
 - Split read/write implementation to multiple patches(10-12)
 - Only map the VINTF page0 MMIO region to guest(patch #15)
 - Add per-device identifier property to SMMUv3 dev so that
   both Tegra DSDT and SMMUv3 IORT uses the same identifier
   (patch #22)
 - TODO: There was a suggestion to factor out common code for vEVNTQ
   read side function. I have left it as is for now.

Please find the complete branch here:
https://github.com/shamiali2008/qemu-master/tree/master-veventq-v4-vcmdq-v2

I have sanity tested this on an NVIDIA GRACE platform and will
continue with additional tests.

Feedback and testing are very welcome.

Thanks,
Shameer

---
Background(from RFCv1):

Thanks to Nicolin for the initial patches and testing on which this
is based.

Tegra241 CMDQV extends SMMUv3 by allocating per-VM "virtual interfaces"
(VINTFs), each hosting up to 128 VCMDQs.

Each VINTF exposes two 64KB MMIO pages:
 - Page0 – guest owned control and status registers (directly mapped
           into the VM)
 - Page1 – queue configuration registers (trapped/emulated by QEMU)

Unlike the standard SMMU CMDQ, a guest owned Tegra241 VCMDQ does not
support the full command set. Only a subset, primarily invalidation
related commands, is accepted by the CMDQV hardware. For this reason,
a distinct CMDQV device must be exposed to the guest, and the guest OS
must include a Tegra241 CMDQV aware driver to take advantage of the
hardware acceleration.

VCMDQ support is integrated via the IOMMU_HW_QUEUE_ALLOC mechanism,
allowing QEMU to attach guest configured VCMDQ buffers to the
underlying CMDQV hardware through IOMMUFD. The Linux kernel already
supports the full CMDQV virtualisation model via IOMMUFD[0].

Summary of QEMU changes:

 - Integrated into the existing SMMUv3 accel path via a
   "tegra241-cmdqv" property.
 - Support for allocating vIOMMU objects of type
   IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV.
 - Mapping and emulation of the CMDQV MMIO register layout.
 - VCMDQ/VINTF read/write handling and queue allocation using IOMMUFD
   APIs.
 - Reset and initialisation hooks, including checks for at least one
   cold-plugged device.
 - CMDQV hardware reads guest queue memory using host physical addresses
   provided through IOMMUFD, which requires that the VCMDQ buffer be
   physically contiguous not only in guest PA space but also in host
   PA space. When Tegra241 CMDQV is enabled, QEMU must therefore only
   expose a CMDQV size that the host can reliably back with contiguous
   physical memory. Because of this constraint, it is suggested to use
   huge pages to back the guest RAM.
 - ACPI DSDT node generation for CMDQV devices on the virt machine.
---

Nicolin Chen (14):
  backends/iommufd: Update iommufd_backend_get_device_info
  backends/iommufd: Update iommufd_backend_alloc_viommu to allow user
    ptr
  backends/iommufd: Introduce iommufd_backend_alloc_hw_queue
  backends/iommufd: Introduce iommufd_backend_viommu_mmap
  hw/arm/tegra241-cmdqv: Implement CMDQV init and vIOMMU allocation
  hw/arm/tegra241-cmdqv: mmap VINTF Page0 for CMDQV
  hw/arm/tegra241-cmdqv: Emulate global CMDQV registers
  hw/arm/tegra241-cmdqv: Emulate global and VINTF VCMDQ register reads
  hw/arm/tegra241-cmdqv: Emulate global and VINTF VCMDQ register writes
  hw/arm/tegra241-cmdqv: Allocate HW VCMDQs on base register programming
  hw/arm/tegra241-cmdqv: map VINTF page0 MMIO region
  hw/arm/tegra241-cmdqv: Add reset handler
  hw/arm/tegra241-cmdqv: Limit queue size based on backend page size
  hw/arm/virt-acpi: Advertise Tegra241 CMDQV nodes in DSDT

Shameer Kolothum (10):
  hw/arm/smmuv3-accel: Introduce CMDQV ops interface
  hw/arm/tegra241-cmdqv: Add Tegra241 CMDQV ops backend stub
  hw/arm/smmuv3-accel: Wire CMDQV ops into accel lifecycle
  system/physmem: Add address_space_is_ram() helper
  hw/arm/tegra241-cmdqv: Use VINTF page0 for mapped VCMDQ registers
  hw/arm/tegra241-cmdqv: Add vEVENTQ allocation and free
  hw/arm/tegra241-cmdqv: Read and propagate Tegra241 CMDQV errors
  virt-acpi-build: Rename AcpiIortSMMUv3Dev to AcpiSMMUv3Dev
  hw/arm/smmuv3: Add per-device identifier poroperty
  hw/arm/smmuv3: Add tegra241-cmdqv property for SMMUv3 device

 backends/iommufd.c       |  65 ++++
 backends/trace-events    |   4 +-
 hw/arm/Kconfig           |   5 +
 hw/arm/meson.build       |   3 +-
 hw/arm/smmuv3-accel.c    |  73 +++-
 hw/arm/smmuv3-accel.h    |  24 ++
 hw/arm/smmuv3.c          |  15 +
 hw/arm/tegra241-cmdqv.c  | 778 +++++++++++++++++++++++++++++++++++++++
 hw/arm/tegra241-cmdqv.h  | 340 +++++++++++++++++
 hw/arm/trace-events      |   5 +
 hw/arm/virt-acpi-build.c | 121 ++++--
 hw/arm/virt.c            |   3 +
 hw/vfio/iommufd.c        |   4 +-
 include/hw/arm/smmuv3.h  |   3 +
 include/system/iommufd.h |  17 +
 include/system/memory.h  |  10 +
 system/physmem.c         |  11 +
 17 files changed, 1447 insertions(+), 34 deletions(-)
 create mode 100644 hw/arm/tegra241-cmdqv.c
 create mode 100644 hw/arm/tegra241-cmdqv.h

-- 
2.43.0


