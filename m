Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC08C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 01:23:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sga47-0008EQ-Eb; Tue, 20 Aug 2024 21:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1sga45-0008Do-TR
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 21:23:09 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1sga43-0006Au-4N
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 21:23:09 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 012C3CE0CDF;
 Wed, 21 Aug 2024 01:23:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5637AC4AF0B;
 Wed, 21 Aug 2024 01:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1724203382;
 bh=PD+v8CbvewzPXcIply8oiPVykbg+nqf9Vz9nQhrUa0c=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=X5shaQ70F4qVY89XUtBQBxoCcc2kuEEqBZe3JM4mvEmEABU4dz+1Mj4Li3mqGSRpB
 w26GCJZ9GOET88VrPaoQCGMLjBHPnd2LAwFU2RU52EPXiXHU+imMhRIm7AEP+fWFlQ
 e0t+oK3hpmZ/iIHv0Ab3g2d03HAeyntuSpgiW3PnhV49FEbMnPCTlJIRzUmXWhmSSB
 /eks8ZbXcpSbIemQd2USXWf95Idp7wQOTdhaci5xlm+2Bqa3iXap28ch8eAXMpzThX
 jp+ateAJAJ12OHv6gO94mb1eRe+f3g1fuXg1N/4PhGiO3Mkxh4whfzhIapFzxL0FsX
 MSUvCQ2mHVO/A==
Date: Tue, 20 Aug 2024 18:22:58 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, anthony@xenproject.org, 
 paul@xen.org, peter.maydell@linaro.org, alex.bennee@linaro.org, 
 xenia.ragiadakou@amd.com, jason.andryuk@amd.com, edgar.iglesias@amd.com, 
 xen-devel@lists.xenproject.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v2 11/12] hw/i386/xen: Add a Xen PVH x86 machine
In-Reply-To: <20240820142949.533381-12-edgar.iglesias@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2408201822530.298534@ubuntu-linux-20-04-desktop>
References: <20240820142949.533381-1-edgar.iglesias@gmail.com>
 <20240820142949.533381-12-edgar.iglesias@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=sstabellini@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 20 Aug 2024, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Add a Xen PVH x86 machine based on the abstract PVH Machine.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  hw/i386/xen/meson.build |   1 +
