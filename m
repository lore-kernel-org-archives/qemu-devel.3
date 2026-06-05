Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 259DFCD8C81
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 15:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVW2P-00062A-2P; Fri, 05 Jun 2026 11:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>)
 id 1wVW2M-0005yl-KG; Fri, 05 Jun 2026 11:00:43 -0400
Received: from msg-4.mailo.com ([213.182.54.15] helo=mailo.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>)
 id 1wVW1a-0006Kw-RC; Fri, 05 Jun 2026 11:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
 t=1780671538; bh=40XambyL0NZiHOcGr/oDIkHHWRqISSmA6XFCWBn9k00=;
 h=X-EA-Auth:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 b=mF5WXjWx69wWgicaRezuxOywfFOQ8zfk1skkx2kx+gXgViVLzFvHv5S3mRmqEyqZL
 CI73NnZQVUG8g93nRMJU362iv2/hmTydNfaHWBxXYvEbSbBBKwZwfFr6Mswm3hGpb8
 og18W74mUacxnhtKX/0r3O6WQmotm8bxqNG2aZX4=
Received: by be1-6.in.mailobj.net [192.168.91.16] with ESMTP
 via ip-20.mailobj.net [213.182.54.20]
 Fri,  5 Jun 2026 16:58:58 +0200 (CEST)
X-EA-Auth: lTR7g0WxJ8fRHMnAIFnh2MzeFO+Q4Aqbiin9w1jGGFgs9be44nopr7WhWMPiCXvRWkfOFcBifqtdnhTQY6ceMhDwnukWswQQ
Message-ID: <d2682cb5-88e6-41f2-b07b-945af5f8d749@mailo.com>
Date: Fri, 5 Jun 2026 16:58:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/9] hw/hexagon: Define hexagon "virt" machine
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 ltaylorsimpson@gmail.com, philmd@linaro.org, Brian Cain <bcain@quicinc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
References: <20260529215937.610229-1-brian.cain@oss.qualcomm.com>
 <20260529215937.610229-9-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260529215937.610229-9-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=213.182.54.15; envelope-from=philmd@mailo.com;
 helo=mailo.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Brian,

On 29/5/26 23:59, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   configs/devices/hexagon-softmmu/default.mak |   1 +
>   configs/targets/hexagon-softmmu.mak         |   1 +
>   include/hw/hexagon/virt.h                   |  31 ++
>   hw/hexagon/virt.c                           | 463 ++++++++++++++++++++
>   hw/hexagon/Kconfig                          |  10 +
>   hw/hexagon/meson.build                      |   1 +
>   tests/qemu-iotests/testenv.py               |   1 +
>   7 files changed, 508 insertions(+)
>   create mode 100644 include/hw/hexagon/virt.h
>   create mode 100644 hw/hexagon/virt.c


> +static int32_t fdt_add_hvm_pic_node(HexagonVirtMachineState *vms,
> +                                     const struct hexagon_machine_config *m_cfg)
> +{

[*] Dead code (see below)

> +    MachineState *ms = MACHINE(vms);
> +    int32_t irq_phandle = qemu_fdt_alloc_phandle(ms->fdt);
> +
> +    qemu_fdt_setprop_cell(ms->fdt, "/soc", "interrupt-parent",
> +                          irq_phandle);
> +
> +    qemu_fdt_add_subnode(ms->fdt, "/soc/interrupt-controller");
> +    qemu_fdt_setprop_cell(ms->fdt, "/soc/interrupt-controller",
> +                          "#address-cells", 2);
> +    qemu_fdt_setprop_cell(ms->fdt, "/soc/interrupt-controller",
> +                          "#interrupt-cells", 2);
> +    qemu_fdt_setprop_string(ms->fdt, "/soc/interrupt-controller", "compatible",
> +                            "qcom,h2-pic,hvm-pic");
> +    qemu_fdt_setprop(ms->fdt, "/soc/interrupt-controller",
> +                     "interrupt-controller", NULL, 0);
> +    qemu_fdt_setprop_cell(ms->fdt, "/soc/interrupt-controller", "phandle",
> +                          irq_phandle);
> +
> +    sysbus_mmio_map(SYS_BUS_DEVICE(vms->l2vic), 1,
> +                    m_cfg->cfgtable.fastl2vic_base << 16);
> +
> +    return irq_phandle;
> +}


