Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97279FC592B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvYyM-0003ve-Gx; Thu, 26 Feb 2026 05:51:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYyK-0003uq-I0; Thu, 26 Feb 2026 05:51:56 -0500
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYyI-0000ev-L7; Thu, 26 Feb 2026 05:51:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YC1YexIh1Davlz/p11v4LrPnui3vY02rKEwCBKlHI9jy/DUQrxs/JtBz0LtUW8UPPO5895ZX/oz+jQcGeZkT7EDcQs+33ds6onXdXo2044gR2tLqGDiM7tUB6Qb5MPSgVQaL4shkjbG2jF9mFs5lPEoDvBpqohRGSbIW9ARqbItEF6JcOVFJn4gKRV1bB8ExGYin/Hf29cS60ZXfAkFIWqc82ceS8Z9+wpxyPYgibuUVcSpa5oMKt4mPhOtdldKclvyiMelDTepq8PLqEYbngdIo0Z03InWfGKmmMPc5H0xenYWpufitd9+KPAZ0cd5eZnnvc4afWu7IraVVPpsDCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzghLJZnlpYtAJY+cWgaThkmNtnVWe9tFGzjehGplDg=;
 b=p0nIcrDPt4m9PdTMtNQ+G4UYs5wnVKK+7/K2jM/ckqs/U1YBBZNfkUuzUrQGMz9EU1Yv46VTwjaAEglVjTQem+a3afGRRBIMEioElucB3hHhEUXoLcDqcT4bTKVxNN26/clTv1Y2qryzEoNbZDp5iHP7fBpKW9OdS3PDNPnJ+3Ux3vjou1KDXo5X+1un9SPsjXTD3jJ2BZOQGTYs6C67oxW+rlwYczQxLLzgbKV1vwbcJFKnLtOWCOQLKbiIqIP8Xj6ZNeQwnggMH7GiqBGERYK7D1pDu6ZFcpVlgXoK2+NZao8rjivnqxWuyAPwhR8P6pfr+9DKsqLo8AkIotLNig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzghLJZnlpYtAJY+cWgaThkmNtnVWe9tFGzjehGplDg=;
 b=tXMQuBcXg1eDEFUOf4KrX75Qzm09y2WpSj0FZEKPlMXiy9A+hicixLoyTJHEyGk+neE5pd2tLpnO/M3D4Pe4H+eIPIMHkq1UNRPyzgT3SglmMXTOI3ywzTv6ghXvvJWZCrxHNsCC9NZmv+UqrVTlYKnSgVnkOTl1UHRxnDFHjiOT43BPXgBH7wbSzVnNhne+PIK7RoTgrcfNhYhdLllOi/VR8HKp3Kv5CLfOnP4xYndldBNW1PjcOCe+N4PptZqV1c6iVD0s6BicIALsxH9o0ei3Zas89qQAwaWtWGhO0zoLd8k7p2WvuDIFXx5EnL3YdJHqgSDJpPFXz2rzNsImKw==
Received: from SA1P222CA0093.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::18)
 by MW6PR12MB9018.namprd12.prod.outlook.com (2603:10b6:303:241::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Thu, 26 Feb
 2026 10:51:45 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:806:35e:cafe::b8) by SA1P222CA0093.outlook.office365.com
 (2603:10b6:806:35e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.25 via Frontend Transport; Thu,
 26 Feb 2026 10:51:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 10:51:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:51:23 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:51:20 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v3 00/32] hw/arm/virt: Introduce Tegra241 CMDQV support for
 accelerated SMMUv3
