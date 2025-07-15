Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA04C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 06:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubZby-0000pZ-Io; Tue, 15 Jul 2025 02:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubZbw-0000oc-No
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:57:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubZbt-0002mZ-AI
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752562672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/sj0K0ZAis3reIX83uXVea43XTwPAsV2pVHkgQcqO0o=;
 b=fHLJT+C7VeQQ8wq10+xOI2eD8JZgyQafKL4n73HWGVc5bpS+p1O2nkpdrMJZNDDZHblYm8
 PYXGr3i0j52zTjR4vCz25+TsuC/zbVN+/DRwvKJ2rZ5teNaMLyjy7wWEarxrHo6Bj4eZ+q
 bxkcXMbRdax/n6MttePOg+58f6SG4Ms=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-dNXaFWtSN6yxmflfK-ZhOA-1; Tue, 15 Jul 2025 02:57:50 -0400
X-MC-Unique: dNXaFWtSN6yxmflfK-ZhOA-1
X-Mimecast-MFC-AGG-ID: dNXaFWtSN6yxmflfK-ZhOA_1752562669
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4538f375e86so42122085e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 23:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752562669; x=1753167469;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/sj0K0ZAis3reIX83uXVea43XTwPAsV2pVHkgQcqO0o=;
 b=iLWxJu90oR5RYhmbd/O/P6pZfP2+e7wWqQCCICE4YKtaZaBhp8eCu2uJcN1DHBP9Fk
 E6BmtBj/O49u0r6fkPBrudzKyrt3j15H8+390cu9JsVXjMTEG8oAsDI+q4HpYZ4asGiu
 9Sf6zLhCsxCvEEpYNvKdd/ugT3G9zRHoB/yh4eJQVhMgFpCuAOTr8AjYqCPDmVDoJp1a
 lFAynlOxkNYHBcmSDxhujSOsyKuXEU4ODWzR/449K6rNntBWda9qoqJagIS/C/BptGB/
 hB9SrB1TkjNHOcYN6jXuG3rKM3JKGDQoRSpKaCewgKhFAIMygIWlp1kpz545X71ewaub
 8jXA==
X-Gm-Message-State: AOJu0YzD2pjuzP8n3uVBuqLKM/hGiLD0/hExBhX7jIRIyC33AZ4NQ5QU
 LwmyGpuDFSAkYWR/F/KGI55ExYjADOSctr90yGiGOKEFUo4cZl3T1l0mO/9tTaBCRpfK5mu37tf
 jxAOh1JkQgKF6ro6pLjjJ7OQIRrYTI+LqCSvHk4gzDqsCrbgqqCSpcSmF2B/4M/FxB2M9z+2Wt2
 +a935LiNTiiOXibuILioztmFJ7uw3KykRO3w==
X-Gm-Gg: ASbGncvrkpxSgqSznjfF87rMT2+6Aoz9Eb7WpYbAi+CeElQMbSYRUdJSLjL2C1AfMJz
 I5orPO4dW/zJwKD2r8hlo+ompCAhzIht5W5mZ9Nc84tIrHwMsCa+tZl/6dkSqvlL5YxX7kNqmi+
 CE95JqoeBwdITvRqXPNnoS3wSJo4DLFwNYEt8kzGDPdMqL+Bler1xZQGXq7b+mYvDbRX8ciS2iz
 TREbCGIcrotzjN5sQpl2NL5dtPt/dTCvAwwQGWL8484+2e0L5AJX09GJ7HILgrXPPDrzMscmUZZ
 SgI3NmGhYiUdb8kP0m7E45sa9WASfvdC
X-Received: by 2002:a05:600c:154f:b0:456:1ab0:d56d with SMTP id
 5b1f17b1804b1-456272d268bmr12688395e9.7.1752562668623; 
 Mon, 14 Jul 2025 23:57:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgueJc2Oy7YsJTh5eP3tomPH924rrwvYsCnxYUHGbvDPNRb7SBytdvTvd2Gmvrih2ajWCHmg==
X-Received: by 2002:a05:600c:154f:b0:456:1ab0:d56d with SMTP id
 5b1f17b1804b1-456272d268bmr12688155e9.7.1752562668019; 
 Mon, 14 Jul 2025 23:57:48 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc1e4fsm14163466f8f.21.2025.07.14.23.57.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 23:57:47 -0700 (PDT)
