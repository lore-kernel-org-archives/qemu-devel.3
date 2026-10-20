Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1CF606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 11:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=rev.ng header.i=@rev.ng header.a=rsa-sha256 header.s=dkim header.b=IX+TAgd2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ7vd-0007o1-8e; Tue, 20 Oct 2026 07:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1xJ7va-0007na-PV
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 07:22:47 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1xJ7vX-0003HE-LB
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 07:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=F0A/ofYvDdrnba1mia95J22cXQardQTdG+QIHbn8WJI=; b=IX+TAgd2qO6tFLJ
 kGrC3zJ55NmeCcnL4dKGxcXjBBQoelzdy+t0QYQJm04xwG8ucLfuS0SVulaYkJ2IJPVy3wMcXFc8b
 3JXukcca8icnGchGxSjRXyoiwHCC5+o7VSnUX/P9wvzeSnYmECfBDOGfZqJm+/ukU/FVvxiJr5aeo
 6I=;
Date: Tue, 20 Oct 2026 13:28:21 +0200
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, 
 Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, 
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH 06/14] hw/hexagon: add the QCS6490 CDSP machine
Message-ID: <atdLk08wTGhJ6flk@hive.localdomain>
References: <20261019055245.1457795-1-brian.cain@oss.qualcomm.com>
 <20261019055245.1457795-7-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261019055245.1457795-7-brian.cain@oss.qualcomm.com>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 19/10/26, Brian Cain wrote:
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  MAINTAINERS                               |   1 +
>  include/hw/hexagon/hexagon.h              |   1 +
>  include/hw/hexagon/qcom_dsp.h             |  81 +++++
>  hw/hexagon/machine_cfg_qcs6490_cdsp.h.inc |  65 ++++
>  hw/hexagon/qcom_dsp.c                     | 399 ++++++++++++++++++++++
>  hw/hexagon/qcs6490_cdsp.c                 |  64 ++++
>  tests/qtest/l2vic-test.c                  |   2 +
>  tests/qtest/qcom-dsp-test.c               |  93 +++++
>  tests/qtest/qct-qtimer-test.c             |   2 +
>  hw/hexagon/Kconfig                        |  15 +
>  hw/hexagon/meson.build                    |   2 +
>  tests/qtest/meson.build                   |   3 +-
>  12 files changed, 727 insertions(+), 1 deletion(-)
>  create mode 100644 include/hw/hexagon/qcom_dsp.h
>  create mode 100644 hw/hexagon/machine_cfg_qcs6490_cdsp.h.inc
>  create mode 100644 hw/hexagon/qcom_dsp.c
>  create mode 100644 hw/hexagon/qcs6490_cdsp.c
>  create mode 100644 tests/qtest/qcom-dsp-test.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ef619991b4b..04df9db77dc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1386,6 +1386,7 @@ F: include/hw/misc/qcom-qdsp6ss-clk.h
>  F: configs/devices/hexagon-softmmu/default.mak
>  F: docs/system/hexagon/
>  F: tests/functional/hexagon/
> +F: tests/qtest/qcom-dsp-test.c
>  F: docs/devel/hexagon-sys.rst
>  
>  LoongArch Machines
> diff --git a/include/hw/hexagon/hexagon.h b/include/hw/hexagon/hexagon.h
> index 6955e600aee..1d0d55ea938 100644
> --- a/include/hw/hexagon/hexagon.h
> +++ b/include/hw/hexagon/hexagon.h
> @@ -23,6 +23,7 @@ typedef enum {
>      v66_rev = 0xa666,
>      v67_rev = 0x2667,
>      v68_rev = 0x8d68,
> +    v68_qcs6490_rev = 0x8a68,
>      v69_rev = 0x8c69,
>      v71_rev = 0x8c71,
>      v73_rev = 0x8c73,
> diff --git a/include/hw/hexagon/qcom_dsp.h b/include/hw/hexagon/qcom_dsp.h
> new file mode 100644
> index 00000000000..d127b0b0b10
> --- /dev/null
> +++ b/include/hw/hexagon/qcom_dsp.h
> @@ -0,0 +1,81 @@
> +/*
> + * Qualcomm DSP subsystem machines: the board layer shared by the SoC models.
> + *
> + * Each SoC provides a QcomDspMachineInfo describing its subsystem, and the
> + * layer supplies what every one of them has in common: the CPUs, a QEMU-only
> + * PL011 console, virtio-mmio slots, a generated device tree, and the
> + * -bios/-kernel/-initrd boot flow.
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_HEXAGON_QCOM_DSP_H
> +#define HW_HEXAGON_QCOM_DSP_H
> +
> +#include "hw/hexagon/hexagon.h"
> +#include "qom/object.h"
> +
> +#define TYPE_QCOM_DSP_MACHINE MACHINE_TYPE_NAME("qcom-dsp")
> +OBJECT_DECLARE_TYPE(QcomDspMachineState, QcomDspMachineClass, QCOM_DSP_MACHINE)
> +
> +/* Number of virtio-mmio transports every machine provides. */
> +#define QCOM_DSP_VIRTIO_COUNT 8
> +
> +typedef struct QcomDspMachineInfo {
> +    const char *desc;
> +    const char *cpu_type;
> +    unsigned int cpus;
> +    Rev_t rev;
> +    const struct hexagon_machine_config *cfg;
> +    /* Where the H2 loadlinux of this SoC expects to find the Linux kernel. */
> +    hwaddr kernel_addr;
> +    /* Add the devices that are specific to this SoC; may be NULL. */
> +    void (*init_devices)(MachineState *ms);
> +} QcomDspMachineInfo;
> +
> +struct QcomDspMachineState {
> +    HexagonCommonMachineState parent_obj;
> +
> +    MemoryRegion tcm;
> +    MemoryRegion l2_ecc;
> +    int fdt_size;
> +    hwaddr fdt_addr;
> +    char *firmware_path;
> +};
> +
> +struct QcomDspMachineClass {
> +    MachineClass parent_class;
> +
> +    const QcomDspMachineInfo *info;
> +};
> +
> +/* Describes a register window the machine stubs out as unimplemented. */
> +typedef struct QcomDspRegion {
> +    const char *name;
> +    hwaddr base;
> +    /* Zero means one 4 KiB page. */
> +    hwaddr size;
> +} QcomDspRegion;
> +
> +/*
> + * Stub out register windows the guest may probe, named
> + * "<machine>.<name>@<base>".
> + */
> +void qcom_dsp_add_regions(MachineState *ms, const QcomDspRegion *regions,
> +                          unsigned int count);
> +
> +/* Create the sysbus device @type and map it at @base. */
> +void qcom_dsp_add_device(const char *type, hwaddr base);
> +
> +/*
> + * Stub out @ports consecutive QUP GENI serial engines of @size bytes.  They
> + * belong to the SoC @soc rather than to the DSP.
> + */
> +void qcom_soc_add_qup_geni_ports(const char *soc, hwaddr base,
> +                                 unsigned int ports, hwaddr size);
> +
> +/* Class init for a machine type whose class_data is a QcomDspMachineInfo. */
> +void qcom_dsp_class_init(ObjectClass *oc, const void *data);
> +
> +#endif /* HW_HEXAGON_QCOM_DSP_H */
> diff --git a/hw/hexagon/machine_cfg_qcs6490_cdsp.h.inc b/hw/hexagon/machine_cfg_qcs6490_cdsp.h.inc
> new file mode 100644
> index 00000000000..11302da2238
> --- /dev/null
> +++ b/hw/hexagon/machine_cfg_qcs6490_cdsp.h.inc
> @@ -0,0 +1,65 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +static const struct hexagon_machine_config qcs6490_cdsp = {
> +    .ddr_base =          0x80000000,
> +    .cfgbase =           0x09980000,
> +    .l2tcm_size =        0x00000000,
> +    .l2vic_base =        0x0a390000,
> +    .l2vic_size =        0x00001000,
> +    .csr_base =          0x0a3a0000,
> +    .qtmr_region =       0x0a3a1000,
> +    .cfgtable = {
> +        .l2tcm_base = 0x00000980,
> +        .reserved0 = 0x00000000,
> +        .subsystem_base = 0x00000a38,
> +        .etm_base = 0x00000999,
> +        .l2cfg_base = 0x0000099a,
> +        .reserved1 = 0x0000099b,
> +        .l1s0_base = 0x000009c0,
> +        .axi2_lowaddr = 0x00000000,
> +        .streamer_base = 0x0000099c,
> +        .reserved2 = 0x0000099d,
> +        .fastl2vic_base = 0x0000099e,
> +        .jtlb_size_entries = 0x00000080,
> +        .coproc_present = 0x00000001,
> +        .ext_contexts = 0x00000002,
> +        .vtcm_base = 0x000009c0,
> +        .vtcm_size_kb = 0x00000800,
> +        .l2tag_size = 0x00000400,
> +        .l2ecomem_size = 0x00000400,
> +        .thread_enable_mask = 0x0000003f,
> +        .eccreg_base = 0x0000099f,
> +        .l2line_size = 0x00000080,
> +        .tiny_core = 0x00000000,
> +        .l2itcm_size = 0x00000000,
> +        .l2itcm_base = 0x00000980,
> +        .reserved3 = 0x00000000,
> +        .dtm_present = 0x00000000,
> +        .dma_version = 0x00000001,
> +        .hvx_vec_log_length = 0x00000007,
> +        .core_id = 0x00000000,
> +        .core_count = 0x00000000,
> +        .coproc2_reg0 = 0x00000040,
> +        .coproc2_reg1 = 0x00000020,
> +        .v2x_mode = 0x00000001,
> +        .coproc2_reg2 = 0x00000002,
> +        .coproc2_reg3 = 0x00000000,
> +        .coproc2_reg4 = 0x00000000,
> +        .coproc2_reg5 = 0x00000000,
> +        .coproc2_reg6 = 0x00000000,
> +        .coproc2_reg7 = 0x00000000,
> +        .acd_preset = 0x00000001,
> +        .mnd_preset = 0x00000001,
> +        .l1d_size_kb = 0x00000010,
> +        .l1i_size_kb = 0x00000020,
> +        .l1d_write_policy = 0x00000002,
> +        .vtcm_bank_width = 0x00000040,
> +        .reserved4 = 0x00000001,
> +        .reserved5 = 0x00000000,
> +        .reserved6 = 0x00000000,
> +        .coproc2_cvt_mpy_size = 0x0000000a,
> +        .consistency_domain = 0x00000000,
> +        .capacity_domain = 0x00000000,
> +        .axi3_lowaddr = 0x00000000,
> +    },
> +};
> diff --git a/hw/hexagon/qcom_dsp.c b/hw/hexagon/qcom_dsp.c
> new file mode 100644
> index 00000000000..5520366bb28
> --- /dev/null
> +++ b/hw/hexagon/qcom_dsp.c
> @@ -0,0 +1,399 @@
> +/*
> + * DSP subsystem machines: the board layer shared by the SoC models.
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/core/boards.h"
> +#include "hw/core/loader.h"
> +#include "hw/core/sysbus.h"
> +#include "hw/hexagon/hexagon.h"
> +#include "hw/hexagon/hex-board.h"
> +#include "hw/hexagon/hex-subsys.h"
> +#include "hw/hexagon/qcom_dsp.h"
> +#include "hw/misc/unimp.h"
> +#include "qemu/datadir.h"
> +#include "qemu/error-report.h"
> +#include "qemu/units.h"
> +#include "system/address-spaces.h"
> +#include "system/device_tree.h"
> +
> +enum {
> +    QCOM_DSP_UART0,
> +    QCOM_DSP_VIRTIO,
> +    QCOM_DSP_GPT,
> +    QCOM_DSP_BOOT,
> +};
> +
> +static const MemMapEntry qcom_dsp_memmap[] = {
> +    [QCOM_DSP_UART0] = { 0x37000000, 0x00001000 },
> +    [QCOM_DSP_VIRTIO] = { 0x37010000, 0x00001000 },
> +    /* Not a device: the window the kernel's H2 timer driver binds to. */
> +    [QCOM_DSP_GPT] = { 0xab000000, 0x00001000 },
> +    [QCOM_DSP_BOOT] = { 0x99c00000, 0x00000200 },
> +};
> +
> +static const int QCOM_DSP_UART0_IRQ = 15;
> +/* Virtio IRQs run from QCOM_DSP_VIRTIO_IRQ to QCOM_DSP_VIRTIO_IRQ + 7 */
> +static const int QCOM_DSP_VIRTIO_IRQ = 96;
> +static const int QCOM_DSP_GPT_IRQ = 12;
> +
> +#define QCOM_DSP_L2_ECC_SIZE 0x1000
> +
> +#define QCOM_DSP_MAX_KERNEL_RAM (896 * MiB)
> +
> +static const uint32_t bootloader[] = {
> +    /* Load fdt_base_low value into r0: */
> +    0x099c4000, /* { immext(#0x99c00000) */
> +    0x7800c606, /*   r6 = ##-0x662fffd0 } */
> +    0x9186c000, /* { r0 = memw(r6+#0x0) } */
> +
> +    /* Load fdt_base_high value into r1: */
> +    0x099c4000, /* { immext(#0x99c00000) */
> +    0x7800c586, /*   r6 = ##-0x662fffd4 } */
> +    0x9186c001, /* { r1 = memw(r6+#0x0) } */
> +
> +    /* Load next_stage_entry value into r7: */
> +    0x099c4000, /* { immext(#0x99c00000) */
> +    0x7800c687, /*   r7 = ##-0x662fffcc } */
> +    0x9187c007, /* { r7 = memw(r7+#0x0) } */
> +
> +    /* Jump to next_stage_entry, r1:0 now contains fdt_base: */
> +    0x5287c000, /* { jumpr r7 } */
> +    0x0, /* Invalid packet */
> +    0x0, /* Pad for fdt_base_high */
> +    0x0, /* Pad for fdt_base_low */
> +    0x0, /* Pad for next_stage_entry */
> +};
> +
> +enum {
> +    FDT_HI = 11,
> +    FDT_LO,
> +    ENTRY_ADDR,
> +};
> +
> +static const QcomDspMachineInfo *qcom_dsp_info(MachineState *ms)
> +{
> +    return QCOM_DSP_MACHINE_GET_CLASS(ms)->info;
> +}
> +
> +void qcom_dsp_add_regions(MachineState *ms, const QcomDspRegion *regions,
> +                          unsigned int count)
> +{
> +    const char *machine = MACHINE_GET_CLASS(ms)->name;
> +
> +    for (unsigned int i = 0; i < count; i++) {
> +        g_autofree char *name = g_strdup_printf("%s.%s@%" HWADDR_PRIx, machine,
> +                                                regions[i].name,
> +                                                regions[i].base);
> +
> +        create_unimplemented_device(name, regions[i].base,
> +                                    regions[i].size ? regions[i].size : 0x1000);
> +    }
> +}
> +
> +void qcom_dsp_add_device(const char *type, hwaddr base)
> +{
> +    DeviceState *dev = qdev_new(type);
> +
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
> +}
> +
> +void qcom_soc_add_qup_geni_ports(const char *soc, hwaddr base,
> +                                 unsigned int ports, hwaddr size)
> +{
> +    for (unsigned int i = 0; i < ports; i++) {
> +        g_autofree char *name = g_strdup_printf("%s.qup-geni@%" HWADDR_PRIx,
> +                                                soc, base + i * size);
> +
> +        create_unimplemented_device(name, base + i * size, size);
> +    }
> +}
> +
> +/*
> + * The firmware programs the L2 ECC registers and polls them until what it
> + * wrote reads back, so they need to hold state.
> + */
> +static void qcom_dsp_add_l2_ecc_regs(QcomDspMachineState *qms,
> +                                     const QcomDspMachineInfo *info)
> +{
> +    hwaddr base = (hwaddr)info->cfg->cfgtable.eccreg_base << 16;
> +
> +    if (!base) {
> +        return;
> +    }
> +    memory_region_init_ram(&qms->l2_ecc, NULL, "l2-ecc-regs",
> +                           QCOM_DSP_L2_ECC_SIZE, &error_fatal);
> +    memory_region_add_subregion(get_system_memory(), base, &qms->l2_ecc);
> +}
> +
> +static void qcom_dsp_create_fdt(QcomDspMachineState *qms)
> +{
> +    MachineState *ms = MACHINE(qms);
> +    g_autofree char *compatible = g_strdup_printf("qcom,%s",
> +                                             MACHINE_GET_CLASS(ms)->name);
> +
> +    hex_board_create_fdt(ms, MACHINE_GET_CLASS(ms)->desc, compatible,
> +                         &qms->fdt_size);
> +    qemu_fdt_setprop_string(ms->fdt, "/soc", "compatible", "simple-bus");
> +}
> +
> +/*
> + * The H2 hypervisor provides the guest timer through hypercalls, so this
> + * node only tells the kernel's timer driver which interrupt to expect.
> + */
> +static void qcom_dsp_fdt_add_gpt(MachineState *ms)
> +{
> +    static const char compat[] = "qcom,h2-timer\0hvm-timer";
> +    g_autofree char *name = g_strdup_printf("/soc/gpt@%" PRIx64,
> +                                            qcom_dsp_memmap[QCOM_DSP_GPT].base);
> +
> +    qemu_fdt_add_subnode(ms->fdt, name);
> +    qemu_fdt_setprop(ms->fdt, name, "compatible", compat, sizeof(compat));
> +    qemu_fdt_setprop_cells(ms->fdt, name, "interrupts", QCOM_DSP_GPT_IRQ, 0);
> +    qemu_fdt_setprop_cells(ms->fdt, name, "reg", 0x0,
> +                           qcom_dsp_memmap[QCOM_DSP_GPT].base,
> +                           qcom_dsp_memmap[QCOM_DSP_GPT].size);
> +}
> +
> +static void qcom_dsp_fdt_add_memory(MachineState *ms)
> +{
> +    hwaddr kernel_addr = qcom_dsp_info(ms)->kernel_addr;
> +    hwaddr ram_end = qcom_dsp_info(ms)->cfg->ddr_base + ms->ram_size;
> +    hwaddr size = MIN(ram_end - kernel_addr, QCOM_DSP_MAX_KERNEL_RAM);
> +    g_autofree char *nodename = g_strdup_printf("/memory@%" HWADDR_PRIx,
> +                                                kernel_addr);
> +
> +    qemu_fdt_add_subnode(ms->fdt, nodename);
> +    qemu_fdt_setprop_string(ms->fdt, nodename, "device_type", "memory");
> +    qemu_fdt_setprop_cells(ms->fdt, nodename, "reg", 0, kernel_addr,
> +                           size);
> +}
> +
> +static uint64_t qcom_dsp_kernel_translate(void *opaque, uint64_t addr)
> +{
> +    return addr + qcom_dsp_info(MACHINE(opaque))->kernel_addr;
> +}
> +
> +static uint64_t qcom_dsp_load_kernel(MachineState *ms, bool through_firmware,
> +                                     hwaddr *image_high)
> +{
> +    return hex_board_load_elf(ms->kernel_filename,
> +                              through_firmware ? qcom_dsp_kernel_translate
> +                                               : NULL,
> +                              ms, image_high);
> +}
> +
> +static uint64_t qcom_dsp_load_firmware(QcomDspMachineState *qms)
> +{
> +    return hex_board_load_elf(qms->firmware_path, NULL, NULL, NULL);
> +}
> +
> +/*
> + * Place the FDT after the kernel image, inside the RAM window the kernel
> + * maps, and the initrd after that.
> + */
> +static void qcom_dsp_load_initrd(QcomDspMachineState *qms)
> +{
> +    MachineState *ms = MACHINE(qms);
> +    hwaddr start = qms->fdt_addr + 4 * MiB;
> +    hwaddr ram_end = qcom_dsp_info(ms)->cfg->ddr_base + ms->ram_size;
> +    ssize_t size;
> +
> +    if (!ms->initrd_filename) {
> +        return;
> +    }
> +
> +    if (start >= ram_end) {
> +        error_report("no room for the initrd: RAM ends at 0x%" HWADDR_PRIx
> +                     " but the initrd would start at 0x%" HWADDR_PRIx,
> +                     ram_end, start);
> +        exit(1);
> +    }
> +
> +    size = load_image_targphys_as(ms->initrd_filename, start, ram_end - start,
> +                                  &address_space_memory, &error_fatal);
> +
> +    qemu_fdt_setprop_u64(ms->fdt, "/chosen", "linux,initrd-start", start);
> +    qemu_fdt_setprop_u64(ms->fdt, "/chosen", "linux,initrd-end", start + size);
> +}
> +
> +/*
> + * A boot stub that passes the FDT address to the firmware in r1:r0, then
> + * jumps to the firmware's entry point.
> + */
> +static uint64_t qcom_dsp_setup_boot_stub(QcomDspMachineState *qms,
> +                                         uint64_t firmware_entry)
> +{
> +    hwaddr bootl_base = qcom_dsp_memmap[QCOM_DSP_BOOT].base;
> +    uint32_t stub[ARRAY_SIZE(bootloader)];
> +
> +    memcpy(stub, bootloader, sizeof(stub));

Maybe I'm missing something, but wouldn't we need to endian swap the
instruction words in `bootloader` on big-endian hosts?

> +    stub[FDT_LO] = cpu_to_le32(extract64(qms->fdt_addr, 0, 32));
> +    stub[FDT_HI] = cpu_to_le32(extract64(qms->fdt_addr, 32, 32));
> +    stub[ENTRY_ADDR] = cpu_to_le32(extract64(firmware_entry, 0, 32));
> +
> +    g_assert(sizeof(stub) <= qcom_dsp_memmap[QCOM_DSP_BOOT].size);
> +    rom_add_blob_fixed_as("bootloader", stub, sizeof(stub), bootl_base,
> +                          &address_space_memory);
> +
> +    return bootl_base;
> +}
> +
> +/* Reject boot options that do not make sense together, and find -bios. */
> +static void qcom_dsp_check_boot_options(QcomDspMachineState *qms)
> +{
> +    MachineState *ms = MACHINE(qms);
> +    hwaddr ddr_base = qcom_dsp_info(ms)->cfg->ddr_base;
> +    hwaddr kernel_addr = qcom_dsp_info(ms)->kernel_addr;
> +
> +    if (ms->firmware) {
> +        qms->firmware_path = qemu_find_file(QEMU_FILE_TYPE_BIOS, ms->firmware);
> +        if (!qms->firmware_path) {
> +            error_report("Could not find firmware '%s'", ms->firmware);
> +            exit(1);
> +        }
> +    }
> +
> +    if (ms->initrd_filename && !(ms->kernel_filename && qms->firmware_path)) {
> +        error_report("-initrd needs both -kernel and the H2 loadlinux "
> +                     "firmware given with -bios");
> +        exit(1);
> +    }
> +
> +    if (ms->kernel_filename && qms->firmware_path &&
> +        (ddr_base > qcom_dsp_memmap[QCOM_DSP_BOOT].base ||
> +         ddr_base + ms->ram_size <= kernel_addr)) {
> +        error_report("RAM (%" PRIu64 " MiB at 0x%" HWADDR_PRIx ") is too "
> +                     "small: the kernel is loaded at 0x%" HWADDR_PRIx,
> +                     ms->ram_size / MiB, ddr_base, kernel_addr);
> +        exit(1);
> +    }
> +}
> +
> +/* Load what -bios and -kernel name and return where CPU 0 starts, if known. */
> +static bool qcom_dsp_load_images(QcomDspMachineState *qms, uint64_t *start)
> +{
> +    MachineState *ms = MACHINE(qms);
> +    hwaddr image_high = 0;
> +
> +    if (ms->kernel_filename && qms->firmware_path) {
> +        uint64_t firmware_entry = qcom_dsp_load_firmware(qms);
> +
> +        qcom_dsp_load_kernel(ms, true, &image_high);
> +        qms->fdt_addr = QEMU_ALIGN_UP(image_high + 16 * MiB, 4 * MiB);

checks against ram_end only occur when -initrd is specified in
qcom_dsp_load_initrd(), so without -initrd you could get a fdt_addr
that's outside the range of ram.

> +        qcom_dsp_load_initrd(qms);
> +        *start = qcom_dsp_setup_boot_stub(qms, firmware_entry);
> +        return true;
> +    }
> +    if (ms->kernel_filename) {
> +        *start = qcom_dsp_load_kernel(ms, false, &image_high);
> +        return true;
> +    }
> +    if (qms->firmware_path) {
> +        *start = qcom_dsp_load_firmware(qms);
> +        return true;
> +    }
> +    return false;
> +}
> +

-- 
Anton Johansson
rev.ng Labs Srl.

