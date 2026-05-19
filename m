Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70216CD5BA6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:39:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHqb-0007Sj-QK; Tue, 19 May 2026 06:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHqa-0007S4-C2; Tue, 19 May 2026 06:38:48 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHqY-0006Oa-3l; Tue, 19 May 2026 06:38:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qfv9RLhPZf8CDyO41diidbVHXbob64vD4AFRVe/AG+6qH4piEmHhUWTOworsZRW36AvkqR4De+uqB8B9Xb0lH80OPQMKsWbzWLn8Ju8AatEVfmRlGvVM56w4TNXc7RWRdRygRPj9qs4FbiDsmEOQ6ZElilIsJViCEjrHj00u7+b0PwIdEnE6Tq4aBTefdu6TxVyanBPtyzu1g/1j9qaeXkgI7ZAalxnAZsOdEtc5qwFLFs/JIzkCxJLgF4k0kzjNo2ZDtdH/urYR+cf/xWcO4nm+koBKXtNJ1/c8KjGmSnX0IVoZmQpF45S9Vuq66LpJT7z+vOV3CPmhT0/lBEJ7DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fuOhod+6sZzRuedNGA6m5OcXg7MbZmgFNybb5lnKMiE=;
 b=kHJwAzrcGsJcF6nJ0LDg2XhGBzkjnqVcuvLYYt2DjOznUCPLqaCKldk3siT1Z2WiI2UNNOn3gqBWZXkm6cYuig6IE/PKqPLLosE5jTZkr5OvsoP2L+sY4B0I4WdnpCLfNcw/UPjMTZuRT1yzBmKiMXeub1JUmjfpF75nkr4/meXO4ZMvFIeSP29jQRniWCAi7SmZPFzM1feFLY5EiGIr17iuApx8u7UiotxvXx8SZkp5/aJ0kI35nJ73PUbHDMfItGADaH26fFFy942L2MO2H7mLgS0FtV7hSqAITkwAMZsuvdYMS2h51lyh/AKd4bYPY45uEfWATT+W1hfeIxM+Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuOhod+6sZzRuedNGA6m5OcXg7MbZmgFNybb5lnKMiE=;
 b=U2/SEt2x9AhmzHel1UdOUQsRM3fRipmVL7o6Ne2ceI+IlZnw46QJZA/Nfu4vvq/guRJbYNf8sPfas72ijsBYiUX6Tg7fiJAVbrtC/BhcheQTX4+fLgVw6TOVOa3wi4eAy40vsDF+St/hUim7Rvkv3Nhn1a0OzkNGEFQ+ZeGWrxtuhcWBp8hEdCs7HzsubhKvVD2z0JvCihu3Ua6VSBm33SphgegpCElczbg1en8XyC1qmtvMAccdSqOV1nsQgc9GQivHVf2gwxP46xDODGui2gLIpqmSXXEANCuShutEqiqlUz0n2R9ic2oATX7RCNP1MSnukVitZC+cIVIZz/v3Tw==
Received: from PH8P220CA0048.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:2d9::25)
 by DM4PR12MB6640.namprd12.prod.outlook.com (2603:10b6:8:8f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.25; Tue, 19 May
 2026 10:38:34 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:510:2d9:cafe::3c) by PH8P220CA0048.outlook.office365.com
 (2603:10b6:510:2d9::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Tue, 19
 May 2026 10:38:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 10:38:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:38:14 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:38:11 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v5 00/32] hw/arm/virt: Introduce Tegra241 CMDQV support for
 accelerated SMMUv3
