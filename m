Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB090D70DE6
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 16:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGhPw-0005b8-KR; Thu, 28 Nov 2024 11:31:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tGhPp-0005Yv-Pr
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 11:30:54 -0500
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tGhPm-0006VA-50
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 11:30:53 -0500
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5f2164a68bbso365819eaf.0
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 08:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1732811448; x=1733416248;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H5E+2OekUNh5ED6S/qIPSiK5trzjwB63T20ZStNDfSc=;
 b=e87v0UM6FwNZldcYKv9R/Q4l/Lu5hNknl80oAihOx7r4vIaCC9Y/FQwIuC6hOFS8Gp
 MH2yd6KTYgyqBHy/kFwE5tmE3VXWW4hE9aLiP2+jhj51OpdwnfjSozqrZu24dO7xLPk4
 EfE6AiU7QrH7JE8ytFQjfsqhh5zjaUFlnBLg9T2JeeSqeUfcdwtPgO53+vqyRfAq1uwX
 TBUDyO1jMxBVszt2P7R1SAqEHwBvvwbBxjobvf1Q8SSWQj5sKU5pKKXMUQ4/JW0jKDdt
 w23VuFc8vP67wXJa3TFi+2hfhVxlJF+aCeU9T0FUMtzr3hG4E+XlBiquSB8NtktMrEbm
 tRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732811448; x=1733416248;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H5E+2OekUNh5ED6S/qIPSiK5trzjwB63T20ZStNDfSc=;
 b=QZrenHJpMbAgadw+Kqtplr0ZyWHvtP02ZMwPahQT9fJ7Skn80dcDNjWKRey3/mtRlt
 TEugtXgnbXctQi5HNgVGlrg0fWVtXGbpCiBViN9oXrlo9hYBW3kOY1/MK7xP32YmKSuN
 bf2WY73A+4oCJIWMtqRWYzMb3rTCRBBNSmfxmhGTVk3HRT/2lq9n/X19TTVw5uVWesg0
 SpYXnWSJpY6+m31/uaAgge80k7stMqDE1DbXv4KLkXjRjGzO/yjzZrGtFFnKfvqYIJFs
 GdJVVhju6ISjxeGNK2BK52rRuTT4U5bFCmALbma/T9/InF4Ob0jEuN95s9F4e9JNYASr
 QGrQ==
X-Gm-Message-State: AOJu0YyELrOt1ceixyjauKT4gIRqTTUGrdU+RNp0Qa33AfR53ufy+XlM
 XtEzERJCZhjhr9bSfxS5/tAUK9l2KifP/CEhXDSfVAZoWkl6HcEjmT9JDo5Icf0qEPJ6E6Eux8V
 O8cGrslSC4VJKFABXeTwvevzJVQzsTbhFWFYk
X-Gm-Gg: ASbGncsSmOI/criWDyvdFtaL0G24/CQJB7GUljnDLm2wWy2i7BM7I3EUDnjQQX3rc7D
 1ENL5pcP99KZeJSwtWoE/4UCoENuO6Jk=
X-Google-Smtp-Source: AGHT+IG6wyxiERCQP/r0Wp/gUtE15pTqxwh8mTn6CNo0ZdkE5uLSap3uYQmINp5MEnfnTMXYrDiRFqDzBR06TZ+vGtg=
X-Received: by 2002:a05:6359:5ccb:b0:1ca:c929:6a61 with SMTP id
 e5c5f4694b2df-1cac9296c50mr33294555d.19.1732811448150; Thu, 28 Nov 2024
 08:30:48 -0800 (PST)
MIME-Version: 1.0
References: <20241127150249.50767-1-phil@philjordan.eu>
 <20241127150249.50767-10-phil@philjordan.eu>
 <93840da2-a582-40b2-8c87-ed0ed349a7b7@daynix.com>
In-Reply-To: <93840da2-a582-40b2-8c87-ed0ed349a7b7@daynix.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Thu, 28 Nov 2024 17:30:37 +0100
Message-ID: <CAAibmn1+KdhJ1DbgZ-y7MsORvLHGOx2TK-6_+7fXvPCnn3TUTQ@mail.gmail.com>
Subject: Re: [PATCH v11 09/15] gpex: Allow more than 4 legacy IRQs
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org, 
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com, 
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com, 
 richard.henderson@linaro.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com, 
 gaosong@loongson.cn, jiaxun.yang@flygoat.com, chenhuacai@kernel.org, 
 kwolf@redhat.com, hreitz@redhat.com, philmd@linaro.org, shorne@gmail.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com, 
 qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org, 
 balaton@eik.bme.hu, Alexander Graf <graf@amazon.com>
Content-Type: multipart/alternative; boundary="000000000000d494fa0627fb9ac8"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=phil@philjordan.eu; helo=mail-oo1-xc2e.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--000000000000d494fa0627fb9ac8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 28 Nov 2024 at 13:45, Akihiko Odaki <akihiko.odaki@daynix.com>
wrote:

