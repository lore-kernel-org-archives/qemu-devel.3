Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9058DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 00:20:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seODT-0000Ym-R9; Wed, 14 Aug 2024 20:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1seODR-0000YI-ID
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 20:19:45 -0400
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1seODP-0003vI-5g
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 20:19:45 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id B45DDCE1B04;
 Thu, 15 Aug 2024 00:19:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E260C116B1;
 Thu, 15 Aug 2024 00:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723681170;
 bh=9IHO+IHlt+Bd47+QggcZMinljdOBWoC9h40/wIqMC3Q=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=XPFlIutVOqaRrr2IAnjhalrqcHb28oShUtLiBvz3nfby2tNneHmk9qHlJ5Mf3X4Eb
 AaR8unaUKM855Yuy6diNyiFCh/VX76I8MytwSWhGUYSHN6kBvKU0BOwC+E/Z+wRAZW
 /E+qDqkGayTP/xIRtNgQj5Uu0B5Xv5s5zHcLl3nF1vud4Ta/4DnhelOkrgXsJdt7Rk
 iMXX2etVZna7PdcEcceBxk7nLJYHQugvzhB9cC7Khy+wJX7DRdKblR1iU5xmgPaDnk
 7hAib7vMmXl6cBwk8lpP8zqsK0xlfgixqqtwn8QirijW1Orl6D8uuVXgK3c7bGEOcw
 xHqJIIjzdzVhQ==
Date: Wed, 14 Aug 2024 17:19:28 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
cc: Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org, 
 anthony@xenproject.org, paul@xen.org, peter.maydell@linaro.org, 
 alex.bennee@linaro.org, xenia.ragiadakou@amd.com, jason.andryuk@amd.com, 
 edgar.iglesias@amd.com, xen-devel@lists.xenproject.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v1 09/10] hw/i386/xen: Add a Xen PVH x86 machine
In-Reply-To: <ZrzSRPPNYxeh98J4@zapote>
Message-ID: <alpine.DEB.2.22.394.2408141718510.298534@ubuntu-linux-20-04-desktop>
References: <20240812130606.90410-1-edgar.iglesias@gmail.com>
 <20240812130606.90410-10-edgar.iglesias@gmail.com>
 <alpine.DEB.2.22.394.2408121840230.298534@ubuntu-linux-20-04-desktop>
 <ZrzSRPPNYxeh98J4@zapote>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=145.40.73.55; envelope-from=sstabellini@kernel.org;
 helo=sin.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.135,
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

