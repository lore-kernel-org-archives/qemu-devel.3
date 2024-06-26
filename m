Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C79C3064D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 01:42:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMHYT-0003zr-3v; Tue, 25 Jun 2024 21:34:38 -0400
Received: from eggs.gnu.org ([209.51.188.92])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMHYG-0003yJ-VG
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 21:34:26 -0400
Received: from [2607:f8b0:4864:20::736] (helo=mail-qk1-x736.google.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMHXY-0003iS-TV
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 21:34:10 -0400
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-79c03dbddb8so132725385a.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 18:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719365545; x=1719970345; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GYudHtkKWd7Dipm9LqNUjoYl4NM9bNcT1f/3vN7kHU8=;
 b=Iy9VtHcY+x1q6Hme+Bdgd7tFy54FRh7s/VTUAF5cwiSh0JItr7T1C8nOvUn2+m82ws
 tc9+LdBl70vpAinoNYcslQsiL77dzsIM9NZfloGDZyUPRSv0bLwuTOBzdWb65sOLh5rK
 PQS/uMAb/h8Ok6oy+ER6nNnilqrAWDOqR+mcF+uQLRg+jF7vZL3eCfF47LkQ8ejpy2ZL
 Pvjs8pi1oYcJkmr6YJTAi+i9N9RkxMZ42Jl09cHwwXzpC1YJ4zDM6k90PoEjl7NSxJzc
 PoUcIVJSoO5WCbSRqMx6ew5AwLBQy9LRhwA/WxSgikbf3yhJiTTQTCQsKZP0xSTKAldd
 /bBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719365545; x=1719970345;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GYudHtkKWd7Dipm9LqNUjoYl4NM9bNcT1f/3vN7kHU8=;
 b=b83YhmtqzXQAItWavJSrayKfL4ienX/wHgdnzB9opsudK5RbKFGlIeP+dlgCy9z3lI
 Mqz1X6nMIkV55ajTSaMuFDU9GateyendEDGqZlkz07SXECWnr5Th0ysuzeoY6HBGZigV
 dMdpxvbSQ8cHLzfv1zdoM5FuuJPeoUXSv+4NaZdSH4yHVQLvAfNma6xDToqco7MzLyKs
 xCPSYVhIcvWzQ3uja4oabUaMaGU90ajTWLlfjjd7tKeWIwQEy30C3QwkROmJWmvxaari
 z7mixKjCSy/MocOjXMPcYp51ynVRKHbqMJm+VmBJZrfQdNWk3zo/2h8kBEA3r6amPg2p
 J2Iw==
X-Gm-Message-State: AOJu0YysBu4MSW2ug8wzz2BiB5wk3ZjjRaQt0c0Y1PjiEYNDjEgjF883
 mQBlHi6D7/CAIEgXkLBTC4ekYHkFg73XpKu3gpakFSdBfU2gISVYkeH9PU31eUpUzEXZmc6ZAxG
 waNKhobsBwiNQSR9fYHsgrSgG1s6aFI6Z
X-Google-Smtp-Source: AGHT+IFSqNqdowHv7MKvWFf4FWp8oBIyt4CXA75Hy7bUW65jxhL5K4b6RP3ABodGjUD+Iv0GFNlAqU6mXuj83QOQH9g=
X-Received: by 2002:a05:6102:416:b0:48c:1157:2f58 with SMTP id
 ada2fe7eead31-48f4ef62aa0mr7138762137.17.1719364992573; Tue, 25 Jun 2024
 18:23:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240612031706.2927602-1-ethan84@andestech.com>
 <20240612031706.2927602-3-ethan84@andestech.com>
 <CAKmqyKM+dSQfGAUcU9w+hHA1SVA-OSLhsfYHh7rV1uutaeppfw@mail.gmail.com>
 <ZnjQCkiR2ikr1Rng@ethan84-VirtualBox>
In-Reply-To: <ZnjQCkiR2ikr1Rng@ethan84-VirtualBox>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 26 Jun 2024 11:22:46 +1000
Message-ID: <CAKmqyKMzg0rHj0RfpcGB3Mecy4tVvMQWDhgM8u3=GaRn46q2vg@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] hw/riscv/virt: Add IOPMP support
To: Ethan Chen <ethan84@andestech.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2607:f8b0:4864:20::736
 (deferred)
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=alistair23@gmail.com; helo=mail-qk1-x736.google.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, PDS_HP_HELO_NORDNS=0.001,
 RDNS_NONE=0.793, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Mon, Jun 24, 2024 at 11:47=E2=80=AFAM Ethan Chen <ethan84@andestech.com>=
 wrote:
