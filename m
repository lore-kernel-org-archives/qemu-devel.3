Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E500C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 21:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubQer-0001T9-9G; Mon, 14 Jul 2025 17:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ubP2R-0001EP-6L; Mon, 14 Jul 2025 15:40:35 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ubP2H-00022o-HD; Mon, 14 Jul 2025 15:40:34 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bgt165McCz6L5W0;
 Tue, 15 Jul 2025 03:39:06 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 265B214033F;
 Tue, 15 Jul 2025 03:40:12 +0800 (CST)
Received: from localhost (10.195.247.138) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 14 Jul
 2025 21:40:10 +0200
Date: Mon, 14 Jul 2025 20:40:08 +0100
To: Eric Auger <eric.auger@redhat.com>
CC: <eric.auger.pro@gmail.com>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>, <peter.maydell@linaro.org>, <imammedo@redhat.com>,
 <gustavo.romero@linaro.org>, <anisinha@redhat.com>, <mst@redhat.com>,
 <shannon.zhaosl@gmail.com>, <pbonzini@redhat.com>, <philmd@linaro.org>,
 <alex.bennee@linaro.org>, <alireza.sanaee@huawei.com>
Subject: Re: [PATCH v7 00/36] ACPI PCI Hotplug support on ARM
Message-ID: <20250714204008.00003fba@huawei.com>
In-Reply-To: <20250714080639.2525563-1-eric.auger@redhat.com>
References: <20250714080639.2525563-1-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.247.138]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 14 Jul 2025 10:04:44 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> This series enables ACPI PCI hotplug/hotunplug on ARM.
> It is not enabled by default and ACPI PCI hotplug can
> be selected by setting: 
> 
> -global acpi-ged.acpi-pci-hotplug-with-bridge-support=on
> 
> Expected benefits should be similar to those listed in [1],
> ie. removal of some racy behaviors, improved latencies.
> 
> The infrastructure used in x86 is heavily reused and a
> huge part of the series consists in moving code from
> hw/i386/acpi-build.c to a generic place and slightly
> adapting it to make it usable on ARM. The DSDT table is
> augmented to support ACPI PCI hotplug elements.
> 
> On ARM we use use a GED event to notify the OS about
> hotplug events.
> 
> Best Regards 
> 
> Eric

Hi Eric,

I guess you probably already know this but there is some
impact on loongarch64 when their ACPI tables tests are added.

