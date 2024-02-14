Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DEF1C48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:23:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDIX-0001DK-Ds; Wed, 14 Feb 2024 06:19:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDIW-000135-5A
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:19:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDIT-00084L-0B
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:19:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mgLlUieJ0ChybfqxujuLCRqut8wR8W5wI4MeMjq0mBQ=;
 b=CzULelPn1h+x3FVHSwOY4Oa1NhQOXczAndBgfgqW993JLQpvaUpbaiV94YeMJoYyjFSVSJ
 ng7EIYAOjVaa/fEipHQOobZvz7kNyOBcHAx0Wvk82FZbRDrYBCBknVcwNyKRLPMChkURqD
 UrWNvh3gPxFmXk/As93ujz88h+41PCo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-T2Q_KRdMN1aQP1QsEww5OA-1; Wed, 14 Feb 2024 06:19:22 -0500
X-MC-Unique: T2Q_KRdMN1aQP1QsEww5OA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-411e1466370so3284905e9.0
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:19:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909561; x=1708514361;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mgLlUieJ0ChybfqxujuLCRqut8wR8W5wI4MeMjq0mBQ=;
 b=akMBHwU/makSW2cWY3/VK9m6GttcNFiASnnWcKe/Ztzov9DE8tg2UutHnWkbqiREvm
 4kfDKUU2gOTdvQVtOhZDNvKCRxaAthqVuwVnQmTXza/POnwd4UARmpbQjgxT1E+V4JEI
 Atot8ccsN0SiBjsLQdG2R0wYG7dGVIaco09v9Zf62nM+h/ru6b2Cc7OaWon76xnxph9i
 QKxvzfgkTj5ZBU6BpLW3HcPxbtrf+yXfQLZpJ8XoLpxPp8+BcVj6Eu2JvAN6aPbGKumw
 YpjaX/x+ewNo1RsSZsHGPcboUUUuIB0JpEtSb/ZzZBokPG7W8Oz0wfuY/8fctL+1r8ce
 a+/g==
X-Gm-Message-State: AOJu0Yym5m8oUu+xmw26nbJLAPy7jQZ8qU8MfAS2L49zvipp7Xax0HtZ
 ttYp91rMEUyxXMC/Lm0EM7cys/+3iaBOoAkevheqdT6ybP6SoQiJqS6LOJRJD5m62JN8/xlhVz0
 48FHaDxHIpRMCZOkpH7vAE1p8T9cxXO/FldAe4Xdyyh+TACTCeO1GO8kdt+ODElJC1y75OiZ4HC
 75Vx1pUhRHDu4f4TJoz4Le3ezAysxVyQ==
X-Received: by 2002:a5d:46c8:0:b0:33c:e45d:66cc with SMTP id
 g8-20020a5d46c8000000b0033ce45d66ccmr1314123wrs.67.1707909560836; 
 Wed, 14 Feb 2024 03:19:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFssQdUPH8AGBEuf/mBuylFPyjUy7OdHwH1QCB7HxwpqKsDUcTguvjQgVqIwaIk4GlxHbOpZg==
X-Received: by 2002:a5d:46c8:0:b0:33c:e45d:66cc with SMTP id
 g8-20020a5d46c8000000b0033ce45d66ccmr1314110wrs.67.1707909560378; 
 Wed, 14 Feb 2024 03:19:20 -0800 (PST)
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 i9-20020a5d5229000000b0033ae7d768b2sm12055199wra.117.2024.02.14.03.19.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:19:19 -0800 (PST)
Date: Wed, 14 Feb 2024 06:19:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/60] virtio,pc,pci: features, cleanups, fixes
Message-ID: <20240214061846-mutt-send-email-mst@kernel.org>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Feb 14, 2024 at 06:13:16AM -0500, Michael S. Tsirkin wrote:
> The following changes since commit df50424b4dcfde823047d3717abd6a61224ea205:
> 
>   Merge tag 'pull-riscv-to-apply-20240209' of https://github.com/alistair23/qemu into staging (2024-02-09 16:15:01 +0000)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> 
> for you to fetch changes up to 3afdb6d18e9ccd6470be30f151a562cf4537d13f:


