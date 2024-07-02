Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BDDC3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeA5-0001wj-Mx; Tue, 02 Jul 2024 10:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeA2-0001vx-Ax
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:07:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOe9y-0007os-Rl
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:07:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LD3N7Z0mMC6xT4TkFHWC/+nQ4lzLGOWUE5iXawCfV3o=;
 b=jBwwMV2wwohpohi4rQW2PG+6VjkL99HJFZmqlQJQ32DsaD+HUBrIpzEq147t/89OPms5mh
 7ZytneQJ9vzMMyeZApHZBnrwNzt+E/ZW5mHgBB5Yl+VbKb5GVWKvK87OZxz+LDJde97k/g
 nXnPDDmKyibqPK/vNbuUnUpuvHK29aI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-V_JEASXyMI6UcUG8iwL9nA-1; Tue, 02 Jul 2024 10:07:03 -0400
X-MC-Unique: V_JEASXyMI6UcUG8iwL9nA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3642cc54bbfso2562611f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:07:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929221; x=1720534021;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LD3N7Z0mMC6xT4TkFHWC/+nQ4lzLGOWUE5iXawCfV3o=;
 b=rQKGFreAZv7kEnizk/DgSI9egIUsJmPe7wGhctUMQzyEepXCxvA3ckvEaCnNfBTbV3
 HpbUTXQdIzkOQCgCCaI7xjRH5+ALsCXc9uKzTEYFKG7obvMEuK0a2c7SYDdK7YhoY8yy
 EwS1LWImevNN2P5A2JNhVkSK4Sk1Rv1ES2FUpKcP1OqGmRQoiyxaPV2G7NuU5fUoF2iH
 9oPDX3fHfKsNlsg4grdLpEqhzGJLkVJDw9MoVm8+BcUCA9WjNW20Helw+2bfwiZmQz10
 hwH/W8C/o26egOwmsf1Qrjx5XZ7keBlBfFE1UgJiMMhN1wQQhCzGC+DmroRvQvJtLVTf
 DaGQ==
X-Gm-Message-State: AOJu0Yzt1ex7Z+ycX75hei85zpppNJhY1tIkhXtjLosWooCvlAtmHY3v
 goyd7/qoRgYDgC0KqHER3fwx/UTwqWJPTuwgmR7vnnOYG/m3O1eNdtqLlw0+AOO5S2ZJKsm3ji7
 qKc1wm0NGmFSfc2TTkrTNxkppWjwWfKAH7xkEYNZNaSW47xHXFvYCO0PbTnyfSEHJLV7wvnf0/O
 XNpPTbwugUOg/myJV9qD75N04pECAXRA==
X-Received: by 2002:adf:fd44:0:b0:366:df65:8763 with SMTP id
 ffacd0b85a97d-367756bca70mr5964381f8f.34.1719929220551; 
 Tue, 02 Jul 2024 07:07:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA+y+X3Gi5gzTtPCRyTaSiX8SvMiIkrb2HpmgIbfI8+mvQRxpTTV1BzOMFpnI+w+M9Rm4RBQ==
X-Received: by 2002:adf:fd44:0:b0:366:df65:8763 with SMTP id
 ffacd0b85a97d-367756bca70mr5964345f8f.34.1719929219601; 
 Tue, 02 Jul 2024 07:06:59 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cd634sm13484281f8f.9.2024.07.02.07.06.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:06:59 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:06:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/91] virtio: features,fixes
Message-ID: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 1152a0414944f03231f3177207d379d58125890e:

  Merge tag 'pull-xen-20240701' of https://xenbits.xen.org/git-http/people/aperard/qemu-dm into staging (2024-07-01 09:06:25 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to a323ad3c8a8f12ee180d0582d7fffa8098b1a962:

  hw/pci: Replace -1 with UINT32_MAX for romsize (2024-07-02 10:04:21 -0400)

----------------------------------------------------------------
virtio: features,fixes

A bunch of improvements:
- vhost dirty log is now only scanned once, not once per device
- virtio and vhost now support VIRTIO_F_NOTIFICATION_DATA
- cxl gained DCD emulation support
- pvpanic gained shutdown support
- beginning of patchset for Generic Port Affinity Structure
- s3 support
- friendlier error messages when boot fails on some illegal configs
- for vhost-user, VHOST_USER_SET_LOG_BASE is now only sent once
- vhost-user now works on any POSIX system
- sr-iov VF setup code has been reworked significantly
- new tests, particularly for risc-v ACPI
- bugfixes

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Akihiko Odaki (11):
      hw/virtio: Free vqs after vhost_dev_cleanup()
      hw/pci: Rename has_power to enabled
      hw/ppc/spapr_pci: Do not create DT for disabled PCI device
      hw/ppc/spapr_pci: Do not reject VFs created after a PF
      pcie_sriov: Do not manually unrealize
      pcie_sriov: Ensure VF function number does not overflow
      pcie_sriov: Reuse SR-IOV VF device instances
      pcie_sriov: Release VFs failed to realize
      pcie_sriov: Remove num_vfs from PCIESriovPF
      pcie_sriov: Register VFs after migration
      hw/pci: Replace -1 with UINT32_MAX for romsize