>  hw/i386/xen/xen-pvh.c   | 121 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 122 insertions(+)
>  create mode 100644 hw/i386/xen/xen-pvh.c
> 
> diff --git a/hw/i386/xen/meson.build b/hw/i386/xen/meson.build
> index 3f0df8bc07..c73c62b8e3 100644
> --- a/hw/i386/xen/meson.build
> +++ b/hw/i386/xen/meson.build
> @@ -4,6 +4,7 @@ i386_ss.add(when: 'CONFIG_XEN', if_true: files(
>  ))
>  i386_ss.add(when: ['CONFIG_XEN', xen], if_true: files(
>    'xen-hvm.c',
> +  'xen-pvh.c',
>  ))
>  
>  i386_ss.add(when: 'CONFIG_XEN_BUS', if_true: files(
> diff --git a/hw/i386/xen/xen-pvh.c b/hw/i386/xen/xen-pvh.c
> new file mode 100644
> index 0000000000..45645667e9
> --- /dev/null
> +++ b/hw/i386/xen/xen-pvh.c
> @@ -0,0 +1,121 @@
> +/*
> + * QEMU Xen PVH x86 Machine
> + *
> + * Copyright (c) 2024 Advanced Micro Devices, Inc.
> + * Written by Edgar E. Iglesias <edgar.iglesias@amd.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "hw/boards.h"
> +#include "sysemu/sysemu.h"
> +#include "hw/xen/arch_hvm.h"
> +#include <xen/hvm/hvm_info_table.h>
> +#include "hw/xen/xen-pvh-common.h"
> +
> +#define TYPE_XEN_PVH_X86  MACHINE_TYPE_NAME("xenpvh")
> +OBJECT_DECLARE_SIMPLE_TYPE(XenPVHx86State, XEN_PVH_X86)
> +
> +struct XenPVHx86State {
> +    /*< private >*/
> +    XenPVHMachineState parent;
> +
> +    DeviceState **cpu;
> +};
> +
> +static DeviceState *xen_pvh_cpu_new(MachineState *ms,
> +                                    int64_t apic_id)
> +{
> +    Object *cpu = object_new(ms->cpu_type);
> +
> +    object_property_add_child(OBJECT(ms), "cpu[*]", cpu);
> +    object_property_set_uint(cpu, "apic-id", apic_id, &error_fatal);
> +    qdev_realize(DEVICE(cpu), NULL, &error_fatal);
> +    object_unref(cpu);
> +
> +    return DEVICE(cpu);
> +}
> +
> +static void xen_pvh_init(MachineState *ms)
> +{
> +    XenPVHx86State *xp = XEN_PVH_X86(ms);
> +    int i;
> +
> +    /* Create dummy cores. This will indirectly create the APIC MSI window.  */
> +    xp->cpu = g_malloc(sizeof xp->cpu[0] * ms->smp.max_cpus);
> +    for (i = 0; i < ms->smp.max_cpus; i++) {
> +        xp->cpu[i] = xen_pvh_cpu_new(ms, i);
> +    }
> +}
> +
> +static void xen_pvh_instance_init(Object *obj)
> +{
> +    XenPVHMachineState *s = XEN_PVH_MACHINE(obj);
> +
> +    /* Default values.  */
> +    s->cfg.ram_low = (MemMapEntry) { 0x0, 0x80000000U };
> +    s->cfg.ram_high = (MemMapEntry) { 0xC000000000ULL, 0x4000000000ULL };
> +    s->cfg.pci_intx_irq_base = 16;
> +}
> +
> +/*
> + * Deliver INTX interrupts to Xen guest.
> + */
> +static void xen_pvh_set_pci_intx_irq(void *opaque, int irq, int level)
> +{
> +    /*
> +     * Since QEMU emulates all of the swizziling
> +     * We don't want Xen to do any additional swizzling in
> +     * xen_set_pci_intx_level() so we always set device to 0.
> +     */
> +    if (xen_set_pci_intx_level(xen_domid, 0, 0, 0, irq, level)) {
> +        error_report("xendevicemodel_set_pci_intx_level failed");
> +    }
> +}
> +
> +static void xen_pvh_machine_class_init(ObjectClass *oc, void *data)
> +{
> +    XenPVHMachineClass *xpc = XEN_PVH_MACHINE_CLASS(oc);
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +
> +    mc->desc = "Xen PVH x86 machine";
> +    mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
> +
> +    /* mc->max_cpus holds the MAX value allowed in the -smp cmd-line opts. */
> +    mc->max_cpus = HVM_MAX_VCPUS;
> +
> +    /* We have an implementation specific init to create CPU objects.  */
> +    xpc->init = xen_pvh_init;
> +
> +    /*
> +     * PCI INTX routing.
> +     *
> +     * We describe the mapping between the 4 INTX interrupt and GSIs
> +     * using xen_set_pci_link_route(). xen_pvh_set_pci_intx_irq is
> +     * used to deliver the interrupt.
> +     */
> +    xpc->set_pci_intx_irq = xen_pvh_set_pci_intx_irq;
> +    xpc->set_pci_link_route = xen_set_pci_link_route;
> +
> +    /* List of supported features known to work on PVH x86.  */
> +    xpc->has_pci = true;
> +
> +    xen_pvh_class_setup_common_props(xpc);
> +}
> +
> +static const TypeInfo xen_pvh_x86_machine_type = {
> +    .name = TYPE_XEN_PVH_X86,
> +    .parent = TYPE_XEN_PVH_MACHINE,
> +    .class_init = xen_pvh_machine_class_init,
> +    .instance_init = xen_pvh_instance_init,
> +    .instance_size = sizeof(XenPVHx86State),
> +};
> +
> +static void xen_pvh_machine_register_types(void)
> +{
> +    type_register_static(&xen_pvh_x86_machine_type);
> +}
> +
> +type_init(xen_pvh_machine_register_types)
> -- 
> 2.43.0
> 