>
> Hi Alistair,
>
> IOPMP can applies all device. In this patch series, PCI devices on the br=
idge
> can connect to IOPMP by pci_setup_iommu(), but other devices need change =
their
> memory access address space from system memory to IOPMP by themself.

We should be really clear about that then. The documentation and the
flag `iopmp=3D[on|off]` implies that either the IOPMP is on or off.

For example, what happens in the future if we extend support to apply
to all devices? That will be a breaking change for anyone currently
using `iopmp=3Don`.

Maybe we should have use something like `iopmp=3D[pci|off]` instead, and
then be really clear in the docs what is and isn't going through the
IOPMP.

Alistair

>
> Thanks,
> Ethan
>
> On Fri, Jun 21, 2024 at 03:54:15PM +1000, Alistair Francis wrote:
> > On Wed, Jun 12, 2024 at 1:25=E2=80=AFPM Ethan Chen via <qemu-devel@nong=
nu.org> wrote:
> > >
> > > If a requestor device is connected to the IOPMP device, its memory ac=
cess will
> > > be checked by the IOPMP rule.
> > >
> > > - Add 'iopmp=3Don' option to add an iopmp device and make the Generic=
 PCI Express
> > >   Bridge connect to IOPMP.
> >
> > I have only had a chance to have a quick look at this series and the sp=
ec.
> >
> > But the IOPMP spec applies to all devices right, but this series seems
> > to only work with PCI. Am I missing something?
> >
> > Alistair
> >
> > >
> > > Signed-off-by: Ethan Chen <ethan84@andestech.com>
> > > ---
> > >  docs/system/riscv/virt.rst |  6 ++++
> > >  hw/riscv/Kconfig           |  1 +
> > >  hw/riscv/virt.c            | 57 ++++++++++++++++++++++++++++++++++++=
--
> > >  include/hw/riscv/virt.h    |  5 +++-
> > >  4 files changed, 66 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
> > > index 9a06f95a34..3b2576f905 100644
> > > --- a/docs/system/riscv/virt.rst
> > > +++ b/docs/system/riscv/virt.rst
> > > @@ -116,6 +116,12 @@ The following machine-specific options are suppo=
rted:
> > >    having AIA IMSIC (i.e. "aia=3Daplic-imsic" selected). When not spe=
cified,
> > >    the default number of per-HART VS-level AIA IMSIC pages is 0.
> > >
> > > +- iopmp=3D[on|off]
> > > +
> > > +  When this option is "on", an IOPMP device is added to machine. It =
checks dma
> > > +  operations from the generic PCIe host bridge. This option is assum=
ed to be
> > > +  "off".
> > > +
> > >  Running Linux kernel
> > >  --------------------
> > >
> > > diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> > > index a2030e3a6f..0b45a5ade2 100644
> > > --- a/hw/riscv/Kconfig
> > > +++ b/hw/riscv/Kconfig
> > > @@ -56,6 +56,7 @@ config RISCV_VIRT
> > >      select PLATFORM_BUS
> > >      select ACPI
> > >      select ACPI_PCI
> > > +    select RISCV_IOPMP
> > >
> > >  config SHAKTI_C
> > >      bool
> > > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> > > index 4fdb660525..53a1b71c71 100644
> > > --- a/hw/riscv/virt.c
> > > +++ b/hw/riscv/virt.c
> > > @@ -55,6 +55,7 @@
> > >  #include "hw/acpi/aml-build.h"
> > >  #include "qapi/qapi-visit-common.h"
> > >  #include "hw/virtio/virtio-iommu.h"
> > > +#include "hw/misc/riscv_iopmp.h"
> > >
> > >  /* KVM AIA only supports APLIC MSI. APLIC Wired is always emulated b=
y QEMU. */
> > >  static bool virt_use_kvm_aia(RISCVVirtState *s)
> > > @@ -82,6 +83,7 @@ static const MemMapEntry virt_memmap[] =3D {
> > >      [VIRT_UART0] =3D        { 0x10000000,         0x100 },
> > >      [VIRT_VIRTIO] =3D       { 0x10001000,        0x1000 },
> > >      [VIRT_FW_CFG] =3D       { 0x10100000,          0x18 },
> > > +    [VIRT_IOPMP] =3D        { 0x10200000,      0x100000 },
> > >      [VIRT_FLASH] =3D        { 0x20000000,     0x4000000 },
> > >      [VIRT_IMSIC_M] =3D      { 0x24000000, VIRT_IMSIC_MAX_SIZE },
> > >      [VIRT_IMSIC_S] =3D      { 0x28000000, VIRT_IMSIC_MAX_SIZE },
> > > @@ -1006,6 +1008,24 @@ static void create_fdt_virtio_iommu(RISCVVirtS=
tate *s, uint16_t bdf)
> > >                             bdf + 1, iommu_phandle, bdf + 1, 0xffff -=
 bdf);
