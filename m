Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FB6C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:26:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAZN-0004Px-1j; Tue, 12 Mar 2024 18:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAZ7-0004Oo-NF
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:25:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAZ1-0004CF-QV
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:25:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=G1ByBR7u2tbXK+8jPALxBeRIyVpK7j+CWSumz7gew70=;
 b=cB6GyYWl0UbZ7RHyoBH7LRGtYhQWE9lfr55eIziwPfhvE/R2cuNp8F1wg69zRnTkRjEZCa
 aQ1lpV7Wk/1xT2sWv1pCUYN4/2DsReXhiKwmzT4ZsWzoZ6RXODajdOGpftUPBjz6u3dmLb
 Bs7Qi0tqD1Q/nUlumhja2mKJ63myEQg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-1R5j9iarN0-JDZC5ys7FaA-1; Tue, 12 Mar 2024 18:25:35 -0400
X-MC-Unique: 1R5j9iarN0-JDZC5ys7FaA-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5685d83ec51so1661312a12.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282333; x=1710887133;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G1ByBR7u2tbXK+8jPALxBeRIyVpK7j+CWSumz7gew70=;
 b=c0D9GjT04z9+pzi2DU6vwEoYl0H2My4+1bSbG+AA1MujSR/cdUdJuqcpVBYDPG2nM0
 H1h38uZZF1q3KXLkmTTtMAsgwGTKrtm8TXm7uTPiQj7HYXwZv7RbaFfc8MF74paLJSlk
 737ka9TyLoyazIRmLGbEWa1d8xw3ftqTieI0P3lxy7JQ0jezGnJykS14FQvhG646UEVs
 H65q5QSn7zrcgWZySkoasTgHLIFdHDQo9gbWIC8KSs7RBHgUcppS312t61GAZz8JmBkZ
 Pb0ANMIwyqFdkScngeG1gH+XxVgivGN95P9SBortPcHRLOfSlOnsZqYcL2tbb+VK51Fj
 8Igw==
X-Gm-Message-State: AOJu0YyOYzsFlsxogwwxDlUYTscfJ8UJrFG2iV0p8yxSfYFNsHf+2MJj
 cfH3ofFnJRE4r+k/3sIMN68sGjtxhWuBJw6CGV2Cv3BAPmju7RDqkhoNmkYT4fqAI3E5BZrGeNa
 FQvVAeNKb0JyB/xtMdyhBf6TDb4eXYRI1Sd4a003+XwnbU2jAVVFMkgRBZbOV71N7w4HnIDbVmL
 XD/p5LgOgJUBiYA1Ca5gVk4yXrrd1oALFC
X-Received: by 2002:a17:906:6949:b0:a45:c706:b239 with SMTP id
 c9-20020a170906694900b00a45c706b239mr2085508ejs.32.1710282333490; 
 Tue, 12 Mar 2024 15:25:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgPQUIK5LH99Kqk3xrrybT1IJ9rp69CVp24c+gV6ppFD2uxSTRp/JFgVbMAnhpMki8raUC5g==
X-Received: by 2002:a17:906:6949:b0:a45:c706:b239 with SMTP id
 c9-20020a170906694900b00a45c706b239mr2085499ejs.32.1710282332883; 
 Tue, 12 Mar 2024 15:25:32 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 og43-20020a1709071deb00b00a46550ec5b1sm100857ejc.32.2024.03.12.15.25.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:25:32 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:25:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/68] virtio,pc,pci: features, cleanups, fixes
Message-ID: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 7489f7f3f81dcb776df8c1b9a9db281fc21bf05f:

  Merge tag 'hw-misc-20240309' of https://github.com/philmd/qemu into staging (2024-03-09 20:12:21 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 73279cecca03f7c2b4489c5fea994e7349eaafaa:

  docs/specs/pvpanic: document shutdown event (2024-03-12 17:59:57 -0400)

----------------------------------------------------------------
virtio,pc,pci: features, cleanups, fixes

more memslots support in libvhost-user
support PCIe Gen5/Gen6 link speeds in pcie
more traces in vdpa
network simulation devices support in vdpa
SMBIOS type 9 descriptor implementation
Bump max_cpus to 4096 vcpus in q35
aw-bits and granule options in VIRTIO-IOMMU
Support report NUMA nodes for device memory using GI in acpi
Beginning of shutdown event support in pvpanic