Rather oddly I'm getting intermittent failures on Michael's
gitlab tree but looks like the unification of _OSC affects
them as well. (should be every time, but they aren't!)

Should just be updating their 4 DSDT variants.

If I had a stable test setup I'd send them.  Will try again
tomorrow if not resolved.

Jonathan



> 
> This series can be found at:
> https://github.com/eauger/qemu/tree/arm-acpi-pcihp-v7
> 
> previous series:
> https://github.com/eauger/qemu/tree/arm-acpi-pcihp-v6
> 
> History:
> v6 -> v7:
> - rebased after minor contextual conflict introduced
>   by "hw/arm/virt: Basic CXL enablement on pci_expander_bridge
>   instances pxb-cxl" in hw/arm/virt-acpi-build.c
>   (hw/pci-host/gpex-acpi: Use GED acpi pcihp property)
> - collected last Igor's and Prasad's R-bs
> 
> v5 -> v6:
> - collected Jonathan's R-bs
> - cropped last 2 patch commit messages (Jonathan)
> 
> v4 -> v5:
> - Collected Jonathan's R-bs (many thanks!)
> - fixed the tests/qtest/bios-tables-test issue by
>   creating a variant for the viot test
> - use the 3 phase reset API
> - fixed qom-test failures that were due to unconditionnal
>   fetches of the GED property
> 
> v3 -> v4:
> - toook into account all comments on v3
> - static acpi-index is now supported unconditionally
>   from acpi pcihp option. See indiviual patches.
> - I hit a problem with ref block generation at
>   [19/32] tests/qtest/bios-tables-test: Update ARM DSDT reference
>   blobs: despite I regenerate the blobs, I get some errors.
> 
> v2 -> v3:
> - lot of changes taking into account various feedbacks
>   (many thanks to all reviewers). Please refer to
>   individual patches for details. Main changes:
>   - no more machine option, acpi pci hp is not set by
>     default.
>   - removal of 2 unused variables in the osc method
>   - introduction of GED property to set the bus
>   - rework of the init/reset sequence
>   - fix virtio-mem-pci hotplug regression
> 
> v1 -> v2:
> - collected a bunch of R-bs from Gustavo (many thanks!)
> - Fixed the breakage of bios-tables-test in TCG mode by
>   incorporating Gustavo's patches (part of
>   [PATCH 0/5] ACPI tests for PCI Hotplug on ARM
>   https://lore.kernel.org/all/20250526053123.1434204-1-gustavo.romero@linaro.org/)
> - Tweeked the dsdt aml changes to avoid any dsdt blob difference when
>   acpi-pcihp is off.
> 
> RFC -> v1:
> - First 3 trivial patches were pulled separately
> - Fix of the register region size (0x18), ie. ACPI_PCIHP_SIZE
> - addition of aml_pci_edsm which was not called in RFC
> - acpi-index feature is now fixed. vms->bus was not set on
>   acpi_pcihp_init. The init sequence is still hacky though. Suggestions
>   are welcome.
> 
> [1] [PATCH v6 0/6] Use ACPI PCI hot-plug for Q35
> https://lore.kernel.org/all/20210713004205.775386-1-jusual@redhat.com/
> 
> Eric Auger (32):
>   hw/i386/acpi-build: Make aml_pci_device_dsm() static
>   hw/acpi: Rename and move build_x86_acpi_pci_hotplug to pcihp
>   hw/pci-host/gpex-acpi: Add native_pci_hotplug arg to
>     acpi_dsdt_add_pci_osc
>   hw/pci-host/gpex-acpi: Split host bridge OSC and DSM generation
>   hw/acpi/ged: Add a acpi-pci-hotplug-with-bridge-support property
>   hw/pci-host/gpex-acpi: Use GED acpi pcihp property
>   hw/i386/acpi-build: Turn build_q35_osc_method into a generic method
>   hw/pci-host/gpex-acpi: Use build_pci_host_bridge_osc_method
>   tests/qtest/bios-tables-test: Update DSDT blobs after GPEX _OSC change
>   hw/i386/acpi-build: Introduce build_append_pcihp_resources() helper
>   hw/acpi/pcihp: Add an AmlRegionSpace arg to build_acpi_pci_hotplug
>   hw/i386/acpi-build: Move build_append_notification_callback to pcihp
>   hw/i386/acpi-build: Move build_append_pci_bus_devices/pcihp_slots to
>     pcihp
>   hw/i386/acpi-build: Use AcpiPciHpState::root in acpi_set_pci_info
>   hw/i386/acpi-build: Move aml_pci_edsm to a generic place
>   qtest/bios-tables-test: Prepare for fixing the aarch64 viot test
>   qtest/bios-tables-test: Add a variant to the aarch64 viot test
>   qtest/bios-tables-test: Generate DSDT.viot
>   hw/arm/virt-acpi-build: Let non hotplug ports support static
>     acpi-index
>   tests/qtest/bios-tables-test: Update ARM DSDT reference blobs
>   hw/arm/virt-acpi-build: Modify the DSDT ACPI table to enable ACPI PCI
>     hotplug
>   hw/acpi/ged: Add a bus link property
>   hw/arm/virt: Pass the bus on the ged creation
>   hw/acpi/ged: Call pcihp plug callbacks in hotplug handler
>     implementation
>   hw/acpi/pcihp: Remove root arg in acpi_pcihp_init
>   hw/acpi/ged: Prepare the device to react to PCI hotplug events
>   hw/acpi/ged: Support migration of AcpiPciHpState
>   hw/core/sysbus: Introduce sysbus_mmio_map_name() helper
>   hw/arm/virt: Minor code reshuffling in create_acpi_ged
>   hw/arm/virt: Let virt support pci hotplug/unplug GED event
>   qtest/bios-tables-test: Generate reference blob for
>     DSDT.hpoffacpiindex
>   qtest/bios-tables-test: Generate reference blob for DSDT.acpipcihp
> 
> Gustavo Romero (4):
>   tests/qtest/bios-tables-test: Prepare for changes in the DSDT table
>   tests/qtest/bios-tables-test: Prepare for changes in the arm virt DSDT
>     table
>   tests/qtest/bios-tables-test: Prepare for addition of acpi pci hp
>     tests
>   tests/qtest/bios-tables-test: Add aarch64 ACPI PCI hotplug test
> 
>  hw/i386/acpi-build.h                          |   4 -
>  include/hw/acpi/generic_event_device.h        |  17 +-
>  include/hw/acpi/pci.h                         |   5 +-
>  include/hw/acpi/pcihp.h                       |  17 +-
>  include/hw/arm/virt.h                         |   1 +
>  include/hw/pci-host/gpex.h                    |   1 +
>  include/hw/sysbus.h                           |   1 +
>  hw/acpi/acpi-pci-hotplug-stub.c               |   2 +-
>  hw/acpi/generic_event_device.c                |  77 +++
>  hw/acpi/ich9.c                                |   7 +-
>  hw/acpi/pci-bridge.c                          |  54 ++
>  hw/acpi/pci.c                                 |  50 ++
>  hw/acpi/pcihp.c                               | 439 ++++++++++++++-
>  hw/acpi/piix4.c                               |   5 +-
>  hw/arm/virt-acpi-build.c                      |  38 ++
>  hw/arm/virt.c                                 |  27 +-
>  hw/core/sysbus.c                              |  11 +
>  hw/i386/acpi-build.c                          | 532 +-----------------
>  hw/pci-host/gpex-acpi.c                       |  74 +--
>  tests/qtest/bios-tables-test.c                |  53 ++
>  hw/arm/Kconfig                                |   2 +
>  hw/pci-host/Kconfig                           |   1 +
>  tests/data/acpi/aarch64/virt/DSDT             | Bin 5196 -> 5293 bytes
>  .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5282 -> 5379 bytes
>  tests/data/acpi/aarch64/virt/DSDT.acpipcihp   | Bin 0 -> 6202 bytes
>  .../acpi/aarch64/virt/DSDT.hpoffacpiindex     | Bin 0 -> 5347 bytes
>  tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6557 -> 6654 bytes
>  tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7679 -> 7768 bytes
>  tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5398 -> 5495 bytes
>  tests/data/acpi/aarch64/virt/DSDT.viot        | Bin 0 -> 5310 bytes
>  tests/data/acpi/riscv64/virt/DSDT             | Bin 3576 -> 3538 bytes
>  tests/data/acpi/x86/microvm/DSDT.pcie         | Bin 3023 -> 2985 bytes
>  32 files changed, 811 insertions(+), 607 deletions(-)
>  create mode 100644 tests/data/acpi/aarch64/virt/DSDT.acpipcihp
>  create mode 100644 tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex
>  create mode 100644 tests/data/acpi/aarch64/virt/DSDT.viot
> 