Alejandro Jimenez (1):
      pvpanic: Emit GUEST_PVSHUTDOWN QMP event on pvpanic shutdown signal

BillXiang (1):
      vhost-user: Skip unnecessary duplicated VHOST_USER_SET_LOG_BASE requests

Christian Pötzsch (1):
      Fix vhost user assertion when sending more than one fd

Cindy Lu (1):
      virtio-pci: Fix the failure process in kvm_virtio_pci_vector_use_one()

Cédric Le Goater (1):
      virtio-iommu: Clear IOMMUDevice when VFIO device is unplugged

David Woodhouse (1):
      hw/i386/fw_cfg: Add etc/e820 to fw_cfg late

Dmitry Frolov (1):
      hw/net/virtio-net.c: fix crash in iov_copy()

Fan Ni (12):
      hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output payload of identify memory device command
      hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative and mailbox command support
      include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for type3 memory devices
      hw/mem/cxl_type3: Add support to create DC regions to type3 memory devices
      hw/mem/cxl-type3: Refactor ct3_build_cdat_entries_for_mr to take mr size instead of mr as argument
      hw/mem/cxl_type3: Add host backend and address space handling for DC regions
      hw/mem/cxl_type3: Add DC extent list representative and get DC extent list mailbox support
      hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/release dynamic capacity response
      hw/cxl/events: Add qmp interfaces to add/release dynamic capacity extents
      hw/mem/cxl_type3: Add DPA range validation for accesses to DC regions
      hw/cxl/cxl-mailbox-utils: Add superset extent release mailbox support
      hw/mem/cxl_type3: Allow to release extent superset in QMP interface

Gregory Price (2):
      hw/cxl/mailbox: change CCI cmd set structure to be a member, not a reference
      hw/cxl/mailbox: interface to add CCI commands to an existing CCI

Halil Pasic (1):
      vhost-vsock: add VIRTIO_F_RING_PACKED to feature_bits

Ira Weiny (1):
      hw/cxl: Fix read from bogus memory

Jiqian Chen (2):
      virtio-pci: only reset pm state during resetting
      virtio-pci: implement No_Soft_Reset bit

Jonah Palmer (5):
      virtio/virtio-pci: Handle extra notification data
      virtio: Prevent creation of device using notification-data with ioeventfd
      virtio-mmio: Handle extra notification data
      virtio-ccw: Handle extra notification data
      vhost/vhost-user: Add VIRTIO_F_NOTIFICATION_DATA to vhost feature bits

Jonathan Cameron (2):
      hw/cxl/events: Improve QMP interfaces and documentation for add/release dynamic capacity.
      hw/cxl/events: Mark cxl-add-dynamic-capacity and cxl-release-dynamic-capcity unstable

Li Feng (2):
      Revert "vhost-user: fix lost reconnect"
      vhost-user: fix lost reconnect again

Manos Pitsidianakis (1):
      virtio-iommu: add error check before assert

Marc-André Lureau (1):
      vhost-user-gpu: fix import of DMABUF

Nicolin Chen (2):
      hw/arm/virt-acpi-build: Drop local iort_node_offset
      hw/arm/virt-acpi-build: Fix id_count in build_iort_id_mapping

Si-Wei Liu (2):
      vhost: dirty log should be per backend type
      vhost: Perform memory section dirty scans once per iteration

Stefano Garzarella (15):
      vhost-vdpa: check vhost_vdpa_set_vring_ready() return value
      qapi: clarify that the default is backend dependent
      libvhost-user: set msg.msg_control to NULL when it is empty
      libvhost-user: fail vu_message_write() if sendmsg() is failing
      libvhost-user: mask F_INFLIGHT_SHMFD if memfd is not supported
      vhost-user-server: do not set memory fd non-blocking
      contrib/vhost-user-blk: fix bind() using the right size of the address
      contrib/vhost-user-*: use QEMU bswap helper functions
      vhost-user: enable frontends on any POSIX system
      libvhost-user: enable it on any POSIX system
      contrib/vhost-user-blk: enable it on any POSIX system
      hostmem: add a new memory backend based on POSIX shm_open()
      tests/qtest/vhost-user-blk-test: use memory-backend-shm
      tests/qtest/vhost-user-test: add a test case for memory-backend-shm
      virtio: remove virtio_tswap16s() call in vring_packed_event_read()

