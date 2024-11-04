Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7839D1BDF2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84GV-0003HT-QI; Mon, 04 Nov 2024 16:05:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84GU-0003HA-0h
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:05:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84GR-0005FB-DD
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:05:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=IplzC0x7xak0+N6kScASvK6ZMGjQpT7Gze9cEHQY71c=;
 b=UEeBTmDY/0VskVOduTXKXSOyQ/WVPzacb4nlljXSGVcK8OPmgJTiki8jUUwHuXSMonTxSo
 AuAZCWReSJDstQ4xM92R0uZG9jrFqHyZx7r+MHKWho4d6BLLBSvmYpH0Bhrli5K8rtRjiN
 YSDehRnKOEDmIyj0jKsXwOSSSE5A2bA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-jegWRYKYMbWjQfMZ7bCiVw-1; Mon, 04 Nov 2024 16:05:28 -0500
X-MC-Unique: jegWRYKYMbWjQfMZ7bCiVw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-539fb5677c9so4677878e87.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:05:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754326; x=1731359126;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IplzC0x7xak0+N6kScASvK6ZMGjQpT7Gze9cEHQY71c=;
 b=tPgvQe51EpZeyfGryoBUK222+mmnSsgPHu6CUS+/hCtlV3iQTB5LnI6pPytoh5GFWe
 CHi5ITyrYYDCnMLcR1xC7kcZfqnDPfMbQ0rGa7/MelUHaF2hN5ifpyfl4eC7aYYEtoaL
 CnbL/bcDgrN5mu7YJduazCo0alRc2HGSfjYyGdsiOv8TFPvi5St7jxjqIuz2hfVC4guA
 MQ6227ziFTQ+6JeNvq+TaAJYwpK5p8W8VKByRZvM0eQ/gNUByO6dTMhFLgnqc/Pt1RlP
 OEcsJi7bPjlpx1RxYbR+EkvR2Jy1ANgt+xx50VjonKgPaB5aYqlR+qa4pxDY+jrnho/L
 VvxQ==
X-Gm-Message-State: AOJu0YzCCXhS+Py1n3ynyhlgeeBAaGhq9MNZ2OcegRH3xztXvIxjPbok
 BwVfHEqf72H9I+XFKVuoCw1mhS7YXlXgKufhfjYIVO4akHt6Q33jjIjdhj0dnnnk+WHrstsFOs7
 7sK9EPgc8p8l0Y3NL3Baxop4jKup5aGeg8vjiLj3v6Ayy/5Z2kbMMIoCHsFZp6FJMCzG/6yeY33
 HUJS6KoGiDf8RIdwwEl5UaXv64+McrTA==
X-Received: by 2002:ac2:4a83:0:b0:533:44e7:1b2a with SMTP id
 2adb3069b0e04-53d6bb3fad8mr3429276e87.40.1730754326068; 
 Mon, 04 Nov 2024 13:05:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJ0Yf5rJkYe9xessyJRfouCcBFOawawyKrxYpNkWVkV477rKN6EFAkH0b2477NPlzr8MZv4Q==
X-Received: by 2002:ac2:4a83:0:b0:533:44e7:1b2a with SMTP id
 2adb3069b0e04-53d6bb3fad8mr3429249e87.40.1730754325373; 
 Mon, 04 Nov 2024 13:05:25 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c0f9bbccsm14327112f8f.0.2024.11.04.13.05.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:05:24 -0800 (PST)
Date: Mon, 4 Nov 2024 16:05:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/65] virtio,pc,pci: features, fixes, cleanups
Message-ID: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 92ec7805190313c9e628f8fc4eb4f932c15247bd:

  Merge tag 'pull-riscv-to-apply-20241031-1' of https://github.com/alistair23/qemu into staging (2024-10-31 16:34:25 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 096d96e7be7071aa805c4e70ef51da0b99b6a8fc:

  intel_iommu: Add missed reserved bit check for IEC descriptor (2024-11-04 16:03:25 -0500)

----------------------------------------------------------------
virtio,pc,pci: features, fixes, cleanups

CXL now can use Generic Port Affinity Structures.
CXL now allows control of link speed and width
vhost-user-blk now supports live resize, by means of
a new device-sync-config command
amd iommu now supports interrupt remapping
pcie devices now report extended tag field support
intel_iommu dropped support for Transient Mapping, to match VTD spec
arch agnostic ACPI infrastructure for vCPU Hotplug