> +static void fdt_add_uart(const HexagonVirtMachineState *vms, int uart,
> +                         int32_t irq_phandle, int32_t clk_phandle)
> +{
> +    char *nodename;
> +    hwaddr base = base_memmap[uart].base;
> +    hwaddr size = base_memmap[uart].size;
> +    assert(uart == 0);
> +    int irq = irqmap[VIRT_UART0 + uart];
> +    const char compat[] = "arm,pl011\0arm,primecell";
> +    const char clocknames[] = "uartclk\0apb_pclk";
> +    MachineState *ms = MACHINE(vms);
> +    DeviceState *dev;
> +    SysBusDevice *s;
> +
> +    dev = qdev_new(TYPE_PL011);
> +    s = SYS_BUS_DEVICE(dev);
> +    qdev_prop_set_chr(dev, "chardev", serial_hd(0));
> +    qdev_connect_clock_in(dev, "clk", vms->apb_clk);
> +    sysbus_realize_and_unref(s, &error_fatal);
> +    sysbus_mmio_map(s, 0, base);
> +    if (vms->l2vic) {
> +        sysbus_connect_irq(s, 0, qdev_get_gpio_in(vms->l2vic, irq));

[*] Dead code (see below)

> +    }
> +
> +    nodename = g_strdup_printf("/pl011@%" PRIx64, base);
> +    qemu_fdt_add_subnode(ms->fdt, nodename);
> +
> +    /* Note that we can't use setprop_string because of the embedded NUL */
> +    qemu_fdt_setprop(ms->fdt, nodename, "compatible", compat, sizeof(compat));
> +    qemu_fdt_setprop_cells(ms->fdt, nodename, "reg", 0, base, size);
> +    if (vms->l2vic) {

[*] Dead code (see below)

> +        qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
> +                               32 + irq, 0);
> +        qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
> +                              irq_phandle);
> +    }
> +    qemu_fdt_setprop_cells(ms->fdt, nodename, "clocks", clk_phandle,
> +                           clk_phandle);
> +    qemu_fdt_setprop(ms->fdt, nodename, "clock-names", clocknames,
> +                     sizeof(clocknames));
> +
> +    qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", nodename);
> +    qemu_fdt_add_subnode(ms->fdt, "/aliases");
> +    qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", nodename);
> +
> +    g_free(nodename);
> +}


> +static void fdt_add_virtio_devices(const HexagonVirtMachineState *vms,
> +                                   int32_t irq_phandle)
> +{
> +    MachineState *ms = MACHINE(vms);
> +    /* VirtIO MMIO devices */
> +    for (int i = 0; i < VIRTIO_DEV_COUNT; i++) {
> +        char *nodename;
> +        int irq = irqmap[VIRT_MMIO] + i;
> +        size_t size = base_memmap[VIRT_MMIO].size;
> +        hwaddr base = base_memmap[VIRT_MMIO].base + i * size;
> +
> +        nodename = g_strdup_printf("/virtio_mmio@%" PRIx64, base);
> +        qemu_fdt_add_subnode(ms->fdt, nodename);
> +        qemu_fdt_setprop_string(ms->fdt, nodename, "compatible", "virtio,mmio");
> +        qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg", 2, base, 1,
> +                                     size);
> +        qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts", irq, 0);
> +        qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
> +                              irq_phandle);
> +
> +        sysbus_create_simple(
> +            "virtio-mmio", base,
> +            qdev_get_gpio_in(vms->l2vic, irqmap[VIRT_MMIO] + i));

[*] Unreachable otherwise that'd crash... Dead code.

> +
> +        g_free(nodename);
> +    }
> +}