Sunil V L (15):
      uefi-test-tools/UefiTestToolsPkg: Add RISC-V support
      uefi-test-tools: Add support for python based build script
      tests/data/uefi-boot-images: Add RISC-V ISO image
      qtest: bios-tables-test: Rename aarch64 tests with aarch64 in them
      tests/qtest/bios-tables-test.c: Add support for arch in path
      tests/qtest/bios-tables-test.c: Set "arch" for aarch64 tests
      tests/qtest/bios-tables-test.c: Set "arch" for x86 tests
      tests/data/acpi: Move x86 ACPI tables under x86/${machine} path
      tests/data/acpi/virt: Move ARM64 ACPI tables under aarch64/${machine} path
      meson.build: Add RISC-V to the edk2-target list
      pc-bios/meson.build: Add support for RISC-V in unpack_edk2_blobs
      tests/data/acpi/rebuild-expected-aml.sh: Add RISC-V
      tests/qtest/bios-tables-test: Add empty ACPI data files for RISC-V
      tests/qtest/bios-tables-test.c: Enable basic testing for RISC-V
      tests/qtest/bios-tables-test: Add expected ACPI data files for RISC-V

Thomas Huth (1):
      hw/virtio: Fix the de-initialization of vhost-user devices

Thomas Weißschuh (6):
      linux-headers: update to 6.10-rc1
      hw/misc/pvpanic: centralize definition of supported events
      tests/qtest/pvpanic: use centralized definition of supported events
      hw/misc/pvpanic: add support for normal shutdowns
      tests/qtest/pvpanic: add tests for pvshutdown event
      Revert "docs/specs/pvpanic: mark shutdown event as not implemented"

Wafer (1):
      hw/virtio: Fix obtain the buffer id from the last descriptor

Yuxue Liu (1):
      vhost-user-test: don't set call fd -1 non-blocking

