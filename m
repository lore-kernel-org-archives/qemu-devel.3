Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8729FCAC5B8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 20:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5VDz-0002Qe-UB; Sun, 05 Oct 2025 16:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5VDy-0002QV-KU
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 16:20:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5VDw-0005dz-BS
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 16:20:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759695651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A0xFP0tCVcOdnstqs/+GzCGyMIBtsrblWuyNtYZR+A0=;
 b=CXcQj6Cg+E9zqciOWUUUqSqTIcTNd5OQrJTQ4FVb0EGijSGJgu3gRe+N/4EIHpMBiysJFO
 ropX9R+Zu1tPgW6AABh1TffYzspYifO87guJTmqnNQGvRhuahvwTkqs54Su7OHnD5CnTle
 0GFPJdKDWi6QIZEExfMEiagJ2cftuxI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-OXSa5wFRPyS9tPDz23xzLw-1; Sun, 05 Oct 2025 16:20:49 -0400
X-MC-Unique: OXSa5wFRPyS9tPDz23xzLw-1
X-Mimecast-MFC-AGG-ID: OXSa5wFRPyS9tPDz23xzLw_1759695648
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e2c11b94cso21241845e9.3
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 13:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759695648; x=1760300448;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A0xFP0tCVcOdnstqs/+GzCGyMIBtsrblWuyNtYZR+A0=;
 b=YqiatPeHyOxP2sw90wePP4lliyjh+yq8GmF1v2xex+tUCisiw3iImXB6d4Rsvc8gDZ
 atukIVED0rJl4Z5fxJN8VkDJz1NvTPFKYvj1ZPUAPPBxXhL3H3mzibZoEjI1SneBHEpm
 Xhfb5rk5gvgapc09N3osB25XDEcu1eIBwW1OB3rLq3BL7aODCph8bn6MXVJSgKwhhw92
 vzKQntdUEJibdbLi767FS9I/mxeAeeZAZnKP/bybGVNJL+Tg5HS92tWY7Vs1KLJCQBpj
 73P4QA0RYiHj+b8Su8GMsex9Q9/zBy3jiNFGE8gF72X2YzC2AQWHrUDQAHyx0XCWl59H
 qvIA==
X-Gm-Message-State: AOJu0Yy18+IgMZBebe4fdpuH671JAPgcPBxfhCk+1COpMJ0Nsl9SBvNB
 m8KF42NB62LHK59OT4tWNx+/c8k7tgO69D2WztNd3eZRdv4ADfh/kNyz+4COQv8gKh3Qq7G83dj
 5oNz95CeWYeg0NVO1Ux8ARWjlpMTlLsOq1oX2ZnAfZ9NVxMiEGGcjvsnsg4qJ8XPj3slXcZy8/Z
 SnMD5mymi8oBO4bzjw8hV14mNi6QfdwWywCQ==
X-Gm-Gg: ASbGncvMSnF8if4EllkqbL260EDwfBOyZbMwX9/W22nSzDvu8fXOXYjYUCFvao+yQ1H
 S2zV6ZVt0VEa4EnJC9eZiDn6MZCRjCCRvefS8QRIQiKbqXpFwRUaIDlqEjX5F9jtB9XmOkSYHEV
 GS4eusR9VYa2wOUsDgNKwDIllnft8yPa5JS7pMpDZuFNtOmWj4s2Sw9w3OvKuxFp7d5igO4ldlr
 QRJ/JVtwuboquMzVTTur29wFPXy+5KVc64hhAGwMDinnGutnw/TDuPwzGJ0PMWdoz4ZkGWDaStR
 pSWYpvMURzQHi7h/w4xw/dj9H3tOgQucyOvIZlk=
X-Received: by 2002:a05:600c:c162:b0:456:13b6:4b18 with SMTP id
 5b1f17b1804b1-46e7114486bmr74013635e9.31.1759695648041; 
 Sun, 05 Oct 2025 13:20:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUv5HmXBgybS9cDEOn9Hg0LyZJEc1ukprWQEh2YCy+ekqFjrKh5TaQap8WSSro6xojpCA97w==