> +static void virt_init(MachineState *ms)
> +{
> +    HexagonVirtMachineState *vms = HEXAGON_VIRT_MACHINE(ms);
> +    const struct hexagon_machine_config *m_cfg = &v68n_1024;
> +    DeviceState *gsregs_dev;
> +    DeviceState *tlb_dev;
> +    DeviceState *cpu0;
> +    int32_t irq_phandle = -1;
> +    int32_t clk_phandle;
> +
> +    qemu_fdt_setprop_string(ms->fdt, "/chosen", "bootargs", ms->kernel_cmdline);
> +
> +    vms->sys = get_system_memory();
> +
> +    /* Create APB clock for peripherals */
> +    vms->apb_clk = clock_new(OBJECT(ms), "apb-pclk");
> +    clock_set_hz(vms->apb_clk, 24000000);
> +
> +    memory_region_init_ram(&vms->parent_obj.ram, NULL, "ddr.ram",
> +                           ms->ram_size, &error_fatal);
> +    memory_region_add_subregion(vms->sys, 0x0, &vms->parent_obj.ram);
> +
> +    if (m_cfg->l2tcm_size) {
> +        memory_region_init_ram(&vms->tcm, NULL, "tcm.ram", m_cfg->l2tcm_size,
> +                               &error_fatal);
> +        memory_region_add_subregion(vms->sys, m_cfg->cfgtable.l2tcm_base << 16,
> +                                    &vms->tcm);
> +    }
> +
> +    memory_region_init_rom(&vms->parent_obj.cfgtable_rom, NULL,
> +                           "config_table.rom", sizeof(m_cfg->cfgtable),
> +                           &error_fatal);
> +    memory_region_add_subregion(vms->sys, m_cfg->cfgbase,
> +                                &vms->parent_obj.cfgtable_rom);
> +    fdt_add_hvx(vms, m_cfg);
> +
> +    gsregs_dev = qdev_new(TYPE_HEXAGON_GLOBALREG);
> +    object_property_add_child(OBJECT(ms), "global-regs", OBJECT(gsregs_dev));
> +    qdev_prop_set_uint64(gsregs_dev, "config-table-addr", m_cfg->cfgbase);
> +    qdev_prop_set_uint32(gsregs_dev, "dsp-rev", v68_rev);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(gsregs_dev), &error_fatal);
> +
> +    tlb_dev = qdev_new(TYPE_HEXAGON_TLB);
> +    object_property_add_child(OBJECT(ms), "tlb", OBJECT(tlb_dev));
> +    qdev_prop_set_uint32(tlb_dev, "num-entries",
> +                         m_cfg->cfgtable.jtlb_size_entries);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(tlb_dev), &error_fatal);
> +
> +    cpu0 = NULL;
> +    for (int i = 0; i < ms->smp.cpus; i++) {
> +        HexagonCPU *cpu = HEXAGON_CPU(object_new(ms->cpu_type));
> +        qemu_register_reset(do_cpu_reset, cpu);
> +
> +        if (i == 0) {
> +            cpu0 = DEVICE(cpu);
> +            if (ms->kernel_filename) {
> +                uint64_t entry = load_kernel(vms);
> +                qdev_prop_set_uint32(cpu0, "exec-start-addr", entry);
> +            } else if (ms->firmware) {
> +                uint64_t entry = load_bios(vms);
> +                qdev_prop_set_uint32(cpu0, "exec-start-addr", entry);
> +            }
> +        }
> +        qdev_prop_set_uint32(DEVICE(cpu), "htid", i);
> +        qdev_prop_set_bit(DEVICE(cpu), "start-powered-off", (i != 0));
> +        object_property_set_link(OBJECT(cpu), "global-regs",
> +                                 OBJECT(gsregs_dev), &error_fatal);
> +        object_property_set_link(OBJECT(cpu), "tlb",
> +                                 OBJECT(tlb_dev), &error_fatal);
> +
> +        qdev_realize_and_unref(DEVICE(cpu), NULL, &error_fatal);
> +    }
> +    /* TODO: enable l2vic when l2vic device arrives */
> +    if (object_class_by_name("l2vic")) {
> +        vms->l2vic = sysbus_create_varargs(
> +            "l2vic", m_cfg->l2vic_base,

I'm really confused by this code, since no "l2vic" exist. Yet I suppose.
Can't we just remove this code and re-introduce once with the former
addition? I'd also remove the fdt_add_hvm_pic_node() and
fdt_add_virtio_devices() methods.
Normally all code should be used / tested, and IIUC [*] is dead code.

> +            qdev_get_gpio_in(cpu0, 0),
> +            qdev_get_gpio_in(cpu0, 1),
> +            qdev_get_gpio_in(cpu0, 2),
> +            qdev_get_gpio_in(cpu0, 3),
> +            qdev_get_gpio_in(cpu0, 4),
> +            qdev_get_gpio_in(cpu0, 5),
> +            qdev_get_gpio_in(cpu0, 6),
> +            qdev_get_gpio_in(cpu0, 7), NULL);
> +
> +        irq_phandle = fdt_add_hvm_pic_node(vms, m_cfg);
> +        fdt_add_virtio_devices(vms, irq_phandle);
> +        fdt_add_gpt_node(vms);
> +    }
> +
> +    fdt_add_cpu_nodes(vms);
> +    clk_phandle = fdt_add_clocks(vms);
> +    fdt_add_uart(vms, VIRT_UART0, irq_phandle, clk_phandle);
> +
> +    rom_add_blob_fixed_as("config_table.rom", &m_cfg->cfgtable,
> +                          sizeof(m_cfg->cfgtable), m_cfg->cfgbase,
> +                          &address_space_memory);
> +
> +    hexagon_load_fdt(vms);
> +}
Rest of the patch LGTM.

Regards,

Phil.



