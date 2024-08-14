Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57A2C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 15:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seGGi-0006v4-BY; Wed, 14 Aug 2024 11:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1seGGg-0006uV-NY
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 11:50:34 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1seGGe-0002JH-L8
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 11:50:34 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2f0271b0ae9so459731fa.1
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 08:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723650630; x=1724255430; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=e/gYLaKPeQFOpje6uLnnz3IMiblJW7rg/lR5EngKbeg=;
 b=KPvsz5CpQ0Uuywfnvg4+3nACEIOKWnEN14vJalKJHus1atvjw74oNL2HIjuzNwJVPC
 sWiXWLEJxxIWGr6NpVXPuQ6xKAYlR5dDKHFHY8SWGgJi3Rqdfw8GMA/gvXrjUEBMn6uE
 MmzzkBgWxZE5T7JOth/7h2+lYGQzkLSKTsqT0WGTBkXgqnV54Yh/cy0QmlZK9LIulDGo
 2sFQVOVwrGXwlcKynEXVuLrhyvfIFpHfTn6VbVu8H+ikL+o5CXEMNMceCTekXuGlanTJ
 41Ee1f34fNnk4QiFz2CX4WpZ6dmDM134HyDGJ8dMgygSMV0DghuqHJPpILnAALO+JYkZ
 brSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723650630; x=1724255430;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e/gYLaKPeQFOpje6uLnnz3IMiblJW7rg/lR5EngKbeg=;
 b=DEWBmF8U9W6BTyYivEIxLR/ct95CiC4w29owykoaVqIAkBc7AbVBe9PgaS4WXvX+A2
 nqlsY0+6nOPe045xeoSicX47xKbnQFEZaSnegZM011EabxcqWEoRbB96vBGgXVznCWIr
 FCdN5lBo4RR2bUN1y5Wxq0CE4NVd+XTQr23fVna1A/aN6siuaNxOCdWKQt3kljzC07pA
 Sfljjvk+zQSoXwL1qooCyI844Or2GTP8M5xr0QSh6HZK2vrZKmeyJRvi6fMiQzB/vHKS
 M0mJ3JnBaJhdPIcChV/A9PSsjkURgHtV6D7lPv8CyfRH6qNKPxmm5QwuEUBN8d1GMP/L
 l1EA==
X-Gm-Message-State: AOJu0Yy3c2CCDpPMJQzqaf/CKeeYaeI7N23pjsqrPNlRgm6DdR+bCvHS
 E1wnawk4bJVs+L1Dieu29aYR4+ExSP0KOsaadmlB7cqit3C8w+r1ENt1HhBW
X-Google-Smtp-Source: AGHT+IHcVkvxyTJG9ipRaZHZ+21NOa0KrthTySBhaf/jwCY7RrKJlzsfNGbJbbK5/xKyDBn6ddqmMQ==
X-Received: by 2002:a05:6512:138b:b0:52c:cc38:592c with SMTP id
 2adb3069b0e04-532ed729715mr2265346e87.0.1723650629740; 
 Wed, 14 Aug 2024 08:50:29 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53200f3daaesm1308152e87.241.2024.08.14.08.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 08:50:29 -0700 (PDT)
Date: Wed, 14 Aug 2024 17:50:28 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-devel@nongnu.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org,
 xenia.ragiadakou@amd.com, jason.andryuk@amd.com,
 edgar.iglesias@amd.com, xen-devel@lists.xenproject.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v1 09/10] hw/i386/xen: Add a Xen PVH x86 machine