> On 2024/11/28 0:02, Phil Dennis-Jordan wrote:
> > From: Alexander Graf <graf@amazon.com>
> >
> > Some boards such as vmapple don't do real legacy PCI IRQ swizzling.
> > Instead, they just keep allocating more board IRQ lines for each new
> > legacy IRQ. Let's support that mode by giving instantiators a new
> > "nr_irqs" property they can use to support more than 4 legacy IRQ lines=
.
> > In this mode, GPEX will export more IRQ lines, one for each device.
> >
> > Signed-off-by: Alexander Graf <graf@amazon.com>
> > Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> > Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>> --->
> > v4:
> >
> >   * Turned pair of IRQ arrays into array of structs.
> >   * Simplified swizzling logic selection.
> >
> >   hw/arm/sbsa-ref.c          |  2 +-
> >   hw/arm/virt.c              |  2 +-
> >   hw/i386/microvm.c          |  2 +-
> >   hw/loongarch/virt.c        |  2 +-
> >   hw/mips/loongson3_virt.c   |  2 +-
> >   hw/openrisc/virt.c         | 12 +++++------
> >   hw/pci-host/gpex.c         | 43 ++++++++++++++++++++++++++++++-------=
-
> >   hw/riscv/virt.c            | 12 +++++------
> >   hw/xtensa/virt.c           |  2 +-
> >   include/hw/pci-host/gpex.h |  7 +++----
> >   10 files changed, 55 insertions(+), 31 deletions(-)
> >
> > diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> > index e3195d54497..7e7322486c2 100644
> > --- a/hw/arm/sbsa-ref.c
> > +++ b/hw/arm/sbsa-ref.c
> > @@ -673,7 +673,7 @@ static void create_pcie(SBSAMachineState *sms)
> >       /* Map IO port space */
> >       sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, base_pio);
> >
> > -    for (i =3D 0; i < GPEX_NUM_IRQS; i++) {
> > +    for (i =3D 0; i < PCI_NUM_PINS; i++) {
> >           sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
> >                              qdev_get_gpio_in(sms->gic, irq + i));
> >           gpex_set_irq_num(GPEX_HOST(dev), i, irq + i);
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index 1a381e9a2bd..8aa22ea3155 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -1547,7 +1547,7 @@ static void create_pcie(VirtMachineState *vms)
> >       /* Map IO port space */
> >       sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, base_pio);
> >
> > -    for (i =3D 0; i < GPEX_NUM_IRQS; i++) {
> > +    for (i =3D 0; i < PCI_NUM_PINS; i++) {
> >           sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
> >                              qdev_get_gpio_in(vms->gic, irq + i));
> >           gpex_set_irq_num(GPEX_HOST(dev), i, irq + i);
> > diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> > index 86637afa0f3..ce80596c239 100644
> > --- a/hw/i386/microvm.c
> > +++ b/hw/i386/microvm.c
> > @@ -139,7 +139,7 @@ static void create_gpex(MicrovmMachineState *mms)
> >                                       mms->gpex.mmio64.base,
> mmio64_alias);
> >       }
> >
> > -    for (i =3D 0; i < GPEX_NUM_IRQS; i++) {
> > +    for (i =3D 0; i < PCI_NUM_PINS; i++) {
> >           sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
> >                              x86ms->gsi[mms->gpex.irq + i]);
> >       }
> > diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> > index 9a635d1d3d3..50056384994 100644
> > --- a/hw/loongarch/virt.c
> > +++ b/hw/loongarch/virt.c
> > @@ -741,7 +741,7 @@ static void virt_devices_init(DeviceState *pch_pic,
> >       memory_region_add_subregion(get_system_memory(), VIRT_PCI_IO_BASE=
,
> >                                   pio_alias);
> >
> > -    for (i =3D 0; i < GPEX_NUM_IRQS; i++) {
> > +    for (i =3D 0; i < PCI_NUM_PINS; i++) {
> >           sysbus_connect_irq(d, i,
> >                              qdev_get_gpio_in(pch_pic, 16 + i));
> >           gpex_set_irq_num(GPEX_HOST(gpex_dev), i, 16 + i);
> > diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
> > index f3b6326cc59..884b5f23a99 100644
> > --- a/hw/mips/loongson3_virt.c
> > +++ b/hw/mips/loongson3_virt.c
> > @@ -458,7 +458,7 @@ static inline void
> loongson3_virt_devices_init(MachineState *machine,
> >                                   virt_memmap[VIRT_PCIE_PIO].base,
> s->pio_alias);
> >       sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2,
> virt_memmap[VIRT_PCIE_PIO].base);
> >
> > -    for (i =3D 0; i < GPEX_NUM_IRQS; i++) {
> > +    for (i =3D 0; i < PCI_NUM_PINS; i++) {
> >           irq =3D qdev_get_gpio_in(pic, PCIE_IRQ_BASE + i);
> >           sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, irq);
> >           gpex_set_irq_num(GPEX_HOST(dev), i, PCIE_IRQ_BASE + i);
> > diff --git a/hw/openrisc/virt.c b/hw/openrisc/virt.c
> > index 47d2c9bd3c7..6f053bf48e0 100644
> > --- a/hw/openrisc/virt.c
> > +++ b/hw/openrisc/virt.c
> > @@ -318,7 +318,7 @@ static void create_pcie_irq_map(void *fdt, char
> *nodename, int irq_base,
> >   {
> >       int pin, dev;
> >       uint32_t irq_map_stride =3D 0;
> > -    uint32_t full_irq_map[GPEX_NUM_IRQS * GPEX_NUM_IRQS * 6] =3D {};
> > +    uint32_t full_irq_map[PCI_NUM_PINS * PCI_NUM_PINS * 6] =3D {};
> >       uint32_t *irq_map =3D full_irq_map;
> >
> >       /*
> > @@ -330,11 +330,11 @@ static void create_pcie_irq_map(void *fdt, char
> *nodename, int irq_base,
> >        * possible slot) seeing the interrupt-map-mask will allow the
> table
> >        * to wrap to any number of devices.
> >        */
> > -    for (dev =3D 0; dev < GPEX_NUM_IRQS; dev++) {
> > +    for (dev =3D 0; dev < PCI_NUM_PINS; dev++) {
> >           int devfn =3D dev << 3;
> >
> > -        for (pin =3D 0; pin < GPEX_NUM_IRQS; pin++) {
> > -            int irq_nr =3D irq_base + ((pin + PCI_SLOT(devfn)) %
> GPEX_NUM_IRQS);
> > +        for (pin =3D 0; pin < PCI_NUM_PINS; pin++) {
> > +            int irq_nr =3D irq_base + ((pin + PCI_SLOT(devfn)) %
> PCI_NUM_PINS);
> >               int i =3D 0;
> >
> >               /* Fill PCI address cells */
> > @@ -357,7 +357,7 @@ static void create_pcie_irq_map(void *fdt, char
> *nodename, int irq_base,
> >       }
> >
> >       qemu_fdt_setprop(fdt, nodename, "interrupt-map", full_irq_map,
> > -                     GPEX_NUM_IRQS * GPEX_NUM_IRQS *
> > +                     PCI_NUM_PINS * PCI_NUM_PINS *
> >                        irq_map_stride * sizeof(uint32_t));
> >
> >       qemu_fdt_setprop_cells(fdt, nodename, "interrupt-map-mask",
> > @@ -409,7 +409,7 @@ static void openrisc_virt_pcie_init(OR1KVirtState
> *state,
> >       memory_region_add_subregion(get_system_memory(), pio_base, alias)=
;
> >
> >       /* Connect IRQ lines. */
> > -    for (i =3D 0; i < GPEX_NUM_IRQS; i++) {
> > +    for (i =3D 0; i < PCI_NUM_PINS; i++) {
> >           pcie_irq =3D get_per_cpu_irq(cpus, num_cpus, irq_base + i);
> >
> >           sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, pcie_irq);
> > diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
> > index e9cf455bf52..cd63aa2d3cf 100644
> > --- a/hw/pci-host/gpex.c
> > +++ b/hw/pci-host/gpex.c
> > @@ -32,6 +32,7 @@
> >   #include "qemu/osdep.h"
> >   #include "qapi/error.h"
> >   #include "hw/irq.h"
> > +#include "hw/pci/pci_bus.h"
> >   #include "hw/pci-host/gpex.h"
> >   #include "hw/qdev-properties.h"
> >   #include "migration/vmstate.h"
> > @@ -41,20 +42,25 @@
> >    * GPEX host
> >    */
> >
> > +struct GPEXIrq {
> > +    qemu_irq irq;
> > +    int irq_num;
> > +};
> > +
> >   static void gpex_set_irq(void *opaque, int irq_num, int level)
> >   {
> >       GPEXHost *s =3D opaque;
> >
> > -    qemu_set_irq(s->irq[irq_num], level);
> > +    qemu_set_irq(s->irq[irq_num].irq, level);
> >   }
> >
> >   int gpex_set_irq_num(GPEXHost *s, int index, int gsi)
> >   {
> > -    if (index >=3D GPEX_NUM_IRQS) {
> > +    if (index >=3D s->num_irqs) {
> >           return -EINVAL;
> >       }
> >
> > -    s->irq_num[index] =3D gsi;
> > +    s->irq[index].irq_num =3D gsi;
> >       return 0;
> >   }
> >
> > @@ -62,7 +68,7 @@ static PCIINTxRoute gpex_route_intx_pin_to_irq(void
> *opaque, int pin)
> >   {
> >       PCIINTxRoute route;
> >       GPEXHost *s =3D opaque;
> > -    int gsi =3D s->irq_num[pin];
> > +    int gsi =3D s->irq[pin].irq_num;
> >
> >       route.irq =3D gsi;
> >       if (gsi < 0) {
> > @@ -74,6 +80,13 @@ static PCIINTxRoute gpex_route_intx_pin_to_irq(void
> *opaque, int pin)
> >       return route;
> >   }
> >
> > +static int gpex_swizzle_map_irq_fn(PCIDevice *pci_dev, int pin)
> > +{
> > +    PCIBus *bus =3D pci_device_root_bus(pci_dev);
> > +
> > +    return (PCI_SLOT(pci_dev->devfn) + pin) % bus->nirq;
> > +}
> > +
> >   static void gpex_host_realize(DeviceState *dev, Error **errp)
> >   {
> >       PCIHostState *pci =3D PCI_HOST_BRIDGE(dev);
> > @@ -82,6 +95,8 @@ static void gpex_host_realize(DeviceState *dev, Error
> **errp)
> >       PCIExpressHost *pex =3D PCIE_HOST_BRIDGE(dev);
> >       int i;
> >
> > +    s->irq =3D g_malloc0_n(s->num_irqs, sizeof(*s->irq));
> > +
> >       pcie_host_mmcfg_init(pex, PCIE_MMCFG_SIZE_MAX);
> >       sysbus_init_mmio(sbd, &pex->mmio);
> >
> > @@ -128,19 +143,27 @@ static void gpex_host_realize(DeviceState *dev,
> Error **errp)
> >           sysbus_init_mmio(sbd, &s->io_ioport);
> >       }
> >
> > -    for (i =3D 0; i < GPEX_NUM_IRQS; i++) {
> > -        sysbus_init_irq(sbd, &s->irq[i]);
> > -        s->irq_num[i] =3D -1;
> > +    for (i =3D 0; i < s->num_irqs; i++) {
> > +        sysbus_init_irq(sbd, &s->irq[i].irq);
> > +        s->irq[i].irq_num =3D -1;
> >       }
> >
> >       pci->bus =3D pci_register_root_bus(dev, "pcie.0", gpex_set_irq,
> > -                                     pci_swizzle_map_irq_fn, s,
> &s->io_mmio,
> > -                                     &s->io_ioport, 0, 4,
> TYPE_PCIE_BUS);
> > +                                     gpex_swizzle_map_irq_fn,
> > +                                     s, &s->io_mmio, &s->io_ioport, 0,
> > +                                     s->num_irqs, TYPE_PCIE_BUS);
> >
> >       pci_bus_set_route_irq_fn(pci->bus, gpex_route_intx_pin_to_irq);
> >       qdev_realize(DEVICE(&s->gpex_root), BUS(pci->bus), &error_fatal);
> >   }
> >
> > +static void gpex_host_unrealize(DeviceState *dev)
> > +{
> > +    GPEXHost *s =3D GPEX_HOST(dev);
> > +
> > +    g_free(s->irq);
> > +}
> > +
> >   static const char *gpex_host_root_bus_path(PCIHostState *host_bridge,
> >                                             PCIBus *rootbus)
> >   {
> > @@ -166,6 +189,7 @@ static Property gpex_host_properties[] =3D {
> >                          gpex_cfg.mmio64.base, 0),
> >       DEFINE_PROP_SIZE(PCI_HOST_ABOVE_4G_MMIO_SIZE, GPEXHost,
> >                        gpex_cfg.mmio64.size, 0),
> > +    DEFINE_PROP_UINT8("num-irqs", GPEXHost, num_irqs, PCI_NUM_PINS),
> >       DEFINE_PROP_END_OF_LIST(),
> >   };
> >
> > @@ -176,6 +200,7 @@ static void gpex_host_class_init(ObjectClass *klass=
,
> void *data)
> >
> >       hc->root_bus_path =3D gpex_host_root_bus_path;
> >       dc->realize =3D gpex_host_realize;
> > +    dc->unrealize =3D gpex_host_unrealize;
> >       set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> >       dc->fw_name =3D "pci";
> >       device_class_set_props(dc, gpex_host_properties);
> > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> > index 45a8c4f8190..567fe92a136 100644
> > --- a/hw/riscv/virt.c
> > +++ b/hw/riscv/virt.c
> > @@ -168,7 +168,7 @@ static void create_pcie_irq_map(RISCVVirtState *s,
> void *fdt, char *nodename,
> >   {
> >       int pin, dev;
> >       uint32_t irq_map_stride =3D 0;
> > -    uint32_t full_irq_map[GPEX_NUM_IRQS * GPEX_NUM_IRQS *
> > +    uint32_t full_irq_map[PCI_NUM_PINS * PCI_NUM_PINS *
> >                             FDT_MAX_INT_MAP_WIDTH] =3D {};
> >       uint32_t *irq_map =3D full_irq_map;
> >
> > @@ -180,11 +180,11 @@ static void create_pcie_irq_map(RISCVVirtState *s=
,
> void *fdt, char *nodename,
> >        * possible slot) seeing the interrupt-map-mask will allow the
> table
> >        * to wrap to any number of devices.
> >        */
> > -    for (dev =3D 0; dev < GPEX_NUM_IRQS; dev++) {
> > +    for (dev =3D 0; dev < PCI_NUM_PINS; dev++) {
> >           int devfn =3D dev * 0x8;
> >
> > -        for (pin =3D 0; pin < GPEX_NUM_IRQS; pin++) {
> > -            int irq_nr =3D PCIE_IRQ + ((pin + PCI_SLOT(devfn)) %
> GPEX_NUM_IRQS);
> > +        for (pin =3D 0; pin < PCI_NUM_PINS; pin++) {
> > +            int irq_nr =3D PCIE_IRQ + ((pin + PCI_SLOT(devfn)) %
> PCI_NUM_PINS);
> >               int i =3D 0;
> >
> >               /* Fill PCI address cells */
> > @@ -210,7 +210,7 @@ static void create_pcie_irq_map(RISCVVirtState *s,
> void *fdt, char *nodename,
> >       }
> >
> >       qemu_fdt_setprop(fdt, nodename, "interrupt-map", full_irq_map,
> > -                     GPEX_NUM_IRQS * GPEX_NUM_IRQS *
> > +                     PCI_NUM_PINS * PCI_NUM_PINS *
> >                        irq_map_stride * sizeof(uint32_t));
> >
> >       qemu_fdt_setprop_cells(fdt, nodename, "interrupt-map-mask",
> > @@ -1182,7 +1182,7 @@ static inline DeviceState
> *gpex_pcie_init(MemoryRegion *sys_mem,
> >
> >       sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, pio_base);
> >
> > -    for (i =3D 0; i < GPEX_NUM_IRQS; i++) {
> > +    for (i =3D 0; i < PCI_NUM_PINS; i++) {
> >           irq =3D qdev_get_gpio_in(irqchip, PCIE_IRQ + i);
> >
> >           sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, irq);
> > diff --git a/hw/xtensa/virt.c b/hw/xtensa/virt.c
> > index 5310a888613..8f5c2009d29 100644
> > --- a/hw/xtensa/virt.c
> > +++ b/hw/xtensa/virt.c
> > @@ -93,7 +93,7 @@ static void create_pcie(MachineState *ms,
> CPUXtensaState *env, int irq_base,
> >       /* Connect IRQ lines. */
> >       extints =3D xtensa_get_extints(env);
> >
> > -    for (i =3D 0; i < GPEX_NUM_IRQS; i++) {
> > +    for (i =3D 0; i < PCI_NUM_PINS; i++) {
> >           void *q =3D extints[irq_base + i];
> >
> >           sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, q);
> > diff --git a/include/hw/pci-host/gpex.h b/include/hw/pci-host/gpex.h
> > index dce883573ba..84471533af0 100644
> > --- a/include/hw/pci-host/gpex.h
> > +++ b/include/hw/pci-host/gpex.h
> > @@ -32,8 +32,6 @@ OBJECT_DECLARE_SIMPLE_TYPE(GPEXHost, GPEX_HOST)
> >   #define TYPE_GPEX_ROOT_DEVICE "gpex-root"
> >   OBJECT_DECLARE_SIMPLE_TYPE(GPEXRootState, GPEX_ROOT_DEVICE)
> >
> > -#define GPEX_NUM_IRQS 4
>
> I found some references to GPEX_NUM_IRQS still remain:
>
> $ git grep GPEX_NUM_IRQS
> hw/loongarch/virt.c:    uint32_t full_irq_map[GPEX_NUM_IRQS
> *GPEX_NUM_IRQS * 10] =3D {};
> hw/loongarch/virt.c:    for (dev =3D 0; dev < GPEX_NUM_IRQS; dev++) {
> hw/loongarch/virt.c:        for (pin =3D 0; pin  < GPEX_NUM_IRQS; pin++) =
{
> hw/loongarch/virt.c:            int irq_nr =3D 16 + ((pin +
> PCI_SLOT(devfn)) % GPEX_NUM_IRQS);
> hw/loongarch/virt.c:                     GPEX_NUM_IRQS * GPEX_NUM_IRQS *
> hw/vmapple/vmapple.c:#define GPEX_NUM_IRQS 16
> hw/vmapple/vmapple.c:    qdev_prop_set_uint32(dev, "num-irqs",
> GPEX_NUM_IRQS);
> hw/vmapple/vmapple.c:    for (i =3D 0; i < GPEX_NUM_IRQS; i++) {
> hw/xen/xen-pvh-common.c:    for (i =3D 0; i < GPEX_NUM_IRQS; i++) {
>
>
Good catch! These were added to the code base long after v1 of the patch
was posted=E2=80=A6
It looks like all of these are safe to replace with PCI_NUM_PINS. (Except
the ones in vmapple.c, which #defines its own local value and is
intentional.)


> > -
> >   struct GPEXRootState {
> >       /*< private >*/
> >       PCIDevice parent_obj;
> > @@ -49,6 +47,7 @@ struct GPEXConfig {
> >       PCIBus      *bus;
> >   };
> >
> > +typedef struct GPEXIrq GPEXIrq;
> >   struct GPEXHost {
> >       /*< private >*/
> >       PCIExpressHost parent_obj;
> > @@ -60,8 +59,8 @@ struct GPEXHost {
> >       MemoryRegion io_mmio;
> >       MemoryRegion io_ioport_window;
> >       MemoryRegion io_mmio_window;
> > -    qemu_irq irq[GPEX_NUM_IRQS];
> > -    int irq_num[GPEX_NUM_IRQS];
> > +    GPEXIrq *irq;
> > +    uint8_t num_irqs;
> >
> >       bool allow_unmapped_accesses;
> >
>
>

--000000000000d494fa0627fb9ac8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, 28 Nov 2024 at 13:45, Akihiko=
 Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko.odaki@daynix=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">On 2024/11/28 0:02, Phil Dennis-Jordan wrote:<br>
&gt; From: Alexander Graf &lt;<a href=3D"mailto:graf@amazon.com" target=3D"=
_blank">graf@amazon.com</a>&gt;<br>
&gt; <br>
&gt; Some boards such as vmapple don&#39;t do real legacy PCI IRQ swizzling=
.<br>
&gt; Instead, they just keep allocating more board IRQ lines for each new<b=
r>
&gt; legacy IRQ. Let&#39;s support that mode by giving instantiators a new<=
br>
&gt; &quot;nr_irqs&quot; property they can use to support more than 4 legac=
y IRQ lines.<br>
&gt; In this mode, GPEX will export more IRQ lines, one for each device.<br=
>
&gt; <br>
&gt; Signed-off-by: Alexander Graf &lt;<a href=3D"mailto:graf@amazon.com" t=
arget=3D"_blank">graf@amazon.com</a>&gt;<br>
&gt; Signed-off-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjorda=
n.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
&gt; Reviewed-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.=
com" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;&gt; ---&gt;<br>
&gt; v4:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* Turned pair of IRQ arrays into array of structs.<br>
&gt;=C2=A0 =C2=A0* Simplified swizzling logic selection.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0hw/arm/sbsa-ref.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 2 +-<br>
&gt;=C2=A0 =C2=A0hw/arm/virt.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 2 +-<br>
&gt;=C2=A0 =C2=A0hw/i386/microvm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 2 +-<br>
&gt;=C2=A0 =C2=A0hw/loongarch/virt.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +=
-<br>
&gt;=C2=A0 =C2=A0hw/mips/loongson3_virt.c=C2=A0 =C2=A0|=C2=A0 2 +-<br>
&gt;=C2=A0 =C2=A0hw/openrisc/virt.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 12 +=
++++------<br>
&gt;=C2=A0 =C2=A0hw/pci-host/gpex.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 43 +=
+++++++++++++++++++++++++++++--------<br>
&gt;=C2=A0 =C2=A0hw/riscv/virt.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
 12 +++++------<br>
&gt;=C2=A0 =C2=A0hw/xtensa/virt.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 2 +-<br>
&gt;=C2=A0 =C2=A0include/hw/pci-host/gpex.h |=C2=A0 7 +++----<br>
&gt;=C2=A0 =C2=A010 files changed, 55 insertions(+), 31 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c<br>
&gt; index e3195d54497..7e7322486c2 100644<br>
&gt; --- a/hw/arm/sbsa-ref.c<br>
&gt; +++ b/hw/arm/sbsa-ref.c<br>
&gt; @@ -673,7 +673,7 @@ static void create_pcie(SBSAMachineState *sms)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Map IO port space */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, base=
_pio);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 for (i =3D 0; i &lt; GPEX_NUM_IRQS; i++) {<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; PCI_NUM_PINS; i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_connect_irq(SYS_BUS_DEV=
ICE(dev), i,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(sms-&gt;gic, irq + i));=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gpex_set_irq_num(GPEX_HOST(dev=
), i, irq + i);<br>
&gt; diff --git a/hw/arm/virt.c b/hw/arm/virt.c<br>
&gt; index 1a381e9a2bd..8aa22ea3155 100644<br>
&gt; --- a/hw/arm/virt.c<br>
&gt; +++ b/hw/arm/virt.c<br>
&gt; @@ -1547,7 +1547,7 @@ static void create_pcie(VirtMachineState *vms)<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Map IO port space */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, base=
_pio);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 for (i =3D 0; i &lt; GPEX_NUM_IRQS; i++) {<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; PCI_NUM_PINS; i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_connect_irq(SYS_BUS_DEV=
ICE(dev), i,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(vms-&gt;gic, irq + i));=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gpex_set_irq_num(GPEX_HOST(dev=
), i, irq + i);<br>
&gt; diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c<br>
&gt; index 86637afa0f3..ce80596c239 100644<br>
&gt; --- a/hw/i386/microvm.c<br>
&gt; +++ b/hw/i386/microvm.c<br>
&gt; @@ -139,7 +139,7 @@ static void create_gpex(MicrovmMachineState *mms)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mms-&g=
t;gpex.mmio64.base, mmio64_alias);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 for (i =3D 0; i &lt; GPEX_NUM_IRQS; i++) {<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; PCI_NUM_PINS; i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_connect_irq(SYS_BUS_DEV=
ICE(dev), i,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 x86ms-&gt;gsi[mms-&gt;gpex.irq + i]);<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c<br>
&gt; index 9a635d1d3d3..50056384994 100644<br>
&gt; --- a/hw/loongarch/virt.c<br>
&gt; +++ b/hw/loongarch/virt.c<br>
&gt; @@ -741,7 +741,7 @@ static void virt_devices_init(DeviceState *pch_pic=
,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0memory_region_add_subregion(get_system_memor=
y(), VIRT_PCI_IO_BASE,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pio_alias);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 for (i =3D 0; i &lt; GPEX_NUM_IRQS; i++) {<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; PCI_NUM_PINS; i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_connect_irq(d, i,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(pch_pic, 16 + i));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gpex_set_irq_num(GPEX_HOST(gpe=
x_dev), i, 16 + i);<br>
&gt; diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c<br>
&gt; index f3b6326cc59..884b5f23a99 100644<br>
&gt; --- a/hw/mips/loongson3_virt.c<br>
&gt; +++ b/hw/mips/loongson3_virt.c<br>
&gt; @@ -458,7 +458,7 @@ static inline void loongson3_virt_devices_init(Mac=
hineState *machine,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virt_memmap[VIRT_PCI=
E_PIO].base, s-&gt;pio_alias);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, virt=
_memmap[VIRT_PCIE_PIO].base);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 for (i =3D 0; i &lt; GPEX_NUM_IRQS; i++) {<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; PCI_NUM_PINS; i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0irq =3D qdev_get_gpio_in(pic, =
PCIE_IRQ_BASE + i);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_connect_irq(SYS_BUS_DEV=
ICE(dev), i, irq);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gpex_set_irq_num(GPEX_HOST(dev=
), i, PCIE_IRQ_BASE + i);<br>
&gt; diff --git a/hw/openrisc/virt.c b/hw/openrisc/virt.c<br>
&gt; index 47d2c9bd3c7..6f053bf48e0 100644<br>
&gt; --- a/hw/openrisc/virt.c<br>
&gt; +++ b/hw/openrisc/virt.c<br>
&gt; @@ -318,7 +318,7 @@ static void create_pcie_irq_map(void *fdt, char *n=
odename, int irq_base,<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int pin, dev;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t irq_map_stride =3D 0;<br>
&gt; -=C2=A0 =C2=A0 uint32_t full_irq_map[GPEX_NUM_IRQS * GPEX_NUM_IRQS * 6=
] =3D {};<br>
&gt; +=C2=A0 =C2=A0 uint32_t full_irq_map[PCI_NUM_PINS * PCI_NUM_PINS * 6] =
=3D {};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t *irq_map =3D full_irq_map;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; @@ -330,11 +330,11 @@ static void create_pcie_irq_map(void *fdt, char =
*nodename, int irq_base,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * possible slot) seeing the interrupt-map-m=
ask will allow the table<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * to wrap to any number of devices.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; -=C2=A0 =C2=A0 for (dev =3D 0; dev &lt; GPEX_NUM_IRQS; dev++) {<br>
&gt; +=C2=A0 =C2=A0 for (dev =3D 0; dev &lt; PCI_NUM_PINS; dev++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int devfn =3D dev &lt;&lt; 3;<=
br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (pin =3D 0; pin &lt; GPEX_NUM_IRQS; p=
in++) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int irq_nr =3D irq_base + (=
(pin + PCI_SLOT(devfn)) % GPEX_NUM_IRQS);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (pin =3D 0; pin &lt; PCI_NUM_PINS; pi=
n++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int irq_nr =3D irq_base + (=
(pin + PCI_SLOT(devfn)) % PCI_NUM_PINS);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int i =3D 0;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Fill PCI addr=
ess cells */<br>
&gt; @@ -357,7 +357,7 @@ static void create_pcie_irq_map(void *fdt, char *n=
odename, int irq_base,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_fdt_setprop(fdt, nodename, &quot;interr=
upt-map&quot;, full_irq_map,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0GPEX_NUM_IRQS * GPEX_NUM_IRQS *<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0PCI_NUM_PINS * PCI_NUM_PINS *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 irq_map_stride * sizeof(uint32_t));<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_fdt_setprop_cells(fdt, nodename, &quot;=
interrupt-map-mask&quot;,<br>
&gt; @@ -409,7 +409,7 @@ static void openrisc_virt_pcie_init(OR1KVirtState =
*state,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0memory_region_add_subregion(get_system_memor=
y(), pio_base, alias);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Connect IRQ lines. */<br>
&gt; -=C2=A0 =C2=A0 for (i =3D 0; i &lt; GPEX_NUM_IRQS; i++) {<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; PCI_NUM_PINS; i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pcie_irq =3D get_per_cpu_irq(c=
pus, num_cpus, irq_base + i);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_connect_irq(SYS_BUS_DEV=
ICE(dev), i, pcie_irq);<br>
&gt; diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c<br>
&gt; index e9cf455bf52..cd63aa2d3cf 100644<br>
&gt; --- a/hw/pci-host/gpex.c<br>
&gt; +++ b/hw/pci-host/gpex.c<br>
&gt; @@ -32,6 +32,7 @@<br>
&gt;=C2=A0 =C2=A0#include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;qapi/error.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/irq.h&quot;<br>
&gt; +#include &quot;hw/pci/pci_bus.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/pci-host/gpex.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;migration/vmstate.h&quot;<br>
&gt; @@ -41,20 +42,25 @@<br>
&gt;=C2=A0 =C2=A0 * GPEX host<br>
&gt;=C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +struct GPEXIrq {<br>
&gt; +=C2=A0 =C2=A0 qemu_irq irq;<br>
&gt; +=C2=A0 =C2=A0 int irq_num;<br>
&gt; +};<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0static void gpex_set_irq(void *opaque, int irq_num, int le=
vel)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0GPEXHost *s =3D opaque;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 qemu_set_irq(s-&gt;irq[irq_num], level);<br>
&gt; +=C2=A0 =C2=A0 qemu_set_irq(s-&gt;irq[irq_num].irq, level);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0int gpex_set_irq_num(GPEXHost *s, int index, int gsi)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; -=C2=A0 =C2=A0 if (index &gt;=3D GPEX_NUM_IRQS) {<br>
&gt; +=C2=A0 =C2=A0 if (index &gt;=3D s-&gt;num_irqs) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 s-&gt;irq_num[index] =3D gsi;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;irq[index].irq_num =3D gsi;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -62,7 +68,7 @@ static PCIINTxRoute gpex_route_intx_pin_to_irq(void =
*opaque, int pin)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0PCIINTxRoute route;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0GPEXHost *s =3D opaque;<br>
&gt; -=C2=A0 =C2=A0 int gsi =3D s-&gt;irq_num[pin];<br>
&gt; +=C2=A0 =C2=A0 int gsi =3D s-&gt;irq[pin].irq_num;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0route.irq =3D gsi;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (gsi &lt; 0) {<br>
&gt; @@ -74,6 +80,13 @@ static PCIINTxRoute gpex_route_intx_pin_to_irq(void=
 *opaque, int pin)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return route;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +static int gpex_swizzle_map_irq_fn(PCIDevice *pci_dev, int pin)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 PCIBus *bus =3D pci_device_root_bus(pci_dev);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return (PCI_SLOT(pci_dev-&gt;devfn) + pin) % bus-&gt;ni=
rq;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0static void gpex_host_realize(DeviceState *dev, Error **er=
rp)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0PCIHostState *pci =3D PCI_HOST_BRIDGE(dev);<=
br>
&gt; @@ -82,6 +95,8 @@ static void gpex_host_realize(DeviceState *dev, Erro=
r **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0PCIExpressHost *pex =3D PCIE_HOST_BRIDGE(dev=
);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 s-&gt;irq =3D g_malloc0_n(s-&gt;num_irqs, sizeof(*s-&gt=
;irq));<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pcie_host_mmcfg_init(pex, PCIE_MMCFG_SIZE_MA=
X);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_init_mmio(sbd, &amp;pex-&gt;mmio);<br=
>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -128,19 +143,27 @@ static void gpex_host_realize(DeviceState *dev, =
Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_init_mmio(sbd, &amp;s-&=
gt;io_ioport);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 for (i =3D 0; i &lt; GPEX_NUM_IRQS; i++) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_init_irq(sbd, &amp;s-&gt;irq[i]);<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;irq_num[i] =3D -1;<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; s-&gt;num_irqs; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_init_irq(sbd, &amp;s-&gt;irq[i].ir=
q);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;irq[i].irq_num =3D -1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pci-&gt;bus =3D pci_register_root_bus(dev, &=
quot;pcie.0&quot;, gpex_set_irq,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_swizzle_=
map_irq_fn, s, &amp;s-&gt;io_mmio,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;s-&gt;i=
o_ioport, 0, 4, TYPE_PCIE_BUS);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gpex_swizzle=
_map_irq_fn,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s, &amp;s-&g=
t;io_mmio, &amp;s-&gt;io_ioport, 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;num_ir=
qs, TYPE_PCIE_BUS);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pci_bus_set_route_irq_fn(pci-&gt;bus, gpex_r=
oute_intx_pin_to_irq);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_realize(DEVICE(&amp;s-&gt;gpex_root), B=
US(pci-&gt;bus), &amp;error_fatal);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +static void gpex_host_unrealize(DeviceState *dev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 GPEXHost *s =3D GPEX_HOST(dev);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 g_free(s-&gt;irq);<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0static const char *gpex_host_root_bus_path(PCIHostState *h=
ost_bridge,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0PCIBus *rootbus)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; @@ -166,6 +189,7 @@ static Property gpex_host_properties[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 gpex_cfg.mmio64.base, 0),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DEFINE_PROP_SIZE(PCI_HOST_ABOVE_4G_MMIO_SIZE=
, GPEXHost,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 gpex_cfg.mmio64.size, 0),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_UINT8(&quot;num-irqs&quot;, GPEXHost, num_i=
rqs, PCI_NUM_PINS),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DEFINE_PROP_END_OF_LIST(),<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -176,6 +200,7 @@ static void gpex_host_class_init(ObjectClass *klas=
s, void *data)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hc-&gt;root_bus_path =3D gpex_host_root_bus_=
path;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0dc-&gt;realize =3D gpex_host_realize;<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;unrealize =3D gpex_host_unrealize;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0set_bit(DEVICE_CATEGORY_BRIDGE, dc-&gt;categ=
ories);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0dc-&gt;fw_name =3D &quot;pci&quot;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0device_class_set_props(dc, gpex_host_propert=
ies);<br>
&gt; diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c<br>
&gt; index 45a8c4f8190..567fe92a136 100644<br>
&gt; --- a/hw/riscv/virt.c<br>
&gt; +++ b/hw/riscv/virt.c<br>
&gt; @@ -168,7 +168,7 @@ static void create_pcie_irq_map(RISCVVirtState *s,=
 void *fdt, char *nodename,<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int pin, dev;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t irq_map_stride =3D 0;<br>
&gt; -=C2=A0 =C2=A0 uint32_t full_irq_map[GPEX_NUM_IRQS * GPEX_NUM_IRQS *<b=
r>
&gt; +=C2=A0 =C2=A0 uint32_t full_irq_map[PCI_NUM_PINS * PCI_NUM_PINS *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FDT_MAX_INT_MAP_WIDTH] =3D {};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t *irq_map =3D full_irq_map;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -180,11 +180,11 @@ static void create_pcie_irq_map(RISCVVirtState *=
s, void *fdt, char *nodename,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * possible slot) seeing the interrupt-map-m=
ask will allow the table<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * to wrap to any number of devices.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; -=C2=A0 =C2=A0 for (dev =3D 0; dev &lt; GPEX_NUM_IRQS; dev++) {<br>
&gt; +=C2=A0 =C2=A0 for (dev =3D 0; dev &lt; PCI_NUM_PINS; dev++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int devfn =3D dev * 0x8;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (pin =3D 0; pin &lt; GPEX_NUM_IRQS; p=
in++) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int irq_nr =3D PCIE_IRQ + (=
(pin + PCI_SLOT(devfn)) % GPEX_NUM_IRQS);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (pin =3D 0; pin &lt; PCI_NUM_PINS; pi=
n++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int irq_nr =3D PCIE_IRQ + (=
(pin + PCI_SLOT(devfn)) % PCI_NUM_PINS);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int i =3D 0;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Fill PCI addr=
ess cells */<br>
&gt; @@ -210,7 +210,7 @@ static void create_pcie_irq_map(RISCVVirtState *s,=
 void *fdt, char *nodename,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_fdt_setprop(fdt, nodename, &quot;interr=
upt-map&quot;, full_irq_map,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0GPEX_NUM_IRQS * GPEX_NUM_IRQS *<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0PCI_NUM_PINS * PCI_NUM_PINS *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 irq_map_stride * sizeof(uint32_t));<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_fdt_setprop_cells(fdt, nodename, &quot;=
interrupt-map-mask&quot;,<br>
&gt; @@ -1182,7 +1182,7 @@ static inline DeviceState *gpex_pcie_init(Memory=
Region *sys_mem,<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, pio_=
base);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 for (i =3D 0; i &lt; GPEX_NUM_IRQS; i++) {<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; PCI_NUM_PINS; i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0irq =3D qdev_get_gpio_in(irqch=
ip, PCIE_IRQ + i);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_connect_irq(SYS_BUS_DEV=
ICE(dev), i, irq);<br>
&gt; diff --git a/hw/xtensa/virt.c b/hw/xtensa/virt.c<br>
&gt; index 5310a888613..8f5c2009d29 100644<br>
&gt; --- a/hw/xtensa/virt.c<br>
&gt; +++ b/hw/xtensa/virt.c<br>
&gt; @@ -93,7 +93,7 @@ static void create_pcie(MachineState *ms, CPUXtensaS=
tate *env, int irq_base,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Connect IRQ lines. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0extints =3D xtensa_get_extints(env);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 for (i =3D 0; i &lt; GPEX_NUM_IRQS; i++) {<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; PCI_NUM_PINS; i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *q =3D extints[irq_base +=
 i];<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_connect_irq(SYS_BUS_DEV=
ICE(dev), i, q);<br>
&gt; diff --git a/include/hw/pci-host/gpex.h b/include/hw/pci-host/gpex.h<b=
r>
&gt; index dce883573ba..84471533af0 100644<br>
&gt; --- a/include/hw/pci-host/gpex.h<br>
&gt; +++ b/include/hw/pci-host/gpex.h<br>
&gt; @@ -32,8 +32,6 @@ OBJECT_DECLARE_SIMPLE_TYPE(GPEXHost, GPEX_HOST)<br>
&gt;=C2=A0 =C2=A0#define TYPE_GPEX_ROOT_DEVICE &quot;gpex-root&quot;<br>
&gt;=C2=A0 =C2=A0OBJECT_DECLARE_SIMPLE_TYPE(GPEXRootState, GPEX_ROOT_DEVICE=
)<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -#define GPEX_NUM_IRQS 4<br>
<br>
I found some references to GPEX_NUM_IRQS still remain:<br>
<br>
$ git grep GPEX_NUM_IRQS<br>
hw/loongarch/virt.c:=C2=A0 =C2=A0 uint32_t full_irq_map[GPEX_NUM_IRQS <br>
*GPEX_NUM_IRQS * 10] =3D {};<br>
hw/loongarch/virt.c:=C2=A0 =C2=A0 for (dev =3D 0; dev &lt; GPEX_NUM_IRQS; d=
ev++) {<br>
hw/loongarch/virt.c:=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (pin =3D 0; pin=C2=A0 &=
lt; GPEX_NUM_IRQS; pin++) {<br>
hw/loongarch/virt.c:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int irq_nr =
=3D 16 + ((pin + <br>
PCI_SLOT(devfn)) % GPEX_NUM_IRQS);<br>
hw/loongarch/virt.c:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0GPEX_NUM_IRQS * GPEX_NUM_IRQS *<br>
hw/vmapple/vmapple.c:#define GPEX_NUM_IRQS 16<br>
hw/vmapple/vmapple.c:=C2=A0 =C2=A0 qdev_prop_set_uint32(dev, &quot;num-irqs=
&quot;, <br>
GPEX_NUM_IRQS);<br>
hw/vmapple/vmapple.c:=C2=A0 =C2=A0 for (i =3D 0; i &lt; GPEX_NUM_IRQS; i++)=
 {<br>
hw/xen/xen-pvh-common.c:=C2=A0 =C2=A0 for (i =3D 0; i &lt; GPEX_NUM_IRQS; i=
++) {<br>
<br></blockquote><div><br></div><div>Good catch! These were added to the co=
de base long after v1 of the patch was posted=E2=80=A6</div><div>It looks l=
ike all of these are safe to replace with PCI_NUM_PINS. (Except the ones in=
 vmapple.c, which #defines its own local value and is intentional.)<br></di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; -<br>
&gt;=C2=A0 =C2=A0struct GPEXRootState {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/*&lt; private &gt;*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0PCIDevice parent_obj;<br>
&gt; @@ -49,6 +47,7 @@ struct GPEXConfig {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0PCIBus=C2=A0 =C2=A0 =C2=A0 *bus;<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +typedef struct GPEXIrq GPEXIrq;<br>
&gt;=C2=A0 =C2=A0struct GPEXHost {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/*&lt; private &gt;*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0PCIExpressHost parent_obj;<br>
&gt; @@ -60,8 +59,8 @@ struct GPEXHost {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MemoryRegion io_mmio;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MemoryRegion io_ioport_window;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MemoryRegion io_mmio_window;<br>
&gt; -=C2=A0 =C2=A0 qemu_irq irq[GPEX_NUM_IRQS];<br>
&gt; -=C2=A0 =C2=A0 int irq_num[GPEX_NUM_IRQS];<br>
&gt; +=C2=A0 =C2=A0 GPEXIrq *irq;<br>
&gt; +=C2=A0 =C2=A0 uint8_t num_irqs;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool allow_unmapped_accesses;<br>
&gt;=C2=A0 =C2=A0<br>
<br>
</blockquote></div></div>

--000000000000d494fa0627fb9ac8--