On Wed, 14 Aug 2024, Edgar E. Iglesias wrote:
> On Mon, Aug 12, 2024 at 06:48:52PM -0700, Stefano Stabellini wrote:
> > On Mon, 12 Aug 2024, Edgar E. Iglesias wrote:
> > > From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> > > 
> > > This adds a Xen PVH x86 machine based on the PVH Common
> > > module used by the ARM PVH machine.
> > > 
> > > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> > > ---
> > >  hw/i386/xen/meson.build |   1 +
> > >  hw/i386/xen/xen-pvh.c   | 196 ++++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 197 insertions(+)
> > >  create mode 100644 hw/i386/xen/xen-pvh.c
> > > 
> > > diff --git a/hw/i386/xen/meson.build b/hw/i386/xen/meson.build
> > > index 3f0df8bc07..c73c62b8e3 100644
> > > --- a/hw/i386/xen/meson.build
> > > +++ b/hw/i386/xen/meson.build
> > > @@ -4,6 +4,7 @@ i386_ss.add(when: 'CONFIG_XEN', if_true: files(
> > >  ))
> > >  i386_ss.add(when: ['CONFIG_XEN', xen], if_true: files(
> > >    'xen-hvm.c',
> > > +  'xen-pvh.c',
> > >  ))
> > >  
> > >  i386_ss.add(when: 'CONFIG_XEN_BUS', if_true: files(
> > > diff --git a/hw/i386/xen/xen-pvh.c b/hw/i386/xen/xen-pvh.c
> > > new file mode 100644
> > > index 0000000000..9c3d3fc58d
> > > --- /dev/null
> > > +++ b/hw/i386/xen/xen-pvh.c
> > > @@ -0,0 +1,196 @@
> > > +/*
> > > + * QEMU Xen PVH x86 Machine
> > > + *
> > > + * Copyright (c) 2024 Advanced Micro Devices, Inc.
> > > + * Written by Edgar E. Iglesias <edgar.iglesias@amd.com>
> > > + *
> > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > + */
> > > +
> > > +#include "qemu/osdep.h"
> > > +#include "qapi/error.h"
> > > +#include "qapi/visitor.h"
> > > +#include "qemu/error-report.h"
> > > +#include "hw/boards.h"
> > > +#include "sysemu/sysemu.h"
> > > +#include "hw/xen/arch_hvm.h"
> > > +#include "hw/xen/xen.h"
> > > +#include "hw/xen/xen-pvh-common.h"
> > > +
> > > +#define TYPE_XEN_PVH_X86  MACHINE_TYPE_NAME("xenpvh")
> > > +OBJECT_DECLARE_SIMPLE_TYPE(XenPVHx86State, XEN_PVH_X86)
> > > +
> > > +#define PVH_MAX_CPUS 128
> > > +
> > > +struct XenPVHx86State {
> > > +    /*< private >*/
> > > +    MachineState parent;
> > > +
> > > +    DeviceState *cpu[PVH_MAX_CPUS];
> > > +    XenPVHCommonState pvh;
> > > +
> > > +    /*
> > > +     * We provide these properties to allow Xen to move things to other
> > > +     * addresses for example when users need to accomodate the memory-map
> > > +     * for 1:1 mapped devices/memory.
> > > +     */
> > > +    struct {
> > > +        MemMapEntry ram_low, ram_high;
> > > +        MemMapEntry pci_ecam, pci_mmio, pci_mmio_high;
> > 
> > Can we use the same properties already present under XenPVHCommonState?
> > 
> > 
> > 
> > > +    } cfg;
> > > +};
> > > +
> > > +static void xenpvh_cpu_new(MachineState *ms,
> > > +                           XenPVHx86State *xp,
> > > +                           int cpu_idx,
> > > +                           int64_t apic_id)
> > > +{
> > > +    Object *cpu = object_new(ms->cpu_type);
> > > +
> > > +    object_property_add_child(OBJECT(ms), "cpu[*]", cpu);
> > > +    object_property_set_uint(cpu, "apic-id", apic_id, &error_fatal);
> > > +    qdev_realize(DEVICE(cpu), NULL, &error_fatal);
> > > +    object_unref(cpu);
> > > +
> > > +    xp->cpu[cpu_idx] = DEVICE(cpu);
> > 
> > 
> > Why do we need to create CPU devices in QEMU given that we are only
> > doing device emulation? I guess it is because ....
> > 
> > 
> > 
> > > +}
> > > +
> > > +static void xenpvh_init(MachineState *ms)
> > > +{
> > > +    XenPVHx86State *xp = XEN_PVH_X86(ms);
> > > +    const struct {
> > > +        const char *name;
> > > +        MemMapEntry *map;
> > > +    } map[] = {
> > > +        { "ram-low", &xp->cfg.ram_low },
> > > +        { "ram-high", &xp->cfg.ram_high },
> > > +        { "pci-ecam", &xp->cfg.pci_ecam },
> > > +        { "pci-mmio", &xp->cfg.pci_mmio },
> > > +        { "pci-mmio-high", &xp->cfg.pci_mmio_high },
> > > +    };
> > > +    int i;
> > > +
> > > +    object_initialize_child(OBJECT(ms), "pvh", &xp->pvh, TYPE_XEN_PVH_COMMON);
> > > +    object_property_set_int(OBJECT(&xp->pvh), "max-cpus", ms->smp.max_cpus,
> > > +                            &error_abort);
> > > +    object_property_set_int(OBJECT(&xp->pvh), "ram-size", ms->ram_size,
> > > +                            &error_abort);
> > > +
> > > +    for (i = 0; i < ARRAY_SIZE(map); i++) {
> > > +        g_autofree char *base_name = g_strdup_printf("%s-base", map[i].name);
> > > +        g_autofree char *size_name = g_strdup_printf("%s-size", map[i].name);
> > > +
> > > +        object_property_set_int(OBJECT(&xp->pvh), base_name, map[i].map->base,
> > > +                                 &error_abort);
> > > +        object_property_set_int(OBJECT(&xp->pvh), size_name, map[i].map->size,
> > > +                                 &error_abort);
> > > +    }
> > > +
> > > +    /* GSI's 16 - 20 are used for legacy PCIe INTX IRQs.  */
> > > +    object_property_set_int(OBJECT(&xp->pvh), "pci-intx-irq-base", 16,
> > > +                            &error_abort);
> > > +
> > > +    sysbus_realize(SYS_BUS_DEVICE(&xp->pvh), &error_abort);
> > > +
> > > +    /* Create dummy cores. This will indirectly create the APIC MSI window.  */
> > 
> > ... of the APIC MSI window ?
> 
> 
> Yes, exactly. I did have a first version without the CPUs that only had
> the MSI window but there was a bit of disentanglement needed and some
> other issue that I forgot. Note that with TCG disabled, this doesn't
> have the any CPU emulation so it doesn't affect our small PVH config
> very much. I could look into the MSI windows again though.

no, I think this is OK, especially if the number of CPUs is accurate