Message-ID: <ZrzSRPPNYxeh98J4@zapote>
References: <20240812130606.90410-1-edgar.iglesias@gmail.com>
 <20240812130606.90410-10-edgar.iglesias@gmail.com>
 <alpine.DEB.2.22.394.2408121840230.298534@ubuntu-linux-20-04-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2408121840230.298534@ubuntu-linux-20-04-desktop>
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Aug 12, 2024 at 06:48:52PM -0700, Stefano Stabellini wrote:
> On Mon, 12 Aug 2024, Edgar E. Iglesias wrote:
> > From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> > 
> > This adds a Xen PVH x86 machine based on the PVH Common
> > module used by the ARM PVH machine.
> > 
> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> > ---
> >  hw/i386/xen/meson.build |   1 +
> >  hw/i386/xen/xen-pvh.c   | 196 ++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 197 insertions(+)
> >  create mode 100644 hw/i386/xen/xen-pvh.c
> > 
> > diff --git a/hw/i386/xen/meson.build b/hw/i386/xen/meson.build
> > index 3f0df8bc07..c73c62b8e3 100644
> > --- a/hw/i386/xen/meson.build
> > +++ b/hw/i386/xen/meson.build
> > @@ -4,6 +4,7 @@ i386_ss.add(when: 'CONFIG_XEN', if_true: files(
> >  ))
> >  i386_ss.add(when: ['CONFIG_XEN', xen], if_true: files(
> >    'xen-hvm.c',
> > +  'xen-pvh.c',
> >  ))
> >  
> >  i386_ss.add(when: 'CONFIG_XEN_BUS', if_true: files(
> > diff --git a/hw/i386/xen/xen-pvh.c b/hw/i386/xen/xen-pvh.c
> > new file mode 100644
> > index 0000000000..9c3d3fc58d
> > --- /dev/null
> > +++ b/hw/i386/xen/xen-pvh.c
> > @@ -0,0 +1,196 @@
> > +/*
> > + * QEMU Xen PVH x86 Machine
> > + *
> > + * Copyright (c) 2024 Advanced Micro Devices, Inc.
> > + * Written by Edgar E. Iglesias <edgar.iglesias@amd.com>
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qapi/error.h"
> > +#include "qapi/visitor.h"
> > +#include "qemu/error-report.h"
> > +#include "hw/boards.h"
> > +#include "sysemu/sysemu.h"
> > +#include "hw/xen/arch_hvm.h"
> > +#include "hw/xen/xen.h"
> > +#include "hw/xen/xen-pvh-common.h"
> > +
> > +#define TYPE_XEN_PVH_X86  MACHINE_TYPE_NAME("xenpvh")
> > +OBJECT_DECLARE_SIMPLE_TYPE(XenPVHx86State, XEN_PVH_X86)
> > +
> > +#define PVH_MAX_CPUS 128
> > +
> > +struct XenPVHx86State {
> > +    /*< private >*/
> > +    MachineState parent;
> > +
> > +    DeviceState *cpu[PVH_MAX_CPUS];
> > +    XenPVHCommonState pvh;
> > +
> > +    /*
> > +     * We provide these properties to allow Xen to move things to other
> > +     * addresses for example when users need to accomodate the memory-map
> > +     * for 1:1 mapped devices/memory.
> > +     */
> > +    struct {
> > +        MemMapEntry ram_low, ram_high;
> > +        MemMapEntry pci_ecam, pci_mmio, pci_mmio_high;
> 
> Can we use the same properties already present under XenPVHCommonState?
> 
> 
> 
> > +    } cfg;
> > +};
> > +
> > +static void xenpvh_cpu_new(MachineState *ms,
> > +                           XenPVHx86State *xp,
> > +                           int cpu_idx,
> > +                           int64_t apic_id)
> > +{
> > +    Object *cpu = object_new(ms->cpu_type);
> > +
> > +    object_property_add_child(OBJECT(ms), "cpu[*]", cpu);
> > +    object_property_set_uint(cpu, "apic-id", apic_id, &error_fatal);
> > +    qdev_realize(DEVICE(cpu), NULL, &error_fatal);
> > +    object_unref(cpu);
> > +
> > +    xp->cpu[cpu_idx] = DEVICE(cpu);
> 
> 
> Why do we need to create CPU devices in QEMU given that we are only
> doing device emulation? I guess it is because ....
> 
> 
> 
> > +}
> > +
> > +static void xenpvh_init(MachineState *ms)
> > +{
> > +    XenPVHx86State *xp = XEN_PVH_X86(ms);
> > +    const struct {
> > +        const char *name;
> > +        MemMapEntry *map;
> > +    } map[] = {
> > +        { "ram-low", &xp->cfg.ram_low },
> > +        { "ram-high", &xp->cfg.ram_high },
> > +        { "pci-ecam", &xp->cfg.pci_ecam },
> > +        { "pci-mmio", &xp->cfg.pci_mmio },
> > +        { "pci-mmio-high", &xp->cfg.pci_mmio_high },
> > +    };
> > +    int i;
> > +
> > +    object_initialize_child(OBJECT(ms), "pvh", &xp->pvh, TYPE_XEN_PVH_COMMON);
> > +    object_property_set_int(OBJECT(&xp->pvh), "max-cpus", ms->smp.max_cpus,
> > +                            &error_abort);
> > +    object_property_set_int(OBJECT(&xp->pvh), "ram-size", ms->ram_size,
> > +                            &error_abort);
> > +
> > +    for (i = 0; i < ARRAY_SIZE(map); i++) {
> > +        g_autofree char *base_name = g_strdup_printf("%s-base", map[i].name);
> > +        g_autofree char *size_name = g_strdup_printf("%s-size", map[i].name);
> > +
> > +        object_property_set_int(OBJECT(&xp->pvh), base_name, map[i].map->base,
> > +                                 &error_abort);
> > +        object_property_set_int(OBJECT(&xp->pvh), size_name, map[i].map->size,
> > +                                 &error_abort);
> > +    }
> > +
> > +    /* GSI's 16 - 20 are used for legacy PCIe INTX IRQs.  */
> > +    object_property_set_int(OBJECT(&xp->pvh), "pci-intx-irq-base", 16,
> > +                            &error_abort);
> > +
> > +    sysbus_realize(SYS_BUS_DEVICE(&xp->pvh), &error_abort);
> > +
> > +    /* Create dummy cores. This will indirectly create the APIC MSI window.  */
> 
> ... of the APIC MSI window ?


Yes, exactly. I did have a first version without the CPUs that only had
the MSI window but there was a bit of disentanglement needed and some
other issue that I forgot. Note that with TCG disabled, this doesn't
have the any CPU emulation so it doesn't affect our small PVH config
very much. I could look into the MSI windows again though.


> 
> 
> 
> > +    for (i = 0; i < ms->smp.cpus; i++) {
> > +        xenpvh_cpu_new(ms, xp, i, i);
> > +    }
> > +}
> > +
> > +#define XENPVH_PROP_MEMMAP_SETTER(n, f)                                    \
> > +static void xenpvh_set_ ## n ## _ ## f(Object *obj, Visitor *v,            \
> > +                                       const char *name, void *opaque,     \
> > +                                       Error **errp)                       \
> > +{                                                                          \
> > +    XenPVHx86State *xp = XEN_PVH_X86(obj);                                 \
> > +    uint64_t value;                                                        \
> > +                                                                           \
> > +    if (!visit_type_size(v, name, &value, errp)) {                         \
> > +        return;                                                            \
> > +    }                                                                      \
> > +    xp->cfg.n.f = value;                                                   \
> > +}
> > +
> > +#define XENPVH_PROP_MEMMAP_GETTER(n, f)                                    \
> > +static void xenpvh_get_ ## n ## _ ## f(Object *obj, Visitor *v,            \
> > +                                       const char *name, void *opaque,     \
> > +                                       Error **errp)                       \
> > +{                                                                          \
> > +    XenPVHx86State *xp = XEN_PVH_X86(obj);                                 \
> > +    uint64_t value = xp->cfg.n.f;                                          \
> > +                                                                           \
> > +    visit_type_uint64(v, name, &value, errp);                              \
> > +}
> > +
> > +#define XENPVH_PROP_MEMMAP(n)              \
> > +    XENPVH_PROP_MEMMAP_SETTER(n, base)     \
> > +    XENPVH_PROP_MEMMAP_SETTER(n, size)     \
> > +    XENPVH_PROP_MEMMAP_GETTER(n, base)     \
> > +    XENPVH_PROP_MEMMAP_GETTER(n, size)
> > +
> > +
> > +XENPVH_PROP_MEMMAP(ram_low)
> > +XENPVH_PROP_MEMMAP(ram_high)
> > +XENPVH_PROP_MEMMAP(pci_ecam)
> > +XENPVH_PROP_MEMMAP(pci_mmio)
> > +XENPVH_PROP_MEMMAP(pci_mmio_high)
> 
> I would make all of these common with ARM. It wouldn't hurt to make them
> configurable on ARM too, in fact we might need it for 1:1 mapped guests
> 


