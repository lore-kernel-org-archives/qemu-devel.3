Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB29CCF2DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIjZV-0007wn-TM; Mon, 19 Oct 2026 05:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1xIjZU-0007w7-B5; Mon, 19 Oct 2026 05:22:20 -0400
Received: from canpmsgout08.his.huawei.com ([113.46.200.223])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1xIjZR-0002ip-Lf; Mon, 19 Oct 2026 05:22:20 -0400
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=v/nn2cTw+F5QP3W8paRiiP4i2V6IxRiSLfNjunOT7xk=;
 b=Tsa4iPNVww2EYmzp93aII/6dSH+fHODi029k3gouekWPndv2q/glvaZmyqylfSyKGi7NcXN8T
 qqMo4CRamOL/NEK9imML4NapA+uIahWX3JkPMiJhnV5frAbvVVdb4j0kSqpA/mEwQUQzesvecCB
 cUEkns+NUmLLWwOTt4OEEfQ=
Received: from mail.maildlp.com (unknown [172.19.163.200])
 by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4j7VS028kqzmVYL;
 Mon, 19 Oct 2026 17:22:08 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
 by mail.maildlp.com (Postfix) with ESMTPS id 6219140563;
 Mon, 19 Oct 2026 17:22:11 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 17:22:10 +0800
Message-ID: <d8b10a7a-b601-49ec-8840-545995a36569@huawei.com>
Date: Mon, 19 Oct 2026 17:22:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/37] Add Arm MPAM emulation
To: Jinjie Ruan <2118537295@qq.com>, <anisinha@redhat.com>,
 <armbru@redhat.com>, <eblake@redhat.com>, <imammedo@redhat.com>,
 <michael.roth@amd.com>, <mst@redhat.com>, <pbonzini@redhat.com>,
 <peter.maydell@linaro.org>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
References: <tencent_22E95650AA60C6E59860452C0D61A21F1105@qq.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <tencent_22E95650AA60C6E59860452C0D61A21F1105@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.68]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk200008.china.huawei.com (7.202.194.74)
Received-SPF: pass client-ip=113.46.200.223;
 envelope-from=ruanjinjie@huawei.com; helo=canpmsgout08.his.huawei.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_SBL=1.623 autolearn=no autolearn_force=no
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

Hi all,

Sorry, due to SMTP rate limiting, this series has been split into
multiple threads. The complete 37 patches are as follows:

- patch 1 ~ 16:
https://lore.kernel.org/all/tencent_0D8D61C20611EC56598A6F86E7B869052E05@qq.com/

- patch 17 ~ 37:
https://lore.kernel.org/all/tencent_88B063FC15FDB4BD89164484DB67A9B61907@qq.com/#t