fixes, cleanups all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Akihiko Odaki (5):
      hw/nvme: Use pcie_sriov_num_vfs()
      pcie_sriov: Validate NumVFs
      pcie_sriov: Reset SR-IOV extended capability
      pcie_sriov: Do not reset NumVFs after disabling VFs
      hw/pci: Always call pcie_sriov_pf_reset()

Albert Esteve (1):
      hw/virtio: check owner for removing objects

Ani Sinha (1):
      pc: q35: Bump max_cpus to 4096 vcpus

Ankit Agrawal (3):
      qom: new object to associate device to NUMA node
      hw/acpi: Implement the SRAT GI affinity structure
      hw/i386/acpi-build: Add support for SRAT Generic Initiator structures

Bernhard Beschow (6):
      Revert "hw/i386/pc_sysfw: Inline pc_system_flash_create() and remove it"
      Revert "hw/i386/pc: Confine system flash handling to pc_sysfw"
      hw/i386/pc: Remove "rtc_state" link again
      hw/i386/pc: Avoid one use of the current_machine global
      hw/i386/pc: Set "normal" boot device order in pc_basic_device_init()
      hw/i386/pc: Inline pc_cmos_init() into pc_cmos_init_late() and remove it

David Hildenbrand (14):
      libvhost-user: Dynamically allocate memory for memory slots
      libvhost-user: Bump up VHOST_USER_MAX_RAM_SLOTS to 509
      libvhost-user: Factor out removing all mem regions
      libvhost-user: Merge vu_set_mem_table_exec_postcopy() into vu_set_mem_table_exec()
      libvhost-user: Factor out adding a memory region
      libvhost-user: No need to check for NULL when unmapping
      libvhost-user: Don't zero out memory for memory regions
      libvhost-user: Don't search for duplicates when removing memory regions
      libvhost-user: Factor out search for memory region by GPA and simplify
      libvhost-user: Speedup gpa_to_mem_region() and vu_gpa_to_va()
      libvhost-user: Use most of mmap_offset as fd_offset
      libvhost-user: Factor out vq usability check
      libvhost-user: Dynamically remap rings after (temporarily?) removing memory regions
      libvhost-user: Mark mmap'ed region memory as MADV_DONTDUMP

Eric Auger (8):
      virtio-iommu: Add a granule property
      virtio-iommu: Change the default granule to the host page size
      qemu-options.hx: Document the virtio-iommu-pci granule option
      virtio-iommu: Trace domain range limits as unsigned int
      virtio-iommu: Add an option to define the input range width
      hw/i386/q35: Set virtio-iommu aw-bits default value to 39
      hw/arm/virt: Set virtio-iommu aw-bits default value to 48
      qemu-options.hx: Document the virtio-iommu-pci aw-bits option

Eugenio Pérez (2):
      vdpa: stash memory region properties in vars
      vdpa: trace skipped memory sections

Felix Wu (2):
      Implement base of SMBIOS type 9 descriptor.
      Implement SMBIOS type 9 v2.6

Hao Chen (1):
      hw/virtio: Add support for VDPA network simulation devices

Jonathan Cameron (4):
      hw/pci-bridge/pxb-cxl: Drop RAS capability from host bridge.
      hmat acpi: Do not add Memory Proximity Domain Attributes Structure targetting non existent memory.
      hmat acpi: Fix out of bounds access due to missing use of indirection
      hw/cxl: Fix missing reserved data in CXL Device DVSEC

Lukas Stockner (1):
      pcie: Support PCIe Gen5/Gen6 link speeds

Si-Wei Liu (11):
      vdpa: add back vhost_vdpa_net_first_nc_vdpa
      vdpa: factor out vhost_vdpa_last_dev
      vdpa: factor out vhost_vdpa_net_get_nc_vdpa
      vdpa: add vhost_vdpa_set_address_space_id trace
      vdpa: add vhost_vdpa_get_vring_base trace for svq mode
      vdpa: add vhost_vdpa_set_dev_vring_base trace for svq mode
      vdpa: add trace events for vhost_vdpa_net_load_cmd
      vdpa: add trace event for vhost_vdpa_net_load_mq
      vdpa: define SVQ transitioning state for mode switching
      vdpa: indicate transitional state for SVQ switching
      vdpa: fix network breakage after cancelling migration

Thomas Weißschuh (1):
      docs/specs/pvpanic: document shutdown event

Volker Rümelin (1):
      hw/audio/virtio-sound: return correct command response size

