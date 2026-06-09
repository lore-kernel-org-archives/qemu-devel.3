Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 527C7CD8CAD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWuc1-0006GS-Bp; Tue, 09 Jun 2026 07:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWuby-0006Fl-Oo; Tue, 09 Jun 2026 07:27:14 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWubw-0002wN-FG; Tue, 09 Jun 2026 07:27:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yhUGWU1A4RD+AC5i1gSdXUQAg2Cb9tZWXbeoL62vGKpcM+OUGvsZXPBrDEi4SboU9T0myzWV/YrnpDrhBX00NkzHdeO03G2qGfLiX3x3dXyJbwBq0oVWE6J8ZW1nTKGT9bptP0cWz32OXVXXyBKh3Xu049wHS72Dt6jC1yBMaqvOQOzKEPEJfweM5Fs+H+7nZFvLlBbnetJmE4oiKVeHLSo7/aM12fDcLvPSUqq+wdqCCGN/G9QQ7k/ff9EdCgaFqN9fyOEhC2Oj29bC21PF/zh55c7I7Oa3endIeDhRXLCrvlxrV9XBYjXXw92CQg7KD6usGr71S6rryov11D+0Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7H69ATIfcC6/Nd7r/K5dCji4q+oUH8Fp1U8f/1sF/1g=;
 b=gadQ5VbWYHn/Ekbv7Alo4RmMEXT6R+YZJK3Cg2U1WWZCImHiF3PvD6Ph+KZwp6lAexe4XPuAyw25FLpm/4/xVFMnWaaqKoyqdNukiRbPZngxbrhZpTNwAGNRJQjpxwtLkL9NLApYGDYuLFf6Ny4cEhaCjVirUhTCzo501rZsp7u9HjeTTmZuF+zcRB8wy0ggA0/Ey4NmXX4xwbJh00ocpzMpLfxPWdPxn0SY0Up6AEL3by3MO+PCejICYaI5XjYcGXENlXYs8Y+F7nC6bJEDft8BFur2ENkWhdDD7oN9plzq8fMILSp0P8kultCIA1FHoFahYtA2rewNpt1OHamwNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7H69ATIfcC6/Nd7r/K5dCji4q+oUH8Fp1U8f/1sF/1g=;
 b=qkDonO1z1Xi6Jb7TTyjwtokO8wWAxKRnKca1Bj1Wm9v8hmOXlbL6Jgg5b82kxxrzSAq//QJ+UYMiiAB7dj3RzBag0WIiCkYWuaKHVN5XhkKDASoyFdDCt7URJLUs8kvJbbEmBZXBygw5XCPorsoY4I1enY4de4AxSIcECEtxieqMgtPo8E36+yal/zrN63JA1PW+ijTNhAJVzQUfsyEWbW7mYoHtfqbwKR0BKjD5bcb6PsOigPbZ999t8Vw6qT4zxvDFNM4XJHe7Eh6rKK5M3iQS0/sk3JYFiEhZlV3Ue6yF6jI9bHIAgkZBRr3AoBPIovxvYiGJCjwrThtrAg8VFg==
Received: from BL1PR13CA0206.namprd13.prod.outlook.com (2603:10b6:208:2be::31)
 by IA1PR12MB7544.namprd12.prod.outlook.com (2603:10b6:208:42c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 11:27:02 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:2be:cafe::26) by BL1PR13CA0206.outlook.office365.com
 (2603:10b6:208:2be::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 11:27:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 11:27:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:26:35 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:26:24 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v7 00/31] hw/arm/virt: Introduce Tegra241 CMDQV support for
 accelerated SMMUv3
