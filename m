Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1FAFC3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgjg-0002Mg-06; Sun, 21 Jul 2024 20:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgje-0002M0-KH
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgjc-0005h4-9q
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DH/ESJQPBGLop/GhzPXFwzSewSPtzCwZMu0vBrYFALw=;
 b=I3zhScJlP5i9vueKCC6AOEsGm618hzpvWitAm0954/lzrDILDyntTYfks046nhwEGBng+h
 dAmsBff5Xrd5JtFWy1SzuvrXB8DmqZaiNluzt7HZpSgq0MFzxLxjq2D3JsnIjLloOwzygP
 Egsmv1Z8uPrXjPQ8+ujfyezM5er/Xyo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-C0P1o7E9NySlS8oB9AG1AA-1; Sun, 21 Jul 2024 20:16:53 -0400
X-MC-Unique: C0P1o7E9NySlS8oB9AG1AA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-36873ed688dso2098444f8f.1
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607411; x=1722212211;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DH/ESJQPBGLop/GhzPXFwzSewSPtzCwZMu0vBrYFALw=;
 b=EanSg+SRkA+WiZ8KP5Sphx4ALbnJcUK2wqSBuY7FCmB+PEvakONbghE88EW9dB0qky
 CO0K2fO3+EjIfhevRlEpJHn4nJJ4HSVgslclVLiuygXlODusaqyTmuDNy0Nfw9S7oO8q
 34UgGYvo6fDTQZGBLMeK0rZ85UtM6uNlX69uKmi0/xS5Q1i8QdysDnSgJF1YTcwHNTCL
 xzFsebpB1oE3vY6t0dagc0an8bRi3mhESlT6y8+PZWLOvUrlkjtHT1SKMx/xyUk8gLpp
 H8C6xjrQYRLN/W5Y7bEkKTVS3NYZubyGfa2qYVYqJiuJ6XicqBQkB7KTMiG3t8BNpHZL
 5c1g==
X-Gm-Message-State: AOJu0YxUGrs4UZbRw3tetPEssEgTDoiP5HkDOUsdBdKhNA9QlfTb7VK9
 q82Bef5q57v9FbNzYigiEDz5jgFY5CYhNpbFBMbO+tDoacMj6uVpSgkfkM6oDTiVrW20dnIpbCs
 oS8nFMa3CK5BccsT29JUoLhOAKOGeMotgqJOnI4Nyqj02nP/pjlAZSOOi+C2D5qB1a8HkvUFsIX
 IDJkMcxcF6dvpwGLGx6xfd/7vxfmcgUQ==
X-Received: by 2002:adf:edcb:0:b0:362:c7b3:764c with SMTP id
 ffacd0b85a97d-369bbc91e3fmr3088257f8f.48.1721607411358; 
 Sun, 21 Jul 2024 17:16:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMhHc70yYCIaUSWPk6Ik0f96jKSZ2poUNaMCageMQsqSt3ajK9NG/AmIAD87aB/o60wU3nMg==
X-Received: by 2002:adf:edcb:0:b0:362:c7b3:764c with SMTP id
 ffacd0b85a97d-369bbc91e3fmr3088244f8f.48.1721607410558; 
 Sun, 21 Jul 2024 17:16:50 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427db34fe3fsm73495175e9.4.2024.07.21.17.16.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:16:49 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:16:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/63] virtio,pci,pc: features,fixes
Message-ID: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

A couple of fixes are outstanding, will merge later.


The following changes since commit a87a7c449e532130d4fa8faa391ff7e1f04ed660:

  Merge tag 'pull-loongarch-20240719' of https://gitlab.com/gaosong/qemu into staging (2024-07-19 16:28:28 +1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 67d834362c55d6fca6504975bc34755606f17cf2:

  virtio: Always reset vhost devices (2024-07-21 14:45:56 -0400)

----------------------------------------------------------------
virtio,pci,pc: features,fixes

pci: Initial support for SPDM Responders
cxl: Add support for scan media, feature commands, device patrol scrub
    control, DDR5 ECS control, firmware updates
virtio: in-order support
virtio-net: support for SR-IOV emulation (note: known issues on s390,
                                          might get reverted if not fixed)
smbios: memory device size is now configurable per Machine
cpu: architecture agnostic code to support vCPU Hotplug

Fixes, cleanups all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Akihiko Odaki (8):
      hw/pci: Do not add ROM BAR for SR-IOV VF
      hw/pci: Fix SR-IOV VF number calculation
      pcie_sriov: Ensure PF and VF are mutually exclusive
      pcie_sriov: Check PCI Express for SR-IOV PF
      pcie_sriov: Allow user to create SR-IOV device
      virtio-pci: Implement SR-IOV PF
      virtio-net: Implement SR-IOV VF
      docs: Document composable SR-IOV device

Alistair Francis (1):
      hw/pci: Add all Data Object Types defined in PCIe r6.0

Clément Mathieu--Drif (4):
      intel_iommu: fix FRCD construction macro
      intel_iommu: move VTD_FRCD_PV and VTD_FRCD_PP declarations
      intel_iommu: fix type of the mask field in VTDIOTLBPageInvInfo
      intel_iommu: make type match