Zhao Liu (1):
      i386/apic: Add hint on boot failure because of disabling x2APIC

 docs/pcie_sriov.txt                                |   8 +-
 qapi/cxl.json                                      | 189 ++++++
 qapi/qom.json                                      |  27 +-
 qapi/run-state.json                                |  14 +
 hw/i386/e820_memory_layout.h                       |   8 +-
 hw/i386/fw_cfg.h                                   |   1 +
 include/hw/cxl/cxl_device.h                        |  85 ++-
 include/hw/cxl/cxl_events.h                        |  18 +
 include/hw/misc/pvpanic.h                          |   6 +
 include/hw/pci/pci.h                               |   2 +-
 include/hw/pci/pci_device.h                        |  17 +-
 include/hw/pci/pcie_sriov.h                        |   9 +-
 include/hw/virtio/vhost-user.h                     |   3 +-
 include/hw/virtio/vhost.h                          |   1 +
 include/hw/virtio/virtio-pci.h                     |   5 +
 include/hw/virtio/virtio.h                         |  10 +-
 include/standard-headers/linux/ethtool.h           |  55 ++
 include/standard-headers/linux/pci_regs.h          |   6 +
 include/standard-headers/linux/virtio_bt.h         |   1 -
 include/standard-headers/linux/virtio_mem.h        |   2 +
 include/standard-headers/linux/virtio_net.h        | 143 +++++
 include/standard-headers/misc/pvpanic.h            |   7 +-
 include/sysemu/runstate.h                          |   1 +
 linux-headers/asm-generic/unistd.h                 |   5 +-
 linux-headers/asm-mips/unistd_n32.h                |   1 +
 linux-headers/asm-mips/unistd_n64.h                |   1 +
 linux-headers/asm-mips/unistd_o32.h                |   1 +
 linux-headers/asm-powerpc/unistd_32.h              |   1 +
 linux-headers/asm-powerpc/unistd_64.h              |   1 +
 linux-headers/asm-s390/unistd_32.h                 |   1 +
 linux-headers/asm-s390/unistd_64.h                 |   1 +
 linux-headers/asm-x86/unistd_32.h                  |   1 +
 linux-headers/asm-x86/unistd_64.h                  |   1 +
 linux-headers/asm-x86/unistd_x32.h                 |   2 +
 linux-headers/linux/kvm.h                          |   4 +-
 linux-headers/linux/stddef.h                       |   8 +
 subprojects/libvhost-user/libvhost-user.h          |   2 +-
 backends/hostmem-shm.c                             | 123 ++++
 contrib/vhost-user-blk/vhost-user-blk.c            |  27 +-
 contrib/vhost-user-input/main.c                    |  16 +-
 hw/arm/virt-acpi-build.c                           |  22 +-
 hw/block/vhost-user-blk.c                          |   6 +-
 hw/core/machine.c                                  |   1 +
 hw/cxl/cxl-mailbox-utils.c                         | 658 ++++++++++++++++++++-
 hw/display/vhost-user-gpu.c                        |   5 +-
 hw/i386/e820_memory_layout.c                       |  16 +-
 hw/i386/fw_cfg.c                                   |  18 +-
 hw/i386/microvm.c                                  |   4 +-
 hw/i386/pc.c                                       |   1 +
 hw/intc/apic_common.c                              |   7 +-
 hw/mem/cxl_type3.c                                 | 637 ++++++++++++++++++--
 hw/mem/cxl_type3_stubs.c                           |  25 +
 hw/misc/pvpanic-isa.c                              |   3 +-
 hw/misc/pvpanic-pci.c                              |   2 +-
 hw/misc/pvpanic.c                                  |   7 +-
 hw/net/igb.c                                       |  13 +-
 hw/net/vhost_net.c                                 |   7 +
 hw/net/virtio-net.c                                |   4 +
 hw/nvme/ctrl.c                                     |  24 +-
 hw/pci/pci.c                                       |  29 +-
 hw/pci/pci_host.c                                  |   4 +-
 hw/pci/pcie_sriov.c                                | 149 ++---
 hw/ppc/spapr_pci.c                                 |   8 +-
 hw/s390x/s390-virtio-ccw.c                         |  17 +-
 hw/scsi/vhost-scsi.c                               |   1 +
 hw/scsi/vhost-user-scsi.c                          |   7 +-
 hw/virtio/vhost-user-base.c                        |   7 +-
 hw/virtio/vhost-user-fs.c                          |   2 +-
 hw/virtio/vhost-user-vsock.c                       |   1 +
 hw/virtio/vhost-user.c                             |  19 +-
 hw/virtio/vhost-vsock-common.c                     |   1 +
 hw/virtio/vhost.c                                  | 112 +++-
 hw/virtio/virtio-iommu.c                           |  43 ++
 hw/virtio/virtio-mmio.c                            |  11 +-
 hw/virtio/virtio-pci.c                             |  67 ++-
 hw/virtio/virtio.c                                 |  46 +-
 hw/xen/xen_pt_load_rom.c                           |   2 +-
 net/vhost-vdpa.c                                   |  16 +-
 subprojects/libvhost-user/libvhost-user.c          |  79 ++-
 system/runstate.c                                  |   6 +
 target/i386/kvm/kvm.c                              |   6 +-
 target/i386/kvm/xen-emu.c                          |   7 +-
 tests/qtest/bios-tables-test.c                     | 169 +++++-
 tests/qtest/pvpanic-pci-test.c                     |  44 +-
 tests/qtest/pvpanic-test.c                         |  34 +-
 tests/qtest/vhost-user-blk-test.c                  |   2 +-
 tests/qtest/vhost-user-test.c                      |  28 +-
 util/vhost-user-server.c                           |  12 +
 backends/meson.build                               |   1 +
 docs/specs/pvpanic.rst                             |   2 +-
 docs/system/devices/vhost-user.rst                 |   5 +-
 hw/block/Kconfig                                   |   2 +-
 hw/pci/trace-events                                |   2 +-
 meson.build                                        |   7 +-
 pc-bios/meson.build                                |   2 +
 qemu-options.hx                                    |  16 +
 tests/data/acpi/{ => aarch64}/virt/APIC            | Bin
 .../data/acpi/{ => aarch64}/virt/APIC.acpihmatvirt | Bin
 tests/data/acpi/{ => aarch64}/virt/APIC.topology   | Bin
 tests/data/acpi/{ => aarch64}/virt/DBG2            | Bin
 tests/data/acpi/{ => aarch64}/virt/DSDT            | Bin
 .../data/acpi/{ => aarch64}/virt/DSDT.acpihmatvirt | Bin
 tests/data/acpi/{ => aarch64}/virt/DSDT.memhp      | Bin
 tests/data/acpi/{ => aarch64}/virt/DSDT.pxb        | Bin
 tests/data/acpi/{ => aarch64}/virt/DSDT.topology   | Bin
 tests/data/acpi/{ => aarch64}/virt/FACP            | Bin
 tests/data/acpi/{ => aarch64}/virt/GTDT            | Bin
 .../data/acpi/{ => aarch64}/virt/HMAT.acpihmatvirt | Bin
 tests/data/acpi/{ => aarch64}/virt/IORT            | Bin
 tests/data/acpi/{ => aarch64}/virt/MCFG            | Bin
 tests/data/acpi/{ => aarch64}/virt/NFIT.memhp      | Bin
 tests/data/acpi/{ => aarch64}/virt/PPTT            | Bin
 .../data/acpi/{ => aarch64}/virt/PPTT.acpihmatvirt | Bin
 tests/data/acpi/{ => aarch64}/virt/PPTT.topology   | Bin
 tests/data/acpi/{pc => aarch64/virt}/SLIT.memhp    | Bin
 tests/data/acpi/{ => aarch64}/virt/SPCR            | Bin
 .../data/acpi/{ => aarch64}/virt/SRAT.acpihmatvirt | Bin
 tests/data/acpi/{ => aarch64}/virt/SRAT.memhp      | Bin
 tests/data/acpi/{ => aarch64}/virt/SRAT.numamem    | Bin
 tests/data/acpi/{ => aarch64}/virt/SSDT.memhp      | Bin
 tests/data/acpi/{ => aarch64}/virt/VIOT            | Bin
 tests/data/acpi/rebuild-expected-aml.sh            |   5 +-
 tests/data/acpi/riscv64/virt/APIC                  | Bin 0 -> 116 bytes
 tests/data/acpi/riscv64/virt/DSDT                  | Bin 0 -> 3518 bytes
 tests/data/acpi/riscv64/virt/FACP                  | Bin 0 -> 276 bytes
 tests/data/acpi/riscv64/virt/MCFG                  | Bin 0 -> 60 bytes
 tests/data/acpi/riscv64/virt/RHCT                  | Bin 0 -> 314 bytes
 tests/data/acpi/riscv64/virt/SPCR                  | Bin 0 -> 80 bytes
 tests/data/acpi/{ => x86}/microvm/APIC             | Bin
 tests/data/acpi/{ => x86}/microvm/APIC.ioapic2     | Bin
 tests/data/acpi/{ => x86}/microvm/APIC.pcie        | Bin
 tests/data/acpi/{ => x86}/microvm/DSDT             | Bin
 tests/data/acpi/{ => x86}/microvm/DSDT.ioapic2     | Bin
 tests/data/acpi/{ => x86}/microvm/DSDT.pcie        | Bin
 tests/data/acpi/{ => x86}/microvm/DSDT.rtc         | Bin
 tests/data/acpi/{ => x86}/microvm/DSDT.usb         | Bin
 tests/data/acpi/{ => x86}/microvm/ERST.pcie        | Bin
 tests/data/acpi/{ => x86}/microvm/FACP             | Bin
 tests/data/acpi/{ => x86}/pc/APIC                  | Bin
 tests/data/acpi/{ => x86}/pc/APIC.acpihmat         | Bin
 tests/data/acpi/{ => x86}/pc/APIC.cphp             | Bin
 tests/data/acpi/{ => x86}/pc/APIC.dimmpxm          | Bin
 tests/data/acpi/{ => x86}/pc/DSDT                  | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.acpierst         | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.acpihmat         | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.bridge           | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.cphp             | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.dimmpxm          | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.hpbridge         | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.hpbrroot         | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.ipmikcs          | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.memhp            | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.nohpet           | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.numamem          | Bin
 tests/data/acpi/{ => x86}/pc/DSDT.roothp           | Bin
 tests/data/acpi/{ => x86}/pc/ERST.acpierst         | Bin
 tests/data/acpi/{ => x86}/pc/FACP                  | Bin
 tests/data/acpi/{ => x86}/pc/FACP.nosmm            | Bin
 tests/data/acpi/{ => x86}/pc/FACS                  | Bin
 tests/data/acpi/{ => x86}/pc/HMAT.acpihmat         | Bin
 tests/data/acpi/{ => x86}/pc/HPET                  | Bin
 tests/data/acpi/{ => x86}/pc/NFIT.dimmpxm          | Bin
 tests/data/acpi/{ => x86}/pc/SLIT.cphp             | Bin
 tests/data/acpi/{q35 => x86/pc}/SLIT.memhp         | Bin
 tests/data/acpi/{ => x86}/pc/SRAT.acpihmat         | Bin
 tests/data/acpi/{ => x86}/pc/SRAT.cphp             | Bin
 tests/data/acpi/{ => x86}/pc/SRAT.dimmpxm          | Bin
 tests/data/acpi/{ => x86}/pc/SRAT.memhp            | Bin
 tests/data/acpi/{ => x86}/pc/SRAT.numamem          | Bin
 tests/data/acpi/{ => x86}/pc/SSDT.dimmpxm          | Bin
 tests/data/acpi/{ => x86}/pc/WAET                  | Bin
 tests/data/acpi/{ => x86}/q35/APIC                 | Bin
 tests/data/acpi/{ => x86}/q35/APIC.acpihmat        | Bin
 .../acpi/{ => x86}/q35/APIC.acpihmat-noinitiator   | Bin
 tests/data/acpi/{ => x86}/q35/APIC.core-count      | Bin
 tests/data/acpi/{ => x86}/q35/APIC.core-count2     | Bin
 tests/data/acpi/{ => x86}/q35/APIC.cphp            | Bin
 tests/data/acpi/{ => x86}/q35/APIC.dimmpxm         | Bin
 tests/data/acpi/{ => x86}/q35/APIC.thread-count    | Bin
 tests/data/acpi/{ => x86}/q35/APIC.thread-count2   | Bin
 tests/data/acpi/{ => x86}/q35/APIC.type4-count     | Bin
 tests/data/acpi/{ => x86}/q35/APIC.xapic           | Bin
 tests/data/acpi/{ => x86}/q35/CEDT.cxl             | Bin
 tests/data/acpi/{ => x86}/q35/DMAR.dmar            | Bin
 tests/data/acpi/{ => x86}/q35/DSDT                 | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.acpierst        | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.acpihmat        | Bin
 .../acpi/{ => x86}/q35/DSDT.acpihmat-noinitiator   | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.applesmc        | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.bridge          | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.core-count      | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.core-count2     | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.cphp            | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.cxl             | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.dimmpxm         | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.ipmibt          | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.ipmismbus       | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.ivrs            | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.memhp           | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.mmio64          | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.multi-bridge    | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.noacpihp        | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.nohpet          | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.numamem         | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.pvpanic-isa     | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.thread-count    | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.thread-count2   | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.tis.tpm12       | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.tis.tpm2        | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.type4-count     | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.viot            | Bin
 tests/data/acpi/{ => x86}/q35/DSDT.xapic           | Bin
 tests/data/acpi/{ => x86}/q35/ERST.acpierst        | Bin
 tests/data/acpi/{ => x86}/q35/FACP                 | Bin
 tests/data/acpi/{ => x86}/q35/FACP.core-count      | Bin
 tests/data/acpi/{ => x86}/q35/FACP.core-count2     | Bin
 tests/data/acpi/{ => x86}/q35/FACP.nosmm           | Bin
 tests/data/acpi/{ => x86}/q35/FACP.slic            | Bin
 tests/data/acpi/{ => x86}/q35/FACP.thread-count    | Bin
 tests/data/acpi/{ => x86}/q35/FACP.thread-count2   | Bin
 tests/data/acpi/{ => x86}/q35/FACP.type4-count     | Bin
 tests/data/acpi/{ => x86}/q35/FACP.xapic           | Bin
 tests/data/acpi/{ => x86}/q35/FACS                 | Bin
 tests/data/acpi/{ => x86}/q35/HMAT.acpihmat        | Bin
 .../acpi/{ => x86}/q35/HMAT.acpihmat-noinitiator   | Bin
 tests/data/acpi/{ => x86}/q35/HPET                 | Bin
 tests/data/acpi/{ => x86}/q35/IVRS.ivrs            | Bin
 tests/data/acpi/{ => x86}/q35/MCFG                 | Bin
 tests/data/acpi/{ => x86}/q35/NFIT.dimmpxm         | Bin
 tests/data/acpi/{ => x86}/q35/SLIC.slic            | Bin
 tests/data/acpi/{ => x86}/q35/SLIT.cphp            | Bin
 tests/data/acpi/{virt => x86/q35}/SLIT.memhp       | Bin
 tests/data/acpi/{ => x86}/q35/SRAT.acpihmat        | Bin
 .../acpi/{ => x86}/q35/SRAT.acpihmat-noinitiator   | Bin
 tests/data/acpi/{ => x86}/q35/SRAT.cphp            | Bin
 tests/data/acpi/{ => x86}/q35/SRAT.dimmpxm         | Bin
 tests/data/acpi/{ => x86}/q35/SRAT.memhp           | Bin
 tests/data/acpi/{ => x86}/q35/SRAT.mmio64          | Bin
 tests/data/acpi/{ => x86}/q35/SRAT.numamem         | Bin
 tests/data/acpi/{ => x86}/q35/SRAT.xapic           | Bin
 tests/data/acpi/{ => x86}/q35/SSDT.dimmpxm         | Bin
 tests/data/acpi/{ => x86}/q35/TCPA.tis.tpm12       | Bin
 tests/data/acpi/{ => x86}/q35/TPM2.tis.tpm2        | Bin
 tests/data/acpi/{ => x86}/q35/VIOT.viot            | Bin
 tests/data/acpi/{ => x86}/q35/WAET                 | Bin
 .../bios-tables-test.riscv64.iso.qcow2             | Bin 0 -> 16896 bytes
 tests/qtest/meson.build                            |   3 +
 tests/uefi-test-tools/Makefile                     |  19 +-
 .../UefiTestToolsPkg/UefiTestToolsPkg.dsc          |   6 +-
 tests/uefi-test-tools/uefi-test-build.config       |  52 ++
 util/meson.build                                   |   4 +-
 251 files changed, 2958 insertions(+), 371 deletions(-)
 create mode 100644 backends/hostmem-shm.c
 rename tests/data/acpi/{ => aarch64}/virt/APIC (100%)
 rename tests/data/acpi/{ => aarch64}/virt/APIC.acpihmatvirt (100%)
 rename tests/data/acpi/{ => aarch64}/virt/APIC.topology (100%)
 rename tests/data/acpi/{ => aarch64}/virt/DBG2 (100%)
 rename tests/data/acpi/{ => aarch64}/virt/DSDT (100%)
 rename tests/data/acpi/{ => aarch64}/virt/DSDT.acpihmatvirt (100%)
 rename tests/data/acpi/{ => aarch64}/virt/DSDT.memhp (100%)
 rename tests/data/acpi/{ => aarch64}/virt/DSDT.pxb (100%)
 rename tests/data/acpi/{ => aarch64}/virt/DSDT.topology (100%)
 rename tests/data/acpi/{ => aarch64}/virt/FACP (100%)
 rename tests/data/acpi/{ => aarch64}/virt/GTDT (100%)
 rename tests/data/acpi/{ => aarch64}/virt/HMAT.acpihmatvirt (100%)
 rename tests/data/acpi/{ => aarch64}/virt/IORT (100%)
 rename tests/data/acpi/{ => aarch64}/virt/MCFG (100%)
 rename tests/data/acpi/{ => aarch64}/virt/NFIT.memhp (100%)
 rename tests/data/acpi/{ => aarch64}/virt/PPTT (100%)
 rename tests/data/acpi/{ => aarch64}/virt/PPTT.acpihmatvirt (100%)
 rename tests/data/acpi/{ => aarch64}/virt/PPTT.topology (100%)
 rename tests/data/acpi/{pc => aarch64/virt}/SLIT.memhp (100%)
 rename tests/data/acpi/{ => aarch64}/virt/SPCR (100%)
 rename tests/data/acpi/{ => aarch64}/virt/SRAT.acpihmatvirt (100%)
 rename tests/data/acpi/{ => aarch64}/virt/SRAT.memhp (100%)
 rename tests/data/acpi/{ => aarch64}/virt/SRAT.numamem (100%)
 rename tests/data/acpi/{ => aarch64}/virt/SSDT.memhp (100%)
 rename tests/data/acpi/{ => aarch64}/virt/VIOT (100%)
 create mode 100644 tests/data/acpi/riscv64/virt/APIC
 create mode 100644 tests/data/acpi/riscv64/virt/DSDT
 create mode 100644 tests/data/acpi/riscv64/virt/FACP
 create mode 100644 tests/data/acpi/riscv64/virt/MCFG
 create mode 100644 tests/data/acpi/riscv64/virt/RHCT
 create mode 100644 tests/data/acpi/riscv64/virt/SPCR
 rename tests/data/acpi/{ => x86}/microvm/APIC (100%)
 rename tests/data/acpi/{ => x86}/microvm/APIC.ioapic2 (100%)
 rename tests/data/acpi/{ => x86}/microvm/APIC.pcie (100%)
 rename tests/data/acpi/{ => x86}/microvm/DSDT (100%)
 rename tests/data/acpi/{ => x86}/microvm/DSDT.ioapic2 (100%)
 rename tests/data/acpi/{ => x86}/microvm/DSDT.pcie (100%)
 rename tests/data/acpi/{ => x86}/microvm/DSDT.rtc (100%)
 rename tests/data/acpi/{ => x86}/microvm/DSDT.usb (100%)
 rename tests/data/acpi/{ => x86}/microvm/ERST.pcie (100%)
 rename tests/data/acpi/{ => x86}/microvm/FACP (100%)
 rename tests/data/acpi/{ => x86}/pc/APIC (100%)
 rename tests/data/acpi/{ => x86}/pc/APIC.acpihmat (100%)
 rename tests/data/acpi/{ => x86}/pc/APIC.cphp (100%)
 rename tests/data/acpi/{ => x86}/pc/APIC.dimmpxm (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.acpierst (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.acpihmat (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.bridge (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.cphp (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.dimmpxm (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.hpbridge (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.hpbrroot (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.ipmikcs (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.memhp (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.nohpet (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.numamem (100%)
 rename tests/data/acpi/{ => x86}/pc/DSDT.roothp (100%)
 rename tests/data/acpi/{ => x86}/pc/ERST.acpierst (100%)
 rename tests/data/acpi/{ => x86}/pc/FACP (100%)
 rename tests/data/acpi/{ => x86}/pc/FACP.nosmm (100%)
 rename tests/data/acpi/{ => x86}/pc/FACS (100%)
 rename tests/data/acpi/{ => x86}/pc/HMAT.acpihmat (100%)
 rename tests/data/acpi/{ => x86}/pc/HPET (100%)
 rename tests/data/acpi/{ => x86}/pc/NFIT.dimmpxm (100%)
 rename tests/data/acpi/{ => x86}/pc/SLIT.cphp (100%)
 rename tests/data/acpi/{q35 => x86/pc}/SLIT.memhp (100%)
 rename tests/data/acpi/{ => x86}/pc/SRAT.acpihmat (100%)
 rename tests/data/acpi/{ => x86}/pc/SRAT.cphp (100%)
 rename tests/data/acpi/{ => x86}/pc/SRAT.dimmpxm (100%)
 rename tests/data/acpi/{ => x86}/pc/SRAT.memhp (100%)
 rename tests/data/acpi/{ => x86}/pc/SRAT.numamem (100%)
 rename tests/data/acpi/{ => x86}/pc/SSDT.dimmpxm (100%)
 rename tests/data/acpi/{ => x86}/pc/WAET (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC.acpihmat (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC.acpihmat-noinitiator (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC.core-count (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC.core-count2 (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC.cphp (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC.dimmpxm (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC.thread-count (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC.thread-count2 (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC.type4-count (100%)
 rename tests/data/acpi/{ => x86}/q35/APIC.xapic (100%)
 rename tests/data/acpi/{ => x86}/q35/CEDT.cxl (100%)
 rename tests/data/acpi/{ => x86}/q35/DMAR.dmar (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.acpierst (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.acpihmat (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.acpihmat-noinitiator (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.applesmc (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.bridge (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.core-count (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.core-count2 (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.cphp (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.cxl (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.dimmpxm (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.ipmibt (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.ipmismbus (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.ivrs (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.memhp (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.mmio64 (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.multi-bridge (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.noacpihp (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.nohpet (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.numamem (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.pvpanic-isa (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.thread-count (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.thread-count2 (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.tis.tpm12 (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.tis.tpm2 (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.type4-count (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.viot (100%)
 rename tests/data/acpi/{ => x86}/q35/DSDT.xapic (100%)
 rename tests/data/acpi/{ => x86}/q35/ERST.acpierst (100%)
 rename tests/data/acpi/{ => x86}/q35/FACP (100%)
 rename tests/data/acpi/{ => x86}/q35/FACP.core-count (100%)
 rename tests/data/acpi/{ => x86}/q35/FACP.core-count2 (100%)
 rename tests/data/acpi/{ => x86}/q35/FACP.nosmm (100%)
 rename tests/data/acpi/{ => x86}/q35/FACP.slic (100%)
 rename tests/data/acpi/{ => x86}/q35/FACP.thread-count (100%)
 rename tests/data/acpi/{ => x86}/q35/FACP.thread-count2 (100%)
 rename tests/data/acpi/{ => x86}/q35/FACP.type4-count (100%)
 rename tests/data/acpi/{ => x86}/q35/FACP.xapic (100%)
 rename tests/data/acpi/{ => x86}/q35/FACS (100%)
 rename tests/data/acpi/{ => x86}/q35/HMAT.acpihmat (100%)
 rename tests/data/acpi/{ => x86}/q35/HMAT.acpihmat-noinitiator (100%)
 rename tests/data/acpi/{ => x86}/q35/HPET (100%)
 rename tests/data/acpi/{ => x86}/q35/IVRS.ivrs (100%)
 rename tests/data/acpi/{ => x86}/q35/MCFG (100%)
 rename tests/data/acpi/{ => x86}/q35/NFIT.dimmpxm (100%)
 rename tests/data/acpi/{ => x86}/q35/SLIC.slic (100%)
 rename tests/data/acpi/{ => x86}/q35/SLIT.cphp (100%)
 rename tests/data/acpi/{virt => x86/q35}/SLIT.memhp (100%)
 rename tests/data/acpi/{ => x86}/q35/SRAT.acpihmat (100%)
 rename tests/data/acpi/{ => x86}/q35/SRAT.acpihmat-noinitiator (100%)
 rename tests/data/acpi/{ => x86}/q35/SRAT.cphp (100%)
 rename tests/data/acpi/{ => x86}/q35/SRAT.dimmpxm (100%)
 rename tests/data/acpi/{ => x86}/q35/SRAT.memhp (100%)
 rename tests/data/acpi/{ => x86}/q35/SRAT.mmio64 (100%)
 rename tests/data/acpi/{ => x86}/q35/SRAT.numamem (100%)
 rename tests/data/acpi/{ => x86}/q35/SRAT.xapic (100%)
 rename tests/data/acpi/{ => x86}/q35/SSDT.dimmpxm (100%)
 rename tests/data/acpi/{ => x86}/q35/TCPA.tis.tpm12 (100%)
 rename tests/data/acpi/{ => x86}/q35/TPM2.tis.tpm2 (100%)
 rename tests/data/acpi/{ => x86}/q35/VIOT.viot (100%)
 rename tests/data/acpi/{ => x86}/q35/WAET (100%)
 create mode 100644 tests/data/uefi-boot-images/bios-tables-test.riscv64.iso.qcow2
 create mode 100644 tests/uefi-test-tools/uefi-test-build.config