> > >  }
> > >
> > > +static void create_fdt_iopmp(RISCVVirtState *s, const MemMapEntry *m=
emmap,
> > > +                             uint32_t irq_mmio_phandle) {
> > > +    g_autofree char *name =3D NULL;
> > > +    MachineState *ms =3D MACHINE(s);
> > > +
> > > +    name =3D g_strdup_printf("/soc/iopmp@%lx", (long)memmap[VIRT_IOP=
MP].base);
> > > +    qemu_fdt_add_subnode(ms->fdt, name);
> > > +    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "riscv_iopm=
p");
> > > +    qemu_fdt_setprop_cells(ms->fdt, name, "reg", 0x0, memmap[VIRT_IO=
PMP].base,
> > > +        0x0, memmap[VIRT_IOPMP].size);
> > > +    qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent", irq_mmi=
o_phandle);
> > > +    if (s->aia_type =3D=3D VIRT_AIA_TYPE_NONE) {
> > > +        qemu_fdt_setprop_cell(ms->fdt, name, "interrupts", IOPMP_IRQ=
);
> > > +    } else {
> > > +        qemu_fdt_setprop_cells(ms->fdt, name, "interrupts", IOPMP_IR=
Q, 0x4);
> > > +    }
> > > +}
> > > +
> > >  static void finalize_fdt(RISCVVirtState *s)
> > >  {
> > >      uint32_t phandle =3D 1, irq_mmio_phandle =3D 1, msi_pcie_phandle=
 =3D 1;
> > > @@ -1024,6 +1044,10 @@ static void finalize_fdt(RISCVVirtState *s)
> > >      create_fdt_uart(s, virt_memmap, irq_mmio_phandle);
> > >
> > >      create_fdt_rtc(s, virt_memmap, irq_mmio_phandle);
> > > +
> > > +    if (s->have_iopmp) {
> > > +        create_fdt_iopmp(s, virt_memmap, irq_mmio_phandle);
> > > +    }
> > >  }
> > >
> > >  static void create_fdt(RISCVVirtState *s, const MemMapEntry *memmap)
> > > @@ -1404,7 +1428,7 @@ static void virt_machine_init(MachineState *mac=
hine)
> > >      RISCVVirtState *s =3D RISCV_VIRT_MACHINE(machine);
> > >      MemoryRegion *system_memory =3D get_system_memory();
> > >      MemoryRegion *mask_rom =3D g_new(MemoryRegion, 1);
> > > -    DeviceState *mmio_irqchip, *virtio_irqchip, *pcie_irqchip;
> > > +    DeviceState *mmio_irqchip, *virtio_irqchip, *pcie_irqchip, *gpex=
_dev;
> > >      int i, base_hartid, hart_count;
> > >      int socket_count =3D riscv_socket_count(machine);
> > >
> > > @@ -1570,7 +1594,7 @@ static void virt_machine_init(MachineState *mac=
hine)
> > >              qdev_get_gpio_in(virtio_irqchip, VIRTIO_IRQ + i));
> > >      }
> > >
> > > -    gpex_pcie_init(system_memory, pcie_irqchip, s);
> > > +    gpex_dev =3D gpex_pcie_init(system_memory, pcie_irqchip, s);
> > >
> > >      create_platform_bus(s, mmio_irqchip);
> > >
> > > @@ -1581,6 +1605,14 @@ static void virt_machine_init(MachineState *ma=
chine)
> > >      sysbus_create_simple("goldfish_rtc", memmap[VIRT_RTC].base,
> > >          qdev_get_gpio_in(mmio_irqchip, RTC_IRQ));
> > >
> > > +    if (s->have_iopmp) {
> > > +        DeviceState *iopmp_dev =3D sysbus_create_simple(TYPE_IOPMP,
> > > +            memmap[VIRT_IOPMP].base,
> > > +            qdev_get_gpio_in(DEVICE(mmio_irqchip), IOPMP_IRQ));
> > > +
> > > +        iopmp_setup_pci(iopmp_dev, PCI_HOST_BRIDGE(gpex_dev)->bus);
> > > +    }
> > > +
> > >      for (i =3D 0; i < ARRAY_SIZE(s->flash); i++) {
> > >          /* Map legacy -drive if=3Dpflash to machine properties */
> > >          pflash_cfi01_legacy_drive(s->flash[i],
> > > @@ -1684,6 +1716,21 @@ static void virt_set_aclint(Object *obj, bool =
value, Error **errp)
> > >      s->have_aclint =3D value;
> > >  }
> > >
> > > +static bool virt_get_iopmp(Object *obj, Error **errp)
> > > +{
> > > +    RISCVVirtState *s =3D RISCV_VIRT_MACHINE(obj);
> > > +
> > > +    return s->have_iopmp;
> > > +}
> > > +
> > > +static void virt_set_iopmp(Object *obj, bool value, Error **errp)
> > > +{
> > > +    RISCVVirtState *s =3D RISCV_VIRT_MACHINE(obj);
> > > +
> > > +    s->have_iopmp =3D value;
> > > +}
> > > +
> > > +
> > >  bool virt_is_acpi_enabled(RISCVVirtState *s)
> > >  {
> > >      return s->acpi !=3D ON_OFF_AUTO_OFF;
> > > @@ -1794,6 +1841,12 @@ static void virt_machine_class_init(ObjectClas=
s *oc, void *data)
> > >                                NULL, NULL);
> > >      object_class_property_set_description(oc, "acpi",
> > >                                            "Enable ACPI");
> > > +
> > > +    object_class_property_add_bool(oc, "iopmp", virt_get_iopmp,
> > > +                                   virt_set_iopmp);
> > > +    object_class_property_set_description(oc, "iopmp",
> > > +                                          "Set on/off to enable/disa=
ble "
> > > +                                          "iopmp device");
> > >  }
> > >
> > >  static const TypeInfo virt_machine_typeinfo =3D {
> > > diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> > > index 3db839160f..81460e29c4 100644
> > > --- a/include/hw/riscv/virt.h
> > > +++ b/include/hw/riscv/virt.h
> > > @@ -55,6 +55,7 @@ struct RISCVVirtState {
> > >
> > >      int fdt_size;
> > >      bool have_aclint;
> > > +    bool have_iopmp;
> > >      RISCVVirtAIAType aia_type;
> > >      int aia_guests;
> > >      char *oem_id;
> > > @@ -84,12 +85,14 @@ enum {
> > >      VIRT_PCIE_MMIO,
> > >      VIRT_PCIE_PIO,
> > >      VIRT_PLATFORM_BUS,
> > > -    VIRT_PCIE_ECAM
> > > +    VIRT_PCIE_ECAM,
> > > +    VIRT_IOPMP,
> > >  };
> > >
> > >  enum {
> > >      UART0_IRQ =3D 10,
> > >      RTC_IRQ =3D 11,
> > > +    IOPMP_IRQ =3D 12,
> > >      VIRTIO_IRQ =3D 1, /* 1 to 8 */
> > >      VIRTIO_COUNT =3D 8,
> > >      PCIE_IRQ =3D 0x20, /* 32 to 35 */
> > > --
> > > 2.34.1
> > >
> > >