Davidlohr Bueso (3):
      hw/cxl: Add get scan media capabilities cmd support
      hw/cxl: Add get scan media results cmd support
      hw/cxl: Support firmware updates

Eric Auger (6):
      Revert "virtio-iommu: Clear IOMMUDevice when VFIO device is unplugged"
      virtio-iommu: Remove probe_done
      virtio-iommu: Free [host_]resv_ranges on unset_iommu_devices
      virtio-iommu: Remove the end point on detach
      hw/vfio/common: Add vfio_listener_region_del_iommu trace event
      virtio-iommu: Add trace point on virtio_iommu_detach_endpoint_from_domain

Fan Ni (1):
      hw/cxl/cxl-mailbox-utils: remove unneeded mailbox output payload space zeroing

Gregory Price (1):
      cxl/mailbox: move mailbox effect definitions to a header

Hanna Czenczek (1):
      virtio: Always reset vhost devices

Huai-Cheng Kuo (1):
      backends: Initial support for SPDM socket support

Hyeonggon Yoo (2):
      hw/cxl/mbox: replace sanitize_running() with cxl_dev_media_disabled()
      hw/cxl/events: discard all event records during sanitation

Igor Mammedov (1):
      smbios: make memory device size configurable per Machine

Jonah Palmer (6):
      virtio: Add bool to VirtQueueElement
      virtio: virtqueue_pop - VIRTIO_F_IN_ORDER support
      virtio: virtqueue_ordered_fill - VIRTIO_F_IN_ORDER support
      virtio: virtqueue_ordered_flush - VIRTIO_F_IN_ORDER support
      vhost,vhost-user: Add VIRTIO_F_IN_ORDER to vhost feature bits
      virtio: Add VIRTIO_F_IN_ORDER property definition

Jonathan Cameron (1):
      hw/cxl: Check for multiple mappings of memory backends.

Manos Pitsidianakis (2):
      virtio-snd: add max size bounds check in input cb
      virtio-snd: check for invalid param shift operands

Salil Mehta (7):
      accel/kvm: Extract common KVM vCPU {creation,parking} code
      hw/acpi: Move CPU ctrl-dev MMIO region len macro to common header file
      hw/acpi: Update ACPI GED framework to support vCPU Hotplug
      hw/acpi: Update GED _EVT method AML with CPU scan
      hw/acpi: Update CPUs AML with cpu-(ctrl)dev change
      physmem: Add helper function to destroy CPU AddressSpace
      gdbstub: Add helper function to unregister GDB register space

Shiju Jose (3):
      hw/cxl/cxl-mailbox-utils: Add support for feature commands (8.2.9.6)
      hw/cxl/cxl-mailbox-utils: Add device patrol scrub control feature
      hw/cxl/cxl-mailbox-utils: Add device DDR5 ECS control feature

Stefano Garzarella (2):
      MAINTAINERS: add Stefano Garzarella as vhost/vhost-user reviewer
      contrib/vhost-user-blk: fix overflowing expression

Sunil V L (9):
      hw/riscv/virt-acpi-build.c: Add namespace devices for PLIC and APLIC
      hw/riscv/virt-acpi-build.c: Update the HID of RISC-V UART
      tests/acpi: Allow DSDT acpi table changes for aarch64
      acpi/gpex: Create PCI link devices outside PCI root bridge
      tests/acpi: update expected DSDT blob for aarch64 and microvm
      tests/qtest/bios-tables-test.c: Remove the fall back path
      tests/acpi: Add empty ACPI data files for RISC-V
      tests/qtest/bios-tables-test.c: Enable basic testing for RISC-V
      tests/acpi: Add expected ACPI AML files for RISC-V

Wilfred Mallawa (1):
      hw/nvme: Add SPDM over DOE support

Yi Liu (1):
      MAINTAINERS: Add myself as a VT-d reviewer

Zhao Liu (1):
      hw/cxl/cxl-host: Fix segmentation fault when getting cxl-fmw property