Date: Thu, 26 Feb 2026 10:50:24 +0000
Message-ID: <20260226105056.897-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|MW6PR12MB9018:EE_
X-MS-Office365-Filtering-Correlation-Id: e976eb22-fec4-44b1-8737-08de75250883
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: boloy5TcZe6SY4vAvumvdKDGbRh/NfnfPM1AWSU9AJROGILi6eCCP5DG61wd+3pYFd6ZmhsM2FuyoFeJ8L+3Z0iz6dSnLNAueyJ29kQrRRc+TLKNNGCqWXRYGojC5q/xJMgSpen9MKBEYJwW8RWpSTZ9b37vqb8ku4Y7AvKP/tlpW/G0teMIUePvRboxuajepxSqugN/womgTfXq4hb5D5dMQHjUOZSaN49TqX8MsNe8ehJwXBs8E23Ypsn/RPHMPuMVrmg/SiOlZmzKy2TtUOSpOkJrMpfRe1/tZG4CnL7z6G7cqtqFy5cbprbkg449+lIKzrBj+jBkFN5OOD4P0Ttl/2m7rPPNfBSt3Tl4bhZycz8Khu0as3Lo90pjGpEPXw51MPAg0AsDMmVCLPfl81X5b98gQIvf3eWXoYbIM7xqOmNUOwUMLNPPuyOlbre4GWrp0zKwMsQvpd7bIwwXxvKBmVW5nWVJpqjzzXubnUcASmYDqP4FRns80bLleQKUHSRvlflBp7zgNxJvLoFVTMbIEHM/j9upzf6ck6PRVvAc2fTTJfbgxQFLraK6AW4ACcDdKwd2PkS+ADljR63+3VdlbfuJo6Npj2ZvJgfK6g7yvL2BEVwJBiEWmzgnmMaHOqTdMEiXkoY+iBz0CLDM1o48wDShkSnfbq/suth3aNrZeRvzp814vemvi1e8XDTxBBljrPnOxHk2mDAwODyVkQgMnunIPLq64sBnXR1+lYkeze1mH8LU5aKYdijbdUJXoZ691FbCdCzZGy0+fd1A14WBItEmAuWZewGCk2jfF7zdqiQ9R1lWknVdD+ktl3TwVqTp6XKsZORGpGrqPMqyyA==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: R8d+I9mUlwHKWhBc9dC6sNt93lUPpF1H1xTmChar1rO6bP42oKJUgu8uwXJRPHu93upjjwAYoc6juFVjhHsjM2zFH1w1ItrxONYdqW3bVpClHIYV6McOG8nmSwe9CcPeaz1JM615JX9KTMVvZXQ+QKsiCZekW5VoqNJYMX/asAIqLS07KyEcXLrCZnLjHxA283XyNnjbvsVS6cCl0rbTf1NRgCzBsQBkSFAlsbK+bJwmnvqJRV9Ikd1ZeuxDKc/4GUU8w3XhTdc9vFTg+yGTDtx9hJhXvg7cANYOzwQWYxNerVHeBwoiUwTij6QWyQA6+i2GS9YEXQ+wSEFq5OgIyxLyvDb4p6RvNZyVDGfCxJBRqSCuzx0/THVc/rGqbDHEACab1IMD5AFMWb3fT+umC+C+c9vNFsPpSkCZmejXqxUB0spSjibnx/+Lg8iv0iej
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 10:51:44.8564 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e976eb22-fec4-44b1-8737-08de75250883
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9018
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Changes from v2:
 https://lore.kernel.org/qemu-devel/20260206144823.80655-1-skolothumtho@nvidia.com/

  - Addressed feedback on v2 and picked up R-by tags. Thanks!
  - Renamed the property from "tegra241-cmdqv" to a generic OnOffAuto
    "cmdqv".
  - Introduced a probe() callback to detect and initialize CMDQV
    support during device attach (patch #7).
  - Since CMDQV initialization is now deferred to device attach time,
    added a helper to link any unmapped MMIO/IRQ resources (patch #12).
  - Moved VINTF enable handling to the CONFIG ENABLE bit write path
    instead of any read/write access path (patch #17). Hopefully this
    won't break any corner cases.
  - Added checks for VINTF and CMDQV ENABLE bits before allocating
    vCMDQ HW queues, and free any allocated resources if disabled
    (patch #19).
  - Introduced a common helper for vEVENTQ read and validation
    (patch #23).
  - Updated bios-tables test IORT blobs for SMMUv3 device identifier
    changes (patch #29).
  - Rebasing on top of Philippe's CONFIG_DEVICES cleanup series [0],
    using tegra241-cmdqv-stubs.c (patch #6).

Please find the complete branch here:
https://github.com/shamiali2008/qemu-master/tree/master-veventq-v8-vcmdq-v3

I have sanity tested this on an NVIDIA GRACE platform and will
continue with additional tests.

Feedback and testing are very welcome.

Thanks,
Shameer
[0] https://lore.kernel.org/qemu-devel/20260225031658.32095-1-philmd@linaro.org/

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
  hw/arm/tegra241-cmdqv: Emulate global CMDQV registers
  hw/arm/tegra241-cmdqv: Emulate global and VINTF VCMDQ register reads
  hw/arm/tegra241-cmdqv: Emulate global and VINTF VCMDQ register writes
  hw/arm/tegra241-cmdqv: mmap VINTF Page0 for CMDQV
  hw/arm/tegra241-cmdqv: Allocate HW VCMDQs on base register programming
  hw/arm/tegra241-cmdqv: Map VINTF page0 into guest MMIO space
  hw/arm/tegra241-cmdqv: Add reset handler
  hw/arm/tegra241-cmdqv: Limit queue size based on backend page size
  hw/arm/virt-acpi: Advertise Tegra241 CMDQV nodes in DSDT

Shameer Kolothum (17):
  hw/arm/smmuv3-accel: Introduce CMDQV ops interface
  hw/arm/tegra241-cmdqv: Add Tegra241 CMDQV ops backend stub
  hw/arm/smmuv3-accel: Wire CMDQV ops into accel lifecycle
  hw/arm/virt: Store SMMUv3 device objects in VirtMachineState.
  hw/arm/virt-acpi-build: Use stored SMMUv3 devices for IORT build
  hw/arm/tegra241-cmdqv: Probe host Tegra241 CMDQV support
  hw/arm/virt: Link SMMUv3 CMDQV resources to platform bus
  system/physmem: Add address_space_is_ram() helper
  hw/arm/tegra241-cmdqv: Use mmap'ed VINTF page0 as VCMDQ backing
  hw/arm/tegra241-cmdqv: Add vEVENTQ allocation and free
  hw/arm/smmuv3-accel: Introduce common helper for veventq read
  hw/arm/tegra241-cmdqv: Read and propagate Tegra241 CMDQV errors
  tests/qtest/bios-tables-test: Prepare for IORT SMMUv3 node identifier
    change
  hw/arm/smmuv3: Add per-device identifier property
  tests/qtest/bios-tables-test: Update IORT blobs for SMMUv3 identifier
    change
  hw/arm/smmuv3-accel: Introduce helper to query CMDQV type
  hw/arm/smmuv3: Add cmdqv property for SMMUv3 device

 hw/arm/smmuv3-accel.h                         |  29 +
 hw/arm/tegra241-cmdqv.h                       | 342 ++++++++
 include/hw/arm/smmuv3.h                       |   3 +
 include/hw/arm/virt.h                         |   1 +
 include/system/iommufd.h                      |  16 +
 include/system/memory.h                       |  10 +
 backends/iommufd.c                            |  64 ++
 hw/arm/smmuv3-accel-stubs.c                   |  11 +
 hw/arm/smmuv3-accel.c                         | 196 ++++-
 hw/arm/smmuv3.c                               |   9 +
 hw/arm/tegra241-cmdqv-stubs.c                 |  18 +
 hw/arm/tegra241-cmdqv.c                       | 793 ++++++++++++++++++
 hw/arm/virt-acpi-build.c                      | 126 ++-
 hw/arm/virt.c                                 |  27 +
 hw/vfio/iommufd.c                             |   4 +-
 system/physmem.c                              |  11 +
 backends/trace-events                         |   4 +-
 hw/arm/Kconfig                                |   5 +
 hw/arm/meson.build                            |   2 +
 hw/arm/trace-events                           |   5 +
 tests/data/acpi/aarch64/virt/IORT.its_off     | Bin 172 -> 172 bytes
 tests/data/acpi/aarch64/virt/IORT.msi_gicv2m  | Bin 172 -> 172 bytes
 tests/data/acpi/aarch64/virt/IORT.smmuv3-dev  | Bin 260 -> 260 bytes
 .../data/acpi/aarch64/virt/IORT.smmuv3-legacy | Bin 192 -> 192 bytes
 24 files changed, 1596 insertions(+), 80 deletions(-)
 create mode 100644 hw/arm/tegra241-cmdqv.h
 create mode 100644 hw/arm/tegra241-cmdqv-stubs.c
 create mode 100644 hw/arm/tegra241-cmdqv.c

-- 
2.43.0


