Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D50EC54E41
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 00:50:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri1wj-0007Zx-AM; Wed, 06 Mar 2024 19:49:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ri1wf-0007Zf-Iv; Wed, 06 Mar 2024 19:49:13 -0500
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ri1wc-0004r0-0D; Wed, 06 Mar 2024 19:49:12 -0500
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-4d371351b62so112537e0c.1; 
 Wed, 06 Mar 2024 16:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709772548; x=1710377348; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BawIH8/ZtMQtxeBB5qVGt+ak4StdZgvKbavEGFrOa90=;
 b=VsJhcIwXhw78IVuZ1UsnuJnwCw8Qu75b3G0s/cI7RE8j8FQ4arjVfNVULxvWqpPnaW
 a0XHJ8pasK6nOUPZ68QSqCNj8q8JAZaM/9XXEy1FUwjBlBoOTvjapijB0fL8b4LtDwtZ
 AN+7bJOyIyRNVxBKlyn8DzrqM5D3j++LAER0qCvjX67IvDXqMJx8JjxmlaktMAARu8K6
 wHKaAciQffm6nJATkEbVZTjmKTka1j72+mX4wYDLb2J3OuRg6We01Nl+7olbK/Ogomim
 2W5zz2XBHpIVwasmVYZtFT7blxD9zjTsmtyXQnkSoN6vQ0NTwRHqjJfLUW+UPAsDTgHV
 6Jog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709772548; x=1710377348;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BawIH8/ZtMQtxeBB5qVGt+ak4StdZgvKbavEGFrOa90=;
 b=dbW5jdKmHkScssO7p8kFeizd7/BQg1o8s0uekwWKuJ+y9BsKcnpWZwXKV3nEwZILEp
 kGhdd15RPmkVr4a4B5RuFdDqp7x9pAOU0zB2r1BWMm+IeYa9q9pcQ77jTJ0bDzjfTaNE
 smXwxqm1aQHMo5zfsb/ZXINvAZajh7Av4+YdytOF1Ml6jz/ENYGvicuw97GiibGv/Ie0
 e3v3ZWdRCzT/K+2qn9wcTGlV7JCixIdBlVsrhP4imMF4eq180UjnScL5N7rtORGG3XkV
 8Jht4LggObRN5fan0ewU+y74vHCYpJbjmcMqS6V4lfRIQhLBKIwdctzDzzSfBF2+uW72
 x6Rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFI+hTxxxrXikKqUE+Z/+zkIcLlua5tvpea6slEVygNZ3phJy+uAA2v0iZN2VnOy0TT2+lx+OF3pUkZcyljo+BuJoPmYWdx6zOoVf7slZ3AWdMFcEQSUxL7QHSKA==
X-Gm-Message-State: AOJu0YxN2PElv9O3PgkbpQcC7ZF48chArd8hKDkcwleoJYlT+ENc0n8r
 fXc5tIw/IiqlGNTOjWuzGA7SXQnhh+saAPc91fb/qS297z1OlbzQidf8d8MFiXLCNnrVbq1aJb0
 r+VHs32/a7jd3hoRKeIKjakAdb9IJYfc0
X-Google-Smtp-Source: AGHT+IFx51ZrVLtyEl8KXXkT26akHE8raR3mnnkLqUtHYji8d/4lhclsmiqUF2+/aGji3BA7HSVgAics7b2X7qRoMeQ=
X-Received: by 2002:a67:b607:0:b0:472:ee80:60d9 with SMTP id
 d7-20020a67b607000000b00472ee8060d9mr3330186vsm.22.1709772548306; Wed, 06 Mar
 2024 16:49:08 -0800 (PST)
MIME-Version: 1.0
References: <20240304102540.2789225-1-fei2.wu@intel.com>
 <20240304102540.2789225-2-fei2.wu@intel.com>
 <CAKmqyKMQyDjLkeo+aU58rE6_Vb84QeeZP3FUafw5GuWpk1JmZQ@mail.gmail.com>
 <8f5d6664-c075-4d31-bf33-ce24ceeb9b13@intel.com>
 <CAHBxVyHP1hgGWg6EByX6XzqmTm_Tr0uw7tk65KWcytNYsKdw8w@mail.gmail.com>