Date: Tue, 19 May 2026 11:36:38 +0100
Message-ID: <20260519103727.899332-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|DM4PR12MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: f3540cc8-4c38-4dae-293d-08deb592c718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|3023799003|11063799006|13003099007|56012099003;
X-Microsoft-Antispam-Message-Info: 1LPMIGrGqNmTMDex/5zDRtkS6d685CyfOk+Iyio2VEMFR5Xy2LDkLIDTWqf/BnZnbA0T0nixqa05FZMz3RfhahTF7KYQ44wnx7hAx0Al2lapVSt/gz6EJjlh037pSw6ugrqF6LqE5h70qiHbrhOks4p4yqFjthdDtNFYK0fivOTd7hN5dxHXqBaqfMFqY54u7DKOvqZBeRQBRTo/Umonm00K5f+mFcc2/ArpsLc5HnDXtnJE+Lu43OH17TJA/WnKUJW3EHVm9CvjVDY5y7WiLq5NpClcO+eVrp2RRkERHWjWeDkyY28Zg+05cdPBV3O/mOUmA1fnS+Iu6wPrXe5TiSCrmtfd8Q2aidrzXxJfJE4n2Dy+R6PvE+U3GDolUeN+KLmS0ZerPC1ScOxzQ7p1LPWtySs2LNqsHcKn9yiafzlO5kcaphqQr1FA1JysDwXy/SU9BBckHz/1tt9jAHUwnhXhoEjaKL4/FuJSJHObDSIubSIifF/9EdQPgpLp9Ipu1mkNyoty9eCD1chAoyqbES09k8x1/NXzMWe2BpDiW3ezyONDdE0LLXTzMGe327qYSPGHdzPCyZC2Et3YJc99Vp25DBy3XFuWIq+kUWqrCmcT9g7u6luxhHejI5f+ww17wjE/8rtUcwpFR+/FmsYV1z07X/JGCIKaYQT7QjGrVR1DVBC2Fa7MTLNRPBuOETDjS+gwEHaqqXtLLvmvOXnLlk1OSGGcVaoBGhALm4Uqz0Y=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(3023799003)(11063799006)(13003099007)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WD0t3dEwH/Jd69uFa75fda+Kf6JjgPi0muWyFaTRrlmQgLKjX4AvKVRDttOU1VjCdpSvf3SilXTaxaglC8F4GOoc+yRJ64I0OH2AjCN0GTDZ8Qbdnk3sv419vnZ7ceNUAX4Fi4ZhB90bI4+ImB/QRl4VuIYfVaBefmyrfXSAz3mZVEoJ8y5JkY2N8/CQzg+JL7ZUUsxu4DeMZQ1PBWf6Czs3JeOgYCFVJmfPSM8v7hk5kftOqDLFbJyQAlrAmWwoHBWYPEDMNm2hj11c1g9Xg0SdgPLmJu1UgKedsjBZxSM6H4E+zanqjZ3nuT6dXw5UnBwu/MkqltmmT9cFqUElIxJ61R6ArywHvMMTprkibiyj8og8gKdJ8lqSW8iUx09Nd0y+VLRuIVb0Bgrm/Fhcm1UxjurRZm36GgeGpYG8thW4By4iPl95ir6PshbBjeUR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:38:34.1945 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3540cc8-4c38-4dae-293d-08deb592c718
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6640
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Changes from v4:
 https://lore.kernel.org/qemu-devel/20260415105552.622421-1-skolothumtho@nvidia.com/
 
 - Addressed v4 feedback and picked up Reviewed-by tags. Thanks!
 - Improved comments to specify optional/mandatory for CMDQ ops(patch#6)
 - Introduced writel_mmio for 4-byte and writell_mmio for 8-byte(patch #14)
 - Separated vcmdq Page0 and Page1 access helpers(patches #15, #16)
 - Ignore VCMDQ BASE writes if the VCMDQ is already enabled(patch #16)
 - Modified address_space_is_ram helper to address_space_range_is_ram()
   to cover the entire range(patch #18)
 - Allocate HW QUEUE once all pre-conditions are met(BASE write,
   CMDQ_ALLOC_MAP, and CMDQV / VINTF enabled) - patch #19
 - Sync the VCMDQ Page0 register cache when mmap'd VINTF page0 is
   available(patch #20)
 - Introduced memory_region_skip_iommu_map()/_set_skip_iommu_map()
   accessors(patch 21).
 - Moved the renamed helper qemu_ram_backend_pagesize_min() to
   system/physmem.c (patch #26)
 - Updated commit log with DSDT/IORT AML descriptions(patch #30).
 - Based on top of Nathan's "Resolve AUTO properties" v3 series [0].

Please find the complete branch here:
https://github.com/shamiali2008/qemu-master/tree/master-vcmdq-v5-ext

Sanity tested on NVIDIA Grace. Further testing in progress.

Feedback and testing are very welcome.

Thanks,
Shameer
[0] https://lore.kernel.org/qemu-devel/20260512193520.3109172-1-nathanc@nvidia.com/

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

Shameer Kolothum (17):
  system/iommufd: Remove unused viommu pointer from IOMMUFDVeventq
  hw/arm/smmuv3-accel: Introduce CMDQV ops interface
  hw/arm/tegra241-cmdqv: Add Tegra241 CMDQV ops backend stub
  hw/arm/smmuv3-accel: Wire CMDQV ops into accel lifecycle
  hw/arm/virt: Use stored SMMUv3 device list for IORT build
  hw/arm/tegra241-cmdqv: Probe host Tegra241 CMDQV support
  hw/arm/virt: Link SMMUv3 CMDQV resources to platform bus
  system/physmem: Add address_space_range_is_ram() helper
  hw/arm/tegra241-cmdqv: Use mmap'd VINTF page0 as VCMDQ backing
  memory: Allow RAM device regions to skip IOMMU mapping
  hw/arm/smmuv3-accel: Introduce common helper for veventq read
  hw/arm/tegra241-cmdqv: Read and propagate Tegra241 CMDQV errors
  system/physmem: Add qemu_ram_backend_pagesize_min() helper
  hw/arm/smmuv3: Add per-device identifier property
  hw/arm/smmuv3-accel: Introduce helper to query CMDQV type
  hw/arm/smmuv3-accel: Enforce viommu association when CMDQV is active
  hw/arm/smmuv3: Add cmdqv property for SMMUv3 device

 hw/arm/smmuv3-accel.h         |   49 ++
 hw/arm/tegra241-cmdqv.h       |  381 +++++++++++++
 include/hw/arm/smmuv3.h       |    3 +
 include/hw/arm/virt.h         |    1 +
 include/system/iommufd.h      |   17 +-
 include/system/memory.h       |   34 ++
 include/system/ramblock.h     |    1 +
 backends/iommufd.c            |   64 +++
 hw/arm/smmuv3-accel-stubs.c   |   12 +
 hw/arm/smmuv3-accel.c         |  196 +++++--
 hw/arm/smmuv3.c               |   10 +
 hw/arm/tegra241-cmdqv-stubs.c |   16 +
 hw/arm/tegra241-cmdqv.c       | 1007 +++++++++++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c      |  127 +++--
 hw/arm/virt.c                 |   37 ++
 hw/vfio/iommufd.c             |    4 +-
 hw/vfio/listener.c            |    4 +
 system/memory.c               |   10 +
 system/physmem.c              |   48 ++
 backends/trace-events         |    4 +-
 hw/arm/Kconfig                |    5 +
 hw/arm/meson.build            |    2 +
 hw/arm/trace-events           |   11 +
 qemu-options.hx               |    8 +
 24 files changed, 1971 insertions(+), 80 deletions(-)
 create mode 100644 hw/arm/tegra241-cmdqv.h
 create mode 100644 hw/arm/tegra241-cmdqv-stubs.c
 create mode 100644 hw/arm/tegra241-cmdqv.c

-- 
2.43.0


