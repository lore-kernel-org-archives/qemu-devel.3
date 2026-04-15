Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A703F41992
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 10:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCxvj-0000Wr-VA; Wed, 15 Apr 2026 06:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxvi-0000W5-4x; Wed, 15 Apr 2026 06:57:10 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxvg-0003sL-4T; Wed, 15 Apr 2026 06:57:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2tltgc00ACNj8pMFU/s3FZlAPvyVwBwQb9tfc1ufEVeA2zJTdyr2aGMWIV72cU9DcCR5Wl2K6AHZpr4vlt11ywXYRBuu6RRuXeZlWj6ILGLNiRyou9m6aj1UvrblUo8jSfiIY7YxQNGSj59ZLOpWaOuQOAkj5s8oP+7nlG7tVMB3yH3Z5KrTwYrzxT+iLkHRaDH2p75Fb6qvoAVMAzqdz2UBxRtTY4rx3aSH1EfK0Eed1CwEuT8+JOeyeLlFvW2HfpiA9zdAL3p7JxOu4mBBDo2hAKk9i2A7bAZuExMbTDaOOTUB2Vo18llF2MNlF+YbfrHdQbhtofmwPPG+biJ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWrX++J/LkC2WchYnOOjCEkxqOotAIEcPw6Bl4n/F3w=;
 b=L9BEaznV66/fg4zQg/b8wwmgo19aiyrJBKZ1O8Kov++RG7isi5CfpYgnvVtJU6Hq+PwbOCND3Ht2ANhKiRj7mZ+EqkkXxlEYZDidpxgCCymYz4559sp818wv+AQNEVA1y7aHRspjL9nIPfSPT50ylVTw3Bgy5EcacfwADaif2H/xxZzldJ6kt8pIrbZTgcprPBN+INkZGYww9q60Bvc0y4BDEl34Q7BIXqMaCpT08nvGMkq8cMIR/CGOlDlgizUR9D2LDjhqG/1HdH6NbKCpAj1V7/dhKZhdFfB/TqKDYeYPJr/4PSChQ9XLKDh4frBKWsqLfq27KKaA9jnBoiYh3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWrX++J/LkC2WchYnOOjCEkxqOotAIEcPw6Bl4n/F3w=;
 b=E1Mih2iHgBQO7wXtQwMQl4SppSPJ7wHaeq2waMRQw5MK5QZaOgXhpQNjjUxnSdf/4yC5cwYdOgPLmIkPFYOXdfZy5ZG4Gzm1LFvfhpqize/hSKS2/NyTM24f9M4V61nSfDMVC+9EdSI5UAXAYbKAIAq34RWpIzYCxFsS2C9ptPO7JSJLeeT6+DmrnHGZGuCELQKvzGXdz20otw3kiw+PdGUE2Lurz2lyggPkD4/4OGhAECa4zTsmuHyWBZICpja54s7qsmt+wQ/zxKGdTItAuXQNBy6fbKIKqduy2kDa7A05GvXnjH545OYyzNoqciqI7cqRtJlVunsDWv645QoAbQ==
Received: from PH0P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::23)
 by SJ5PPF8AECCE022.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::99c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 15 Apr
 2026 10:57:01 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::c2) by PH0P220CA0023.outlook.office365.com
 (2603:10b6:510:d3::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Wed,
 15 Apr 2026 10:57:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 10:57:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:56:29 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:56:26 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v4 00/31] hw/arm/virt: Introduce Tegra241 CMDQV support for
 accelerated SMMUv3