Fixes, cleanups all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Ajay Joshi (1):
      hw/cxl: Fix background completion percentage calculation

Albert Esteve (1):
      vhost-user: fix shared object return values

Dmitry Frolov (1):
      hw/cxl: Fix uint32 overflow cxl-mailbox-utils.c

Fan Ni (3):
      hw/mem/cxl_type3: Fix More flag setting for dynamic capacity event records
      cxl/cxl-mailbox-utils: Fix size check for cmd_firmware_update_get_info
      hw/cxl/cxl-mailbox-util: Fix output buffer index update when retrieving DC extents

Gao Shiyuan (1):
      virtio-pci: fix memory_region_find for VirtIOPCIRegion's MR

Jonathan Cameron (30):
      hw/acpi: Fix ordering of BDF in Generic Initiator PCI Device Handle.
      hw/acpi/GI: Fix trivial parameter alignment issue.
      hw/acpi: Move AML building code for Generic Initiators to aml_build.c
      hw/acpi: Rename build_all_acpi_generic_initiators() to build_acpi_generic_initiator()
      hw/pci: Add a busnr property to pci_props and use for acpi/gi
      acpi/pci: Move Generic Initiator object handling into acpi/pci.*
      hw/pci-bridge: Add acpi_uid property to TYPE_PXB_BUS
      hw/i386/acpi: Use TYPE_PXB_BUS property acpi_uid for DSDT
      hw/pci-host/gpex-acpi: Use acpi_uid property.
      hw/acpi: Generic Port Affinity Structure support
      hw/acpi: Make storage of node id uint32_t to reduce fragility
      hw/acpi: Generic Initiator - add missing object class property descriptions.
      hw/pci-bridge/cxl_root_port: Provide x-speed and x-width properties.
      hw/pci-bridge/cxl_upstream: Provide x-speed and x-width properties.
      hw/pcie: Factor out PCI Express link register filling common to EP.
      hw/pcie: Provide a utility function for control of EP / SW USP link
      hw/mem/cxl-type3: Add properties to control link speed and width
      hw/pci-bridge/cxl-upstream: Add properties to control link speed and width
      hw/cxl: Fix indent of structure member
      hw/pci-bridge: Make pxb_dev_realize_common() return if it succeeded
      hw/cxl: Check size of input data to dynamic capacity mailbox commands
      hw/cxl: Check input includes at least the header in cmd_features_set_feature()
      hw/cxl: Check input length is large enough in cmd_events_clear_records()
      hw/cxl: Check enough data in cmd_firmware_update_transfer()
      hw/cxl: Check the length of data requested fits in get_log()
      hw/cxl: Avoid accesses beyond the end of cel_log.
      hw/cxl: Ensuring enough data to read parameters in cmd_tunnel_management_cmd()
      hw/cxl: Check that writes do not go beyond end of target attributes
      hw/cxl: Ensure there is enough data for the header in cmd_ccls_set_lsa()
      hw/cxl: Ensure there is enough data to read the input header in cmd_get_physical_port_state()

Marcin Juszkiewicz (1):
      pcie: enable Extended tag field support

Mattias Nissler (1):
      softmmu: Expand comments describing max_bounce_buffer_size

Michael S. Tsirkin (1):
      acpi/disassemle-aml.sh: fix up after dir reorg

Ricardo Ribalda (3):
      tests/acpi: pc: allow DSDT acpi table changes
      hw/i386/acpi-build: return a non-var package from _PRT()
      tests/acpi: pc: update golden masters for DSDT

Roque Arcudia Hernandez (1):
      hw/pci: Add parenthesis to PCI_BUILD_BDF macro

Salil Mehta (5):
      hw/acpi: Make CPUs ACPI `presence` conditional during vCPU hot-unplug
      qtest: allow ACPI DSDT Table changes
      hw/acpi: Update ACPI `_STA` method with QOM vCPU ACPI Hotplug states
      tests/qtest/bios-tables-test: Update DSDT golden masters for x86/{pc,q35}
      hw/acpi: Update GED with vCPU Hotplug VMSD for migration

Shiju Jose (1):
      hw/cxl/cxl-mailbox-utils: Fix for device DDR5 ECS control feature tables