Date: Tue, 15 Jul 2025 02:57:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/97] virtio,pci,pc: features, fixes, tests
Message-ID: <20250715025716-mutt-send-email-mst@kernel.org>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jul 14, 2025 at 07:06:18PM -0400, Michael S. Tsirkin wrote:
> The following changes since commit 9a4e273ddec3927920c5958d2226c6b38b543336:
> 
>   Merge tag 'pull-tcg-20250711' of https://gitlab.com/rth7680/qemu into staging (2025-07-13 01:46:04 -0400)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> 
> for you to fetch changes up to 77a8fbb887cb4c00be094aee839a42f72a850950:


rebased - it is fdd48ce20ce125cc992dfaace925f1bfae3dfdc1 now.


>   hw/cxl: mailbox-utils: 0x5605 - FMAPI Initiate DC Release (2025-07-14 19:03:20 -0400)
> 
> ----------------------------------------------------------------
> virtio,pci,pc: features, fixes, tests
> 
> SPCR acpi table can now be disabled
> vhost-vdpa can now report hashing capability to guest
> PPTT acpi table now tells guest vCPUs are identical
> vost-user-blk now shuts down faster
> loongarch64 now supports bios-tables-test
> intel_iommu now supports ATS
> cxl now supports DCD Fabric Management Command Set
> arm now supports acpi pci hotplug
> 
> fixes, cleanups
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ----------------------------------------------------------------
> Akihiko Odaki (6):
>       qdev-properties: Add DEFINE_PROP_ON_OFF_AUTO_BIT64()
>       net/vhost-vdpa: Report hashing capability
>       virtio-net: Move virtio_net_get_features() down
>       virtio-net: Retrieve peer hashing capability
>       net/vhost-vdpa: Remove dummy SetSteeringEBPF
>       virtio-net: Add hash type options
> 
> Alejandro Jimenez (7):
>       amd_iommu: Fix Miscellaneous Information Register 0 encoding
>       amd_iommu: Fix Device ID decoding for INVALIDATE_IOTLB_PAGES command
>       amd_iommu: Update bitmasks representing DTE reserved fields
>       amd_iommu: Fix masks for various IOMMU MMIO Registers
>       amd_iommu: Fix mask to retrieve Interrupt Table Root Pointer from DTE
>       amd_iommu: Fix the calculation for Device Table size
>       amd_iommu: Remove duplicated definitions
> 
> Alireza Sanaee (1):
>       tests: virt: Update expected ACPI tables for virt test
> 
> Anisa Su (10):
>       hw/cxl: mailbox-utils: 0x5600 - FMAPI Get DCD Info
>       hw/mem: cxl_type3: Add dsmas_flags to CXLDCRegion struct
>       hw/cxl: mailbox-utils: 0x5601 - FMAPI Get Host Region Config
>       hw/cxl: Move definition for dynamic_capacity_uuid and enum for DC event types to header
>       hw/mem: cxl_type3: Add DC Region bitmap lock
>       hw/cxl: mailbox-utils: 0x5602 - FMAPI Set DC Region Config
>       hw/cxl: mailbox-utils: 0x5603 - FMAPI Get DC Region Extent Lists
>       hw/cxl: Create helper function to create DC Event Records from extents
>       hw/cxl: mailbox-utils: 0x5604 - FMAPI Initiate DC Add
>       hw/cxl: mailbox-utils: 0x5605 - FMAPI Initiate DC Release
> 
> Bibo Mao (5):
>       tests/acpi: Add empty ACPI data files for LoongArch
>       tests/qtest/bios-tables-test: Add basic testing for LoongArch
>       rebuild-expected-aml.sh: Add support for LoongArch
>       tests/acpi: Fill acpi table data for LoongArch
>       tests/acpi: Remove stale allowed tables
> 
> CLEMENT MATHIEU--DRIF (10):
>       pci: Add a memory attribute for pre-translated DMA operations
>       memory: Add permissions in IOMMUAccessFlags
>       memory: Allow to store the PASID in IOMMUTLBEntry
>       intel_iommu: Fill the PASID field when creating an IOMMUTLBEntry
>       intel_iommu: Declare supported PASID size
>       intel_iommu: Implement vtd_get_iotlb_info from PCIIOMMUOps
>       intel_iommu: Implement the PCIIOMMUOps callbacks related to invalidations of device-IOTLB
>       intel_iommu: Return page walk level even when the translation fails
>       intel_iommu: Set address mask when a translation fails and adjust W permission
>       intel_iommu: Add support for ATS
> 
> Daniil Tatianin (3):
>       softmmu/runstate: add a way to detect force shutdowns
>       vhost: add a helper for force stopping a device
>       vhost-user-blk: add an option to skip GET_VRING_BASE for force shutdown
> 
> David Hildenbrand (1):
>       vhost: Fix used memslot tracking when destroying a vhost device
> 
> Eric Auger (31):
>       hw/i386/acpi-build: Make aml_pci_device_dsm() static
>       hw/acpi: Rename and move build_x86_acpi_pci_hotplug to pcihp
>       hw/pci-host/gpex-acpi: Add native_pci_hotplug arg to acpi_dsdt_add_pci_osc
>       hw/pci-host/gpex-acpi: Split host bridge OSC and DSM generation
>       hw/acpi/ged: Add a acpi-pci-hotplug-with-bridge-support property
>       hw/pci-host/gpex-acpi: Use GED acpi pcihp property
>       hw/i386/acpi-build: Turn build_q35_osc_method into a generic method
>       hw/pci-host/gpex-acpi: Use build_pci_host_bridge_osc_method
>       hw/i386/acpi-build: Introduce build_append_pcihp_resources() helper
>       hw/acpi/pcihp: Add an AmlRegionSpace arg to build_acpi_pci_hotplug
>       hw/i386/acpi-build: Move build_append_notification_callback to pcihp
>       hw/i386/acpi-build: Move build_append_pci_bus_devices/pcihp_slots to pcihp
>       hw/i386/acpi-build: Use AcpiPciHpState::root in acpi_set_pci_info
>       hw/i386/acpi-build: Move aml_pci_edsm to a generic place
>       qtest/bios-tables-test: Prepare for fixing the aarch64 viot test
>       qtest/bios-tables-test: Add a variant to the aarch64 viot test
>       qtest/bios-tables-test: Generate DSDT.viot
>       hw/arm/virt-acpi-build: Let non hotplug ports support static acpi-index
>       tests/qtest/bios-tables-test: Update ARM DSDT reference blobs
>       hw/arm/virt-acpi-build: Modify the DSDT ACPI table to enable ACPI PCI hotplug
>       hw/acpi/ged: Add a bus link property
>       hw/arm/virt: Pass the bus on the ged creation
>       hw/acpi/ged: Call pcihp plug callbacks in hotplug handler implementation
>       hw/acpi/pcihp: Remove root arg in acpi_pcihp_init
>       hw/acpi/ged: Prepare the device to react to PCI hotplug events
>       hw/acpi/ged: Support migration of AcpiPciHpState
>       hw/core/sysbus: Introduce sysbus_mmio_map_name() helper
>       hw/arm/virt: Minor code reshuffling in create_acpi_ged
>       hw/arm/virt: Let virt support pci hotplug/unplug GED event
>       qtest/bios-tables-test: Generate reference blob for DSDT.hpoffacpiindex
>       qtest/bios-tables-test: Generate reference blob for DSDT.acpipcihp
> 
> Ethan Milon (1):
>       amd_iommu: Fix truncation of oldval in amdvi_writeq
> 
> Fan Ni (1):
>       hw/cxl: fix DC extent capacity tracking
> 
> Gustavo Romero (4):
>       tests/qtest/bios-tables-test: Prepare for changes in the DSDT table
>       tests/qtest/bios-tables-test: Prepare for changes in the arm virt DSDT table
>       tests/qtest/bios-tables-test: Prepare for addition of acpi pci hp tests
>       tests/qtest/bios-tables-test: Add aarch64 ACPI PCI hotplug test
> 
> Li Chen (3):
>       acpi: Add machine option to disable SPCR table
>       tests/qtest/bios-tables-test: Add test for disabling SPCR on AArch64
>       tests/qtest/bios-tables-test: Add test for disabling SPCR on RISC-V
> 
> Li Zhijian (1):
>       hw/acpi: Fix GPtrArray memory leak in crs_range_merge
> 
> Michael S. Tsirkin (2):
>       rust: bindings: allow any number of params
>       tests/qtest/bios-tables-test: Update DSDT blobs after GPEX _OSC change
> 
> Philippe Mathieu-Daudé (8):
>       target/qmp: Use target_cpu_type()
>       qemu/target-info: Factor target_arch() out
>       qemu/target-info: Add %target_arch field to TargetInfo
>       qemu/target-info: Add target_endian_mode()
>       qemu: Convert target_words_bigendian() to TargetInfo API
>       gdbstub/helpers: Replace TARGET_BIG_ENDIAN -> target_big_endian()
>       qemu: Declare all load/store helper in 'qemu/bswap.h'
>       hw/virtio: Build various files once
> 
> Yicong Yang (3):
>       tests: virt: Allow changes to PPTT test table
>       hw/acpi/aml-build: Set identical implementation flag for PPTT processor nodes
>       hw/acpi/aml-build: Build a root node in the PPTT table
> 
>  hw/i386/acpi-build.h                             |   4 -
>  hw/i386/amd_iommu.h                              |  59 ++-
>  hw/i386/intel_iommu_internal.h                   |   1 +
>  include/exec/memattrs.h                          |   3 +
>  include/exec/tswap.h                             |  83 +---
>  include/gdbstub/helpers.h                        |  48 +-
>  include/hw/acpi/generic_event_device.h           |  17 +-
>  include/hw/acpi/pci.h                            |   5 +-
>  include/hw/acpi/pcihp.h                          |  17 +-
>  include/hw/arm/virt.h                            |   1 +
>  include/hw/boards.h                              |   1 +
>  include/hw/cxl/cxl.h                             |   1 +
>  include/hw/cxl/cxl_device.h                      |  31 +-
>  include/hw/cxl/cxl_events.h                      |  15 +
>  include/hw/cxl/cxl_mailbox.h                     |   6 +
>  include/hw/pci-host/gpex.h                       |   1 +
>  include/hw/pci/pci.h                             |   9 +
>  include/hw/qdev-properties.h                     |  18 +
>  include/hw/sysbus.h                              |   1 +
>  include/hw/virtio/vhost-user-blk.h               |   2 +
>  include/hw/virtio/vhost.h                        |  15 +
>  include/hw/virtio/virtio-net.h                   |   6 +-
>  include/net/net.h                                |   3 +
>  include/qemu/bswap.h                             |  73 +++
>  include/qemu/target-info-impl.h                  |   6 +-
>  include/qemu/target-info-qapi.h                  |  29 ++
>  include/qemu/target-info.h                       |  14 +-
>  include/system/memory.h                          |  25 +-
>  include/system/runstate.h                        |   1 +
>  include/user/abitypes.h                          |   1 -
>  target/ppc/mmu-hash64.h                          |   2 -
>  cpu-target.c                                     |   7 -
>  hw/acpi/acpi-pci-hotplug-stub.c                  |   2 +-
>  hw/acpi/aml-build.c                              |  27 +-
>  hw/acpi/bios-linker-loader.c                     |   2 -
>  hw/acpi/generic_event_device.c                   |  77 ++++
>  hw/acpi/ich9.c                                   |   7 +-
>  hw/acpi/pci-bridge.c                             |  54 +++
>  hw/acpi/pci.c                                    |  50 ++
>  hw/acpi/pcihp.c                                  | 439 +++++++++++++++++-
>  hw/acpi/piix4.c                                  |   5 +-
>  hw/arm/allwinner-r40.c                           |   1 -
>  hw/arm/boot.c                                    |   2 +
>  hw/arm/npcm7xx.c                                 |   2 +-
>  hw/arm/virt-acpi-build.c                         |  43 +-
>  hw/arm/virt.c                                    |  27 +-
>  hw/block/hd-geometry.c                           |   1 -
>  hw/block/vhost-user-blk.c                        |   9 +-
>  hw/char/riscv_htif.c                             |   1 -
>  hw/core/cpu-system.c                             |   2 +-
>  hw/core/machine-qmp-cmds.c                       |   8 +-
>  hw/core/machine.c                                |  22 +
>  hw/core/qdev-properties.c                        |  67 ++-
>  hw/core/sysbus.c                                 |  11 +
>  hw/cxl/cxl-events.c                              |  40 +-
>  hw/cxl/cxl-mailbox-utils.c                       | 552 ++++++++++++++++++++++-
>  hw/display/artist.c                              |   1 +
>  hw/display/ati.c                                 |   1 +
>  hw/display/vga.c                                 |   2 +-
>  hw/i386/acpi-build.c                             | 532 +---------------------
>  hw/i386/amd_iommu.c                              |  17 +-
>  hw/i386/intel_iommu.c                            | 142 +++++-
>  hw/loongarch/virt-acpi-build.c                   |   4 +-
>  hw/mem/cxl_type3.c                               |  83 +---
>  hw/net/can/ctucan_core.c                         |   1 -
>  hw/net/lan9118.c                                 |   1 +
>  hw/net/rtl8139.c                                 |   1 +
>  hw/net/virtio-net.c                              | 254 +++++++----
>  hw/net/vmxnet3.c                                 |   1 -
>  hw/pci-host/gpex-acpi.c                          |  74 +--
>  hw/pci-host/gt64120.c                            |   1 +
>  hw/pci-host/pnv_phb3.c                           |   1 +
>  hw/pci-host/pnv_phb4.c                           |   1 +
>  hw/pci-host/ppce500.c                            |   1 -
>  hw/pci-host/sh_pci.c                             |   1 -
>  hw/riscv/virt-acpi-build.c                       |   5 +-
>  hw/s390x/s390-pci-inst.c                         |   1 +
>  hw/sensor/lsm303dlhc_mag.c                       |   1 -
>  hw/smbios/smbios.c                               |   1 +
>  hw/vfio/migration-multifd.c                      |   1 -
>  hw/virtio/vhost.c                                |  89 ++--
>  hw/virtio/virtio-config-io.c                     |   1 -
>  hw/virtio/virtio-pci.c                           |   1 +
>  hw/virtio/virtio.c                               |   2 +-
>  hw/vmapple/virtio-blk.c                          |   1 -
>  net/net.c                                        |   9 +
>  net/vhost-vdpa.c                                 |  40 +-
>  system/memory.c                                  |   1 +
>  system/qtest.c                                   |   1 +
>  system/runstate.c                                |  10 +
>  target-info-stub.c                               |   2 +
>  target-info.c                                    |  23 +
>  target/arm/arm-qmp-cmds.c                        |   3 +-
>  target/arm/cpu.c                                 |   1 -
>  target/i386/tcg/system/excp_helper.c             |   1 -
>  target/i386/xsave_helper.c                       |   1 -
>  target/loongarch/loongarch-qmp-cmds.c            |   3 +-
>  target/mips/system/mips-qmp-cmds.c               |   3 +-
>  target/riscv/vector_helper.c                     |   1 -
>  tests/qtest/bios-tables-test.c                   | 174 +++++++
>  tests/tcg/plugins/mem.c                          |   1 +
>  hw/arm/Kconfig                                   |   2 +
>  hw/block/meson.build                             |   6 +-
>  hw/pci-host/Kconfig                              |   1 +
>  hw/virtio/meson.build                            |  20 +-
>  qemu-options.hx                                  |   5 +
>  rust/qemu-api/src/bindings.rs                    |  12 +-
>  tests/data/acpi/aarch64/virt/DSDT                | Bin 5196 -> 5293 bytes
>  tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt   | Bin 5282 -> 5379 bytes
>  tests/data/acpi/aarch64/virt/DSDT.acpipcihp      | Bin 0 -> 6202 bytes
>  tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex | Bin 0 -> 5347 bytes
>  tests/data/acpi/aarch64/virt/DSDT.memhp          | Bin 6557 -> 6654 bytes
>  tests/data/acpi/aarch64/virt/DSDT.pxb            | Bin 7679 -> 7768 bytes
>  tests/data/acpi/aarch64/virt/DSDT.topology       | Bin 5398 -> 5495 bytes
>  tests/data/acpi/aarch64/virt/DSDT.viot           | Bin 0 -> 5310 bytes
>  tests/data/acpi/aarch64/virt/PPTT                | Bin 76 -> 96 bytes
>  tests/data/acpi/aarch64/virt/PPTT.acpihmatvirt   | Bin 156 -> 176 bytes
>  tests/data/acpi/aarch64/virt/PPTT.topology       | Bin 336 -> 356 bytes
>  tests/data/acpi/loongarch64/virt/APIC            | Bin 0 -> 108 bytes
>  tests/data/acpi/loongarch64/virt/APIC.topology   | Bin 0 -> 153 bytes
>  tests/data/acpi/loongarch64/virt/DSDT            | Bin 0 -> 4603 bytes
>  tests/data/acpi/loongarch64/virt/DSDT.memhp      | Bin 0 -> 5824 bytes
>  tests/data/acpi/loongarch64/virt/DSDT.numamem    | Bin 0 -> 4609 bytes
>  tests/data/acpi/loongarch64/virt/DSDT.topology   | Bin 0 -> 4905 bytes
>  tests/data/acpi/loongarch64/virt/FACP            | Bin 0 -> 268 bytes
>  tests/data/acpi/loongarch64/virt/MCFG            | Bin 0 -> 60 bytes
>  tests/data/acpi/loongarch64/virt/PPTT            | Bin 0 -> 96 bytes
>  tests/data/acpi/loongarch64/virt/PPTT.topology   | Bin 0 -> 196 bytes
>  tests/data/acpi/loongarch64/virt/SLIT            |   0
>  tests/data/acpi/loongarch64/virt/SLIT.numamem    | Bin 0 -> 48 bytes
>  tests/data/acpi/loongarch64/virt/SPCR            | Bin 0 -> 80 bytes
>  tests/data/acpi/loongarch64/virt/SRAT            | Bin 0 -> 104 bytes
>  tests/data/acpi/loongarch64/virt/SRAT.memhp      | Bin 0 -> 144 bytes
>  tests/data/acpi/loongarch64/virt/SRAT.numamem    | Bin 0 -> 144 bytes
>  tests/data/acpi/loongarch64/virt/SRAT.topology   | Bin 0 -> 152 bytes
>  tests/data/acpi/rebuild-expected-aml.sh          |   4 +-
>  tests/data/acpi/riscv64/virt/DSDT                | Bin 3576 -> 3538 bytes
>  tests/data/acpi/x86/microvm/DSDT.pcie            | Bin 3023 -> 2985 bytes
>  tests/qtest/meson.build                          |   1 +
>  139 files changed, 2466 insertions(+), 1037 deletions(-)
>  create mode 100644 include/qemu/target-info-qapi.h
>  create mode 100644 tests/data/acpi/aarch64/virt/DSDT.acpipcihp
>  create mode 100644 tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex
>  create mode 100644 tests/data/acpi/aarch64/virt/DSDT.viot
>  create mode 100644 tests/data/acpi/loongarch64/virt/APIC
>  create mode 100644 tests/data/acpi/loongarch64/virt/APIC.topology
>  create mode 100644 tests/data/acpi/loongarch64/virt/DSDT
>  create mode 100644 tests/data/acpi/loongarch64/virt/DSDT.memhp
>  create mode 100644 tests/data/acpi/loongarch64/virt/DSDT.numamem
>  create mode 100644 tests/data/acpi/loongarch64/virt/DSDT.topology
>  create mode 100644 tests/data/acpi/loongarch64/virt/FACP
>  create mode 100644 tests/data/acpi/loongarch64/virt/MCFG
>  create mode 100644 tests/data/acpi/loongarch64/virt/PPTT
>  create mode 100644 tests/data/acpi/loongarch64/virt/PPTT.topology
>  create mode 100644 tests/data/acpi/loongarch64/virt/SLIT
>  create mode 100644 tests/data/acpi/loongarch64/virt/SLIT.numamem
>  create mode 100644 tests/data/acpi/loongarch64/virt/SPCR
>  create mode 100644 tests/data/acpi/loongarch64/virt/SRAT
>  create mode 100644 tests/data/acpi/loongarch64/virt/SRAT.memhp
>  create mode 100644 tests/data/acpi/loongarch64/virt/SRAT.numamem
>  create mode 100644 tests/data/acpi/loongarch64/virt/SRAT.topology
> 