Date: Tue, 9 Jun 2026 12:25:21 +0100
Message-ID: <20260609112552.378999-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|IA1PR12MB7544:EE_
X-MS-Office365-Filtering-Correlation-Id: 52caf7f7-31a2-47a4-1d5b-08dec61a065b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|13003099007|6133799003|18002099003|3023799007|5023799004|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Nm6Q59LID3pP2hBhGGSmpwGxiQ8OSS9MD2Bar7SMlTP/oo3aUKMKXLTgcfG2wW9S0UD8jmiegEI2puvuAGxMKxy+Wwc2UAb9nf931ziPpgAUMKh7YhVKFT5jEyoK0cfT+8tIGoGJ2+YalWrsXfi/eYjqaCy2qOeh/jyOcbAhITPAAY3pXG0OBQLDyMf26MfdZoXtumo+gnoUPth15tZ/x9B78jM9/1a5TLTMgOxwhMMuqgd4cAmv/dR5HiRRCesvsJbXhmVNwnjt5PWOR0kRDmh2tSVe7ZOQWhLa22AzR3cqjY4zBWrIPRchlzUTIP5BYLx3nW1x/rKt5FV6muO2BDAPPO7RDvQS5myo4EsSLX+9wgJDaR1vigM6lcoBC7ntULunWoO0XOCkbNHIoZGbjjRt7YN/x2v0Bcql/ingAzDbvBame9j3Zgsqo3tlH/ynWUP7yFQFQiUf5nN4Ub+qIEbm7vyJLkJo2Tnq/sknqn2GTYbH8qZ2RmRG/Vs0B3x2kNi4pT3lkEDJGnj8vvYtftbAOBdL6ICijwqhZEVt60ZL6lcnBj3ziBPSNIcTnsWaK+2DS1/tM2RuXaG22mdZYkruoszMGKA+jxOi/OBttNH8SID6lfsXCj5RxPUAV7sMmzA+n3BNJ/5KtYY9z5l24/6vmfqgvPHj7LdEH9Xq3eKWA1KeLB50EJ7eS4MVAk0D1gJof7rk0FE7I1oVWlqF17g9rs5xi1iEFctSklJbeSYPD5+0EujoV9E7NRZsHyox
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(13003099007)(6133799003)(18002099003)(3023799007)(5023799004)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3xsmO0VI5ESjfX1mDBosBzxzAYTAtIg5m11KGYibo+rR7fEOB+YQabu0MDtRz3SLkaUOlJjbctga4NvRQ539sMnyFDqV8errm2TiN9dvL/i2w6E3Z08oh9uqCozg/Ty1AmoRpGcZnkf/+w/cXQIK7TyAAxzUfQQncte3mmoGFO7huBVtN9sqIKjV0M9FJPufjriQHW1Xar5Yns0hC8qmc7aZVGK9YYTPRERqVoS1JvQIJ2HCLxvzLHeM+Zy2c2/edpQScBBSJ9Id3cQHBYDu+ugf7c9C+B4KmP0Cx4/5uwWGDQk3jcBeKD8UpO2TSfhtSk+eH3/ShIVD+zMnefGy2tDFI3bJkQ/q7wajRTlGzi6kBpFyZEN8sGhQM4S+vZFahay95hM1ZJOfjxWJ8gbal4iHiTmC2NwLio+vqex7/11dZadnfcGg/Ul18Ob8eYgN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 11:27:00.9164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52caf7f7-31a2-47a4-1d5b-08dec61a065b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7544
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Changes from v6:
 https://lore.kernel.org/qemu-devel/20260601114221.457995-1-skolothumtho@nvidia.com/

 - Addressed v6 feedback and picked up R-by/T-by tags. Thanks!
 - mmap the host VINTF Page0 at IOMMU_VIOMMU_ALLOC instead of on VINTF
   enable (patch #14)
 - Reset the per-VCMDQ Page0 cache when a queue is freed (patch #19)
 - Distributed the reset teardown into the patches that introduce each
   resource (patches #18, #21)
 - Added a VCMDQ readiness helper and renamed the Page0 backing-pointer
   helper to vintf_lvcmdq_ptr() (patches #18, #19)
 - Trace the VCMDQ Page0 backing, hw vs cache (patch #19)
 - Renamed patch #24 to reflect the changes accurately
 - Updated the design and lifecycle documentation (patch #30)
 - Based on top of Nathan's "Resolve AUTO properties" v6 series [0].
 
Please find the complete branch here:
 https://github.com/shamiali2008/qemu-master/tree/master-vcmdq-v7-ext
 
Sanity tested on NVIDIA Grace. Further testing in progress.

Feedback and testing are very welcome.

Thanks,
Shameer
[0] https://lore.kernel.org/qemu-devel/20260608174900.2227340-1-nathanc@nvidia.com/

---
Background(from RFCv1):
https://lore.kernel.org/qemu-devel/20251210133737.78257-1-skolothumtho@nvidia.com/

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
---

Nicolin Chen (15):
  backends/iommufd: Update iommufd_backend_get_device_info
  backends/iommufd: Update iommufd_backend_alloc_viommu to allow user
    ptr
  backends/iommufd: Introduce iommufd_backend_alloc_hw_queue
  backends/iommufd: Introduce iommufd_backend_viommu_mmap
  hw/arm/tegra241-cmdqv: Implement CMDQV init
  hw/arm/tegra241-cmdqv: Implement CMDQV vIOMMU alloc/free
  hw/arm/tegra241-cmdqv: mmap host VINTF Page0 for CMDQV
  hw/arm/tegra241-cmdqv: Emulate CMDQ-V Config region
  hw/arm/tegra241-cmdqv: Emulate VCMDQ register reads
  hw/arm/tegra241-cmdqv: Emulate VCMDQ register writes
  hw/arm/tegra241-cmdqv: Allocate HW VCMDQs once configured
  hw/arm/tegra241-cmdqv: Use mmap'd host VINTF page0 for virtual VINTF
    page0
  hw/arm/tegra241-cmdqv: Initialize register state on reset
  hw/arm/tegra241-cmdqv: Limit queue size based on backend page size
  hw/arm/virt-acpi: Advertise Tegra241 CMDQV nodes in DSDT

Shameer Kolothum (16):
  system/iommufd: Remove unused viommu pointer from IOMMUFDVeventq
  hw/arm/smmuv3-accel: Introduce CMDQV ops interface
  hw/arm/tegra241-cmdqv: Add Tegra241 CMDQV ops backend stub
  hw/arm/smmuv3-accel: Wire CMDQV ops into accel lifecycle
  hw/arm/virt: Use stored SMMUv3 device list for IORT build
  hw/arm/tegra241-cmdqv: Probe host Tegra241 CMDQV support
  hw/arm/virt: Link SMMUv3 CMDQV resources to platform bus
  hw/arm/tegra241-cmdqv: Route allocated VCMDQ Page0 accesses to the
    mmap'd host VINTF page0
  memory: Allow RAM device regions to skip IOMMU mapping
  hw/arm/smmuv3-accel: Introduce common helper for veventq read
  hw/arm/tegra241-cmdqv: Read and propagate Tegra241 CMDQV errors
  hw/arm/smmuv3: Add per-device identifier property
  hw/arm/smmuv3-accel: Introduce helper to query CMDQV type
  hw/arm/smmuv3-accel: Enforce viommu association when CMDQV is active
  hw/arm/tegra241-cmdqv: Document the CMDQV design and lifecycle
  hw/arm/smmuv3: Add cmdqv property for SMMUv3 device

 hw/arm/smmuv3-accel.h         |   48 ++
 hw/arm/tegra241-cmdqv.h       |  384 +++++++++++
 include/hw/arm/smmuv3.h       |    3 +
 include/hw/arm/virt.h         |    1 +
 include/system/iommufd.h      |   17 +-
 include/system/memory.h       |   21 +
 backends/iommufd.c            |   64 ++
 hw/arm/smmuv3-accel-stubs.c   |   12 +
 hw/arm/smmuv3-accel.c         |  194 ++++--
 hw/arm/smmuv3.c               |   10 +
 hw/arm/tegra241-cmdqv-stubs.c |   16 +
 hw/arm/tegra241-cmdqv.c       | 1119 +++++++++++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c      |  127 ++--
 hw/arm/virt.c                 |   37 ++
 hw/vfio/iommufd.c             |    4 +-
 hw/vfio/listener.c            |    6 +
 system/memory.c               |   10 +
 backends/trace-events         |    4 +-
 hw/arm/Kconfig                |    5 +
 hw/arm/meson.build            |    2 +
 hw/arm/trace-events           |   11 +
 hw/vfio/trace-events          |    1 +
 qemu-options.hx               |    8 +
 23 files changed, 2024 insertions(+), 80 deletions(-)
 create mode 100644 hw/arm/tegra241-cmdqv.h
 create mode 100644 hw/arm/tegra241-cmdqv-stubs.c
 create mode 100644 hw/arm/tegra241-cmdqv.c

-- 
2.43.0