In-Reply-To: <CAHBxVyHP1hgGWg6EByX6XzqmTm_Tr0uw7tk65KWcytNYsKdw8w@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 7 Mar 2024 10:48:42 +1000
Message-ID: <CAKmqyKM08RwR7RybMGaN6CpmbHJrLwx0DSjz_A1w6h0AkW12rQ@mail.gmail.com>
Subject: Re: [RFC 1/2] hw/riscv: Add server platform reference machine
To: Atish Kumar Patra <atishp@rivosinc.com>
Cc: "Wu, Fei" <fei2.wu@intel.com>, pbonzini@redhat.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, andrei.warkentin@intel.com, 
 shaolin.xie@alibaba-inc.com, ved@rivosinc.com, sunilvl@ventanamicro.com, 
 haibo1.xu@intel.com, evan.chai@intel.com, yin.wang@intel.com, 
 tech-server-platform@lists.riscv.org, tech-server-soc@lists.riscv.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a30;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa30.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Mar 7, 2024 at 5:13=E2=80=AFAM Atish Kumar Patra <atishp@rivosinc.c=
om> wrote:
>
> On Wed, Mar 6, 2024 at 4:56=E2=80=AFAM Wu, Fei <fei2.wu@intel.com> wrote:
> >
> > On 3/6/2024 8:19 AM, Alistair Francis wrote:
> > > On Mon, Mar 4, 2024 at 8:28=E2=80=AFPM Fei Wu <fei2.wu@intel.com> wro=
te:
> > >>
> > >> The RISC-V Server Platform specification[1] defines a standardized s=
et
> > >> of hardware and software capabilities, that portable system software=
,
> > >> such as OS and hypervisors can rely on being present in a RISC-V ser=
ver
> > >> platform.
> > >>
> > >> A corresponding Qemu RISC-V server platform reference (rvsp-ref for
> > >> short) machine type is added to provide a environment for firmware/O=
S
> > >> development and testing. The main features included in rvsp-ref are:
> > >>
> > >>  - Based on riscv virt machine type
> > >>  - A new memory map as close as virt machine as possible
> > >>  - A new virt CPU type rvsp-ref-cpu for server platform compliance
> > >>  - AIA
> > >>  - PCIe AHCI
> > >>  - PCIe NIC
> > >>  - No virtio device
> > >>  - No fw_cfg device
> > >>  - No ACPI table provided
> > >>  - Only minimal device tree nodes
> > >>
> > >> [1] https://github.com/riscv-non-isa/riscv-server-platform
> > >
> > > + Atish
> > >
> > >>
> > >> Signed-off-by: Fei Wu <fei2.wu@intel.com>
> > >> ---
> > >>  configs/devices/riscv64-softmmu/default.mak |    1 +
> > >>  hw/riscv/Kconfig                            |   13 +
> > >>  hw/riscv/meson.build                        |    1 +
> > >>  hw/riscv/server_platform_ref.c              | 1244 ++++++++++++++++=
+++
> > >>  4 files changed, 1259 insertions(+)
> > >>  create mode 100644 hw/riscv/server_platform_ref.c
> > >>
> > >> diff --git a/configs/devices/riscv64-softmmu/default.mak b/configs/d=
evices/riscv64-softmmu/default.mak
> > >> index 3f68059448..a1d98e49ef 100644
> > >> --- a/configs/devices/riscv64-softmmu/default.mak
> > >> +++ b/configs/devices/riscv64-softmmu/default.mak
> > >> @@ -10,5 +10,6 @@ CONFIG_SPIKE=3Dy
> > >>  CONFIG_SIFIVE_E=3Dy
> > >>  CONFIG_SIFIVE_U=3Dy
> > >>  CONFIG_RISCV_VIRT=3Dy
> > >> +CONFIG_SERVER_PLATFORM_REF=3Dy
> > >>  CONFIG_MICROCHIP_PFSOC=3Dy
> > >>  CONFIG_SHAKTI_C=3Dy
> > >> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> > >> index 5d644eb7b1..debac5a7f5 100644
> > >> --- a/hw/riscv/Kconfig
> > >> +++ b/hw/riscv/Kconfig
> > >> @@ -48,6 +48,19 @@ config RISCV_VIRT
> > >>      select ACPI
> > >>      select ACPI_PCI
> > >>
> > >> +config SERVER_PLATFORM_REF
> > >> +    bool
> > >> +    select RISCV_NUMA
> > >> +    select GOLDFISH_RTC
> > >> +    select PCI
> > >> +    select PCI_EXPRESS_GENERIC_BRIDGE
> > >> +    select PFLASH_CFI01
> > >> +    select SERIAL
> > >> +    select RISCV_ACLINT
> > >> +    select RISCV_APLIC
> > >> +    select RISCV_IMSIC
> > >> +    select SIFIVE_TEST
> > >
> > > Do we really need SiFive Test in the server platform?
> > >
> > It's used to reset the system, is there any better choice?