Date: Wed, 15 Apr 2026 11:55:21 +0100
Message-ID: <20260415105552.622421-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|SJ5PPF8AECCE022:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f551248-af9f-4bf9-5bec-08de9addb885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|13003099007|18096099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: T2/Wewn0aFz9dy0q90vkDGtYlk+pRGYVkh7s2ljItElC37/PzqAyB08fkUAxqNw3O6yqXxx2wE1YVdDBY+fjFUFZsyYH4CsCCggVNr5h42YBC15d6n+OL0tedxaiUzm8DAuH0wxEtcgm5WamJoeaIAwEpMp87P+WK3EyUW5AvmHkMp8bf2S/Nv863ZFZAbIoyuAQWHdHYG9nCT2IfdBDcEXshPiPBa2Eoxo+WNwsHFtNAQJYDFc4C7F+TuXsA0Wwos8fyqyt4ME7zvbRWsYg4cOVucffUS8fYL+G5DxrbedRKbx/BJqUb7nZ8bdht1QbaxCag3wBSXBw2ss1w9qJi1MwDlGGVoPT12Gp+ot/X8MAELrzvN9jggjXIvKTagY7ahmdN++mgOdl1tmHwCM+fZUYzhcfzE/FHL8oAEoRfbYL1/tnshF0DhVgnLPS07RAO1MG4GnpFrD9chmXCEv+QlzSlajgmUMIK/XE9ocVeIwMiFM2MmNncNuzZvldsZedbj7ElVisDMVfTjWV66l3QyWwrcpnJZda9j3/eG7afFlCrp9AbbKJrNfg16fVhd9ET5WHfdzF8rIWEzO1imt0iMRBnEQL8mDZTy6Qgqfnv0KOwIBYgCmVn2hkDzgtqNJr05fM3wWI1CiCIx1MFOFc2DgRqPRwX9CpbJ/37+CjPjtnB/TE6ovpjGkCuFtZjqvsWUVFVoiv7w0B6irEo0Bpbhx+1uGfyOIZTgrSg+TPadSFKZ6NddxeX7QybX7ytimH6iUs274LdU8bGWmH6whfrA==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(13003099007)(18096099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: P30Ht3T+Ha8a55Y/2cXFfnUyPtpicU3v0nGwsktb1cS9pDrF3QvJ67hsSfF8jBt7gKaGQFvLQ66SsCoJeE3wN0TPp8il3ruqi7TxBeTbeKW3aSFB5UMlUjIavLEIXjSya5a2fr/ObhjfmZiaKQqkuTjD4o0tuTYv5ypEkiKKZv+N/BjrcMnM109gimfhb3fAWe+ElonJm3zgmlNDiFpLJe6nK3Aznq5akK5QTIUy/YG7Ofl2q7v2/mDA7yQqpU18+aqSI/cZpMvqLQqw0aqeNE/FvcGAJk2zhosMJt/LLqLHg3329HCe7XTUyuBbeADJqHsc2WP+TtmTsQKWXiMZi95vgviFSGVkWUfCgA5JyxApbjPxpmqTtLXRiIJpw/s8ImVD5zvzxLN9qfDkc26YbBo9mPsDCV6T9USiceCUggq15bh+5LJHqaME2S9vs4FN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 10:57:00.6074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f551248-af9f-4bf9-5bec-08de9addb885
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8AECCE022
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Changes from v3:
 https://lore.kernel.org/qemu-devel/20260226105056.897-1-skolothumtho@nvidia.com/

 - Addressed v3 feedback and picked up Reviewed-by tags.
 - Folded veventq alloc/free into alloc_viommu/free_viommu, removing
   the separate ops callback (patch 13).
 - Reworked register and macro names based on feedback.
 - Improved documentation around VCMDQ aperture usage, which was a
   source of confusion in v3. See patches 15, 16, 17, 19 and 20.
   Patch 20 in particular explains the cached register vs hardware-backed
   MMIO model for VCMDQ apertures. Hope this is clearer and correct now!.
 - Added patch 21 to skip IOMMU mappings for RAM device regions,
   eliminating spurious "IOMMU_IOAS_MAP failed: Bad address" warnings
   for the VINTF page0 guest mapping.
 - Updated SMMUv3 identifier property to accommodate the ITS node id
   (patch 27).
 - Removed qtest bios-tables blob patches; node id changes are now
   handled in patch 27.
 - Based on top of Nathan's "Resolve AUTO properties" series [0].
 - Added patch 30 to enforce viommu association stability when CMDQV
   is active.

Please find the complete branch here:
https://github.com/shamiali2008/qemu-master/tree/master-vcmdq-v4-ext

Sanity tested on NVIDIA Grace. Further testing in progress.

Feedback and testing are very welcome.

Thanks,
Shameer
[0] https://lore.kernel.org/qemu-devel/20260401010231.4166776-1-nathanc@nvidia.com

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
  hw/arm/tegra241-cmdqv: Emulate CMDQ-V Config region
  hw/arm/tegra241-cmdqv: Emulate VCMDQ register reads
  hw/arm/tegra241-cmdqv: Emulate VCMDQ register writes
  hw/arm/tegra241-cmdqv: mmap VINTF Page0 for CMDQV
  hw/arm/tegra241-cmdqv: Allocate HW VCMDQs on base register programming
  hw/arm/tegra241-cmdqv: Map VINTF page0 into guest MMIO space
  hw/arm/tegra241-cmdqv: Add reset handler
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
  system/physmem: Add address_space_is_ram() helper
  hw/arm/tegra241-cmdqv: Use mmap'd VINTF page0 as VCMDQ backing
  memory: Allow RAM device regions to skip IOMMU mapping
  hw/arm/smmuv3-accel: Introduce common helper for veventq read
  hw/arm/tegra241-cmdqv: Read and propagate Tegra241 CMDQV errors
  hw/arm/smmuv3: Add per-device identifier property
  hw/arm/smmuv3-accel: Introduce helper to query CMDQV type
  hw/arm/smmuv3-accel: Enforce viommu association when CMDQV is active
  hw/arm/smmuv3: Add cmdqv property for SMMUv3 device

 hw/arm/smmuv3-accel.h         |  29 ++
 hw/arm/tegra241-cmdqv.h       | 367 +++++++++++++++
 include/hw/arm/smmuv3.h       |   3 +
 include/hw/arm/virt.h         |   1 +
 include/system/iommufd.h      |  17 +-
 include/system/memory.h       |  12 +
 backends/iommufd.c            |  64 +++
 hw/arm/smmuv3-accel-stubs.c   |  16 +
 hw/arm/smmuv3-accel.c         | 187 ++++++--
 hw/arm/smmuv3.c               |  15 +
 hw/arm/tegra241-cmdqv-stubs.c |  16 +
 hw/arm/tegra241-cmdqv.c       | 817 ++++++++++++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c      | 127 ++++--
 hw/arm/virt.c                 |  37 ++
 hw/vfio/iommufd.c             |   4 +-
 hw/vfio/listener.c            |   5 +
 system/physmem.c              |  11 +
 backends/trace-events         |   4 +-
 hw/arm/Kconfig                |   5 +
 hw/arm/meson.build            |   2 +
 hw/arm/trace-events           |   7 +
 21 files changed, 1666 insertions(+), 80 deletions(-)
 create mode 100644 hw/arm/tegra241-cmdqv.h
 create mode 100644 hw/arm/tegra241-cmdqv-stubs.c
 create mode 100644 hw/arm/tegra241-cmdqv.c

-- 
2.43.0