Suravee Suthikulpanit (5):
      amd_iommu: Rename variable mmio to mr_mmio
      amd_iommu: Add support for pass though mode
      amd_iommu: Use shared memory region for Interrupt Remapping
      amd_iommu: Send notification when invalidate interrupt entry cache
      amd_iommu: Check APIC ID > 255 for XTSup

Vladimir Sementsov-Ogievskiy (3):
      qdev-monitor: add option to report GenericError from find_device_state
      vhost-user-blk: split vhost_user_blk_sync_config()
      qapi: introduce device-sync-config

Yao Xingtao (1):
      mem/cxl_type3: Fix overlapping region validation error

Zhenzhong Duan (4):
      intel_iommu: Introduce property "stale-tm" to control Transient Mapping (TM) field
      intel_iommu: Send IQE event when setting reserved bit in IQT_TAIL
      intel_iommu: Add missed sanity check for 256-bit invalidation queue
      intel_iommu: Add missed reserved bit check for IEC descriptor

luzhixing12345 (1):
      docs: fix vhost-user protocol doc

yaozhenguo (1):
      virtio/vhost-user: fix qemu abort when hotunplug vhost-user-net device

 qapi/qdev.json                                    |  24 +++
 qapi/qom.json                                     |  41 ++++
 hw/i386/amd_iommu.h                               |   5 +-
 hw/i386/intel_iommu_internal.h                    |  16 +-
 include/exec/memory.h                             |   9 +-
 include/hw/acpi/acpi_generic_initiator.h          |  47 -----
 include/hw/acpi/aml-build.h                       |   7 +
 include/hw/acpi/pci.h                             |   3 +
 include/hw/core/cpu.h                             |   2 +
 include/hw/cxl/cxl_device.h                       |  40 ++--
 include/hw/i386/intel_iommu.h                     |   3 +
 include/hw/pci-bridge/cxl_upstream_port.h         |   4 +
 include/hw/pci/pci.h                              |   4 +-
 include/hw/pci/pci_bridge.h                       |   3 +
 include/hw/pci/pci_device.h                       |   6 +-
 include/hw/pci/pcie.h                             |   2 +
 include/hw/qdev-core.h                            |   6 +
 include/hw/virtio/vhost-user.h                    |   1 +
 include/hw/virtio/virtio-pci.h                    |   3 +
 hw/acpi/acpi_generic_initiator.c                  | 148 -------------
 hw/acpi/aml-build.c                               |  83 ++++++++
 hw/acpi/cpu.c                                     |  53 ++++-
 hw/acpi/generic_event_device.c                    |  19 ++
 hw/acpi/pci.c                                     | 242 ++++++++++++++++++++++
 hw/arm/virt-acpi-build.c                          |   3 +-
 hw/block/vhost-user-blk.c                         |  27 ++-
 hw/core/machine.c                                 |   4 +-
 hw/cxl/cxl-mailbox-utils.c                        | 115 +++++++---
 hw/i386/acpi-build.c                              |  15 +-
 hw/i386/amd_iommu.c                               |  98 +++++++--
 hw/i386/intel_iommu.c                             |  96 ++++++---
 hw/i386/pc.c                                      |   1 +
 hw/mem/cxl_type3.c                                |  21 +-
 hw/pci-bridge/cxl_downstream.c                    |  23 +-
 hw/pci-bridge/cxl_root_port.c                     |   5 +
 hw/pci-bridge/cxl_upstream.c                      |   6 +
 hw/pci-bridge/pci_expander_bridge.c               |  27 ++-
 hw/pci-host/gpex-acpi.c                           |   5 +-
 hw/pci/pci.c                                      |  16 ++
 hw/pci/pci_bridge.c                               |   5 +
 hw/pci/pcie.c                                     | 117 +++++++----
 hw/virtio/vhost-user.c                            |  59 +++---
 hw/virtio/virtio-pci.c                            |  19 ++
 system/qdev-monitor.c                             |  53 ++++-
 tests/qtest/fuzz-virtio-balloon-test.c            |  37 ++++
 docs/interop/vhost-user.rst                       |  24 ++-
 hw/acpi/meson.build                               |   1 -
 tests/data/acpi/disassemle-aml.sh                 |   2 +-
 tests/data/acpi/x86/pc/DSDT                       | Bin 8527 -> 8560 bytes
 tests/data/acpi/x86/pc/DSDT.acpierst              | Bin 8438 -> 8471 bytes
 tests/data/acpi/x86/pc/DSDT.acpihmat              | Bin 9852 -> 9885 bytes
 tests/data/acpi/x86/pc/DSDT.bridge                | Bin 15398 -> 15431 bytes
 tests/data/acpi/x86/pc/DSDT.cphp                  | Bin 8991 -> 9024 bytes
 tests/data/acpi/x86/pc/DSDT.dimmpxm               | Bin 10181 -> 10214 bytes
 tests/data/acpi/x86/pc/DSDT.hpbridge              | Bin 8478 -> 8511 bytes
 tests/data/acpi/x86/pc/DSDT.hpbrroot              | Bin 5034 -> 5067 bytes
 tests/data/acpi/x86/pc/DSDT.ipmikcs               | Bin 8599 -> 8632 bytes
 tests/data/acpi/x86/pc/DSDT.memhp                 | Bin 9886 -> 9919 bytes
 tests/data/acpi/x86/pc/DSDT.nohpet                | Bin 8385 -> 8418 bytes
 tests/data/acpi/x86/pc/DSDT.numamem               | Bin 8533 -> 8566 bytes
 tests/data/acpi/x86/pc/DSDT.roothp                | Bin 12320 -> 12353 bytes
 tests/data/acpi/x86/q35/DSDT                      | Bin 8355 -> 8389 bytes
 tests/data/acpi/x86/q35/DSDT.acpierst             | Bin 8372 -> 8406 bytes
 tests/data/acpi/x86/q35/DSDT.acpihmat             | Bin 9680 -> 9714 bytes
 tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator | Bin 8634 -> 8668 bytes
 tests/data/acpi/x86/q35/DSDT.applesmc             | Bin 8401 -> 8435 bytes
 tests/data/acpi/x86/q35/DSDT.bridge               | Bin 11968 -> 12002 bytes
 tests/data/acpi/x86/q35/DSDT.core-count           | Bin 12913 -> 12947 bytes
 tests/data/acpi/x86/q35/DSDT.core-count2          | Bin 33770 -> 33804 bytes
 tests/data/acpi/x86/q35/DSDT.cphp                 | Bin 8819 -> 8853 bytes
 tests/data/acpi/x86/q35/DSDT.cxl                  | Bin 13148 -> 13180 bytes
 tests/data/acpi/x86/q35/DSDT.dimmpxm              | Bin 10009 -> 10043 bytes
 tests/data/acpi/x86/q35/DSDT.ipmibt               | Bin 8430 -> 8464 bytes
 tests/data/acpi/x86/q35/DSDT.ipmismbus            | Bin 8443 -> 8477 bytes
 tests/data/acpi/x86/q35/DSDT.ivrs                 | Bin 8372 -> 8406 bytes
 tests/data/acpi/x86/q35/DSDT.memhp                | Bin 9714 -> 9748 bytes
 tests/data/acpi/x86/q35/DSDT.mmio64               | Bin 9485 -> 9519 bytes
 tests/data/acpi/x86/q35/DSDT.multi-bridge         | Bin 13208 -> 13242 bytes
 tests/data/acpi/x86/q35/DSDT.noacpihp             | Bin 8235 -> 8269 bytes
 tests/data/acpi/x86/q35/DSDT.nohpet               | Bin 8213 -> 8247 bytes
 tests/data/acpi/x86/q35/DSDT.numamem              | Bin 8361 -> 8395 bytes
 tests/data/acpi/x86/q35/DSDT.pvpanic-isa          | Bin 8456 -> 8490 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count         | Bin 12913 -> 12947 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count2        | Bin 33770 -> 33804 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm12            | Bin 8961 -> 8995 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm2             | Bin 8987 -> 9021 bytes
 tests/data/acpi/x86/q35/DSDT.type4-count          | Bin 18589 -> 18623 bytes
 tests/data/acpi/x86/q35/DSDT.viot                 | Bin 14615 -> 14646 bytes
 tests/data/acpi/x86/q35/DSDT.xapic                | Bin 35718 -> 35752 bytes
 tests/qtest/meson.build                           |   1 +
 90 files changed, 1121 insertions(+), 430 deletions(-)
 delete mode 100644 include/hw/acpi/acpi_generic_initiator.h
 delete mode 100644 hw/acpi/acpi_generic_initiator.c
 create mode 100644 tests/qtest/fuzz-virtio-balloon-test.c


