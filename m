Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C087CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU186-0004Td-Bl; Mon, 01 Jun 2026 07:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU17z-0004T5-9q; Mon, 01 Jun 2026 07:48:19 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU17x-0004jS-5K; Mon, 01 Jun 2026 07:48:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HzNj2bafkyY2Tz7mjD/8VLuVFdvtPNvMcSY35wSZtL6zSRlhz7Uu/KrqWTeW+qBGnJqm+W4G2vc0AFvP3j79v+ksJLFnxDwq2aj7Q3h0GnjTgtP15xyE2udbP2ltN7LxLTNHn7EfLw5ESzdOUHgzo5Kd9c5RhIgFUvkCFQ9mBBed06DC0wzhfBfF9E387v8q95/FfuoZgLmcM51v4miLVQ9t2OpqiusMn4qq1U9Lyf0xYB/pNI/C3eXpmvSU+gVhT9ObxxoAMG5vEZVNUiy1Iia6fdfcCvr9qvgJprq/LPFv6ViyM/3pzW6eoyJ8XasCBXGkVieaTtMbDTMZm2NhBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxE8YJVowDhyFEzAK9JEoSOiCg4/kNZTf53QTtkZ1Z4=;
 b=x4kuYD11iyY8ckqVHRnSbA0NnsIiOwEBIRHjoBJQ/S+alj1rSZwrzQW4JsBBDJSFX7VCnP/nb4UpiEl3NedoMZJQRvJj7xXunmI7C5dODnv4jYxhf2R0zeb9VQPSH0T8dCQOH+r9SADP31lWaqv9PHzLKuzNH4yBHXnhOOK2yoJqjKIkmWLdjlQT7ugEXtU9ibdOpuEc4z7CCVj6y2UTAb4UjCjVAgDPGMNpIdgwZoIDhXtFWgIveJd3Y+COGgbFr7jB0G+ED37BLkHhFQZ1d7cAC+vI+w5cCKKjePbsswrUKvlD+fTlt7NEARDySiJbczFHNuv/35lZNhjsOvEuEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxE8YJVowDhyFEzAK9JEoSOiCg4/kNZTf53QTtkZ1Z4=;
 b=bwVwBP2KQB21XbTKi82m/i2LedoJpbNRb5Sg57XFzH4Y4xWLQKdRFuuBg19WDo+CYSyJbxueFBS6rUnUXz6HLI3AHxmCCEDAQkFZ3HHuyUMh46soR73GrthAoAkF5s/ei2pDgHDmKWIgcoSFgtydaoqjXfO0YP1iQmTIwBgqEdZ7a2qj8PoJsVuSPmC3ZxJZUF70jdIUTnUgtjGoB5nFQIXAbhuTKTLOiN+nVt44WrkctZmly63WWPPWG/HFFURK5+73voySN+CUoBx1/vSy4jNPWobr+VQeB0uhkxNWGg/bwwymtAte++2rVoKTTxpH+ChDi8fQTEORgb13P1CmMA==
Received: from BN9P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::34)
 by MW5PR12MB5622.namprd12.prod.outlook.com (2603:10b6:303:198::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 11:48:07 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:408:13e:cafe::22) by BN9P220CA0029.outlook.office365.com
 (2603:10b6:408:13e::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 11:48:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Mon, 1 Jun 2026 11:48:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:47:48 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:47:45 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v6 00/31] hw/arm/virt: Introduce Tegra241 CMDQV support for
 accelerated SMMUv3