If we add this now we are stuck with it forever (or at least a long
time). So it'd be nice to think about these and decide if these really
are the best way to do things. We don't have to just copy the existing
virt machine.

There must be a more standard way to do this then MMIO mapped SiFive hardwa=
re?

> >
> > Probably I can remove the "sifive,test1 sifive,test0" from the
> > compatible list in fdt, and only keep "syscon", I see opensbi has
> > already removed that support in commit c2e602707.
> >
> > > Same with the goldfish RTC?
> > >
> > Although the spec doesn't make RTC mandatory, it should be a common
> > practice having a RTC on server, so I add a RTC here no matter it's
> > goldfish or not.
> >
>
> The platform spec says
> HPER_070 : A battery-backed RTC or analogous timekeeping mechanism
> MUST be implemented.
>
> Can we consider goldfish RTC in this category ?

I think so, although I haven't read the spec yet :)

My point was more that if we are going to implement a new machine, we
should aim to standardise on things that other
machines/servers/platforms/architectures do. Some of the things in the
virt machine are historical because that's what worked at the time.
But with a clean slate design there might be better alternatives.
Obviously while still sticking to the spec

>
> But I want to discuss a larger point as the server platform/SoC spec
> defines a bunch of optional requirement.
> Does this platform intend to be a platform that is a superset of all
> those options or allow optionality in
> the platform as well ?

Generally I feel that QEMU has the luxury of just supporting
everything. If there is an optional component created by the machine
it generally is fine if the guest doesn't use it. While creating
complex configuration options is a pain for users

Alistair

