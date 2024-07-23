Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F12C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 10:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDAt-0006JV-OS; Tue, 23 Jul 2024 06:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDAr-0006Ie-EU
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:55:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDAo-0001Wm-Td
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=d5weeYnIdRONYakNGZjCigzbuKt/Leqa3Yad9SpKsTQ=;
 b=VVpHqk3Qoo8LRyZ7oo6kzmUfvp+c7+6eJUzpYMaqpbkwCEsmcSJqSsQSMs+MPmP6+WJ4Hr
 tRS6tdIki+JP2mK6RMElV5KL7Bqv8DYcBPvv9JsxRH58fbtTcJmJmJktpBhkQstE4SxK1Z
 ZwmSLjAzBICKk3XlALVuqun7UA6ZTuY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-p6fdK4PyOLKQMtfa37Uf9g-1; Tue, 23 Jul 2024 06:55:12 -0400
X-MC-Unique: p6fdK4PyOLKQMtfa37Uf9g-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-57c93227bbeso2885060a12.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732110; x=1722336910;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d5weeYnIdRONYakNGZjCigzbuKt/Leqa3Yad9SpKsTQ=;
 b=fwP00+aF6vtZUKF1xisMbU9XCXSbXRrmrUY03DBb7rseQpFSrM8qdcFeUiu+PM+PkN
 noA/yzjUw5gs9vrNjhnKUUgP43LJJlv1JtOrvCtKz0qt2ThlL5ABGCKWmBkF2nuKJHun
 z4Nw4WaRNVjpe4ZqNVrxqJzNwG1A/f1chPBiWV/9AEnhslXb/bYNFDJc/UkN+PcO9nAY
 bEYfuzhnzwarfGt0Hj/gG5pGm0p4qwQr9b1HGKgpc95nvjZbbI91gh7pP49dG0CJUJfW
 vPvlCvRSb8rtIv2Zal4C16FiShzmJZGjuiASP+ycSTs7saiumL9Nmgsy3GlVMz/tfkRt
 dWuA==
X-Gm-Message-State: AOJu0Yxrui/wtpWSNL7SAR++anRzdslvxXw4bW1rVG7/NXGaKJlIqrqL
 Xjcut0wxp0ePbhKpTKOS1iOqQqFIIapTv8llN5p/zafzwIb+1a849XKOgb8dOXpjNvnpEDJGf/Y
 UYq4FVeS10T/YMVVy5TGf9sPmrQVh9kuXFMZMUQRC42B+cfzTvWzLcGKEmVsRenzLWZnQfOnR3p
 ZCJS3UloM2/4a9DXFYYejHdlnfzPAltg==
X-Received: by 2002:a50:d6dc:0:b0:5a0:f8a2:9cf5 with SMTP id
 4fb4d7f45d1cf-5a3f089d878mr6340077a12.29.1721732110252; 
 Tue, 23 Jul 2024 03:55:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEPefce0//dpRvvjbmfM63J7spLjwRLSRJB6Db7NCNitwbES6xJb7WFAkDmLHrWLjOe/x7Hw==
X-Received: by 2002:a50:d6dc:0:b0:5a0:f8a2:9cf5 with SMTP id
 4fb4d7f45d1cf-5a3f089d878mr6340051a12.29.1721732109436; 
 Tue, 23 Jul 2024 03:55:09 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5a30a4d6e45sm7386570a12.7.2024.07.23.03.55.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:55:08 -0700 (PDT)
Date: Tue, 23 Jul 2024 06:55:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 00/61] virtio,pci,pc: features,fixes
Message-ID: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

changes from v1:
    dropped two patches:
        hw/pci: Do not add ROM BAR for SR-IOV VF
        virtio: Always reset vhost devices
    at author's request

Akiko, I think the on/off rework is a bit risky so close
to the release. So pls rework your patch not to depend on that.
Also pls note you still need to fix s390, if that does
not happen by say rc1 I'll have to revert all this stuff
by rc2, and defer to the next release.

Thanks!

The following changes since commit a87a7c449e532130d4fa8faa391ff7e1f04ed660:

  Merge tag 'pull-loongarch-20240719' of https://gitlab.com/gaosong/qemu into staging (2024-07-19 16:28:28 +1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 4f947b10d525958578002848a92eeb6152ffbf0d:

  hw/nvme: Add SPDM over DOE support (2024-07-22 20:15:42 -0400)

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
Akihiko Odaki (7):
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
 hw/pci/pci.c                                   |  68 +-
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
 hw/virtio/virtio.c                             | 131 +++-
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
 81 files changed, 2486 insertions(+), 288 deletions(-)
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