Zhao Liu (7):
      hw/cxl/cxl-host: Fix missing ERRP_GUARD() in cxl_fixed_memory_window_config()
      hw/display/macfb: Fix missing ERRP_GUARD() in macfb_nubus_realize()
      hw/mem/cxl_type3: Fix missing ERRP_GUARD() in ct3_realize()
      hw/misc/xlnx-versal-trng: Check returned bool in trng_prop_fault_event_set()
      hw/pci-bridge/cxl_upstream: Fix missing ERRP_GUARD() in cxl_usp_realize()
      hw/vfio/iommufd: Fix missing ERRP_GUARD() in iommufd_cdev_getfd()
      hw/intc: Check @errp to handle the error of IOAPICCommonClass.realize()

 qapi/common.json                            |   6 +-
 qapi/qom.json                               |  17 +
 include/hw/acpi/acpi_generic_initiator.h    |  47 +++
 include/hw/audio/virtio-snd.h               |   1 +
 include/hw/cxl/cxl_component.h              |   1 +
 include/hw/cxl/cxl_pci.h                    |   3 +-
 include/hw/firmware/smbios.h                |  17 +
 include/hw/i386/pc.h                        |   4 +-
 include/hw/pci/pcie_regs.h                  |   2 +
 include/hw/pci/pcie_sriov.h                 |   4 +-
 include/hw/virtio/vhost-vdpa.h              |   9 +
 include/hw/virtio/virtio-iommu.h            |   3 +
 include/hw/virtio/virtio-pci.h              |   5 +
 include/hw/virtio/virtio.h                  |  19 +
 include/standard-headers/linux/virtio_pci.h |   7 +
 include/sysemu/numa.h                       |   1 +
 subprojects/libvhost-user/libvhost-user.h   |  10 +-
 hw/acpi/acpi_generic_initiator.c            | 148 +++++++
 hw/acpi/hmat.c                              |  15 +-
 hw/arm/virt-acpi-build.c                    |   3 +
 hw/arm/virt.c                               |  17 +
 hw/audio/virtio-snd.c                       |   7 +-
 hw/core/machine.c                           |   6 +-
 hw/core/numa.c                              |   3 +-
 hw/core/qdev-properties-system.c            |  16 +-
 hw/cxl/cxl-component-utils.c                |  21 +-
 hw/cxl/cxl-host.c                           |   1 +
 hw/display/macfb.c                          |   1 +
 hw/i386/acpi-build.c                        |   3 +
 hw/i386/pc.c                                |  30 +-
 hw/i386/pc_piix.c                           |   3 +-
 hw/i386/pc_q35.c                            |  14 +-
 hw/i386/pc_sysfw.c                          |  17 +-
 hw/intc/ioapic_common.c                     |   4 +
 hw/mem/cxl_type3.c                          |   1 +
 hw/misc/xlnx-versal-trng.c                  |   3 +-
 hw/net/igb.c                                |   2 -
 hw/net/virtio-net.c                         |  16 +
 hw/nvme/ctrl.c                              |  30 +-
 hw/pci-bridge/cxl_upstream.c                |   1 +
 hw/pci-bridge/pci_expander_bridge.c         |   2 +-
 hw/pci/pci.c                                |   1 +
 hw/pci/pcie.c                               |   8 +
 hw/pci/pcie_sriov.c                         |  32 +-
 hw/smbios/smbios.c                          | 142 +++++++
 hw/vfio/iommufd.c                           |   1 +
 hw/virtio/vhost-user.c                      |  21 +-
 hw/virtio/vhost-vdpa.c                      |  44 +-
 hw/virtio/virtio-iommu.c                    |  36 +-
 hw/virtio/virtio-pci.c                      | 189 ++++++++-
 hw/virtio/virtio.c                          |  39 ++
 net/vhost-vdpa.c                            |  30 +-
 subprojects/libvhost-user/libvhost-user.c   | 601 +++++++++++++++-------------
 tests/qtest/virtio-iommu-test.c             |   2 +-
 MAINTAINERS                                 |   5 +
 docs/interop/vhost-user.rst                 |   4 +-
 docs/specs/pvpanic.rst                      |   2 +
 docs/system/device-emulation.rst            |   1 +
 docs/system/devices/vdpa-net.rst            | 121 ++++++
 hw/acpi/meson.build                         |   1 +
 hw/virtio/trace-events                      |   7 +-
 net/trace-events                            |   6 +
 qemu-options.hx                             |  14 +
 63 files changed, 1440 insertions(+), 387 deletions(-)
 create mode 100644 include/hw/acpi/acpi_generic_initiator.h
 create mode 100644 hw/acpi/acpi_generic_initiator.c
 create mode 100644 docs/system/devices/vdpa-net.rst