>
> > >> +
> > >>  config SHAKTI_C
> > >>      bool
> > >>      select RISCV_ACLINT
> > >> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> > >> index 2f7ee81be3..bb3aff91ea 100644
> > >> --- a/hw/riscv/meson.build
> > >> +++ b/hw/riscv/meson.build
> > >> @@ -4,6 +4,7 @@ riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: fil=
es('numa.c'))
> > >>  riscv_ss.add(files('riscv_hart.c'))
> > >>  riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'=
))
> > >>  riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
> > >> +riscv_ss.add(when: 'CONFIG_SERVER_PLATFORM_REF', if_true: files('se=
rver_platform_ref.c'))
> > >>  riscv_ss.add(when: 'CONFIG_SHAKTI_C', if_true: files('shakti_c.c'))
> > >>  riscv_ss.add(when: 'CONFIG_SIFIVE_E', if_true: files('sifive_e.c'))
> > >>  riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
> > >> diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platfo=
rm_ref.c
> > >> new file mode 100644
> > >> index 0000000000..ae90c4b27a
> > >> --- /dev/null
> > >> +++ b/hw/riscv/server_platform_ref.c
> > >> @@ -0,0 +1,1244 @@
> > >> +/*
> > >> + * QEMU RISC-V Server Platfrom (RVSP) Reference Board
> > >
> > > Platform
> > >
> > OK.
> >
> > >> +static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
> > >> +                                          DeviceState *irqchip,
> > >> +                                          RVSPMachineState *s)
> > >> +{
> > >> +    DeviceState *dev;
> > >> +    PCIHostState *pci;
> > >> +    PCIDevice *pdev_ahci;
> > >> +    AHCIPCIState *ich9;
> > >> +    DriveInfo *hd[NUM_SATA_PORTS];
> > >> +    MemoryRegion *ecam_alias, *ecam_reg;
> > >> +    MemoryRegion *mmio_alias, *high_mmio_alias, *mmio_reg;
> > >> +    hwaddr ecam_base =3D rvsp_ref_memmap[RVSP_PCIE_ECAM].base;
> > >> +    hwaddr ecam_size =3D rvsp_ref_memmap[RVSP_PCIE_ECAM].size;
> > >> +    hwaddr mmio_base =3D rvsp_ref_memmap[RVSP_PCIE_MMIO].base;
> > >> +    hwaddr mmio_size =3D rvsp_ref_memmap[RVSP_PCIE_MMIO].size;
> > >> +    hwaddr high_mmio_base =3D rvsp_ref_memmap[RVSP_PCIE_MMIO_HIGH].=
base;
> > >> +    hwaddr high_mmio_size =3D rvsp_ref_memmap[RVSP_PCIE_MMIO_HIGH].=
size;
> > >> +    hwaddr pio_base =3D rvsp_ref_memmap[RVSP_PCIE_PIO].base;
> > >> +    hwaddr pio_size =3D rvsp_ref_memmap[RVSP_PCIE_PIO].size;
> > >> +    MachineClass *mc =3D MACHINE_GET_CLASS(s);
> > >> +    qemu_irq irq;
> > >> +    int i;
> > >> +
> > >> +    dev =3D qdev_new(TYPE_GPEX_HOST);
> > >> +
> > >> +    /* Set GPEX object properties for the rvsp ref machine */
> > >> +    object_property_set_uint(OBJECT(GPEX_HOST(dev)), PCI_HOST_ECAM_=
BASE,
> > >> +                            ecam_base, NULL);
> > >> +    object_property_set_int(OBJECT(GPEX_HOST(dev)), PCI_HOST_ECAM_S=
IZE,
> > >> +                            ecam_size, NULL);
> > >> +    object_property_set_uint(OBJECT(GPEX_HOST(dev)),
> > >> +                             PCI_HOST_BELOW_4G_MMIO_BASE,
> > >> +                             mmio_base, NULL);
> > >> +    object_property_set_int(OBJECT(GPEX_HOST(dev)), PCI_HOST_BELOW_=
4G_MMIO_SIZE,
> > >> +                            mmio_size, NULL);
> > >> +    object_property_set_uint(OBJECT(GPEX_HOST(dev)),
> > >> +                             PCI_HOST_ABOVE_4G_MMIO_BASE,
> > >> +                             high_mmio_base, NULL);
> > >> +    object_property_set_int(OBJECT(GPEX_HOST(dev)), PCI_HOST_ABOVE_=
4G_MMIO_SIZE,
> > >> +                            high_mmio_size, NULL);
> > >> +    object_property_set_uint(OBJECT(GPEX_HOST(dev)), PCI_HOST_PIO_B=
ASE,
> > >> +                            pio_base, NULL);
> > >> +    object_property_set_int(OBJECT(GPEX_HOST(dev)), PCI_HOST_PIO_SI=
ZE,
> > >> +                            pio_size, NULL);
> > >> +
> > >> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> > >> +
> > >> +    ecam_alias =3D g_new0(MemoryRegion, 1);
> > >> +    ecam_reg =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> > >> +    memory_region_init_alias(ecam_alias, OBJECT(dev), "pcie-ecam",
> > >> +                             ecam_reg, 0, ecam_size);
> > >> +    memory_region_add_subregion(get_system_memory(), ecam_base, eca=
m_alias);
> > >> +
> > >> +    mmio_alias =3D g_new0(MemoryRegion, 1);
> > >> +    mmio_reg =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
> > >> +    memory_region_init_alias(mmio_alias, OBJECT(dev), "pcie-mmio",
> > >> +                             mmio_reg, mmio_base, mmio_size);
> > >> +    memory_region_add_subregion(get_system_memory(), mmio_base, mmi=
o_alias);
> > >> +
> > >> +    /* Map high MMIO space */
> > >> +    high_mmio_alias =3D g_new0(MemoryRegion, 1);
> > >> +    memory_region_init_alias(high_mmio_alias, OBJECT(dev), "pcie-mm=
io-high",
> > >> +                             mmio_reg, high_mmio_base, high_mmio_si=
ze);
> > >> +    memory_region_add_subregion(get_system_memory(), high_mmio_base=
,
> > >> +                                high_mmio_alias);
> > >> +
> > >> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, pio_base);
> > >> +
> > >> +    for (i =3D 0; i < GPEX_NUM_IRQS; i++) {
> > >> +        irq =3D qdev_get_gpio_in(irqchip, RVSP_PCIE_IRQ + i);
> > >> +
> > >> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, irq);
> > >> +        gpex_set_irq_num(GPEX_HOST(dev), i, RVSP_PCIE_IRQ + i);
> > >> +    }
> > >> +
> > >> +    pci =3D PCI_HOST_BRIDGE(dev);
> > >> +    pci_init_nic_devices(pci->bus, mc->default_nic);
> > >> +    /* IDE disk setup.  */
> > >> +    pdev_ahci =3D pci_create_simple(pci->bus, -1, TYPE_ICH9_AHCI);
> > >> +    ich9 =3D ICH9_AHCI(pdev_ahci);
> > >> +    g_assert(ARRAY_SIZE(hd) =3D=3D ich9->ahci.ports);
> > >> +    ide_drive_get(hd, ich9->ahci.ports);
> > >> +    ahci_ide_create_devs(&ich9->ahci, hd);
> > >> +
> > >> +    GPEX_HOST(dev)->gpex_cfg.bus =3D PCI_HOST_BRIDGE(GPEX_HOST(dev)=
)->bus;
> > >> +    return dev;
> > >> +}
> > >
> > > We should share as much of this code as possible with the virt machin=
e.
> > >
> > This function references multiple rvsp specific variables, some
> > refactorings are needed to group all the information of
> > ecam/mmio/high_mmio/pio/irq and pass them to virt and rvsp respectively=
.
> > I see arm virt/sbsa-ref are seperated clearly and no sharing between
> > them. It has the benefit there is no side effect between them. Should w=
e
> > use the same policy?
> >
> > Thanks,
> > Fei.
> >
> > > Alistair
> > >
> > >> +
> > >> +static DeviceState *rvsp_ref_create_aia(int aia_guests,
> > >> +                                        const MemMapEntry *memmap, =
int socket,
> > >> +                                        int base_hartid, int hart_c=
ount)
> > >> +{
> > >> +    int i;
> > >> +    hwaddr addr;
> > >> +    uint32_t guest_bits;
> > >> +    DeviceState *aplic_s =3D NULL;
> > >> +    DeviceState *aplic_m =3D NULL;
> > >> +    bool msimode =3D true;
> > >> +
> > >> +    /* Per-socket M-level IMSICs */
> > >> +    addr =3D memmap[RVSP_IMSIC_M].base +
> > >> +           socket * RVSP_IMSIC_GROUP_MAX_SIZE;
> > >> +    for (i =3D 0; i < hart_count; i++) {
> > >> +        riscv_imsic_create(addr + i * IMSIC_HART_SIZE(0),
> > >> +                           base_hartid + i, true, 1,
> > >> +                           RVSP_IRQCHIP_NUM_MSIS);
> > >> +    }
> > >> +
> > >> +    /* Per-socket S-level IMSICs */
> > >> +    guest_bits =3D imsic_num_bits(aia_guests + 1);
> > >> +    addr =3D memmap[RVSP_IMSIC_S].base + socket * RVSP_IMSIC_GROUP_=
MAX_SIZE;
> > >> +    for (i =3D 0; i < hart_count; i++) {
> > >> +        riscv_imsic_create(addr + i * IMSIC_HART_SIZE(guest_bits),
> > >> +                           base_hartid + i, false, 1 + aia_guests,
> > >> +                           RVSP_IRQCHIP_NUM_MSIS);
> > >> +    }
> > >> +
> > >> +    /* Per-socket M-level APLIC */
> > >> +    aplic_m =3D riscv_aplic_create(memmap[RVSP_APLIC_M].base +
> > >> +                                 socket * memmap[RVSP_APLIC_M].size=
,
> > >> +                                 memmap[RVSP_APLIC_M].size,
> > >> +                                 (msimode) ? 0 : base_hartid,
> > >> +                                 (msimode) ? 0 : hart_count,
> > >> +                                 RVSP_IRQCHIP_NUM_SOURCES,
> > >> +                                 RVSP_IRQCHIP_NUM_PRIO_BITS,
> > >> +                                 msimode, true, NULL);
> > >> +
> > >> +    /* Per-socket S-level APLIC */
> > >> +    aplic_s =3D riscv_aplic_create(memmap[RVSP_APLIC_S].base +
> > >> +                                 socket * memmap[RVSP_APLIC_S].size=
,
> > >> +                                 memmap[RVSP_APLIC_S].size,
> > >> +                                 (msimode) ? 0 : base_hartid,
> > >> +                                 (msimode) ? 0 : hart_count,
> > >> +                                 RVSP_IRQCHIP_NUM_SOURCES,
> > >> +                                 RVSP_IRQCHIP_NUM_PRIO_BITS,
> > >> +                                 msimode, false, aplic_m);
> > >> +
> > >> +    (void)aplic_s;
> > >> +    return aplic_m;
> > >> +}
> > >> +
> > >> +static void rvsp_ref_machine_done(Notifier *notifier, void *data)
> > >> +{
> > >> +    RVSPMachineState *s =3D container_of(notifier, RVSPMachineState=
,
> > >> +                                       machine_done);
> > >> +    const MemMapEntry *memmap =3D rvsp_ref_memmap;
> > >> +    MachineState *machine =3D MACHINE(s);
> > >> +    target_ulong start_addr =3D memmap[RVSP_DRAM].base;
> > >> +    target_ulong firmware_end_addr, kernel_start_addr;
> > >> +    const char *firmware_name =3D riscv_default_firmware_name(&s->s=
oc[0]);
> > >> +    uint64_t fdt_load_addr;
> > >> +    uint64_t kernel_entry =3D 0;
> > >> +    BlockBackend *pflash_blk0;
> > >> +
> > >> +    /* load/create device tree */
> > >> +    if (machine->dtb) {
> > >> +        machine->fdt =3D load_device_tree(machine->dtb, &s->fdt_siz=
e);
> > >> +        if (!machine->fdt) {
> > >> +            error_report("load_device_tree() failed");
> > >> +            exit(1);
> > >> +        }
> > >> +    } else {
> > >> +        create_fdt(s, memmap);
> > >> +    }
> > >> +
> > >> +    firmware_end_addr =3D riscv_find_and_load_firmware(machine, fir=
mware_name,
> > >> +                                                     start_addr, NU=
LL);
> > >> +
> > >> +    pflash_blk0 =3D pflash_cfi01_get_blk(s->flash[0]);
> > >> +    if (pflash_blk0) {
> > >> +        if (machine->firmware && !strcmp(machine->firmware, "none")=
) {
> > >> +            /*
> > >> +             * Pflash was supplied but bios is none and not KVM gue=
st,
> > >> +             * let's overwrite the address we jump to after reset t=
o
> > >> +             * the base of the flash.
> > >> +             */
> > >> +            start_addr =3D rvsp_ref_memmap[RVSP_FLASH].base;
> > >> +        } else {
> > >> +            /*
> > >> +             * Pflash was supplied but either KVM guest or bios is =
not none.
> > >> +             * In this case, base of the flash would contain S-mode=
 payload.
> > >> +             */
> > >> +            riscv_setup_firmware_boot(machine);
> > >> +            kernel_entry =3D rvsp_ref_memmap[RVSP_FLASH].base;
> > >> +        }
> > >> +    }
> > >> +
> > >> +    if (machine->kernel_filename && !kernel_entry) {
> > >> +        kernel_start_addr =3D riscv_calc_kernel_start_addr(&s->soc[=
0],
> > >> +                                                         firmware_e=
nd_addr);
> > >> +
> > >> +        kernel_entry =3D riscv_load_kernel(machine, &s->soc[0],
> > >> +                                         kernel_start_addr, true, N=
ULL);
> > >> +    }
> > >> +
> > >> +    fdt_load_addr =3D riscv_compute_fdt_addr(memmap[RVSP_DRAM].base=
,
> > >> +                                           memmap[RVSP_DRAM].size,
> > >> +                                           machine);
> > >> +    riscv_load_fdt(fdt_load_addr, machine->fdt);
> > >> +
> > >> +    /* load the reset vector */
> > >> +    riscv_setup_rom_reset_vec(machine, &s->soc[0], start_addr,
> > >> +                              rvsp_ref_memmap[RVSP_MROM].base,
> > >> +                              rvsp_ref_memmap[RVSP_MROM].size, kern=
el_entry,
> > >> +                              fdt_load_addr);
> > >> +
> > >> +}
> > >> +
> > >> +static void rvsp_ref_machine_init(MachineState *machine)
> > >> +{
> > >> +    const MemMapEntry *memmap =3D rvsp_ref_memmap;
> > >> +    RVSPMachineState *s =3D RVSP_REF_MACHINE(machine);
> > >> +    MemoryRegion *system_memory =3D get_system_memory();
> > >> +    MemoryRegion *mask_rom =3D g_new(MemoryRegion, 1);
> > >> +    char *soc_name;
> > >> +    DeviceState *mmio_irqchip, *pcie_irqchip;
> > >> +    int i, base_hartid, hart_count;
> > >> +    int socket_count =3D riscv_socket_count(machine);
> > >> +
> > >> +    /* Check socket count limit */
> > >> +    if (RVSP_SOCKETS_MAX < socket_count) {
> > >> +        error_report("number of sockets/nodes should be less than %=
d",
> > >> +            RVSP_SOCKETS_MAX);
> > >> +        exit(1);
> > >> +    }
> > >> +
> > >> +    if (!tcg_enabled()) {
> > >> +        error_report("'aclint' is only available with TCG accelerat=
ion");
> > >> +        exit(1);
> > >> +    }
> > >> +
> > >> +    /* Initialize sockets */
> > >> +    mmio_irqchip =3D pcie_irqchip =3D NULL;
> > >> +    for (i =3D 0; i < socket_count; i++) {
> > >> +        if (!riscv_socket_check_hartids(machine, i)) {
> > >> +            error_report("discontinuous hartids in socket%d", i);
> > >> +            exit(1);
> > >> +        }
> > >> +
> > >> +        base_hartid =3D riscv_socket_first_hartid(machine, i);
> > >> +        if (base_hartid < 0) {
> > >> +            error_report("can't find hartid base for socket%d", i);
> > >> +            exit(1);
> > >> +        }
> > >> +
> > >> +        hart_count =3D riscv_socket_hart_count(machine, i);
> > >> +        if (hart_count < 0) {
> > >> +            error_report("can't find hart count for socket%d", i);
> > >> +            exit(1);
> > >> +        }
> > >> +
> > >> +        soc_name =3D g_strdup_printf("soc%d", i);
> > >> +        object_initialize_child(OBJECT(machine), soc_name, &s->soc[=
i],
> > >> +                                TYPE_RISCV_HART_ARRAY);
> > >> +        g_free(soc_name);
> > >> +        object_property_set_str(OBJECT(&s->soc[i]), "cpu-type",
> > >> +                                machine->cpu_type, &error_abort);
> > >> +        object_property_set_int(OBJECT(&s->soc[i]), "hartid-base",
> > >> +                                base_hartid, &error_abort);
> > >> +        object_property_set_int(OBJECT(&s->soc[i]), "num-harts",
> > >> +                                hart_count, &error_abort);
> > >> +        sysbus_realize(SYS_BUS_DEVICE(&s->soc[i]), &error_fatal);
> > >> +
> > >> +        /* Per-socket ACLINT MTIMER */
> > >> +        riscv_aclint_mtimer_create(memmap[RVSP_ACLINT].base +
> > >> +                i * RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
> > >> +            RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
> > >> +            base_hartid, hart_count,
> > >> +            RISCV_ACLINT_DEFAULT_MTIMECMP,
> > >> +            RISCV_ACLINT_DEFAULT_MTIME,
> > >> +            RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, true);
> > >> +
> > >> +        /* Per-socket interrupt controller */
> > >> +        s->irqchip[i] =3D rvsp_ref_create_aia(s->aia_guests,
> > >> +                                            memmap, i, base_hartid,
> > >> +                                            hart_count);
> > >> +
> > >> +        /* Try to use different IRQCHIP instance based device type =
*/
> > >> +        if (i =3D=3D 0) {
> > >> +            mmio_irqchip =3D s->irqchip[i];
> > >> +            pcie_irqchip =3D s->irqchip[i];
> > >> +        }
> > >> +        if (i =3D=3D 1) {
> > >> +            pcie_irqchip =3D s->irqchip[i];
> > >> +        }
> > >> +    }
> > >> +
> > >> +    s->memmap =3D rvsp_ref_memmap;
> > >> +
> > >> +    /* register system main memory (actual RAM) */
> > >> +    memory_region_add_subregion(system_memory, memmap[RVSP_DRAM].ba=
se,
> > >> +        machine->ram);
> > >> +
> > >> +    /* boot rom */
> > >> +    memory_region_init_rom(mask_rom, NULL, "riscv_rvsp_ref_board.mr=
om",
> > >> +                           memmap[RVSP_MROM].size, &error_fatal);
> > >> +    memory_region_add_subregion(system_memory, memmap[RVSP_MROM].ba=
se,
> > >> +                                mask_rom);
> > >> +
> > >> +    /* SiFive Test MMIO device */
> > >> +    sifive_test_create(memmap[RVSP_TEST].base);
> > >> +
> > >> +    gpex_pcie_init(system_memory, pcie_irqchip, s);
> > >> +
> > >> +    serial_mm_init(system_memory, memmap[RVSP_UART0].base,
> > >> +        0, qdev_get_gpio_in(mmio_irqchip, RVSP_UART0_IRQ), 399193,
> > >> +        serial_hd(0), DEVICE_LITTLE_ENDIAN);
> > >> +
> > >> +    sysbus_create_simple("goldfish_rtc", memmap[RVSP_RTC].base,
> > >> +        qdev_get_gpio_in(mmio_irqchip, RVSP_RTC_IRQ));
> > >> +
> > >> +    for (i =3D 0; i < ARRAY_SIZE(s->flash); i++) {
> > >> +        /* Map legacy -drive if=3Dpflash to machine properties */
> > >> +        pflash_cfi01_legacy_drive(s->flash[i],
> > >> +                                  drive_get(IF_PFLASH, 0, i));
> > >> +    }
> > >> +    rvsp_flash_map(s, system_memory);
> > >> +
> > >> +    s->machine_done.notify =3D rvsp_ref_machine_done;
> > >> +    qemu_add_machine_init_done_notifier(&s->machine_done);
> > >> +}
> > >> +
> > >> +static void rvsp_ref_machine_instance_init(Object *obj)
> > >> +{
> > >> +    RVSPMachineState *s =3D RVSP_REF_MACHINE(obj);
> > >> +
> > >> +    rvsp_flash_create(s);
> > >> +}
> > >> +
> > >> +static char *rvsp_ref_get_aia_guests(Object *obj, Error **errp)
> > >> +{
> > >> +    RVSPMachineState *s =3D RVSP_REF_MACHINE(obj);
> > >> +    char val[32];
> > >> +
> > >> +    sprintf(val, "%d", s->aia_guests);
> > >> +    return g_strdup(val);
> > >> +}
> > >> +
> > >> +static void rvsp_ref_set_aia_guests(Object *obj, const char *val, E=
rror **errp)
> > >> +{
> > >> +    RVSPMachineState *s =3D RVSP_REF_MACHINE(obj);
> > >> +
> > >> +    s->aia_guests =3D atoi(val);
> > >> +    if (s->aia_guests < 0 || s->aia_guests > RVSP_IRQCHIP_MAX_GUEST=
S) {
> > >> +        error_setg(errp, "Invalid number of AIA IMSIC guests");
> > >> +        error_append_hint(errp, "Valid values be between 0 and %d.\=
n",
> > >> +                          RVSP_IRQCHIP_MAX_GUESTS);
> > >> +    }
> > >> +}
> > >> +
> > >> +static void rvsp_ref_machine_class_init(ObjectClass *oc, void *data=
)
> > >> +{
> > >> +    char str[128];
> > >> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> > >> +
> > >> +    mc->desc =3D "RISC-V Server SoC Reference board";
> > >> +    mc->init =3D rvsp_ref_machine_init;
> > >> +    mc->max_cpus =3D RVSP_CPUS_MAX;
> > >> +    mc->default_cpu_type =3D TYPE_RISCV_CPU_BASE;
> > >> +    mc->pci_allow_0_address =3D true;
> > >> +    mc->default_nic =3D "e1000e";
> > >> +    mc->possible_cpu_arch_ids =3D riscv_numa_possible_cpu_arch_ids;
> > >> +    mc->cpu_index_to_instance_props =3D riscv_numa_cpu_index_to_pro=
ps;
> > >> +    mc->get_default_cpu_node_id =3D riscv_numa_get_default_cpu_node=
_id;
> > >> +    mc->numa_mem_supported =3D true;
> > >> +    /* platform instead of architectural choice */
> > >> +    mc->cpu_cluster_has_numa_boundary =3D true;
> > >> +    mc->default_ram_id =3D "riscv_rvsp_ref_board.ram";
> > >> +
> > >> +    object_class_property_add_str(oc, "aia-guests",
> > >> +                                  rvsp_ref_get_aia_guests,
> > >> +                                  rvsp_ref_set_aia_guests);
> > >> +    sprintf(str, "Set number of guest MMIO pages for AIA IMSIC. Val=
id value "
> > >> +                 "should be between 0 and %d.", RVSP_IRQCHIP_MAX_GU=
ESTS);
> > >> +    object_class_property_set_description(oc, "aia-guests", str);
> > >> +}
> > >> +
> > >> +static const TypeInfo rvsp_ref_typeinfo =3D {
> > >> +    .name       =3D TYPE_RVSP_REF_MACHINE,
> > >> +    .parent     =3D TYPE_MACHINE,
> > >> +    .class_init =3D rvsp_ref_machine_class_init,
> > >> +    .instance_init =3D rvsp_ref_machine_instance_init,
> > >> +    .instance_size =3D sizeof(RVSPMachineState),
> > >> +};
> > >> +
> > >> +static void rvsp_ref_init_register_types(void)
> > >> +{
> > >> +    type_register_static(&rvsp_ref_typeinfo);
> > >> +}
> > >> +
> > >> +type_init(rvsp_ref_init_register_types)
> > >> --
> > >> 2.34.1
> > >>
> > >>
> >