X-Received: by 2002:a05:600c:c162:b0:456:13b6:4b18 with SMTP id
 5b1f17b1804b1-46e7114486bmr74013495e9.31.1759695647495; 
 Sun, 05 Oct 2025 13:20:47 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f45e9sm18016540f8f.51.2025.10.05.13.20.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 13:20:46 -0700 (PDT)
Date: Sun, 5 Oct 2025 16:20:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/75] virtio,pci,pc: features, fixes
Message-ID: <20251005162013-mutt-send-email-mst@kernel.org>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, Oct 05, 2025 at 03:16:03PM -0400, Michael S. Tsirkin wrote:
> The following changes since commit 81e3121bef89bcd3ccb261899e5a36246199065d:
> 
>   Merge tag 'pull-vfio-20251003' of https://github.com/legoater/qemu into staging (2025-10-03 04:57:58 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> 
> for you to fetch changes up to e27b177339ea4d391ed7538fbdbad34518937408:
> 
>   pci: Fix wrong parameter passing to pci_device_get_iommu_bus_devfn() (2025-10-05 09:13:26 -0400)

it is:

commit e209d4d7a31b9f82925a2205e6e19e61a3facbe0

    virtio: improve virtqueue mapping error messages

now.


sorry.


> ----------------------------------------------------------------
> virtio,pci,pc: features, fixes
> 
> users can now control VM bit in smbios.
> vhost-user-device is now user-createable.
> intel_iommu now supports PRI
> virtio-net now supports GSO over UDP tunnel
> ghes now supports error injection
> amd iommu now supports dma remapping for vfio
> 
> small fixes all over the place.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ----------------------------------------------------------------
> Alejandro Jimenez (20):
>       memory: Adjust event ranges to fit within notifier boundaries
>       amd_iommu: Document '-device amd-iommu' common options
>       amd_iommu: Reorder device and page table helpers
>       amd_iommu: Helper to decode size of page invalidation command
>       amd_iommu: Add helper function to extract the DTE
>       amd_iommu: Return an error when unable to read PTE from guest memory
>       amd_iommu: Add helpers to walk AMD v1 Page Table format
>       amd_iommu: Add a page walker to sync shadow page tables on invalidation
>       amd_iommu: Add basic structure to support IOMMU notifier updates
>       amd_iommu: Sync shadow page tables on page invalidation
>       amd_iommu: Use iova_tree records to determine large page size on UNMAP
>       amd_iommu: Unmap all address spaces under the AMD IOMMU on reset
>       amd_iommu: Add replay callback
>       amd_iommu: Invalidate address translations on INVALIDATE_IOMMU_ALL
>       amd_iommu: Toggle memory regions based on address translation mode
>       amd_iommu: Set all address spaces to use passthrough mode on reset
>       amd_iommu: Add dma-remap property to AMD vIOMMU device
>       amd_iommu: Toggle address translation mode on devtab entry invalidation
>       amd_iommu: Do not assume passthrough translation when DTE[TV]=0
>       amd_iommu: Refactor amdvi_page_walk() to use common code for page walk
> 
> Alessandro Ratti (1):
>       virtio: Add function name to error messages
> 
> Alex Bennée (1):
>       hw/virtio: rename vhost-user-device and make user creatable
> 
> CLEMENT MATHIEU--DRIF (5):
>       pcie: Add a way to get the outstanding page request allocation (pri) from the config space.
>       intel_iommu: Bypass barrier wait descriptor
>       intel_iommu: Declare PRI constants and structures
>       intel_iommu: Declare registers for PRI
>       intel_iommu: Add PRI operations support
> 
> Damien Bergamini (1):
>       pcie_sriov: Fix broken MMIO accesses from SR-IOV VFs
> 
> Daniil Tatianin (1):
>       hw/smbios: allow clearing the VM bit in SMBIOS table 0
> 
> Igor Mammedov (2):
>       smbios: cap DIMM size to 2Tb as workaround for broken Windows
>       x86: ich9: fix default value of 'No Reboot' bit in GCS
> 
> Joao Martins (2):
>       intel-iommu: Move dma_translation to x86-iommu
>       amd_iommu: HATDis/HATS=11 support
> 
> Li Zhaoxin (1):
>       vdpa-dev: add get_vhost() callback for vhost-vdpa device
> 
> Mauro Carvalho Chehab (17):
>       Revert "hw/acpi/ghes: Make ghes_record_cper_errors() static"
>       acpi/ghes: Cleanup the code which gets ghes ged state
>       acpi/ghes: prepare to change the way HEST offsets are calculated
>       acpi/ghes: add a firmware file with HEST address
>       acpi/ghes: Use HEST table offsets when preparing GHES records
>       acpi/ghes: don't hard-code the number of sources for HEST table
>       acpi/ghes: add a notifier to notify when error data is ready
>       acpi/generic_event_device: Update GHES migration to cover hest addr
>       acpi/generic_event_device: add logic to detect if HEST addr is available
>       acpi/generic_event_device: add an APEI error device
>       tests/acpi: virt: allow acpi table changes at DSDT and HEST tables
>       arm/virt: Wire up a GED error device for ACPI / GHES
>       qapi/acpi-hest: add an interface to do generic CPER error injection
>       acpi/generic_event_device.c: enable use_hest_addr for QEMU 10.x
>       tests/acpi: virt: update HEST and DSDT tables
>       docs: hest: add new "etc/acpi_table_hest_addr" and update workflow
>       scripts/ghes_inject: add a script to generate GHES error inject
> 
> Paolo Abeni (14):
>       net: bundle all offloads in a single struct
>       linux-headers: deal with counted_by annotation
>       linux-headers: Update to Linux v6.17-rc1
>       virtio: introduce extended features type
>       virtio: serialize extended features state
>       virtio: add support for negotiating extended features
>       virtio-pci: implement support for extended features
>       vhost: add support for negotiating extended features
>       qmp: update virtio features map to support extended features
>       vhost-backend: implement extended features support
>       vhost-net: implement extended features support
>       virtio-net: implement extended features support
>       net: implement tunnel probing
>       net: implement UDP tunnel features offloading
> 
> Stefan Hajnoczi (6):
>       vhost: use virtio_config_get_guest_notifier()
>       virtio: unify virtio_notify_irqfd() and virtio_notify()
>       virtio: support irqfd in virtio_notify_config()
>       tests/libqos: extract qvirtqueue_set_avail_idx()
>       tests/virtio-scsi: add a virtio_error() IOThread test
>       pcie_sriov: make pcie_sriov_pf_exit() safe on non-SR-IOV devices
> 
> Zhenzhong Duan (3):
>       intel_iommu: Enable Enhanced Set Root Table Pointer Support (ESRTPS)
>       intel_iommu: Simplify caching mode check with VFIO device
>       pci: Fix wrong parameter passing to pci_device_get_iommu_bus_devfn()
> 
> peng guo (1):
>       hw/i386/pc: Avoid overlap between CXL window and PCI 64bit BARs in QEMU
> 
>  docs/pcie_sriov.txt                                |    5 +-
>  qapi/acpi-hest.json                                |   36 +
>  qapi/qapi-schema.json                              |    1 +
>  qapi/virtio.json                                   |    9 +-
>  hw/i386/amd_iommu.h                                |   51 +
>  hw/i386/intel_iommu_internal.h                     |   52 +
>  hw/virtio/virtio-qmp.h                             |    3 +-
>  include/hw/acpi/acpi_dev_interface.h               |    1 +
>  include/hw/acpi/aml-build.h                        |    2 +
>  include/hw/acpi/generic_event_device.h             |    1 +
>  include/hw/acpi/ghes.h                             |   51 +-
>  include/hw/arm/virt.h                              |    2 +
>  include/hw/firmware/smbios.h                       |    2 +-
>  include/hw/i386/intel_iommu.h                      |    1 +
>  include/hw/i386/x86-iommu.h                        |    1 +
>  include/hw/pci/pcie.h                              |    1 +
>  include/hw/pci/pcie_sriov.h                        |    4 -
>  include/hw/southbridge/ich9.h                      |    2 +-
>  include/hw/virtio/vhost-backend.h                  |    6 +
>  include/hw/virtio/vhost-user-base.h                |    2 +-
>  include/hw/virtio/vhost.h                          |   56 +-
>  include/hw/virtio/virtio-features.h                |  126 +++
>  include/hw/virtio/virtio-net.h                     |    2 +-
>  include/hw/virtio/virtio-pci.h                     |    2 +-
>  include/hw/virtio/virtio.h                         |   16 +-
>  include/net/net.h                                  |   20 +-
>  include/net/vhost_net.h                            |   33 +-
>  include/standard-headers/drm/drm_fourcc.h          |   56 +-
>  include/standard-headers/linux/ethtool.h           |    4 +-
>  include/standard-headers/linux/input-event-codes.h |    8 +
>  include/standard-headers/linux/input.h             |    1 +
>  include/standard-headers/linux/pci_regs.h          |    9 +
>  include/standard-headers/linux/vhost_types.h       |    5 +
>  include/standard-headers/linux/virtio_net.h        |   33 +
>  linux-headers/asm-arm64/unistd_64.h                |    2 +
>  linux-headers/asm-generic/unistd.h                 |    8 +-
>  linux-headers/asm-loongarch/unistd_64.h            |    2 +
>  linux-headers/asm-mips/unistd_n32.h                |    2 +
>  linux-headers/asm-mips/unistd_n64.h                |    2 +
>  linux-headers/asm-mips/unistd_o32.h                |    2 +
>  linux-headers/asm-powerpc/kvm.h                    |   13 -
>  linux-headers/asm-powerpc/unistd_32.h              |    2 +
>  linux-headers/asm-powerpc/unistd_64.h              |    2 +
>  linux-headers/asm-riscv/kvm.h                      |    1 +
>  linux-headers/asm-riscv/unistd_32.h                |    2 +
>  linux-headers/asm-riscv/unistd_64.h                |    2 +
>  linux-headers/asm-s390/unistd_32.h                 |    2 +
>  linux-headers/asm-s390/unistd_64.h                 |    2 +
>  linux-headers/asm-x86/unistd_32.h                  |    2 +
>  linux-headers/asm-x86/unistd_64.h                  |    2 +
>  linux-headers/asm-x86/unistd_x32.h                 |    2 +
>  linux-headers/linux/iommufd.h                      |  154 ++-
>  linux-headers/linux/kvm.h                          |    2 +
>  linux-headers/linux/vfio.h                         |   12 +-
>  linux-headers/linux/vhost.h                        |   35 +
>  net/tap-linux.h                                    |    9 +
>  net/tap_int.h                                      |    5 +-
>  tests/qtest/libqos/virtio.h                        |    2 +
>  hw/acpi/aml-build.c                                |   10 +
>  hw/acpi/generic_event_device.c                     |   44 +
>  hw/acpi/ghes-stub.c                                |    7 +-
>  hw/acpi/ghes.c                                     |  233 +++--
>  hw/acpi/ghes_cper.c                                |   40 +
>  hw/acpi/ghes_cper_stub.c                           |   20 +
>  hw/arm/virt-acpi-build.c                           |   35 +-
>  hw/arm/virt.c                                      |   20 +-
>  hw/block/virtio-blk.c                              |    6 +-
>  hw/core/machine.c                                  |   10 +-
>  hw/i386/acpi-build.c                               |    6 +-
>  hw/i386/amd_iommu.c                                | 1066 +++++++++++++++++---
>  hw/i386/intel_iommu.c                              |  384 ++++++-
>  hw/i386/pc.c                                       |   40 +-
>  hw/i386/pc_piix.c                                  |    1 +
>  hw/i386/pc_q35.c                                   |    1 +
>  hw/i386/x86-iommu.c                                |    1 +
>  hw/isa/lpc_ich9.c                                  |    7 +-
>  hw/net/e1000e_core.c                               |    5 +-
>  hw/net/igb_core.c                                  |    5 +-
>  hw/net/igbvf.c                                     |    6 +-
>  hw/net/vhost_net-stub.c                            |    8 +-
>  hw/net/vhost_net.c                                 |   45 +-
>  hw/net/virtio-net.c                                |  234 +++--
>  hw/net/vmxnet3.c                                   |   13 +-
>  hw/nvme/ctrl.c                                     |    8 +-
>  hw/pci/pci.c                                       |   21 +-
>  hw/pci/pcie.c                                      |    8 +
>  hw/pci/pcie_sriov.c                                |   17 +-
>  hw/scsi/virtio-scsi.c                              |    6 +-
>  hw/smbios/smbios.c                                 |   11 +-
>  hw/virtio/vdpa-dev.c                               |    7 +
>  hw/virtio/vhost-backend.c                          |   62 +-
>  ...r-device-pci.c => vhost-user-test-device-pci.c} |   17 +-
>  ...host-user-device.c => vhost-user-test-device.c} |    9 +-
>  hw/virtio/vhost.c                                  |   79 +-
>  hw/virtio/virtio-balloon.c                         |    2 +-
>  hw/virtio/virtio-bus.c                             |   11 +-
>  hw/virtio/virtio-hmp-cmds.c                        |    3 +-
>  hw/virtio/virtio-pci.c                             |   76 +-
>  hw/virtio/virtio-qmp.c                             |   91 +-
>  hw/virtio/virtio.c                                 |  138 ++-
>  net/net.c                                          |   17 +-
>  net/netmap.c                                       |    3 +-
>  net/tap-bsd.c                                      |    8 +-
>  net/tap-linux.c                                    |   38 +-
>  net/tap-solaris.c                                  |    9 +-
>  net/tap-stub.c                                     |    8 +-
>  net/tap.c                                          |   21 +-
>  system/memory.c                                    |   10 +-
>  target/arm/kvm.c                                   |    7 +-
>  tests/qtest/libqos/virtio.c                        |   16 +-
>  tests/qtest/virtio-scsi-test.c                     |   32 +
>  MAINTAINERS                                        |   10 +
>  docs/specs/acpi_hest_ghes.rst                      |   28 +-
>  docs/system/devices/vhost-user.rst                 |   20 +-
>  hw/acpi/Kconfig                                    |    5 +
>  hw/acpi/meson.build                                |    2 +
>  hw/virtio/Kconfig                                  |    5 +
>  hw/virtio/meson.build                              |    5 +-
>  hw/virtio/trace-events                             |    1 -
>  linux-headers/LICENSES/preferred/GPL-2.0           |   10 +-
>  qapi/meson.build                                   |    1 +
>  qemu-options.hx                                    |   25 +-
>  scripts/arm_processor_error.py                     |  476 +++++++++
>  scripts/ghes_inject.py                             |   51 +
>  scripts/qmp_helper.py                              |  703 +++++++++++++
>  scripts/update-linux-headers.sh                    |    1 +
>  tests/data/acpi/aarch64/virt/DSDT                  |  Bin 5293 -> 5337 bytes
>  tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt     |  Bin 5379 -> 5423 bytes
>  tests/data/acpi/aarch64/virt/DSDT.acpipcihp        |  Bin 6202 -> 6246 bytes
>  tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex   |  Bin 5347 -> 5391 bytes
>  tests/data/acpi/aarch64/virt/DSDT.memhp            |  Bin 6654 -> 6698 bytes
>  tests/data/acpi/aarch64/virt/DSDT.pxb              |  Bin 7768 -> 7812 bytes
>  tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev       |  Bin 10230 -> 10274 bytes
>  tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy    |  Bin 10230 -> 10274 bytes
>  tests/data/acpi/aarch64/virt/DSDT.topology         |  Bin 5495 -> 5539 bytes
>  tests/data/acpi/aarch64/virt/DSDT.viot             |  Bin 5310 -> 5354 bytes
>  tests/data/acpi/aarch64/virt/HEST                  |  Bin 132 -> 224 bytes
>  137 files changed, 4476 insertions(+), 722 deletions(-)
>  create mode 100644 qapi/acpi-hest.json
>  create mode 100644 include/hw/virtio/virtio-features.h
>  create mode 100644 hw/acpi/ghes_cper.c
>  create mode 100644 hw/acpi/ghes_cper_stub.c
>  rename hw/virtio/{vhost-user-device-pci.c => vhost-user-test-device-pci.c} (77%)
>  rename hw/virtio/{vhost-user-device.c => vhost-user-test-device.c} (87%)
>  create mode 100644 scripts/arm_processor_error.py
>  create mode 100755 scripts/ghes_inject.py
>  create mode 100755 scripts/qmp_helper.py
> 


