Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C1CC5CFEB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 13:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuVB1-0007WM-31; Thu, 13 Aug 2026 09:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>)
 id 1wuVB0-0007W7-7V; Thu, 13 Aug 2026 09:08:54 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>)
 id 1wuVAx-0005Wn-9V; Thu, 13 Aug 2026 09:08:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFSkqyK3x/eACm/TnX0F/W7mD+9sUZwkDGp5GbmDZV3MzF2qjb3NnuPeIw9qXHw9LwK/tUdjJC3QX+s6hGpdl8XxGVwOqtEgjjw7F2PizjiQLMwbNfzxP8WaIjOxGnW7EnpdLygKZUvTZmTtrPABqMUMsYm5bOjCcWIXCZzO/KuW5ll2OOQCNJrJlt0nl2W+vfZjBPb97s30rFM8ze+lpgMF5rekrRn3E9url+PoQ9u3F8a9dx3g6qjZYyCoBUmZ+SCA/qmrZqIhW6bTnOji9FKHUcGe66VF61CjDa9vo0/qCADm+fKEPq1jRjviKx3v1GT2sdx8HTfYcnUkt/eLGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKtgVk1fshHeRBH137d2Rbu6ZpMhy5YHmllEIZX8qc8=;
 b=gsTzAo+I/rjBqeWbH49MQJlpvlwnLt6bzOJkhGtMOJ5lDtf65dba79G97KJctbIaPzFIZieMrO+KINC3I7ytd71hA45x06KShmtrxC1fD+bTthfiN4YsBMcmv7sFjggSMXEsHIT9pxMhY27IajiZBLQHFXT1j6mfoT7euBh/R+B/HnX5Q2A1mJpnTrYtHixwwQ4Ol9iDQS+oFwvG5UqF4VJP70ZFnkl5F9g+FMNwcY0ivR3rPvqNA8AG11QBigNHYV6YeqiVQzS5NKKlkZ9El06SZJk6Q2YoV/C09qffZ1c0JGOpp8Ew3fBBrJaCktMH4F0n5cu0u8ODNhWxR8Dslg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKtgVk1fshHeRBH137d2Rbu6ZpMhy5YHmllEIZX8qc8=;
 b=ftxXlB/XgJDTwg8i5PE604UG65F7r7lzZWTkNBImvGY1xKXkCNkLPBBA2aCkDfV49D8pAAOFGLXcGKwELgJbWbaGk8FRu4otX0IgUthgE0+tKVGsrgMysMy22hP7ebPuCvdbkoReVCnMshNCwFqmVcZ4y1Um/mjFelLNv2vjGDruTss5DY7ywzgjxxuwAKIIlcRtE5dHQMCVP/LDzYs/iBsGqooq4Lg7DRZRKFE7k6pZo7F00FuGwi6kV9MK7SNV4EImX6tNJyB4mgi105d2q2UwiOjBM88L6ro7NyS5SCawDi2+z8uA8hslQbVVRHMboLFGI9rloCMn8dvMLkbyeg==