Yes, that was the plan in future patches.


> 
> 
> > +static void xenpvh_instance_init(Object *obj)
> > +{
> > +    XenPVHx86State *xp = XEN_PVH_X86(obj);
> > +
> > +    /* Default memmap.  */
> > +    xp->cfg.ram_low.base = 0x0;
> > +    xp->cfg.ram_low.size = 0x80000000U;
> > +    xp->cfg.ram_high.base = 0xC000000000ULL;
> > +    xp->cfg.ram_high.size = 0x4000000000ULL;
> > +}
> > +
> > +static void xenpvh_machine_class_init(ObjectClass *oc, void *data)
> > +{
> > +    MachineClass *mc = MACHINE_CLASS(oc);
> > +
> > +    mc->desc = "Xen PVH x86 machine";
> > +    mc->init = xenpvh_init;
> > +    mc->max_cpus = PVH_MAX_CPUS;
> > +    mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
> > +    mc->default_machine_opts = "accel=xen";
> > +    /* Set explicitly here to make sure that real ram_size is passed */
> > +    mc->default_ram_size = 0;
> > +
> > +#define OC_MEMMAP_PROP(c, prop_name, name)                               \
> > +do {                                                                     \
> > +    object_class_property_add(c, prop_name "-base", "uint64_t",          \
> > +                              xenpvh_get_ ## name ## _base,              \
> > +                              xenpvh_set_ ## name ## _base, NULL, NULL); \
> > +    object_class_property_set_description(oc, prop_name "-base",         \
> > +                              prop_name " base address");                \
> > +    object_class_property_add(c, prop_name "-size", "uint64_t",          \
> > +                              xenpvh_get_ ## name ## _size,              \
> > +                              xenpvh_set_ ## name ## _size, NULL, NULL); \
> > +    object_class_property_set_description(oc, prop_name "-size",         \
> > +                              prop_name " size of memory region");       \
> > +} while (0)
> > +
> > +    OC_MEMMAP_PROP(oc, "ram-low", ram_low);
> > +    OC_MEMMAP_PROP(oc, "ram-high", ram_high);
> > +    OC_MEMMAP_PROP(oc, "pci-ecam", pci_ecam);
> > +    OC_MEMMAP_PROP(oc, "pci-mmio", pci_mmio);
> > +    OC_MEMMAP_PROP(oc, "pci-mmio-high", pci_mmio_high);
> > +}
> > +
> > +static const TypeInfo xenpvh_machine_type = {
> > +    .name = TYPE_XEN_PVH_X86,
> > +    .parent = TYPE_MACHINE,
> > +    .class_init = xenpvh_machine_class_init,
> > +    .instance_init = xenpvh_instance_init,
> > +    .instance_size = sizeof(XenPVHx86State),
> > +};
> > +
> > +static void xenpvh_machine_register_types(void)
> > +{
> > +    type_register_static(&xenpvh_machine_type);
> > +}
> > +
> > +type_init(xenpvh_machine_register_types)
> > -- 
> > 2.43.0
> > 