Zheyu Ma (1):
      hw/virtio/virtio-crypto: Fix op_code assignment in virtio_crypto_create_asym_session

 accel/kvm/kvm-cpus.h                           |   1 -
 hw/i386/intel_iommu_internal.h                 |   6 +-
 include/exec/cpu-common.h                      |   8 +
 include/exec/gdbstub.h                         |   6 +
 include/hw/acpi/cpu.h                          |   7 +-
 include/hw/acpi/generic_event_device.h         |   5 +
 include/hw/boards.h                            |   4 +
 include/hw/core/cpu.h                          |   1 +
 include/hw/cxl/cxl_device.h                    |  88 ++-
 include/hw/cxl/cxl_mailbox.h                   |  18 +
 include/hw/pci/pci_device.h                    |  13 +-
 include/hw/pci/pcie_doe.h                      |   5 +
 include/hw/pci/pcie_sriov.h                    |  18 +
 include/hw/virtio/virtio-iommu.h               |   1 -
 include/hw/virtio/virtio-pci.h                 |   1 +
 include/hw/virtio/virtio.h                     |   6 +-
 include/sysemu/kvm.h                           |  25 +
 include/sysemu/spdm-socket.h                   |  74 ++
 accel/kvm/kvm-all.c                            |  95 ++-
 backends/spdm-socket.c                         | 216 ++++++
 contrib/vhost-user-blk/vhost-user-blk.c        |   2 +-
 gdbstub/gdbstub.c                              |  13 +
 hw/acpi/acpi-cpu-hotplug-stub.c                |   6 +
 hw/acpi/cpu.c                                  |  18 +-
 hw/acpi/generic_event_device.c                 |  50 ++
 hw/arm/virt.c                                  |   1 +
 hw/audio/virtio-snd.c                          |  13 +-
 hw/block/vhost-user-blk.c                      |   1 +
 hw/core/cpu-common.c                           |   5 +-
 hw/core/machine.c                              |   6 +
 hw/cxl/cxl-events.c                            |  13 +
 hw/cxl/cxl-host.c                              |   3 +-
 hw/cxl/cxl-mailbox-utils.c                     | 966 +++++++++++++++++++++++--
 hw/i386/acpi-build.c                           |   3 +-
 hw/i386/intel_iommu.c                          |   2 +-
 hw/i386/pc_piix.c                              |   1 +
 hw/i386/pc_q35.c                               |   1 +
 hw/mem/cxl_type3.c                             |  64 +-
 hw/net/vhost_net.c                             |   2 +
 hw/nvme/ctrl.c                                 |  62 ++
 hw/pci-host/gpex-acpi.c                        |  13 +-
 hw/pci/pci.c                                   |  76 +-
 hw/pci/pcie_sriov.c                            | 300 ++++++--
 hw/riscv/virt-acpi-build.c                     |  34 +-
 hw/scsi/vhost-scsi.c                           |   1 +
 hw/scsi/vhost-user-scsi.c                      |   1 +
 hw/smbios/smbios.c                             |  11 +-
 hw/vfio/common.c                               |   3 +-
 hw/virtio/vhost-user-fs.c                      |   1 +
 hw/virtio/vhost-user-vsock.c                   |   1 +
 hw/virtio/virtio-crypto.c                      |   2 +-
 hw/virtio/virtio-iommu.c                       |  88 +--
 hw/virtio/virtio-net-pci.c                     |   1 +
 hw/virtio/virtio-pci.c                         |  20 +-
 hw/virtio/virtio.c                             | 139 +++-
 net/vhost-vdpa.c                               |   1 +
 system/physmem.c                               |  29 +
 tests/qtest/bios-tables-test.c                 |  40 +-
 MAINTAINERS                                    |   9 +
 accel/kvm/trace-events                         |   5 +-
 backends/Kconfig                               |   4 +
 backends/meson.build                           |   2 +
 docs/specs/acpi_hw_reduced_hotplug.rst         |   3 +-
 docs/specs/index.rst                           |   1 +
 docs/specs/spdm.rst                            | 134 ++++
 docs/system/index.rst                          |   1 +
 docs/system/sriov.rst                          |  36 +
 hw/vfio/trace-events                           |   3 +-
 hw/virtio/trace-events                         |   1 +
 tests/data/acpi/aarch64/virt/DSDT              | Bin 5196 -> 5196 bytes
 tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt | Bin 5282 -> 5282 bytes
 tests/data/acpi/aarch64/virt/DSDT.memhp        | Bin 6557 -> 6557 bytes
 tests/data/acpi/aarch64/virt/DSDT.pxb          | Bin 7679 -> 7679 bytes
 tests/data/acpi/aarch64/virt/DSDT.topology     | Bin 5398 -> 5398 bytes
 tests/data/acpi/riscv64/virt/APIC              | Bin 0 -> 116 bytes
 tests/data/acpi/riscv64/virt/DSDT              | Bin 0 -> 3576 bytes
 tests/data/acpi/riscv64/virt/FACP              | Bin 0 -> 276 bytes
 tests/data/acpi/riscv64/virt/MCFG              | Bin 0 -> 60 bytes
 tests/data/acpi/riscv64/virt/RHCT              | Bin 0 -> 332 bytes
 tests/data/acpi/riscv64/virt/SPCR              | Bin 0 -> 80 bytes
 tests/data/acpi/x86/microvm/DSDT.pcie          | Bin 3023 -> 3023 bytes
 81 files changed, 2500 insertions(+), 290 deletions(-)
 create mode 100644 include/hw/cxl/cxl_mailbox.h
 create mode 100644 include/sysemu/spdm-socket.h
 create mode 100644 backends/spdm-socket.c
 create mode 100644 docs/specs/spdm.rst
 create mode 100644 docs/system/sriov.rst
 create mode 100644 tests/data/acpi/riscv64/virt/APIC
 create mode 100644 tests/data/acpi/riscv64/virt/DSDT
 create mode 100644 tests/data/acpi/riscv64/virt/FACP
 create mode 100644 tests/data/acpi/riscv64/virt/MCFG
 create mode 100644 tests/data/acpi/riscv64/virt/RHCT
 create mode 100644 tests/data/acpi/riscv64/virt/SPCR