Received: from MN0PR12MB6003.namprd12.prod.outlook.com (2603:10b6:208:37f::17)
 by SN7PR12MB6837.namprd12.prod.outlook.com (2603:10b6:806:267::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 13 Aug
 2026 13:07:13 +0000
Received: from MW4PR03CA0286.namprd03.prod.outlook.com (2603:10b6:303:b5::21)
 by MN0PR12MB6003.namprd12.prod.outlook.com (2603:10b6:208:37f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 13:07:08 +0000
Received: from CO1PEPF00012E82.namprd03.prod.outlook.com
 (2603:10b6:303:b5:cafe::82) by MW4PR03CA0286.outlook.office365.com
 (2603:10b6:303:b5::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Thu,
 13 Aug 2026 13:07:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF00012E82.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 13:07:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 06:06:43 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 13 Aug 2026 06:06:37 -0700
From: <mhonap@nvidia.com>
To: <alex@shazbot.org>, <ankita@nvidia.com>, <jic23@kernel.org>,
 <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
 <smadhavan@nvidia.com>, <pierrick.bouvier@oss.qualcomm.com>,
 <mst@redhat.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
 <pbonzini@redhat.com>, <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>, <clg@redhat.com>, <cohuck@redhat.com>
CC: <kjaju@nvidia.com>, <vsethi@nvidia.com>, <zhiw@nvidia.com>,
 <mhonap@nvidia.com>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
Subject: [PATCH 00/10] QEMU: CXL Type-2 device passthrough via vfio-pci
Date: Thu, 13 Aug 2026 18:36:13 +0530
Message-ID: <20260813130623.2499506-1-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E82:EE_|MN0PR12MB6003:EE_|SN7PR12MB6837:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f64d428-e9d4-49a6-a760-08def93bc735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|7416014|376014|56012099006|11063799006|10067099003|6133799003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: PEqHbe/OrZY12WjT9w3vYz2HrUvHMADDuuHSAafzqr7AOtmm75HMpOonkUq2U1Irx1EjK93MlvzZ0Gu0810W9ttq4D8Y4i2iX6YAT+3wVJjGTy3Xco8OOB9JqtBj5Hw6eB4L94jZCTzhXMjwuKmamXcUhqAJDQH825ouNfIEgu7FhhGDyiACLGXD2RbO4ZfZV5Gye2KpLaJZKvdYcjuzo1R2CKYAXVHkx3O9kW6/5efcRkbjeP451USVlZA551rA8cxeoSkYVxFH7uQH/Q2pUw7zrHaehcjTqBQxMOsC7fUHWrOkumVuv97CfuzDTj7VSzPLBNyCdG+e3REQFKjQXr2w6NeAMIWVaKCqX25r9h/OBxxApne7eQqZnbYY8e7MF+tltq3KGKAExd/L21aWz6hyEQHs8X6+K5ayHVM4zVblXwpIT0J/oUqG0jRemYZpILdv4qSqAmJV83Wp15VruDVr2cgkEoCywBSXjILzaOsucUNpzFcExIuW1BwfBwItG7R7Qi0LmrPiKDYv5DuLgbXVM5pc2q0esjI8RxnEu7Bm0aZf7YzE4vxeX0DAFJ+zQKThLJk+2cA+Qd3hcWg3ZeI6Ut4mekOUBtnKVXtAQaix/JJrmwp4G0zXK+th8YPXnZtT7i33PgXH+qswbHVd2h8bjMhcSv0pCWJ5By5vLvQtQPnOZlUKjr4al7eKbrnSljeNE91fwdpyYKZc6sjZaHEuAgwoxLAsMADmV62EICRLE1SzvV2LHDkCLrtJqIgV
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(7416014)(376014)(56012099006)(11063799006)(10067099003)(6133799003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rkA9B+lrCA25ETcgpZfA58A/kRn3nl+/jUdvntAABwydSQI9cXfWGUQ1LOSBWjaufwtVM0yONTNM5pt7Oj7zh+M4sPZHgqpJjPXiWDEi/e6yKhoMrGBuy+BghouKxO5IghzRWyCEfcLlXU0J8BeSsFSG50X+X9khXuGF+qL0F1amOm/pt3VMPfECB2IfQ6aUB6wwaF5hXP+kZXYbm8b5KwAI/6A/XtYaE4XTdu+QNaE/ipXDQ/2OBvJMaus07BYOeBjY0eiFApRkWCBuOiPaFIeg/MjCXpXCk8OkLsbfU+VP065VViGCRGYT3B8ylLpstf6niM55AIk9cIGXo4JOYAJwdGqTTnyvwtv9x7gx4jm0pGlh3gZQs8rnanmOx6B7r4zWWtUk91fOuFD99g5NmEdElEbk3+tVyAfGa6ICepBQrEibSCmirSZslVrLWp+d
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 13:07:07.2175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f64d428-e9d4-49a6-a760-08def93bc735
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E82.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6837
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=mhonap@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.759,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

From: Manish Honap <mhonap@nvidia.com>

This series adds QEMU support for passing a CXL Type-2 device (an
accelerator with host-managed device memory, e.g. a GPU) to a guest via
vfio-pci. The guest drives its own virtual endpoint HDM decoder and QEMU
maps the device memory at the guest physical address the guest commits,
while the host owns the host physical placement.

It is a full rewrite of the RFC v1 series [1] on clean upstream master,
reworked to address Jonathan's review.

Base: master (post pull-9p-20260725), commit 6333226c2a.


Kernel dependency
-----------------

Pairs with the kernel vfio-cxl series "vfio/cxl: CXL Type-2 device
passthrough" [2].
- The kernel exposes the device memory as an HPA-backed VFIO region, traps
  the HDM decoder block and runs its lock-on-commit FSM, handles the CXL
  DVSEC (including guest-triggered reset), and reports two things through
  VFIO:
  - A device flag (VFIO_DEVICE_FLAGS_CXL) and
  - The component-register geometry (VFIO_REGION_INFO_CAP_CXL_COMP_REGS).


Sample supported topology
-------------------------

Guest disk, network, and system-RAM lines are omitted:

  -machine virt,accel=kvm,gic-version=3,hmat=on,cxl=on,ras=on, \
           highmem-mmio-size=4T
  -object iommufd,id=iommufd0
  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1
  -device cxl-rp,port=1,bus=cxl.1,id=rport0.1,chassis=4, \
          pref64-reserve=2G,mem-reserve=1G
  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=256G
  -device arm-smmuv3,primary-bus=cxl.1,id=smmuv3.0,accel=on,ats=on, \
          ril=on,ssidsize=8,oas=48
  -device vfio-pci-nohotplug,host=<BDF>,bus=rport0.1,id=dev0, \
          iommufd=iommufd0
  -object acpi-generic-initiator,id=gi0,pci-dev=dev0,node=2
  ... (one acpi-generic-initiator per guest NUMA node the HDM memory backs)


Address model
-------------

The kernel fixes device memory to a host physical range before the guest
sees the device, and hardware presents a firmware-committed, locked
endpoint HDM decoder whose registers hold that host physical base.

QEMU never exposes Host physical base. It virtualizes the decoder base registers
in the trapped component-register read and returns the base of the device's
CFMWS window, a guest physical address, so the guest only ever sees a GPA.

QEMU maps the RAM-device region (backed by the fixed HPA) at that CFMWS base.

The kernel never learns the GPA and the guest never learns the HPA.

Because the decoder is already committed at boot, no guest commit write
triggers the mapping. QEMU maps once the guest enables memory decoding
(the Command register Memory-Space bit) and re-checks on any decoder
control write, so the region enters the guest address space and the IOAS
while the device is live.

When the guest clears Memory-Space, QEMU withdraws the mapping, matching the
kernel's revoke of the backing PTEs on the same write, so a guest access during
the disabled interval cannot fault a zapped mapping and stop the VM; the enable
path re-installs it.

This also helps to keep the guest-visible base as the CFMWS base by
construction, and the host physical placement stays with the kernel.

The RFC added the pxb-cxl _DSM because OS may treat PCI configuration as
reassignable and a BAR move would break the CXL.mem mapping. This change keeps
it narrower than the RFC v1 _DSM: it applies only to the host bridge that
carries the passed-through CXL device.


Reset
-----

There is no QEMU reset patch. A guest CXL reset is a DVSEC write that
lands in vfio config space and is handled entirely by the host kernel,
which stamps the outcome into DVSEC STATUS2. The kernel re-commits this
firmware-fixed decoder across the reset, and the guest reaches its memory
through the mapping QEMU already installed.


Reviewer feedback addressed
---------------------------

The RFC [1] thread has the full discussion.

Jonathan Cameron
  - The high-MMIO window and the cxl-fmws-base property are removed. The
    guest-visible base is the CFMWS base by construction, so it equals the
    decoder base and stays stable without a hack.
  - The guest programs its virtual (GPA) decoder and QEMU maps the memory at
    commit time.
  - The host owns the HPA, resolved before the guest sees the device.
  - The committed decoder is the fast path this series ships. The
    guest-programmed uncommitted case is delivered by cxl-core resolving the
    range at enumeration, not by a QEMU or vfio dynamic branch, so it is a
    later cxl-core item this series does not depend on.
  - FIRMWARE_COMMITTED is dropped; the cap is no longer exposed.
  - The one-endpoint, non-interleaved, no-switch topology is enforced at
    realize.
  - PCI/BAR configuration and CXL.mem stay independent.


Validation
----------

- Every patch passes scripts/checkpatch.pl --codespell --strict
  (patch 1 carries the expected imported-from-Linux warning)
- The series applies cleanly on the stated base.
- Ran couple of rounds of masoncl/review-prompts on this series before posting.


Pending items
-------------

Future enhancements for the multi-decoder, interleaved devices and switched
topologies.

Trapped CXL RAS registers are planned as a new VFIO region subtype that the same
region-by-subtype detection already handles, not as a change to the
component-register cap.

The bios-tables test refresh for the new _DSM is still to be added.


References
----------

[1] [RFC 0/9] QEMU: CXL Type-2 device passthrough via vfio-pci
https://lore.kernel.org/linux-cxl/20260427181235.3003865-1-mhonap@nvidia.com/

[2] [PATCH v4 00/27] vfio/pci: Add CXL Type-2 device passthrough support
https://lore.kernel.org/linux-cxl/20260813093631.2288172-1-mhonap@nvidia.com/


Manish Honap (10):
  linux-headers: Update vfio.h for CXL Type-2 passthrough
  hw/vfio/region: Add vfio_region_setup_with_ops()
  hw/vfio/pci: Detect a CXL Type-2 device and read its geometry
  hw/vfio/pci: Enforce the passthrough topology for a CXL device
  hw/vfio/pci: Back the CXL memory with a RAM-device region
  hw/vfio/pci: Bind a CXL device to its fixed memory window
  hw/vfio/pci: Map the CXL memory on the guest decoder commit
  docs/cxl: Document CXL Type-2 device passthrough
  hw/arm/smmu-common: Allow pxb-cxl as an SMMUv3 primary bus
  hw/pci-host: Emit a _DSM on pxb-cxl to preserve firmware PCI config

 docs/system/devices/cxl.rst               |  46 ++
 hw/acpi/Kconfig                           |   1 +
 hw/acpi/cxl-stub.c                        |   2 +-
 hw/acpi/cxl.c                             |   4 +-
 hw/acpi/pci.c                             |  40 ++
 hw/arm/smmu-common.c                      |  19 +-
 hw/i386/acpi-build.c                      |   2 +-
 hw/pci-bridge/pci_expander_bridge_stubs.c |   6 +
 hw/pci-host/gpex-acpi.c                   |  42 +-
 hw/vfio/pci.c                             | 742 ++++++++++++++++++++++
 hw/vfio/pci.h                             |  24 +
 hw/vfio/region.c                          |  27 +-
 hw/vfio/vfio-region.h                     |   3 +
 include/hw/acpi/cxl.h                     |   2 +-
 include/hw/acpi/pci.h                     |   1 +
 linux-headers/linux/vfio.h                |  22 +
 16 files changed, 927 insertions(+), 56 deletions(-)


base-commit: 055952c0aa91ea7a00d135b73f78fc0b13442d6c
-- 
2.25.1