Date: Mon, 1 Jun 2026 12:41:50 +0100
Message-ID: <20260601114221.457995-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|MW5PR12MB5622:EE_
X-MS-Office365-Filtering-Correlation-Id: 8089cc78-8355-46e8-6768-08debfd3a5cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|13003099007|18002099003|6133799003|3023799007|5023799004|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 2Ji4UNJNW/xhF1y/nJ+VBhDItKI+IlsylFF+pxz2IZOP2YX5P2gS2A6/vzbKlt9pDXIsQKfuqLL4tKSoUDk73Iyehm4V++xF318aXFaD34LGT2TAg0oKxdCOURU3g3qPW4hKQyUd06BegodZurjSn1++1uEKm/3m4ATAdStlu5oaRO2VOk4eTXI87qttbtzyPiVj5yCPpmMUOus89nZsJvuv9NjvqDMpfUxBqcRpRzzScPjvOimF56Ok4qIJR5mSA6ptDAubMOLCeDg7am0UI9Z6ZHPkHxn5LXNbAdVyF8KpmlIA8Eq8CktE0njTGcGxRdzmEe6IfJr/utxJQwGLB8ckEJP5hRp94NJBsKgvqPhydaK0gGAyhnzxBN5i/lXAAb4+RtMkmtSEbJut8qUs8m84jO5APCi0U1e4/XdIQEdPnXYumP4Zb5GRi6D/i0ec2Ad9DHFcLZJ+oTW1AlOE+ZTvj0juWr2nq4L+7u8FDGHvugZmgKNi9aOGuj95EPAYjL4/0JIv+pdkV6dNXuafGdaIdr4rHNAm9h6P418KrrcgtgfoccP5yb84OwLfp18glsZPjKwlIVkdKcMQDeLOctH3SabNf7dJ/p9Ro0K5Y0fSJhtEHzrc4ftpTXlzqi6XdY5UJzoavXOR6dGEJa3chJ6B2rSHCaVF7d/aDRGoBrW3lGQJF+THznEFqtOajfmwFw5GHrkAHOqew+3TQOPzkHP0KDE2EzEGgLlRBPJyg4eokCTPSaslHsVAScT54Hmf
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(13003099007)(18002099003)(6133799003)(3023799007)(5023799004)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: doZcTVI2R9ZFNF5MHMQDfb0HdyKwW5PQzSEoH+oE+3jy/2h9x5gY93HWwoUkU7ETG5/C8nloGeEZx74oTyPfSxm8XSxT1BtH8tY6wbQuwulKJts6kSWYrc6ukYaQylf1LO/jHQOFxx+zK44QCUbphpgWupU13WkPqFulkbiNNrup1F6/2PSHpiGzuKcuzHNkHZjni2LUNZPxYOUww0c9JIOs1ZZJBSffDb492dZcMoHGQD3mOM2U/sZx49SkIcalbKBX856dH3vRkNv3lvgaW4yGrfcLVqeUVT4HQorjkJSNt0Q4XHgbClhDmxo+MgK5QFr7SozZ87lVKjtG0O5YZKsRQsaXj4jXsLr7y1Vp4vQLNEIEDGd9aBU3tr+ugtirsw/Csis2QjOHJpYanBraBVv5z6d+ovh89f1lHWxqGfhsegBrlikm224S9xLJrKyN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 11:48:07.1981 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8089cc78-8355-46e8-6768-08debfd3a5cb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5622
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
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

Changes from v5:
 https://lore.kernel.org/qemu-devel/20260519103727.899332-1-skolothumtho@nvidia.com/

 - Addressed v5 feedback and picked up Reviewed-by tags. Thanks!
 - Added documentation for design and lifecycle details. Please see patch #30.
 - Changed probe() and alloc_viommu() CMDQV ops both mandatory (patches #6, #8)
 - Fixed build on windows failure (patch #11)
 - Improved tracing with "Direct" vs "VI" info (patches #15, #16)
 - Removed vcmdq_enabled() check on BASE reprogramming (patch #16)
 - Dropped address_space_range_is_ram() check; record error on setup_vcmdq()
   failure (patch #18)
 - Dropped qemu_ram_backend_pagesize_min() and instead uses
   qemu_minrampagesize()- patch #25
 - Based on top of Nathan's "Resolve AUTO properties" v4 series [0].

Please find the complete branch here:
https://github.com/shamiali2008/qemu-master/tree/master-vcmdq-v6-ext

Sanity tested on NVIDIA Grace. Further testing in progress.

Feedback and testing are very welcome.

Thanks,
Shameer
[0] https://lore.kernel.org/qemu-devel/20260527221631.612026-1-nathanc@nvidia.com/

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
  hw/arm/tegra241-cmdqv: Allocate HW VCMDQs once configured
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
  hw/arm/tegra241-cmdqv: Use mmap'd VINTF page0 as VCMDQ backing
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
 hw/arm/tegra241-cmdqv.c       | 1122 +++++++++++++++++++++++++++++++++
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
 23 files changed, 2027 insertions(+), 80 deletions(-)
 create mode 100644 hw/arm/tegra241-cmdqv.h
 create mode 100644 hw/arm/tegra241-cmdqv-stubs.c
 create mode 100644 hw/arm/tegra241-cmdqv.c

-- 
2.43.0