在 2026/10/16 17:46, Jinjie Ruan 写道:
> From: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> MPAM (Memory System Resource Partitioning and Monitoring) is Arm's
> architecture for partitioning and monitoring system memory resources
> - Cache portions
> - Capacity limits
> - Memory bandwidth and priority
> 
> And MPAM is the Arm counterpart of x86 RDT, which Linux exposes to user
> space via resctrl.
> 
> QEMU so far has no MPAM support at all: the CPU-side system registers
> are missing (a guest kernel that probes FEAT_MPAM takes an UNDEFINED
> exception), and there are no Memory System Components (MSCs), so a virt
> guest cannot exercise resctrl on Arm.
> 
> This series adds MPAM 1.1 emulation for the virt machine,
> and the structure is as below:
> 
> * target/arm (patches 1-3): the CPU registers:
>     - MPAMIDR_EL1 and MPAM0_EL1/MPAM1_EL1
>     - MPAM2_EL2/MPAMHCR_EL2
>     - MPAMSM_EL1 for FEAT_MPAM_SMS
> 
> * hw/acpi (patch 4): PPTT revision 3 with Cache IDs, which the kernel
>   needs to resolve the MPAM table's cache references to PPTT cache
>   nodes.
> 
> * hw/arm/mpam device model (patches 5-15): built up layer by layer
>     - The register map as pure registerfields declarations
>     - The base MSC device with MMIO access
>     - The mpam-msc-mem and mpam-msc-cache subtypes
>     - MPAMCFG_PART_SEL selection
>     - Per-RIS partition config storage
>     - The partitioning features one at a time (CPOR cache portions, MBW
>       bandwidth, PRI priority, CCAP capacity)
>     - The ECR/ESR register surface
> 
> * hw/arm/mpam (patch 16): PARTID narrowing via MPAMCFG_INTPARTID with
>   the identity-wrap default map
>    - The linux mainline driver exercises it by default and resctrl
>      reports num_closids=32.
> 
> * hw/arm/virt + hw/acpi (patches 17-23): the board wiring, one concern
>   per patch
>     - Machine properties
>     - The MMIO window reservation
>     - Device locator/irq properties
>     - Memory-side MSC creation
>     - Cache MSC creation derived from the smp cache topology
>     - The ACPI MPAM table, split into the DEN0065 MSC node builders
>       and the table assembly
> 
> * Monitoring (patches 24-29):
>     - The MSMON selection/window infrastructure
>     - The MBWU bandwidth monitor whose counters track the configured
>       bandwidth control (MBW_MAX or MBW_PBM, whichever the guest drives)
>     - CMIN/CASSOC storage
>     - PRI advertised on the memory side (backing the driver's MBPRI
>       pseudo-resource)
>     - The CSU occupancy monitor (a snapshot of the capacity scaled by
>       the CPBM fraction)
>     - The board sizing of that capacity per cache level
> 
> *Error reporting (patches 30-33):
>     - ECR/ESR as MSC-global registers (IHI 0099 4.3)
>     - Device reset with power-on state initialisation
>     - The two level-held interrupt outputs (8.2/8.3)
>     - Table 7-1 error recording injected on the invalid-configuration
>       write paths.
> 
> * patch 34: the board wiring of the MSC interrupts to free SPIs on the
>   GIC, with the assigned GSIVs reported in the ACPI MPAM table.
> 
> * patch 35: defaulting to a single node when none is specified.
> 
> * patches 36-37: the query-mpam-cache QMP introspection, split into
>   schema+stub and implementation.
> 
> With this, a Linux guest booted with -M virt,mpam=on (plus NUMA nodes)
> mounts resctrl with the full schemata set (L2/L3 CAT, capacity, MBA,
> priority), and MBM bandwidth and L2/L3 occupancy counters track the
> configured controls.
> 
> Verified with a Linux 7.3-rc6 guest on gic-v3: the arm_mpam driver probes
> cleanly, the resctrl regression suite passes and no MPAM error interrupt
> fires during normal boot.
> 
> Patches 1, 5-8 and 36-37 carry Jonathan Cameron's authorship, being
> derived from his RFC series and its QMP face.  Compared to that RFC [1],
> this series completes most of its TODO list and tracks what the
> mainline arm_mpam driver now requires:
>     - Monitoring
>     - The MSC interrupts
>     - Error reporting on invalid parameters
>     - PARTID narrowing
>     - The missing CPU registers
>     - PPTT rev 3 with Cache IDs
>     - CMIN/CASSOC
>     - Memory-side
>     - CSU monitoring
> 
> Still open from the RFC's TODO list: ACPI table unit tests.  Like the
> RFC, this is ACPI-only; the DT binding remains unimplemented.
> 
> [1] https://patchew.org/QEMU/20230808115713.2613-1-Jonathan.Cameron@huawei.com/
> 
> Jinjie Ruan (30):
>   target/arm: Add MPAM2_EL2 and MPAMHCR_EL2 registers
>   target/arm: Add MPAMSM_EL1 register
>   hw/acpi: Build PPTT rev 3 with cache IDs for MPAM cross-references
>   hw/arm/mpam: Handle MPAMCFG_PART_SEL selection
>   hw/arm/mpam: Add per-RIS partition config storage
>   hw/arm/mpam: Implement CPOR cache portion partitioning
>   hw/arm/mpam: Implement MBW bandwidth partitioning
>   hw/arm/mpam: Implement PRI priority partitioning
>   hw/arm/mpam: Implement CCAP capacity partitioning
>   hw/arm/mpam: Add ECR/ESR and error MSI register storage
>   hw/arm/mpam: Implement PARTID narrowing
>   hw/arm/virt: Add mpam and mpam-min-msc machine properties
>   hw/arm/virt: Reserve the MPAM MSC MMIO window
>   hw/arm/mpam: Add node and interrupt GSIV properties
>   hw/arm/virt: Create memory-side MPAM MSCs
>   hw/arm/virt: Create L2/L3 cache MPAM MSCs
>   hw/acpi: Add MPAM table MSC node builders
>   hw/acpi: Build the MPAM ACPI table
>   hw/arm/mpam: Add MSMON monitor selection and window configuration
>   hw/arm/mpam: Emulate MBWU bandwidth monitoring
>   hw/arm/mpam: Implement CMIN/CASSOC storage
>   hw/arm/mpam: Advertise PRI on memory-side MSCs
>   hw/arm/mpam: Emulate CSU cache-usage monitoring
>   hw/arm/virt: Size the cache MSC occupancy model by level
>   hw/arm/mpam: Handle ECR/ESR as MSC-global registers
>   hw/arm/mpam: Add device reset and power-on state initialisation
>   hw/arm/mpam: Add error and overflow interrupt outputs
>   hw/arm/mpam: Record errors and reject invalid configuration writes
>   hw/arm/virt: Wire MSC error and overflow interrupts to the GIC
>   hw/arm/virt: Default to implicit node 0 for MPAM without -numa
> 
> Jonathan Cameron (7):
>   target/arm: Add support for MPAM CPU registers
>   hw/arm/mpam: Add MPAM MSC register map
>   hw/arm/mpam: Add MPAM MSC base device
>   hw/arm/mpam: Add mpam-msc-mem memory-side MSC subtype
>   hw/arm/mpam: Add mpam-msc-cache MSC subtype
>   qapi: Add MPAM cache introspection schema and stub
>   hw/arm/mpam: Implement query-mpam-cache
> 
>  hw/acpi/aml-build.c         |   31 +-
>  hw/arm/Kconfig              |    4 +
>  hw/arm/meson.build          |    3 +
>  hw/arm/mpam-qapi-stubs.c    |   14 +
>  hw/arm/mpam-qapi.c          |   62 ++
>  hw/arm/mpam.c               | 1620 +++++++++++++++++++++++++++++++++++
>  hw/arm/virt-acpi-build.c    |  231 +++++
>  hw/arm/virt.c               |  239 ++++++
>  include/hw/acpi/aml-build.h |    8 +
>  include/hw/arm/mpam.h       |   23 +
>  include/hw/arm/virt.h       |    3 +
>  qapi/meson.build            |    1 +
>  qapi/mpam.json              |  120 +++
>  qapi/qapi-schema.json       |    1 +
>  target/arm/cpu-features.h   |   11 +
>  target/arm/cpu.c            |   10 +-
>  target/arm/cpu.h            |    6 +
>  target/arm/helper.c         |   33 +
>  18 files changed, 2410 insertions(+), 10 deletions(-)
>  create mode 100644 hw/arm/mpam-qapi-stubs.c
>  create mode 100644 hw/arm/mpam-qapi.c
>  create mode 100644 hw/arm/mpam.c
>  create mode 100644 include/hw/arm/mpam.h
>  create mode 100644 qapi/mpam.json
> 

-- 
Best regards,
Jinjie