1dd6954c3f5c5c610cf94b6f740118e565957293 now - dropped a duplicate
SOB from commit log.

>   MAINTAINERS: Switch to my Enfabrica email (2024-02-14 06:09:33 -0500)
> 
> ----------------------------------------------------------------
> virtio,pc,pci: features, cleanups, fixes
> 
> vhost-user-snd support
> x2APIC mode with TCG support
> CXL update to r3.1
> 
> fixes, cleanups all over the place.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ----------------------------------------------------------------
> Akihiko Odaki (2):
>       hw/smbios: Fix OEM strings table option validation
>       hw/smbios: Fix port connector option validation
> 
> Alex Bennée (6):
>       virtio: split into vhost-user-base and vhost-user-device
>       hw/virtio: convert vhost-user-base to async shutdown
>       hw/virtio: derive vhost-user-rng from vhost-user-base
>       hw/virtio: derive vhost-user-gpio from vhost-user-base
>       hw/virtio: derive vhost-user-i2c from vhost-user-base
>       docs/system: add a basic enumeration of vhost-user devices
> 
> Andrey Ignatov (1):
>       vhost-user.rst: Fix vring address description
> 
> Bernhard Beschow (14):
>       hw/i386/x86: Reverse if statement
>       hw/i386/x86: Fix PIC interrupt handling if APIC is globally disabled
>       target/i386/cpu: Fix typo in comment
>       hw/block/fdc-isa: Move portio_list from FDCtrl to FDCtrlISABus
>       hw/block/fdc-sysbus: Move iomem from FDCtrl to FDCtrlSysBus
>       hw/char/parallel: Move portio_list from ParallelState to ISAParallelState
>       exec/ioport: Resolve redundant .base attribute in struct MemoryRegionPortio
>       exec/ioport: Add portio_list_set_address()
>       exec/ioport: Add portio_list_set_enabled()
>       hw/block/fdc-isa: Implement relocation and enabling/disabling for TYPE_ISA_FDC
>       hw/char/serial-isa: Implement relocation and enabling/disabling for TYPE_ISA_SERIAL
>       hw/char/parallel-isa: Implement relocation and enabling/disabling for TYPE_ISA_PARALLEL
>       hw/ppc/pegasos2: Let pegasos2 machine configure SuperI/O functions
>       hw/isa/vt82c686: Implement relocation and toggling of SuperI/O functions
> 
> Bui Quang Minh (7):
>       i386/tcg: implement x2APIC registers MSR access
>       apic: add support for x2APIC mode
>       apic, i386/tcg: add x2apic transitions
>       intel_iommu: allow Extended Interrupt Mode when using userspace APIC
>       test: bios-tables-test: prepare IVRS change in ACPI table
>       amd_iommu: report x2APIC support to the operating system
>       test: bios-tables-test: add IVRS changed binary
> 
> Davidlohr Bueso (1):
>       hw/cxl/mbox: Remove dead code
> 
> Dmitry Osipenko (1):
>       virtio-gpu: Correct virgl_renderer_resource_get_info() error check
> 
> Hyeonggon Yoo (1):
>       hw/cxl/device: read from register values in mdev_reg_read()
> 
> Ira Weiny (2):
>       cxl/cdat: Handle cdat table build errors
>       cxl/cdat: Fix header sum value in CDAT checksum
> 
> Jonathan Cameron (11):
>       hw/mem/cxl_type3: Drop handling of failure of g_malloc0() and g_malloc()
>       hw/pci-bridge/cxl_upstream: Drop g_malloc() failure handling
>       hw/mem/cxl_type3: Fix potential divide by zero reported by coverity
>       tests/acpi: Allow update of DSDT.cxl
>       hw/i386: Fix _STA return value for ACPI0017
>       tests/acpi: Update DSDT.cxl to reflect change _STA return value.
>       hw/cxl: Update HDM Decoder capability to version 3
>       hw/cxl: Update link register definitions.
>       hw/cxl: Update RAS Capability Definitions for version 3.
>       hw/cxl: Update mailbox status registers.
>       hw/cxl: Standardize all references on CXL r3.1 and minor updates
> 
> Leo Yan (4):
>       hw/virtio: Support set_config() callback in vhost-user-base
>       docs/system: Add vhost-user-input documentation
>       hw/virtio: Move vhost-user-input into virtio folder
>       hw/virtio: derive vhost-user-input from vhost-user-base
> 
> Li Zhijian (2):
>       hw/cxl: Pass CXLComponentState to cache_mem_ops
>       hw/cxl: Pass NULL for a NULL MemoryRegionOps
> 
> Manos Pitsidianakis (4):
>       hw/virtio: add vhost-user-snd and vhost-user-snd-pci devices
>       hw/display/virtio-gpu.c: use reset_bh class method
>       virtio-gpu.c: add resource_destroy class method
>       virtio-gpu-rutabaga.c: override resource_destroy method
> 
> Peter Xu (1):
>       MAINTAINERS: Drop myself as VT-d maintainers
> 
> Raphael Norwitz (1):
>       MAINTAINERS: Switch to my Enfabrica email
> 
> Zhenzhong Duan (2):
>       virtio_iommu: Clear IOMMUPciBus pointer cache when system reset
>       smmu: Clear SMMUPciBus pointer cache when system reset
> 
>  hw/block/fdc-internal.h                            |   4 -
>  hw/i386/amd_iommu.h                                |  16 +-
>  include/exec/ioport.h                              |   4 +-
>  include/hw/block/fdc.h                             |   3 +
>  include/hw/char/parallel-isa.h                     |   5 +
>  include/hw/char/parallel.h                         |   2 -
>  include/hw/char/serial.h                           |   2 +
>  include/hw/cxl/cxl_cdat.h                          |  10 +-
>  include/hw/cxl/cxl_component.h                     |  51 ++-
>  include/hw/cxl/cxl_device.h                        |  86 ++--
>  include/hw/cxl/cxl_events.h                        |  18 +-
>  include/hw/cxl/cxl_pci.h                           |  67 ++-
>  include/hw/i386/apic.h                             |   9 +-
>  include/hw/i386/apic_internal.h                    |   9 +-
>  .../{vhost-user-device.h => vhost-user-base.h}     |  21 +-
>  include/hw/virtio/vhost-user-gpio.h                |  25 +-
>  include/hw/virtio/vhost-user-i2c.h                 |  14 +-
>  include/hw/virtio/vhost-user-rng.h                 |  13 +-
>  include/hw/virtio/vhost-user-snd.h                 |  24 ++
>  include/hw/virtio/virtio-gpu.h                     |   3 +
>  include/hw/virtio/virtio-input.h                   |   6 +-
>  target/i386/cpu.h                                  |   9 +
>  contrib/vhost-user-gpu/virgl.c                     |   6 +-
>  hw/arm/smmu-common.c                               |   2 +
>  hw/block/fdc-isa.c                                 |  18 +-
>  hw/block/fdc-sysbus.c                              |   6 +-
>  hw/char/parallel-isa.c                             |  14 +
>  hw/char/parallel.c                                 |   2 +-
>  hw/char/serial-isa.c                               |  14 +
>  hw/cxl/cxl-cdat.c                                  |  11 +-
>  hw/cxl/cxl-component-utils.c                       |  33 +-
>  hw/cxl/cxl-device-utils.c                          |  31 +-
>  hw/cxl/cxl-events.c                                |   2 +-
>  hw/cxl/cxl-mailbox-utils.c                         |  92 ++--
>  hw/display/virtio-gpu-rutabaga.c                   |  47 +-
>  hw/display/virtio-gpu-virgl.c                      |   2 +-
>  hw/display/virtio-gpu.c                            |  27 +-
>  hw/i386/acpi-build.c                               | 109 +++--
>  hw/i386/amd_iommu-stub.c                           |  26 ++
>  hw/i386/amd_iommu.c                                |  29 +-
>  hw/i386/intel_iommu.c                              |   6 +-
>  hw/i386/kvm/apic.c                                 |   3 +-
>  hw/i386/x86.c                                      |  14 +-
>  hw/i386/xen/xen_apic.c                             |   3 +-
>  hw/input/vhost-user-input.c                        | 136 ------
>  hw/intc/apic.c                                     | 473 ++++++++++++++++-----
>  hw/intc/apic_common.c                              |  35 +-
>  hw/isa/vt82c686.c                                  |  65 ++-
>  hw/mem/cxl_type3.c                                 |  67 +--
>  hw/pci-bridge/cxl_downstream.c                     |   4 +-
>  hw/pci-bridge/cxl_root_port.c                      |   4 +-
>  hw/pci-bridge/cxl_upstream.c                       |  10 +-
>  hw/ppc/pegasos2.c                                  |  12 +
>  hw/smbios/smbios.c                                 |  12 +
>  hw/virtio/vhost-user-base.c                        | 371 ++++++++++++++++
>  hw/virtio/vhost-user-device-pci.c                  |  13 +-
>  hw/virtio/vhost-user-device.c                      | 338 +--------------
>  hw/virtio/vhost-user-gpio.c                        | 407 +-----------------
>  hw/virtio/vhost-user-i2c.c                         | 272 +-----------
>  hw/virtio/vhost-user-input-pci.c                   |   3 -
>  hw/virtio/vhost-user-input.c                       |  58 +++
>  hw/virtio/vhost-user-rng.c                         | 294 +------------
>  hw/virtio/vhost-user-snd-pci.c                     |  75 ++++
>  hw/virtio/vhost-user-snd.c                         |  67 +++
>  hw/virtio/virtio-iommu.c                           |   4 +-
>  system/ioport.c                                    |  41 +-
>  target/i386/cpu-sysemu.c                           |  18 +-
>  target/i386/cpu.c                                  |  11 +-
>  target/i386/tcg/sysemu/misc_helper.c               |  41 +-
>  target/i386/whpx/whpx-apic.c                       |   3 +-
>  MAINTAINERS                                        |  19 +-
>  docs/devel/migration/main.rst                      |   6 +-
>  docs/interop/vhost-user.rst                        |   6 +-
>  docs/system/device-emulation.rst                   |   1 +
>  docs/system/devices/cxl.rst                        |   3 +-
>  docs/system/devices/vhost-user-input.rst           |  45 ++
>  docs/system/devices/vhost-user-rng.rst             |   2 +
>  docs/system/devices/vhost-user.rst                 |  72 +++-
>  hw/i386/meson.build                                |   3 +-
>  hw/input/meson.build                               |   1 -
>  hw/intc/trace-events                               |   4 +-
>  hw/virtio/Kconfig                                  |   5 +
>  hw/virtio/meson.build                              |  27 +-
>  tests/data/acpi/q35/DSDT.cxl                       | Bin 9713 -> 9714 bytes
>  tests/data/acpi/q35/IVRS.ivrs                      | Bin 104 -> 176 bytes
>  85 files changed, 2016 insertions(+), 1910 deletions(-)
>  rename include/hw/virtio/{vhost-user-device.h => vhost-user-base.h} (71%)
>  create mode 100644 include/hw/virtio/vhost-user-snd.h
>  create mode 100644 hw/i386/amd_iommu-stub.c
>  delete mode 100644 hw/input/vhost-user-input.c
>  create mode 100644 hw/virtio/vhost-user-base.c
>  create mode 100644 hw/virtio/vhost-user-input.c
>  create mode 100644 hw/virtio/vhost-user-snd-pci.c
>  create mode 100644 hw/virtio/vhost-user-snd.c
>  create mode 100644 docs/system/devices/vhost-user-input.rst
> 


